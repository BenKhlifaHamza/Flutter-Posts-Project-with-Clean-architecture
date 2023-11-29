import 'core/constantes/app_theme.dart';
import 'features/posts/presentation/blocs/add_delete_update_post/add_delete_update_bloc.dart';
import 'features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'features/posts/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injections_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (_) => di.sl<AddDeleteUpdateBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Clean Architecture Project',
          theme: AppTheme.primaryTheme,
          initialRoute: "/",
          routes: {"/": (_) => const PostsPage()},
        ));
  }
}
