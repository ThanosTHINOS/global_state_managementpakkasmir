import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalState with ChangeNotifier {
  final List<int> _counters = [];

  List<int> get counters => _counters;

  void addCounter() {
    _counters.add(0);
    notifyListeners();
  }

  void removeCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      _counters.removeAt(index);
      notifyListeners();
    }
  }

  void incrementCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      _counters[index]++;
      notifyListeners();
    }
  }

  void decrementCounter(int index) {
    if (index >= 0 && index < _counters.length && _counters[index] > 0) {
      _counters[index]--;
      notifyListeners();
    }
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Global State Example")),
        body: const CounterScreen(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<GlobalState>(context, listen: false).addCounter(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, globalState, child) {
        return ListView.builder(
          itemCount: globalState.counters.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Counter ${index + 1}: ${globalState.counters[index]}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => globalState.incrementCounter(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => globalState.decrementCounter(index),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
