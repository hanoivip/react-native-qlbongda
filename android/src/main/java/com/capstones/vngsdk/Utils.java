package com.capstones.vngsdk;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import java.io.IOException;

public class Utils {
    public static void showAlert(Context context, String title, String message) {
        AlertDialog.Builder builder;
        if (Build.VERSION.SDK_INT >= 21) {
            builder = new AlertDialog.Builder(context, 16974374);
        } else {
            builder = new AlertDialog.Builder(context);
        }
        builder.setTitle(title).setMessage(message).setPositiveButton("OK", (DialogInterface.OnClickListener) null).show();
    }

    public static void showAlert(Context context, String title, String message, DialogInterface.OnClickListener block) {
        AlertDialog.Builder builder;
        if (Build.VERSION.SDK_INT >= 21) {
            builder = new AlertDialog.Builder(context, 16974374);
        } else {
            builder = new AlertDialog.Builder(context);
        }
        builder.setTitle(title).setMessage(message).setPositiveButton("OK", block).show();
    }

    public static Bitmap loadBitmap(Context context, String filePath) {
        try {
            return BitmapFactory.decodeStream(context.getAssets().open(filePath));
        } catch (IOException e) {
            return null;
        }
    }
}
