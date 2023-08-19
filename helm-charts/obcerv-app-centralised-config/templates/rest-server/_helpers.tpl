{{/*
Create a default fully qualified app name.
*/}}
{{- define "obcerv-app-centralised-config-rest-server.fullname" -}}
{{- printf "%s-rest-server" .Chart.Name }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "obcerv-app-centralised-config-rest-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
The rest server's context path.
*/}}
{{- define "obcerv-app-centralised-config-rest-server.ingressPath" -}}
{{- if (.Values.ingress).restPath }}
{{- printf "%s" .Values.ingress.restPath | trimSuffix "/" }}
{{- else }}
{{- printf "%s" "/rest/centralised-config" }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "obcerv-app-centralised-config-rest-server.labels" -}}
helm.sh/chart: {{ include "obcerv-app-centralised-config-rest-server.chart" . }}
{{ include "obcerv-app-centralised-config-rest-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/part-of: obcerv
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "obcerv-app-centralised-config-rest-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "obcerv-app-centralised-config-rest-server.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
