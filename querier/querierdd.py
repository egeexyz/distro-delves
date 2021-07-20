#!/bin/env python3

import click
import psutil


class QueryManager:
    def __init__(self):
        self.load_avg = psutil.getloadavg()
        self.mem_used = psutil.virtual_memory()
        self.swap = psutil.swap_memory()
        self.temps = psutil.sensors_temperatures()
        self.fans = psutil.sensors_fans()
        self.disk_usage = psutil.disk_usage("/")

    def run(self):
        print(f"Total Disk Usage:          {self.format_bytes(self.disk_usage.used)}")
        print(f"Total Memory In Use:       {self.format_bytes(bytes=self.mem_used.used, fmt='mb')}")
        print(f"5 Minute CPU Load Average: {self.load_avg[1]}%")

    def format_bytes(self, bytes, fmt="gb"):
        if fmt == "gb":
            return f"{format(int(bytes) / 1073741824, '.0f')}G"
        elif fmt == "mb":
            return f"{format(int(bytes) / 1048576, '.0f')}M"
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
