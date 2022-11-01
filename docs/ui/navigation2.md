# Navegación V2

Estas notas son para explorar la **Navegación V2** que se deberia usar en los proyectos nuevos y sobre todo los que quieran dar soporte a Web.

?> En este [enlace]() se encuentra un ejemplo con todas las features de la navegación v2 con [Go Router](), que es la libreria oficial de flutter para la nueva navegación.

## Navegación V1

La navegación v1 (Navigator) se encuentra disponible desde el inicio de Flutter y nos permite navegar entre el stack de pantallas con las funciones **push** y **pop**, como en el siguiente ejemplo:

*Configuración de Rutas*
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation V1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Realizamos la configuración de las rutas
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "/add": (context) => AddProductPage(),
        "/detail": (context) => DetailProductPage()
      }
    );
  }
}
```

Si deseamos navegar hacia adelante

```dart
Navigator.pushNamed(context, "/add");
```

Si deseamos retroceder

```dart
Navigator.pop(context);
```

### Limitantes y Problemas

La navegación V1 fue diseñada para aplicaciones moviles donde el stack suele ser mas lineal pero no para otras plataformas, por lo que tenemos los siguientes limitantes:

**- Las rutas tienes nombres fijos no dinamicos**

Esto es un problema pensando en la plataforma Web, por ejemplo nosotros podemos configurar las rutas con el path:

`/detail`

Pero este path no nos proporciona información de cual item o producto queremos el detalle, si estuvieramos en una aplicación podemos abrir un link directamente en el contenido que nos interesa por ejemplo, en el detalle del producto cuyo id sea 123

`/detail/123`

El anterior path contiene información del producto que se va a mostrar por lo que la aplicación web sabe que contenido debe cargar, pero en la navegación V1 esto no es posible de especificar debido a que cada ruta es fija o puede tener secciones variables como el identificador.

**- Las Rutas no soportan datos**

Las rutas no pueden contener información dinamica como query params o secciones del path como se mostro en el ejemplo anterior, lo que limita la navegación en otras plataformas diferentes a Mobile.

**- Las rutas no soporta navegación anidada**

Supongamos que nuestra aplicación navega hacia `/home` y en esa pantalla tenemos un [bottom navigation](https://m2.material.io/components/bottom-navigation) con tres secciones, es decir que ademas de navegar a la pantalla de Home podriamos navegar a cualquiera de esas secciones.

La navegación v1 no permite especificar rutas para ir a una seccion en particular de la pantalla de Home, como podria ser `/home/profile`

!> Por las limitaciones mencionadas anteriormente se debe utilizar la navegación V2 para todos los proyectos.


## Navegación V2

La navegación v2 nos da mucha mas flexibilidad para navegar entre pantallas, entre las caracteristicas mas importantes:

- Permite especificar rutas de navegación con datos, es decir paths dinamicos y query parameters, ejemplo `/detail/:id?sort=desc`, donde `:id` puede tomar cualquier valor.

- Soporta navegación anidada con [ShellRoute](https://pub.dev/documentation/go_router/latest/go_router/ShellRoute-class.html)

- Permite hacer redirecciones en caso de que no se cumplan ciertas condiciones, como por ejemplo haber iniciado sesión.

- Permite agregar una pantalla de error cuando la ruta a navegar no exista.

Estos son los pasos para configurar **Go Router**:

### Configuración Go Router

**- Instalamos la dependencia de Go Router**

Ejecutamos el siguiente comando en consola

```
flutter pub add go_router
```

**- Creamos un archivo donde vamos a tener todas nuestras rutas**

Podemos crear un archivo para organizar toda la logica de navegación:

`lib/app_router.dart`
```dart

final appRouter = GoRouter(
  routes: [],
);

```

**- Agregamos las rutas a Material App**

`lib/main.dart`
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router( // 1
      title: 'Environments',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: appRouter, // 2
    );
  }
}
```

En **1** creamos el MaterialApp con el factory **router** que nos va a permitir usar go router.

En **2** agregamos nuestro **GoRouter** en la app.


### Adicionar Rutas

Para agregar rutas lo hacemos a traves de la clase **GoRoute**

`lib/app_router.dart`
```dart

final appRouter = GoRouter(
  initialLocation: "/", // Podemos especificar la ruta inicial
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path:"/add",
      builder: (context, state) => AddProductPage(),
    ),
    GoRoute(
      path:"/detail/:id",
      builder: (context, state) => DetailProductPage(),
    ),
  ],
);

```
La propiedad **builder** de GoRoute nos proporciona el contexto y el state, el **state** contiene la información de la ruta como puede ser los valores dinamicos como `:id` o los query params.


### Rutas Hijas

Podemos organizar las rutas en jerarquias, esto es util cuando queremos organizar las rutas de un mismo feature

`lib/app_router.dart`
```dart

final appRouter = GoRouter(
  initialLocation: "/", // Podemos especificar la ruta inicial
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path:"/products",
      builder: (context, state) => ListProductPage(),
      routes: [
        GoRoute(
          path:"/add",
          builder: (context, state) => AddProductPage(),
        ),
        GoRoute(
          path:"/:id",
          builder: (context, state) => DetailProductPage(),
        ),
      ]
    ),
    
  ],
);

```




### Envio de datos en el path



### Rutas anidadas

!> en la version **5.1.1** de go_router no es posible usar ShellRouter

### Navegación entre pantallas