import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operaeasy_app/config/theme.dart';
import 'package:operaeasy_app/screens/checklist_screen.dart';

class OrderDetailScreen extends ConsumerWidget {
  final String orderId;

  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock order data
    final mockOrder = {
      'id': orderId,
      'clientName': 'Cliente Exemplo',
      'serviceType': 'Instalação de Ar Condicionado',
      'address': 'Rua Principal, 123 - São Paulo, SP',
      'status': 'RECEBIDO',
      'createdAt': DateTime.now(),
      'description':
          'Instalação de unidade condicionadora de ar tipo split. Cliente solicita serviço urgente.',
      'estimatedTime': '2 horas',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe do Serviço'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: OperaEasyTheme.primaryBlue.withValues(alpha: 0.08),
                border: Border.all(color: OperaEasyTheme.primaryBlue),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STATUS ATUAL',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: OperaEasyTheme.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mockOrder['status'] as String,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: OperaEasyTheme.fontDisplay,
                      color: OperaEasyTheme.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _DetailSection(
              label: 'Cliente',
              child: Text(
                mockOrder['clientName'] as String,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            _DetailSection(
              label: 'Tipo de Serviço',
              child: Text(
                mockOrder['serviceType'] as String,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            _DetailSection(
              label: 'Endereço',
              child: Row(
                children: [
                  Icon(Icons.location_on_rounded,
                      size: 18, color: OperaEasyTheme.errorRed),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      mockOrder['address'] as String,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            _DetailSection(
              label: 'Tempo Estimado',
              child: Row(
                children: [
                  Icon(Icons.schedule_rounded,
                      size: 18, color: OperaEasyTheme.warningAmber),
                  const SizedBox(width: 6),
                  Text(
                    mockOrder['estimatedTime'] as String,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            _DetailSection(
              label: 'Descrição do Serviço',
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: OperaEasyTheme.neutral100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: OperaEasyTheme.neutral200),
                ),
                child: Text(
                  mockOrder['description'] as String,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ChecklistScreen(orderId: mockOrder['id'] as String),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Iniciar Serviço'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              backgroundColor: OperaEasyTheme.successGreen,
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String label;
  final Widget child;

  const _DetailSection({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}
