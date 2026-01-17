/**
 * Company API Controller
 * Handles all company-related API calls
 */

import { apiRequest } from './api'

export interface Company {
    id: number
    name: string
    address: string
    phone: string
    email: string
    logo_url: string | null
    created_at: string
}

export interface CompaniesResponse {
    data: Company[]
    total: number
    skip: number
    limit: number
}

export interface CompanyWithDocCount extends Company {
    document_count: number
}

/**
 * Fetch all companies
 */
export async function fetchCompanies(
    skip: number = 0,
    limit: number = 100
): Promise<CompaniesResponse> {
    return apiRequest<CompaniesResponse>(
        `/companies/?skip=${skip}&limit=${limit}`
    )
}

/**
 * Fetch companies with document count
 */
export async function fetchCompaniesWithCount(
    skip: number = 0,
    limit: number = 100
): Promise<{ data: CompanyWithDocCount[], total: number, skip: number, limit: number }> {
    return apiRequest(
        `/companies/?skip=${skip}&limit=${limit}&with_count=true`
    )
}

/**
 * Fetch a single company by ID
 */
export async function fetchCompanyById(companyId: number): Promise<Company> {
    return apiRequest<Company>(`/companies/${companyId}`)
}

/**
 * Fetch documents for a specific company
 */
export async function fetchCompanyDocuments(
    companyId: number,
    skip: number = 0,
    limit: number = 100
) {
    return apiRequest(`/companies/${companyId}/documents?skip=${skip}&limit=${limit}`)
}
