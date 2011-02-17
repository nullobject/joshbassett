---
title: Caching RESTful APIs in Rails
created_at: 2011-02-17
---

Intro to HTTP caching, Rails support and the state of the union.

## I'm in your HTTP headers, controlling your cache

* talk about the Cache-Control response header
* talk about the Last-Modified response header
* talk about the If-Modified-Since request header
* talk about ETags

### Public

Public indicates that the response MAY be cached by any cache, even if it would normally be non-cacheable or cacheable only within a non-shared cache.

### Private

Indicates that all or part of the response message is intended for a single user and MUST NOT be cached by a shared cache. This allows an origin server to state that the specified parts of the response are intended for only one user and are not a valid response for requests by other users. A private (non-shared) cache MAY cache the response.

### No-cache

If the no-cache directive does not specify a field-name, then a cache MUST NOT use the response to satisfy a subsequent request without successful revalidation with the origin server. This allows an origin server to prevent caching even by caches that have been configured to return stale responses to client requests.

If the no-cache directive does specify one or more field-names, then a cache MAY use the response to satisfy a subsequent request, subject to any other restrictions on caching. However, the specified field-name(s) MUST NOT be sent in the response to a subsequent request without successful revalidation with the origin server. This allows an origin server to prevent the re-use of certain header fields in a response, while still allowing caching of the rest of the response.

## Rails controllers

Talk about the `expires_in` method. Sets the Cache-Control header on the response.

    [@language="ruby"]
    [@caption="Listing 1"]

    expires_in 20.minutes
    expires_in 3.hours, :public => true
    expires_now

Talk about the `fresh_when` method. Sets the ETag and/or Last-Modified headers on the response.

    [@language="ruby"]
    [@caption="Listing 2"]

    def show
      @article = Article.find(params[:id])
      return if fresh_when(:etag => @article, :last_modified => @article.updated_at.utc, :public => true)
      respond_with(@article)
    end

Talk about the `stale?` method. Sets the ETag and/or Last-Modified headers on the response.

    [@language="ruby"]
    [@caption="Listing 3"]

    def show
      @article = Article.find(params[:id])
      if stale?(:etag => @article, :last_modified => @article.created_at.utc)
        @statistics = @article.really_expensive_call
        respond_with(@statistics)
      end
    end

## Mmm, dog food tastes good! ActiveResource, you wanna try some?

If Rails makes it so easy to provide caching for your RESTful API, then why doesn't ActiveResource support it out of the box? Sometimes it's good to eat your own dog food.

G Tizzle
