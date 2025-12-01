Return-Path: <linux-efi+bounces-5745-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF85C98E04
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 20:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFFD3A2328
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 19:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714E923A58B;
	Mon,  1 Dec 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g2ijtTF8"
X-Original-To: linux-efi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A2C1E1A17;
	Mon,  1 Dec 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764617744; cv=fail; b=vAp9elSqxrYzVT2A+pPaA0ZyFmmN0IIlq0bBxRIM03+EFY/iCfZvvuEU9po9MqDzqltx9DiwNiYtldZY+0jrMH5nKRjpIbqPH15IQg1xqru7hAoZnjwl4oOW+JIIEdQysXfeUxvMz0yltjbcMJxdDOu89DILuT5CYFNF3kVTwMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764617744; c=relaxed/simple;
	bh=ufj25Gc55qE4N3RiKoR8okAFLFoPcu4357hWNdxzUUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ekEhl+rEaRJwk5FEPFnQMQSrvPiR3YthQvMGf1WDt0QrS06qqGdXN0a3EdtKBzqmVFvj2VfLFxCF3RDOzlssEozuIV9zsWlBMXElKHFLFJfY38vEvPuesPVximdKT65tWsz+m1iS5V8YZ21lFz2VuJht0N/c7jL60jlcD4yI1Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g2ijtTF8; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3lFc+fzaBgVNpgLMQFrTK3F1cfQrU3l3aLSdGB/tIFUIULyHjyUTWFg0V0rv1MVJLHRNlmSV6oh7xgKErkygA0SyoYImLixLbkdc6Ee9jcgRkXDtroitSB8v4L7KLn/Ifps8TbMKg+92/kwpqiFkXAOqIO1DzArPaZNQY1bzOJICtHsAFA5oU24aShMw7JpLkALr4vojn7kmumST4G3a2hkDlsTFNHvmLBxSpS3XuqA+i/iw72CljkDeCBcayZLNLEiCqX0fPpM1xfbylLpKMKtGKoBAtsoeVEOYulXtmYpHdIiNKg7MigagH//HawkkOIg25wTEnqQaBVVZAeiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13jhjuRjYJiHOFSfE4CLvFM7vMw5zINQR3wivStM2V0=;
 b=dnO832r9W5DTBFF7ACpRQ1WzkaCK7cFSJDk2cbDE8Pnjj196EXxWgaRj0fuw/GgIJ9XCcJNYvR9/d5Yk4h526/Hg0pSGf0yUJe59GsxvvpEV3OHRXBC8FUhKEUyC0MAou+Lft2bE//WG+80rS5ejtLsd52hb/HJj0RHl/1ccij/vsAs+icUMTlVakIENZfLtMmoBUYjJkY+1CTFnWBSgyoQVrEOUjbr3s7is7IrSOYjDPvuSsTf8tD/loUZvJY+4x9peQiAtjPrq7KkNwmIhd0pJc0touRDdRpZIkebJQoRH73B1lZTTZqiytISuoBO+fvpekcaLZZWFR+DFgyyW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13jhjuRjYJiHOFSfE4CLvFM7vMw5zINQR3wivStM2V0=;
 b=g2ijtTF8EN0ofW6TB/IjyqmHiri1pAlprsfEAbRFeJsjo/M0xHF66SzD0UE/kMlBTwIAiWhvNK354a5JUo7mpyml/jwM+9fJTAkwHiOE5A/4NEWJ2tO0IqKbWxWuaZH28xc4UD56LT4Aqo82QxWcjZexmzT0v6d7UCpfCVUCojw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:35:39 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:35:39 +0000
