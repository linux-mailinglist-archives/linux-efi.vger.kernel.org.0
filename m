Return-Path: <linux-efi+bounces-1527-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E9943522
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2024 19:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B44B22B37
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2024 17:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D28922315;
	Wed, 31 Jul 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vt3MIITE"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13718AE4;
	Wed, 31 Jul 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447941; cv=fail; b=V6e+xnbT3fEOUNnpfzzSE0i6q2pdNaUCDCj2T6i1szJSfqnaTp7dVplmjLCvCbVOnjzRk+rFnunn3uJ1doWbvCA5SGmYJ/Ub+2ZqOaae/8pXf5J3fZwEuNOX6ucXhO7NunZ/FZ7QJRczRlkPKM6lHTV5+5q1VqfIsodynlfUUoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447941; c=relaxed/simple;
	bh=TGAyfWhGXRZP3lyahKwBNBCBmqHnybe5JzXnDEQB4P8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mq3jsa7gCratrwnSvIkArU5ZoUy7Eu5eUzQRI3ksSm/ySo5zflu+M3jA6O+c3ecQV87L22i1V/7TAujZ3qL+JLD8de9Pgl7TxVSw6d11YfY5cOCaCBSvqLuN2lHWvEdhUa/jNdxYbtPtYDjjBQ62X4D3SX3DMT74hBzYCy5LQqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vt3MIITE; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3PrG/kl1Iq05gvSgrVNtWbiNLwJapVeVJhoxEp/0IcbuIBrdC1cUzREmJ58QJQpEQjKX73V1Q/2R4q743ZWjXkbXG52iIkFhbcDfl6kEY5IvG9C3x1Zh1JP5TxTzalgUaSST8wo9UfMo6W9mbo4q1k15ol8wDF9TOT6tZ9FwjKLpFF+ezAwShJHbrNTf7kTcp2OkQDoiTqTZZYZuUDBbfzRE51Uy2aDm7cqbGIseAoQyvF5vScQV83t2P3t5UojFNE70vVBHvrlHoRXLVlMVfidi/emXLWZiRUsgbCS7Anb6vI3BxiajgSH+pPsqW9xYYPudA3SJdXj7Ew8LlarHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10DGx2ljruPtGcMuBh0KtB5Kg6LXwOYPpdvLh0DXv6M=;
 b=ireg97+EG3gA4okuzb6VqFJXPUP8RCbmEYQt+92YS3FQfQc4BhqAVL731PgIEAPOjxELtruNsg4T8SmqZwg7sODMXby1N7QmYNv1z1qPoMsCukTIiGs2RtrmlAdMbPvaumEuwDeFZQ3iLtqKy9xfonmJMCfQa4i2YDI5cKtxGgZQ4QxapVJ5i3yQzKqbp2vL7Ga2jJFp06539uXkxz50oi+3u/DPLW8Zali7OOpDZogzX64P0684PIikz4f8X+KLroGHKLXfL2U/9k8MGxFmBpVAqcAMS5kDXmvUMhPgsQnEQh9gBkMyfOJgkW+ArymIpxkwzyWQ1si8nG6/e4OnAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10DGx2ljruPtGcMuBh0KtB5Kg6LXwOYPpdvLh0DXv6M=;
 b=vt3MIITEdmBuZM+BOCAjVVvc9RuEyQ6AmmhvSxdJSOOhWuQM5VI+FBhbPR1utmfzfaN8OoAcqMxoBNkaxW0tuUtl8H8F5DimPk/PbcmJdrDORW/7Wv8VdE+SgvOAWjj1n3bp3DzyrtI3t12Ov3KW5d5pT4ImaZ3kZKJ5HLCgSb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 17:45:35 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%7]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 17:45:35 +0000
Message-ID: <5b031938-9c82-4f09-b5dc-c45bc7fe6e07@amd.com>
Date: Wed, 31 Jul 2024 23:15:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] x86: Make 5-level paging support unconditional for
 x86-64
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: ardb@kernel.org, bp@alien8.de, brijesh.singh@amd.com, corbet@lwn.net,
 dave.hansen@linux.intel.com, hpa@zytor.com, jan.kiszka@siemens.com,
 jgross@suse.com, kbingham@kernel.org, linux-doc@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 luto@kernel.org, michael.roth@amd.com, mingo@redhat.com,
 peterz@infradead.org, rick.p.edgecombe@intel.com, sandipan.das@amd.com,
 thomas.lendacky@amd.com, x86@kernel.org
