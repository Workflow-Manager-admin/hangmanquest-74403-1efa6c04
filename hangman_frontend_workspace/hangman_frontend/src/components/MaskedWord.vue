<script setup lang="ts">
/**
 * @props maskedWord: computed masked word with underscores & spaces
 * @props originalWord: to show solution on loss
 * @props status: 'playing', 'won', or 'lost'
 */
// PUBLIC_INTERFACE
defineProps<{
  maskedWord: string
  originalWord: string
  status: 'playing' | 'won' | 'lost'
}>()
</script>

<template>
  <div class="masked-word-area">
    <div class="masked-text" :data-status="status">
      <span v-for="(char, idx) in maskedWord.split(' ')" :key="idx" class="masked-letter">
        <template v-if="char === '_'">
          <span class="masked-underscore">_</span>
        </template>
        <template v-else-if="char === ''">
          <span>&nbsp;</span>
        </template>
        <template v-else>
          <span class="masked-reveal">{{ char }}</span>
        </template>
      </span>
    </div>
    <div v-if="status === 'won'" class="message win">🎉 You won!</div>
    <div v-if="status === 'lost'" class="message lose">Game Over! Word was: <b>{{ originalWord }}</b></div>
  </div>
</template>

<style scoped>
.masked-word-area {
  text-align: center;
  margin-top: 0.3em;
  margin-bottom: 0.8em;
  min-height: 2em;
}

.masked-text {
  font-size: 2.0rem;
  letter-spacing: 0.4rem;
  font-family: 'Fira Mono', 'Menlo', 'Consolas', 'monospace';
  color: var(--color-heading, #24242a);
  user-select: none;
  margin-bottom: 0.2em;
  word-break: break-word;
}
.masked-text[data-status="won"] .masked-reveal,
.masked-text[data-status="lost"] .masked-reveal {
  color: var(--color-primary, #4CAF50);
  font-weight: bold;
}
.masked-letter {
  display: inline-block;
  min-width: 1.15em;
  margin: 0 0.01em;
}
.masked-underscore {
  color: #BFBFBF;
  font-size: 1.03em;
  font-weight: 400;
}
.masked-reveal {
  color: var(--color-primary, #4CAF50);
  font-weight: 500;
}

.message {
  margin-top: 0.5em;
  font-size: 1.18rem;
  font-weight: 500;
}
.win {
  color: var(--color-primary, #4CAF50);
}
.lose {
  color: var(--color-accent, #FFC107);
}
</style>
