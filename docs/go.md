# GoのTips
## Makefile
Goで使えるツールがいくつか
## pprof
```go
import (
	_ "net/http/pprof"
)

func main() {
	go func() {
		log.Print(http.ListenAndServe("localhost:6060", nil))
	}()
}
```

## sqlx
```go
	db.SetMaxOpenConns(10000)
	db.SetMaxIdleConns(10000)
```

Bulk Insert
```go
	for {
		rows = append(rows, IsuCondition{
			JIAIsuUUID: jiaIsuUUID,
			Timestamp: timestamp,
		})
	}

	_, err = tx.NamedExec(
		"INSERT INTO `isu_condition`"+
			"	(`jia_isu_uuid`, `timestamp`)"+
			"	VALUES (:jia_isu_uuid, :timestamp)",
		rows)
```
## In-Memory Cache
```go
import (
	"time"

	"github.com/patrickmn/go-cache"
)

type Cache[V any] struct {
	cache *cache.Cache
}

func NewCache[V any](expiration time.Time) *Cache[V] {
	return &Cache[V]{
		cache: cache.New(expiration, cache.NoExpiration) // 2つ目はexpireしたキャッシュをclearする間隔でOFFにしている
	}
}

func (c *Cache[V]) Get(key string) (V, bool) {
	v, ok := c.cache.Get(key)
	if ok {
		return v.(V), true
	}
	var defaultValue V
	return defaultValue, false
}

func (c *Cache[V]) Set(k string, v V) {
	c.cache.Set(k, v, cache.DefaultExpiration)
}

func (c *Cache[V]) SetNoExpiration(k string, v V) {
	c.cache.Set(k, v, cache.NoExpiration)
}
```

## goccy/go-json
JSON使う時はこれがはやいが効果は不明
https://github.com/goccy/go-json
