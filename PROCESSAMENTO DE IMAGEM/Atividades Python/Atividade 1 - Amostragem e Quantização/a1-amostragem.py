import cv2 as cv
import numpy as np


img = cv.imread('./resized_butterfly_doppler_black_pearl_cs2.png', cv.IMREAD_GRAYSCALE)
height, width = img.shape
# cv.imshow('Original', img)
# if cv.waitKey(0) & 0xFF == ord('q'):  # Wait for 'q' key to exit
#     cv.destroyAllWindows()

# Sampling
spacial_res = 300
sampled_img = np.zeros((spacial_res, spacial_res), dtype=np.uint8)

for i in range(spacial_res):
    for j in range(spacial_res):
        sampled_img[i, j] = img[int(i * height/spacial_res), int(j * width/spacial_res)]

cv.imshow('Sampled', sampled_img)
if cv.waitKey(0) & 0xFF == ord('q'):  # Wait for 'q' key to exit
    cv.destroyAllWindows()
