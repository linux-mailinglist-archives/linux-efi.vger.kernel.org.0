Return-Path: <linux-efi+bounces-3351-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A03A92241
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 18:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E827A3D82
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF12C254843;
	Thu, 17 Apr 2025 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l+Sm/shU"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B41CB9F0;
	Thu, 17 Apr 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906111; cv=fail; b=KQ7u1fJ9xisFl2BVYst+Omd6kdCoZ+m+/3qErAmaDfLWPd9DiS7FAyKWSruCd6O5K0pGk0jkt8PKfYgUZg8n05xKpsqm7aRVlgX63bsu0LWXvNVkRMVzSkhk0n+qEzcHPZ1qGwsj2c0kWvBIwXJ2zvgHjuUy44NXzosoOudoG6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906111; c=relaxed/simple;
	bh=MJd2F1eZj2Zeg3iGPXN3Nc2XSDm6PuKVVVCQ0P1MV/w=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=Rlp6CocdLMI5PT9agdHW6Edr8ekXAAu2tc2a2tjMy7dAd92utN+dKmbLvLDgscsuIWrINQ0LeDDiCxxETEnLCAHh2AKFnTuN+BvRzsAy5ug7WJX/SMR06EtIZVSwq3pkZomXUNVbR8h6uzDkgbXW137R+dKmMphapMB0+UZABIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l+Sm/shU; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOZg1FgjNWV76l3RcehrzGXHD8RbhMNIJjXrZqpa9i9H2tfIDh1fdCPOLdHVbBR8mUk/Yl30HxYRoXjHRXL6ziqBMxbV/qqqJ77DghL2ol6z+dylKQdo19P06mmwB4e0nV7qhvAXgbRIczcblFaBkvq/aTl8uUSpIMcc6+EfhJg4W2axQjRiENClQ38eDT+lENMPotVTp4jVZ2y1aSwY5mp65gbDcoT58TRYRutfhLtUT6RLRCoBY/1hltmh8p1QBER9mQ3OLS/cnfwDK3vrytlRDyOv3PHJXhSJ4cCr2CPk1Tg4gMVb9tVZiX7bQgjwFRSoxONM1P77Lumo6mohuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF7R9/shulS14B/tn2zCgmdm1jgNBpLQjEGTl2io4Ls=;
 b=XQpQsEZ0qEkVzpUOLwvA47JGDnTYBcdoqGaAaQYLevnyOPycUyHSuuc+e3afKi+yLFlpbrnRd+4KTyuG/+/0Hlao63K96jZXLt2W3OHjrcicXsNLWkyFYtEml+hJH+t+srsrxeDpyz1ZKwKfvFWqfkrtEJJIXBiehLYXxYBhEFxOMytue0vntHYCWHSeP+B4TnpezX5B8AeJpANMVE2J99Iny20TlmvM0d+5eC/9ZApyk0VmlBiSCZ+WTnM7HDVR81V39eM6ilH5Xn3pfRXv9FJWSgJjHn3Y8ssGzLq0V/bl9vVilP9PE8UfZWw5vGMup3e8nMjm1HgUbL90FynEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF7R9/shulS14B/tn2zCgmdm1jgNBpLQjEGTl2io4Ls=;
 b=l+Sm/shU5R+Z8Pv92KrKF89C/imGqme6LPfeXi8xEWp6Z+9E0WO0PeaMgixtuLVU+BEy2H4vQyYIk9TQU0Rt5Z4SOj6fCdXw2G2Q2+b/RuIczY4eMcrJXkRJfmynhkOzDLH7wfs//qKPI0o/4nfOpW72vYEIgJcxd/vLhk2EAWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 16:08:25 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 16:08:25 +0000
Message-ID: <3f2b0089-a641-1e0c-3558-0a8dc174d1ec@amd.com>
Date: Thu, 17 Apr 2025 11:08:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20250410132850.3708703-2-ardb+git@google.com>
 <20250411184113.GBZ_liSYllx10eT-l1@renoirsky.local>
 <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3] x86/boot/sev: Avoid shared GHCB page for early memory
 acceptance
