package com.example.teste_desenvolvedor_imply.activity;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.example.teste_desenvolvedor_imply.R;
import com.example.teste_desenvolvedor_imply.adapter.ExtratoAdapter;
import com.example.teste_desenvolvedor_imply.adapter.ProductAdapter;
import com.example.teste_desenvolvedor_imply.model.Item;
import com.example.teste_desenvolvedor_imply.model.SelectedProducts;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class TelaExtrato extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tela_extrato);
        Gson gson = new Gson();

        Intent intent = getIntent();
        String itemString = intent.getStringExtra("products");
        SelectedProducts selectedProducts = gson.fromJson(itemString, SelectedProducts.class);

        RecyclerView recyclerView = findViewById(R.id.recyclerView);
        TextView textTotalExtrato = findViewById(R.id.textTotalExtrato);
        Button buttonCancelar = findViewById(R.id.buttonCancelar);


        recyclerView.setHasFixedSize(true);
        recyclerView.addItemDecoration(new DividerItemDecoration(this, LinearLayout.VERTICAL));
        RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(this);
        List<Item> listaItens = new ArrayList<>();
        listaItens.add(new Item("", 0.00));
        for(Item item : selectedProducts.getItens()){
            listaItens.add(item);
        }
        ExtratoAdapter extratoAdapter = new ExtratoAdapter(listaItens);
        recyclerView.setLayoutManager(layoutManager);
        recyclerView.setAdapter(extratoAdapter);

        textTotalExtrato.setText("R$ "+new DecimalFormat("0.00").format(selectedProducts.getValorTotal()).replace(".", ","));

        buttonCancelar.setOnClickListener(view -> {
            Intent intentMain = new Intent(TelaExtrato.this, MainActivity.class);
            startActivity(intentMain);
        });
    }
}