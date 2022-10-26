import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final Widget child;

  const HomePage({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getSelectedTitle(context)),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selected(context),
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
        ctx.push("/purchases");
        break;
      case 1:
        ctx.push("/notifications");
        break;
      case 2:
        ctx.push("/profile");
        break;
    }
  }

  int _selected(BuildContext ctx){
    final location = GoRouter.of(ctx).location;
    switch(location){
      case "/purchases": return 0;
      case "/notifications": return 1;
      case "/profile": return 2;
      default: return 0;
    }
  }

  String _getSelectedTitle(BuildContext context) {
    final location = GoRouter.of(context).location;
    switch(location){
      case "/purchases": return "Mis Compras";
      case "/notifications": return "Notificaciones";
      case "/profile": return "Mi Perfil";
      default: return "";
    }
  }
}
