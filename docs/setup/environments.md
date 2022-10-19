# Environments

Cuando hablamos de environments nos referimos a diferentes configuraciones o inclusive implementaciones que pueda tener la aplicación, por ejemplo podemos desarrollar una aplicación que cuando se publique en la tienda de aplicaciones haga operaciones de lectura o escritura a algun servicio como puede ser Firebase o un servicio Web, que pasa si necesitamos realizar pruebas o implementar una nueva feature que realice operaciones sobre un servicio, no deberiamos usar los datos de que ya esten usandoce es decir los de **producción** deberiamos probar con otros datos que nos permitan manipular los datos sin modificar los que estan funcionando, es decir podriamos crear una configuración de la app que apunte a los datos productivos y otra configuración que apunte a datos de prueba.

?> En este [link](https://github.com/milo2005/flutter-with-coffee/tree/master/examples/flavors) hay un ejemplo de como manejar environments con injección de dependencias, mas info en esta [sección](setup/environments.md?id=algunas-ideas).

Por lo genera hablamos de tres environments:

**Development**

Es el ambiente que usamos para implementar la aplicación por lo que no hay problema de cambiar todos los datos.

**Test**

Ambiente construido para probar la app, esta pensado para hacerla fallar e identificar errores.

**Staging**

Ambiente casi productivo, puede tener las ultimas features para ser probadas por usuarios de beta, podria trabajar con datos reales o con copia de ellos.

**Production**

Es el ambiente final, el que usan nuestros usuarios y el que contiene los datos productivos.


?> En la practica para una aplicación pequeña, es de mucha utilidad poder diferenciar el ambiente de desarrollo y de producción.

## Build Variants

Cuando hablamos de build variants, nos referimos a variantes de una misma aplicación al momento de compilarlas, en flutter tenemos dos variantes:

**Debug**

Si ejecutamos la aplicación directamente con Android Studio, este generará una version de debug, es decir una version no optimizada que nos permite ver los mensajes en consola y depurar la app (Con Breakpoints y analisis de codigo). 

Si queremos ejecutar flutter en debug podemos hacerlo con el siguiente comando:

```
flutter run --debug
```

Si queremos generar un apk en debug:

```
flutter build apk --debug
```

**Release**

Cuando generamos una version productiva de la aplicación y es la que vamos a publicar en la tienda, para ello aqui hay mas info para publicar en [Android](https://docs.flutter.dev/deployment/android) y [iOS](https://docs.flutter.dev/deployment/ios), esta version es optimizada en tamaño y no incorpora elementos que permitan realizar un debug de la aplicación.

Si queremos ejecutar flutter en release podemos hacerlo con el siguiente comando:

```
flutter run --release
```

Si queremos generar un apk en release:

```
flutter build apk --release
```

### En el codigo

Si quieremos diferenciar el modo debug a release podemos hacerlo con un if.

```dart
import 'package:flutter/foundation.dart';

// ...

if(kReleaseMode){ // es release mode?
 // Hacer algo en release
} else {
 // Hacer algo en debug
}
```


## Algunas ideas

A continuación se dan algunas ideas para separar environments con algunas estrategias:

### Injección de dependencias
Podemos crear environments con injección de dependencias, es decir podemos proveer una dependencia diferente en cada environments para que se comporten de una forma distinta. Para poder proveer dependencias en diferentes ambientes vamos a usar el service locator [getIt](https://pub.dev/packages/get_it) y la utilidad de [injectable](https://pub.dev/packages/injectable) para generar el arbol de dependencias a partir de anotaciones.

**Clase de configuración**

Este archivo nos va a proporcionar la información del ambiente, por ejemplo la baseURl de un servicio web o un api key.

*lib/env/env_config.dart*
```dart
import 'package:injectable/injectable.dart';

// Esta constante nos ayudara a marcar una dependencia como de desarrollo o producción
const development = Environment(Environment.dev); 
const production = Environment(Environment.prod);

// Clase que define la estructura de configuración para los ambientes
abstract class EnvConfig {
    abstract String apiKey;
    abstract String baseUrl;
}
```

**Implementación para Development y para Production**

*lib/env/*

<!-- tabs:start -->
#### **dev_env.dart**
```dart
@development // Especificamos que esta impl, solo es para development
@LazySingleton(as: EnvironmentConfig)
class DevEnvironment implements EnvironmentConfig {
  @override
  String apiKey = "dev api key";

  @override
  String baseUrl = "dev url";
}

```

#### **production_env.dart**
```dart
@production // Especificamos que esta impl, solo es para production
@LazySingleton(as: EnvironmentConfig)
class ProductionEnvironment implements EnvironmentConfig {
  @override
  String apiKey = "prod api key";

  @override
  String baseUrl = "prod url";
}

```
<!-- tabs:end -->


**Generamos el arbol de dependencias**

Configuramos el injector de la aplicación:

*lib/di/injector.dart*
```dart
final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies(String environment) => $initGetIt(
      getIt,
      environment: environment,
    );

```

En la función configureDependencies recibimos el environment para proveer las dependencias de producción o desarrollo.


**Creamos un main para Production y otro para Development**

El archivo main.dart es el archivo que inicializa la aplicación y es el que se ejecuta, vamos a segmentarlo en dos archivos, el primero donde hagamos configuraciones de la aplicación que sean comunes a todos los ambientes (app.dart) y otros que nos permitan ejecutar cada ambiente de forma independiente(main_prod.dart, main_dev.dart).

<!-- tabs:start -->
#### **app.dart**
```dart
void setupApp() { // esta funcion no debe llamarse main debido a que no se va a ejecutar directamente
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Environments',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

```

#### **main_dev.dart**
```dart
void main() {
  configureDependencies(Environment.dev); // Configuramos las dependencias de desarrollo
  setupApp();
}

```

#### **main_prod.dart**
```dart
void main() {
  configureDependencies(Environment.prod); // Configuramos las dependencias de producción
  setupApp();
}

```
<!-- tabs:end -->

?> Podriamos dejar **main_prod.dart** como solo **main.dart**, para que sea la ejecución por defecto.


**Configuración IDE y Ejecutar Environment**

Para ejecutar main_dev por consola podemos usar el siguiente comando

```
flutter run -t lib/main_dev.dart
```

Podemos configurar Android Studio para que nos salgan las dos opciones (Development, Production)

- Damos click en main a la izquierda del boton de play, y luego en edit configurations

<img src="assets/env1.png" width="400">

- Seleccionamos la configuración de main y le damos click en copiar

<img src="assets/env2.png" width="400">

- En la copia cambiamos el nombde a development y tambien el nombre del archivo

<img src="assets/env3.png" width="600">

- Si queremos tambien cambiamos el de main prodution

<img src="assets/env4.png" width="400">


### DotEnv

Muchas veces en las configuraciones de los ambientes se tienen keys o llaves que no deberian ir al repositorio, para eso podriamos usar la libreria de [envify](https://pub.dev/packages/envify) que nos permiten cargar esas configuraciones con un archivo .env y que no deberiamos agregarlo al repositorio por cuestiones de seguridad. Se podria tener una version local para hacer pruebas y una que se agregue al momento de generar la version de release que seria el definitivo.

?> Depende del proyecto o la empresa podria ser muy util usar envify, aun que la injección de dependencias cubre muchos casos de ambientes.

### Marcar los environments

En caso de que queramos diferenciar un ambiente de otro de forma visial lo podemos hacer con la libreria [flutter_flavor](https://pub.dev/packages/flutter_flavor) que agrega un banner en una de las esquinas de la aplicación y el cual lo podemos personalizar.

<img src="assets/flavor_test.png" width="400">

## Flavors
Cuando hablamos de flavors nos referimos a versiones de una aplicación que tiene features distintos, por ejemplo en una aplicación podriamos tener un codigo para un usuario normal y un codigo para un usuario premium y generar dos versiones de la misma app (normal y premium).

Un flavor implica que tenga un **identificador** de aplicación distinto es decir que podamos tener la misma app instalada pero con distintos identificadores.

Esto requiere configuración en cada app (Android y iOS) pero esta [libreria](https://pub.dev/packages/flutter_flavorizr) nos ayuda a implementar flavors sin tocar el codigo nativo.

!> Este caso es mas avanzado y no siempre se requiere, hay que analizar los requerimientos para evaluar si realmente se necesita.