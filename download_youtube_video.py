import pafy

videoHash = raw_input("Enter hash of video to download: ")
v = pafy.new(videoHash)
s = v.getbest()
print("Size is %s" % s.get_filesize())
filename = s.download()  # starts download