Return-Path: <linux-efi+bounces-5704-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76672C8C360
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 23:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EFF8F3461D2
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 22:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A02FB99D;
	Wed, 26 Nov 2025 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mFB/45oC"
X-Original-To: linux-efi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCF1096F;
	Wed, 26 Nov 2025 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764196061; cv=fail; b=J6Ngi39yzbFrChzE1CMOTwibkdIDNoI2gzp67FlrHnHaYXwYWOQ97CSH0GgXOaFqOgtw2Du7wBplp6xlSTL+2uyBGhNamEorVA+OqYTjlwVDtUGKTk75U1g8nta0LU+bI0aCnoGdjVolASL+6FxQ8wCOEiJa2EWcE+ZvH/3HWQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764196061; c=relaxed/simple;
	bh=84nRlHgT9KAxGXbETKCjFC2HAcAfiJNYpyNbGfNyZ2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kXaDsLDKOY9mb8J+pHFr7HyMuYymBfTCWsDWKieP3fbd068X+ps3QL174cHCdq28cf3Q7a5QlAw6BHshXTk6NI/SxHobhawPQ9SSewtzX97bvLJdRvFQAl1uO6fR3eS9SAuYU4+EuBZqE5/QKz8EhGFUVKeEV6QiMPI0H1FaQic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mFB/45oC; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+0d+cDvXk8PkF1V8amPTxcooGxYiglz+4MLM4iS6h4Q6KoKUdcCPgg3ZBiNeG5P+vUWNA+DS54p/OsIv21yEjZl8eaz4IqVMpeI6ealKZ6BxJPU3/3NPvTyMTzniStTqfmrimPIQGeY2Pv15Yc17caGMFOQkOIZaATuJD06kgbUEhQlWqpcOIvr1WtIPN5U4ckXcMB6S5j04ldiFCsQFVBX9sFp+YKCdN+RMl2dVe76R3Zls9c0GG/qTsm4qs6TkO0NDJNhz7t6lMxKfzctg9918FjS97ocoidJYt4nPJlU9Qj9hsYy7COIZZ6Sy4NpV/sS/nkYLIerIl/rj6PTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbQEOOHw1IcXq6BfBEbxOZLnl/Se35nQTbPfQtOklDA=;
 b=zGcFbuD2W6TF6Is1bnMkfJhDuv6qyHG273y2VEHklPZMrrXkgzO0LR97NBrwoosZl/PgpkmikL21l9JUdeLlUHZ70lqVvasQRNAnSUAa7Reo4mH/5CJ4HFKIdCHywHxVjeepz5U/KeeoX2pfgJQkpePR400ykpcMtG2gBC4fYdJ2aGstWXZ9e92g97Fw6Lmups2sdtus0bEvCa+mDWeG0i0JHHKgY/LeydT4YxSKQbIWKLnR2FtKVk8Lr053ML+gRmFIIEnofXzYch3AeBYCtt9TxnMfRq6nsgqxgY/n5X6zQY8o3VYj0meqImzoUxT5D6CqFNzzqh4Wj9Ti6vDE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbQEOOHw1IcXq6BfBEbxOZLnl/Se35nQTbPfQtOklDA=;
 b=mFB/45oCcheR8UAmq7g/FIkGYawlDBrk+3mCP+FL5rSRl+iiyi5rrIA+o4JR1MfZCPOchN1xGVtMFX8kbEIYrx87fw9veZaqSO2Va/ahEHbAdByGHG9Z0kV1yZd1z8b8ThfBQwYa+8TOddpSoGhpGn6r5uP8NmaO4Vc93B5eZFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 22:27:38 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 22:27:31 +0000
