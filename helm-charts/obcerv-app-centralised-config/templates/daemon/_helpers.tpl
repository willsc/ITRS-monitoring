{{/*
Create a default fully qualified app name.
*/}}
{{- define "obcerv-app-centralised-config-daemon.fullname" -}}
{{- printf "%s-daemon" .Chart.Name }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "obcerv-app-centralised-config-daemon.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "obcerv-app-centralised-config-daemon.labels" -}}
helm.sh/chart: {{ include "obcerv-app-centralised-config-daemon.chart" . }}
{{ include "obcerv-app-centralised-config-daemon.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/part-of: obcerv
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "obcerv-app-centralised-config-daemon.selectorLabels" -}}
app.kubernetes.io/name: {{ include "obcerv-app-centralised-config-daemon.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
