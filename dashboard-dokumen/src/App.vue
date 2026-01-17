<script setup lang="ts">
import { ref, onMounted } from 'vue'
import Navbar from './components/Navbar.vue'
import Dashboard from './components/Dashboard.vue'
import CreateDocument from './components/CreateDocument.vue'
import DocumentHistory from './components/DocumentHistory.vue'

// State management
const currentSection = ref<'dashboard' | 'create' | 'history'>('dashboard')
const theme = ref<'light' | 'dark'>('light')

// Section navigation
const showSection = (section: 'dashboard' | 'create' | 'history') => {
  currentSection.value = section
}

// Theme toggle
const toggleTheme = () => {
  theme.value = theme.value === 'light' ? 'dark' : 'light'
  if (theme.value === 'dark') {
    document.documentElement.classList.add('dark')
  } else {
    document.documentElement.classList.remove('dark')
  }
  localStorage.setItem('theme', theme.value)
}

// Initialize theme from localStorage
onMounted(() => {
  const savedTheme = localStorage.getItem('theme') as 'light' | 'dark' | null
  if (savedTheme) {
    theme.value = savedTheme
    if (savedTheme === 'dark') {
      document.documentElement.classList.add('dark')
    }
  }
})
</script>

<template>
  <div class="app-container">
    <Navbar 
      :current-section="currentSection"
      :theme="theme"
      @navigate="showSection"
      @toggle-theme="toggleTheme"
    />
    
    <main class="main-content">
      <Dashboard 
        v-if="currentSection === 'dashboard'"
        @navigate="showSection"
      />
      
      <CreateDocument 
        v-if="currentSection === 'create'"
        @navigate="showSection"
      />
      
      <DocumentHistory 
        v-if="currentSection === 'history'"
        @navigate="showSection"
      />
    </main>
  </div>
</template>

<style scoped>
.app-container {
  @apply min-h-screen flex flex-col;
}

.main-content {
  @apply flex-1 pt-20 animate-fade-in;
}
</style>
