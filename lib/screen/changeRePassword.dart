import 'package:app_well_mate/api/user/user_repo.dart';
import 'package:app_well_mate/components/loginByEmail.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Changerepassword extends StatefulWidget {
  const Changerepassword({super.key});

  @override
  State<Changerepassword> createState() => _ChangerepasswordState();
}

class _ChangerepasswordState extends State<Changerepassword> {
  final TextEditingController passCurrentController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController newRepassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _changePassword(String newPassword) async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    String? token = await SecureStorage.getToken();
    bool success = await UserRepo().changePassword(newPassword, token);

    if (!mounted) return;

    setState(() {
      isLoading = false;
      if (success) {
        currentPassword = newPassword;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(success ? 'Đổi mật khẩu thành công' : 'Đổi mật khẩu thất bại')),
      );
    });
  }


  // void _changePassword(String newPassword) async {
  //   String? token = await SecureStorage.getToken();
  //   await UserRepo().changePassword(newPassword, token);
  //   print("NewPassword: $newPassword");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đổi mật khẩu',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thêm hình ảnh
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/undraw_forgot_password.svg',
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Text(
                          'Đổi mật khẩu hiện tại',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        'Mật khẩu hiện tại',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passCurrentController,
                        decoration: const InputDecoration(
                          hintText: 'Nhập mật khẩu hiện tại',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.normal,
                            color: Color.fromARGB(255, 216, 206, 206),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 3),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColor, width: 3),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.greyColor, width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu hiện tại';
                          }
                          if (value != currentPassword) {
                            return 'Mật khẩu hiện tại không đúng';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Mật khẩu mới',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        controller: newPassController,
                        decoration: const InputDecoration(
                          hintText: 'Nhập mật khẩu mới',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.normal,
                            color: Color.fromARGB(255, 216, 206, 206),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 3),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColor, width: 3),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.greyColor, width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu mới';
                          }
                          if(value == currentPassword){
                            return 'Vui lòng không nhập trùng với mật khẩu cũ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Nhập lại mật khẩu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        controller: newRepassController,
                        decoration: const InputDecoration(
                          hintText: 'Nhập lại mật khẩu mới',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.normal,
                            color: Color.fromARGB(255, 216, 206, 206),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 3),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColor, width: 3),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.greyColor, width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập lại mật khẩu';
                          }
                          if (value != newPassController.text) {
                            return 'Mật khẩu không khớp';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _changePassword(newPassController.text);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //       content: Text('Đổi mật khẩu thành công')),
                      // );
                      // Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                    child: Text(
                      'Cập nhật',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            isLoading
            ? Center(
                child: LoadingAnimationWidget.flickr(
                leftDotColor: colorScheme.primary,
                rightDotColor: colorScheme.error,
                size: 70,
              ))
            : const SizedBox()
          ],
        ),
      ),
    );
  }
}
