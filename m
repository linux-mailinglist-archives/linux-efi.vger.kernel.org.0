Return-Path: <linux-efi+bounces-6152-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI8kM0Mvk2ke2QEAu9opvQ
	(envelope-from <linux-efi+bounces-6152-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 15:52:51 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0F4144D57
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 15:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E795B300F118
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C10B3128CF;
	Mon, 16 Feb 2026 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5WQqZXit"
X-Original-To: linux-efi@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABDC29D26D;
	Mon, 16 Feb 2026 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253540; cv=fail; b=B5IllbMv6kx2tF9FwzmB8UQz/LUffLCVi07jjzhtcDhnFvpUN7jwNj/RRaM3dcC4/B7YoPnsfMuv3f+V/gMmUIxnsjaqOwdccYsskm+Sr1XMwEUi7hTxG3NH5vfUXPkkdPLH3btMrwry5uNr/X8dnOKLU0yFxn9SXPBj0Em615E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253540; c=relaxed/simple;
	bh=I3wI4AJ7Aiu/S41Q+CzulRQ30aWxr7uIki6a8pwOLe4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fk9TojuVdGYnudd6a4Cgbf0T4gI4tJQz+gfOWibnz0C3OTKZ2SVWZH8nWfU6x0krqelKwXzYiw36CECgHpGuBFWgRWjTzw6eSfrwHvEhCMb6KBFQI1Ggr55p58ARbsWpGFJxAN+IAm+YjDrMYiBTqSeKxHX+jYvauByTDXjk1tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5WQqZXit; arc=fail smtp.client-ip=40.93.194.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLQE4agGcLFOre8aXIcZ0bm4JgBuJcedx+tfw67QqgGXFZIeXKj3M1sGE42KNrk9mtt11UKMNytwPzfWNiObtgof/AikOylXmT0883KU5RyOKRkAKv2F62+oFadBG6wZAnab78t8n9QUdac6zMrzFBhFwCjvglKA8LTn+MnbFQiwBe9gI6Vzv9WVwDwK7ABodhuV/BA4kRNFT0ybkLkW2CjJkV0kUEY/19eMLOvm80az8dfrtsDaaExPWoiHN2MjlM1GtNv+eHqePDCrCHJxjka+6+frhSpci6fQT7MlVxlf48o0wrcb1wkpjBX8MSIGfzvAPtOTk/yURQWPJ5OcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meW4gEcjpBRXsbEceRlKYF2vDUu/CeNqF3OO7Pztu+E=;
 b=NVlXaf+hs5YQjURIJ4yw2AXvXJasTASZq/JzpRI+kpKQHwW2jWIH6TYnCA4DhX4aGrdL91etJjipYQiTZFoylnRiRcP6g1i0Z4oIt+3LE2TPazwMgCkF//4izwZt18zxNtFRRMeOvGmma+FS3gT7SJp3b28/WzodgXLEvx0K82qfEW6um5CZ5eS4/+nOoy7AOuNagNcEHVbVA7HVr6waXxAWaUgpKa9191g9TRKhgTLYU4klMZoLXg76fmDDuS7EG3CJfAYImN6mWKOElSCKEQj47eLcZ5K+Cdnyt46VMC6J0JoIIrEMmGmP12VjVKfMug+2iOtjF/334X23BdbNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meW4gEcjpBRXsbEceRlKYF2vDUu/CeNqF3OO7Pztu+E=;
 b=5WQqZXit2P3h44e6JvKqFqV2XdPqAImiLrT0VTEC6ABXoxOhZKl/mqxynBsmCzLOn02rvxXYUwqtLKHyUIs14hQM/WcrhTzlgqW7SzVQif4QWbolgyF0D1jZ0VMMXoQ9zXuJ0rO5oCR+FJ7CnSCBn0pamoNSx2M8er6yuIr0yFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS5PPF5FAA0E762.namprd12.prod.outlook.com (2603:10b6:f:fc00::651) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Mon, 16 Feb
 2026 14:52:16 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 14:52:16 +0000
Message-ID: <86c040be-e91a-4d1d-a365-a3bf3772374f@amd.com>
Date: Mon, 16 Feb 2026 08:51:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] efi: Align unaccepted memory range to page boundary
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Moritz Sanft <ms@edgeless.systems>
References: <20260213154838.46567-1-kas@kernel.org>
 <20260213154838.46567-3-kas@kernel.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <20260213154838.46567-3-kas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:806:125::31) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS5PPF5FAA0E762:EE_
