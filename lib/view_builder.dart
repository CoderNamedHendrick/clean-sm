import 'package:cleaner_sm_approach/main.dart';
import 'package:cleaner_sm_approach/reactive_builder.dart';
import 'package:cleaner_sm_approach/view_model.dart';
import 'package:flutter/material.dart';

class ReactiveViewBuilder<T extends Object> extends StatelessWidget {
  const ReactiveViewBuilder({
    super.key,
    required this.listenable,
    required this.builder,
  });

  final ReactiveModel<T> listenable;
  final Function(BuildContext context, T state) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listenable,
      builder: (context, value, _) => builder(context, value),
    );
  }
}

class CounterWidget
    extends ReactiveWidget<CounterReactiveViewModel, CounterUiModel> {
  const CounterWidget({super.key});

  @override
  CounterReactiveViewModel get model => locator<CounterReactiveViewModel>();

  @override
  Widget build(BuildContext context, CounterUiModel state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '${state.count}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
