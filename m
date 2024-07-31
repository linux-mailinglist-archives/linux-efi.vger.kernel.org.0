Return-Path: <linux-efi+bounces-1522-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132A39429C7
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2024 10:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0FEB220C3
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2024 08:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFBD1A6166;
	Wed, 31 Jul 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rLRzsPxc"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5041A8C06;
	Wed, 31 Jul 2024 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416263; cv=fail; b=sEr6EKlLZk8V8iVKLJJ2bPs38jlne6rBHYGz6ftHbR2PVt1pHiujyEMPCQue1Pc3kxZCX6NG4mEnt7hHUnMoi4FvwkwCZl5z2mVZOND8cEYpOmRaVfIAYYeyupAacU4COayswo97XkKnzQNJx+yCbit75qZ16YGO/WcCC8iqBgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416263; c=relaxed/simple;
	bh=DJQIJZh55Ucjb2MuoHPvYQn5r33t+fv0zOERXeumaVE=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=Ha0uNyNFCEn9NF29F0q6G8VKkfT6NTDnXIM/SuhDwpX2EIyn3SdgjNCdXgF2cGd5/5L+DbJ0Qwtp79hS5PiQEn/CUGCGxy+Y000FEvjtJbfqFTumwttu3ZTD2wXHMz3YjTHDq+OJ48Vxd+4BvfYYMES2pWLu1pdqVTVN2PE6fuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rLRzsPxc; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Erbi445kJLYTE6b158XWlx11jqhuI6+ETtWJWeCPq9cbG8g8BKmN0soGzCCB/Dw2ZUrH/1h5YnSsF/s1AZ1arDjVy2meqE9O9dw1GYZ2N28VvdZbLS5GxnMEPcMwVSCjV2Fsu1I/gM+j4DmR6IiVa2xGSpyxKzVm4yU9CpS6CwVvnPpqroXMOleSoWVm3Wv1YUDSbldWA7A9JGaCFwKkGiOOpmPX8coa0z33X9hymrTUV4bp+F+YxT+JdxJUlYZ1BXbVV8iQ6hNlwmVWDsv90KLRTN+m/4mgF+glyMH8lYOgZ1eLCY0sqpQkoiu/iDoN28ng46v1wdEMZBYUtFP5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mNzOL4qd2xqRmZp9rR5lXnnYUdj7gEyC1PAvnYdBfo=;
 b=oXuxKnGcLAdLbbzePq4iYzdFWZ5CYLtKpwpR1mQWB4mHVlR7c8F7T/V0/vto4VjysYKQBEgBY7IywS/6p4TrIfoSq+p47fvbsCfDZwUQ/cwPsOVF3OgHEUEB7puTvw1sl/DFsbZdkMIGnjUvxYpvPNYkFs1D6Ak6wUf6WmEwUvVKsWmu4CPQlEwIbNVQNhWdYttLcW1yWN8BzEHv3+u0NQMnUHChWYv8PId+UYDh24et+IRWHlZ/HWSrEQ4CwjHQp87Zh29mVEpgK4bt4VOnxjQG0QCZfgS5XpuVROUwWNf95GVSCyEUI5HihqrqL3nsCd24hKsZPVq/0i67w1kUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mNzOL4qd2xqRmZp9rR5lXnnYUdj7gEyC1PAvnYdBfo=;
 b=rLRzsPxc+n1TTmiY50VUxNKQXDj6qDKTLnf04yGRTw68JX3AKswlCL0K8mzKAbAQRbhnBSJT7jPM7I5uKR5sH1uwGK6DWwfOjYFJKOkHnW6e6mMMyRjukm98OXICfJV8dxhC6VoJb8C+adRXPApxetp5gfLy2qW7QJg5AF1LaJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 08:57:39 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%7]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 08:57:39 +0000
