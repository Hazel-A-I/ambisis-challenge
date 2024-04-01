# Ambisis Challenge

Projeto realizado para entrevista de emprego na Ambisis - Software de gestão ambiental, feito por Hazel Arcangelo durante o período requisitado de uma semana.

Todos e quaisquer commits realizados após a data de 4/02/2024 (MM/DD/YYYY) devem ser considerados conteúdos adicionais posteriores ao desafio.

## Instalação

### Pré-requisitos

Flutter SDK instalado e com variáveis de ambiente configuradas: https://flutter.dev/docs/get-started/install

Android Studio e VS Code (opcional) com o plugin Flutter instalado: https://flutter.dev/docs/get-started/editor

Conta Firebase: https://firebase.google.com/

### Execute localmente

Faça um clone do repositório

```bash
  git clone https://github.com/Hazel-A-I/ambisis_challenge.git
```

Vá para o diretório do projeto

```bash
  cd ambisis_challenge
```

Instale as dependências

```bash
  flutter pub get
```

### Crie um projeto Firebase:

Acesse o console Firebase: https://firebase.google.com/

Clique em "Adicionar projeto" e siga as instruções para criar um novo projeto.

Dê um nome ao seu projeto e selecione a região desejada.

Adicionar o SDK do Firebase ao seu projeto:

No console Firebase, vá para a guia "Visão geral" do seu projeto.

Clique no ícone do Flutter onde diz: "Comece adicionando o Firebase ao seu aplicativo".

Siga as instruções para baixar o SDK do Firebase e adicionar as dependências ao seu
projeto Flutter.

### Finalmente, configure o Firebase no seu projeto:

Abra o arquivo main.dart do repositório clonado.

Chame o método initializeApp no widget MyApp.

Passe as configurações do seu projeto Firebase para o método initializeApp.

### Passos após o setup inicial:

1. Instale o Android Studio:

Baixe e instale o Android Studio: https://developer.android.com/studio

Durante a instalação, escolha a opção de instalar o SDK do Android e o Android Virtual Device (AVD) Manager.

2. Crie um AVD (Android Virtual Device):

Abra o Android Studio e vá em Tools > AVD Manager.

Clique em Create Virtual Device.

Selecione um dispositivo e configure as opções desejadas, como API level, RAM e armazenamento.

Clique em Create.

3. Iniciar o Emulador:

Na lista de AVDs, selecione o dispositivo que você criou e clique em Start.
Aguarde o emulador iniciar.

4. Execute o aplicativo no Emulador:

#### No VS Code (se você optou por baixá-lo juntamente ao Android Studio):

Abra o projeto no VS Code.
Pressione Ctrl+Shift+P para abrir a paleta de comandos.
Digite Flutter: Run e selecione a opção Run on Device or Emulator.
Selecione o emulador na lista.
O aplicativo será instalado e iniciado no emulador.

#### No Android Studio:

Abra o projeto no Android Studio.
Clique no botão verde Executar na barra de ferramentas.
Selecione o emulador na lista.
O aplicativo será instalado e iniciado no emulador.

### Dicas:

Certifique-se de que o emulador esteja com a API Android 28 ou superior.
Se você encontrar erros ao executar o aplicativo, verifique se o SDK do Android e o Flutter SDK estão atualizados.
Consulte a documentação do Flutter para obter mais informações sobre como executar aplicativos em emuladores: https://flutter.dev/

## Recursos adicionais:

Documentação Flutter: https://flutter.dev/docs

Documentação Firebase: https://firebase.google.com/docs
