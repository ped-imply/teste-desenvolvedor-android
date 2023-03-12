package com.example.teste_desenvolvedor_imply;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    private Button buttonLanches;
    private Button buttonBebidas;
    private View activeLanches;
    private View activeBebidas;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        buttonBebidas = findViewById(R.id.buttonBebidas);
        buttonLanches = findViewById(R.id.buttonLanches);

        activeBebidas = findViewById(R.id.activeBebidas);
        activeLanches = findViewById(R.id.activeLanches);

        buttonLanches.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                System.out.println("Lanches");
                activeBebidas.setVisibility(View.INVISIBLE);
                activeLanches.setVisibility(View.VISIBLE);
            }
        });

        buttonBebidas.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                System.out.println("Bebidas");
                activeLanches.setVisibility(View.INVISIBLE);
                activeBebidas.setVisibility(View.VISIBLE);
            }
        });
    }
}