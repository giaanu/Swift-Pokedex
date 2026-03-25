# Documentación Técnica

## Visión general

Swift Pokédex es una app iOS en SwiftUI orientada a consulta y exploración de datos Pokémon. El objetivo no es sólo mostrar fichas básicas, sino construir una base que pueda evolucionar hacia una enciclopedia más completa para acompañar y complementar los juegos.

El proyecto ya integra datos remotos de PokeAPI con contenido local curado, y fue reorganizado para que la UI no dependa directamente de la implementación de red.

## Objetivos técnicos actuales

- mantener una arquitectura simple pero extensible,
- desacoplar infraestructura y UI,
- reducir requests repetidos,
- preparar el proyecto para crecer sin reescribir pantallas,
- sostener una experiencia de navegación fluida en detalle.

## Módulos principales

### `App/`

- punto de entrada de la app,
- `ContentView` monta el `NavigationStack`,
- contiene splash inicial antes de entrar a la pantalla principal.

### `Core/`

Infraestructura compartida.

#### `Core/Networking`

- `PokemonRepository`: fachada principal de datos.
- `PokeAPIClient`: protocolo de acceso a la API.
- `NativePokeAPIClient`: implementación actual basada en `URLSession`.

Rol:

- centralizar cargas,
- aplicar caché en memoria,
- componer datos de múltiples endpoints,
- dejar preparada una futura integración con una librería externa sin romper la UI.

#### `Core/Models`

Modelos de dominio y modelos auxiliares:

- `Pokemon`
- `PokemonSupplementalData`
- `PokemonTypeRelations`
- `Region`

#### `Core/DesignSystem`

Tokens y componentes reutilizables:

- colores,
- tipografías,
- spacing,
- cards,
- chips,
- background general.

#### `Core/Extensions`

Helpers de presentación y formato, por ejemplo:

- traducción visual de tipos y stats,
- utilidades de formato.

### `Features/`

Organización por feature.

#### `Features/Regions`

- listado principal de regiones,
- carga del índice global de Pokémon,
- detalle por región con grilla de Pokémon.

#### `Features/PokemonDetail`

- ficha principal del Pokémon,
- estadísticas,
- debilidades y resistencias,
- descripción Pokédex,
- evolución,
- formas especiales,
- navegación entre fichas.

#### `Features/PokemonSearch`

- búsqueda puntual de Pokémon,
- reutiliza el repositorio para no duplicar lógica de acceso a datos.

#### `Features/Gyms`

- sección local de gimnasios,
- regiones de gimnasios,
- líderes y equipos,
- acceso al detalle individual de los Pokémon del equipo.

## Flujo de datos

### Carga de Pokémon

1. La vista solicita datos a un `ViewModel`.
2. El `ViewModel` delega en `PokemonRepository`.
3. `PokemonRepository` usa `PokeAPIClient`.
4. El cliente resuelve la llamada remota.
5. El repositorio transforma, completa y cachea datos.
6. La vista renderiza modelos propios de la app.

## Endpoints usados

Actualmente se consumen estos recursos de PokeAPI:

- `pokemon`
- `pokemon-species`
- `evolution-chain`
- `type`

### Qué se obtiene de cada uno

- `pokemon`: id, nombre, tipos, stats, sprites, species.
- `pokemon-species`: flavor text, variedades, evolution chain.
- `evolution-chain`: orden de la línea evolutiva.
- `type`: relaciones de daño para debilidades y resistencias.

## Caché y performance

Hoy existe caché en memoria para:

- índice global de Pokémon,
- Pokémon por ID,
- datos suplementarios del detalle,
- relaciones de daño por tipo.

Además:

- el detalle resuelve sus datos en una sola coordinación,
- se cargan en paralelo relaciones de daño y datos suplementarios,
- se precargan el Pokémon anterior y siguiente para mejorar la navegación por swipe,
- la búsqueda global reutiliza el repositorio y evita fetches duplicados.

## Contenido local

No todo proviene de PokeAPI.

La sección de gimnasios usa datos definidos dentro del proyecto para modelar:

- región,
- gimnasio,
- líder,
- especialidad,
- insignia,
- equipo Pokémon.

Esto es importante porque PokeAPI no expone de forma completa equipos de líderes, Alto Mando o estructuras de juego al nivel que la app necesita para una futura enciclopedia.

## Localización actual

La app está orientada al español.

Ya se localizan:

- títulos principales del detalle,
- descripción Pokédex cuando existe entrada en español,
- nombres de tipos,
- nombres de estadísticas,
- varios labels de navegación y secciones.

Pendiente:

- revisar y unificar textos residuales en otras vistas para evitar mezclas entre inglés y español.

## Diseño actual

La pantalla de detalle fue evolucionada hacia una línea más editorial:

- fondo cálido con overlays técnicos,
- ficha principal protagonista,
- cards translúcidas,
- badges y paneles más legibles,
- mejor jerarquía visual.

Esto sirve como referencia para extender el mismo lenguaje al resto de la app.

## Decisiones de arquitectura importantes

### 1. Mantener modelos propios

La app usa modelos internos en vez de exponer directamente modelos de una librería externa.

Beneficios:

- menor acoplamiento,
- más control sobre la UI,
- migraciones futuras menos riesgosas.

### 2. Repositorio como fachada

`PokemonRepository` centraliza la lógica que hoy resuelve:

- fetch base,
- composición de species/evolution/forms,
- caché,
- precarga.

Beneficios:

- la UI se mantiene más limpia,
- el cambio de backend de datos es más simple,
- la lógica queda en un solo punto.

### 3. Cliente desacoplado

`PokeAPIClient` existe para permitir una futura integración de una librería como `PokemonAPI` sin reescribir la app.

Camino sugerido:

- conservar `PokemonRepository`,
- agregar otra implementación del cliente,
- migrar endpoint por endpoint.

## Próximos pasos recomendados

### Corto plazo

- caché persistente en disco,
- revisión de textos residuales,
- extender el nuevo lenguaje visual a `Stats`, `Regions` y `Search`.

### Mediano plazo

- integrar una implementación alternativa de `PokeAPIClient`,
- separar mejor datos core de datos enciclopédicos,
- preparar una capa `GameContentRepository`.

### Largo plazo

- sección de juegos,
- gimnasios por versión,
- Alto Mando y campeones,
- equipos por juego,
- información enciclopédica más amplia.

## Convenciones útiles para seguir trabajando

- mantener la UI separada de la infraestructura,
- no acoplar vistas a clientes de red,
- agregar nuevas integraciones detrás del repositorio o del cliente abstracto,
- priorizar cambios incrementales por branch,
- validar cada bloque importante con `xcodebuild`.

## Resumen

Hoy el proyecto ya no es sólo una Pokédex básica. Tiene:

- una base visual reconocible,
- una capa de datos más preparada para crecer,
- mejoras reales de performance,
- localización parcial al español,
- y un camino técnico claro para evolucionar hacia una enciclopedia Pokémon más completa.
