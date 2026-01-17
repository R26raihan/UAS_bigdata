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
  }
}

const props = defineProps<Props>()

import { computed } from 'vue'

// Default company info
const companyName = computed(() => props.document.companyName || 'PT. NAMA PERUSAHAAN')
const companyAddress = computed(() => props.document.companyAddress || 'Jl. Contoh No. 123, Jakarta 12345')
const companyPhone = computed(() => props.document.companyPhone || '+62 21 1234 5678')
const companyEmail = computed(() => props.document.companyEmail || 'info@perusahaan.co.id')

</script>

<template>
  <div class="custom-document">
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
        <p class="doc-type">DOKUMEN CUSTOM</p>
        <h2 class="doc-title">{{ document.title }}</h2>
      </div>
      <div class="doc-metadata">
        <table class="metadata-table">
          <tbody>
            <tr>
              <td class="meta-label">No. Dokumen</td>
              <td class="meta-colon">:</td>
              <td class="meta-value">CST/{{ new Date().getFullYear() }}/{{ String(Math.floor(Math.random() * 1000)).padStart(4, '0') }}</td>
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

    <!-- Content Section -->
    <section class="section">
      <h3 class="section-title">ISI DOKUMEN</h3>
      
      <!-- Notes if provided -->
      <div v-if="document.notes" class="content-box">
        <p class="content-text">{{ document.notes }}</p>
      </div>

      <!-- Main Content Area with AI Enhancement if applicable -->
      <div v-if="document.content" class="ai-section professional-custom">
        <div class="ai-header">
          <div class="ai-badge">
            <svg class="ai-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M12 2L14.85 8.65L22 9.25L16.5 13.97L18.18 21L12 17.27L5.82 21L7.5 13.97L2 9.25L9.15 8.65L12 2Z" fill="currentColor"/>
            </svg>
            <span>AI GENERATED CONTENT</span>
          </div>
        </div>
        <div class="ai-content-wrapper">
          <div v-html="document.content" class="generated-content"></div>
        </div>
        <div class="ai-footer">
          * Konten ini disusun secara otomatis berdasarkan parameter kustom yang Anda berikan.
        </div>
      </div>
      
      <div v-else-if="!document.notes" class="content-box empty-state">
        <p>Konten dokumen kosong. Silakan tambahkan isi melalui formulir pembuatan.</p>
      </div>
    </section>

    <!-- Signatures Section (New Page Trigger) -->
    <section class="section" style="margin-top: 100px; page-break-before: always;">
      <h3 class="section-title">LEMBAR PENGESAHAN DAN PERSETUJUAN</h3>
      <div class="signature-grid">
        <div class="signature-slot">
          <p class="signature-label">Disiapkan Oleh,</p>
          <div class="signature-line"></div>
          <p class="signature-name">( ________________________ )</p>
          <p class="signature-title">Manager Operasional</p>
        </div>
        <div class="signature-slot">
          <p class="signature-label">Diperiksa Oleh,</p>
          <div class="signature-line"></div>
          <p class="signature-name">( ________________________ )</p>
          <p class="signature-title">Internal Auditor</p>
        </div>
        <div class="signature-slot">
          <p class="signature-label">Disetujui Oleh,</p>
          <div class="signature-line"></div>
          <p class="signature-name">( ________________________ )</p>
          <p class="signature-title">Direktur Utama</p>
        </div>
      </div>
      <div class="approval-stamp" style="margin-top: 40px; text-align: right; opacity: 0.1;">
        <div style="display: inline-block; border: 4px solid #000; padding: 10px; font-weight: bold; transform: rotate(-15deg);">
          APPROVED BY CORP HQ
        </div>
      </div>
    </section>

    <!-- Additional Sections can be added here -->
    <section class="section">
      <h3 class="section-title">INFORMASI TAMBAHAN</h3>
      <div class="placeholder-box">
        <p class="placeholder-text">
          Bagian ini dapat digunakan untuk informasi tambahan atau lampiran yang diperlukan.
        </p>
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
.custom-document {
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

/* Content Boxes */
.content-box {
  margin-bottom: 20px;
}

.content-text {
  font-size: 10pt;
  line-height: 1.8;
  color: #333;
  margin: 0;
  text-align: justify;
}

.generated-content {
  font-size: 10pt;
  line-height: 1.8;
  color: #333;
}

.generated-content p {
  margin: 0 0 10px 0;
  text-align: justify;
}

.generated-content h1,
.generated-content h2,
.generated-content h3 {
  font-weight: 700;
  color: #000;
  margin: 20px 0 10px 0;
}

.generated-content h1 {
  font-size: 13pt;
}

.generated-content h2 {
  font-size: 12pt;
}

.generated-content h3 {
  font-size: 11pt;
}

.generated-content ul,
.generated-content ol {
  margin: 10px 0;
  padding-left: 25px;
}

.generated-content li {
  margin-bottom: 5px;
}

.generated-content table {
  width: 100%;
  border-collapse: collapse;
  margin: 15px 0;
}

.generated-content table th,
.generated-content table td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}

.generated-content table th {
  background: #f5f5f5;
  font-weight: 700;
}

/* Placeholder */
.placeholder-box {
  padding: 30px;
  background: #fafafa;
  border: 2px dashed #ddd;
  text-align: center;
}

.placeholder-text {
  font-size: 10pt;
  color: #999;
  margin: 0;
  font-style: italic;
  line-height: 1.6;
}

/* Signature Grid */
.signature-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 40px;
  margin-top: 40px;
}

.signature-slot {
  text-align: center;
}

.signature-label {
  font-size: 10pt;
  margin-bottom: 60px;
}

.signature-line {
  border-bottom: 1px solid #000;
  width: 80%;
  margin: 0 auto 5px auto;
}

.signature-name {
  font-size: 10pt;
  font-weight: 700;
  margin: 0;
}

.signature-title {
  font-size: 9pt;
  color: #666;
  margin: 2px 0 0 0;
}

/* AI Section Professional Styles for Custom Document */
.professional-custom {
  margin-bottom: 30px;
  background: #fdfdfd;
  border: 1px solid #d1d5db;
  border-radius: 4px;
  page-break-inside: avoid;
}

.ai-header {
  padding: 12px 20px;
  background: #111827;
  display: flex;
  align-items: center;
  color: #fff;
}

.ai-badge {
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 700;
  font-size: 9pt;
  letter-spacing: 1px;
}

.ai-icon {
  width: 14px;
  height: 14px;
  color: #fbbf24;
}

.ai-content-wrapper {
  padding: 20px;
}

.ai-footer {
  padding: 8px 20px;
  background: #f9fafb;
  font-size: 8pt;
  color: #9ca3af;
  font-style: italic;
  border-top: 1px solid #e5e7eb;
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
  .custom-document {
    padding: 0;
  }
  
  .ai-header {
    background: #111827 !important;
    color: #fff !important;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
  }
  
  .placeholder-box {
    display: none;
  }
}

/* Dark Mode Override */
@media (prefers-color-scheme: dark) {
  .custom-document {
    background: #fff;
    color: #000;
  }
}

:global(.dark) .custom-document {
  background: #fff;
  color: #000;
}
</style>
