(defun conv/org-sync-to-usb ()
  	"gets all my org files on the usb"
	(interactive)
	(when (y-or-n-p "do you want to sync TO the usb")
	  (shell-command "tar czf org.tar.gz ~/org")
	  (eshell-command "mv ./org.tar.gz ~/usb/org.tar.gz")))

(defun conv/org-sync-from-usb ()
  	"gets all my org files OFF the usb"
	(interactive)
	(when (y-or-n-p "do you want to sync FROM the usb?")
	  (eshell-command "cp ~/usb/org.tar.gz ~/")
	  (eshell-command "tar xzf ~/org.tar.gz")))

(defun conv/org-rsync-with-thinkpond ()
    "syncs all my files with thinkpond"
    (interactive)
    (when (y-or-n-p "do you want to sync with thinkpond?")
      (shell-command "rsync -ru ~/org/ radtaditha@thinkpond:ftp/org/")
      (shell-command "rsync -ru radtaditha@thinkpond:ftp/org/ ~/org/")
      (message "done :>")))

(defun conv/org-agenda-list ()
  "convieniently sets up my org agenda list :>"
  (interactive)
  (org-agenda-list)
  (delete-other-windows)
  (org-agenda-day-view))

(defun conv/usr-sync-to-usb ()
  "convieniently sync my usr files to usb"
  (interactive)
  (when (y-or-n-p "do you want to sync TO the usb?")
	(shell-command "tar czf usr.tar.gz ./usr")
	(eshell-command "mv ./usr.tar.gz ~/usb/usr.tar.gz")))

(defun conv/usr-sync-from-usb ()
  "conveniently sync my usr files from usb"
  (interactive)
  (when (y-or-n-p "do you want to sync FROM the usb?")
	(eshell-command "cp ~/usb/usr.tar.gz ~/")
	(eshell-command "tar xzf ~/usr.tar.gz")))
