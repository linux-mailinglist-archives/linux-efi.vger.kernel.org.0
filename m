Return-Path: <linux-efi+bounces-4559-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E916DB26D68
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 19:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EB31CE2F3B
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003BB2FB996;
	Thu, 14 Aug 2025 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E/zpxxLN"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1C11C5499;
	Thu, 14 Aug 2025 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191870; cv=fail; b=F1HamXT3/aBP5nts8r8DEdPL7CpZuxJBS6RhGLmqcY1HDBcVV9iNlCXvgz9QP1B+mXexiBMbEniaOGhJEd+Nh0TUpiUQXB/pV3i8rtRnVp3eEMLWaW0g5Teq0ig16qRrlV4hF74Y/8VxuxI9qDhlM9tMG3JwqwtRDyNVS44qm8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191870; c=relaxed/simple;
	bh=VT/8TJmWZCH1+cDDVTA2480puW99KqeAQtxVIYxrB4U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=usjsZkycYVCDSKqX8JtBEI3trPnf5P+D7BxgpwcAEpGKq55LL0L2C2KPhxSM4G73MzXeoEJq90ALdIxjf5sbNl6mufzcvg7knh5taS8z1byjXmyB0a9ST88VBneF6ccRLgUiU2Ym6bEPAyiFeg82MNnyLSh1O3FvmLkbFYvKIW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E/zpxxLN; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhSqb9LDmlZkRqZJ/n73FdZA6yv1Vu40XA0mMfXHifYTnBVRdgRjZoEh1HrU68Nz+cq//7MBunnpnDWAxJJy/yCpbxbZp6qtTPhLPuwNHZ3ymhJD/QUeeVRH8B7EZ2nzJCBvOWAwdfr/5lexXrNHvbfj1nuZMDxN/yfCqGud4siXBLiEUk74IMficbvNYcSZTdtkpuLCkPBuWUVjyGXVh8h9Yph1Chcvvefb0i7e1fD6okLjzYVnbm2Tppvk3qg2pddhwfcR56O1nRkb4ftd/vGQiNGvDOWVyIAORex3j/+J0ePDYl2m/YaWLHj0pvayjTJLuoCg+xDqneoP5y/aqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWUZykw1k6M50YTC3U2Mh/zq7VX25qQGNVv7FRqXUP0=;
 b=J/muLBHdw/1+hFAH2PCGpr1hxDKKyvGd+lUl2Zo9KAAmZZD30Pt5GqCd+i/lzLR+npntDzevHEsyldaDp+2/GQtsEXvPNn/KzcONM8sVABEuISQ/FRg71Nsu0EmR+NU7lrLCzrL67eUP6N5ZbidkyseY0SMBg3V3U+OJqLL1/LHTHkougQxxsDZUQSd90wBwot1sjC9jTLbzc0cwZAGGJc3WPUAZNBqfDQvDk0pJaDAhFMvxOcuvUAOsEyswEfso/IXvRG6zJm6qbTOTuhrpXoQdUt2MwbPbbw/TQbkkDT+W7sVbshrGl6MUuIyXF7OVltjgVmHNl3o3HF/p9iUtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWUZykw1k6M50YTC3U2Mh/zq7VX25qQGNVv7FRqXUP0=;
 b=E/zpxxLN45zoKWu91wesHiNEzSFAPwp9pVGkzR+qos+Iy0sswtKnU8KYliSaRXTbpcZHn94eyOXJW/Mkhyqkpv2tlVgmHS9ih7qaFJxIhaz0tatDY14W7GpSqLyhOd150dGng68R7bhxbbyw1NSaKg9RRklJqb7+fWKyRQb04Z8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 17:17:45 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%6]) with mapi id 15.20.9009.017; Thu, 14 Aug 2025
 17:17:45 +0000