X-MS-Office365-Filtering-Correlation-Id: 534bb88d-31be-43be-aad3-08de6d6af9cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXh1bzA5bkFXdVZKcHlGdTJZcjVDMFZ3VnVJamg2RmtSVjE4cWljZU81ckM2?=
 =?utf-8?B?b240WUxTTlNTSlBDTDhkQXBJNzVVSHhCL0tibTRSM21RQ3JKb2RVUEVjRmcz?=
 =?utf-8?B?Q3JGQU44dzl4M3IrZnVabzNYOUFvSzEzYi8zN2tTWHBINXZVRERkUmJNbXpR?=
 =?utf-8?B?NjQ1T2NjK3ZjbXh5Ni9NWi9EaXp3L0NNUTBaVkljRzQ2YVNtOWtBN2pkeUVq?=
 =?utf-8?B?cURQU1V3Z21tZ0doQmVTWDM3SFhGWWQ4K3d5YThiSWorK3k5UFVReTBkbytl?=
 =?utf-8?B?NGd6dHNiVGNnNnAza2RGUmFDRy9IcVE2akJsVTUxQUZtOTZSdlNzU3pjMVhC?=
 =?utf-8?B?MU8vWkh5MmJjc3pydEhJcDNNU0lINXB3dnBvcmozVm83Yjl6SXh3QTA1cTFP?=
 =?utf-8?B?VERxK0RLYXJYazdJNzFTZGJmK0dqZTRYTDRSb2VyQVBUeUp0bHhCY1Q4SlU3?=
 =?utf-8?B?NlQyZHNwL0VaSnpocWFYWG5sV0ZIVGNhdkpuNU4vTm1DTFU0VXRPMCtxeVRw?=
 =?utf-8?B?eDZCSlZLRzlEbVNhOEZLNUtqdzQ5T3ZMcGZxdnJVMHdFekhRb3Rza3JPcUZD?=
 =?utf-8?B?UzR2d1Q2Q29ldjRuOEZWMnlIbVlqdjNadUcvSTFYZWhHOVQ0aWp2RUZzZnJ2?=
 =?utf-8?B?cEVSdXJQc3FuRkFNWTB0bGtFblFWLzhhekxFM3N1YURuQTVFZWpsQnd2aGdC?=
 =?utf-8?B?enhBS0J5UjFycm5NU0VRUW9jYVNkK2JDVkhLYm9ackx4ME5VTm9UR2pUVTRU?=
 =?utf-8?B?N2pDbDRJbSsyMmtlZ3NlbUd2WlZYSVhxNVd4dnA0TUxzdVQ2N2xqeWxVVkV6?=
 =?utf-8?B?RkZhR1Z4OXlwWHhmcmhmSTV4WXRCZmI3QWJ4V1hNbjFKMUJ5WUQzRVB6TXB3?=
 =?utf-8?B?N3FMN2E2Vm55VTQ4eitLc3JWSSsvV3YrMFlRS1VuQkNRck1EYVlBT2t5d2Jz?=
 =?utf-8?B?RDRma0tFL1MwV1FnU3hZdnc0M3Z3NGMyUElMY2dEank4T2J2bENzUExOZk5I?=
 =?utf-8?B?RElMYzZnTGRrMk16MVI3TEJSZ1VCem9SdTkyZmdoaFB0MW9DdVg2K2RoK2Q2?=
 =?utf-8?B?b0U1bE9iYmJodnRRNmRHdjBhMEJDYWVJeEhhRCtDclVQNTFUdWVxTk5pMVBa?=
 =?utf-8?B?QzNkZnpmeHBYenN1TEhLYWU5SExCeDMxOTluVTNBQmJZcUh3QjdOVE9FRkVn?=
 =?utf-8?B?YXY5eGlHbEFFNGxUN2VtNEhpdDh3amkxWHNscWNEZm11UmNrM3J4WjQ5QUdn?=
 =?utf-8?B?RGZ2UklSYzJQSlNFYWtZdXdJdUlyd2xueFZSN3Jucm4ydCs2SUpIbGRXbkRi?=
 =?utf-8?B?dkZhMm83NU04NDBTK29CQlJxanBlaWZ0Y3VyYVB4dVBNQUx1MER0TkNKVXNz?=
 =?utf-8?B?T0x3cWQ2dHVKM0JzbE54OXFlWndkMlQ2ZXJkemhyTlJ0R3FFcXhSVWhiS0Zh?=
 =?utf-8?B?Z1pGZFZ3cWlNUXdieE5nVkxzUnJkQ2JXS3cxdVkyenVEU0lpOFA3M281K1VY?=
 =?utf-8?B?aGFEbmsxQlNYdkp4RHl1NTEvd0V3Q2ZCMGx4Nyt5aExSSmFEaGJXRkR1blUz?=
 =?utf-8?B?RzR1bjJmcDh2VWFpLzRlZFZPYkpwZndjZlc1T1JDNFdPQWdROXNjejd0OTRp?=
 =?utf-8?B?Z2lBdElCVURxbzFvc0srU0E5STJWL0h2b1JNTjlJeUYwZVNBbWdPUmQ2Nmdq?=
 =?utf-8?B?dUhFY2Y2MFVXT2lMd0M2aTZCUU1RYzRLZ3JvY01zZmpZTndxWG1KcUExNStz?=
 =?utf-8?B?ckRTZjZ4djhGUUlSNzdmTFBLeFhXYXJIbXVYaXoxSCtTMXVlU09hWkd3YWtr?=
 =?utf-8?B?Y0hjQndlZUt1V0tldTZKcnJMSWJmTzhqUklkSGxyZ05ORmN1TmI5akUraSt0?=
 =?utf-8?B?YXFwNktLdFIySmhHUjhCQlFwVDRBUmdleGtiOGM5czkyYUdQclZ5UlRzVWhl?=
 =?utf-8?B?TGErYkVYb0hrUVI1OFdpUk1obDZnaHV3Q0ZCNS9HNk05NGZzdHAxMDAxeE9Q?=
 =?utf-8?B?azVGYW1oRHIvSEJtK05sTXJVdENLK2pZaC9UOTgvWjdHcDA5OEsyWWlrU2xs?=
 =?utf-8?B?NmVSUGMxS1JHZHFKVFlVRk01clI1c1EzSjdEQ3dRQ2UrUkxqUVY0eVhkWUpK?=
 =?utf-8?Q?J9pI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUJqNituZ1lnc2ZkWjdxSUs5Qng3a05YUGRXMTJIcGNKUXVjbGhRUktXUHNu?=
 =?utf-8?B?S0hKQnA3UWQ1S2N4UzVYMmJtZVltUHQ3d3VUNXRXdWt2SWdEZkxzM3dwLzlq?=
 =?utf-8?B?a2JOc0JYa3BxOU1XclpnZS9jcldDUEFUbUZQbXNGTml1dnk2SXpsVWRJL0sw?=
 =?utf-8?B?dzQzeEFCb0crb1hlQ2Z2N01aaG8zcXJtZnQxSlB5d3hMa0I5VmNnVWZLUVgw?=
 =?utf-8?B?M2NyWnk3KzkyUjJkbEtyaUNhazNuSm9Vczk3c20rbWZBK1FIVTYzaXZpZmpI?=
 =?utf-8?B?bW5EMlBWSVFJb3VEblpQN1lwWk9zL1FJZ2JxN0w3Y0hsWXp0a2l3OFo5RTd5?=
 =?utf-8?B?eTVBeXgvK0FPUlYzdUpjaTR2OVljZzg5cUtUNXczYmZBSFRUdXNKYmxwZDBZ?=
 =?utf-8?B?dkd6UmM2VDdmZ2czNVN0bTFJZ3Q0UUJob09MQ3JPcC90YXFqQkpiSmVRWkJn?=
 =?utf-8?B?VTY2V05UMWNpekcyM1Q5RE41SnlIQmo2VWlGZmtwL2wxZXIybVBtTllreUx1?=
 =?utf-8?B?N0FkRWFldFlBRnllQmVhbUh5SXRrVEZvY0VjaE96bHVnK1NvUGcwdmFJWkF5?=
 =?utf-8?B?UFdUeUdTWmJURUFJaVF6VkxyR0ZVcnhQNlYvM3Y4RVE4KzM1ejh0K0NDN004?=
 =?utf-8?B?bmRCTDl6WEhRN2ZuVXFZbHMxWnR3VTRqL3pSL2tiaTlONGc2SEU3YVNvcDVP?=
 =?utf-8?B?NUNZLzNEcnptV0RrZ21IemFZYkRhR2tXNGUvWHRHQWV4N0Z0ajB5WGJVS2RF?=
 =?utf-8?B?c3c0QUxocTBML3p1R0FUckNNS3lLVkxMZFNwbTF4RW52TUhVZWw1dDZzZmMz?=
 =?utf-8?B?RFEyem9PVy9LeE01S3dDdUl6c0REN094NjVOTFc5a3ZKUk80N0JhZnVRMGlk?=
 =?utf-8?B?aDVVcStsNTRKNzBWaFBCd2VubUg3dDlMajVyb2g4ZUwreHNkZGovUTVsd25p?=
 =?utf-8?B?cVBEUkZIcHNYNDR1WFFiWDdRL0trY29ET1Njb0VUV3RxYkdCQ1ozZEpuVXRO?=
 =?utf-8?B?K2RwRnoyempMTUp4TExyMkJFeFNvVlhxemtHQVd2UFQ3QnpMd1lTT09EWUhY?=
 =?utf-8?B?Q3hPbmxpRzBhQkpkT3dxcmhGczN0SnU1NXVFVGRubWgvZkR2TkVBL0FhQmdl?=
 =?utf-8?B?eUxUYk1nbkNCRTZiRUthK2hUMlJFU05lUTBVblN0eHRQTGszZjJMbWlLY3Jn?=
 =?utf-8?B?OTVKSStzNGdwUVZVd2VIRUdOaS8zOXJOd1B4R3VKTDMvZHFmdmNCWVNsZytJ?=
 =?utf-8?B?Q0NJRm1SbUtxOThRVFVnSmxMYUhkME84azNnaWkzbjRHWldxU3FGeDZoL2FU?=
 =?utf-8?B?MmdrUHFKQ05hamZtMndzcDlTcTJHakx0TzJCMzE2N0VYTTl6OGd3U0F4Njdw?=
 =?utf-8?B?TnMySENrbHlQeEh2MUxSZmorS2FyLzlUYjBrNmVTT2xhaUxUMlRTU2NTbHBS?=
 =?utf-8?B?a2NOWDJpZ3AzSHdCWUU4YmJkUmZyajR0SmFCUmlUd0FNRk53SlBKWkpVRzBC?=
 =?utf-8?B?aXRhVThZZXlCTnZyMi9wWkhVMUVLNzdZT1duZFpRSENuZ0VKdklVWmNVQUVB?=
 =?utf-8?B?OTNaOUphK0QwdEI0Y1M0VHNBcFVJTmdLWFAvS2k2ZDRqbitiSXVCT1JKbDVq?=
 =?utf-8?B?UG1YOG5FdmdPcFhBeExxZDNoZVp1MUdYdG00MnRxcXVWSEx1dEhUMTVvQU11?=
 =?utf-8?B?aVFWR2FTMnJ3Vit5VXlwZ0s2SVRKMjBCc1M0YzlOenFFUUZPaCtrN1YyR1pz?=
 =?utf-8?B?Q0FUZmV2Q2RENjk5YjM4TCtPTzFWWC9VRmpxVGlKWUhzalVFd1NxY0dWclhq?=
 =?utf-8?B?ay9wdmV5YXFsckpoY1Rmb3dBS1lBdnNEdEdmdWsxRi8wSitHK3ROT3VuUWhP?=
 =?utf-8?B?M0J6Rm8yRzNac0NJRk1icFM0MUNjdVdwYzNPSnpGdTA1Sy9LQldnSjFvclBZ?=
 =?utf-8?B?Q3FFTEExVlg3OFByMmhBRVhmcytKRWxMTkFJR0V0cDVpN2F5aCtmMWRrejRY?=
 =?utf-8?B?VVp2WHMzVEVIK0dhRFBUaElETnA1ZXNSaWp5YnlhdmlvNllRSlRzYzlCTnZr?=
 =?utf-8?B?Q1QrRXJwS1VEK3pEeHI4b2V5bGZBMmpWck03YUEzS2RqY0ltQ1dHclpsOXho?=
 =?utf-8?B?bzBTMGtyWnkxc1N3SnB2c3F5ZnVjbXJrZ05MZmpLazZLQUF4dUFMaTh0L3JT?=
 =?utf-8?B?SEM1TE51eVlPVkhlVm9EWTFZOHRaeVkzcHUrMjNONnUyM0hjdnZ0aWxLeGll?=
 =?utf-8?B?eXFOUXhCWWY0U0pyQU9jTEN3SmJyTWRSTkk4ZUphMnFTYjQ4dGpKTkhCaHVv?=
 =?utf-8?Q?UtD4JLayQe6n3TCRoC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534bb88d-31be-43be-aad3-08de6d6af9cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 14:52:16.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14nQnxIOiD4Gp3XoOF1b3xl2sWVekpmwZHBc/IObCEEaQUiLmKfDYX0Yf1JAGIKTLBCCSAVCWHTjS0lzHA9X9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5FAA0E762
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-6152-lists,linux-efi=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.lendacky@amd.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 5B0F4144D57
X-Rspamd-Action: no action

