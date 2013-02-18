Teacup.handler UISearchBar, :shows_cancel_button do |view, value|
  view.showsCancelButton = value
end

Teacup.handler UITableViewCell, :label_font do |view, fontSize|
  view.textLabel.font = UIFont.systemFontOfSize(fontSize)
end

Teacup.handler UITableViewCell, :label_num_lines do |view, num|
  view.textLabel.numberOfLines = num
end

Teacup::Stylesheet.new(:main) do

  style :search_bar,
    shows_cancel_button: true

end

Teacup::Stylesheet.new(:cell) do

  style(:tweet_cell,
    label_font: 14,
    label_num_lines: 0
  )

end
