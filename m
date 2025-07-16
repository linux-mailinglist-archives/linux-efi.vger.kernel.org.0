Return-Path: <linux-efi+bounces-4389-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8E2B07B90
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A8D7A5358
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B99E2F547F;
	Wed, 16 Jul 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RmALGIE+"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3DD2F5C24;
	Wed, 16 Jul 2025 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684759; cv=fail; b=oQRmqyDqEsI91Vf2Ud60cShM2mfDsdrMlI6mbtTJzGqmr02MbnffG6kASUzq4YKy52+ENHFPL7iCGdFTj8SmwfSuihW2Cv8wEWlEfMSYJ1CvBI2acsEz5qBkxZtpCPht/TJcQpQTlvR54LW/0VM2IgSdQmwdlpT1YWNYIL8Xgko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684759; c=relaxed/simple;
	bh=s/GxeAGSz2VrbeVqJ8M2fpwdvPqTmMmHO6Nx8Ev1cQo=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=UR69DpcERsoufRe/MF3Pq4JnmwmB4i2gzQgNF3Zbtp4jPWjO8U5VwpVigp1sC22xFmg46rAdY69iYs5hodF120Fr6uEfwlnYOlwCSwjInTteAjI1vuY66VXEMV0q/JeK3RIAY9YGsAtem/6wt7zGu03JGBvBPaj+xfIkkt2eYUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RmALGIE+; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/YFAnXpAbNxxv63uD5eUujOP7120ZDLjpd9aAcXS9lsDx1mYe9CRZLXgqBsSRRhb9stpKXBWMJR8WGCWVdnFI89AlQFfuNKP15rwv2RFupbKieGigz2HUURLOKJEjoUs9+we8uxP+PCoh7lNG3fAOUpMIDvwPqSkX+cxZj3env2L3Rjz0di6M4ooSUyFOd8jYppxB1ZpxA3BuSOmrlZ8O2cZN643HKzJqWIikR7IvRdIhK4wGKS68yNcYl8hEuggtzOV8+h018OzAwiYOtm2EeCZ51A8cb/hpn03TBuQX40GreYdy/7/a+fTyTSu2ZqqjeyQ95sbDMKhr+eSNKCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLtJ1U0oZ98SvvWeP25U68yuS6jfh4+PCa7Qh4DP3jc=;
 b=LVQBeoGQU1cm6fae4Lyu1YR9LPf0juy3nkYHJwvKaH7L4WB1r9gajlWV47pJZMKKWJZvqktNoTw8beXZq7W+qlcu03MZjFmgB6gbdJRIuFdKIU62pgpcnD0LZ3qzYXztQ8ol69GGup6LX9VcS7wDwIM/cRc/hAtO/8jGOvSqwNRgEmkMCV+G5Dt4mdbIOWi69JUpHd3onbuW5nb7c0zT06NKmDqtROwuvbKGmuZqYtf4VuZ6SC9SJ8hyuT/Ic4FqqsXg157SznNO5LDPdxKO0yaAUbZWqEFCrXX2a3mA46hTK9zp/F8Vo+cVKhlhA8u3D+6Ez4lZMf5lEnK52DXXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLtJ1U0oZ98SvvWeP25U68yuS6jfh4+PCa7Qh4DP3jc=;
 b=RmALGIE+tM70DDpbT8GKfcsl/Sy1+O2q4LTVTApPgS5JpJwQSgiC9KOrSBJU+xdHYOB4/TP1PxLciHh27Ul835cEADykyYOkFRJBM3cRyOTWLxm5p+JtXVhu6MpARWvPuWkjZpj8QdxfnNXDwaDQuG/XpOd2DD0GOJ5SywgTb6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 16 Jul
 2025 16:52:31 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8922.035; Wed, 16 Jul 2025
 16:52:31 +0000
Message-ID: <93f9ea0e-acfa-076d-ee39-42b7582675a3@amd.com>
Date: Wed, 16 Jul 2025 11:52:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nikunj A Dadhania <nikunj@amd.com>
References: <20250716031814.2096113-24-ardb+git@google.com>
 <20250716031814.2096113-25-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v5 01/22] x86/sev: Separate MSR and GHCB based snp_cpuid()
 via a callback
