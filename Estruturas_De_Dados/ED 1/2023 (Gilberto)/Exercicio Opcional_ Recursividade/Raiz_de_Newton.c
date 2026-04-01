#include <stdio.h>
#include <math.h>

double calcularRaizQuadrada(double numero, double estimativaInicial, double criterioParada) {
    double raizAtual = estimativaInicial;
    double raizAnterior;

    do {
        raizAnterior = raizAtual;
        raizAtual = 0.5 * (raizAnterior + numero / raizAnterior);
    } while (fabs(raizAtual - raizAnterior) > criterioParada);

    return raizAtual;
}

int main() {
    double numero, estimativaInicial, criterioParada;

    printf("Digite um número para calcular a raiz quadrada: ");
    scanf("%lf", &numero);

    
    printf("Digite uma estimativa inicial para a raiz: ");
    scanf("%lf", &estimativaInicial);

    
    printf("Digite o critério de parada: ");
    scanf("%lf", &criterioParada);

    
    if (numero < 0) {
        printf("Não é possível calcular a raiz quadrada de um número negativo.\n");
    } else {
        
        double resultado = calcularRaizQuadrada(numero, estimativaInicial, criterioParada);
        printf("A raiz quadrada de %.2lf é aproximadamente %.6lf\n", numero, resultado);
    }

    return 0;
}
