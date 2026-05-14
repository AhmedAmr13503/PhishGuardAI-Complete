abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message =
        'We could not complete this request on our servers. Please try again.',
  ]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message =
        'No internet connection. Check your network and try again.',
  ]);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([
    super.message =
        'The request took too long. Please try again in a moment.',
  ]);
}

class ValidationFailure extends Failure {
  const ValidationFailure([
    super.message = 'Please check your input and try again.',
  ]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([
    super.message = 'Something went wrong. Please try again.',
  ]);
}
