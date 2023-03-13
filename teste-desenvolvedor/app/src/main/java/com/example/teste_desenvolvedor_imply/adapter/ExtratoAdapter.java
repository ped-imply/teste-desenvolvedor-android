package com.example.teste_desenvolvedor_imply.adapter;

import android.graphics.Typeface;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.teste_desenvolvedor_imply.R;
import com.example.teste_desenvolvedor_imply.model.Item;

import java.text.DecimalFormat;
import java.util.List;

public class ExtratoAdapter extends RecyclerView.Adapter<ExtratoAdapter.ViewHolder> {

    private List<Item> itemList;
    public class ViewHolder extends RecyclerView.ViewHolder {
        TextView itemTextView;
        TextView quantityTextView;
        TextView unitPriceTextView;
        TextView totalPriceTextView;

        public ViewHolder(@NonNull View view) {
            super(view);
            itemTextView = view.findViewById(R.id.textName);
            quantityTextView = view.findViewById(R.id.textQtde);
            unitPriceTextView = view.findViewById(R.id.textUnit);
            totalPriceTextView = view.findViewById(R.id.textTotal);
        }
    }

    public ExtratoAdapter(List<Item> itemList){
        this.itemList = itemList;
    }

    @NonNull
    @Override
    public ExtratoAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.recycler_view_item_product, parent, false);
        return new ViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(@NonNull ExtratoAdapter.ViewHolder holder, int position) {
        Item item = itemList.get(position);

        // Se a posição for 0, a linha é a primeira e deve ser exibida em negrito
        if (position == 0) {
            holder.itemTextView.setTypeface(null, Typeface.BOLD_ITALIC);
            holder.quantityTextView.setTypeface(null, Typeface.BOLD_ITALIC);
            holder.unitPriceTextView.setTypeface(null, Typeface.BOLD_ITALIC);
            holder.totalPriceTextView.setTypeface(null, Typeface.BOLD_ITALIC);
            holder.itemTextView.setText("Item");
            holder.quantityTextView.setText("Qtde");
            holder.unitPriceTextView.setText("Unit.");
            holder.totalPriceTextView.setText("Total");
        } else {
            holder.itemTextView.setTypeface(null, Typeface.NORMAL);
            holder.quantityTextView.setTypeface(null, Typeface.NORMAL);
            holder.unitPriceTextView.setTypeface(null, Typeface.NORMAL);
            holder.totalPriceTextView.setTypeface(null, Typeface.NORMAL);
            holder.itemTextView.setText(item.getName());
            holder.quantityTextView.setText(item.getQuantity().toString());
            holder.unitPriceTextView.setText(new DecimalFormat("0.00").format(item.getUnitaryValue()).replace(".", ","));
            holder.totalPriceTextView.setText(new DecimalFormat("0.00").format((item.getQuantity()*item.getUnitaryValue())).replace(".", ","));
        }

       }

    @Override
    public int getItemCount() {
        return itemList.size();
    }
}