Message-ID: <80734605-1926-4ac7-9c63-006fe3ea6b6a@amd.com>
Date: Wed, 31 Jul 2024 14:27:25 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: kirill.shutemov@linux.intel.com
Cc: ardb@kernel.org, bp@alien8.de, brijesh.singh@amd.com, corbet@lwn.net,
 dave.hansen@linux.intel.com, hpa@zytor.com, jan.kiszka@siemens.com,
 jgross@suse.com, kbingham@kernel.org, linux-doc@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 luto@kernel.org, michael.roth@amd.com, mingo@redhat.com,
 peterz@infradead.org, rick.p.edgecombe@intel.com, sandipan.das@amd.com,
 tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Reply-To: 20240621164406.256314-1-kirill.shutemov@linux.intel.com
From: Shivank Garg <shivankg@amd.com>
Subject: Re: [PATCH 0/3] x86: Make 5-level paging support unconditional for
 x86-64
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::15) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|MW4PR12MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b27c68-55a0-4aaa-33df-08dcb13ed426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGZoeWhmZXNQTDBYVmlNLzlBUHgrZ3lUOExEeXdTUEVSUFZsb1V4VHJEdzBr?=
 =?utf-8?B?aEpOT1RHVGJKQ2hDcDVzbmFLZHpmOGJ6eWpRVjBKVG8ySlY4cFo3eFlVVzJk?=
 =?utf-8?B?aHN0M2Rrbk1JeVpOUXdPZHJOazZGLys1Y3JGbTFLaFB3MzhoTDlPS0ljOGtX?=
 =?utf-8?B?ZFU4WTVVc3Vjb1d6SGZFQTE1ekZpU1hGN1c4WDZkcVIrb3pXdXlXN3dWL3B6?=
 =?utf-8?B?VDFGcm82VU85VHJ5OW5TTE9YWWM0YmZ6ellRZk14RFlmNTl1S3dUNXJxWlR6?=
 =?utf-8?B?SGg3cDcxcmZucEc2ZzMrWTBDNUk4UDJ2WmQ0eDBuMXRzdU1Qa1dlSmNrTUtx?=
 =?utf-8?B?MzFLWFNncCsxaE5XeU5NbnpQYTA4SVR2c1VMSGFtWnArRlEyOWpoblRKcG9R?=
 =?utf-8?B?U0VVa3dJRWxyZTdoYWJaZHJicW16blkvNy84QTI1dmtjajNEZDhKb1gzUE5s?=
 =?utf-8?B?ZU8yeDhOdnNMOGQ2dkExR1lRT3A5QzlPUG8vcWMvR3RLRzhVdWROdVBsUnlC?=
 =?utf-8?B?VFprQnBOMWdlNWpxWms0b1VoT3hUaUN1SWhwcTcwMXk5QnNscDArZ0paL1Zr?=
 =?utf-8?B?cEVOd0JOT0lZOXFxc2dDS0pKQjEwa2lCR1V1ZS8rb25GcWlKQU1YOTg3Wkpw?=
 =?utf-8?B?R29FK2FOU0tKNjMwTnhWM1h1eGMxUy9NdUJ5YTJnbS9GRlpQcS9ZR2VTT3Bi?=
 =?utf-8?B?M0twNTlFMzF1QnN3bVJJeEVCZWg5bVN3MnozWGVXV0txZ3ZLZDFtQ1hET0hy?=
 =?utf-8?B?VTZwS3VCSGYwazV6Z1FTczk0RE9aYUtjQytvWmV2RTZCbWJ2U1R1N1oxZWRW?=
 =?utf-8?B?dnk4Ykl4NEdpUWVDaXFYRXpYSGRQa2VIRERuQ2JNdjlRMFh3MFRUdkNnbVJw?=
 =?utf-8?B?T3N5UTg5TE0zTkZjZTczMWpTZlBsajdVeG1OMDFlWkU5SXlHdzVHZHZ0OUNp?=
 =?utf-8?B?NnJndk05THFyd243OWlsbVlMQ3FYMk54RWxqdTNpeERTMnZkYVY3aGlvWDRN?=
 =?utf-8?B?WVA5RWRvcmpvcElyM1lZTTVHYTJsV1JqRklQYWNCVGNycG5Md25iR2lFazFo?=
 =?utf-8?B?VkFNblh3S3lBSVNKMGltL1pQTXQ2NHUxdjRlS0h2ZEpkdk1LNk01VmZKeUJz?=
 =?utf-8?B?NSsxUVhEelBwZ1JuMXUybTNsU2VDay9OcTZnNWorZWpLY2ZreFI3SFErQUI2?=
 =?utf-8?B?Q2xuZVYxS3A2YktUdzF2azkrMkY0d1crQXNmSVV2bjg5NTUwRGhTTnlOOTBM?=
 =?utf-8?B?WkwxMXFSbWVVT1NxeWRlczFNalJUNmNkRFFYR1JWSnZubzc3MXNDWnlvcjk0?=
 =?utf-8?B?TnBFRnZFUmRkVGtocDN3bThqTGtvTDhQc3h0bm1IUTArQ1lhS1BPK2JjN0ts?=
 =?utf-8?B?M3V3aVNPQ1A1TThmeXVVNWI3ZlNtZlpTYnhJTmZoejY1UWpEZ3BtcXdUQVBN?=
 =?utf-8?B?SzJJNWg4SkV5RmVSWlR4TVZXN3BsQkRzMzcxdERWZ1JUL0dmdVlZcnhNK05y?=
 =?utf-8?B?UlZmRFViT0pRM3U3SUs0SHpERmhkSHFVV0tQVTUzbExGUW95VnFWcHQ2L2hn?=
 =?utf-8?B?RENoM1VzSnR1N2dJbjhOZjhBU25KQXJlUys3SGoyUEs2VnR2em9McG5uaW9O?=
 =?utf-8?B?bzMvWlV4c0RzWmhCOHcxKy9GYThLK3E0MzREUUtaOThheHdxTS9uM3pSbnVZ?=
 =?utf-8?B?QnNDRVZ0RjVpOTVzTlZmYjV5QS9tREt4emxhOG5qdXdZbWVRbStSUTgwdWh5?=
 =?utf-8?B?VHdBWE1iZ3pSa2g5cVNXMHVUU0lIREkwVEQzVnlWWGUyTFNOTmQxOFViQ2x6?=
 =?utf-8?B?MlRaS09ESHdNdU1hNVBoQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enFHTnBFUGZCUXNpWVh6LzcrdXVESzdMMDFMejlNanhyRUZOTlZrUDhLekhq?=
 =?utf-8?B?N2Q2TnFDSXZMclRZQndDOEFFYmlpYjNPbkNLdHdWd0Exc1FTckdHYVMzWFZt?=
 =?utf-8?B?TkFnTHJ5QUdUaHZnK1dyMVA1b29qSFN0WUxQVUFNaVV1dWZZNnNLZHhtaXUr?=
 =?utf-8?B?UlN5eCtLSU5uRWc3b0VPNURrZ3lHYmloR2ZReG9LcU8zY0RLRjFGYThsMzZO?=
 =?utf-8?B?cHBjOThwU0UvRHBUQmtxQm1JLzVaS0w0WlQvN0xxZk94aVBsYkV0TG5tL0hH?=
 =?utf-8?B?MUdpZzZzM0MwN3RwdGJtZUg0cmI5MVFDNXZMVndkdHhlMzdiaCs2M2cxdWRS?=
 =?utf-8?B?U0lqbWxSa0tQZG1MNG95L1ptVlh4bzk2R3AwNS9xOW9IK2VTV0dLZEJlc2RD?=
 =?utf-8?B?bmkza1NFVHpjTHJTMFBFQ29OdVpRSWIyRms5bWkrdStnRW8zNlluNkdyNllR?=
 =?utf-8?B?YmhDSzh0cnkzZHIzRGR0WURQZjRBUHJnS2diNkx0L3owUFNiZTlqWFozS2dj?=
 =?utf-8?B?ejBidEd1WFJKVWNIczB0MnF3b0NicERvWDhCUm44M2ZuODg3WUZIQnYyV3hF?=
 =?utf-8?B?MUlSb2UvY05KTnlWS1RmUkhXVEsySXo2UUxjeDg1YW9NK0J2Ukc4RVFtZUlw?=
 =?utf-8?B?OGVmTmdvS0VzellEcWNPRlYvS09ZZ1Fmb2lBVEY3UDg4OGlvUEc2R1B0Yjlp?=
 =?utf-8?B?a2Y2dlRjeDZoOExsWCt3WmxEVnc5QmFZd2NOamx4SnAzYWR3SlRPc0lkdm4r?=
 =?utf-8?B?SXZjM1ZMeHViNGcvdWZuazF4aXZVdUsvSWxkS3ZWUk5OdThqR05PQjI2RDQx?=
 =?utf-8?B?QkVCTTdtbVZjVnNFMk5YcENUcVZWQ1JVdEV6UWxhQVVIQklxZTlPaFN1Q3Zt?=
 =?utf-8?B?TGR5d1BrUG9QOUNjMXZIQ3VaaS8zRUtVdUJ4djZKUVoxejlCMDFlT2ltM3Aw?=
 =?utf-8?B?VUpNaFZ0Q2dRQXNEZEZtUDRCdkUxYlBXcG03N0JyQVY3bVFxeWQrZjNLd0Zj?=
 =?utf-8?B?WXIxZmgyZjQ5VnVYNnF0SituMDAvVmdGemRBOXV0aUwxNHRvaFBmTHYzdlBZ?=
 =?utf-8?B?NUQ4THloOXF3ejgrQU5CSkVCaFd0Z2tOSnZZVzdaQ3QrUlM2Skg4NmRCV25I?=
 =?utf-8?B?Yk90Vm15QUpQOThNQjFDL3ZGamdWNFhNWnlpNnc2U20ralFwclRWVWRQbFFB?=
 =?utf-8?B?ekdzSHlJb0hUeDF3OEZhOHVzMEVXQ1VpN2lsU25jQ2c1dWhMaDFUeEhJbDFv?=
 =?utf-8?B?cmx1NXNTcmpCVGN4UmZvaDBtUW9vN2ovRTZoeFp3QmxBbk5iVDAzSFpPY3J6?=
 =?utf-8?B?T2NMMjlMWENDeno4dTYxN0gvTnhWNVA0cTBOZEdESkk2NXl2RnZmcjNmOUxp?=
 =?utf-8?B?b3hNMVNaSEtMYnRCaEFPNnpvQkJwMGNuUkRZYkZRMk9FWDJxQ2xPcDh4WVRK?=
 =?utf-8?B?TnMvZ2JKQ3U1a0dTLzByc01vdDdINTUxQXcySGo2MmNOejNSUEU4Q21KcEp1?=
 =?utf-8?B?OC9jZWhSekJMTlRZblYxSnA3TGhFZW1kcE51ZE9vOWlNenRnTmdvelc1cGtz?=
 =?utf-8?B?OUJ3ZFpZTmRRUWdUQ3ZxWTJRbzdpSmFkTXdvMzJGNWNuUnVac0Z2bmEyM2dX?=
 =?utf-8?B?Njl0bVMvT2tnVmcvbC9WNC9vZjVqZWNDLzh5U3d2M2Vvb0xkS1hZU1c1NXM5?=
 =?utf-8?B?b3VuVnMwWm5kL2J5N2F0RkdpdXhWWXJxTGg3V2hqU000OEgzSFMvZThzQzRm?=
 =?utf-8?B?a1NOZHpwVFgvSDNISU5JVEVuMHg5amhjeE1zWGt4NUtXTjNRcUNCUmJkNTV3?=
 =?utf-8?B?OEpLVUtmVHZXSEFOL05xbC95QVZSMVpwSGorM3Z1N0hLeDBmMXp6Nk04VTMv?=
 =?utf-8?B?eE9ualZRY0JDaEFrajRyUnd2V1FPLzBwZ2ZCTEFtbUgwaWtqVnFuT29iMFdm?=
 =?utf-8?B?WXIyOENIVGp5STVmamtNMkNta0dkZDBWRm13WmtSUlpLUThRdDlucEM2QzVu?=
 =?utf-8?B?Y2UyM2RlcHBhbk9KUlVZQmRSVUptQytIZjdQQy92T256V1VDZFFGR0pOcWU4?=
 =?utf-8?B?NGNsSThVTms3Tkh6RDA4VG5VVVluTzQzdHJtS1NOVnhwaThFdlhUOXZCVUdn?=
 =?utf-8?Q?cf1ovwF2q8sJuXDSZ+aikA9yU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b27c68-55a0-4aaa-33df-08dcb13ed426
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:57:38.8397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1pwPNwSwjAr08bGO5QwRMwShT0K9fb3WXWroHDlq//ZFq/QrZVfK3GxK+LXwUbhBCQDwOOFWvTICXHdRu0fLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166

