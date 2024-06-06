# Print ESP32 hardware capabilities
from machine import freq
from gc import collect, mem_free
from esp import flash_size
from os import uname

collect()  # Run garbage collection to free as much RAM as possible.
arch = "CPU: {:>11s}".format(uname()[0])
speed = "Speed:   {:4.0f}MHz".format(freq() / 1000 / 1000)
ram_free = "RAM:      {:4.0f}KB".format(mem_free() / 1024)
flash_total = "Flash:    {:4.0f}MB".format(flash_size() / 1024 / 1024)
version = "MicroPy:{:>8s}".format(uname()[2])

print(arch)
print(speed)
print(ram_free)
print(flash_total)
print(version)
