<script setup lang="ts">
interface Props {
  document: {
    title: string
    period: string
    date: string
    notes?: string
    content?: any
    companyName?: string
    companyAddress?: string
    companyPhone?: string
    companyEmail?: string
    companyLogo?: string
    management_data?: any
  }
}

const props = defineProps<Props>()

import { computed } from 'vue'

// Default company info
const companyName = computed(() => props.document.companyName || 'PT. NAMA PERUSAHAAN')
const companyAddress = computed(() => props.document.companyAddress || 'Jl. Contoh No. 123, Jakarta 12345')
const companyPhone = computed(() => props.document.companyPhone || '+62 21 1234 5678')
const companyEmail = computed(() => props.document.companyEmail || 'info@perusahaan.co.id')

// Helper to get AI content or fallback
const aiNarrative = computed(() => props.document.content || null)

// Safe access to management data from props
const managementData = computed(() => props.document.management_data || null)
const executiveSummary = computed(() => managementData.value?.executiveSummary || '')
const swot = computed(() => managementData.value?.swot || null)
const stakeholders = computed(() => managementData.value?.stakeholders || [])
const strategicGoals = computed(() => managementData.value?.strategicGoals || [])
const achievements = computed(() => managementData.value?.achievements || [])
const challenges = computed(() => managementData.value?.challenges || [])
const nextSteps = computed(() => managementData.value?.nextSteps || [])

</script>

