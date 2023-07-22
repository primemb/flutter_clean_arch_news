import 'package:clean_arch_news/config/theme/app_theme.dart';
import 'package:clean_arch_news/features/daily_news/presentation/bloc/article/remote/remote_bloc.dart';
import 'package:clean_arch_news/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:clean_arch_news/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        home: const DailyNews(),
      ),
    );
  }
}
