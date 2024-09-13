import 'package:flutter/material.dart';
import 'package:swipe_tab_controller/swipe_tab_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Tab Controller',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Swipe Tab Controller'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  bool isLoading = false;

  void changeLoading(bool value) {
    setState(() => isLoading = value);
  }

  void changeTab(int index) async {
    changeLoading(true);
    setState(() => selectedIndex = index);
    await Future.delayed(const Duration(milliseconds: 1300));
    changeLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SwipeTabController(
        onTabChanged: changeTab,
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              bottom: TabBar(
                labelStyle: Theme.of(context).textTheme.titleLarge,
                indicatorColor: Theme.of(context).colorScheme.primary,
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: changeTab,
                tabs: const [
                  Text('Tab1'),
                  Text('Tab2'),
                  Text('Tab3'),
                ],
              ),
            ),
            body: TabBarView(children: [
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Tab 1',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
              ),
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Tab 2',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
              ),
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Tab 3',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
              ),
            ])),
      ),
    );
  }
}
