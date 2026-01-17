<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue'
import BaseButton from './BaseButton.vue'
import FinancialTemplate from './templates/FinancialTemplate.vue'
import OperationalTemplate from './templates/OperationalTemplate.vue'
import ManagementTemplate from './templates/ManagementTemplate.vue'
import CustomTemplate from './templates/CustomTemplate.vue'
import { 
  fetchCompanies, 
  type Company, 
  API_BASE_URL, 
  createDocument,
  fetchDocumentById,
  generateFinancialNarrative,
  generateOperationalNarrative,
  generateManagementNarrative,
  fetchQuarterlyCoverageDetail,
  type QuarterlyCoverageDetail
} from '@/controller'

// AI and Loading state
const loadingAI = ref(false)
const aiContent = ref<any>(null)
const createdDocumentId = ref<number | null>(null)


const emit = defineEmits<{
  navigate: [section: 'dashboard' | 'create' | 'history']
}>()

const currentStep = ref(1)
const selectedDocType = ref('')
const currentPage = ref(1)
const totalPages = ref(5) 

// Companies from API
const companies = ref<Company[]>([])
const selectedCompanyId = ref<number | null>(null)
const loadingCompanies = ref(false)
const companyCoverage = ref<QuarterlyCoverageDetail | null>(null)
const loadingCoverage = ref(false)
const dataPreview = ref<any>(null)
const loadingPreview = ref(false)

const formData = ref({
  title: '',
  period: '',
  date: '',
  notes: '',
  companyName: '',
  companyAddress: '',
  companyPhone: '',
  companyEmail: '',
  companyLogo: null as string | null
})

const handleLogoUpload = (event: Event) => {
  const file = (event.target as HTMLInputElement).files?.[0]
  if (file) {
    const reader = new FileReader()
    reader.onload = (e) => {
      formData.value.companyLogo = e.target?.result as string
    }
    reader.readAsDataURL(file)
  }
}

// Load companies using API controller
const loadCompanies = async () => {
  loadingCompanies.value = true
  try {
    const response = await fetchCompanies()
    companies.value = response.data
    console.log('✅ Companies loaded:', companies.value.length)
  } catch (error) {
    console.error('❌ Error loading companies:', error)
    alert(`Gagal memuat data perusahaan. Pastikan backend berjalan di ${API_BASE_URL}`)
  } finally {
    loadingCompanies.value = false
  }
}

// Auto-populate company data when selected
const onSelectCompany = (companyId: number) => {
  const company = companies.value.find(c => c.id === companyId)
  if (company) {
    formData.value.companyName = company.name
    formData.value.companyAddress = company.address || ''
    formData.value.companyPhone = company.phone || ''
    formData.value.companyEmail = company.email || ''
    formData.value.companyLogo = company.logo_url || null
    
    // Fetch coverage for the selected company
    loadCompanyCoverage(companyId)
  }
}

const loadCompanyCoverage = async (companyId: number) => {
  loadingCoverage.value = true
  try {
    const response = await fetchQuarterlyCoverageDetail(companyId)
    companyCoverage.value = response
    console.log('✅ Coverage loaded for company:', companyId)
  } catch (error) {
    console.error('❌ Error loading coverage:', error)
  } finally {
    loadingCoverage.value = false
  }
}

// Transform coverage data into selectable options
const periodOptions = computed(() => {
  if (!companyCoverage.value || !selectedDocType.value) return []
  
  const options: Array<{ value: string, label: string, hasData: boolean, availableTypes: string[] }> = []
  const { coverage } = companyCoverage.value
  
  const years = Object.keys(coverage).sort((a, b) => b.localeCompare(a))
  
  for (const year of years) {
    const quarters = coverage[year]
    for (const [qKey, qData] of Object.entries(quarters)) {
      const types = (qData as any).documents.map((d: any) => d.type)
      options.push({
        value: `${qKey} ${year}`,
        label: `${qKey} ${year}`,
        hasData: types.includes(selectedDocType.value),
        availableTypes: types
      })
    }
  }
  
  return options
})

// Load companies on component mount
onMounted(() => {
  loadCompanies()
})

