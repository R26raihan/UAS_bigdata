/**
 * AI Generation API Controller
 * Handles AI narrative generation requests
 */

import { apiRequest } from './api'

export interface AIGenerateRequest {
    document_id: number
}

export interface AIGenerateResponse {
    intro: string
    analysis: string
    conclusion: string
}

/**
 * Generate financial narrative
 */
export async function generateFinancialNarrative(
    documentId: number
): Promise<AIGenerateResponse> {
    return apiRequest<AIGenerateResponse>(`/ai/generate/financial/${documentId}`, {
        method: 'POST',
    })
}

/**
 * Generate operational narrative
 */
export async function generateOperationalNarrative(
    documentId: number
): Promise<AIGenerateResponse> {
    return apiRequest<AIGenerateResponse>(`/ai/generate/operational/${documentId}`, {
        method: 'POST',
    })
}

/**
 * Generate management narrative
 */
export async function generateManagementNarrative(
    documentId: number
): Promise<AIGenerateResponse> {
    return apiRequest<AIGenerateResponse>(`/ai/generate/management/${documentId}`, {
        method: 'POST',
    })
}

/**
 * Get AI models status
 */
export async function getAIModelsStatus(): Promise<any> {
    return apiRequest('/ai/models/status')
}
