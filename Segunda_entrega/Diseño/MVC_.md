# Evaluación de las clases en MVC

Evaluación del modelo de la hoja de enfermería (diagrama de clases y código en Dart) según el patrón **Modelo – Vista – Controlador**.

- **Modelo:** datos y reglas de negocio (qué es el dato y cómo se calcula).
- **Vista:** cómo se presenta el dato (desplegar, acomodar, graficar).
- **Controlador:** coordina: recibe las acciones, actualiza el modelo y elige la vista.

En un backend en Dart, la "vista" no tiene que ser una pantalla: puede ser la salida en consola, un JSON o un PDF.

---

## Veredicto

El diseño actual se parece más a un patrón **Composite** (`PlantillaHoja` contiene muchos `SegmentosHoja`) que a un MVC estricto. El **modelo** está bien definido y el **controlador** existe, pero está concentrado en `PlantillaHoja`. La **vista** no tiene clases propias: está mezclada dentro de los modelos mediante `desplegar()` y `acomodar()`.

| Capa | Estado | Comentario |
|---|---|---|
| Modelo | Bien | Datos, cálculos y dependencias están en las clases correctas. |
| Vista | Mezclada | Cada segmento sabe desplegarse y acomodarse a sí mismo. |
| Controlador | Parcial | `PlantillaHoja` hace de modelo y de controlador a la vez. |

---

## Clasificación de las clases

### Modelo

| Clase | Qué contiene | Capa | Qué parte sobra o es de otra capa |
|---|---|---|---|
| `DatosPaciente` | Nombre, fecha de nacimiento, no. paciente, diagnóstico médico, peso, talla, perímetro cefálico, perímetro abdominal, grupo, RH, no. cama, servicio, género, fecha, alergias. Calcula edad, IMC y días de estancia. | **Modelo** | Al implementar `SegmentosHoja` hereda `desplegar()`, `escribir()` y `acomodar()`, que no son de modelo. |
| `RellenoDatos` | El `Map<String, vector>` donde se guardan los datos de las tablas. Es la base de las 14 tablas de datos. | **Modelo** | Implementa `TablasDatos` y `SegmentosHoja`, que arrastran métodos de vista. |
| `Ingresos` | Registro de los líquidos que entran al paciente. Depende de `ControlLiquidos`. | **Modelo** | Solo guarda datos; su despliegue es de vista. |
| `Egresos` | Registro de los líquidos que salen del paciente. Depende de `ControlLiquidos`. | **Modelo** | Igual que `Ingresos`. |
| `Balance` | Calcula la diferencia entre ingresos y egresos. Depende de `Ingresos` y `Egresos`. | **Modelo** | Es lógica de negocio pura, está bien ubicada. |
| `DatosSignosVitales` | Registro de los signos vitales. Es la fuente de datos de `SignosVitales` y `MatrizSV`. | **Modelo** | Ninguna. |
| `NtpNpp` | Registro de NTP/NPP. | **Modelo** | Solo su despliegue es de vista. |
| `Medicamentos` | Registro de medicamentos. | **Modelo** | Igual. |
| `Hemocomponentes` | Registro de hemocomponentes. | **Modelo** | Igual. |
| `SolucionesParenterales` | Registro de soluciones parenterales. | **Modelo** | Igual. |
| `NotasEnfermeros` | Texto de las notas de enfermería. | **Modelo** | Igual. |
| `NotasFinales` | Texto de las notas finales. | **Modelo** | Igual. |
| `TiempoFuera` | Registro del tiempo fuera. | **Modelo** | Igual. |
| `Dieta` | Registro de la dieta del paciente. | **Modelo** | Igual. |
| `Cuidados` | Registro de los cuidados. | **Modelo** | Igual. |
| `EvaGlasgow` | Registro de las escalas EVA y Glasgow. | **Modelo** | Igual. |
| `DanoTisular` | Datos del daño tisular del paciente. | **Modelo** | Los datos son de modelo; el dibujo sobre el cuerpo es de vista. |

### Clases que combinan modelo y vista

| Clase | Parte de modelo | Parte de vista |
|---|---|---|
| `SignosVitales` | Guarda los valores que se grafican. Depende de `DatosSignosVitales`. | Implementa `GraficaTabla`: se muestra como gráfica. |
| `ControlLiquidos` | Concentra los valores de líquidos. Es la clase de la que dependen `Ingresos` y `Egresos`. | Implementa `GraficaTabla`: se muestra como gráfica. |
| `MatrizSV` | Valores de la matriz de signos vitales. Depende de `DatosSignosVitales`. | Implementa `TablasMarcador`: se muestra como tabla de marcado. |
| `BradenUPP` | Valores marcados de la escala Braden y UPP. | Implementa `TablasMarcador`. |
| `TablaPosturales` | Posturas registradas. | Implementa `TablasMarcador`. |
| `MedidasHigienicas` | Medidas higiénicas registradas. | Implementa `TablasMarcador`. |

### Vista

| Interfaz | Qué define | Capa |
|---|---|---|
| `DesplegableEscribible` | `desplegar()` y `escribir()`. | `desplegar()` es de **vista**; `escribir()` es una acción del **controlador** que termina guardando en el modelo. |
| `SegmentosHoja` | `acomodar()`, además de lo heredado. | **Vista**: decide la posición del segmento en la hoja. Mezcla capas porque hereda `escribir()`. |
| `TablasDatos` | Marca que el segmento es una tabla de datos para rellenar. | **Vista**: describe el tipo de presentación. |
| `TablasMarcador` | Marca que el segmento es una tabla de marcado. | **Vista**. |
| `GraficaTabla` | Marca que el segmento se muestra como gráfica. | **Vista**. |
| `DibujoHumano` | Marca el dibujo del cuerpo humano. | **Vista**. Depende de `DanoTisular`, que le da los datos. |

### Controlador

| Clase | Qué contiene | Capa |
|---|---|---|
| `PlantillaHoja` | Atributos: el archivo `.txt` y el vector de referencias a `SegmentosHoja`. Métodos: leer el `.txt` y crear los objetos de la hoja. | **Mixta**. Los atributos son de **modelo** (estructura de la hoja); leer el archivo y crear los objetos es de **controlador**. Es la clase con más responsabilidades. |