const docTypes = [
  { value: 'financial', label: 'Laporan Keuangan', icon: '💰', desc: 'Laba rugi, neraca, cash flow' },
  { value: 'operational', label: 'Laporan Operasional', icon: '⚙️', desc: 'Kinerja dan produktivitas' },
  { value: 'management', label: 'Laporan Manajemen', icon: '📊', desc: 'Executive summary & KPI' },
  { value: 'custom', label: 'Custom', icon: '🔧', desc: 'Template sendiri' }
]

const steps = [
  { number: 1, label: 'Pilih Jenis' },
  { number: 2, label: 'Input Data' },
  { number: 3, label: 'Preview' },
  { number: 4, label: 'Selesai' }
]

const nextStep = (step: number) => {
  if (step === 2 && !selectedDocType.value) {
    alert('Pilih jenis dokumen terlebih dahulu')
    return
  }
  currentStep.value = step
}

const prevStep = (step: number) => {
  currentStep.value = step
}



// Watch for period/docType changes to fetch preview
const onPeriodChange = async () => {
  const selected = periodOptions.value.find(o => o.value === formData.value.period)
  if (selected?.hasData && selectedCompanyId.value && selectedDocType.value) {
    loadingPreview.value = true
    dataPreview.value = null
    try {
      const [qKey, year] = selected.value.split(' ')
      const doc = companyCoverage.value?.coverage[year][qKey]?.documents.find(d => d.type === selectedDocType.value)
      
      if (doc) {
        const fullDoc = await fetchDocumentById(doc.id)
        if (selectedDocType.value === 'financial') {
          dataPreview.value = fullDoc.financial_data?.summary
        } else if (selectedDocType.value === 'operational') {
          dataPreview.value = fullDoc.operational_data?.kpi
        } else if (selectedDocType.value === 'management') {
          dataPreview.value = {
            goals_count: fullDoc.management_data?.strategicGoals?.length || 0,
            achievements_count: fullDoc.management_data?.achievements?.length || 0,
            first_goal: fullDoc.management_data?.strategicGoals?.[0]?.goal || 'N/A',
            executive_summary: fullDoc.management_data?.executiveSummary || ''
          }
        }
      }
    } catch (error) {
      console.error('❌ Error fetching preview data:', error)
    } finally {
      loadingPreview.value = false
    }
  } else {
    dataPreview.value = null
  }
}

// Add watchers
watch([() => formData.value.period, () => selectedDocType.value], () => {
  onPeriodChange()
})

const generatePreview = async () => {
  if (!formData.value.title || !formData.value.period || !formData.value.date) {
    alert('Lengkapi semua field yang diperlukan')
    return
  }

  if (!selectedCompanyId.value) {
    alert('Pilih perusahaan terlebih dahulu')
    return
  }

  loadingAI.value = true
  try {
    // 1. Create document in database (or use existing if we already generated Once)
    // For simplicity, we create a new one each time they regenerate preview
    const newDoc = await createDocument({
      company_id: selectedCompanyId.value,
      type: selectedDocType.value as any,
      title: formData.value.title,
      period: formData.value.period,
      date: formData.value.date,
      notes: formData.value.notes
    })
    
    createdDocumentId.value = newDoc.id
    console.log('✅ Document created for preview:', newDoc.id)
    
    // 2. Trigger AI generation based on type
    let result = null
    if (selectedDocType.value === 'financial') {
      result = await generateFinancialNarrative(newDoc.id)
    } else if (selectedDocType.value === 'operational') {
      result = await generateOperationalNarrative(newDoc.id)
    } else if (selectedDocType.value === 'management') {
      result = await generateManagementNarrative(newDoc.id)
    }
    
    if (result) {
      console.log('✅ AI Narrative generated successfully')
    }

    // 3. Fetch full document details (including structured data seeded by backend)
    const fullDocRes = await fetchDocumentById(newDoc.id)
    
    // Merge everything into a flat structure for the template preview
    if (fullDocRes) {
      aiContent.value = {
        ...fullDocRes,
        companyName: fullDocRes.companyName || formData.value.companyName,
        companyAddress: formData.value.companyAddress,
        companyPhone: formData.value.companyPhone,
        companyEmail: formData.value.companyEmail,
        companyLogo: formData.value.companyLogo,
        content: result // AI narrative
      }
    }
    
    currentStep.value = 3
  } catch (error) {
    console.error('❌ Preview generation failed:', error)
    alert('Gagal membuat preview. Pastikan backend berjalan dan data tersedia.')
  } finally {
    loadingAI.value = false
  }
}

