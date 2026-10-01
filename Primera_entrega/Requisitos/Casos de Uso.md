# Casos de Uso

### UC-01: Gestionar Cédulas
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-01: Gestionar Cédulas[cite: 149] |
| **Actores** | Administrador, Servidor de autenticación.[cite: 149] |
| **Precondiciones** | El Administrador debe haber iniciado sesión en el sistema administrativo web.[cite: 149] |
| **Flujo Básico** | 1. El Administrador ingresa los datos y cédula del profesional en el panel.[cite: 149]<br>2. El sistema envía la información al Servidor de autenticación.[cite: 149]<br>3. El Servidor guarda la cédula en la lista de accesos permitidos.[cite: 149] |
| **Flujos Alternativos** | Si la cédula ya está registrada, el sistema muestra una alerta de duplicidad.[cite: 149] |
| **Postcondiciones** | La cédula del enfermero queda autorizada para iniciar sesión en la aplicación móvil.[cite: 149] |

### UC-02: Autenticar y Generar Token
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-02: Autenticar y Generar Token[cite: 149] |
| **Actores** | Enfermero, Servidor de autenticación.[cite: 149] |
| **Precondiciones** | El dispositivo tiene conexión a internet y la cédula está preautorizada en el servidor.[cite: 149] |
| **Flujo Básico** | 1. El Enfermero ingresa sus credenciales en la aplicación móvil.[cite: 149]<br>2. La aplicación solicita la validación al Servidor de autenticación.[cite: 149]<br>3. El servidor aprueba y devuelve un token criptográfico.[cite: 149]<br>4. La aplicación almacena el token para uso local.[cite: 149] |
| **Flujos Alternativos** | Si las credenciales son incorrectas, el sistema deniega el acceso.[cite: 149] |
| **Postcondiciones** | El Enfermero obtiene una sesión válida que permite operar la aplicación sin internet.[cite: 149] |

### UC-03: Desbloquear Sesión Local
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-03: Desbloquear Sesión Local[cite: 149] |
| **Actores** | Enfermero.[cite: 149] |
| **Precondiciones** | Existe un token activo guardado y la aplicación fue minimizada o bloqueada.[cite: 149] |
| **Flujo Básico** | 1. El Enfermero abre la aplicación móvil.[cite: 149]<br>2. El sistema solicita el ingreso de PIN o huella dactilar.[cite: 149]<br>3. El sistema valida el PIN contra el token local almacenado.[cite: 149]<br>4. El sistema restaura el acceso a las funciones operativas.[cite: 149] |
| **Flujos Alternativos** | Si el PIN es incorrecto, el sistema solicita reintentarlo.[cite: 149] |
| **Postcondiciones** | La sesión local queda desbloqueada y lista para su uso del programa.[cite: 149] |

### UC-04: Gestionar Pestañas de Pacientes
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-04: Gestionar Pestañas de Pacientes[cite: 149] |
| **Actores** | Enfermero.[cite: 149] |
| **Precondiciones** | La aplicación está desbloqueada y en la pantalla principal.[cite: 149] |
| **Flujo Básico** | 1. El Enfermero selecciona la opción para agregar o cambiar de paciente.[cite: 149]<br>2. El sistema crea o despliega la pestaña correspondiente al paciente seleccionado.[cite: 149]<br>3. El usuario alterna entre las distintas camas o expedientes abiertos.[cite: 149] |
| **Flujos Alternativos** | N/A[cite: 149] |
| **Postcondiciones** | La interfaz activa la hoja de enfermería del paciente seleccionado y listo para escribir.[cite: 149] |

### UC-05: Capturar Datos clínicos
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-05 Capturar Datos clínicos[cite: 149] |
| **Actores** | Enfermero[cite: 149] |
| **Precondiciones** | Existe una pestaña de paciente abierta.[cite: 149] |
| **Flujo Básico** | 1. El Enfermero ingresa valores de signos vitales, balances o notas en los campos de la hoja.[cite: 149]<br>2. El sistema invoca al caso de uso "Evaluar Limites de Valores Clínicos" mediante `<<include>>`.[cite: 149]<br>3. El sistema invoca al caso de uso "Calcular formulas" mediante `<<include>>`.[cite: 149]<br>4. Los datos se almacenan cifrados en la base de datos local.[cite: 149] |
| **Flujos Alternativos** | - Uso de escalas: El Enfermero invoca manualmente "Seleccionar escalas" mediante `<<extend>>` si el campo requiere una valoración específica (ej. Glasgow).[cite: 149]<br>- Alto Riesgo: El sistema invoca automáticamente "Aplicar Doble Verificación a Registros Clínicos con Firma" mediante `<<extend>>` si en el apartado de la hoja de enfermería corresponde de esta (ej. Ministración de medicamentos)[cite: 149] |
| **Postcondiciones** | Los datos clínicos quedan registrados y guardados en el expediente local del paciente.[cite: 149] |

