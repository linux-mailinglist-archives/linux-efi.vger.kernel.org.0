Return-Path: <linux-efi+bounces-2221-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C789D9DAE20
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2024 20:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFC2B21897
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2024 19:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB43200BA1;
	Wed, 27 Nov 2024 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eNc97cdw"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06B14D2B7;
	Wed, 27 Nov 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736816; cv=fail; b=A7MkBQTTVerK1/MUyBs/8iXAQSFopUbMCRHxPW8pSCSI7mE+HUvaeqsu5LvXPjxHgO1YuDf5Dqwuwkc4Odl+iuwrKu29IRtaXQnxERDelRcyDgP+rAs7lbM+yyfxA6gaY1l7JxHnhTse6qcv2YaqmxAYwVOgQ8X8XX3/AB/d8MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736816; c=relaxed/simple;
	bh=feJM2hMA+mLS8i9eYcoxpTzlFX/C1aV9VX1+m9+IRfo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=S/JQoaoKhlCnHCFCHctf13IxZAscrF0WI1gJ/QK6W+jfpUOtg7ytP5jXCm3a+GNF1VeQqPz9xoqbJu53EwF2SXsx/ayucwsBL0uphfVhMOdFp76ATGm2YOpF/w+mDMyJOIPr4rIkQ28JQOqrr1m0sZyYzYNaETrClR/Y8s7xLrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eNc97cdw; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ihp3hd4xendIzJl52f4y8TRCTLKD3o7rLZqg7rLPnrxJM3AheQn55hde8ChUw078uTgrSOqPLDNF378bk1j1X1nxjGZAAUW0Jn9MTviqbdIe1BnuFrpBBaFdKYTO5bD+0UIeRQEEuUzxd8vpXYOa3zAN8CJI28sLCR4I13VNoLh16xKsN+C2DOqIn26RrQ/Wr+ITEdEALQzSkaLuKDoAyObcBOcnCJCDjGbMq/PvuvFVN9R374Kp5+Uc2ej6Upg0tavhnCPW+B6qyXB+4ewsg+zMRMicqAqs1VDLHlARgEXNiyANZ1bn/ZZA9LW8gPV4n6Vz/Osw5NyCwgL5NpKfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2pMtEU+L18CIMV7IKUjN4T9SsQqXJ4tcUgHZSzCZew=;
 b=VIfp6i630SH2owiR29m2CmRKqpZ+D3VKtjg3O36rmpzUyD5sHE5Ft0W/VaqFwocF2FB47GjffbZIdKuK5ng25liWTiHLfnigd84EQJt3nJxLwD9A7TKOu1m82XTH5GS46YgvWQurAlLj4sUgMqobkfHQL+6nT88pO7lAUgyKQ4+rucrhJYI3Aa7XBu0oUoN+HTx4JrX9kpj3FgxR1+MmV0N9moxlo/Xcik4p63M+mFa7sWKzS55RPv2cnUHJJLxyDoEmERNcrf3a5CRnGlaMXj1OOr0W2tuEGCIDEJ09ay5u+JYQju/gYFDeWgsoaC0U4kbmXWZEef8m9PnHoIXtIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2pMtEU+L18CIMV7IKUjN4T9SsQqXJ4tcUgHZSzCZew=;
 b=eNc97cdwQiFBROAmJ/l+M/2Q6CRV48y0iJePBes94BKnxPbAjDYvENlG/XOUw1t9Qt+lJ3TIF9B6fcHvlpTkbPMjyLQHeAxIV4o1uS/DFQXAFTo2SA6jo5QfhDcDGFfH8EKqxrgOi/AC2wdeP81jcHsVDBDJ/NaCzGBjTYigyJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 19:46:51 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 19:46:51 +0000
Subject: Re: [PATCH v3 5/7] acpi/ghes, cxl: Refactor work registration
 functions to support multiple workqueues
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241119003915.174386-6-Smita.KoralahalliChannabasappa@amd.com>
 <20241126155724.0000634c@huawei.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <72d0a9a3-228e-55d8-273b-c6175d8a1f25@amd.com>
