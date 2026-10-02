import 'package:flutter/foundation.dart';

/// Estado de carga/error compartido por los providers que consultan un
/// repositorio.
///
/// Centraliza `isLoading`/`hasLoaded`/`error` y captura las excepciones para
/// que un fallo de red no se propague como un error async sin capturar ni deje
/// la pantalla mostrando datos mock en silencio.
mixin LoadableProvider on ChangeNotifier {
  bool _isLoading = false;
  bool _hasLoaded = false;
  Object? _error;
  Object? _writeError;

  bool get isLoading => _isLoading;
  bool get hasLoaded => _hasLoaded;
  bool get hasError => _error != null;
  String? get error => _error?.toString();

  /// Error de la ultima escritura (guardado) fallida, si lo hubiera.
  bool get hasWriteError => _writeError != null;
  String? get writeError => _writeError?.toString();

  /// Ejecuta [body] marcando el estado de carga y capturando cualquier error.
  ///
  /// Devuelve `true` si [body] termino sin excepciones. Cuando [markLoaded] es
  /// `true` (por defecto), un exito deja `hasLoaded` en `true`.
  @protected
  Future<bool> runLoad(
    Future<void> Function() body, {
    bool markLoaded = true,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await body();
      if (markLoaded) _hasLoaded = true;
      return true;
    } catch (error) {
      _error = error;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Registra (o limpia) el ultimo error y notifica a los listeners.
  @protected
  void setError(Object? error) {
    _error = error;
    notifyListeners();
  }

  /// Registra (o limpia) el ultimo error de escritura.
  @protected
  void setWriteError(Object? error) {
    _writeError = error;
    notifyListeners();
  }

  /// Limpia el ultimo error, si lo hubiera.
  @protected
  void clearError() {
    if (_error == null) return;
    _error = null;
    notifyListeners();
  }
}
