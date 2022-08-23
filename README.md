an instrument for organizing and filtering large sample sets



## viscis-batch

This script processes samples for use with VISCIS and other things.


##### DEPENDENCIES:

- fd
- ffmpeg
- ffsample-get (https://github.com/tuckerjohnson/scripts)
- flucoma-cli


##### EXPECTED FILE STRUCTURE:

```
 "COPRUSNAME"/
  └── wav/   <-(WAV FILES GO HERE)
```

###### USE:

1. copy `/bin` to your local bin

2. while in "CORPUSNAME" directory run `viscis-batch`


##### OUTPUT FILE STRUCTURE:

```
 "COPRUSNAME"/
  ├── h-loudness/  (loudness of slices of harmonic layer)
  ├── loudness/    (loudness of slices)
  ├── p-loudness/  (loudness of slices of percusive layer)
  ├── tslices/     (transient slices)
  └── wav/         (audio files)
```
