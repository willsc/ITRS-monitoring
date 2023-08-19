{{/*
Expand the name of the chart.
*/}}
{{- define "obcerv-app-alerting-ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "obcerv-app-alerting-ui.fullname" -}}
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
{{- define "obcerv-app-alerting-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "obcerv-app-alerting-ui.labels" -}}
helm.sh/chart: {{ include "obcerv-app-alerting-ui.chart" . }}
{{ include "obcerv-app-alerting-ui.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/group: "web-platform"
{{- end }}

{{/*
Selector labels
*/}}
{{- define "obcerv-app-alerting-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "obcerv-app-alerting-ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}