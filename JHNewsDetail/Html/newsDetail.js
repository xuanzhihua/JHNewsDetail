window.onload = function(){
    // 这段代码是固定的，必须要放到js中
    function setupWebViewJavascriptBridge(callback) {
        if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
        if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
        window.WVJBCallbacks = [callback];
        var WVJBIframe = document.createElement('iframe');
        WVJBIframe.style.display = 'none';
        WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
        document.documentElement.appendChild(WVJBIframe);
        setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
    }
    
    // 与OC交互的所有JS方法都要在这里注册,才能让OC和JS之间相互调用
    setupWebViewJavascriptBridge(function(bridge) {

        var srcArr = [];

        var allImage = document.getElementsByTagName('img');
        for(var i=0; i<allImage.length; i++){
            var image = allImage[i];
            image.index = i;

            srcArr.push({'pic_url': image.src});

            image.onclick = function () {
                bridge.callHandler('openCameraLib', {'index':this.index, 'srcArr': srcArr}, function responseCallback(responseData) {
                    console.log("OC中返回的参数:", responseData)
                });
            }
        }


        //  处理夜间模式切换
        bridge.registerHandler('changeState', function(data, responseCallback) {
              var body = document.getElementsByTagName('body')[0];
              if(data){
                  body.style.backgroundColor = 'rgba(0,0,0,0.8)';
                  body.style.color = 'white';
              }else{
                  body.style.backgroundColor = 'white';
                  body.style.color = 'black';
              }
        });


        // 处理文字大小
        bridge.registerHandler('changeFontSize', function(data, responseCallback) {
            var body = document.getElementsByTagName('body')[0];
            if(data <= 0.2 || data >= 0.8) return;
            body.style.fontSize = 33 * data + 'px'
        });
                                 
                                 

    })

};