module FlashesHelper
  def team_facing_flashes
    flash.to_hash.slice("alert", "error", "notice", "success")
  end
end
