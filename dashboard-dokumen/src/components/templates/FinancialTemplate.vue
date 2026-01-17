<script setup lang="ts">
import { computed } from 'vue'
import type { FinancialData } from '@/controller/documentController'

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
    financial_data?: FinancialData
  }
}

const props = defineProps<Props>()

// Default company info
const companyName = computed(() => props.document.companyName || 'PT. NAMA PERUSAHAAN')
const companyAddress = computed(() => props.document.companyAddress || 'Jl. Contoh No. 123, Jakarta 12345')
const companyPhone = computed(() => props.document.companyPhone || '+62 21 1234 5678')
const companyEmail = computed(() => props.document.companyEmail || 'info@perusahaan.co.id')

// Helper to get AI content or fallback
const aiNarrative = computed(() => props.document.content || null)

// Safe access to financial data from props
const financialData = computed(() => props.document.financial_data || null)
const summary = computed(() => financialData.value?.summary || null)
const breakdowns = computed(() => financialData.value?.breakdowns || [])

// Improved breakdown filtering using 'type' field from backend
const revenueBreakdown = computed(() => {
  return breakdowns.value.filter(b => b.type === 'revenue' || b.category.toLowerCase().includes('penjualan') || b.category.toLowerCase().includes('pendapatan'))
})

const expenseBreakdown = computed(() => {
  return breakdowns.value.filter(b => b.type === 'expense' || b.category.toLowerCase().includes('biaya') || b.category.toLowerCase().includes('gaji') || b.category.toLowerCase().includes('beban'))
})

const cashFlow = computed(() => financialData.value?.cash_flow || null)
const trends = computed(() => financialData.value?.trends || [])

// Ratios and other data (if not in backend, we show placeholders or hide)
const ratios = computed(() => (financialData.value as any)?.ratios || null)
</script>

