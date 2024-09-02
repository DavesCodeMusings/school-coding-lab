from machine import Pin
from time import sleep

red = Pin(4, Pin.OUT)
yellow = Pin(5, Pin.OUT)
green = Pin(6, Pin.OUT)

while True:
    red.on()
    yellow.off()
    green.off()
    sleep(1)

    red.off()
    yellow.off()
    green.off()
    sleep(1)
