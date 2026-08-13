/* =====================================================================
   VITALBOOST · INDEX.JS
   Pequeñas interacciones para la landing page: barra de progreso de
   scroll, animaciones de aparición, contador de estadísticas y botón
   "volver arriba". No afecta ninguna otra vista del sistema.
   ===================================================================== */
document.addEventListener('DOMContentLoaded', function () {

    /* ---- barra de progreso de scroll ---- */
    var barra = document.querySelector('.scroll-progress');
    function actualizarBarra() {
        var alto = document.documentElement.scrollHeight - window.innerHeight;
        var progreso = alto > 0 ? (window.scrollY / alto) * 100 : 0;
        if (barra) barra.style.width = progreso + '%';
    }
    window.addEventListener('scroll', actualizarBarra, { passive: true });
    actualizarBarra();

    /* ---- botón volver arriba ---- */
    var volverArriba = document.querySelector('.volver-arriba');
    window.addEventListener('scroll', function () {
        if (!volverArriba) return;
        if (window.scrollY > 500) {
            volverArriba.classList.add('mostrar');
        } else {
            volverArriba.classList.remove('mostrar');
        }
    }, { passive: true });
    if (volverArriba) {
        volverArriba.addEventListener('click', function () {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }

    /* ---- animación de aparición al hacer scroll (reveal) ---- */
    var elementos = document.querySelectorAll('.reveal, .beneficio');
    if ('IntersectionObserver' in window) {
        var observador = new IntersectionObserver(function (entradas) {
            entradas.forEach(function (entrada) {
                if (entrada.isIntersecting) {
                    entrada.target.classList.add('visible');
                    observador.unobserve(entrada.target);
                }
            });
        }, { threshold: 0.15 });

        elementos.forEach(function (el) { observador.observe(el); });
    } else {
        elementos.forEach(function (el) { el.classList.add('visible'); });
    }

    /* ---- contador animado de estadísticas del hero ---- */
    var contadores = document.querySelectorAll('.stat-num[data-fin]');
    function animarContador(el) {
        var fin = parseInt(el.getAttribute('data-fin'), 10) || 0;
        var sufijo = el.getAttribute('data-sufijo') || '';
        var duracion = 1400;
        var inicioTiempo = null;

        function paso(marca) {
            if (!inicioTiempo) inicioTiempo = marca;
            var avance = Math.min((marca - inicioTiempo) / duracion, 1);
            var valor = Math.floor(avance * fin);
            el.textContent = valor + sufijo;
            if (avance < 1) {
                window.requestAnimationFrame(paso);
            } else {
                el.textContent = fin + sufijo;
            }
        }
        window.requestAnimationFrame(paso);
    }

    if (contadores.length && 'IntersectionObserver' in window) {
        var observadorStats = new IntersectionObserver(function (entradas) {
            entradas.forEach(function (entrada) {
                if (entrada.isIntersecting) {
                    animarContador(entrada.target);
                    observadorStats.unobserve(entrada.target);
                }
            });
        }, { threshold: 0.4 });
        contadores.forEach(function (el) { observadorStats.observe(el); });
    }

    /* ---- resaltar el enlace del menú según la sección visible ---- */
    var secciones = document.querySelectorAll('section[id]');
    var enlaces = document.querySelectorAll('nav a[href^="#"]');
    if (secciones.length && enlaces.length && 'IntersectionObserver' in window) {
        var observadorNav = new IntersectionObserver(function (entradas) {
            entradas.forEach(function (entrada) {
                if (entrada.isIntersecting) {
                    enlaces.forEach(function (a) { a.classList.remove('activo'); });
                    var actual = document.querySelector('nav a[href="#' + entrada.target.id + '"]');
                    if (actual) actual.classList.add('activo');
                }
            });
        }, { threshold: 0.5 });
        secciones.forEach(function (s) { observadorNav.observe(s); });
    }
});
