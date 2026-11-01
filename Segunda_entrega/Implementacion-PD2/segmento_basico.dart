import 'interfaces.dart';

/// Implementación compartida de [SegmentosHoja] para no repetir
/// `desplegar()`, `escribir()` y `acomodar()` en cada clase.
mixin SegmentoBasico implements SegmentosHoja {
  /// Nombre del segmento tal como aparece en la hoja.
  String get titulo;

  /// Campos del segmento (nombre del campo -> valor). Vacío por defecto.
  Map<String, Object?> get contenido => const {};

  @override
  void desplegar() {
    if (contenido.isEmpty) {
      print('■ $titulo (vacío)');
      return;
    }
    print('┌─ $titulo');
    contenido.forEach((campo, valor) {
      print('│ $campo: ${_formatear(valor)}');
    });
    print('└─');
  }

  @override
  void escribir() {
    final lleno = contenido.values.where((v) => !_estaVacio(v)).length;
    print('[escribir] $titulo -> $lleno de ${contenido.length} campos con datos');
  }

  @override
  void acomodar() => print('[acomodar] $titulo');
}

bool _estaVacio(Object? v) => v == null || (v is List && v.isEmpty);

String _formatear(Object? v) {
  if (_estaVacio(v)) return '—';
  if (v is DateTime) {
    final d = v.day.toString().padLeft(2, '0');
    final m = v.month.toString().padLeft(2, '0');
    return '$d/$m/${v.year}';
  }
  if (v is double) return v.toStringAsFixed(1);
  return '$v';
}
