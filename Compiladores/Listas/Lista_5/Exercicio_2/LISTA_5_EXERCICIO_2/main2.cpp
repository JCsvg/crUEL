#include <iostream>
#include <string>

using namespace std;

// Matriz de transição
// O valor 0 indica que não há transição válida (fim do token ou erro)
const int T[14][11] = {
          // 0-9, i, f, a-e, g-h, j-z, -, ., ' ',  \n, other
   /*0*/  {   0,  0,  0,  0,   0,   0,  0, 0,   0,   0,    0, },
   /*1*/  {   7,  2,  4,  4,   4,   4,  9, 5,  12,  13,   13, },
   /*2*/  {   4,  4,  3,  4,   4,   4,  0, 0,   0,   0,    0, },
   /*3*/  {   4,  4,  4,  4,   4,   4,  0, 0,   0,   0,    0, },
   /*4*/  {   4,  4,  4,  4,   4,   4,  0, 0,   0,   0,    0, },
   /*5*/  {   6,  0,  0,  0,   0,   0,  0, 0,   0,   0,    0, },
   /*6*/  {   6,  0,  0,  0,   0,   0,  0, 0,   0,   0,    0, },
   /*7*/  {   7,  0,  0,  0,   0,   0,  0, 8,   0,   0,    0, },
   /*8*/  {   8,  0,  0,  0,   0,   0,  0, 0,   0,   0,    0, },
   /*9*/  {   0,  0,  0,  0,   0,   0, 10, 0,   0,   0,    0, },
   /*10*/ {   0, 10, 10, 10,  10,  10,  0, 0,   0,  11,    0, },
   /*11*/ {   0,  0,  0,  0,   0,   0,  0, 0,   0,   0,    0, },
   /*12*/ {   0,  0,  0,  0,   0,   0,  0, 0,  12,   0,    0, },
   /*13*/ {   0,  0,  0,  0,   0,   0,  0, 0,   0,   0,    0  }
};

int obter_coluna(char c) {
    if (c >= '0' && c<= '9') return 0;
    if (c == 'i') return 1;
    if (c == 'f') return 2;
    if (c >= 'a' && c<= 'e') return 3;
    if (c == 'g' || c== 'h') return 4;
    if (c >= 'j' && c<= 'z') return 5;
    if (c == '-') return 6;
    if (c == '.') return 7;
    if (c == '\n') return 9;
    if (c == ' ') return 8;
    return 10;
}

string obter_nome_token(int estado) {
    switch (estado) {
        case 2: return "ID";
        case 3: return "IF";
        case 4: return "ID";
        case 5: return "ERROR";
        case 6: return "REAL";
        case 7: return "NUM";
        case 8: return "REAL";
        case 9: return "ERROR";
        case 11: return "COMMENT";
        case 12: return "WHITE SPACE";
        case 13: return "ERROR";
        default: return "ERROR";
    }
}

int main() {
    char c;
    int estado = 1;
    string lexema = "";

    while (cin.get(c)) {
        if (c == '\r') continue; 

        if (estado == 1 && c == '\n') continue;

        int col = obter_coluna(c);
        int proximo_estado = T[estado][col];

        if (proximo_estado == 0) {
            
            cout << lexema << " " << obter_nome_token(estado) << "\n";
            
            cin.unget();
            
            estado = 1;
            lexema = "";
            
        } else {
            estado = proximo_estado;
            
            if (c != '\n') {
                lexema += c;
            }
        }
    }

    if (estado != 1) {
        cout << lexema << " " << obter_nome_token(estado) << "\n";
    }

    return 0;
}