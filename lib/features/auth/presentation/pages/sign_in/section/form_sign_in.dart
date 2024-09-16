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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is AuthSuccess) {
          context.read<UserBloc>().add(GetUser(uid: state.uid));
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 50),
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
                          signIn();
                        },
                  child: state is AuthLoading || userLoading
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
      ),
    );
  }
}
