const APIUtil = require('./api_util.js');

class FollowToggle {
  constructor(element) {
    this.$el = $(element);
    this.userId = this.$el.attr("data-user-id");
    this.followState = (this.$el.attr("data-initial-follow-state") === 'true' ? true: false);
    this.pending = false;
    this.render();
    this.handleClick();
  }

  render() {
    if (this.pending) {
      this.$el.prop('disabled', true);
    } else {
      this.$el.prop('disabled', false);
      if (this.followState) {
        this.$el.text("Unfollow!");
      } else {
        this.$el.text("Follow!");
      }
    }
  }

  toggleState() {
    this.followState = (this.followState ? false : true);
    this.pending = false;
    this.render();
  }

  handleClick() {
    this.$el.on('click', (e) => {
      // e.preventDefault();

      let fail = () => console.log("FaIL");
      if (this.followState) {
        APIUtil.unfollowUser(this.userId).then(this.toggleState.bind(this), fail);
      } else {
        APIUtil.followUser(this.userId).then(this.toggleState.bind(this), fail);
      }
      this.pending = true;
      this.render();
    });
  }
}



module.exports = FollowToggle;
