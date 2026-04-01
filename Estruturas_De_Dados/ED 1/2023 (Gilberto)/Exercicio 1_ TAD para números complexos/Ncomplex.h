#ifndef NCOMPLEX_H
#define NCOMPLEX_H

#include <stdio.h>

typedef struct ncomplex NumeroComplexo;

void inicializaComplexo(NumeroComplexo *num, double real, double imaginario);

void imprimeComplexo(NumeroComplexo num);

void copiaComplexo(NumeroComplexo *dest, NumeroComplexo src);

NumeroComplexo somaComplexos(NumeroComplexo num1, NumeroComplexo num2);

int ehReal(NumeroComplexo num);

#endif