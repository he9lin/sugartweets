Teacup.handler UISearchBar, :shows_cancel_button do |view, value|
  view.showsCancelButton = value
end

Teacup::Stylesheet.new(:main) do

  style :search_bar,
    shows_cancel_button: true

end
