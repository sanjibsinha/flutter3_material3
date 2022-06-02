import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/counting_the_number.dart';
import 'model/theme.dart';

final settings = ValueNotifier(ThemeSettings(
  sourceColor: Colors.pink,
  themeMode: ThemeMode.system,
));

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
      title: _title,
      home: const FlutterMaterialHome(),
    );
  }
}

class FlutterMaterialHome extends StatelessWidget {
  const FlutterMaterialHome({Key? key}) : super(key: key);

  static const List<String> _tabs = <String>['Pages', 'Categories'];
  static const List<String> _pages = <String>[
    'Home',
    'About',
    'Contact',
  ];
  static const List<String> _categories = <String>[
    'Flutter',
    'Dart',
    'Algorithm',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        // Listens to the scroll events and returns the current position.
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
            } else if (scrollNotification is ScrollEndNotification) {}
            // Return true to cancel the notification bubbling.
            return true;
          },
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: const Text('Flutter 3.0 Notification & Material 3'),
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                ListView.builder(
                  itemCount: _pages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text(_pages[index]));
                  },
                ),
                ListView.builder(
                  itemCount: _categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text(_categories[index]));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
