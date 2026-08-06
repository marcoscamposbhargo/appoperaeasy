# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## OperaEasy — Field Service Management App

App Flutter para técnicos em campo receberem ordens de serviço, executar checklists dinâmicos com fotos, e fechar o serviço. Integra com SaaS backend via REST + Webhooks.

## Stack

- **Framework**: Flutter 3.44.8 (Dart 3.12.2) — 1 codebase para web, iOS, Android
- **State Management**: Riverpod 2.x (testável, sem boilerplate)
- **HTTP**: `dio` (interceptors pra auth, retry, logging)
- **Database**: `drift` (SQLite local para cache offline)
- **Models**: `freezed` + `json_serializable` (type-safe DTOs)
- **Firebase**: FCM para push notifications
- **Câmera**: `image_picker`, `camera` (tirar fotos durante checklist)
- **Storage**: Upload direto pro bucket do SaaS (Supabase ou equivalente)

## Arquitetura

```
lib/
├── main.dart              # Ponto de entrada (ProviderScope + MaterialApp)
├── models/                # DTOs com Freezed (@freezed, .copyWith, etc)
│   ├── order.dart         # Order (id, techniciandId, status, createdAt, etc)
│   └── checklist_item.dart # ChecklistItem (id, type, resposta, fotoUrls)
├── providers/             # Riverpod providers (state management)
│   ├── api_provider.dart  # Provider do ApiService
│   └── orders_provider.dart # Providers de ordens + ordem selecionada
├── screens/               # Telas da app
│   ├── orders_list_screen.dart    # Lista de ordens (RECEBIDO/ACEITO/EM_EXECUCAO)
│   ├── order_detail_screen.dart   # Detalhe + botão Aceitar
│   ├── checklist_screen.dart      # Execução do checklist (câmera + formulário)
│   ├── review_screen.dart         # Revisão pré-fechamento
│   └── history_screen.dart        # Comandos finalizados
├── services/              # Lógica de negócio e integração
│   ├── api_service.dart   # Interface + MockApiService (pra MVP)
│   ├── storage_service.dart # Upload de fotos pra bucket
│   └── sync_service.dart  # Fila de sync offline-first
├── widgets/               # Widgets reutilizáveis
│   ├── status_badge.dart
│   ├── photo_grid.dart
│   └── checklist_form.dart # Formulário dinâmico
├── config/
│   ├── constants.dart     # API URL, status labels, etc
│   └── theme.dart         # Material 3 customizations (cores, tipografia)
└── utils/
    ├── logger.dart        # Logging estruturado
    ├── validators.dart    # Validação de inputs
    └── extensions.dart    # Extension methods (String, DateTime, etc)
```

## Pipeline do Serviço (Máquina de estados)

```
RECEBIDO → ACEITO → EM_EXECUCAO → CHECKLIST → FINALIZADO
```

- **RECEBIDO**: Ordem chega via FCM push, técnico vê detalhes (cliente, endereço, tipo).
- **ACEITO**: Técnico confirma que vai atender (timestamp + geo opcional).
- **EM_EXECUCAO**: Técnico inicia execução no local.
- **CHECKLIST**: Carrega template dinâmico da API (itens obrigatórios/opcionais, fotos, texto, boolean). Cada item pode exigir foto obrigatória.
- **FINALIZADO**: Só libera fechamento se itens obrigatórios completos. Gera relatório final (fotos + respostas) → POST ao SaaS.

Cada transição = 1 chamada PATCH `/orders/:id/status` + log local.

## Integração com SaaS

Assumir endpoints REST do SaaS (Swagger/OpenAPI deve ser confirmado):

```
GET  /orders?technician_id=TECH001
     → List<{id, clientName, serviceType, address, status, createdAt, description}>

GET  /orders/:id
     → Order + checklistTemplate (List<ChecklistItem>)

PATCH /orders/:id/status
     → {status: "ACEITO" | "EM_EXECUCAO" | "CHECKLIST" | "FINALIZADO"}

POST /orders/:id/checklist-items/:itemId/complete
     → {response: "texto", fotoUrls: [...]}

POST /orders/:id/photos (ou multipart upload)
     → Ou receber URL assinada (Supabase/S3) e app faz PUT direto
```

**Auth**: Token JWT do SaaS → interceptor Dio adiciona `Authorization: Bearer <token>` em todas requests.

