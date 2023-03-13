package com.example.teste_desenvolvedor_imply.database;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DBHelper extends SQLiteOpenHelper {
    private static final int DATABASE_VERSION = 1;
    private static final String DATABASE_NAME = "dbCompras.db";
    public static final String TABELA_COMPRAS = "compras";
    private static final String COLUNA_ID = "id";
    public static final String COLUNA_DATA_HORA_COMPRA = "data_hora_compra";
    public static final String COLUNA_DESCRICAO_PRODUTO = "descricao_produto";
    public static final String COLUNA_QUANTIDADE = "quantidade";
    public static final String COLUNA_VALOR_UNITARIO = "valor_unitario";
    public static final String COLUNA_VALOR_TOTAL = "valor_total";

    private static final String CRIAR_TABELA_COMPRAS = "CREATE TABLE " + TABELA_COMPRAS + "("
            + COLUNA_ID + " INTEGER PRIMARY KEY AUTOINCREMENT,"
            + COLUNA_DATA_HORA_COMPRA + " TEXT,"
            + COLUNA_DESCRICAO_PRODUTO + " TEXT,"
            + COLUNA_QUANTIDADE + " INTEGER,"
            + COLUNA_VALOR_UNITARIO + " REAL,"
            + COLUNA_VALOR_TOTAL + " REAL"
            + ")";

    public DBHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(CRIAR_TABELA_COMPRAS);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABELA_COMPRAS);
        onCreate(db);
    }
}
