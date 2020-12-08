package com.unity3d.player;

import android.os.Build;

import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import javax.net.ssl.HandshakeCompletedEvent;
import javax.net.ssl.HandshakeCompletedListener;
import javax.net.ssl.KeyManager;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLPeerUnverifiedException;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

/* renamed from: com.unity3d.player.a */
public final class C0041a extends SSLSocketFactory {

    /* renamed from: c */
    private static volatile SSLSocketFactory f137c;

    /* renamed from: d */
    private static final Object[] f138d = new Object[0];

    /* renamed from: e */
    private static final boolean f139e;

    /* renamed from: a */
    private final SSLSocketFactory f140a;

    /* renamed from: b */
    private final C0042a f141b = new C0042a();

    /* renamed from: com.unity3d.player.a$a */
    class C0042a implements HandshakeCompletedListener {
        C0042a() {
        }

        public final void handshakeCompleted(HandshakeCompletedEvent handshakeCompletedEvent) {
            SSLSession session = handshakeCompletedEvent.getSession();
            session.getCipherSuite();
            session.getProtocol();
            try {
                session.getPeerPrincipal().getName();
            } catch (SSLPeerUnverifiedException e) {
            }
        }
    }

    static {
        boolean z = false;
        if (Build.VERSION.SDK_INT >= 16 && Build.VERSION.SDK_INT < 20) {
            z = true;
        }
        f139e = z;
    }

    private C0041a() throws NoSuchAlgorithmException, KeyManagementException {
        SSLContext instance = SSLContext.getInstance("TLS");
        instance.init((KeyManager[]) null, (TrustManager[]) null, (SecureRandom) null);
        this.f140a = instance.getSocketFactory();
    }

    /* renamed from: a */
    private static Socket m97a(Socket socket) {
        if (socket != null && (socket instanceof SSLSocket) && f139e) {
            ((SSLSocket) socket).setEnabledProtocols(((SSLSocket) socket).getSupportedProtocols());
        }
        return socket;
    }

    /* renamed from: a */
    public static SSLSocketFactory m98a() {
        synchronized (f138d) {
            if (f137c != null) {
                SSLSocketFactory sSLSocketFactory = f137c;
                return sSLSocketFactory;
            }
            try {
                C0041a aVar = new C0041a();
                f137c = aVar;
                return aVar;
            } catch (Exception e) {
                MyLog.Log(5, "CustomSSLSocketFactory: Failed to create SSLSocketFactory (" + e.getMessage() + ")");
                return null;
            }
        }
    }

    public final Socket createSocket() throws IOException {
        return m97a(this.f140a.createSocket());
    }

    public final Socket createSocket(String str, int i) throws IOException{
        return m97a(this.f140a.createSocket(str, i));
    }

    public final Socket createSocket(String str, int i, InetAddress inetAddress, int i2) throws IOException{
        return m97a(this.f140a.createSocket(str, i, inetAddress, i2));
    }

    public final Socket createSocket(InetAddress inetAddress, int i) throws IOException{
        return m97a(this.f140a.createSocket(inetAddress, i));
    }

    public final Socket createSocket(InetAddress inetAddress, int i, InetAddress inetAddress2, int i2) throws IOException{
        return m97a(this.f140a.createSocket(inetAddress, i, inetAddress2, i2));
    }

    public final Socket createSocket(Socket socket, String str, int i, boolean z) throws IOException {
        return m97a(this.f140a.createSocket(socket, str, i, z));
    }

    public final String[] getDefaultCipherSuites() {
        return this.f140a.getDefaultCipherSuites();
    }

    public final String[] getSupportedCipherSuites() {
        return this.f140a.getSupportedCipherSuites();
    }
}
