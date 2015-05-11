'use strict';

# this script is used in background.html

chrome.runtime.onInstalled.addListener (details) ->
  console.log('previousVersion', details.previousVersion)


# User =
#   email: ""
#   name: ""

# if localStorage.getItem("user-info")
#   User = JSON.parse(localStorage.getItem("user-info"))
#   alert(JSON.stringify(User))

# chrome.runtime.onInstalled.addListener (details) ->
#   console.log('previousVersion', details.previousVersion)

# chrome.browserAction.setBadgeText({text: '00:00:00'})

cur_domain: null

# if localStorage.getItem("get-domain")
#   cur_domain = JSON.parse(localStorage.getItem("get-domain"))
  # alert(JSON.stringify(cur_domain))

# alert(cur_domain)

tabChanged = (url) ->
  cur_domain = url
  # alert(cur_domain)
  localStorage.setItem("get-domain", JSON.stringify(cur_domain))

# calc = (url)->
#   lst = Stat.data[url]
#   if not lst
#     return 0
#   n = Math.floor (lst.length / 2)
#   res = 0
#   for i in [0..n]
#     if lst[2 * i + 1] and lst[2 * i]
#       res += lst[2 * i + 1].getTime() - lst[2 * i].getTime()
#   hh = Math.floor(res / 3600000)
#   mm = Math.floor((res % 3600000) / 60000)
#   ss = Math.floor((res % 60000) / 1000)
#   return hh + ":" + mm + ":" + ss 

# updateBadge = (url)->
#   res = calc url
#   localStorage.setItem("browse-track", JSON.stringify(Stat.data))
#   chrome.browserAction.setBadgeText({text: res})

urlCheck = (url)->
  a = document.createElement 'a'
  a.href = url 
  if a.protocol == 'http:' or a.protocol == 'https:'
    return true
  else 
    return false

url2domain = (url)->
  a = document.createElement 'a'
  a.href = url 
  return a.hostname

# alert('bla')

chrome.tabs.onActivated.addListener (activeInfo)->
  console.log "Select #{activeInfo.tabId} "
  curTabId = activeInfo.tabId
  # alert(activeInfo.tabId)
  chrome.tabs.get activeInfo.tabId, (tab) ->
    if not urlCheck tab.url
        return 
    domain = url2domain tab.url
    tabChanged(domain) if domain
    # alert(domain)
    # updateBadge domain

# chrome.alarms.onAlarm.addListener (alarm)->
#   console.log alarm, curTabId
#   if alarm.name == "update"
#     if not curTabId
#       return
#     chrome.tabs.get curTabId, (tab)->
#       console.log tab
#       if not urlCheck tab.url
#         return 
#       if tab.url
#         domain = url2domain tab.url       
#         # updateBadge domain

# alert(domain)
chrome.tabs.onUpdated.addListener (tabId , info) ->
    if (info.status == "complete") 
        chrome.tabs.get tabId, (tab) ->
          if not urlCheck tab.url
              return 
          domain = url2domain tab.url
          cur_domain = domain
          localStorage.setItem("get-domain", JSON.stringify(cur_domain))
          # alert(cur_domain)

# chrome.alarms.create("update", {periodInMinutes: 0.02})
# console.log('\'Allo \'Allo! Event Page for Browser Action')

# cur_domain = document.domain

# localStorage.setItem("get-domain", JSON.stringify(cur_domain))

