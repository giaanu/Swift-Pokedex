# 📕 Pokédex – SwiftUI + PokéAPI

Desarrollada en **SwiftUI**, consumiendo datos en tiempo real desde la **PokéAPI**, con una interfaz inspirada visualmente en la Pokédex del anime y los juegos clásicos.

El proyecto está en desarrollo activo y prioriza una arquitectura clara, reutilizable y una experiencia visual cuidada.

---

## 🚀 Funcionalidades actuales

### 🗺️ Navegación por regiones
- Lista inicial con **tarjetas de regiones Pokémon**.
- Cada región contiene los Pokémon correspondientes según su rango de Pokédex.
- Diseño con **estética Pokédex**, fondo personalizado y scroll recortado alineado a la interfaz.

### 🧩 Listado de Pokémon por región
- Grid con **3 Pokémon por fila**.
- Cada tarjeta muestra:
  - Imagen oficial
  - Nombre
- Carga dinámica desde PokéAPI.
- Scroll optimizado para integrarse visualmente con el fondo.

### 🔍 Búsqueda de Pokémon
- Búsqueda por **nombre o número**.
- Normalización del input del usuario.
- Resultados en tiempo real desde la API.

### 📄 Detalle del Pokémon
Vista dividida en **dos pantallas deslizables**:

#### 📸 Información general
- Imagen oficial
- Nombre
- Número
- Tipos (con colores reales)

#### 📊 Estadísticas y combate
- Stats base animadas (HP, Ataque, Defensa, etc.)
- Debilidades
- Resistencias
- Visualización clara y alineada con el fondo Pokédex
- Chips dinámicos y animados

### 🔙 Navegación
- Botón de volver visible y funcional en todas las pantallas
- Navegación basada en `NavigationStack`
- Arquitectura preparada para navegación avanzada (siguiente/anterior Pokémon)

## 📷 Capturas
Pantalla inicial:

<img width="472" height="1055" alt="image" src="https://github.com/user-attachments/assets/56e80ecc-4398-41e6-9080-dd59c3a521e5" />


Vista de Region (Kanto):


<img width="472" height="1055" alt="image" src="https://github.com/user-attachments/assets/e7c4743a-f7d5-4718-8611-cb46e0d75159" />


Vista de detalle del pokemon:

<img width="472" height="1055" alt="image" src="https://github.com/user-attachments/assets/c81d71f9-518b-4ce3-9ad9-2c13d2b1811f" />


---

## 🧱 Arquitectura

- **SwiftUI**
- **MVVM**
- `ViewModels` separados por responsabilidad:
  - Pokémon individual
  - Pokémon por región
  - Detalle y estadísticas
- Componentes reutilizables:
  - Cards
  - Chips
  - Secciones
  - Barras de stats
- Fondo Pokédex reutilizable (`PokedexBackground`)

---

## 🛠️ Tecnologías utilizadas

- Swift 5
- SwiftUI
- Combine
- PokéAPI (https://pokeapi.co)
- Async/Await

---

## 🔮 Próximas mejoras (Roadmap)

- 🎮 Navegación avanzada tipo Pokédex:
  - Swipe arriba/abajo → Pokémon anterior / siguiente
  - Swipe izquierda/derecha → cambio de pantalla
- 🏟️ Sección de **Gimnasios Pokémon**
  - Gimnasios por región
  - Líderes de gimnasio
  - Pokémon de cada entrenador
- ⚡ Optimización de carga (cache y requests paralelos)
- 🎨 Más animaciones y feedback visual
- 🔊 Sonidos clásicos de Pokédex

---

## 📌 Estado del proyecto

🟢 **En desarrollo activo**  
La base funcional y visual ya está completa.  
Las próximas versiones se enfocarán en **navegación avanzada** y **contenido de entrenadores y gimnasios**.

---

## ▶️ Cómo ejecutar el proyecto

1. Clonar el repositorio:
  git clone https://github.com/giaanu/Swift-Pokedex.git
2. Abrir el proyecto en Xcode
3. Seleccionar el simulador deseado o el dispositivo fisico.
4. Ejecutar la aplicación

---

## 👨‍💻 Autor

Gianluca Zarrelli
Estudiante de Desarrollo de Software

📍 Buenos Aires, Argentina
🔗 https://www.linkedin.com/in/gianlucazarrelli/

Proyecto personal para aprendizaje y exploración de SwiftUI, arquitectura y diseño de interfaces complejas.

---
