# Swift Pokédex

Pokédex para iOS construida con **SwiftUI**, conectada a **PokeAPI**, diseñada como una base sólida para evolucionar hacia una enciclopedia Pokémon más completa.

La app ya permite explorar regiones, buscar Pokémon, abrir fichas detalladas, consultar evolución, shiny y formas especiales, además de recorrer gimnasios por región.

## Qué ofrece hoy

- exploración de la Pokédex nacional organizada por regiones,
- búsqueda global por nombre o número,
- fichas detalladas con arte oficial, tipos, estadísticas, debilidades y resistencias,
- descripción Pokédex en español cuando está disponible,
- cadena evolutiva navegable,
- soporte para shiny, Mega Evolución y Gigantamax,
- navegación por gestos entre Pokémon,
- sección de gimnasios con líderes, especialidades, insignias y equipos,
- interfaz localizada al español,
- mejoras de performance con caché y precarga de detalle.

## Stack

- `Swift`
- `SwiftUI`
- `Combine`
- `PokeAPI v2`
- `Xcode`

## Captura general del proyecto

La app está pensada con dos objetivos:

1. ofrecer una experiencia visual cuidada tipo Pokédex moderna,
2. mantener una base técnica lo suficientemente limpia como para crecer hacia una enciclopedia más ambiciosa.

Por eso la UI no depende directamente de la API: el acceso a datos pasa por una capa de repositorio y un cliente desacoplado.

## Arquitectura resumida

- `Views`: pantallas y componentes visuales.
- `ViewModels`: estado y coordinación de carga.
- `PokemonRepository`: fachada principal para datos Pokémon.
- `PokeAPIClient`: abstracción para el acceso a PokeAPI.
- `Models`: modelos de dominio y modelos auxiliares.

Actualmente el proyecto usa recursos de PokeAPI para:

- `pokemon`
- `pokemon-species`
- `evolution-chain`
- `type`

Y combina eso con contenido local curado para la sección de gimnasios.

## Funcionalidades destacadas

### Regiones

- listado principal desde Kanto hasta Paldea,
- navegación por región,
- grilla de Pokémon por rango regional,
- búsqueda local dentro de cada región.

### Detalle del Pokémon

- arte oficial,
- tipos en español,
- descripción Pokédex,
- estadísticas base,
- debilidades y resistencias,
- cadena evolutiva navegable,
- versión shiny,
- formas especiales,
- precarga del siguiente y anterior para mejorar la fluidez.

### Gimnasios

- regiones con listado de gimnasios,
- detalle de cada líder,
- especialidad e insignia,
- equipo Pokémon con acceso a ficha individual.

## Estado del proyecto

El proyecto ya tiene una base visual y funcional sólida, y está en una etapa ideal para seguir creciendo en tres direcciones:

- performance,
- contenido enciclopédico,
- expansión de la arquitectura de datos.

## Roadmap sugerido

- caché persistente en disco,
- integración progresiva de una librería externa detrás de `PokeAPIClient`,
- expansión hacia juegos, liga y contenido enciclopédico,
- unificación visual del resto de pantallas con el nuevo lenguaje del detalle.

## Cómo correrlo

1. Abrir `Pokedex-v1.1.xcodeproj` en Xcode.
2. Seleccionar el scheme de la app.
3. Ejecutar en Simulator o dispositivo iOS.

La app requiere conexión a internet para cargar datos remotos desde PokeAPI.

## Descripción sugerida para GitHub

Opciones cortas para la descripción del repo:

- `Pokédex en SwiftUI con regiones, evolución, shiny, formas especiales y gimnasios.`
- `SwiftUI Pokédex para iOS con PokeAPI, fichas detalladas y base lista para crecer como enciclopedia.`
- `Pokédex iOS en SwiftUI con búsqueda global, detalle avanzado y navegación por regiones.`

## Documentación técnica

Para una explicación más completa de la arquitectura, el flujo de datos y el roadmap técnico, ver:

[`DOCUMENTATION.md`](./DOCUMENTATION.md)
