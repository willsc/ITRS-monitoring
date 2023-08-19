{{/*
Create a default fully qualified app name.
*/}}
{{- define "obcerv-app-capacity-planner-entities.fullname" -}}
{{- printf "obcerv-app-%s-%s" .Values.id "entities" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "obcerv-app-capacity-planner-entities.chart" -}}
{{- printf "obcerv-app-%s-%s-%s" .Values.id "entities" .Chart.Version }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "obcerv-app-capacity-planner-entities.labels" -}}
helm.sh/chart: {{ include "obcerv-app-capacity-planner-entities.chart" . }}
{{ include "obcerv-app-capacity-planner-entities.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "obcerv-app-capacity-planner-entities.selectorLabels" -}}
app.kubernetes.io/name: {{ include "obcerv-app-capacity-planner-entities.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}