class TweetsController < UITableViewController
  stylesheet :main

  layout do
    @tweets = []

    @searchBar = UISearchBar.new

    # Why stylesheets not working for these?
    @searchBar.frame = [[0, 0], [tableView.frame.size.width, 0]]
    @searchBar.sizeToFit
    @searchBar.text = "xcode crash"

    layout @searchBar, :search_bar
    view.tableHeaderView = @searchBar
  end

  def layoutDidLoad
    view.dataSource = view.delegate = self
    @searchBar.delegate = self
    searchBarSearchButtonClicked(@searchBar)
  end

  def searchBarSearchButtonClicked(searchBar)
    query = searchBar.text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    url = "http://search.twitter.com/search.json?q=#{query}"

    @tweets.clear
    BW::HTTP.get(url) do |response|
      if response.ok?
        new_tweets = []
        BW::JSON.parse(response.body.to_str)['results'].each do |dict|
          new_tweets << Tweet.new(dict)
        end
        load_tweets(new_tweets)
      else
        App.alert(response.error_message)
      end
    end

    searchBar.resignFirstResponder
  end

  def searchBarCancelButtonClicked(searchBar)
    searchBar.resignFirstResponder
  end

  def load_tweets(tweets)
    @tweets = tweets
    view.reloadData
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @tweets.size
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    TweetCell.heightForTweet(@tweets[indexPath.row], tableView.frame.size.width)
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    tweet = @tweets[indexPath.row]
    TweetCell.cellForTweet(tweet, inTableView:tableView)
  end

  def reloadRowForTweet(tweet)
    row = @tweets.index(tweet)
    if row
      view.reloadRowsAtIndexPaths([NSIndexPath.indexPathForRow(row, inSection:0)],
                                  withRowAnimation:false)
    end
  end
end
