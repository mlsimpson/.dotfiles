PLUGIN_NAME = 'Add to iTunes'
PLUGIN_AUTHOR = 'Andrew Barnert'
PLUGIN_DESCRIPTION = 'Add an album or track to iTunes.'
PLUGIN_VERSION = '0.1'
PLUGIN_API_VERSIONS = ['0.12']

import os.path
import re
import picard.ui.itemviews
from PyQt4 import QtGui

try:
    import appscript
    import mactypes

    class AddToITunes(picard.ui.itemviews.BaseAction):
		NAME = "Add to &iTunes"

		def callback(self, objs):
			paths = [mactypes.File(f.filename).hfspath
					 for path in objs[0].iterfiles()]
			try:
				tracks = appscript.app('iTunes').add(paths)
				msg = '%d track(s) added to iTunes' % (len(tracks), )
			except appscript.reference.CommandError, x:
				msg = 'Failed: %s' % (x.errormessage,)
			mbox = QtGui.QMessageBox()
			mbox.setText(msg)
			mbox.exec_()
			#
			# TODO: More result handling?
			#
			# iTunes will return a list of file_track objects.
			#
			# We might want to use location.path to tell Picard that the
			# file has been moved or copied. (To tell which, I think you
			# have to check if the original still exists.)
			#
			# We might want to stash database_ID, so a plugin could later
			# just do app.file_tracks[its.database_ID == ...] to find it
			# again.
except:
	import os
	import os.path
	import subprocess

	class AddToITunes(picard.ui.itemviews.BaseAction):
		NAME = "Add to &iTunes"

		def callback(self, objs):
			paths = ['posix file "%s"' % (os.path.abspath(f.filename),)
					 for f in objs[0].iterfiles()]
			script = u'tell app "iTunes" to add {%s}' % ', '.join(paths)
			p = subprocess.Popen(['osascript'],
								 stdin=subprocess.PIPE,
								 stdout=subprocess.PIPE,
								 stderr=subprocess.PIPE)
			o, e = p.communicate(script)
			r = p.returncode
			if r == 0:
				msg = '%d track(s) added to iTunes' % (len(o.split(',')), )
			else:
				msg = e
			mbox = QtGui.QMessageBox()
			mbox.setText(msg)
			mbox.exec_()

# TODO: Would you really want to add a cluster, or an unmatched/unsaved
# file? Not sure.
action = AddToITunes()
picard.ui.itemviews.register_track_action(action)
picard.ui.itemviews.register_file_action(action)
picard.ui.itemviews.register_cluster_action(action)
picard.ui.itemviews.register_album_action(action)
