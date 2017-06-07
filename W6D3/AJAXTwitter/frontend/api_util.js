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