### UC-06: Evaluar Limites de Valores Clínicos
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-06: Evaluar Limites de Valores Clínicos[cite: 149] |
| **Actores** | Sistema (Invocado mediante `<<include>>` por UC-05).[cite: 149] |
| **Precondiciones** | Se está ejecutando el caso de uso de Capturar Datos Clinicos y se ingresó un valor numérico.[cite: 149] |
| **Flujo Básico** | 1. El sistema recibe el valor numérico ingresado.[cite: 149]<br>2. El sistema compara el valor contra los rangos lógicos preestablecidos de signos vitales.[cite: 149]<br>3. El sistema valida y acepta la entrada.[cite: 149] |
| **Flujos Alternativos** | Si el valor está fuera de rangos humanos posibles (ej. temperatura de 50°C), bloquea la captura y muestra un error.[cite: 149] |
| **Postcondiciones** | El valor clínico es marcado como congruente y permitido para su guardado.[cite: 149] |

### UC-07: Calcular formulas
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-07: Calcular formulas[cite: 149] |
| **Actores** | Sistema (Invocado mediante `<<include>>` por UC-05).[cite: 149] |
| **Precondiciones** | Se ingresaron datos base suficientes (ej. ingresos, egresos, peso, talla,etc.) durante la captura clínica.[cite: 149] |
| **Flujo Básico** | 1. El sistema detecta los datos base capturados.[cite: 149]<br>2. Aplica algoritmos internos para determinar balances, IMC o PAM.[cite: 149]<br>3. Rellena automáticamente los campos de resultados en la interfaz.[cite: 149] |
| **Flujos Alternativos** | Si faltan variables para la fórmula, el sistema deja el campo derivado en blanco temporalmente.[cite: 149] |
| **Postcondiciones** | Los valores calculados se visualizan en la hoja y se anexan al registro.[cite: 149] |

### UC-08: Seleccionar escalas
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-08: Seleccionar escalas[cite: 149] |
| **Actores** | Enfermero (Extiende `<<extend>>` a UC-05).[cite: 149] |
| **Precondiciones** | El Enfermero interactúa con un campo de valoración neurológica o de riesgo.[cite: 149] |
| **Flujo Básico** | 1. El usuario presiona el campo de la escala.[cite: 149]<br>2. El sistema despliega un menú con las opciones predefinidas de la escala clínica.[cite: 149]<br>3. El usuario selecciona los puntajes correspondientes.[cite: 149]<br>4. El sistema suma los puntos y los inserta en la hoja.[cite: 149] |
| **Flujos Alternativos** | N/A[cite: 149] |
| **Postcondiciones** | El puntaje de la escala clínica queda registrado en el expediente.[cite: 149] |

### UC-09: Firmar y Validar Registro de Cédula en la App
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-09: Firmar y Validar Registro de Cédula en la App[cite: 149] |
| **Actores** | Enfermero.[cite: 149] |
| **Precondiciones** | El enfermero se está registrando por primera vez en la App[cite: 149] |
| **Flujo Básico** | 1. El Enfermero presiona el botón de firma en la interfaz.[cite: 149]<br>2. El sistema solicita la firma del enfermero.[cite: 149]<br>3. El enfermero realiza su firma en un espacio en blanco en la pantalla.[cite: 149]<br>4. La firma del enfermero es guardado en su perfil para que se pueda utilizar en las hojas de enfermería[cite: 149] |
| **Flujos Alternativos** | Si la firma digital no está configurada, el sistema no permite avanzar con el uso de la aplicación hasta que el enfermero realice su firma y los guarde digitalmente. El enfermero podrá reintentar firmar.[cite: 149] |
| **Postcondiciones** | El registro adquiere validez legal e inalterabilidad.[cite: 149] |

### UC-10: Aplicar Doble Verificación a Registros Clinicos con Firma
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-10: Aplicar Doble Verificación a Registros Clinicos con Firma[cite: 149] |
| **Actores** | Enfermero.[cite: 149] |
| **Precondiciones** | Se está ejecutando el caso de uso UC-05 (Capturar Datos Clínicos) y el usuario acaba de ingresar la administración de un procedimiento o medicamentos en donde corresponda la hoja de enfermería.[cite: 149] |
| **Flujo Básico** | 1. El apartado solicita la firma (por botón) para el enfermero que realiza la doble verificación[cite: 149]<br>2. El enfermero presiona el boton para registrar su firma de la doble verificación.[cite: 149]<br>3. El sistema guarda temporalmente la firma del enfermero en la hoja de enfermería.[cite: 149] |
| **Flujos Alternativos** | N/A[cite: 149] |
| **Postcondiciones** | La firma de enfermero es guardada temporalmente en el registro de la hoja de enfermería hasta que se imprima y esta sera visualizada tanto en los apartado de generación y previsualización.[cite: 149] |

