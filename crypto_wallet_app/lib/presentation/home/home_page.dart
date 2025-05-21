import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/entities/crypto.dart';
import '../../data/repositories/crypto_repository_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../widgets/crypto_card.dart';
import 'crypto_cubit.dart';
import 'crypto_detail_page.dart';
import '../profile/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final TextEditingController _searchController = TextEditingController();
    return BlocProvider(
      create: (_) => CryptoCubit(CryptoRepositoryImpl())..fetchCryptos(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.home),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await AuthRepositoryImpl().logout();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Buscar criptomoeda',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final nome = _searchController.text.trim();
                      if (nome.isNotEmpty) {
                        context.read<CryptoCubit>().searchCryptos(nome: nome);
                      } else {
                        context.read<CryptoCubit>().fetchCryptos();
                      }
                    },
                    child: const Text('Buscar'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<CryptoCubit, CryptoState>(
                builder: (context, state) {
                  if (state is CryptoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CryptoLoaded) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: state.cryptos.length,
                      itemBuilder: (context, index) {
                        final crypto = state.cryptos[index];
                        final percent = double.tryParse(crypto.percentChange
                                .replaceAll('%', '')
                                .replaceAll(',', '.')) ??
                            0;
                        final percentColor =
                            percent < 0 ? Colors.red : Colors.green;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CryptoDetailPage(crypto: crypto),
                              ),
                            );
                          },
                          child: CryptoCard(
                            name: crypto.name,
                            symbol: crypto.symbol,
                            price: crypto.price,
                            percentChange: crypto.percentChange,
                            iconUrl: crypto.iconUrl,
                            percentColor: percentColor,
                          ),
                        );
                      },
                    );
                  } else if (state is CryptoError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
