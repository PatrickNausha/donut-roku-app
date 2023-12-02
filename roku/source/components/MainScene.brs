sub init()
    m.Image = m.top.findNode("Image")
    m.ButtonGroup = m.top.findNode("ButtonGroup")
    m.Details = m.top.findNode("Details")
    m.Title = m.top.findNode("Title")
    m.VideoHls = m.top.findNode("VideoHls")
    m.VideoDash = m.top.findNode("VideoDash")
    m.Warning = m.top.findNode("WarningDialog")
    setContent()
    m.ButtonGroup.setFocus(true)
    m.ButtonGroup.observeField("buttonSelected", "onButtonSelected")
end sub

sub onButtonSelected()
    hlsButtonIndex = 0
    dashButtonIndex = 1
    if m.ButtonGroup.buttonSelected = hlsButtonIndex
        m.VideoHls.visible = "true"
        m.VideoHls.control = "play"
        m.VideoHls.setFocus(true)
    else if m.ButtonGroup.buttonSelected = dashButtonIndex
        m.VideoDash.visible = "true"
        m.VideoDash.control = "play"
        m.VideoDash.setFocus(true)
    end if
end sub

'Set your information here
sub setContent()
    description = "This is a spinning donut. The donut has pink frosting and sprinkles."
    shortDescriptionLine1 = "This is a spinning donut. The donut has pink frosting and sprinkles."

    m.Image.uri = "pkg:/images/donut-thumbnail.png"
    HlsContentNode = CreateObject("roSGNode", "ContentNode")
    HlsContentNode.streamFormat = "hls"
    HlsContentNode.url = "http://patrick-video-streaming-service.eastus.azurecontainer.io/hls/donut,360p.mp4,480p.mp4,720p.mp4,1080p.mp4,.urlset/master.m3u8"
    HlsContentNode.ShortDescriptionLine1 = shortDescriptionLine1
    HlsContentNode.Description = description
    HlsContentNode.Title = "Spinning Donut"

    DashContentNode = CreateObject("roSGNode", "ContentNode")
    DashContentNode.streamFormat = "dash"
    DashContentNode.url = "http://patrick-video-streaming-service.eastus.azurecontainer.io/dash/donut,360p.mp4,480p.mp4,720p.mp4,1080p.mp4,.urlset/manifest.mpd"
    DashContentNode.ShortDescriptionLine1 = shortDescriptionLine1
    DashContentNode.Description = description
    DashContentNode.Title = "Spinning Donut"

    m.VideoHls.content = HlsContentNode
    m.VideoDash.content = DashContentNode

    'Change the buttons
    Buttons = ["Play HLS", "Play DASH"]
    m.ButtonGroup.buttons = Buttons

    m.Title.text = "Watch this donut spin!"
    m.Details.text = "In 2022 I followed Blender Guru's Donut Tutorial and the video above is the result. This isn't a very involved Roku Channel, but it was a chance to showcase a small amount of BrightScript/SceneGraph development."
end sub

' Called when a key on the remote is pressed
function onKeyEvent(key as string, press as boolean) as boolean
    print "in SimpleVideoScene.xml onKeyEvent ";key;" "; press
    if press then
        if key = "back"
            print "------ [back pressed] ------"
            if m.Warning.visible
                m.Warning.visible = false
                m.ButtonGroup.setFocus(true)
                return true
            else if m.VideoHls.visible
                m.VideoHls.control = "stop"
                m.VideoHls.visible = false
                m.ButtonGroup.setFocus(true)
                return true
            else if m.VideoDash.visible
                m.VideoDash.control = "stop"
                m.VideoDash.visible = false
                m.ButtonGroup.setFocus(true)
                return true
            else
                return false
            end if
        else if key = "OK"
            print "------- [ok pressed] -------"
            if m.Warning.visible
                m.Warning.visible = false
                m.ButtonGroup.setFocus(true)
                return true
            end if
        else
            return false
        end if
    end if
    return false
end function
