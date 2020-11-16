package com.example.application.data.model;

import java.io.Serializable;
import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Produto implements Serializable {

    private Integer id;
    private String descricaoProduto;
    private CategoriaProduto categoriaProduto;
    private BigDecimal valor;
    private String imagem;

}
