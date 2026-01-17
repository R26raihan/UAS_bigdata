<script setup lang="ts">
import { ref } from 'vue'
import BaseButton from './BaseButton.vue'

const emit = defineEmits<{
  navigate: [section: 'dashboard' | 'create' | 'history']
}>()

interface Document {
  id: string
  title: string
  type: string
  period: string
  createdAt: string
  status: 'completed' | 'draft' | 'processing'
}

const searchQuery = ref('')
const filterType = ref('all')

const documents = ref<Document[]>([
  // Sample data - will be empty initially
])

const getStatusBadge = (status: string) => {
  const badges = {
    completed: { label: 'Selesai', class: 'badge-success' },
    draft: { label: 'Draft', class: 'badge-warning' },
    processing: { label: 'Proses', class: 'badge-primary' }
  }
  return badges[status as keyof typeof badges] || badges.completed
}

const getTypeLabel = (type: string) => {
  const types: Record<string, string> = {
    financial: 'Keuangan',
    operational: 'Operasional',
    management: 'Manajemen',
    custom: 'Custom'
  }
  return types[type] || type
}

const downloadDocument = (id: string, format: 'pdf' | 'markdown') => {
  console.log(`Downloading document ${id} as ${format}`)
  // Implementation will be added later
}

const viewDocument = (id: string) => {
  console.log(`Viewing document ${id}`)
  // Implementation will be added later
}

const deleteDocument = (id: string) => {
  if (confirm('Apakah Anda yakin ingin menghapus dokumen ini?')) {
    documents.value = documents.value.filter(doc => doc.id !== id)
  }
}
</script>

