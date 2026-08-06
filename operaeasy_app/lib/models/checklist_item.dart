import 'package:freezed_annotation/freezed_annotation.dart';

part 'checklist_item.freezed.dart';
part 'checklist_item.g.dart';

@freezed
class ChecklistItem with _$ChecklistItem {
  const factory ChecklistItem({
    required String id,
    required String label,
    required String type, // foto, texto, boolean, numero
    required bool obrigatorio,
    required bool fotoObrigatoria,
    String? resposta,
    List<String>? fotoUrls, // URLs das fotos
    DateTime? completadoEm,
  }) = _ChecklistItem;

  factory ChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$ChecklistItemFromJson(json);
}
