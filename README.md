# A simple Dask distributed setup

This repository hosts a container-based Dask distributed setup.


## Requisites

You'll need:

* Docker Compose (tested with version 1.22)


## Running

First build the container images:

```
$ ./build
```

Then start the containers:


```
$ ./docker-compose up -d
```

The Dask dashboard is now available at http://localhost/dask/status,
and the Dask scheduler lis available on port 8786.


# Using the scheduler

The file [sample.py](./sample.py) shows a simple
```
import argparse
import sys

from distributed import Client


def inc(x):
    return x + 1


def main():
    p = argparse.ArgumentParser()
    p.add_argument('scheduler')

    args = p.parse_args()
    c = Client(args.scheduler)

    lst = c.map(inc, range(1000))
    total = c.submit(sum, lst)
    print('total: ', total)

    total = c.gather(total)
    print('total (gathered): ', total)


if __name__ == '__main__':
    sys.exit(main())
```

You may run it using the wrapper script [run-client](./run-client),
which runs it in a container with the right versions of Dask and
connected to the Docker Compose setup you started before:

```
$ ./run-client python sample.py scheduler:8786
total:  <Future: status: pending, key: sum-794beb922aa77a2f165cbf69307e290b>
total (gathered):  500500
$
```
