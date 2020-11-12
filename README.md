Teste para Desenvolvedor Android Imply
===================

Este teste é apresentado aos candidatos a vaga de desenvolvedor Android para avaliar os quesitos técnicos.

----------


O Desafio
-------------

Você deverá desenvolver duas telas, que serão descritas na sequência. Para desenvolver gostariamos que você utilizasse Java, mas não terá pontos descontados caso usar Kotlin. Em relação a consulta dos produtos utilize o Retrofit https://square.github.io/retrofit/. E para fazer a persistência dos dados utilize a biblioteca "Room Persistence" https://developer.android.com/topic/libraries/architecture/room ou o SQLite puro https://developer.android.com/training/data-storage/sqlite?hl=pt-br.

#### <i class="icon-folder-open"></i> Tela Cardápio (principal)

Nesta tela teremos um cardápio com os produtos que você obterá consultando o endpoint https://ah.we.imply.com/cashless/produtos através do método de requisição http "GET". Cada produto terá sua categoria, estás categorias devem ser separadas por "tabs". No "card" de cada produto deverá ter a descrição do produto, a imagem  e o valor. Ao clicar sobre um produto, deverá ser incrementado a quantidade, atualizado o valor total da compra e a quantidade de itens. Ao clicar no botão "LIMPAR" o valor total e a quantidade são resetados e ao clicar em "CONFIRMAR" o app deverá chamar a tela do extrato que será explicada a seguir. 

<img src="https://github.com/myfreecomm/desafio-mobile-android/blob/master/screens/two-line-example-2.png?raw=true" style="height:300px">

#### <i class="icon-folder-open"></i> Tela Extrato

Nesta tela deverá ter uma tabela, com as seguintes colunas: "Item" (descrição do produtos), "Qtde" (quantidade selecionada do produto), "Unit" (valor unitário do produto), "Total". Logo abaixo da tabela deverá ter um descritivo do valor total da compra. Ao clicar no botão "CONFIRMAR", você deverá salvar os dados da compra na tabela "transacoes", sendo que cada item da tabela do extrato deverá gerar uma linha na tabela transacoes. Os campos da tabela "transacoes" devem ser os seguintes:

* id
* data_hora_compra (Data e hora que foi clicado no CONFIRMAR)
* descricao_produto
* quantidade
* valor_unitario
* valor_total  

Ao clicar em "CANCELAR" o app deverá voltar para a tela do cardápio.

<img src="https://github.com/myfreecomm/desafio-mobile-android/blob/master/screens/two-line-example-2.png?raw=true" style="height:300px">


#### <i class="icon-folder-open"></i> Plus
- Implementação de algum tipo de arquitetura, pode ser  (mvc, mvp, mvvm, clean etc)
- Testes unitários


Publicação
-------------

Crie um **Fork** do repositório para realizar o teste, e depois de finalizado envie um **Pull Request** para nossa equipe interna avaliar