References: <80734605-1926-4ac7-9c63-006fe3ea6b6a@amd.com>
 <87wml16hye.ffs@tglx>
 <jczq52e6vrluqobqzejakdo3mdxqiqohdzbwmq64uikrm2h52n@l2bgf4ir7pj6>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <jczq52e6vrluqobqzejakdo3mdxqiqohdzbwmq64uikrm2h52n@l2bgf4ir7pj6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::16) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 91172986-b226-4f26-b52d-08dcb18894f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enZ3VFZUYmw1Nmo0NXFzWE9UMkJvK0lwRFl4cS9hR3gyRlpJdXJra1ZuY05T?=
 =?utf-8?B?TWRlcG9aZTF1bmhHcElmWVZMQmFtZTkyaWppRGZhSXpHYWZ3cTZMVnJEQnB5?=
 =?utf-8?B?bENxNGlJYjBzOC94b1B5bCtoZk5HNldHYUMxeE5ReExwazh5MlUzVjhmQWk0?=
 =?utf-8?B?Kyt3S0FZU3FCOWpJbEtCaERkOVhycEFPeVdPL2JzdTRjdW96V1A3QWNLZlNW?=
 =?utf-8?B?VThEU0tkcGhrUFZlUGp3UXRaYW1EM0ltcU5GUmg5LzhOdEZ2TE0rYlNOUVk3?=
 =?utf-8?B?b0ljRUs2cE0yRWtTOTBqWWkrSC93WU1PbXRDR0JtWWxtWk0ycG01K0VETGM3?=
 =?utf-8?B?R1ByYVVXTi9DbmRNQUNZeHE2NzYxU3E1U2JKMkxoMk51Z2l3UVhIaUVpTWRr?=
 =?utf-8?B?a3p2bnBHV29oKzdIQmthWmhxZTdFVFV4R2FpVEk3YWdFOVY0TUloZk4vYVB3?=
 =?utf-8?B?ejgzUVdGZllvYWR5V3BPWkhZWk52OHlrOVJseXRvMEtwUHJFaWlKVmJlSEFH?=
 =?utf-8?B?TUJRZmdBSDdhWmdIdnJYK3hoa0VyZm1hOFIvT2ZjQXh5bFJUM3RnNlVXN1Bn?=
 =?utf-8?B?SEMzbENUajQ3QXkwUG04Wld4WUkrdzBaT3kwNnNZRXp0OE9kaUlVNnlVNmlX?=
 =?utf-8?B?RFJiNE5nYU5CNWpoS2k2WkpmTUJhNFFVVDdqZ092V1pNOFRHdnNKRC9Hdnk4?=
 =?utf-8?B?MXl2d2ltbzFpN241dHI4MUdUdlhTQXlMbFNXTGdhVWRIRmdSQXpqVEp6S01V?=
 =?utf-8?B?cENaU0hYU09DTWxlay9TUkJrMmRuY3lVVUtVb2l0Rlo4emdqMEpUbTZtdWda?=
 =?utf-8?B?NTduTS9IUmNqOHRLakdtNWNmYnFFSXlwK3BlR29LVjJoczBRMTZSb05nNGk0?=
 =?utf-8?B?NmxpTVRSRllvc0U4bjZQZ3JkUHIwclVNUnlHYnJFWjFoem5vVDhxNEllaDBn?=
 =?utf-8?B?MFJmNy9GRjhyQnV4L01MSlpEMS85L04xZzhIUmFiQm45SllKaksxMGd5ekl6?=
 =?utf-8?B?VGU1OThIQUhQRVJKd29VaWthMUg5V1N0a0FEQUkxRVc0dFhOL243WEh3TWNO?=
 =?utf-8?B?RW5kNVo1SjVHb1dDNVQyYlpUaE83RjZ2NGdScGFUMEZtRVplazB3eENEVFpQ?=
 =?utf-8?B?ZjNYMXA5Rk90VXhlWE5GQVFlWUJrS1FUMXhkK21iL2EvSitaRFJwT21xRm1D?=
 =?utf-8?B?SmJlTEFmbWRsTVdJOWVVWXRtd1Vnb0FmM3NzNXl5Uy9lWG5NeDl4RTlVSHpl?=
 =?utf-8?B?Q29wa2VvaHVNQnBMWUpDQjVWQkRVSWw0NHpVNUwwVzBOdEIzeDFoai9HVUdo?=
 =?utf-8?B?ME1rdkZzWDFIZDlaNEczeWllL3RYaU9KZ0QrcGx5M2lsSW9hT2srRmRFN1hY?=
 =?utf-8?B?MFdNY0RHMDhxQm45azdzV3pyTXcxNXNuWEFSOFBpWGFKeWNINVZmeGJ4WDVM?=
 =?utf-8?B?bHNxUkNqOGprbVBRd2NVeCt2L0FxYmkxUUZudW1wMS91Z3UwQTYrWmRIakly?=
 =?utf-8?B?dUxkeW9sWHZjaFMxNlNoUHFTaWhWMUZrY3o3U0N4YUNxYW9maWd1d20xQzFk?=
 =?utf-8?B?amJLcnI3WFNUdFlvMnNLdzZ3L3VnajJPb1BqRzBFQ243K2wxSFQ3TXJUUGdm?=
 =?utf-8?B?eHFtTWZUVGtYNkxjanVYM2QvMGdNWUdPcUhPdkNpWTMzZExmajdaTWtJNS94?=
 =?utf-8?B?d1FqelhTN0VYS3JheUxrWGpmSGkvWWQ1OTVKVmJjK0k1emJrVzc1aW9PUTBE?=
 =?utf-8?Q?zPIpejhd75jSwMaxcA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bi9PUlY5NUgrZnFPcEorajFMQWhuRkRJb1NuM1A5b1NaT0lqUXVvQVdIS1hw?=
 =?utf-8?B?VnFRZ2xnWkRZUjRkOHhNRGp6MmdrS0NKckRLRWlCRUxhYUlYVHJWb1BKcFph?=
 =?utf-8?B?b041MXl0Z3BPRkRJTEh3TGoybzdxangwSFNya1psM0RENGlaZ0RnQlRmV1Nv?=
 =?utf-8?B?aDhPOFZoRm5uaEkrSjZJQ3kzSkJvTFBXMnA0TmFiZ01kemNXMXg1Y1Vuajg2?=
 =?utf-8?B?KzZjc3p3aExGc080VlIrTDdNUC9oaENDWUtEVlU4MU1LT1hodGxMNnN6d1Jj?=
 =?utf-8?B?Z2d5VzFQaHpaQ3pmVjRwUnVydHBLTGFWayswejhEaHRPdDJndnpsajYrU0N6?=
 =?utf-8?B?YzRzL0pMZUE5ajF5UWdkOWlKMUdFUkRsTkFmOVVRUnczU0VwUExCeHRnQXNt?=
 =?utf-8?B?ZUZ0TVlJVnZsZU5tdlZjR1krblBxOGNRVzJGMUlWcmFNYXVHcFgxZ1VLMEQz?=
 =?utf-8?B?UGd0d21OeERsMDJiejZJUkNBMVBPdzN2U3QwYjJYMzBneE1ybEJ3S2pKaTZI?=
 =?utf-8?B?U29oMmZyV3pUV0lvNHljMXUwTTczZzArT2wxNHF2OHdaa1VGeFdvc0tQMGlC?=
 =?utf-8?B?UFIwb2FxeHFuZFhOTzJadlVQV3RiMTVpQU9sTTlaTWFaak90ZVZYazBwcjl3?=
 =?utf-8?B?Vk5vN1c0endudTRjV1VJLzlSSEEyaE5Xb01WYWZxSFhvWndyNTAzRVYvL1lN?=
 =?utf-8?B?MUVEZkVLenZtTEZ6KzdBakZLNGEwMEROaWdxZnVOeGx6d0FPcjRQaURkYzIw?=
 =?utf-8?B?d212aWU1RVYxN0ZwcHVIYzVXaENMTG1pcGZPM2t0RmREcUtSSEJqNDlOV2Vt?=
 =?utf-8?B?WGFYUXhuQStSKy9WWlNRd3lQMU1XVlcwV3hjclpQT2NQSHdzNFA0Q3h5NURZ?=
 =?utf-8?B?KzJGOWNYM0p3emtVdDZ4ZFZNd281azJiRkd0SzdrNnlNMmwvL2xzWkw5bDhX?=
 =?utf-8?B?UzNrTmEwMmcwTHYxSjV4WDRiL2ZqUWJRdmswUzJxY0paMWlaWmVBY1JraFBK?=
 =?utf-8?B?aXVRaUVEYXJOamo3eDNXb0hZK2FpK0VNdVFva1Y0ZG1JWU9zaHFDWFNYN1V2?=
 =?utf-8?B?RUJxWTdoSm1Fc2hGRmM5bS9oQ0JXeFU3RVJ0Unc4TnNENDh2UHpSUzMzMk10?=
 =?utf-8?B?SElEeDR6b1hTWWZZWHRtOVBOSndlMnlSRnhneUZlczdEbWlGVnZ5Z2lYM1BX?=
 =?utf-8?B?cm9PZk9uTUJMMGZjTWc2anhkcDJHZkN4eDJmSWx3MG1ReTJKd0luWGlKYmxZ?=
 =?utf-8?B?c1dUbW5qTEg3cWYwemZIRVFKdGlNQnFRSlV3Y3AxQWIyRDNQZUM0Z2ZSTVN5?=
 =?utf-8?B?MVdIM3Y3WG43Y1RNb0ZUYWtLM1ozQVRtTVlkTzNHQTVWTUtoZzZOMFJPTXh0?=
 =?utf-8?B?LzQvbUh6cUM5SXFScENFaHR0UCtUYXRqTGNzUXZKNGl6ek5lS1R2azlmTG9n?=
 =?utf-8?B?dU93dFlwdXpCUVlMakJMb3hGOUtlZm5xR3FLQ3BRQlhsS2pyWG5xei9VTklL?=
 =?utf-8?B?Ykp3ZWIwbVA3bmxHOEpLYVQzbnhyYmxNei9LYnorZ3h0V3ZndmNJdWlYUFVB?=
 =?utf-8?B?NGc2YmlySlZDd3kzc2Jydm5jK0pFdStBcVpPcjJHNGdPY3hXZStFQ0xZS3li?=
 =?utf-8?B?dnMyclFObG9qMVBzMlBkSmJ6Qkk5R05wbFVrRUZ1ck9nc2pTZUhLQ0xVSy9Y?=
 =?utf-8?B?WFM3bUMzY3FsT2M1T3ovcmdmQlMzSi9OUVVBbGplaXhPbG5ZZzdsWE1vcmhR?=
 =?utf-8?B?aS80SmVNWk04VVJzbWdnYVZqTE1SdTZHSzJHMXhRa0dhcTBQVDhSd0RndXI1?=
 =?utf-8?B?TzlrZVZkeXFOdE5NdEFxMGx6MldiWmxtOHhXSmwyN0xHY3dNcUZzK1ZiZHdi?=
 =?utf-8?B?Vko3QUZUZ2hDV3ZCbTMwVHNMSHQwNzYrZlN2dHpjeVFDN0tzQnQzWis1WGdM?=
 =?utf-8?B?V2FkTGxUaXRYL2Q0bTArL3RLS1N4U2NtdFRFU0J2VkVhV3VEamphU0FTYm5t?=
 =?utf-8?B?dExXY3FDSE5IVFJEeWFqQkZUV1JmNnhja3pnK1krWEEwS3Q0anZiQ0s3bzMw?=
 =?utf-8?B?NXozOUduSldRM3RRRVV4cW9CYUNUa29TV2xKYlY3WjRmUFVha3FwdDZHNXgv?=
 =?utf-8?Q?cXkvKoYWJntFDQuoFE0KOQsHc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91172986-b226-4f26-b52d-08dcb18894f2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 17:45:35.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muTiIJMu6YLHrrrK3FCf5Wyr2cUYvX/kUD52LlXEfwgTunCi/Rm6HWH+hHA2MD0X8W1+5rN9iVj8RUgDRxSfGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

