Return-Path: <linux-efi+bounces-5735-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F230CC9877B
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 18:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9890E4E354B
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C25337115;
	Mon,  1 Dec 2025 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lDuoWQTM"
X-Original-To: linux-efi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE34337111;
	Mon,  1 Dec 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609349; cv=fail; b=nga9XsCKMFbk9rClt6ajMAjxO40GhZfLesnAy+0C7NaiPLXczGySOuNtX0p9bx0DS7dnaYegtVI2dcv7Wnywq123WP1A/EDsuOs3rR1SLrgtHLWMropfe34134TRTnGfUCkDbap+bTOQ5eT9K2PDbZpeH8Ncksr/mZkD6BA9IF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609349; c=relaxed/simple;
	bh=pKBiBpZpuOLfVGqB6vU95LfOdobNL5PesNJBz8BlswQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdM3JPW/AGmR1XmKYYKS79TVTUdoqWFLXV1yJZyIjUdiY6USjPVvTk++ucoxBY5Lq7mMjqnkTWWKThzHnEbmap6q5TtGJ47K12iKI03AGSQf3pVPSQYw0W2QLa+zO5fy7+t5hev1Hqb0wEr+PbhctUJ3p+6iSfmn1hiqphAebeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lDuoWQTM; arc=fail smtp.client-ip=52.101.62.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCqPNxpNosGJBqSjq+gXcyZLCItlVdy3sXRdmXWXCyGiNve4NutC8VJouNpSrYbd8oHpjjD0v8OF//r+3yoH0X/u7aPwFznvS+RDL8QxpOPeQsB3HB+kd66ckXNCvMfG5iyQcUlUTaE7bKBg93Pa/v8nzGJeHtYWyj1AEqnHZMCpjIaKJpUhjfTzExF2INEJEzKCjYJfFN0fmUHMcQo7cfpIVr6o2iYQfwVfPr5Y5es640XodvJRxp8/iezaWZxLAiOWL5AkSjhsdME6gJ4ptgOG3Z6GWhVZGrMMrNtNm7xAQeHW4Wg0/AzyFDgh0LvBR8tCtXFUd0kcRmdCPdJtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJREo60fbeChd1YJS6kLzsbePZ6qr0f9f5dAzY3Wh6U=;
 b=FMZDHuU80rPdQOdIJPzYTbnGX+lpMipSo6AtwUVqHZKROIaslHQwPN8Y02MjdwPeV/oti063vjApTV3EIWU1swCNKQwz2BVvFt/4Vrh6R9q7RMtxq1ZxwoAXsdWUiDOH8SlJ6Zfb/JhgNxC8FLe+yJ10W21kySsRMvuv1uqPE3FDPcZf/QudYv39FomaTd7Yife9cs3whYJXWmIedrJ9Sm+zUYJ5Oq841GsH769MoSYnJNgHb42ucAZT+Eeloi+TTWU2kCZT0QGgjltUtLTQRo7bksCVWIkEnUbhNifYnCCtOegBAFbI76Wn3suofkgdbJlmoJW5CWON50lORrnYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJREo60fbeChd1YJS6kLzsbePZ6qr0f9f5dAzY3Wh6U=;
 b=lDuoWQTMcTrZHEIeoYs8xsqVo+9peJ4pwyfMjz2p2IU9AtqRTyj0i0HclNrFvXVa8MStZbCsKCgWriH16Ws+dOO5KyMJ8FcsDSvGsd1ttCqgu7H/qEYeyXi9rZc3Hx9a+HKe9A9J7CTrlGtFeDSPUkbqxVfaJIyOI2u0qBZvX7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 17:15:43 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 17:15:43 +0000
