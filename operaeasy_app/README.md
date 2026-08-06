# OperaEasy — App do Técnico de Campo

App Flutter para técnicos de campo: recebem ordens de serviço, executam checklist dinâmico com fotos reais e fecham o atendimento. Web + iOS + Android a partir de um codebase só.

## Stack

- **Flutter** (Dart), Riverpod (state), Dio (HTTP), Freezed (models), `image_picker` (câmera)
- Design system próprio: cor de marca **teal `#14B8C6`** + navy `#0A1430`, tipografia Space Grotesk/Manrope (ver `lib/config/theme.dart`)

## Rodar localmente

Ambiente Windows tem **duas instalações Flutter**; use a de `Documents`, a de `Downloads` tem PATH quebrado:

```bash
# Web
"C:\Users\User\Documents\flutter\bin\flutter.bat" run -d chrome

# Android (precisa emulador aberto antes)
"C:\Users\User\AppData\Local\Android\Sdk\emulator\emulator.exe" -avd Pixel_7_API_34
"C:\Users\User\Documents\flutter\bin\flutter.bat" run -d emulator-5554
```

O emulador **não persiste entre sessões** — precisa reabrir toda vez.

## Telas (6, todas navegáveis)

1. **Login** — mock, qualquer credencial entra
2. **Lista de Ordens** — status coloridos, busca visual por card
3. **Detalhe da Ordem** — info + botão "Iniciar Serviço"
4. **Checklist** — formulário dinâmico (boolean/foto/texto), câmera real, progresso trava em 100% dos itens obrigatórios
5. **Revisão** — resumo pré-fechamento com confirmação
6. **Histórico** — ordens finalizadas

## Status

✅ MVP funcional ponta a ponta, validado em emulador Android
✅ Câmera real integrada (`image_picker`, múltiplas fotos por item)
✅ Design system consistente (cor de marca corrigida pra teal real, contraste AA)

🔲 API real (hoje usa `MockApiService`, ver `lib/services/api_service.dart`)
🔲 Modo offline (Drift, planejado)
🔲 Push notifications (FCM, planejado)
🔲 Auth real (SSO/JWT do SaaS)

Log detalhado de decisões e bugs corrigidos: [`LOG.md`](LOG.md).
Arquitetura completa: [`CLAUDE.md`](CLAUDE.md).
