package com.unity3d.player;

/* renamed from: com.unity3d.player.l */
final class C0059l {

    /* renamed from: a */
    private static boolean f176a = false;

    /* renamed from: b */
    private boolean f177b;

    /* renamed from: c */
    private boolean f178c;

    /* renamed from: d */
    private boolean f179d;

    /* renamed from: e */
    private boolean f180e;

    C0059l() {
        this.f177b = !PermissionUtil.f155c;
        this.f178c = false;
        this.f179d = false;
        this.f180e = true;
    }

    /* renamed from: a */
    static void m112a() {
        f176a = true;
    }

    /* renamed from: b */
    static void m113b() {
        f176a = false;
    }

    /* renamed from: c */
    static boolean m114c() {
        return f176a;
    }

    /* access modifiers changed from: package-private */
    /* renamed from: a */
    public final void mo178a(boolean z) {
        this.f178c = z;
    }

    /* access modifiers changed from: package-private */
    /* renamed from: b */
    public final void mo179b(boolean z) {
        this.f180e = z;
    }

    /* access modifiers changed from: package-private */
    /* renamed from: c */
    public final void mo180c(boolean z) {
        this.f179d = z;
    }

    /* access modifiers changed from: package-private */
    /* renamed from: d */
    public final void mo181d() {
        this.f177b = true;
    }

    /* access modifiers changed from: package-private */
    /* renamed from: e */
    public final boolean mo182e() {
        return this.f180e;
    }

    /* access modifiers changed from: package-private */
    /* renamed from: f */
    public final boolean mo183f() {
        return f176a && this.f178c && this.f177b && !this.f180e && !this.f179d;
    }

    /* access modifiers changed from: package-private */
    /* renamed from: g */
    public final boolean mo184g() {
        return this.f179d;
    }

    public final String toString() {
        return super.toString();
    }
}
