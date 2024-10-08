{{/*
Knowledge Base configuration ConfigMap Name
*/}}
{{- define "marketplace-assistant.knowledgebase-configmap" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "knowledgebase" }}
{{- end }}

{{/*
Knowledge Base Configuration
*/}}
{{- define "marketplace-assistant.knowledgebase-config" -}}
slackbot:
  app_token: $SLACK_APP_TOKEN|""
  bot_token: $SLACK_BOT_TOKEN|""
  forward_channel: $FORWARD_QUESTION_CHANNEL_NAME|""
  command_strings:
    reset: cmpa-reset-conversation
    forward: cmpa-forward-conversation

llm:
  mode: vllm

ollama: {}

history:
  mode: redis

redis:
  host: "{{ include "marketplace-assistant.redis-host" . }}"
  password: $REDIS_PASSWORD|""
  ttl: 3600

log:
  chat_log_path: /logs/slackbot_chat_log.log

content_loader: {}

google_drive:
  service_key_file: $SERVICE_KEY_FILE|""
  folder_id: $GOOGLE_DRIVE_FOLDER_ID|""

text_splitter: {}

embedding:
  mode: infinity

infinity:
  embedding_model: $EMBEDDINGS_MODEL_NAME|{{ .Values.infinity.model }}
  api_url: "{{ include "marketplace-assistant.infinity-endpoint" . }}"

hugging_face: {}

vectorstore:
  persist_directory: "/db"

fake_model: {}

vllm:
  api_base: "{{ include "marketplace-assistant.vllm-endpoint" . }}"
  llm_model: $MODEL|{{ .Values.vllm.model }}

{{- end }}
