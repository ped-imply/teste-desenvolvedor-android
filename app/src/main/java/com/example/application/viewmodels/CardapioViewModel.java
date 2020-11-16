package com.example.application.viewmodels;

import android.util.Log;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.example.application.data.model.Produto;
import com.example.application.data.model.ProdutoDto;
import com.example.application.data.rest.RetrofitConfiguration;
import com.example.application.data.service.ProdutoService;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class CardapioViewModel extends ViewModel {

    private static final String TAG = CardapioViewModel.class.getName();
    private MutableLiveData<List<Produto>> produtos;

    public LiveData<List<Produto>> getProdutos() {
        if (produtos == null) {
            produtos = new MutableLiveData<>();
            getList();
        }

        return produtos;
    }

    private void getList() {
        ProdutoService produtoService = new RetrofitConfiguration().getProdutoService();
        Call<ProdutoDto> object = produtoService.getAll();

        object.enqueue(new Callback<ProdutoDto>() {
            @Override
            public void onResponse(Call<ProdutoDto> call, Response<ProdutoDto> response) {
                ProdutoDto dto = response.body();
                produtos.setValue(dto.getResult().getRows());
            }

            @Override
            public void onFailure(Call<ProdutoDto> call, Throwable t) {
                Log.e(TAG, t.getMessage());
            }
        });
    }

}
