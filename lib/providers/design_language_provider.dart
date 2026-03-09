import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DesignLanguage { material, cupertino }

class DesignLanguageNotifier extends Notifier<DesignLanguage> {
  @override
  DesignLanguage build() => DesignLanguage.material;

  void setLanguage(DesignLanguage lang) {
    state = lang;
  }
}

final designLanguageProvider =
    NotifierProvider<DesignLanguageNotifier, DesignLanguage>(
      DesignLanguageNotifier.new,
    );
