{
  window.onload = function() {
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
  };
  
  
}
