import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/ui/screens/auth/login_screen.dart';
import 'package:vazifa/ui/screens/auth/register_admin_for_teacher.dart';
import 'package:vazifa/ui/screens/auth/register_screen.dart';
import 'package:vazifa/ui/screens/managment_screen.dart';
import 'data/services/services.dart';
import 'blocs/blocs.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SubjectServices subjectServices = SubjectServices();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AppStarted())),
        BlocProvider(create: (context) => CurrentUserBloc()),
        BlocProvider(create: (context) => UsersBloc()),
        BlocProvider(create: (context) => GroupBloc()),
        BlocProvider(create: (context) => RoomBloc()),
        BlocProvider(create: (context) => TimetableBloc()),
        BlocProvider(create: (context) => SubjectBloc(subjectServices)),
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        return ManagmentScreen();
                      } else if (state is UnauthenticatedState) {
                        return SignInScreen();
                      } else if (state is AuthErrorState) {
                        if (state.error == 'register') {
                          return SignUpScreen();
                        } else {
                          return SignInScreen();
                        }
                      } else {
                        return SignInScreen();
                      }
                    },
                  ),
              '/signup': (context) => SignUpScreen(),
              '/signupteacher': (context) => SignupForTeacher(),
              '/home': (context) => ManagmentScreen(),
            },
          );
        },
      ),
    );
  }
}

/*

admin {
  name: asadbek_xomidov,
  phone: 998908579552,
  password: admin2006A,
}

student {
  name: asadbek,
  phone: +998333333333,
  password: student2006S,
}

teacher {
  name: asadbek,
  phone: 998920060909,
  password: teacher2006T,
}

*/
