var TableDatatablesEditable = function() {
    var e = function() {
        function e(e, t) {
            for (var n = e.fnGetData(t), a = $(">td", t), l = 0, r = a.length; r > l; l++) e.fnUpdate(n[l], t, l, !1);
            e.fnDraw()
        }

        function t(e, t) {
            var n = e.fnGetData(t),
                a = $(">td", t);
            a[0].innerHTML = '<input type="text" class="form-control input-small subject_code" value="' + n[0] + '">', a[1].innerHTML = '<input type="text" class="form-control input-small subject_name" value="' + n[1] + '">', a[2].innerHTML = '<a class="edit" href="">Save</a>', a[3].innerHTML = '<a class="cancel" href="">Cancel</a>'
        }

        function n(e, t) {
            var n = $("input", t);
            e.fnUpdate(n[0].value, t, 0, !1), e.fnUpdate(n[1].value, t, 1, !1), e.fnUpdate('<a class="edit" href="">Edit</a>', t, 2, !1), e.fnUpdate('<a class="delete" href="">Delete</a>', t, 3, !1), e.fnDraw()
        }
        var a = $("#sample_editable_1"),
            l = a.dataTable({
                lengthMenu: [
                    [5, 15, 20, -1],
                    [5, 15, 20, "All"]
                ],
                pageLength: 5,
                language: {
                    lengthMenu: " _MENU_ records"
                },
                columnDefs: [{
                    orderable: !0,
                    targets: [0]
                }, {
                    searchable: !0,
                    targets: [0]
                }],
                order: [
                    [0, "asc"]
                ]
            }),
            r = ($("#sample_editable_1_wrapper"), null),
            o = !1;
        
        a.on("click", ".delete", function(e) {
            e.preventDefault();
            var this_obj = $(this);
            var subject_id = this_obj.parent().next().val().toString();
            $.ajax({
              url: '/subject/delete_subject',
              type: 'POST',
              data: {subject_id: subject_id},
              success: function(response){
                new PNotify({
                    title: 'Success!',
                    text: response['message'],
                    type: 'success'
                    });
                this_obj.parent().parent().remove();
            }, error: function(response){
                new PNotify({
                    title: 'Oh No!',
                    text: response['message'],
                    type: 'error',
                    });
                }
            })
        }), a.on("click", ".cancel", function(t) {
            t.preventDefault(), o ? (l.fnDeleteRow(r), r = null, o = !1) : (e(l, r), r = null)
        }), a.on("click", ".edit", function(a) {
            a.preventDefault(), o = !1;
            var i = $(this).parents("tr")[0];
            function excute(a) {
                subject_id = a.parent().next().next().val();
                subject_code = a.parent().prev().prev().children().val();
                subject_name = a.parent().prev().children().val();
                // console.log(subject_name);
                $.ajax({
                  url: '/subject/update_subject',
                  type: 'POST',
                  data: {subject_id: subject_id, subject_code: subject_code, subject_name: subject_name},
                  success: function(response){
                    new PNotify({
                        title: 'Success!',
                        text: response['message'],
                        type: 'success'
                    });
                    }, error: function(response){
                    new PNotify({
                        title: 'Oh No!',
                        text: response['message'],
                        type: 'error',
                    });
                    }
                })
            }
            null !== r && r != i ? (e(l, r), t(l, i), r = i) : r == i && "Save" == this.innerHTML ? (excute($(this)),n(l, r), r = null) : (t(l, i), r = i)
        })
    };
    return {
        init: function() {
            e()
        }
    }
}();
jQuery(document).ready(function() {
    TableDatatablesEditable.init();
});