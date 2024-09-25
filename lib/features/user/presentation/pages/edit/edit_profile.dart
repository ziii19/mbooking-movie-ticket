import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/utils/alert.dart';
import 'package:mbooking/core/widgets/back_nav.dart';
import 'package:mbooking/features/auth/domain/entities/user.dart';
import 'package:mbooking/features/main/pages/cubit/nav_index_cubit.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/pick_image.dart';
import '../../../../../core/widgets/input_text.dart';
import '../../../../auth/presentation/blocs/user/user_bloc.dart';
import '../../../../main/pages/main_page.dart';

class EditProfile extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const EditProfile(),
      );
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;
  User? user;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _nameController.text = user!.name;
      _emailController.text = user!.email;
      _phoneController.text = user?.phoneNumber?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void updateUser() {
    if (formKey.currentState!.validate()) {
      if (_nameController.text == user!.name &&
          _phoneController.text == user!.phoneNumber.toString() &&
          image == null) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.topSlide,
          title: 'Warning',
          desc: 'No changes made',
          btnOkOnPress: () {},
        ).show();
        return;
      }
      context.read<UserBloc>().add(
            UpdateUserDetail(
              uid: user!.uid,
              name: _nameController.text,
              email: _emailController.text,
              phoneNumber: int.tryParse(_phoneController.text),
              photoUrl: image,
            ),
          );
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UpdateUserSuccess) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.topSlide,
                title: 'Success',
                desc: 'Profile updated successfully',
                btnOkOnPress: () {
                  FocusScope.of(context).unfocus();
                  context.read<NavIndexCubit>().setIndex(3);
                  Future.delayed(const Duration(milliseconds: 400)).then(
                    (value) {
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MainPage.route(),
                          (route) => false,
                        );
                      }
                    },
                  );

                  context.read<UserBloc>().add(GetUser());
                },
              ).show();
            } else if (state is UserError) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is UserSuccess) {
              user = state.user;
              if (_nameController.text.isEmpty) {
                _nameController.text = state.user.name;
                _emailController.text = state.user.email;
                _phoneController.text =
                    state.user.phoneNumber?.toString() ?? '';
              }
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  BackNav(
                    text: 'Edit Profile',
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Future.delayed(const Duration(milliseconds: 300)).then(
                        (value) {
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectImage();
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.outline,
                              image: image != null
                                  ? DecorationImage(
                                      image: FileImage(image!),
                                      fit: BoxFit.cover,
                                    )
                                  : user?.photoUrl != null
                                      ? DecorationImage(
                                          image: NetworkImage(user!.photoUrl!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                            ),
                            child: (image == null && user?.photoUrl == null)
                                ? const Center(
                                    child: Icon(
                                      Icons.add_a_photo_rounded,
                                      color: AppColors.enabled,
                                      size: 40,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 30),
                        InputText(
                          controller: _nameController,
                          label: 'Name',
                          hintText: 'Adam',
                        ),
                        const SizedBox(height: 16),
                        InputText(
                          enabled: false,
                          controller: _emailController,
                          label: 'Email',
                          hintText: 'adam@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        InputText(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          label: 'Phone',
                          hintText: '628XXXXXXXX',
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: state is UserLoading
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();
                                  updateUser();
                                },
                          child: state is UserLoading
                              ? const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator())
                              : const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
