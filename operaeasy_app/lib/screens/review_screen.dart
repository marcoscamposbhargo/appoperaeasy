import 'package:flutter/material.dart';
import 'package:operaeasy_app/config/theme.dart';

class ReviewScreen extends StatelessWidget {
  final String orderId;
  final Map<String, dynamic> checklistResponses;

  const ReviewScreen({
    super.key,
    required this.orderId,
    required this.checklistResponses,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revisar Serviço'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  Row(
                    children: [
                      const Icon(Icons.fact_check_rounded,
                          color: OperaEasyTheme.primaryBlue, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'RESUMO DO SERVIÇO',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: OperaEasyTheme.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Ordem: $orderId',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 2),
                  Text(
                    'Data: ${DateTime.now().toString().split('.').first}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: OperaEasyTheme.fontMono,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Checklist Preenchido',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...checklistResponses.entries.map((entry) {
              final isEmpty = entry.value == null;
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        isEmpty
                            ? Icons.remove_circle_outline_rounded
                            : Icons.check_circle_rounded,
                        size: 18,
                        color: isEmpty
                            ? OperaEasyTheme.neutral400
                            : OperaEasyTheme.successGreen,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isEmpty
                                  ? 'Não preenchido'
                                  : entry.value.toString(),
                              style:
                                  Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: isEmpty
                                            ? OperaEasyTheme.neutral400
                                            : OperaEasyTheme.neutral600,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: OperaEasyTheme.successGreen.withValues(alpha: 0.1),
                border: Border.all(color: OperaEasyTheme.successGreen),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded,
                      color: OperaEasyTheme.successGreen),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Pronto para fechar — todas as informações obrigatórias foram coletadas.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: OperaEasyTheme.successGreen,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () => _confirmClose(context),
                icon: const Icon(Icons.task_alt_rounded),
                label: const Text('Finalizar Serviço'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  backgroundColor: OperaEasyTheme.successGreen,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Voltar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmClose(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar Fechamento'),
        content: const Text(
          'Tem certeza que deseja finalizar este serviço? '
          'As informações serão enviadas ao sistema.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: OperaEasyTheme.successGreen,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.of(context).popUntil((route) => route.isFirst);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Serviço finalizado com sucesso!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Confirmar Fechamento'),
          ),
        ],
      ),
    );
  }
}
