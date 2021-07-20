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
        self.file_system = self.get_filesystem()

    def run(self):
        print(f"Swap Size: {self.format_bytes(self.swap.total)}")
        print(
            f"Total Disk Usage: {self.format_bytes(self.disk_usage.used)} | {self.disk_usage.percent}%"
        )
        print(f"Memory In Use: {self.format_bytes(self.mem_used.used)}")
        print(f"Average CPU Load ~5 Minutes: {self.load_avg[1]}%")
        print(f"File System Type: {self.file_system}")

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
