Return-Path: <linux-efi+bounces-2715-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD166A19932
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 20:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217DB188B468
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 19:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38502153F4;
	Wed, 22 Jan 2025 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OjcUJXNX"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B71BC099;
	Wed, 22 Jan 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737574548; cv=fail; b=nOQ/Pr0u9ZA999j/6ALj2OdMEBksbAfeFORvFS75iGvhj8HzkCuwH78zEHYBoMM1sqz+bo9WLuKwHbDLst6E9KNbYFnFINEAGYx9gQ+H4AiNRxOUSzWcTMklOrxp8JgkAp35f+KlYVzEwTWwVCCHadBJh+SRO/qDGWNOvD3kDeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737574548; c=relaxed/simple;
	bh=wU87izUimLC+pRh4jSYK7SsYjv8fJ1iXc0hGdlyAsWc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CB40lIgMG27+KW0/wFtFoKAoN3py4R1MX0e4OFBV0H+YcYTaHbDxu7bYYh8llDuIPRwoHZ8K6R3HegvReW54Oibb9Zctb7LrDbdwZFeG8sh5i9xdVr3sC5DOzbCzCdMoWb5MZRztAxcVQ60cRJ+bpEC6Ia13LWDn9UyECPlqDhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OjcUJXNX; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWMfg6plJFHBM2aQOFMiXauXnNDdmvU/Eqcb3G9orvPYBt5ILbkPG+NyQ2kN1Bnf4UKkWFsIZoxnnfkhAvkrX1CSZIyM5+rNS2J0uHbayp+z/lWlBXOqZRQm24TpXI1GAJAZVBE+eBiU9FPDToKZSEEYu9N5afdjtbGA6KehryBVRLjTGVaCQZL7vSPgCUrLdYPE5YnNHGbFn07bC1P8DbSFKUYhtQmGJ2PuD4pZJXxdxqDZJfjlEy2SVaaoJ0yQkAPr6O55SzXsCZZEivSpzcNbylo7iRWIZwbM4KPPJT76nYTvtbJk5Ipbus2T5igNoAys+m0L4pEJYi4grXwzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3T95sHuhjKpaKT4jRkKA3f16WHbckqCPl1pHy7RXfA=;
 b=qbsylgmIzug+du5VDDIXwkLLNNh+A/omuFrXZp1wlyYhqjBZl9d3qP4C8J/nHcvmi7O9Q4McgNKau8ZVkMbIgVQV6XAQrx3oEPGQAkpxzY92p7tIgCq94t8h+f532Tu8nMl6wAMpW5oBOPc0whXDVKBC2jrZrptWwx8ZiWfdiyMCIIOAShH4gLLVT6wLVq9eK+KrEbQJldxk5oIBIXXa5V7kKgTUZXsJKI5FR18bdYbpQsmkwbyiXaSTdlDrTih3r/v18pWHrfLU0B86PNgP7ogpJ1pghVkUcstT/E3UCgyDxgYXhGgcLr6cvgMUnpyjcjJP6e0Skj4vZSp11tPoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3T95sHuhjKpaKT4jRkKA3f16WHbckqCPl1pHy7RXfA=;
 b=OjcUJXNX2utTpj7GtuWLiyDUUf8C5LVkGCr3VkGpA+JpSBbW92Gs03YWzs9QPZeeLqaTefJaPUs/XSpWzrZtiQoGTCA3QDeDRE4xbmr8lrIHNgcEtAbxq2vHy3CERMEAWyQRZHuoL6FTQCQ4WOcwBNxmwDSqBF4xTJEOaqluN0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 19:35:42 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 19:35:42 +0000
Message-ID: <a0908b08-b127-4fb5-a7a0-9161aebd0d50@amd.com>
Date: Wed, 22 Jan 2025 11:35:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] acpi/ghes, cper, cxl: Process CXL CPER Protocol
 errors
