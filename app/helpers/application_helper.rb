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
end
