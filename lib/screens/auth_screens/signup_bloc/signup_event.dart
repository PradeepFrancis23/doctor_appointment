abstract class SignUpEvent {}

class SignUpTextChangingEvent extends SignUpEvent {
  final String fullname;
  final String phoneNumber;
  final String emailValue;

  final String passwordValue;
  final String confirmPasswordValue;

  SignUpTextChangingEvent(this.emailValue, this.passwordValue, this.fullname, this.phoneNumber, this.confirmPasswordValue);
}

class SignUpSubmittedEvent extends SignUpEvent {
  final String fullname;
  final String phoneNumber;
  final String email;
  final String passwordValue;
  final String password;

  SignUpSubmittedEvent(this.email, this.password, this.fullname, this.phoneNumber, this.passwordValue);
}
