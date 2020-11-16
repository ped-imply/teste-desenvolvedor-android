package com.example.application.data.service;

import com.example.application.data.model.Produto;
import com.example.application.data.model.ProdutoDto;
import com.google.gson.JsonObject;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;

public interface ProdutoService {

    @GET("produtos")
    Call<ProdutoDto> getAll();

}
