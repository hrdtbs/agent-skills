# Concurrency in Go

Go's concurrency model is based on CSP (Communicating Sequential Processes). It uses goroutines (lightweight threads) and channels (typed conduits for passing data).

## Goroutines

- **Goroutine Lifecycles**: Before starting a goroutine, always know when and how it will stop. Unbounded goroutines lead to memory leaks.
- **WaitGroups**: Use `sync.WaitGroup` to wait for a collection of goroutines to finish.
- **ErrGroup**: Use `golang.org/x/sync/errgroup` when you need to run multiple operations concurrently and stop if any of them returns an error. It manages the goroutines and propagates the first error encountered.

## Channels

- **Channel Types**:
  - **Unbuffered channels**: Block until both sender and receiver are ready. Useful for synchronization.
  - **Buffered channels**: Don't block the sender until the buffer is full. Use carefully, as they can hide design flaws or lead to deadlocks if not sized correctly.
- **Closing Channels**: Only the *sender* should close a channel. Closing a channel that is already closed, or sending on a closed channel, causes a panic. Receivers can use the comma-ok idiom (`val, ok := <-ch`) to check if a channel has been closed.
- **Select Statement**: Use `select` to handle multiple channel operations (sends or receives) simultaneously. It blocks until one of its cases can run.

## Context

The `context` package is essential for managing timeouts, deadlines, and cancellation signals across API boundaries and goroutines.

- **Pass Context Explicitly**: `context.Context` should always be passed as the *first* parameter to a function, typically named `ctx`. Do not store contexts inside structs.
- **Cancellation**: Use `context.WithCancel`, `context.WithTimeout`, or `context.WithDeadline` to create derived contexts. Always call the returned `cancel` function (usually with `defer cancel()`) to release resources when the operation completes.
- **Checking Context**: Inside long-running or blocking goroutines, periodically check `ctx.Done()` using a `select` statement to see if you should stop working.

### Context Example

```go
func DoSomethingWithTimeout(ctx context.Context) error {
    // Create a new context that times out after 2 seconds
    ctx, cancel := context.WithTimeout(ctx, 2*time.Second)
    defer cancel() // Important: release resources

    ch := make(chan string)

    go func() {
        // Simulate work
        time.Sleep(1 * time.Second)
        ch <- "result"
    }()

    select {
    case res := <-ch:
        fmt.Println("Got:", res)
        return nil
    case <-ctx.Done():
        // This case runs if the timeout is reached before the work finishes
        return fmt.Errorf("operation timed out: %w", ctx.Err())
    }
}
```

## Data Races

- Always run tests and your application with the race detector enabled (`go test -race`, `go run -race`) during development and CI.
- If you need to protect shared state, use `sync.Mutex` or `sync.RWMutex`.
- Consider `sync.Map` for concurrent map access, but prefer standard maps with mutexes unless you have a specific performance bottleneck identified by profiling.
