<script setup lang="ts">
/**
 * @props status: 'playing' | 'won' | 'lost'
 * @props word: string (for showing on loss)
 * @emits restart()
 */
// PUBLIC_INTERFACE
defineProps<{
  status: 'playing' | 'won' | 'lost'
  word: string
}>()
const emits = defineEmits<{ (e: 'restart'): void }>()
</script>

<template>
  <div class="controls-row">
    <button
      v-if="status !== 'playing'"
      class="restart-btn"
      @click="emits('restart')"
      type="button"
      autofocus
    >
      Restart Game
    </button>
  </div>
</template>

<style scoped>
.controls-row {
  margin-top: 1.5em;
  display: flex;
  justify-content: center;
  width: 100%;
}
.restart-btn {
  background: var(--color-primary, #4CAF50);
  color: #fff;
  font-size: 1.13rem;
  border: none;
  border-radius: 8px;
  padding: 0.68em 1.35em;
  font-weight: 500;
  cursor: pointer;
  transition: background 0.13s;
  box-shadow: 0 2px 10px rgba(44,138,89,0.08);
}
.restart-btn:hover {
  background: var(--color-secondary, #2196F3);
  color: #fff;
}
</style>