In-Reply-To: <20250716031814.2096113-25-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::18) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: e2986ccb-0923-44ad-3d60-08ddc4892784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2dTeGZ2QnhLcVU3dGM2TmZldXBkSklwR21xOE9LQmxXYlFZb3RaN3Bxd3Fy?=
 =?utf-8?B?RjUyeE8zeVpvREs5c09zNmFEZ0FNUWxJaUYrWXJSNFNOMEZiMWsvVktEVGxK?=
 =?utf-8?B?c2JsZFErbEd3UVV6STdCRDQvZkw1SjV6SHZ0dHhSTXdvNWkwRmFqejNPZnU1?=
 =?utf-8?B?a3phcUx6OEFJZEVnR2VKNFhSVU9ZQTFVTXRwZmpQdTB5STFtWWp1OHluSnIy?=
 =?utf-8?B?aGVUbU9CeHFmaXpHenc3WC9OVUxneGxESThZYi9INGJMdUljZ2pLUXlkei9K?=
 =?utf-8?B?MHlya0RHRlUwOGFVWFJlRU1JcUZQL2ExclI5blhHcXNrODQ5YmFSZDIrWTZn?=
 =?utf-8?B?NWc0eVltbHgramV1QlFrczRBelIwbnFzOFdOQWpkYmV3QmFJUGpqUk42SzJB?=
 =?utf-8?B?Sm44dTZPN0NwbzgyYzgzeTlDcEdiMVUyVUlQV2tjYmtkLytGdTlwL0REU0d2?=
 =?utf-8?B?WE5tNjdBNnZHeVJiT0FkU3hsOG96OTFrRVF3MHptZFMxbGZ5TUx3YzVrMzN4?=
 =?utf-8?B?OGxmcVN6d1BMa1Bvc0tnVzl3OTd3RXBQSE5ya0NpOVVaMlpSdHZ4ZWUvMEYv?=
 =?utf-8?B?NVJuNzl2R2RyUG9UVmQvWFkwd0R1ekx3YVBTbnRBZ1JHcldWYlowaVdOSUVw?=
 =?utf-8?B?eHp2V0hDemxUWnB4OTJFM29qd2cvQSszWnJ2ZFBKWTByY2dCR3FMR2pqWDBw?=
 =?utf-8?B?aEN0a3lCQ2dLdUtQcFZrYlZFVmtMZzEwQ3o3RW8reEgxZzJqRHVwN1pSVWdN?=
 =?utf-8?B?WXNSVm1QdnByMHBEcmt0OXAzNnJIb25VbkZQa1ducUtXQTdyVG5DWkFUYXZX?=
 =?utf-8?B?UElYa2pEb1FBTlZpaUU4MzFUVUN1VVo0cnc5OVJ1M3lXT2dnUmo4Vk1ZdjV3?=
 =?utf-8?B?SFBTTEVpckwwWVNXRTF3YWlIMEdGS21FS1BzTmszTHJ1aFdmZ1o4SEZwWnp1?=
 =?utf-8?B?WDEzaGNTQTBTaFVRNmpZUFpiRUx2V1ZpNXptRjJiSVlFQ016K2pXRm8yQUMr?=
 =?utf-8?B?U010MlI0cWNyZDRGSEhBRFU5M2Zacnp5K3R1dytZQTJOdFgxNkc2bzhYbjZu?=
 =?utf-8?B?NGhRYkdINkZGa2plZFRKc1JUU0dVTWY4VVVjUmdRc1FTZlNBa3B4UHFPQXEx?=
 =?utf-8?B?cXRKQTlRTy9peFl0cmlmbzhRekkxTTRRdVdQS0RqRUExOTZhTUNlRE54cGdm?=
 =?utf-8?B?dWl6QzN3Z0poTHh6Z2QxWU9LakczK2FHank4SkRtQW5sc1FuZlRuVzYveUtw?=
 =?utf-8?B?cDI1TVRNVXYwUzYrVk0zQWlXNlBxWnR6WXVZbjBYSXNWcVg5WkhSVzdWd1Ir?=
 =?utf-8?B?VWQwU2dDRmo1NlNmTWUzZENTbG5aNCsvbThJZnVtYWUvelZoL05xaXpzMzFP?=
 =?utf-8?B?dC9VQzBmdlk5Z0VySFZ2Q01mbmFkMTRWcnhMNU82aGI5MmNyWlJLTUtQTll0?=
 =?utf-8?B?NDBENTlUc1BZOFRRY0tvUksyMzAxMUJhblNhRkduY3hIOFZ4dHE2bUhMTHdE?=
 =?utf-8?B?c0dRQnhLQ0hMTVRwejJYMnR0T25MRGp2SXg0aEtvYWVkelJIcVFVWkJDQmg3?=
 =?utf-8?B?N1BjNTllTXJ5WHhPMjc4NC9BWURWZzRHeVJha1RtRVFrZkxDbmdZSHVOTE9z?=
 =?utf-8?B?VWNBL0cvWjlpWkRVYm85ZVl3MUtJdzVkemFhTjN5a1ZhbzhFZVk2WUpUdTZX?=
 =?utf-8?B?a0JZLzZITno5dkZiLzFieGJuOVVDcjQzZlZONkQxWFpnOGlwN2VuR2NXTE9x?=
 =?utf-8?B?eUpPcG9vS3RJZEV2Q0hOcUlGOHNmTUtZVWl0Y3AxRWE5VUIzWFRRZmFsUGJs?=
 =?utf-8?B?T3dtaFFQdHpVQ1E2UU4wUFJZSDJEaElXeTk2dkwwMXRRTGhvR2RoUkNiYTBk?=
 =?utf-8?B?Y1ZpOTlYeERUcm50K05WRkkrOVlBYTNINDE2N2xuNUFpYXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzI3eHdZT0R4aDlWMENvaitBYkRHUHJEVExMenJOL2d0Z01tVFJuZVpaUnFq?=
 =?utf-8?B?WHRwWHkvaWtWeXBPM3dPcmtMOFl0akk4eVZmazBUeG1JSDVXaVhoUWVCbEpT?=
 =?utf-8?B?VUVnRzZLcHFQakFCb0c1K3FWRHd5VS9RVURkeE15YzRxSEhPOGQ3Z3RiaGFl?=
 =?utf-8?B?ZkU3TVNMVDVYb1JpK2EzR0V6MU1GQnBGV2QrTDFmWHFmM3lhdndXZnpFM2Iy?=
 =?utf-8?B?VUFxeEJkcDEydER4RStqWmVzVVRWeGZPeTEvam9aellySGtHYkhLYW5SMlVM?=
 =?utf-8?B?aS9RbjdBQjlLdmxET1ZvS1hLaE1kZno1VzdXQStra2hxT3plbmZQdXRadnR1?=
 =?utf-8?B?MVkwR1gyekFFWEVvVE1naExSS1NCU0Zpb3dLODhjSUsvUHVkWnYxcXM4WVR0?=
 =?utf-8?B?Q1I0UnJXQVJFRkNQZmZuckJnSXExUXJpWGw3Z3hISm5Demd5VE1Vb3ZyQ09D?=
 =?utf-8?B?Ny9YZEtSeGc3b1R3MFQyYnJBUWlPK0REZGQ0dWIxYkZGRENOQlQyY3h3bVFG?=
 =?utf-8?B?TDk1cjIyRUFjeEIzaFJDMUUrTWJ0cjRYd1NIcTVRWVZHNk4vNXhEQm14TDV1?=
 =?utf-8?B?RXAvTk4vYmwvaTZOZWUrZ0hiMzMwWTdWTU9WUUovNER3UC9hd3dSSUdsclpF?=
 =?utf-8?B?ZlFNV2toL2xOQ3RCTXRDZW82OGNKNjkyTWc5WXFORnpIc2J3YzNSV1Q2ZWtn?=
 =?utf-8?B?S25wemNLL2pZSmloY25QcGxFWCtFSzFnYmZma25TMm1aRmhwYWhQeXVUVlBw?=
 =?utf-8?B?QWNhUnhpOFRBT0pMSzRoU2dmMWl2bW9LNlhldjU1U3FqbXVJOGQ3Y2h2eW00?=
 =?utf-8?B?RWxINEZXamZTYldBRVJNMlJqN2lWcHdNbkhaSGlNMVJFSnlQNWFQY0xMRCtx?=
 =?utf-8?B?UmgxSi94cmtXUXVVUFBYYjhEZkdUTjhVSUVYWVVSZHIyY2ZiU3BGZ0sxSHN0?=
 =?utf-8?B?SGw3YkU1SnFmSy9HblBJbmNIc2xSUnFIRlB3SEhXN3hUbGRjMElJREYvWGEz?=
 =?utf-8?B?VGM2bTJhRk9wN08vT2hOSjhqYVk1czF4K1p1ZUVPZDNGUkZYanlodkV4Q1ZV?=
 =?utf-8?B?WmVlZm5wa3RFcnl5NDY3V1lDbXVpczVodWQzeG02dThzOUtVQXdKaytoU3Vm?=
 =?utf-8?B?cis3SU80YS91Z25WMkRRYWE2MlBhWnEyZ0ZVcEVscS9DTUl0U1B1R2d5TXZ5?=
 =?utf-8?B?cnBqdXlxYzZXMHBqNGVnRjBnaWE4T0pCaHRJOVQ1UkdsT0tSTkpLV1hSVDJX?=
 =?utf-8?B?Ykhxa1JEZHUyNXFnME03QVNtMVFQell5T01uVlhhRHNHRzFPOEFPaFduOFhl?=
 =?utf-8?B?alJ6elV2d0h0QXJaRVhJeUlhRHpxZDJXMTk4TGJLSmNZMktaMzExVVhVdnov?=
 =?utf-8?B?TjI2V0RPbnVHakw5TjhzTkNxeUpETC80aVdMcVFEYlJibGFYRXZMN1p3VFJ5?=
 =?utf-8?B?TlUrUmYwaWtwd2JPaUhXMGIyZ0xRNThFaC9UbG9ZU1ZtMUlKUTNpb3Y5d2Zn?=
 =?utf-8?B?WDd4K3JoVVEwVjhhdjFNMWJtWWwvUk5aWkQvYXF4b2FmcmFNT0s2OG5kMVBX?=
 =?utf-8?B?Rnp3cFdHTHNOWnVNNysvdnlTWjZMUm0rcWxWRGx5ZGc4VlR1U0lXQk56eWFj?=
 =?utf-8?B?RHlxa0wySWV3MUxTbVlLQzFnYTV5c3hISFdDbWwyaGtCUHBZNVNIQ0ZGV3hF?=
 =?utf-8?B?YmFNZjJCR1lGd0FPcGNDYStzTGUvamxSeHVSMXZHbVF4M21nNjZyNlFJdkZx?=
 =?utf-8?B?WGxqYWRDUmlMYlNiNUx3VTd0d05iZW1wL3QxdkQ4aXgwSUJJQ0k3VXZ3OThw?=
 =?utf-8?B?Wjh4SkN0RFFHZzdSREhtR2VwYW92ZmRBKzQrRVBhaDdlK3NWN2pya1RTaTVa?=
 =?utf-8?B?SWZDTTVkZmN0ZnVUQVFNeXVSVTNTWVR3dWtCL3ZRa2J3R3g5eEY1am5Ha0Mx?=
 =?utf-8?B?eVhwV0NheXlVekY1KzY3L0N5U0hoWDJoRStVMFRQQ2M2eTl3MjU5R3A5NEZm?=
 =?utf-8?B?ZGQ0V011c2Y3WnQxRFFma3I2ZEM5a0dPV0RpU0dlR0JQUURzb3J1ZGltc0Ez?=
 =?utf-8?B?eTlZU21XVXdsQzE3MzZtSXdjWDBDR3NvTDhPYkVTMmJuaEJvT0ZONzd1WnBx?=
 =?utf-8?Q?RygjszHdDJ5qGewkxgUsdXWek?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2986ccb-0923-44ad-3d60-08ddc4892784
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 16:52:31.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTnRAm/E24UrGPiDRR5VjtwfdmSrDJTyOGJRpfbt2XXOB+2f+nVcZSle+WZG1Fc0j5Fy0kb6Si9kOWLk4BiWuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829

