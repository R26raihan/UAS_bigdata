<script setup lang="ts">
import { ref } from 'vue'
import BaseButton from './BaseButton.vue'

const loading = ref(false)

const simulateLoading = () => {
  loading.value = true
  setTimeout(() => {
    loading.value = false
  }, 2000)
}

const icons = {
  download: 'M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4M7 10l5 5 5-5M12 15V3',
  heart: 'M20.84 4.61a5.5 5.5 0 00-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 00-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 000-7.78z',
  star: 'M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z',
  send: 'M22 2L11 13M22 2l-7 20-4-9-9-4 20-7z',
  check: 'M20 6L9 17l-5-5',
  plus: 'M12 5v14M5 12h14',
  trash: 'M3 6h18M19 6v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6m3 0V4a2 2 0 012-2h4a2 2 0 012 2v2'
}
</script>

<template>
  <div class="demo-container">
    <div class="demo-header">
      <h1>🎨 Custom Button Component</h1>
      <p>Reusable button component dengan berbagai variant dan efek modern</p>
    </div>

    <!-- Variants -->
    <section class="demo-section">
      <h2>Button Variants</h2>
      <div class="button-grid">
        <BaseButton variant="primary">Primary Button</BaseButton>
        <BaseButton variant="gradient">Gradient Button</BaseButton>
        <BaseButton variant="glass">Glass Button</BaseButton>
        <BaseButton variant="secondary">Secondary Button</BaseButton>
        <BaseButton variant="outline">Outline Button</BaseButton>
        <BaseButton variant="ghost">Ghost Button</BaseButton>
        <BaseButton variant="danger">Danger Button</BaseButton>
        <BaseButton variant="success">Success Button</BaseButton>
      </div>
    </section>

    <!-- Sizes -->
    <section class="demo-section">
      <h2>Button Sizes</h2>
      <div class="button-grid">
        <BaseButton variant="primary" size="sm">Small</BaseButton>
        <BaseButton variant="primary" size="md">Medium</BaseButton>
        <BaseButton variant="primary" size="lg">Large</BaseButton>
        <BaseButton variant="primary" size="xl">Extra Large</BaseButton>
      </div>
    </section>

    <!-- With Icons -->
    <section class="demo-section">
      <h2>Buttons with Icons</h2>
      <div class="button-grid">
        <BaseButton variant="primary" :icon="icons.download" icon-position="left">
          Download
        </BaseButton>
        <BaseButton variant="gradient" :icon="icons.heart" icon-position="left">
          Like
        </BaseButton>
        <BaseButton variant="success" :icon="icons.check" icon-position="left">
          Confirm
        </BaseButton>
        <BaseButton variant="outline" :icon="icons.send" icon-position="right">
          Send Message
        </BaseButton>
        <BaseButton variant="secondary" :icon="icons.plus" icon-position="left">
          Add New
        </BaseButton>
        <BaseButton variant="danger" :icon="icons.trash" icon-position="left">
          Delete
        </BaseButton>
      </div>
    </section>

    <!-- Loading State -->
    <section class="demo-section">
      <h2>Loading State</h2>
      <div class="button-grid">
        <BaseButton variant="primary" :loading="loading" @click="simulateLoading">
          Click to Load
        </BaseButton>
        <BaseButton variant="gradient" :loading="true">
          Loading...
        </BaseButton>
        <BaseButton variant="success" :loading="true">
          Processing
        </BaseButton>
      </div>
    </section>

    <!-- Disabled State -->
    <section class="demo-section">
      <h2>Disabled State</h2>
      <div class="button-grid">
        <BaseButton variant="primary" :disabled="true">Disabled Primary</BaseButton>
        <BaseButton variant="gradient" :disabled="true">Disabled Gradient</BaseButton>
        <BaseButton variant="outline" :disabled="true">Disabled Outline</BaseButton>
      </div>
    </section>

    <!-- Rounded -->
    <section class="demo-section">
      <h2>Rounded Buttons</h2>
      <div class="button-grid">
        <BaseButton variant="primary" :rounded="true">Rounded Primary</BaseButton>
        <BaseButton variant="gradient" :rounded="true" :icon="icons.star">
          Rounded with Icon
        </BaseButton>
        <BaseButton variant="glass" :rounded="true">Rounded Glass</BaseButton>
      </div>
    </section>

    <!-- Full Width -->
    <section class="demo-section">
      <h2>Full Width Button</h2>
      <BaseButton variant="primary" :full-width="true" :icon="icons.send" icon-position="right">
        Full Width Button
      </BaseButton>
    </section>

    <!-- Usage Example -->
    <section class="demo-section code-section">
      <h2>📝 Cara Penggunaan</h2>
      <div class="code-block">
        <pre><code>&lt;script setup&gt;
