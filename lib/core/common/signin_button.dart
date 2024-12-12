// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../features/auth/controller/auth_controller.dart';
// import '../../theme/pallete.dart';
// import '../constants/constants.dart';
//
//
// class SignInButton extends ConsumerWidget {
//   final bool isFromLogin;
//   const SignInButton({Key? key, this.isFromLogin = true}) : super(key: key);
//
//   void signInWithGoogle(BuildContext context, WidgetRef ref) {
//     ref.read(authControllerProvider.notifier).signInWithGoogle(context,);
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.all(18.0),
//       child: ElevatedButton.icon(
//         onPressed: () => signInWithGoogle(context, ref),
//         icon: CachedNetworkImage(
//           width: 35, imageUrl: Constants.googleIcon,
//         ),
//         label: const Text(
//           'Continue with Google',
//           style: TextStyle(fontSize: 18),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Pallete.primaryColor,
//           minimumSize: const Size(double.infinity, 50),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//       ),
//     );
//   }
// }