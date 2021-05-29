package com.example.cardapio_imply;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.lifecycle.Lifecycle;
import androidx.viewpager2.adapter.FragmentStateAdapter;

public class CardapioImply extends FragmentStateAdapter {
    public CardapioImply(@NonNull FragmentManager fragmentManager, @NonNull Lifecycle lifecycle) {
        super(fragmentManager, lifecycle);
    }

    @NonNull
    @Override
    public Fragment createFragment(int position) {

        switch (position)
        {
            case 1 :
                return new LanchesFragment();

        }

        return new BebidasFragment();
    }

    @Override
    public int getItemCount() {
        return 2;
    }
}