import BaseButton from '@/components/BaseButton.vue'

const handleClick = () => {
  console.log('Button clicked!')
}
&lt;/script&gt;

&lt;template&gt;
  &lt;!-- Basic Usage --&gt;
  &lt;BaseButton variant="primary" @click="handleClick"&gt;
    Click Me
  &lt;/BaseButton&gt;

  &lt;!-- With Icon --&gt;
  &lt;BaseButton 
    variant="gradient" 
    :icon="iconPath"
    icon-position="left"
  &gt;
    Download
  &lt;/BaseButton&gt;

  &lt;!-- Loading State --&gt;
  &lt;BaseButton 
    variant="success" 
    :loading="isLoading"
  &gt;
    Submit
  &lt;/BaseButton&gt;

  &lt;!-- Full Width --&gt;
  &lt;BaseButton 
    variant="primary" 
    :full-width="true"
    size="lg"
  &gt;
    Sign In
  &lt;/BaseButton&gt;
&lt;/template&gt;</code></pre>
      </div>
    </section>

    <!-- Props Documentation -->
    <section class="demo-section">
      <h2>📚 Props Documentation</h2>
      <div class="props-table">
        <table>
          <thead>
            <tr>
              <th>Prop</th>
              <th>Type</th>
              <th>Default</th>
              <th>Description</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><code>variant</code></td>
              <td>String</td>
              <td>'primary'</td>
              <td>primary | gradient | glass | secondary | outline | ghost | danger | success</td>
            </tr>
            <tr>
              <td><code>size</code></td>
              <td>String</td>
              <td>'md'</td>
              <td>sm | md | lg | xl</td>
            </tr>
            <tr>
              <td><code>loading</code></td>
              <td>Boolean</td>
              <td>false</td>
              <td>Show loading spinner</td>
            </tr>
            <tr>
              <td><code>disabled</code></td>
              <td>Boolean</td>
              <td>false</td>
              <td>Disable button</td>
            </tr>
            <tr>
              <td><code>icon</code></td>
              <td>String</td>
              <td>-</td>
              <td>SVG path for icon</td>
            </tr>
            <tr>
              <td><code>iconPosition</code></td>
              <td>String</td>
              <td>'left'</td>
              <td>left | right</td>
            </tr>
            <tr>
              <td><code>fullWidth</code></td>
              <td>Boolean</td>
              <td>false</td>
              <td>Make button full width</td>
            </tr>
            <tr>
              <td><code>rounded</code></td>
              <td>Boolean</td>
              <td>false</td>
              <td>Fully rounded button</td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
  </div>
</template>

<style scoped>
.demo-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 3rem 2rem;
}

.demo-header {
  text-align: center;
  margin-bottom: 4rem;
}

.demo-header h1 {
  font-size: 3rem;
  font-weight: 800;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  margin-bottom: 1rem;
}

.demo-header p {
  font-size: 1.25rem;
  color: #64748b;
}

.demo-section {
  margin-bottom: 4rem;
  padding: 2rem;
  background: white;
  border-radius: 1rem;
  border: 1px solid #e2e8f0;
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
}

.demo-section h2 {
  font-size: 1.5rem;
  font-weight: 700;
  color: #1e293b;
  margin-bottom: 1.5rem;
  padding-bottom: 0.75rem;
  border-bottom: 2px solid #e2e8f0;
}

.button-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
  align-items: center;
}

.code-section {
  background: #1e293b;
}

.code-section h2 {
  color: white;
  border-bottom-color: #334155;
}

.code-block {
  background: #0f172a;
  border-radius: 0.5rem;
  padding: 1.5rem;
  overflow-x: auto;
}

.code-block pre {
  margin: 0;
  font-family: 'Monaco', 'Menlo', 'Courier New', monospace;
  font-size: 0.875rem;
  line-height: 1.6;
}

.code-block code {
  color: #e2e8f0;
}

.props-table {
  overflow-x: auto;
}

.props-table table {
  width: 100%;
  border-collapse: collapse;
}

.props-table th,
.props-table td {
  padding: 0.75rem 1rem;
  text-align: left;
  border-bottom: 1px solid #e2e8f0;
}

.props-table th {
  background: #f8fafc;
  font-weight: 600;
  color: #1e293b;
}

.props-table code {
  background: #f1f5f9;
  padding: 0.25rem 0.5rem;
  border-radius: 0.25rem;
  font-size: 0.875rem;
  color: #667eea;
  font-family: 'Monaco', 'Menlo', 'Courier New', monospace;
}

@media (max-width: 768px) {
  .demo-container {
    padding: 2rem 1rem;
  }
  
  .demo-header h1 {
    font-size: 2rem;
  }
  
  .button-grid {
    grid-template-columns: 1fr;
  }
}
</style>
