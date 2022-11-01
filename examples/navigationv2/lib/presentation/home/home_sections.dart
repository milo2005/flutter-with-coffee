import 'package:flutter/material.dart';
import 'package:navigationv2/presentation/home/content/my_notifications_page.dart';
import 'package:navigationv2/presentation/home/content/my_purchases_page.dart';
import 'package:navigationv2/presentation/home/content/profile_page.dart';

enum HomeSection {
  myPurchases(0, "purchases"),
  myNotifications(1, "notifications"),
  profile(2, "profile");

  final String route;
  final int position;

  const HomeSection(this.position, this.route);

  static HomeSection fromRoute(String? route) {
    return HomeSection.values.firstWhere(
      (element) => element.route == route,
      orElse: () => HomeSection.myPurchases,
    );
  }

  Widget build() {
    switch (this) {
      case HomeSection.myNotifications:
        return const MyNotificationsPage();
      case HomeSection.myPurchases:
        return const MyPurchasesPage();
      case HomeSection.profile:
        return const ProfilePage();
    }
  }
}
