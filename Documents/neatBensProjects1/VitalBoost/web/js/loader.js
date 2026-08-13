/* =====================================================================
   VITALBOOST · LOADER.JS — Controla el overlay #vb-loader.
   1) Lo oculta con fade cuando la página actual ya cargó.
   2) Lo vuelve a mostrar al hacer clic en un enlace interno o enviar
      un formulario, para cubrir el viaje al servidor (esta app es
      JSP/Servlets tradicional: cada navegación recarga la página).
   ===================================================================== */
(function () {

    function ocultarLoader() {
        var loader = document.getElementById('vb-loader');
        if (loader) {
            loader.classList.add('vb-loader--oculto');
        }
    }

    function mostrarLoader() {
        var loader = document.getElementById('vb-loader');
        if (loader) {
            loader.classList.remove('vb-loader--oculto');
        }
    }

    // Oculta el loader cuando el navegador ya pintó todo (imágenes incluidas)
    window.addEventListener('load', ocultarLoader);

    // Si por algo el evento "load" tarda, lo ocultamos igual como red de seguridad
    setTimeout(ocultarLoader, 4000);

    document.addEventListener('DOMContentLoaded', function () {

        // Vuelve a mostrar el loader al navegar a otra página del sitio
        document.addEventListener('click', function (e) {
            var link = e.target.closest('a');
            if (!link) return;

            var href = link.getAttribute('href');
            var target = link.getAttribute('target');
            var esInterno = href
                && !href.startsWith('#')
                && !href.startsWith('javascript:')
                && !href.startsWith('mailto:')
                && !href.startsWith('tel:')
                && (!target || target === '_self');

            if (esInterno) {
                mostrarLoader();
            }
        });

        // Vuelve a mostrar el loader al enviar cualquier formulario
        document.addEventListener('submit', function (e) {
            if (e.target && e.target.tagName === 'FORM') {
                mostrarLoader();
            }
        });
    });

})();