Date: Wed, 27 Nov 2024 11:46:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241126155724.0000634c@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b72a0d-3bb6-41e9-c72f-08dd0f1c3cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTdKc2xYN0NVMlZQNDJFZmZLNkZGVG1IS2RPRmZEaVdCWDFVRUcxOW43T1Va?=
 =?utf-8?B?ejQ2R3N5aUp6Qk1yUkZ6MS8zVmY4WmZ0ajlmS2VFT3lrdCs2VUtieXcwOHdC?=
 =?utf-8?B?dE1pQ1d0QkFuVVRxOUl3aTBGelREK1FsUEZ6eXZBemRmNlFTK0crRklobEda?=
 =?utf-8?B?Mzc0RVhpeVhCMDZRS2JuRG8wZUphQ01iWTcvMFFqOU4yR09mMzhGZ0F1UEhQ?=
 =?utf-8?B?TlZKUlN1dlZYNlpNcGFsbXBiNWlKRTRjYzBobkVoa2FocDhxcENtVkJpbG1j?=
 =?utf-8?B?eWkxZndySzRnUURIbnZkSE9FTS9BZnlVRytXUXdienJmejFZRk1HRyswWEQw?=
 =?utf-8?B?K25IT2MvZEE4dSt2Wis3b3F1bUVNc29NZFBCS1JRWjg3aTBNRU9sTXRGM1N2?=
 =?utf-8?B?cGpTckdCdXdxcUQ1T3NHVFNVT3RaSFNwY1VVVHA0YTlselQ1NVFRVmRFY3hJ?=
 =?utf-8?B?a1pqUjRyK3ErdG9yWW5EYUhxVHQ1dUJnRElUaWZjaE9LZFNGU2dRcFMvU3U2?=
 =?utf-8?B?NmFBQ3Vtb1I3d3Z1NEd0SmR4MjNuZHZhRkhlcENZOHJGYWJ0Z3JPaStCTzVX?=
 =?utf-8?B?bzZIaHYrS3dxSUJnRmNkMHhjMERkMUhUUm5lZitGVGJ5TG9uWmNtQlhFMlY1?=
 =?utf-8?B?THpva0YyTVN3YzZJMlZNYkNzTHUrdFlJSHBSRlRudWp4dm5YdzlPNndtb0NR?=
 =?utf-8?B?VXVyTThCRzlCdGRjZXEyMDRlQmVMZDZiczYrZzBNMndVK0hkYy91N04xcS96?=
 =?utf-8?B?TFpwRkxWUlZ0K0VvQnA0VkFUU1NNcE9USS9XYWgyRGNQS25hR1hMa0JzQm9E?=
 =?utf-8?B?dStDLzhXSlBUZ3pVUUMzdGprTXc5aVlxWWtaMDNPMVlpaC9hQncxU2taTS9J?=
 =?utf-8?B?VkhsU0hnelJTYUYyRjB6V2E1bGxHeTkxOWs0UE92SFpGNjNmWUg2L1dqbWtm?=
 =?utf-8?B?aGFWeFJzbVF4VUtTcmJSYk5VVWkxUUVWcjNmQ01mMGt5b0tNZGZiKzVyLzgx?=
 =?utf-8?B?OW11eE1DK0VjL3ZYdEtoRE9GbkVFc1FFU2tPRTRWTVV3K1NkZlQ3MVI2OHFa?=
 =?utf-8?B?RVJiSjg3bmptdWc1SzNtbnE3TVFDUDdQTmo2dzVsSEJBSGQvT05KNCs2dG0v?=
 =?utf-8?B?SVlNSm5vZUVBTHllcllwcSsrK2l4N2xkWk5RcFJoSlZUOGxUS0ZLWk1LbGJk?=
 =?utf-8?B?UmlYUjdDNlErQVEvK0c0d0p0VEhVTlJ2bVV3L21OM3NNVlZFenBDc0ZLOW95?=
 =?utf-8?B?T05rU2tqZ3NnV3RSQ29VT2VsSS9hSU80aFZqcGFsQVA5UjlabFUySHZzeEwr?=
 =?utf-8?B?bXZZcWdaZlVWcDEzZ1JCbzZnYUt2VW01N1pGclhhSDhyN3ZaZWV3dGlOZ3hX?=
 =?utf-8?B?YmwrTW5oS3IvSUlZNjMrNFpQK21mSWJNallHejR3OFpmc1p6ZmgvUFc4dmor?=
 =?utf-8?B?bjdPL2c1cnJxRkZJYWtsc0lxL3N6TEg2YTZ6RSsrMkJ4MzRPRk1nNzVpalls?=
 =?utf-8?B?Tm1EbVZuaWRHUzlRRlNZMmkvSXVCdURoSGFGYi9ySGJPMUxCWVVrcnJQaWRV?=
 =?utf-8?B?STdmcXUzc01acXhKNHk2UlViTDk3WEo4di9kVGs4TlBpbVZGZW5CcGJzZUN0?=
 =?utf-8?B?K1VubWRxa2hvUHNRaUk2SlJHVnBvcTA0cXdoODZKbnBQMGxqeVlKbkI1bDNS?=
 =?utf-8?B?MTNIZ3pqOUJPUkJ5eSticEp6S2hSa2NiMXV4WjJWS3V5dzZFQVplS1JQQzB3?=
 =?utf-8?B?TDZKRndUbHBRWXBPUk56WHlyL3lES3NqT1JKdWs5bkJ3N0ZLMStZTjIvc0RW?=
 =?utf-8?B?SzhRQnhFUmdGQThGdzJaZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjFvOFFXZDJBUTZjVmQ4djdTYkpHd1hIMkdTcUxlZS94OHpIS2gvdUgvc3ZN?=
 =?utf-8?B?czJXb0N0MVhUWmFEMjRRdU4vVS85UEwzVW50T2JPQXVhcmlwdGJ3dU5NcGJU?=
 =?utf-8?B?NXh3Znk3K2ExOCtmYS9KZElIT21Lamt5Sno1QlRXckdnVU5OK09kcVltV3Ni?=
 =?utf-8?B?WHVwVVFDcDBUNkhuczdCK3dBNDJQSWhKblA3UCtDZGhKaGRLSHB3czlUZ1A0?=
 =?utf-8?B?MW00ZFNaMHRvU0lWRjJkSEt4UEZPSGZ4K1RxRnFwY0s2MkVDZmZDZEJpUHJq?=
 =?utf-8?B?cmNmUEkxMnJiS3dqM044NFlOSDFWcGdNTjdlVGdKZW80WERXRmlLdGlmRmZL?=
 =?utf-8?B?cVQ4eEtid2tWMURycU40U0p1WTZuMzZSRGF0RWU5ZUx4bDUxSnBPZHE1NEs1?=
 =?utf-8?B?ZS9jd0dGT294S2JhUlpqbkwyUkJTRmF2WUJYSmx1eWFvdlZ3SnJ0WXcvRUpV?=
 =?utf-8?B?ZksyUVgxb2lVc08wRlcyYmRtRnpBMlIzZXliNVU4c3FHeURoalFraTllQkcv?=
 =?utf-8?B?cXB4Ty9WZmxIdVE4cUdGWmxxNGt4TkROcDZOSS9yazU3T2tucXh1ME1NdnFG?=
 =?utf-8?B?VUYvY044UEZ3SzJkUFFBVXExdVdnNXFpaHBDSmtXV3RZK01TT2UzZXRqUnZD?=
 =?utf-8?B?YnFZRFJqVEFjZ2FWY0UwZEhGaHowQndGV3hmUW9CcHd5Y1RCZmo2SXJScDJO?=
 =?utf-8?B?T1ptclZlb2lxblVJaG9aTDIyZVd2QmhpNTl1UnBpWUw1dERGbkQ5ZHQxNlox?=
 =?utf-8?B?dnlYZUd0NXdrNkI0SmRNNEJaZkV2RE5yYlBSRVdrM25LOTN5a3ZuRWRlQXYv?=
 =?utf-8?B?SzVvVzN1QktnbGVXdVBrUHE2WWRWNktRWnlCaHoyWkxMQWVFNWl6ODJIRG8w?=
 =?utf-8?B?MTh1dnhNZ2tRcTdyckFqNmluaG85WE1zanhRUVR6Qzg3WGMvazhYRWVnSDVX?=
 =?utf-8?B?MVl2ZUtnaW4ycUoxM0tBdGorV3pUQ0FucnJjYkxta1FBNWtBKzgrS0Z0b1Bh?=
 =?utf-8?B?bWYyNWZOR0FJTVlMcHZaNlBERHZralFQcXJFMjBmWkhDNE9XcjFTZGxnL2tj?=
 =?utf-8?B?MDRWYytyN0pIUFAzSERXUHorR1RuZVVxMzZ4SSttSW9ndzVMZUg3dXBUb096?=
 =?utf-8?B?YmgyL3E1NGZFdmZ5QzU1ZnBqSDhrV0VNbUQ5dkpYQzBITERxZElRWHRUblJC?=
 =?utf-8?B?bjhMNVZ6U3B1ZVN2M1VMYmFSTDNoRGtWZzA2YjlMY1F2emRLRVRVeVVKbnBV?=
 =?utf-8?B?Zy81VEdzQUpVWkJySjRoM1A1c3FvWjdNc0hON3NzTmMveFBVVC9KakcrYlpp?=
 =?utf-8?B?Mjdod29MbEltaFBSTmJURGlDN1NWeVpUakRJcVNjTTlONTl6YllqQ3ZTRUx4?=
 =?utf-8?B?SlRXaDg1Z09vZm8zWndRd1h2QVV2MVFZbnlaa1crQmdYaWF4Tzk5anpGM0l2?=
 =?utf-8?B?WndJQjZFdTU5elFiaHdvYWlNZHdub0JtVGhCOGhhbTF6QUJUUzlhc1VzVkdt?=
 =?utf-8?B?UjNMN3kwTnA2SFZIRmFQQTZDZTY3L25Vc1M3alUwSXMxV3BKVkxMVE1pR2dz?=
 =?utf-8?B?NGdUNlQ1TXRNSkdkZHVvdEdUQ0FUMEE1TGR3TWF1N05ndHlnR0E1SVNoMVJa?=
 =?utf-8?B?Y0dZeU1pVDJQS2tEM05BSlp6UE5IV3ZqZEdxM3dWTUd1aHNnZTluUW5xdFJn?=
 =?utf-8?B?TDE3aStQSitrNG5CRTJlT0N1VUpLcFU4T3dPOGRhR2hqZ0N4T1Iwajh1TXhR?=
 =?utf-8?B?bnpMZm1kenFoMHlsODZ3KzBMSWFUaFNBQ1gvOEdlQVoyWnJNUVE2WW42WjRQ?=
 =?utf-8?B?Yi9lczhNSEg1VHJZRmV1UDRhZ1ptQzZ5dTFQOTRMSEVhZE0zRElZdHF0R2Ru?=
 =?utf-8?B?Z1F2UUhKM2srUUNhM0ljNXMzTW96QjRHL3NMbHF4bUh1RnZZb1ZHNUsrVElL?=
 =?utf-8?B?UUZWQkNCZlhZSzg2VkJlNXMzRXdjUFQzNHZrYzVwSVJMaEFnT0pNanB6aHVU?=
 =?utf-8?B?bmtUVDFYVkU5N3NvdFlIT0lqd0QremZHKzlmU3NiNG9iSTNYZWlqM2JLRHp5?=
 =?utf-8?B?N2Z5eVZnY1BBeEl2b093bUVSTTRlTHJkUWtEZ1k1SnprMGlJSTV3Q1JGRUxz?=
 =?utf-8?Q?RG1IcxUQ5TKBVxnlwoMwd4+gn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b72a0d-3bb6-41e9-c72f-08dd0f1c3cf1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 19:46:51.3960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+IQ8T736RRrNCK6M1o1tWTUL3O0ul6e+QEj4LeafNxNpGb8UQCGMGcvypZXL7LIJjrsi8IpBmfnXoijuVUzYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813

