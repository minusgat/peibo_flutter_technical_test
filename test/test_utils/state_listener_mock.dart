// Helper class to listen to Riverpod state changes
import 'package:mockito/mockito.dart';

class StateChangeListener<T> extends Mock {
  void call(T? previous, T next);
}