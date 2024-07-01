{{/*
DB Common labels
*/}}
{{- define "db.labels" -}}
helm.sh/chart: {{ include "geonode.chart" . }}
{{ include "db.selectorLabels" . }}
{{- if .Values.services.db.image.tag }}
app.kubernetes.io/version: {{ .Values.services.db.image.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.openshift.io/runtime: postgresql
app.kubernetes.io/component: database
app.kubernetes.io/part-of: geonode
{{- end }}

{{/*
DB Selector labels
*/}}
{{- define "db.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.services.db.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
DB Service - hostname
*/}}
{{- define "db.hostname" -}}
{{- if .Values.services.db.external }}
{{- $dbHost := .Values.configs.postgres.host -}}
{{- if not $dbHost }}
{{- fail "If services.db.external is True, you must set a valid PostgreSQL hostname" -}}
{{- end }} 
{{- $dbHost }}
{{- else -}}
{{- printf "%s.%s.svc.cluster.local" .Values.services.db.name .Release.Namespace -}}
{{- end }}
{{- end }}
