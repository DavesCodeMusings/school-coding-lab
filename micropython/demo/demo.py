# Simulate a lightning strike with a NeoPixel white LED chaser effect.
# Other color values are included for experimentation.

# Requires a strip of NeoPixels attached to a GPIO.

from machine import Pin
from neopixel import NeoPixel
from time import sleep, sleep_ms
from random import randomrange

NEOPIXEL_GPIO = 8
TOTAL_PIXELS = 6

COLOR_OFF = (0, 0, 0)
COLOR_WHITE = (255, 255, 255)
COLOR_RED = (255, 0, 0)
COLOR_ORANGE = (191, 63, 0)
COLOR_YELLOW = (127, 127, 0)
COLOR_GREEN = (0, 255, 0)
COLOR_BLUE = (0, 0, 255)
COLOR_VIOLET = (127, 0, 127)

led_strip = NeoPixel(Pin(NEOPIXEL_GPIO), TOTAL_PIXELS)


def change_pixel(pixel_number, color):
    """
    Light up the NeoPixel given by pixel_number with the RGB code
    given by color.
    """
    global led_strip
    led_strip[pixel_number] = color
    led_strip.write()


def show_lightning(num_pixels):
    """
    Light up a neopixel bright white for a short time, then switch it
    off and move to the next one. Repeat for all pixels in the strip.
    """
    for pixel_number in range(num_pixels):
        change_pixel(pixel_number, COLOR_WHITE)
        sleep_ms(10)
        change_pixel(pixel_number, COLOR_OFF)


while True:
    show_lightning(TOTAL_PIXELS)
    delay = randomrange(1, 10)
    sleep(delay)
