Return-Path: <linux-efi+bounces-3522-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1635AA629A
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 20:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B9A7A6779
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 18:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0280F21B9C2;
	Thu,  1 May 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oQWHvmzj"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3577B2DC799;
	Thu,  1 May 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746122735; cv=fail; b=sxg18sqchSuaUZWiI/UZhph15+u5r1eoNfuEHOG0borEdCAOqZR8ShupjNTR0vf8dUGlWqDAMhbm8sAQ8nPdXdetayW79j2K1RY3Wj8sQXyBUrqHjkCcgRoMLymCB9q8Y0dbxSCaGrndz48IUbgnjac9F5/Gmn5TsYp+sOr6wmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746122735; c=relaxed/simple;
	bh=ksIu7dfIImW8gdDuMaWRWKwbZmxeI10JwldRWGKFS0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RB1aFcIXbvONyxvqeqzTIr3iCrDhYPK8Q46hQ4G5HiInEdEA18mQoXGy87maV/A/eP+e6qlCFnoFX/MQlLj953TVopRu0nm5mqpCOhNqJ2SvWGojXiNi/gElDIvHU9Of53FL5Zum5fsSpxKjpJ/IxYvN+sGJHFR+DlbJFsZhJLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oQWHvmzj; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/yP1A6LmlWnoEGqW7LJWpg0HHCLQyjuwtTQXYIbGD2GaNZD38W3pA4D9z/c2kwJpUxwWwf0mNSa3qudgUSY8igzB2db1WUe7i4mZYPJkvBWacL2nXynFy0nZR2boB+dCC+J6MuGFMcjpRQBa+QfvtN05U2dFJAGiTygN1FJe9rrpc0O9MyQZIFsgn7qELuw3t3hf0kGkVDE7dYlMaoBLfGueMCXYi+ZRPeUHxJJXZy4vsjX02ttdAMeUtz4LKWyjmns9FvCphYnyx9fuq+B2YV8vkT2a3rArTRG/x7alAZ5tcHwV2F3+8ZULxi8AAQK/SdtdhBPEdAQk4B4xenhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yymLSFBSejjz7SbbqJ/Yfp+e0DrWMFyrEykQPyR4Wr4=;
 b=gW+UnOXnST2rnZdUlEyZZyuFA4Z7dh6LfvK8Bb4u/HIKnWNkPuEADvK2edtTS2DhK/MDjPVaizR6n1vD5Vgh6VsiC+xLF3Z3qTGHsKd0+/FffnMmWSdDWX4CHa++AZFynV26HgMpyL3Ygh7Rp0vnXDApm73XzlJzdZ7GfoBE28umGKN3/npsZla3BZoaDeA7k2MPCErRKEADZTgsyVpRSn6JG6RwbO9w1DbH65Sq9z5voE+5xDE7swq2lWp5luCAvyd0lF0gW3s9Vh/OQglNg9F/GW6gHiwHc1wiXyA/b6R1Kjw/fdAsGiTMh3hnXyTPnsPBCKTaY08BSBAt/eVswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yymLSFBSejjz7SbbqJ/Yfp+e0DrWMFyrEykQPyR4Wr4=;
 b=oQWHvmzjW5X1EKzSHw5yp+vBIC+5gs5Bm9NbTDnns/sNrFXO32Yg/uje1tL2tRmTn0WtBN5I/ZxNoBfaOGMkYQlkiROaTZiarzmN+qZ7Bbh6FGAegzchiFWUR3R2FqosSu2xSA0SUTdjLIFNnqdJWrpgD4o2F4uxNRFD5Tgnb6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 18:05:32 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 18:05:31 +0000
Message-ID: <0ad5e887-e0f3-6c75-4049-fd728267d9c0@amd.com>
Date: Thu, 1 May 2025 13:05:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/boot/sev: Support memory acceptance in the EFI stub
 under SVSM
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>,
 stable@vger.kernel.org
