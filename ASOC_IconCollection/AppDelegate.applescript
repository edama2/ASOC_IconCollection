--
--  AppDelegate.applescript
--  ASOC_IconCollection
--
--  Created by zzz on 2020/01/22.
--  Copyright ý 2020 zzz. All rights reserved.
--

(*
# 
NSWindow
@„¯„ª Bordered Scroll View - Collection View
@@@@„¯„ª Collection View Item
@@@@@@@„¯„ª View
@@@@@@@@@@„¯„±„ª Image View
@@@@@@@@@@@„¯„ª Text Filed

# Binding
AppDelegate --> _the_array_controller

Collection View 
	Contents --> _the_array_controller --> arrangedObjects
	Selection Indexes --> _the_array_controller --> selectionIndexes

Collection View Item
	view --> View
	itemPrototype --> Collection View Item

View
	Image View --> Collection View Item --> representedObject.fileURL
	Text Filed --> Collection View Item --> representedObject.Name

*)


script AppDelegate
	property parent : class "NSObject"
	
	-- IBOutlets
	property _the_window : missing value
	
	on applicationShouldTerminate:sender
		return current application's NSTerminateNow
	end applicationShouldTerminate:
	
	on applicationShouldTerminateAfterLastWindowClosed:sender
		return true
	end applicationShouldTerminateAfterLastWindowClosed:
	
	on applicationWillFinishLaunching:aNotification
	end applicationWillFinishLaunching:
	
end script

#MARK: - NSValueTransformer
script YKZURLToIcon
	property parent : class "NSValueTransformer"
	property allowsReverseTransformation : false
	property transformedValueClass : a reference to current application's NSImage
	
	on transformedValue:fileURL
		if fileURL is missing value then return
		
		set appPath to fileURL's |path|()
		set iconImage to current application's NSWorkspace's sharedWorkspace's iconForFile:appPath
		return iconImage
	end transformedValue:
end script

script YKZURLToDisplayedName
	property parent : class "NSValueTransformer"
	property allowsReverseTransformation : false
	property transformedValueClass : a reference to current application's NSString
	
	on transformedValue:fileURL
		if fileURL is missing value then return
		
		set appPath to fileURL's |path|()
		set displayedName to current application's NSFileManager's defaultManager's displayNameAtPath:appPath
		return displayedName
	end transformedValue:
end script

#MARK: -
script YKZNoRespondBox
	property parent : class "NSBox"
	
	on hitTest:aPoint
		return missing value -->ƒNƒŠƒbƒN‚É”½‰ž‚µ‚È‚¢
	end hitTest:
end script

