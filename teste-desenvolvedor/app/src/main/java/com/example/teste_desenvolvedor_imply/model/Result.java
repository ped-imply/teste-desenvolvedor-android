package com.example.teste_desenvolvedor_imply.model;

import java.util.List;

public class Result {

    private List<Product> rows;

    public List<Product> getProducts() {
        return rows;
    }

    public void setProducts(List<Product> product) {
        this.rows = product;
    }
}
