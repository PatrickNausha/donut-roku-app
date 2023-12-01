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
    m.Image.uri = "pkg:/images/CraigVenter-2008.jpg"
    HlsContentNode = CreateObject("roSGNode", "ContentNode")
    HlsContentNode.streamFormat = "hls"
    HlsContentNode.url = "http://192.168.0.116:3030/hls/devito,360p.mp4,480p.mp4,720p.mp4,.en_US.vtt,.urlset/master.m3u8"
    HlsContentNode.ShortDescriptionLine1 = "Can we create new life out of our digital universe?"
    HlsContentNode.Description = "He walks the TED2008 audience through his latest research into fourth-generation fuels -- biologically created fuels with CO2 as their feedstock. His talk covers the details of creating brand-new chromosomes using digital technology, the reasons why we would want to do this, and the bioethics of synthetic life. A fascinating Q and A with TED's Chris Anderson follows."
    HlsContentNode.StarRating = 80
    HlsContentNode.Length = 1972
    HlsContentNode.Title = "Craig Venter asks, Can we create new life out of our digital universe?"

    DashContentNode = CreateObject("roSGNode", "ContentNode")
    DashContentNode.streamFormat = "dash"
    DashContentNode.url = "http://192.168.0.116:3030/dash/devito,360p.mp4,480p.mp4,720p.mp4,.en_US.vtt,.urlset/manifest.mpd"
    DashContentNode.ShortDescriptionLine1 = "Can we create new life out of our digital universe?"
    DashContentNode.Description = "He walks the TED2008 audience through his latest research into fourth-generation fuels -- biologically created fuels with CO2 as their feedstock. His talk covers the details of creating brand-new chromosomes using digital technology, the reasons why we would want to do this, and the bioethics of synthetic life. A fascinating Q and A with TED's Chris Anderson follows."
    DashContentNode.StarRating = 80
    DashContentNode.Length = 1972
    DashContentNode.Title = "Craig Venter asks, Can we create new life out of our digital universe?"

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
