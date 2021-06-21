import 'package:puffzone/model/repository/user_repository.dart';
import 'package:puffzone/model/user.dart';

class UserController {
  UserRepository _repository = UserRepository();

  void addUser(User user) {
    _repository.addUser(user);
  }

  void deleteUser(int index) {
    _repository.deleteUser(index);
  }

  List<User> getUser() {
    return _repository.getUser();
  }
}
