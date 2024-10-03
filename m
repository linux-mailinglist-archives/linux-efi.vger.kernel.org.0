Return-Path: <linux-efi+bounces-1894-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0641198E8EA
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 05:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800711F261A9
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 03:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2961D27735;
	Thu,  3 Oct 2024 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GaCwwTnk"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402720309;
	Thu,  3 Oct 2024 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927170; cv=fail; b=ormU2qmsRKz2U+hHZMgou+8vXFtfuatqE4gFXhEHl1Qm7Xgd6fdS1urAZWFrbKVgHCd4BiNlFqCC8mDenQ5g3WC0UA8j9Dh15fd+Aj6rN1wgFyyCoKcQ0Mgcl5mKkO5jvrGomaGJ5SEYbuYN9A/LeodFYHKczTdIMUv01IJEqsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927170; c=relaxed/simple;
	bh=s8qRCotoHwwdvuXvzqOGEouXSn6Sv/3YavtWfEMEx4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ytx7T1hDqFXwxsFWHX3RNAmo7zTo1s0mVkTvRTEZW4hohRrNIF6UiXm5FFTAT2kDxB0AP9RT06JMUP21LOF8s3tzqnivTCmUi6K79mR9erA5sOaHg949ZyJhsMyRCEq7QdhlxVGjkrN6DYg4PEdG3auv3OkbRGKfh8YOFLtozhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GaCwwTnk; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbmysTyBtCAvoA+tAKCOr3QjikCdRTfvfQ+PBDwn9HBJIqJaKgbhIZaQS/qI+nnRkYJaZtczDYYYVjvrbpTdDNSVtfccfGjasr17PDSs5Sy0rxPnzINRCB7H3sRe/dEaL8oHrHOi0p8UpmxgnfqN6p3biJRuwFCDttHe5NjNSrXYKjawTyR+n+YF81rFkG8vZzIcvKoYj9UmnNUTTv3BYcp1G4oC1IOswHUuDEHmhl6cDjKYYt0+3GkT6GPmyS3axWxRUGkMy/lurV0YT6XjJyd6GY9zXI95IEbGLj5mzOjsWn6vc6zcM1Om8P6pe50j6Nha8dmv2OAZrci82yH3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgrJ3E64IHUAokyBMCv7cwx7mjdPvjSSXKK//R3m8M8=;
 b=gROK4jdz01xuH1E92g/gTQzJbTJ9H70BhM8ZjSaT0dHjDUhfNx7nP5OpYVRrRWGLXxcQWga/AHda6HtIjGtOev83fTMTfj5/ndPkCBE9lomWW3HoDxNL5ebijnflvHV5Kg+i8mxxYVokqCYhL6Uin5gOApSLGJm+CdVZAPlPRvcKmp4wi2G/6mjkT5967gdhL0lXOyx2yn2rsTszLUk9IX+koNc859pVDeJQjIAGv58QhUsgW/0d8anwFvQOxmPl5x8RP/ISn7HOEkBv3OwbMz8KhNcpMjpPrwvT9me5Xj8kN1QQAxNfTuQDbDBw/knoTrxdgnhwIz1jvwuI6Gz6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgrJ3E64IHUAokyBMCv7cwx7mjdPvjSSXKK//R3m8M8=;
 b=GaCwwTnkrSZ1wONOKzZg6veSMrC9G/ZOsAYhytK2O4OcQfQQ/eE1DPU7B2x1vE0XGC+d+fks1ubloYqE0XCoP8+QUM02y01akj63Yz0lxjaMCHSm9JOurOpRzSu34PlsRJaDLiLZA23bksLDQo1/pyVA1Zr6Nu/mh7S8UqTlmdFOhlD/Xcm5NGan3J6PIQJy/popPVWiFs+dBSa5YM853HNonBR1Iv3ZCZM4aQuwUrhLZbZcReqK3BYsvJwiauX6ZBkVywKEMWiM6yUJz6QaB4TgE8KbKAZxKCnGmn8ZUvcaz6PwZFOOJIpS6TUFvWdUIoPqQfLPYKiGRuSms8+5NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 03:46:05 +0000
