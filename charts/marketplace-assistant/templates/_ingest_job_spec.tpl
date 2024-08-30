{{/*
Ingest Job Spec. Reuse in initial job and crobjob
*/}}
{{- define "marketplace-assistant.ingest-job-spec" -}}
spec:
  template:
    spec:
      containers:
      - name: ingest
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
        command:
        - "/bin/sh"
        - "-c"
        - "--"
        args:
        - "source /vault-output/output && echo $SERVICE_JSON | jq -r > /usr/app/service.json && python -m knowledge_base_gpt.apps.ingest"
        volumeMounts:
        - name: embedding
          mountPath: "/db"
        - name: service-json
          mountPath: /usr/app/
        - mountPath: /etc/knowledgebase
          name: knowledgebase-config
        - mountPath: /.cache
          name: cache
        - name: vault-output
          mountPath: /vault-output
          readOnly: true
        env:
        - name: KNOWLEDGE_BASE_SETTINGS_FOLDER
          value: /etc/knowledgebase
        - name: SERVICE_KEY_FILE
          value: /usr/app/service.json
        resources:
          limits:
            cpu: 1
            memory: 2Gi
      initContainers:
      {{- include "marketplace-assistant.vault-init-container" (dict "root" .) | nindent 6 }}
      volumes:
      - name: knowledgebase-config
        configMap:
          name: {{ include "marketplace-assistant.knowledgebase-configmap" . }}
      - name: embedding
        persistentVolumeClaim:
          claimName: {{ include "marketplace-assistant.embedding-pvc" . }}
      - name: service-json
        emptyDir:
          sizeLimit: 1Mi
      - name: cache
        emptyDir:
          sizeLimit: 1Gi
      {{- include "marketplace-assistant.vault-base-volumes" . | nindent 6 }}
      {{- include "marketplace-assistant.vault-instance-volumes" (dict "templateConfigMapName" (include "marketplace-assistant.vault-template-ingest-configmap" .)) | nindent 6 }}
      restartPolicy: Never
  backoffLimit: 4
{{- end }}