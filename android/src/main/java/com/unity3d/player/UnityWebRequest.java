package com.unity3d.player;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.CookieHandler;
import java.net.CookieManager;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLConnection;
import java.net.UnknownHostException;
import java.nio.ByteBuffer;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.security.cert.CertPathValidatorException;
import java.util.List;
import java.util.Map;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLException;
import javax.net.ssl.SSLKeyException;
import javax.net.ssl.SSLPeerUnverifiedException;
import javax.net.ssl.SSLSocketFactory;

class UnityWebRequest implements Runnable {

    /* renamed from: a */
    private long f131a;

    /* renamed from: b */
    private String f132b;

    /* renamed from: c */
    private String f133c;

    /* renamed from: d */
    private Map<String, String> f134d;

    /* renamed from: e */
    private int f135e;

    /* renamed from: f */
    private long f136f;

    static {
        if (CookieHandler.getDefault() == null) {
            CookieHandler.setDefault(new CookieManager());
        }
    }

    UnityWebRequest(long j, String str, Map map, String str2, int i) {
        this.f131a = j;
        this.f132b = str2;
        this.f133c = str;
        this.f134d = map;
        this.f135e = i;
    }

    private static native void contentLengthCallback(long j, int i);

    private static native boolean downloadCallback(long j, ByteBuffer byteBuffer, int i);

    private static native void errorCallback(long j, int i, String str);

    private boolean hasTimedOut() {
        return this.f135e > 0 && System.currentTimeMillis() - this.f136f >= ((long) this.f135e);
    }

    private static native void headerCallback(long j, String str, String str2);

    private static native void responseCodeCallback(long j, int i);

    private void runSafe() {
        InputStream inputStream;
        SSLSocketFactory a;
        this.f136f = System.currentTimeMillis();
        try {
            URL url = new URL(this.f132b);
            URLConnection openConnection = url.openConnection();
            openConnection.setConnectTimeout(this.f135e);
            openConnection.setReadTimeout(this.f135e);
            if ((openConnection instanceof HttpsURLConnection) && (a = C0041a.m98a()) != null) {
                ((HttpsURLConnection) openConnection).setSSLSocketFactory(a);
            }
            if (!url.getProtocol().equalsIgnoreCase("file") || url.getHost().isEmpty()) {
                if (openConnection instanceof HttpURLConnection) {
                    try {
                        HttpURLConnection httpURLConnection = (HttpURLConnection) openConnection;
                        httpURLConnection.setRequestMethod(this.f133c);
                        httpURLConnection.setInstanceFollowRedirects(false);
                    } catch (ProtocolException e) {
                        badProtocolCallback(e.toString());
                        return;
                    }
                }
                if (this.f134d != null) {
                    for (Map.Entry entry : this.f134d.entrySet()) {
                        openConnection.addRequestProperty((String) entry.getKey(), (String) entry.getValue());
                    }
                }
                ByteBuffer allocateDirect = ByteBuffer.allocateDirect(131072);
                if (uploadCallback((ByteBuffer) null) > 0) {
                    openConnection.setDoOutput(true);
                    try {
                        OutputStream outputStream = openConnection.getOutputStream();
                        int uploadCallback = uploadCallback(allocateDirect);
                        while (uploadCallback > 0) {
                            if (hasTimedOut()) {
                                outputStream.close();
                                errorCallback(this.f131a, 14, "WebRequest timed out.");
                                return;
                            }
                            outputStream.write(allocateDirect.array(), allocateDirect.arrayOffset(), uploadCallback);
                            uploadCallback = uploadCallback(allocateDirect);
                        }
                    } catch (Exception e2) {
                        errorCallback(e2.toString());
                        return;
                    }
                }
                if (openConnection instanceof HttpURLConnection) {
                    try {
                        responseCodeCallback(((HttpURLConnection) openConnection).getResponseCode());
                    } catch (UnknownHostException e3) {
                        unknownHostCallback(e3.toString());
                        return;
                    } catch (SSLException e4) {
                        sslCannotConnectCallback(e4);
                        return;
                    } catch (SocketTimeoutException e5) {
                        errorCallback(this.f131a, 14, e5.toString());
                        return;
                    } catch (IOException e6) {
                        errorCallback(e6.toString());
                        return;
                    }
                }
                Map<String, List<String>> headerFields = openConnection.getHeaderFields();
                headerCallback(headerFields);
                if ((headerFields == null || !headerFields.containsKey("content-length")) && openConnection.getContentLength() != -1) {
                    headerCallback("content-length", String.valueOf(openConnection.getContentLength()));
                }
                if ((headerFields == null || !headerFields.containsKey("content-type")) && openConnection.getContentType() != null) {
                    headerCallback("content-type", openConnection.getContentType());
                }
                contentLengthCallback(openConnection.getContentLength());
                try {
                    if (openConnection instanceof HttpURLConnection) {
                        HttpURLConnection httpURLConnection2 = (HttpURLConnection) openConnection;
                        responseCodeCallback(httpURLConnection2.getResponseCode());
                        inputStream = httpURLConnection2.getErrorStream();
                    } else {
                        inputStream = null;
                    }
                    if (inputStream == null) {
                        inputStream = openConnection.getInputStream();
                    }
                    ReadableByteChannel newChannel = Channels.newChannel(inputStream);
                    int read = newChannel.read(allocateDirect);
                    while (read != -1) {
                        if (!hasTimedOut()) {
                            if (!downloadCallback(allocateDirect, read)) {
                                break;
                            }
                            allocateDirect.clear();
                            read = newChannel.read(allocateDirect);
                        } else {
                            newChannel.close();
                            errorCallback(this.f131a, 14, "WebRequest timed out.");
                            return;
                        }
                    }
                    newChannel.close();
                } catch (UnknownHostException e7) {
                    unknownHostCallback(e7.toString());
                } catch (SSLException e8) {
                    sslCannotConnectCallback(e8);
                } catch (SocketTimeoutException e9) {
                    errorCallback(this.f131a, 14, e9.toString());
                } catch (IOException e10) {
                    errorCallback(this.f131a, 14, e10.toString());
                } catch (Exception e11) {
                    errorCallback(e11.toString());
                }
            } else {
                malformattedUrlCallback("file:// must use an absolute path");
            }
        } catch (MalformedURLException e12) {
            malformattedUrlCallback(e12.toString());
        } catch (IOException e13) {
            errorCallback(e13.toString());
        }
    }

