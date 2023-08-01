import $ from "jquery";

{
  $('.responsive-btn').on('click', function () {
    $('.header-nav').toggleClass('menu-active');
  });

  $('.switch-btns').on('click', '.button', function() {
    const btnId = $(this).attr('id');
    const imageId = `#image${btnId.slice(-1)}`;
    $(imageId).toggleClass('appear');
    $(this).toggleClass('sepia');
  });
  
  $(function () {
    $(".tabbox").removeClass("box-show");
    $('#spring-box').addClass("box-show");
    $(".tab").on("click", function () {
      const season = $(this).data("season");
      $(".tab").removeClass("border");
      $(".tabbox").removeClass("box-show");
      $(this).addClass("border");
      $(`#${season}-box`).addClass("box-show");
    });
  });

  $(function() {
    $('.button').on('click', function () {
      $(this).addClass('active');
    });
    $('.button').on('mouseout', function () {
      $(this).removeClass('active');
    });
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

  $(function() {
    const targets = $('.target');
    const observer = new IntersectionObserver((entries, obs) => {
      entries.forEach(entry => {
        if (!entry.isIntersecting) {
          return;
        }
        $(entry.target).addClass('appear');
        obs.unobserve(entry.target);
      });
    }, { threshold: 0.2 });
    targets.each((index, target) => {
      observer.observe(target);
    });
  });
}
