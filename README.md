## 💷 PiggyBank

**PiggyBank**, kullanıcıların kelime öğrenme süreçlerini yönetmesini sağlayan kişisel bir öğrenme asistanıdır. Uygulama, her kullanıcının kendine özel öğrenme süreçleri tanımlamasına olanak tanır ve bu süreçleri offline/online olarak yönetir. Flutter ile geliştirilen mobil uygulama, modern mimari desenler ve güncel teknolojilerle desteklenmiştir.

### 🎩 Proje Videosu

Uygulamanın tanıtım videosunu https://drive.google.com/file/d/1xkblZxt6_2Qgge6SANHkRbRnDRfruQq0/view?usp=sharing.

---

## 📦 Kullanılan Teknolojiler ve Yapılar

| Teknoloji / Paket        | Açıklama                                                                                                 |
| ------------------------ | -------------------------------------------------------------------------------------------------------- |
| **Flutter**              | Mobil uygulama geliştirme için temel framework.                                                          |
| **Bloc (flutter\_bloc)** | Uygulamada tüm state yönetimi bu yapı ile sağlanır. UI ile iş mantığı ayrıştırılmıştır.                  |
| **Clean Architecture**   | Presentation, Domain ve Data katmanlarına ayrılmıştır. Test edilebilirlik ve sürdürülebilirlik sağlanır. |
| **Hive**                 | Lokal veritabanı. Offline veri yönetimi için kullanılır.                                                 |
| **get\_it**              | Dependency Injection sağlar. Katmanlar arısı bağımsızlık kurar.                                          |
| **Equatable**            | Bloc yapısında state karşılaştırma için kullanılır.                                                      |
| **Localization**         | Çok dil desteği sunar. LocaleManager yapısı ile sağlanır.                                                |
| **Dartz**                | Either, Left, Right yapıları ile hata yönetimi sağlar.                                                   |
| **Connectivity\_plus**   | İnternet bağlantısı kontrolü.                                                                            |
| **Lottie**               | Kullanıcı deneyimini artırmak için animasyonlar.                                                         |

---

## 🧱‍🎓 Mimari

Uygulama Clean Architecture yapısında geliştirilmiştir:

```
lib/
├— core/
│   ├— common/
│   ├— error/
│   ├— localization/
│   ├— theme/
│   └— utils/
├— features/
│   ├— home/
│   │   ├— data/
│   │   ├— domain/
│   │   └— presentation/
│   ├— settings/
└— main.dart
```

---

## 🌍 Localization

- `tr` ve `en` JSON dosyaları ile dil desteği
- `LocaleManager` sınıfı ile kolay yönetim
- UI'da sabit yazı yoktur

---

## 📖 Özellikler

- ✨ Kelime havuzu yönetimi
- 💡 PiggyBank sistemi ile kelime öğrenme
- 🚫 Bağlantı yoksa hata mesajları
- 📊 Kullanıcı bazlı öğrenme istatistikleri
- ⚙️ Dil değişimi

---

## ✨ Kurulum

```bash
git clone https://github.com/ismailVasip/PiggyBank.git
cd PiggyBank
flutter pub get
flutter run
```

---

## 🚀 Geliştirici

**İsmail Vasip**\
[GitHub](https://github.com/ismailVasip)

---

---

## 🌐 PiggyBank (EN)

**PiggyBank** is a personal vocabulary learning assistant built with Flutter. It helps users manage their learning processes both online and offline with support for state management, local storage, and clean architecture principles.

### 🎩 Demo Video

Watch the short intro video [here](#).

---

## 📦 Technologies & Packages

| Tech / Package           | Description                                          |
| ------------------------ | ---------------------------------------------------- |
| **Flutter**              | Cross-platform mobile framework                      |
| **Bloc (flutter\_bloc)** | State management with Bloc pattern                   |
| **Clean Architecture**   | Separation of concerns: Data, Domain, Presentation   |
| **Hive**                 | NoSQL local storage for offline support              |
| **get\_it**              | Dependency Injection (DI)                            |
| **Equatable**            | Efficient Bloc state comparison                      |
| **Localization**         | Multi-language support with `LocaleManager`          |
| **Dartz**                | Functional error handling with Either / Left / Right |
| **Connectivity\_plus**   | Check internet connection                            |
| **Lottie**               | Beautiful animations for better UX                   |

---

## 🧱‍🎓 Architecture

Modular and scalable Clean Architecture:

```
lib/
├— core/
│   ├— common/
│   ├— error/
│   ├— localization/
│   ├— theme/
│   └— utils/
├— features/
│   ├— home/
│   │   ├— data/
│   │   ├— domain/
│   │   └— presentation/
│   ├— settings/
└— main.dart
```

---

## 🌍 Localization

- JSON-based language files
- Easy to manage with `LocaleManager`
- No hardcoded text in UI

---

## 📖 Features

- 📅 Personalized learning processes
- 💡 WordPool and PiggyBank systems
- 🚫 Offline support with clear error messages
- 📊 User-based statistics and progress
- ⚙️ Language switching

---

## ✨ Setup

```bash
git clone https://github.com/ismailVasip/PiggyBank.git
cd PiggyBank
flutter pub get
flutter run
```

---

## 🚀 Developer

**Ismail Vasip**\
[GitHub](https://github.com/ismailVasip)


