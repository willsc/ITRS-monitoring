{{/*
Create a default fully qualified app name.
*/}}
{{- define "obcerv-app-notifications-notifier.fullname" -}}
{{- printf "%s-%s" .Chart.Name "notifier" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "obcerv-app-notifications-notifier.chart" -}}
{{- printf "%s-%s-%s" .Chart.Name "notifier" .Chart.Version }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "obcerv-app-notifications-notifier.labels" -}}
helm.sh/chart: {{ include "obcerv-app-notifications-notifier.chart" . }}
{{ include "obcerv-app-notifications-notifier.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: obcerv
{{- end }}

{{/*
Selector labels
*/}}
{{- define "obcerv-app-notifications-notifier.selectorLabels" -}}
app.kubernetes.io/name: {{ include "obcerv-app-notifications-notifier.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
External URL
*/}}
{{- define "obcerv-app-notifications-notifier.externalUrl" -}}
{{- $ingress := .Values.ingress | default dict }}
{{- $ingressEnabled := $ingress.enabled | default true }}
{{- $tls := $ingress.tls | default dict }}
{{- $tlsEnabled := $tls.enabled | default false }}
{{- $defaultPath := printf "/%s/" .Release.Name }}
{{- $path := $ingress.path | default $defaultPath }}
{{- if $ingressEnabled }}
{{- if $tlsEnabled }}
{{- printf "https://%s/app%s" .Values.externalHostname $path }}
{{- else }}
{{- printf "http://%s/app%s" .Values.externalHostname $path }}
{{- end }}
{{- end }}
{{- end }}