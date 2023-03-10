abstract class SignInState {}

class SignInInitialState extends SignInState {}

class InvalidState extends SignInState {}

class ValidState extends SignInState {}

class ErrorState extends SignInState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}


class SigninLoadingState extends SignInState{}
