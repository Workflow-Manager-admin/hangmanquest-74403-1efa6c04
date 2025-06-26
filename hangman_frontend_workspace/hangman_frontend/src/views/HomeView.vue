<script setup lang="ts">
import { ref, computed, type CSSProperties } from 'vue'
import HangmanDrawing from '../components/HangmanDrawing.vue'
import MaskedWord from '../components/MaskedWord.vue'
import LetterGrid from '../components/LetterGrid.vue'
import GameControls from '../components/GameControls.vue'

// PUBLIC_INTERFACE
const WORDS = [
  'JAVASCRIPT', 'VUEJS', 'HANGMAN', 'OPENAI', 'KNOWLEDGE', 'MINIMAL DESIGN', 'MODERN WEB'
]

const maxAttempts = 6

const word = ref('')
const guessed = ref<string[]>([])
const incorrect = ref<string[]>([])
const status = ref<'playing' | 'won' | 'lost'>('playing')
const score = ref(0)

// PUBLIC_INTERFACE
function startNewGame() {
  // Pick a random word
  word.value = WORDS[Math.floor(Math.random() * WORDS.length)]
  guessed.value = []
  incorrect.value = []
  status.value = 'playing'
}

// PUBLIC_INTERFACE
function guessLetter(letter: string) {
  if (status.value !== 'playing' || guessed.value.includes(letter)) return
  guessed.value.push(letter)
  if (word.value.includes(letter)) {
    // Check win
    if (maskedWord.value.replace(/ /g, '') === word.value.replace(/ /g, '')) {
      status.value = 'won'
      score.value += 1
    }
  } else {
    incorrect.value.push(letter)
    if (incorrect.value.length >= maxAttempts) {
      status.value = 'lost'
    }
  }
}

// PUBLIC_INTERFACE
const maskedWord = computed(() =>
  word.value
    .split('')
    .map(ch =>
      ch === ' ' ? ' ' : (guessed.value.includes(ch) ? ch : '_')
    )
    .join(' ')
)

const remaining = computed(() => maxAttempts - incorrect.value.length)

startNewGame()

const attemptsStyle = computed<CSSProperties>(() => ({
  color: '#4caf50',
  fontWeight: 'bold',
  textAlign: 'left',
  fontSize: '1.2875rem',
  fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Fira Sans", "Droid Sans", "Helvetica Neue", sans-serif'
}))
</script>

<template>
  <div class="hangman-container">
    <h1 class="game-title">Hangman</h1>
    <HangmanDrawing :attempts="incorrect.length" :maxAttempts="maxAttempts" class="drawing" />
    <MaskedWord :maskedWord="maskedWord" :originalWord="word" :status="status" class="masked" />
    <LetterGrid
      :guessed="guessed"
      :incorrect="incorrect"
      :status="status"
      @guess="guessLetter"
    />
    <div class="attempts-score-row">
      <span><strong :style="{color: '#2196f3', fontWeight: 'bold', textAlign: 'left', fontSize: '1.35rem'}">Score:</strong> {{ score }}</span>
      <span class="remaining" :style="attemptsStyle">
        <strong>Attempts:</strong> {{ remaining }} / {{ maxAttempts }}
      </span>
    </div>
    <GameControls
      :status="status"
      :word="word"
      @restart="startNewGame"
    />
  </div>
</template>

<style scoped>
.hangman-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  min-height: 80vh;
  justify-content: center;
  background: var(--color-background);
  margin: 0 auto;
  padding: 2rem 1rem;
  border-radius: 24px;
  box-shadow: 0 2px 24px rgba(68, 68, 68, 0.04);
  max-width: 430px;
}

.game-title {
  text-align: center;
  font-size: 2.2rem;
  letter-spacing: 0.08em;
  color: var(--color-primary, #4CAF50);
  margin: 0.35em 0 0.75em;
  font-weight: 600;
}

.drawing {
  margin-bottom: 2.1rem;
  min-height: 168px;
  width: 150px;
}

.masked {
  margin-bottom: 1.6rem;
  width: 100%;
}

.attempts-score-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  font-size: 1.1rem;
  margin: 1.25rem 0 0.65rem;
  padding: 0 0.6em;
}

.remaining {
  font-weight: 600;
}

@media (max-width: 640px) {
  .hangman-container {
    max-width: 99vw;
    padding: 0.7rem 0.4rem;
    border-radius: 16px;
  }
  .drawing {
    min-height: 120px;
    width: 100px;
  }
}
</style>