Message-ID: <c8926ced-3ef3-4c11-9d04-00db388887c5@amd.com>
Date: Mon, 1 Dec 2025 11:15:41 -0600
User-Agent: Mozilla Thunderbird
From: "Pratik R. Sampat" <prsampat@amd.com>
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
Content-Language: en-US
In-Reply-To: <27c06cf2-7500-4875-bd22-f55571fb85f9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0155.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::25) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c00fce-7f27-4034-0fb4-08de30fd42b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkNrbTdCVmd2cHBLeDJSSzg2eWRrbVVPcitDV1c1T2lhWnUyWXoyUkcrQTNi?=
 =?utf-8?B?UTlhZ1lNM0pkUnJidUJzQ3gybWZrK0NnYWJIL3d0TWkxc2NhMWpwZ1hSRkZn?=
 =?utf-8?B?TTNMZzRvWmdBaSs3TEw4aktnWExaVTdLaVd6aEZOclJ3am9QY1c1WDdvQVVX?=
 =?utf-8?B?MWFlcHpKTEpyRmJObnhpUmdjSUdsYlU5d2ZSMlJFNVlaTWh1aGE2Q256YnpM?=
 =?utf-8?B?RzRSeU9ScS9tUHl5dElmQ2V5ODdtL3o2SnFYMmthampDSkNER1BrUlI5L2dw?=
 =?utf-8?B?ZndEK3I3Um5oWDFObTVwdzQ4aTl0OUNLTXNGUXRPNGp1SmhzVXQ3cTBDN1pW?=
 =?utf-8?B?emtTVnJPSU16U0g0Z1N1YjJwYVhRYzQzMW54R1VPL2R6L0s0azRiMmxoODZt?=
 =?utf-8?B?Z2x4aHA3aHFtd1FFdDVKTFV2b3V3Zng0OVVKYmFCOTQvWkI5NTZnS2NIcUhq?=
 =?utf-8?B?NGp2OWxxNVRoT0l5QWNNcjZnbkgzOG45c284M2Job0l5cVFsY2gzVkgvaUNz?=
 =?utf-8?B?STdObmhWQ0llQnYreHlEdmZWVzRobjdBRVBULzNGb2RoRUtJbDlqcCtvMkZH?=
 =?utf-8?B?anZNMnVVS3pZL0RtSE1td1phSHFyQnhPTnJYNk9hakMxZy9SRExlN2VjUWd2?=
 =?utf-8?B?REdNeEcrSlVDUExmWXcvNWF1d1VlNlBLVDRnRGNQQXFxMW1OZWF4M3JVQm9r?=
 =?utf-8?B?SkVhREhkeW50QU02b0Z4MEg3NlVqMExYbHI0RVVMRzV3dFVqWWdsYTJFSnpL?=
 =?utf-8?B?bXlVMHo0ay9XREI5Y3dxNkwrS2Z2QVBZbnpmMnFySnE5QnY1Njl4cTVSeFZB?=
 =?utf-8?B?YlpMYUg5Z2lvQTNFM0wwcU4vRmE2MTJEd1YxSlZaT3NSKzl1cW5xeUJEZlFv?=
 =?utf-8?B?MnpaWitlekxnLzB1UkN1UitRbVBINkNlTkt1SktPWTBWTzlhcVN2VHo5Tm9D?=
 =?utf-8?B?NkkybkhTR2s2TmFiWTZoUDNQQytFblRmNU5ieTJQU3NZam1aVm5BSnQrWTdk?=
 =?utf-8?B?eXVTdUxnaGkyMyttbGJtekVoMEJpRzZncDk0Q2RvUE05QlZPcjNYeGRmWk1X?=
 =?utf-8?B?VlF0K0UyeG1rS3g3dzFnZ29JRkdLbXhkejd6bUU5dWlSTjhmTVRHZm04ZXp6?=
 =?utf-8?B?bU1paUdBU2ZZV3dwMGFlb1Vabmc5TjRtSmdENkN2N3hURDN5ZTBuTUp1T1Zs?=
 =?utf-8?B?N2xuTi9Kc2JOU3B5U3FJY3Y1UVlYZ3VxY1ZrbkdRallMZXNiWmlha3lMTnJY?=
 =?utf-8?B?REI4OTl2dWdFZFV3QmF6Wm9JM3pBbmx1a1AwZDR3QisrRmh6Y3BtNzJPRXNH?=
 =?utf-8?B?SkJyYlRsL2liUVdQdURsVlYyR0N1aXVaMHhPNGZQZnJUZHBmWE10TEMrL3Q5?=
 =?utf-8?B?VjdKSkpVc3hscXI1dGtndjYyd1hmQWNsTzhqWGF2S0FBRDhXbjc3WmtTODJu?=
 =?utf-8?B?MUNuOHZtcThwM1hseDlCWDZFR0lPRFhCWWtwUzlmR0pnazhzUXRHKzJYVVRJ?=
 =?utf-8?B?UjErWk5OK2RHbHRjVUl3VmNMRTIvblNOdENTTHdUVVREdktzYngwUmd6dklN?=
 =?utf-8?B?bFZvWjRoNm1BMzV5VjFhOWpjYW9VK2RoQW5rd0M0U1V5Wm5uSGtRVkprVU45?=
 =?utf-8?B?dDRwczNVK2RacXVTNUJBOWp6ZUdJOHBzSG1FSHNaTmMybmZZQWtXcmU4OXE3?=
 =?utf-8?B?V0pZcHlWUGRpNk5kSUxETjhqVmpOcWV6MGtocXNXNHRLd0x6a3pwTSs4bWUw?=
 =?utf-8?B?a0tWMmRGNVV1dkNOdW43N2E5bVJDbFlFaVJwekhHNmVyc1B4bTJ4YUp0bXYy?=
 =?utf-8?B?d3o3UHBPeDlMd0V4V0NNMGJmMWlXZEtSMU4veE0veGZ5MEhDMDhWL1doQ3Jx?=
 =?utf-8?B?K2h4MVdGdk0yQUxPOUNEVGpHQWRsMHpYTEVpcG5nS2ROc3ErdWJKd1k3eFpY?=
 =?utf-8?Q?mMRYMI6picDvm+/bQsRD0npztwPaTP7z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlhiaE1hOUEvSE1OdGFyU3R0T2VpYW1rTVJla3RzKzNjQzFRazkxZFM0anJN?=
 =?utf-8?B?Q1I3d0hINHR5QzZuVGRRdHl3SHJ6c2lwRkR3Wm1pTktVYmxRZXNPaU0rSnlF?=
 =?utf-8?B?RXMvYnJ3STNiaUVqWkkrSG9JZTVrN0I0MllZZHNTU1BzcFFYdlVxNWFzSW1W?=
 =?utf-8?B?RmhETGxlOVBkbi82V1cwVFVpY3JPa1BGN1o3MHpxN0JyOWdnanVycG1vYVFz?=
 =?utf-8?B?Q1o2Y044WmF0SC9FdXJ4ZE9tZzFtV08yYU53MDZvbFdwT1dZdWtDRisxc2ZE?=
 =?utf-8?B?V2dZYWlPNEdMNXdkTkxHNnpYRHJzanZLYXIxUlIxL2tHa0lUdURWdjAzVkRQ?=
 =?utf-8?B?MS9LY2IxZUcyMDQ1MGlmVUhwOHdVQjdIUFR3OWh2Ris5TzNHRjUweXA2T045?=
 =?utf-8?B?R2lQQlg4M2VPZ01rZkZ3MzdZMmlFSE1xT3BiZzFaYmVWYkYxRURBM0hEamZn?=
 =?utf-8?B?K2crVElmK3pkNUtCS3lYOTcrTk1nWkM1SVlUZHJsNjd5NFNwdmIwZHhvdTRG?=
 =?utf-8?B?Vjk4THBwT2N0UmNPTGdqelNVY1Ayc2JaZWFXc1BMV0JSTjREQit0cEY4UElw?=
 =?utf-8?B?QURvYVEvRnhsZitQSXMrNktKSFhyTk1VdHdqSE5qdnFnUG1yOUEwbVdlT1p4?=
 =?utf-8?B?WExmT09Ob0o2RCtXMGFSQkdtWGxHL0FPQjkySUxEclBoc1I3ZStLOW5GNDc5?=
 =?utf-8?B?RWFlOTRQSmE2R2JYdStuenZjNDVZZ3BHdUhrUEREbko3c1JhblNnRDBka3Ay?=
 =?utf-8?B?K2g4Y2RNdDhjLytpTVZYMmFhUkZRK2NTQ001dHlKVXVJY0l6U0JBVDd2cmRL?=
 =?utf-8?B?dGhxd3ZVNFM5MEp6d1VidC9xWmNrV0FyZDU4dDBqaG5SdzRsZnNOS0JyaGMz?=
 =?utf-8?B?aGd3SzNndm9kU0ZPYmZVajlYZStuVzhzRmdHaStJclJxazRLcElqNXBkVVB4?=
 =?utf-8?B?am1IZWhNR1JXUjk4a1BlZTdyb0hzVFMwZzIzaitBYUlyUXBnODRjWHVaaFlC?=
 =?utf-8?B?dm81YlNiOE5kTzdKOXRvMFEwZ0pZV3RLMU44ZURHdUE2RHgxdi9wcStKT0FX?=
 =?utf-8?B?NEgrNU5nOVM0bXdxSzlUU0ppS0VmaWVERGFBZk1ZeXpZQ3p0UnhNZ3ZqbG5S?=
 =?utf-8?B?SHVtV2dwTXlYLzB5UFUwM05RTHl4Wlc0a0JoTlZBY1RmRitINE1WOUhlQ3B5?=
 =?utf-8?B?cUhWdmVzM2FBNklwSWpBR2Y5bzY1aW9LcjN6bXh4cVFsUHorNEh3WFdDdlNC?=
 =?utf-8?B?MElxempSbXFZQnNCbW5kdEFwY1BIRXc5WWwvL0pEWHhxQnlpU2tDbnZqWmJM?=
 =?utf-8?B?NjF0R3luZGZIQlVLMFlIL0E0R0pKRTFubnNsOE1OWlA1NWxPNVZTRVlHemg3?=
 =?utf-8?B?Wk4wcU1OcGMxbDJ4MTZ1Vk0raXRQaHMwRTA1Y0d0OWUzWXB3VjRvcStrdzhx?=
 =?utf-8?B?cVVxUlNucHp3T1d5Wk9rQTRPeHcrNWVxNFg1cVlxZytpWldFV1JJVkFVOVI4?=
 =?utf-8?B?cU1MM2szSjc5WFltRHZyWTNVZklra3hVdDVYNzJMYk0yazlRZGZuUkF1dGRx?=
 =?utf-8?B?WU5TSlBZTVcvU2doZjVmcHNvN2RHWVRCdlcycy9zUWhtWldMZktCdnpzS0pk?=
 =?utf-8?B?K2RTQTljeFJrK21qVkZMZmc0OThXS3g5bmo2dFI3dUVNOFpITHpUQS8zWXJs?=
 =?utf-8?B?WTNwMVBmaEh6NWh1K3F0cWoyNlZjTnlUY2VBTWIrWlhQaVFrV0RsWWFaVnR2?=
 =?utf-8?B?REdzZC9WL1F0bjZodUprakNwbmVrRk0rVWdiTDZHQkdzVEpFcUsxOEpGUmtz?=
 =?utf-8?B?V2lqb3FSbXNYeTRKcXVqVmZIMGRuTjJ3TDkwdVBVK3hTcmRubzVZaVVMR1kx?=
 =?utf-8?B?Rm12N050NkF4YWVsR0JBSEYwdk5Ib2w1RnhkU0R0VTBvc3ZESDBrS29MU1ND?=
 =?utf-8?B?NDFBYjNFdGNudFl3b1lndkJoTjR6WGNqZFB5eDN5K3Q4aUdWM3pwMTN1UUE2?=
 =?utf-8?B?eGZrYy9QdEt4OFUrVm5lM00vZWZSSGViakprL0wvU3JDS3p6MXZ3Z01OdjF1?=
 =?utf-8?B?dEVXeG8vUHpXNWVmVDVqSno5cWRLWk0xazZRMzFqT1BqRGJ2UE13bWZNRFRM?=
 =?utf-8?Q?azUELi+0cX5cxdXEH2Q5LUpsP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c00fce-7f27-4034-0fb4-08de30fd42b0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 17:15:43.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9sk87ECzZwWbRfqGqqyqe7uIrhwL3wRIwItmWQuajvKLf6YA9SYFQ4klZG2bi6vDAyTbOraKYUgoViIh27kVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389

