<script setup lang="ts">
/**
 * @props guessed: string[] - letters guessed by user
 * @props incorrect: string[] - incorrect guesses
 * @props status: 'playing' | 'won' | 'lost'
 * @emits guess(letter: string)
 */
// PUBLIC_INTERFACE
const props = defineProps<{
  guessed: string[]
  incorrect: string[]
  status: 'playing' | 'won' | 'lost'
}>()
const emits = defineEmits<{ (e: 'guess', letter: string): void }>()

const LETTERS = Array.from('ABCDEFGHIJKLMNOPQRSTUVWXYZ')

// PUBLIC_INTERFACE
function onGuess(letter: string) {
  if (props.status === 'playing' && !props.guessed.includes(letter)) {
    emits('guess', letter)
  }
}
</script>

<template>
  <div class="letter-grid" :aria-disabled="status !== 'playing'">
    <button
      v-for="letter in LETTERS"
      :key="letter"
      :disabled="guessed.includes(letter) || status !== 'playing'"
      :class="{
        guessed: guessed.includes(letter),
        incorrect: incorrect.includes(letter)
      }"
      @click="onGuess(letter)"
      tabindex="0"
      type="button"
    >
      {{ letter }}
    </button>
  </div>
</template>

<style scoped>
.letter-grid {
  display: grid;
  grid-template-columns: repeat(8, 1fr);
  gap: 0.40em 0.32em;
  justify-content: center;
  align-content: center;
  margin-top: 0.60em;
  margin-bottom: 0.45em;
  width: 100%;
  max-width: 420px;
  min-height: 104px;
}
.letter-grid button {
  background: var(--color-background, #fff);
  color: var(--color-heading, #24242a);
  border: 2px solid var(--color-secondary, #2196F3);
  border-radius: 8px;
  padding: 0.25em 0.37em;
  font-size: 1.0rem;
  font-family: inherit;
  cursor: pointer;
  font-weight: 500;
  transition: all 0.13s;
  outline: none;
  min-width: 24px;
  min-height: 34px;
  margin: 0;
}

.letter-grid button:disabled {
  background: #f1f1f4;
  color: #aaa;
  cursor: not-allowed;
  opacity: 0.66;
}

.letter-grid button.guessed {
  background: var(--color-primary, #4CAF50);
  color: #fff;
  border-color: var(--color-primary, #4CAF50);
  opacity: 0.90;
}

.letter-grid button.incorrect {
  background: var(--color-accent, #FFC107);
  color: #333;
  border-color: var(--color-accent, #FFC107);
  opacity: 0.90;
}
</style>
