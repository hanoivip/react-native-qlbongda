package com.unity3d.player;

import java.lang.reflect.Array;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Member;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.lang.reflect.Proxy;
import java.util.ArrayList;
import java.util.Iterator;

final class ReflectionHelper {
    protected static boolean LOG = false;
    protected static final boolean LOGV = false;

    /* renamed from: a */
    private static C0011a[] f35a = new C0011a[4096];
    /* access modifiers changed from: private */

    /* renamed from: b */
    public static long f36b = 0;

    /* renamed from: com.unity3d.player.ReflectionHelper$a */
    private static class C0011a {

        /* renamed from: a */
        public volatile Member f40a;

        /* renamed from: b */
        private final Class f41b;

        /* renamed from: c */
        private final String f42c;

        /* renamed from: d */
        private final String f43d;

        /* renamed from: e */
        private final int f44e;

        C0011a(Class cls, String str, String str2) {
            this.f41b = cls;
            this.f42c = str;
            this.f43d = str2;
            this.f44e  = (((((this.f41b.hashCode() + 527) * 31) + this.f42c.hashCode()) * 31) + this.f43d.hashCode());
        }

        public final boolean equals(Object obj) {
            if (obj == this) {
                return true;
            }
            if (!(obj instanceof C0011a)) {
                return false;
            }
            C0011a aVar = (C0011a) obj;
            return this.f44e == aVar.f44e && this.f43d.equals(aVar.f43d) && this.f42c.equals(aVar.f42c) && this.f41b.equals(aVar.f41b);
        }

        public final int hashCode() {
            return this.f44e;
        }
    }

    ReflectionHelper() {
    }

    /* renamed from: a */
    private static float m28a(Class cls, Class cls2) {
        if (cls.equals(cls2)) {
            return 1.0f;
        }
        if (!cls.isPrimitive() && !cls2.isPrimitive()) {
            try {
                if (cls.asSubclass(cls2) != null) {
                    return 0.5f;
                }
            } catch (ClassCastException e) {
            }
            try {
                if (cls2.asSubclass(cls) != null) {
                    return 0.1f;
                }
            } catch (ClassCastException e2) {
            }
        }
        return 0.0f;
    }

    /* renamed from: a */
    private static float m29a(Class cls, Class[] clsArr, Class[] clsArr2) {
        int i = 0;
        if (clsArr2.length == 0) {
            return 0.1f;
        }
        if ((clsArr == null ? 0 : clsArr.length) + 1 != clsArr2.length) {
            return 0.0f;
        }
        float f = 1.0f;
        if (clsArr != null) {
            int length = clsArr.length;
            int i2 = 0;
            while (i < length) {
                f *= m28a(clsArr[i], clsArr2[i2]);
                i++;
                i2++;
            }
        }
        return f * m28a(cls, clsArr2[clsArr2.length - 1]);
    }

    /* renamed from: a */
    private static Class m31a(String str, int[] iArr) {
        while (true) {
            if (iArr[0] >= str.length()) {
                break;
            }
            int i = iArr[0];
            iArr[0] = i + 1;
            char charAt = str.charAt(i);
            if (charAt != '(' && charAt != ')') {
                if (charAt == 'L') {
                    int indexOf = str.indexOf(59, iArr[0]);
                    if (indexOf != -1) {
                        String substring = str.substring(iArr[0], indexOf);
                        iArr[0] = indexOf + 1;
                        try {
                            return Class.forName(substring.replace('/', '.'));
                        } catch (ClassNotFoundException e) {
                        }
                    }
                } else if (charAt == 'Z') {
                    return Boolean.TYPE;
                } else {
                    if (charAt == 'I') {
                        return Integer.TYPE;
                    }
                    if (charAt == 'F') {
                        return Float.TYPE;
                    }
                    if (charAt == 'V') {
                        return Void.TYPE;
                    }
                    if (charAt == 'B') {
                        return Byte.TYPE;
                    }
                    if (charAt == 'S') {
                        return Short.TYPE;
                    }
                    if (charAt == 'J') {
                        return Long.TYPE;
                    }
                    if (charAt == 'D') {
                        return Double.TYPE;
                    }
                    if (charAt == '[') {
                        return Array.newInstance(m31a(str, iArr), 0).getClass();
                    }
                    MyLog.Log(5, "! parseType; " + charAt + " is not known!");
                }
            }
        }
        return null;
    }

