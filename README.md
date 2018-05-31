# Maverick

Welcome to Maverick, a blog engine built to work with [textbundles](http://textbundle.org). It's kind of a cross between static sites (in that files are stored on and read from disk), and dynamic sites that have more complicated server logic and need some database running to contain everything.

## Why Textbundle?

Typically you'll have your pages landing on your disk separate from the posts that contain them. I wanted to build a system where posts could be truly portable, and allowed maximum flexibility when adding new content to the site. Textbundles are themselves a folder structure that contain an `assets` folder for images, linked to by the enclosed markdown file inside the bundle. It's really nice.

## How Does it Work?

Maverick is built on top of the [Vapor](https://vapor.codes) framework. Inside of the `Public` folder are subfolders called `_pages` and `_posts`. The pages folder is for static pages (such as https://example.com/about), and the posts folder is for blog posts (such as https://example.com/2018/05/28/introducing-maverick/).

The presentation is done via the [Leaf](https://docs.vapor.codes/3.0/leaf/basics/) templating syntax. There are 2 templates: `index.leaf` and `post.leaf`. The site can be customized by changing those templates, and the `styles`, `scripts`, and `fonts` folders inside of `Public`.

Future plans include full API support for [micropub](https://micropub.net) and [XML-RPC](http://xmlrpc.scripting.com). I want Maverick to work exceptionally well with microblogs, and it will support title-less posts. I hope to also make things like publishing from clients such as the [Micro.blog](https://micro.blog) app or [Ulysses](https://ulyssesapp.com) work seamlessly.

Feeds will be generated with full text and truncated variants, in both [RSS](https://en.wikipedia.org/wiki/RSS) and [JSONFeed](https://jsonfeed.org). These can be used to send your content anywhere you want on the web.

## Should I Use It?

Probably not yet. It's at a very early stage of development, and built to scratch my own itch and migrate from my current Ghost blog. But if it's up your alley feel free to check it out.

## The Roadmap

There's a taskpaper file of all the things that need to get done. [Check it out here.](https://github.com/jsorge/maverick/blob/master/Maverick%20To-Do.taskpaper)