On 7/15/25 22:18, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> There are two distinct callers of snp_cpuid(): one where the MSR
> protocol is always used, and one where the GHCB page based interface is
> always used.
> 
> The snp_cpuid() logic does not care about the distinction, which only
> matters at a lower level. But the fact that it supports both interfaces
> means that the GHCB page based logic is pulled into the early startup
> code where PA to VA conversions are problematic, given that it runs from
> the 1:1 mapping of memory.
> 
> So keep snp_cpuid() itself in the startup code, but factor out the
> hypervisor calls via a callback, so that the GHCB page handling can be
> moved out.
> 
> Code refactoring only - no functional change intended.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Just a minor comment below...

> ---
>  arch/x86/boot/startup/sev-shared.c | 60 ++++----------------
>  arch/x86/coco/sev/vc-shared.c      | 49 +++++++++++++++-
>  arch/x86/include/asm/sev.h         |  3 +-
>  3 files changed, 61 insertions(+), 51 deletions(-)
> 


> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 89075ff19afa..2cabf617de3c 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -552,7 +552,8 @@ struct cpuid_leaf {
>  	u32 edx;
>  };
>  
> -int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf);
> +int snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),

You use cpuid_fn elsewhere in the patch. I'm ok with either one, but
they should match name-wise.

Also, you should provide an argument name for the leaf pointer or no
argument name for the void pointer (throughout).

Thanks,
Tom

> +	      void *ctx, struct cpuid_leaf *leaf);
>  
>  void __noreturn sev_es_terminate(unsigned int set, unsigned int reason);
>  enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,

