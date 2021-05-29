package com.example.cardapio_imply;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentPagerAdapter;
import androidx.viewpager2.widget.ViewPager2;

import android.os.Bundle;
import android.widget.Button;

import com.google.android.material.tabs.TabLayout;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class MainActivity extends AppCompatActivity {

    TabLayout tabLayout;
    ViewPager2 pager2;
    CardapioImply adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tabLayout = findViewById(R.id.tab_layout);
        pager2 = findViewById(R.id.view_pager2);

        FragmentManager fm = getSupportFragmentManager();
        adapter = new CardapioImply(fm, getLifecycle());
        pager2.setAdapter(adapter);

        tabLayout.addTab(tabLayout.newTab().setText("BEBIDAS"));
        tabLayout.addTab(tabLayout.newTab().setText("LANCHES"));

        tabLayout.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {
            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                pager2.setCurrentItem(tab.getPosition());
            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {

            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        });

        pager2.registerOnPageChangeCallback(new ViewPager2.OnPageChangeCallback() {
            @Override
            public void onPageSelected(int position) {
                tabLayout.selectTab(tabLayout.getTabAt(position));
            }
        });

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("https://ah.we.imply.com/cashless/produtos")
                .addConverterFactory(GsonConverterFactory.create())
                .build();
        ApiCall apiCall = retrofit.create(ApiCall.class);


        Call<DataModel> call = apiCall.getData();

        call.enqueue(new Callback<DataModel>() {
            @Override
            public void onResponse(Call<DataModel> call, Response<DataModel> response) {

                 //if (response.code() != 200) {
                    //txt.setText("Cheque a conexão");
                   // return;
               // }


                String jsony = "";

                jsony = "dsc_produto=" + response.body().getDsc_produto()+
                        "\n valor=" + response.body().getValor()+
                        "\n dsc_produto_cat" + response.body().getDsc_produto_cat()+
                        "\n imagem" + response.body().getImagem();

                //txt.append(jsony);


            }
            @Override
            public void onFailure(Call<DataModel> call, Throwable t) {

            }
        });






    }
}