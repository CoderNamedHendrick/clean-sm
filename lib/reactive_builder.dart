import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReactiveModel<T extends Object> extends ValueNotifier<T> {
  ReactiveModel(super.value);

  T get state => value;

  set state(T newState) {
    value = newState;
  }

  @visibleForTesting
  @override
  set value(T newValue) {
    super.value = newValue;
  }

  @visibleForTesting
  @override
  T get value => super.value;
}

abstract class ReactiveWidget<E extends ReactiveModel<T>, T extends Object>
    extends StatefulWidget {
  const ReactiveWidget({super.key});

  E get model;

  Widget build(BuildContext context, T state);

  @override
  State<StatefulWidget> createState() => _ValueListenableBuilderState<E, T>();
}

class _ValueListenableBuilderState<E extends ReactiveModel<T>, T extends Object>
    extends State<ReactiveWidget<E, T>> {
  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.model.value;
    widget.model.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(ReactiveWidget<E, T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.model != widget.model) {
      oldWidget.model.removeListener(_valueChanged);
      value = widget.model.value;
      widget.model.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.model.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    setState(() {
      value = widget.model.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, value);
  }
}

extension ValueListenableX<T> on ValueListenable<T> {
  void onValueChangedListener(void Function(T? previous, T next) fn) {
    T? prev;
    return addListener(() {
      fn(prev, value);
      prev = value;
    });
  }
}
