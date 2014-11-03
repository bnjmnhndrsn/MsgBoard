module ApplicationHelper
  def logout_button
    form = "<div class=\"navbar-nav nav navbar-right\">"
    form +=  "<form action=\"/session\" method=\"post\" class=\"form-inline\">"
    form += "<div class=\"form-group\"><p class=\"navbar-text\">Welcome #{current_user.username}!</p></div>"
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
  
end
