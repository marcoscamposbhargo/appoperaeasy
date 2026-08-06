import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:operaeasy_app/config/constants.dart';
import 'package:operaeasy_app/config/theme.dart';
import 'package:operaeasy_app/providers/orders_provider.dart';
import 'package:operaeasy_app/widgets/pressable_card.dart';

Color _statusColor(String status) {
  switch (status) {
    case 'RECEBIDO':
      return OperaEasyTheme.primaryBlue;
    case 'ACEITO':
      return OperaEasyTheme.successGreen;
    case 'EM_EXECUCAO':
      return OperaEasyTheme.warningAmber;
    case 'CHECKLIST':
      return OperaEasyTheme.primaryBlue;
    case 'FINALIZADO':
      return OperaEasyTheme.successGreen;
    default:
      return OperaEasyTheme.neutral400;
  }
}

Color _statusTint(String status) {
  switch (status) {
    case 'RECEBIDO':
    case 'CHECKLIST':
      return OperaEasyTheme.primaryTint;
    case 'ACEITO':
    case 'FINALIZADO':
      return OperaEasyTheme.successTint;
    case 'EM_EXECUCAO':
      return OperaEasyTheme.warningTint;
    default:
      return OperaEasyTheme.neutral100;
  }
}

IconData _statusIcon(String status) {
  switch (status) {
    case 'RECEBIDO':
      return Icons.inbox_rounded;
    case 'ACEITO':
      return Icons.check_circle_rounded;
    case 'EM_EXECUCAO':
      return Icons.build_circle_rounded;
    case 'CHECKLIST':
      return Icons.checklist_rounded;
    case 'FINALIZADO':
      return Icons.task_alt_rounded;
    default:
      return Icons.help_outline_rounded;
  }
}

class OrdersListScreen extends ConsumerWidget {
  const OrdersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/mark-operaeasy-white.svg',
              height: 26,
            ),
            const SizedBox(width: 10),
            Container(width: 1, height: 20, color: Colors.white24),
            const SizedBox(width: 10),
            const Text('Ordens de Serviço', style: TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            tooltip: 'Histórico',
            onPressed: () => Navigator.of(context).pushNamed('/history'),
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Atualizar',
            onPressed: () => ref.invalidate(ordersProvider),
          ),
        ],
      ),
      body: ordersAsync.when(
        data: (orders) {
          if (orders.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.inbox_outlined,
                      size: 64,
                      color: OperaEasyTheme.neutral400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nenhuma ordem no momento',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Novas ordens aparecem aqui assim que forem atribuídas a você.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(ordersProvider),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final statusLabel =
                    orderStatusLabels[order.status] ?? order.status;
                final color = _statusColor(order.status);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: PressableCard(
                    onTap: () {
                      ref.read(selectedOrderIdProvider.notifier).state =
                          order.id;
                      Navigator.of(context)
                          .pushNamed('/order-detail', arguments: order.id);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          height: 56,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      order.clientName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  StatusBadge(
                                    label: statusLabel,
                                    icon: _statusIcon(order.status),
                                    color: color,
                                    tint: _statusTint(order.status),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                order.serviceType,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined,
                                      size: 14,
                                      color: OperaEasyTheme.neutral400),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      order.address,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: OperaEasyTheme.neutral400),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_rounded,
                    size: 48, color: OperaEasyTheme.errorRed),
                const SizedBox(height: 12),
                Text('Não foi possível carregar as ordens',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text('$error', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => ref.invalidate(ordersProvider),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Tentar novamente'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
