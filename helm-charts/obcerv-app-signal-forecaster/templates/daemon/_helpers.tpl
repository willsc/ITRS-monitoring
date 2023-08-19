{{/*
Expand the name of the chart.
*/}}
{{- define "obcerv-app-signal-forecaster.name" -}}
{{- default .Values.forecaster.name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "obcerv-app-signal-forecaster.fullname" -}}
{{- printf "%s-daemon" .Chart.Name}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "obcerv-app-signal-forecaster.chart" -}}
{{- printf "%s-%s" .Values.forecaster.name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "obcerv-app-signal-forecaster.labels" -}}
helm.sh/chart: {{ include "obcerv-app-signal-forecaster.chart" . }}
{{ include "obcerv-app-signal-forecaster.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "obcerv-app-signal-forecaster.selectorLabels" -}}
app.kubernetes.io/name: {{ include "obcerv-app-signal-forecaster.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "obcerv-app-signal-forecaster.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "obcerv-app-signal-forecaster.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
