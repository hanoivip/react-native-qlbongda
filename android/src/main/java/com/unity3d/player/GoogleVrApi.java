package com.unity3d.player;

import java.util.concurrent.atomic.AtomicReference;

public class GoogleVrApi {

    /* renamed from: a */
    private static AtomicReference f8a = new AtomicReference();

    private GoogleVrApi() {
    }

    /* renamed from: a */
    static void m8a() {
        f8a.set((Object) null);
    }

    /* renamed from: a */
    static void m9a(C0046d dVar) {
        f8a.compareAndSet((Object) null, new GoogleVrProxy(dVar));
    }

    /* renamed from: b */
    static GoogleVrProxy m10b() {
        return (GoogleVrProxy) f8a.get();
    }

    public static GoogleVrVideo getGoogleVrVideo() {
        return (GoogleVrVideo) f8a.get();
    }
}
