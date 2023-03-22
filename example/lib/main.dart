import 'package:flexible_spacer/flexible_spacer.dart';
import 'package:flexible_spacer/sliver_flexible_spacer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget buildColumn() {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const FlexibleSpacer(space: 16),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        const FlexibleSpacer(space: 64),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button:',
            ),
            const FlexibleSpacer(space: 32),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSliver() {
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        SliverFlexibleSpacer(space: 128),
        const SliverToBoxAdapter(
          child: Text(
            'You have pushed the button this many times:',
          ),
        ),
        SliverFlexibleSpacer(space: 128),
        SliverToBoxAdapter(
          child: Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(height: 50, color: Colors.blue, child: buildSliver()),
          Container(
            height: 200,
            color: Colors.black,
          ),
        ],
      ),
      // buildColumn(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
