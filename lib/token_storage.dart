class TokenStorage {
  String? _token;

  Future<void> storeToken(String token) async {
    _token = token;
  }

  Future<String?> retrieveToken() async {
    return _token;
  }
}
