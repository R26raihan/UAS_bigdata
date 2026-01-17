/**
 * Quarterly Coverage API Controller
 * Handles quarterly data coverage monitoring
 */

import { apiRequest } from './api'

export interface QuarterlyCoverageSummary {
    company_id: number
    company_name: string
    total_quarters: number
    existing_quarters: number
    missing_quarters: number
    coverage_percentage: number
    status: 'complete' | 'incomplete'
}

export interface QuarterlyCoverageDetail {
    company_id: number
    coverage: {
        [year: string]: {
            [quarter: string]: {
                exists: boolean
                documents: Array<{
                    id: number
                    document_number: string
                    type: string
                    title: string
                    period: string
                    date: string
                }>
            }
        }
    }
    statistics: {
        total_quarters: number
        existing_quarters: number
        missing_quarters_count: number
        coverage_percentage: number
        missing_quarters: string[]
    }
}

/**
 * Get quarterly coverage summary for all companies
 */
export async function fetchQuarterlyCoverageSummary(): Promise<QuarterlyCoverageSummary[]> {
    return apiRequest<QuarterlyCoverageSummary[]>('/companies/quarterly-coverage/summary')
}

/**
 * Get quarterly coverage detail for a specific company
 */
export async function fetchQuarterlyCoverageDetail(
    companyId: number
): Promise<QuarterlyCoverageDetail> {
    return apiRequest<QuarterlyCoverageDetail>(`/companies/${companyId}/quarterly-coverage`)
}

/**
 * Get quarterly coverage by document type
 */
export async function fetchQuarterlyCoverageByType(
    companyId: number,
    docType: 'financial' | 'operational' | 'management'
): Promise<any> {
    return apiRequest(`/companies/${companyId}/quarterly-coverage/by-type?doc_type=${docType}`)
}
