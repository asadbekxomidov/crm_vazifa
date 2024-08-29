// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:vazifa/blocs/auth_bloc/auth_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SignInScreen extends StatelessWidget {
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   SignInScreen({super.key});

//   void _validateAndSubmit(BuildContext context) {
//     FocusScope.of(context).unfocus();
//     final String phone = _phoneController.text.trim();
//     final String password = _passwordController.text.trim();

//     if (phone.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Phone number cannot be empty'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     if (password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Password cannot be empty'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     context.read<AuthBloc>().add(LogIn(phone: phone, password: password));
//     Navigator.pushReplacementNamed(context, "/");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: const Color(0xffF4F9FD),
//       body: Padding(
//         padding:
//             const EdgeInsets.only(top: 120, bottom: 20, left: 20, right: 20),
//         child: BlocListener<AuthBloc, AuthState>(
//           listener: (context, state) {
//             if (state is Authenticated) {
//               Navigator.of(context).pushReplacementNamed('/home');
//             } else if (state is AuthErrorState) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.error),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//             }
//           },
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 40,
//                     clipBehavior: Clip.hardEdge,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Image.asset(
//                       "assets/images/workflow_icon.png",
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   const Text(
//                     "WorkRoom",
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: _phoneController,
//                       decoration: InputDecoration(
//                         labelText: 'Phone Number',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     TextField(
//                       controller: _passwordController,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       obscureText: true,
//                     ),
//                     SizedBox(height: 20.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         InkWell(
//                           child: Text(
//                             "Forgot Password?",
//                             style: TextStyle(
//                               fontSize: 14.h,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     BlocConsumer<AuthBloc, AuthState>(
//                       builder: (context, state) {
//                         if (state is AuthLoadingState) {
//                           return Container(
//                             height: 50,
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(15),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: Colors.blue),
//                             child: const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           );
//                         }
//                         return InkWell(
//                           splashColor: Colors.transparent,
//                           onTap: () => _validateAndSubmit(context),
//                           child: Container(
//                             height: 50,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.blue,
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: const Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Sign In',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(width: 10),
//                                   Icon(
//                                     Icons.arrow_forward,
//                                     color: Colors.white,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                       listener: (context, state) {},
//                     ),
//                     SizedBox(height: 20.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             context.read<AuthBloc>().add(SocialLogInEvent(
//                                 type: SocialLoginTypes.google));
//                           },
//                           splashColor: Colors.transparent,
//                           highlightColor: Colors.transparent,
//                           child: Container(
//                             height: 50.h,
//                             width: 50.w,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               color: Colors.blue.shade50,
//                             ),
//                             child: Center(
//                                 child: SvgPicture.asset(
//                                     'assets/svg/google_icons.svg')),
//                           ),
//                         ),
//                         SizedBox(width: 10.w),
//                         InkWell(
//                           splashColor: Colors.transparent,
//                           highlightColor: Colors.transparent,
//                           child: Container(
//                             height: 50.h,
//                             width: 50.w,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               color: Colors.blue.shade50,
//                             ),
//                             child: Center(
//                               child: SvgPicture.asset(
//                                   'assets/svg/facebook_icons.svg'),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10.w),
//                         InkWell(
//                           splashColor: Colors.transparent,
//                           highlightColor: Colors.transparent,
//                           child: Container(
//                             height: 50.h,
//                             width: 50.w,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               color: Colors.blue.shade50,
//                             ),
//                             child: Center(
//                               child: SvgPicture.asset(
//                                   'assets/svg/github_icons.svg'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.h),
//                     InkWell(
//                       onTap: () {
//                         Navigator.pushReplacementNamed(context, "/signup");
//                       },
//                       child: const Text(
//                         "Don't have an Account?",
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vazifa/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInScreen({super.key});

  void _validateAndSubmit(BuildContext context) {
    FocusScope.of(context).unfocus();
    final String phone = _phoneController.text.trim();
    final String password = _passwordController.text.trim();

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number cannot be empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password cannot be empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(LogIn(phone: phone, password: password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF4F9FD),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 120, bottom: 20, left: 20, right: 20),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.of(context).pushReplacementNamed('/home');
            } else if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      "assets/images/workflow_icon.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "WorkRoom",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell( 
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 14.h,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return Container(
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade800,
                                  Colors.blue.shade600
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        }
                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: () => _validateAndSubmit(context),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade800,
                                  Colors.blue.shade600
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.h,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      key: ValueKey<bool>(true),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      listener: (context, state) {},
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<AuthBloc>().add(SocialLogInEvent(
                                type: SocialLoginTypes.google));
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.blue.shade50,
                            ),
                            child: Center(
                                child: SvgPicture.asset(
                                    'assets/svg/google_icons.svg')),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.blue.shade50,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                  'assets/svg/facebook_icons.svg'),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.blue.shade50,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                  'assets/svg/github_icons.svg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/signup");
                      },
                      child: const Text(
                        "Don't have an Account?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
