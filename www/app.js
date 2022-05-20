$(document).ready(function() {
  
  // Instantiate select2 object
  $('#select_widget').select2({
    closeOnSelect: false,
    placeholder: "Make a selection"
  });
  
  // Create a tag showing the options selected
  $('#select_widget').change(function() {
    
    var selected = $(this).find('option:selected');
    
    // Makes sure selection is not blank
    if (selected.text() != "") {
      
      // Makes sure there are no duplicate selection tags
      if ($('#show_selected').text().indexOf(selected.text()) == -1) {
        
        $('#show_selected').append(
          `
          <div class = 'control'>
            <div class = 'tags has-addons'>
              <span class = 'tag is-link'>` + selected.text() + `</span>
              <a class = 'tag is-delete'></a>
            </div>
          </div>
          `
        )
    }}
  })
  
  // Delete a tag when the delete button is
  $(document).click(function() {
    $('.is-delete').click(function() {
      $(this).parent().parent().remove();
    })
  })

})