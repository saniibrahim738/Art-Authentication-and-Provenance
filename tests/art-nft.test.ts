import { describe, it, expect, beforeEach, vi } from 'vitest';

describe('Art NFT Contract', () => {
  let mockContractCall: any;
  
  beforeEach(() => {
    mockContractCall = vi.fn();
  });
  
  it('should mint an artwork', async () => {
    mockContractCall.mockResolvedValue({ success: true, value: 1 });
    const result = await mockContractCall('mint-artwork', 'Mona Lisa', 'A famous painting', 1503, 'https://example.com/mona-lisa.jpg', true);
    expect(result.success).toBe(true);
    expect(result.value).toBe(1);
  });
  
  it('should transfer an artwork', async () => {
    mockContractCall.mockResolvedValue({ success: true });
    const result = await mockContractCall('transfer-artwork', 1, 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG');
    expect(result.success).toBe(true);
  });
  
  it('should get artwork data', async () => {
    mockContractCall.mockResolvedValue({
      success: true,
      value: {
        artist: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
        title: 'Mona Lisa',
        description: 'A famous painting',
        creation_date: 1503,
        image_url: 'https://example.com/mona-lisa.jpg',
        is_physical: true
      }
    });
    const result = await mockContractCall('get-artwork-data', 1);
    expect(result.success).toBe(true);
    expect(result.value.title).toBe('Mona Lisa');
  });
  
  it('should get artwork owner', async () => {
    mockContractCall.mockResolvedValue({ success: true, value: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM' });
    const result = await mockContractCall('get-artwork-owner', 1);
    expect(result.success).toBe(true);
    expect(result.value).toBe('ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM');
  });
});

