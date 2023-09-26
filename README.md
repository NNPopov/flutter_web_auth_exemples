# Flutter Web Auth Exemples

Launch a docker containers
```
docker-compose -f docker-compose.yaml -f docker-compose.override.yml -p keycloack-flutter  up  -d
```

## Configurations:

### Code flow without PKCE:
- Dart package: [flutter_web_auth_2 2.2.1](https://pub.dev/packages/flutter_web_auth_2)
- Keycloack admin console: [https://localhost:5553/admin](https://localhost:5553/admin)
- Flutter web: [https://localhost:5553/](https://localhost:5553/)
- Realm: keycloakflows
- ClinetId: keycloakcodenopkce
- Default user: Admin
- Default user password: change_me