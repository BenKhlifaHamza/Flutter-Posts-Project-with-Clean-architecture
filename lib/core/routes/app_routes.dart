import 'package:flutter/material.dart';

import '../../features/posts/presentation/pages/posts_page.dart';
import 'routes_names.dart';

class AppRoutes {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.postPage:
        return MaterialPageRoute(
          builder: (_) => const PostsPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const PostsPage(),
        );
    }
  }
}
