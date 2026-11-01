# Hoja de enfermería – Diagrama de clases

Modelo de clases de la hoja de enfermería. El diagrama está dividido en varios para que se lea bien en GitHub.

**Leyenda**

| Flecha | Significado |
|---|---|
| `..\|>` (punteada, triángulo vacío) | Realización (la clase **implementa** una interfaz) |
| `--\|>` (continua, triángulo vacío) | Herencia (clase → clase o interfaz → interfaz) |
| `..>` (punteada, punta abierta) | Dependencia |
| `*--` (rombo lleno) | Composición |

---

## 1. Jerarquía de interfaces

`SegmentosHoja` hereda de `DesplegableEscribible`, que es la combinación de las interfaces "desplegable" y "escribible" en una sola. Todas las clases del modelo, excepto `PlantillaHoja`, implementan `SegmentosHoja`.

```mermaid
classDiagram
    class DesplegableEscribible {
        <<interface>>
        +desplegar() void
        +escribir() void
    }
    class SegmentosHoja {
        <<interface>>
        +acomodar() void
    }

    SegmentosHoja --|> DesplegableEscribible
```

---

## 2. Tablas de datos (herencia de `RellenoDatos`)

`RellenoDatos` es una clase abstracta que implementa `TablasDatos` y `SegmentosHoja`, y guarda el mapa de datos. Las 14 clases solo heredan de ella.

```mermaid
classDiagram
    class TablasDatos {
        <<interface>>
    }
    class SegmentosHoja {
        <<interface>>
        +acomodar() void
    }
    class RellenoDatos {
        <<abstract>>
        #datos : Map~String, List~dynamic~~
    }

    RellenoDatos ..|> TablasDatos
    RellenoDatos ..|> SegmentosHoja

    Ingresos --|> RellenoDatos
    Egresos --|> RellenoDatos
    Balance --|> RellenoDatos
    DatosSignosVitales --|> RellenoDatos
    NtpNpp --|> RellenoDatos
    Medicamentos --|> RellenoDatos
    Hemocomponentes --|> RellenoDatos
    SolucionesParenterales --|> RellenoDatos
    NotasEnfermeros --|> RellenoDatos
    NotasFinales --|> RellenoDatos
    TiempoFuera --|> RellenoDatos
    Dieta --|> RellenoDatos
    Cuidados --|> RellenoDatos
    EvaGlasgow --|> RellenoDatos
```

---

## 3. Tablas marcador y gráfica de tabla

`ControlLiquidos` implementa únicamente `GraficaTabla` (y `SegmentosHoja`).

```mermaid
classDiagram
    class TablasMarcador {
        <<interface>>
    }
    class GraficaTabla {
        <<interface>>
    }
    class SegmentosHoja {
        <<interface>>
        +acomodar() void
    }

    BradenUPP ..|> TablasMarcador
    TablaPosturales ..|> TablasMarcador
    MedidasHigienicas ..|> TablasMarcador
    MatrizSV ..|> TablasMarcador

    SignosVitales ..|> GraficaTabla
    ControlLiquidos ..|> GraficaTabla

    BradenUPP ..|> SegmentosHoja
    TablaPosturales ..|> SegmentosHoja
    MedidasHigienicas ..|> SegmentosHoja
    MatrizSV ..|> SegmentosHoja
    SignosVitales ..|> SegmentosHoja
    ControlLiquidos ..|> SegmentosHoja
```

---

## 4. Dependencias entre clases

```mermaid
classDiagram
    SignosVitales ..> DatosSignosVitales : depende
    MatrizSV ..> DatosSignosVitales : depende
    Ingresos ..> ControlLiquidos : depende
    Egresos ..> ControlLiquidos : depende
    Balance ..> Ingresos : depende
    Balance ..> Egresos : depende
```

---

## 5. Plantilla, paciente y dibujo humano

```mermaid
classDiagram
    class SegmentosHoja {
        <<interface>>
        +acomodar() void
    }
    class PlantillaHoja {
        -archivoTxt : String
        -segmentos : List~SegmentosHoja~
        +cargarDesdeTxt() void
        +construirSegmentos() void
    }
    class DatosPaciente {
        -nombre : String
        -fechaNacimiento : DateTime
        -numPaciente : String
        -diagnosticoMedico : String
        -peso : double
        -talla : double
        -perimetroCefalico : double
        -perimetroAbdominal : double
        -grupo : String
        -rh : String
        -noCama : String
        -servicio : String
        -genero : String
        -fecha : DateTime
        -alergias : String
        +calcularEdad() int
        +calcularIMC() double
        +calcularDiasEstancia() int
    }
    class DibujoHumano {
        <<interface>>
    }
    class DanoTisular

    PlantillaHoja "1" *-- "*" SegmentosHoja : segmentos
    DatosPaciente ..|> SegmentosHoja
    DanoTisular ..|> SegmentosHoja
    DibujoHumano ..> DanoTisular : depende
```

---

## Notas y supuestos

- `PlantillaHoja` es una **clase** (no interfaz) porque tiene atributos: el archivo `.txt` y el vector de `SegmentosHoja`.
- `Edad`, `IMC` y `días de estancia` van como **métodos** porque se calculan a partir de fecha de nacimiento, peso/talla y fecha de ingreso.
- `DanoTisular` se asumió como segmento de hoja (implementa `SegmentosHoja`).
- `Dieta`, `Cuidados` y `EvaGlasgow` se asignaron a `TablasDatos`.
- Las interfaces `TablasDatos`, `TablasMarcador`, `GraficaTabla` y `DibujoHumano` todavía no tienen métodos propios.
- Nombres tomados de la captura de Visual Paradigm: `TablasMarcador` ("Tablas rellenar") y `GraficaTabla` ("Tabla").
- En Dart, `vector` se representa con `List`.
