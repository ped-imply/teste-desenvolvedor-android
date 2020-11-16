package com.example.application.data.model;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity(tableName = "transacoes")
public class Transacao implements Serializable {

    @PrimaryKey(autoGenerate = true)
    private Integer id;
    @ColumnInfo(name = "data_hora_compra")
    private Date dataHoraCompra;
    @ColumnInfo(name = "descricao_produto")
    private String descricaoProduto;
    @ColumnInfo(name = "quantidade")
    private Integer quantidade;
    @ColumnInfo(name = "valor_unitario")
    private BigDecimal valorUnitario;
    @ColumnInfo(name = "valor_total")
    private BigDecimal valorTotal;

}
