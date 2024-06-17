import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:si2_parcialito2/screens/classAssistance/classAssistance_screen.dart';
import 'package:si2_parcialito2/screens/classAssistance/scan_qr_screen.dart';
import 'package:si2_parcialito2/screens/horario_screen.dart';

import 'asistence/assistence_screen.dart';

class MenuScreenPage extends StatefulWidget {
  int? page;
  MenuScreenPage({super.key, this.page});

  @override
  _MenuScreenPageState createState() => _MenuScreenPageState();
}

class _MenuScreenPageState extends State<MenuScreenPage> {
  int _selectedIndex = MenuScreenPage().page ?? 0;
  final PageController _pageController = PageController();

  static final List<Widget> _pages = <Widget>[
    HorarioScreenPage(),
    AssistenceScreenPage(),
    ClassAssistanceScreen()
  ];

  @override
  void initState() {
    super.initState();
    if (widget.page != null) {
      _selectedIndex = widget.page!;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Horario',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in),
              label: 'Materias',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.free_breakfast),
              label: 'Asistencias',
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
