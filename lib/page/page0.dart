import 'package:flutter/material.dart';
import 'package:newmaster/page/page4.dart' show Page4;
import 'page1.dart';
import 'page12.dart'; // สมมุติว่าคุณมีไฟล์นี้

class Page0 extends StatefulWidget {
  const Page0({Key? key}) : super(key: key);

  @override
  State<Page0> createState() => _Page0State();
}

class _Page0State extends State<Page0> {
  Widget _currentPage = const Page1(); // หน้าเริ่มต้น
  String selectedMenu = 'sparepart'; // เมนูเริ่มต้นที่ active

  void _setPage(Widget page, String menuKey) {
    setState(() {
      _currentPage = page;
      selectedMenu = menuKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // 👇 รูปภาพที่ด้านบนของ Sidebar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: Icons.build,
                  label: 'Sparepart',
                  menuKey: 'sparepart',
                  page: const Page1(),
                ),
                _buildMenuItem(
                  icon: Icons.history,
                  label: 'History',
                  menuKey: 'history',
                  page: const Page12(),
                ),
                const Divider(),
                _buildMenuItem(
                  icon: Icons.logout,
                  label: 'Logout',
                  menuKey: 'logout',
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () {
                    // ทำ logout
                  },
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: _currentPage,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required String menuKey,
    Widget? page,
    Color? iconColor,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    final bool isSelected = selectedMenu == menuKey;

    return Container(
      color: isSelected ? Colors.grey[300] : null,
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(label, style: TextStyle(color: textColor)),
        onTap: onTap ??
            () => _setPage(
                  page ?? const SizedBox(),
                  menuKey,
                ),
      ),
    );
  }
}
