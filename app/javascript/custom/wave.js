var unit = 100,
    canvasList, // キャンバスの配列
    info = {}, // 全キャンバス共通の描画情報
    colorList, // 各キャンバスの色情報
    i = 0;

function init() {
    info.seconds = 0;
    info.t = 0;
		canvasList = [];
    colorList = [];
    canvasList.push(document.getElementById("waveCanvas"));
    colorList.push(['#90d1ff', '#c4dae9', '#4ab3f99c', '#86c4f0']);//重ねる波の色設定
	// 各キャンバスの初期化
for(var canvasIndex in canvasList) {
        var canvas = canvasList[canvasIndex];
        canvas.width = document.documentElement.clientWidth; //Canvasのwidthをウィンドウの幅に合わせる
        canvas.height = 450;//波の高さ
        canvas.contextCache = canvas.getContext("2d");
    }
    // 共通の更新処理呼び出し
		update();
}

function update() {
		for(var canvasIndex in canvasList) {
        var canvas = canvasList[canvasIndex];
        // 各キャンバスの描画
        draw(canvas, colorList[canvasIndex]);
    }
    // 共通の描画情報の更新
    info.seconds = info.seconds + .01;
    info.t = info.seconds*Math.PI;
    // 自身の再起呼び出し
    setTimeout(update, 55);
}

function draw(canvas, color) {
		// 対象のcanvasのコンテキストを取得
    var context = canvas.contextCache;
    // キャンバスの描画をクリア
    context.clearRect(0, 0, canvas.width, canvas.height);
    //波の重なりを描画 drawWave(canvas, color[数字（波の数を0から数えて指定）], 透過, 波の幅のzoom,波の開始位置の遅れ )
    drawWave(canvas, color[0], 0.7, 3, 0);//0.5⇒透過具合50%、3⇒数字が大きいほど波がなだらか
    drawWave(canvas, color[1], 0.4, 5, 350);
    drawWave(canvas, color[2], 0.2, 1.6, 100);
    drawWave(canvas, color[3], 1, 2.1, 50);
}

/**
* 波を描画
* drawWave(色, 不透明度, 波の幅のzoom, 波の開始位置の遅れ)
*/
function drawWave(canvas, color, alpha, zoom, delay) {
		var context = canvas.contextCache;
    context.fillStyle = color;//塗りの色
    context.globalAlpha = alpha;
    context.beginPath(); //パスの開始
    drawSine(canvas, info.t / 0.5, zoom, delay);
    context.lineTo(canvas.width + 10, canvas.height); //パスをCanvasの右下へ
    context.lineTo(0, canvas.height); //パスをCanvasの左下へ
    context.closePath(); //パスを閉じる
    context.fill(); //波を塗りつぶす
}

/**
 * drawSine(時間, 波の幅のzoom, 波の開始位置の遅れ)
 */
function drawSine(canvas, t, zoom, delay) {
    var xAxis = Math.floor(canvas.height/2);
    var yAxis = 0;
    var context = canvas.contextCache;
    // Set the initial x and y, starting at 0,0 and translating to the origin on
    // the canvas.
    var x = t; //時間を横の位置とする
    var y = Math.sin(x)/zoom;
    context.moveTo(yAxis, unit*y+xAxis); //スタート位置にパスを置く

    // Loop to draw segments (横幅の分、波を描画)
    for (i = yAxis; i <= canvas.width + 10; i += 10) {
        x = t+(-yAxis+i)/unit/zoom;
        y = Math.sin(x - delay)/3;
        context.lineTo(i, unit*y+xAxis);
    }
}
$(function(){
  var timer = false;
  var prewidth = $(window).width();
  $(window).resize(function() {
  if (timer !== false) {
  clearTimeout(timer);
  }
  timer = setTimeout(function() {
  var nowWidth = $(window).width();
  if(prewidth !== nowWidth){
  // リロード
  location.reload();
  }
  prewidth = nowWidth;
  }, 200);
  });
});

init();