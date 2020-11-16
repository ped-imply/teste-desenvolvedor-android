package com.example.application.data.utils;

import com.example.application.data.model.CategoriaProduto;
import com.example.application.data.model.Produto;
import com.example.application.data.model.ProdutoDto;
import com.example.application.data.model.ResultDto;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

public class ProdutoDeserializer implements JsonDeserializer<ProdutoDto> {

    private Gson gson;

    @Override
    public ProdutoDto deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
            throws JsonParseException {
        gson = new Gson();
        ProdutoDto dto = ProdutoDto.builder()
                .result(parseResultDto(json.getAsJsonObject().get("result")))
                .build();

        return dto;
    }

    private ResultDto parseResultDto(JsonElement element) {
        ResultDto result = ResultDto.builder()
                .rows(parseProdutos(element.getAsJsonObject().get("rows").getAsJsonArray()))
                .build();

        return result;
    }

    private List<Produto> parseProdutos(JsonArray array) {
        List<Produto> produtos = new ArrayList<>();
        Integer id = 0;

        for (JsonElement element : array) {
            JsonObject object = element.getAsJsonObject();
            String imagem = object.get("imagem").getAsString().split("\",\"")[1];

            String content = imagem.split("\":\"")[1];
            content = content.substring(0, content.length() - 2);
            content = content.split(",")[1];
            content = content.replaceAll("\\\\", "");

            Produto produto = Produto.builder()
                    .id(id)
                    .descricaoProduto(object.get("dsc_produto").getAsString())
                    .categoriaProduto(CategoriaProduto.valueOf(object.get("dsc_produto_cat").getAsString().toUpperCase()))
                    .valor(object.get("valor").getAsBigDecimal())
                    .imagem(content)
                    .build();

            produtos.add(produto);
            id++;
        }

        return produtos;
    }

}