<template>
  <section class="max-w-screen-xl mx-auto px-8 py-12">
    <div class="flex items-center justify-between mb-12 gap-6 flex-wrap">
      <div>
        <h1 class="text-4xl font-extrabold text-slate-900 dark:text-slate-100 mb-2">Riwayat Dokumen</h1>
        <p class="text-lg text-slate-600 dark:text-slate-400 m-0">Kelola dan unduh dokumen yang telah dibuat</p>
      </div>
      <div class="flex gap-4 items-center flex-wrap">
        <div class="relative flex items-center">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="absolute left-4 text-slate-400 dark:text-slate-500 pointer-events-none">
            <circle cx="11" cy="11" r="8"/>
            <path d="M21 21l-4.35-4.35"/>
          </svg>
          <input 
            type="text" 
            placeholder="Cari dokumen..." 
            v-model="searchQuery"
            class="pl-11 pr-4 py-2.5 border border-slate-200 dark:border-slate-700 rounded-lg bg-white dark:bg-slate-800 text-slate-900 dark:text-slate-100 text-sm min-w-[250px] transition-all duration-200 focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10"
          >
        </div>
        <select 
          v-model="filterType"
          class="px-4 py-2.5 border border-slate-200 dark:border-slate-700 rounded-lg bg-white dark:bg-slate-800 text-slate-900 dark:text-slate-100 text-sm cursor-pointer transition-all duration-200 focus:outline-none focus:border-primary"
        >
          <option value="all">Semua Jenis</option>
          <option value="financial">Keuangan</option>
          <option value="operational">Operasional</option>
          <option value="management">Manajemen</option>
          <option value="custom">Custom</option>
        </select>
      </div>
    </div>

    <div class="bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-xl overflow-hidden shadow-sm">
      <div v-if="documents.length === 0" class="p-12">
        <div class="flex flex-col items-center justify-center py-12 text-slate-400 dark:text-slate-500 text-center">
          <svg width="96" height="96" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" class="mb-8 opacity-50">
            <path d="M9 12h6M9 16h6M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/>
            <path d="M14 2v6h6"/>
          </svg>
          <h3 class="text-2xl text-slate-900 dark:text-slate-100 mb-2">Belum ada riwayat dokumen</h3>
          <p class="text-base text-slate-600 dark:text-slate-400 mb-8">Dokumen yang Anda buat akan muncul di sini</p>
          <BaseButton 
            variant="gradient" 
            size="lg"
            :icon="'M12 5v14M5 12h14'"
            @click="emit('navigate', 'create')"
          >
            Buat Dokumen Pertama
          </BaseButton>
        </div>
      </div>

      <div v-else class="overflow-x-auto">
        <table class="w-full border-collapse">
          <thead class="bg-slate-100 dark:bg-slate-700 border-b-2 border-slate-200 dark:border-slate-600">
            <tr>
              <th class="px-6 py-4 text-left text-sm font-bold text-slate-600 dark:text-slate-300 uppercase tracking-wider">Judul Dokumen</th>
              <th class="px-6 py-4 text-left text-sm font-bold text-slate-600 dark:text-slate-300 uppercase tracking-wider">Jenis</th>
              <th class="px-6 py-4 text-left text-sm font-bold text-slate-600 dark:text-slate-300 uppercase tracking-wider">Periode</th>
              <th class="px-6 py-4 text-left text-sm font-bold text-slate-600 dark:text-slate-300 uppercase tracking-wider">Tanggal Dibuat</th>
              <th class="px-6 py-4 text-left text-sm font-bold text-slate-600 dark:text-slate-300 uppercase tracking-wider">Status</th>
              <th class="px-6 py-4 text-left text-sm font-bold text-slate-600 dark:text-slate-300 uppercase tracking-wider">Aksi</th>
            </tr>
          </thead>
          <tbody>
            <tr 
              v-for="doc in documents" 
              :key="doc.id" 
              class="transition-all duration-200 hover:bg-slate-100 dark:hover:bg-slate-700"
            >
              <td class="px-6 py-5 text-sm text-slate-900 dark:text-slate-100 border-b border-slate-200 dark:border-slate-700 font-semibold">
                {{ doc.title }}
              </td>
              <td class="px-6 py-5 text-sm text-slate-900 dark:text-slate-100 border-b border-slate-200 dark:border-slate-700">
                <span class="inline-block px-3 py-1 text-xs font-semibold rounded-full bg-slate-100 dark:bg-slate-700 text-slate-600 dark:text-slate-400">
                  {{ getTypeLabel(doc.type) }}
                </span>
              </td>
              <td class="px-6 py-5 text-sm text-slate-900 dark:text-slate-100 border-b border-slate-200 dark:border-slate-700">{{ doc.period }}</td>
              <td class="px-6 py-5 text-sm text-slate-900 dark:text-slate-100 border-b border-slate-200 dark:border-slate-700">{{ doc.createdAt }}</td>
              <td class="px-6 py-5 text-sm text-slate-900 dark:text-slate-100 border-b border-slate-200 dark:border-slate-700">
                <span :class="['badge', getStatusBadge(doc.status).class]">
                  {{ getStatusBadge(doc.status).label }}
                </span>
              </td>
              <td class="px-6 py-5 text-sm text-slate-900 dark:text-slate-100 border-b border-slate-200 dark:border-slate-700">
                <div class="flex gap-2">
                  <button class="btn-icon-small" @click="viewDocument(doc.id)" title="Lihat">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                      <circle cx="12" cy="12" r="3"/>
                    </svg>
                  </button>
                  <button class="btn-icon-small" @click="downloadDocument(doc.id, 'pdf')" title="Download PDF">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4M7 10l5 5 5-5M12 15V3"/>
                    </svg>
                  </button>
                  <button class="btn-icon-small danger" @click="deleteDocument(doc.id)" title="Hapus">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M3 6h18M19 6v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6m3 0V4a2 2 0 012-2h4a2 2 0 012 2v2"/>
                    </svg>
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </section>
</template>

<style scoped>
.btn-icon-small.danger:hover {
  @apply bg-red-500 border-red-500;
}

@media (max-width: 768px) {
  section {
    @apply px-4 py-8;
  }
  
  .flex-wrap > div {
    @apply w-full;
  }
  
  input[type="text"] {
    @apply w-full min-w-0;
  }
  
  select {
    @apply w-full;
  }
  
  table {
    @apply text-xs;
  }
  
  th, td {
    @apply px-3 py-2;
  }
}
</style>
