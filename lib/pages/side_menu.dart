import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFE8D6),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFFA9500)),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Menu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text("Home"),
            onTap: () => Navigator.pushNamed(context, '/huntersNote'),
          ),
          ListTile(
            title: const Text("About"),
            onTap: () => Navigator.pushNamed(context, '/about'),
          ),
          // ListTile(
          //   title: const Text("Hunter's Note"),
          //   onTap: () => Navigator.pushNamed(context, '/huntersNote'),
          // ),
          ListTile(
            title: const Text("Logout"),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
    );
  }
}
