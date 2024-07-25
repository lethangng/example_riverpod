// import 'package:flutter/cupertino.dart';
// import 'package:mobile_framework/mobile_framework.dart';
//
// class SSOAuthenticator extends StatefulWidget {
//   final Widget main;
//   final Widget Function(
//           BuildContext context, String intialRoute, List<GetPage> initialPages)
//       childBuilder;
//
//   @override
//   State<SSOAuthenticator> createState() => _SSOAuthenticatorState();
//
//   const SSOAuthenticator({
//     super.key,
//     required this.main,
//     required this.childBuilder,
//   });
// }
//
// class _SSOAuthenticatorState extends State<SSOAuthenticator> {
//   late var ssoRoute = SSORoute(main: widget.main);
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.childBuilder(
//       context,
//       ssoRoute.initialRoute,
//       ssoRoute.initialPages,
//     );
//   }
// }
