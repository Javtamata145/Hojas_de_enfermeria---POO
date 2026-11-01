/// Combina "desplegable" y "escribible" en una sola interfaz.
abstract interface class DesplegableEscribible {
  /// Muestra el segmento.
  void desplegar();

  /// Escribe el contenido del segmento en la hoja.
  void escribir();
}

/// Todo lo que va dentro de la hoja (excepto la plantilla) es un segmento.
abstract interface class SegmentosHoja implements DesplegableEscribible {
  /// Acomoda el segmento dentro de la hoja.
  void acomodar();
}

/// Segmentos que son tablas de datos para rellenar.
abstract interface class TablasDatos {}

/// Segmentos que son tablas de marcado.
abstract interface class TablasMarcador {}

/// Segmentos que se muestran como gráfica de tabla.
abstract interface class GraficaTabla {}

/// Dibujo del cuerpo humano (todavía sin clases que lo implementen).
abstract interface class DibujoHumano {}
