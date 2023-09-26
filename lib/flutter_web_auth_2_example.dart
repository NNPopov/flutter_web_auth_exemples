import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


class FlutterWebAuth2Example {

  final String _clientId = dotenv.env["CLIENT_ID"].toString();
  final String _clientBaseUrl = dotenv.env["CLIENT_BASE_URL"].toString();

  final String _identityHost = dotenv.env["IDENTITY_HOST"].toString();
  final String _identityTokenPath =
  dotenv.env["IDENTITY_TOKEN_PATH"].toString();
  final String _callbackPath = dotenv.env["CALLBACK_PATH"].toString();
  final String _identityAuthPath = dotenv.env["IDENTITY_AUTH_PATH"].toString();

  Future<String> LogIn() async {
    final callbackUrlScheme = '${_clientBaseUrl}/${_callbackPath}';

    final url = Uri.https(_identityHost, _identityAuthPath, {
      'response_type': 'code',
      'client_id': _clientId,
      'redirect_uri': '$callbackUrlScheme',
      'scope': 'email openid phone'
    });

    final result = await FlutterWebAuth2.authenticate(
        url: url.toString(),
        callbackUrlScheme: _callbackPath,
        preferEphemeral: true);

    final code = Uri
        .parse(result)
        .queryParameters['code'];

    final url1 = Uri.https(_identityHost, _identityTokenPath);

    final response = await http.post(url1, body: {
      'client_id': _clientId,
      'redirect_uri': callbackUrlScheme,
      'grant_type': 'authorization_code',
      'code': code
    }, headers: {
      "content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json, text/plain, */*"
    });

    return response.body;
  }
}