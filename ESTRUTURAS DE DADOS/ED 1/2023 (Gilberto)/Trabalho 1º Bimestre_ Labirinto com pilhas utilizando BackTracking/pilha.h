#ifndef PILHA_H
#define PILHA_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct no No;

typedef struct pilha Pilha;

Pilha *criaPilha();
/**
 * @brief Criar uma pilha
 * 
 * @return Pilha*
 */

void push(Pilha *p, int x, int y);
/**
 * @brief Adiciona itens a pilha
 * 
 * @param p Pilha para adicionar
 * @param x Coordenada x
 * @param y Coordenada y
 */

void pop(Pilha *p, int *x, int *y);
/**
 * @brief remove o item no topo da pilha copia suas coordenadas para @param x e @param y
 * 
 * @param p Pilha
 * @param x Coordenada x
 * 
 */

bool isEmpty(Pilha *p);
/**
 * @brief Informa se a pilha está vazia
 * 
 * @param p Pilha*
 */

void imprimePilha(Pilha *p);
/**
 * @brief Imprime a pilha
 * 
 * @param p Pilha
 */

#endif