const createAnother = () => {
  currentStep.value = 1
  selectedDocType.value = ''
  aiContent.value = null
  createdDocumentId.value = null
  formData.value = {
    title: '',
    period: '',
    date: '',
    notes: '',
    companyName: 'PT. NAMA PERUSAHAAN',
    companyAddress: 'Jl. Contoh No. 123, Jakarta 12345',
    companyPhone: '+62 21 1234 5678',
    companyEmail: 'info@perusahaan.co.id',
    companyLogo: null
  }
}

// Computed property untuk memilih template yang sesuai
const currentTemplate = computed(() => {
  switch (selectedDocType.value) {
    case 'financial':
      return FinancialTemplate
    case 'operational':
      return OperationalTemplate
    case 'management':
      return ManagementTemplate
    case 'custom':
      return CustomTemplate
    default:
      return null
  }
})

// Document data untuk preview
const previewDocument = computed(() => {
  const company = companies.value.find(c => c.id === selectedCompanyId.value)
  return {
    ...formData.value,
    ...aiContent.value, // This now includes fullDoc data and AI content
    companyName: company?.name || formData.value.companyName,
    companyAddress: company?.address || formData.value.companyAddress,
    companyPhone: company?.phone || formData.value.companyPhone,
    companyEmail: company?.email || formData.value.companyEmail,
    companyLogo: (company?.logo_url ? `${API_BASE_URL.replace('/api/v1', '')}${company.logo_url}` : formData.value.companyLogo) || undefined
  }
})

const finalizeDocument = async () => {
  // Document is already created during Preview step
  // Just move to the final success step
  currentStep.value = 4
  console.log('✅ Document finalized (Step 4)')
}

const downloadPDF = () => {
  window.print()
}

