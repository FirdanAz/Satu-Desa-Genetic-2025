import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/profile/views/widgets/edit_profile_field.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: 'John Doe');
    final TextEditingController nikController =
        TextEditingController(text: '601298171263552');
    final TextEditingController emailController =
        TextEditingController(text: 'johndoe@gmail.com');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Akun'),
        backgroundColor: AppColor.primary,
        toolbarHeight: 100,
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: const [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/icons/ic_avatar.png'),
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 24),
            EditProfileField(
              label: 'Nama Lengkap',
              controller: nameController,
            ),
            const SizedBox(height: 12),
            EditProfileField(
              label: 'NIK',
              controller: nikController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            EditProfileField(
              label: 'Email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColor.primary,
                    disabledForegroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: AppColor.descText),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Simpan Perubahan",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(height: 66,)
          ],
        ),
      ),
    );
  }
}
