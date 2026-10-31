# Casos de Uso

### UC-01: Gestionar Pestañas y Plantillas de Pacientes
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-01: Gestionar Pestañas y Plantillas de Pacientes |
| **Actores** | Enfermero. |
| **Precondiciones** | La aplicación está desbloqueada y en la pantalla principal. |
| **Flujo Básico** | 1. El Enfermero selecciona la opción para agregar un nuevo paciente.<br>2. El sistema despliega las opciones de plantillas clínicas estandarizadas (hospitalización, hemodiálisis, consulta externa, quirófano, cuidados intensivos, etc.).<br>3. El Enfermero selecciona la plantilla adecuada.<br>4. El sistema crea o despliega la pestaña correspondiente al paciente y formato seleccionado.<br>5. El usuario alterna entre las distintas camas o expedientes abiertos mediante el sistema de pestañas. |
| **Flujos Alternativos** | N/A |
| **Postcondiciones** | La interfaz activa la hoja de enfermería del paciente con el formato institucional correcto, lista para ser llenada. |

### UC-02: Capturar Datos Clínicos y Constantes
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-02: Capturar Datos Clínicos y Constantes |
| **Actores** | Enfermero. |
| **Precondiciones** | Existe una pestaña de paciente abierta con su respectiva plantilla. |
| **Flujo Básico** | 1. El Enfermero ingresa valores utilizando botones y controles de selección rápida preconfigurados, limitando el texto libre.<br>2. El sistema invoca al caso de uso "Evaluar Límites de Valores Clínicos" mediante `<<include>>`.<br>3. El sistema invoca al caso de uso "Calcular Fórmulas Clínicas" mediante `<<include>>`.<br>4. Los datos se almacenan cifrados en la base de datos local. |
| **Flujos Alternativos** | - **Uso de Escalas:** Si el campo requiere valoración específica, el Enfermero invoca "Evaluar Escalas Clínicas" mediante `<<extend>>`.<br>- **Firma o Verificación:** Si la sección lo requiere, el usuario invoca "Gestionar e Insertar Firma Digital" mediante `<<extend>>`. |
| **Postcondiciones** | Los datos clínicos quedan registrados y estructurados en el expediente local del paciente. |

### UC-03: Evaluar Límites de Valores Clínicos
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-03: Evaluar Límites de Valores Clínicos |
| **Actores** | Sistema (Invocado mediante `<<include>>` por UC-02). |
| **Precondiciones** | Se está ejecutando la captura de datos y se ingresó un valor de constantes vitales o balances. |
| **Flujo Básico** | 1. El sistema recibe el valor numérico ingresado (ej. presión arterial, temperatura).<br>2. El sistema compara el valor contra los rangos de validación lógica preestablecidos.<br>3. El sistema valida y acepta la entrada. |
| **Flujos Alternativos** | Si el valor está fuera de los límites lógicos posibles, el sistema bloquea la captura o emite una alerta restrictiva. |
| **Postcondiciones** | El valor clínico es marcado como válido y se aprueba su registro. |

### UC-04: Calcular Fórmulas Clínicas
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-04: Calcular Fórmulas Clínicas |
| **Actores** | Sistema (Invocado mediante `<<include>>` por UC-02). |
| **Precondiciones** | Se ingresaron datos base suficientes (peso, talla, líquidos, etc.) durante la captura clínica. |
| **Flujo Básico** | 1. El sistema detecta los datos base capturados.<br>2. Aplica algoritmos internos sin requerir acción del usuario para determinar IMC, Superficie Corporal, PAM o balances de líquidos (ingresos/egresos totales).<br>3. Rellena automáticamente los campos de resultados en la interfaz. |
| **Flujos Alternativos** | Si faltan variables para la fórmula, el sistema deja el campo derivado en blanco temporalmente. |
| **Postcondiciones** | Los valores calculados se visualizan de manera automática en la hoja y se anexan al registro. |

### UC-05: Evaluar Escalas Clínicas
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-05: Evaluar Escalas Clínicas |
| **Actores** | Enfermero (Extiende `<<extend>>` a UC-02). |
| **Precondiciones** | El usuario interactúa con una sección que requiere valoración (ej. Glasgow, EVA, Flebitis, Downton, Bristol). |
| **Flujo Básico** | 1. El usuario presiona el campo de la escala correspondiente dentro del contexto de la hoja.<br>2. El sistema despliega botones y opciones preconfiguradas (evitando texto libre).<br>3. El usuario selecciona los parámetros.<br>4. El sistema calcula los puntajes totales y los inserta en la hoja. |
| **Flujos Alternativos** | N/A |
| **Postcondiciones** | El resultado exacto de la escala clínica queda registrado en el expediente. |

### UC-06: Gestionar e Insertar Firma Digital
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-06: Gestionar e Insertar Firma Digital |
| **Actores** | Enfermero. |
| **Precondiciones** | El usuario se encuentra en un apartado que requiere firma o doble verificación. |
| **Flujo Básico** | 1. El Enfermero presiona el botón de acción rápida para insertar firma.<br>2. El sistema recupera la firma manuscrita digital previamente guardada y los datos de identificación del perfil.<br>3. El sistema adjunta la firma al apartado correspondiente o de doble verificación. |
| **Flujos Alternativos** | Si la firma digital no está configurada, el sistema solicita al usuario trazar y guardar su firma a mano en la pantalla antes de permitir la validación. |
| **Postcondiciones** | La firma queda vinculada al registro para plasmarse en el documento final. |