Message-ID: <38f6fa08-41fb-4717-9763-39ec5fa54075@amd.com>
Date: Thu, 14 Aug 2025 12:17:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/22] x86/boot: Move startup code out of __head
 section
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-45-ardb+git@google.com>
 <20250811174034.GRaJorEmcBfLTDhWml@fat_crate.local>
 <c9bb1b3f-17ce-254f-5d0f-ae3563b03b50@amd.com>
 <20250811190306.GAaJo-ai4M2aVod6_V@fat_crate.local>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20250811190306.GAaJo-ai4M2aVod6_V@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:5:335::32) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a2e902-95fe-4e28-af01-08dddb567a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlZCR1Z3dW5LNExhTHdkYWZUKzBWb1ZzS2tjNG5FbSt6RVd5SFNMM2wrTjJa?=
 =?utf-8?B?VmNOZUwvYy9hUFMrNW9oUklwd25iMS9FdFJacFhyTmJiT2JqSUpFQWhyTGtC?=
 =?utf-8?B?Y2xvV3NFdG5SaGtWa3YyYm4xZEJoZWtuVHhFUnZtSjd1S2pUU0c5ZlFUcHpJ?=
 =?utf-8?B?cEdKVDIybkpCTlFaVUpFbnJaQ2psUlBPSGZTam53WXJCRHp6eW9YeUhIelpi?=
 =?utf-8?B?ZnZaUjN2enNLbjRsb1NVOGF3VUpqODBwbERLei9nZlVFL2JXMzNkVHFWVTJH?=
 =?utf-8?B?akhrUUlXU2RwMTVVRFROWEk5Rm5ucERQZjVkMm0zcUZJS0pmaUVIZmRqVzVx?=
 =?utf-8?B?cDI3bmhLQ253bDJJNXZka3JUMlZoVG1oNGNIbVlZZ0JSbWdYS01BclRLd200?=
 =?utf-8?B?cVJ5YnBJSmt5TXh4ekpLdk0zMGt1K2xaVlg3MmY3TGdxTTVzZTFBSUdSS0tp?=
 =?utf-8?B?eld3ZWJMNTJNRHlSdm1YTE5lVllaWVQxM2tvcW4xVXYwemNxcCtPcXVGdjlH?=
 =?utf-8?B?eUc3SEFVeG5DRlcwa3ZueXorb2xBem90SDdodnkySDZGZWFaU1N1Wk9sSkNv?=
 =?utf-8?B?TDEwc3Bnei9LTUhHTGlnT2dCaEF6ZG9OOTVkT3VZV0JGOEtSOVNNMDY5TmFj?=
 =?utf-8?B?YjhFaVdPVkVYUnl2U3JVb3YzdmY3R1RhREFkV0pwcEgwbW0zMi9nbDE5dW9T?=
 =?utf-8?B?a25pYjhnNlY2Y21OUTFWL09STGRuU1U2QzBGc2tPWjUzbkNOV0Z4MlNvREhI?=
 =?utf-8?B?bFF1bERuMnlJaFNHTnU1TjBDbGQ5WStROVdVQkMrZlZiT3dMcE05MEdPL0k3?=
 =?utf-8?B?ZTUwV1BORWM5eWtyNUwwN3hhbk9DaGRNMytRY1RIMzF5OFBIbEdSRmMvZ3Nm?=
 =?utf-8?B?VHhTMVZ3Tmtjd1JEbzMyd0kzMzYyOVZ4ZzZzbnZXeUluSUdDZzEvVWZwQkRS?=
 =?utf-8?B?RzhQUUtIYmJ6cGs1anlSVTNuOU9DWDJiWUpLTUFkbksrbHlBcVJ6UHFsRmhS?=
 =?utf-8?B?ZjdxR1pTU09VMkhpTGFoMkJJalZXV2I5b0ZmQ3JlSGFBWkJnblpOaVhIOVha?=
 =?utf-8?B?TkRJNDhZU0QyTGhwYWdQbVgra3VIbW5ySjRJTnNDVTNrU0JoTFA5aHIzTDFi?=
 =?utf-8?B?bTRvQlFVV05oODB0S2cvVVZkVk53T0VjbVgwRHVUY29uWEQ3aDc1ZmZCbkhz?=
 =?utf-8?B?UXFTVFkwclNiMC93bUtMZ3c4cERaWTRJbDNUSDMrVUtOYklFV241Mk9rNmRu?=
 =?utf-8?B?eHlRM3RsSUFaNWlScTJKSllsajVRZ0NLUWR6cURJTW1hL3ZJbVJEMnFnUG4v?=
 =?utf-8?B?cWlUMnZmTUF5THJYcFpjU3YwcXdxODM1ZnVjZi9ZOGQzVjV1cm5nVGMzQ1dB?=
 =?utf-8?B?M1F3ckJ4ckNRNVdpTW5sSGZvZCtzTC9GaFQxL1J6MHJEUWUySnlWTi9ESFY1?=
 =?utf-8?B?S1BoR1lNU0VKc3pXdmlJZmlzdXJQMjhUcW5oK3huL0gxcFJzemVzVm8veS9V?=
 =?utf-8?B?MUFHTjc3SkxZY080ekNHQ1lFWFpSQnZ3bHg4aGlyOGh3dWpnM0UycUtMY0py?=
 =?utf-8?B?NVFTbkRycG90RGgvdVlmUk5HVFN2T204UFc0WSt0WFJuNWZkRkdZeVRUbThH?=
 =?utf-8?B?YjEwaStkYUtHc05lTzdpdmYvODJDUGI4S21VNGpaRU5mbUx4YThyOUJJWWZj?=
 =?utf-8?B?L2wxdU9mYVZyS200Zy82WHpGL1UzSmwrY1ZUNExTZTExL2JhOFFndFZOREQ1?=
 =?utf-8?B?OXMyTlBua3dYWk5Xc01SK3pUbzlPT1k2NURpOE5BY1FURUoyM1ByVTYzYllr?=
 =?utf-8?B?U1VJUFZJY0toRzlMSk5vcVpPa0p0T2lRMllpeHEvWWQ2bG1YbEZxMjdDOFQw?=
 =?utf-8?B?NTYybXVXdjNFcTUwRUhKQSszQ0lVQXNsV2dFQmRGQTI1R1p4WXNXZUcwM2Qx?=
 =?utf-8?Q?P3pqsQlMY60=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3Bmb3ZrUVlua2xvdXduc2huaFYraitXU3phNExueklOMjBPVmdkOGJSME43?=
 =?utf-8?B?eWxMd1VvQkJWZU1PL2dMSlVPL3ozL0RySE1Od3VjbjBwRzB4L082SGI2Ty9v?=
 =?utf-8?B?NVNnZFVweHkzSWdnUEJSVFBsdkxNUE5adXFWaU5oMTVxaHNmRnpLYWVaWHFa?=
 =?utf-8?B?K2ZoSVNtZmhDZmhldWFMRUlNNW1IVHNQSFJlcm9WRFA5N3paNXdIbE1hdU01?=
 =?utf-8?B?ek9MT1hZZmxVVDZBYkhzRHI0NHJHYVl0c2EyQmRMa3BlTHFIUnVhaEliRUx2?=
 =?utf-8?B?OTZzYU9HT3JHK1pCdkFjOHBIMGdvWlRBWExtWG1pZVNNeEdRMnAva2dEUjVJ?=
 =?utf-8?B?Y0pTSktwUnlrcjl2UXdaa1k4Wkc4emI0N0xNYnFMMXA3K01nMlMvN2o1NkNm?=
 =?utf-8?B?Mk9yazRMd1dzK2VLdlVVYW5PVzh0VXJXM2hqYjdOMHhmZURzOWNHVlloTi9E?=
 =?utf-8?B?YjhKdTgxOXVGTmUzbVpIQnZrOUJocEZOR1hhMHIzNUNucUhrSjlHZjZsUFNj?=
 =?utf-8?B?QnUyaTk5dmdnUld1a3Nwa204SE53eFhaWGNtdEJ6ejdHRnNyUDJsUzBtYmhX?=
 =?utf-8?B?cktuYkZLVUdQVGlGUXlma2hZYUI2ZS93NG1qQUwvWEtIMjQ4TndnaW9TYm0v?=
 =?utf-8?B?aW92bVdjWUZvY1IzZXg4OFd6RHBjbFZ6WllCQWZJQTk5V1VnZlYxSFltS2FM?=
 =?utf-8?B?NDRLdkdaUXpiaHppUE96UkYrcFJxQ2VLQ05pMkxzc0N3bnlGSE9EZjkrQlNr?=
 =?utf-8?B?blhUSXFqQ2dXc3c5RXliZkhEbGpsb1Q2enVRb0N3MUM5MGVuaWREQnh1RVJE?=
 =?utf-8?B?Q2R4ZnRJNXZrNG5wb21JZHh1Sms5WS9leDUraEpzVmdvMkE5NWdNbUZtLzdE?=
 =?utf-8?B?ZTJSOE84Qk5leGpCQXhaTWtXWW5xTWVMazB4bGk4Wm1MRElTM1hTNndPQjQ5?=
 =?utf-8?B?TTBXSmh2ZTc5dGVGMjNYRnFIZXRScGZaYVU2anovcEdxYkg0MDJWNzNsbkh6?=
 =?utf-8?B?dEtvYkZqays2YmlOeEVDWTBCOTc0QXRLbFA2RFVsbUVRSzUzZ20wcXVFR3Ux?=
 =?utf-8?B?aUNrR2F5YTdHb0VuamFmclV0ZG1IN1VsS3lTalZoZXpJT1NEZTBxRXdIWDNr?=
 =?utf-8?B?bmpYM2pZdG5XRVhGcUFNWjVSVWdIV3lCVWRCY0dxU1lDaThjQUlaUFhpektN?=
 =?utf-8?B?Q1h5bVpUd2piZExZUXlqVjVUZ1dyMVphTWVSTmkxV1orSG1TbzJadXNMMlRw?=
 =?utf-8?B?VDNvS2RKVFUxZWtSMURYK3BVTVVqMW53U3I5NFQwanRjU1J4QU5XMEthbnVP?=
 =?utf-8?B?MGJBVngweUJlWENWZGEwQTFObWl2RkVlT3BrRm50RzlaeGhlMmRXa1dOQXhV?=
 =?utf-8?B?bStWajFCbldldDgxbTBOWjNYMkVWVk9PZTJsaGpIeGtJOFpocHZPajlnL0E3?=
 =?utf-8?B?aFJaNTJEdmFRRTBMM0NjQm9yZXQxR0JPZ2lDVS9WRGUxUTgvbEJyUklVM3cw?=
 =?utf-8?B?OFg5UXY1b3dhbGM0amVoMHpVUGRXZEZscGVRb3Y0SkpNNy9rcmR0S1RtdVc1?=
 =?utf-8?B?RWZaaXBzaVFJWjgvT0VNZ1JLQmZvVUVTVmY1RXZCeENGc3RtM3Ftc2lvckt1?=
 =?utf-8?B?Wkovc3FWd0ZJdWlCVVBQaXNocVNxQWxkU2haZ20xUk1XRThkQ3R1b21FNGp2?=
 =?utf-8?B?NWUwR3Rya1JId2ZrYkRLeGpwelFKZDQ3bzNxV2xLZXhyMWl0eFRkVTE3STRk?=
 =?utf-8?B?QjA2Z2ZuZTU5aGVtYVl3ZWNNVmhqQ0J3QUpxNEVtbFBZQS9KZjVVSGlWRW10?=
 =?utf-8?B?UUg1RXkrQjVtcER5U2NGeGxVS2hLYXhFV2dTN3hqcUwzV1VGa0ExeTBsanRG?=
 =?utf-8?B?eDZENVI5Y0I5SlZENGVYb2VWODZIemZhS0t3WWdiT2V6a0M5YWFUSlFGblBw?=
 =?utf-8?B?VUk1Q1ZFaklzTXMwYXIxY0pBU3BXWk1TVkZVWkQ0U3FtTVQwRWx3bm0zTnVi?=
 =?utf-8?B?Mmw3dzZMS3QyZ1ZvYXRPUXBWaFkzM3FRUGQ4N09xMWRzUDNWR280NU03NXN1?=
 =?utf-8?B?SmtIQ0tTeDQ4bERtbDNGZ0k3c2IwZ3FVckNOd01WTHJlS0sxajBrYmp3cU1k?=
 =?utf-8?Q?2X1IIY5TR2H7aU7DT8y4LKpxE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a2e902-95fe-4e28-af01-08dddb567a1c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 17:17:45.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqHVU2T+t/bDW+QQ4It1j09aMV6w2CpwIW7vjArEWaibjeS6+i5n3WvojruSxMEDq8cAfOWckCKzMFpEnM7xXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699

