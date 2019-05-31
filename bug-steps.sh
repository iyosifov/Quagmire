#! /bin/bash

echo "This expects to be ran from the project root as ./bug-steps.sh"

adb uninstall com.example.swamp
adb uninstall com.example.swamp.test
./gradlew clean assembleRelease assembleReleaseAndroidTest
adb install ./app/build/outputs/apk/release/app-release.apk
adb install ./app/build/outputs/apk/androidTest/release/app-release-androidTest.apk
adb shell am instrument -w -r com.example.swamp.test

# Expected failure:
#
# INSTRUMENTATION_STATUS: class=com.example.swamp.ExampleInstrumentedTest
# INSTRUMENTATION_STATUS: current=2
# INSTRUMENTATION_STATUS: id=AndroidJUnitRunner
# INSTRUMENTATION_STATUS: numtests=2
# INSTRUMENTATION_STATUS: stack=java.lang.NoClassDefFoundError: Failed resolution of: Lcom/example/swamp/SomeClass;
#     at com.example.swamp.ExampleInstrumentedTest.someTest(ExampleInstrumentedTest.java:32)
#     at java.lang.reflect.Method.invoke(Native Method)
#     at org.junit.runners.model.FrameworkMethod$1.runReflectiveCall(FrameworkMethod.java:50)
#     at org.junit.internal.runners.model.ReflectiveCallable.run(ReflectiveCallable.java:12)
#     at org.junit.runners.model.FrameworkMethod.invokeExplosively(FrameworkMethod.java:47)
#     at org.junit.internal.runners.statements.InvokeMethod.evaluate(InvokeMethod.java:17)
#     at org.junit.runners.ParentRunner.runLeaf(ParentRunner.java:325)
#     at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:78)
#     at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:57)
#     at org.junit.runners.ParentRunner$3.run(ParentRunner.java:290)
#     at org.junit.runners.ParentRunner$1.schedule(ParentRunner.java:71)
#     at org.junit.runners.ParentRunner.runChildren(ParentRunner.java:288)
#     at org.junit.runners.ParentRunner.access$000(ParentRunner.java:58)
#     at org.junit.runners.ParentRunner$2.evaluate(ParentRunner.java:268)
#     at org.junit.runners.ParentRunner.run(ParentRunner.java:363)
#     at androidx.test.runner.AndroidJUnit4.run(AndroidJUnit4.java:104)
#     at org.junit.runners.Suite.runChild(Suite.java:128)
#     at org.junit.runners.Suite.runChild(Suite.java:27)
#     at org.junit.runners.ParentRunner$3.run(ParentRunner.java:290)
#     at org.junit.runners.ParentRunner$1.schedule(ParentRunner.java:71)
#     at org.junit.runners.ParentRunner.runChildren(ParentRunner.java:288)
#     at org.junit.runners.ParentRunner.access$000(ParentRunner.java:58)
#     at org.junit.runners.ParentRunner$2.evaluate(ParentRunner.java:268)
#     at org.junit.runners.ParentRunner.run(ParentRunner.java:363)
#     at org.junit.runner.JUnitCore.run(JUnitCore.java:137)
#     at org.junit.runner.JUnitCore.run(JUnitCore.java:115)
#     at androidx.test.internal.runner.TestExecutor.execute(TestExecutor.java:56)
#     at androidx.test.runner.AndroidJUnitRunner.onStart(AndroidJUnitRunner.java:392)
#     at android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:2075)
# Caused by: java.lang.ClassNotFoundException: Didn't find class "com.example.swamp.SomeClass" on path: DexPathList[[zip file "/system/framework/android.test.runner.jar", zip file "/system/framework/android.test.mock.jar", zip file "/data/app/com.example.swamp.test-cOfnYiQu2OgGcLrEpENsGw==/base.apk", zip file "/data/app/com.example.swamp-mKQjIf6OY0aGvtGSpnrxdg==/base.apk"],nativeLibraryDirectories=[/data/app/com.example.swamp.test-cOfnYiQu2OgGcLrEpENsGw==/lib/arm64, /data/app/com.example.swamp-mKQjIf6OY0aGvtGSpnrxdg==/lib/arm64, /system/lib64, /vendor/lib64]]
#     at dalvik.system.BaseDexClassLoader.findClass(BaseDexClassLoader.java:125)
#     at java.lang.ClassLoader.loadClass(ClassLoader.java:379)
#     at java.lang.ClassLoader.loadClass(ClassLoader.java:312)
#     ... 29 more
# 
 
