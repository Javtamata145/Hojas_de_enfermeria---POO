import 'dart:io';

import 'dano_tisular.dart';
import 'datos_paciente.dart';
import 'interfaces.dart';
import 'tablas_datos.dart';
import 'tablas_marcador.dart';

/// Plantilla de la hoja: lee un `.txt` con los nombres de los segmentos y
/// construye un objeto por cada uno.
class PlantillaHoja {
  PlantillaHoja(this.archivoTxt);

  final String archivoTxt;
  final List<SegmentosHoja> segmentos = [];

  final List<String> _nombres = [];
  final Map<String, SegmentosHoja> _instancias = {};

  /// Lee los nombres de segmento del archivo (ignora vacías y `#`).
  void cargarDesdeTxt() {
    _nombres
      ..clear()
      ..addAll(File(archivoTxt)
          .readAsLinesSync()
          .map((linea) => linea.trim())
          .where((linea) => linea.isNotEmpty && !linea.startsWith('#')));
  }

  /// Crea los segmentos listados, respetando las dependencias entre ellos.
  void construirSegmentos() {
    segmentos.clear();
    _instancias.clear();
    for (final nombre in _nombres) {
      final segmento = _obtener(nombre);
      if (!segmentos.contains(segmento)) segmentos.add(segmento);
    }
  }

  /// Devuelve el primer segmento del tipo [T] (por ejemplo `DatosPaciente`).
  T segmento<T extends SegmentosHoja>() => segmentos.whereType<T>().first;

  void desplegarHoja() {
    for (final s in segmentos) {
      s.acomodar();
      s.desplegar();
    }
  }

  SegmentosHoja _obtener(String nombre) {
    final existente = _instancias[nombre];
    if (existente != null) return existente;

    final fabrica = _fabricas[nombre];
    if (fabrica == null) {
      throw ArgumentError('Segmento desconocido en la plantilla: "$nombre"');
    }
    final nuevo = fabrica(this);
    _instancias[nombre] = nuevo;
    return nuevo;
  }

  static final Map<String, SegmentosHoja Function(PlantillaHoja)> _fabricas = {
    'DatosPaciente': (_) => DatosPaciente(),
    'DanoTisular': (_) => DanoTisular(),
    // Tablas de datos
    'DatosSignosVitales': (_) => DatosSignosVitales(),
    'Ingresos': (p) => Ingresos(p._obtener('ControlLiquidos') as ControlLiquidos),
    'Egresos': (p) => Egresos(p._obtener('ControlLiquidos') as ControlLiquidos),
    'Balance': (p) => Balance(
          p._obtener('Ingresos') as Ingresos,
          p._obtener('Egresos') as Egresos,
        ),
    'NtpNpp': (_) => NtpNpp(),
    'Medicamentos': (_) => Medicamentos(),
    'Hemocomponentes': (_) => Hemocomponentes(),
    'SolucionesParenterales': (_) => SolucionesParenterales(),
    'NotasEnfermeros': (_) => NotasEnfermeros(),
    'NotasFinales': (_) => NotasFinales(),
    'TiempoFuera': (_) => TiempoFuera(),
    'Dieta': (_) => Dieta(),
    'Cuidados': (_) => Cuidados(),
    'EvaGlasgow': (_) => EvaGlasgow(),
    // Tablas marcador
    'BradenUPP': (_) => BradenUPP(),
    'TablaPosturales': (_) => TablaPosturales(),
    'MedidasHigienicas': (_) => MedidasHigienicas(),
    'MatrizSV': (p) =>
        MatrizSV(p._obtener('DatosSignosVitales') as DatosSignosVitales),
    // Gráfica de tabla
    'SignosVitales': (p) =>
        SignosVitales(p._obtener('DatosSignosVitales') as DatosSignosVitales),
    'ControlLiquidos': (_) => ControlLiquidos(),
  };
}
