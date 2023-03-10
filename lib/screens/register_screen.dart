import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakala_app/design/input_decorations.dart';
import 'package:wakala_app/providers/login_form_provider.dart';
import 'package:wakala_app/services/auth_service.dart';
import 'package:wakala_app/services/notifications_service.dart';
import 'package:wakala_app/widgets/auth_background.dart';
import 'package:wakala_app/widgets/card_container.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Create account', style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 10),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                child: const Text('I already have an account'),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      //TODO: mantener referencia al Key
      //autovalidateMode: AutovalidateMode.onUserInteraction,

      key: loginForm.formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            autofocus: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'example@mail.com',
              labelText: 'e-mail',
              prefixIcon: Icons.alternate_email_sharp,
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '') ? null: 'invalid e-mail';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            autofocus: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
              hintText: '*******',
              labelText: 'password',
              prefixIcon: Icons.lock_outlined,
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              if (value == null) return 'This field is required';
              if (value.length >= 6) return null;
              return 'Password has to be at least 6 characters';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            color: Colors.deepPurple,
            // ignore: sort_child_properties_last
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'Creating account...' : 'Register',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    if (!loginForm.isValidForm()) return;
                    loginForm.isLoading = true;
                    await Future.delayed(const Duration(seconds: 2));

                    final String? errorMessage = await authService.createUser(
                        loginForm.email, loginForm.password);

                    if (errorMessage == null) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      NotificationsService.showSnackbar('Correo ya registrado');
                      loginForm.isLoading = false;
                    }
                  },
          ),
        ],
      ),
    );
  }
}
