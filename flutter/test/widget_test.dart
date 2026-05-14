import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:phishguard/core/network/dio_client.dart';
import 'package:phishguard/features/scan/cubit/scan_cubit.dart';
import 'package:phishguard/features/scan/data/scan_api_service.dart';
import 'package:phishguard/features/scan/data/scan_repository.dart';
import 'package:phishguard/features/scan/presentation/screens/splash_screen.dart';
import 'package:phishguard/main.dart';

void main() {
  testWidgets('PhishGuard home shows app title and scan action', (
    WidgetTester tester,
  ) async {
    final dioClient = DioClient();
    final scanApiService = ScanApiService(dioClient);
    final scanRepository = ScanRepository(scanApiService);

    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: scanRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ScanCubit(scanRepository)),
          ],
          child: const PhishGuardApp(),
        ),
      ),
    );

    await tester.pump(SplashScreen.displayDuration + const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    expect(find.text('PhishGuard'), findsOneWidget);
    expect(find.textContaining('Check a link'), findsOneWidget);
    expect(find.text('Scan URL'), findsOneWidget);
  });
}
