import 'segmento_basico.dart';

/// Datos del paciente. Los campos son públicos (convención de Dart); en el
/// diagrama UML aparecen como privados.
class DatosPaciente with SegmentoBasico {
  String? nombre;
  DateTime? fechaNacimiento;
  String? numPaciente;
  String? diagnosticoMedico;

  /// Peso en kilogramos.
  double? peso;

  /// Talla en centímetros.
  double? talla;
  double? perimetroCefalico;
  double? perimetroAbdominal;
  String? grupo;
  String? rh;
  String? noCama;
  String? servicio;
  String? genero;

  /// Fecha de ingreso.
  DateTime? fecha;
  String? alergias;

  int? calcularEdad({DateTime? hoy}) {
    final nacimiento = fechaNacimiento;
    if (nacimiento == null) return null;
    final ref = hoy ?? DateTime.now();
    var edad = ref.year - nacimiento.year;
    if (ref.month < nacimiento.month ||
        (ref.month == nacimiento.month && ref.day < nacimiento.day)) {
      edad--;
    }
    return edad;
  }

  double? calcularIMC() {
    final p = peso;
    final t = talla;
    if (p == null || t == null || t == 0) return null;
    final metros = t / 100;
    return p / (metros * metros);
  }

  int? calcularDiasEstancia({DateTime? hoy}) {
    final ingreso = fecha;
    if (ingreso == null) return null;
    final ref = hoy ?? DateTime.now();
    return DateTime(ref.year, ref.month, ref.day)
        .difference(DateTime(ingreso.year, ingreso.month, ingreso.day))
        .inDays;
  }

  @override
  String get titulo => 'Datos del paciente';

  @override
  Map<String, Object?> get contenido => {
        'Nombre': nombre,
        'Fecha de nacimiento': fechaNacimiento,
        'Edad': calcularEdad(),
        'No. paciente': numPaciente,
        'Diagnóstico médico': diagnosticoMedico,
        'Peso (kg)': peso,
        'Talla (cm)': talla,
        'IMC': calcularIMC(),
        'Perímetro cefálico': perimetroCefalico,
        'Perímetro abdominal': perimetroAbdominal,
        'Grupo': grupo,
        'RH': rh,
        'No. cama': noCama,
        'Servicio': servicio,
        'Género': genero,
        'Fecha de ingreso': fecha,
        'Días de estancia': calcularDiasEstancia(),
        'Alergias': alergias,
      };
}
