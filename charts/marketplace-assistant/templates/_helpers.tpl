{{/*
Expand the name of the chart.
*/}}
{{- define "marketplace-assistant.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "marketplace-assistant.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "marketplace-assistant.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "marketplace-assistant.labels" -}}
helm.sh/chart: {{ include "marketplace-assistant.chart" . }}
{{ include "marketplace-assistant.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "marketplace-assistant.selectorLabels" -}}
app.kubernetes.io/name: {{ include "marketplace-assistant.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Embedding DB Volume name
*/}}
{{- define "marketplace-assistant.embedding-pvc" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "embedding" }}
{{- end }}

{{/*
Ingest Job name
*/}}
{{- define "marketplace-assistant.ingest" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "ingest" }}
{{- end }}

{{/*
Slackbot Pod name
*/}}
{{- define "marketplace-assistant.slackbot-pod-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "slackbot" }}
{{- end }}

{{/*
Redis Service name
*/}}
{{- define "marketplace-assistant.redis-host" -}}
{{- printf "%s-redis-master" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "marketplace-assistant.redis-password-secret" -}}
{{- printf "%s-redis" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Redis StatefulSet name
*/}}
{{- define "marketplace-assistant.redis-statefulset-name" -}}
{{- printf "%s-redis-master" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Elasticsearch Service name
*/}}
{{- define "marketplace-assistant.elasticsearch" -}}
{{- printf "%s-elasticsearch" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Kibana Service name
*/}}
{{- define "marketplace-assistant.kibana" -}}
{{- printf "%s-kibana" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
MetricBeat Pod name
*/}}
{{- define "marketplace-assistant.metricbeat-pod-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "metricbeat" }}
{{- end }}

{{/*
vLLM Cache Volume name
*/}}
{{- define "marketplace-assistant.vllm-pvc" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "vllm-cache" }}
{{- end }}

{{/*
vLLM Deployment name
*/}}
{{- define "marketplace-assistant.vllm-deployment-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "vllm" }}
{{- end }}

{{/*
vLLM Service name
*/}}
{{- define "marketplace-assistant.vllm-service-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "vllm" }}
{{- end }}

{{/*
vLLM Endpoint
*/}}
{{- define "marketplace-assistant.vllm-endpoint" -}}
{{- printf "http://%s:8000/v1" (include "marketplace-assistant.vllm-service-name" .) }}
{{- end }}

{{/*
Redis PVC Name
*/}}
{{- define "marketplace-assistant.redis-pvc-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "redis" }}
{{- end }}

{{/*
Helm Hooks ServiceAccount Name
*/}}
{{- define "marketplace-assistant.helm-hooks-serviceaccount-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "helm-hooks" }}
{{- end }}

{{/*
Helm Hooks Role Name
*/}}
{{- define "marketplace-assistant.helm-hooks-role-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "helm-hooks" }}
{{- end }}

{{/*
Helm Hooks RoleBinding Name
*/}}
{{- define "marketplace-assistant.helm-hooks-rolebinding-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "helm-hooks" }}
{{- end }}

{{/*
Redis PVC Patcher Job Name
*/}}
{{- define "marketplace-assistant.redis-patcher-job-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "redis-patcher" }}
{{- end }}

{{/*
Redis PVC Patcher Fix ConfigMap Name
*/}}
{{- define "marketplace-assistant.redis-patcher-configmap-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "redis-patcher" }}
{{- end }}

{{/*
Ingest Job hook ConfigMap Name
*/}}
{{- define "marketplace-assistant.ingest-job-hook-configmap-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "ingest-job-hook" }}
{{- end }}

{{/*
Ingest Job hook Job Name
*/}}
{{- define "marketplace-assistant.ingest-job-hook-job-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "ingest-job-hook" }}
{{- end }}

{{/*
Infinity Deployment name
*/}}
{{- define "marketplace-assistant.infinity-deployment-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "infinity" }}
{{- end }}

{{/*
Infinity Service name
*/}}
{{- define "marketplace-assistant.infinity-service-name" -}}
{{- printf "%s-%s" (include "marketplace-assistant.fullname" .) "infinity" }}
{{- end }}

{{/*
Infinity Endpoint
*/}}
{{- define "marketplace-assistant.infinity-endpoint" -}}
{{- printf "http://%s:7997" (include "marketplace-assistant.infinity-service-name" .) }}
{{- end }}
