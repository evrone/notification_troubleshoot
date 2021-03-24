package com.evrone.notification_troubleshoot;

import android.content.Context;
import android.content.IntentSender;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.thelittlefireman.appkillermanager.managers.KillerManager;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.ArrayList;
import java.util.List;

public class MethodCallHandlerImpl implements MethodChannel.MethodCallHandler {
    private static final String TAG = "MethodCallHandlerImpl";
    @Nullable
    private MethodChannel methodChannel;

    @Nullable private Context applicationContext;

    /**
     * Uses the given {@code sender} for all incoming calls.
     *
     * <p>This assumes that the sender's context and activity state are managed elsewhere and
     * correctly initialized before being sent here.
     */
    MethodCallHandlerImpl(@Nullable Context applicationContext) {
        this.applicationContext = applicationContext;
    }

    void setApplicationContext(Context applicationContext) {
        this.applicationContext = applicationContext;
    }

    /**
     * Registers this instance as a method call handler on the given {@code messenger}.
     *
     * <p>Stops any previously started and unstopped calls.
     *
     * <p>This should be cleaned with {@link #stopListening} once the messenger is disposed of.
     */
    void startListening(BinaryMessenger messenger) {
        if (methodChannel != null) {
            Log.wtf(TAG, "Setting a method call handler before the last was disposed.");
            stopListening();
        }

        methodChannel = new MethodChannel(messenger, "notification_troubleshoot");
        methodChannel.setMethodCallHandler(this);
    }

    /**
     * Clears this instance from listening to method calls.
     *
     * <p>Does nothing is {@link #startListening} hasn't been called, or if we're already stopped.
     */
    void stopListening() {
        if (methodChannel == null) {
            Log.d(TAG, "Tried to stop listening when no methodChannel had been initialized.");
            return;
        }

        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
    }

    /**
     * Parses the incoming call and forwards it to the cached {@link IntentSender}.
     *
     * <p>Always calls {@code result#success}.
     */
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("startIntent")) {
            String actionString = call.argument("action");
            KillerManager.Actions action = convertAction(actionString);
            if (action != null) {
                boolean res = KillerManager.doAction(applicationContext, action);
                result.success(res);
            } else {
                result.error(String.format("Unknown action %s", actionString), null, null);
            }

        } else if (call.method.equals("availableActions")) {
            List<String> res = new ArrayList<>();
            for (KillerManager.Actions action : KillerManager.Actions.values()) {
                if (KillerManager.isActionAvailable(applicationContext, action)) {
                    res.add(action.toString().toLowerCase());
                }
            }
            result.success(res);
        } else {
            result.notImplemented();
        }
    }

    private static KillerManager.Actions convertAction(String action) {
        if (action == null) {
            return null;
        }

        switch (action) {
            case "action_autostart":
                return KillerManager.Actions.ACTION_AUTOSTART;
            case "action_notifications":
                return KillerManager.Actions.ACTION_NOTIFICATIONS;
            case "action_powersaving":
                return KillerManager.Actions.ACTION_POWERSAVING;
            default:
                return null;
        }
    }
}
