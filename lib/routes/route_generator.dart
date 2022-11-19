import 'package:classified_app/models/models.dart';
import 'package:classified_app/screens/screens.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  Route<dynamic> Function(RouteSettings) routes = (settings) {
    var routeName = settings.name;
    var args = settings.arguments;
    switch (routeName) {
      case '/login':
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case '/register':
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeScreen(data: args));
      case '/settings':
        return MaterialPageRoute(builder: (context) => const SettingsScreen());
      case '/edit-profile':
        return MaterialPageRoute(
          builder: (context) => EditProfileScreen(
            myUser: args as UserModel,
          ),
        );
      case '/my-ads':
        return MaterialPageRoute(
          builder: (context) => MyAdsScreen(data: args),
        );
      case '/edit-ad':
        return MaterialPageRoute(
          builder: (context) => EditAdScreen(
            data: args,
          ),
        );
      case '/product-detail':
        return MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
            data: args,
          ),
        );
      case '/create-ad':
        return MaterialPageRoute(
          builder: (context) => const CreateAdScreen(),
        );
      case '/image-viewer':
        return MaterialPageRoute(
          builder: (context) => ImageViewerScreen(
            data: args as List,
          ),
        );
    }
    return MaterialPageRoute(builder: (context) => const LoginScreen());
  };
}
