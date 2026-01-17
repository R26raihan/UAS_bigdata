/**
 * API Configuration
 * Centralized API base URL and common configurations
 */

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://192.168.1.12:8000/api/v1'

/**
 * Generic API request handler with error handling
 */
async function apiRequest<T>(
    endpoint: string,
    options: RequestInit = {}
): Promise<T> {
    const url = `${API_BASE_URL}${endpoint}`

    try {
        const response = await fetch(url, {
            headers: {
                'Content-Type': 'application/json',
                ...options.headers,
            },
            ...options,
        })

        if (!response.ok) {
            throw new Error(`API Error: ${response.status} ${response.statusText}`)
        }

        return await response.json()
    } catch (error) {
        console.error(`API Request failed for ${endpoint}:`, error)
        throw error
    }
}

export { API_BASE_URL, apiRequest }
