import cv2 as cv
import numpy as np


img = cv.imread('./resized_butterfly_doppler_black_pearl_cs2.png', cv.IMREAD_GRAYSCALE)
height, width = img.shape
# cv.imshow('Original', img)
# if cv.waitKey(0) & 0xFF == ord('q'):  # Wait for 'q' key to exit
#     cv.destroyAllWindows()


# Quantization
nbits = 5
intensity_levels = 2 ** nbits
quantization_factor = 256 // intensity_levels
quantized_img = np.zeros((height, width), dtype=np.uint8)

for i in range(height):
    for j in range(width):
        quantized_img[i, j] = (img[i, j] // quantization_factor) * quantization_factor

cv.imshow('Quantized', quantized_img)
if cv.waitKey(0) & 0xFF == ord('q'):  # Wait for 'q' key to exit
    cv.destroyAllWindows()