References: <20250428174322.2780170-2-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250428174322.2780170-2-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:806:24::18) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa46485-51e2-476c-3095-08dd88dac338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3JCWVRFcC9iZEtLa2Vsb3BnZG9ZSWVpUHFvU1MraEt0NFJ0R2xob2Fwb0Nq?=
 =?utf-8?B?QUVIdjg0UDc5ZEN3ZzNFKzlMbjBvcHRnWS80WVZEWjc5eUtFbnJkU2h5aDlr?=
 =?utf-8?B?Q3FrcWViSWRCVTVuUnd3Tm16VWJieURGbTNyOUd5dHRYYmRVRmdPWVFqM3ps?=
 =?utf-8?B?TG90K1U4RWVwT1ExSVpyN2dnMU13NUJsL05XVTZCc0ZPc1NnMFg4cUdUV09x?=
 =?utf-8?B?RTdvRjROZHpKOGxkcDZUVzBEUCtQdGh6SGtMKzFCbWNWOXZFSmovaVl3Zlls?=
 =?utf-8?B?Mnl6ZWtIa2ZvN1BNd2RyZEpKNXZUckF5aTQ5M2x6V092bHYybWFFY0RCQ01F?=
 =?utf-8?B?SE9mMGgvaGV4Uk9mMmRPMUVRakMyNEpobGxacHFLbnlrYUY3QitESzhlTGZS?=
 =?utf-8?B?R1h5THVRU0RwQ1M2UDJGK0xDU0FvbmNFU2pvNnU3S2MzcEl5cmx6MnlqVENv?=
 =?utf-8?B?RXc4UWQ4cTQ1WUc3UVVDa1dObWVnVi9Ic1JVOHZrT0RFMUVpUExHRitnVkJW?=
 =?utf-8?B?b0RyMkJZMThjNUl0d1N0ajA0ZGdUeTJyVVdrVUo4WFFSZEczSVJnZTRDVFZE?=
 =?utf-8?B?TlNZWStHM3g3dmFESHJ1VHVMakZGMWhNOHdvbmV2RTBFU0J1aG1sZGxacldS?=
 =?utf-8?B?MS9FODN5RCtzM1E1dGdzU3VlYm1hSWVNZ0VNdHo2dWhhZDZZZG1QTi9WTU1W?=
 =?utf-8?B?NlM4ek41ajZUTitvRUE3Sk1KRHd2bFNkUEoyT3hQcFk4aW5XZHdGZGk1OVNZ?=
 =?utf-8?B?MDJMOXk0R2FGaE1ra1hpQXFvMHRQS0FFaE91VVY2bGtWcm96eVcrTnQ0UU5B?=
 =?utf-8?B?eExLRzZBNFZZOC92Q2tFU05TWW1rSG1EUk5kWmtIZEl6Ri9CTUFHcnNXZDhN?=
 =?utf-8?B?blNKbjZ1bHdEVmdaQTNrR0oyUW9RRnNZUDI2RlkyUGxTZEZaLzlKbUxDK292?=
 =?utf-8?B?NVBvTURCak42QUp2RmVnSExVUkhLY0o4R1B3Q1pRZVppdDhzUE02TmVIU1dD?=
 =?utf-8?B?aTVDRmZrc3c5cFVqalV6cmp3TWVOWHdmNDJRYldpbmcxSjBiTXdUcE9SaHZ5?=
 =?utf-8?B?b0FhY1RKQk0veW5XTkxwcTNINlJhU3pML2IzbExnNUZxODRNd2FUZlJYdE1w?=
 =?utf-8?B?cW1JOUVTWUIvUVkxT0RMQVAvbzdkYTZiV3hKMTNtYUtYNHNrK3E4Q1FxWFVs?=
 =?utf-8?B?c1hnelBjV0t5eGE0Z3RHb1o5VWNuTk9JUVNpZFNDQWwxVUQ0ZHVSeWNxUmhX?=
 =?utf-8?B?Z3F4aHFCWG9UdVpVU2xiMm5CY0JWN1d2REtkTGl4MERuVlY1dDMzQ2h2Ni9E?=
 =?utf-8?B?Zmo2eFBIVlErSnNucW1WS1MyYTh4UnR1YVBLMktYSklDTXQ0T1FCOTRabkVN?=
 =?utf-8?B?TEV3QUhlQjNxTGdRV0xLVlJydUdQN2RvelIvM3FjWmF0TWJGUStQSkpwaEZ1?=
 =?utf-8?B?dXpIVUlkTVZSazlnam4vaWt3NEtTeWV1NEtYWTBrU2JIbjdWQkQydUdlNUlD?=
 =?utf-8?B?RlFZZWc2RFR5YnpBdm01OXB0eWk1OVZCTUxkbWFvcXhrTHZCMzNZejkvRWVQ?=
 =?utf-8?B?cGlQQzN3aGREZ09QRTczR3hOa3hDTndJRm02b3h2aEdPSDlDazg4SjlBRXJ3?=
 =?utf-8?B?RlozNmY4LzFKRWtyekUyWitYUkNsYzJXNXRRZVh0bDRaNE1CUlVLdVZ2Y1Vl?=
 =?utf-8?B?bmpGNE85eHJpSUMvdEdSbGNiVnJEZzRlQi9NdnhMYjVuaUFCYUhwQ1Q0WXNZ?=
 =?utf-8?B?NHZKaVdNQ1pTNFVSN3RvN2dwNjhkMC93RzBuR0RlZy9oSk5ZTlhLRHU4dEhU?=
 =?utf-8?B?VzdKYVdSbzdrdUpWVXE4dmk4bFBWVzJ6VGhwU0NnMTl0RmczdHYvNCt4ZkZG?=
 =?utf-8?B?T1VIcUtnYTV4cHVlcVRiNU1McGwzUVUyOUozdXEwNGpRK3dSa29hMkNiS1Zm?=
 =?utf-8?Q?1n9IjsWCnFo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDIwUWxXaDBKL1dUaDhRSGVYNjBkL0ZmOE53MWRURnZzMHRZTzBTRHZaQm8z?=
 =?utf-8?B?N0s4N0FJT1M1eGZLNHB1VzNuMTJ0V05yV3F3a3M5ZEY0ZXBWb0s1Vy91aTBN?=
 =?utf-8?B?TUtjVnh4SDMzb2h4YXpKMDFIRXpOb0NlcSsramNCQzhjRmkxc3BaRDZYS0dw?=
 =?utf-8?B?Wm9meXZaelp2aTdhclVqL3VzQ0Y0ZDlBamhkeHJnUWo4UW9NWlZ6bDhtT0FY?=
 =?utf-8?B?OEFnTWpaVTBTK1JWdlU0SVNWVTJyV1RUYWFSRXdmWU42N1hZU1A2Y3lnOC96?=
 =?utf-8?B?aVlVNS9naU5sMUdlcGt3UUpEZnhoRDB1M1lPdHA5TGI1RHd1T3ZPaFNUdWwx?=
 =?utf-8?B?MDkzemcvelNDQ1hWbzJFVjJpVVBVSU9sZlYzTE1LWU1tREhwWkNwUUErdnps?=
 =?utf-8?B?S3d4VC95RlpjUllyV09EVjJQS2QxbkxlMDJSNEhCaVNQRGZQUGFTVDZvK2N0?=
 =?utf-8?B?TlNQbkIxK3Q2WnhUOFZvdXJqZUhtdlhDZno5aFRqOGhsMndscHpWQS8zQXVV?=
 =?utf-8?B?Yy9UWi9tZU4zcUc2OXRpbTR0SzR6NWNyWnUyZU1XbTBkT3ZmN0lVa0ZLV2hu?=
 =?utf-8?B?dTJDeWhqUk5UVlJoUTZXZmV6UXZhZnhidzlsZlNzTXVpeUtUVzVGSUp2Y2ZZ?=
 =?utf-8?B?RWt6SG5pV3Y2NmlXR0xNMUlMTDdrSWpjczBiQXlNWWxaaWZBS1pTa0dMd2Rx?=
 =?utf-8?B?MHc3T2phVHZBeHJ6cjJWVVhFM0RHVDQ4ZXpDUG9HVlBNcy9JcDcxanp3cHBI?=
 =?utf-8?B?ZVFHSlIwQWZNUTlLYjQyeUl3aVQ2dlF3YzJIY1h5RW5ZTEJjYWkwWDV0UDZs?=
 =?utf-8?B?ZVlmSTFVT2dNQmlHd3FteUVNbk5uZWhIZzcyMlRxSDF5bzloeEEwa1B6TUs0?=
 =?utf-8?B?ZnNWZHZwbVhDYVZnWHdrcjlRVWV1aDdUQnVrbGRwVTdsM2djR3U1SSs1MDM5?=
 =?utf-8?B?NjUzVFlkVVIyWkhhOEpBUFBHRVQ5WDFwQjBCb1dYR3J3SjdHSEJaVFA0cEVN?=
 =?utf-8?B?eGhsTXYvSmlObEM5RWExcjZDQUNmcGFUVk03dGxSazk0cFg5d1dYa1BZZ3Z1?=
 =?utf-8?B?YkVsdEhrbkRiZ1JxVG93TExrSGd2Qk0wYkJwRUpkRlZpL3N1WndtSEQvbE4x?=
 =?utf-8?B?RWIvelFuNzNJZ2svbUhNMVA3OG54WDdpV051eVh1WTJuTjBlOVAyMnJnMERC?=
 =?utf-8?B?TGFYNS80RU5sMm9jQUF2WkpwZXdqU3Q4aXlwbWp4T0xNYU9XY2tMSFRoMFRC?=
 =?utf-8?B?NXBjQnRyZThud0p2OTUwUEkvZklKd1hITDd1U24rNTRvKzB1NkxyZzNFVTRk?=
 =?utf-8?B?a2ZQc2RVbU9NL2NRMjZPZHRVeEJoRFZZVVc1N0Q1RVlvaWc1TDdBM28vQi9p?=
 =?utf-8?B?dEZ6QjloT3FTc3c2UEJ6S3g0cGlXUXZtVDlIZFhONGI2S2dFdk9zLytjKy9E?=
 =?utf-8?B?czZoUDdHYVR2U20yTXpteVk5ZVI4Q3YwNlEvS1BWMm8vc1hQckpycHVma3Vl?=
 =?utf-8?B?eWVDem9aMFR3UXoyN21kVDNZMVhPSS9mam52NG1paFc1Vi9ZVjlsWjNQZGZp?=
 =?utf-8?B?VWIxQXN3dlBMRVhSTUljWk93R3p0U0ZuSmJleUJWcXA4SHdtbW43dXpxMHZo?=
 =?utf-8?B?SzU5M3lscnlDdkxMUDJ4ajAxWkI3VlhtTHJIZEFaRDZ4aUUvTWZHL2hRN0hS?=
 =?utf-8?B?Mk5lUTFFeWVtUVZPaGI4Q2N3a1pZZlREQ0h3MFdkUHlrWXVpdzZsTm02enZv?=
 =?utf-8?B?c0JXL2NlZ0g4Q0p3VW9wUHRJYWpoMXVxenRqNzhYMzBwNVZRd20xbC9OY1ZQ?=
 =?utf-8?B?bDBCay9rYXBFTjlWUDA0cW9SNnFJUnc3ZGo3OU1ZMGZXZkt5WGZBT2VTRnFB?=
 =?utf-8?B?TVZWWmFHNlZ2YzN3REFCZ2pSbWFjSVA3a2hKYjlsWHR4WGdlQUIrUHdHemh3?=
 =?utf-8?B?KzNmMk0rSmlaWTAyaFRweHJJNWx3R0VsZ2J5Y1dDMGdSczRvRGFzN08wL0M2?=
 =?utf-8?B?Mm5kbHcxbmJFQytFcVFpU2U4TVpsOGF4azBpS2t0c2xod3FYdFBiWUNvMWls?=
 =?utf-8?B?aWl3aUpUcHNpQUl5SG5XTW5BcHhBOUZnQkdrZzczRTZjL2w1U016VjJabStM?=
 =?utf-8?Q?2iCFXJI5s5ZZVmcG48rytn+gh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa46485-51e2-476c-3095-08dd88dac338
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 18:05:31.7760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Umz+k9/0PMK9E2tP/6Jz60keXpOE3unLBH+VjEuIwSkrE1WJ3hADEqGf+ocac2cgKIi6VRC4AjDwsNgejVLoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150

