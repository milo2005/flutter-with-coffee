# Navegación V2

Estas notas son para explorar la **Navegación V2** que se deberia usar en los proyectos nuevos y sobre todo los que quieran dar soporte a Web.

?> En este [enlace](https://github.com/milo2005/flutter-with-coffee/tree/master/examples/navigationv2) se encuentra un ejemplo con todas las features de la navegación v2 con [Go Router](https://pub.dev/packages/go_router), que es la libreria oficial de flutter para la nueva navegación.

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


## Navegación V2 - Go Router

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

*lib/app_router.dart*
```dart
final appRouter = GoRouter(
  routes: [],
);

```

**- Agregamos las rutas a Material App**

*lib/main.dart*
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

*lib/app_router.dart*
```dart

final appRouter = GoRouter(
  initialLocation: "/", // Podemos especificar la ruta inicial
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path:"/home",
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path:"/home/notifications",
      builder: (context, state) => NotificationsPage(),
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

Podemos organizar las rutas en jerarquias, esto es util cuando queremos organizar las rutas de un mismo feature y tambien tiene un comportamiento cuando usamos **go** en lugar **push**.

*lib/app_router.dart*
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

La ruta principal seria `/products` pero tendria dos sub rutas `add` y `:id` es decir que para navegar a **AddProductPage** debemos usar la ruta `/products/add`.

?> El uso de sub rutas tiene un comportamiento diferente cuando se usa **go** en lugar de **push**, para mas detalle en esta [sección](ui/navigation2?id=navegacion-entre-pantallas).


### Envio de datos en el path

Cuando definimos una ruta con **GoRoute** podemos enviar datos en el path o como query params

*lib/app_router.dart*
```dart
final appRouter = GoRouter(
  // ...
  routes: [
    GoRoute(
      path: "/movies"
      builder: (context, state) {
        final sort = state.queryParams["sort"] ?? "descending"; // 1
        return ListMoviePage(sortBy: sort);
      }
    ),
    GoRoute(
      path: "/movies/:idMovie",
      builder: (context, state){
        final id = state.params["idMovie"]; // 2
        return DetailMovie(id: id);
      }
    ),
  ]
);
```

A travez de **state** podemos obtener la información de la ruta y los datos, como por ejemplo en:

1. Asumimos que puede llegar un query param llamado **sort**, por lo que lo podemos obtener con la propiedad **queryParams**.

`/movies?sort=ascending`

2. El path tiene un campo dinamico **idMovie**, eso quiere decir que idMovie puede tomar cualquier valor, lo obtenemos mediante la propiedd **params**.

`/movies/123`

### Redirecciones

Go router nos permite redireccionar a otras rutas, estas redireciones pueden estar ubicadas a nivel de router general o de cada ruta por ejemplo:

*lib/app_router.dart*
```dart
final appRouter = GoRouter(
  // ...
  routes: [
    GoRoute(
      path: "/",
      redirect: (ctx, state) => "/home", // 1
    ),
    GoRoute(
      path: "/home",
      builder: (ctx, state)=> LoginPage(),  
    ),
    GoRoute(
      path: "/login",
      builder: (ctx, state)=> LoginPage(),      
    ),
  ],
  redirect: (ctx, state) { // 2
    final path = state.location;
    final isLoggedUC = getIt<IsLoggedUseCase>();

    if(path == "/login" || isLoggedUC()) {
      return null;
    }

    return "/login";
  }
)
```
1. Aqui hacemos un redirección a nivel de ruta, es decir si navegamos hacia `/`, go router va a redirigir hacia `/home`;
2. Aqui hacemos una redirección a nivel del router es decir va a aplicar a todas las rutas:
- Obtenemos el path actual
- Obtenemos un servicio o un use case que nos indique si el usuario ha iniciado sesion o no
- Verificamos si la ruta es `/login` o si el usuario esta logeado, en ese casos e retorna un **null** para indicarle al router que no se debe redireccionar a otra ruta, por lo que continua con la ruta anterior.
- Si no esta logeado retornamos `/login` para que el usuario pueda iniciar sesion.

### Rutas anidadas

Cuando hablamos de rutas anidadas nos referimos a navegación que se pueda dar dentro de un [BottomNavigation](https://m2.material.io/components/bottom-navigation), un ejemplo de aplicación es Instagram que tiene una navegación con este tipo.

!> Go router (v 5.1.1) tiene un componente para implementar este tipo de navegación llamado **ShellRouter** pero al dia de hoy parece que solo funciona con la navegación a travez de **go**, por lo que tiene mal comportamiento cuando se usa un **push**, por lo que si necesita este tipo de navegación se recomienda hacerlo [manualmente]() o con la libreria [breamer](https://pub.dev/packages/beamer).


### Ordenar Rutas

Cuando la aplicación crezca va ser mas complicado mantener todas las rutas en un solo archivo como **app_router.dart**, por lo que puede ser util segmentarlo segun features, por ejemplo algunas ideas:

<!-- tabs:start -->
#### **lib/app_router.dart**
```dart
final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    ...mainRoutes, // 1
    productRoutes  // 2
  ]  
);
```

1. Debido a que main routes es un array podemos agregarlo con el operador spread
2. productRoutes solo es un objeto de GoRouter por lo que lo agregamos directamente

#### **lib/products/products_router.dart**

```dart
final productRoutes = GoRoute(
  path: "/products"
  builder: (ctx, state) => ListProductPage(),
  routes: [
    GoRoute(
      path: "add",
      builder: (ctx, state) => const AddProductPage(),
    ),
  ]
);
```

#### **lib/home/home_router.dart**

```dart
final List<GoRoute> mainRoutes = [
  GoRoute(
    path: "/"
    redirect: (ctx, state) => "/home" // 1
  ),
  GoRoute(
    path: "/home"
    builder: (ctx, state) => HomePage(),    
  ),
  GoRoute(
    path: "/home/profile"
    builder: (ctx, state) => ProfilePage(),    
  )
];
```

1. Cuando se lance el path `/` se va a redirigir a `/home` y se va a cargar HomePage.

<!-- tabs:end -->



### Navegacion entre pantallas

Para navegar entre pantallas podemos hacerlo de la siguiente manera:

```dart
GoRoter.of(context).push("/path");
```

La libreria nos proporciona extensiones para que la navegación se haga mas sencilla:

```dart
context.path("/path");
```

Los metodos disponibles para navegar son los siguientes:

| Metodo | Descripción |
|--------|-------------|
|push| Agrega una nueva pantalla al stack, es decir navegamos hacia adelante |
|pop| Quita una pantalla del stack es decir retorcedemos a la pantalla anterior |
|replace| Hace lo mismo que un push solo que quita la pantalla actual |
|go|Es una version declarativa del push, podriamos hacer la analogia de escribir una url en un navegador, lo que hace es eliminar todo el stack actual (Todas las pantallas abiertas) y abre un nuevo stack|

Para aclarar mas el comportamiento de **go**, cuando tenemos [rutas hijas]() abrimos todo el stack, es decir si navegamos hacia `/products/add` estariamos borrando todas las pantallas actuales y quedarian abiertas las pantallas [ListProductPage, AddProductPage].