<template>
  <div class="management-document">
    <!-- Letterhead -->
    <div class="letterhead">
      <div class="letterhead-top">
        <div class="logo-section">
          <div v-if="document.companyLogo" class="company-logo">
            <img :src="document.companyLogo" :alt="companyName" />
          </div>
          <div v-else class="company-logo-placeholder">
            <div class="logo-box"></div>
          </div>
        </div>
        <div class="company-info">
          <h1 class="company-name">{{ companyName }}</h1>
          <div class="company-details">
            <p>{{ companyAddress }}</p>
            <p>Telp: {{ companyPhone }} | Email: {{ companyEmail }}</p>
          </div>
        </div>
      </div>
      <div class="letterhead-line"></div>
    </div>

    <!-- Document Header -->
    <div class="doc-header">
      <div class="doc-title-section">
        <p class="doc-type">LAPORAN MANAJEMEN</p>
        <h2 class="doc-title">{{ document.title }}</h2>
      </div>
      <div class="doc-metadata">
        <table class="metadata-table">
          <tbody>
            <tr>
              <td class="meta-label">No. Dokumen</td>
              <td class="meta-colon">:</td>
              <td class="meta-value">MGT/{{ new Date().getFullYear() }}/{{ String(Math.floor(Math.random() * 1000)).padStart(4, '0') }}</td>
            </tr>
            <tr>
              <td class="meta-label">Periode</td>
              <td class="meta-colon">:</td>
              <td class="meta-value">{{ document.period }}</td>
            </tr>
            <tr>
              <td class="meta-label">Tanggal</td>
              <td class="meta-colon">:</td>
              <td class="meta-value">{{ document.date }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <section v-if="executiveSummary || aiNarrative?.intro" class="section">
      <h3 class="section-title">RINGKASAN EKSEKUTIF</h3>
      <p class="summary-text">{{ executiveSummary || aiNarrative?.intro }}</p>
    </section>

    <!-- SWOT Analysis -->
    <section v-if="swot" class="section">
      <h3 class="section-title">ANALISIS SWOT</h3>
      <div class="swot-matrix">
        <div class="swot-quadrant s">
          <div class="quadrant-header">
            <span class="quadrant-key">S</span>
            <h4 class="quadrant-title">STRENGTHS</h4>
          </div>
          <ul v-if="swot.strengths?.length">
            <li v-for="(item, index) in swot.strengths" :key="index">{{ item }}</li>
          </ul>
        </div>
        <div class="swot-quadrant w">
          <div class="quadrant-header">
            <span class="quadrant-key">W</span>
            <h4 class="quadrant-title">WEAKNESSES</h4>
          </div>
          <ul v-if="swot.weaknesses?.length">
            <li v-for="(item, index) in swot.weaknesses" :key="index">{{ item }}</li>
          </ul>
        </div>
        <div class="swot-quadrant o">
          <div class="quadrant-header">
            <span class="quadrant-key">O</span>
            <h4 class="quadrant-title">OPPORTUNITIES</h4>
          </div>
          <ul v-if="swot.opportunities?.length">
            <li v-for="(item, index) in swot.opportunities" :key="index">{{ item }}</li>
          </ul>
        </div>
        <div class="swot-quadrant t">
          <div class="quadrant-header">
            <span class="quadrant-key">T</span>
            <h4 class="quadrant-title">THREATS</h4>
          </div>
          <ul v-if="swot.threats?.length">
            <li v-for="(item, index) in swot.threats" :key="index">{{ item }}</li>
          </ul>
        </div>
      </div>
    </section>

    <!-- Stakeholders & Governance -->
    <section v-if="stakeholders.length > 0" class="section">
      <h3 class="section-title">STAKEHOLDERS & TATA KELOLA</h3>
      <table class="data-table">
        <thead>
          <tr>
            <th class="text-left">Nama / Entitas</th>
            <th class="text-left">Peran</th>
            <th class="text-left">Keterlibatan Strategis</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(person, index) in stakeholders" :key="index">
            <td><strong>{{ person.name }}</strong></td>
            <td>{{ person.role }}</td>
            <td>{{ person.involvement }}</td>
          </tr>
        </tbody>
      </table>
    </section>

    <!-- Strategic Goals & Roadmap -->
    <section v-if="strategicGoals.length > 0" class="section">
      <h3 class="section-title">TUJUAN STRATEGIS & PROGRES</h3>
      <table class="data-table">
        <thead>
          <tr>
            <th class="text-left">Tujuan Strategis</th>
            <th class="text-center">Progres</th>
            <th class="text-center">Status</th>
            <th class="text-right">Deadline</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(goal, index) in strategicGoals" :key="index">
            <td>{{ goal.goal }}</td>
            <td class="text-center">
              <div class="progress-container">
                <div class="progress-bar" :style="{ width: goal.progress + '%' }"></div>
                <span class="progress-text">{{ goal.progress }}%</span>
              </div>
            </td>
            <td class="text-center">
              <span class="status-badge" :class="goal.status.toLowerCase().replace(' ', '-')">
                {{ goal.status }}
              </span>
            </td>
            <td class="text-right">{{ goal.deadline }}</td>
          </tr>
        </tbody>
      </table>
    </section>

    <!-- Analysis & Work Plan -->
    <section v-if="aiNarrative?.analysis || aiNarrative?.conclusion || achievements.length > 0 || challenges.length > 0 || nextSteps.length > 0 || document.notes" class="section mt-8">
      <h3 class="section-title">ANALISIS MANAJEMEN & RENCANA KERJA</h3>
      
      <!-- Achievements -->
      <div v-if="aiNarrative?.achievements" class="subsection">
        <h4 class="subsection-label">Pencapaian Utama</h4>
        <p class="analysis-p">{{ aiNarrative.achievements }}</p>
      </div>
      <div v-else-if="achievements.length > 0" class="subsection">
        <h4 class="subsection-title">Pencapaian Utama (Milestones)</h4>
        <ul class="bullet-list">
          <li v-for="(item, index) in achievements" :key="index">{{ item }}</li>
        </ul>
      </div>

      <div v-if="aiNarrative?.challenges" class="subsection">
        <h4 class="subsection-label">Tantangan & Hambatan</h4>
        <p class="analysis-p">{{ aiNarrative.challenges }}</p>
      </div>
      <div v-else-if="challenges.length > 0" class="subsection">
        <h4 class="subsection-title">Tantangan & Hambatan</h4>
        <ul class="bullet-list challenge-list">
          <li v-for="(item, index) in challenges" :key="index">{{ item }}</li>
        </ul>
      </div>

      <!-- Strategic Content -->
      <div v-if="aiNarrative?.analysis || aiNarrative?.conclusion" class="analysis-container mt-4">
        <div v-if="aiNarrative?.analysis" class="analysis-subsection">
          <h4 class="subsection-label">Evaluasi Strategis</h4>
          <p class="analysis-p">{{ aiNarrative.analysis }}</p>
        </div>
        <div v-if="aiNarrative?.conclusion" class="analysis-subsection">
          <h4 class="subsection-label">Kesimpulan & Rekomendasi</h4>
          <p class="analysis-p highlighted-p">{{ aiNarrative.conclusion }}</p>
        </div>
      </div>

      <!-- User Notes -->
      <div v-if="document.notes" class="subsection">
        <h4 class="subsection-title">Catatan Tambahan Direksi</h4>
        <p class="notes-text">{{ document.notes }}</p>
      </div>

      <!-- Next Steps -->
      <div v-if="aiNarrative?.next_steps" class="subsection">
        <h4 class="subsection-label">Langkah Strategis Berikutnya</h4>
        <p class="analysis-p">{{ aiNarrative.next_steps }}</p>
      </div>
      <div v-else-if="nextSteps.length > 0" class="subsection">
        <h4 class="subsection-title">Langkah Strategis Berikutnya</h4>
        <ul class="bullet-list next-steps-list">
          <li v-for="(item, index) in nextSteps" :key="index">{{ item }}</li>
        </ul>
      </div>
    </section>

    <!-- Footer -->
    <div class="document-footer">
      <div class="footer-line"></div>
      <p class="footer-text">Dokumen ini dibuat secara otomatis pada {{ new Date().toLocaleDateString('id-ID', { day: 'numeric', month: 'long', year: 'numeric' }) }}</p>
    </div>
  </div>
</template>

<style scoped>
/* Base Document Styles */
.management-document {
  font-family: 'Times New Roman', Times, serif;
  font-size: 11pt;
  line-height: 1.5;
  color: #000;
  background: #fff;
  padding: 0;
  max-width: 210mm;
  margin: 0 auto;
}

/* Letterhead */
.letterhead {
  margin-bottom: 30px;
  padding-bottom: 15px;
}

.letterhead-top {
  display: flex;
  align-items: flex-start;
  gap: 20px;
  margin-bottom: 10px;
}

.logo-section {
  flex-shrink: 0;
}

.company-logo img {
  width: 60px;
  height: 60px;
  object-fit: contain;
}

.company-logo-placeholder .logo-box {
  width: 60px;
  height: 60px;
  border: 2px solid #000;
  background: #f5f5f5;
}

.company-info {
  flex: 1;
}

.company-name {
  font-size: 16pt;
  font-weight: 700;
  margin: 0 0 5px 0;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  color: #000;
}

.company-details {
  font-size: 9pt;
  line-height: 1.4;
}

.company-details p {
  margin: 2px 0;
  color: #333;
}

.letterhead-line {
  height: 3px;
  background: #000;
  margin-top: 10px;
}

/* Document Header */
.doc-header {
  margin-bottom: 30px;
  padding-bottom: 20px;
  border-bottom: 1px solid #000;
}

.doc-title-section {
  margin-bottom: 15px;
}

.doc-type {
  font-size: 9pt;
  font-weight: 700;
  letter-spacing: 2px;
  margin: 0 0 5px 0;
  color: #666;
}

.doc-title {
  font-size: 14pt;
  font-weight: 700;
  margin: 0;
  color: #000;
}

.doc-metadata {
  margin-top: 15px;
}

.metadata-table {
  font-size: 10pt;
  border-collapse: collapse;
}

.metadata-table td {
  padding: 2px 0;
  vertical-align: top;
}

.meta-label {
  width: 120px;
  color: #666;
}

.meta-colon {
  width: 15px;
  text-align: center;
  color: #666;
}

.meta-value {
  color: #000;
  font-weight: 500;
}

/* Sections */
.section {
  margin-bottom: 35px;
}

.section-title {
  font-size: 11pt;
  font-weight: 700;
  margin: 0 0 15px 0;
  padding-bottom: 5px;
  border-bottom: 2px solid #000;
  letter-spacing: 0.5px;
  color: #000;
}

/* SWOT Matrix Styles */
.swot-matrix {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-template-rows: auto auto;
  border: 1px solid #000;
  margin-top: 15px;
}

.swot-quadrant {
  padding: 15px;
  border: 0.5px solid #000;
}

.quadrant-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 10px;
  border-bottom: 1px solid #eee;
  padding-bottom: 5px;
}

