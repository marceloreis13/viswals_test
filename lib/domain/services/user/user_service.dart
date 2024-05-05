import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals/app/constants/constant.dart';
import 'package:viswals/app/constants/env.dart';
import 'package:viswals/app/helpers/api/responses/api_response.dart';
import 'package:viswals/domain/models/user/user_model.dart';
import 'package:viswals/domain/providers/user/user_dependencies.dart';
import 'package:viswals/ui/widgets/progress_circle/progress_circle_state.dart';

class UserService {
  final UserProviderProtocol provider;
  User get user => Env.user;

  UserService({required this.provider});

  /// Sets up the user session by loading user data from cached memory if available,
  /// otherwise uses the default user data.
  /// If it's the user's first access, updates the onboarding progress.
  ///
  /// Also, this is the point where the connection with the backend is made to persist the user session.
  ///
  /// Returns a [Future] of [ApiResponse] object containing the success status
  /// and the updated user data.
  Future<ApiResponse> setUpUserSession() async {
    try {
      //Load user from cached memory
      final source = await provider.getUser();
      Env.user = await source.object ?? Env.user;

      // Update onboarding progress case it is first access
      if (Env.user.onboardingProgress.isEmpty) {
        Env.user.onboardingProgress = Constant.progressCircleSteps;
      }

      // Get user from database
      User newUser = User(
        docType: Env.user.docType,
        onboardingProgress: Env.user.onboardingProgress,
      );

      ApiResponse response = ApiResponse(
        success: true,
        object: newUser,
      );

      return response;
    } catch (e) {
      return ApiResponse.genericError(e);
    }
  }

  Future<ApiResponse> setUser(User newUser) async {
    try {
      final source = await provider.setUser(newUser);

      ApiResponse response = ApiResponse(
        success: true,
        object: source.object,
      );

      return response;
    } catch (e) {
      return ApiResponse.genericError(e);
    }
  }

  void setAsFirstStep() {
    Env.user.onboardingProgress.asMap().forEach((index, step) {
      step.isActive = false;
    });
  }

  void setAsNextStep(BuildContext context) {
    final stepActive = ++Env.user.onboardingProgressStep;
    setStepAsActive(stepActive, context);
  }

  void setAsPrevStep(BuildContext context) {
    final stepActive = --Env.user.onboardingProgressStep;
    setStepAsActive(stepActive, context);
  }

  void setStepAsActive(int stepActive, BuildContext context) {
    if (stepActive < 1 || stepActive > Env.user.onboardingProgress.length) {
      return;
    }

    Env.user.onboardingProgressStep = stepActive;
    Env.user.onboardingProgress.asMap().forEach((index, step) {
      step.isActive = false;
      if ((stepActive - 1) == index) {
        step.isActive = true;
      }
    });

    setUser(Env.user);
    context.read<ProgressCircleState>().refresh();
  }

  void setStepAsCompleted(
    int stepComplete,
    BuildContext context, {
    bool isCompleted = true,
  }) {
    if (stepComplete < 1 || stepComplete > Env.user.onboardingProgress.length) {
      return;
    }

    Env.user.onboardingProgress[stepComplete - 1].isCompleted = isCompleted;

    setUser(Env.user);
    context.read<ProgressCircleState>().refresh();
  }
}
