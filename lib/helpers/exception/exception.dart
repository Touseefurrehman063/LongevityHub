class SignUpwithEmailandPasswordFailure {
  final String message;
  const SignUpwithEmailandPasswordFailure([this.message = "An unknown Error"]);

  factory SignUpwithEmailandPasswordFailure.code(String code) {
    switch (code) {
      case "weak-password":
        return const SignUpwithEmailandPasswordFailure(
            "Please Enter a Strong Password");
      case "Invalid-email":
        return const SignUpwithEmailandPasswordFailure(
            "Email is not valid or badly formated");
      case "email-already-in-use":
        return const SignUpwithEmailandPasswordFailure(
            "An Account is Already exist for following Email");
      case "operation-not-allowed":
        return const SignUpwithEmailandPasswordFailure(
            "Opperation is not allowed, Please Contact Support");
      case "user-disabled":
        return const SignUpwithEmailandPasswordFailure(
            "This user has been disabled, please Contact Support");

      default:
        return const SignUpwithEmailandPasswordFailure();
    }
  }
}
