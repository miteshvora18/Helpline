$(document).ready(function () {
    //On page load
    GetUnreadMsgList();
    RefreshStatus();
    ChatGrid();
    GroupChatGrid();
    GetUserDetails();

    //After every 3 sec
    setInterval(function () {
        GetUnreadMsgList();
        RefreshStatus();
        ChatGrid();
        GroupChatGrid();
    }, 3000);

    //Not allow backspace 
    $(document).keydown(function (e) {
        if (e.which == 8 && (document.activeElement.id == 'memberlist')) {
            e.preventDefault();
            return false;
        }
    });  

    //Message
    function GetUnreadMsgList() {
        $.post('RefreshUnreadMsg', function (data) {
            // Update the ItemList html element
            $('#lblUnreadMsg').html(data);
        });
    }

    //Dialog PopUp
    var dialog
    //groupname = $("#groupname")
    //icon = $("#icon")
    //memberlist = $("#memberlist")
    //allFields = $([]).add(groupname).add(icon).add(memberlist)
    //tips = $(".validateTips");

    dialog = $("#dialog-form").dialog({
        autoOpen: false,
        height: 300,
        width: 500,
        modal: true,
        show: {
            effect: "blind",
            duration: 1000
        },
        hide: {
            effect: "explode",
            duration: 1000
        },
        close: function () {
            //$("#dialog-form").reset();
            //allFields.removeClass("ui-state-error");
            $("#group_GroupName").val('');
            $("#group_Memberlist").val();
            $("#group_Memberlistid").val();
        },
        open: function (event, ui) {
            //tips.text('');
        }
    });

    $("#create-user").click(function () {
        dialog.dialog("open");
    });

    /*
    function addGroup() {
        var valid = true;
        allFields.removeClass("ui-state-error");

        valid = valid && checkLength(groupname, "groupname", 1, 300);

        //if (valid) {
        //    dialog.dialog("close");
        //}
        return valid;
    }

    function updateTips(t) {
        tips
            .text(t)
            .addClass("ui-state-highlight");
        setTimeout(function () {
            tips.removeClass("ui-state-highlight", 1500);
        }, 500);
    }

    function checkLength(o, n, min, max) {
        if (o.val().length > max || o.val().length < min) {
            o.addClass("ui-state-error");
            updateTips("Length of " + n + " must be between " +
                min + " and " + max + ".");
            return false;
        } else {
            return true;
        }
    }*/
    //End dialog

    //Autocomplete
    /*
    var availableTags = [
        "ActionScript",
        "AppleScript",
        "Asp",
        "BASIC",
        "C",
        "C++",
        "Clojure",
        "COBOL",
        "ColdFusion",
        "Erlang",
        "Fortran",
        "Groovy",
        "Haskell",
        "Java",
        "JavaScript",
        "Lisp",
        "Perl",
        "PHP",
        "Python",
        "Ruby",
        "Scala",
        "Scheme"
    ];
    */

    function split(val) {
        return val.split(/,\s*/);
    }
    function extractLast(term) {
        return split(term).pop();
    }

    function GetUserDetails() {
        availableTags = new Array();
        
        $.post('GetUserList', function (data) {
            $.each($.parseJSON(data), function (i, item) {
                var name = item.name;
                var uid = item.uid;
                availableTags.push({ 'label': name, 'value' : uid });
            });
        });
    }

    $("#group_Memberlist")
    // don't navigate away from the field on tab when selecting an item
    .on("keydown", function (event) {
        if (event.keyCode === $.ui.keyCode.TAB &&
            $(this).autocomplete("instance").menu.active) {
            event.preventDefault();
        }
    })
    .autocomplete({
        minLength: 0,
        source: function (request, response) {
            // delegate back to autocomplete, but extract the last term
            response($.ui.autocomplete.filter(
                availableTags, extractLast(request.term)));
        },
        focus: function () {
            // prevent value inserted on focus
            return false;
        },
        select: function (event, ui) {
            var terms = split(this.value);
            // remove the current input
            terms.pop();
            // add the selected item
            terms.push(ui.item.label);
            // add placeholder to get the comma-and-space at the end
            terms.push("");
            this.value = terms.join(", ");

            //Enter ids
            var ids = split($("#group_Memberlistid").val());
            ids.pop();
            ids.push(ui.item.value);
            ids.push("");
            $("#group_Memberlistid").val(ids);
            //alert($("#group_Memberlistid").val());
            return false;
        }
    });
    //End
});

function addZero(i) {
    if (i < 10) {
        i = "0" + i;
    }
    return i;
}


