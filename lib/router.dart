// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:go_router/go_router.dart';

import 'src/pages/login.page.dart';
import 'src/pages/splash.page.dart';
import 'src/pages/student_detail.page.dart';
import 'src/pages/student_form.page.dart';
import 'src/pages/welcome.page.dart';

const routeLogin = 'login';
const routeSplash = 'splash';
const routeWelcome = 'welcome';
const routeStudentForm = 'student-form';
const routeDetailStudent = 'detail-student';

final _routes = <RouteBase>[
  GoRoute(
    path: "/splash",
    name: routeSplash,
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: "/login",
    name: routeLogin,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: "/welcome",
    name: routeWelcome,
    builder: (context, state) => const WelcomePage(),
  ),
  GoRoute(
    path: "/student-form/:id",
    name: routeStudentForm,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? '-1';
      return StudentFormPage(id: int.parse(id));
    },
  ),
  GoRoute(
    path: "/student/:id",
    name: routeDetailStudent,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? '-';
      return StudentDetailPage(id: int.parse(id));
    },
  ),
];

final routerConfig = GoRouter(
  // initialLocation: '/welcome',
  initialLocation: '/splash',
  routes: _routes,
);
