module ApplicationHelper
  def logout_button
    form = "<div class=\"navbar-nav nav navbar-right\">"
    form +=  "<form action=\"/session\" method=\"post\" class=\"form-inline\">"
    form += "<div class=\"form-group\"><p class=\"navbar-text\">Logged in as #{current_user.username}</p></div>"
    form += "<input type=\"hidden\" value=\"DELETE\" name=\"_method\">"
    form += "<button value=\"Submit!\"  class=\"btn-default btn\">Sign Out</button>"
    form += "</form></div>"
    form.html_safe
  end
  
  def vote_buttons(object)
    obj_name = object.class.to_s.downcase
    
    upvote_path = send("upvote_#{obj_name}_path", object)
    upvote_span = content_tag("span", "", class: "glyphicon glyphicon-arrow-up")
    form = "<div class=\"btn-group\">"
    form += form_for(:upvote, url: upvote_path) do |f| 
      f.button(upvote_span, class: "btn btn-default btn-xs")
    end
    
    downvote_path = send("downvote_#{obj_name}_path", object)
    downvote_span = content_tag("span", "", class: "glyphicon glyphicon-arrow-down")
    form += form_for(:downvote, url: downvote_path) do |f|
      f.button(downvote_span, class: "btn btn-default btn-xs")
    end
    form += "</div>"
    form.html_safe
  end
  
  def vote_badge(object)
		number = content_tag("div", object.score, class: "btn-group")
    buttons = vote_buttons(object)
    "<div class=\"vote-badge\">#{number}#{buttons}</div>".html_safe
  end
  
  def edit_delete_buttons(object)
    obj_name = object.class.to_s.downcase
    edit_url = send("edit_#{obj_name}_url", object)
    edit_link = link_to("Edit", edit_url, class: "btn btn-default btn-xs")
    
    destroy_url = send("#{obj_name}_url", object)
    destroy_link = form_for(object, url: destroy_url, method: :delete, html: { class: "btn-group" }) do |f|
      f.button("Delete", class: "btn btn-default btn-xs")
    end
    
    (content_tag("div", edit_link, class: "btn-group") + destroy_link).html_safe
  end
  
  def default_grid(&blk)
    content_tag("div", class: "row") do
      content_tag("div", class: "col-xs-6 col-xs-offset-3", &blk)
    end
  end
  
end
