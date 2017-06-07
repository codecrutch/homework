const APIUtil = require('./api_util.js');

class TweetCompose {
  constructor() {
    this.$form = $('.tweet-compose');
    this.$counter = $('.chars-left');
    this.countHandler();
    this.submit();
  }

  countHandler() {
    $('textarea').on('input', (e) => {
      let tweetLength = $(e.currentTarget).val().length;
      this.$counter.text(`${140 - tweetLength}`);
      if (tweetLength > 140) {
        $('#tweet-submit').prop('disabled', true);
      } else {
        $('#tweet-submit').prop('disabled', false);
      }
    });
  }

  submit() {
    this.$form.on('submit', (e) => {
      e.preventDefault();
      let data = this.$form.serializeJSON();
      console.log(data);
      APIUtil.createTweet(data).then(this.handleSuccess.bind(this));
      // disable inputs
      $(':input').prop('disabled', true);
    });
  }

  clearInput() {
    $(':input').val("");
  }

  handleSuccess(data) {
    this.clearInput();
    $(':input').prop('disabled', false);
    let feedId = this.$form.data("tweets-ul");
    console.log(data);
    // let $newTweet = $(`<li>${JSON.stringify(data)}</li>`);
    let $newTweet = $(`<li>${data.content} -- <a href="/users/${data.user.id}">${data.user.username}</a> -- ${data.created_at}</li>`);
    $(feedId).prepend($newTweet);

  }
}

module.exports = TweetCompose;