<template>
  <div class="financial-document">
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
        <p class="doc-type">LAPORAN KEUANGAN</p>
        <h2 class="doc-title">{{ document.title }}</h2>
      </div>
      <div class="doc-metadata">
        <table class="metadata-table">
          <tbody>
            <tr>
              <td class="meta-label">No. Dokumen</td>
              <td class="meta-colon">:</td>
              <td class="meta-value">FIN/{{ new Date().getFullYear() }}/{{ String(Math.floor(Math.random() * 1000)).padStart(4, '0') }}</td>
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

    <!-- Summary Section -->
    <section v-if="summary" class="section">
      <h3 class="section-title">RINGKASAN KEUANGAN</h3>
      <div class="summary-grid">
        <div class="summary-item">
          <p class="summary-label">Total Pendapatan</p>
          <p class="summary-value">Rp {{ Number(summary.revenue || 0).toLocaleString('id-ID') }}</p>
          <p v-if="summary.revenue_growth" class="summary-growth positive">↑ {{ summary.revenue_growth }}% YoY</p>
        </div>
        <div class="summary-item">
          <p class="summary-label">Total Beban</p>
          <p class="summary-value">Rp {{ Number(summary.expenses || 0).toLocaleString('id-ID') }}</p>
          <p v-if="summary.expenses_last_year" class="summary-change">Tahun Lalu: Rp {{ Number(summary.expenses_last_year).toLocaleString('id-ID') }}</p>
        </div>
        <div class="summary-item highlight">
          <p class="summary-label">Laba Bersih</p>
          <p class="summary-value">Rp {{ Number(summary.net_profit || 0).toLocaleString('id-ID') }}</p>
          <p v-if="summary.net_profit_last_year" class="summary-change">Tahun Lalu: Rp {{ Number(summary.net_profit_last_year).toLocaleString('id-ID') }}</p>
        </div>
        <div class="summary-item">
          <p class="summary-label">Margin Laba</p>
          <p class="summary-value">{{ summary.profit_margin || '-' }}%</p>
          <p v-if="summary.profit_margin_last_year" class="summary-change">Tahun Lalu: {{ summary.profit_margin_last_year }}%</p>
        </div>
      </div>
    </section>

    <!-- Revenue Analysis with YoY -->
    <section v-if="revenueBreakdown.length > 0" class="section">
      <h3 class="section-title">ANALISIS PENDAPATAN</h3>
      <table class="financial-table">
        <thead>
          <tr>
            <th class="text-left">Kategori</th>
            <th class="text-right">Tahun Ini (Rp)</th>
            <th v-if="revenueBreakdown[0]?.previous_amount" class="text-right">Tahun Lalu (Rp)</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in revenueBreakdown" :key="'rev-' + index">
            <td>{{ item.category }}</td>
            <td class="text-right">{{ Number(item.amount || 0).toLocaleString('id-ID') }}</td>
            <td v-if="item.previous_amount" class="text-right">{{ Number(item.previous_amount).toLocaleString('id-ID') }}</td>
          </tr>
          <tr v-if="summary?.revenue" class="total-row">
            <td><strong>TOTAL</strong></td>
            <td class="text-right"><strong>{{ Number(summary.revenue).toLocaleString('id-ID') }}</strong></td>
            <td v-if="summary.revenue_last_year" class="text-right"><strong>{{ Number(summary.revenue_last_year).toLocaleString('id-ID') }}</strong></td>
          </tr>
        </tbody>
      </table>
    </section>

    <!-- Expense Breakdown with Percentage -->
    <section v-if="expenseBreakdown.length > 0" class="section">
      <h3 class="section-title">STRUKTUR BEBAN OPERASIONAL</h3>
      <table class="financial-table">
        <thead>
          <tr>
            <th class="text-left">Kategori</th>
            <th class="text-right">Jumlah (Rp)</th>
            <th v-if="expenseBreakdown[0]?.percentage" class="text-right">Persentase (%)</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in expenseBreakdown" :key="'exp-' + index">
            <td>{{ item.category }}</td>
            <td class="text-right">{{ Number(item.amount || 0).toLocaleString('id-ID') }}</td>
            <td v-if="item.percentage" class="text-right">{{ item.percentage }}%</td>
          </tr>
          <tr v-if="summary?.expenses" class="total-row">
            <td><strong>TOTAL</strong></td>
            <td class="text-right"><strong>{{ Number(summary.expenses).toLocaleString('id-ID') }}</strong></td>
            <td class="text-right"><strong>100.0%</strong></td>
          </tr>
        </tbody>
      </table>
    </section>

    <!-- Cash Flow -->
    <section v-if="cashFlow" class="section">
      <h3 class="section-title">LAPORAN ARUS KAS</h3>
      <table class="financial-table">
        <thead>
          <tr>
            <th class="text-left">Aktivitas</th>
            <th class="text-right">Jumlah (Rp)</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Kas Awal Periode</td>
            <td class="text-right">{{ Number(cashFlow.beginning_cash || 0).toLocaleString('id-ID') }}</td>
          </tr>
          <tr class="spacer"><td colspan="2"></td></tr>
          <tr>
            <td>Arus Kas dari Aktivitas Operasi</td>
            <td :class="['text-right', (cashFlow.operating_cash || 0) >= 0 ? 'growth-positive' : 'growth-negative']">
              {{ Number(cashFlow.operating_cash || 0).toLocaleString('id-ID') }}
            </td>
          </tr>
          <tr>
            <td>Arus Kas dari Aktivitas Investasi</td>
            <td :class="['text-right', (cashFlow.investing_cash || 0) >= 0 ? 'growth-positive' : 'growth-negative']">
              {{ Number(cashFlow.investing_cash || 0).toLocaleString('id-ID') }}
            </td>
          </tr>
          <tr>
            <td>Arus Kas dari Aktivitas Pendanaan</td>
            <td :class="['text-right', (cashFlow.financing_cash || 0) >= 0 ? 'growth-positive' : 'growth-negative']">
              {{ Number(cashFlow.financing_cash || 0).toLocaleString('id-ID') }}
            </td>
          </tr>
          <tr class="subtotal-row">
            <td><strong>Kenaikan (Penurunan) Kas Bersih</strong></td>
            <td class="text-right"><strong>{{ Number(cashFlow.net_change || 0).toLocaleString('id-ID') }}</strong></td>
          </tr>
          <tr class="spacer"><td colspan="2"></td></tr>
          <tr class="total-row">
            <td><strong>KAS AKHIR PERIODE</strong></td>
            <td class="text-right"><strong>{{ Number(cashFlow.ending_cash || 0).toLocaleString('id-ID') }}</strong></td>
          </tr>
        </tbody>
      </table>
    </section>

    <!-- Balance Sheet Section -->
    <section v-if="financialData?.balance_sheet" class="section">
      <h3 class="section-title">NERACA (BALANCE SHEET)</h3>
      <table class="financial-table">
        <thead>
          <tr>
            <th class="text-left">Aset</th>
            <th class="text-right">Jumlah (Rp)</th>
          </tr>
        </thead>
        <tbody>
          <template v-if="(financialData.balance_sheet as any).currentAssets">
            <tr class="category-row"><td colspan="2">ASET LANCAR</td></tr>
            <tr v-for="item in (financialData.balance_sheet as any).currentAssets" :key="item.item">
              <td class="indent">{{ item.item }}</td>
              <td class="text-right">{{ item.amount.toLocaleString('id-ID') }}</td>
            </tr>
          </template>
          <template v-if="(financialData.balance_sheet as any).fixedAssets">
            <tr class="category-row"><td colspan="2">ASET TETAP</td></tr>
            <tr v-for="item in (financialData.balance_sheet as any).fixedAssets" :key="item.item">
              <td class="indent">{{ item.item }}</td>
              <td class="text-right">{{ item.amount.toLocaleString('id-ID') }}</td>
            </tr>
          </template>
        </tbody>
      </table>
    </section>

    <!-- Monthly Trends -->
    <section v-if="trends.length > 0" class="section">
      <h3 class="section-title">TREN KINERJA TERAKHIR</h3>
      <table class="financial-table">
        <thead>
          <tr>
            <th class="text-left">Bulan</th>
            <th class="text-right">Pendapatan (Rp)</th>
            <th class="text-right">Laba (Rp)</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="trend in trends" :key="trend.period_label">
            <td>{{ trend.period_label }}</td>
            <td class="text-right">{{ trend.revenue?.toLocaleString('id-ID') }}</td>
            <td class="text-right">{{ trend.profit?.toLocaleString('id-ID') }}</td>
          </tr>
        </tbody>
      </table>
    </section>

    <!-- Financial Ratios -->
    <section v-if="ratios" class="section">
      <h3 class="section-title">RASIO KEUANGAN</h3>
      <div class="ratio-grid">
        <div v-for="(val, label) in ratios" :key="label" class="ratio-item">
          <span class="ratio-label">{{ label }}</span>
          <span class="ratio-value">{{ val }}</span>
        </div>
      </div>
    </section>

    <!-- Analysis Section -->
    <section v-if="aiNarrative || document.notes" class="section">
      <h3 class="section-title">ANALISIS & CATATAN MANAJERIAl</h3>
      
      <div class="analysis-content">
        <!-- Intro -->
        <div v-if="aiNarrative?.intro" class="analysis-subsection">
          <h4 class="subsection-label">Ringkasan Eksekutif</h4>
          <p class="analysis-p">{{ aiNarrative.intro }}</p>
        </div>

        <!-- Analysis -->
        <div v-if="aiNarrative?.analysis" class="analysis-subsection">
          <h4 class="subsection-label">Analisis Kinerja</h4>
          <p class="analysis-p">{{ aiNarrative.analysis }}</p>
        </div>

        <!-- Conclusion -->
        <div v-if="aiNarrative?.conclusion" class="analysis-subsection">
          <h4 class="subsection-label">Kesimpulan</h4>
          <p class="analysis-p highlighted-p">{{ aiNarrative.conclusion }}</p>
        </div>

        <!-- User Notes -->
        <div v-if="document.notes" class="analysis-subsection">
          <h4 class="subsection-label">Catatan Tambahan</h4>
          <p class="analysis-p italic">{{ document.notes }}</p>
        </div>
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
.financial-document {
  font-family: 'Times New Roman', Times, serif;
  font-size: 11pt;
  line-height: 1.5;
  color: #000;
  background: #fff;
  padding: 0;
  max-width: 210mm; /* A4 width */
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

/* Summary Grid */
.summary-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 15px;
  margin-bottom: 10px;
}

