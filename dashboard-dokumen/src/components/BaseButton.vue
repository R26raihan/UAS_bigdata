<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  variant?: 'primary' | 'secondary' | 'gradient' | 'glass' | 'outline' | 'ghost' | 'danger' | 'success'
  size?: 'sm' | 'md' | 'lg' | 'xl'
  loading?: boolean
  disabled?: boolean
  icon?: string
  iconPosition?: 'left' | 'right'
  fullWidth?: boolean
  rounded?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'primary',
  size: 'md',
  loading: false,
  disabled: false,
  iconPosition: 'left',
  fullWidth: false,
  rounded: false
})

const emit = defineEmits<{
  click: [event: MouseEvent]
}>()

const buttonClasses = computed(() => {
  const classes = [
    'base-button',
    `base-button--${props.variant}`,
    `base-button--${props.size}`,
  ]
  
  if (props.fullWidth) classes.push('base-button--full')
  if (props.rounded) classes.push('base-button--rounded')
  if (props.loading) classes.push('base-button--loading')
  if (props.disabled) classes.push('base-button--disabled')
  
  return classes.join(' ')
})

const handleClick = (event: MouseEvent) => {
  if (!props.disabled && !props.loading) {
    // Ripple effect
    const button = event.currentTarget as HTMLElement
    const ripple = document.createElement('span')
    const rect = button.getBoundingClientRect()
    const size = Math.max(rect.width, rect.height)
    const x = event.clientX - rect.left - size / 2
    const y = event.clientY - rect.top - size / 2
    
    ripple.style.width = ripple.style.height = `${size}px`
    ripple.style.left = `${x}px`
    ripple.style.top = `${y}px`
    ripple.classList.add('ripple')
    
    button.appendChild(ripple)
    
    setTimeout(() => {
      ripple.remove()
    }, 600)
    
    emit('click', event)
  }
}
</script>

<template>
  <button
    :class="buttonClasses"
    :disabled="disabled || loading"
    @click="handleClick"
  >
    <!-- Loading Spinner -->
    <span v-if="loading" class="base-button__spinner">
      <svg class="animate-spin" width="20" height="20" viewBox="0 0 24 24" fill="none">
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
      </svg>
    </span>
    
    <!-- Icon Left -->
    <span v-if="icon && iconPosition === 'left' && !loading" class="base-button__icon">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path :d="icon"/>
      </svg>
    </span>
    
    <!-- Content -->
    <span class="base-button__content">
      <slot />
    </span>
    
    <!-- Icon Right -->
    <span v-if="icon && iconPosition === 'right' && !loading" class="base-button__icon">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path :d="icon"/>
      </svg>
    </span>
  </button>
</template>

<style scoped>
.base-button {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  font-weight: 600;
  border: none;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  overflow: hidden;
  white-space: nowrap;
  user-select: none;
  outline: none;
}

.base-button:focus-visible {
  box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.3);
}

/* Ripple Effect */
.ripple {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.6);
  transform: scale(0);
  animation: ripple-animation 0.6s ease-out;
  pointer-events: none;
}

@keyframes ripple-animation {
  to {
    transform: scale(4);
    opacity: 0;
  }
}

/* Sizes */
.base-button--sm {
  padding: 0.5rem 1rem;
  font-size: 0.875rem;
  border-radius: 0.5rem;
  line-height: 1.25rem;
}

.base-button--md {
  padding: 0.625rem 1.5rem;
  font-size: 0.9375rem;
  border-radius: 0.625rem;
  line-height: 1.5rem;
}

.base-button--lg {
  padding: 0.75rem 2rem;
  font-size: 1rem;
  border-radius: 0.75rem;
  line-height: 1.75rem;
}

.base-button--xl {
  padding: 1rem 2.5rem;
  font-size: 1.125rem;
  border-radius: 0.875rem;
  line-height: 2rem;
}

/* Variants */
.base-button--primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}

.base-button--primary:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05), 0 0 20px rgba(102, 126, 234, 0.4);
}

.base-button--primary:active:not(:disabled) {
  transform: translateY(0);
}

.base-button--gradient {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
  background-size: 200% 200%;
  color: white;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  animation: gradient-shift 3s ease infinite;
}

@keyframes gradient-shift {
  0%, 100% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
}

.base-button--gradient:hover:not(:disabled) {
  transform: translateY(-2px) scale(1.02);
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04), 0 0 30px rgba(102, 126, 234, 0.5);
}

.base-button--glass {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: #667eea;
  box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.15);
}

.base-button--glass:hover:not(:disabled) {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(102, 126, 234, 0.4);
  transform: translateY(-2px);
  box-shadow: 0 8px 32px 0 rgba(102, 126, 234, 0.3);
}

.base-button--secondary {
  background: white;
  color: #667eea;
  border: 2px solid #e2e8f0;
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
}

.base-button--secondary:hover:not(:disabled) {
  background: #f8fafc;
  border-color: #667eea;
  transform: translateY(-1px);
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.base-button--outline {
  background: transparent;
  color: #667eea;
  border: 2px solid #667eea;
}

.base-button--outline:hover:not(:disabled) {
  background: #667eea;
  color: white;
  transform: translateY(-2px);
  box-shadow: 0 10px 15px -3px rgba(102, 126, 234, 0.3);
}

.base-button--ghost {
  background: transparent;
  color: #64748b;
}

.base-button--ghost:hover:not(:disabled) {
  background: #f1f5f9;
  color: #334155;
}

.base-button--danger {
  background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
  color: white;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.base-button--danger:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 10px 15px -3px rgba(239, 68, 68, 0.4);
}

.base-button--success {
  background: linear-gradient(135deg, #10b981 0%, #059669 100%);
  color: white;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.base-button--success:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 10px 15px -3px rgba(16, 185, 129, 0.4);
}

/* States */
.base-button--full {
  width: 100%;
}

.base-button--rounded {
  border-radius: 9999px;
}

.base-button--loading {
  pointer-events: none;
}

.base-button--disabled,
.base-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  transform: none !important;
}

.base-button__spinner,
.base-button__icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.base-button__content {
  display: inline-flex;
  align-items: center;
}

/* Dark mode support */
@media (prefers-color-scheme: dark) {
  .base-button--secondary {
    background: #1e293b;
    color: #a78bfa;
    border-color: #334155;
  }
  
  .base-button--secondary:hover:not(:disabled) {
    background: #334155;
    border-color: #a78bfa;
  }
  
  .base-button--ghost {
    color: #94a3b8;
  }
  
  .base-button--ghost:hover:not(:disabled) {
    background: #1e293b;
    color: #e2e8f0;
  }
}

/* Dark class support */
:global(.dark) .base-button--secondary {
  background: #1e293b;
  color: #a78bfa;
  border-color: #334155;
}

:global(.dark) .base-button--secondary:hover:not(:disabled) {
  background: #334155;
  border-color: #a78bfa;
}

:global(.dark) .base-button--ghost {
  color: #94a3b8;
}

:global(.dark) .base-button--ghost:hover:not(:disabled) {
  background: #1e293b;
  color: #e2e8f0;
}
</style>
