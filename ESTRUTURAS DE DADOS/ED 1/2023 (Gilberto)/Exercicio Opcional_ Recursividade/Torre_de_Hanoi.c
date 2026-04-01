#include <stdio.h>

void torresDeHanoi(int n, char estacaOrigem, char estacaDestino, char estacaAuxiliar) {
    if (n == 1) {
        printf("Mover disco 1 de %c para %c\n", estacaOrigem, estacaDestino);
        return;
    }

    torresDeHanoi(n - 1, estacaOrigem, estacaAuxiliar, estacaDestino);
    printf("Mover disco %d de %c para %c\n", n, estacaOrigem, estacaDestino);
    torresDeHanoi(n - 1, estacaAuxiliar, estacaDestino, estacaOrigem);
}

int main() {
    int numDiscos;

    
    printf("Digite o número de discos: ");
    scanf("%d", &numDiscos);

    if (numDiscos <= 0) {
        printf("Por favor, insira um número de discos positivo.\n");
        return 1; 
    }


    torresDeHanoi(numDiscos, 'A', 'C', 'B');

    return 0;
}
