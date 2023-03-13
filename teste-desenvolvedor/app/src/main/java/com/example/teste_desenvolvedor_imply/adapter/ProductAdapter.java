package com.example.teste_desenvolvedor_imply.adapter;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.teste_desenvolvedor_imply.R;
import com.example.teste_desenvolvedor_imply.model.Product;

import java.text.DecimalFormat;
import java.util.List;

public class ProductAdapter extends BaseAdapter {

        private final List<Product> products;
        private final Context context;

        public ProductAdapter(List<Product> product, Context context) {
            this.products = product;
            this.context = context;
        }

        @Override
        public int getCount() {
            return products.size();
        }

        @Override
        public Object getItem(int position) {
            return products.get(position);
        }

        @Override
        public long getItemId(int position) {
            return position;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            View view = convertView;

            if (view == null) {
                view = LayoutInflater.from(context).inflate(R.layout.grid_item_product, parent, false);
            }

            TextView textDscProduto = view.findViewById(R.id.textDescProduto);
            ImageView imageView = view.findViewById(R.id.imageView);
            TextView textValor = view.findViewById(R.id.textValor);

            Product product = products.get(position);

            //decodificando a string base64 em um objeto Bitmap
            byte[] decodedString = Base64.decode(product.getDadosImagem().getContent().substring(product.getDadosImagem().getContent().indexOf(",") + 1), Base64.DEFAULT);
            Bitmap decodedByte = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
            imageView.setImageBitmap(decodedByte);

            textDscProduto.setText(product.getDsc_produto());
            String valor = "R$ "+new DecimalFormat("0.00").format(Double.parseDouble(product.getValor()));
            textValor.setText(valor.replace(".", ","));

            return view;
        }

}
