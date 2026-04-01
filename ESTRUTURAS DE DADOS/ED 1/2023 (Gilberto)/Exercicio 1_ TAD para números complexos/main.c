#include <stdio.h>


int main() {
    // Testando as operações do TAD "Número Complexo"
    NumeroComplexo num1, num2, resultado;

    inicializaComplexo(&num1, 3.0, 4.0);
    inicializaComplexo(&num2, 1.5, 2.5);

    printf("Número 1: ");
    imprimeComplexo(num1);

    printf("Número 2: ");
    imprimeComplexo(num2);

    resultado = somaComplexos(num1, num2);
    printf("Soma: ");
    imprimeComplexo(resultado);

    if (ehReal(resultado)) {
        printf("A soma é um número real.\n");
    } else {
        printf("A soma não é um número real.\n");
    }

    return 0;
}