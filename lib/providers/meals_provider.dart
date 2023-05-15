import 'package:flutter_food/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealsProvier = Provider((ref) {
  return dummyMeals;
});
