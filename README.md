an instrument for organizing and filtering large sample sets

## viscis-batch

This script processes samples for use with VISCIS and other things.

##### DEPENDENCIES:

- [ffmpeg](https://ffmpeg.org/) and [ffsample-get](https://github.com/tuckerjohnson/scripts)
- [flucoma-cli](https://github.com/flucoma/flucoma-cli/releases)

##### USE:

1. copy the contents of `/bin` to your local bin

2. put all of the desired wav files into a directory and name it.

3. run `viscis-batch [your directory of wav files]`


#### OUTPUT FILE STRUCTURE:

```
  $DIR/
  ├── h-loudness/  (loudness of slices of harmonic layer)
  ├── loudness/    (loudness of slices)
  ├── p-loudness/  (loudness of slices of percusive layer)
  ├── tslices/     (transient slices)
  └── wav/         (audio files)
```

## viscis