On 11/26/2024 7:57 AM, Jonathan Cameron wrote:
> On Tue, 19 Nov 2024 00:39:13 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> Refactor the work registration and unregistration functions in GHES to
>> enable reuse across different workqueues. This update lays the foundation
>> for integrating additional workqueues in the CXL subsystem for better
>> modularity and code reuse.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 34 +++++++++++++++++++++++++---------
>>   1 file changed, 25 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 082c409707ba..62ffe6eb5503 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -717,26 +717,42 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>>   	schedule_work(cxl_cper_work);
>>   }
>>   
>> -int cxl_cper_register_event_work(struct work_struct *work)
>> +static int cxl_cper_register_work(struct work_struct **work_ptr,
>> +				  spinlock_t *lock,
>> +				  struct work_struct *work)
> 
> This is a somewhat strange interface.  It doesn't
> really do anything particularly useful. I'd be tempted to
> just open code this at each call site.

Okay I will change.
> 
> 
>>   {
>> -	if (cxl_cper_work)
>> +	if (*work_ptr)
>>   		return -EINVAL;
>>   
>> -	guard(spinlock)(&cxl_cper_work_lock);
>> -	cxl_cper_work = work;
>> +	guard(spinlock)(lock);
>> +	*work_ptr = work;
>>   	return 0;
>>   }
>> -EXPORT_SYMBOL_NS_GPL(cxl_cper_register_event_work, CXL);
>>   
>> -int cxl_cper_unregister_event_work(struct work_struct *work)
>> +static int cxl_cper_unregister_work(struct work_struct **work_ptr,
>> +				    spinlock_t *lock,
>> +				    struct work_struct *work)
>>   {
>> -	if (cxl_cper_work != work)
>> +	if (*work_ptr != work)
> As above.
okay.

Thanks
Smita
> 
>>   		return -EINVAL;
>>   
>> -	guard(spinlock)(&cxl_cper_work_lock);
>> -	cxl_cper_work = NULL;
>> +	guard(spinlock)(lock);
>> +	*work_ptr = NULL;
>>   	return 0;
>>   }
>> +
>> +int cxl_cper_register_event_work(struct work_struct *work)
>> +{
>> +	return cxl_cper_register_work(&cxl_cper_work, &cxl_cper_work_lock,
>> +				      work);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_cper_register_event_work, CXL);
>> +
>> +int cxl_cper_unregister_event_work(struct work_struct *work)
>> +{
>> +	return cxl_cper_unregister_work(&cxl_cper_work, &cxl_cper_work_lock,
>> +					work);
>> +}
>>   EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_event_work, CXL);
>>   
>>   int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
> 