    private static native int uploadCallback(long j, ByteBuffer byteBuffer);

    /* access modifiers changed from: protected */
    public void badProtocolCallback(String str) {
        errorCallback(this.f131a, 4, str);
    }

    /* access modifiers changed from: protected */
    public void contentLengthCallback(int i) {
        contentLengthCallback(this.f131a, i);
    }

    /* access modifiers changed from: protected */
    public boolean downloadCallback(ByteBuffer byteBuffer, int i) {
        return downloadCallback(this.f131a, byteBuffer, i);
    }

    /* access modifiers changed from: protected */
    public void errorCallback(String str) {
        errorCallback(this.f131a, 2, str);
    }

    /* access modifiers changed from: protected */
    public void headerCallback(String str, String str2) {
        headerCallback(this.f131a, str, str2);
    }

    /* access modifiers changed from: protected */
    public void headerCallback(Map<String,List<String>> map) {
        if (map != null && map.size() != 0) {
            for (Map.Entry entry : map.entrySet()) {
                String str = (String) entry.getKey();
                if (str == null) {
                    str = "Status";
                }
                for (String headerCallback : (List<String>) entry.getValue()) {
                    headerCallback(str, headerCallback);
                }
            }
        }
    }

    /* access modifiers changed from: protected */
    public void malformattedUrlCallback(String str) {
        errorCallback(this.f131a, 5, str);
    }

    /* access modifiers changed from: protected */
    public void responseCodeCallback(int i) {
        responseCodeCallback(this.f131a, i);
    }

    public void run() {
        try {
            runSafe();
        } catch (Exception e) {
            errorCallback(e.toString());
        }
    }

    /* access modifiers changed from: protected */
    public void sslCannotConnectCallback(SSLException sSLException) {
        String sSLException2 = sSLException.toString();
        int i = 16;
        Throwable th = sSLException;
        while (true) {
            if (th == null) {
                break;
            } else if (th instanceof SSLKeyException) {
                i = 23;
                break;
            } else if ((th instanceof SSLPeerUnverifiedException) || (th instanceof CertPathValidatorException)) {
                i = 25;
            } else {
                th = th.getCause();
            }
        }
        errorCallback(this.f131a, i, sSLException2);
    }

    /* access modifiers changed from: protected */
    public void unknownHostCallback(String str) {
        errorCallback(this.f131a, 7, str);
    }

    /* access modifiers changed from: protected */
    public int uploadCallback(ByteBuffer byteBuffer) {
        return uploadCallback(this.f131a, byteBuffer);
    }
}
