import 'package:viswals/app/constants/constant.dart';
import 'package:viswals/app/helpers/debugger_helper.dart';
import 'package:viswals/ui/widgets/progress_circle/progress_model.dart';

class User {
  String? id;
  List<ProgressStepsModel>? onboardingProgress;

  User({
    this.id,
    this.onboardingProgress,
  });

  factory User.fromJson(JSON? json) {
    try {
      if (json == null) {
        return User();
      }

      String? id = json['_id'];
      List<ProgressStepsModel>? onboardingProgress =
          json['onboarding_progress'];

      return User(
        id: id,
        onboardingProgress: onboardingProgress,
      );
    } catch (e) {
      Log.e('[User] - Error on encode JSON', error: e);
      return User();
    }
  }

  JSON toJson({bool relationship = true}) {
    final JSON data = <String, dynamic>{};
    data['_id'] = id;
    data['onboarding_progress'] = onboardingProgress;

    if (relationship) {}

    return data;
  }

  User copyWith({
    String? id,
    List<ProgressStepsModel>? onboardingProgress,
  }) =>
      User(
        id: id ?? this.id,
        onboardingProgress: onboardingProgress ?? this.onboardingProgress,
      );
}
