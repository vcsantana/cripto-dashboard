import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/user.dart';
import '../../data/repositories/user_repository_impl.dart';
import 'profile_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  String? _base64Image;

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(UserRepositoryImpl())..fetchProfile(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Perfil')),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is ProfileUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Perfil atualizado com sucesso!')),
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded || state is ProfileUpdated) {
              final user = state is ProfileLoaded
                  ? state.user
                  : (state as ProfileUpdated).user;
              _nomeController.text = user.nome;
              _descricaoController.text = user.descricao;
              Widget imageWidget;
              if (_base64Image != null && _base64Image!.isNotEmpty) {
                imageWidget = CircleAvatar(
                  radius: 48,
                  backgroundImage: MemoryImage(base64Decode(_base64Image!)),
                );
              } else if (user.imagem.isNotEmpty) {
                try {
                  imageWidget = CircleAvatar(
                    radius: 48,
                    backgroundImage: MemoryImage(base64Decode(user.imagem)),
                  );
                } catch (_) {
                  imageWidget = const CircleAvatar(
                      radius: 48, child: Icon(Icons.person, size: 48));
                }
              } else {
                imageWidget = const CircleAvatar(
                    radius: 48, child: Icon(Icons.person, size: 48));
              }
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: imageWidget),
                    TextButton(
                      onPressed: _pickImage,
                      child: const Text('Alterar foto'),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _nomeController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _descricaoController,
                      decoration: const InputDecoration(labelText: 'Descrição'),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileCubit>().updateProfile(
                              nome: _nomeController.text.trim(),
                              descricao: _descricaoController.text.trim(),
                              imagem: _base64Image ?? user.imagem,
                            );
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