### UC-07: Visualizar Hoja y Generar Gráficas Automáticas
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-07: Visualizar Hoja y Generar Gráficas Automáticas |
| **Actores** | Enfermero. |
| **Precondiciones** | Existen datos clínicos guardados en la hoja de enfermería en proceso. |
| **Flujo Básico** | 1. El Enfermero solicita visualizar la hoja para revisar los registros del día.<br>2. El sistema compila la información y traza automáticamente las gráficas de signos vitales (temperatura, tensión arterial) según la normativa.<br>3. El sistema detecta apartados únicos y aplica el color correspondiente al turno del enfermero (según guías operativas).<br>4. El sistema renderiza el documento completo en pantalla. |
| **Flujos Alternativos** | Si el archivo falla en el renderizado, se muestra un mensaje de error solicitando recargar la vista. |
| **Postcondiciones** | El usuario puede auditar visualmente todo el trabajo realizado en el turno con el formato de colores y gráficas correctas. |

### UC-08: Transferir Hojas de Enfermería en Lotes (P2P)
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-08: Transferir Hojas de Enfermería en Lotes (P2P) |
| **Actores** | Enfermero, Enfermero (Receptor). |
| **Precondiciones** | Cambio de turno inminente; dispositivos con Bluetooth/Wi-Fi Direct activos. |
| **Flujo Básico** | 1. El Enfermero selecciona un lote de expedientes (de 1 hasta 10 pacientes).<br>2. El sistema genera un único código QR para emparejamiento.<br>3. El Receptor escanea el código para establecer un enlace seguro de proximidad.<br>4. El sistema invoca "Confirmar Transferencia (Doble Factor)" mediante `<<include>>`.<br>5. Se transmiten los expedientes en bloque. |
| **Flujos Alternativos** | Si se pierde la conexión P2P, la transferencia se aborta y debe reiniciarse el emparejamiento. |
| **Postcondiciones** | El lote de pacientes es transferido exitosamente al dispositivo del receptor. |

### UC-09: Confirmar Transferencia (Doble Factor)
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-09: Confirmar Transferencia (Doble Factor) |
| **Actores** | Sistema, Enfermeros (Emisor y Receptor) (Invocado por UC-08). |
| **Precondiciones** | Los dispositivos están vinculados vía QR y listos para iniciar la transmisión. |
| **Flujo Básico** | 1. El sistema emite una solicitud de confirmación en ambos dispositivos de manera simultánea.<br>2. El Emisor y el Receptor aprueban la transferencia mediante una acción rápida.<br>3. El sistema libera el envío del paquete de datos. |
| **Flujos Alternativos** | Si cualquiera de las dos partes deniega o el tiempo de espera expira, la transferencia se cancela. |
| **Postcondiciones** | Se garantiza la autorización mutua y se previene la pérdida accidental de información médica. |

### UC-10: Realizar Impresión (Individual o en Conjunto)
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-10: Realizar Impresión (Individual o en Conjunto) |
| **Actores** | Enfermero. |
| **Precondiciones** | Dispositivo conectado a la red local con acceso a una impresora. |
| **Flujo Básico** | 1. El Enfermero selecciona desde la vista de pestañas cuáles y cuántas hojas de enfermería desea imprimir.<br>2. El sistema agrupa los documentos y crea una cola de impresión.<br>3. El sistema invoca "Verificar Seguridad de Impresión" mediante `<<include>>`.<br>4. El sistema imprime de manera nativa los documentos solicitados. |
| **Flujos Alternativos** | Si la impresora no responde, el sistema alerta sobre el fallo de red sin perder los datos redactados. |
| **Postcondiciones** | Las hojas seleccionadas se materializan físicamente en la central de enfermería. |

### UC-11: Verificar Seguridad de Impresión
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-11: Verificar Seguridad de Impresión |
| **Actores** | Sistema (Invocado mediante `<<include>>` por UC-10). |
| **Precondiciones** | Se solicitó la impresión de una o varias hojas clínicas. |
| **Flujo Básico** | 1. El sistema escanea la totalidad de las plantillas seleccionadas.<br>2. Valida la presencia de datos críticos y firmas requeridas.<br>3. Habilita y ejecuta la acción de impresión. |
| **Flujos Alternativos** | Si detecta varias secciones vacías o importantes sin llenar, el sistema emite una advertencia de seguridad, pausando la impresión y señalando visualmente las partes faltantes para evitar errores o desperdicio de papel. |
| **Postcondiciones** | Se asegura la calidad de la información del documento antes de la impresión física. |

### UC-12: Eliminación Automática de Hojas Caducadas
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-12: Eliminación Automática de Hojas Caducadas |
| **Actores** | Sistema. |
| **Precondiciones** | La aplicación se ejecuta en segundo plano o se inicializa. |
| **Flujo Básico** | 1. El sistema rastrea el tiempo de actividad de todas las hojas de enfermería almacenadas.<br>2. Detecta expedientes que superan las 10 horas extra de su horario institucional de turno.<br>3. Verifica que la hoja no haya completado el proceso de impresión ni de verificación en dos pasos post-impresión.<br>4. El sistema purga permanentemente el registro por seguridad. |
| **Flujos Alternativos** | N/A |
| **Postcondiciones** | El dispositivo libera espacio y elimina información clínica riesgosa o abandonada, manteniendo el cumplimiento normativo. |