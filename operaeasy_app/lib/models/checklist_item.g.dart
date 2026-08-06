// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChecklistItemImpl _$$ChecklistItemImplFromJson(Map<String, dynamic> json) =>
    _$ChecklistItemImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      type: json['type'] as String,
      obrigatorio: json['obrigatorio'] as bool,
      fotoObrigatoria: json['fotoObrigatoria'] as bool,
      resposta: json['resposta'] as String?,
      fotoUrls: (json['fotoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      completadoEm: json['completadoEm'] == null
          ? null
          : DateTime.parse(json['completadoEm'] as String),
    );

Map<String, dynamic> _$$ChecklistItemImplToJson(_$ChecklistItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'type': instance.type,
      'obrigatorio': instance.obrigatorio,
      'fotoObrigatoria': instance.fotoObrigatoria,
      'resposta': instance.resposta,
      'fotoUrls': instance.fotoUrls,
      'completadoEm': instance.completadoEm?.toIso8601String(),
    };
