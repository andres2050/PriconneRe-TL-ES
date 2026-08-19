# Estado de la Traducción al Español (PriconneRe-TL-ES)

Este archivo documenta en qué versión del proyecto original ([ImaterialC/PriconneRe-TL](https://github.com/ImaterialC/PriconneRe-TL)) se basan las traducciones al español, para saber qué commits nuevos hay que traducir.

---

## Versión base del upstream

| Campo | Valor |
|-------|-------|
| **Commit base del upstream** | `e4e0640b78eee57b571d16bff7dd0b356e9d13c6` |
| **Asunto del commit base** | `A` |
| **Fecha del commit base** | 2026-08-10 18:07:38 +0700 |
| **BepInEx (doorstop)** | 4.0.0 |
| **.NET runtime** | 6.0.7 |
| **Il2Cpp interop version** | 12.6.0 |
| **Assembly hash** | `374ed6680fd50b3b20705dce86f064df` |
| **Idioma de destino** | `es` (español) |
| **Idioma de origen** | `ja` (japonés) |

> **Nota:** El proyecto original usa mensajes de commit poco descriptivos (`A`, `up`, `update`, `ok`, etc.), por lo que no es fiable guiarse por el texto del commit. Usa el hash del commit como referencia principal.

---

## Cómo actualizar las traducciones cuando el upstream añada nuevos commits

### 1. Añadir el upstream como remoto (solo la primera vez)

```bash
git remote add upstream https://github.com/ImaterialC/PriconneRe-TL.git
git fetch upstream
```

### 2. Descargar los nuevos commits del upstream

```bash
git fetch upstream
```

### 3. Ver qué archivos de texto en inglés han cambiado desde el commit base

```bash
# Lista de archivos modificados/añadidos desde el commit base
git diff --name-status e4e0640b78eee57b571d16bff7dd0b356e9d13c6 upstream/master -- src/BepInEx/Translation/en/Text/

# Ver el contenido nuevo/modificado de un archivo concreto
git diff e4e0640b78eee57b571d16bff7dd0b356e9d13c6 upstream/master -- "src/BepInEx/Translation/en/Text/<archivo>"
```

### 4. Traducir solo los archivos nuevos/modificados

Copia los archivos nuevos de `en/Text/` a `es/Text/` y traduce el lado derecho (inglés → español), manteniendo intacta la clave japonesa (lado izquierdo de `=`).

### 5. Actualizar el commit base en este archivo

Una vez traducidos los nuevos cambios, actualiza el campo **Commit base del upstream** con el hash del último commit de `upstream/master` que hayas integrado.

```bash
# Obtener el hash del último commit del upstream
git rev-parse upstream/master
```

---

## Progreso de la traducción

| Carpeta / Archivo | Estado | Notas |
|-------------------|--------|-------|
| `Text/` (archivos raíz, 61 archivos) | ✅ Completado | Toda la UI principal del juego |
| `Text/Beginner/` | ✅ Completado | |
| `Text/System/` | ✅ Completado | System, Error codes, Update |
| `Text/Dimension/` | ✅ Completado | Dimension, Boss, Mission, Prolog |
| `Text/Settings/` | ✅ Completado | 19 archivos |
| `Text/Caravan/` | ✅ Completado | 5 archivos |
| `Text/MiniGames/` | ✅ Completado | 5 archivos |
| `Text/Mission/` | ✅ Completado | 6 archivos |
| `Text/PrincessKnight/` | ✅ Completado | 8 archivos |
| `Text/Adventure/` | ✅ Completado | 7 archivos |
| `Text/Album/` | ✅ Completado | 5 archivos |
| `Text/Tutorial/` | ✅ Completado | 24 archivos (movidos a `Story/Tutorial/`) |
| `Text/Item/` | ✅ Completado | 10 archivos |
| `Text/Enemy/` | ⏳ Pendiente | |
| `Text/GuildHouse/` | ⏳ Pendiente | |
| `Text/Ex Equip/` | ✅ Completado | 4 archivos |
| `Text/Abyss Battle/` | ✅ Completado | 1 archivo |
| `Text/DawnLabyrinth/` | ✅ Completado | 6 archivos |
| `Text/Home Screen/` | ⏳ Pendiente | |
| `Text/Character/` | ⏳ Pendiente | 352 archivos |
| `Text/Event/` | ⏳ Pendiente | 389 archivos |
| `Text/Story/` | ⏳ Pendiente | Contiene `Tutorial/` (✅) y `Seasonal/` (⏳ Pendiente) |

---

## Convenciones de traducción

- **Clave japonesa intacta**: el lado izquierdo de `=` es la clave de búsqueda de AutoTranslator y no debe modificarse.
- **Términos del juego**:
  - ジュエル → Joyas
  - マナ → Mana
  - スタミナ → Resistencia
  - クエスト → Misión
  - ダンジョン → Mazmorra
  - ガチャ → Gacha
  - クラン → Clan
  - バトルアリーナ → Arena de Batalla
  - プリンセスアリーナ → Arena de Princesa
  - メモリーピース → Fragmento de Memoria
  - 女神の秘石 → Amuletos Divinos
  - 専用装備 → Equipo Único (EU)
  - 才能開花 → Ascensión
  - 限界突破 → Romper Límite
  - ランクアップ → Subir de Rango
- **Nombres propios** de personajes se mantienen (Pecorine, Kokkoro, Kyaru, etc.).
- **Códigos de color** (`[FFBB00,CE4F00]`, etc.) y **patrones regex** (`r:"..."=`, `sr:"..."=`) se preservan exactamente.
- **Archivos técnicos** (resizer, font) se copian sin cambios (solo rutas de UI).