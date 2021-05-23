module CableHelper
  # This cable broadcast methos will be usable in all actioncable call 
  def cable_broadcast(channel, data)
    ActionCable.server.broadcast channel, content: data
  end
end
