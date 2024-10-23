#!/bin/bash

# Função para verificar a instalação de um pacote e instalá-lo se necessário
verificar_instalar() {
    local comando=$1
    local pacote=$2
    local nome=$3

    if ! command -v "$comando" &> /dev/null
    then
        echo "$nome não encontrado. Instalando $pacote..."
        pacman -S "$pacote"
        
        if command -v "$comando" &> /dev/null
        then
            echo "$nome instalado com sucesso!"
        else
            echo "Erro: Falha ao instalar $nome. Abortando."
            exit 1
        fi
    else
        echo "$nome já está instalado."
    fi
}

# Verificar e instalar o GCC (mingw-w64-x86_64-gcc)
verificar_instalar "g++" "mingw-w64-x86_64-gcc" "GCC"

# Verificar e instalar o Make (mingw-w64-x86_64-make)
verificar_instalar "make" "mingw-w64-x86_64-make" "Make"

# Verificar e instalar o FLTK (mingw-w64-x86_64-fltk)
verificar_instalar "fltk-config" "mingw-w64-x86_64-fltk" "FLTK"

# Criar arquivo de teste FLTK
echo -n 'Testando...'
echo '#include <FL/Fl.H>' > testefltk.cpp
echo '#include <FL/Fl_Window.H>' >> testefltk.cpp
echo '#include <FL/Fl_Box.H>' >> testefltk.cpp
echo '' >> testefltk.cpp
echo 'int main (int argc, char ** argv)' >> testefltk.cpp
echo '{' >> testefltk.cpp
echo '    Fl_Window *window;' >> testefltk.cpp
echo '    Fl_Box *box;' >> testefltk.cpp
echo '' >> testefltk.cpp
echo '    window = new Fl_Window (300, 180);' >> testefltk.cpp
echo '    box = new Fl_Box (20, 40, 260, 100, "Hello World!");' >> testefltk.cpp
echo '' >> testefltk.cpp
echo '    box->box (FL_UP_BOX);' >> testefltk.cpp
echo '    box->labelsize (36);' >> testefltk.cpp
echo '    box->labelfont (FL_BOLD+FL_ITALIC);' >> testefltk.cpp
echo '    box->labeltype (FL_SHADOW_LABEL);' >> testefltk.cpp
echo '    window->end ();' >> testefltk.cpp
echo '    window->show (argc, argv);' >> testefltk.cpp
echo '' >> testefltk.cpp
echo '    return(Fl::run());' >> testefltk.cpp
echo '}' >> testefltk.cpp

# Compilar e executar o teste
g++ -c testefltk.cpp -o testefltk.o
g++ testefltk.o -o testefltk.exe -lfltk
echo 'Compilação concluída!'
echo -n 'Verifique se uma janela foi aberta (pode estar atrás desta). Feche-a para continuar...'

./testefltk.exe

# Limpar arquivos temporários
rm -f ./testefltk.o
rm -f ./testefltk.exe
echo 'Teste finalizado!'
