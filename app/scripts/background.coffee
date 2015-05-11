'use strict';

# this script is used in background.html

chrome.runtime.onInstalled.addListener (details) ->
  console.log('previousVersion', details.previousVersion)


cur_domain: null


# Checking url 
urlCheck = (url)->
  a = document.createElement 'a'
  a.href = url 
  if a.protocol == 'http:' or a.protocol == 'https:'
    return true
  else 
    return false

# Takes domain from url
url2domain = (url)->
  a = document.createElement 'a'
  a.href = url 
  return a.hostname

updateBadge = (url)->
  chrome.browserAction.setBadgeText({text: JSON.stringify(URL.count) })


changeCount = (url) ->
  if localStorage.getItem("url-info")
    URL.data = JSON.parse(localStorage.getItem("url-info"))
    if URL.data[url]
      URL.count = URL.data[url]
    else URL.count = 0
    updateBadge url

tabChanged = (url) ->
  cur_domain = url
  changeCount cur_domain


chrome.tabs.onActivated.addListener (activeInfo)->
  curTabId = activeInfo.tabId
  chrome.tabs.get activeInfo.tabId, (tab) ->
    if not urlCheck tab.url
        return 
    domain = url2domain tab.url
    tabChanged(domain) if domain

# function for update number of comments
chrome.alarms.onAlarm.addListener (alarm)->
  if alarm.name == "update"
    if not URL.curTabId
      return
    chrome.tabs.get URL.curTabId, (tab)->
      if not urlCheck tab.url
        return 
      if tab.url
        domain = url2domain tab.url
    changeCount domain


chrome.tabs.onUpdated.addListener (tabId , info) ->
    if (info.status == "complete") 
        chrome.tabs.get tabId, (tab) ->
          if not urlCheck tab.url
              return 
          domain = url2domain tab.url
          # Save domain in localStorage for popup.js
          localStorage.setItem("get-domain", JSON.stringify(domain))
          tabChanged domain

# call function for update number of comments
chrome.alarms.create("update", {periodInMinutes: 0.02})

URL =
  data: {}
  count: 0


