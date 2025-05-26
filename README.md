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
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### playMediaList(...)

```typescript
playMediaList(options: { mediaList: string; }) => Promise<{ value: string; }>
```

| Param         | Type                                |
| ------------- | ----------------------------------- |
| **`options`** | <code>{ mediaList: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### addMediaToList(...)

```typescript
addMediaToList(options: { mediaList: string; }) => Promise<{ value: string; }>
```

| Param         | Type                                |
| ------------- | ----------------------------------- |
| **`options`** | <code>{ mediaList: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### clearMediaList()

```typescript
clearMediaList() => Promise<{ value: string; }>
```

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### play()

```typescript
play() => Promise<{ value: string; }>
```

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### pause()

```typescript
pause() => Promise<{ value: string; }>
```

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### getCurrentPlayerItemSeekTime()

```typescript
getCurrentPlayerItemSeekTime() => Promise<{ time: number; }>
```

**Returns:** <code>Promise&lt;{ time: number; }&gt;</code>

--------------------


### fetchMediaListStatistics()

```typescript
fetchMediaListStatistics() => Promise<{ statisticsList: any[]; }>
```

**Returns:** <code>Promise&lt;{ statisticsList: any[]; }&gt;</code>

--------------------


### updatePlayerRate(...)

```typescript
updatePlayerRate(options: { rate: number; }) => Promise<{ value: string; }>
```

| Param         | Type                           |
| ------------- | ------------------------------ |
| **`options`** | <code>{ rate: number; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### getCurrentMediaItemPlaybackInfo()

```typescript
getCurrentMediaItemPlaybackInfo() => Promise<{ info: any; }>
```

**Returns:** <code>Promise&lt;{ info: any; }&gt;</code>

--------------------


### removeAllMediaItemsExceptCurrentPlayingItem()

```typescript
removeAllMediaItemsExceptCurrentPlayingItem() => Promise<{ value: string; }>
```

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### seekToTimeInSeconds(...)

```typescript
seekToTimeInSeconds(options: { seconds: number; }) => Promise<{ value: string; }>
```

| Param         | Type                              |
| ------------- | --------------------------------- |
| **`options`** | <code>{ seconds: number; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### checkPlayingMediaList()

```typescript
checkPlayingMediaList() => Promise<{ mediaList: any[]; }>
```

**Returns:** <code>Promise&lt;{ mediaList: any[]; }&gt;</code>

--------------------


### getStatisticsOfLastPlayedMediaBeforeAppClose()

```typescript
getStatisticsOfLastPlayedMediaBeforeAppClose() => Promise<{ statistics: any; }>
```

**Returns:** <code>Promise&lt;{ statistics: any; }&gt;</code>

--------------------


### removeStatisticsOfLastPlayedMedia()

```typescript
removeStatisticsOfLastPlayedMedia() => Promise<{ value: string; }>
```

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------

</docgen-api>
