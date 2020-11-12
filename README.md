# Teste para Desenvolvedor Android Imply

Este teste é apresentado aos candidatos a vaga de desenvolvedor Android para avaliar os quesitos técnicos.

---

## O Desafio

Você deverá desenvolver duas telas, que serão descritas na sequência. Para desenvolver gostariamos que você utilizasse Java, mas não terá pontos descontados caso usar Kotlin. Em relação a consulta dos produtos utilize o Retrofit https://square.github.io/retrofit/. E para fazer a persistência dos dados utilize a biblioteca "Room Persistence" https://developer.android.com/topic/libraries/architecture/room ou o SQLite puro https://developer.android.com/training/data-storage/sqlite?hl=pt-br.

#### <i class="icon-folder-open"></i> Tela Cardápio (principal)

Nesta tela teremos um cardápio com os produtos que você obterá consultando o endpoint https://ah.we.imply.com/cashless/produtos através do método de requisição http "GET". Cada produto terá sua categoria, estás categorias devem ser separadas por "tabs". No "card" de cada produto deverá ter a descrição do produto, a imagem (vem junto em base64 na consulta) e o valor. Ao clicar sobre um produto, deverá ser incrementado a quantidade, atualizado o valor total da compra e a quantidade de itens. Ao clicar no botão "LIMPAR" o valor total e a quantidade são resetados e ao clicar em "CONFIRMAR" o app deverá chamar a tela do extrato que será explicada a seguir.

#### <i class="icon-file"></i> Mockup da tela do cardápio

<table>
<tbody>
<tr>
  <th>Cardápio (Categoria "BEBIDAS")</th>
  <th>Cardápio (Categoria "LANCHES")</th>
  <th>Cardápio (Categoria "BEBIDAS") com itens selecionados</th>
  <th>Cardápio (Categoria "LANCHES") com itens selecionados</th>
</tr>
<tr>
  <td><img src="https://github.com/ped-imply/teste-desenvolvedor-android/blob/master/imagens/cardapio01.png?raw=true" ></td>
  <td><img src="https://github.com/ped-imply/teste-desenvolvedor-android/blob/master/imagens/cardapio02.png?raw=true"></td>
  <td><img src="https://github.com/ped-imply/teste-desenvolvedor-android/blob/master/imagens/cardapio03.png?raw=true"></td>
  <td><img src="https://github.com/ped-imply/teste-desenvolvedor-android/blob/master/imagens/cardapio04.png?raw=true"></td>
</tr>
</tbody>
</table>

#### <i class="icon-folder-open"></i> Tela Extrato

Nesta tela deverá ter uma tabela, com as seguintes colunas: "Item" (descrição do produtos), "Qtde" (quantidade selecionada do produto), "Unit" (valor unitário do produto), "Total". Logo abaixo da tabela deverá ter um descritivo do valor total da compra. Ao clicar no botão "CONFIRMAR", você deverá salvar os dados da compra na tabela "transacoes", sendo que cada item da tabela do extrato deverá gerar uma linha na tabela transacoes. Os campos da tabela "transacoes" devem ser os seguintes:

- id
- data_hora_compra (Data e hora que foi clicado no CONFIRMAR)
- descricao_produto
- quantidade
- valor_unitario
- valor_total

Ao clicar em "CANCELAR" o app deverá voltar para a tela do cardápio.

#### <i class="icon-file"></i> Mockup da tela do extrato
<table>
<tbody>
<tr>
  <th>Extrato</th>
</tr>
<tr>
  <td><img src="https://github.com/ped-imply/teste-desenvolvedor-android/blob/master/imagens/extrato.png?raw=true" height="600" width="400" ></td>
</tr>
</tbody>
</table>

#### <i class="icon-folder-open"></i> Você ganhará pontos extras se:

- Implementar de algum tipo de arquitetura, pode ser (mvc, mvp, mvvm, clean etc)
- Desenvolver Testes unitários
- Fazer commits claros, evidenciando o que realmente foi desenvolvido, pois seu código será revisado e validado por nossa equipe de desenvolvedores


## Publicação

Crie um **Fork** do repositório para realizar o teste, e depois de finalizado envie um **Pull Request** para nossa equipe interna avaliar
