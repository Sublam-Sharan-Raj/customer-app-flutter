import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:insta_closet/bad_request.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/auth/auth_event.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/models/auth.dart';
import 'package:insta_closet/services/user_service.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthBloc authBloc;
  final UserService _userService = UserService();

  SignInBloc({
    required this.authBloc,
  }) : super(SignInInitial()) {
    on<SignInEvent>((event, emit) async {
      if (event is GenerateVerificationCode) {
        emit(SignInSendingCodeState());
        EasyLoading.show(status: 'Loading...');

        if (Constants.regrexValidation['mobile']!.hasMatch(event.userName!) ||
            Constants.regrexValidation['email']!.hasMatch(event.userName!)) {
          final payload = {"user_name": event.userName};

          try {
            final response =
                await _userService.generateVerificationCode(payload);

            if (response.statusCode == 200 || response.statusCode == 201) {
              // Emit success state
              emit(SignInCodeSentState(event.userName));
            } else {
              // Check if the response contains 'errors' and emit error state
              if (response.data.containsKey('errors')) {
                emit(SignInErrorState(response.data['message']));
              } else {
                emit(SignInErrorState('Unknown error occurred'));
              }
            }
          } on BadRequest catch (error) {
            emit(SignInErrorState(
                error.errors![error.errors!.keys.toList()[0]]));
          } on Exception catch (error) {
            emit(SignInErrorState(error.toString()));
          }
        } else {
          emit(SignInErrorState("Invalid mobile number or email address."));
        }
      }
      if (event is ValidateVerificationCode) {
        emit(SignInValidatingCodeState());
        try {
          final payload = {"user_name": event.userName, "code": event.code};
          final response = await _userService.validateVerificationCode(payload);
          if (response.statusCode == 200 || response.statusCode == 201) {
            Auth authData = Auth.fromJson(response.data);
            authBloc.add(LoggedIn(authData));
            emit(SignInFinishedState());
          } else {
            // Check if the response contains 'errors' and emit error state
            if (response.data.containsKey('errors')) {
              emit(SignInErrorState(response.data['message']));
            } else {
              emit(SignInErrorState('Unknown error occurred'));
            }
          }
        } on BadRequest catch (error) {
          emit(SignInErrorState(error.errors![error.errors!.keys.toList()[0]]));
        } on Exception catch (error) {
          emit(SignInErrorState(error.toString()));
        }
      }
      if (event is CreateNewAccount) {
        emit(SignInCreatingAccountState());
        try {
          final payload = {
            "last_name": event.lastName,
            "first_name": event.firstName,
            "role": "CUSTOMER",
            "email": event.email,
            "mobile": event.mobile
          };
          final response = await _userService.createNewAccount(payload);
          if (response.statusCode == 200 || response.statusCode == 201) {
            BlocProvider.of<SignInBloc>(event.context)
                .add(GenerateVerificationCode(
              userName: event.mobile,
            ));
            emit(SignInCreateAccountSuccessState());
          } else {
            if (response.data.containsKey('errors')) {
              emit(SignInCreateAccountErrorState(response.data['message']));
            } else {
              emit(SignInCreateAccountErrorState('Unknown error occurred'));
            }
          }
        } on BadRequest catch (error) {
          emit(SignInCreateAccountErrorState(
              error.errors![error.errors!.keys.toList()[0]]));
        } on Exception catch (error) {
          emit(SignInCreateAccountErrorState(error.toString()));
        }
      }
    });
  }
}
