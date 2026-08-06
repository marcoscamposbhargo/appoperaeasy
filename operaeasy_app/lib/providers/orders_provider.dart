import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operaeasy_app/models/order.dart';
import 'package:operaeasy_app/providers/api_provider.dart';

final technicianIdProvider = StateProvider<String>((ref) {
  return 'TECH001'; // Mockado. Depois vem de auth/SSO do SaaS
});

final ordersProvider = FutureProvider<List<Order>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  final technicianId = ref.watch(technicianIdProvider);
  return apiService.getOrders(technicianId);
});

final selectedOrderIdProvider = StateProvider<String?>((ref) {
  return null;
});

final selectedOrderProvider = FutureProvider<Order?>((ref) async {
  final orderId = ref.watch(selectedOrderIdProvider);
  if (orderId == null) return null;

  final apiService = ref.watch(apiServiceProvider);
  return apiService.getOrderById(orderId);
});
