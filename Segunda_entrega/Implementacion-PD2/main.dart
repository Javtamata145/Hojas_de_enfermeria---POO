import 'package:hoja_enfermeria/hoja_enfermeria.dart';

void main() {
  // 1. Crear la plantilla a partir del .txt.
  final plantilla = PlantillaHoja('datos/plantilla.txt')
    ..cargarDesdeTxt()
    ..construirSegmentos();

  print('Segmentos en la plantilla: ${plantilla.segmentos.length}\n');

  // 2. Rellenar solo los datos del paciente (datos ficticios).
  plantilla.segmento<DatosPaciente>()
    ..nombre = 'Paciente de Ejemplo'
    ..fechaNacimiento = DateTime(1980, 5, 14)
    ..numPaciente = 'P-0001'
    ..diagnosticoMedico = 'Diagnóstico de ejemplo'
    ..peso = 68.5
    ..talla = 165
    ..perimetroCefalico = 55
    ..perimetroAbdominal = 90
    ..grupo = 'O'
    ..rh = '+'
    ..noCama = '12'
    ..servicio = 'Medicina interna'
    ..genero = 'Femenino'
    ..fecha = DateTime.now().subtract(const Duration(days: 3))
    ..alergias = 'Ninguna conocida';

  // 3. Desplegar la hoja: solo "Datos del paciente" lleva información.
  plantilla.desplegarHoja();

  // 4. Escribir únicamente el segmento del paciente.
  print('');
  plantilla.segmento<DatosPaciente>().escribir();
}
