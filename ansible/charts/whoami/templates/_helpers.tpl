{{/*
Expand the name of the chart.
Usa o .Values.nameOverride se definido, caso contrário o nome do chart.
*/}}

{{- define "whoami.name" -}}
{{- default .Chart.Name (default "" .Values.nameOverride) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "whoami.fullname" -}}
{{- if (default "" .Values.fullnameOverride) -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := include "whoami.name" . -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end }}

{{/*
Common labels para todos os recursos do chart.
*/}}
{{- define "whoami.labels" -}}
helm.sh/chart: {{ include "whoami.chart" . }}
app.kubernetes.io/name: {{ include "whoami.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels (usados em matchLabels de Deployments, Services, etc.)
*/}}
{{- define "whoami.selectorLabels" -}}
app.kubernetes.io/name: {{ include "whoami.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Retorna o nome completo da imagem (registry + repositório + tag)
*/}}
{{- define "whoami.image" -}}
{{- if (default "" .Values.image.repository) -}}
{{- printf "%s:%s" .Values.image.repository (default .Chart.AppVersion .Values.image.tag) -}}
{{- else -}}
{{- printf "%s:%s" .Chart.Name (default .Chart.AppVersion .Values.image.tag) -}}
{{- end -}}
{{- end }}

{{/*
Chart name and version
*/}}
{{- define "whoami.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" -}}
{{- end }}
