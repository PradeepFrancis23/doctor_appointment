abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpInvalidState extends SignUpState {}

class SignUpValidState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String errorMessage;

  SignUpErrorState(this.errorMessage);
}


class SignUpLoadingState extends SignUpState{}
