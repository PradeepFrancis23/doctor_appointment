abstract class SignInEvent {}

class SignInTextChangingEvent extends SignInEvent {
  final String emailValue;
  final String passwordValue;

  SignInTextChangingEvent(this.emailValue, this.passwordValue);

}


class SignInSubmittedEvent extends SignInEvent{
  final String email;
  final String password;

  SignInSubmittedEvent(this.email, this.password);

}