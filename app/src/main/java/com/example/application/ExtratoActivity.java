package com.example.application;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
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
    private RecyclerView recyclerView;

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

        recyclerView = findViewById(R.id.RecyclerExtrato);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));

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
            recyclerView.setAdapter(new ExtratoAdapter(this));

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

    public class ExtratoAdapter extends RecyclerView.Adapter {

        private Context context;
        private LayoutInflater inflater;

        public ExtratoAdapter(Context context) {
            this.context = context;
            inflater = LayoutInflater.from(context);
        }

        @NonNull
        @Override
        public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            View v = inflater.inflate(R.layout.row_extrato, parent, false);
            RecyclerView.ViewHolder vh = new ExtratosHolder(v);

            return vh;
        }

        @Override
        public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, int position) {
            Transacao t = transacoes.get(position);

            ExtratosHolder ih = (ExtratosHolder) holder;
            ih.labelItemExtrato.setText(t.getDescricaoProduto());
            ih.labelQtItemExtrato.setText(t.getQuantidade().toString());
            ih.labelValorUnitItemExtrato.setText(Formatters.currencyFormat(t.getValorUnitario()));
            ih.labelValorTotalItemExtrato.setText(Formatters.currencyFormat(t.getValorTotal()));
        }

        @Override
        public int getItemCount() {
            return transacoes.size();
        }

        public class ExtratosHolder extends RecyclerView.ViewHolder {

            private TextView labelItemExtrato;
            private TextView labelQtItemExtrato;
            private TextView labelValorUnitItemExtrato;
            private TextView labelValorTotalItemExtrato;

            public ExtratosHolder(@NonNull View itemView) {
                super(itemView);

                labelItemExtrato = itemView.findViewById(R.id.LabelItemExtrato);
                labelQtItemExtrato = itemView.findViewById(R.id.LabelQtItem);
                labelValorUnitItemExtrato = itemView.findViewById(R.id.LabelValorUnitItem);
                labelValorTotalItemExtrato = itemView.findViewById(R.id.LabelValorTotalExtrato);
            }

        }

    }

}