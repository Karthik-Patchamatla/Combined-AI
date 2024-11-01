import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String userEmail = user?.email ?? 'Guest';
    String userInitial = userEmail.isNotEmpty ? userEmail[0].toUpperCase() : '';

    // Fetch the colors based on the current theme (light or dark)
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color drawerBackgroundColor = isDarkMode ? Colors.grey[900]! : Colors.grey[100]!;
    final Color headerBackgroundColor = isDarkMode ? Colors.grey[850]! : Colors.grey[300]!;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color iconColor = isDarkMode ? Colors.white : Colors.black;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Container(
        color: drawerBackgroundColor,
        padding: const EdgeInsets.only(top: 80.0),
        child: Column(
          children: [
            // User account header
            Container(
              padding: const EdgeInsets.all(16.0),
              color: headerBackgroundColor,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple[400],
                    radius: 25,
                    child: Text(
                      userInitial,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello,',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        userEmail,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Home navigation
            ListTile(
              leading: Icon(Icons.home, color: iconColor),
              title: Text('Home', style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
              },
            ),
            // Settings navigation
            ListTile(
              leading: Icon(Icons.settings, color: iconColor),
              title: Text('Settings', style: TextStyle(color: textColor)),
              onTap: () {
                
              },
            ),
            // Listening history navigation
            ListTile(
              leading: Icon(Icons.history, color: iconColor),
              title: Text('Listening History', style: TextStyle(color: textColor)),
              onTap: () {
                
              },
            ),
            // Privacy settings navigation
            ListTile(
              leading: Icon(Icons.privacy_tip, color: iconColor),
              title: Text('Settings and Privacy', style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
              },
            ),
            const Spacer(), // Add space between options and logout
            // Logout option
            ListTile(
              leading: Icon(Icons.logout, color: iconColor),
              title: Text('Logout', style: TextStyle(color: textColor)),
              onTap: () async {
                await auth.signOut();
                Navigator.of(context).pop(); // Close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}
