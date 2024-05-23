Return-Path: <linux-efi+bounces-1080-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B08CDBDB
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 23:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886D91F2238C
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F13B126F37;
	Thu, 23 May 2024 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y/50GLVe"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81F684A22;
	Thu, 23 May 2024 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499387; cv=fail; b=ZNB+Nt3DoIZkK8qxSwmB77sPQy82fj0gr8zEJ0PmXAymFM6gOoLPP3dMk4mT3Bu0SeGU3ovXd+vPQDLK3hpqCWcR+kxa5geL3NbAAXjf7dGMhJ9Bv3nyMSE8Inb0FExXGwVuldn1GgoU6ArzEZ9mDfG/8vVJAHwog/+PammdSCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499387; c=relaxed/simple;
	bh=dLmDzEY+C/ZbVAKXoJ5kbTZQlYimT3K3yj2arRo3N5U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=IGeZIGVlOtVKTIOOGzE2CTvvMFRH3zznaCTyXNyBCA7nsZX1qbUb9vp6ANdlJYmC0EfmSqhMZYmpiSwI5C/Nl8gk3rvBzWhBgRQ8+s7i8Gvavshiygl6gwCkfxvDvkxRY0yVLZ2nuwwMYep+QmV8nG650ZMmxE+v+ku7NX3sltE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y/50GLVe; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxzcZDjpBN5t0w1iiDeky0xemMkMdXyAEhKxcL3zE5/AZLWqJtFMqN/7cpR1PVK92dy1dVpwwPQPRqdeDeW40eF/DPcnEt45Y1vauUgkKSNQh29haY+P0ueUaBH/qsaewi1Veyil+jZYwWlr6eTHNS2TNTR8lQizDSNC8RvrUjmEi1fe0XQAQ9H8CTrCx9o5LY+tnMmI82FRoTd8kpyg9eQtsr4UnllAL835CSfKnwziusf3vmmiIW3Wz/zImOCK5Tws9leUZCJLegsIROdJdrEO0eVtjVWziFPEvQJO11ieWPEKYB8AnTpposQpzVqO4MxNUMu0oMewYTJDODnS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXWcGkbJg1awsPEao4hwsr/mGtgA08WwpXot6uUoJ7s=;
 b=f6OwB8S4iBUunp3vx5fRq384o1xdz5+TwiXgkGykBHZgZmH1zch3zZP4flf/A40jn56HbZIPT9B2Bt2B/lfMNor45QoxX406eDOzIK8C+Fcr2DKDJI2qIdjdCStNdsMHmJl/ZehB/3eR98X7q+PUFWVRIcHDrI6C7W+mMH0qxC9KF+bOqA9RrhsOislJpD3ZmBf1ojRKYyI5D64W71IiQ+AdlEbxkdiTL89aCKnagH8cWFQxzo5Etg2+3qW6rHFOaN/p1d94aHxGghH3gbpfptLyzSRAJhgFRNdqwNDC+6alCYgRbi3bOxS5scAtSLFlt3TOzyY5k0o7Y+1utF9T+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXWcGkbJg1awsPEao4hwsr/mGtgA08WwpXot6uUoJ7s=;
 b=y/50GLVebpdoDNfUiYiM2EdEMWgZVlbFBJDJOJVjSn1JSKAYP1FcfTnz9+PLeooV8lTx3zRIwxqBYW9aN6ec4sC3QbUAF9t2MUHRGFbCueU4xTtdWMQEbxvXihOT+IOYyFdmYcDO8OPic96OxVyt/IckVyFDZCJc/TDpzjKcyu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 21:23:02 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 21:23:02 +0000
