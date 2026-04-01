#include <iostream>
#include <string>

using namespace std;

/// Matriz de transição
// O valor 0 indica que não há transição válida (fim do token ou erro)
const int T[23][13] = {
         // h, e, r, s, i, c, a, t, +, -, num, ws, out
   /*0*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
   /*1*/ {  2, 0, 0, 4, 0,11, 0, 0,17,18, 19,  0,  0 }, 
   /*2*/ {  0, 3, 0, 0, 7, 0, 0, 0, 0, 0,  0,  0,  0 }, 
   /*3*/ {  0, 0, 9, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
   /*4*/ {  5, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
   /*5*/ {  0, 6, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
   /*6*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
   /*7*/ {  0, 0, 0, 8, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
   /*8*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
   /*9*/ {  0, 0, 0,10, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
  /*10*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
  /*11*/ {  0, 0, 0, 0, 0, 0,12, 0, 0, 0,  0,  0,  0 }, 
  /*12*/ {  0, 0,14, 0, 0, 0, 0,13, 0, 0,  0,  0,  0 }, 
  /*13*/ {  0, 0, 0,15, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
  /*14*/ {  0, 0, 0,16, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
  /*15*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
  /*16*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
  /*17*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
  /*18*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0 }, 
  /*19*/ {  0,20, 0, 0, 0, 0, 0, 0, 0, 0, 19,  0,  0 }, 
  /*20*/ {  0, 0, 0, 0, 0, 0, 0, 0,21,21, 22,  0,  0 }, 
  /*21*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22,  0,  0 }, 
  /*22*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22,  0,  0 } 
};

int obter_coluna(char c) {
    switch(c) {
        case 'h': return 0;
        case 'e': return 1;
        case 'r': return 2;
        case 's': return 3;
        case 'i': return 4;
        case 'c': return 5;
        case 'a': return 6;
        case 't': return 7;
        case '+': return 8;
        case '-': return 9;
        default:
            if (c >= '0' && c <= '9') return 10;
            if (c == ' ' || c == '\n' || c == '\t' || c == '\r') return 11;
            return 12;
    }
}

bool is_final(int state) {
    return (state == 3 || state == 6 || state == 8 || state == 10 ||
            state == 13 || state == 14 || state == 15 || state == 16 ||
            state == 17 || state == 18 || state == 19 || state == 22);
}

bool primeira_linha = true;

void imprimir(string texto) {
    if (!primeira_linha) cout << "\n";
    cout << texto;
    primeira_linha = false;
}

void print_token(int state, string lexema) {
    switch(state) {
        case 3: imprimir("ELE"); break;
        case 6: imprimir("ELA"); break;
        case 8: imprimir("DELE"); break;
        case 10: imprimir("DELA"); break;
        case 13: imprimir("GATO"); break;
        case 14: imprimir("CARRO"); break;
        case 15: imprimir("GATOS"); break;
        case 16: imprimir("CARROS"); break;
        case 17: imprimir("MAIS"); break;
        case 18: imprimir("MENOS"); break;
        case 19: imprimir("INTEIRO " + lexema); break;
        case 22: imprimir("REAL " + lexema); break;
    }
}

int main() {
    char c;
    int estado = 1;
    string lexema = "";

    while (cin.get(c)) {
        
        if (estado == 1 && (c == ' ' || c == '\n' || c == '\t' || c == '\r')) {
            continue;
        }

        int col = obter_coluna(c);
        int proximo_estado = T[estado][col];

        if (proximo_estado == 0) {
            if (estado == 1) {
                imprimir("ERRO");
            } else {
                if (is_final(estado)) {
                    print_token(estado, lexema);
                } else {
                    for(size_t i = 0; i < lexema.length(); i++) {
                        imprimir("ERRO");
                    }
                }
                cin.unget();
            }
            estado = 1;
            lexema = "";
        } else {
            estado = proximo_estado;
            lexema += c;
        }
    }

    if (estado != 1) {
        if (is_final(estado)) {
            print_token(estado, lexema);
        } else {
            for(size_t i = 0; i < lexema.length(); i++) {
                imprimir("ERRO");
            }
        }
    }

    return 0;
}