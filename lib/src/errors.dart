import 'dart:developer';

import 'package:stack_trace/stack_trace.dart';

enum ErrorType { network, api, local }

class ErrorRequest {
  final String? baseUrl, path;
  ErrorRequest({this.baseUrl, this.path});
}

class Errors {
  final String errorMessage;
  final ErrorType errorType;

  Errors({required this.errorMessage, this.errorType = ErrorType.local});

  static Future<Errors> check(e, StackTrace s, {ErrorRequest? request}) async {
    // NETWORK ERROR
    List<String> networkFail = ['SocketException', 'Failed host lookup', 'NetworkException'];

    if (networkFail.any((n) => e.toString().contains(n))) {
      log('-- No internet connection!', name: 'LOG');

      return Errors(
        errorMessage: 'No internet connection!',
        errorType: ErrorType.network,
      );
    }

    // STACK TRACE
    List frames = Trace.current().frames, terseFrames = Trace.from(s).terse.frames;

    if (frames.isEmpty) {
      log('-- No frames in stack trace!', name: 'LOG');

      return Errors(
        errorMessage: 'No frames in stack trace!',
        errorType: ErrorType.local,
      );
    }

    if (request?.path == null) {
      Frame frame = frames[frames.length > 1 ? 1 : 0];
      Frame trace = terseFrames[terseFrames.length > 1 ? 1 : 0];

      String errorLocation = frame.member ?? '?', errorLine = '${trace.line}';
      String errorMessage = 'Error on $errorLocation (Line $errorLine), $e';

      log('-- $errorMessage', name: 'LOG');
      log('\n-- Please check the errors below:', name: 'LOG');

      terseFrames.take(3).toList().asMap().forEach((i, f) {
        log('${i + 1}. $f', name: 'LOG');
      });

      return Errors(
        errorMessage: errorMessage,
        errorType: ErrorType.local,
      );
    } else {
      // get error info
      String errorMessage = '$e'.replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), '').replaceAll('&nbsp;', '');
      String errorMessageFirstLine = errorMessage.split('\n')[0]; // get first line of error message

      return Errors(
        errorMessage: errorMessageFirstLine,
        errorType: ErrorType.api,
      );
    }
  }
}
