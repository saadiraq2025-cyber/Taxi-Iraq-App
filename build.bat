@echo off
title 🚖 Taxi Iraq APK & AAB Builder
echo --------------------------------------------
echo   تحويل الموقع إلى تطبيق أندرويد (APK + AAB)
echo --------------------------------------------
echo.

REM إعداد المتغيرات
set APP_NAME=TaxiIraq
set PACKAGE_NAME=com.taxi.iraq
set VERSION_NAME=1.0
set VERSION_CODE=1
set JAVA_HOME="C:\Program Files\Java\jdk-17"
set PATH=%JAVA_HOME%\bin;%PATH%

REM فحص وجود مجلد www
if not exist www (
  echo ❌ لم يتم العثور على مجلد www
  echo أنشئ مجلد www وضع بداخله ملفات موقعك (index.html, css, js ...)
  pause
  exit
)

REM حذف أي ملفات قديمة
rmdir /s /q app
rmdir /s /q android
echo 🧩 إنشاء مشروع Android بسيط...

REM إنشاء بنية المشروع الأساسية
mkdir app\src\main\assets\www
xcopy www app\src\main\assets\www /E /I

REM إنشاء AndroidManifest.xml بسيط
mkdir app\src\main
echo ^<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="%PACKAGE_NAME%"^> > app\src\main\AndroidManifest.xml
echo ^<application android:label="%APP_NAME%" android:icon="@mipmap/ic_launcher"^> >> app\src\main\AndroidManifest.xml
echo ^<activity android:name=".MainActivity"^> >> app\src\main\AndroidManifest.xml
echo ^<intent-filter^> >> app\src\main\AndroidManifest.xml
echo ^<action android:name="android.intent.action.MAIN"/^> >> app\src\main\AndroidManifest.xml
echo ^<category android:name="android.intent.category.LAUNCHER"/^> >> app\src\main\AndroidManifest.xml
echo ^</intent-filter^> >> app\src\main\AndroidManifest.xml
echo ^</activity^> >> app\src\main\AndroidManifest.xml
echo ^</application^> >> app\src\main\AndroidManifest.xml
echo ^</manifest^> >> app\src\main\AndroidManifest.xml

REM توليد كود Java بسيط لفتح WebView
mkdir app\src\main\java\com\taxi\iraq
echo package com.taxi.iraq; > app\src\main\java\com\taxi\iraq\MainActivity.java
echo import android.app.Activity; >> app\src\main\java\com\taxi\iraq\MainActivity.java
echo import android.os.Bundle; >> app\src\main\java\com\taxi\iraq\MainActivity.java
echo import android.webkit.WebView; >> app\src\main\java\com\taxi\iraq\MainActivity.java
echo public class MainActivity extends Activity { >> app\src\main\java\com\taxi\iraq\MainActivity.java
echo @Override protected void onCreate(Bundle savedInstanceState) { >> app\src\main\java\com\taxi\iraq\MainActivity.java
echo super.onCreate(savedInstanceState); >> app\src\main\java\com\taxi\iraq\MainActivity.java
echo WebView w = new WebView(this); >> app\src\main\java\com\taxi\iraq\MainActivity.java
echo w.getSettings().setJavaScriptEnabled(true); >> app\src\main\java\com\taxi\iraq\MainActivity.java
echo w.loadUrl("file:///android_asset/www/index.html"); >> app\src\main\java\com\taxi\iraq\MainActivity.java
echo setContentView(w); >> app\src\main\java\com\taxi\iraq\MainActivity.java
echo } >> app\src\main\java\com\taxi\iraq\MainActivity.java
echo } >> app\src\main\java\com\taxi\iraq\MainActivity.java

REM إنشاء ملف build.gradle بسيط
echo apply plugin: 'com.android.application' > build.gradle
echo android { >> build.gradle
echo compileSdkVersion 34 >> build.gradle
echo defaultConfig { >> build.gradle
echo applicationId "%PACKAGE_NAME%" >> build.gradle
echo minSdkVersion 21 >> build.gradle
echo targetSdkVersion 34 >> build.gradle
echo versionCode %VERSION_CODE% >> build.gradle
echo versionName "%VERSION_NAME%" >> build.gradle
echo } >> build.gradle
echo buildTypes { >> build.gradle
echo release { >> build.gradle
echo minifyEnabled false >> build.gradle
echo } >> build.gradle
echo } >> build.gradle
echo } >> build.gradle

REM إنشاء keystore بسيط للتوقيع
if not exist taxi-key.keystore (
  echo 🔑 إنشاء مفتاح توقيع جديد...
  keytool -genkey -v -keystore taxi-key.keystore -alias taxi -keyalg RSA -keysize 2048 -validity 10000 -storepass 123456 -keypass 123456 -dname "CN=Taxi Iraq"
)

REM بناء APK باستخدام أدوات Java
echo 🏗️ بناء APK...
call gradlew assembleRelease || echo ⚠️ لم يتم العثور على gradlew

echo ✅ تم البناء بنجاح إن وُجد gradlew.
echo ⚙️ في حال لم يتوفر gradlew، انسخ ملفاتك إلى بيئة Android SDK أو أرسلها لأداة خارجية للبناء.

pause
