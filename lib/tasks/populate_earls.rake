# rubocop:disable LineLength
namespace :earls do
  desc 'gather top posts from reddit, and assign their score as the number of views on tiny_earl'
  task populate: :environment do
    session = Redd.it(
      user_agent: 'TinyEarl',
      client_id: ENV['REDDIT_ID'],
      secret: ENV['REDDIT_SECRET'],
      username: ENV['REDDIT_USERNAME'],
      password: ENV['REDDIT_PASSWORD']
    )

    last_post_name = nil
    LIMIT = 50
    0.upto(3) do |page|
      session.subreddit('all').top(limit: LIMIT, count: page * LIMIT, after: last_post_name).each do |post|
        Earl.create(full_url: post.url, view_count: post.score)
        last_post_name = post.name
      end
    end
  end
end
