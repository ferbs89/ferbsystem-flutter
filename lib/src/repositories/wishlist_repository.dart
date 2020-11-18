import 'package:ferbsystem/src/services/api.dart';

class WishlistRepository {
  Future<void> create(String name, String description, String value) async {
    final api = new Api();

    await api.dio.post("/users/1/wishlist", data: {
      "name": name,
      "description": description.isNotEmpty ? description : null,
      "value": value.isNotEmpty ? value : null,
    });
  }

  Future<void> update(int id, String name, String description, String value) async {
    final api = new Api();

    await api.dio.put("/users/1/wishlist/$id", data: {
      "name": name,
      "description": description.isNotEmpty ? description : null,
      "value": value.isNotEmpty ? value : null,
    });
  }

  Future<void> delete(int id) async {
    final api = new Api();

    await api.dio.delete("/wishlist/$id");
  }
}