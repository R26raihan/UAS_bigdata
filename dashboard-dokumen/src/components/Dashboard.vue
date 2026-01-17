<script setup lang="ts">
import { ref } from 'vue'
import BaseButton from './BaseButton.vue'

const emit = defineEmits<{
  navigate: [section: 'dashboard' | 'create' | 'history']
}>()

interface StatCard {
  icon: string
  label: string
  value: string | number
  change: string
  positive: boolean
  gradient: string
}

interface DocType {
  id: string
  title: string
  description: string
  icon: string
  gradient: string
  badge?: string
}

const stats = ref<StatCard[]>([
  {
    icon: 'M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z M14 2v6h6 M16 13H8 M16 17H8 M10 9H8',
    label: 'Total Dokumen',
    value: 0,
    change: '+12% bulan ini',
    positive: true,
    gradient: 'purple'
  },
  {
    icon: 'M22 12h-4l-3 9L9 3l-3 9H2',
    label: 'Dokumen Bulan Ini',
    value: 0,
    change: '+8% dari target',
    positive: true,
    gradient: 'blue'
  },
  {
    icon: 'M12 2v20 M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H6',
    label: 'Token Terhemat',
    value: '87%',
    change: 'Efisiensi tinggi',
    positive: true,
    gradient: 'green'
  },
  {
    icon: 'M12 6v6l4 2',
    label: 'Waktu Rata-rata',
    value: '2.3s',
    change: '-15% lebih cepat',
    positive: true,
    gradient: 'orange'
  }
])

const documentTypes = ref<DocType[]>([
  {
    id: 'financial',
    title: 'Laporan Keuangan',
    description: 'Laporan laba rugi, neraca, dan cash flow',
    icon: '💰',
    gradient: 'financial',
    badge: 'Populer'
  },
  {
    id: 'operational',
    title: 'Laporan Operasional',
    description: 'Kinerja operasional dan produktivitas',
    icon: '⚙️',
    gradient: 'operational'
  },
  {
    id: 'management',
    title: 'Laporan Manajemen',
    description: 'Executive summary dan KPI dashboard',
    icon: '📊',
    gradient: 'management'
  },
  {
    id: 'custom',
    title: 'Dokumen Custom',
    description: 'Buat template dokumen sendiri',
    icon: '🔧',
    gradient: 'custom',
    badge: 'Baru'
  }
])

const selectDocType = (type: string) => {
  console.log('Selected document type:', type)
  emit('navigate', 'create')
}
</script>

<template>
  <section class="max-w-screen-xl mx-auto px-8 py-12">
    <div class="flex items-center justify-between mb-12 gap-6 flex-wrap">
      <div>
        <h1 class="text-4xl font-extrabold text-slate-900 dark:text-slate-100 mb-2">Dashboard</h1>
        <p class="text-lg text-slate-600 dark:text-slate-400 m-0">Kelola dokumen perusahaan dengan AI Agentic</p>
      </div>
      <BaseButton 
        variant="gradient" 
        size="lg"
        :icon="'M12 5v14M5 12h14'"
        @click="emit('navigate', 'create')"
      >
        Buat Dokumen Baru
      </BaseButton>
    </div>

    <!-- Stats Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
      <div 
        v-for="(stat, index) in stats" 
        :key="index"
        class="bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-xl p-6 flex gap-4 transition-all duration-200 hover:-translate-y-1 hover:shadow-lg hover:border-primary animate-fade-in"
        :style="{ animationDelay: `${index * 0.1}s` }"
      >
        <div 
          :class="[
            'w-14 h-14 rounded-lg flex items-center justify-center flex-shrink-0 text-white',
            stat.gradient === 'purple' ? 'bg-gradient-purple' : '',
            stat.gradient === 'blue' ? 'bg-gradient-blue' : '',
            stat.gradient === 'green' ? 'bg-gradient-green' : '',
            stat.gradient === 'orange' ? 'bg-gradient-orange' : ''
          ]"
        >
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path :d="stat.icon"/>
          </svg>
        </div>
        <div class="flex-1">
          <div class="text-sm text-slate-600 dark:text-slate-400 mb-1">{{ stat.label }}</div>
          <div class="text-3xl font-extrabold text-slate-900 dark:text-slate-100 mb-1">{{ stat.value }}</div>
          <div :class="['text-xs', stat.positive ? 'text-green-600 dark:text-green-400' : 'text-slate-500 dark:text-slate-400']">
            {{ stat.change }}
          </div>
        </div>
      </div>
    </div>

    <!-- Document Types -->
    <div class="mb-12">
      <h2 class="text-2xl font-bold text-slate-900 dark:text-slate-100 mb-6">Jenis Dokumen Tersedia</h2>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div 
          v-for="docType in documentTypes"
          :key="docType.id"
          class="relative bg-white dark:bg-slate-800 border-2 border-slate-200 dark:border-slate-700 rounded-xl p-8 cursor-pointer transition-all duration-200 overflow-hidden hover:-translate-y-2 hover:border-primary hover:shadow-xl before:absolute before:top-0 before:left-0 before:right-0 before:h-1 before:bg-gradient-primary before:scale-x-0 before:transition-transform before:duration-200 hover:before:scale-x-100"
          @click="selectDocType(docType.id)"
        >
          <div 
            :class="[
              'w-16 h-16 rounded-lg flex items-center justify-center mb-4 text-3xl',
              docType.gradient === 'financial' ? 'bg-gradient-to-br from-purple-100 to-purple-50 dark:from-purple-900/20 dark:to-purple-800/20' : '',
              docType.gradient === 'operational' ? 'bg-gradient-to-br from-blue-100 to-blue-50 dark:from-blue-900/20 dark:to-blue-800/20' : '',
              docType.gradient === 'management' ? 'bg-gradient-to-br from-green-100 to-green-50 dark:from-green-900/20 dark:to-green-800/20' : '',
              docType.gradient === 'custom' ? 'bg-gradient-to-br from-amber-100 to-amber-50 dark:from-amber-900/20 dark:to-amber-800/20' : ''
            ]"
          >
            <span>{{ docType.icon }}</span>
          </div>
          <h3 class="text-xl font-bold text-slate-900 dark:text-slate-100 mb-2">{{ docType.title }}</h3>
          <p class="text-sm text-slate-600 dark:text-slate-400 m-0">{{ docType.description }}</p>
          <div 
            v-if="docType.badge" 
            :class="[
              'absolute top-4 right-4 px-3 py-1 text-xs font-bold rounded-full text-white',
              docType.badge === 'Baru' ? 'bg-gradient-success' : 'bg-gradient-primary'
            ]"
          >
            {{ docType.badge }}
          </div>
        </div>
      </div>
    </div>

    <!-- Recent Documents -->
    <div class="mb-12">
      <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-bold text-slate-900 dark:text-slate-100">Dokumen Terbaru</h2>
        <a href="#" class="text-primary font-semibold text-sm transition-all duration-150 hover:text-primary-dark hover:translate-x-1" @click.prevent="emit('navigate', 'history')">
          Lihat Semua →
        </a>
      </div>
      <div class="bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-xl p-12">
        <div class="flex flex-col items-center justify-center py-12 text-slate-400 dark:text-slate-500 text-center">
          <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" class="mb-6 opacity-50">
            <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/>
            <path d="M14 2v6h6M16 13H8M16 17H8M10 9H8"/>
          </svg>
          <p class="text-base m-0">Belum ada dokumen. Mulai buat dokumen pertama Anda!</p>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
@media (max-width: 768px) {
  section {
    @apply px-4 py-8;
  }
}
</style>