Message-ID: <91092d6d-888d-48dc-8a90-d184bfe73d0a@amd.com>
Date: Mon, 1 Dec 2025 13:35:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Kiryl Shutsemau <kas@kernel.org>
Cc: linux-mm@kvack.org, linux-coco@lists.linux.dev,
 linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, ardb@kernel.org, akpm@linux-foundation.org,
 osalvador@suse.de, thomas.lendacky@amd.com, michael.roth@amd.com
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <14df1d99-7df0-4982-8029-e66dfb140399@amd.com>
 <dy65eupwalp5wsljetlto27l6tjjvoygeotjd3n7mk7zjc4dma@jf4hzsy6rtcd>
 <27c06cf2-7500-4875-bd22-f55571fb85f9@kernel.org>
 <c8926ced-3ef3-4c11-9d04-00db388887c5@amd.com>
 <2b82fb9f-338e-47e9-bd14-3bdb392dfcbf@kernel.org>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <2b82fb9f-338e-47e9-bd14-3bdb392dfcbf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::13) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8064e2-ce43-4850-25db-08de3110cec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEtCMHFWT3R0QnJ6MUNzeDVSTmtaUHVrQkR0dy9QR1dXblJ3VzJyTmYrcEJY?=
 =?utf-8?B?R0pidG9PMHpMYWRxaEg1ODN6RXllV3ltZnRabnRSM2Y3aVdCQnJSUEdKdnp3?=
 =?utf-8?B?WE11UVVTMkZ1bW85ZzRsRzRtTHk3NTZ0Y1d1VkQ2Qlp2djdxTkdGcEpDNnpt?=
 =?utf-8?B?TndDT0JXeVRQWnRKdTlrRGp2ZG9SQVZ4V3JucnhnUXJkV0d1clZpN0ZNYWF5?=
 =?utf-8?B?TXl1S1QzOXpia1pPQ3NJejJYZG9FMVo5cTMxTVE4V2lUdk56Rkp6alN3MHhx?=
 =?utf-8?B?OWtlaU5PNVZDa0dPQzJJMFlabWpqTmRFSks1OXhKa2s3aysvWkNPWmdaeUtp?=
 =?utf-8?B?aS94eVNteURyeThBNlBwU3FJZElWdEVmRmFsUEx6NExmbmw4Y3UzVC9BclRl?=
 =?utf-8?B?bDhwMVNmaW9reFFENGJkaTZUbzhRdmU5T2U5bW5td1E1alNPeWhIMlVFaGdx?=
 =?utf-8?B?QWFnSytBM0dwRktsb1IyMDRIQ1Q5YkFSelgvUzdBMUY3bEd0a1h2eUlJNkZu?=
 =?utf-8?B?bjNweGlwNUp4ck9iUVM2WXVhWFhSazQzTGZjc3Y0TE1IbzdyQTJyU2lSNDhV?=
 =?utf-8?B?WVRvQmJCMUJzTGkwanhqVXRReW4zemVxU1VZck92Q0NUQ3I0MGs1V05maUE5?=
 =?utf-8?B?WklPZkFqUDU0VFRPQlhEUFBVVmt4V01OYmJwRFpLYTZoYXJjd0VGT2tBWmVj?=
 =?utf-8?B?b1FqOXl3SFQ5dTZxQW1pNC9PcUdlSFVMM3luTWZwd3hTK0NzOW9pcE1FcmhQ?=
 =?utf-8?B?d2s4UjhPTUZCWW9TV2h1RUo0MmgyT1hSdkp0eWI3U3NqTDUrSW5NOWZkNlZD?=
 =?utf-8?B?Z04vU08zZHRKY0ZHSFh6QzJHcGozVlFFUzR5eVhiOUxwamZ2RzVvSU5QN0E0?=
 =?utf-8?B?WlBiVGZRdElKQ1hjMUY1UnJKaVhveStiU2RCK1p6UW9hdjEyTGhhOXovQVpS?=
 =?utf-8?B?MklwY1djRExWcWxXR25CbElOd0VmVkN5c015Y2EwaHNjS3crbUQyL1hkdDBW?=
 =?utf-8?B?eG05VXpSbVBjWElaTDVTc2VMUDVkWmhLaWlYc083TkI3L3BsS3RLdTUvOGdn?=
 =?utf-8?B?eUlmWmc2WEZRbm0yUHNTYy82WTEzb1AvVURhOENWTTF1YkJ6SHdKS1B6Tm9z?=
 =?utf-8?B?Q2hvdmFMRXJTNStRRHl0WDhHcnh5bmxBRGpSQytySkNZRUxFQ1ZNUlpERC90?=
 =?utf-8?B?bjhtcm9SekhlNERoZFgyTzVCK0xEcUE3YnVvRUlKTUMxOGNCQnZZUnZjWjAr?=
 =?utf-8?B?cEkyZ2pMb29vZmJJejFLV3FUdVo4aVJkazdjWkdZOHY4NEh0a29neEdoRDYz?=
 =?utf-8?B?b2RnZ2U5QktOejBMSjgwZkh3bHo0WU9jTW9EMk1aMWgra256MU1TTk1DdmJh?=
 =?utf-8?B?UUJpTllVSWNudTl6MjlIZDdZS0QrNjkyQTBIcUtSSzluWFFNUGh5Y2N4amh2?=
 =?utf-8?B?THpFL2U2aUdwazRPQ2Y1ckVrUWw4M0lyR3MyVkFZZW9zLzBJUDJqTjVjbkNy?=
 =?utf-8?B?d1NwUHkxcFBldlZoU3dJUlUvUVNucnVvWThuSkZEQUNZOVhHK2FNYUhPb05S?=
 =?utf-8?B?U3BobDgvREdveXVQZHFSRWpjRHB0UVB6QWd3cUNsY3RrMjNZd1hpdjBCN3dR?=
 =?utf-8?B?cmhXRXNlVmNiTUMreXpPYk1LcGhhOHN4SEdjNnQ2SnhLSi9XSkNnVnZnSllo?=
 =?utf-8?B?eDZ2L1dTNjFKUjNuU0J5SkcyUW9xakpHTHBqV0hyVmhyYlhCU2ppd2NmZ1hH?=
 =?utf-8?B?c0E3OHlCbkdBTFVFSXVqdGI0Y1RjT1NEalRvc1pIWWg2NUloQ1RPdWVkbk9O?=
 =?utf-8?B?L0s1bkNaTEhHU3plN0ozN3I4MFNhaDBFOTUvK3gwdVpDSTRNSXY1aTF2NG5S?=
 =?utf-8?B?V2tHQ3BHdGRVRFpWTENnaEV6amtyaEg4T0RLNVlBVDVUbzRKTTQ5NFRNbG1D?=
 =?utf-8?Q?3eo5gI6PMBdA0GGeobw0GylH32XWMxyW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWFnM3FiWlFVODNjUXNyRnFYMlBzRlo3QlZsMzdqUGtiZ0ErNUFQL0E3dUE0?=
 =?utf-8?B?aHluZjd5TFVNL1VxUG5pRmJjMUZkTE9wekswSmFBRDc1MXA0aWtIYi96SWgx?=
 =?utf-8?B?MTZTM05pWkRuanZxYmV5QjBXd2NtOE5ybE9mRmtWdUpGU2lTeFpVK2VSNTE2?=
 =?utf-8?B?MmdodythZGR2QVBSbjl5WlB0c1k4U0M5WlF1clVyQnY4WlNQRWRYTFZDdkc2?=
 =?utf-8?B?YU5aMzJxeUw4NDVqOW5KdTB5N0ZYS3BsRzkvQmZJUmNNSWZDU3kyS24zWisz?=
 =?utf-8?B?RStHenNkM2t4cVRxVnBPbUxHS3B0RmFNRFFtRkJwbzRiTTdITkFBK3d0Mk5B?=
 =?utf-8?B?ME0vQStBdG56bDZ2b0drRllFTmhjWm5mOWdLbUpoeTlvYlJIeTRKYlR2cC90?=
 =?utf-8?B?aUd1cVBuam0wOTZhQ0NzRnd5SGhib1lud25JZjRDbHk2QlAyNnlGaEpXYjlT?=
 =?utf-8?B?dklFMW0xQTloNEpFWkZ6OE8relZ5ZWN5MzI4QWFxSnZkbmg0R3VyVDRlMVAw?=
 =?utf-8?B?N3lWRjZpT2hMVGFIcitpSWVSK1A2TEJZa2E1dlpXbFJVeG81bVlYSlBCVzh5?=
 =?utf-8?B?U3Q0NFZkalBxbmsvNS9hRk9PUENmWFRrcTZDUVJVSFJaN3NzVmNWcFZmZk5L?=
 =?utf-8?B?NWZEY2o3eWFiL3FNcTNlVGI3dk10aFFXaWtoUFE5OC9QaEx0TUJ3aGlkcTBR?=
 =?utf-8?B?UWZ1VlJXVEx3OFQyajRuaXNvbWcwRDFtTjVBNXV1SGxZTDRkUVZVK3MyWFJK?=
 =?utf-8?B?TnNyRnRwa1BHVENKVGtWanMvNFlGNFBWeW1pVzlQTUhHK2lFL3IxNm9jMkdD?=
 =?utf-8?B?YjdPMmhQWFREVzJLeERDQUErdkxJNG9Ib2gwdTJmU045R2R2ZTdXTXhKdlV2?=
 =?utf-8?B?ME0wdTE3WmphSmVITzlBTkI0ZUVIRHNyRERxQjJtVmlvckFUMU02Z2hFT3h2?=
 =?utf-8?B?T1drdXJoUlhjTUQ4WlMxbVZWRFIxUW02NXBTNTM2RS9oZENES3k1d01PZldW?=
 =?utf-8?B?RmtvRU9iWWZiZjdadEV6TFpuV2FZeFRYRUphUmIrYTJBaS9DaklWUzJGVE5r?=
 =?utf-8?B?SUJWUVg4azMvUFd2clRTdmVLZU9WaHNPWjloWkUyS014Q2pkNVpiYzlxWEFR?=
 =?utf-8?B?VDRQZkw3aHZhWFpWZVNORWpZYW5RUU9BeU9SOTUrNDQ5L0lnWjRjdTMxWE0w?=
 =?utf-8?B?Yy9uSGs5SnUvK1pQaHFpcDUvQmtuTGw5WW9jaXBSbTJjRlpHclg1ZzZweFZG?=
 =?utf-8?B?aEpvYjRKZllMMU8vWHMzUmExMlpoVE13ZDJDMTNsV3doNVp2MDR2NFlzdzUv?=
 =?utf-8?B?TE90QXU2dld4S0EwQmE4cXFLS1JjS2hKczNONnU5eWZ5Q3hjd0pmVUNDcHRi?=
 =?utf-8?B?K0llaExLaWhsY3kvNDhmMXgyNlpod0JwdTlzVitNZWZKdVlJMDlnYW1hNHpj?=
 =?utf-8?B?NE9mQUFNdk05QW5MdlpId0h6cWRuekpsdDhoeEN3SURYNjVJOHhNVlFTZ3hP?=
 =?utf-8?B?Mm9CeW1HWjJ5UG5qdlB2Z0ZyZ0p4ZlBzR1AxTVZ6d3hFK21iK3l6OEQvS0VB?=
 =?utf-8?B?T25GVnIzSG9YNmc4bEROcksrUFVHSGwrOHAxWDF2UFV1aDdqQUQ0TUNVQ2pT?=
 =?utf-8?B?TjdXVCt0RU5reHFhSjBvOUJwVFA1Znh2cnJhQ1RnVkc0bFgwVjVma2FwdTJW?=
 =?utf-8?B?dEFGWE9DSnhBcUZwR29CeGV6Z1YvZFJ1K0NCNTd5THFBUHNET3JUM1ZFOENB?=
 =?utf-8?B?R3hHVE5CR2gvWHB2bkhaK3NrVGpqOURHUDlzdkpoV3U5L1lYOFVCNk0rbmgx?=
 =?utf-8?B?cHlISE5FdFB2WjVjR0FMdWNXT3B5M04wcnU5SGxDbmEwUVRQVm9ybnBYYzcv?=
 =?utf-8?B?NHB5NVZQVlBUV0ZyWGt6enlEVE9MdTZ4TXpCb01pcDVwSFlKRlhaSEg2UE5v?=
 =?utf-8?B?QXYyREQyM3VzSmlqSStCdmRpR1NkY2x6aURXdjgxQWlwUXBEd3J3VnRnVFlI?=
 =?utf-8?B?SVBCd3NlMzdOQlFBbXdjNW9ZVkNXVi9vc0lDd0xrZXFWbDhudjR1dzBLYk1D?=
 =?utf-8?B?VXR3SkhnSkd0bFIralc2dE5uaFZIOUNQQm1lYmc5eXN5alZxbm9rbUxmUjlM?=
 =?utf-8?Q?5SPRmMO9mZQY4QvNTSB+UnwVP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8064e2-ce43-4850-25db-08de3110cec7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:35:39.3216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0nIAzivX+49hYiHEKwSinZBgkSMiQz4KJdLCEj5JzOHffxm1/16xM02t9LeWmuuuFvdccc84ezXjIDXfLBTsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361



