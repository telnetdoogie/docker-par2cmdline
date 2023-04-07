# docker-par2cmdline
Run par from par2cmdline tools in a Docker image

## usage:
```bash
docker run -v {path to local par files}:/par2_files {par2 commands}
```

## example:
```bash
docker run -v /volume1/media/downloads/broken/:/par2_files repair broken_file.par
```