.summary-item {
  padding: 15px;
  border: 1px solid #ddd;
  background: #fafafa;
}

.summary-item.highlight {
  background: #f0f0f0;
  border-color: #000;
}

.summary-label {
  font-size: 9pt;
  margin: 0 0 8px 0;
  color: #666;
  font-weight: 500;
}

.summary-value {
  font-size: 13pt;
  font-weight: 700;
  margin: 0;
  color: #000;
}

/* Financial Tables */
.financial-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 10pt;
  margin-top: 10px;
}

.financial-table thead {
  border-bottom: 2px solid #000;
}

.financial-table th {
  padding: 8px 10px;
  font-weight: 700;
  color: #000;
}

.financial-table td {
  padding: 6px 10px;
  border-bottom: 1px solid #e0e0e0;
}

.financial-table .category-row {
  background: #f5f5f5;
  font-weight: 600;
}

.financial-table .category-row td {
  padding-top: 10px;
  padding-bottom: 6px;
  border-bottom: 1px solid #ccc;
}

.financial-table .indent {
  padding-left: 30px;
}

.financial-table .subtotal-row {
  background: #fafafa;
  border-top: 1px solid #999;
}

.financial-table .subtotal-row td {
  padding-top: 8px;
  padding-bottom: 8px;
}

.financial-table .total-row {
  background: #f0f0f0;
  border-top: 2px solid #000;
  border-bottom: 2px solid #000;
}

.financial-table .total-row td {
  padding-top: 10px;
  padding-bottom: 10px;
  font-size: 11pt;
}

.financial-table .spacer td {
  padding: 8px 0;
  border: none;
}

.text-left {
  text-align: left;
}

.text-right {
  text-align: right;
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
}

.highlighted-p {
  font-weight: 500;
}

/* Default Notes Fallback */
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
  .financial-document {
    padding: 0;
  }
  
  .ai-header {
    background: #1a1a1a !important;
    color: #fff !important;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
  }
}

/* Dark Mode Override - Keep document white */
@media (prefers-color-scheme: dark) {
  .financial-document {
    background: #fff;
    color: #000;
  }
}

:global(.dark) .financial-document {
  background: #fff;
  color: #000;
}
</style>