To: Dave Jiang <dave.jiang@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
 <977859ca-3971-4d03-b514-9bf37bbceff3@intel.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <977859ca-3971-4d03-b514-9bf37bbceff3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::22) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eef0a80-54bf-4adc-dfeb-08dd3b1bf523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXdpb1RMeVZaUktEQ0pwNXEwWE9tc3hWRnJwS2RBb2VkdDNsZVBYU0pFMTRS?=
 =?utf-8?B?SFRndHhHUjdqMytDeUdzcHJQM1hPbTYzVFpiV2xVTkNRKzVTV2pBMmZtUGZj?=
 =?utf-8?B?UmdHRndJZGRTWHd0dm9RSENEMXY1VFZDdk1jZkNBaDJndzF2U282eXBoQlY5?=
 =?utf-8?B?ekZ6dUYrUXM2U29zVTNzUlg5NzUrUlBaWW5YUU9lZEtyb2lSbitaWXRUMmpF?=
 =?utf-8?B?ZGpONHRIczhYODFKdjZIRTVMZE1LRWZOdWpNTUhZTGhsdVg4VklESURTS2to?=
 =?utf-8?B?T1pmWmh1SnJNNGFRZlRrY2IrS2dlSDBJTVRyOTVIY2JQbFVMRklCbzhvZTRx?=
 =?utf-8?B?M3hRRVpwV3FJRDdoenBCMlNqcm5oaSs4MURpeDdaMmU1emNIUWtJWEIvOEoz?=
 =?utf-8?B?WTdSS0k2SEtQODlDOGozOGU3S3VibHRUZDE3Wlo0c29ZUjQ3ajdmLzR5YXFL?=
 =?utf-8?B?OVkreFFTT3VRZXRoa3pXRnBRMTlwVHJjRk1YL3JKNFZXc2R6ZXMxTjdULzhR?=
 =?utf-8?B?bWdzODVkZVVvRDJSWldEbE1ja25udEdycjZKVHAySEIwbXBBRmMrY0pjYUhY?=
 =?utf-8?B?NDdQMTlQV0FhY1pMbHpLREgraDc0bG1MYlM3NmhXc1ZCcE1LUlJ0eUxVbFpi?=
 =?utf-8?B?cCt1WFQ1bGt0ZUFXd2s4Qk45aXdnU1lBeG1GL2xWalpyY3ZNNG8xS05qWSs2?=
 =?utf-8?B?Y1FzQ0Y2eHBWSUhycnBWWlFNeFlNaXArV0o0alRWNW90MHUxMC8wOHA1dmh6?=
 =?utf-8?B?U2ZQRkdUOEtLZityQk91MGFEVk9ISW5tczlINEJEVlptcVFCQnZWWHp6Y0JJ?=
 =?utf-8?B?Wm03QzhEVGlwUmduY1pBaTlLNCszRkxURzhJV1J6UTRuVDl5RlV5YWZGV1VK?=
 =?utf-8?B?VndCbHlyS3E4dmVpV3cycTRSeWs3YnRHS3FDM3hpa05GTmtlOU9NQnFZbjdM?=
 =?utf-8?B?R2lkYWVJWi9SWWF4TEo2WDh5RVhESzRYN3U1UzBwVUtHSmpFT2RWUjBwaS9I?=
 =?utf-8?B?TDFLVkQyODFyMzR6RXBEb0xBeEg2dGRaTnZ0cElIRkhVVGY5NVZIREIxcFdy?=
 =?utf-8?B?WFE3ZGNlSmxQU3ZMOCtaQmlWKzlDSlV2aUxtUDgvUG94MVk0b3REaGxoeW00?=
 =?utf-8?B?ZnNOaGl2UTJOWGhTejN6a1hESjRxRGJHN2x2cncybmFzZFFFb2Y5YjllbUE5?=
 =?utf-8?B?cDJTSDVjaHNFSjFXdDhMcTlOSlk1N1dKRnlBNWRoS0NqU3EyNTFBUkRoUE8y?=
 =?utf-8?B?R2RKNkI4eGVtZ250U2Jhc1RRcEg1MkFuOWJ0ZCtNY25MdGZrQU03MTlKSnJw?=
 =?utf-8?B?ZnpFM3pGV2pFUHhZMklwekhkNHl4QTJrN0p6UFpjUGduWHJ6c0hBZlhBQm9w?=
 =?utf-8?B?bkpjTE5DUFdMakNpMmhCUk9TMDE0dXl2WlBoTldjc1I5SlhXL05yQUVLR0hK?=
 =?utf-8?B?K0dxVklpOTB2cjhQNkxWWk9HRDZMUEpHclJ1dk92bU53RTRXOFhwbDlzMTdw?=
 =?utf-8?B?cXdTWHFveVBZK2hTdC81Q3B0OGdWelc4MUI3NGt5c2p4SVBuUGxMMWVlRVNm?=
 =?utf-8?B?a0RKdFhiTnlRdjNtRGFuS3F4WWF5YzJLNlhTWHZLZVJCMkVxbW4xb04xRkRQ?=
 =?utf-8?B?WkRUVXNDMFRuREl6eVhJR2FtcmtURHZNUXMyZVd0aTJRS0tJQmQ0TjM0WGlF?=
 =?utf-8?B?L0xJNUFTZ3NORGwzOXJEOFg3djYwTzN6QkpIVVZPWEdKMFhuNVZJRW5yNk9B?=
 =?utf-8?B?YXU3Zzc2bUl0QWhrdTVjVHYzOWtxL1ZQWUYxTUR4WGNzL3RzKzFuWGxVdUtY?=
 =?utf-8?B?T3NEbDYrd080U1RvODVmRE1UbjNvY1FKSUpYS2xDYzZld3IramVKZURwV2Vn?=
 =?utf-8?B?dUpCWWYxTmJQT1VtY3pOWUlFbHk3NytUenBzY0h6MVljVUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHhsQklWZWw5RXNvQ0NTaEgzYXJrSnJOMDlhcDJMc3ZKVytUNWVSd0YwRFZv?=
 =?utf-8?B?NDRsc1ZLMXZFc3FJb1ZKNE43MWllTSt2VkRQYVFqWUhpaDV6THN1WERVcm1L?=
 =?utf-8?B?MkFVdzNjWFdVUU5tWUU4WmdjaVFmYk5MQ0xtWW9pQ0NPWllNMnJpNFk5Nmtq?=
 =?utf-8?B?c1ptMjZITWpWZnFuTjk0SHJISjRGNjBocSs4RUlubHRQbDc4bkxXWEp1LzRx?=
 =?utf-8?B?TDMrekFNaE1zZmVGUnJndWErYVJ6Ky9ROE1ubnhudEgwbUx2Ujk2LzVEU3pV?=
 =?utf-8?B?YzBTMDc2UXUvSDdaUG1NRXBWOUsxRGF4SW8vd3dtdlNzN3BoMlN5d0JEOHBy?=
 =?utf-8?B?V1R1QTVCVHpLeWRTMVFPdkVIU3RYd0M0Nys1YkVUaHhwRTJ3a3RNdUd4ZmpP?=
 =?utf-8?B?SFJMZHZKbmIyMFd1UWNQaGpLWDhNb1Y4Q0gwc1BLRjNvV1JpeFhpMmxFM1Yy?=
 =?utf-8?B?RHE0eG1zNVZvVnhjUnpiTVFPaTFtZjE2bWJuRTc0b1RrbXgyVnl0TEdOcDA1?=
 =?utf-8?B?aE5xVDJjY3o0Nm1nbDVBM3Yvd3Zmb1VIRXBYaFlpUkdlNEp2a0Z5WVlUR3pN?=
 =?utf-8?B?WmZoOExwSVYweXF1ZkoyNjBJZGE4b0gwYzYweHVubjZ0ZkRoSjBwbFVKZUla?=
 =?utf-8?B?QWdVcEZWTS9KQzJZUDFQZit3dXdUazYzdzBwclFPK00xb3pLMUNQYW5nUTZ2?=
 =?utf-8?B?Rm0vSWxkb00rdlFSVnhOWDdVelRsbzIwa0RaL1BGZmgzM0RjWWIwczlIenZN?=
 =?utf-8?B?R3RuYU94QnplOGFrUXZ6TEpTc3ZyZ3EyV0VOai9xTUlTVXBFbHlXR2xmTitv?=
 =?utf-8?B?ZUhiYzkwN2t4UlZwZXY4RDh2NlVjdEhMbis2TzhZMEtPTmhHQVhyelpZbWxx?=
 =?utf-8?B?RTFOSkNJckd1bHF5bkRxVXJmbnZ3UnFpOEF3NG12ZVJiN3BoRDFVc0VFcU1u?=
 =?utf-8?B?WTRNLzkrZTBDb3FmY3R5NWdZdG5kNGU1UFk4NVVnQnd1MEZxTUtOVlhrVXhv?=
 =?utf-8?B?T25tTHFuWHdEc2sxM1hhdTdqYmhnWmZGWGVZcjBlUGlrQ0VOam55amlDdGlo?=
 =?utf-8?B?andEaVFVVjloR2ZKdzlpVHB6M2liSWhDUWJiSlZ0YWJHeDdBaHMvdVR6OGpX?=
 =?utf-8?B?WWFFYUhDOERaTkM2QVh0MDdqMVc2MHJ3SVpKY0FzMWRwd1hHVlZHSURkZDBN?=
 =?utf-8?B?SFZIdVU0aWdqVEdUaFJYbjBBeGZuU3g5a0NVOWlUVzFIMjBwaFpxYUZaa0Fs?=
 =?utf-8?B?ZlZpVkk1MUN0ekJXTFZzQkxvaE9oZXlRLzJJMmN6S2tSYjg4SEkvTmlrbXdy?=
 =?utf-8?B?L0ltbnFFeTRZd3VWZ3phMGNqendCN1owY2xNN3c0amFNU1RSWGFISHFYeXY0?=
 =?utf-8?B?cytwTkRVVU45RVlvUXJ1ckcvWjRNZEhRZVZwaUo1TU5iY2wxTTljTEE1Qkdk?=
 =?utf-8?B?YU01UnRnc3RrMkhuRUVaUGhGUkY1ZHlUWWpNeDc3eUhqcjNCQ1pBa1lXdjFS?=
 =?utf-8?B?MkdNb1VTRHJ0c2V4ZS8wRElQRTNvSkY0TmhLNnNPQndNOFcrdjZMb3lHTW5H?=
 =?utf-8?B?akJCQ1JXdnBJbHFCa2NyTk9qMVZxR2dwUG1Fcy9RUS8yMDVRdGlDMGdEdE5t?=
 =?utf-8?B?S1ZvVjlNMDhISmxKL3Q3alBZNnFsUDBUUGllVGxuZlplZUlNM2VOVVRtSHhI?=
 =?utf-8?B?QTBGN2dEenFqdldjaUxUVGVzdjFRK3g0b3doQkw3ZFpZYkE5eUlIY0VOWGFt?=
 =?utf-8?B?QjlmWXVpZGdiUWpXdURwb0VQbEFrNFRCSTBpZkQrRVBmZHd0TFhyNTlXTHpm?=
 =?utf-8?B?NDg3Z1JSbElOa053SHpmTHBRa1ErbW0yOVRGTDdiZjdYVmdKM2FJYWF1Zlk0?=
 =?utf-8?B?VkpwVktEcXZweFhFT1ZxbE9KUnp2c25oNVcrOVpvR3VmQlVCemM4SUU4Ynlz?=
 =?utf-8?B?QmVSOTVKbnJCaWgwWFdDeThsbUZxaWtuU0lDeUJUSDduYmkwaGF5cFJxQVB5?=
 =?utf-8?B?VkU3eW5QQW1ZVE5tQ294d28xTmdQaklkRTRNTjJJc3NFVnNyK1Zid2pFMG53?=
 =?utf-8?B?WGczTDVNaGZWZUVkK21Pd3BpSWNFUCtOeTdpblZudDFNQ09PUFlkUElqUm92?=
 =?utf-8?Q?eQD1EQQFqVOc3O7eVBufMCSWe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eef0a80-54bf-4adc-dfeb-08dd3b1bf523
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 19:35:42.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pDhZSsbTq/gh6mKKzoRp6YOS+UdhshZlW7+q0FLPGtS0M/oKky4FZeJ49VyZRVNI+T8EYRn75Puh7xi92XTEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405

