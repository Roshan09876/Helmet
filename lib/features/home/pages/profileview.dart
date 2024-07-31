import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helmet/app/app_routes.dart';
import 'package:helmet/constants/show_snackbar.dart';
import 'package:helmet/features/auth/service/service.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

final Service _service = Service();

class _ProfileViewState extends ConsumerState<ProfileView> {
  Map<String, dynamic>? _profileData;

  void getProfile() async {
    try {
      print('Fetching profile data...');
      final response = await _service.getProfile(context);
      print('API response: $response');
      if (response != null &&
          response['success'] == true &&
          response.containsKey('user')) {
        setState(() {
          _profileData = response['user'];
        });
        print('Profile data set: $_profileData');
      } else {
        throw Exception(response['message'] ?? 'Failed to fetch profile data');
      }
    } catch (e) {
      print('Error fetching profile: $e');
      showSnackBar(
        color: Colors.red,
        message: e.toString().replaceFirst('Exception: ', ''),
        context: context,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  Future<void> logout(BuildContext context) async {
    await secureStorage.delete(key: "token");
    EasyLoading.showSuccess('Logged out', dismissOnTap: true);
    Navigator.pushReplacementNamed(context, AppRoute.loginRoute);
  }

  void showLogout(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: "Logout",
      //  titleTextStyle: G.montserrat(
      //   color: AppColors.primaryColor,
      //   fontSize: 15,
      //   fontWeight: FontWeight.w600,
      // ),
      desc: "Are you sure you want to logout?",
      btnCancelOnPress: () {},
      btnOkOnPress: () => logout(context),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: _profileData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/helmet1.png'),
                      backgroundColor: Colors.orangeAccent,
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${_profileData!['firstName']} ${_profileData!['lastName']}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _profileData!['email'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.phone, color: Colors.orange),
                              title: Text(
                                'Phone Number',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(_profileData!['phoneNum']),
                            ),
                            Divider(),
                            ListTile(
                              leading:
                                  Icon(Icons.location_on, color: Colors.orange),
                              title: Text(
                                'Address',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  '123 Main St, City, Country'), // Add actual address field if available
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.calendar_today,
                                  color: Colors.orange),
                              title: Text(
                                'Date of Birth',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  'January 1, 1990'), // Add actual DOB field if available
                            ),
                          ],
                        ),
                      ),
                    ),
                    SettingsGroup(
                      settingsGroupTitle: 'Account',
                      items: [
                        SettingsItem(
                          onTap: () {
                            showLogout(context);
                          },
                          icons: Icons.exit_to_app_rounded,
                          title: "Sign Out",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
