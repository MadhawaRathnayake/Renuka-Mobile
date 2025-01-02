import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustumDrawer extends StatelessWidget {
  CustumDrawer({super.key});

  // Function to handle logout
  void logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out the user

      // Navigate to the login screen or home screen after logout
      Navigator.pushReplacementNamed(context, '/loginorregister');
    } catch (e) {
      // Handle any errors during sign-out
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error logging out. Please try again.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  // Function to get the user's profile picture
  Future<Widget> getProfilePicture() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.photoURL != null) {
      return CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(user.photoURL!),
      );
    } else {
      return Icon(Icons.account_circle, size: 40); // Default profile icon
    }
  }

  // Function to get the user's display name
  Future<String> getDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? "Guest User";
  }

  @override
  Widget build(BuildContext context) {
    var kheight = MediaQuery.sizeOf(context).height;
    return Drawer(
        backgroundColor:
            Theme.of(context).colorScheme.surface, // Theme-based surface color
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: kheight * 0.05,
                  ),
                  Image.asset(
                    "assets/logo.png",
                    height: kheight * 0.08, // Set an appropriate height
                    fit: BoxFit
                        .contain, // Ensures the image scales proportionally
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed:
                          () {}, // Add any onTap functionality here if needed
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Align items at the top
                          children: [
                            FutureBuilder<Widget>(
                              future: getProfilePicture(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // Loading indicator
                                }
                                if (snapshot.hasError || !snapshot.hasData) {
                                  return Icon(Icons.account_circle,
                                      size: 40); // Default icon
                                }
                                return snapshot.data!;
                              },
                            ),
                            const SizedBox(
                                width: 10), // Spacing between picture and text
                            Expanded(
                              child: FutureBuilder<String>(
                                future: getDisplayName(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text(
                                      "Loading...",
                                      style: TextStyle(fontSize: 16),
                                    );
                                  }
                                  if (snapshot.hasError || !snapshot.hasData) {
                                    return Text(
                                      "Guest User",
                                      style: TextStyle(fontSize: 16),
                                    );
                                  }
                                  return Text(
                                    snapshot.data!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2, // Allow wrapping
                                    overflow: TextOverflow
                                        .visible, // Wrap text if necessary
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  _buildListTile(
                    context,
                    icon: Icons.home,
                    title: "H O M E",
                    onTap: () => Navigator.pushNamed(context, "/"),
                  ),
                  SizedBox(
                    height: kheight * 0.02,
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.location_on,
                    title: "D E S T I N A T I O N S",
                    onTap: () => Navigator.pushNamed(context, "/destinations"),
                  ),
                  SizedBox(
                    height: kheight * 0.02,
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.flight,
                    title: "F E A T U R E D  T O U R S",
                    onTap: () =>
                        Navigator.pushNamed(context, "/featured_tours"),
                  ),
                  SizedBox(
                    height: kheight * 0.02,
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.groups_rounded,
                    title: "A B O U T  U S",
                    onTap: () => Navigator.pushNamed(context, "/aboutus"),
                  ),
                ],
              ),
              Column(
                children: [
                  _buildListTile(context,
                      icon: Icons.logout,
                      title: "Log Out",
                      onTap: () => logout(context)),
                  SizedBox(
                    height: kheight * 0.02,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Widget _buildListTile(
  BuildContext context, {
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(
      icon,
      // Dynamic secondary icon color
    ),
    title: Text(
      title,
      style: TextStyle(
        // Updated text color for bodyLarge
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    onTap: onTap,
  );
}
