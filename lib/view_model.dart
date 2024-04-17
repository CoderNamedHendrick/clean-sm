import 'package:flutter/material.dart';

import 'reactive_builder.dart';

class CounterReactiveViewModel extends ReactiveModel<CounterUiModel> {
  CounterReactiveViewModel() : super(const CounterUiModel.initial());

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }
}

@immutable
final class CounterUiModel {
  final int count;
  final int secondCount;

  const CounterUiModel({required this.count, required this.secondCount});

  const CounterUiModel.initial() : this(count: 0, secondCount: 0);

  CounterUiModel copyWith({int? count, int? secondCount}) => CounterUiModel(
        count: count ?? this.count,
        secondCount: secondCount ?? this.secondCount,
      );

  @override
  int get hashCode => count.hashCode ^ secondCount.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterUiModel &&
          runtimeType == other.runtimeType &&
          count == other.count &&
          secondCount == other.secondCount;

  @override
  String toString() {
    return 'CounterUiModel(count: $count, secondCount: $secondCount)';
  }
}
