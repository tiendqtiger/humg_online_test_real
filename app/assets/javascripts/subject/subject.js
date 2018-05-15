var TableDatatablesEditable = function() {
    var e = function() {
        function e(e, t) {
            for (var n = e.fnGetData(t), a = $(">td", t), l = 0, r = a.length; r > l; l++) e.fnUpdate(n[l], t, l, !1);
            e.fnDraw()
        }

        function t(e, t) {
            var n = e.fnGetData(t),
                a = $(">td", t);
            a[0].innerHTML = '<input type="text" class="form-control input-small" value="' + n[0] + '">', a[1].innerHTML = '<input type="text" class="form-control input-small" value="' + n[1] + '">', a[2].innerHTML = '<a class="edit" href="">Save</a>', a[3].innerHTML = '<a class="cancel" href="">Cancel</a>'
        }

        function n(e, t) {
            var n = $("input", t);
            e.fnUpdate(n[0].value, t, 0, !1), e.fnUpdate(n[1].value, t, 1, !1), e.fnUpdate('<a class="edit" href="">Edit</a>', t, 2, !1), e.fnUpdate('<a class="delete" href="">Delete</a>', t, 3, !1), e.fnDraw()
        }
        var a = $("#sample_editable_1"),
            l = a.dataTable({
                lengthMenu: [
                    [5, 10, 15, 20, -1],
                    [5, 10, 15, 20, "All"]
                ],
                pageLength: 10,
                language: {
                    lengthMenu: " _MENU_ bản ghi"
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
                        type: response['noti']
                    });
                    }, error: function(response){
                    new PNotify({
                        title: 'Oh No!',
                        text: response['message'],
                        type: response['noti']
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
    $('#create_subject').click(function(){
        var subject_code = $('#subject_code').val();
        var subject_name = $('#subject_name').val();
        $.ajax({
            url: '/subject/create_subject',
            type: 'POST',
            data: {subject_code: subject_code, subject_name: subject_name},
            success: function(response){
                var new_row = '<tr>'+
                    '<td>'+subject_code+'</td>'+
                    '<td>'+subject_name+'</td>'+
                    '<td>'+
                        '<a class="edit" href="javascript:;"> Edit </a>'
                    +'</td>'+
                    '<td>'+
                        '<a class="delete" id="delete_subject" href="javascript:;"> Delete </a>'
                    +'</td>'+
                    '<input type="hidden" value="'+response['subject_id']+'">'
                +'</tr>';
                $('#list_subject').append(new_row);
                $('#subject_code').val('');
                $('#subject_name').val('');
                new PNotify({
                        title: 'Success!',
                        text: response['message'],
                        type: response['noti']
                    });
            },
            error: function(response){
                new PNotify({
                        title: 'Oh No!',
                        text: response['message'],
                        type: response['noti']
                    });
            }
        });
    });
});