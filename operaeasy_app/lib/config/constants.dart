const String apiBaseUrl = 'https://api.operaeasy.local'; // Ajustar pra URL real do SaaS

const Map<String, String> orderStatusLabels = {
  'RECEBIDO': 'Recebido',
  'ACEITO': 'Aceito',
  'EM_EXECUCAO': 'Em Execução',
  'CHECKLIST': 'Checklist',
  'FINALIZADO': 'Finalizado',
};

const Map<String, int> orderStatusPriority = {
  'RECEBIDO': 0,
  'ACEITO': 1,
  'EM_EXECUCAO': 2,
  'CHECKLIST': 3,
  'FINALIZADO': 4,
};
