$(function(){

  $('.responsive_btn').on('click', function () {
    $('.header_nav').toggleClass('menu_active');
  });

  $('#btn1').on('click', function () {
    $('#image1').toggleClass('appear');
    $('#btn1').toggleClass('sepia');
  });
  $('#btn2').on('click', function () {
    $('#image2').toggleClass('appear');
    $('#btn2').toggleClass('sepia');
  });
  $('#btn3').on('click', function () {
    $('#image3').toggleClass('appear');
    $('#btn3').toggleClass('sepia');
  });
  $('#btn4').on('click', function () {
    $('#image4').toggleClass('appear');
    $('#btn4').toggleClass('sepia');
  });
  $('#btn5').on('click', function () {
    $('#image5').toggleClass('appear');
    $('#btn5').toggleClass('sepia');
  });

  function show() {
    $('#spring').removeClass('border');
    $('#summer').removeClass('border');
    $('#autumn').removeClass('border');
    $('#winter').removeClass('border');
    $('#spring-box').removeClass('box-show');
    $('#summer-box').removeClass('box-show');
    $('#autumn-box').removeClass('box-show');
    $('#winter-box').removeClass('box-show');
  }
  $('#spring').on('click', function () {
    show();
    $('#spring').addClass('border');
    $('#spring-box').addClass('box-show');
  });
  $('#summer').on('click', function () {
    show();
    $('#summer').addClass('border');
    $('#summer-box').addClass('box-show');
  });
  $('#autumn').on('click', function () {
    show();
    $('#autumn').addClass('border');
    $('#autumn-box').addClass('box-show');
  });
  $('#winter').on('click', function () {
    show();
    $('#winter').addClass('border');
    $('#winter-box').addClass('box-show');
  });



  function slider() {
    var $sliderWrap = $('.slideshow'),
        $slider = $sliderWrap.find('.slideshow-slides'),
        $slides = $slider.find('.slide'),
        $indicator = $sliderWrap.find('.slideshow-indicator'),
        $prev = $sliderWrap.find('.prev'),
        $next = $sliderWrap.find('.next'),
        $text = $sliderWrap.find('.text'),
        $item = '',
        currentIndex = 0,
        slideLength = $slides.length,
        slidewidth = $slides.width(),
        timer,
        drag_flg = false,
        posX,
        imgPosX,
        drug_dis;

    function cloneSlide(){
      var $lastSlide = $slider.find('div:last-child'),
          $firstSlide = $slider.find('div:first-child');
      $lastSlide.clone(true).prependTo($slider);
      $firstSlide.clone(true).appendTo($slider);
      $slider.animate({
				left: (currentIndex + 1) * -(slidewidth) + "px"
			},0);
    }

    function addIndicator(){
		var indicatorHTML = '<span class="item"></span>';
		for (let i = 0; i < slideLength; i++){
		$indicator.append(indicatorHTML);
		}
		$item = $(".item");
		$item.eq(currentIndex).addClass("active");
    }

    function addText(){
      $text.eq(currentIndex).addClass("active");
    }
    function updateText() {
      $text.removeClass("active");
      $text.eq(currentIndex).addClass("active");
    }

    function updateNav() {
      $item.removeClass("active");
      $item.eq(currentIndex).addClass("active");
    }

    function goSomeWhere() {
      if(!$slider.is(":animated")){
        currentIndex = $(this).index();
        changeSlide();
      }
    }

    function nextSlide() {
      if(!$slider.is(":animated")){
        currentIndex++;
        changeSlide();
      }
    }

    function prevSlide() {
      if(!$slider.is(":animated")){
        currentIndex--;
        changeSlide();
      }
    }

    function resizeSlide() {
      slidewidth = $slides.width();
    }

    function changeSlide() {
		var duration = 200;
    resizeSlide();

		if(currentIndex == slideLength){
			currentIndex = 0;
			$slider.animate({
				left: (currentIndex + 1) * -(slidewidth) + "px"
			},0);
		}else if(currentIndex == -1){
			currentIndex = slideLength - 1;
			$slider.animate({
				left: (currentIndex + 1) * -(slidewidth) + "px"
			},0);
		}else {
      $slider.animate({
        left: (currentIndex + 1) * -(slidewidth) + "px"
      },duration);
    }
		updateNav();
    updateText();
    }

    function startTimer() {
		var interval = 5000;
		timer = setInterval(nextSlide, interval);
    }

    function stopTimer() {
      timer = clearInterval(timer);
    }

    function clickSlider(evt1){
      drag_flg = true;
      posX = evt1.screenX;
      imgPosX = $slider.position();
    }

    function leaveSlider(){
      if(drag_flg == true){
        if(drug_dis < -(slidewidth / 2)){
          nextSlide();
        }else if(drug_dis > (slidewidth / 2)){
          prevSlide();
        }else{
          changeSlide();
        }
        drag_flg = false;
      }
    }

	  function moveSlider(evt2){
      if(drag_flg == true){
        evt2.preventDefault();
        $slider.css("left",(imgPosX.left + evt2.screenX - posX) + "px");
        drug_dis = evt2.screenX - posX
      }
    } 

    function setEvent() {
		$(window).on('mousemove',moveSlider);
		$(window).on('mouseup',leaveSlider);
		$slider.on({
			mouseenter: stopTimer,
			mouseleave: startTimer,
			mousedown : clickSlider
		});
		$prev.on('click', prevSlide);
		$next.on('click', nextSlide);
		$item.on('click', goSomeWhere);
    }
    addIndicator();
    addText();
    cloneSlide();
    setEvent();
    startTimer();
  }
  slider();

  
  const targets = document.querySelectorAll('.target');

  function callback(entries, obs) {

    entries.forEach(entry => {
      if (!entry.isIntersecting) {
        return;
      }
  
      entry.target.classList.add('appear');
      obs.unobserve(entry.target);
    });
  }

  const options = {
    threshold: 0.2,
  };

  const observer = new IntersectionObserver(callback, options);

  targets.forEach(target => {
    observer.observe(target);
  });
});

