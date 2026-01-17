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
    operational_data?: any
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

// Safe access to operational data from props
const operationalData = computed(() => props.document.operational_data || null)
const kpi = computed(() => operationalData.value?.kpi || null)
const performance = computed(() => operationalData.value?.performance || [])
const inventory = computed(() => operationalData.value?.inventory || [])
const risks = computed(() => operationalData.value?.risks || [])
const achievements = computed(() => operationalData.value?.achievements || [])
const issues = computed(() => operationalData.value?.issues || [])
const recommendations = computed(() => operationalData.value?.recommendations || [])

</script>

<template>
  <div class="operational-document">
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
        <p class="doc-type">LAPORAN OPERASIONAL</p>
        <h2 class="doc-title">{{ document.title }}</h2>
      </div>
      <div class="doc-metadata">
        <table class="metadata-table">
          <tbody>
            <tr>
              <td class="meta-label">No. Dokumen</td>
              <td class="meta-colon">:</td>
              <td class="meta-value">OPS/{{ new Date().getFullYear() }}/{{ String(Math.floor(Math.random() * 1000)).padStart(4, '0') }}</td>
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

    <!-- KPI Summary -->
    <section v-if="kpi" class="section">
      <h3 class="section-title">KEY PERFORMANCE INDICATORS</h3>
      <div class="kpi-grid">
        <div class="kpi-item">
          <p class="kpi-label">Produktivitas</p>
          <p class="kpi-value">{{ kpi.productivity }}%</p>
        </div>
        <div class="kpi-item">
          <p class="kpi-label">Efisiensi</p>
          <p class="kpi-value">{{ kpi.efficiency }}%</p>
        </div>
        <div class="kpi-item">
          <p class="kpi-label">Kualitas</p>
          <p class="kpi-value">{{ kpi.quality }}%</p>
        </div>
        <div class="kpi-item">
          <p class="kpi-label">Ketepatan Waktu</p>
          <p class="kpi-value">{{ kpi.onTimeDelivery }}%</p>
        </div>
      </div>
    </section>

    <!-- Performance Logs -->
    <section v-if="performance.length > 0" class="section">
      <h3 class="section-title">LAPORAN PERFORMA UNIT DETIL</h3>
      <table class="data-table">
        <thead>
          <tr>
            <th class="text-left">Unit / Departemen</th>
            <th class="text-right">Target</th>
            <th class="text-right">Aktual</th>
            <th class="text-right">Pencapaian (%)</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in performance" :key="index">
            <td>{{ item.department }}</td>
            <td class="text-right">{{ item.target?.toLocaleString('id-ID') }}</td>
            <td class="text-right">{{ item.actual?.toLocaleString('id-ID') }}</td>
            <td class="text-right" :class="(item.achievement || 0) >= 100 ? 'text-positive' : 'text-negative'">
              {{ item.achievement }}%
            </td>
          </tr>
        </tbody>
      </table>
    </section>

    <!-- Inventory Status -->
    <section v-if="inventory.length > 0" class="section">
      <h3 class="section-title">STATUS INVENTARIS & ASET UTAMA</h3>
      <table class="data-table">
        <thead>
          <tr>
            <th class="text-left">Item / Material</th>
            <th class="text-left">Stok Saat Ini</th>
            <th class="text-left">Status</th>
            <th class="text-left">Rencana Pesanan</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in inventory" :key="index">
            <td>{{ item.item }}</td>
            <td>{{ item.stock }}</td>
            <td>
              <span class="status-badge" :class="item.status.toLowerCase()">
                {{ item.status }}
              </span>
            </td>
            <td>{{ item.restockDate }}</td>
          </tr>
        </tbody>
      </table>
    </section>

    <!-- Operational Risk Matrix -->
    <section v-if="risks.length > 0" class="section">
      <h3 class="section-title">MATRIKS RISIKO OPERASIONAL</h3>
      <table class="data-table">
        <thead>
          <tr>
            <th class="text-left">Kategori</th>
            <th class="text-left">Isu Risiko</th>
            <th class="text-left">Dampak</th>
            <th class="text-left">Mitigasi</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(risk, index) in risks" :key="index">
            <td style="font-weight: 500;">{{ risk.category }}</td>
            <td>{{ risk.risk }}</td>
            <td :class="risk.impact === 'Sangat Tinggi' || risk.impact === 'Tinggi' ? 'text-negative' : ''" style="font-weight: 700;">
              {{ risk.impact }}
            </td>
            <td>{{ risk.mitigation }}</td>
          </tr>
        </tbody>
      </table>
    </section>

    <!-- Observation & Evaluation Section -->
    <section v-if="aiNarrative" class="section">
      <h3 class="section-title">OBSERVASI & EVALUASI OPERASIONAL</h3>
      
      <div class="analysis-content">
        <div v-if="aiNarrative.intro" class="analysis-subsection">
          <h4 class="subsection-label">Ringkasan Performa</h4>
          <p class="analysis-p">{{ aiNarrative.intro }}</p>
        </div>

        <div v-if="aiNarrative.analysis" class="analysis-subsection">
          <h4 class="subsection-label">Analisis Detail</h4>
          <p class="analysis-p">{{ aiNarrative.analysis }}</p>
        </div>

        <div v-if="aiNarrative.conclusion" class="analysis-subsection">
          <h4 class="subsection-label">Kesimpulan Operasional</h4>
          <p class="analysis-p highlighted-p">{{ aiNarrative.conclusion }}</p>
        </div>
      </div>
    </section>

    <!-- Detailed Insights -->
    <section v-if="aiNarrative?.achievements" class="section">
      <h4 class="subsection-label">Pencapaian Tim & Unit</h4>
      <p class="analysis-p">{{ aiNarrative.achievements }}</p>
    </section>
    
    <section v-else-if="achievements.length > 0" class="section">
      <h3 class="section-title">PENCAPAIAN TIM & UNIT</h3>
      <ul class="numbered-list" style="list-style-type: disc;">
        <li v-for="(achievement, index) in achievements" :key="index">
          {{ achievement }}
        </li>
      </ul>
    </section>

    <!-- Issues -->
    <section v-if="aiNarrative?.issues" class="section">
      <h4 class="subsection-label">Isu dan Tantangan</h4>
      <p class="analysis-p">{{ aiNarrative.issues }}</p>
    </section>

    <section v-else-if="issues.length > 0" class="section">
      <h3 class="section-title">ISU DAN TANTANGAN</h3>
      <ol class="numbered-list">
        <li v-for="(issue, index) in issues" :key="index">{{ issue }}</li>
      </ol>
    </section>

    <!-- Recommendations -->
    <section v-if="aiNarrative?.recommendations" class="section">
      <h4 class="subsection-label">Rekomendasi</h4>
      <p class="analysis-p">{{ aiNarrative.recommendations }}</p>
    </section>

    <section v-else-if="recommendations.length > 0" class="section">
      <h3 class="section-title">REKOMENDASI</h3>
      <ol class="numbered-list">
        <li v-for="(rec, index) in recommendations" :key="index">{{ rec }}</li>
      </ol>
    </section>

    <!-- Notes if any -->
    <section v-if="document.notes" class="section">
      <h3 class="section-title">CATATAN</h3>
      <p class="notes-text">{{ document.notes }}</p>
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
.operational-document {
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

/* KPI Grid */
.kpi-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 15px;
  margin-bottom: 10px;
}

.kpi-item {
  padding: 15px;
  border: 1px solid #ddd;
  background: #fafafa;
  text-align: center;
}

.kpi-label {
  font-size: 9pt;
  margin: 0 0 8px 0;
  color: #666;
  font-weight: 500;
}

.kpi-value {
  font-size: 18pt;
  font-weight: 700;
  margin: 0;
  color: #000;
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
.analysis-subsection {
  margin-bottom: 20px;
}

.subsection-label {
  font-size: 10.5pt;
  font-weight: 700;
  color: #000;
  margin: 0 0 5px 0;
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
  margin: 0;
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
  .operational-document {
    padding: 0;
  }

  .ai-header {
    background: #065f46 !important;
    color: #fff !important;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
  }
}

/* Dark Mode Override */
@media (prefers-color-scheme: dark) {
  .operational-document {
    background: #fff;
    color: #000;
  }
}

:global(.dark) .operational-document {
  background: #fff;
  color: #000;
}
</style>
