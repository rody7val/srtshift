# srtshift

Una utilidad ligera de Bash para desplazar las marcas de tiempo de los subtítulos `.srt` hacia adelante o hacia atrás.

Ideal cuando encuentras el archivo de subtítulos correcto, pero está desfasado unos segundos.

## Características

* Desplaza los subtítulos hacia adelante (`up`) o hacia atrás (`down`).

* Admite segundos enteros y decimales.

* Conserva el archivo `.srt` original.

* Genera un nuevo archivo con la extensión `_shifted.srt`.

* Admite finales de línea de Windows (`CRLF`) y Unix (`LF`).

* Sin dependencias externas (opcional: `dos2unix` para la conversión de archivos).

## Instalación

Clonar el repositorio:

```bash
git clone https://github.com/rody7val/srtshift
cd srtshift
chmod +x srtshift.sh
```

O instalarlo en todo el sistema:

```bash
sudo cp srtshift /usr/local/bin/
sudo chmod +x /usr/local/bin/srtshift.sh
```

## Uso

Avanzar los subtítulos 2 segundos:

```bash
srtshift up 2 movie.srt
```

Retroceder los subtítulos 1,5 segundos:

```bash
srtshift down 1.5 movie.srt
```

El archivo de salida se creará como:

```text
movie_shifted.srt
```

El archivo original permanece sin cambios.

## Ejemplos

```bash
srtshift up 0.8 episode.srt
srtshift down 3.25 subtitle.srt
```

## Licencia

Licencia MIT.