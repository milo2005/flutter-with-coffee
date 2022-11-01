import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigationv2/presentation/home/home_sections.dart';

class HomePage extends StatelessWidget {
  final HomeSection section;

  const HomePage({required this.section, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getSelectedTitle()),
      ),
      body: section.build(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: section.position,
        onTap: (index)=>_goToContent(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Mis compras"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notificaciones"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }

  _goToContent(BuildContext ctx, int index){
    switch(index){
      case 0:
        ctx.replace("/home/${HomeSection.myPurchases.route}");
        break;
      case 1:
        ctx.replace("/home/${HomeSection.myNotifications.route}");
        break;
      case 2:
        ctx.replace("/home/${HomeSection.profile.route}");
        break;
    }
  }

  String _getSelectedTitle() {
    switch(section){
      case HomeSection.myPurchases: return "Mis Compras";
      case HomeSection.myNotifications: return "Notificaciones";
      case HomeSection.profile: return "Mi Perfil";
    }
  }
}