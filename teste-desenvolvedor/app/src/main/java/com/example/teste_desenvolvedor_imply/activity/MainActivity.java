package com.example.teste_desenvolvedor_imply.activity;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.GridView;
import android.widget.TextView;
import android.widget.Toast;

import com.example.teste_desenvolvedor_imply.R;
import com.example.teste_desenvolvedor_imply.adapter.ProductAdapter;
import com.example.teste_desenvolvedor_imply.api.DataService;
import com.example.teste_desenvolvedor_imply.model.Imagem;
import com.example.teste_desenvolvedor_imply.model.Item;
import com.example.teste_desenvolvedor_imply.model.Product;
import com.example.teste_desenvolvedor_imply.model.Response;
import com.example.teste_desenvolvedor_imply.model.SelectedProducts;
import com.google.gson.Gson;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class MainActivity extends AppCompatActivity {

    private GridView gridView;
    private List<Product> products;
    private List<Product> bebidas;
    private List<Product> lanches;
    private SelectedProducts selectedProducts;
    private String chosenTab;
    private Retrofit retrofit;
    private Gson gson;

    @SuppressLint("SetTextI18n")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        gson = new Gson();

        Button buttonBebidas = findViewById(R.id.buttonBebidas);
        Button buttonLanches = findViewById(R.id.buttonLanches);
        Button buttonConfirmar = findViewById(R.id.buttonConfirmar);
        Button buttonLimpar = findViewById(R.id.buttonLimpar);
        TextView textItens = findViewById(R.id.textItens);
        TextView textTotalValue = findViewById(R.id.textTotalValue);
        View activeBebidas = findViewById(R.id.activeBebidas);
        View activeLanches = findViewById(R.id.activeLanches);
        gridView = findViewById(R.id.gridView);

        bebidas = new ArrayList<>();
        lanches = new ArrayList<>();
        selectedProducts = new SelectedProducts();

        retrofit = new Retrofit.Builder()
                .baseUrl("https://ah.we.imply.com/cashless/")
                .addConverterFactory(GsonConverterFactory.create())
                .build();
        recoverData();

        buttonLanches.setOnClickListener(view -> {
            activeBebidas.setVisibility(View.INVISIBLE);
            activeLanches.setVisibility(View.VISIBLE);

            ProductAdapter adapter = new ProductAdapter(lanches,getApplicationContext());
            gridView.setAdapter(adapter);
            chosenTab = "Lanches";
        });

        buttonBebidas.setOnClickListener(view -> {
            activeLanches.setVisibility(View.INVISIBLE);
            activeBebidas.setVisibility(View.VISIBLE);

            ProductAdapter adapter = new ProductAdapter(bebidas,getApplicationContext());
            gridView.setAdapter(adapter);
            chosenTab = "Bebidas";
        });

        buttonConfirmar.setOnClickListener(view -> {
            if(selectedProducts.getItens().size()>=1){
                Intent intent = new Intent(MainActivity.this, TelaExtrato.class);
                intent.putExtra("products", gson.toJson(selectedProducts));
                startActivity(intent);
            }else
                Toast.makeText(getApplicationContext(), "Você precisa adicionar pelo menos 1 item em sua lista!", Toast.LENGTH_SHORT).show();
        });

        buttonLimpar.setOnClickListener(view -> {
            selectedProducts.clearItens();
            textTotalValue.setText("R$ 0,00");
            textItens.setText("0 ITENS");
        });

        gridView.setOnItemClickListener((parent, view, position, id) -> {
            Product product;
            if(chosenTab.contains("Bebidas"))
                product = bebidas.get(position);
            else
                product = lanches.get(position);

            boolean found = false;
            for (Item item : selectedProducts.getItens()) {
                if (item.getName().equals(product.getDsc_produto())) {
                    item.addQuantity();
                    found = true;
                    break;
                }
            }
            if (!found) {
                selectedProducts.addItem(new Item(product.getDsc_produto(), Double.parseDouble(product.getValor())));
            }

            textTotalValue.setText("R$ "+new DecimalFormat("0.00").format(selectedProducts.getValorTotal()).replace(".", ","));
            textItens.setText(selectedProducts.getQuantidadeTotal()+" ITENS");
        });

    }

    private void recoverData(){

        DataService service = retrofit.create(DataService.class);
        Call<Response> call = service.recoverData();

        call.enqueue(new Callback<Response>() {
            @Override
            public void onResponse(Call<Response> call, retrofit2.Response<Response> response) {
                if(response.isSuccessful()){
                    Response responseApi = response.body();
                    products = responseApi.getResult().getProducts();

                    for(int i = 0; i<products.size(); i++){
                        Imagem imagem = gson.fromJson(products.get(i).getImagem(), Imagem.class);
                        products.get(i).setDadosImagem(imagem);

                        Product product = products.get(i);
                        if(product.getDsc_produto_cat().contains("Bebidas"))
                            bebidas.add(product);
                        if(product.getDsc_produto_cat().contains("Lanches"))
                            lanches.add(product);
                    }

                    chosenTab = "Bebidas";
                    ProductAdapter adapter = new ProductAdapter(bebidas,getApplicationContext());
                    gridView.setAdapter(adapter);

                }
            }

            @Override
            public void onFailure(Call<Response> call, Throwable t) {

            }
        });

    }
}