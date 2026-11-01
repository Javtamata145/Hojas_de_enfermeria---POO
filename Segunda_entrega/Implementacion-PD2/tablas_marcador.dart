import 'interfaces.dart';
import 'segmento_basico.dart';
import 'tablas_datos.dart';

// --- Implementan TablasMarcador ---

class BradenUPP with SegmentoBasico implements TablasMarcador {
  @override
  String get titulo => 'Braden & UPP';
}

class TablaPosturales with SegmentoBasico implements TablasMarcador {
  @override
  String get titulo => 'Tabla posturales';
}

class MedidasHigienicas with SegmentoBasico implements TablasMarcador {
  @override
  String get titulo => 'Medidas higiénicas';
}

/// Depende de [DatosSignosVitales].
class MatrizSV with SegmentoBasico implements TablasMarcador {
  MatrizSV(this.datosSignosVitales);
  final DatosSignosVitales datosSignosVitales;
  @override
  String get titulo => 'Matriz S.V.';
}

// --- Implementan GraficaTabla ---

/// Depende de [DatosSignosVitales].
class SignosVitales with SegmentoBasico implements GraficaTabla {
  SignosVitales(this.datosSignosVitales);
  final DatosSignosVitales datosSignosVitales;
  @override
  String get titulo => 'Signos vitales';
}

class ControlLiquidos with SegmentoBasico implements GraficaTabla {
  @override
  String get titulo => 'Control de líquidos';
}
