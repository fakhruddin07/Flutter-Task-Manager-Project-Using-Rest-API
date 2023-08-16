import 'package:get/get.dart';

import '../../data/models/auth_utility.dart';
import '../../data/models/login_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class UpdateProfileController extends GetxController{
  bool _isUpdateProfileInProgress = false;

  bool get isUpdateProfileInProgress => _isUpdateProfileInProgress;

  Future<bool> updateProfile(String firstName, String lastName, String mobile, String password) async {
    _isUpdateProfileInProgress = true;
    update();

    final Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": "",
    };

    if(password.isNotEmpty && password.length>= 6){
      requestBody["password"] = password;
    }

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.profileUpdate, requestBody);

    _isUpdateProfileInProgress = false;
    update();

    if (response.isSuccess) {
      UserData userData = AuthUtility.userInfo.data!;
      userData.firstName = firstName;
      userData.lastName = lastName;
      userData.mobile = mobile;
      AuthUtility.updateUserInfo(userData);
      return true;
      /*password.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile Updated Successfully"),
          ),
        );
      }*/
    } else {
      return false;
      /*if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile Update failed! try again"),
          ),
        );
      }*/
    }
  }
}