const downloadMarkdown = () => {
  const content = `
# ${formData.value.title}
Periode: ${formData.value.period}
Tanggal: ${formData.value.date}

${formData.value.notes}
  `
  const blob = new Blob([content], { type: 'text/markdown' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `${formData.value.title || 'dokumen'}.md`
  document.body.appendChild(a)
  a.click()
  document.body.removeChild(a)
  URL.revokeObjectURL(url)
}
</script>

<template>
  <section class="max-w-screen-xl mx-auto px-8 py-12">
    <div class="mb-12">
      <h1 class="text-4xl font-extrabold text-slate-900 dark:text-slate-100 mb-2">Buat Dokumen Baru</h1>
      <p class="text-lg text-slate-600 dark:text-slate-400 m-0">AI akan membantu menyusun dokumen berdasarkan data yang Anda masukkan</p>
    </div>

    <div class="bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-2xl p-12 shadow-md">
      <!-- Step Indicator -->
      <div class="flex items-center justify-center mb-12 py-8">
        <template v-for="(step, index) in steps" :key="step.number">
          <div class="flex flex-col items-center gap-2">
            <div 
              :class="[
                'w-12 h-12 rounded-full flex items-center justify-center font-bold text-lg transition-all duration-200',
                currentStep >= step.number 
                  ? 'bg-gradient-primary text-white shadow-md' 
                  : 'bg-slate-100 dark:bg-slate-700 text-slate-400 dark:text-slate-500'
              ]"
            >
              {{ step.number }}
            </div>
            <div 
              :class="[
                'text-sm font-semibold',
                currentStep >= step.number 
                  ? 'text-slate-900 dark:text-slate-100' 
                  : 'text-slate-400 dark:text-slate-500'
              ]"
            >
              {{ step.label }}
            </div>
          </div>
          <div 
            v-if="index < steps.length - 1" 
            :class="[
              'w-20 h-0.5 mx-4 transition-all duration-200',
              currentStep > step.number ? 'bg-primary' : 'bg-slate-200 dark:bg-slate-700'
            ]"
          ></div>
        </template>
      </div>

      <!-- Form Container -->
      <div>
        <!-- Step 1: Document Type Selection -->
        <div v-if="currentStep === 1" class="animate-fade-in">
          <h2 class="text-2xl font-bold text-slate-900 dark:text-slate-100 mb-8 text-center">Pilih Jenis Dokumen</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
            <label 
              v-for="docType in docTypes"
              :key="docType.value"
              :class="[
                'relative cursor-pointer',
                selectedDocType === docType.value ? 'selected' : ''
              ]"
            >
              <input 
                type="radio" 
                name="docType" 
                :value="docType.value"
                v-model="selectedDocType"
                class="absolute opacity-0 pointer-events-none"
              >
              <div 
                :class="[
                  'bg-white dark:bg-slate-800 border-2 rounded-xl p-8 text-center transition-all duration-200',
                  selectedDocType === docType.value 
                    ? 'border-primary bg-gradient-to-br from-purple-50 to-blue-50 dark:from-purple-900/10 dark:to-blue-900/10 shadow-md' 
                    : 'border-slate-200 dark:border-slate-700 hover:border-primary hover:-translate-y-1 hover:shadow-lg'
                ]"
              >
                <div class="text-5xl mb-4">{{ docType.icon }}</div>
                <h3 class="text-lg font-bold text-slate-900 dark:text-slate-100 mb-2">{{ docType.label }}</h3>
                <p class="text-sm text-slate-600 dark:text-slate-400 m-0">{{ docType.desc }}</p>
              </div>
            </label>
          </div>
          <div class="flex gap-4 justify-center">
            <BaseButton variant="secondary" @click="emit('navigate', 'dashboard')">Batal</BaseButton>
            <BaseButton variant="primary" @click="nextStep(2)">Lanjut</BaseButton>
          </div>
        </div>

        <!-- Step 2: Input Data -->
        <div v-if="currentStep === 2" class="animate-fade-in">
          <div class="mb-10 text-center">
            <h2 class="text-3xl font-bold text-slate-900 dark:text-slate-100 mb-2">Input Data Dokumen</h2>
            <p class="text-slate-500 dark:text-slate-400">Silakan pilih perusahaan dan lengkapi detail laporan.</p>
          </div>

          <div class="bg-white dark:bg-slate-800 rounded-2xl shadow-xl shadow-slate-200/50 dark:shadow-none border border-slate-100 dark:border-slate-700 p-8 md:p-12 mb-10">
            <!-- Company Details Section (PRIORITIZED) -->
            <div class="mb-12">
              <h3 class="text-xl font-bold text-slate-900 dark:text-slate-100 mb-6 flex items-center gap-2">
                <span class="flex items-center justify-center w-8 h-8 rounded-full bg-primary text-white text-sm">1</span>
                Identitas Perusahaan (Kop Surat)
              </h3>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
              <div>
                <label class="form-label">Pilih Perusahaan</label>
                <select class="form-input" v-model="selectedCompanyId" @change="onSelectCompany(selectedCompanyId!)">
                  <option :value="null">Pilih perusahaan</option>
                  <option v-for="company in companies" :key="company.id" :value="company.id">
                    {{ company.name }}
                  </option>
                </select>
              </div>

              <div>
                <label class="form-label">Upload Logo</label>
                <input type="file" class="form-input" @change="handleLogoUpload" accept="image/*" />
              </div>

              <div>
                <label class="form-label">Nama Perusahaan</label>
                <input type="text" class="form-input" v-model="formData.companyName" placeholder="Akan terisi otomatis" readonly />
              </div>

              <div class="md:col-span-2">
                <label class="form-label">Alamat Lengkap</label>
                <input type="text" class="form-input" v-model="formData.companyAddress" placeholder="Jl. Sudirman No. 1..." />
              </div>

              <div>
                <label class="form-label">Nomor Telepon</label>
                <input type="text" class="form-input" v-model="formData.companyPhone" placeholder="+62 21 ..." />
              </div>

              <div>
                <label class="form-label">Email Perusahaan</label>
                <input type="email" class="form-input" v-model="formData.companyEmail" placeholder="info@perusahaan.com" />
              </div>
            </div>
          </div>

          <div class="border-t border-slate-100 dark:border-slate-700 my-10"></div>

          <!-- Document Details Section -->
          <div class="mb-12">
            <h3 class="text-xl font-bold text-slate-900 dark:text-slate-100 mb-6 flex items-center gap-2">
              <span class="flex items-center justify-center w-8 h-8 rounded-full bg-primary text-white text-sm">2</span>
              Detail Laporan
            </h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-8">
              <div class="md:col-span-2">
                <label class="form-label">Judul Dokumen</label>
                <input 
                  type="text" 
                  class="form-input" 
                  v-model="formData.title"
                  placeholder="Contoh: Laporan Keuangan Q4 2024" 
                />
              </div>
              
              <div>
                <label class="form-label">Periode Laporan (Historis)</label>
                <div class="relative">
                  <select class="form-input" v-model="formData.period" :disabled="loadingCoverage">
                    <option value="">{{ loadingCoverage ? 'Memuat data...' : 'Pilih periode berbasis data API' }}</option>
                    <optgroup v-if="periodOptions.some(o => o.hasData)" label="Tersedia di Database">
                      <option 
                        v-for="opt in periodOptions.filter(o => o.hasData)" 
                        :key="opt.value" 
                        :value="opt.value"
                      >
                        ✅ {{ opt.label }} (Data Lengkap)
                      </option>
                    </optgroup>
                    <optgroup label="Data Kosong/Belum Ada">
                      <option 
                        v-for="opt in periodOptions.filter(o => !o.hasData)" 
                        :key="opt.value" 
                        :value="opt.value"
                      >
                        ❌ {{ opt.label }} (Input Manual)
                      </option>
                    </optgroup>
                  </select>
                  <div v-if="formData.period && periodOptions.find(o => o.value === formData.period)?.hasData" class="mt-2 text-xs text-green-600 font-medium flex items-center gap-1">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3">
                      <path d="M20 6L9 17l-5-5"/>
                    </svg>
                    Sistem akan otomatis menarik data historis untuk {{ formData.period }}
                  </div>
                </div>
              </div>

              <div>
                <label class="form-label">Tanggal</label>
                <input type="date" class="form-input" v-model="formData.date" />
              </div>

              <div class="md:col-span-2">
                <label class="form-label">Catatan Tambahan (Opsional)</label>
                <textarea 
                  class="form-textarea" 
                  v-model="formData.notes"
                  rows="4" 
                  placeholder="Informasi tambahan yang perlu dimasukkan dalam dokumen..."
                ></textarea>
              </div>
            </div>

            <!-- Data Preview Section -->
            <div v-if="dataPreview || loadingPreview" class="mb-12 p-6 bg-slate-50 dark:bg-slate-700/30 border border-slate-200 dark:border-slate-700 rounded-xl animate-fade-in">
              <h3 class="text-base font-bold text-slate-900 dark:text-slate-100 mb-4 flex items-center gap-2">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                  <circle cx="12" cy="12" r="3"/>
                </svg>
                Pratinjau Data Sumber (API)
              </h3>
              
              <div v-if="loadingPreview" class="flex justify-center py-4">
                <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
              </div>
              
              <div v-else-if="selectedDocType === 'financial' && dataPreview" class="grid grid-cols-2 md:grid-cols-4 gap-4">
                <div class="p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-100 dark:border-slate-600 shadow-sm">
                  <div class="text-[10px] text-slate-500 uppercase font-bold mb-1">Revenue</div>
                  <div class="text-sm font-bold text-slate-900 dark:text-slate-100">Rp {{ Number(dataPreview.revenue || 0).toLocaleString('id-ID') }}</div>
                </div>
                <div class="p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-100 dark:border-slate-600 shadow-sm">
                  <div class="text-[10px] text-slate-500 uppercase font-bold mb-1">Expenses</div>
                  <div class="text-sm font-bold text-slate-900 dark:text-slate-100">Rp {{ Number(dataPreview.expenses || 0).toLocaleString('id-ID') }}</div>
                </div>
                <div class="p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-100 dark:border-slate-600 shadow-sm">
                  <div class="text-[10px] text-slate-500 uppercase font-bold mb-1">Net Profit</div>
                  <div class="text-sm font-bold text-slate-900 dark:text-slate-100">Rp {{ Number(dataPreview.net_profit || 0).toLocaleString('id-ID') }}</div>
                </div>
                <div class="p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-100 dark:border-slate-600 shadow-sm">
                  <div class="text-[10px] text-slate-500 uppercase font-bold mb-1">Margin</div>
                  <div class="text-sm font-bold text-slate-900 dark:text-slate-100">{{ dataPreview.profit_margin }}%</div>
                </div>
              </div>

              <div v-else-if="selectedDocType === 'operational' && dataPreview" class="grid grid-cols-2 md:grid-cols-4 gap-4">
                <div class="p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-100 dark:border-slate-600 shadow-sm">
                  <div class="text-[10px] text-slate-500 uppercase font-bold mb-1">Productivity</div>
                  <div class="text-sm font-bold text-green-600">{{ dataPreview.productivity_score || 0 }}%</div>
                </div>
                <div class="p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-100 dark:border-slate-600 shadow-sm">
                  <div class="text-[10px] text-slate-500 uppercase font-bold mb-1">Efficiency</div>
                  <div class="text-sm font-bold text-blue-600">{{ dataPreview.efficiency_score || 0 }}%</div>
                </div>
                <div class="p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-100 dark:border-slate-600 shadow-sm">
                  <div class="text-[10px] text-slate-500 uppercase font-bold mb-1">Quality</div>
                  <div class="text-sm font-bold text-purple-600">{{ dataPreview.quality_score || 0 }}%</div>
                </div>
                <div class="p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-100 dark:border-slate-600 shadow-sm">
                  <div class="text-[10px] text-slate-500 uppercase font-bold mb-1">Delivery</div>
                  <div class="text-sm font-bold text-orange-600">{{ dataPreview.on_time_delivery_score || 0 }}%</div>
                </div>
              </div>

              <div v-else-if="selectedDocType === 'management' && dataPreview" class="grid grid-cols-2 md:grid-cols-4 gap-4">
                <div class="p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-100 dark:border-slate-600 shadow-sm">
                  <div class="text-[10px] text-slate-500 uppercase font-bold mb-1">Goals</div>
                  <div class="text-sm font-bold text-slate-900 dark:text-slate-100">{{ dataPreview.goals_count }}</div>
                </div>
                <div class="p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-100 dark:border-slate-600 shadow-sm">
                  <div class="text-[10px] text-slate-500 uppercase font-bold mb-1">Achievements</div>
                  <div class="text-sm font-bold text-slate-900 dark:text-slate-100">{{ dataPreview.achievements_count }}</div>
                </div>
                <div class="md:col-span-2 p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-100 dark:border-slate-600 shadow-sm">
                  <div class="text-[10px] text-slate-500 uppercase font-bold mb-1">First Goal</div>
                  <div class="text-xs font-semibold text-slate-900 dark:text-slate-100 truncate">{{ dataPreview.first_goal }}</div>
                </div>
              </div>

            <p class="text-[10px] text-slate-500 mt-4 italic">* Data ini akan digunakan AI sebagai referensi utama dalam menyusun narasi laporan.</p>
          </div>
        </div>
      </div> <!-- End of bg-white inner box -->

        <div class="flex gap-4 justify-center">
          <BaseButton variant="secondary" @click="prevStep(1)">Kembali</BaseButton>
          <BaseButton variant="primary" @click="generatePreview" :loading="loadingAI">Generate Preview</BaseButton>
        </div>
        </div>

        <!-- Step 3: Preview -->
        <div v-if="currentStep === 3" class="animate-fade-in">
          <h2 class="text-2xl font-bold text-slate-900 dark:text-slate-100 mb-8 text-center">Preview Dokumen</h2>
          
          <!-- Template Preview Container -->
          <div class="preview-container">
            <div class="preview-viewport" :style="{ transform: `translateY(calc(-${currentPage - 1} * (297mm + 10mm)))` }">
              <div class="document-preview-wrapper">
                <component 
                  v-if="currentTemplate" 
                  :is="currentTemplate" 
                  :document="previewDocument"
                />
                <div v-else class="preview-error">
                  <p class="text-slate-600 dark:text-slate-400">
                    Tidak dapat menampilkan preview. Silakan kembali dan pilih jenis dokumen.
                  </p>
                </div>
              </div>
            </div>
          </div>

          <!-- Pagination Controls -->
          <div class="flex items-center justify-center gap-4 mt-4 mb-8">
            <button 
              class="w-10 h-10 rounded-full flex items-center justify-center bg-white border border-slate-200 hover:bg-slate-50 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
              @click="currentPage > 1 && currentPage--"
              :disabled="currentPage === 1"
            >
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M15 18l-6-6 6-6"/>
              </svg>
            </button>
            <span class="text-sm font-medium text-slate-600">
              Halaman {{ currentPage }} dari {{ totalPages }}
            </span>
            <button 
              class="w-10 h-10 rounded-full flex items-center justify-center bg-white border border-slate-200 hover:bg-slate-50 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
              @click="currentPage < totalPages && currentPage++"
              :disabled="currentPage === totalPages"
            >
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M9 18l6-6-6-6"/>
              </svg>
            </button>
          </div>
          
          <div class="flex gap-4 justify-center mt-8">
            <BaseButton variant="secondary" @click="prevStep(2)">Edit Data</BaseButton>
            <BaseButton variant="primary" @click="finalizeDocument">Finalisasi & Simpan</BaseButton>
          </div>
        </div>

        <!-- Step 4: Complete -->
        <div v-if="currentStep === 4" class="animate-fade-in">
          <div class="text-center py-16 px-8">
            <div class="w-24 h-24 mx-auto mb-8 rounded-full bg-gradient-success flex items-center justify-center text-white animate-[scaleIn_0.5s_ease-out]">
              <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M22 11.08V12a10 10 0 11-5.93-9.14"/>
                <path d="M22 4L12 14.01l-3-3"/>
              </svg>
            </div>
            <h2 class="text-3xl text-slate-900 dark:text-slate-100 mb-4">Dokumen Berhasil Dibuat!</h2>
            <p class="text-lg text-slate-600 dark:text-slate-400 mb-12">Dokumen Anda telah disimpan dan siap diunduh</p>
            <div class="flex gap-4 justify-center mb-8">
              <button class="btn-secondary" @click="downloadPDF">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4M7 10l5 5 5-5M12 15V3"/>
                </svg>
                Download PDF
              </button>
              <button class="btn-secondary" @click="downloadMarkdown">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4M7 10l5 5 5-5M12 15V3"/>
                </svg>
                Download Markdown
              </button>
            </div>
            <button class="btn-primary" @click="createAnother">Buat Dokumen Lain</button>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  <!-- Hidden dedicated print container -->
  <div class="print-only-document">
    <div class="document-preview-wrapper shadow-none p-0 border-none m-0">
      <component 
        v-if="currentTemplate" 
        :is="currentTemplate" 
        :document="previewDocument"
      />
    </div>
  </div>
