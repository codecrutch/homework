const FollowToggle = require('./follow_toggle.js');
const UsersSearch = require('./users_search.js');
const TweetCompose = require('./tweet_compose.js');

$(() => {

  $('.follow-toggle').each((_, button) => new FollowToggle(button));
  $('.users-search').each((_, nav) => new UsersSearch($(nav)));
  new TweetCompose(); 
});
