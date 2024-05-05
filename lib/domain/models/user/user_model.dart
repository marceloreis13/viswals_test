import 'package:viswals/app/constants/constant.dart';
import 'package:viswals/app/helpers/debugger_helper.dart';
import 'package:viswals/domain/models/country/country_model.dart';
import 'package:viswals/domain/models/model.dart';
import 'package:viswals/domain/models/user/user_constants.dart';
import 'package:viswals/domain/models/user/user_progress_model.dart';

class User extends Model {
  String? id;
  String? doc;
  UserDocType? docType;
  Country? country;
  List<UserProgressStepsModel> onboardingProgress;
  int onboardingProgressStep;

  User({
    this.id,
    this.doc,
    this.docType,
    this.country,
    onboardingProgress,
    this.onboardingProgressStep = 0,
  }) : onboardingProgress = onboardingProgress ?? [];

  factory User.fromJson(JSON? json) {
    try {
      if (json == null) {
        return User();
      }

      String? id = json['_id'];
      String? doc = json['doc'];
      UserDocType? docType = parseUserDocType(json['doc_type']);
      int onboardingProgressStep = json['onboarding_progress_step'] ?? 0;

      Country? country;
      if (json['country'] != null) {
        country = Country.fromJson(json['country']);
      }

      List<UserProgressStepsModel> onboardingProgress = [];
      Model.populate(json['onboarding_progress'], (item) {
        onboardingProgress.add(UserProgressStepsModel.fromJson(item));
      });

      return User(
        id: id,
        doc: doc,
        docType: docType,
        country: country,
        onboardingProgressStep: onboardingProgressStep,
        onboardingProgress: onboardingProgress,
      );
    } catch (e) {
      Log.e('[User] - Error on encode JSON', error: e);
      return User();
    }
  }

  JSON toJson() {
    final JSON data = <String, dynamic>{};
    data['_id'] = id;
    data['doc'] = doc;
    data['doc_type'] = enumToString(docType).toLowerCase();
    data['country'] = country?.toJson();
    data['onboarding_progress'] = onboardingProgress;
    data['onboarding_progress_step'] = onboardingProgressStep;

    return data;
  }

  static UserDocType? parseUserDocType(dynamic json) {
    if (json != null) {
      final entity = (json as String).toUpperCase();
      final isValid = UserDocType.values
          .where((e) => e.toString().split('.').last.toUpperCase() == entity)
          .isNotEmpty;
      if (isValid) {
        return UserDocType.values.firstWhere(
            (e) => e.toString().split('.').last.toUpperCase() == entity);
      }
    }

    return null;
  }

  User copyWith({
    String? id,
    String? doc,
    UserDocType? docType,
    Country? country,
    List<UserProgressStepsModel>? onboardingProgress,
    int? onboardingProgressStep,
  }) =>
      User(
        id: id ?? this.id,
        doc: doc ?? this.doc,
        docType: docType ?? this.docType,
        country: country ?? this.country,
        onboardingProgress: onboardingProgress ?? this.onboardingProgress,
        onboardingProgressStep:
            onboardingProgressStep ?? this.onboardingProgressStep,
      );
}