</template>

<style scoped>
.print-only-document {
  display: none;
}

@media print {
  body * {
    visibility: hidden;
  }
  .print-only-document, .print-only-document * {
    visibility: visible;
  }
  .print-only-document {
    display: block !important;
    position: relative !important;
    left: 0 !important;
    top: 0 !important;
    width: 100% !important;
    margin: 0 !important;
    padding: 0 !important;
    background: white !important;
  }
  .document-preview-wrapper {
    box-shadow: none !important;
    border: none !important;
    margin: 0 !important;
    padding: 0 !important;
    width: 100% !important;
    background-image: none !important; /* Remove page break simulation in print */
  }
}

/* Preview Container - A4 Paper Format */
/* Preview Container - Viewport */
.preview-container {
  background: #f5f5f5;
  border-radius: 8px;
  overflow: hidden; /* Hide header/footer overflow */
  margin-bottom: 2rem;
  height: calc(297mm + 80px); /* A4 height + padding */
  position: relative;
  border: 1px solid #e2e8f0;
  max-height: none; /* Ensure full A4 visibility */
}

.preview-viewport {
  transition: transform 0.4s cubic-bezier(0.25, 1, 0.5, 1);
  padding: 40px 20px; /* Internal padding */
  width: 100%;
}

.document-preview-wrapper {
  /* A4 dimensions: 210mm x 297mm */
  width: 210mm;
  min-height: 297mm;
  background: white;
  margin: 0 auto;
  padding: 25mm 20mm; /* Standard document margins */
  box-shadow: 
    0 0 0 1px rgba(0, 0, 0, 0.05),
    0 2px 8px rgba(0, 0, 0, 0.08),
    0 4px 16px rgba(0, 0, 0, 0.06);
  position: relative;

  /* Page break simulation: 297mm white page + 10mm gray gap */
  background-image: linear-gradient(to bottom, 
    #fff 0, 
    #fff 297mm, 
    #525659 297mm, 
    #525659 calc(297mm + 10mm)
  );
  background-size: 100% calc(297mm + 10mm);
  background-attachment: local;
  background-repeat: repeat-y;
}

