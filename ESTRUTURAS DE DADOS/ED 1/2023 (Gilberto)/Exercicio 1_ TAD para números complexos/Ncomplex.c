#include <stdio.h>
#include "Ncomplex.h"

typedef struct ncomplex{
    double real;
    double imaginario;
} NumeroComplexo;


void inicializaComplexo(NumeroComplexo *num, double real, double imaginario) {
    num->real = real;
    num->imaginario = imaginario;
}

void imprimeComplexo(NumeroComplexo num) {
    printf("%.2f + %.2fi\n", num.real, num.imaginario);
}


void copiaComplexo(NumeroComplexo *dest, NumeroComplexo src) {
    dest->real = src.real;
    dest->imaginario = src.imaginario;
}

NumeroComplexo somaComplexos(NumeroComplexo num1, NumeroComplexo num2) {
    NumeroComplexo resultado;
    resultado.real = num1.real + num2.real;
    resultado.imaginario = num1.imaginario + num2.imaginario;
    return resultado;
}

int ehReal(NumeroComplexo num) {
    return num.imaginario == 0;
}