On 4/28/25 12:43, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Commit
> 
>   d54d610243a4 ("x86/boot/sev: Avoid shared GHCB page for early memory acceptance")
> 
> provided a fix for SEV-SNP memory acceptance from the EFI stub when
> running at VMPL #0. However, that fix was insufficient for SVSM SEV-SNP
> guests running at VMPL >0, as those rely on a SVSM calling area, which
> is a shared buffer whose address is programmed into a SEV-SNP MSR, and
> the SEV init code that sets up this calling area executes much later
> during the boot.
> 
> Given that booting via the EFI stub at VMPL >0 implies that the firmware
> has configured this calling area already, reuse it for performing memory
> acceptance in the EFI stub.

This looks to be working for SNP guest boot and kexec. SNP guest boot with
an SVSM is also working, but kexec isn't. But the kexec failure of an SVSM
SNP guest is unrelated to this patch, I'll send a fix for that separately.

Thanks,
Tom

> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: Kevin Loughlin <kevinloughlin@google.com>
> Cc: <stable@vger.kernel.org>
> Fixes: fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")
> Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Tom,
> 
> Please confirm that this works as you intended.
> 
> Thanks,
> 
>  arch/x86/boot/compressed/mem.c |  5 +--
>  arch/x86/boot/compressed/sev.c | 40 ++++++++++++++++++++
>  arch/x86/boot/compressed/sev.h |  2 +
>  3 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> index f676156d9f3d..0e9f84ab4bdc 100644
> --- a/arch/x86/boot/compressed/mem.c
> +++ b/arch/x86/boot/compressed/mem.c
> @@ -34,14 +34,11 @@ static bool early_is_tdx_guest(void)
>  
>  void arch_accept_memory(phys_addr_t start, phys_addr_t end)
>  {
> -	static bool sevsnp;
> -
>  	/* Platform-specific memory-acceptance call goes here */
>  	if (early_is_tdx_guest()) {
>  		if (!tdx_accept_memory(start, end))
>  			panic("TDX: Failed to accept memory\n");
> -	} else if (sevsnp || (sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED)) {
> -		sevsnp = true;
> +	} else if (early_is_sevsnp_guest()) {
>  		snp_accept_memory(start, end);
>  	} else {
>  		error("Cannot accept memory: unknown platform\n");
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 89ba168f4f0f..0003e4416efd 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -645,3 +645,43 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
>  
>  	sev_verify_cbit(top_level_pgt);
>  }
> +
> +bool early_is_sevsnp_guest(void)
> +{
> +	static bool sevsnp;
> +
> +	if (sevsnp)
> +		return true;
> +
> +	if (!(sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED))
> +		return false;
> +
> +	sevsnp = true;
> +
> +	if (!snp_vmpl) {
> +		unsigned int eax, ebx, ecx, edx;
> +
> +		/*
> +		 * CPUID Fn8000_001F_EAX[28] - SVSM support
> +		 */
> +		eax = 0x8000001f;
> +		ecx = 0;
> +		native_cpuid(&eax, &ebx, &ecx, &edx);
> +		if (eax & BIT(28)) {
> +			struct msr m;
> +
> +			/* Obtain the address of the calling area to use */
> +			boot_rdmsr(MSR_SVSM_CAA, &m);
> +			boot_svsm_caa = (void *)m.q;
> +			boot_svsm_caa_pa = m.q;
> +
> +			/*
> +			 * The real VMPL level cannot be discovered, but the
> +			 * memory acceptance routines make no use of that so
> +			 * any non-zero value suffices here.
> +			 */
> +			snp_vmpl = U8_MAX;
> +		}
> +	}
> +	return true;
> +}
> diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
> index 4e463f33186d..d3900384b8ab 100644
> --- a/arch/x86/boot/compressed/sev.h
> +++ b/arch/x86/boot/compressed/sev.h
> @@ -13,12 +13,14 @@
>  bool sev_snp_enabled(void);
>  void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>  u64 sev_get_status(void);
> +bool early_is_sevsnp_guest(void);
>  
>  #else
>  
>  static inline bool sev_snp_enabled(void) { return false; }
>  static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
>  static inline u64 sev_get_status(void) { return 0; }
> +static inline bool early_is_sevsnp_guest(void) { return false; }
>  
>  #endif
>  
> 
> base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e

