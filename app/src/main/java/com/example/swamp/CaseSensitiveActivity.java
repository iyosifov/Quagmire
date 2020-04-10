package com.example.swamp;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Environment;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.Arrays;

import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

public class CaseSensitiveActivity extends Activity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    protected void onResume() {
        super.onResume();


        if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this,
                    new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE},
                    42);
            return;
        }

        File root = new File(Environment.getExternalStorageDirectory(), "case-test-dir");
        root.mkdir();

        File low = new File(root, "aaa.txt");
        File high = new File(root, "AAA.txt");

        writeStr(low, "aaa");
        writeStr(high, "AAA");

        String s = "";
        s += read(low) + " " + read(high) + "\n";
        s += String.join("\n", Arrays.asList(root.list()));
        Toast.makeText(this, s, Toast.LENGTH_LONG).show();
    }

    private static void writeStr(File f, String s) {
        try (OutputStream out = new FileOutputStream(f);
             OutputStreamWriter osw = new OutputStreamWriter(out))
        {
            osw.write(s+"\n");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static String read(File f) {
        try (InputStream in = new FileInputStream(f);
             InputStreamReader isr = new InputStreamReader(in);
             BufferedReader br = new BufferedReader(isr))
        {
            return br.readLine();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
