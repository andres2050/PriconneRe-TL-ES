# Estado de la Traducción al Español (PriconneRe-TL-ES)

Este archivo documenta en qué versión del proyecto original ([ImaterialC/PriconneRe-TL](https://github.com/ImaterialC/PriconneRe-TL)) se basan las traducciones al español, para saber qué commits nuevos hay que traducir.

---

## Versión base del upstream

| Campo | Valor |
|-------|-------|
| **Commit base del upstream** | `66eb6f9812b327a398ef56b2c39414139bf7ce4b` |
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
git diff --name-status 66eb6f9812b327a398ef56b2c39414139bf7ce4b upstream/master -- src/BepInEx/Translation/en/Text/

# Ver el contenido nuevo/modificado de un archivo concreto
git diff 66eb6f9812b327a398ef56b2c39414139bf7ce4b upstream/master -- "src/BepInEx/Translation/en/Text/<archivo>"
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
| `Text/Enemy/` | ⏳ Pendiente | 15 archivos |
| `Text/GuildHouse/` | ⏳ Pendiente | 37 archivos |
| `Text/Ex Equip/` | ✅ Completado | 4 archivos |
| `Text/Abyss Battle/` | ✅ Completado | 1 archivo |
| `Text/DawnLabyrinth/` | ✅ Completado | 6 archivos |
| `Text/Home Screen/` | ⏳ Pendiente | 208 archivos |
| `Text/Character/` | ⏳ Pendiente | 353 archivos |
| `Text/Event/` | ⏳ Pendiente | 389 archivos |
| `Text/Story/` | ⏳ Pendiente | 587 archivos (contiene `Tutorial/` ✅ y `Seasonal/` ⏳) |

---

## Desglose de carpetas grandes

### `Text/Character/` — 353 archivos (sin subcarpetas)
Todos los archivos están directamente en la carpeta (uno por personaje).

### `Text/Event/` — 389 archivos
- **25 archivos directos** + **364 en subcarpetas** numeradas (1, 15, 24, 27, 29, 31, 36, 37, 47–101, etc.) + `ZombieLand Raid/` (2).
- Subcarpetas más grandes: `71/` (33), `83/` (18), `62/` (15), `74/` (13), `76/` (13), `64/` (13), `65/` (13), `75/` (12), `63/` (12), `51/` (12), `37/` (11), `67/` (11), `70/` (10).

### `Text/Story/` — 587 archivos
| Subcarpeta | Archivos |
|------------|----------|
| `Character/` | 245 |
| `Seasonal/` | 136 |
| `3_/` | 93 |
| `2_/` | 19 |
| `Quest/` | 17 |
| `3rd anni/` | 16 |
| `Tutorial/` | 24 ✅ |
| `Tower of Luna/` | 11 |
| `Dungeon/` | 4 |
| `Alces Atelier/` | 3 |
| `Guild/` | 1 |

### `Text/Enemy/` — 15 archivos
- **10 directos**: `AscendTrial`, `BossDesc`, `CBBoss`, `ChadYuuki`, `EnemySkillDesc`, `Mobs`, `MobsRegex`, `ShadowRegex`, `ShadowUncatagorized`, `TrialRoom`.
- **`Dungeon/`** (5): `Dungeon`, `Ex5`, `Ex6`, `Ex7`, `Ex7MiniBoss`.

### `Text/GuildHouse/` — 37 archivos
- **23 directos** (diálogos de personajes en la casa del gremio, muebles, BGM, etc.).
- **`Birthday/`** (3): `1103`, `djeeta2023`, `others`.
- **`Game Table/`** (11): minijuegos de mesa (Carmina Summer Live, Dash to Eternal Summer, Kaoris Soulful Dojo, etc.).

### `Text/Home Screen/` — 208 archivos (sin subcarpetas)

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