I did some experiments to understand the impact of making 5 level page tables
default.
Machine Info:  AMD Zen 4 EPYC server (2-socket system, 128 cores and 1 NUMA
node per socket, SMT Enabled)
Size of each NUMA node is approx 377 GB.

For experiments, I'm binding the benchmark to CPUs and memory nodes of single
socket for consistent results. Measured by enabling/disabling 5level Page
table using CONFIG_X86_5LEVEL.

% Change: (5L-4L)/4L*100
CoV (%):  Coefficient of Variation (%)

Results:

lmbench:lat_pagefault: Metric- page-fault time (us) - Lower is better
                4-Level PT              5-Level PT		% Change
THP-never       Mean:0.4068             Mean:0.4294		5.56
                95% CI:0.4057-0.4078    95% CI:0.4287-0.4302

THP-Always      Mean: 0.4061            Mean: 0.4288		% Change
                95% CI: 0.4051-0.4071   95% CI: 0.4281-0.4295	5.59


Btree (Thread:32): Metric- Time Taken (in seconds) - Lower is better 
                4-Level                 5-Level               
                Time Taken(s) CoV (%)   Time Taken(s) CoV(%)    % Change
THP Never       382.2         0.219     388.8         1.019     1.73
THP Madvise     383.0         0.261     384.8         0.809     0.47
THP Always      392.8         1.376     386.4         2.147     -1.63

