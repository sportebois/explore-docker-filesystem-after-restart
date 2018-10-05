# Docker filesystem overlay state after a restart

What happens to filesystem overlay when a container is automatically restarted?
Do you get a fresh clean new filesystem, or are the previous (temporary?) files still available from the code you run in the container?

The easiest way to make sure is to test it for real. (See the [spoiler section](#Spoiler) below for the answer)

## Test methodology

We'll create a small container which create new file, sleep and exits with an error.
Then we'll run it with the `restart-always` flag and see if the restarted container gets a fresh filesystem or gets back the previous one.

## Build it

    docker build . -t testfs

## Run it

    docker run -d --restart=always --name=testfs testfs

## Check the logs to see what the container sees

    docker logs -f testfs

## Clean it

`docker rm $(docker kill testfs)` will remove everything.

## Spoiler

The previous filesystem is restored:

After a few automatic restarts, here are the logs:

```
$ docker logs -f testfs
20181005_150739Z.tmp
command.sh
20181005_150739Z.tmp
20181005_150744Z.tmp
command.sh
20181005_150739Z.tmp
20181005_150744Z.tmp
20181005_150750Z.tmp
command.sh
20181005_150739Z.tmp
20181005_150744Z.tmp
20181005_150750Z.tmp
20181005_150756Z.tmp
command.sh
20181005_150739Z.tmp
20181005_150744Z.tmp
20181005_150750Z.tmp
20181005_150756Z.tmp
20181005_150802Z.tmp
command.sh
20181005_150739Z.tmp
20181005_150744Z.tmp
20181005_150750Z.tmp
20181005_150756Z.tmp
20181005_150802Z.tmp
20181005_150809Z.tmp
command.sh
20181005_150739Z.tmp
20181005_150744Z.tmp
20181005_150750Z.tmp
20181005_150756Z.tmp
20181005_150802Z.tmp
20181005_150809Z.tmp
20181005_150818Z.tmp
command.sh
20181005_150739Z.tmp
20181005_150744Z.tmp
20181005_150750Z.tmp
20181005_150756Z.tmp
20181005_150802Z.tmp
20181005_150809Z.tmp
20181005_150818Z.tmp
20181005_150830Z.tmp
command.sh
20181005_150739Z.tmp
20181005_150744Z.tmp
20181005_150750Z.tmp
20181005_150756Z.tmp
20181005_150802Z.tmp
20181005_150809Z.tmp
20181005_150818Z.tmp
20181005_150830Z.tmp
20181005_150848Z.tmp
command.sh
20181005_150739Z.tmp
20181005_150744Z.tmp
20181005_150750Z.tmp
20181005_150756Z.tmp
20181005_150802Z.tmp
20181005_150809Z.tmp
20181005_150818Z.tmp
20181005_150830Z.tmp
20181005_150848Z.tmp
20181005_150919Z.tmp
command.sh
20181005_150739Z.tmp
20181005_150744Z.tmp
20181005_150750Z.tmp
20181005_150756Z.tmp
20181005_150802Z.tmp
20181005_150809Z.tmp
20181005_150818Z.tmp
20181005_150830Z.tmp
20181005_150848Z.tmp
20181005_150919Z.tmp
20181005_151016Z.tmp
command.sh
20181005_150739Z.tmp
20181005_150744Z.tmp
20181005_150750Z.tmp
20181005_150756Z.tmp
20181005_150802Z.tmp
20181005_150809Z.tmp
20181005_150818Z.tmp
20181005_150830Z.tmp
20181005_150848Z.tmp
20181005_150919Z.tmp
20181005_151016Z.tmp
20181005_151121Z.tmp
command.sh
20181005_150739Z.tmp
20181005_150744Z.tmp
20181005_150750Z.tmp
20181005_150756Z.tmp
20181005_150802Z.tmp
20181005_150809Z.tmp
20181005_150818Z.tmp
20181005_150830Z.tmp
20181005_150848Z.tmp
20181005_150919Z.tmp
20181005_151016Z.tmp
20181005_151121Z.tmp
20181005_151227Z.tmp
command.sh
```

You got the idea... ;-)
