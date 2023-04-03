
import 'package:doctor_appointment/screens/auth_screens/signup_bloc/signup_event.dart';
import 'package:doctor_appointment/screens/auth_screens/signup_bloc/signup_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingUpBloc extends Bloc<SignUpEvent,SignUpState>{
   SingUpBloc() : super(SignUpInitialState())  {
        // **Texfield Edit
    on<SignUpTextChangingEvent>((event, emit) {


      if (event.emailValue == "" || EmailValidator.validate(event.emailValue) == false) {
        emit(SignUpErrorState("Please enter a valid Email Address"));
      } else if (event.passwordValue.length < 5) {
        emit(SignUpErrorState("Enter Valid Password"));
      } else {
        emit(SignUpValidState());
      }
    });

     //  **On Login buttn press
    on<SignUpSubmittedEvent>((event, emit) {
      emit(SignUpLoadingState());
    });

   }
}