On 7/31/2024 5:06 PM, Kirill A. Shutemov wrote:
> On Wed, Jul 31, 2024 at 11:15:05AM +0200, Thomas Gleixner wrote:
>> On Wed, Jul 31 2024 at 14:27, Shivank Garg wrote:
>>> lmbench:lat_pagefault: Metric- page-fault time (us) - Lower is better
>>>                 4-Level PT              5-Level PT		% Change
>>> THP-never       Mean:0.4068             Mean:0.4294		5.56
>>>                 95% CI:0.4057-0.4078    95% CI:0.4287-0.4302
>>>
>>> THP-Always      Mean: 0.4061            Mean: 0.4288		% Change
>>>                 95% CI: 0.4051-0.4071   95% CI: 0.4281-0.4295	5.59
>>>
>>> Inference:
>>> 5-level page table shows increase in page-fault latency but it does
>>> not significantly impact other benchmarks.
>>
>> 5% regression on lmbench is a NONO.
> 
> Yeah, that's a biggy.
> 
> In our testing (on Intel HW) we didn't see any significant difference
> between 4- and 5-level paging. But we were focused on TLB fill latency.
> In both bare metal and in VMs. Maybe something wrong in the fault path?
> 
> It requires a closer look.
> 
> Shivank, could you share how you run lat_pagefault? What file size? How
> parallel you run it?...

