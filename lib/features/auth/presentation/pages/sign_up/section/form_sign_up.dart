part of '../sign_up_page.dart';

class _FormSignUp extends StatefulWidget {
  const _FormSignUp();

  @override
  State<_FormSignUp> createState() => _FormSignUpState();
}

class _FormSignUpState extends State<_FormSignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;

  signUp() {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      context.read<AuthBloc>().add(AuthSignUp(
            email: email,
            password: password,
          ));
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
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is AuthSuccess) {
          context.read<UserBloc>().add(
                CreateNewUser(
                  uid: state.uid,
                  name: nameController.text,
                  email: emailController.text,
                  phoneNumber: null,
                  photoUrl: image,
                ),
              );
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 50),
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
                      : null,
                ),
                child: image == null
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
              controller: nameController,
              label: 'Name',
              hintText: 'Adam',
            ),
            const SizedBox(height: 16),
            InputText(
              controller: emailController,
              label: 'Email',
              hintText: 'adam@gmail.com',
            ),
            const SizedBox(height: 16),
            InputText(
              controller: passwordController,
              label: 'Password',
              hintText: '**********',
            ),
            const SizedBox(height: 32),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final userLoading =
                    context.read<UserBloc>().state is UserLoading;
                return ElevatedButton(
                  onPressed: state is AuthLoading || userLoading
                      ? null
                      : () {
                          signUp();
                        },
                  child: state is AuthLoading || userLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.yellow,
                          ))
                      : const Text('Sign Up'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
