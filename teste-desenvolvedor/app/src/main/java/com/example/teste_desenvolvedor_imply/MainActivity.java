package com.example.teste_desenvolvedor_imply;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.example.teste_desenvolvedor_imply.api.DataService;
import com.example.teste_desenvolvedor_imply.model.Imagem;
import com.example.teste_desenvolvedor_imply.model.Product;
import com.example.teste_desenvolvedor_imply.model.Response;
import com.google.gson.Gson;

import java.io.IOException;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class MainActivity extends AppCompatActivity {

    private Button buttonLanches;
    private Button buttonBebidas;
    private View activeLanches;
    private View activeBebidas;

    private Button buttonConfirmar;
    private List<Product> products;
    private Retrofit retrofit;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        retrofit = new Retrofit.Builder()
                .baseUrl("https://ah.we.imply.com/cashless/")
                .addConverterFactory(GsonConverterFactory.create())
                .build();
        recoverData();

        buttonBebidas = findViewById(R.id.buttonBebidas);
        buttonLanches = findViewById(R.id.buttonLanches);

        activeBebidas = findViewById(R.id.activeBebidas);
        activeLanches = findViewById(R.id.activeLanches);

        buttonConfirmar = findViewById(R.id.buttonConfirmar);

        buttonLanches.setOnClickListener(view -> {
            activeBebidas.setVisibility(View.INVISIBLE);
            activeLanches.setVisibility(View.VISIBLE);
        });

        buttonBebidas.setOnClickListener(view -> {
            activeLanches.setVisibility(View.INVISIBLE);
            activeBebidas.setVisibility(View.VISIBLE);
        });

        buttonConfirmar.setOnClickListener(view -> {
            System.out.println("Confirmar");
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
                    Gson gson = new Gson();
                    products = responseApi.getResult().getProducts();
                    for(int i = 0; i<products.size(); i++){
                        Imagem imagem = gson.fromJson(products.get(i).getImagem(), Imagem.class);
                        products.get(i).setDadosImagem(imagem);
                        Product product = products.get(i);

                        System.out.println("base64: "+product.getDadosImagem().getFilename());
                    }
                }
            }

            @Override
            public void onFailure(Call<Response> call, Throwable t) {

            }
        });

    }
}