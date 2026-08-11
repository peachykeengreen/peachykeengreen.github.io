---
title: "{{ .File.Dir | replaceRE `/` `` | replaceRE `^[0-9]{4}-[0-9]{2}-[0-9]{2}-` `` }}"
slug: "{{ .File.Dir | replaceRE `/` `` | replaceRE `^[0-9]{4}-[0-9]{2}-[0-9]{2}-` `` | urlize }}"
date: {{ .Date }}
draft: true
categories: []
description: ""
featured_image: ""
---

My amazing intro.

<!-- {{< figure src="{{ .File.Dir | replaceRE `/` `` | replaceRE `^[0-9]{4}-[0-9]{2}-[0-9]{2}-` `` | urlize }}-1.jpg" alt="" caption="" >}} -->

## Ingredients

- My first ingredient
- My awesome next ingredient

## Instructions

My instructions.