Hi David,

On 11/28/25 3:34 AM, David Hildenbrand (Red Hat) wrote:
> On 11/27/25 18:40, Kiryl Shutsemau wrote:
>> On Wed, Nov 26, 2025 at 04:27:29PM -0600, Pratik R. Sampat wrote:
>>>
>>>
>>> On 11/26/25 5:12 AM, Kiryl Shutsemau wrote:
>>>> On Tue, Nov 25, 2025 at 11:57:51AM -0600, Pratik R. Sampat wrote:
>>>>> The unaccepted memory structure currently only supports accepting memory
>>>>> present at boot time. The unaccepted table uses a fixed-size bitmap
>>>>> reserved in memblock based on the initial memory layout, preventing
>>>>> dynamic addition of memory ranges after boot. This causes guest
>>>>> termination when memory is hot-added in a secure virtual machine due to
>>>>> accessing pages that have not transitioned to private before use.
>>>>
>>>> How does the hot-pluggable memory look in EFI memory map? I thought
>>>> hot-pluggable ranges suppose to be declared thare. The cleanest solution
>>>> would be to have hot-pluggable and unaccepted indicated in EFI memory,
>>>> so we can size bitmap accordingly upfront.
>>>>
>>>
>>> I'm not quite sure if I fully understand. Do you mean to refer to the
>>> EFI_MEMORY_HOT_PLUGGABLE attribute that is used for cold plugged boot
>>> memory? If so, wouldn't it still be desirable to increase the size of
>>> the bitmap to what was marked as hotpluggable initially?
>>
>> I just don't understand how hotpluggable memory presented in EFI memory
>> map in presence of unaccepted memory. If not-yet-plugged memory marked
>> as unaccepted we can preallocate bitmap upfront and make unaccepted
>> memory transparent wrt hotplug.
>>
>> BTW, isn't virtio-mem a more attractive target to support than HW-style
>> hotplug?
> 
> I would have thought so as well, such that we can just let virtio-mem take care of any acceptance before actually using hotplugged memory (exposing it to the buddy).
> 
> Likely there is desire to support other hypervisors?

That's true. We are certainly thinking about how the RAM discard manager
should look like with multiple states to allow guest_memfd and
virtio-mem to work together.

Since both paths in Linux eventually converge around
add_memory_resource(), based on some light hacking in QEMU I could see
similar hotplug behavior for virtio-mem as well. So I thought I'd get
some feedback on the Linux side of the design since enabling it
for traditional memory seemed like a simpler first step in enabling
hotplug.

Thanks,
--Pratik

