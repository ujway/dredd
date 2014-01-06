class BaseReporter
  constructor: (emitter, stats, tests) ->
    @type = "base"
    @stats = stats
    @tests = tests
    @configureEmitter emitter

  configureEmitter: (emitter) =>
    emitter.on 'start', =>
      @stats.start = new Date

    emitter.on 'end', =>
      @stats.end = new Date
      @stats.duration = @stats.end - @stats.start

    emitter.on 'test start', (test) =>
      @tests.push(test)
      @stats.tests += 1
      test['start'] = new Date

    emitter.on 'test pass', (test) =>
      @stats.passes += 1
      test['end'] = new Date
      test['duration'] = test.end - test.start

    emitter.on 'test skip', (test) =>
      @stats.skipped += 1

    emitter.on 'test fail', (test) =>
      @stats.skipped += 1
      test['end'] = new Date
      test['duration'] = test.end - test.start

    emitter.on 'test error', (test, error) =>
      @stats.errors += 1
      test['end'] = new Date
      test['duration'] = test.end - test.start

module.exports = BaseReporter