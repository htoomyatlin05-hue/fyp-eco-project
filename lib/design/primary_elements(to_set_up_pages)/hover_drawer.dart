import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/welcomelogo.dart';

class HoverSidebarWithNested extends StatefulWidget {
  final Function(int) onSelectPage;

  const HoverSidebarWithNested({super.key, required this.onSelectPage});

  @override
  State<HoverSidebarWithNested> createState() => _HoverSidebarWithNestedState();
}

class _HoverSidebarWithNestedState extends State<HoverSidebarWithNested>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  bool _openSubmenu = false;

  @override
  Widget build(BuildContext context) {
    // --- Shortcuts (main items) ---
    final shortcuts = [
      
      _drawerTile("Attributes", () => widget.onSelectPage(1)),
      _drawerTile("Allocation", () => widget.onSelectPage(2)),
      _drawerTile("Sustainability News", () => widget.onSelectPage(3)),
      _drawerTile("About Us", () => widget.onSelectPage(4)),
      _drawerTile("Debug Page", () => widget.onSelectPage(5)),
    ];

    // --- Bookmarks / Categories (now as submenu) ---
    final bookmarks = [
      _drawerTileLight("Category 1", () => widget.onSelectPage(6)),
      _drawerTileLight("Category 2", () => widget.onSelectPage(7)),
      _drawerTileLight("Category 3", () => widget.onSelectPage(8)),
      _drawerTileLight("Category 4", () => widget.onSelectPage(9)),
      _drawerTileLight("Category 5", () => widget.onSelectPage(10)),
      _drawerTileLight("Category 9", () => widget.onSelectPage(11)),
      _drawerTileLight("Category 10", () => widget.onSelectPage(12)),
      _drawerTileLight("Category 11", () => widget.onSelectPage(13)),
      _drawerTileLight("Category 12", () => widget.onSelectPage(14)),
    ];

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _openSubmenu = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: _hovered ? 250 : 60,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: const BorderRadius.only(topRight: Radius.circular(30)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(),
            ),
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                // --- Logo / Title ---
                

                // --- Shortcut Tiles ---
                ...shortcuts,

                // --- Parent Tile with Submenu (Scope & Categories) ---
                _parentTile(
                  icon: Icons.calculate,
                  label: "Scope & Categories",
                  isOpen: _openSubmenu,
                  onTap: () => setState(() => _openSubmenu = !_openSubmenu),
                ),

                // --- Animated Submenu ---
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  alignment: Alignment.topLeft,
                  child: (_hovered && _openSubmenu)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              color: Colors.white24,
                              indent: 16,
                              endIndent: 16,
                              thickness: 1,
                            ),
                            // --- Bookmarks as submenu ---
                            ...bookmarks,
                          ],
                        )
                      : const SizedBox.shrink(),
                ),

                // --- Settings Tile ---
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---
Widget _drawerTile(String title, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 16), // Icon padding
        const Icon(Icons.circle, color: Colors.white, size: 20),
        if (_hovered) ...[
          const SizedBox(width: 16), // Space between icon and label
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: onTap,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // remove extra padding
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

Widget _parentTile({
  required IconData icon,
  required String label,
  required bool isOpen,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: _hovered ? onTap : null,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 16), // Icon padding
          Icon(icon, color: Colors.white, size: 20),
          if (_hovered) ...[
            const SizedBox(width: 16), // Space between icon and label
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            AnimatedRotation(
              turns: isOpen ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ),
            const SizedBox(width: 12), // Right padding for arrow
          ],
        ],
      ),
    ),
  );
}


  Widget _drawerTileLight(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 4, bottom: 4),
      child: Row(
        children: [
          const SizedBox(width: 12),
          if (_hovered)
            Expanded(
              child: TextButton(
                onPressed: onTap,
                child: Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
              ),
            )
        ],
      ),
    );
  }


  Widget _submenuTile(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 58, top: 4, bottom: 4),
      child: Row(
        children: [
          Icon(Icons.circle, size: 6, color: Colors.white.withOpacity(0.7)),
          const SizedBox(width: 12),
          if (_hovered)
            Text(text,
                style:
                    const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

Widget _titleTile(Widget icon,String title, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 0), // Icon padding
        icon,
        if (_hovered) ...[
          const SizedBox(width: 16), // Space between icon and label
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: onTap,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // remove extra padding
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ],
      ],
    ),
  );
}


}
