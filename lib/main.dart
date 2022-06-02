import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'model/counting_the_number.dart';
import 'model/theme.dart';

final settings = ValueNotifier(
  ThemeSettings(
    sourceColor: Colors.pink,
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
      title: _title,
      home: const FlutterMaterialHome(),
    );
  }
}

class FlutterMaterialHome extends StatelessWidget {
  const FlutterMaterialHome({Key? key}) : super(key: key);

  static const List<String> _tabs = <String>['Pages', 'Categories'];
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    BlogPage(),
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
                  title: const Text(
                    'Flutter 3.0 Notification & Material 3',
                  ),
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
                    return ListTile(title: _pages[index]);
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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      },
      child: Text(
        'Home Page',
        style: GoogleFonts.laila(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).cardTheme.color,
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: GoogleFonts.adventPro(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).cardTheme.shadowColor,
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 10,
            ),
          ),
          child: Text(
            'Home Page',
            style: GoogleFonts.laila(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).cardTheme.color,
            ),
          ),
        ),
      ),
    );
  }
}

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Blog(),
          ),
        );
      },
      child: Text(
        'Blog Page',
        style: GoogleFonts.laila(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).cardTheme.color,
        ),
      ),
    );
  }
}

class Blog extends StatelessWidget {
  const Blog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog Page',
          style: GoogleFonts.adventPro(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).cardTheme.shadowColor,
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 10,
            ),
          ),
          child: Text(
            'Blog Page',
            style: GoogleFonts.laila(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).cardTheme.color,
            ),
          ),
        ),
      ),
    );
  }
}