On 2/13/26 09:48, Kiryl Shutsemau (Meta) wrote:
> The accept_memory() and range_contains_unaccepted_memory() functions
> employ a "guard page" logic to prevent crashes with load_unaligned_zeropad().
> This logic extends the range to be accepted (or checked) by one unit_size
> if the end of the range is aligned to a unit_size boundary.
> 
> However, if the caller passes a range that is not page-aligned, the
> 'end' of the range might not be numerically aligned to unit_size, even
> if it covers the last page of a unit. This causes the "if (!(end % unit_size))"
> check to fail, skipping the necessary extension and leaving the next
> unit unaccepted, which can lead to a kernel panic when accessed by
> load_unaligned_zeropad().
> 
> Align the start address down and the size up to the nearest page
> boundary before performing the unit_size alignment check. This ensures
> that the guard unit is correctly added when the range effectively ends
> on a unit boundary.
> 
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  drivers/firmware/efi/unaccepted_memory.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> index c2c067eff634..9ddf3dedd514 100644
> --- a/drivers/firmware/efi/unaccepted_memory.c
> +++ b/drivers/firmware/efi/unaccepted_memory.c
> @@ -35,14 +35,18 @@ void accept_memory(phys_addr_t start, unsigned long size)
>  	struct efi_unaccepted_memory *unaccepted;
>  	unsigned long range_start, range_end;
>  	struct accept_range range, *entry;
> -	phys_addr_t end = start + size;
>  	unsigned long flags;
> +	phys_addr_t end;
>  	u64 unit_size;
>  
>  	unaccepted = efi_get_unaccepted_table();
>  	if (!unaccepted)
>  		return;
>  
> +	start = PAGE_ALIGN_DOWN(start);
> +	size = PAGE_ALIGN(size);
> +	end = start + size;

Should this really be:

	end = PAGE_ALIGN(start + size);
	start = PAGE_ALIGN_DOWN(start);

?

Thanks,
Tom

> +
>  	unit_size = unaccepted->unit_size;
>  
>  	/*
> @@ -160,15 +164,19 @@ void accept_memory(phys_addr_t start, unsigned long size)
>  bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size)
>  {
>  	struct efi_unaccepted_memory *unaccepted;
> -	phys_addr_t end = start + size;
>  	unsigned long flags;
>  	bool ret = false;
> +	phys_addr_t end;
>  	u64 unit_size;
>  
>  	unaccepted = efi_get_unaccepted_table();
>  	if (!unaccepted)
>  		return false;
>  
> +	start = PAGE_ALIGN_DOWN(start);
> +	size = PAGE_ALIGN(size);
> +	end = start + size;
> +
>  	unit_size = unaccepted->unit_size;
>  
>  	/*


