// import 'package:flutter/material.dart';
// import 'package:lubes_bazaar/controller/cart_controller.dart';
// import 'package:lubes_bazaar/controller/product_controller.dart';
// import 'package:lubes_bazaar/controller/profile_controller.dart';
// import 'package:lubes_bazaar/services/auth_service.dart';
// import 'package:provider/provider.dart';
// import 'config/app_theme.dart';
// import 'config/app_routes.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final authService = AuthService();
//   final token = await authService.getToken(); // 🔹 token check

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ProductController()),
//         ChangeNotifierProvider(create: (_) => CartController()),
//         ChangeNotifierProvider(create: (_) => UserController()),
//       ],
//       child: MyApp(
//         initialRoute: token != null && token.isNotEmpty
//             ? AppRoutes.home
//             : AppRoutes.login,
//       ),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   final String initialRoute;
//   const MyApp({super.key, required this.initialRoute});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();

//     /// 🔹 App start hone ke baad user fetch karo (agar token hai)
//     Future.microtask(() {
//       final userController = context.read<UserController>();
//       userController.fetchUserFromToken();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Lubes Bazaar",
//       theme: AppTheme.lightTheme,
//       onGenerateRoute: AppRoutes.generateRoute,
//       initialRoute: widget.initialRoute,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 🔹 dotenv import
import 'package:lubes_bazaar/controller/cart_controller.dart';
import 'package:lubes_bazaar/controller/product_controller.dart';
import 'package:lubes_bazaar/controller/profile_controller.dart';
import 'package:lubes_bazaar/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'config/app_theme.dart';
import 'config/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 Load .env before anything else
  await dotenv.load(fileName: ".env");

  final authService = AuthService();
  final token = await authService.getToken(); // 🔹 token check

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => UserController()),
      ],
      child: MyApp(
        initialRoute: token != null && token.isNotEmpty
            ? AppRoutes.home
            : AppRoutes.login,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    /// 🔹 App start hone ke baad user fetch karo (agar token hai)
    Future.microtask(() {
      final userController = context.read<UserController>();
      userController.fetchUserFromToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lubes Bazaar",
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: widget.initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
