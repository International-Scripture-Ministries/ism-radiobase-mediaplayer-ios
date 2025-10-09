# tmtplayer

Player to play audio on lockscreen as well.

## Install

```bash
npm install tmtplayer
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`playMediaList(...)`](#playmedialist)
* [`addMediaToList(...)`](#addmediatolist)
* [`clearMediaList()`](#clearmedialist)
* [`play()`](#play)
* [`pause()`](#pause)
* [`getCurrentPlayerItemSeekTime()`](#getcurrentplayeritemseektime)
* [`fetchMediaListStatistics()`](#fetchmedialiststatistics)
* [`updatePlayerRate(...)`](#updateplayerrate)
* [`getCurrentMediaItemPlaybackInfo()`](#getcurrentmediaitemplaybackinfo)
* [`removeAllMediaItemsExceptCurrentPlayingItem()`](#removeallmediaitemsexceptcurrentplayingitem)
* [`seekToTimeInSeconds(...)`](#seektotimeinseconds)
* [`checkPlayingMediaList()`](#checkplayingmedialist)
* [`getStatisticsOfLastPlayedMediaBeforeAppClose()`](#getstatisticsoflastplayedmediabeforeappclose)
* [`removeStatisticsOfLastPlayedMedia()`](#removestatisticsoflastplayedmedia)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => any
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>any</code>

--------------------


### playMediaList(...)

```typescript
playMediaList(options: { mediaList: string; }) => any
```

| Param         | Type                                |
| ------------- | ----------------------------------- |
| **`options`** | <code>{ mediaList: string; }</code> |

**Returns:** <code>any</code>

--------------------


### addMediaToList(...)

```typescript
addMediaToList(options: { mediaList: string; }) => any
```

| Param         | Type                                |
| ------------- | ----------------------------------- |
| **`options`** | <code>{ mediaList: string; }</code> |

**Returns:** <code>any</code>

--------------------


### clearMediaList()

```typescript
clearMediaList() => any
```

**Returns:** <code>any</code>

--------------------


### play()

```typescript
play() => any
```

**Returns:** <code>any</code>

--------------------


### pause()

```typescript
pause() => any
```

**Returns:** <code>any</code>

--------------------


### getCurrentPlayerItemSeekTime()

```typescript
getCurrentPlayerItemSeekTime() => any
```

**Returns:** <code>any</code>

--------------------


### fetchMediaListStatistics()

```typescript
fetchMediaListStatistics() => any
```

**Returns:** <code>any</code>

--------------------


### updatePlayerRate(...)

```typescript
updatePlayerRate(options: { rate: number; }) => any
```

| Param         | Type                           |
| ------------- | ------------------------------ |
| **`options`** | <code>{ rate: number; }</code> |

**Returns:** <code>any</code>

--------------------


### getCurrentMediaItemPlaybackInfo()

```typescript
getCurrentMediaItemPlaybackInfo() => any
```

**Returns:** <code>any</code>

--------------------


### removeAllMediaItemsExceptCurrentPlayingItem()

```typescript
removeAllMediaItemsExceptCurrentPlayingItem() => any
```

**Returns:** <code>any</code>

--------------------


### seekToTimeInSeconds(...)

```typescript
seekToTimeInSeconds(options: { seconds: number; }) => any
```

| Param         | Type                              |
| ------------- | --------------------------------- |
| **`options`** | <code>{ seconds: number; }</code> |

**Returns:** <code>any</code>

--------------------


### checkPlayingMediaList()

```typescript
checkPlayingMediaList() => any
```

**Returns:** <code>any</code>

--------------------


### getStatisticsOfLastPlayedMediaBeforeAppClose()

```typescript
getStatisticsOfLastPlayedMediaBeforeAppClose() => any
```

**Returns:** <code>any</code>

--------------------


### removeStatisticsOfLastPlayedMedia()

```typescript
removeStatisticsOfLastPlayedMedia() => any
```

**Returns:** <code>any</code>

--------------------

</docgen-api>
