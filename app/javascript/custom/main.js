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

  $(function() {
    $('.preload-image').each(function() {
      var imageUrl = $(this).data('src');
      if (imageUrl) {
        var image = new Image();
        image.src = imageUrl;
      }
    });
  });

  $(function(){
    $('.flash').fadeOut(3000);
  });

  function handlePaginationClick(event, containerSelector) {
    event.preventDefault();
    var url = $(this).attr('href');
    $.ajax({
      url: url,
      type: 'GET',
      dataType: 'html',
      success: function(data) {
        var contentHtml = $(data).find(containerSelector).html();
        $(containerSelector).html(contentHtml);
      }
    });
  }
  
  $(document).on('click', '#comments-container .pagination a', function(event) {
    handlePaginationClick.call(this, event, '#comments-container');
  });
  
  $(document).on('click', '#customer-bookmark .pagination a', function(event) {
    handlePaginationClick.call(this, event, '#customer-bookmark');
  });
  
  $(document).on('click', '#customer-comments-container .pagination a', function(event) {
    handlePaginationClick.call(this, event, '#customer-comments-container');
  });

  $(function () {
    function updateBookmarkContainers(spotId, template) {
      $('#bookmarked-button-container-' + spotId).html(template);
      $('#bookmark-button-container-' + spotId).html(template);
    }
    function showMessageContainers(spotId, message) {
      $('#message-container-' + spotId).text(message);
      $('#bookmarked-message-container-' + spotId).text(message);
      setTimeout(function() {
        $('#message-container-' + spotId).text('');
        $('#bookmarked-message-container-' + spotId).text('');
      }, 5000);
    }
    function sendAjaxRequest(url, type, data, successCallback) {
      $.ajax({
        url: url,
        type: type,
        data: data,
        dataType: 'json',
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        success: successCallback,
        error: function () {
          $('#alert-message').text('処理に失敗しました。');
          setTimeout(function () {
            $('#alert-message').text('');
          }, 5000);
        }
      });
    }
    $(document).on('click', '#unbookmark-button', function () {
      var spotId = $(this).data('spot-id');
      var url = '/spots/' + spotId + '/bookmarks';
      var data = { spot_id: spotId };
  
      sendAjaxRequest(url, 'POST', data, function (data) {
        if (data.bookmarked) {
          updateBookmarkContainers(spotId, data.template);
          showMessageContainers(spotId, 'お気に入りに追加しました。');
        }
      });
      return false;
    });

    $(document).on('click', '#bookmark-button', function () {
      var spotId = $(this).data('spot-id');
      var customerId = $('#customer-bookmark').data('customer-id');
      var currentPageUrl = window.location.href;
      var isSpotPage = currentPageUrl.includes("/spots");
      var url = '/spots/' + spotId + '/bookmarks';
      var data = { spot_id: spotId };
  
      sendAjaxRequest(url, 'DELETE', data, function (data) {
        if (isSpotPage) {
          updateBookmarkContainers(spotId, data.template);
        } else {
          var Url = "/customers/" + customerId ;
          $.get(Url, function(data) {
            var bookmarkHtml = $(data).find('#customer-bookmark').html();
            $('#customer-bookmark').html(bookmarkHtml);
          });
        }
        updateBookmarkContainers(spotId, data.template);
        showMessageContainers(spotId, 'お気に入りから削除しました。');
        $('#mypage-alert-message').text('お気に入りから削除しました。');
        setTimeout(function() {
          $('#mypage-alert-message').text('');
        }, 5000);
      });
      return false;
    });
  })
  $(function () {
    function updateCommentsContainer(spotId) {
      var spotUrl = "/spots/" + spotId + "?page=1";
      $.get(spotUrl, function(data) {
        var commentsHtml = $(data).find('#comments-container').html();
        $('#comments-container').html(commentsHtml);
      });
    }
    function displayErrorMessage(message) {
      $('#alert-message').text(message);
      setTimeout(function () {
        $('#alert-message').text('');
      }, 5000);
    }
    $(document).on('submit', '#comment-form form', function (e) {
      e.preventDefault();
      var form = $(this);
      var url = form.attr('action');
      var formData = form.serialize();

      $.ajax({
        url: url,
        type: 'POST',
        data: formData,
        dataType: 'json',
        success: function (data) {
          if (data.success) {
            var commentContent = data.spot_comment.content;
            var customerName = data.customer_name;

            var newComment = $('<ul class="comment" id="comment-body">' +
              '<li class="comment-content">' +
              '<span class="customer-name">' + customerName + '</span>' +
              commentContent +
              '</li>' +
              '<li class="comment-actions">' +
              '<button class="btn" onclick="return confirm(\'本当に削除しますか？\');" data-remote="true" data-method="delete" href="/spots/' + data.spot_comment.spot_id + '/spot_comments/' + data.spot_comment.id + '">削除する</button>' +
              '</li>' +
              '</ul>');

            $('#comment-form textarea').val('');
            $('.comment-list').prepend(newComment);
            updateCommentsContainer(data.spot_comment.spot_id);
            displayErrorMessage('コメントを投稿しました。');
          } else {
            displayErrorMessage('コメントの投稿に失敗しました。エラー: ' + data.errors.join(', '));
          }
        },
        error: function () {
          displayErrorMessage('コメントの投稿に失敗しました。');
        }
      });
    });

    $(document).on('click', '.comment-actions .btn', function (event) {
      event.preventDefault();
      var button = $(this);
      var form = button.closest('form');
      var url = form.attr('action');
      var spotId = url.match(/\/spots\/(\d+)\//)[1];
      var customerId = $('.customer-comments-list').data('customer-id');

      if (!confirm('本当に削除しますか？')) {
        return;
      }
      $.ajax({
        url: url,
        type: 'DELETE',
        dataType: 'json',
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        success: function (data) {
          if (data.success) {
            var currentPageUrl = window.location.href;
            var isSpotDetailPage = currentPageUrl.includes("/spots/");
            var isMyPage = currentPageUrl.includes("/customers/");
            var Url;

            if (isSpotDetailPage) {
              updateCommentsContainer(spotId);
            } else if (isMyPage) {
              Url = "/customers/" + customerId ;
              $.get(Url, function(data) {
                var commentsHtmls = $(data).find('.customer-comments-list').html();
                $('.customer-comments-list').html(commentsHtmls);  
              });
            }
            $('#alert-message').text('コメントを削除しました。');
            $('#mypage-alert-message').text('コメントを削除しました。');
            setTimeout(function () {
              $('#alert-message').text('');
              $('#mypage-alert-message').text('');
            }, 5000);
          } else {
            alert('削除に失敗しました。エラー: ' + data.errors.join(', '));
          }
        },
        error: function () {
          alert('削除に失敗しました。');
        }
      });
    });
  });
  $(function() {
    $('.tab-button').on('click', function() {
      $('.tab-button').removeClass('active');
      $(this).addClass('active');
  
      var tab = $(this).data('tab');
      $('.tab-content').removeClass('active');
      $('.' + tab + '-tab').addClass('active');
    });
  });
}
