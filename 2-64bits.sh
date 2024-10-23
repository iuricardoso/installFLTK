#!/bin/bash

# Verificar se o FLTK está instalado
if command -v fltk-config &> /dev/null
then
    # Se instalado, exibir a versão
    echo "FLTK já está instalado. Versão: $(fltk-config --version)"
else
    # Se não estiver instalado, proceder com a instalação
    echo 'FLTK não encontrado. Instalando MinGW64 e FLTK...'
    pacman -S mingw-w64-x86_64-gcc mingw-w64-x86_64-fltk mingw-w64-x86_64-make
    echo 'Instalação concluída!'

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
    echo -n 'Verifique se uma janela foi aberta. Feche-a para continuar...'

    ./testefltk.exe

    # Limpar arquivos temporários
    rm -f ./testefltk.o
    rm -f ./testefltk.exe
    echo 'Teste finalizado!'
fi
