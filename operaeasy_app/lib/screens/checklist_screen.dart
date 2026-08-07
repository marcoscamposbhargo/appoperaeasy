import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:operaeasy_app/config/theme.dart';
import 'package:operaeasy_app/screens/review_screen.dart';

class ChecklistScreen extends ConsumerStatefulWidget {
  final String orderId;

  const ChecklistScreen({
    super.key,
    required this.orderId,
  });

  @override
  ConsumerState<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends ConsumerState<ChecklistScreen> {
  late Map<String, dynamic> checklistResponses = {};
  int progressPercent = 0;
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> mockChecklistItems = [
    {
      'id': 'ITEM001',
      'label': 'Inspeção visual do equipamento',
      'type': 'boolean',
      'obrigatorio': true,
      'fotoObrigatoria': false,
    },
    {
      'id': 'ITEM002',
      'label': 'Foto do equipamento instalado',
      'type': 'foto',
      'obrigatorio': true,
      'fotoObrigatoria': true,
    },
    {
      'id': 'ITEM003',
      'label': 'Observações adicionais',
      'type': 'texto',
      'obrigatorio': false,
      'fotoObrigatoria': false,
    },
    {
      'id': 'ITEM004',
      'label': 'Teste de funcionamento',
      'type': 'boolean',
      'obrigatorio': true,
      'fotoObrigatoria': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    for (var item in mockChecklistItems) {
      checklistResponses[item['id']] = null;
    }
  }

  void updateProgress() {
    final requiredItems =
        mockChecklistItems.where((item) => item['obrigatorio'] == true);
    final completed = requiredItems
        .where((item) => checklistResponses[item['id']] != null)
        .length;
    setState(() {
      progressPercent = requiredItems.isEmpty
          ? 100
          : ((completed / requiredItems.length) * 100).toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = progressPercent == 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist do Serviço'),
      ),
      body: Column(
        children: [
          // Sticky progress header — sempre visível, sem scroll
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              border: const Border(
                bottom: BorderSide(color: OperaEasyTheme.neutral200),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progresso do Checklist',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '$progressPercent%',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: OperaEasyTheme.fontDisplay,
                        color: isComplete
                            ? OperaEasyTheme.successGreen
                            : OperaEasyTheme.primaryBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progressPercent / 100,
                    minHeight: 8,
                    backgroundColor: OperaEasyTheme.neutral200,
                    valueColor: AlwaysStoppedAnimation(
                      isComplete
                          ? OperaEasyTheme.successGreen
                          : OperaEasyTheme.primaryBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              itemCount: mockChecklistItems.length,
              itemBuilder: (context, index) {
                final item = mockChecklistItems[index];
                final itemId = item['id'] as String;
                final response = checklistResponses[itemId];
                final isDone = response != null;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isDone
                          ? OperaEasyTheme.successGreen.withValues(alpha: 0.4)
                          : OperaEasyTheme.neutral200,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isDone)
                              const Padding(
                                padding: EdgeInsets.only(right: 8, top: 2),
                                child: Icon(Icons.check_circle_rounded,
                                    color: OperaEasyTheme.successGreen,
                                    size: 20),
                              ),
                            Expanded(
                              child: Text(
                                item['label'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            if (item['obrigatorio'])
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: OperaEasyTheme.warningTint,
                                  borderRadius: BorderRadius.circular(
                                      OperaEasyTheme.radiusPill),
                                ),
                                child: const Text(
                                  'Obrigatório',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: OperaEasyTheme.warningAmber,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildChecklistItemWidget(item, itemId, response),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Ação primária fixa no terço inferior — thumb-reach
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: isComplete ? _submitChecklist : null,
            icon: Icon(isComplete
                ? Icons.check_circle_rounded
                : Icons.lock_clock_rounded),
            label: Text(
              isComplete
                  ? 'Finalizar Checklist'
                  : 'Finalizar Checklist ($progressPercent%)',
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              backgroundColor: isComplete
                  ? OperaEasyTheme.successGreen
                  : OperaEasyTheme.primaryBlue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChecklistItemWidget(
    Map<String, dynamic> item,
    String itemId,
    dynamic response,
  ) {
    final type = item['type'] as String;

    switch (type) {
      case 'boolean':
        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              checklistResponses[itemId] = !(response == true);
            });
            updateProgress();
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: response == true
                  ? OperaEasyTheme.successGreen.withValues(alpha: 0.1)
                  : OperaEasyTheme.neutral100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  response == true
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded,
                  color: response == true
                      ? OperaEasyTheme.successGreen
                      : OperaEasyTheme.neutral400,
                ),
                const SizedBox(width: 10),
                Text(
                  response == true ? 'Confirmado' : 'Toque para confirmar',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: response == true
                        ? OperaEasyTheme.successGreen
                        : OperaEasyTheme.neutral600,
                  ),
                ),
              ],
            ),
          ),
        );

      case 'foto':
        final photos = (response as List<String>?) ?? const [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (photos.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 84,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: photos.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, i) => Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              OperaEasyTheme.radiusControl),
                          child: Image.file(
                            File(photos[i]),
                            width: 84,
                            height: 84,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () => _removePhoto(itemId, i),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close_rounded,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _capturePhoto(itemId),
                icon: const Icon(Icons.camera_alt_rounded),
                label: Text(
                    photos.isNotEmpty ? 'Tirar Outra Foto' : 'Tirar Foto'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            ),
          ],
        );

      case 'texto':
        return TextField(
          onChanged: (value) {
            setState(() {
              checklistResponses[itemId] = value.isEmpty ? null : value;
            });
            updateProgress();
          },
          decoration: const InputDecoration(
            hintText: 'Digite sua observação',
            filled: true,
          ),
          maxLines: 3,
        );

      default:
        return const Text('Tipo de item desconhecido');
    }
  }

  Future<void> _capturePhoto(String itemId) async {
    final XFile? shot = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (shot == null) return; // usuário cancelou

    setState(() {
      final current = (checklistResponses[itemId] as List<String>?) ?? [];
      checklistResponses[itemId] = [...current, shot.path];
    });
    updateProgress();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Foto capturada'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _removePhoto(String itemId, int index) {
    setState(() {
      final current = List<String>.from(
          (checklistResponses[itemId] as List<String>?) ?? []);
      current.removeAt(index);
      checklistResponses[itemId] = current.isEmpty ? null : current;
    });
    updateProgress();
  }

  void _submitChecklist() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReviewScreen(
          orderId: widget.orderId,
          checklistResponses: {
            for (final item in mockChecklistItems)
              item['label'] as String: checklistResponses[item['id']],
          },
        ),
      ),
    );
  }
}
