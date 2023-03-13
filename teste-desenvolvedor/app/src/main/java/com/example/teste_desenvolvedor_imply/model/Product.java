package com.example.teste_desenvolvedor_imply.model;

public class Product {

    private String dsc_produto;
    private String valor;
    private String dsc_produto_cat;
    private String imagem;
    private Imagem dadosImagem;


    public String getDsc_produto() {
        return dsc_produto;
    }

    public void setDsc_produto(String dsc_produto) {
        this.dsc_produto = dsc_produto;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public String getDsc_produto_cat() {
        return dsc_produto_cat;
    }

    public void setDsc_produto_cat(String dsc_produto_cat) {
        this.dsc_produto_cat = dsc_produto_cat;
    }

    public String getImagem() {
        return imagem;
    }

    public void setImagem(String imagem) {
        this.imagem = imagem;
    }

    public Imagem getDadosImagem() {
        return dadosImagem;
    }

    public void setDadosImagem(Imagem dadosImagem) {
        this.dadosImagem = dadosImagem;
    }
}