Hi Kirill,

I got lmbench from here:
https://github.com/foss-for-synopsys-dwc-arc-processors/lmbench/blob/master/src/lat_pagefault.c

and using this command:
numactl --membind=1 --cpunodebind=1 bin/x86_64-linux-gnu/lat_pagefault -N 100 1GB_dev_urandom_file

> 
> It would also be nice to get perf traces. Maybe it is purely SW issue.
> 

4-level-page-table:
      - 52.31% benchmark
         - 49.52% asm_exc_page_fault
            - 49.35% exc_page_fault
               - 48.36% do_user_addr_fault
                  - 46.15% handle_mm_fault
                     - 44.59% __handle_mm_fault
                        - 42.95% do_fault
                           - 40.89% filemap_map_pages
                              - 28.30% set_pte_range
                                 - 23.70% folio_add_file_rmap_ptes
                                    - 14.30% __lruvec_stat_mod_folio
                                       - 10.12% __mod_lruvec_state
                                          - 5.70% __mod_memcg_lruvec_state
                                               0.60% cgroup_rstat_updated
                                            1.06% __mod_node_page_state
                                      2.84% __rcu_read_unlock
                                      0.76% srso_alias_safe_ret
                                   0.84% set_ptes.isra.0
                              - 5.48% next_uptodate_folio
                                 - 1.19% xas_find
                                      0.96% xas_load
                                1.00% set_ptes.isra.0
                    1.22% lock_vma_under_rcu


