import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);
    final mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadowColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.only(bottom: 8),
          width: mediaQuery.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: mediaQuery.width > 700
                    ? mediaQuery.height * 0.80
                    : mediaQuery.height * 0.75,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.shade700),
                      accountName: const Text(
                        'Unknown',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      accountEmail: const Text(
                        '.....',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      currentAccountPicture: Image.asset(
                        'assets/auth_banner.png',
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        //Get.toNamed(BottomNavigationScreen.routeNamed);
                      },
                      leading: const Icon(
                        Icons.dashboard,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Dashboard',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: mediaQuery.width > 700 ? 16 : 14),
                      ),
                      minLeadingWidth: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      onTap: () {
                        //Get.toNamed(BottomNavigationScreen.routeNamed);
                      },
                      leading: const Icon(
                        Icons.report,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Reports',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: mediaQuery.width > 700 ? 16 : 14),
                      ),
                      minLeadingWidth: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      onTap: () {
                        //Get.toNamed(BottomNavigationScreen.routeNamed);
                      },
                      leading: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Customer',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: mediaQuery.width > 700 ? 16 : 14),
                      ),
                      minLeadingWidth: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      onTap: () {
                        //Get.toNamed(BottomNavigationScreen.routeNamed);
                      },
                      leading: const Icon(
                        Icons.settings,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Settings',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: mediaQuery.width > 700 ? 16 : 14),
                      ),
                      minLeadingWidth: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      onTap: () {
                        //Get.toNamed(BottomNavigationScreen.routeNamed);
                      },
                      leading: const Icon(
                        Icons.help,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Help',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: mediaQuery.width > 700 ? 16 : 14),
                      ),
                      minLeadingWidth: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      onTap: () {
                        //Get.toNamed(BottomNavigationScreen.routeNamed);
                      },
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: mediaQuery.width > 700 ? 16 : 14),
                      ),
                      minLeadingWidth: 5,
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
