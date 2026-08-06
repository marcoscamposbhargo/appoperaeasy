import 'package:flutter/material.dart';
import 'package:operaeasy_app/config/theme.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static final List<Map<String, String>> _mockHistory = [
    {
      'client': 'Cliente A',
      'serviceType': 'Instalação',
      'address': 'Rua Principal, 123',
      'finishedAt': '05/08 às 14:30',
    },
    {
      'client': 'Cliente B',
      'serviceType': 'Manutenção',
      'address': 'Avenida Central, 456',
      'finishedAt': '04/08 às 16:45',
    },
    {
      'client': 'Cliente D',
      'serviceType': 'Reparo',
      'address': 'Rua Lateral, 789',
      'finishedAt': '03/08 às 11:20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            tooltip: 'Filtrar por data',
            onPressed: () {},
          ),
        ],
      ),
      body: _mockHistory.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.history_rounded,
                        size: 64, color: OperaEasyTheme.neutral400),
                    const SizedBox(height: 16),
                    Text('Nenhum serviço finalizado ainda',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _mockHistory.length,
              itemBuilder: (context, index) {
                final item = _mockHistory[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          height: 56,
                          decoration: BoxDecoration(
                            color: OperaEasyTheme.successGreen,
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
                                      item['client']!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: OperaEasyTheme.successGreen
                                          .withValues(alpha: 0.12),
                                      borderRadius:
                                          BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.task_alt_rounded,
                                            size: 14,
                                            color:
                                                OperaEasyTheme.successGreen),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Finalizado',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                OperaEasyTheme.successGreen,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item['serviceType']!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      size: 14,
                                      color: OperaEasyTheme.neutral400),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      item['address']!,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.check_circle_outline_rounded,
                                      size: 13,
                                      color: OperaEasyTheme.successGreen),
                                  const SizedBox(width: 4),
                                  Text(
                                    item['finishedAt']!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: OperaEasyTheme.fontMono,
                                      color: OperaEasyTheme.neutral400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