Subject: Re: [PATCH 3/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
To: Dave Jiang <dave.jiang@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-4-Smita.KoralahalliChannabasappa@amd.com>
 <7dc64418-6821-49c2-b9af-ee4ab148ba9f@intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <c7cb3a9c-02e5-09e7-d3f3-b0a3b93f324d@amd.com>
Date: Thu, 23 May 2024 14:23:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <7dc64418-6821-49c2-b9af-ee4ab148ba9f@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:a03:100::44) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: d07a5cd5-5a8d-4610-e0b8-08dc7b6e873f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RENCNjdTM0dMemc3NDRoa0xwWE1YWHgweFFGNTVzUDJYTGoxYVZPTzRoRmto?=
 =?utf-8?B?elZ2cG8wV2NiaGlYV2FGR2tISDVkcFlEVERxelVUcE9pYmRMeVJHYitkTWpF?=
 =?utf-8?B?VGNzek1INXpiQm1Hb01vUWZTMDRrNEh4QUx5aGMybU5jbFhoQXJrM25PSFhL?=
 =?utf-8?B?c3dTQjM0bjVGWi9DMUZqWnNNZDVzUFJJSGU2ckUzRWxRR1FBWVpUeEpyaUVO?=
 =?utf-8?B?QkFsVEtUQ3pSVi81aGM3YzhLVVE3NGtMK3VDSzF3TnNzdUVEZEE2ekM2d1Ir?=
 =?utf-8?B?WEpCR3hvMFlSQWoyN1FGOU5WN2VKelFSNTNvQ1k2am13ZkhLdFJXd1dzMUoz?=
 =?utf-8?B?UVJZdE91R3ZuN0NxUE51QnZpSEUyWmNJdm9KOTd3MVJZbnNmNGs1ZFBPTDBo?=
 =?utf-8?B?UUV3ck1VN2MxUXg5OC9sdkJpdHFCcWdQSjNzYUl6S3VWWkJLcyt6QUdVVFhF?=
 =?utf-8?B?SGxLMkd3MThNclA0WGcyaytYOGh3WWw5cVJTbkhhL04xNkp0M2JraWRKU25F?=
 =?utf-8?B?UmJUaW9oWFIrMHdkZm9NRDBUR2RKZHc5ZGJ2N2dncmI1OEF6K25hK3JDMkM2?=
 =?utf-8?B?cFFhZVdFTWNQL2REOThBSWs0dUNhdWRvTlV2L2hvZUw0UjVqOGlPOHIzZEIy?=
 =?utf-8?B?ZGprd0hWZkI3OU5pK2JiRTJPQ1U2Y0ptenVwMlM2S1NPOUFZZXdtUmlsUW9j?=
 =?utf-8?B?alpLdFdvSS93c0xkTVczTWd3UGZ3NTRuRm5RazlmaGwya3lseVNja1RNSjN6?=
 =?utf-8?B?WkplaW1ibzQ5SnE1Sm8zNmJPN0xrTTc3VWUwZEdYOFdST3FCbUQ2UDZHdjUw?=
 =?utf-8?B?RjdNcnpQL1pLamNDd3piUTh1UlNYZktrUDJxdGJzaWUyejVmVngxeEJTNVhV?=
 =?utf-8?B?M1Nxc0p1dCtJcUJ5VEdzUExabDVUOFlTZjB6UVNDOEFwcHJHd3VhalVmVGU0?=
 =?utf-8?B?WmFHREtlb3lUbWY3Y2pkRUxvdHZodDE4NXlMZGtodGtsZ3orQlU2cW5SR0JN?=
 =?utf-8?B?LzNhdnB0K2FMZjlLQUVIMngrYlVpWlJJQ0hIK2pINXh1U08yVTV4OFRseGRu?=
 =?utf-8?B?OWxSSWlwTmswQWFqemlHWnNNUWgrcDJUUFhsZm9tWjJRRmRKeFZwc3MvdTd5?=
 =?utf-8?B?R09ab29wYnZtUWhockovdHVGcFZZdHh0YjduMGFtSCs5UWZUMyszK3hLd0ZX?=
 =?utf-8?B?RkxVNi80a0c3UmJZNTEwd3BUVFczaEs1dDRGdzRBWXpGM0NjbnZxa2tXODN0?=
 =?utf-8?B?RUpvNXVSZExQckVpeStIWlZKWEVhb0daRWw4OGl1RitqcE8xdGJrNk9iaU5z?=
 =?utf-8?B?QmdueHpRcHVUNlcxb2NtTy9ZSU5ra2p5Q0IyRmpvTXc0UkNadU9UVTFlSUJ4?=
 =?utf-8?B?MklSYkhaNml5bVp2aW9yTE9sYjY2S3RlOE90NnVKS0hUZWdxSldPRVpsZXZU?=
 =?utf-8?B?MFk0bXU1OENvekdGT2IwM05TLzFOR08zV2wvREdBWDJWRUlrWmpKcWFDdDl0?=
 =?utf-8?B?S0VQajcxNStwTG5FdGppZnU0bWc5bFZlOUxuejYvU3BuK3hOMURpQnR1QlN6?=
 =?utf-8?B?UTdva01VZVhDWXJyeHhOempXZWNBZTlrMzNBWEtKbzNZRFNJa0M3Yjk3NmpU?=
 =?utf-8?B?Z2ZUbU93akdVOFZwUk5XQjFETmNhZFZlZ080SzYzNmpxMWRPSEZMM1Exak9x?=
 =?utf-8?B?T08zS3Bhc3J4RnNsandDQ2h2Si80ZEFZODNONWU4S0c2dlBEVGcvOVZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjhvcjYvdkJ0WU9kRHdsUFVpYjVhS2JzaW1iSW9iRDY1a1JzZzdyWi9wZldW?=
 =?utf-8?B?NGp4cGpFOEIrbktOZWZVbTI0QUxjZERzQnY3czNHeldOT01IT3ZRMmNpdVo1?=
 =?utf-8?B?V2x5dzhlbzh3OGtuTGpqWUhVT0FTczAyZTU3OG9NUzF2YTNVRFY5cGhxSGFt?=
 =?utf-8?B?WkRRSElVZXdGcmtvdmpoZFJuc2w4MlBCa0I3Mll1TDNsak9WS0tKSVpMMXVI?=
 =?utf-8?B?UExXd1hvUVNoNGh5TE96bWV1NGZTbjQzaUhZQTBlMW9HWVBkN0pkUDM4aWZp?=
 =?utf-8?B?Zmtqc0Q5RGZ6Z2pidFpIeDFQOGpKRzlvY3lteWw2eXBoUk14dHZ4YlJtQTFF?=
 =?utf-8?B?ZFVFSFRZSGNacW81d09PV3NnSlpxemZIYW5QZWs3bzd6YzFHVUlvMXE4Q3pZ?=
 =?utf-8?B?eEJybGQzTFNWZTFHVVRLcWhtdjVBSUNhWHg1K1FrMHk2N1NDSjBROXEzS1VS?=
 =?utf-8?B?RHdBU1U0OS9TeWRUYk0yOWxVNmxKb3BZa2htb1RpNTIwVzFSSGxCbFVMbEpm?=
 =?utf-8?B?Sm41Nmk3WXAvUS9FSzFibGNaa05kOU8vOS80QkpsbEZTMFVtdTFSTmNOMElV?=
 =?utf-8?B?ZzhlREFMaGZNcm83eFBnZTJ1SFc4NGMyMHNoUzV1UE5SdWdFSkx5QmVCMGxj?=
 =?utf-8?B?UEZobk5PME9VaEFBYmdXaHdlL2NhWkRzWDFrNXFyRXUvSDZnZmtEOGduNXkv?=
 =?utf-8?B?NmlvV00wU281K2VnRG9nREg2TmtKVzRyS1JqMXA2VFk3YkxBRUtGY0hqNk96?=
 =?utf-8?B?K3pDY2pMQUlPaTJ0ZEFvUHpXSnRuTDFxbHVudkVnVTQyTGwvZ0xDZWVQb2Qx?=
 =?utf-8?B?QXAyb1pWVDJNOFVpS1lvTVR2aFRsb1JjRW9LT1dRSE5ad0F5eForVnZoUkg3?=
 =?utf-8?B?aHcwU0JqMGlwY2ovRm8wajlDVlFWSkNuK0lpbFU4MENvNjllMVV5ZmwzU2JV?=
 =?utf-8?B?bmh0QXU3azM0Qk9YMGxzeExyYUhlYmZFb0xHdEI1Q2dNanRBbkhrUzVRQ3J4?=
 =?utf-8?B?SHVLUCtJaGdtNUFlWEtXZmVXa2RZV3BwcEdHU01FRWdUSXN0eTZUSzdSRUdR?=
 =?utf-8?B?Y0tQd2pNczJvYWl0Y0xUM1ZsYzkzbWFxWHQrKzhJa2xQdlMvMjNrYjNNR3BB?=
 =?utf-8?B?SW5DaE9XeGxSckxmcHh5bGE0UUVxU2dSTVErdjVHL2xSbzgyRCtzaG9JU1FI?=
 =?utf-8?B?M3M4aWNiaktpQmxTTW50MlJ3Z0hpS0lkVkxEckVFaWlqdWdaWnFHb243cHhR?=
 =?utf-8?B?M1BrZG1hSEdheTNFSVRsSldkZTVyVXhualN1TnlsR01TOWpjdDd0bk1WS3Vp?=
 =?utf-8?B?R2JFMkZxRS9CN3U4Y1M0bmVQZnpabVcyQW5oSWRBUmhlWFZMQXd4M1JCMHhT?=
 =?utf-8?B?aXBBekM5STJjRE0ycnRZeUpSSVBnQUhlKzVJQWdTalV0cjBUMHJPek9PUWhs?=
 =?utf-8?B?WWRaZkZrZ2g1dXNaaUlDaFVhNjJmNUQ1QnZxMEsvckNzUktXcnZuSlhGSXhZ?=
 =?utf-8?B?V2w1cENzSmlWNXRLL1ZjUEJJUDFBYW1La3VQdkZibU4veFdQSUtBQkVSTjNu?=
 =?utf-8?B?bzZNWmtRSHhSUTRjYWlKQTR6cHRzVmJKUHpYeTBLSjVBL3NsYmpJYXh5emlV?=
 =?utf-8?B?bTNabURiQW8relI4c0Fkc2hONFF2bzNDYmdxYThiNm5ZcVl0TlE0WThiUHhY?=
 =?utf-8?B?UFAzcDNDb05DWnpZdGZpNXp2dHpOVy9FL0RHN3UzSEpnMlBDOEJtb2F0SlZS?=
 =?utf-8?B?V3NHb3d2VUQ5RVJKckQ2RlhyUzROcDRBeDI2MlMzNWUveVRENXZ3NFl3c3Zn?=
 =?utf-8?B?N2lUdHVTdVJSajYwRWZPODFDZVEwWHVaYW1VSnFPa0NacmVVcXJCclphdnEz?=
 =?utf-8?B?MTQzWGF3elZodStDU0tXSFV1VFhoa01XN1gzUUJlZXZndkpWQXVLbGVSTFJz?=
 =?utf-8?B?VGNDYm9KcFNWbTV4NFdqNEpjTHk0M00xWHdCb2pTVkZuTVE0Q2V4NlJ5RzZu?=
 =?utf-8?B?dFBBRjJ6ZnVJaVFLUjV3SG5kOWdRdEs1Sm5XQUtadlNqUytSdXBSZWhkaTZC?=
 =?utf-8?B?cHQrQ3JVWjV5RVc0aFh3czlYSFFPcGJOVHhvYTRPUUNrcHdROWxJRWlZK01v?=
 =?utf-8?Q?moCbUqUoZ6o2nMaSkVn4YHER3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07a5cd5-5a8d-4610-e0b8-08dc7b6e873f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 21:23:02.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iZIyCQWEnuzfWe2JIBsEutZ0VaVrebL64NgdAIEVrocq6m0hplZ/xKuLuzwbuKBpmgZpHeZNVk3Lu7iXcA8zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329

