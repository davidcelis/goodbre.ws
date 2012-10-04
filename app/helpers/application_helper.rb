module ApplicationHelper
  def like_button(beer)
    if current_user.likes?(beer)
      klass  = 'btn like-button btn-success'
      action = 'unlike'
    else
      klass  = 'btn like-button'
      action = 'like'
      disabled = true if current_user.dislikes?(beer) || current_user.ignored?(beer) || current_user.stashed?(beer)
    end

    <<-BUTTON
<button class='#{klass}' data-id='#{beer.id}' data-action='#{action}' data-original-title='#{action.capitalize}' #{'disabled' if disabled}>
  <i class='icon-thumbs-up'></i>
  <span class='like-count pull-right'>#{beer.likes_count}</span>
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
      disabled = true if current_user.likes?(beer) || current_user.ignored?(beer) || current_user.stashed?(beer)
    end

    <<-BUTTON
<button class='#{klass}' data-id='#{beer.id}' data-action='#{action}' data-original-title='#{action.capitalize}' #{'disabled' if disabled}>
  <i class='icon-thumbs-down'></i>
  <span class='dislike-count pull-right'>#{beer.dislikes_count}</span>
</button>
    BUTTON
  end

  def fridge_button(beer)
    if current_user.stashed?(beer)
      klass  = 'btn fridge-button btn-primary'
      action = 'unstash'
      title  = 'Remove from fridge'
    else
      klass  = 'btn fridge-button'
      action = 'stash'
      title  = 'Put in fridge'
      disabled = true if current_user.ignored?(beer) || current_user.likes?(beer) || current_user.dislikes?(beer)
    end

    <<-BUTTON
<button class='#{klass}' data-id='#{beer.id}' data-action='#{action}' data-original-title='#{title}' #{'disabled' if disabled}>
  <i class='icon-bookmark'></i>
</button>
    BUTTON
  end

  def hide_button(beer)
    if current_user.ignored?(beer)
      klass  = 'btn ignore-button btn-warning'
      action = 'unignore'
      title  = 'Unhide'
    else
      klass  = 'btn ignore-button'
      action = 'ignore'
      title  = 'Hide'
      disabled = true if current_user.likes?(beer) || current_user.dislikes?(beer) || current_user.stashed?(beer)
    end

    <<-BUTTON
<button class='#{klass}' data-id='#{beer.id}' data-action='#{action}' data-original-title='#{title}' #{'disabled' if disabled}>
  <i class='icon-eye-close'></i>
</button>
    BUTTON
  end
end