#MARK: - NSScrollView
--”wŒi‚ÉƒOƒ‰ƒf[ƒVƒ‡ƒ“‚ð•\Ž¦‚·‚é
script YKZScrollView
	property parent : class "NSScrollView"
	
	global _background_gradient --> IBOutlet‚É•\Ž¦‚µ‚È‚¢
	
	on awakeFromNib()
		log "YKZScrollView/awakeFromNib"
		# ”wŒiF‚ÌƒOƒ‰ƒf[ƒVƒ‡ƒ“‚ðÝ’è‚·‚é
		set strartColor to current application's NSColor's colorWithDeviceRed:0.349 green:0.6 blue:0.898 alpha:0.0
		set endColor to current application's NSColor's colorWithDeviceRed:0.349 green:0.6 blue:0.898 alpha:0.6
		set _background_gradient to current application's NSGradient's alloc()'s initWithStartingColor:strartColor endingColor:endColor
	end awakeFromNib
	
	#MARK: ƒOƒ‰ƒf[ƒVƒ‡ƒ“‚ð•`‰æ
	on drawRect:rect
		_background_gradient's drawInRect:(my |bounds|()) angle:90.0
	end drawRect:
end script

#MARK: -
script YKZViewController
	property parent : class "NSViewController"
	
	# IBOutlet
	property _collection_view : missing value
	property _array_controller : missing value
	
	#‚±‚Ìproperty‚Ì–¼‘O‚Æƒnƒ“ƒhƒ‰‚ª˜A“®‚µ‚Ä‚¢‚é
	property sortingMode : 0 -->ƒ\[ƒgó‘Ô
	property alternateColors : false -->”wŒiF‚Ìó‘Ô
	
	#“à•”‚ÅŽg‚¤—p‚È‚Ì‚Åglobal‚É‚·‚é
	global _saved_alternate_colors
	
	# Image View—p
	property _KEY_IMAGE : "icon"
	property _KEY_NAME : "name"
	
	#MARK: awakeFromNib:
	on awakeFromNib()
		
		# save this for later when toggling between alternate colors
		set _saved_alternate_colors to _collection_view's backgroundColors()
		
		my setSortingMode:0 # icon collection in ascending sort order
		my setAlternateColors:alternateColors # no alternate background colors (initially use gradient background)
		
		#
		set tempArray to {}
		
		set coreTypes to current application's NSBundle's bundleWithPath:"/System/Library/CoreServices/CoreTypes.bundle/"
		repeat with i in (coreTypes's pathsForResourcesOfType:"icns" inDirectory:"")
			set aName to (current application's NSFileManager's defaultManager()'s displayNameAtPath:i)
			set aPicture to (current application's NSImage's alloc()'s initWithContentsOfFile:i)
			set tempArray's end to {icon:aPicture, |name|:aName}
		end repeat
		
		set icons to {}
		
		set icons's end to current application's NSImageNameActionTemplate
		set icons's end to current application's NSImageNameAddTemplate
		set icons's end to current application's NSImageNameAdvanced
		set icons's end to current application's NSImageNameApplicationIcon
		set icons's end to current application's NSImageNameBluetoothTemplate
		set icons's end to current application's NSImageNameBonjour
		set icons's end to current application's NSImageNameBookmarksTemplate
		set icons's end to current application's NSImageNameCaution
		set icons's end to current application's NSImageNameColumnViewTemplate
		set icons's end to current application's NSImageNameColorPanel
		set icons's end to current application's NSImageNameComputer
		set icons's end to current application's NSImageNameDotMac
		set icons's end to current application's NSImageNameEnterFullScreenTemplate
		set icons's end to current application's NSImageNameEveryone
		set icons's end to current application's NSImageNameExitFullScreenTemplate
		set icons's end to current application's NSImageNameFlowViewTemplate
		set icons's end to current application's NSImageNameFolder
		set icons's end to current application's NSImageNameFolderBurnable
		set icons's end to current application's NSImageNameFolderSmart
		set icons's end to current application's NSImageNameFollowLinkFreestandingTemplate
		set icons's end to current application's NSImageNameFontPanel
		set icons's end to current application's NSImageNameGoLeftTemplate
		set icons's end to current application's NSImageNameGoRightTemplate
		set icons's end to current application's NSImageNameHomeTemplate
		set icons's end to current application's NSImageNameIChatTheaterTemplate
		set icons's end to current application's NSImageNameIconViewTemplate
		set icons's end to current application's NSImageNameInfo
		set icons's end to current application's NSImageNameInvalidDataFreestandingTemplate
		set icons's end to current application's NSImageNameLeftFacingTriangleTemplate
		set icons's end to current application's NSImageNameListViewTemplate
		set icons's end to current application's NSImageNameLockLockedTemplate
		set icons's end to current application's NSImageNameLockUnlockedTemplate
		set icons's end to current application's NSImageNameMenuMixedStateTemplate
		set icons's end to current application's NSImageNameMenuOnStateTemplate
		set icons's end to current application's NSImageNameMobileMe
		set icons's end to current application's NSImageNameMultipleDocuments
		set icons's end to current application's NSImageNameNetwork
		set icons's end to current application's NSImageNamePathTemplate
		set icons's end to current application's NSImageNamePreferencesGeneral
		set icons's end to current application's NSImageNameQuickLookTemplate
		set icons's end to current application's NSImageNameRefreshFreestandingTemplate
		set icons's end to current application's NSImageNameRefreshTemplate
		set icons's end to current application's NSImageNameRemoveTemplate
		set icons's end to current application's NSImageNameRevealFreestandingTemplate
		set icons's end to current application's NSImageNameRightFacingTriangleTemplate
		set icons's end to current application's NSImageNameSlideshowTemplate
		set icons's end to current application's NSImageNameSmartBadgeTemplate
		set icons's end to current application's NSImageNameStatusAvailable
		set icons's end to current application's NSImageNameStatusNone
		set icons's end to current application's NSImageNameStatusPartiallyAvailable
		set icons's end to current application's NSImageNameStatusUnavailable
		set icons's end to current application's NSImageNameStopProgressFreestandingTemplate
		set icons's end to current application's NSImageNameStopProgressTemplate
		set icons's end to current application's NSImageNameTrashEmpty
		set icons's end to current application's NSImageNameTrashFull
		set icons's end to current application's NSImageNameUser
		set icons's end to current application's NSImageNameUserAccounts
		set icons's end to current application's NSImageNameUserGroup
		set icons's end to current application's NSImageNameUserGuest
		
		repeat with aName in icons
			set aPicture to (current application's NSImage's imageNamed:aName)
			set tempArray's end to {icon:aPicture, |name|:aName}
		end repeat
		
		# ƒ\[ƒg‚µ‚ÄArrayController‚É“o˜^
		set descriptorsArray to current application's NSSortDescriptor's alloc()'s initWithKey:"name" ascending:(sortingMode as boolean) selector:"caseInsensitiveCompare:"
		set descriptorsArray to descriptorsArray as list
		set sortedArray to (current application's NSMutableArray's arrayWithArray:tempArray)'s sortedArrayUsingDescriptors:descriptorsArray
		tell _array_controller
			addObjects_(sortedArray)
			setSelectionIndex_(0)
		end tell
		
		#
		_collection_view's setDraggingSourceOperationMask:(current application's NSDragOperationCopy) forLocal:false
	end awakeFromNib
	
	#MARK: ƒRƒŒƒNƒVƒ‡ƒ“ƒrƒ…[‚Ì”wŒiF‚ð•ÏX
	on setAlternateColors:useAlternateColors
		set alternateColors to useAlternateColors
		if alternateColors then
			set startColor to current application's NSColor's gridColor()
			set endColor to current application's NSColor's lightGrayColor()
			_collection_view's setBackgroundColors:{startColor, endColor}
		else
			_collection_view's setBackgroundColors:_saved_alternate_colors
		end if
	end setAlternateColors:
	
	#MARK: •À‚Ñ‡‚ðƒ\[ƒg‚·‚é
	on setSortingMode:newMode
		set sortingMode to newMode
		set sort to current application's NSSortDescriptor's alloc()'s initWithKey:_KEY_NAME ascending:sortingMode selector:"caseInsensitiveCompare:"
		_array_controller's setSortDescriptors:(sort as list)
	end setSortingMode:
	
	#MARK: ƒhƒ‰ƒbƒN•ƒhƒƒbƒvˆ—
	on collectionView:cv writeItemsAtIndexes:indexes toPasteboard:aPasteboard
		set urls to {}
		--set temporaryDirectoryURL to current application's class "NSURL"'s fileURLWithPath_isDirectory_((path to temporary items)'s POSIX path, true)
		set temporaryDirectory to (path to temporary items)'s POSIX path
		
		set aIndex to indexes's firstIndex()
		--log result
		
		repeat (indexes's |count| as integer) times
			
			#‘I‘ðƒAƒCƒeƒ€‚ðŽæ‚èo‚·
			tell (cv's content's objectAtIndex:aIndex)
				set thisImage to objectForKey_(_KEY_IMAGE)
				set thisName to objectForKey_(_KEY_NAME)
			end tell
			
			if (thisImage ‚ missing value) and (thisName ‚ missing value) then
				
				#tiffƒCƒ[ƒW‚ðƒeƒ“ƒ|ƒ‰ƒŠƒtƒHƒ‹ƒ_‚É•Û‘¶
				tell current application's NSString
					set str to stringWithFormat_("%@.tiff", thisName's stringByDeletingPathExtension())
				end tell
				tell (current application's NSURL's fileURLWithPath:(temporaryDirectory & str as text))
					set urls's end to it
					thisImage's TIFFRepresentation()'s writeToURL:it atomically:true
				end tell
			end if
			
			#ŽŸ‚Ìindex‚ðŽw’è
			set aIndex to indexes's indexGreaterThanIndex:aIndex
			--log result
		end repeat
		
		if (count urls) > 0 then
			aPasteboard's clearContents()
			return aPasteboard's writeObjects:urls
		end if
	end collectionView:writeItemsAtIndexes:toPasteboard:
	
end script


