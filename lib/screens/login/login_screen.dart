import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/duo_mascot.dart';
import '../../widgets/primary_button.dart';

/// Pantalla de acceso (tema claro, segun el skill).
///
/// Permite iniciar sesion o crear una cuenta con email y contraseña. La
/// navegacion al home la resuelve `AuthGate` al detectar la sesion.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  bool _isSignUp = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final AuthProvider auth = context.read<AuthProvider>();
    final String email = _email.text.trim();
    final String password = _password.text;
    if (email.isEmpty || password.isEmpty) return;

    if (_isSignUp) {
      await auth.signUp(
        email: email,
        password: password,
        name: _name.text.trim(),
      );
    } else {
      await auth.signIn(email: email, password: password);
    }
  }

  void _toggleMode() {
    context.read<AuthProvider>().clearError();
    setState(() => _isSignUp = !_isSignUp);
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.paperWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s24,
              vertical: AppSpacing.s24,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Column(
                children: <Widget>[
                  const DuoMascot(size: 120),
                  const SizedBox(height: AppSpacing.s16),
                  Text(
                    'duolingo',
                    style: AppTypography.display(color: AppColors.eagerGreen),
                  ),
                  const SizedBox(height: AppSpacing.s24),
                  if (_isSignUp) ...<Widget>[
                    _AuthField(
                      controller: _name,
                      label: 'Nombre',
                      icon: Icons.person_rounded,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.s12),
                  ],
                  _AuthField(
                    controller: _email,
                    label: 'Correo electrónico',
                    icon: Icons.mail_rounded,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppSpacing.s12),
                  _AuthField(
                    controller: _password,
                    label: 'Contraseña',
                    icon: Icons.lock_rounded,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                  ),
                  if (auth.error != null) ...<Widget>[
                    const SizedBox(height: AppSpacing.s12),
                    Text(
                      auth.error!,
                      textAlign: TextAlign.center,
                      style: AppTypography.caption(color: AppColors.heartPink),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.s24),
                  PrimaryButton(
                    label: _isSignUp ? 'Crear cuenta' : 'Iniciar sesión',
                    onPressed: auth.isSubmitting ? null : _submit,
                  ),
                  const SizedBox(height: AppSpacing.s12),
                  TextButton(
                    onPressed: auth.isSubmitting ? null : _toggleMode,
                    child: Text(
                      _isSignUp
                          ? '¿Ya tienes cuenta? Inicia sesión'
                          : '¿No tienes cuenta? Regístrate',
                      style: AppTypography.label(color: AppColors.sparkBlue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  const _AuthField({
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      style: AppTypography.body(color: AppColors.charcoal),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.fadedGray),
        labelStyle: AppTypography.body(color: AppColors.pencilGray),
        filled: true,
        fillColor: AppColors.paperWhite,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.standard),
          borderSide: const BorderSide(color: AppColors.fadedGray, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.standard),
          borderSide: const BorderSide(color: AppColors.sparkBlue, width: 2),
        ),
      ),
    );
  }
}
