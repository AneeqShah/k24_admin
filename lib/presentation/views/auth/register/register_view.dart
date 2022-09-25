// import 'package:flutter/material.dart';
// import '../../../../config/front_end_config.dart';
// import '../../../elements/custom_text.dart';
// import 'layout/register_body.dart';
//
// class RegisterView extends StatelessWidget {
//   const RegisterView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: Colors.white,
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 18.0),
//         child: GestureDetector(
//           onTap: (){
//             Navigator.pop(context);
//           },
//           child: Row(mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomText(text: 'Already have an account.'),
//               CustomText(text: 'Log In',color: FrontEndConfigs.kPrimaryColor,),
//             ],
//           ),
//         ),
//       ),
//       body: RegisterBody(),
//     );
//   }
// }
