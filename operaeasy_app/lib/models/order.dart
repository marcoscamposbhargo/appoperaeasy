import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    required String techniciandId,
    required String clientName,
    required String serviceType,
    required String address,
    required String status, // RECEBIDO, ACEITO, EM_EXECUCAO, CHECKLIST, FINALIZADO
    required DateTime createdAt,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? finishedAt,
    required String description,
    required int checklistProgress, // 0-100
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
