import cv2 as cv
import numpy as np
from collections import deque


def preparar_imagem(caminho):
    """Lê a imagem e aplica a binarização (quantização de 1 bit)."""
    img = cv.imread(caminho, cv.IMREAD_GRAYSCALE)
    if img is None:
        raise FileNotFoundError("Imagem não encontrada no caminho especificado.")

    # Binarização: 0 para fundo, 255 para objeto
    _, bin_img = cv.threshold(img, 127, 255, cv.THRESH_BINARY)
    return bin_img


def algoritmo_logica_basica(img_binaria):
    """Implementação baseada na sua lógica de propagação iterativa."""
    h, w = img_binaria.shape
    # Inicializa cada pixel branco com um ID único
    labels = np.zeros((h, w), dtype=int)
    count = 1
    for i in range(h):
        for j in range(w):
            if img_binaria[i, j] > 0:
                labels[i, j] = count
                count += 1

    vizinhos = [(-1, 0), (1, 0), (0, -1), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)]

    mudou = True
    while mudou:
        mudou = False
        for i in range(h):
            for j in range(w):
                if labels[i, j] > 0:
                    for dy, dx in vizinhos:
                        ny, nx = i + dy, j + dx
                        if 0 <= ny < h and 0 <= nx < w and labels[ny, nx] > 0:
                            if labels[ny, nx] < labels[i, j]:
                                labels[i, j] = labels[ny, nx]
                                mudou = True
    return labels


def algoritmo_bfs(img_binaria):
    """Implementação utilizando Busca em Largura (BFS)."""
    h, w = img_binaria.shape
    labels = np.zeros((h, w), dtype=int)
    visitados = np.zeros((h, w), dtype=bool)
    label_atual = 1

    vizinhos = [(-1, 0), (1, 0), (0, -1), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)]

    for i in range(h):
        for j in range(w):
            if img_binaria[i, j] > 0 and not visitados[i, j]:
                # Inicia fila para o novo componente encontrado
                fila = deque([(i, j)])
                visitados[i, j] = True

                while fila:
                    y, x = fila.popleft()
                    labels[y, x] = label_atual

                    for dy, dx in vizinhos:
                        ny, nx = y + dy, x + dx
                        if 0 <= ny < h and 0 <= nx < w:
                            if img_binaria[ny, nx] > 0 and not visitados[ny, nx]:
                                visitados[ny, nx] = True
                                fila.append((ny, nx))
                label_atual += 1
    return labels


def colorir_e_exibir(labels, titulo):
    """Gera cores aleatórias para os rótulos e exibe o resultado."""
    h, w = labels.shape
    img_colorida = np.zeros((h, w, 3), dtype=np.uint8)

    rótulos_unicos = np.unique(labels[labels > 0])
    for label in rótulos_unicos:
        cor = np.random.randint(50, 255, size=3).tolist()
        img_colorida[labels == label] = cor

    cv.imshow(titulo, img_colorida)


def main():
    # Configurações iniciais
    caminho_imagem = './img.png'

    try:
        # Processamento
        img_bin = preparar_imagem(caminho_imagem)

        # Execução dos algoritmos
        resultado_logica = algoritmo_logica_basica(img_bin)
        resultado_bfs = algoritmo_bfs(img_bin)

        # Saída visual
        colorir_e_exibir(resultado_logica, "Resultado: Logica Basica")
        colorir_e_exibir(resultado_bfs, "Resultado: BFS")

        print("Processamento concluído. Pressione 'q' nas janelas para sair.")
        if cv.waitKey(0) & 0xFF == ord('q'):
            cv.destroyAllWindows()

    except Exception as e:
        print(f"Erro: {e}")


if __name__ == "__main__":
    main()