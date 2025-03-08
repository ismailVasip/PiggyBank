import 'package:flutter/material.dart';

class AppPalette {
  // Arka plan rengi: Sakin ve odaklanmayı artıran koyu bir renk
  static const Color backgroundColor = Color.fromRGBO(28, 28, 36, 1); // Koyu gri-mavi

  // Gradyan renkleri: Enerjik ama rahatsız etmeyen renkler
  static const Color gradient1 = Color.fromRGBO(100, 145, 230, 1); // Mavi (sakinlik ve güven)
  static const Color gradient2 = Color.fromRGBO(140, 200, 240, 1); // Açık mavi (öğrenmeyi destekler)
  static const Color gradient3 = Color.fromRGBO(255, 200, 150, 1); // Pastel turuncu (yaratıcılık ve motivasyon)

  // Kenarlık rengi: Arka planla uyumlu, düşük kontrastlı bir renk
  static const Color borderColor = Color.fromRGBO(52, 51, 67, 1); // Koyu gri

  // Metin ve arayüz renkleri
  static const Color whiteColor = Colors.white; // Beyaz (okunabilirlik için)
  static const Color blackColor = Colors.black;
  static const Color greyColor = Colors.grey; // Gri (ikincil metinler için)
  static const Color errorColor = Color.fromRGBO(255, 100, 100, 1); // Yumuşak kırmızı (hata mesajları için)
  static const Color transparentColor = Colors.transparent; // Şeffaf renk

  // Ekstra renkler: Öğrenme sürecini destekleyecek renkler
  static const Color successColor = Color.fromRGBO(100, 200, 100, 1); // Yeşil (başarı ve olumlu geri bildirim)
  static const Color warningColor = Color.fromRGBO(255, 200, 100, 1); // Sarı (uyarılar için)
  static const Color accentColor = Color.fromRGBO(100, 145, 230, 1); // Mavi (ana aksan rengi)
}