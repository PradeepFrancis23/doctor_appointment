import 'package:bloc/bloc.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_event.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_state.dart';
import 'package:email_validator/email_validator.dart';

class LoginBloc extends Bloc<SignInEvent, SignInState> {
  LoginBloc() : super(SignInInitialState()) {



      // **Texfield Edit
    on<SignInTextChangingEvent>((event, emit) {


      if (event.emailValue == "" || EmailValidator.validate(event.emailValue) == false) {
        emit(ErrorState("Please enter a valid Email Address"));
      } else if (event.passwordValue.length < 5) {
        emit(ErrorState("Enter Valid Password"));
      } else {
        emit(ValidState());
      }
    });

      //  **On Login buttn press
    on<SignInSubmittedEvent>((event, emit) {
      emit(SigninLoadingState());
    });
  }
}
