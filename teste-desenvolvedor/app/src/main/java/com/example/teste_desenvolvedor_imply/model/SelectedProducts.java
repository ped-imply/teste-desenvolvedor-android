package com.example.teste_desenvolvedor_imply.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class SelectedProducts implements Serializable {

    List<Item> itens;
    Double valorTotal;
    Integer quantidadeTotal;

    public SelectedProducts() {
        this.itens = new ArrayList<>();
        this.valorTotal = 0.00;
        this.quantidadeTotal = 0;
    }

    public List<Item> getItens() {
        return itens;
    }

    public void addItem(Item item){
        itens.add(item);
    }

    public void clearItens() {
        this.itens.clear();
    }

    public Double getValorTotal() {
        valorTotal = 0.00;
        for(Item item : itens){
            valorTotal += ((double) item.getQuantity()) * item.getUnitaryValue();
        }

        return valorTotal;
    }

    public Integer getQuantidadeTotal() {
        quantidadeTotal = 0;
        for(Item item : itens){
            quantidadeTotal += item.getQuantity();
        }
        return quantidadeTotal;
    }

}
