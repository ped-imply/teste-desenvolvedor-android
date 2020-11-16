package com.example.application;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.room.Room;

import com.example.application.data.database.TransacaoDatabase;
import com.example.application.data.model.Produto;
import com.example.application.data.model.Transacao;
import com.example.application.data.utils.Formatters;
import com.google.android.material.snackbar.Snackbar;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class ExtratoActivity extends AppCompatActivity {

    private Button buttonConfirm;
    private Button buttonCancel;
    private TextView labelTotalValue;

    private TransacaoDatabase database;

    private List<Produto> itens;
    private List<Transacao> transacoes;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_extrato);

        itens = (List<Produto>) getIntent().getSerializableExtra("itens");

        initializeDatabase();
        initializeActivityComponents();
    }

    private void initializeDatabase() {
        database = Room.databaseBuilder(getApplicationContext(),
                TransacaoDatabase.class,
                "database")
                .allowMainThreadQueries()
                .build();
    }

    private void initializeActivityComponents() {
        buttonConfirm = findViewById(R.id.ButtonConfirmCart);
        buttonCancel = findViewById(R.id.ButtonCancel);
        labelTotalValue = findViewById(R.id.LabelCartTotal);

        buttonConfirm.setOnClickListener(click -> {
            if (transacoes != null)
                insertTransacoes();
            else
                Snackbar.make(findViewById(R.id.ConstraintExtrato),
                        R.string.toast_empty_cart,
                        Snackbar.LENGTH_LONG).show();
        });

        buttonCancel.setOnClickListener(click -> {
            finish();
        });

        if (itens != null) {
            transacoes = convertForTransacao();

            labelTotalValue.setText
                    (String.format("%s", Formatters.currencyFormat
                            (transacoes.stream()
                                    .map(Transacao::getValorTotal)
                                    .reduce(BigDecimal.ZERO, BigDecimal::add))));
        } else {
            labelTotalValue.setText
                    (String.format("%s", Formatters.currencyFormat(new BigDecimal(0))));
        }
    }

    private void insertTransacoes() {
        try {
            Transacao[] array = transacoes.toArray(new Transacao[transacoes.size()]);
            database.transacaoDao().insertAll(array);

            Intent i = new Intent(this, CardapioActivity.class);
            i.putExtra("inserted", true);
            startActivity(i);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private List<Transacao> convertForTransacao() {
        List<Transacao> listTransacoes = new ArrayList<>();

        while (!itens.isEmpty()) {
            Stream<Produto> stream = itens.stream().filter(i -> i.equals(itens.get(0)));
            List<Produto> produtos = stream.collect(Collectors.toList());

            Transacao transacao = new Transacao();
            transacao.setDataHoraCompra(Calendar.getInstance().getTime());
            transacao.setDescricaoProduto(produtos.get(0).getDescricaoProduto());
            transacao.setValorUnitario(produtos.get(0).getValor());

            transacao.setQuantidade(produtos.size());
            transacao.setValorTotal(produtos.stream()
                    .map(Produto::getValor)
                    .reduce(BigDecimal.ZERO, BigDecimal::add));

            listTransacoes.add(transacao);
            itens.removeAll(produtos);
        }

        return listTransacoes;
    }

}