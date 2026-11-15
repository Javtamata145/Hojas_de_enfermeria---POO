# Evaluación de las clases en MVC (Modelo Multiservicios)

Evaluación del modelo ampliado de la hoja de enfermería para Hospitalización, UCIN, UCIP, UCIA, Pre/Postoperatorio y Cirugía, estructurado bajo el patrón **Modelo – Vista – Controlador**.

* **Modelo:** Datos clínicos, cálculos, reglas de negocio y jerarquías especializadas por área hospitalaria.

* **Vista:** Formato de presentación, interfaces de renderizado (`TablasDatos`, `TablasMarcador`, `GraficaTabla`, `DibujoHumano`) y distribución espacial.

* **Controlador:** Coordinación general a través de `PlantillaHoja` (actuando como factoría o ensamblador dinámico) y sub-controladores modulares (`Segmento...`).

En este sistema, la salida del controlador y la vista se orienta a la generación estructurada de documentos listos para impresión (PDF/JSON) que se integran al expediente clínico físico.

## Veredicto

El diseño arquitectónico escala exitosamente mediante una combinación de **Patrón Composite**, **Herencia Polimórfica** y **MVC Distribuido**. El **modelo** se encuentra completamente desglosado mediante clases especializadas para cada servicio (evitando sobrecargar el núcleo con campos vacíos). El **controlador** implementa un ensamblaje dinámico que selecciona los segmentos requeridos según el área seleccionada (Piso, UCIN, UCIP, UCIA o Quirófano), y la **vista** se mantiene desacoplada a través de interfaces de marcado y graficación.

| Capa | Estado | Comentario | 
| ----- | ----- | ----- | 
| Modelo | Robusto y Polimórfico | Estructura modular con jerarquía en pacientes y modelos específicos para áreas críticas y quirúrgicas. | 
| Vista | Desacoplada | Interfaces claras que dictan el formato visual sin mezclar lógica de negocio. | 
| Controlador | Dinámico y Distribuido | `PlantillaHoja` opera como factoría de ensamblaje apoyada por sub-controladores especializados. | 

## Clasificación de las clases

### Modelo (Datos y Reglas de Negocio)

| Clase | Qué contiene | Capa | Observación | 
| ----- | ----- | ----- | ----- | 
| `DatosPacienteBase` | Atributos universales (Nombre, expediente, fecha de nacimiento, diagnóstico, cama, servicio, género, alergias). | **Modelo (Abstracta)** | Clase base polimórfica. | 
| `DatosPacienteAdulto` | Peso, talla, perímetros, grupo, RH, cálculos de IMC y días de estancia. | **Modelo** | Hereda de `DatosPacienteBase`. | 
| `DatosPacienteNeonatal` | Semanas de gestación, peso al nacer/actual, perímetros, Apgar y nombre de la madre. | **Modelo** | Hereda de `DatosPacienteBase`. | 
| `DatosPacientePediatrico` | Peso, talla, perímetros, superficie corporal, datos del tutor y parentesco. | **Modelo** | Hereda de `DatosPacienteBase`. | 
| `RellenoDatos` | El `Map<String, List<dynamic>>` para almacenamiento general de tablas. | **Modelo** | Clase abstracta base para tablas de datos. | 
| `VolumenIngresado` / `VolumenEgresado` / `VolumenPorTurno` | Registros detallados de ingresos, egresos y desgloses por turno. | **Modelo** | Soporta control de líquidos estándar y estricto. | 
| `DatosSignosVitales` | Valores base de signos vitales. | **Modelo** | Fuente de datos para matrices y gráficas. | 
| `HistorialFarmacologico` y asociadas (`PrescripcionMedicamento`, `NutricionParenteral`, `TransfusionSanguinea`, `SolucionParenteral`) | Fármacos, nutrición, hemoderivados y soluciones con control de infusiones y faltantes (`FXP`). | **Modelo** | Compartido en todos los servicios. | 
| `RegistroAccesos`, `AccesoVenoso`, `DispositivoInvasivo` | Catéteres venosos, arteriales, sondas y drenajes con control de días y observaciones. | **Modelo** | Soporta accesos periféricos, centrales y umbilicales. | 
| `TerapiaRespiratoria` | Oxigenoterapia, mascarillas, CPAP y ventilación mecánica. | **Modelo** | Base para soporte respiratorio. | 
| `RegistroDietetico` | Tipo de dieta o nutrición enteral por horarios. | **Modelo** | Adaptable a piso, pediatría y terapia. | 
| `PlanCuidadosEnfermeria` | Diagnósticos NANDA, NIC, NOC, educación y plan de alta. | **Modelo** | Cuidados generales de enfermería. | 
| `AmbienteTermico` | Incubadora, cuna térmica, temperaturas programadas y humedad (UCIN). | **Modelo** | Exclusivo de neonatología. | 
| `MonitoreoHemodinamicoInvasivo` | PVC, PAM invasiva, PIC, etCO2 y gasometrías (UCIP/UCIA). | **Modelo** | Exclusivo de terapias intensivas. | 
| `ParametrosVentilacionMecanica` | Modos ventilatorios, volumen tidal, PEEP y presiones. | **Modelo** | Exclusivo de soporte ventilatorio avanzado. | 
| `RegistroQuirurgico` | Tiempos anestésicos, cirugía programada/realizada y sangrado. | **Modelo** | Compartido en pre, post y transoperatorio. | 
| `ControlHeridaQuirurgica` | Ubicación, estado de apósitos y características de drenajes. | **Modelo** | Seguimiento postquirúrgico inmediato. | 
| `ControlMaterialEInstrumental` | Conteo de gasas, compresas e instrumental quirúrgico. | **Modelo** | Seguridad transoperatoria obligatoria. | 
| `EquipoQuirurgicoYPosicion` | Personal participante y posición del paciente en sala. | **Modelo** | Trazabilidad legal y de seguridad. | 
| `MuestrasYBiopsias` | Registro de especímenes enviados a patología o cultivo. | **Modelo** | Control de piezas quirúrgicas. | 

