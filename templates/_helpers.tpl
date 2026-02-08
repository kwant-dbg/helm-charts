{{/*
Expand the name of the chart.
*/}}
{{- define "velero-operations.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "velero-operations.fullname" -}}
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
Generate a dynamic Backup Name.
Format: cluster-YYYYMMDD-HHMMSS
*/}}
{{- define "velero-operations.backupName" -}}
{{- printf "%s-%s" .Values.cluster (now | date "20060102-150405") -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "velero-operations.labels" -}}
helm.sh/chart: {{ include "velero-operations.name" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
cluster: {{ .Values.cluster }}
created-by-port: "true"
{{- end }}

{{/*
Generate current timestamp in ISO format
*/}}
{{- define "velero-operations.timestamp" -}}
{{- now | date "2006-01-02T15:04:05Z" -}}
{{- end }}
