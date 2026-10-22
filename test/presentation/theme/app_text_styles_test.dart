import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_base_project/presentation/theme/app_text_styles.dart';

void main() {
  testWidgets('static styles inherit color and font from their surroundings', (
    tester,
  ) async {
    Widget build(Color color) => MaterialApp(
      home: DefaultTextStyle(
        style: TextStyle(color: color, fontFamily: 'TestFont'),
        child: Text('Example', style: AppTextStyles.bodyMedium),
      ),
    );
    TextStyle renderedStyle() =>
        (tester
                    .widget<RichText>(
                      find.descendant(
                        of: find.text('Example'),
                        matching: find.byType(RichText),
                      ),
                    )
                    .text
                as TextSpan)
            .style!;
    await tester.pumpWidget(build(Colors.black));
    expect(renderedStyle().color, Colors.black);
    expect(renderedStyle().fontFamily, 'TestFont');
    expect(renderedStyle().fontSize, 14);
    await tester.pumpWidget(build(Colors.white));
    await tester.pumpAndSettle();
    expect(renderedStyle().color, Colors.white);
    expect(AppTextStyles.bodyMedium.color, isNull);
  });

  test('copyWith customizes a static style without changing its default', () {
    final customized = AppTextStyles.titleMedium.copyWith(color: Colors.red);
    expect(customized.color, Colors.red);
    expect(customized.fontSize, 16);
    expect(AppTextStyles.titleMedium.color, isNull);
  });

  test('movie styles preserve inherited color and typography', () {
    expect(AppTextStyles.movieRating.fontSize, 18);
    expect(AppTextStyles.movieRating.fontWeight, FontWeight.bold);
    expect(AppTextStyles.movieOverviewTitle.fontSize, 22);
    expect(AppTextStyles.movieOverviewBody.height, 1.5);
    expect(AppTextStyles.movieOverviewBody.color, isNull);
    expect(AppTextStyles.movieTitle.inherit, isTrue);
  });
}
