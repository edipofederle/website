---
title: Python/Django notes from a Ruby/Rails Developer
date: 2019-05-26
tags: python, django, rails, ruby, programming
---

So, recently I starting working with Python/Django, come from a Ruby/Rails background, I decide keep notes about some points. So here we go:

**NOTE:** I will keep this post updated as I figure out new things.

- Use `pk` instead of `id`

Some models don't follow the rule of use `id` as the primary key. So always use `.pk` in order to get the correct primary key

```python
object.pk
```


- Run single test case: `./manage.py test app.tests.test_helper`


- Tests: mocks

Inform the path from where the method is called. In this case, the method `foo_bar` is used inside the `my_app` helper.


```python
@mock.patch('my_app.helpers.foo_bar', return_value=10)
```


If is a object related method, use:

```python
mock.patch.object(Object, 'foo_bar')
```

You can also use `return_value` if you need

```python
 mock.return_value = some_thing
```


- Refresh object from DB

```python
obj.refresh_from_db()
```
