$(function () {
  $("#formRegistro").validate({
    rules: {
      nombre: {
        required: true
      },
      correo: {
        required: true,
        email: true
      },
      contrasena: {
        required: true,
        minlength: 6
      },
      confirmar_contrasena: {
        required: true,
        equalTo: "#contrasena"
      }
    },
    messages: {
      nombre: {
        required: "Campo obligatorio"
      },
      correo: {
        required: "Campo obligatorio",
        email: "Formato incorrecto"
      },
      contrasena: {
        required: "Campo obligatorio",
        minlength: "Mínimo 6 caracteres"
      },
      confirmar_contrasena: {
        required: "Campo obligatorio",
        equalTo: "Las contraseñas no coinciden"
      }
    },
    errorElement: "span",
    errorClass: "text-danger",
    highlight: function (element) {
      $(element).addClass("is-invalid");
    },
    unhighlight: function (element) {
      $(element).removeClass("is-invalid");
    }
  });
});