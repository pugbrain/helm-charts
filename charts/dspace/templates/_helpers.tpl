{{/*
Expand the name of the chart.
*/}}
{{- define "dspace.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dspace.fullname" -}}
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
{{- define "dspace.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dspace.labels" -}}
helm.sh/chart: {{ include "dspace.chart" . }}
{{ include "dspace.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dspace.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dspace.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dspace.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "dspace.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of each service
*/}}
{{- define "dspace.backendFullname" -}}
{{- printf "%s-%s" (include "dspace.fullname" .) "backend" -}}
{{- end }}

{{- define "dspace.frontendFullname" -}}
{{- printf "%s-%s" (include "dspace.fullname" .) "frontend" -}}
{{- end }}

{{- define "dspace.solrFullname" -}}
{{- printf "%s-%s" (include "dspace.fullname" .) "solr" -}}
{{- end }}

{{- define "dspace.dbFullname" -}}
{{- printf "%s-%s" (include "dspace.fullname" .) "db" -}}
{{- end }}
