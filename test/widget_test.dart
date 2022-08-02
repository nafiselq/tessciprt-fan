import 'package:email_validator/email_validator.dart';

void main() {
  var email = "fredrik@gmail.com";

  assert(EmailValidator.validate(email));
}
