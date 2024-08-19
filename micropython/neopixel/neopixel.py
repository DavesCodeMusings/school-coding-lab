from machine import Pin
from neopixel import NeoPixel
from time import sleep

walk_signal = NeoPixel(Pin(8), 1)

while True:
    walk_signal[0] = (255, 0, 0)
    walk_signal.write()
    sleep(5)

    walk_signal[0] = (255, 255, 255)
    walk_signal.write()
    sleep(5)
