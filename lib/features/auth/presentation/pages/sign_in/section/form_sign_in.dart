part of '../sign_in_page.dart';

class _FormSignIn extends StatefulWidget {
  const _FormSignIn();

  @override
  State<_FormSignIn> createState() => _FormSignInState();
}

class _FormSignInState extends State<_FormSignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  signIn() {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      context.read<AuthBloc>().add(AuthLogin(
            email: email,
            password: password,
          ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 50),
          InputText(
            controller: emailController,
            label: 'Email',
            hintText: 'adam@gmail.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          InputPassword(
            controller: passwordController,
          ),
          const SizedBox(height: 32),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state is UserLoading
                    ? null
                    : () {
                        signIn();
                      },
                child: state is UserLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.yellow,
                        ))
                    : const Text('Sign In'),
              );
            },
          ),
        ],
      ),
    );
  }
}
