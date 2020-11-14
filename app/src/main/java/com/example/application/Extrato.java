package com.example.application;

import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class Extrato extends AppCompatActivity {

    private Button buttonConfirm;
    private Button buttonCancel;
    private TextView labelTotalValue;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_extrato);

        initializeActivityComponents();
    }

    private void initializeActivityComponents() {
        buttonConfirm = findViewById(R.id.ButtonConfirmCart);
        buttonCancel = findViewById(R.id.ButtonCancel);
        labelTotalValue = findViewById(R.id.LabelCart);
    }

}