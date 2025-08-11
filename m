Return-Path: <linux-efi+bounces-4538-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B372B213D5
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 20:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28FA1778C4
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276591E2834;
	Mon, 11 Aug 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YKG+kKTo"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2E72600;
	Mon, 11 Aug 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935549; cv=fail; b=r9b8c/+nQBtgeY0bEPRQg+zr14JWQjSADiOTZFrsaG0EoC1S3I5gLX2ikc6zbp9BB/nl5b5Qelifdmm79kF4E3Nh04+hdh2CP8Njrn5+cz/VWfuNHxQ8RC6AbIdBRRpz3BwYi+O5BJMoxcVn/eXGO5OCjnOEL9RfVhJ/YGL0doY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935549; c=relaxed/simple;
	bh=JeoXH+UeEAwS5+S4ZXHnCbJdW9hZyP5pxmW6hmoCvRc=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=XU3CzNlDOvCViijPTUCWIWQREMTmb7qxYEQpP0HiU1LdYwuYLfvQ55Z1Pexfj3dNiwabUkgWf2O8k91WRnV1gB1iq40QSg/cqNO2RFLMY5VOJmuequgWAhfjoan6WGOrXtOcweLVK4PwyDIuV0Lw3iE0oJvKJCAddomI6bPxpzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YKG+kKTo; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJkZBGo4XEbupmyZfPyYRerzX71DVSI7YDcQhsI/CNjJrQ1dRZdHsMrvBErPr/wVOSHMDz5dUMJLlatSpVQXvzLoNL42WRfPB9ItuBBbdCaUceCY7//g6PEUhSPpVx7jESEQzPjQxXFm5c53iq3RPW6isHJz8RIvhVRXwG2sXvFePa7CGYL6juoMoEy4Vvfv++fHxLhGI3CZ567nBc6w51duj6LdM4YdmxjKHXmxeOnAhoUVqa035yNSUyRcgAR8cR3lfutYDRO9aJtUPtVHbMtZNuFI3hJtHtv94nfg6uBwQIyqskLAipJ4HgQnAt8R0/1yN/jgm3qIryq1yDBN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUFDkQ0RzkRs/mUsdBzQqAxC6Xt7Vn2lL3HwID24Pro=;
 b=Hc1aWL62f8PXISUxH/nVyqSBTkzop9BYgeWpzM38m7Nynw00GJMHETpXP5BO3RTcvCIONWiZiIXBYoYTktPYftbHM+ONxS5RJsu9sJ9YJMrl2if5gZePgAlMZLgGMxPJ7oPjFyyG3XTEdboozYF9eIoslUkxP5sodKLVYXjridVU4DQtUaLVKdI3qj1dTtBfciQzW8Mt1xqS8SdMmZ2QsjpoA9HMUHxO1mOnUVvOBQC+Wd/jrH+s51nUgJNQ7rHGXOeB33U7PycdnuejHpIb4Nhr7S3+12NBSqIOi+J0G8h9tAFwuES3x0vuY82+HMi8/twMrOKzjTOtl1l9XMMP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUFDkQ0RzkRs/mUsdBzQqAxC6Xt7Vn2lL3HwID24Pro=;
 b=YKG+kKToMr65BTECXnVeGK8vOdCYZdb+2jSx2wc2KMKl/2QO0kpwN9WXW641TjD1BA4GdOpa4UFbEAXEWuM2RHJ1X8rIox64u0ISonEmBihJbyx/2ZGIryGjXAE0FJ5IT/df8qCrq6XD7JRy2ogZUVhRKgXkrMrwHeA80BNZ0FE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 18:05:45 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%6]) with mapi id 15.20.9009.017; Mon, 11 Aug 2025
 18:05:45 +0000
Message-ID: <c9bb1b3f-17ce-254f-5d0f-ae3563b03b50@amd.com>
Date: Mon, 11 Aug 2025 13:05:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-45-ardb+git@google.com>
 <20250811174034.GRaJorEmcBfLTDhWml@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v6 21/22] x86/boot: Move startup code out of __head
 section
