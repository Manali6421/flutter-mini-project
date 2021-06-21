import 'package:puffzone/model/user.dart';
import 'package:puffzone/model/user_data.dart';

class UserRepository {
  void addUser(User user) {
    Map map = {
      "name": user.name,
      "email": user.email,
      "mobile": user.mobile,
      "jobTitle": user.jobTitle,
      "gender": user.gender,
      "avatar": "https://cdn.fakercloud.com/avatars/keryilmaz_128.jpg"
    };
    userList.add(map);
  }

  void deleteUser(int index) {
    userList.removeAt(index);
  }

  List<User> getUser() {
    List<User> list = [];
    userList.forEach((element) {
      User user = User();
      user.gender = element['gender'];
      user.jobTitle = element['jobTitle'];
      user.mobile = element['mobile'];
      user.email = element['email'];
      user.name = element['name'];
      user.avatar = element['avatar'];
      list.add(user);
    });
    return list;
  }
}
