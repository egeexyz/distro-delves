#!/bin/env python3

import click
import psutil
import shutil
import logging


logging.basicConfig(format='%(levelname)s: %(message)s', level=logging.DEBUG)


class QueryManager:
    def __init__(self):
        self.disk_usage = shutil.disk_usage("/").used
        self.swap = psutil.swap_memory()

    def run(self):
        logging.info(f"Swap Size: {self.format_bytes(self.swap.total)}")
        logging.info(f"Total Disk Usage: {self.format_bytes(self.disk_usage)}")

    def format_bytes(self, bytes, type="gb"):
        if type == "gb":
            return f"{format(int(bytes) / 1073741824, '.2f')}G"
        elif type == "mb":
            return f"{format(int(bytes) / 1024, '.2f')}M"
        else:
            print("ERROR: Unknown format type.")
            exit(1)


@click.group()
@click.pass_context
def cli(ctx):
    ctx.obj = QueryManager()


@cli.command()
@click.pass_obj
def run(obj: QueryManager):
    obj.run()


if __name__ == "__main__":
    cli()
