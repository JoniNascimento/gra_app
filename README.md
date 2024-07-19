# gra_app

Produto do teste da aplicação Golden Raspberry Awards para front end web, adaptado para Flutter mobile. 

## Descriptio

O projeto foi construido utilizando algumas camadas do clean architerure como data(chamada de services neste projeto) e domain;
Na camada Features, temos as duas páginas existentes no app, representando suas funcionalidades;
Foi utilizado o atributo drawer do widget Scafold para navegar entre as páginas, sendo elas gerenciadas dentro de um pageView;
Usado injeção de dependêcias com o package Get_it;
Utilizado flutter_bloc para separar a logica da tela e as facilidades do package para gerenciar o estado da tela;
Foram realizados alguns testes unitários referente as funções da classe de services, onde estão as chamadas externas com conversões em objetos;

Projeto criado no flutter versão 3.19.5;
Para rodar o projeto basta instalar uma ide compativel com o framework flutter, instalar e configurar o flutter, configurar um emulador ou utilizar um diospositivo fisico, ou até mesmo usar o webbrouser, abrir rodar o comando "flutter pub get"para fazer o download das dependências e executar o projeto;

Abaixo uma sugestão de como fazer esta configuração utilizando o Visual Studio Code:

Instalação e Configuração do Ambiente
Configuração no Visual Studio Code (Mac e Windows)

1-Instalação do Flutter:

Baixe o Flutter SDK do site oficial do Flutter: https://docs.flutter.dev/

2-Configuração do Path 

 2.1-(Mac):

Descompacte o arquivo baixado e adicione a pasta flutter/bin ao seu PATH:
bash
Copy code
export PATH="$PATH:`pwd`/flutter/bin"
Para tornar permanente, adicione esta linha ao seu arquivo de perfil, por exemplo, .bash_profile ou .zshrc.

2.2-(Windows):

Extraia o Flutter SDK para um diretório de sua escolha.
Abra o Control Panel > System and Security > System, clique em Advanced system settings e depois em Environment Variables.
Sob System Variables, selecione Path e clique em Edit. Adicione o caminho para flutter/bin.

3-Instalação do Visual Studio Code:

Baixe e instale o Visual Studio Code.

4-Instalação do Plugin Flutter:

No VS Code, vá para Extensions (ou pressione Cmd+Shift+X no macOS ou Ctrl+Shift+X no Windows), e pesquise por "Flutter". Instale o plugin oferecido pela equipe do Flutter.

5- Instalação do Android Studio para rodar apps android através do link: https://developer.android.com/studio?gad_source=1&gclid=CjwKCAjwnei0BhB-EiwAA2xuBuYjtyDK2xoCU4hLPY5eLTM-z-BjVSSkOCNxiXQ0XUb0f9v6ETCguhoCUY0QAvD_BwE&gclsrc=aw.ds


Abra o projeto no VS Code.
Abra um terminal integrado no VS Code (Ctrl+` ) e execute flutter pub get para instalar as dependências.
Execute o aplicativo pressionando F5 ou digitando flutter run no terminal.

