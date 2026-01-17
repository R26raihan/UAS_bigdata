<script setup lang="ts">
interface Props {
  currentSection: 'dashboard' | 'create' | 'history'
  theme: 'light' | 'dark'
}

const props = defineProps<Props>()
const emit = defineEmits<{
  navigate: [section: 'dashboard' | 'create' | 'history']
  toggleTheme: []
}>()

const navItems = [
  {
    id: 'dashboard' as const,
    label: 'Dashboard',
    icon: 'M3 3h7v7H3V3zm11 0h7v7h-7V3zM3 14h7v7H3v-7zm11 0h7v7h-7v-7z'
  },
  {
    id: 'create' as const,
    label: 'Buat Dokumen',
    icon: 'M12 5v14M5 12h14'
  },
  {
    id: 'history' as const,
    label: 'Riwayat',
    icon: 'M3 3h7a2 2 0 012 2v14a2 2 0 01-2 2H3M14 3h7a2 2 0 012 2v14a2 2 0 01-2 2h-7'
  }
]
</script>

<template>
  <nav class="fixed top-0 left-0 right-0 h-18 bg-white dark:bg-slate-800 border-b border-slate-200 dark:border-slate-700 z-[1020] backdrop-blur-lg">
    <div class="max-w-[1440px] mx-auto h-full px-8 flex items-center justify-between gap-8">
      <div class="flex items-center gap-4">
        <div class="flex items-center justify-center">
          <svg width="32" height="32" viewBox="0 0 32 32" fill="none">
            <rect width="32" height="32" rx="8" fill="url(#brandGradient)"/>
            <path d="M10 12h12M10 16h12M10 20h8" stroke="white" stroke-width="2" stroke-linecap="round"/>
            <defs>
              <linearGradient id="brandGradient" x1="0" y1="0" x2="32" y2="32">
                <stop offset="0%" stop-color="#667eea"/>
                <stop offset="100%" stop-color="#764ba2"/>
              </linearGradient>
            </defs>
          </svg>
        </div>
        <span class="text-lg font-bold text-slate-900 dark:text-slate-100 whitespace-nowrap">Enterprise Document Writer</span>
      </div>
      
      <div class="flex items-center gap-2 flex-1 justify-center">
        <a 
          v-for="item in navItems"
          :key="item.id"
          href="#"
          :class="[
            'flex items-center gap-2 px-4 py-2.5 text-sm font-semibold rounded-lg transition-all duration-200 no-underline',
            currentSection === item.id 
              ? 'bg-gradient-primary text-white shadow-md' 
              : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-700 hover:text-slate-900 dark:hover:text-slate-100'
          ]"
          @click.prevent="emit('navigate', item.id)"
        >
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="flex-shrink-0">
            <path :d="item.icon"/>
          </svg>
          {{ item.label }}
        </a>
      </div>

      <div class="flex items-center gap-4">
        <button class="btn-icon" @click="emit('toggleTheme')" aria-label="Toggle theme">
          <svg v-if="theme === 'light'" class="theme-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="5"/>
            <path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42"/>
          </svg>
          <svg v-else class="theme-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M21 12.79A9 9 0 1111.21 3 7 7 0 0021 12.79z"/>
          </svg>
        </button>
        <div class="flex items-center gap-2">
          <div class="w-10 h-10 rounded-full bg-gradient-primary flex items-center justify-center text-white font-bold text-sm cursor-pointer transition-all duration-200 hover:scale-105 hover:shadow-md">
            <span>AD</span>
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>

<style scoped>
@media (max-width: 768px) {
  .brand-text {
    display: none;
  }
  
  nav > div {
    padding: 0 1rem;
  }
  
  nav a span {
    display: none;
  }
}
</style>
