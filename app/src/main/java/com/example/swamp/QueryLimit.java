package com.example.swamp;

import android.app.Activity;
import android.os.Bundle;
import android.provider.MediaStore;
import android.widget.Toast;

import androidx.annotation.Nullable;

public class QueryLimit extends Activity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    protected void onResume() {
        super.onResume();

        try {
            getApplicationContext().getContentResolver().query(
                    MediaStore.Files.getContentUri("external"),
                    new String[]{MediaStore.MediaColumns.DATA},
                    MediaStore.MediaColumns.DATA + " like ?",
                    new String[]{"%dummy123%"},
                    MediaStore.MediaColumns._ID + " limit 1");
        } catch (Throwable t) {
            t.printStackTrace();
            Toast.makeText(this, t.getMessage(), Toast.LENGTH_LONG).show();
            return;
        }

        Toast.makeText(this, "query ok", Toast.LENGTH_LONG).show();
    }
}
