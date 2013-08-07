Bbs::App.helpers do

  def name_or_you account
    name = account.name
    return nil   unless account
    return name  unless logged_in?
    return 'You' if current_account.id == account.id
    account.name
  end

end
