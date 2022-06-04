import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'model/counting_the_number.dart';
import 'model/theme.dart';

final settings = ValueNotifier(
  ThemeSettings(
    sourceColor: Colors.red.shade900,
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
    final theme = ThemeProvider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.dark(settings.value.sourceColor),
      darkTheme: theme.dark(settings.value.sourceColor), // Add this line
      themeMode: theme.themeMode(),
      title: _title,
      home: const MyScaffold(),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          MyAppBar(
            title: Text(
              'Test Your Knowledge...',
              style: GoogleFonts.alexBrush(
                fontSize: 30.0,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: Text(
                  'Here we will place our body widget...',
                  style: GoogleFonts.charm(
                    fontSize: 60.0,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key, required this.title}) : super(key: key);

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 10,
        ),
      ),
      child: Row(
        children: <Widget>[
          const IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null,
          ),
          Expanded(
            child: title,
          ),
          const IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
