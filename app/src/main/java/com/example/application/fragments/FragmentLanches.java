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

import java.util.List;
import java.util.stream.Collectors;

public class FragmentLanches extends Fragment {

    private GridView gridViewLanches;
    private CardapioViewModel cardapioViewModel;

    private LanchesAdapter lanchesAdapter;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        cardapioViewModel = ViewModelProviders.of(getActivity()).get(CardapioViewModel.class);

        cardapioViewModel.getProdutos().observe(this, new Observer<List<Produto>>() {
            @Override
            public void onChanged(List<Produto> produtos) {
                lanchesAdapter = new LanchesAdapter(getContext());
                lanchesAdapter.setLanches(produtos);
                lanchesAdapter.notifyDataSetChanged();
                gridViewLanches.setAdapter(lanchesAdapter);
            }
        });
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater,
                             @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.fragment_lanches, container, false);

        return v;
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        gridViewLanches = view.findViewById(R.id.GridViewLanches);

        ((CardapioActivity) getActivity()).updateLabelCart();
    }

    public class LanchesAdapter extends BaseAdapter {

        private Context context;
        private LayoutInflater inflater;

        private List<Produto> lanches;

        public LanchesAdapter(Context context) {
            this.context = context;
            inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        }

        @Override
        public int getCount() {
            return lanches.size();
        }

        @Override
        public Object getItem(int position) {
            return lanches.get(position);
        }

        @Override
        public long getItemId(int position) {
            return lanches.get(position).getId();
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

                if (!lanches.isEmpty()) {
                    image.setImageBitmap(decodeImageSrc(lanches.get(position)));
                    description.setText(lanches.get(position).getDescricaoProduto());
                    value.setText(Formatters.currencyFormat(lanches.get(position).getValor()));
                }

                v.setOnClickListener(click -> {
                    ((CardapioActivity) getActivity()).addItem(lanches.get(position));
                    ((CardapioActivity) getActivity()).updateLabelCart();
                });
            }

            return v;
        }

        private Bitmap decodeImageSrc(Produto bebida) {
            byte[] decodedString = Base64.decode(bebida.getImagem(), Base64.DEFAULT);

            return BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
        }

        public void setLanches(List<Produto> lanches) {
            this.lanches = lanches.stream()
                    .filter(p -> p.getCategoriaProduto() == CategoriaProduto.LANCHES)
                    .collect(Collectors.toList());
        }

    }

}