**Push**: Webhook do SaaS → FCM → app recebe nova ordem em tempo real.

## Modo Offline

Técnico em campo pode perder sinal:

1. **Cache**: Ao abrir/aceitar ordem, download checklist template local (Drift).
2. **Progresso local**: Respostas + fotos salvas em Drift enquanto offline.
3. **Sync na background**: Quando rede volta, `SyncService` processa fila de uploads (retry automático).
4. **UI**: Indicador visual "Pendente de sync" nos itens que falharam.

**Drift schema** (SQLite):
```sql
orders (id PK, technician_id, client_name, service_type, address, status, ...)
checklist_items (id PK, order_id FK, label, type, response, photo_urls, completed_at)
pending_uploads (id PK, order_id FK, item_id FK, file_path, retry_count, created_at)
```

## Build & Run

### Deps
```bash
flutter pub get
```

### Dev (web)
```bash
flutter run -d chrome
```

### Dev (Android emulator)
```bash
flutter run -d emulator-5554
```

### Dev (iOS simulator)
```bash
flutter run -d "iPhone 15"
```

### Code generation (Freezed + JSON)
```bash
flutter pub run build_runner build
   # ou watch (roda automaticamente ao salvar):
flutter pub run build_runner watch
```

### Lint
```bash
flutter analyze
```

### Format
```bash
dart format lib/
```

### Build APK (Android release)
```bash
flutter build apk --release
```

### Build iOS (IPA)
```bash
flutter build ios --release
```

### Build web
```bash
flutter build web
```

## Padrões de código

- **State management**: Todos estados passam por Riverpod (providers). Sem StatefulWidget, prefira ConsumerWidget.
- **Async**: Use `FutureProvider` e `.when()` pra loading/error/data.
- **Models**: `@freezed` com `.copyWith()` pra mutação type-safe.
- **Services**: Interfaces abstratas (`abstract class XService`) + 1+ implementação mockada/real.
- **Routing**: Named routes em `MaterialApp.routes` + `Navigator.of(context).pushNamed()`.
- **Logging**: Usar função `log()` da `dart:developer` ou provider customizado.
- **Validação**: Não no app layer — validar só em fronteira (input do usuário).

## Estrutura de telas (MVP)

1. **OrdersListScreen** — lista de ordens filtradas por status, badge de status, onTap → detalhe
2. **OrderDetailScreen** — info da ordem (cliente, endereço, tipo), botão "Aceitar" → EM_EXECUCAO
3. **ChecklistScreen** — formulário dinâmico renderizado a partir do template da API, botão câmera inline, progresso %
4. **ReviewScreen** — resumo do que foi preenchido (respostas + fotos), confirma finalizar
5. **HistoryScreen** — lista de ordens FINALIZADO com data/hora de fechamento

Não implementar: login (mockado), notificações push (mockado), storage remoto (mock upload).

## Testing

Próximo passo:
- Unit tests pra `services/` (MockApiService substitui HTTP)
- Widget tests pra formulário dinâmico
- Integration tests pra pipeline completo

Usar `test`, `flutter_test`, `mocktail`.

## TODO antes de produção

- [ ] Confirmar contrato real da API do SaaS (Swagger/OpenAPI) → ajustar DTOs
- [ ] Integrar Firebase FCM (google-services.json + configuração)
- [ ] Integrar Supabase Storage ou bucket do SaaS → URL assinada
- [ ] Implementar autenticação real (SSO/JWT do SaaS)
- [ ] Implementar `RealApiService` (trocar `MockApiService`)
- [ ] Implementar `Drift` (local database) + `SyncService` offline
- [ ] Testes automatizados (unit + widget + integration)
- [ ] App signing (iOS + Android)
- [ ] Deploy (TestFlight, Play Store, web hosting)

## Próximos passos

MVP atual:
- ✅ Estrutura Flutter + Riverpod
- ✅ Mock API com dados fake
- ✅ OrdersListScreen + navegação
- 🔲 ChecklistScreen (formulário dinâmico, câmera)
- 🔲 Pipeline completo (estado bloqueia finalização)
- 🔲 Teste manual em web/mobile

Integração:
- Depois de MVP validado, substituir MockApiService por RealApiService + endpoints reais do SaaS.
