% Introducción a QtQuick
% Juan Morales del Olmo
% 27 de enero de 2015

# Introducción a QtQuick

## QML

> - Lenguaje declarativo

> - Expresiones imperativas en Javascript

> - La sintaxis es similar a Javascript

> - Bindings reactivos

> - Profundiza: En la ayuda de Qt: "QML Applications"

## QtQuick

> - La librería estándar de QML
	- El canvas gráfico (0,0 arriba a la izquierda)
	- **Interacción:** Touch, Mouse, Keyboard (con focus), Sensors
	- **Posiciónes:** bindings, anchors, *positioners* y Layouts
	- Estados, transiciones y animaciones

> - QtQuick Controls
	- Implementación de QtWidgets en QML

> - QtQuick Layouts
	- Implementación de layouts en QML (pantallas redimensionables)

## Sintaxis ##
    import QtQuick 2.0
	
	Rectangle {
        id: miRectangulo              // identificador único

	    width: 40                     // propiedades definidas
		height: 40
		radius: 10
        color: "red"

        property int miNumero: 42     // definición de propiedades
		                              //    ->   onMiNumeroChanged

		x : parent.width / 2          // posición con bindigns
		y : parent.height / 2

        MouseArea {
            anchors.fill: parent      // tambien por id: miRectangulo
            onClicked: {              // análogo a SIGNAL/SLOT
                Qt.quit();
            }
        }
     }

## Modular ##

- Se reutiliza el código de los componentes

- Los módulos tienen componentes
	
- Normalmente un componente es un módulo

- También se pueden definir componentes *inline* con `Component`

## Propiedades ##

Se le pueden asignar valores en asignaciones imperativas o en
**bindings** dinámicos

    Item {
        property int someNumber            // Con tipo
        property string someString
        property url someUrl
    
        property var someNumber: 1.5       // Con var
        property var someString: "abc"
        property var someBool: true
        property var someList: [1, 2, "three", "four"]
        property var someObject: Rectangle { width: 100; height: 100; color: "red" }
    
        property Rectangle someRectangle   // Cualquier QML Type
    }

## Propiedades ##

Definen señales automáticamente

    Rectangle {
        property color previousColor
        property color nextColor
        onNextColorChanged: console.log("The next color will be: " + nextColor.toString())
    }
	
## Propiedades ##

    Text {
        //dot notation
        font.pixelSize: 12
        font.b: true
    }
    
    Text {
        //group notation
        font { pixelSize: 12; b: true }
    }

	Item {
	    property alias widgetLabel: label
    }

## Señales ##

    // SquareButton.qml
    Rectangle {
        id: root
    
        signal activated(real xPosition, real yPosition)
        signal deactivated
    
        width: 100; height: 100
    
        MouseArea {
            anchors.fill: parent
            onPressed: root.activated(mouse.x, mouse.y)  // Así se emiten
            onRelased: root.deactivated()
        }
    }


    // myapplication.qml
    SquareButton {
        onActivated: console.log("Activated at " + xPosition + "," + yPosition)
        onDeactivated: console.log("Deactivated!")
    }

## Métodos ##

    import QtQuick 2.0
    Rectangle {
        id: rect
    
        function calculateHeight() {    // Sintaxis de Javascript
            return rect.width / 2;
        }
    
        width: 100
        height: calculateHeight()
    }

## Bindings ##


    Rectangle {
        width: 100
        height: width * 2
    
        focus: true               // Puede tener el foco
        Keys.onSpacePressed: {
            height = width * 3    // No es un binding. Asignación estática
        }
    }
    
    Rectangle {
        width: 100
        height: width * 2
    
        focus: true
        Keys.onSpacePressed: {
            height = Qt.binding(function() { return width * 3 })
        }
    }

## Estados y transiciones ##


> - Para GUIs medianamente complejas

> - Los estados tiene un nombre y una serie valores para propiedades

> - Permiten agrupar los valores definidos en cada momento de la interacción

> - <http://doc.qt.io/qt-5/qtquick-usecase-animations.html>

## Posiciones en QtQuick ##

- Originalmente diseñado para móviles (dimensiones fijas)

> - Se puede hacer a mano, con bindings, anchors o layouts

> - <http://doc.qt.io/qt-5/qtquick-usecase-layouts.html>
