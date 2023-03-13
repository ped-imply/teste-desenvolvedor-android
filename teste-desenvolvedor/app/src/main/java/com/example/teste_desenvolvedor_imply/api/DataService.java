package com.example.teste_desenvolvedor_imply.api;

import com.example.teste_desenvolvedor_imply.model.Response;

import retrofit2.Call;
import retrofit2.http.GET;

public interface DataService {

    @GET("produtos")
    Call<Response> recoverData();
}