Message-ID: <14df1d99-7df0-4982-8029-e66dfb140399@amd.com>
Date: Wed, 26 Nov 2025 16:27:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
To: Kiryl Shutsemau <kas@kernel.org>
Cc: linux-mm@kvack.org, linux-coco@lists.linux.dev,
 linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, ardb@kernel.org, akpm@linux-foundation.org,
 david@redhat.com, osalvador@suse.de, thomas.lendacky@amd.com,
 michael.roth@amd.com
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:805:66::35) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 30623cc5-1ded-4bff-2a9d-08de2d3afd39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEF2U0tGNy9vc1E5alA1T0N5OGVpNWF3ZEptQTBLUW9RejFDUWhaSGVDdlFW?=
 =?utf-8?B?SVRjb2VxSHg5dEVwMTBib3VscDJnc0FMUDIrOGhnVGVIcWFyWUJvNitzRk9i?=
 =?utf-8?B?V2Y1djZ2SkFWWHRIWktrUjFKVFppVlNUV3ZwU0Y0SlJpK1VGaXV0Z3prTzNy?=
 =?utf-8?B?MVlqTzhVcjNFZnRnVSt1UnlTR21tdzB5blphQWptK3ViRC9PUEhwWEtTdXI1?=
 =?utf-8?B?YXFUUm52dC83WUJrU3lyZTE0VHBrdnlHV0pCN2hFWUk3cXg3RzlSNFFkMWV3?=
 =?utf-8?B?c3JabXNCZWczUWw0RFJUOWpUVHpBSXM2T0lWd3VJaVdzQzQ2cUM3WHBoZGZU?=
 =?utf-8?B?cW4zeUN3Q1ZBQ25VOVVYSGlpeHFyK1VLSEFmMXdJYURWSTJlQUE0VlZPRFpG?=
 =?utf-8?B?OTBRaUJ4MWZNTlVqMmlCem1oSDFMZnQrc0JzMXVHd3EraERrV2NxclMyZVNz?=
 =?utf-8?B?bDRuOUZXSnBqNVh5L0RxWXhYd3BsRDl1aGg0eEp4OU9vZlVTUnNwS3I5K1pp?=
 =?utf-8?B?Wm9ZNzZZdWFTbTFJU3p1cmtLeDdzZFArTXU3WXhKb00yZkMvQkYwYzVGUEtk?=
 =?utf-8?B?MmNhUnduelRpbWhRdEgxRUN4ZFZtcGVQS2g0M1NLWURNMUVWd2haMk10Q2tS?=
 =?utf-8?B?cUErd2YyNkhTcEhrYXJIYlRUV0FjbXpSb2xIUXl4WGhwSEpQZUVJWkExQTZx?=
 =?utf-8?B?b1BXYVVHK3B4M0xlQmdwV1M4NEZncEFrVDFoVVFwZlY1Yk03NEFRemRqSFNR?=
 =?utf-8?B?M05ZWmdjY2ZBdzJMVVE3NG9kYUZxOG5yYnJDSGp6aFFaWStIbXZSbjlCQ0ta?=
 =?utf-8?B?T0ZWTnVZa3dUbmRjUXlvcFpxS3ROL0NzSklrK3JheHFlTGlHblVaU2pERklR?=
 =?utf-8?B?cU0zZENrMitLRVJIaU1kd2pUSzVWblJESE84Z25relJPZzZqaUsvVUxJV0sy?=
 =?utf-8?B?QnJEYUg2WnpNR0d4N0c5cXVMbTVZaEZ4TTIxanhuZDlWQjZMMFJaZS9pY04r?=
 =?utf-8?B?aEF4TjVZR2FpUk1ka1Fra2N5bXoxZGM1ZnRjUEN3OFR1d01sZFdIR1hDWEVU?=
 =?utf-8?B?N1JZdjM3dkJ3dFdqSEtYVkVpTnJyYWNpaGNvRm93U2pEUWZjYklJOHB2QmZo?=
 =?utf-8?B?UDFscGk2N0FxRVdySjdFZU0zQ2wxR0REV0Z0N3VMdGNSY2xtVFI2VktMQzdC?=
 =?utf-8?B?aVpUZmMwblAyZitQV3NsNTRUajA4ZXZzUkU5MFFTWkJZWFBnZ2hBK3BJdWFF?=
 =?utf-8?B?akR3b2xXazJHRzU2VkV3bkdrSXVOWnc2eFJOeU9FU3VSVWV6bVFROFo1UGxV?=
 =?utf-8?B?cFVYSXJsc1IydUNicW5neVBNMU9zZ0tLT0kza213Q0p1M2I2N1hUa2JCN1lw?=
 =?utf-8?B?ek1MQ2d5VjFPa2F4L2RyTzJDMnl2REdZYmdyYXhLQzlad1M4R1UraktXTldN?=
 =?utf-8?B?dWJ4dUpJeG04ckNWdFNtUWM3OXBXaWdjdUR5T29BOTVzU3dyUW5VVW1aUDhH?=
 =?utf-8?B?TmJQZ1h5M3RFNWJVYkFPMW1lTmhxOXd0N2FJcG9ibzRJVzlmMmVSd0RiOVhx?=
 =?utf-8?B?WjJ5MGVhc01GZk1BMkxNWXRrd2ErdXo1Vkp0K0ZRL2VmMVBtYXBna0VTWllw?=
 =?utf-8?B?RmNHd2xiVGJvSEZPMnB1ZlFNWno2SmJCK2VnbFZGUGZOMDd4VmtRMXhCclVk?=
 =?utf-8?B?endzTkhCdkEzOVJCcVo1MEZqcjYyUUV4UGJnaFBDcmkxSVpYcVpYQzA4Uk5k?=
 =?utf-8?B?UjRFdHBlNEhJVGNHc3p5MGd4aXdqak1GckF6c2Y5TmhMRjk0R3RqNEtINzAy?=
 =?utf-8?B?RWFXLzVFUkNTN2JheGRpODJvd1RlNXBjeG83K0ROaXRubk5QQzcwQ3VFd1BS?=
 =?utf-8?B?SGlaNUZraEdWcFV6cjQ1L3ZRMWRBTnVoRWlPeVZJSC9VMXAxSEFXVjlwS1J0?=
 =?utf-8?Q?yvxcqI4c2epCLo/jvHHfncDxJ915gNvk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzZuWDlEOGtkV3RQaWw0STFHV2dtK0diVlJ4VFNrWFhSbUVQZERRK1l2Snlw?=
 =?utf-8?B?eDcvdmNVM3J0bkRRd3kyRkFrQ2xmZ3QyQ3pJQU1na09rTXhEWUZKNG9zem92?=
 =?utf-8?B?ZmJESk1Za1dwdDVsSlFJRngzU0VQR29rTVRwcGYvSGV4dmhyRS9laGdIR3NR?=
 =?utf-8?B?Y1hnWm54SG5HOENwOVFuSGhZbklaVk8rMzB1NW5BRk1TWVpTakUvRWJ3OUNF?=
 =?utf-8?B?RGxiNFNYN0xNR1d3bXNXbzZmSk5IUVVyS2JQRU1HQXhTd0x1cmwyaW1GOWhL?=
 =?utf-8?B?QytiQlVXaElYODExd2xVUnpPci9FeWJsdHk1R3MwYXlyM3BqOCs0Zy81bDFs?=
 =?utf-8?B?VnVQcDdHdkFjQ1JGekllUTVLQ0JBQXlGNWtFWCsrQ3cyQ3NmU3laci8rWElB?=
 =?utf-8?B?TkJ6bUlsNTZINm9HSDNTck84OTlvRnN0bzZyTExjbUxRMVIwNkZTT3ZYZTcz?=
 =?utf-8?B?NUt1b3lmU0ZtcWR3YWRoR0M2YkR1a0RRTEhQc2xCOTZKcWhJMUR5OElVT2kr?=
 =?utf-8?B?NHkvUzZLNGZsRFNwWms2cHV2TjBSZ2xsQ1c2TzNqbFl0S2dEVFIyeFd0RHlM?=
 =?utf-8?B?MEdFdzI1MmhNaEh4TkdLR1VuRHpHTENYL2hiSXIxU0tjbXdQTTRadDhZMDNN?=
 =?utf-8?B?bFYyOVh1SGxLOWRSV1JDUi9GcURnZEsvbVBTRWhoVVhRWk5WN0V2ZjhGaEUz?=
 =?utf-8?B?TlpGZlF2OEI3bHVoQXZVR3MvTU9TU05nVVg2a0tRQkxLRlFwM1VTT0tlV0NT?=
 =?utf-8?B?Tmp2UDFLM3NlMllvdG9LRUF1cDNRQ1FCbW1YVjh3YlRmSmtnWHFUVFc0QUho?=
 =?utf-8?B?a2laUWdvS1FPMjBacldDYmh3SkY5VkM0cXBGRDNFSFpuU29yQStJbkMyMDdW?=
 =?utf-8?B?aFpFS1Nhemp5WElscU10RThFQXVYMmswUnBZNHFUWGJjb0RkYnJ1Y3hoOFRp?=
 =?utf-8?B?K1hibDBuS2tMUmUrR2p3T2IrVDVKbFJld3NRQnBEdXdMVTlBN0YyM09aZ2N5?=
 =?utf-8?B?Vk1uQjRLa3NuQlZXdUk4Vm52SHZCcVV0Nll3SG9sbitYVWlZZ01Pamg1UUlC?=
 =?utf-8?B?Tko4cXpVNm93R2tuRC90RXdLOVh1QmRGZmVKL0VSRDR6K1ZiVXJVdUpaYVBB?=
 =?utf-8?B?aHRtYTBWelhEVmxKU2pVWWJCTHV1aExZUnNnY290WFRZL2U1bXhvV2NrWUtB?=
 =?utf-8?B?c3ozeVdUbHpYR2pLaDBHT2VtWjIwdVZ2cGE5WEVvTGx5RGVQbE1HL0c5OGY0?=
 =?utf-8?B?Y0RTdE1xYjBWWUFsYWJVNDJJTm1xSjBXdzBuRnBScVhHbUhKRkorcVdWT2ow?=
 =?utf-8?B?WEkxZ2w3SHlnNzNWWGJ2L2tYZVZZSndTNnhRUlcyMG5IUWlKZXZGNTQwOXRo?=
 =?utf-8?B?MGl1YkxGQ0htaDRuUzlOUkt6N05EQXY2ZFZsd205VTlTU0tZdytGNzBjd3FB?=
 =?utf-8?B?ZHNiZTltcUNlVExJbVA0bXMxdEZDbTdKUERsV042YUlTc0p2aVVLQXUrNHFk?=
 =?utf-8?B?VjBpNnFuNWszU2NFNU9QQ0pqcXV5NkdYbTBwRFdLZUV1bVBUVnEyOXVzV0sr?=
 =?utf-8?B?UGZvUzVIL215bDM4bUF1bCtnUWpxTzZjMTB1MTZ2MWdUVU5PVlhFczhoL3ZS?=
 =?utf-8?B?WXpWREhuSHc0TThuVUJGcWhrcW42SCtsenNzeFByVDNtNXQrSDBIYnRoNzlP?=
 =?utf-8?B?Q0t4WklEZytadHMrTERPNUJ3Ri81TVl4NjNQVlVSTVBSN3NiQ2NhOFdLMTlr?=
 =?utf-8?B?NzQyRU1CQ1pwV3p3bFM5Yzk3dzRzQ3B1Uk5jUkRxeEltMFlpelZnTFNjMFpJ?=
 =?utf-8?B?WjdIa2RMbkV6SnRLRFJaYVNPdlRIVnJwMGtSVzV0WDRtQ2o3SUVuWUNOQnMv?=
 =?utf-8?B?enRnWFF5STY5VGpIUGU2VUFpL20vQUh1aitHK01DekxtS1Mrb3hxOUpGRGY5?=
 =?utf-8?B?MGJhbHUzbm9DYXJMc0tzZC9GdzBSNzUza0REaDcvd2pOTGdXVmdUM1Zzc0VW?=
 =?utf-8?B?ZThEdzUvMEZlalFzS1Yxazdrb0VMaHkvTFB6TWk1c084djliekszV2VTYkF5?=
 =?utf-8?B?VmlTSk5VMzJEcDAzM3dRRG1WNlQwbVlweWFkQyt0TVJ5bXFSdWZaZmkvQlYw?=
 =?utf-8?Q?Ry21Hr+xSUr5p/0QHXPqH8b5S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30623cc5-1ded-4bff-2a9d-08de2d3afd39
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 22:27:31.4345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJAASnkqAK4QgoTbNmqfWpWo/AYbkjCrElEo0717QVQkw84rkN63GmRIBsTaHaw1kLVwtXa0ND257d/bh7ILiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539