.quadrant-key {
  font-size: 14pt;
  font-weight: 800;
  color: #000;
  width: 25px;
}

.quadrant-title {
  font-size: 9pt;
  font-weight: 700;
  margin: 0;
  letter-spacing: 1px;
}

.swot-quadrant ul {
  margin: 0;
  padding-left: 20px;
  font-size: 9pt;
  list-style-type: disc;
}

.swot-quadrant li {
  margin-bottom: 5px;
  line-height: 1.4;
}

/* Data Tables */
.data-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 10pt;
  margin-top: 10px;
}

.data-table thead {
  border-bottom: 2px solid #000;
}

.data-table th {
  padding: 8px 10px;
  font-weight: 700;
  color: #000;
}

.data-table td {
  padding: 6px 10px;
  border-bottom: 1px solid #e0e0e0;
}

.data-table tbody tr:last-child td {
  border-bottom: 1px solid #000;
}

.text-left {
  text-align: left;
}

.text-center {
  text-align: center;
}

.text-right {
  text-align: right;
}

/* Numbered Lists */
.numbered-list {
  margin: 0;
  padding-left: 25px;
  font-size: 10pt;
  line-height: 1.8;
}

.numbered-list li {
  margin-bottom: 8px;
  color: #333;
}

/* Analysis Section Styles */
.subsection {
  margin-bottom: 25px;
}

.subsection-label {
  font-size: 10.5pt;
  font-weight: 700;
  color: #000;
  margin: 0 0 8px 0;
  text-transform: uppercase;
}

.analysis-p {
  font-size: 10.5pt;
  line-height: 1.6;
  color: #333;
  text-align: justify;
  margin: 0;
  white-space: pre-line;
}

.highlighted-p {
  font-weight: 500;
}

/* Notes */
.notes-text {
  font-size: 10pt;
  line-height: 1.6;
  color: #333;
  padding: 15px;
  background: #f9f9f9;
  border-left: 3px solid #666;
  margin: 15px 0 0 0;
}

/* Footer */
.document-footer {
  margin-top: 50px;
  padding-top: 20px;
}

.footer-line {
  height: 1px;
  background: #ccc;
  margin-bottom: 10px;
}

.footer-text {
  font-size: 8pt;
  color: #999;
  text-align: center;
  margin: 0;
  font-style: italic;
}

/* Print Styles */
@media print {
  .management-document {
    padding: 0;
  }

  .ai-header {
    background: #1e3a8a !important;
    color: #fff !important;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
  }
}

/* Dark Mode Override */
@media (prefers-color-scheme: dark) {
  .management-document {
    background: #fff;
    color: #000;
  }
}

:global(.dark) .management-document {
  background: #fff;
  color: #000;
}
</style>
