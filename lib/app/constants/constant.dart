import 'package:viswals/domain/models/user/user_progress_model.dart';

typedef JSON = Map<String, dynamic>;

const int docDetailTypeStep = 1;
const int docDetailCountryStep = 2;
const int docDetailProfileStep = 3;

class Constant {
  static List<UserProgressStepsModel> progressCircleSteps = [
    UserProgressStepsModel(isCompleted: false, isActive: false),
    UserProgressStepsModel(isCompleted: false, isActive: false),
    UserProgressStepsModel(isCompleted: false, isActive: false),
  ];
}
