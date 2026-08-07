# OperaEasy — Requisitos de Integração com a Plataforma Web (SaaS)

Documento de solicitação técnica. Objetivo: trocar `MockApiService` (Flutter)
por `RealApiService` conectado à API real do SaaS. Tudo abaixo é o que
falta ser confirmado ou disponibilizado pelo time/dono da plataforma web.

## 1. Documentação da API

- [ ] Swagger/OpenAPI (arquivo `.json`/`.yaml` ou URL pública/interna)
- [ ] Ambiente de staging/homologação com URL base acessível
- [ ] Coleção Postman/Insomnia (se não houver Swagger)

## 2. Autenticação

- [ ] Método de login: usuário/senha? SSO? Magic link?
- [ ] Endpoint de login (ex: `POST /auth/login`) — payload de entrada e resposta
- [ ] Tipo de token: JWT? Sessão? Formato do header (`Authorization: Bearer <token>`)
- [ ] Tempo de expiração do token
- [ ] Existe endpoint de refresh token? (`POST /auth/refresh`)
- [ ] Endpoint de logout, se houver

## 3. Endpoint — Listar Ordens de Serviço

`GET /orders?technician_id=...`

- [ ] Confirmar path exato e nome do parâmetro de filtro (técnico logado)
- [ ] Confirmar todos os campos retornados por ordem e seus tipos exatos.
      Campos que o app espera hoje (nomes do modelo Flutter `Order`):

```
id              String
techniciandId   String
clientName      String
serviceType     String
address         String
status          String   // RECEBIDO | ACEITO | EM_EXECUCAO | CHECKLIST | FINALIZADO
createdAt       DateTime (ISO 8601)
acceptedAt      DateTime? (ISO 8601)
startedAt       DateTime? (ISO 8601)
finishedAt      DateTime? (ISO 8601)
description     String
checklistProgress  int (0-100)
```

- [ ] Nomes reais dos campos na API podem ser diferentes (ex: `camelCase` vs
      `snake_case`) — precisa mapa de campo por campo
- [ ] Valores possíveis de `status` são exatamente esses 5? Outros estados existem?
- [ ] Paginação? Filtros adicionais (data, status)?

## 4. Endpoint — Detalhe da Ordem + Template do Checklist

`GET /orders/:id`

- [ ] Retorna a ordem completa + lista de itens do checklist (template dinâmico)?
      Ou é endpoint separado (`GET /orders/:id/checklist-template`)?
- [ ] Estrutura de cada item do checklist. Campos que o app espera (modelo
      `ChecklistItem`):

```
id              String
label           String
type            String   // foto | texto | boolean | numero
obrigatorio     bool
fotoObrigatoria bool
resposta        String?
fotoUrls        List<String>?
completadoEm    DateTime? (ISO 8601)
```

- [ ] Tipos de item (`type`) são só esses 4 ou existem mais (data, seleção múltipla etc)?
- [ ] Ordem dos itens é definida pela API (array ordenado) ou tem campo `ordem`?

## 5. Endpoint — Atualizar Status da Ordem (transição de pipeline)

`PATCH /orders/:id/status`

- [ ] Payload de entrada — confirmar chave (`status` ou outro nome)
- [ ] O app envia `timestamp` e `geolocalização` (lat/long) na transição —
      a API aceita/espera esses campos? Em qual formato?
- [ ] Regras de transição validadas no backend (ex: não pode pular de
      RECEBIDO pra FINALIZADO) ou o app precisa garantir isso sozinho?
- [ ] Resposta esperada em caso de sucesso/erro (códigos HTTP, corpo)

## 6. Endpoint — Completar Item do Checklist

`POST /orders/:id/checklist-items/:itemId/complete`

- [ ] Payload exato — `response`/`resposta`, tipo conforme campo `type` do item
      (texto livre, boolean, número)
- [ ] Validação de item obrigatório é feita no backend também, ou só no app?

## 7. Upload de Fotos

- [ ] Modelo de upload: multipart direto pro backend, ou URL assinada
      (Supabase Storage / S3 / GCS) que o app faz PUT direto?
- [ ] Se URL assinada: endpoint que gera a URL (ex: `POST /orders/:id/photos/sign-url`),
      payload de entrada/saída, tempo de validade da URL
- [ ] Se multipart: endpoint exato, limite de tamanho de arquivo, formatos aceitos
- [ ] Como a URL final da foto é associada ao `ChecklistItem.fotoUrls`
      (o app registra depois de subir, ou a API já retorna atualizado)?
- [ ] Limite de fotos por item?

## 8. Notificação de Nova Ordem (Push)

Hoje mockado no app. Duas opções, confirmar qual a plataforma usa:

- [ ] **Firebase Cloud Messaging (FCM)**: SaaS dispara push via Firebase quando
      nova ordem é criada/atribuída? Precisa `google-services.json` (Android) e
      certificado APNs (iOS) do projeto Firebase do SaaS
- [ ] **Webhook próprio**: SaaS chama endpoint do app/servidor intermediário?
- [ ] Alternativa se nenhum dos dois existir ainda: app faz polling
      (`GET /orders` a cada X segundos) — confirmar se é aceitável pro MVP

## 9. Erros e Códigos HTTP

- [ ] Formato padrão de erro da API (ex: `{ "error": "mensagem", "code": "..." }`)
- [ ] Códigos usados: 401 (token expirado), 403, 404, 422 (validação), 500
- [ ] Rate limiting existe? Headers relevantes?

## 10. Ambiente e Acesso

- [ ] URL base: produção e staging
- [ ] Credenciais de teste (usuário técnico de homologação)
- [ ] CORS liberado pra Flutter Web, se o app rodar em browser
- [ ] Versionamento da API (`/v1/...`)? Trocas de contrato são versionadas?

---

## Depois de recebido

Com as respostas acima, os arquivos que serão criados/alterados no app:

- `lib/services/api_service.dart` — nova classe `RealApiService implements ApiService`
- `lib/services/storage_service.dart` — upload de fotos (novo arquivo)
- interceptor Dio de auth (novo, em `lib/services/` ou `lib/config/`)
- `lib/models/order.dart` e `lib/models/checklist_item.dart` — ajuste de
  `@JsonKey` se os nomes de campo da API divergirem do modelo atual
- tela de login real (hoje mockada)