5-level-page-table:
      - 52.75% benchmark
         - 50.04% asm_exc_page_fault
            - 49.90% exc_page_fault
               - 48.91% do_user_addr_fault
                  - 46.74% handle_mm_fault
                     - 45.27% __handle_mm_fault
                        - 43.30% do_fault
                           - 41.58% filemap_map_pages
                              - 28.04% set_pte_range
                                 - 22.77% folio_add_file_rmap_ptes
                                    - 17.74% __lruvec_stat_mod_folio
                                       - 10.89% __mod_lruvec_state
                                          - 5.97% __mod_memcg_lruvec_state
                                               1.94% cgroup_rstat_updated
                                            1.09% __mod_node_page_state
                                         0.56% __mod_node_page_state
                                      2.28% __rcu_read_unlock
                                   1.08% set_ptes.isra.0
                              - 5.94% next_uptodate_folio
                                 - 1.13% xas_find
                                      0.99% xas_load
                                1.13% srso_alias_safe_ret
                                0.52% set_ptes.isra.0
                    1.16% lock_vma_under_rcu

>> 5-level page tables add a cost in every hardware page table walk. That's
>> a matter of fact and there is absolutely no reason to inflict this cost
>> on everyone.
>>
>> The solution to this to make the 5-level mechanics smarter by evaluating
>> whether the machine has enough memory to require 5-level tables and
>> select the depth at boot time.
> 
> Let's understand the reason first.

Sure, please let me know how can I help in this debug.

Thanks,
Shivank

> 
> The risk with your proposal is that 5-level paging will not get any
> testing and rot over time.
> 
> I would like to keep it on, if possible.
> 