On 8/11/25 14:03, Borislav Petkov wrote:
> On Mon, Aug 11, 2025 at 01:05:42PM -0500, Tom Lendacky wrote:
>> Yes, that works. Or just get rid of snp_abort() and call
>> sev_es_terminate() directly. Secure AVIC could even use an
>> SEV_TERM_SET_LINUX specific code instead of the generic failure code.
> 
> I *love* deleting code. Here's something to start the debate:
> 
> ---
> diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
> index 7a8128dc076e..19b23e6d2dbe 100644
> --- a/arch/x86/boot/startup/sev-startup.c
> +++ b/arch/x86/boot/startup/sev-startup.c
> @@ -135,7 +135,7 @@ static struct cc_blob_sev_info *__init find_cc_blob(struct boot_params *bp)
>  
>  found_cc_info:
>  	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
> -		snp_abort();
> +		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>  
>  	return cc_info;
>  }
> @@ -209,8 +209,3 @@ bool __init snp_init(struct boot_params *bp)
>  
>  	return true;
>  }
> -
> -void __init __noreturn snp_abort(void)
> -{
> -	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> -}
> diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
> index 39e7e9d18974..e389b39fa2a9 100644
> --- a/arch/x86/boot/startup/sme.c
> +++ b/arch/x86/boot/startup/sme.c
> @@ -531,7 +531,7 @@ void __init sme_enable(struct boot_params *bp)
>  	 * enablement abort the guest.
>  	 */
>  	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
> -		snp_abort();
> +		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>  
>  	/* Check if memory encryption is enabled */
>  	if (feature_mask == AMD_SME_BIT) {
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 0020d77a0800..01a6e4dbe423 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -208,6 +208,7 @@ struct snp_psc_desc {
>  #define GHCB_TERM_SVSM_CAA		9	/* SVSM is present but CAA is not page aligned */
>  #define GHCB_TERM_SECURE_TSC		10	/* Secure TSC initialization failed */
>  #define GHCB_TERM_SVSM_CA_REMAP_FAIL	11	/* SVSM is present but CA could not be remapped */
> +#define GHCB_TERM_SAVIC_FAIL		12	/* Secure AVIC-specific failure */

We can get specific if desired, e.g., GHCB_TERM_SAVIC_NO_X2APIC

Thanks,
Tom

>  
>  #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
>  
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 2b8a779f1477..e907646b4e4b 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -512,7 +512,6 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
>  void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
>  void snp_set_wakeup_secondary_cpu(void);
>  bool snp_init(struct boot_params *bp);
> -void __noreturn snp_abort(void);
>  void snp_dmi_setup(void);
>  int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input);
>  void snp_accept_memory(phys_addr_t start, phys_addr_t end);
> @@ -590,7 +589,6 @@ static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npag
>  static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
>  static inline void snp_set_wakeup_secondary_cpu(void) { }
>  static inline bool snp_init(struct boot_params *bp) { return false; }
> -static inline void snp_abort(void) { }
>  static inline void snp_dmi_setup(void) { }
>  static inline int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input)
>  {
> diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2apic_savic.c
> index bea844f28192..f0270ce16e6c 100644
> --- a/arch/x86/kernel/apic/x2apic_savic.c
> +++ b/arch/x86/kernel/apic/x2apic_savic.c
> @@ -26,7 +26,7 @@ static int savic_probe(void)
>  
>  	if (!x2apic_mode) {
>  		pr_err("Secure AVIC enabled in non x2APIC mode\n");
> -		snp_abort();
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);
>  		/* unreachable */
>  	}
>  
> diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
> index 6a922d046b8e..802895fae3ca 100644
> --- a/tools/objtool/noreturns.h
> +++ b/tools/objtool/noreturns.h
> @@ -45,7 +45,6 @@ NORETURN(rewind_stack_and_make_dead)
>  NORETURN(rust_begin_unwind)
>  NORETURN(rust_helper_BUG)
>  NORETURN(sev_es_terminate)
> -NORETURN(snp_abort)
>  NORETURN(start_kernel)
>  NORETURN(stop_this_cpu)
>  NORETURN(usercopy_abort)
> 


