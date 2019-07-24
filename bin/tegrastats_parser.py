#!/usr/bin/python3

import re
import argparse
import sys


def main(filename):
    with open(filename, 'r') as file:
        cpu_p = re.compile(r'\[.+\]')
        ram_p = re.compile(r'RAM \d+\/\d+MB')
        emc_p = re.compile(r'EMC_FREQ \d+%')

        cpu_counter = 0
        cpu_total = 0
        
        ram_counter = 0
        ram_total = 0
        
        emc_counter = 0
        emc_total = 0
        
        for line in file:
            cpu_values = cpu_p.search(line)
            if(cpu_values is not None):
                single_value = re.search(
                    "([0-9]+)%@[0-9]+", cpu_values.group())
                cpu_total += int(single_value.group(1))
                cpu_counter = cpu_counter + 1
            
            ram_values = ram_p.search(line)
            if(ram_values is not None):
                single_value = re.search(
                    "(\d+)\/", ram_values.group())
                ram_total += int(single_value.group(1))
                ram_counter = ram_counter + 1
            
            emc_values = emc_p.search(line)
            if(emc_values is not None):
                single_value = re.search(
                    "(\d+)", emc_values.group())
                emc_total += int(single_value.group(1))
                emc_counter = emc_counter + 1

        print("CPU Average: ", cpu_total / cpu_counter, "%")
        print("RAM Average: ", ram_total / ram_counter, "MB")
        print("EMC Average: ", emc_total / emc_counter, "%")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        "Gets the average cpu usage for a tegrastats output")
    parser.add_argument("-f", "--filename", help="File with tegrastats output",
                        type=str)
    args = parser.parse_args()

    if(args.filename):
        main(args.filename)
    else:
        parser.print_help(sys.stderr)
        sys.exit(1)
