import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_button.dart';
import '../../data/repositories/auth_repository_impl.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  String? _base64Image;
  bool _loading = false;
  String? _error;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
      });
    }
  }

  Future<void> _register() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await AuthRepositoryImpl().register(
        _emailController.text.trim(),
        _senhaController.text.trim(),
        _nomeController.text.trim(),
        _descricaoController.text.trim(),
        _base64Image,
      );
      if (!mounted) return;
      Navigator.pop(context); // Volta para login
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.register,
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 32),
              AppTextField(
                label: l10n.email,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              AppTextField(
                label: l10n.password,
                controller: _senhaController,
                obscureText: true,
              ),
              AppTextField(
                label: 'Nome',
                controller: _nomeController,
              ),
              AppTextField(
                label: 'Descrição',
                controller: _descricaoController,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Selecionar Imagem'),
                  ),
                  const SizedBox(width: 12),
                  if (_base64Image != null)
                    const Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
              const SizedBox(height: 24),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              if (_loading)
                const CircularProgressIndicator()
              else
                AppButton(
                  label: l10n.register,
                  onPressed: _register,
                ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(l10n.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