### UC-11: Generar y Pre-visualizar Hoja
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-11: Generar y Pre-visualizar Hoja[cite: 149] |
| **Actores** | Enfermero.[cite: 149] |
| **Precondiciones** | La hoja de enfermería contiene datos clínicos capturados y está firmada.[cite: 149] |
| **Flujo Básico** | 1. El Enfermero solicita previsualizar el documento.[cite: 149]<br>2. El sistema procesa los datos y traza las gráficas automáticamente.[cite: 149]<br>3. El sistema compila y renderiza el PDF en pantalla, mostrando la estructura física del documento.[cite: 149] |
| **Flujos Alternativos** | Si el archivo falla en el renderizado, se muestra un mensaje de error solicitando recargar la vista.[cite: 149] |
| **Postcondiciones** | El usuario visualiza la hoja de enfermería en formato de impresión sin guardar archivos en disco.[cite: 149] |

### UC-12: Transferir Hoja de Enfermeria (P2P)
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-12: Transferir Hoja de Enfermeria (P2P)[cite: 149] |
| **Actores** | Enfermero, Enfermero (receptor).[cite: 149] |
| **Precondiciones** | Cambio de turno inminente; ambos dispositivos tienen conexión de proximidad activa.[cite: 149] |
| **Flujo Básico** | 1. El Enfermero selecciona la hoja y genera un código QR para transferencia.[cite: 149]<br>2. El Enfermero (receptor) escanea el código para enlazar los dispositivos.[cite: 149]<br>3. Se transmiten los datos cifrados localmente.[cite: 149]<br>4. El sistema invoca el caso de uso "Confirmar (Recepción/Impresión)".[cite: 149] |
| **Flujos Alternativos** | Si se pierde la conexión de bluetooth, la transferencia se aborta y debe reiniciarse el enlace QR.[cite: 149] |
| **Postcondiciones** | Los datos del paciente se envían al dispositivo del receptor de manera íntegra.[cite: 149] |

### UC-13: Realizar impresión de hoja
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-13: Realizar impresión de hoja[cite: 149] |
| **Actores** | Enfermero.[cite: 149] |
| **Precondiciones** | Dispositivo conectado a la red local donde se encuentra la impresora.[cite: 149] |
| **Flujo Básico** | 1. El Enfermero selecciona la opción de imprimir expediente.[cite: 149]<br>2. El sistema invoca "Verificar información necesaria".[cite: 149]<br>3. El sistema envía el documento a la impresora.[cite: 149]<br>4. El sistema invoca "Confirmar (Recepción/Impresión)".[cite: 149] |
| **Flujos Alternativos** | Si la impresora no responde, el sistema alerta sobre el fallo de conexión y no se confirma la impresión para no borrar la información redactada.[cite: 149] |
| **Postcondiciones** | El documento físico es generado en la central de enfermería.[cite: 149] |

### UC-14: Verificar información necesaria
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-14: Verificar información necesaria[cite: 149] |
| **Actores** | Sistema (Invocado mediante `<<include>>` por UC-13).[cite: 149] |
| **Precondiciones** | Se solicitó la impresión de una hoja clínica.[cite: 149] |
| **Flujo Básico** | 1. El sistema escanea la totalidad de la plantilla.[cite: 149]<br>2. Revisa que los campos obligatorios legales y las firmas de cierre estén presentes.[cite: 149]<br>3. Habilita la acción de impresión.[cite: 149] |
| **Flujos Alternativos** | Si faltan firmas o campos críticos, el sistema detiene la impresión y señala las omisiones al usuario.[cite: 149] |
| **Postcondiciones** | Se garantiza que el documento impreso cumple con la normativa legal mínima.[cite: 149] |

### UC-15: Confirmar (Recepción/Impresión)
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-15: Confirmar (Recepción/Impresión)[cite: 149] |
| **Actores** | Sistema, Enfermero (receptor) (Invocado por UC-12 y UC-13).[cite: 149] |
| **Precondiciones** | Finalizó la transferencia P2P o se envió el comando a la impresora.[cite: 149] |
| **Flujo Básico** | 1. El sistema solicita validación visual al usuario receptor sobre la integridad de los datos o documento.[cite: 149]<br>2. El usuario acepta la confirmación.[cite: 149]<br>3. El sistema invoca el caso de uso "Eliminar hoja".[cite: 149] |
| **Flujos Alternativos** | Si el usuario rechaza la confirmación (documento corrupto o impresión fallida), el sistema cancela el borrado.[cite: 149] |
| **Postcondiciones** | La transición de la información es certificada por las partes involucradas.[cite: 149] |

### UC-16: Eliminar hoja
| Atributo | Descripción |
| :--- | :--- |
| **Nombre** | UC-16: Eliminar hoja[cite: 149] |
| **Actores** | Sistema (Invocado mediante `<<include>>` por UC-15).[cite: 149] |
| **Precondiciones** | Se validó exitosamente la recepción o impresión.[cite: 149] |
| **Flujo Básico** | 1. El sistema localiza los registros vinculados en el dispositivo emisor.[cite: 149]<br>2. Elimina toda la información escrita de manera permanente.[cite: 149]<br>3. Elimina las referencias visuales de la interfaz de pestañas.[cite: 149] |
| **Flujos Alternativos** | N/A[cite: 149] |
| **Postcondiciones** | El dispositivo original queda sin rastros de los datos clínicos transferidos.[cite: 149] |