import 'interfaces.dart';
import 'segmento_basico.dart';
import 'tablas_marcador.dart';

/// Base de todas las tablas de datos. Implementa [TablasDatos] y, por el
/// mixin, también [SegmentosHoja].
abstract class RellenoDatos with SegmentoBasico implements TablasDatos {
  /// Datos de la tabla: nombre del campo -> lista de valores.
  final Map<String, List<dynamic>> datos = {};

  @override
  Map<String, Object?> get contenido => datos;

  void agregar(String campo, dynamic valor) =>
      datos.putIfAbsent(campo, () => []).add(valor);

  /// Suma de todos los valores numéricos de la tabla.
  double total() => datos.values
      .expand((valores) => valores)
      .whereType<num>()
      .fold(0.0, (suma, n) => suma + n);
}

class Ingresos extends RellenoDatos {
  Ingresos(this.controlLiquidos);
  final ControlLiquidos controlLiquidos;
  @override
  String get titulo => 'Ingresos';
}

class Egresos extends RellenoDatos {
  Egresos(this.controlLiquidos);
  final ControlLiquidos controlLiquidos;
  @override
  String get titulo => 'Egresos';
}

class Balance extends RellenoDatos {
  Balance(this.ingresos, this.egresos);
  final Ingresos ingresos;
  final Egresos egresos;

  double calcular() => ingresos.total() - egresos.total();

  @override
  String get titulo => 'Balance';
}

class DatosSignosVitales extends RellenoDatos {
  @override
  String get titulo => 'Datos signos vitales';
}

class NtpNpp extends RellenoDatos {
  @override
  String get titulo => 'NTP/NPP';
}

class Medicamentos extends RellenoDatos {
  @override
  String get titulo => 'Medicamentos';
}

class Hemocomponentes extends RellenoDatos {
  @override
  String get titulo => 'Hemocomponentes';
}

class SolucionesParenterales extends RellenoDatos {
  @override
  String get titulo => 'Soluciones parenterales';
}

class NotasEnfermeros extends RellenoDatos {
  @override
  String get titulo => 'Notas enfermeros';
}

class NotasFinales extends RellenoDatos {
  @override
  String get titulo => 'Notas finales';
}

class TiempoFuera extends RellenoDatos {
  @override
  String get titulo => 'Tiempo fuera';
}

class Dieta extends RellenoDatos {
  @override
  String get titulo => 'Dieta';
}

class Cuidados extends RellenoDatos {
  @override
  String get titulo => 'Cuidados';
}

class EvaGlasgow extends RellenoDatos {
  @override
  String get titulo => 'EVA & Glasgow';
}
