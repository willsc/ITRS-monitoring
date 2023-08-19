{{/*
============================
========== Common ==========
============================
*/}}
{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "obcerv-app-query-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "obcerv-app-query-service.labels" -}}
helm.sh/chart: {{ include "obcerv-app-query-service.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
==========================
=========== DB ===========
==========================
*/}}
{{/*
Create a default fully qualified db name.
*/}}
{{- define "obcerv-app-query-service-db.fullname" -}}
obcerv-app-query-service-db
{{- end }}

{{/*
DB selector labels
*/}}
{{- define "obcerv-app-query-service-db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "obcerv-app-query-service-db.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
DB labels
*/}}
{{- define "obcerv-app-query-service-db.labels" -}}
{{ include "obcerv-app-query-service.labels" . }}
{{ include "obcerv-app-query-service-db.selectorLabels" . }}
{{- end }}

{{/*
==========================
========== BFF ===========
==========================
*/}}
{{/*
Create a default fully qualified bff service name.
*/}}
{{- define "obcerv-app-query-service-bff.fullname" -}}
obcerv-app-query-service-bff
{{- end }}

{{/*
Bff labels
*/}}
{{- define "obcerv-app-query-service-bff.labels" -}}
{{ include "obcerv-app-query-service.labels" . }}
{{ include "obcerv-app-query-service-bff.selectorLabels" . }}
{{- end }}

{{/*
Bff selector labels
*/}}
{{- define "obcerv-app-query-service-bff.selectorLabels" -}}
app.kubernetes.io/name: {{ include "obcerv-app-query-service-bff.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
==========================
========== Sink ==========
==========================
{{/*
Create a default fully qualified app name.
*/}}
{{- define "obcerv-app-query-service-sink.fullname" -}}
obcerv-app-query-service-sink
{{- end }}

{{/*
Sink labels
*/}}
{{- define "obcerv-app-query-service-sink.labels" -}}
{{ include "obcerv-app-query-service.labels" . }}
{{ include "obcerv-app-query-service-sink.selectorLabels" . }}
{{- end }}

{{/*
Sink selector labels
*/}}
{{- define "obcerv-app-query-service-sink.selectorLabels" -}}
app.kubernetes.io/name: {{ include "obcerv-app-query-service-sink.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