    /* renamed from: a */
    private static void m34a(C0011a aVar, Member member) {
        aVar.f40a = member;
        f35a[aVar.hashCode() & (f35a.length - 1)] = aVar;
    }

    /* renamed from: a */
    private static boolean m35a(C0011a aVar) {
        C0011a aVar2 = f35a[aVar.hashCode() & (f35a.length - 1)];
        if (!aVar.equals(aVar2)) {
            return false;
        }
        aVar.f40a = aVar2.f40a;
        return true;
    }

    /* renamed from: a */
    private static Class[] m36a(String str) {
        Class a;
        int[] iArr = {0};
        ArrayList arrayList = new ArrayList();
        while (iArr[0] < str.length() && (a = m31a(str, iArr)) != null) {
            arrayList.add(a);
        }
        Class[] clsArr = new Class[arrayList.size()];
        Iterator it = arrayList.iterator();
        int i = 0;
        while (it.hasNext()) {
            clsArr[i] = (Class) it.next();
            i++;
        }
        return clsArr;
    }

    protected static void endUnityLaunch() {
        f36b++;
    }

    protected static Constructor getConstructorID(Class cls, String str) {
        Constructor constructor;
        Constructor constructor2;
        Constructor constructor3;
        Constructor constructor4 = null;
        C0011a aVar = new C0011a(cls, "", str);
        if (m35a(aVar)) {
            constructor2 = (Constructor) aVar.f40a;
        } else {
            Class[] a = m36a(str);
            float f = 0.0f;
            Constructor[] constructors = cls.getConstructors();
            int length = constructors.length;
            int i = 0;
            while (true) {
                if (i >= length) {
                    constructor = constructor4;
                    break;
                }
                constructor = constructors[i];
                float a2 = m29a(Void.TYPE, constructor.getParameterTypes(), a);
                if (a2 > f) {
                    if (a2 == 1.0f) {
                        break;
                    }
                    constructor3 = constructor;
                } else {
                    a2 = f;
                    constructor3 = constructor4;
                }
                i++;
                constructor4 = constructor3;
                f = a2;
            }
            m34a(aVar, (Member) constructor);
            constructor2 = constructor;
        }
        if (constructor2 != null) {
            return constructor2;
        }
        throw new NoSuchMethodError("<init>" + str + " in class " + cls.getName());
    }

    protected static Field getFieldID(Class cls, String str, String str2, boolean z) {
        Field field;
        float f;
        Field field2;
        C0011a aVar = new C0011a(cls, str, str2);
        if (m35a(aVar)) {
            field = (Field) aVar.f40a;
        } else {
            Class[] a = m36a(str2);
            field = null;
            float f2 = 0.0f;
            while (cls != null) {
                Field[] declaredFields = cls.getDeclaredFields();
                int length = declaredFields.length;
                int i = 0;
                Field field3 = field;
                while (true) {
                    if (i >= length) {
                        field = field3;
                        break;
                    }
                    Field field4 = declaredFields[i];
                    if (z == Modifier.isStatic(field4.getModifiers()) && field4.getName().compareTo(str) == 0) {
                        f = m29a((Class) field4.getType(), (Class[]) null, a);
                        if (f > f2) {
                            if (f == 1.0f) {
                                f2 = f;
                                field = field4;
                                break;
                            }
                            field2 = field4;
                            i++;
                            field3 = field2;
                            f2 = f;
                        }
                    }
                    f = f2;
                    field2 = field3;
                    i++;
                    field3 = field2;
                    f2 = f;
                }
                if (f2 == 1.0f || cls.isPrimitive() || cls.isInterface() || cls.equals(Object.class) || cls.equals(Void.TYPE)) {
                    break;
                }
                cls = cls.getSuperclass();
            }
            m34a(aVar, (Member) field);
        }
        if (field != null) {
            return field;
        }
        Object[] objArr = new Object[4];
        objArr[0] = z ? "static" : "non-static";
        objArr[1] = str;
        objArr[2] = str2;
        objArr[3] = cls.getName();
        throw new NoSuchFieldError(String.format("no %s field with name='%s' signature='%s' in class L%s;", objArr));
    }

