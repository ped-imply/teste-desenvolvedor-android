package com.example.application;

import android.content.Context;
import android.os.AsyncTask;
import android.os.Build;

import androidx.room.Room;
import androidx.test.core.app.ApplicationProvider;

import com.example.application.data.database.TransacaoDatabase;
import com.example.application.data.model.Transacao;
import com.example.application.data.repository.TransacaoDao;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.robolectric.RobolectricTestRunner;
import org.robolectric.annotation.Config;

import java.math.BigDecimal;
import java.util.Date;

@RunWith(RobolectricTestRunner.class)
@Config(sdk = {Build.VERSION_CODES.O_MR1})
public class TransacaoInsertTest {

    private TransacaoDao dao;
    private TransacaoDatabase database;

    @Before
    public void createDatabase() {
        Context context = ApplicationProvider.getApplicationContext();
        database = Room.inMemoryDatabaseBuilder(context, TransacaoDatabase.class).build();
        dao = database.transacaoDao();
    }

    @After
    public void closeDatabase() {
        database.close();
    }

    @Test
    public void saveTransacao() {
        Transacao transacao = Transacao.builder()
                .id(1)
                .dataHoraCompra(new Date())
                .descricaoProduto("Teste")
                .quantidade(1)
                .valorUnitario(new BigDecimal(10))
                .valorTotal(new BigDecimal(10))
                .build();

        new AsyncTask<Void, Void, Void>() {
            @Override
            protected Void doInBackground(Void... voids) {
                dao.insertAll(transacao);
                return null;
            }
        };
    }

}
