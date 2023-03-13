package com.example.teste_desenvolvedor_imply.model;

public class SelectedProducts {

    private String name;
    private Integer quantity;
    private Double unitaryValue;

    public SelectedProducts(String name, Double unitaryValue) {
        this.name = name;
        this.quantity = 1;
        this.unitaryValue = unitaryValue;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void addQuantity() {
        this.quantity += 1;
    }

    public Double getUnitaryValue() {
        return unitaryValue;
    }

    public void setUnitaryValue(Double unitaryValue) {
        this.unitaryValue = unitaryValue;
    }
}
