//
//  EEWK-Inject.js
//  Easy Embedded WebKit WebView
//
//  Created by 腹黒い茶 on 28/1/2016.
//  Copyright (c) 2016 Haraguroicha. All rights reserved.
//

____EmbeddedWK____ = ____EmbeddedWK____ || new (function EmbeddedWKBridge(){
    this.__callbacks = {};
    
    this.invokeCallback = function invokeCallback(cbID, removeAfterExecute) {
        var args = Array.prototype.slice.call(arguments);
        args.shift();
        args.shift();
        
        // let all of returned object in an array object, that can resolved to apply arguments to callback
        args = JSON.parse(args.shift());
        
        var cb = ____EmbeddedWK____.__callbacks[cbID];
        if (removeAfterExecute){
            ____EmbeddedWK____.__callbacks[cbID] = undefined;
            delete ____EmbeddedWK____.__callbacks[cbID];
        }
        return cb.apply(null, args);
    };
    
    this.call = function call(obj, functionName, args) {
        var formattedArgs = [];
        for (var i = 0, l = args.length; i < l; i++) {
            if (typeof args[i] == "function") {
                formattedArgs.push("f");
                var cbID = "__cb" + (+new Date);
                ____EmbeddedWK____.__callbacks[cbID] = args[i];
                formattedArgs.push(cbID);
            } else {
                formattedArgs.push("s");
                formattedArgs.push(encodeURIComponent(JSON.stringify(args[i])));
            }
        }
        
        var argStr = (formattedArgs.length > 0 ? ":" + encodeURIComponent(formattedArgs.join(":")) : "");

        var methodInfo = obj + ":" + encodeURIComponent(functionName) + argStr;
        var __RETRY_MAX_TIMES__ = 5;
        var retryCount = 0;
        var xhr = new XMLHttpRequest();
        xhr.open('POST', window.__nativeURL, false);
        xhr.setRequestHeader("X-Method-Info", methodInfo);
        while(true) {
            try {
                xhr.send(methodInfo);
                break;
            } catch (e) {
                if (retryCount <= __RETRY_MAX_TIMES__) {
                    console.error('request failed!! retry=%s with request content!!\n\t%s', ++retryCount, methodInfo);
                } else {
                    console.error('retry reach the limit of %s times, abort!!', __RETRY_MAX_TIMES__);
                    // load specified domain to tell web view to re-initialize
                    location.href = 'http://reload.webview/';
                    return;
                }
            }
        }
        if (xhr.status === 200) {
            window.__returnedValue = xhr.responseText;
            if (window.__returnedValue == "") window.__returnedValue = null;
        }

        var retValue = JSON.parse(JSON.stringify([ { value: decodeURIComponent(window.__returnedValue) } ]))[0].value;
        if (retValue == 'false' || retValue == 'true' || retValue == 'null') retValue = JSON.parse(retValue);
        console.log(retValue);
        delete window.__returnedValue;
        return retValue;
    };
    
    this.inject = function inject(obj, methods) {
        window[obj] = {};
        var jsObj = window[obj];
        
        for (var i = 0, l = methods.length; i < l; i++) {
            (function () {
                var method = methods[i];
                var jsMethod = method.replace(new RegExp(":", "g"), "");
                jsObj[jsMethod] = function () {
                    return ____EmbeddedWK____.call(obj, method, Array.prototype.slice.call(arguments));
                };
            })();
        }
    }
})();
