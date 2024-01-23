import 'package:flutter/material.dart';

/// Gibt true zurück, wenn a hinter b liegt
bool isExpired(DateTime a, DateTime b) {
  return a.isAfter(b) && !a.isAtSameMomentAs(b);
}

/// wenn das Produkt bald abläuft, geben wir eine Orange-Farbe zurück
/// wenn das Proukt abgelaufen ist, geben wir eine Rote-Farbe zurück
/// sonst geben wir Weiß zurück
Color getExpireColor(DateTime a) {
  int days = a.difference(DateTime.now()).inDays;
  switch (days) {
    case > 0 && <= 2:
      return Colors.orange.withOpacity(0.8);
    case <= 0:
      return Colors.red.withOpacity(0.8);
    default:
      return Colors.white;
  }
}
