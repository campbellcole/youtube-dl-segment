# youtube-dl-segment

This tool allows you to download part of a youtube video without downloading the whole thing

## Dependencies

This script requires the `youtube-dl` and `ffmpeg` packages.

### Ubuntu
```console
### youtube-dl
# recommended
sudo pip install youtube-dl
# or
sudo apt install youtube-dl

### ffmpeg
sudo apt install ffmpeg
```

### NixOS

#### Using flakes

##### With direnv (ideally with direnv-nix)
```console
direnv allow
```

##### Without direnv
```console
nix develop
```

#### Using nix-shell

```console
$ nix-shell
# or
$ nix-shell shell.nix
# or
$ ./shell.sh
```

## Usage

### Show usage
```console
$ ./download.sh -h
This script allows you to download part of a youtube video.
Usage: ./download.sh [-h] <youtube url> <start time> <duration> <output file>
  -h Show this help message

<start time> and <duration> must obey the following format:
MM:SS (ex. 15:00, 00:00, 160:32)
IMPORTANT: set the <start time> to 30 seconds BEFORE you
want your snippet to start. This is to ensure a key frame
is grabbed. The 30 seconds will be trimmed off automatically

<output file> can have any extension supported by ffmpeg
```

### Download a video
```console
$ ./download.sh <youtube url> <start time> <duration> <output file>
...
```

This will download a video starting at `<start time>`.
**You must manually subtract 30 seconds from this time.**
The 30 seconds will be trimmed off automatically. It is required to ensure
a full color frame is captured so FFmpeg isn't glitchy for the first few seconds
of the video.