In-Reply-To: <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::12) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cd8bbd-c3e5-43f7-9dc6-08dd7dca154f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGhRaFN6N0dkSzVDTEhGdzdJOUYycGdJcHIwWmRoTGcyaGtCbytYd0tNbHk1?=
 =?utf-8?B?OUt3eWVhaUloaVNBcytYMWk0NjczanpSRlRySzF4NzJ4RjZmaUlLYlhnVFpa?=
 =?utf-8?B?VXZaeXVYUFNGcU55MTJzSyt1cndFZDhMQlRPM0N2UENGVkUxYlpZbURLalQz?=
 =?utf-8?B?SC9wVDRlWjA2YlVBeHNSQUJMMjBXTGRwWFpidFZFS2Z3SWp3a3haWnd3UkFT?=
 =?utf-8?B?aHVFblAzSFNxU1JNZjA3bTJHRjRSNjQwalIvRDM4bkJOeWhFdzNhcGRxVWM5?=
 =?utf-8?B?QmE2ZkRhVkJPcHA2T1BZR3FyQytwN3RoV0tuU1VQVU5QZTBGUk52NjRxTDFD?=
 =?utf-8?B?dHVNekNJSWtwQnZXNTJBVTU0WkF6bjN2R256d2Z2SllmYy9jQ3E2R0xWU3Jm?=
 =?utf-8?B?S3ZFNzNoSWUyVUcxdVVmTDE2UnQxdVFpK2ZsanFjaWR0aWNtZDBZWVdKRWdx?=
 =?utf-8?B?SWVwUkpzdDVGMEFyNGJ3L0phSFBNZ1dPVnB0VWE2N2IwRkJTbCtFSWJZcXUv?=
 =?utf-8?B?WGNkWk9QaDJ6NWdrcFY1SjBnZGhlQUlRbjdmT1RKN1NkL1lrdDEvenk1OXRn?=
 =?utf-8?B?LzRabG1ISFhzb0kyZmNDTC9Xb0cvOE9IN0hKSVU1MlBxaXBSSWNxYUxNbmtY?=
 =?utf-8?B?bE44QlRzSmF1SUpiWU5TaU1WS3lZdXRxZlhWYzZSMU0rL0RVbVpLN0tRWjFV?=
 =?utf-8?B?WEE1RjZYTkVzTlg4M0lDMmdqbWFWOFdqbmpVNXM1MDA5V3o5MFJPQ0R5bUFZ?=
 =?utf-8?B?ZGhEOTQySkdxQWQyeVZlbXltQWZiRFhFUE9iNzZNWVd5TGROeGF2a3c0QU9F?=
 =?utf-8?B?L1JGQmNDQjFaM2Q0T1ZvMEIxNVFuSTQ2Uk9LK3ZtZVpJRDhMWGNyK0pMNDQw?=
 =?utf-8?B?VWVmdnJGclcxeUhGc25aS3JDbUx4MWZCb213L1pYVzM4aGEwbG1acGdrUHpu?=
 =?utf-8?B?TFBnSzlBeUNWZ2hnREEwd1BhcURISmFuMzR5bjNyaEhkcU43Mi96SWZmUkpo?=
 =?utf-8?B?STNnRXZkWnpmejR2MDNrQmZTUElwQjdQbnJHYkhYSElMdCt6TjNwYk90NTlE?=
 =?utf-8?B?ajdiL0Mvams0SXRiN3VVZTFNdUphMGhtcmxsRWdpdk5DMXRMQmVBWVVOVmFC?=
 =?utf-8?B?bHdBT3hvaFRrK0JuVk84NE5lemF4a3lDVGhVQlZQc1F4QzVTVENvWlFXWW5l?=
 =?utf-8?B?MmhEM2RHTlZNRzZHUDFyOVlhd0FlOUEzaTlNdzJNckNsaU91VG9RSjRIdG8r?=
 =?utf-8?B?dmZFeXYxazM5ZDFsK2VWZVVpa2tTTDYzYWV4MUJUSXNsakZLampyNXlFMmRw?=
 =?utf-8?B?MThsR3daZ3FmTjYwYk5hRWZ0N09aTjlnVTEwQ2dGcW9JUU02dkJEOWpwdnNy?=
 =?utf-8?B?TUJMNktTTWR6TFI0dzFWdDJOekJrcEtNT1hkYVJwNW42N0pmOEw4SGJ3VkVO?=
 =?utf-8?B?S3NhbTR4ZnIwamYzNmxiNFBmaVJSUkRwL2pnamlPTTl6VHcvZlJRK2trK3Zz?=
 =?utf-8?B?V1NaSTduVVVDUTNWWHc2MUJwWlhzdTE1bUZZTjE3c3o0NkJ1bmhicG5UTVF6?=
 =?utf-8?B?eEVJbGEzVE5NOE8rYWh1aFhvZGlYVFY2MEI4SHYzY3pBdVlQSjlxbkc3Z1VS?=
 =?utf-8?B?YnlHMzI4Mkg5QXBVMmdHVGJOLzNEYUNzcU9uK2dTUXlOSFFtYWI0N3JGNFpR?=
 =?utf-8?B?c2E5MjNkYlEyc1hLa2hkMzEzVlVDb1duM09MMmRCR25WWWhJcFUxS0dpN1V0?=
 =?utf-8?B?WDNaRWJONnlxa2JtVWJBWmo5eGpvaWREKy9yQnQwSmpJSGFKNTVVSU1PWFhi?=
 =?utf-8?B?Y3VwYlBja0tuZ1h2ZmVLcFJQQXc5SUR6eERDcENneXRYek1aY09Md3daTmtI?=
 =?utf-8?B?SDBXTW1TZnQ1ZlI5TWJsR3RaS2RIeGhVWEQ3THRhRWxBL2tSQ2M0WjNValVT?=
 =?utf-8?Q?ZYT2HM8Tfvs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnJ2RWlZRHZxVzhseXg0cldGcWtkeEpnYzVGdkYyOUsxQzAwWlVlSGM3Y0M1?=
 =?utf-8?B?VkhvVnNLVmRVNERiRWc3Zm1rOWF3Y2p3L3U1VXdqMXdJUXFOUUE5SThxVTd4?=
 =?utf-8?B?bHl0SHZiczZWWk9KVVo5M01QNFRodm16MkcwVjQ2YVkvK2IxWU5vMFlIQmla?=
 =?utf-8?B?Y3A0SG5tSWhNNjE5VUx3c0gwZUswTFNSZnhLQ1padmRzSjE5N2dVRzZyT3BZ?=
 =?utf-8?B?cVJSQTAvMkRzRFhQOEgza3FMWTZGdFc5bzNVUEpHbmg1M21KQVpDaDhTb0pC?=
 =?utf-8?B?bmE1dlBJYkxzYk54aldkSFNOS3ZseW5kMUZERGNVcStDVnF0QjJJSStNTGFl?=
 =?utf-8?B?R3N5S2NicC81VkppTUZRMmtuSjcrMjdlN3NyQ0xmVlN3Rm1CU1Z1UTZ4VVFO?=
 =?utf-8?B?L04xek9NZVBod0ZseGtqL2lSOVNBanRCTVdXdTJmMkNNMzdPclhlTW8xZGJK?=
 =?utf-8?B?c1ltbmpUa0Y3TmhvQnBKVVFBdlo3RWRjNTdnSU1nc3ZRNThRZ2ZGemdEdDJQ?=
 =?utf-8?B?Z2ZOTitQUUk2U2pkeTE0WElJOE9kUWFmNDFRbTRIWXVpRytka01RTjNWOGpk?=
 =?utf-8?B?TDZ2cXNvVTZCYWp1Q0gzUzhnTExCd0g5Y004dXAvVGM0d0dKbDdnSTE0L01n?=
 =?utf-8?B?NUVhU1NKNzlOY1BJdUVDLzJQKzZHaE4wQTBFc0pCRGE3SU5nTjYvMlN5cjEz?=
 =?utf-8?B?ZHlNTjJ2L0ZYM21zSUZNOTM0dHJhSU81aXBJSjgvK3NDN1FUMWJ3WTNJZkxQ?=
 =?utf-8?B?U1ZkYUhoeVZ2eHpRVzJtdk5UL1RLU2hkV1pOa3BvblZnOTlIM3FLb2drdlpL?=
 =?utf-8?B?SlRwRGpqdzFhSEJlbC9XR3RKczhLdnRyRzd5Q3hqamw4Y1EraC9IUlgwdktx?=
 =?utf-8?B?MXcvU25sTWlNelFreG5vU08vWDRRb3UvaFE0b2FieU1RcHFjVkF3U2FHVFBH?=
 =?utf-8?B?TWtHTTNvd0RiczRqNFJ1TUZzOGdhZEpZOTVRbEN0Z0dxVG5JTzlieEV1SDUy?=
 =?utf-8?B?WkpFMkpHenUvVUJjSnRTbDMzeXJTckN4R0hzMStqMXpnbFB2OW5uRy9pZkl0?=
 =?utf-8?B?eUFzM2V4Y0plQkNiWk5oeFVnd0d1ZDUyTTZYWHM5TnN5MGpWNENKRytmbm1Z?=
 =?utf-8?B?d2x1RGw1aGFZUTZsdFhjMVNmdHA2bTlzaG56Rk9JdzJPV2FmZkpLTWI0ZjUx?=
 =?utf-8?B?bUtTd01tU1lrMG5Ob043bDUzVWFLeWVhUGdYZnhIZDJHV3FjUFFDc2NDdTZX?=
 =?utf-8?B?NWhXbHNPZXpxQ3N1YUo3dDZQaFdyZWQwSWpJR0cwMlBwZlNwWWNaNXNUMmFu?=
 =?utf-8?B?SzVoSXpURStmeDBsMXk3dkFNWTdRdFEvWnFRai91ektiVjh0QXV6S3NkT1pR?=
 =?utf-8?B?aU9OSFVrRHpqcWJMOW4zaDdiSTVOQzB0Y1MzaW04bWxNVXNDM3N0YnQxR0FU?=
 =?utf-8?B?ZHJKWlRGb0hHRWhKY0FyVWRhVjRrRXp5WFU0Q1A2VWY5dWtYSnNHYUtYS0N4?=
 =?utf-8?B?cVRFbDZ1K1ZqU2pIdElVRERRdGZXcVV3ZlJMRVVmSGhtWmRreHNTNEtocFcv?=
 =?utf-8?B?YUdaWmxTTEpwYVdSbzZNQ2FLNW5Fc2E4bElyYkxDdytXTVhnRGh3ZS9za2pr?=
 =?utf-8?B?VDVDTDMydGFJdnZGRU8vMEE5a2Z1Y3NJNTBHaE5YMzgwL3pPWUpId3Q3UkRZ?=
 =?utf-8?B?SzM4Z2tXdiszQms3cWpKckhONnhhbVhjazBQbTBJUnZHdWJMMVVnQmcvRDQ2?=
 =?utf-8?B?MFlqL2tqanQzV2dRcEpEYWlDV1RPN2MwYnVHOUpZSnBxVHNaNkpQSXExQ3F5?=
 =?utf-8?B?bnhsUjBHcFloTnpZRzlSc2kxL1hxKzhKdnBqZHJ2NFdRdzNSRVloOHA0OVB1?=
 =?utf-8?B?blFHTHFSZFIvcTBnbjJKMlg3VkxDQWU0Q2tSdnJXSUJmSGxYOElIYVJjQUJT?=
 =?utf-8?B?SkdOSkZPNWsrOEpyYVFUUzg4bHdkVjBabFp6a0dMNlBqU1ZmM0tNOUFtcjV1?=
 =?utf-8?B?c1FxQldPL0JiWmpkRHZpdWRnR2tSQ1FhVU40UlgrTEo2WEJ1U3lRYmhwSi94?=
 =?utf-8?B?RDE3eDQ4b21JSThEc3hhbytkaXl3N2p1MXB2bEZreFFQYWlUTUNEZXYxZWpt?=
 =?utf-8?Q?Z+VJoC3pWhC53bFGIMSjb7Fcc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cd8bbd-c3e5-43f7-9dc6-08dd7dca154f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 16:08:25.2633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpdtDWX5gLh7k++pxV6IMh1X6shA8vRRvhjt+8UNscpI0K2Mhnxt5YPppchKILDsaC12XKFfRRqnyqUZ0XMjbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085

