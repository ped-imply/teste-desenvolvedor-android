package com.example.application.data.database;

import androidx.room.Database;
import androidx.room.RoomDatabase;
import androidx.room.TypeConverters;

import com.example.application.data.model.Transacao;
import com.example.application.data.repository.TransacaoDao;
import com.example.application.data.utils.Converters;

@Database(entities = {Transacao.class}, version = 1)
@TypeConverters({Converters.class})
public abstract class TransacaoDatabase extends RoomDatabase {

    public abstract TransacaoDao transacaoDao();

}
