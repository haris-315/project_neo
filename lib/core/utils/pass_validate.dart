bool isStrongPassword(String password) {
  final regex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$'
  );
  return regex.hasMatch(password);
}
