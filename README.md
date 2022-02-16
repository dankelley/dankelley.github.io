# About this blog

This Jekyll-based blog was started January 2014, at which time a few items
previously stored on Wordpress were transferred here.

The advantage of blogging with Jekyll is mainly that the files are local and
can be created in a standard text editor.  But there are also disadvantages
that become clearer over time:

1. Anything not in the Wordpress system is a bit hidden from the blogging
   community.

2. Using Jekyll is labourious and tricky.  I've found that the system is
   brittle, requiring fiddling from time to time, to keep up with changes in
   what seems to be a big toolchain.  This might not be a problem for people
   using Ruby from day to day, but it makes me think the pain is not worth the
   gain.

# How to post

Enter the `assets` directory. Create a file with a name like
`yyyy-mm-dd-topic.Rmd` and write an entry. It is easiest to pattern this on
existing entries. Then, type `make yyyy-mm-dd-topic.md` (using your date and
topic, of course). This will create some files, and at the end you'll see
a message telling you what to do next, namely to go up a directory, type `make`
and then git add/commit/push.  Well, maybe you'll see that message.  And maybe
you'll see an error message that will require you to look at the Makefile
(which is just something I hacked together) or your system. Remember to take
your heart medicine before starting to try to debug this.

Visit https://dankelley.github.io/blog/ (perhaps after waiting 10 minutes) to
see if it worked.