Hi Dave,

On 1/21/2025 12:32 PM, Dave Jiang wrote:
> 
> 
> On 1/14/25 5:04 AM, Smita Koralahalli wrote:
>> This patchset adds logging support for CXL CPER endpoint and port protocol
>> errors.
> 
> Ard,
> Do you mind giving an ACK for the series if it looks ok to you? I can pick up the series through the CXL tree with your ACKs. Thanks!
> 
> Smita,
> Can you please respin a v6 based on top of latest upstream instead of Terry's changes? I think we are ready to pick this up before Terry's series. Thank you.

Sure. These patches depend on trace logging functions written by Terry 
trace_cxl_port_aer_uncorrectable_error() and 
trace_cxl_port_aer_correctable_error(). Let me work with him to just 
merge the trace logging functions and I will post v6 on latest upstream.

Thanks
Smita
> 
>>
>> The first 3 patches update the existing codebase to support CXL CPER
>> Protocol error reporting.
>>
>> The last 2 patches introduce recognizing and reporting CXL CPER Protocol
>> errors.
>>
>> Should be based on top of:
>> https://lore.kernel.org/linux-cxl/20250107143852.3692571-1-terry.bowman@amd.com
>>
>> Link to v4:
>> https://lore.kernel.org/linux-cxl/20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com
>>
>> Changes in v4 -> v5:
>> [Dave]: Reviewed-by tags.
>> [Jonathan]: Remove blank line.
>> [Jonathan, Ira]: Change CXL -> "CXL".
>> [Ira]: Fix build error for CONFIG_ACPI_APEI_PCIEAER.
>>
>> Changes in v3 -> v4:
>> [Ira]: Use memcpy() for RAS Cap struct.
>> [Jonathan]: Commit description edits.
>> [Jonathan]: Use separate work registration functions for protocol and
>> component errors.
>> [Jonathan, Ira]: Replace flags with separate functions for port and
>> device errors.
>> [Jonathan]: Use goto for register and unregister calls.
>>
>> Changes in v2 -> v3:
>> [Dan]: Define a new workqueue for CXL CPER Protocol errors and avoid
>> reusing existing workqueue which handles CXL CPER events.
>> [Dan] Update function and struct names.
>> [Ira] Don't define common function get_cxl_devstate().
>> [Dan] Use switch cases rather than defining array of structures.
>> [Dan] Pass the entire cxl_cper_prot_err struct for CXL subsystem.
>> [Dan] Use pr_err_ratelimited().
>> [Dan] Use AER_ severities directly. Don't define CXL_ severities.
>> [Dan] Limit either to Device ID or Agent Info check.
>> [Dan] Validate size of RAS field matches expectations.
>>
>> Changes in v2 -> v1:
>> [Jonathan] Refactor code for trace support. Rename get_cxl_dev()
>> to get_cxl_devstate().
>> [Jonathan] Cleanups for get_cxl_devstate().
>> [Alison, Jonathan]: Define array of structures for Device ID and Serial
>> number comparison.
>> [Dave] p_err -> rec/p_rec.
>> [Jonathan] Remove pr_warn.
>>
>> Smita Koralahalli (5):
>>    efi/cper, cxl: Prefix protocol error struct and function names with
>>      cxl_
>>    efi/cper, cxl: Make definitions and structures global
>>    efi/cper, cxl: Remove cper_cxl.h
>>    acpi/ghes, cper: Recognize and cache CXL Protocol errors
>>    acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
>>
>>   drivers/acpi/apei/ghes.c        | 103 ++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/pci.c          |  62 +++++++++++++++++++
>>   drivers/cxl/cxlpci.h            |   9 +++
>>   drivers/cxl/pci.c               |  59 +++++++++++++++++-
>>   drivers/firmware/efi/cper.c     |   6 +-
>>   drivers/firmware/efi/cper_cxl.c |  39 +-----------
>>   drivers/firmware/efi/cper_cxl.h |  66 --------------------
>>   include/cxl/event.h             | 101 +++++++++++++++++++++++++++++++
>>   include/linux/cper.h            |   8 +++
>>   9 files changed, 347 insertions(+), 106 deletions(-)
>>   delete mode 100644 drivers/firmware/efi/cper_cxl.h
>>
> 


