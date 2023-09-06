abstract class ApiService<T> {
  Future<T?> get(String url, {Map<String, dynamic> queryParams});
  Future<T?> post(String url, {Map<String, dynamic> body});
  Future<T?> update(String url, {Map<String, dynamic> body});
  Future<T?> delete(String url, {required int id});
  Future<T?> addHeaders(Map<String, String> headers);
}