.preview-error {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 400px;
  text-align: center;
  padding: 2rem;
  background: white;
}

/* Scrollbar Styling */
.preview-container::-webkit-scrollbar {
  width: 10px;
}

.preview-container::-webkit-scrollbar-track {
  background: #e8e8e8;
}

.preview-container::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 5px;
}

.preview-container::-webkit-scrollbar-thumb:hover {
  background: #a8a8a8;
}

/* Dark mode support */
@media (prefers-color-scheme: dark) {
  .preview-container {
    background: #2d2d2d;
  }
  
  .document-preview-wrapper {
    background: white;
  }
  
  .preview-container::-webkit-scrollbar-track {
    background: #1a1a1a;
  }
  
  .preview-container::-webkit-scrollbar-thumb {
    background: #4a4a4a;
  }
  
  .preview-container::-webkit-scrollbar-thumb:hover {
    background: #5a5a5a;
  }
}

:global(.dark) .preview-container {
  background: #2d2d2d;
}

:global(.dark) .document-preview-wrapper {
  background: white;
}

:global(.dark) .preview-container::-webkit-scrollbar-track {
  background: #1a1a1a;
}

:global(.dark) .preview-container::-webkit-scrollbar-thumb {
  background: #4a4a4a;
}

:global(.dark) .preview-container::-webkit-scrollbar-thumb:hover {
  background: #5a5a5a;
}