In-Reply-To: <20250811174034.GRaJorEmcBfLTDhWml@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:806:6e::20) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA4PR12MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e30819-ec71-4c97-d0b0-08ddd901b142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXpWSktucXZFbHF1VjU3WkZ6cEw1SWRleW0xWkdhZk92MVFsa01VWCtJbVZr?=
 =?utf-8?B?NzVTMEpRbjcrUmsyZ0pJdTRwcDZ0UTVhSzFmQk54b1lyZXZiWk11STdJck9l?=
 =?utf-8?B?VzlpNWd5R1ErSllzc1FkTFJqbGNiSmJTcEFXUE4wd05kRU9BV09DV2k5dnli?=
 =?utf-8?B?Uk5GT0RLYVhtQUFtMys0WGdtazF6ZkhvUnZBMnViYmV2VHFoV1hrMXZvSVpN?=
 =?utf-8?B?TzY1OUM5NC9IUzJFTmxyR1ZKaC9SVkFhOGd1bk9hS05GVXV2ZmxvUDlmMmFj?=
 =?utf-8?B?NEhIS2UvRlhzeHBSRUNqNndrNXpqc0pHTDA0VkxkTEJOZ1l3YXNyaWUxdEp1?=
 =?utf-8?B?aU5zQUNoUlJXTUJ1eHB5dytUZXVpMGgwUVlXTlJHZG1rR0pzcFpNNWx3bGJU?=
 =?utf-8?B?RHQ5Z3E1T3cxZEtPRU54NTRUNUllcDRLaHVESEFveUwyZzJDaGNSNVFlcFh5?=
 =?utf-8?B?aUFRZkI4ZDlJRlJLMk9obmVDZGZsa3pWR2owc2dNV0tBaW9DY013ekdMc1FM?=
 =?utf-8?B?c0NCNjg0azZDK29GVEttWkt5UkdXNXRqaHh4RlZHdHoyYW9mUzlMeUovUER1?=
 =?utf-8?B?YTNqb2Z0NGtXUEdBZlZnclgzc2JSaFB2REFLWDcwdVI2UGYrR2kwd1lQaTd3?=
 =?utf-8?B?eHgzVVpPcGF4WVQ4ajczVlVhUDhjNWQ2WVA0NEJCd0hxUW5uVnZlUEIwbW5Y?=
 =?utf-8?B?NXk4bVZnOFpjZW5aN056SjlGSTdjWkhveXlWcDREUFZwVVZGN2JDODBMUnlX?=
 =?utf-8?B?aVkyM25NOGFZdFRZYUhCOXB5ODZEMkVGaU1VZGJWWHZ2NkF0emxneHRvYzR3?=
 =?utf-8?B?Zmp5NkRHWWovUDY4U3REOE16SENkSGV5OENIUEJBK2hlNE9sUHQrVkkyZ3VD?=
 =?utf-8?B?d21qbFVGOFk0aStySUFMQVd1ekZ5T0hRTnF1ZmRoNnNSdTA0bWlCUWN0K3hT?=
 =?utf-8?B?bHdPWHgxVXFZcDY2NzlqRFk1NSswNnppRDBlMGo0bVJsemMzdmpxVlRGeWVO?=
 =?utf-8?B?UjNmbTc2QVFNUk1HMXcxNllRR0lwSUdPU3gzRHhFRDNDSUxrWVdJRHZLUzE5?=
 =?utf-8?B?VElVRU9BYUFxeTNnMGpHbTcxZUlxbER0aFcyS3pWc1lTODBSNUtzOS9tWXZp?=
 =?utf-8?B?c282TklvNm9lRmdLR1ora09TekhoTjBFaGtiS2JqUEx0bFZmZkN0VUJzdXJZ?=
 =?utf-8?B?Ni92bTB1UVFIKytOUmdibVR0aGc0bTZwekhsakJ6aDBwQzJkRisyZUxGWHJM?=
 =?utf-8?B?dVB5a090amdzODFCMmtZVXh3dys0d3FpUHlhUy9PZjZpbFgrU2p5ZXpJcjRT?=
 =?utf-8?B?c294cUUwSnI0dlplT3I3a1l0ZlNySmlscTRBRFR4T3dYdHRLWHVNc2Ivc2Fa?=
 =?utf-8?B?b1JFcFF1ZEdod0tGNXM1ZFJ1L0hDNytjRFdEMlhYYnhwMm5ONVplWDhwYVFY?=
 =?utf-8?B?akZuV0dHYlFUY0lNRGlBUGdsR2FLZm1hc0FLR0FUdkg0R25xY1h4Q2pTMGlT?=
 =?utf-8?B?cEFvVlpTZkRxTGdiMk50TnhXUXR4Uk5OVzUxL0F4dllaZkRvRExWek13ZU1y?=
 =?utf-8?B?dm0yMnV5azQ3d2lRbFdLSzJ6Z0JOMGtPWk9MVGk3WTM2R1ZwQmxNbzQ1Wlp0?=
 =?utf-8?B?Z25EQUVJTWlpaXpwTU81UnV0NGVaZ1pqRGhuSldBUmo4MlQ2UFZiR3dTeEs3?=
 =?utf-8?B?dGNzelc4bHNIeFprdkZ4cEpIVHdCbVZqcjZUNTVQc0h5cTluQ0xkcWJCbnVl?=
 =?utf-8?B?YkpFdkVKbjVWa3JGOHF4N0cvSk9idk9WNmtCeHF5R2xueWRmbHEyTXRpTXpO?=
 =?utf-8?B?S29CUkI2QTRqZDIyVHlVRHJqY3lnYk42bGdxZUpkRFJYb1JZclVkZ2hoaWNH?=
 =?utf-8?B?RCs5VGNKOGpLajl5aUJRbU5lN3lkclJlOG9zQnRCcXNiWHdZbCtDdVJpQlZK?=
 =?utf-8?Q?rKBtfFEUVAw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blVGS3dVTlp1TlhXMUpDOVNyRXgwQTBTNUxTRXFYMlo5d1NrRWdZRE1Ydnpn?=
 =?utf-8?B?dmRNOG1vUG9oSTF4cVhicjMzek9pMU1mekNwWi9lWWN0VUdRMi9yMVJ3alBj?=
 =?utf-8?B?dTNxekpWMnhvRWowRjFKR1RVVERMdGpGdUE2VDdMU2V0ZzhSUkxDOWFUaEth?=
 =?utf-8?B?RXp4Y1hYNzk4TDRzcWNld1UrSktIa3ZLRnViUmFrazV4VG0yOUZoeGVQVE9Z?=
 =?utf-8?B?NzVrMVAxcWViS3p4L09SVDRJT1U2ckwvd3NyTEdmMVF2VVA4QTV5aXFTc3lS?=
 =?utf-8?B?WkxjNnYzYmEvaG9QVWVveWFEYVVZR2U0azFwWXBDYUlFUnN4TGNocTQ2TWtN?=
 =?utf-8?B?c1hhUk5XOVR5LzVld05DNE83RWYwWWJ6ZzBOQzl2OFBGOHp1Q21oUU11WW4z?=
 =?utf-8?B?ejBMWjlPTmhoU2g5dEljS3ZNOTU1aGtYTmFWWThaS3lIZk9vdVFhMXhXTjAx?=
 =?utf-8?B?VEp0ZGl1OWVMVlpKL3hjUUtMZXVDOE85RUFmRVNlazZXVjZnenVjbFZidG05?=
 =?utf-8?B?T09yTU1leEFoZ3UrUHUvUForWW05TU1wcTlzVEFxSXg0b1FaZ3FyMWd5aVZt?=
 =?utf-8?B?OTFsT3NLNXhqQytOMEgxS3VkS2xWck1mckpuSEFINHlkQ0J1TUJLVWVQcFMv?=
 =?utf-8?B?ZFlQQ05UMUpHeDFwc1RDM1FjK0w0aDBaWEllS1B1VFVBeUFyRHZ5amdPV1Nv?=
 =?utf-8?B?K2dVRFFKNG1UTDRwOTBKeTl4d2RJa3NpcDA4LzhIR2FsRXY1b0FtdFJ0bDdu?=
 =?utf-8?B?aXBJdHFYRGlSblBQVklzbGFmcE1mSUhtajFHUU40N1U1Tktmbm5ScjlVL0Fj?=
 =?utf-8?B?R2Q3SXZpVDNMYU5GVWxwMGdMN0pzRG1GbXZWSmZqNlcxWGVtK2cybGZCMFIx?=
 =?utf-8?B?UENCV0ZRMVJhaEVCdU9kWHFKQ2Jmc1h2b0V6RjVxUlAxQUEreVhXT0dldkEr?=
 =?utf-8?B?UUhPNFY0L1NYdjBWNytCUE96b0daSFBEK1lGaTR2aUFxU3JkREE3TGFmZWF4?=
 =?utf-8?B?cEkvOFkwUG9JR1UxMGIvUERKK3JMWENZeVNEbG5BdnhUbEcrclZtaDBacDR6?=
 =?utf-8?B?M3FKS1liTUpTR1orNDNzOUkyVktOaFdiUGNKNzhqVGVxQ0YwVnJ3dUpyMmdL?=
 =?utf-8?B?VVBvMzZTWm02b2JZR080ZnVmSi9HZEZqV2x2VVl5MDVZcnNUdGN5TzlPZnVk?=
 =?utf-8?B?QnVYSXgzVEdwVU1lN290MWpESUx2enhSYnc2ejFEU25SOWpJOHM3aEJ5S0Y5?=
 =?utf-8?B?dHRjeEd4bmtNQnQ0MlBsL25kL3dIWU9rNzkzSG05QUtZbDFzb011TEQ5Y2d6?=
 =?utf-8?B?My9Yd1hrZUx6Sktha1grazF6SDdRV0FEYi9IaXdmUUpWcDBnME9TTVhMcXk1?=
 =?utf-8?B?RFB6K21RaWRhOVdUbDltTXg0VWRhMERWRTM1V0x6UlVydXZmc0UyalplZmhv?=
 =?utf-8?B?Q0ZpZHExc0wxc05GVHpGZE1rVjcydnRHWjdxMGd6OEU5aFdra09KVmkxNGVp?=
 =?utf-8?B?dk5PTjBPRlZIZFBkUGdUWTU0Q3NXakYxQVhTTmZLdzg4OUlLSno0bkY2VHhC?=
 =?utf-8?B?S2VmOHVudFRobHplRUxOZzc4ZzFFbU5ldlcrTGUxcVoySXo1WWdVSXFpejdy?=
 =?utf-8?B?NEhuNVYyRFpXdjJFeFcyaXFnK05Bd1B3VDlEMUhDMjJ0RU53eExTeWlrVk5r?=
 =?utf-8?B?bmEwbjEwK0ZjT3A4d25iYzFNbnMzY0JUenE0WDl2b2kyelVwalpwbm93TkJu?=
 =?utf-8?B?MEdnTE9qWVVYdFU0Q1A0Z0wxWU5ydW5qdTdWdXhuN2tPWXZ4L3JqZlZrbjIx?=
 =?utf-8?B?WUFhVGYzVGt4WDk2UkdaOGJiT3Yrc25uTjYzZTE3TDBiR0Q0c3V5b2kwUXBY?=
 =?utf-8?B?TFdhUFk0TGJRL21KS2I1c0FRMForckt0N3JrRjVZOUh0OEJRMG9YenJTWEEz?=
 =?utf-8?B?bFpBWk1mYVUwN1hEb3h6K3FuZ3AwTE8vVkZFaTdPQ0pkR1ZOOGxOTXlQYkZp?=
 =?utf-8?B?bnpPY0IvTzkzREZZdlYrRnN5OTlqL1o2b3hNSmxoVHVNamlpVkdDNUE0emRv?=
 =?utf-8?B?ZTFjRFkrWmI4VTZ3TU5lQ2xGbHhWQ1V2aVZUNVFxUHNqY1lndUhRUWN5R1N3?=
 =?utf-8?Q?krfTInfCCkSz4OJYhJk9PHCle?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e30819-ec71-4c97-d0b0-08ddd901b142
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 18:05:45.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmf+7fuLNqebgu8P/P8ktXI6Vr5lg8uFCp8BcUtmVkOeEA0bCtv12gui9MLxCRJpXG2c6w/ecw9dS+8Og04eAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9810

