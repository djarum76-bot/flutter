import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:nonolep/utils/helpers/logger_util.dart';

class Logger {
  static void info(
      String message, {
        String? header,
        String? name,
        String? tag = 'INFO',
      }) {
    if (kDebugMode) {
      if (header != null) {
        log(
          List.filled(header.length + 6, '\x1B[36m=').join(),
          name: name ?? '💡',
        );
        log(
          '\x1B[36m|| $header ||',
          name: name ?? '💡',
        );
        log(
          List.filled(header.length + 6, '\x1B[36m=').join(),
          name: name ?? '💡',
        );
      }

      if (message.isNotEmpty && header == null) {
        log(
          '\x1B[36m${tag != null && tag.isNotEmpty ? '$tag | ' : ''}$message\x1B[0m',
          name: name ?? '💡',
        );
      }
    }
  }

  static void succes(
      Object message, {
        String? header,
        String? name,
        String? tag = 'SUCCESS',
      }) {
    if (kDebugMode) {
      if (header != null) {
        log(
          List.filled(header.length + 6, '\x1B[32m=').join(),
          name: name ?? '✅',
        );
        log(
          '\x1B[32m|| $header ||',
          name: name ?? '✅',
        );
        log(
          List.filled(header.length + 6, '\x1B[32m=').join(),
          name: name ?? '✅',
        );
      }

      if (message is String && message.isNotEmpty && header == null) {
        log(
          '\x1B[32m${tag != null && tag.isNotEmpty ? '$tag | ' : ''}$message\x1B[0m',
          name: name ?? '✅',
        );
      }

      if (message is Map && header == null) {
        log(
          '\x1B[32m${tag != null && tag.isNotEmpty ? '$tag | ' : ''}${LoggerUtil.jsonFormat(message)}\x1B[0m',
          name: name ?? '✅',
        );
      }
    }
  }

  static void error({
    String? header,
    String? name,
    String? tag = 'ERROR',
    StackTrace? stackTrace,
    Object? error,
  }) {
    if (kDebugMode) {
      if (header != null) {
        log(
          List.filled(header.length + 6, '\x1B[31m=').join(),
          name: name ?? '❌',
        );
        log(
          '\x1B[31m|| $header ||',
          name: name ?? '❌',
        );
        log(
          List.filled(header.length + 6, '\x1B[31m=').join(),
          name: name ?? '❌',
        );
      }

      if (error != null) {
        log(
          '',
          name: name ?? '❌',
          error: '${tag != null && tag.isNotEmpty ? '$tag | ' : ''}$error',
        );
      }
    }
  }
}