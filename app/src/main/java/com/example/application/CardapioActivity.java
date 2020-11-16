package com.example.application;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager.widget.ViewPager;

import com.example.application.data.model.Produto;
import com.example.application.data.utils.Formatters;
import com.example.application.ui.main.SectionsPagerAdapter;
import com.google.android.material.snackbar.Snackbar;
import com.google.android.material.tabs.TabLayout;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class CardapioActivity extends AppCompatActivity {

    private TextView labelCart;
    private Button buttonClear;
    private Button buttonConfirm;

    private boolean inserted;
    private List<Produto> itens;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        SectionsPagerAdapter sectionsPagerAdapter
                = new SectionsPagerAdapter(this, getSupportFragmentManager());
        ViewPager viewPager = findViewById(R.id.ViewPagerTabs);
        viewPager.setAdapter(sectionsPagerAdapter);

        TabLayout tabs = findViewById(R.id.tabs);
        tabs.setupWithViewPager(viewPager);

        itens = new ArrayList<>();
        initializeActivityComponents();
    }

    private void initializeActivityComponents() {
        inserted = getIntent().getBooleanExtra("inserted", false);
        labelCart = findViewById(R.id.LabelCart);
        buttonClear = findViewById(R.id.ButtonClear);
        buttonConfirm = findViewById(R.id.ButtonConfirm);

        buttonClear.setOnClickListener(click -> {
            itens.clear();
            updateLabelCart();
        });

        buttonConfirm.setOnClickListener(click -> {
            Intent i = new Intent(this, ExtratoActivity.class);

            if (!itens.isEmpty())
                i.putExtra("itens", (Serializable) itens);

            startActivity(i);
        });

        if (inserted)
            showSnackbarSuccess();
    }

    public void updateLabelCart() {
        if (itens.isEmpty())
            labelCart.setText(String.format("%s  | %s",
                    Formatters.currencyFormat(null), "0 itens"));

        else
            labelCart.setText(String.format("%s  | %s itens",
                    Formatters.currencyFormat(itens.stream()
                            .map(Produto::getValor)
                            .reduce(BigDecimal.ZERO, BigDecimal::add)),
                    itens.size()));
    }

    public void showSnackbarSuccess() {
        Snackbar.make(findViewById(R.id.CoordinatorLayout),
                R.string.toast_success,
                Snackbar.LENGTH_LONG)
                .show();
    }

    public void addItem(Produto item) {
        itens.add(item);
    }

}