{{/* vim: set filetype=mustache: */}}

{{- define "plugins" -}}
{{- join "," .Values.deployment.plugins }}
{{- end -}}
