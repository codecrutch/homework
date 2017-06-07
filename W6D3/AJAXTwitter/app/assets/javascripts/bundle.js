/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const FollowToggle = __webpack_require__(1);
const UsersSearch = __webpack_require__(3);
const TweetCompose = __webpack_require__(4);

$(() => {

  $('.follow-toggle').each((_, button) => new FollowToggle(button));
  $('.users-search').each((_, nav) => new UsersSearch($(nav)));
  new TweetCompose(); 
});


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

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


/***/ }),
/* 2 */
/***/ (function(module, exports) {

const APIUtil = {
  followUser: (id) => {
    return $.ajax({
      url: `/users/${id}/follow`,
      method: 'POST',
      dataType: 'JSON',
      data: { user_id: id },
    });
  },

  unfollowUser: (id) => {
    return $.ajax({
      url: `/users/${id}/follow`,
      method: 'DELETE',
      dataType: 'JSON',
      data: { user_id: id },
    });
  },

  searchUsers: (queryVal, success) => {
    return $.ajax({
      url: `/users/search`,
      method: 'GET',
      dataType: 'JSON',
      data: { query: queryVal},
      success: (returnedUsers) => success(returnedUsers)
    });
  },

  createTweet: (data) => {
    return $.ajax({
      url: `/tweets`,
      method: 'POST',
      dataType: 'JSON',
      data: { tweet: { content: data.tweet.content , mentioned_user_ids: data.tweet.mentioned_user_ids}} 
    });
  }
};

module.exports = APIUtil;


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);
const FollowToggle = __webpack_require__(1);

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


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

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


/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map