import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class LocaleManager {
  static final LocaleManager _instance = LocaleManager._internal();
  factory LocaleManager() => _instance;

  LocaleManager._internal() {
    if (kIsWeb) {
      try {
        html.window.addEventListener('message', (html.Event event) {
          if (event is html.MessageEvent) {
            final data = event.data;
            if (data is Map && data['type'] == 'setLocale') {
              final locale = data['locale'];
              if (locale == 'en' || locale == 'ja') {
                _setLanguageInternal(locale);
              }
            }
          }
        });
      } catch (e) {
        debugPrint('Failed to add window message listener: $e');
      }
    }
  }

  final ValueNotifier<String> languageNotifier = ValueNotifier('en');

  String get language => languageNotifier.value;

  void _setLanguageInternal(String lang) {
    if (languageNotifier.value != lang) {
      languageNotifier.value = lang;
    }
  }

  void setLanguage(String lang) {
    if (languageNotifier.value != lang) {
      languageNotifier.value = lang;
      if (kIsWeb) {
        try {
          html.window.parent?.postMessage({
            'type': 'syncLocale',
            'locale': lang,
          }, '*');
        } catch (e) {
          debugPrint('Failed to post message to parent: $e');
        }
      }
    }
  }

  bool get isJapanese => language == 'ja';
}

final localeManager = LocaleManager();

/// Inline translation helper
String tr(String enVal, String jaVal) {
  return localeManager.isJapanese ? jaVal : enVal;
}