Received: from IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5]) by IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5%7]) with mapi id 15.20.8005.026; Thu, 3 Oct 2024
 03:46:05 +0000
Message-ID: <0e7b4bc5-92e1-4589-bb15-a1bc63abc8b4@nvidia.com>
Date: Thu, 3 Oct 2024 11:46:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] acpi/prmt: find block with specific type
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Matt Ochs <mochs@nvidia.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, linux-efi <linux-efi@vger.kernel.org>
References: <20240911155536.3900579-1-kobak@nvidia.com>
 <CAJZ5v0gQVPcmMNL4J7UskHsTx8vugJ6pZ_T=Ob3qjsrGmhnFAw@mail.gmail.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <CAJZ5v0gQVPcmMNL4J7UskHsTx8vugJ6pZ_T=Ob3qjsrGmhnFAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::21) To IA0PR12MB7579.namprd12.prod.outlook.com
 (2603:10b6:208:43c::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7579:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e2d0e6-0fe8-448e-036f-08dce35de871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkVzWlcydDJlejFsWVFiempzTjBUVnhnR1ord2l1SHhsejhQYng2OUZLT0ds?=
 =?utf-8?B?QytGVXhMQUIwbmdGc28wckIwaTB2MzEwSUNqS3ZhZnFnN3N6MnMxcVhHdWVO?=
 =?utf-8?B?UXE3cEhvaXdHRzg4RVl5T1U5TS9xanZ5M0htWUVBRUk2NlJMV2Fod004SU00?=
 =?utf-8?B?b1FaNk1NUGM5Znc2bG1od1htZUJ5Tkw0OUxja0VsME5QN2FHa21wRVVHUmtB?=
 =?utf-8?B?WGpkWS9XOTNwOUxvY0ZwSlFzdCs3L3ZRTW0vRFd6cFRIQjN5Y0diTHBMMGdK?=
 =?utf-8?B?Q2VleXpHTzVqV3NSMGtxZUhXUElVSXU4cmkvZzdaTFgycFgwRU9EUDhra1dl?=
 =?utf-8?B?V25GUXRZN1diNU9NUDFNeVhFa0pyU3F4Y2VTNEZBSzliMU5tK3J6ZTd1bFN1?=
 =?utf-8?B?Q2NJRURudTl4OUFVOW5lRHR0Y1pRaDBNdkN4M0xZSU91MHdvbkFaaGEweWhh?=
 =?utf-8?B?Z3g2ZlRGVjVyRFcrcE9yRUhwaDQwOERORVlSeEdreEVQVjB0ZTBudjVxVkFD?=
 =?utf-8?B?clJNRjBaelNWM290WVVSQmpTVFV3STNYK0ZMNUtWTWUvTmg3REkwaS8xYXpH?=
 =?utf-8?B?d3Jza2ZGOUF0SWR2bnpIUWVya0VuTmpMeEd3aXlLNlhBY0pzNUUreDRVQXFO?=
 =?utf-8?B?M25LTUlhS21XMDdTRkszd3pQWFdCR0VVQ3l1ZGdsQThTcWpNa1E3cXVydDly?=
 =?utf-8?B?c2NRR1pTekpVVk5kNFlITjlDbVVkc0N2djErQmRkS2hKKzdqa0RudE5GMVl6?=
 =?utf-8?B?a2dPT2pqRThDeitEZnFQVHdmNVVTSlZIOVhOQ2QrNlBxMkFnZDRlUmQvSU5X?=
 =?utf-8?B?WDArQzdFWE1IQTY2UGV4S1hCUlNiSEdXcHZmOCs5RFZaRDlTMEdYd25Hc0c3?=
 =?utf-8?B?UldpVVdsczNqRUdIZUQxdnVDMTNUckR2bEJuSTdhRXlKbURQcHZwN1haMDQx?=
 =?utf-8?B?UjF6VVUrOUlXS3RmZHFoY2t6b2c3VnpvRk1PVVFRWmlkUkdmK3NnWWhjRFBV?=
 =?utf-8?B?cEt2aVRtNCt3RFhXd0NjSTJQVmxUQTl2K3FsVnRrUExKVStWelhmWW04M1VE?=
 =?utf-8?B?d0ptaGZZMk1PbVpXWkdDZlRmMnlSSUxsc0szMTNiT2NIWG1KVlMwSWtLUTIr?=
 =?utf-8?B?UHNoQzFkOEtnbEUvL0hlVFBvdkdqb1EvendHQkdkOGdjbmRNSVp6Q3grdG1U?=
 =?utf-8?B?WE1wVkZhSTB5YnZRSW5Ebi9GVXFOTHE4OHIzeGxLeFh1czVJK3dWYWpCdkJN?=
 =?utf-8?B?Rmd4RlhISFp6TXI2TDhOR0w2U2IvV0VHT0NDTHdoZm9SK2dsUnRnQy9ibGlQ?=
 =?utf-8?B?cDFNSUZCMXRPMWxBQ1JpNU5sZG1TNlhJcnp0OWlBQmNEeEFqaWExbnZrNTN2?=
 =?utf-8?B?aEM4alBsWGp2aSt4REJwREliUWI1dU5iQnpXdUVpdzhiS1F3QVVEVldVZkpQ?=
 =?utf-8?B?NVc5UDVNM1VxV1FBNzFlZ3hDK2RreWo3UWtIWXFkbGpGVGFiMHBCZ2xVOVBq?=
 =?utf-8?B?ZG13RS9BS012djd1cUplRVN6S2pnd0hMSzRWZnNYNGxNVEp2MWZxbXZqMVJP?=
 =?utf-8?B?QWFqaXZxR3lNdDVRNFR5ekFpSDhhZVYyYVpndG1HalpxL1YzK3FOWC9iUWY1?=
 =?utf-8?B?R05DWkFOQjJaVy9aMTNsbVpod09EWk9ZTE00dHhVN2FLV254SGFVR0c3bE10?=
 =?utf-8?B?bUJPMjdIMUhNanprbHBZclBLNUJrZldKSU1BT09UODNUVDFsNldTWU93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXEzOEFoVUtETm1KOHd4MTZWd041djVtbHZYbW1hS0o0MDFOZEk5VW5WZDZX?=
 =?utf-8?B?a3k0MmJhNVdnUFFZYXR1NzJ0cjBHKyt3RnVjMFloNmRRdDIwS2hxbXVzSDFh?=
 =?utf-8?B?UEY4YzE3bkNPcGN3YmQ3WFk0cGJHaVc5STV4SXQ5OFJaUkZER3VEb0JLZHhG?=
 =?utf-8?B?eHpCZlJ5ajJOZU82d2gyMFZOMkd6VWV5TGtzMTBPMDhGYkJMNEFReXhJUmFm?=
 =?utf-8?B?RytOcDAzb21WZHVKNWs0QzJXM25sbjRpeFh2cjZUdVEva3IyRFhpcThlbXdy?=
 =?utf-8?B?KzdETnZDbUY1L0lhWjVPbWpwY0Via2o0cHdVb3czdTlFS3dGalJTeWNzcERs?=
 =?utf-8?B?VUN3eEwwVGtBWUFhbnZ4ZkovMkZhQzQ1R0IvelJOdThuK0NKODh1NXNSMmNG?=
 =?utf-8?B?d2syeUNqckR5TlRjYmZiVDJzN2ZjbjFJZjhkNWFBSmR0cHQ1cUZwZ2g1VCtj?=
 =?utf-8?B?MTRwOG9jSW0rMkNEd0xGc1d6Y0dJdnpQQVdPU1VxVU5JTFAxdFQrbTd1Mko0?=
 =?utf-8?B?LzE4RjRxZFFJb0M2Rm1ITVhVSDhKWTZCaEVrekRjY0tGbnlHTENBMFVqakFh?=
 =?utf-8?B?cjRadTVaU2s4TlgwTlhQVTlLYXZKNXErSGpQUG9NLzRmYmZyTU1Sd2MvRlNs?=
 =?utf-8?B?SEZyQllKcXJQZDJFZkxjcHRCdFZrTHhYcEJRS3ByTHA1eTlRTGJyYURaQU5L?=
 =?utf-8?B?V0Q3MVhoRVF2YXc3TWdkajcrVy9rTmFJb2lhV0FCMTlNaWg3ZEN0LzcwYnR6?=
 =?utf-8?B?VmQzVVJibjFkaDZ6K25tT2oyMDhCSHpHUUNTOWFIbUtZd1J2TnlwYVZLM3E3?=
 =?utf-8?B?KzNGd3lJZSthOXdoTDUwRDFTK3VQS1g4eWZmdDNmZ3d1TTZRZ3RUQUpRY1R5?=
 =?utf-8?B?QUQ5Q3hXaThXb1J0aFFnUVJDMytFNTJCQXgyWDRRT3o5RWpkQkdPdStlUzdm?=
 =?utf-8?B?dlJwYnVBL3ZiN0JGajJUcWh0RWxxQnBFMEQ4UDFMU3JDdU1Qa2MwRE5rTHls?=
 =?utf-8?B?cGJlVmh4NUdFTDRYNGhnK2YrN0M5blhrSTdFa0lkMmhKZzJzYlk5MFJNU0N3?=
 =?utf-8?B?Q2s1dXVCOWdCdDc1RC93czBROTBubGU2MVpOUlNGUWhkVlNVT01xL1hEUXQr?=
 =?utf-8?B?VGdSUmJQKzA5b2xtTXl5NVBUcS91QUhObUt6L0FOQlZRa0RqWDJyNm4wWXNX?=
 =?utf-8?B?dGh1dTlGQnhLK1hOTzNrRG84OWNuQjJXTWlNaGdZekxJc2ZuZG5aYkxIUkFC?=
 =?utf-8?B?MTBhTm1HV2NCN0lPTXEwRzFrMVFtOEVSemloRkZTdjFnNm1OZ29pQWdzOWRF?=
 =?utf-8?B?NDY1a3J3WnlLbFpuaGp2MFd6SjRqb2RsMUg4ZzlBRXFacnpPdU9iYzdockFF?=
 =?utf-8?B?VTQ2WjhDYitRbGtGaTZYSnJGVUZTQ1pPQ2Exc0E0UnJRK0NOY2k5elhCMUF6?=
 =?utf-8?B?b3ZYU3krZlRGb1RWbkdyTGVmTTlSRTMybGViZ1VKMldiOXd4T3NyZmJ5NlZZ?=
 =?utf-8?B?Qy9NT3Z1aDY3N21OYTVYbUxaVnFkMlNkRkZuR2IvNXRVUEEzSDF6MFRFSm91?=
 =?utf-8?B?S1hEZ3lWa1RkVWI5THRPZk51Ky94b0NwNzgvaWY4SjFlWUtCWEF4K0Nzb0sv?=
 =?utf-8?B?OGY5ZndpVUVadVNqRVp3U2F6Q2g5eVNoaElTZUhQR256ZERUc0JVTHI3eFd1?=
 =?utf-8?B?bHd5YURmdFQvOGUzN2h0QlFqREE1RjZpZ3FTTFBWUDV6TUJHSXpESDZTU2Ja?=
 =?utf-8?B?YWlvcFRoaC9rMzZRSE15SGpKdXYxV0pXTFNzRmZJaUdwS04vcTRrM0M5S0tG?=
 =?utf-8?B?cnVIYkpNUU5vcWVtUGV0YUxrNExNaEJFd0xEV0pKdTlqOEYxaktaWmhMU0xX?=
 =?utf-8?B?Q242ODdJV2paMlloUVpCS2RLTExyYURJZWV1d0xURUVkWEJsNUtQSlJ2MWJW?=
 =?utf-8?B?QWN5QlZLc0lVMWlFckZ5NFBmdm9ZeGdXckhlZUwvZkJLb1JGb0FjaktMSWEr?=
 =?utf-8?B?Um9zcmdYZFVLSXc3SU9oR2dRYytXUnFGOVhjWUFkRXJuYjR0M2FTcFpmd2tr?=
 =?utf-8?B?UnJFMGplVmh0eFZBRlA4QkhMbG12R0VqMHVGODFEb2RXNDFyYk1UdFRWZW9w?=
 =?utf-8?Q?4YFEcKHpgjBduNaDMNKcPkpPp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e2d0e6-0fe8-448e-036f-08dce35de871
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 03:46:05.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQknuudfwI+6DnBSHz4dYB/7+SA4ehIyuUBeVxiYxj5d4BG4J6TemJ8hrw6VZnXANmjbRQ0RuuzAOzNMTAf+fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113


On 10/3/24 02:05, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Sep 11, 2024 at 5:55 PM KobaK <kobak@nvidia.com> wrote:
>> PRMT needs to find the correct type of block to
>> translate the PA-VA mapping for EFI runtime services.
>>
>> The issue arises because the PRMT is finding a block of
>> type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
>> runtime services as described in Section 2.2.2 (Runtime
>> Services) of the UEFI Specification [1]. Since the PRM handler is
>> a type of runtime service, this causes an exception
>> when the PRM handler is called.
>>
>>      [Firmware Bug]: Unable to handle paging request in EFI runtime service
>>      WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c:341
>>          __efi_queue_work+0x11c/0x170
>>      Call trace:
>>        __efi_queue_work+0x11c/0x170
>>        efi_call_acpi_prm_handler+0x68/0xd0
>>        acpi_platformrt_space_handler+0x198/0x258
>>        acpi_ev_address_space_dispatch+0x144/0x388
>>        acpi_ex_access_region+0x9c/0x118
>>        acpi_ex_write_serial_bus+0xc4/0x218
>>        acpi_ex_write_data_to_field+0x168/0x218
>>        acpi_ex_store_object_to_node+0x1a8/0x258
>>        acpi_ex_store+0xec/0x330
>>        acpi_ex_opcode_1A_1T_1R+0x15c/0x618
>>        acpi_ds_exec_end_op+0x274/0x548
>>        acpi_ps_parse_loop+0x10c/0x6b8
>>        acpi_ps_parse_aml+0x140/0x3b0
>>        acpi_ps_execute_method+0x12c/0x2a0
>>        acpi_ns_evaluate+0x210/0x310
>>        acpi_evaluate_object+0x178/0x358
>>        acpi_proc_write+0x1a8/0x8a0 [acpi_call]
>>        proc_reg_write+0xcc/0x150
>>        vfs_write+0xd8/0x380
>>        ksys_write+0x70/0x120
>>        __arm64_sys_write+0x24/0x48
>>        invoke_syscall.constprop.0+0x80/0xf8
>>        do_el0_svc+0x50/0x110
>>        el0_svc+0x48/0x1d0
>>        el0t_64_sync_handler+0x15c/0x178
>>        el0t_64_sync+0x1a8/0x1b0
>>
>> Find a block with specific type to fix this.
>> prmt find a block with EFI_RUNTIME_SERVICES_DATA for prm handler and
>> find a block with EFI_RUNTIME_SERVICES_CODE for prm context.
>> If no suitable block is found, a warning message will be prompted
>> but the procedue continues to manage the next prm handler.
>> However, if the prm handler is actullay called without proper allocation,
>> it would result in a failure during error handling.
>>
>> By using the correct memory types for runtime services,
>> Ensure that the PRM handler and the context are
>> properly mapped in the virtual address space during runtime,
>> preventing the paging request error.
>>
>> [1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
> I need input from EFI people on this, so can you please resend the
> patch with a CC to linux-efi@vger.kernel.org?
Ok, i will CC in next push
>> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
>> Signed-off-by: KobaK <kobak@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> ---
>> V2:
>> 1. format the changelog and add more about error handling.
>> 2. replace goto
>> V3: Warn if parts of handler are missed during va-pa translating.
>> V4: Fix the 0day
>> V5: Fix typo and pr_warn warning
>> ---
>>   drivers/acpi/prmt.c | 49 +++++++++++++++++++++++++++++++--------------
>>   1 file changed, 34 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
>> index c78453c74ef5..cd4a7f5491d6 100644
>> --- a/drivers/acpi/prmt.c
>> +++ b/drivers/acpi/prmt.c
>> @@ -72,15 +72,17 @@ struct prm_module_info {
>>          struct prm_handler_info handlers[] __counted_by(handler_count);
>>   };
>>
>> -static u64 efi_pa_va_lookup(u64 pa)
>> +static u64 efi_pa_va_lookup(u64 pa, u32 type)
>>   {
>>          efi_memory_desc_t *md;
>>          u64 pa_offset = pa & ~PAGE_MASK;
>>          u64 page = pa & PAGE_MASK;
>>
>>          for_each_efi_memory_desc(md) {
>> -               if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
>> +               if ((md->type == type) &&
>> +                       (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
>>                          return pa_offset + md->virt_addr + page - md->phys_addr;
>> +               }
>>          }
>>
>>          return 0;
>> @@ -148,9 +150,18 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
>>                  th = &tm->handlers[cur_handler];
>>
>>                  guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
>> -               th->handler_addr = (void *)efi_pa_va_lookup(handler_info->handler_address);
>> -               th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
>> -               th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
>> +               th->handler_addr =
>> +                       (void *)efi_pa_va_lookup(handler_info->handler_address, EFI_RUNTIME_SERVICES_CODE);
>> +               th->static_data_buffer_addr =
>> +                       efi_pa_va_lookup(handler_info->static_data_buffer_address, EFI_RUNTIME_SERVICES_DATA);
>> +               th->acpi_param_buffer_addr =
>> +                       efi_pa_va_lookup(handler_info->acpi_param_buffer_address, EFI_RUNTIME_SERVICES_DATA);
>> +
>> +               if (!th->handler_addr || !th->static_data_buffer_addr || !th->acpi_param_buffer_addr)
>> +                       pr_warn(
>> +                               "Idx: %llu, Parts of handler(GUID: %pUL) are missed, handler_addr %p, data_addr %p, param_addr %p",
>> +                               cur_handler, &th->guid, th->handler_addr,
>> +                               (void *)th->static_data_buffer_addr, (void *)th->acpi_param_buffer_addr);
>>          } while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
>>
>>          return 0;
>> @@ -250,8 +261,16 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>>
>>                  handler = find_prm_handler(&buffer->handler_guid);
>>                  module = find_prm_module(&buffer->handler_guid);
>> -               if (!handler || !module)
>> -                       goto invalid_guid;
>> +               if (!handler || !module) {
>> +                       buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
>> +                       return AE_OK;
>> +               }
>> +
>> +               if (!handler->handler_addr || !handler->static_data_buffer_addr ||
>> +                       !handler->acpi_param_buffer_addr) {
>> +                       buffer->prm_status = PRM_HANDLER_ERROR;
>> +                       return AE_OK;
>> +               }
>>
>>                  ACPI_COPY_NAMESEG(context.signature, "PRMC");
>>                  context.revision = 0x0;
>> @@ -274,8 +293,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>>          case PRM_CMD_START_TRANSACTION:
>>
>>                  module = find_prm_module(&buffer->handler_guid);
>> -               if (!module)
>> -                       goto invalid_guid;
>> +               if (!module) {
>> +                       buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
>> +                       return AE_OK;
>> +               }
>>
>>                  if (module->updatable)
>>                          module->updatable = false;
>> @@ -286,8 +307,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>>          case PRM_CMD_END_TRANSACTION:
>>
>>                  module = find_prm_module(&buffer->handler_guid);
>> -               if (!module)
>> -                       goto invalid_guid;
>> +               if (!module) {
>> +                       buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
>> +                       return AE_OK;
>> +               }
>>
>>                  if (module->updatable)
>>                          buffer->prm_status = UPDATE_UNLOCK_WITHOUT_LOCK;
>> @@ -302,10 +325,6 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>>          }
>>
>>          return AE_OK;
>> -
>> -invalid_guid:
>> -       buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
>> -       return AE_OK;
>>   }
>>
>>   void __init init_prmt(void)
>> --
>> 2.43.0
>>
>>

