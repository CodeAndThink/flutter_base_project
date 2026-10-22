import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_base_project/core/extensions/text_style_extensions.dart';

void main() {
  testWidgets(
    'text styles follow the nearest theme and update on theme change',
    (tester) async {
      Widget build(Color color) => MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: color, fontSize: 19),
          ),
        ),
        home: Builder(
          builder: (context) =>
              Text('Example', style: context.textStyles.bodyMedium),
        ),
      );
      await tester.pumpWidget(build(Colors.black));
      expect(
        tester.widget<Text>(find.text('Example')).style?.color,
        Colors.black,
      );
      expect(tester.widget<Text>(find.text('Example')).style?.fontSize, 19);
      await tester.pumpWidget(build(Colors.white));
      await tester.pumpAndSettle();
      expect(
        tester.widget<Text>(find.text('Example')).style?.color,
        Colors.white,
      );
    },
  );

  testWidgets('copyWith customizes one style without changing the theme', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            final original = context.textStyles.titleMedium;
            final customized = original.copyWith(color: Colors.red);
            expect(customized.color, Colors.red);
            expect(customized.fontSize, original.fontSize);
            expect(context.textStyles.titleMedium, original);
            expect(original, Theme.of(context).textTheme.titleMedium);
            return const SizedBox();
          },
        ),
      ),
    );
  });

  testWidgets('movie styles preserve inherited color and existing typography', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            expect(context.textStyles.movieRating.fontSize, 18);
            expect(context.textStyles.movieRating.fontWeight, FontWeight.bold);
            expect(context.textStyles.movieOverviewTitle.fontSize, 22);
            expect(context.textStyles.movieOverviewBody.height, 1.5);
            expect(context.textStyles.movieOverviewBody.color, isNull);
            expect(context.textStyles.movieTitle.inherit, isTrue);
            return const SizedBox();
          },
        ),
      ),
    );
  });
}
