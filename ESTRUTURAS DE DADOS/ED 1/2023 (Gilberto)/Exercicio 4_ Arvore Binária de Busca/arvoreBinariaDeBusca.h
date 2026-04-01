#ifndef ARVOREBINARIADEBUSCA
#define ARVOREBINARIADEBUSCA

typedef struct Node Node;

Node* createNode(int data);

Node* insert(Node* root, int data);

Node* search(Node* root, int data);

Node* findMin(Node* node);

Node* deleteNode(Node* root, int data);

void preOrder(Node* root);

void inOrder(Node* root);

void postOrder(Node* root);

void freeTree(Node* root);

#endif