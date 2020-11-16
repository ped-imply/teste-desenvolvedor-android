package com.example.application.data.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum CategoriaProduto {

    BEBIDAS("Bebida"),
    COMIDA("Comida"),
    LANCHES("Lanche");

    private String descricao;

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

}
