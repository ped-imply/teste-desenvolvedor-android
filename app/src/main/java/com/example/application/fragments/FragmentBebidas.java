package com.example.application.fragments;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.util.Base64;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;

import com.example.application.CardapioActivity;
import com.example.application.R;
import com.example.application.data.model.CategoriaProduto;
import com.example.application.data.model.Produto;
import com.example.application.data.utils.Formatters;
import com.example.application.viewmodels.CardapioViewModel;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class FragmentBebidas extends Fragment {

    private GridView gridViewBebidas;
    private CardapioViewModel cardapioViewModel;

    private BebidasAdapter bebidasAdapter;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        cardapioViewModel = ViewModelProviders.of(getActivity()).get(CardapioViewModel.class);

        cardapioViewModel.getProdutos().observe(this, new Observer<List<Produto>>() {
            @Override
            public void onChanged(List<Produto> produtos) {
                bebidasAdapter = new BebidasAdapter(getContext());
                bebidasAdapter.setBebidas(produtos);
                bebidasAdapter.notifyDataSetChanged();
                gridViewBebidas.setAdapter(bebidasAdapter);
            }
        });
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater,
                             @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.fragment_bebidas, container, false);

        return v;
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        gridViewBebidas = view.findViewById(R.id.GridViewBebidas);

        ((CardapioActivity) getActivity()).updateLabelCart();
    }

    public class BebidasAdapter extends BaseAdapter {

        private Context context;
        private LayoutInflater inflater;

        private List<Produto> bebidas;

        public BebidasAdapter(Context context) {
            this.context = context;
            inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        }

        @Override
        public int getCount() {
            return bebidas.size();
        }

        @Override
        public Object getItem(int position) {
            return bebidas.get(position);
        }

        @Override
        public long getItemId(int position) {
            return bebidas.get(position).getId();
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            View v = convertView;

            if (v == null) {
                v = inflater.inflate(R.layout.fragment_bebidas, parent, false);
            } else {
                v = inflater.inflate(R.layout.row_item, null);
                ImageView image = v.findViewById(R.id.ImageViewItem);
                TextView description = v.findViewById(R.id.LabelItemDescription);
                TextView value = v.findViewById(R.id.LabelItemValue);

                if (!bebidas.isEmpty()) {
                    image.setImageBitmap(decodeImageSrc(bebidas.get(position)));
                    description.setText(bebidas.get(position).getDescricaoProduto());
                    value.setText(Formatters.currencyFormat(bebidas.get(position).getValor()));
                }

                v.setOnClickListener(click -> {
                    ((CardapioActivity) getActivity()).addItem(bebidas.get(position));
                    ((CardapioActivity) getActivity()).updateLabelCart();
                });
            }

            return v;
        }

        private Bitmap decodeImageSrc(Produto bebida) {
            byte[] decodedString = Base64.decode(bebida.getImagem(), Base64.DEFAULT);

            return BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
        }

        public void setBebidas(List<Produto> bebidas) {
            this.bebidas = bebidas.stream()
                    .filter(p -> p.getCategoriaProduto() == CategoriaProduto.BEBIDAS)
                    .collect(Collectors.toList());
        }

    }

}