    protected static Method getMethodID(Class cls, String str, String str2, boolean z) {
        Method method;
        float f;
        Method method2;
        C0011a aVar = new C0011a(cls, str, str2);
        if (m35a(aVar)) {
            method = (Method) aVar.f40a;
        } else {
            Class[] a = m36a(str2);
            method = null;
            float f2 = 0.0f;
            while (cls != null) {
                Method[] declaredMethods = cls.getDeclaredMethods();
                int length = declaredMethods.length;
                int i = 0;
                Method method3 = method;
                while (true) {
                    if (i >= length) {
                        method = method3;
                        break;
                    }
                    Method method4 = declaredMethods[i];
                    if (z == Modifier.isStatic(method4.getModifiers()) && method4.getName().compareTo(str) == 0) {
                        f = m29a((Class) method4.getReturnType(), method4.getParameterTypes(), a);
                        if (f > f2) {
                            if (f == 1.0f) {
                                f2 = f;
                                method = method4;
                                break;
                            }
                            method2 = method4;
                            i++;
                            method3 = method2;
                            f2 = f;
                        }
                    }
                    f = f2;
                    method2 = method3;
                    i++;
                    method3 = method2;
                    f2 = f;
                }
                if (f2 == 1.0f || cls.isPrimitive() || cls.isInterface() || cls.equals(Object.class) || cls.equals(Void.TYPE)) {
                    break;
                }
                cls = cls.getSuperclass();
            }
            m34a(aVar, (Member) method);
        }
        if (method != null) {
            return method;
        }
        Object[] objArr = new Object[4];
        objArr[0] = z ? "static" : "non-static";
        objArr[1] = str;
        objArr[2] = str2;
        objArr[3] = cls.getName();
        throw new NoSuchMethodError(String.format("no %s method with name='%s' signature='%s' in class L%s;", objArr));
    }

    /* access modifiers changed from: private */
    public static native void nativeProxyFinalize(int i);

    /* access modifiers changed from: private */
    public static native Object nativeProxyInvoke(int i, String str, Object[] objArr);

    protected static Object newProxyInstance(int i, Class cls) {
        return newProxyInstance(i, new Class[]{cls});
    }

    protected static Object newProxyInstance(final int i, final Class[] clsArr) {
        return Proxy.newProxyInstance(ReflectionHelper.class.getClassLoader(), clsArr, new InvocationHandler() {

            /* renamed from: c */
            private long f39c = ReflectionHelper.f36b;

            /* access modifiers changed from: protected */
            public final void finalize() throws Throwable {
                try {
                    if (this.f39c == ReflectionHelper.f36b) {
                        ReflectionHelper.nativeProxyFinalize(i);
                    }
                } finally {
                    super.finalize();
                }
            }

            public final Object invoke(Object obj, Method method, Object[] objArr) {
                if (this.f39c == ReflectionHelper.f36b) {
                    return ReflectionHelper.nativeProxyInvoke(i, method.getName(), objArr);
                }
                MyLog.Log(6, "Scripting proxy object was destroyed, because Unity player was unloaded.");
                return null;
            }
        });
    }
}
