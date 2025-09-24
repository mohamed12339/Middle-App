
import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart' as math;

import 'package:middle/backend/schema/reviews_record.dart';

double ratingSummary(
  double totalRatings,
  double rating,
) {
  /// get average rating to one decimal point from list of reviews
  if (totalRatings > 0) {
    return (rating +
            (totalRatings - rating) ~/ math.max((totalRatings ~/ 5), 1)) /
        2;
  } else {
    return rating;
  }
}

String ratingSummaryList(List<ReviewsRecord> rating) {
  if (rating.isEmpty) {
    return '-';
  }
  var ratingsSum = 0.0;
  for (final comment in rating) {
    ratingsSum += comment.rating;
  }
  return (ratingsSum / rating.length).toStringAsFixed(1);
}
