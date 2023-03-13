package com.example.teste_desenvolvedor_imply.activity;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.teste_desenvolvedor_imply.R;
import com.example.teste_desenvolvedor_imply.adapter.ExtratoAdapter;
import com.example.teste_desenvolvedor_imply.database.DBHelper;
import com.example.teste_desenvolvedor_imply.model.Item;
import com.example.teste_desenvolvedor_imply.model.SelectedProducts;
import com.google.gson.Gson;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
        Button buttonConfirmar = findViewById(R.id.buttonConfirmar);

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

        buttonConfirmar.setOnClickListener(view -> {
            String dataHoraCompra = Calendar.getInstance().getTime().toString();

            DBHelper dbHelper = new DBHelper(this);
            SQLiteDatabase db = dbHelper.getWritableDatabase();
            for(Item item : selectedProducts.getItens()){
                db.beginTransaction();
                try {
                    String sql = "INSERT INTO " + DBHelper.TABELA_COMPRAS + " ("
                            + DBHelper.COLUNA_DATA_HORA_COMPRA + ", "
                            + DBHelper.COLUNA_DESCRICAO_PRODUTO + ", "
                            + DBHelper.COLUNA_QUANTIDADE + ", "
                            + DBHelper.COLUNA_VALOR_UNITARIO + ", "
                            + DBHelper.COLUNA_VALOR_TOTAL + ") VALUES (?, ?, ?, ?, ?)";
                    Object[] bindArgs = {dataHoraCompra, item.getName(), item.getQuantity(), item.getUnitaryValue(), (item.getQuantity()*item.getUnitaryValue())};
                    db.execSQL(sql, bindArgs);
                    db.setTransactionSuccessful();
                } finally {
                    db.endTransaction();
                }
            }
            db.close();

            Toast.makeText(getApplicationContext(), "Lista de Compras Salva", Toast.LENGTH_SHORT).show();

            Intent intentMain = new Intent(TelaExtrato.this, MainActivity.class);
            startActivity(intentMain);
        });
    }
}