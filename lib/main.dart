import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/repositories/app_repository.dart';
import 'presentation/app.dart';
import 'presentation/habits_bloc/habits_bloc.dart';
import 'utils/config/initialize_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDatabase = await initializeDependencies();

  final app = RepositoryProvider(
    create: (_) => appDatabase,
    child: MaterialApp(
      theme: ThemeData(useMaterial3: true),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
      ],
      home: BlocProvider(
        create: (context) => HabitsBloc(context.read<AppRepository>())..add(GetHabits()),
        child: const MainApp(),
      ),
    ),
  );

  runApp(app);
}
