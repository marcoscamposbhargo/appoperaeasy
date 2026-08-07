# OperaEasy MVP — Log de Desenvolvimento

## Checkpoint 2026-08-05 (sessão 3) — Câmera real + commit no GitHub

**Status**: câmera do dispositivo testada ponta a ponta no emulador; código
commitado e pronto pra push.

### Feito
- **Câmera real** (`image_picker`): item tipo `foto` no checklist agora abre
  a câmera de verdade, permite múltiplas fotos por item com galeria de
  miniaturas + botão remover. `AndroidManifest.xml` com permissão `CAMERA`.
  Testado com o dialog nativo de permissão + captura real no emulador
  (webcam sintética do Android Studio).
- **Ajustes finos** em `login_screen.dart` (ícone da marca 52→44px, padding
  do círculo 20→18) e uso do lockup oficial `logo-operaeasy-light.svg` em
  vez de recriar o texto "operaeasy" na mão.
- **Git**: repo tinha só o `first commit` vazio — `home.html` e
  `operaeasy_app/` nunca foram staged. `.gitignore` do Flutter já cobre
  `build/` (a pasta que provavelmente travava o commit anterior, tem
  milhares de arquivos gerados). Commit `17115e7` criado com 206 arquivos.
  **Falta**: `git push` pro remote `appoperaeasy` — aguardando confirmação
  do usuário antes de enviar.

### Pendências conhecidas
- Push ainda não feito.
- Fluxo Checklist → Revisão → Fechamento integrado mas não re-testado após
  a mudança de foto mock → foto real.
- Emulador não persiste entre sessões — reabrir a cada vez.

---

## Checkpoint 2026-08-05 (sessão 2) — Design system real + câmera

**Status**: 6 telas completas, rodando em emulador Android (Pixel 7 API 34)

### Corrigido nesta sessão
- **Cor de marca errada**: LEIA-ME dizia azul `#2D6BFF`, mas os SVGs reais
  (ícone do app, favicon, og-image) usam **teal `#14B8C6`**. Trocado
  `OperaEasyTheme.primaryBlue` pro valor real. Semânticas (verde/âmbar/vermelho)
  afastadas do teal pra não confundir.
- **Contraste AA quebrado**: badge "Obrigatório" era texto branco sobre âmbar
  claro (~2:1). Critério real do app é leitura sob sol — trocado pra fundo
  tintado + texto na cor forte (`warningTint` + `warningAmber`).
- **Bug de progresso**: cálculo dividia pelo total de itens mas só contava
  obrigatórios no numerador — nunca chegava a 100%. Corrigido em
  `checklist_screen.dart::updateProgress()`.
- **Shape system inconsistente**: raios variavam 8/12/20 sem padrão. Unificado
  em `OperaEasyTheme.radiusCard/radiusControl/radiusPill`.
- **Logo do login**: estava recriando "operaeasy" em `Text()` customizado.
  Trocado pro lockup oficial `logo-operaeasy-light.svg`.
- **`order_detail_screen.dart`**: única tela ainda com `Colors.blue` cru,
  fora do design system. Refeita com tokens do tema.

### Adicionado
- `PressableCard` + `StatusBadge` (`lib/widgets/pressable_card.dart`) —
  componentes compartilhados com sombra tintada (nunca preto puro) e feedback
  tátil (scale ao pressionar, substitui o ripple que some sob luz solar forte).
- `OperaEasyTheme.shadowSoft` / `shadowLifted` — profundidade consistente.
- **Câmera real** (`image_picker`): checklist agora tira foto de verdade
  (câmera do device), permite múltiplas fotos por item com galeria de
  miniaturas horizontal + botão remover. `AndroidManifest.xml` com permissão
  `CAMERA`. Substitui o mock anterior (`mock_photo_url`).

### Pendências conhecidas
- Fluxo Checklist → Revisão → Fechamento (via `ReviewScreen`) integrado, mas
  ainda não testado ponta a ponta após as mudanças de câmera.
- Emulador não persiste entre sessões do Claude Code — precisa reabrir
  (`emulator -avd Pixel_7_API_34`) e rodar `flutter run -d emulator-5554`
  a cada nova sessão.
- Env: Flutter em `C:\Users\User\Documents\flutter` (não a cópia em
  Downloads — aquela tem PATH quebrado). Android SDK em
  `C:\Users\User\AppData\Local\Android\Sdk`.

---

**Data**: 2026-08-05  
**Status**: MVP Base Estruturado ✅

## Concluído

### 1. Setup Inicial
- ✅ Flutter 3.44.8 instalado e configurado
- ✅ Projeto Flutter criado com estrutura vazia (`flutter create --empty`)
- ✅ Dependências adicionadas: Riverpod, Dio, Freezed, JSON Serializable
- ✅ Estrutura de pastas criada:
  - `lib/models/` — DTOs (Order, ChecklistItem)
  - `lib/providers/` — Riverpod state management
  - `lib/screens/` — Telas da aplicação
  - `lib/services/` — Camada de API/negócio
  - `lib/config/` — Constantes e configurações
  - `lib/widgets/` — Componentes reutilizáveis
  - `lib/utils/` — Utilitários

