# bytebank

Um projeto Flutter baseado na Formação Alura.

Bytebank tem a funcionalidade de criar e salvar contatos em sua agenda e realizar transações após autenticar o usuário através de uma API e então manter um histórico de transacões efetuadas sincronizado com banco de dados externo.

Henrique F. Batista

- [linkedIn](https://www.linkedin.com/in/henrique-batista-61181b141/)
## Funcionalidades

- Pesistencia interna de dados usando SQFlite
- Tecnicas de Statefull e Stateless widgets
- Consumo de API externa via Rest usando biblioteca do Flutter
- Autenticação de request pela API
- Serialização de Objetos JSON
- Captura de requests para tratativa de excessões com HttpInterceptors
- Navação entre telas
- Exibição e interação com Dialogs 
- Utilização de bibliotecas externas
- Uso de Widget de imagem
- layout em Material
- Teste Unitario
- Teste de Fluxo
- Teste de Widget


## Getting Started

Para que as requisições funcionem você deve baixar o Servidor java disponível na pasta do projeto criado pelo instrutor da Alura :
- Extrair o pacote zip
- Abrir o terminal e navegar até a pasta do projeto Ex: "C:/Usuario/Downloads/servidor"  
- Executar o comando "java -jar server.jar"

Para que o emulador consiga fazer as requisições você deve colocar seu IP de rede no arquivo "Webclient.dart" linha
- lib/http/Webclients.dart




