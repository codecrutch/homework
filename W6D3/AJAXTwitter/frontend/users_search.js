const APIUtil = require('./api_util.js');
const FollowToggle = require('./follow_toggle.js');

class UsersSearch {
  constructor($element) {
    this.$nav = $element;
    this.$input = this.$nav.find('input[name]');
    this.$ul = this.$nav.find('ul');

    this.handleInput();

  }

  handleInput() {
    this.$input.on('input', (e) => {
      e.preventDefault();
      APIUtil.searchUsers(this.$input.val(), this.renderResults.bind(this));
    });
  }

  renderResults(returnedUsers) {
    this.$ul.empty();
    returnedUsers.forEach(user => {
      let $li = $(`<li><a href="/users/${user.id}">${user.username}</a></li>`);
      let userButton = $(`<button type="button" name="follow" class='follow-toggle' data-user-id='${user.id}' data-initial-follow-state='${user.followed}'></button>`);
      new FollowToggle(userButton);
      $li.append(userButton);
      this.$ul.append($li);
    });
  }
}

module.exports = UsersSearch;