On 12/1/25 12:25 PM, David Hildenbrand (Red Hat) wrote:
> On 12/1/25 18:15, Pratik R. Sampat wrote:
>> Hi David,
>>
>> On 11/28/25 3:34 AM, David Hildenbrand (Red Hat) wrote:
>>> On 11/27/25 18:40, Kiryl Shutsemau wrote:
>>>> On Wed, Nov 26, 2025 at 04:27:29PM -0600, Pratik R. Sampat wrote:
>>>>>
>>>>>
>>>>> On 11/26/25 5:12 AM, Kiryl Shutsemau wrote:
>>>>>> On Tue, Nov 25, 2025 at 11:57:51AM -0600, Pratik R. Sampat wrote:
>>>>>>> The unaccepted memory structure currently only supports accepting memory
>>>>>>> present at boot time. The unaccepted table uses a fixed-size bitmap
>>>>>>> reserved in memblock based on the initial memory layout, preventing
>>>>>>> dynamic addition of memory ranges after boot. This causes guest
>>>>>>> termination when memory is hot-added in a secure virtual machine due to
>>>>>>> accessing pages that have not transitioned to private before use.
>>>>>>
>>>>>> How does the hot-pluggable memory look in EFI memory map? I thought
>>>>>> hot-pluggable ranges suppose to be declared thare. The cleanest solution
>>>>>> would be to have hot-pluggable and unaccepted indicated in EFI memory,
>>>>>> so we can size bitmap accordingly upfront.
>>>>>>
>>>>>
>>>>> I'm not quite sure if I fully understand. Do you mean to refer to the
>>>>> EFI_MEMORY_HOT_PLUGGABLE attribute that is used for cold plugged boot
>>>>> memory? If so, wouldn't it still be desirable to increase the size of
>>>>> the bitmap to what was marked as hotpluggable initially?
>>>>
>>>> I just don't understand how hotpluggable memory presented in EFI memory
>>>> map in presence of unaccepted memory. If not-yet-plugged memory marked
>>>> as unaccepted we can preallocate bitmap upfront and make unaccepted
>>>> memory transparent wrt hotplug.
>>>>
>>>> BTW, isn't virtio-mem a more attractive target to support than HW-style
>>>> hotplug?
>>>
>>> I would have thought so as well, such that we can just let virtio-mem take care of any acceptance before actually using hotplugged memory (exposing it to the buddy).
>>>
>>> Likely there is desire to support other hypervisors?
>>
>> That's true. We are certainly thinking about how the RAM discard manager
>> should look like with multiple states to allow guest_memfd and
>> virtio-mem to work together.
>>
> 
> Right, there is the QEMU side of it as well.
> 
>> Since both paths in Linux eventually converge around
>> add_memory_resource(), based on some light hacking in QEMU I could see
>> similar hotplug behavior for virtio-mem as well.
> 
> For virtio-mem it would not be add_memory_resource().
> 
> Whenever we would be plugging memory we would be accepting it, and when we would be unplugging memory we would unaccept it.
> 
> That is, acceptance does not happen at add_memory_resource() time, but when virtio-mem asks the device to transition a device block from unplugged<->plugged.

Ah, I see. Thanks for clearing that up!


