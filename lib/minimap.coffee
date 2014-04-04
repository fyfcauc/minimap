{Emitter} = require 'emissary'
Debug = require 'prolix'

require '../vendor/resizeend'

ViewManagement = require './mixins/view-management'

class Minimap
  Emitter.includeInto(this)
  ViewManagement.includeInto(this)
  Debug('minimap').includeInto(this)

  configDefaults: { plugins: {} }

  # We'll be using this property to store the toggle state as the
  # minimapViews object will never be set to null.
  active: false

  activate: ->
    atom.workspaceView.command 'minimap:toggle', => @toggleNoDebug()
    atom.workspaceView.command 'minimap:toggle-debug', => @toggleDebug()

  deactivate: ->
    @destroyViews()
    @emit('deactivated')

  toggle: () ->
    if @active
      @active = false
      @deactivate()
    else
      @createViews()
      @active = true
      @emit('activated')

  toggleDebug: ->
    @getChannel().activate()
    @toggle()

  toggleNoDebug: ->
    @getChannel().deactivate()
    @toggle()

module.exports = new Minimap()