On 8/11/25 12:40, Borislav Petkov wrote:
> On Tue, Jul 22, 2025 at 09:27:30AM +0200, Ard Biesheuvel wrote:
>> @@ -210,7 +210,7 @@ bool __head snp_init(struct boot_params *bp)
>>  	return true;
>>  }
>>  
>> -void __head __noreturn snp_abort(void)
>> +void __init __noreturn snp_abort(void)
>>  {
>>  	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>>  }
> 
> So this thing already conflicts with the SAVIC stuff:
> 
> ld: vmlinux.o: in function `savic_probe':
> /home/boris/kernel/2nd/linux/arch/x86/kernel/apic/x2apic_savic.c:29:(.text+0x6601f): undefined reference to `snp_abort'
> make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux] Error 1
> make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1244: vmlinux] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:248: __sub-make] Error 2
> 
> because it calls snp_abort().
> 
> I'm thinking since it is a one-liner, we can simply turn it into a macro which
> evaluates to
> 
> 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> 
> and problem solved.

Yes, that works. Or just get rid of snp_abort() and call
sev_es_terminate() directly. Secure AVIC could even use an
SEV_TERM_SET_LINUX specific code instead of the generic failure code.

Thanks,
Tom

> 
> Or you folks have a better idea?
> 
> Thx.
> 

