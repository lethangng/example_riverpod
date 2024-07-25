// ignore_for_file: public_member_api_docs, sort_constructors_first

// class SSORoute {
//   Widget main;
//
//   List<GetPage> get initialPages {
//     return [
//       GetPage(name: "/auth", page: () => const SSOAuthPage()),
//       GetPage(
//           name: "/main",
//           page: () => main,
//           transition: Transition.downToUp,
//           curve: Curves.fastOutSlowIn),
//     ];
//   }
//
//   SSORoute({
//     required this.main,
//   }) {
//     SSO.ssoMain = main;
//   }
//
//   String get initialRoute {
//     if (SSO.isAppNoLongerSignedIn()) {
//       return "/auth";
//     }
//
//     return '/main';
//   }
//
//   static bool get isOnLogoutPage => Get.routing.current == "/auth";
// }
