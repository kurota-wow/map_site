{
  window.onload = function() {
    const responsive_menu_btn = document.querySelector('.responsive_btn');
    responsive_menu_btn.addEventListener('click', function() {
      const header_menu_detail = document.querySelector('.header_nav');
      header_menu_detail.classList.toggle('menu_active');
    });

    if (document.querySelector("#btn1")) {
      const btn1 = document.getElementById('btn1');
      const btn2 = document.getElementById('btn2');
      const btn3 = document.getElementById('btn3');
      const btn4 = document.getElementById('btn4');
      const btn5 = document.getElementById('btn5');

      btn1.addEventListener('click', function() {
        const image1 = document.getElementById('image1');
        image1.classList.toggle('appear');
        btn1.classList.toggle('sepia');
      });
      btn2.addEventListener('click', function() {
        const image2 = document.getElementById('image2');
        image2.classList.toggle('appear');
        btn2.classList.toggle('sepia');
      });
      btn3.addEventListener('click', function() {
        const image3 = document.getElementById('image3');
        image3.classList.toggle('appear');
        btn3.classList.toggle('sepia');
      });
      btn4.addEventListener('click', function() {
        const image4 = document.getElementById('image4');
        image4.classList.toggle('appear');
        btn4.classList.toggle('sepia');
      });
      btn5.addEventListener('click', function() {
        const image5 = document.getElementById('image5');
        image5.classList.toggle('appear');
        btn5.classList.toggle('sepia');
      });
    }

    if (document.querySelector("#spring")) {
      const spring = document.getElementById('spring');
      const summer = document.getElementById('summer');
      const autumn = document.getElementById('autumn');
      const winter = document.getElementById('winter');
      const springbox = document.getElementById('spring-box');
      const summerbox = document.getElementById('summer-box');
      const autumnbox = document.getElementById('autumn-box');
      const winterbox = document.getElementById('winter-box');

      spring.addEventListener('click', function() {
        spring.classList.remove('border');
        summer.classList.remove('border');
        autumn.classList.remove('border');
        winter.classList.remove('border');
        springbox.classList.remove('box-show');
        summerbox.classList.remove('box-show');
        autumnbox.classList.remove('box-show');
        winterbox.classList.remove('box-show');
        spring.classList.add('border');
        springbox.classList.add('box-show');
      });
      summer.addEventListener('click', function() {
        spring.classList.remove('border');
        summer.classList.remove('border');
        autumn.classList.remove('border');
        winter.classList.remove('border');
        springbox.classList.remove('box-show');
        summerbox.classList.remove('box-show');
        autumnbox.classList.remove('box-show');
        winterbox.classList.remove('box-show');
        summer.classList.add('border');
        summerbox.classList.add('box-show');
      });
      autumn.addEventListener('click', function() {
        spring.classList.remove('border');
        summer.classList.remove('border');
        autumn.classList.remove('border');
        winter.classList.remove('border');
        springbox.classList.remove('box-show');
        summerbox.classList.remove('box-show');
        autumnbox.classList.remove('box-show');
        winterbox.classList.remove('box-show');
        autumn.classList.add('border');
        autumnbox.classList.add('box-show');
      });
      winter.addEventListener('click', function() {
        spring.classList.remove('border');
        summer.classList.remove('border');
        autumn.classList.remove('border');
        winter.classList.remove('border');
        springbox.classList.remove('box-show');
        summerbox.classList.remove('box-show');
        autumnbox.classList.remove('box-show');
        winterbox.classList.remove('box-show');
        winter.classList.add('border');
        winterbox.classList.add('box-show');
      });
    }

  };
  
  
}
