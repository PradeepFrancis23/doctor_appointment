import 'package:bloc/bloc.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_event.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_state.dart';
import 'package:email_validator/email_validator.dart';

class LoginBloc extends Bloc<SignInEvent, SignInState> {
  LoginBloc() : super(SignInInitialState()) {
    on<SignInTextChangingEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == false) {
        emit(ErrorState("Please enter a valid Email Address"));
      } else if (event.passwordValue.length < 8) {
        emit(ErrorState("Enter Valid Password"));
      } else {
        emit(ValidState());
      }
    });
    on<SignInSubmittedEvent>((event, emit) {
      emit(SigninLoadingState());
    });
  }
}
