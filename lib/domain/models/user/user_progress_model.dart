import 'package:viswals/app/constants/constant.dart';
import 'package:viswals/app/helpers/debugger_helper.dart';

class UserProgressStepsModel {
  bool isCompleted;
  bool isActive;

  UserProgressStepsModel({
    required this.isCompleted,
    required this.isActive,
  });

  factory UserProgressStepsModel.fromJson(JSON? json) {
    try {
      if (json == null) {
        return UserProgressStepsModel(isCompleted: false, isActive: false);
      }

      bool isCompleted = json['is_complete'] ?? false;
      bool isActive = json['is_active'] ?? false;

      return UserProgressStepsModel(
        isCompleted: isCompleted,
        isActive: isActive,
      );
    } catch (e) {
      Log.e('[UserProgressStepsModel] - Error on encode JSON', error: e);
      return UserProgressStepsModel(isCompleted: false, isActive: false);
    }
  }

  JSON toJson({bool relationship = true}) {
    final JSON data = <String, dynamic>{};
    data['is_complete'] = isCompleted;
    data['is_active'] = isActive;

    return data;
  }
}
