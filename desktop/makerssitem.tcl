
#
# Author :  DFL
# Version : 1.0
# Date :    Jun 2017
# Licence : Creative Commons BY-SA
# Description
#     makes an RSS item, writes it to a file, from a form input
# Version Comment:
#     Initial Version
#
wm title . {Make Item}
wm iconname . {MRI}
# location only
wm geometry . +550+300

set launchdir [pwd]
set workingdir "/Users/davel/etc"
cd $workingdir

frame .top ; frame .top.margin ; frame .top.space -width 5 ; frame .top.motd
frame .mid ; frame .mid.0 ;frame .mid.1 ; frame .mid.2 ; frame .mid.3 ; frame .mid.4
frame .bottom

label .mid.0.filetitle -width 8 -text "File:"
entry .mid.0.filetext -bg white -fg grey -relief sunken -width 64

label .mid.1.titletitle -width 8 -text "Title:"
entry .mid.1.titletext -bg white -width 64

label .mid.2.linktitle -width 8 -text "Link: "
entry .mid.2.linktext -bg white -width 64

label .mid.3.desctitle -width 8 -text "Desc:"
entry .mid.3.desctext -bg white -width 64

label .mid.4.datetitle -width 8 -text "Date: "
entry .mid.4.datetext -bg white -width 64
# called <pubDate>
label .mid.4.default -text "DD MMM YYYY hh:mm:ss +0100"

set buttontextd "  Dismiss  "
set buttontextc "  Commit   "
# make sure its there
image create photo infopic -file [file join $tk_library images info.gif]
label .top.margin.icon  -image infopic

label .top.motd.title -text "Make RSS Item"

button .bottom.dismiss -text $buttontextd -command "exit"
button .bottom.commit -text $buttontextc  -command "commit"

# Needs two colums to force justifications

pack .mid.0.filetitle .mid.0.filetext -fill both -side left -padx 4 -pady 2
pack .mid.1.titletitle .mid.1.titletext -fill both -side left -padx 4 -pady 2
pack .mid.2.linktitle  .mid.2.linktext  -fill both -side left -padx 4 -pady 2
pack .mid.3.desctitle  .mid.3.desctext  -fill both -side left -padx 4 -pady 2
pack .mid.4.datetitle  .mid.4.datetext  -fill both -side left -padx 4 -pady 2
pack .top.margin.icon  .top.motd.title

pack   .bottom.commit .bottom.dismiss -side left  -padx 4 -pady 2
pack   .top.margin .top.space .top.motd -side left -pady 4
pack   .mid.0 .mid.1 .mid.2 .mid.3 .mid.4
pack   .top .mid .bottom

proc commit {} {
    set idelim {<item>}; set endidelim {</item>}

    set linkstring [ .mid.2.linktext get ]
    append link4write {<link>} $linkstring {</link>}

    set titlestring [ .mid.1.titletext get ]
    append title4write {<title>} $titlestring {</title>}

    set descstring [ .mid.3.desctext get ]
    append desc4write {<description>} $descstring {</description>}

    set datestring [ .mid.4.datetext get ]
    append date4write {<pubDate>} $datestring {</pubDate>}

    # label .mid.4.default -text "DD MMM YYYY hh:mm:ss +0100"
    # label .i -text $idelim ; label .ei -text $endidelim
    
    set outputbuffer {}
    lappend  outputbuffer $idelim $title4write $link4write $desc4write $date4write $endidelim
    # label .z -text $outputbuffer

    set filename [ .mid.0.filetext get ]
    # open the filename for writing
    set fileId [open $filename "w"]
    foreach line $outputbuffer { puts $fileId $line } 
    # send the data to the file -
    close $fileId                                     
    # close the file,
    
    set message "Item written to $filename"
    label .mess -text $message
    pack .mess
    }

proc exit {} {
    destroy .
}