On 5/22/2024 11:05 AM, Dave Jiang wrote:
> 
> 
> On 5/22/24 8:08 AM, Smita Koralahalli wrote:
>> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
>> CPER records.
>>
>> Reuse the existing work queue cxl_cper_work registered with GHES to notify
>> the CXL subsystem on a Protocol error.
>>
>> The defined trace events cxl_aer_uncorrectable_error and
>> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
>> them to trace FW-First Protocol Errors.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/acpi/apei/ghes.c  | 14 ++++++++++++++
>>   drivers/cxl/core/pci.c    | 24 ++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h      |  3 +++
>>   drivers/cxl/pci.c         | 34 ++++++++++++++++++++++++++++++++--
>>   include/linux/cxl-event.h |  1 +
>>   5 files changed, 74 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 1a58032770ee..a31bd91e9475 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -723,6 +723,20 @@ static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
>>   
>>   	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_err))
>>   		return;
>> +
>> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
>> +
>> +	if (!cxl_cper_work)
>> +		return;
>> +
>> +	wd.event_type = CXL_CPER_EVENT_PROT_ERR;
>> +
>> +	if (!kfifo_put(&cxl_cper_fifo, wd)) {
>> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
>> +		return;
>> +	}
>> +
>> +	schedule_work(cxl_cper_work);
>>   }
>>   
>>   int cxl_cper_register_work(struct work_struct *work)
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 0df09bd79408..ef9438cb1dd6 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -686,6 +686,30 @@ void read_cdat_data(struct cxl_port *port)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>>   
>> +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
>> +			struct cxl_cper_prot_err *p_err)
>> +{
>> +	u32 status, fe;
>> +
>> +	if (p_err->severity == CXL_AER_CORRECTABLE) {
>> +		status = p_err->cxl_ras.cor_status & ~p_err->cxl_ras.cor_mask;
>> +
>> +		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
>> +	} else {
>> +		status = p_err->cxl_ras.uncor_status & ~p_err->cxl_ras.uncor_mask;
>> +
>> +		if (hweight32(status) > 1)
>> +			fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>> +					   p_err->cxl_ras.cap_control));
>> +		else
>> +			fe = status;
>> +
>> +		trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
>> +						  p_err->cxl_ras.header_log);
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_trace_prot_err, CXL);
>> +
>>   static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>>   				 void __iomem *ras_base)
>>   {
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 93992a1c8eec..0ba3215786e1 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -130,4 +130,7 @@ void read_cdat_data(struct cxl_port *port);
>>   void cxl_cor_error_detected(struct pci_dev *pdev);
>>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>   				    pci_channel_state_t state);
>> +struct cxl_cper_prot_err;
>> +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
>> +			struct cxl_cper_prot_err *p_err);
>>   #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 74876c9835e8..3e3c36983686 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1011,12 +1011,42 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>>   			       &uuid_null, &rec->event);
>>   }
>>   
>> +static void cxl_handle_prot_err(struct cxl_cper_prot_err *p_err)
>> +{
>> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>> +	struct cxl_dev_state *cxlds;
>> +	unsigned int devfn;
>> +
>> +	devfn = PCI_DEVFN(p_err->device, p_err->function);
>> +	pdev = pci_get_domain_bus_and_slot(p_err->segment,
>> +					   p_err->bus, devfn);
>> +	if (!pdev)
>> +		return;
>> +
>> +	guard(device)(&pdev->dev);
>> +	if (pdev->driver != &cxl_pci_driver)
>> +		return;
>> +
>> +	cxlds = pci_get_drvdata(pdev);
>> +	if (!cxlds)
>> +		return;
>> +
>> +	if (((u64)p_err->upper_dw << 32 | p_err->lower_dw) != cxlds->serial)
>> +		pr_warn("CPER-reported device serial number does not match expected value\n");
> 
> Given that we are operating on a device, perhaps dev_warn(&pdev->dev, ...) may be better served.

Will fix.

Thanks,
Smita

[snip]

