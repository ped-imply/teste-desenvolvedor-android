package com.example.cardapio_imply;

import retrofit2.Call;
import retrofit2.http.GET;

public interface ApiCall {

    @GET("20210529114807")
    Call<DataModel> getData();

}
