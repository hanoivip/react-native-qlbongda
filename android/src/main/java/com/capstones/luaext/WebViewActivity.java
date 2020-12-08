package com.capstones.luaext;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ImageButton;

import com.oh.zuqiu.vi.R;

import java.util.HashMap;
import java.util.Map;

public class WebViewActivity extends Activity {
    private WebView webView;

    /* access modifiers changed from: protected */
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.webview);
        ((ImageButton) findViewById(R.id.closeButton)).setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                WebViewActivity.this.finish();
            }
        });
        this.webView = (WebView) findViewById(R.id.webView);
        Intent intent = getIntent();
        String url = intent.getStringExtra("url");
        String userAgentAppend = intent.getStringExtra("userAgentAppend");
        final Map<String, String> httpAdditionalHeaders = new HashMap<>();
        for (int param_num = 1; intent.getStringExtra("httpHeadersKey" + param_num) != null; param_num++) {
            httpAdditionalHeaders.put(intent.getStringExtra("httpHeadersKey" + param_num), intent.getStringExtra("httpHeadersVal" + param_num));
        }
        if (userAgentAppend != null && !userAgentAppend.isEmpty()) {
            this.webView.getSettings().setUserAgentString(this.webView.getSettings().getUserAgentString() + " " + userAgentAppend);
        }
        this.webView.loadUrl(url, httpAdditionalHeaders);
        this.webView.getSettings().setJavaScriptEnabled(true);
        this.webView.setWebViewClient(new WebViewClient() {
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                if (url.startsWith("http:") || url.startsWith("https:")) {
                    view.loadUrl(url, httpAdditionalHeaders);
                    return super.shouldOverrideUrlLoading(view, url);
                }
                try {
                    WebViewActivity.this.startActivity(new Intent("android.intent.action.VIEW", Uri.parse(url)));
                    return true;
                } catch (Exception e) {
                    return false;
                }
            }
        });
    }
}