### 2. Models & Code Generation
- ✅ `Order.dart` — @freezed com .copyWith()
- ✅ `ChecklistItem.dart` — @freezed para itens do checklist
- ✅ Build runner executado com sucesso (Freezed + JSON)

### 3. State Management (Riverpod)
- ✅ `api_provider.dart` — Provider do ApiService
- ✅ `orders_provider.dart` — Providers de ordens e ordem selecionada
- ✅ Mock data para desenvolvimento sem API real

### 4. Services
- ✅ `api_service.dart` — Interface + MockApiService
- Mock endpoints implementados:
  - `getOrders()` — Lista 2 ordens fake (RECEBIDO/ACEITO)
  - `getOrderById()` — Detalhe da ordem
  - `updateOrderStatus()` — Transição de estado
  - `uploadPhoto()` — Mock upload
  - `completeChecklistItem()` — Marca item completo

### 5. Screens (MVP)
- ✅ **OrdersListScreen** — Lista de ordens com status badge, navegação
- ✅ **OrderDetailScreen** — Detalhe + botão "Iniciar Serviço"
- ✅ **ChecklistScreen** — Formulário dinâmico mockado:
  - 4 itens de exemplo (boolean, foto, texto)
  - Progresso em % (0-100)
  - Indicador visual de obrigatoriedade
  - Botão "Tirar Foto" (mock)
  - Desabilita finalizar até checklist 100%
- ✅ **ReviewScreen** — Resumo pré-fechamento com confirmação

### 6. Documentação
- ✅ `CLAUDE.md` — Arquitetura completa, stack, comandos, padrões
- ✅ `main.dart` — ProviderScope + MaterialApp com rotas

## Parado/Próximos Passos

### Aguardando
- Flutter web compilação (em progresso, dart process ativo)
- URL localhost será exibida quando compilação terminar

### TODO Imediato (após Web rodar)
1. Validar fluxo completo no localhost:
   - Lista de ordens → Detalhe → Checklist → Revisão → Fechamento
2. Testar navegação entre telas

### TODO Curto Prazo (próximas sessões)
1. **Checklist dinâmico real**
   - Carregar template da API (em vez de mock hardcoded)
   - Renderizar formulário a partir do schema dinâmico

2. **Câmera + Upload**
   - `image_picker` para web (localização: browser file picker)
   - Preparar estrutura para mobile (iOS/Android) com `camera` plugin
   - Mock upload (sem storage remoto no MVP)

3. **Pipeline & Bloqueios**
   - Estado bloqueia transição sem checklist 100%
   - Timestamp + geolocation em cada transição
   - Log local de transições

4. **Offline Support**
   - `Drift` (SQLite) para cache local
   - Fila de sync em background
   - Indicador visual "Pendente de sync"

5. **Real API Integration**
   - Substituir `MockApiService` por `RealApiService`
   - Confirmar contrato OpenAPI do SaaS
   - Ajustar endpoints/DTOs conforme real

6. **Firebase FCM (Push)**
   - Google Services JSON
   - Listener de notificações
   - Auto-refresh de ordens quando nova chega

## Dependências Removidas Temporariamente
(Para MVP rodar em web, mobile depois)

- ❌ `firebase_core`, `firebase_messaging` — Adicionado em mobile/after-MVP
- ❌ `drift`, `sqlite3_flutter_libs` — Adicionado em mobile/offline-sync
- ❌ `camera`, `image_picker` — Adicionado em mobile/after-MVP

## Stack Confirmado

- **Flutter** 3.44.8 (Dart 3.12.2)
- **Riverpod** 2.4.0 (state management)
- **Dio** 5.4.0 (HTTP)
- **Freezed** 2.4.1 (models)
- **JSON Serializable** 6.7.1 (serialization)
- **Material 3** (UI)

## Arquitetura Pipeline

```
RECEBIDO → ACEITO → EM_EXECUCAO → CHECKLIST → FINALIZADO
```

Cada transição registra timestamp + geoloc local, bloqueia finalização sem checklist 100%.

## Notas Importantes

1. **Mock data**: Usamos MockApiService para não depender do SaaS real durante MVP
2. **Web-first**: MVP validado em web (Chrome), depois mobile
3. **Type-safe**: Freezed + JSON Serializable = DTOs robustos
4. **Offline-ready**: Arquitetura preparada pra Drift + sync, não implementado ainda
5. **Dynamic checklist**: Template vem da API, não hardcoded (estrutura pronta, dados mockados)

## Comandos Úteis

```bash
# Desenvolvimento
flutter run -d chrome          # Web (localhost)
flutter run -d emulator-5554   # Android
flutter run -d "iPhone 15"     # iOS

# Code generation
flutter pub run build_runner watch  # Auto-regenerate

# Lint & Format
flutter analyze
dart format lib/

# Build
flutter build web
flutter build apk --release
flutter build ios --release
```

## Próxima Sessão

1. Validar web (verificar localhost URL)
2. Testar fluxo completo: Lista → Detalhe → Checklist → Revisão
3. Decidir próximo feature: câmera ou API real
