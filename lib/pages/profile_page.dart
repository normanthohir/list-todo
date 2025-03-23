import 'package:flutter/material.dart';
import 'package:workshop_flutter_firebases/pages/authentication/login/login_page.dart';
import 'package:workshop_flutter_firebases/services/authentication_services.dart';
import 'package:workshop_flutter_firebases/widgets/shared_appbar.dart';
import 'package:workshop_flutter_firebases/widgets/shared_buttton.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // fungsi untuk logout
  final _authService = AuthenticationServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppbar(title: 'Profile'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Norman Tho | ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Flutter Devoloper',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Member since ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: ' 31 Oktober 2022',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Email: ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'mannteh@gmail.com',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Phone number: ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '081234556772',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SharedButtton(
                title: Text('Logout'),
                onPressed: () {
                  _authService.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
