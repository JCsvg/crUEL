from matplotlib import pyplot as plt
import numpy as np
import cv2 as cv


# ──────────────────────────────────────────────────────────────────
#                 João Carlos dos Santos Correia
#                         202100560332
# ──────────────────────────────────────────────────────────────────


# ──────────────────────────────────────────────────────────────────
#  GLOBAL EQUALIZATION  (manual, sem funções prontas do OpenCV)
# ──────────────────────────────────────────────────────────────────


def calculate_histogram(img, height, width, intensity_levels):
    """Calcula o histograma da imagem pixel a pixel."""
    hist = [0] * intensity_levels
    for i in range(height):
        for j in range(width):
            hist[img[i, j]] += 1
    return hist


def calculate_frequency_distribution(hist, height, width, intensity_levels):
    """Calcula a distribuição de frequência (histograma normalizado)."""
    m_n = height * width
    freq_dist = [hist[i] / m_n for i in range(intensity_levels)]
    return freq_dist


def calculate_transformation_function(freq_dist, intensity_levels):
    """Calcula a função de transformação pela CDF acumulada."""
    transf_func = [0] * intensity_levels
    for i in range(intensity_levels):
        transf_func[i] = (intensity_levels - 1) * sum(freq_dist[: i + 1])
    return transf_func


def equalize_image_global(img, height, width, eq_map):
    """Aplica o mapeamento de equalização global na imagem."""
    eq_img = img.copy()
    for i in range(height):
        for j in range(width):
            eq_img[i, j] = eq_map[img[i, j]]
    return eq_img


# ──────────────────────────────────────────────────────────────────
#  LOCAL EQUALIZATION  (CLAHE via OpenCV)
# ──────────────────────────────────────────────────────────────────


def equalize_image_clahe(img, clip_limit=2.0, tile_grid_size=(8, 8)):
    """Aplica equalização local CLAHE usando a função do OpenCV."""
    clahe = cv.createCLAHE(clipLimit=clip_limit, tileGridSize=tile_grid_size)
    return clahe.apply(img)


# ──────────────────────────────────────────────────────────────────
#  MAIN
# ──────────────────────────────────────────────────────────────────


def main(image_path: str):
    img = cv.imread(image_path, cv.IMREAD_GRAYSCALE)
    if img is None:
        raise FileNotFoundError(f"Imagem não encontrada: {image_path}")

    height, width = img.shape
    intensity_levels = 2**8  # 256

    # ---------- Equalização global (manual) ----------
    org_hist = calculate_histogram(img, height, width, intensity_levels)
    freq_dist = calculate_frequency_distribution(
        org_hist, height, width, intensity_levels
    )
    transf_func = calculate_transformation_function(freq_dist, intensity_levels)
    eq_map = [int(round(x)) for x in transf_func]
    eq_img_global = equalize_image_global(img, height, width, eq_map)

    # Histograma da imagem equalizada globalmente
    eq_hist_global = calculate_histogram(eq_img_global, height, width, intensity_levels)

    # ---------- Equalização local (CLAHE) ----------
    eq_img_clahe = equalize_image_clahe(img)
    eq_hist_clahe = calculate_histogram(eq_img_clahe, height, width, intensity_levels)

    # ──────────── PLOTS ────────────

    # 1. Histograma original
    plt.figure(figsize=(8, 4))
    plt.plot(org_hist, color="black")
    plt.title("Histograma Original")
    plt.xlabel("Nível de Intensidade")
    plt.ylabel("Frequência")
    plt.tight_layout()
    plt.savefig("original_histogram.png", dpi=150)
    plt.close()

    # 2. Histograma equalizado (global)
    plt.figure(figsize=(8, 4))
    plt.plot(eq_hist_global, color="steelblue")
    plt.title("Histograma Equalizado — Global (manual)")
    plt.xlabel("Nível de Intensidade")
    plt.ylabel("Frequência")
    plt.tight_layout()
    plt.savefig("equalized_histogram_global.png", dpi=150)
    plt.close()

    # 3. Histograma equalizado (CLAHE)
    plt.figure(figsize=(8, 4))
    plt.plot(eq_hist_clahe, color="darkorange")
    plt.title("Histograma Equalizado — Local (CLAHE)")
    plt.xlabel("Nível de Intensidade")
    plt.ylabel("Frequência")
    plt.tight_layout()
    plt.savefig("equalized_histogram_clahe.png", dpi=150)
    plt.close()

    # 4. Figura equalizada (global)
    cv.imwrite("equalized_image_global.png", eq_img_global)

    # 5. Figura equalizada (CLAHE)
    cv.imwrite("equalized_image_clahe.png", eq_img_clahe)

    print("Arquivos gerados:")
    print("  original_histogram.png")
    print("  equalized_histogram_global.png")
    print("  equalized_histogram_clahe.png")
    print("  equalized_image_global.png")
    print("  equalized_image_clahe.png")


if __name__ == "__main__":
    main("resized_butterfly_doppler_black_pearl_cs2.png")
