# Soporte multi-idioma

Por defecto flutter solo soporta el idioma ingles, es decir todos los Widgets en caso de que tengan un texto por defecto van a estar en ingles. En estas notas se describe el paso a paso para soportar diferentes idiomas, realmente no es complejo y flutter tiene una herramienta super potente para soportar intenacionalización.

?> En este [link](https://github.com/milo2005/flutter-with-coffee/tree/master/examples/internationalization) hay un ejemplo donde se explican muchos casos (plurales, cantidades, interpolación y opciones) para soportar multiples idiomas (en, es).

## 1. Configuración Inicial
Para soportar multiples idiomas debemos agregar lo siguiente en el [pubspec.yml](https://github.com/milo2005/flutter-with-coffee/blob/master/examples/internationalization/pubspec.yaml).

- En la sección de **dependencies** agregamos **flutter_locations**, esto es para agregar el soporte multi-idioma a los widgets propios de Flutter.

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations: # Agregamos esta linea y la siguiente
    sdk: flutter
```

- Agregamos la dependencia **intl** que nos permite realizar el soporte a multiples idiomas para nuestros propios Strings, ejecutamos el siguiente comando en la terminal:

```
flutter pub add intl
```

- en la sección de **flutter** agregamos la propiedad generate para que podamos generar las clases que nos van a dar acceso a los Strings.

```yaml
flutter:
  generate: true # Agregamos esta linea
```


## 1.5 Soporte solo a los Widgets de Flutter

!> Este paso no es necesario, solo es para entender como se da soporte a las Widgets de flutter a multiples idiomas, pero en una app productiva hay que realizar este [paso](ui/intl?id=soportando-multiples-idiomas).



Para agregar soporte a multiples idiomas a los widgets de Flutter (Es decir los que vienen por defecto), debemos agregar la siguiente configuración en MaterialApp en el archivo [main.dart](https://github.com/milo2005/flutter-with-coffee/blob/master/examples/internationalization/lib/main.dart).

```dart
// En los imports agregamos
import "package:flutter_gen/gen_l10n/app_localizations.dart";

// ...
// En el Widget de Material App agregamos los LocalizationsDelegates & supportedLocales
return const MaterialApp(
  title: 'Internationalization',
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: [
    Locale('en', ''),
    Locale('es', ''),
  ],
  home: MyHomePage(),
);

```

**localizationsDelegates**

Estos son las clases que proporcionan los strings en multiples idiomas, en este caso se agregan los de material, cupertino y los widgets base.

**supportedLocales**

Aqui se especifican los idiomas y paises soportadoss, 
- El idioma debe venir en el [formato](https://lingohub.com/developers/supported-locales/language-designators) de dos caracteres, por lo que en el anterior ejemplo se soporta en = ingles y es = español
- El pais debe venir en el siguiente [formato](https://lingohub.com/developers/supported-locales/language-designators-with-regions) de dos caracteres en mayusculas, en el ejemplo anterior no se especifican por lo que es español o ingles para cualquier pais.


## 2. Configuración para Intl

Para agregar nuestros propios Strings que tengan soporte a diferentes idiomas vamos a usar la libreria de **intl** que nos permite especificar los Strings en archivos .arb, hay que seguir los siguientes pasos:

### Agregarmos el archivo arb por defecto

Un archivo .arb es el que va contener nuestros Strings, mas adelante se va a entrar en detalle de que contenido tiene, por ahora agregamos el folder donde vamos a colocar los archivos .arb para nuestros Strings y creamos nuestro archivo **app_en.arb** que contiene los strings por defecto.

`lib/assets/l10n/app_en.arb`

En el ejemplo anterior hay varias consideraciones a tener en cuenta:

- **l10n** es un termino que se usa para referirse a **localización**, por lo que es estandar que ubiquemos en ese folder nuestros strings.
- El nombre del archivo **app_en.arb** es muy importante tiene el siguiente formato:

`[name]_[lang]_[country].arb`

El nombre puede ser cualquiera en este caso **app**, el idioma es ingles (en) y no tiene un pais por defecto especificado, para ver los formatos de idioma y pais podemos revisar este [enlace](https://lingohub.com/developers/supported-locales/language-designators-with-regions).

?> Es importante dar soporte a paises cuando se use regionalismos de cada pais, o se use simbolos de moneda. 


### Agregamos la configuración de l10n

Agregamos el archivo **l10n.yaml** en la ruta raiz del proyecto, este archivo va tener información sobre cual es la ruta de los archivos .arb y cual va ser el idioma por defecto.


**l10n.yaml**

```yaml
arb-dir: lib/assets/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
nullable-getter: false
```

**arb-dir**

Es el directorio donde van a estar los archivos .arb

**template-arb-file**

Es el idioma por defecto y el que contiene toda la descripción de los strings como se va a ver en la siguiente sección.

**output-location-file**

Es el nombre del archivo que se va a generar con nuestros Strings y el que vamos a usar en nuestra aplicación flutter.


**nullable-getter**
Especifica si hay que considerar los strings como nulos, en este caso lo he especificado que no.

## 3. Archivos ARB

En la seccion anterior crearmos el archivo **app_en.arb** y lo especificamos en la configuración de **l10n.yaml** como el template, por lo que en este archivo contendrá los strings y su descripción.

Ejemplo podemos agregar un String de la siguiente manera en el archivo **app_en.arb**:

```json
{
    "applicationTitle": "Internationalization Example",
    "wellcomeMessage": "Wellcome! to this example "
}
```

En el ejemplo anterior el contendio de **app_en.arb** es un documento JSON que contiene dos propiedades es decir dos Strings, el nombre de la propiedad puede ser cualquiera pero debe estar en formato camelCase (estoEsCamelCase) y el contenido de la propiedad es el texto que vamos a presentar en pantalla.


Lo anterior se va a generar en Flutter de la siguiente manera (Aun no hemos visto como se genera los archivos):

```dart
Text(AppLocalizations.of(context).applicationTitle)
```

Cada String en el archivo arb puede tener información asociada (metadata) que describa ese string y que permita generar un codigo mas completo, por ejemplo:

```json
{
    "applicationTitle": "Internationalization Example",
    "@applicationTitle":{
        "description": "This is the title of the home screen"
    },

    "wellcomeMessage": "Wellcome! to this example "
}
```

Como se ve en el ejemplo anterior, para agregar la metadata se debe crear otra propiedad con mismo nombre que el string pero con una @ (**@applicationTitle**), dentro de ella se agregan las propiedades que describen el string, en el ejemplo se agrega una descripción que se agrega al codigo generado.


?> La metadata de un string (**@applicationTitle**) solo se deben incluir en el archivo arb que fue configurado como template en el **l10n.yaml**

### Variables en Strings
Se puede colocar variables dentro de los Strings de la siguiente manera:

```json
{
    "applicationTitle": "Internationalization Example",
    "@applicationTitle": {
        "description": "This is the title of the home screen"
    },

    "wellcomeMessage": "Wellcome {name}! you have {count} messages ",
    "@wellcomeMessage": {
        "placeholders": {
            "name": {
                "type": "String"
            },
            "count": {
                "type": "int"
            }
        }
    }
}
```

En el ejemplo anterior en **wellcomeMessage** se agregaron dos variables en el String: name y count, en la metadata en la seccion de place holders se especifica el tipo de cada variable.

Los tipos solo pueden ser String, int, double, num, Object o DateTime.

El ejemplo anterior va a generar un codigo como el siguiente:

```dart
Text(AppLocalizations.of(context).wellcomeMessage("Dario", 10)) 
```

En caso de ser valores decimales o de moneda y se pueden describir aun mas, por ejemplo:

```json
{
    // ... 
    "moneyFormat": "{money}",
    "@moneyFormat": {
        "placeholders": {
            "money": {
                "type": "double",
                "format": "currency", // Especifica el formato con el cual se imprime solo para moneda y fechas
                "optionalParameters": { // Opciones que dan mas información del formato
                    "decimalDigits": 2,                    
                }
            }
        }
    }
}
```
Para mayor info del formato ver este [enlace](https://localizely.com/flutter-arb/).

### Plurales
Los plurales son casos en el que el texto varia segun la cantidad
```json
{
    // ... 
    "productsCount": "{count, plural, =0{You not have products} =1{You have only one product} other{You have {count} products}}",
    "@productsCount": {
        "placeholders": {
            "count": {
                "type": "int"
            }
        }
    }
}
```

El formato para plurales es el siguiente

`{nombreDeVariable, plural, =0{Texto en caso de ser cero} =1{Texto en caso de ser 1} other{Texto en caso de ser varios}}`


### Opciones
Arb permite establecer opciones, esto puede ser util cuando se usan enums

```json
{
    // ... 
    "movieCategory": "{category, select, terror{Terror} comedy{Comedy} mistery{Mistery & Fantasy} other{Unknown}}",
    "@movieCategory": {
        "placeholders": {
            "category": {
                "type": "String"
            }
        }
    }
}
```

El formato para plurales es el siguiente

`{nombreDeVariable, select, opcion1{Texto en caso de ser la opcion 1} opcionN{Texto en caso de ser la opcion n} other{Texto en caso de no ser ninguna opcion}}`

### Fechas
Tambien podemos dar formato a fechas con arb
```json
{
    // ... 
    "currentDate": "Today: {date}",
    "@currentDate": {
        "placeholders": {
            "today": {
                "type": "DateTime",
                "format": "yMd"
            }
        }
    }
}
```


# 4. Agregar otro Idioma

Para agregar otro solo debemos agregar otro archivo arb especificando el idioma y el pais, es decir, si queremos dar soporte a español seria **app_es.arb**

<!-- tabs:start -->
#### **app_en.arb**

```json
{
    "applicationTitle": "Internationalization Example",
    "@applicationTitle": {
        "description": "This is the title of the home screen"
    },

    "wellcomeMessage": "Wellcome {name}! you have {count} messages ",
    "@wellcomeMessage": {
        "placeholders": {
            "name": {
                "type": "String"
            },
            "count": {
                "type": "int"
            }
        }
    },

    "moneyFormat": "{money}",
    "@moneyFormat": {
        "placeholders": {
            "money": {
                "type": "double",
                "format": "currency",
                "optionalParameters": {
                    "decimalDigits": 2,                    
                }
            }
        }
    },

    "productsCount": "{count, plural, =0{You not have products} =1{You have only one product} other{You have {count} products}}",
    "@productsCount": {
        "placeholders": {
            "count": {
                "type": "int"
            }
        }
    },

    "movieCategory": "{category, select, terror{Terror} comedy{Comedy} mistery{Mistery & Fantasy} other{Unknown}}",
    "@movieCategory": {
        "placeholders": {
            "category": {
                "type": "String"
            }
        }
    },

    "currentDate": "Today: {date}",
    "@currentDate": {
        "placeholders": {
            "today": {
                "type": "DateTime",
                "format": "yMd"
            }
        }
    }
}
```


#### **app_es.arb**

```json
{
    "applicationTitle": "Ejemplo de Internacionalizacion",
    "wellcomeMessage": "Bienvenido {name}! tienes {count} mensajes ",
    "moneyFormat": "{money}",
    "productsCount": "{count, plural, =0{No tienes productos} =1{Solo tienes un producto} other{Tienes {count} productos}}",
    "movieCategory": "{category, select, terror{Horror} comedy{Comedia} mistery{Misterio y Fantasia} other{Desconocido}}",
    "currentDate": "Hoy: {date}"   
}
```

<!-- tabs:end -->


# Usar los Strings
Para usar los Strings primero debemos generar la clase que nos va a ayudar a usar los archivos arb, para eso usamos este comando en la terminal

```
flutter gen-l10n
```

Esto va a generar el archivo **AppLocalizations** donde vamos a poder obtener los Strings

## Agregar la configuración en MaterialApp

```dart
// En los imports agregamos
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ...
// En el Widget de Material App agregamos los LocalizationsDelegates & supportedLocales generados
// Estos incluyen los GlobalDelegate de Flutter
return const MaterialApp(
  title: 'Internationalization',
  localizationsDelegates: AppLocalizations.localizationsDelegates, // Agregamos los delegates y idiomas generados
  supportedLocales: AppLocalizations.supportedLocales,
  home: MyHomePage(),
);

```

## Agregamos la configuración en iOS

En Android la configuración es automatica pero en iOS debemos agregar lo siguiente  en el archivo

`ios/Runner/info.plist`

```xml
  <key>CFBundleLocalizations</key>
  <array>
      <string>English</string>
      <string>French</string>
  </array>
```

## Clase AppLocalizations

En este [ejemplo](https://github.com/milo2005/flutter-with-coffee/blob/master/examples/internationalization/lib/HomePage.dart) podemos ver como se pueden usar los strings en una interfaz.