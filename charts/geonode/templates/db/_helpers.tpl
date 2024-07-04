{{/*
Create a default fully qualified app name.
*/}}
{{- define "db.fullname" -}}
{{- $name := ( include "geonode.fullname" . ) | trunc 60 | trimSuffix "-" -}}
{{- printf "%s-db" $name }}
{{- end }}

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
app.kubernetes.io/part-of: {{ .Chart.Name }}
{{- end }}

{{/*
DB Selector labels
*/}}
{{- define "db.selectorLabels" -}}
app.kubernetes.io/name: postgis
app.kubernetes.io/instance: {{ printf "%s-%s" ( .Release.Namespace ) ( include "db.fullname" . ) }}
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
{{- printf "%s.%s.svc.cluster.local" ( include "db.fullname" . ) .Release.Namespace -}}
{{- end }}
{{- end }}