@keyframes scaleIn {
  from {
    transform: scale(0);
  }
  to {
    transform: scale(1);
  }
}

@media (max-width: 768px) {
  section {
    @apply px-4 py-8;
  }
  
  .bg-white.dark\:bg-slate-800 {
    @apply p-6;
  }
  
  .flex.items-center.justify-center {
    @apply overflow-x-auto;
  }
  
  .w-20 {
    @apply w-10;
  }
  
  /* Responsive A4 */
  .preview-container {
    padding: 20px 10px;
  }
  
  .document-preview-wrapper {
    width: 100%;
    min-width: 0;
    padding: 15mm 10mm;
  }
}

/* Print styles */
@media print {
  /* Hide Navbar and System UI globally */
  :global(nav), 
  :global(.navbar), 
  :global(header),
  :global(.sidebar) { 
    display: none !important; 
  }

  /* Hide the interactive section of this component */
  section {
    display: none !important;
  }
  
  /* Reset body/app containers for print */
  :global(body), 
  :global(#app), 
  :global(.app-container), 
  :global(.main-content) {
    margin: 0 !important;
    padding: 0 !important;
    background: white !important;
    width: 100% !important;
    height: auto !important;
    overflow: visible !important;
    visibility: hidden; /* Hide everything by default */
  }

  /* Show only the print container */
  .print-only-document {
    display: block !important;
    visibility: visible;
    position: relative; /* Changed from absolute to allow multi-page flow */
    width: 210mm; /* A4 width */
    margin: 0 auto;
    z-index: 9999;
  }
  
  .print-only-document * {
    visibility: visible;
  }
  
  /* Reset element styles inside print container */
  .print-only-document :deep(.document-preview-wrapper) {
    box-shadow: none !important;
    margin: 0 !important;
    padding: 0 !important;
    border: none !important;
    background: white !important;
  }
}
</style>
