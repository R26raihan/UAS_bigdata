/**
 * Document API Controller
 * Handles all document-related API calls
 */

import { apiRequest } from './api'

export interface FinancialData {
    summary?: {
        revenue: number
        revenue_last_year: number
        expenses: number
        expenses_last_year: number
        net_profit: number
        net_profit_last_year: number
        profit_margin: number
        profit_margin_last_year: number
        revenue_growth?: number
        profit_growth?: number
    }
    breakdowns?: Array<{
        category: string
        amount: number
        previous_amount?: number
        percentage?: number
        type: 'revenue' | 'expense'
    }>
    cash_flow?: {
        operating_cash: number
        investing_cash: number
        financing_cash: number
        beginning_cash: number
        ending_cash: number
        net_change?: number
    }
    trends?: Array<{
        period_label: string
        revenue: number
        profit: number
    }>
    balance_sheet?: any
    ratios?: any
}

export interface Document {
    id: number
    company_id: number
    document_number: string
    type: 'financial' | 'operational' | 'management' | 'custom'
    title: string
    period: string
    date: string
    notes: string | null
    created_at: string
    content?: any // For AI Narratives
    companyName?: string
    financial_data?: FinancialData
    operational_data?: any
    management_data?: any
}

export interface DocumentsResponse {
    documents: Document[]
    total: number
}

/**
 * Fetch all documents
 */
export async function fetchDocuments(
    skip: number = 0,
    limit: number = 100
): Promise<DocumentsResponse> {
    const response = await apiRequest<{ total: number, data: Document[] }>(
        `/documents/?skip=${skip}&limit=${limit}`
    )
    return {
        documents: response.data,
        total: response.total
    }
}

/**
 * Fetch documents by type
 */
export async function fetchDocumentsByType(
    type: string,
    skip: number = 0,
    limit: number = 100
): Promise<DocumentsResponse> {
    const response = await apiRequest<{ total: number, data: Document[] }>(
        `/documents/type/${type}?skip=${skip}&limit=${limit}`
    )
    return {
        documents: response.data,
        total: response.total
    }
}

/**
 * Fetch a single document by ID
 */
export async function fetchDocumentById(documentId: number): Promise<Document> {
    const response = await apiRequest<{
        document: Document,
        company_name?: string,
        financial_data?: any,
        operational_data?: any,
        management_data?: any
    }>(`/documents/${documentId}`)

    return {
        ...response.document,
        companyName: response.company_name,
        financial_data: response.financial_data,
        operational_data: response.operational_data,
        management_data: response.management_data
    }
}

/**
 * Create a new document
 */
export async function createDocument(documentData: Partial<Document>): Promise<Document> {
    return apiRequest<Document>('/documents/', {
        method: 'POST',
        body: JSON.stringify(documentData),
    })
}

/**
 * Update a document
 */
export async function updateDocument(
    documentId: number,
    documentData: Partial<Document>
): Promise<Document> {
    return apiRequest<Document>(`/documents/${documentId}`, {
        method: 'PUT',
        body: JSON.stringify(documentData),
    })
}

/**
 * Delete a document
 */
export async function deleteDocument(documentId: number): Promise<void> {
    return apiRequest<void>(`/documents/${documentId}`, {
        method: 'DELETE',
    })
}
// No need for duplicate AI narrative generation functions here as they are in aiController.ts

// No need for a separate export block as functions are exported inline
export { API_BASE_URL } from './api'
