from machine import Pin
from neopixel import NeoPixel

np = NeoPixel(Pin(8), 1)
np[0] = (64, 0, 0)
np.write()
