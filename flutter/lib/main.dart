import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/network/dio_client.dart';
import 'core/theme/app_theme.dart';
import 'features/scan/cubit/scan_cubit.dart';
import 'features/scan/data/scan_api_service.dart';
import 'features/scan/data/scan_repository.dart';
import 'features/scan/presentation/screens/splash_screen.dart';

void main() {
  // Initialize Core Services
  final dioClient = DioClient();
  
  // Initialize Data Layer
  final scanApiService = ScanApiService(dioClient);
  final scanRepository = ScanRepository(scanApiService);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: scanRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ScanCubit(scanRepository)),
        ],
        child: const PhishGuardApp(),
      ),
    ),
  );
}

class PhishGuardApp extends StatelessWidget {
  const PhishGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhishGuard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