Btree (Thread:256): Metric- Time Taken (in seconds) - Lower is better
                4-Level                 5-Level               
                Time Taken(s) CoV (%)   Time Taken(s) CoV(%)     % Change
THP Never       56.6          2.014     55.2          0.810     -2.47
THP Madvise     56.6          2.014     56.4          2.022     -0.35
THP Always      56.6          0.968     56.2          1.489     -0.71


Ebizzy: Metric- records/s - Higher is better
                4-Level                 5-Level
Threads         record/s    CoV (%)     record/s    CoV(%)      % Change
1               844         0.302       837         0.196       -0.85
256             10160       0.315       10288       1.081       1.26


XSBench (Thread:256, THP:Never) - Higher is better
Metric          4-Level         5-Level         % Change
Lookups/s       13720556        13396288        -2.36
CoV (%)         1.726           1.317


Hashjoin (Thread:256, THP:Never) - Lower is better
Metric          4-Level         5-Level         % Change
Time taken(s)   424.4           427.4           0.707
CoV (%)         0.394           0.209


Graph500(Thread:256, THP:Madvise) - Lower is better
Metric          4-Level         5-Level       % Change
Time Taken(s)   0.1879          0.1873        -0.32
CoV (%)         0.165           0.213


GUPS(Thread:128, THP:Madvise) - Higher is better
Metric          4-Level         5-Level       % Change
GUPS            1.3265          1.3252        -0.10
CoV (%)         0.037           0.027


pagerank(Thread:256, THP:Madvise) - Lower is better
Metric          4-Level         5-Level       % Change
Time taken(s)   143.67          143.67        0.00
CoV (%)         0.402           0.402


Redis(Thread:256, THP:Madvise) - Higher is better
Metric              4-Level     5-Level       % Change
Throughput(Ops/s)   141030744   139586376     -1.02
CoV (%)             0.372       0.561


memcached(Thread:256, THP:Madvise) - Higher is better
Metric              4-Level     5-Level       % Change
Throughput(Ops/s)   19916313    19743637      -0.87
CoV (%)             0.051       0.095


Inference:
5-level page table shows increase in page-fault latency but it does
not significantly impact other benchmarks.


Thanks,
Shivank

