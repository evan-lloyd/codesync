# codesync
Docker image for synchronization between local development and remote containers via Mutagen. Run the image with a volume linked to the host directory to sync mapped to `/alpha` within the container, and the `BETA` environment variable set to the remote host and destination path. See below for examples.

## usage
If built locally:
```
docker run --rm -it -v /path/to/local/directory:/alpha -e BETA=remote_host:/path/to/remote/directory codesync
```

If running from Docker Hub:

```
docker run --rm -it -v /path/to/local/directory:/alpha -e BETA=remote_host:/path/to/remote/directory elloyd/codesync
```

`-it` is passed so you can monitor the synchronization in the current terminal and simply control-C it when done; if you prefer to run `codesync` silently, omit the option.

### Tip for Tailscale users
I have found it useful for development to join running containers to my personal Tailnet. To connect to a remote host by Tailscale host name, you'll need to append your MagicDNS suffix, which you can look up in your shell with:

```
tailscale status --json | jq -j '.MagicDNSSuffix'
```

Combining that with `docker run`:

```
docker run --rm -it -v /path/to/local/directory:/alpha -e BETA=tailscale_host_name.$(tailscale status --json | jq -j '.MagicDNSSuffix'):/test:/path/to/remote/directory elloyd/codesync
```

## Building the image
The image can be built locally via `./build.sh`. It will get tagged `codesync`.

## Custom ignore paths
To set up custom paths to ignore, modify `.mutagen.yml` and rebuild the image. The default setup ignores some common Python cache files.
