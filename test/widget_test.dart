import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:duolingo_clon/app.dart';
import 'package:duolingo_clon/providers/learning_path_provider.dart';
import 'package:duolingo_clon/providers/user_stats_provider.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('login muestra el CTA y navega al home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserStatsProvider>(
            create: (_) => UserStatsProvider(),
          ),
          ChangeNotifierProvider<LearningPathProvider>(
            create: (_) => LearningPathProvider(),
          ),
        ],
        child: const DuolingoApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('duolingo'), findsOneWidget);
    expect(find.text('GET STARTED'), findsOneWidget);

    await tester.tap(find.text('GET STARTED'));
    await tester.pumpAndSettle();

    expect(find.text('Parejas: Expresa tus sentimientos'), findsOneWidget);
  });
}