On 4/11/25 14:00, Ard Biesheuvel wrote:
> On Fri, 11 Apr 2025 at 20:40, Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Thu, Apr 10, 2025 at 03:28:51PM +0200, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> Communicating with the hypervisor using the shared GHCB page requires
>>> clearing the C bit in the mapping of that page. When executing in the
>>> context of the EFI boot services, the page tables are owned by the
>>> firmware, and this manipulation is not possible.
>>>
>>> So switch to a different API for accepting memory in SEV-SNP guests, one
>>
>> That being the GHCB MSR protocol, it seems.
>>
> 
> Yes.
> 
>> And since Tom co-developed, I guess we wanna do that.
>>
>> But then how much slower do we become?
>>
> 
> Non-EFI stub boot will become slower if the memory that is used to
> decompress the kernel has not been accepted yet. But given how heavily
> SEV-SNP depends on EFI boot, this typically only happens on kexec, as
> that is the only boot path that goes through the traditional
> decompressor.

Some quick testing showed no significant differences in kexec booting
and testing shows everything seems to be good.

But, in testing with non-2M sized memory (e.g. a guest with 4097M of
memory) and without the change to how SNP is detected before
sev_enable() is called, we hit the error path in arch_accept_memory() in
arch/x86/boot/compressed/mem.c and the boot crashes.

Thanks,
Tom

> 
>> And nothing in here talks about why that GHCB method worked or didn't
>> work before and that it is ok or not ok why we're axing that off.
>>
> 
> ---%<---
> The GHCB shared page method never worked for accepting memory from the
> EFI stub, but this is rarely needed in practice: when using the higher
> level page allocation APIs, the firmware will make sure that memory is
> accepted before it is returned. The only use case for explicit memory
> acceptance by the EFI stub is when populating the 'unaccepted memory'
> bitmap, which tracks unaccepted memory at a 2MB granularity, and so
> chunks of unaccepted memory that are misaligned wrt that are accepted
> without being allocated or used.
> ---%<---
> 
>> I'm somehow missing that aspect of why that change is warranted...
>>
> 
> This never worked correctly for SEV-SNP, we're just lucky the firmware
> appears to accept memory in 2+ MB batches and so these misaligned
> chunks are rare in practice. Tom did manage to trigger it IIUC by
> giving a VM an amount of memory that is not a multiple of 2M.

