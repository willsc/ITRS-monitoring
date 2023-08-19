{{- /*
Defines the documentation URL for the app
*/}}
{{- define "obcerv-app-notifications.docsUrl" }}
{{- $appVersion := semver .Chart.AppVersion }}
{{- $urlTemplate := "https://%s.itrsgroup.com/docs/obcerv/app/notifications/%d.%d.%d/user-guide/notifications/index.html" }}
{{- if $appVersion.Prerelease }}
{{- printf $urlTemplate "devdocs" $appVersion.Major $appVersion.Minor $appVersion.Patch }}
{{- else }}
{{- printf $urlTemplate "docs" $appVersion.Major $appVersion.Minor $appVersion.Patch }}
{{- end }}
{{ end -}}
