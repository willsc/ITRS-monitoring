{{/*
Create a default fully qualified app name.
*/}}
{{- define "obcerv-app-capacity-planner-metrics.fullname" -}}
{{- printf "obcerv-app-%s-%s" .Values.id "metrics" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "obcerv-app-capacity-planner-metrics.chart" -}}
{{- printf "obcerv-app-%s-%s-%s" .Values.id "metrics" .Chart.Version }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "obcerv-app-capacity-planner-metrics.labels" -}}
helm.sh/chart: {{ include "obcerv-app-capacity-planner-metrics.chart" . }}
{{ include "obcerv-app-capacity-planner-metrics.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "obcerv-app-capacity-planner-metrics.selectorLabels" -}}
app.kubernetes.io/name: {{ include "obcerv-app-capacity-planner-metrics.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}