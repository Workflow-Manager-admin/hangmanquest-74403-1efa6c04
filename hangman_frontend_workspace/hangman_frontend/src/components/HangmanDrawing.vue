<script setup lang="ts">
/**
 * @props attempts: number of incorrect guesses (0 to maxAttempts)
 * @props maxAttempts: max allowed (for reference, usually 6)
 */
// PUBLIC_INTERFACE
defineProps<{
  attempts: number
  maxAttempts: number
}>()
</script>

<template>
  <svg
    :width="150"
    :height="180"
    viewBox="0 0 120 160"
    class="hangman-svg"
    aria-label="Hangman Drawing"
  >
    <!-- Gallows (always rendered) -->
    <line x1="20" y1="150" x2="100" y2="150" stroke="#727272" stroke-width="5" />
    <line x1="40" y1="150" x2="40" y2="15" stroke="#727272" stroke-width="5" />
    <line x1="40" y1="15" x2="85" y2="15" stroke="#727272" stroke-width="5" />
    <line x1="85" y1="15" x2="85" y2="30" stroke="#727272" stroke-width="5" />

    <!-- Head -->
    <circle
      v-if="attempts > 0"
      cx="85"
      cy="43"
      r="13"
      stroke="#8B2F0F"
      stroke-width="3"
      fill="#FFDAB2"
    />
    <!-- Body -->
    <line
      v-if="attempts > 1"
      x1="85" y1="56"
      x2="85" y2="105"
      stroke="#4CAF50"
      stroke-width="4"
      stroke-linecap="round"
      />
    <!-- Left Arm -->
    <line
      v-if="attempts > 2"
      x1="85" y1="58"
      x2="65" y2="85"
      stroke="#2196F3"
      stroke-width="4"
      stroke-linecap="round"
      />
    <!-- Right Arm -->
    <line
      v-if="attempts > 3"
      x1="85" y1="58"
      x2="105" y2="85"
      stroke="#FFC107"
      stroke-width="4"
      stroke-linecap="round"
      />
    <!-- Left Leg -->
    <line
      v-if="attempts > 4"
      x1="85" y1="105"
      x2="72" y2="135"
      stroke="#2196F3"
      stroke-width="4"
      stroke-linecap="round"
      />
    <!-- Right Leg -->
    <line
      v-if="attempts > 5"
      x1="85" y1="105"
      x2="98" y2="135"
      stroke="#FFC107"
      stroke-width="4"
      stroke-linecap="round"
      />
  </svg>
</template>

<style scoped>
.hangman-svg {
  display: block;
  margin: 0 auto;
}
</style>
