// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checklist_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChecklistItem _$ChecklistItemFromJson(Map<String, dynamic> json) {
  return _ChecklistItem.fromJson(json);
}

/// @nodoc
mixin _$ChecklistItem {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // foto, texto, boolean, numero
  bool get obrigatorio => throw _privateConstructorUsedError;
  bool get fotoObrigatoria => throw _privateConstructorUsedError;
  String? get resposta => throw _privateConstructorUsedError;
  List<String>? get fotoUrls =>
      throw _privateConstructorUsedError; // URLs das fotos
  DateTime? get completadoEm => throw _privateConstructorUsedError;

  /// Serializes this ChecklistItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChecklistItemCopyWith<ChecklistItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChecklistItemCopyWith<$Res> {
  factory $ChecklistItemCopyWith(
    ChecklistItem value,
    $Res Function(ChecklistItem) then,
  ) = _$ChecklistItemCopyWithImpl<$Res, ChecklistItem>;
  @useResult
  $Res call({
    String id,
    String label,
    String type,
    bool obrigatorio,
    bool fotoObrigatoria,
    String? resposta,
    List<String>? fotoUrls,
    DateTime? completadoEm,
  });
}

/// @nodoc
class _$ChecklistItemCopyWithImpl<$Res, $Val extends ChecklistItem>
    implements $ChecklistItemCopyWith<$Res> {
  _$ChecklistItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? type = null,
    Object? obrigatorio = null,
    Object? fotoObrigatoria = null,
    Object? resposta = freezed,
    Object? fotoUrls = freezed,
    Object? completadoEm = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            obrigatorio: null == obrigatorio
                ? _value.obrigatorio
                : obrigatorio // ignore: cast_nullable_to_non_nullable
                      as bool,
            fotoObrigatoria: null == fotoObrigatoria
                ? _value.fotoObrigatoria
                : fotoObrigatoria // ignore: cast_nullable_to_non_nullable
                      as bool,
            resposta: freezed == resposta
                ? _value.resposta
                : resposta // ignore: cast_nullable_to_non_nullable
                      as String?,
            fotoUrls: freezed == fotoUrls
                ? _value.fotoUrls
                : fotoUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            completadoEm: freezed == completadoEm
                ? _value.completadoEm
                : completadoEm // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChecklistItemImplCopyWith<$Res>
    implements $ChecklistItemCopyWith<$Res> {
  factory _$$ChecklistItemImplCopyWith(
    _$ChecklistItemImpl value,
    $Res Function(_$ChecklistItemImpl) then,
  ) = __$$ChecklistItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String label,
    String type,
    bool obrigatorio,
    bool fotoObrigatoria,
    String? resposta,
    List<String>? fotoUrls,
    DateTime? completadoEm,
  });
}

/// @nodoc
class __$$ChecklistItemImplCopyWithImpl<$Res>
    extends _$ChecklistItemCopyWithImpl<$Res, _$ChecklistItemImpl>
    implements _$$ChecklistItemImplCopyWith<$Res> {
  __$$ChecklistItemImplCopyWithImpl(
    _$ChecklistItemImpl _value,
    $Res Function(_$ChecklistItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? type = null,
    Object? obrigatorio = null,
    Object? fotoObrigatoria = null,
    Object? resposta = freezed,
    Object? fotoUrls = freezed,
    Object? completadoEm = freezed,
  }) {
    return _then(
      _$ChecklistItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        obrigatorio: null == obrigatorio
            ? _value.obrigatorio
            : obrigatorio // ignore: cast_nullable_to_non_nullable
                  as bool,
        fotoObrigatoria: null == fotoObrigatoria
            ? _value.fotoObrigatoria
            : fotoObrigatoria // ignore: cast_nullable_to_non_nullable
                  as bool,
        resposta: freezed == resposta
            ? _value.resposta
            : resposta // ignore: cast_nullable_to_non_nullable
                  as String?,
        fotoUrls: freezed == fotoUrls
            ? _value._fotoUrls
            : fotoUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        completadoEm: freezed == completadoEm
            ? _value.completadoEm
            : completadoEm // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChecklistItemImpl implements _ChecklistItem {
  const _$ChecklistItemImpl({
    required this.id,
    required this.label,
    required this.type,
    required this.obrigatorio,
    required this.fotoObrigatoria,
    this.resposta,
    final List<String>? fotoUrls,
    this.completadoEm,
  }) : _fotoUrls = fotoUrls;

  factory _$ChecklistItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChecklistItemImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String type;
  // foto, texto, boolean, numero
  @override
  final bool obrigatorio;
  @override
  final bool fotoObrigatoria;
  @override
  final String? resposta;
  final List<String>? _fotoUrls;
  @override
  List<String>? get fotoUrls {
    final value = _fotoUrls;
    if (value == null) return null;
    if (_fotoUrls is EqualUnmodifiableListView) return _fotoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // URLs das fotos
  @override
  final DateTime? completadoEm;

  @override
  String toString() {
    return 'ChecklistItem(id: $id, label: $label, type: $type, obrigatorio: $obrigatorio, fotoObrigatoria: $fotoObrigatoria, resposta: $resposta, fotoUrls: $fotoUrls, completadoEm: $completadoEm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChecklistItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.obrigatorio, obrigatorio) ||
                other.obrigatorio == obrigatorio) &&
            (identical(other.fotoObrigatoria, fotoObrigatoria) ||
                other.fotoObrigatoria == fotoObrigatoria) &&
            (identical(other.resposta, resposta) ||
                other.resposta == resposta) &&
            const DeepCollectionEquality().equals(other._fotoUrls, _fotoUrls) &&
            (identical(other.completadoEm, completadoEm) ||
                other.completadoEm == completadoEm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    label,
    type,
    obrigatorio,
    fotoObrigatoria,
    resposta,
    const DeepCollectionEquality().hash(_fotoUrls),
    completadoEm,
  );

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChecklistItemImplCopyWith<_$ChecklistItemImpl> get copyWith =>
      __$$ChecklistItemImplCopyWithImpl<_$ChecklistItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChecklistItemImplToJson(this);
  }
}

abstract class _ChecklistItem implements ChecklistItem {
  const factory _ChecklistItem({
    required final String id,
    required final String label,
    required final String type,
    required final bool obrigatorio,
    required final bool fotoObrigatoria,
    final String? resposta,
    final List<String>? fotoUrls,
    final DateTime? completadoEm,
  }) = _$ChecklistItemImpl;

  factory _ChecklistItem.fromJson(Map<String, dynamic> json) =
      _$ChecklistItemImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  String get type; // foto, texto, boolean, numero
  @override
  bool get obrigatorio;
  @override
  bool get fotoObrigatoria;
  @override
  String? get resposta;
  @override
  List<String>? get fotoUrls; // URLs das fotos
  @override
  DateTime? get completadoEm;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChecklistItemImplCopyWith<_$ChecklistItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
