import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/theme_service.dart';
import 'features/counter/counter.dart';
import 'injection_container.dart';

/// Main application widget
class VendartApp extends StatelessWidget {
  const VendartApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Wrap with DynamicColorBuilder for Monet support
    // See theme_service.dart for implementation details
    return MaterialApp(
      title: 'Vendart POS',
      debugShowCheckedModeBanner: false,
      theme: ThemeService.lightTheme(),
      darkTheme: ThemeService.darkTheme(),
      themeMode: ThemeMode.system,
      home: BlocProvider(
        create: (_) => sl<CounterBloc>()..add(const CounterStarted()),
        child: const CounterPage(),
      ),
    );
  }
}
