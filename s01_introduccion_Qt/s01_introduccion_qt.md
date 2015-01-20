% Introducción a Qt
% Juan Morales del Olmo
% 20 de enero de 2015
	
# Introducción a Qt

## Qué es Qt

<iframe width="640" height="480" src="http://www.youtube.com/embed/FIs5YqzS4Bc" frameborder="1" allowfullscreen>
![[http://www.youtube.com/embed/FIs5YqzS4Bc](http://www.youtube.com/embed/FIs5YqzS4Bc)](../rsc/images/link.png)

</iframe>

-----------------------------------------

- Qt is a **cross-platform** application and **UI framework** for developers
	using **C++** or **QML**, a CSS & **JavaScript** like language.

>- *Moto:* Write Once Deploy Everywhere

>- Windows, Mac Os, X11, Wayland, Android, iOS, WinRT

>- Casi una librería estándar de C++ (*sin plantillas*)
	- <http://doc.qt.io/qt-5/qtcore-index.html>

>- Oculta diferencias de plataformas

>- Varios frameworks para hacer GUIs: QWidgets, QtQuick, QWebKit

>- Licencia dual: GPL/LGPL y módulos comerciales

## GUI Frameworks

#### QWidgets ####

- C++
- Desktop

#### QtQuick ####

- QML / Javascript
- Móvil / Desktop

#### QWebKit ####

- HTML, CSS, Javascript
- Lo vamos a ignorar

<http://doc.qt.io/qt-5/topics-ui.html>

# Programación para GUIs #

## Programación asíncrona ##

- También llamado "inversión de control"

>- Ortogonal a Orientación a objetos, funcional, procedural

>- Un programa ya no es una serie de pasos con principio y fin determinados.

>- Diferente a programación concurrente y programación paralela.

## Implementación (p. asíncrona) ##

>- Control de flujo: **Callbacks** o programación **reactiva**

>- **Loop infinito**  (Normalmente sin espera activa)

>- **Cola de eventos** (Con o sin prioridades)

--------------------------------------------------

### Implementación en QT ###

>- Control de flujo:
	- En **QWidgets y QWebkit**: Callbacks
		- **SIGNAL/SLOT** gracias al MOC
		- ``void \*``  no chequea tipos
		- No había lambdas hasta C++11		
	- En **QtQuick**: Programación reactiva
		- Bindings implícitos y explícitos

>- Loop infinito: Explícito
    - ``QEventLoop`` es la clase que lo implementa 
			QApplication.exec();

--------------------------------------------------

- Cola de eventos: Implícita
	  - Tiene prioridad 
      - Eventos de Ratón (``QMouseEvent``), Teclado (``QKeyEvent``) o alarmas (``QTimerEvent``)
	  - Internos (``QResizeEvent``, ``QPaintEvent``)

			QCoreApplication::sendEvent(); // Inmediato
			QCoreApplication::postEvent(); // Se encola y el event loop lo notifica

Profundiza: <http://doc.qt.io/qt-5/eventsandfilters.html>

## Programación declarativa ##

>- Contraparte a programación imperativa
>- Subtipos de programación declarativa:
	- programación lógica: *Prolog*
	- programación funcional: *Haskell*
	- programación algebraica: *SQL*
>- Tiende a ser lo más eficaz (facilidad de código) para interfaces gráficos

>- PROS:
	- Definir la interfaz (vs *ir creándola*)
	- *El diablo está en el estado*
	
--------------------------------------------------

>- Qt Designer crea .ui (XML declarativo) que con MOC se convierte en imperativo (.h)

>- QML es un lenguaje declarativo
	- El Javascript imperativo es mínimo

>- HTML es declarativo

## Herramientas de desarrollo

>- MOC
>- Qmake
>- Qt Designer
	- <http://doc.qt.io/qt-5/qtdesigner-manual.html>
>- UIC
>- RCC

>- **QtCreator**

## Modelo de renderizado

- Thread principal hace el renderizado
	- **Ojo:** No pintar desde otro thread
	- Tareas pesadas no deben bloquear el main thread
	
>- Evento QPaintEvent cuando se repinta

>- Se puede forzar con ``update()``

>- QML acelarado por hardware

## Jerarquía de Widgets

- Patron de diseño principal para desarrollar GUIs

>- La gestión de memoria de ``QObjects`` se realiza en jerarquía también
>- Criterios de visibilidad/layout afectan a hijos
>- El manejo de eventos se transmite por la jerarquía

## Foco

>- Foco: (metáfora de atención del usuario)
	- Sobre qué interactúa el usuario
	- Es un modo (por tanto conlleva errores)
	- Muy extendido en Desktop, menos en Móvil

