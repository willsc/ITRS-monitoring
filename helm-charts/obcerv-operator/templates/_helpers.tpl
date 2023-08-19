{{/*
Expand the name of the chart.
*/}}
{{- define "obcerv-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "obcerv-operator.fullname" -}}
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
{{- define "obcerv-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "obcerv-operator.labels" -}}
helm.sh/chart: {{ include "obcerv-operator.chart" . }}
{{ include "obcerv-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "obcerv-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "obcerv-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "obcerv-operator.serviceAccountName" -}}
{{- if .Values.rbac.serviceAccount.create }}
{{- default (include "obcerv-operator.fullname" .) .Values.rbac.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.rbac.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the cluster role.
The generated name includes the namespace so that releases with same name in different namespaces don't clash.
*/}}
{{- define "obcerv-operator.clusterRoleName" -}}
{{- if .Values.rbac.clusterRole.create }}
{{- default (printf "%s-%s" (include "obcerv-operator.fullname" .) .Release.Namespace) .Values.rbac.clusterRole.name }}
{{- else }}
{{- default "default" .Values.rbac.clusterRole.name }}
{{- end }}
{{- end }}