### Clases que combinan Modelo y Vista (Tablas Marcador y Gráficas)

| Clase | Parte de Modelo | Parte de Vista | 
| ----- | ----- | ----- | 
| `SignosVitales` / `BalanceHidrico` | Almacenan valores numéricos e históricos. | Implementan `GraficaTabla` (renderizado visual esquemático). | 
| `MatrizSV` | Valores tabulares de signos vitales. | Implementan `TablasMarcador`. | 
| `ValoracionUPP` / `PrevencionUPP` / `PrevencionCaidas` / `ManejoPresion` / `CambioPostural` / `ControlHigiene` / `ControlEvacuacion` / `ManejoOstomia` / `CuidadoTisular` | Datos de escalas, checklists y registros de turnos (`TM`, `TV`, `TN`). | Implementan `TablasMarcador`. | 
| `ValoracionNeonatal` / `ValoracionPediatrica` / `ValoracionNeurologicaYSedacion` | Puntajes de escalas especializadas (Silverman, Capurro, Glasgow pediátrico/adulto, RASS, EVA). | Implementan `TablasMarcador`. | 
| `PreparacionPreoperatoria` / `ValoracionPostanestesica` / `ListaVerificacionCirugiaSegura` | Verificaciones de ayuno, seguridad OMS (Time Out) y escalas de alta (Aldrete, Bromage). | Implementan `TablasMarcador`. | 

### Vista

| Interfaz / Elemento | Qué define | Capa | 
| ----- | ----- | ----- | 
| `DesplegableEscribible` | Define contratos para `desplegar()` y `escribir()`. | `desplegar()` es visual; `escribir()` interactúa con el modelo. | 
| `SegmentosHoja` | Define el método `acomodar()`. | **Vista**: distribución espacial y orden de los bloques en el formato impreso. | 
| `TablasDatos` | Interfaz marcador para contenedores de texto y números detallados. | **Vista**: formato tabular estándar. | 
| `TablasMarcador` | Interfaz marcador para listas de verificación y escalas. | **Vista**. | 
| `GraficaTabla` | Interfaz para componentes que requieren representación gráfica o de líneas. | **Vista**. | 
| `DibujoHumano` | Interfaz para el mapeo anatómico de lesiones. | **Vista**. Depende funcionalmente de `EvaluacionTisular`. | 

### Controlador

| Clase | Qué contiene | Capa | 
| ----- | ----- | ----- | 
| `PlantillaHoja` | Atributos (`archivoTxt`, lista polimórfica de `SegmentosHoja`) y métodos de carga y construcción dinámica. | **Controlador Principal / Factoría**. Ensambla de forma dinámica los segmentos específicos según el servicio médico seleccionado. | 
| `Segmento...` (Sub-controladores) | Clases de agrupamiento modular (`SegmentoAccesosYDispositivos`, `SegmentoTerapiaYPiel`, `SegmentoBalanceHidrico`, `SegmentoMonitoreoIntensivo`, `SegmentoPerioperatorio`, `SegmentoTransoperatorio`, etc.). | **Sub-controladores**. Gestionan la validación y preparación de sus modelos hijos antes de renderizar la hoja clínica. | 
