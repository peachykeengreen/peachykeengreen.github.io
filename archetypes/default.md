---
title: "{{ .File.Dir | replaceRE `/` `` | replaceRE `^[0-9]{4}-[0-9]{2}-[0-9]{2}-` `` | replaceRE `-` ` ` | title }}"
slug: "{{ .File.Dir | replaceRE `/` `` | replaceRE `^[0-9]{4}-[0-9]{2}-[0-9]{2}-` `` }}"
date: {{ .Date }}
draft: false
categories: []
description: ""
featured_image: ""
---
