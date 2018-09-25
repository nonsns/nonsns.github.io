#==========================================================================
# IMAGES
#-------------------------------------------------------------------------- 
https://meta.stackexchange.com/questions/2133/whats-the-recommended-syntax-for-an-image-with-a-link

It is possible to use Markdown for both the image and the link. You'll have to do it manually because the toolbar isn't smart enough to add a custom link for you.

Reference-style:

[![alt text][image]][hyperlink]

  [hyperlink]: https://meta.stackoverflow.com/users/44330/jason-s
  [image]: https://www.gravatar.com/avatar/…?s=128&d=identicon&r=PG (tooltip)
    or
  [image]: https://www.gravatar.com/avatar/…?s=128&d=identicon&r=PG "tooltip"
alt text

Inline-style:
[![alt text](image "tooltip")](hyperlink)
  eg:
[![alt text](https://www.gravatar.com/avatar/… "Let's check Jason S' profile page")]


[![alt text][image]][hyperlink]
[![alt text](image "tooltip")](hyperlink)


#==========================================================================
# FOR LOOPS
#-------------------------------------------------------------------------- 


{% comment %}
<!-- https://shopify.github.io/liquid/tags/iteration/ -->
{% for year in (2008..2018) reversed %}
	## {{ year }}   
	<!-- amazing: years render correctly, seminar-year is correctly set but bibliography uses 2018 
	     https://jekyllrb.com/tutorials/orderofinterpretation/
	-->

	{% bibliography --file seminar-{{ year }}  --template bibseminar %}  
{% endfor %}
{% endcomment %}