On 11/26/25 5:12 AM, Kiryl Shutsemau wrote:
> On Tue, Nov 25, 2025 at 11:57:51AM -0600, Pratik R. Sampat wrote:
>> The unaccepted memory structure currently only supports accepting memory
>> present at boot time. The unaccepted table uses a fixed-size bitmap
>> reserved in memblock based on the initial memory layout, preventing
>> dynamic addition of memory ranges after boot. This causes guest
>> termination when memory is hot-added in a secure virtual machine due to
>> accessing pages that have not transitioned to private before use.
> 
> How does the hot-pluggable memory look in EFI memory map? I thought
> hot-pluggable ranges suppose to be declared thare. The cleanest solution
> would be to have hot-pluggable and unaccepted indicated in EFI memory,
> so we can size bitmap accordingly upfront.
> 

I'm not quite sure if I fully understand. Do you mean to refer to the
EFI_MEMORY_HOT_PLUGGABLE attribute that is used for cold plugged boot
memory? If so, wouldn't it still be desirable to increase the size of
the bitmap to what was marked as hotpluggable initially?

>> Extend the unaccepted memory framework to handle hotplugged memory by
>> dynamically managing the unaccepted bitmap. Allocate a new bitmap when
>> hotplugged ranges exceed the reserved bitmap capacity and switch to
>> kernel-managed allocation.
>>
>> Hotplugged memory also follows the same acceptance policy using the
>> accept_memory=[eager|lazy] kernel parameter to accept memory either
>> up-front when added or before first use.
>>
>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>> ---
>>  arch/x86/boot/compressed/efi.h                |  1 +
>>  .../firmware/efi/libstub/unaccepted_memory.c  |  1 +
>>  drivers/firmware/efi/unaccepted_memory.c      | 83 +++++++++++++++++++
>>  include/linux/efi.h                           |  1 +
>>  include/linux/mm.h                            | 11 +++
>>  mm/memory_hotplug.c                           |  7 ++
>>  mm/page_alloc.c                               |  2 +
>>  7 files changed, 106 insertions(+)
>>
>> diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
>> index 4f7027f33def..a220a1966cae 100644
>> --- a/arch/x86/boot/compressed/efi.h
>> +++ b/arch/x86/boot/compressed/efi.h
>> @@ -102,6 +102,7 @@ struct efi_unaccepted_memory {
>>  	u32 unit_size;
>>  	u64 phys_base;
>>  	u64 size;
>> +	bool mem_reserved;
>>  	unsigned long *bitmap;
>>  };
>>  
> 
> Again, this is ABI break for kexec.
> 

Right, maybe I could just use memblock_is_reserved() instead to prevent
this ABI breakage.

Thanks!
--
Pratik


