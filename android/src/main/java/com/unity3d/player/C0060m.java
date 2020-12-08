package com.unity3d.player;

import java.lang.reflect.Method;
import java.util.HashMap;

/* renamed from: com.unity3d.player.m */
final class C0060m {

    /* renamed from: a */
    private HashMap f181a = new HashMap();

    /* renamed from: b */
    private Class f182b = null;

    /* renamed from: c */
    private Object f183c = null;

    /* renamed from: com.unity3d.player.m$a */
    class C0061a {

        /* renamed from: a */
        public Class[] f184a;

        /* renamed from: b */
        public Method f185b = null;

        public C0061a(Class[] clsArr) {
            this.f184a = clsArr;
        }
    }

    public C0060m(Class cls, Object obj) {
        this.f182b = cls;
        this.f183c = obj;
    }

    /* renamed from: a */
    private void m122a(String str, C0061a aVar) {
        try {
            aVar.f185b = this.f182b.getMethod(str, aVar.f184a);
        } catch (Exception e) {
            MyLog.Log(6, "Exception while trying to get method " + str + ". " + e.getLocalizedMessage());
            aVar.f185b = null;
        }
    }

    /* renamed from: a */
    public final Object mo186a(String str, Object... objArr) {
        Object obj;
        if (!this.f181a.containsKey(str)) {
            MyLog.Log(6, "No definition for method " + str + " can be found");
            return null;
        }
        C0061a aVar = (C0061a) this.f181a.get(str);
        if (aVar.f185b == null) {
            m122a(str, aVar);
        }
        if (aVar.f185b == null) {
            MyLog.Log(6, "Unable to create method: " + str);
            return null;
        }
        try {
            obj = objArr.length == 0 ? aVar.f185b.invoke(this.f183c, new Object[0]) : aVar.f185b.invoke(this.f183c, objArr);
        } catch (Exception e) {
            MyLog.Log(6, "Error trying to call delegated method " + str + ". " + e.getLocalizedMessage());
            obj = null;
        }
        return obj;
    }

    /* renamed from: a */
    public final void mo187a(String str, Class[] clsArr) {
        this.f181a.put(str, new C0061a(clsArr));
    }
}
