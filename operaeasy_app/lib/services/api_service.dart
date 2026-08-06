import 'package:operaeasy_app/models/order.dart';

abstract class ApiService {
  Future<List<Order>> getOrders(String technicianId);
  Future<Order> getOrderById(String orderId);
  Future<void> updateOrderStatus(String orderId, String newStatus);
  Future<void> uploadPhoto(String orderId, String itemId, String filePath);
  Future<void> completeChecklistItem(
      String orderId, String itemId, String response);
}

class MockApiService implements ApiService {
  @override
  Future<List<Order>> getOrders(String technicianId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Order(
        id: 'ORD001',
        techniciandId: technicianId,
        clientName: 'Cliente A',
        serviceType: 'Instalação',
        address: 'Rua Principal, 123',
        status: 'RECEBIDO',
        createdAt: DateTime.now(),
        description: 'Instalação de ar condicionado',
        checklistProgress: 0,
      ),
      Order(
        id: 'ORD002',
        techniciandId: technicianId,
        clientName: 'Cliente B',
        serviceType: 'Manutenção',
        address: 'Avenida Central, 456',
        status: 'ACEITO',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        acceptedAt: DateTime.now().subtract(const Duration(hours: 1)),
        description: 'Manutenção de sistema HVAC',
        checklistProgress: 0,
      ),
    ];
  }

  @override
  Future<Order> getOrderById(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Order(
      id: orderId,
      techniciandId: 'TECH001',
      clientName: 'Cliente Teste',
      serviceType: 'Instalação',
      address: 'Endereço Teste',
      status: 'ACEITO',
      createdAt: DateTime.now(),
      description: 'Descrição do serviço',
      checklistProgress: 0,
    );
  }

  @override
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Future<void> uploadPhoto(
      String orderId, String itemId, String filePath) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> completeChecklistItem(
      String orderId, String itemId, String response) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
