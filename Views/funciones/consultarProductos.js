$(function () {
    new DataTable("#tProductos", {
        language: {
            url: "/PowerZone/Views/assets/css/i18n/es-ES.json"
        },
        ordering: false,
        columnDefs: [{ className: "dt-left px-2", targets: "_all" }]
    });
});
