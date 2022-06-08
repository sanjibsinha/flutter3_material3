import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'model/counting_the_number.dart';
import 'model/theme.dart';

final settings = ValueNotifier(
  ThemeSettings(
    sourceColor: Colors.yellow.shade900,
    themeMode: ThemeMode.system,
  ),
);

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => CountingTheNumber(),
        builder: (context, _) => DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) => ThemeProvider(
            lightDynamic: lightDynamic,
            darkDynamic: darkDynamic,
            settings: settings,
            child: const FlutterMaterial(),
          ),
        ),
      ),
    );

class FlutterMaterial extends StatelessWidget {
  const FlutterMaterial({Key? key}) : super(key: key);

  static const String _title = 'Flutter 3.0 Notification & Material 3';

  @override
  Widget build(BuildContext context) {
    print('First Build');
    final theme = ThemeProvider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.dark(settings.value.sourceColor),
      darkTheme: theme.dark(settings.value.sourceColor), // Add this line
      themeMode: theme.themeMode(),
      title: _title,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Second Build');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'How Many Widget Builds',
          style: GoogleFonts.alexBrush(
            fontSize: 30.0,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: GoogleFonts.charm(
                fontSize: 40.0,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const Count(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),

        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        /// when [Counter] changes.
        onPressed: () => context.read<CountingTheNumber>().increaseValue(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Third Build');
    return Text(
      /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
      '${context.watch<CountingTheNumber>().value}',
      key: const Key('counterState'),
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
