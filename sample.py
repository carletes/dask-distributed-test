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
