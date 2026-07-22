import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/app_typography.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinPilot',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const _ThemePreviewScreen(),
    );
  }
}

/// Temporary home screen used to visually verify the design system until
/// the dashboard feature (§4) is built.
class _ThemePreviewScreen extends StatelessWidget {
  const _ThemePreviewScreen();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).extension<AppTextStyles>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('FinPilot')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text('Balance', style: textStyles.labelMd),
          const SizedBox(height: 4),
          Text('\$4,231.90', style: textStyles.displayLg),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Coffee', style: textStyles.bodySm),
                  Text(
                    '-\$4.50',
                    style: textStyles.dataMono.copyWith(color: colors.onSurface),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Refund', style: textStyles.bodySm),
                  Text(
                    '+\$120.00',
                    style: textStyles.dataMono.copyWith(
                      color: colors.onTertiaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: () {}, child: const Text('Add Expense')),
          const SizedBox(height: 8),
          TextButton(onPressed: () {}, child: const Text('View all')),
        ],
      ),
    );
  }
}