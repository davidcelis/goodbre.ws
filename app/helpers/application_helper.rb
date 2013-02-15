module ApplicationHelper
  def action_buttons(beer)
    likes = current_user.likes?(beer)
    dislikes = current_user.dislikes?(beer)
    hides = current_user.hides?(beer)
    bookmarks = current_user.bookmarks?(beer)
    notes = Note.where(:user_id => current_user.id, :beer_id => beer.id).exists? rescue nil

    if likes
      klass  = 'btn like-button btn-success'
      action = 'unlike'
      disabled = false
    else
      klass  = 'btn like-button'
      action = 'like'
      disabled = dislikes || hides ? true : false
    end

    like_button = <<-BUTTON
<button class='#{klass}' data-id='#{beer.id}' data-action='#{action}' data-original-title='#{action.capitalize}' #{'disabled' if disabled}>
  <i class='icon-thumbs-up'></i>
  <span class='like-count pull-right'>#{beer.liked_by_count}</span>
</button>
    BUTTON

    if dislikes
      klass  = 'btn dislike-button btn-danger'
      action = 'undislike'
      disabled = false
    else
      klass  = 'btn dislike-button'
      action = 'dislike'
      disabled = likes || hides ? true : false
    end

    dislike_button = <<-BUTTON
<button class='#{klass}' data-id='#{beer.id}' data-action='#{action}' data-original-title='#{action.capitalize}' #{'disabled' if disabled}>
  <i class='icon-thumbs-down'></i>
  <span class='dislike-count pull-right'>#{beer.disliked_by_count}</span>
</button>
    BUTTON

    if bookmarks
      klass  = 'btn fridge-button btn-primary'
      action = 'unbookmark'
      title  = 'Remove from fridge'
      disabled = false
    else
      klass  = 'btn fridge-button'
      action = 'bookmark'
      title  = 'Put in fridge'
      disabled = hides ? true : false
    end

    bookmark_button = <<-BUTTON
<button class='#{klass}' data-id='#{beer.id}' data-action='#{action}' data-original-title='#{title}' #{'disabled' if disabled}>
  <i class='icon-bookmark'></i>
</button>
    BUTTON

    if hides
      klass  = 'btn hide-button btn-warning'
      action = 'unhide'
      title  = 'Unhide'
      disabled = false
    else
      klass  = 'btn hide-button'
      action = 'hide'
      title  = 'Hide'
      disabled = likes || dislikes || bookmarks ? true : false
    end

    hide_button = <<-BUTTON
<button class='#{klass}' data-id='#{beer.id}' data-action='#{action}' data-original-title='#{title}' #{'disabled' if disabled}>
  <i class='icon-eye-close'></i>
</button>
    BUTTON

    if notes
      klass = 'btn-info'
    else
      klass = ''
    end

    note_button = <<-BUTTON
<button class='btn note-button #{klass}' data-id='#{beer.id}' data-action='note' data-original-title='Notes'>
  <i class='icon-pencil'></i>
</button>
    BUTTON

    [like_button, dislike_button, bookmark_button, hide_button, note_button].join("\n")
  end
end
