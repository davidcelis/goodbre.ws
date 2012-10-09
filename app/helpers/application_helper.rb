module ApplicationHelper
  def like_button(beer)
    if current_user.likes?(beer)
      klass  = 'btn like-button btn-success'
      action = 'unlike'
    else
      klass  = 'btn like-button'
      action = 'like'
      disabled = true if current_user.dislikes?(beer) || current_user.hides?(beer)
    end

    <<-BUTTON
<button class='#{klass}' data-id='#{beer.id}' data-action='#{action}' data-original-title='#{action.capitalize}' #{'disabled' if disabled}>
  <i class='icon-thumbs-up'></i>
  <span class='like-count pull-right'>#{beer.liked_by_count}</span>
</button>
    BUTTON
  end

  def dislike_button(beer)
    if current_user.dislikes?(beer)
      klass  = 'btn dislike-button btn-danger'
      action = 'undislike'
    else
      klass  = 'btn dislike-button'
      action = 'dislike'
      disabled = true if current_user.likes?(beer) || current_user.hides?(beer)
    end

    <<-BUTTON
<button class='#{klass}' data-id='#{beer.id}' data-action='#{action}' data-original-title='#{action.capitalize}' #{'disabled' if disabled}>
  <i class='icon-thumbs-down'></i>
  <span class='dislike-count pull-right'>#{beer.disliked_by_count}</span>
</button>
    BUTTON
  end

  def fridge_button(beer)
    if current_user.bookmarks?(beer)
      klass  = 'btn fridge-button btn-primary'
      action = 'unbookmark'
      title  = 'Remove from fridge'
    else
      klass  = 'btn fridge-button'
      action = 'bookmark'
      title  = 'Put in fridge'
      disabled = true if current_user.hides?(beer)
    end

    <<-BUTTON
<button class='#{klass}' data-id='#{beer.id}' data-action='#{action}' data-original-title='#{title}' #{'disabled' if disabled}>
  <i class='icon-bookmark'></i>
</button>
    BUTTON
  end

  def hide_button(beer)
    if current_user.hides?(beer)
      klass  = 'btn hide-button btn-warning'
      action = 'unhide'
      title  = 'Unhide'
    else
      klass  = 'btn hide-button'
      action = 'hide'
      title  = 'Hide'
      disabled = true if current_user.likes?(beer) || current_user.dislikes?(beer) || current_user.bookmarks?(beer)
    end

    <<-BUTTON
<button class='#{klass}' data-id='#{beer.id}' data-action='#{action}' data-original-title='#{title}' #{'disabled' if disabled}>
  <i class='icon-eye-close'></i>
</button>
    BUTTON
  end
end
