import 'package:ferbsystem/src/models/user.dart';
import 'package:ferbsystem/src/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<void> login(String email, String password) async {
    final api = new Api();

    await api.dio.post("/login", data: {
      "email": email, 
      "password": password,
    
    }).then((response) async {
      User user = User.fromJson(response.data);

      final prefs = await SharedPreferences.getInstance();
                      
      prefs.setInt('id', user.id);
      prefs.setString('name', user.name);
      prefs.setString('email', user.email);
      prefs.setString('token', user.token);
    });    
  }

  Future<void> register(String name, String email, String password) async {
    final api = new Api();

    await api.dio.post("/users", data: {
      "name": name,
      "email": email,
      "password": password,    
    });
  }
}