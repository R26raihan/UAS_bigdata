<script setup lang="ts">
import { ref, computed } from 'vue'
import BaseButton from './BaseButton.vue'
import FinancialTemplate from './templates/FinancialTemplate.vue'
import OperationalTemplate from './templates/OperationalTemplate.vue'
import ManagementTemplate from './templates/ManagementTemplate.vue'
import CustomTemplate from './templates/CustomTemplate.vue'

interface DocumentData {
  id?: string
  type: 'financial' | 'operational' | 'management' | 'custom'
  title: string
  period: string
  date: string
  notes?: string
  content?: any // Data yang di-generate oleh AI
  generatedAt?: string
}

interface Props {
  document: DocumentData
  mode?: 'preview' | 'view' // preview saat create, view saat lihat history
}

const props = withDefaults(defineProps<Props>(), {
  mode: 'view'
})

const emit = defineEmits<{
  close: []
  edit: []
  download: [format: 'pdf' | 'markdown']
}>()

// Select template based on document type
const currentTemplate = computed(() => {
  switch (props.document.type) {
    case 'financial':
      return FinancialTemplate
    case 'operational':
      return OperationalTemplate
    case 'management':
      return ManagementTemplate
    case 'custom':
      return CustomTemplate
    default:
      return CustomTemplate
  }
})

const handleDownload = (format: 'pdf' | 'markdown') => {
  emit('download', format)
}

const handleEdit = () => {
  emit('edit')
}

const handleClose = () => {
  emit('close')
}
</script>

<template>
  <div class="document-viewer">
    <!-- Header Actions -->
    <div class="viewer-header">
      <div class="flex items-center gap-4">
        <BaseButton variant="ghost" size="sm" @click="handleClose">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M19 12H5M12 19l-7-7 7-7"/>
          </svg>
          Kembali
        </BaseButton>
        <div class="flex-1">
          <h2 class="text-xl font-bold text-slate-900 dark:text-slate-100">{{ document.title }}</h2>
          <p class="text-sm text-slate-500 dark:text-slate-400">
            {{ document.period }} • {{ document.date }}
          </p>
        </div>
      </div>
      
      <div class="flex gap-3">
        <BaseButton v-if="mode === 'preview'" variant="secondary" size="sm" @click="handleEdit">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M11 4H4a2 2 0 00-2 2v14a2 2 0 002 2h14a2 2 0 002-2v-7"/>
            <path d="M18.5 2.5a2.121 2.121 0 013 3L12 15l-4 1 1-4 9.5-9.5z"/>
          </svg>
          Edit
        </BaseButton>
        
        <BaseButton variant="secondary" size="sm" @click="handleDownload('pdf')">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4M7 10l5 5 5-5M12 15V3"/>
          </svg>
          PDF
        </BaseButton>
        
        <BaseButton variant="secondary" size="sm" @click="handleDownload('markdown')">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4M7 10l5 5 5-5M12 15V3"/>
          </svg>
          Markdown
        </BaseButton>
      </div>
    </div>

    <!-- Document Content -->
    <div class="viewer-content">
      <div class="document-paper" id="document-content">
        <component :is="currentTemplate" :document="document" />
      </div>
    </div>
  </div>
</template>

<style scoped>
.document-viewer {
  min-height: 100vh;
  background: linear-gradient(to bottom, #f8fafc 0%, #e2e8f0 100%);
  padding: 2rem;
}

.viewer-header {
  max-width: 1200px;
  margin: 0 auto 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.viewer-content {
  max-width: 1200px;
  margin: 0 auto;
}

.document-paper {
  background: white;
  border-radius: 0.5rem;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  padding: 4rem;
  min-height: 800px;
}

/* Print styles */
@media print {
  .viewer-header {
    display: none;
  }
  
  .document-viewer {
    background: white;
    padding: 0;
  }
  
  .document-paper {
    box-shadow: none;
    padding: 2rem;
  }
}

/* Dark mode */
@media (prefers-color-scheme: dark) {
  .document-viewer {
    background: linear-gradient(to bottom, #0f172a 0%, #1e293b 100%);
  }
  
  .document-paper {
    background: #1e293b;
    border: 1px solid #334155;
  }
}

:global(.dark) .document-viewer {
  background: linear-gradient(to bottom, #0f172a 0%, #1e293b 100%);
}

:global(.dark) .document-paper {
  background: #1e293b;
  border: 1px solid #334155;
}
</style>
