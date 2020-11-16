package com.example.application.data.repository;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;

import com.example.application.data.model.Transacao;

@Dao
public interface TransacaoDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insertAll(Transacao... transacoes);

}
