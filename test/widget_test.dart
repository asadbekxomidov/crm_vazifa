import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/auth_bloc/auth_bloc.dart';
import 'package:vazifa/blocs/current_user_bloc/current_user_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_bloc.dart';
import 'package:vazifa/blocs/timetable_bloc/timetable_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_bloc.dart';
import 'package:vazifa/data/services/subject_services.dart';
import 'package:vazifa/ui/screens/auth/register_admin_for_teacher.dart';
import 'package:vazifa/ui/screens/auth/register_screen.dart';
import 'package:vazifa/ui/screens/managment_screen.dart';
import 'package:vazifa/ui/screens/auth/login_screen.dart';

void main() {
  testWidgets('App starts and displays the correct initial screen based on authentication state', (WidgetTester tester) async {
    // Create mock Blocs
    final authBloc = AuthBloc();
    final currentUserBloc = CurrentUserBloc();
    final usersBloc = UsersBloc();
    final groupBloc = GroupBloc();
    final roomBloc = RoomBloc();
    final timetableBloc = TimetableBloc();
    
    final subjectServices = SubjectServices();
    final subjectBloc = SubjectBloc(subjectServices);

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: authBloc),
          BlocProvider<CurrentUserBloc>.value(value: currentUserBloc),
          BlocProvider<UsersBloc>.value(value: usersBloc),
          BlocProvider<GroupBloc>.value(value: groupBloc),
          BlocProvider<RoomBloc>.value(value: roomBloc),
          BlocProvider<TimetableBloc>.value(value: timetableBloc),
          BlocProvider<SubjectBloc>.value(value: subjectBloc),
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
      ),
    );

    // Assert that the SignInScreen is displayed initially
    expect(find.byType(SignInScreen), findsOneWidget);

    // Simulate an authentication state change to Authenticated
    authBloc.add(LoggedOut());

    // Rebuild the widget after state change
    await tester.pumpAndSettle();

    // Assert that the ManagementScreen is displayed after login
    expect(find.byType(ManagmentScreen), findsOneWidget);
  });
}
