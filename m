Return-Path: <linux-efi+bounces-3238-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC6FA810D7
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 17:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8946618841A6
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4152222ACC6;
	Tue,  8 Apr 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nBwocGd+"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408122A7F6;
	Tue,  8 Apr 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127626; cv=fail; b=cJBsZ7C5pQ6H4RRF6wrvPmG5mIHAboo65u/6/O+Nf9+yvvFQNDqVoJOeJwyQGy4NRDgqvAM0k7oMQmbsPuYJCu4k/oFM3kob6n/RVGmQKu/30mri2ZsUOhvlLI8NP5oXOCI4uAdL3BcnPh3wxABYT1EoflW3Ffb2uVRi34eYxL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127626; c=relaxed/simple;
	bh=Q6oCCs9duEZXOZf54k0500Ng7tXjkuHDviXw6msWCrs=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=UmXe1fuCEkYos0hcUUWhpxs0S0c2rCUxROX2LsRvf+mjSO6bQ+unUNyYXg8zfH2D3fXLPD0iWGCWPGwfm89B+7dJxO6Pu5RUsC0Uzq+uMoARwZwiGgOLNKwl+XMtWhQYjux7iB3epT8Zekw/IZBFhvJ4HxNmE6biCd6e7nXq+rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nBwocGd+; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob/f65DWlrsJJLqL6Q/SuMA+ZBgvLznTJwmtZkLaJ5PIm/ZUE5LLuFlqVuWOQfSgfvSsKudBIWMm/kH7E5BYdlsLWxZQiEU6RaDsy9g4GEDamHo69Jw8RPzIdKfDxb0B4Y/8fOnwbn7kqG3mixVBMBle6dwcATtE7FyARga+jm2yoeznGhwgICchY6o0e7pCbIMFq3NtP1o487vIG/EsbAjDaoF/LULB2oxnlcJN8+8VkvJInaviKTInnXzxkL2CnYORb9AVPCSYRXpf3NeDOT2W/OmcD9NZZTNbWxXGzsN15YwQBxu4aVb2NfQLpn5ciJv6WzPhoJoEb+KFEgUUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HM+WPKL4jMDg4wlgu643iHDAMko2pR3BO4CXOqd7lfs=;
 b=ciKBKGJoa4PeNHAUq9NaRM8bLFDBuJmo8T4SDmeU5wHhXy0rmx6xcyqhYaLns2YZYGOzOuP9HiodEyqI54GLM4/GogoO1zsTTLs+6XWxSCtkY6fNPPWzPJhzRJrWeP2jaUlrZYRWHm2YJsVrOc9Od0rDdwe6IaK15Y1ItUQGa74f3pPJz5XXFPAvO8xCwm/pYNyirqC7ZfKfyBs2rjTESIf/wSpEdKhCbDFcRi+y/pHT9E70gK1FV6OTc8u11DIF/NccL1z/7XRGRZDUCMdXkRAc3PkPwx4Ddc4TjXo2kXXQtUfz6pV+3uWOxzYZ5Li2y59eOUM3V7ksvQ/g+I0xkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM+WPKL4jMDg4wlgu643iHDAMko2pR3BO4CXOqd7lfs=;
 b=nBwocGd+0axAvzb++MK0ez0fONyO70u8PkXd5UbbJpiQ784TjkkEG7Oqpcmp3RJdDkbqLzd71W3f6Nt1uKlzdJCuncra07epYCzRVhtVVQsAWmEqvbHO/B2hL5a1kDu4/wZre861/CCmncdCSb5m+7BR+GnREBgryf+vgY87SXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 15:53:38 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 15:53:38 +0000
Message-ID: <a53b3a3f-9fa1-4939-7885-1c06fe31af23@amd.com>
Date: Tue, 8 Apr 2025 10:53:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov
 <bp@alien8.de>, Kevin Loughlin <kevinloughlin@google.com>
References: <20250404082921.2767593-5-ardb+git@google.com>
 <20250404082921.2767593-8-ardb+git@google.com>
 <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43>
 <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
 <CAAH4kHbxMDGQy3v9ef1ZdqK0TNzpm==BJgx1KiUpRP-CRKDx4w@mail.gmail.com>
 <ldrma6tce2bwhenu5kobjzvk7cz445ubfmpcynwadqudgvzuh3@aibigcdzui6m>
 <9f689ba2-add6-cca2-e7b3-fa0393fe2b98@amd.com>
 <CAMj1kXERL=8Y51RUJSqgLWVMs4PJa9aQK0puvKaCpg6eRu0t8g@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for
 SEV-SNP
In-Reply-To: <CAMj1kXERL=8Y51RUJSqgLWVMs4PJa9aQK0puvKaCpg6eRu0t8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:805:66::43) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY5PR12MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 18434be7-70c1-44cb-c350-08dd76b5871a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGJxdUNyaTdFQUdWb2RLRnJHSjh0YTVyTEF4elBxM1Y3eHVGWEs1bzNQTjhX?=
 =?utf-8?B?TjBXRktGZ0p6eUdFUERnNzhBZDJTUVhWM1RWeFRsTkFPMmVGbzZ2Q2FhUm1R?=
 =?utf-8?B?Q0Vid2dNaFZrSU5kdHQwSmt2SVRyblBtRUJDQ1Jjc2JuZGdLZEwrZHVKcTl6?=
 =?utf-8?B?ZDh0Yng2T1V0RjN5NXM0OXB3eWhzYTdoYXJieUZSRnVaaVU4QTd2RVpoMUdz?=
 =?utf-8?B?QmZhUVlTSXlINlJUU1dlTWxZVy9DUmFBRjJtNG13KzlVUC9keWl5Ty8zTWpH?=
 =?utf-8?B?MUVVVzNDSklDaWFZeUZGY2p5UVM5SmFyNGlVTmtIdG02VW1INXRjQmkwZ25P?=
 =?utf-8?B?cWZqT3ZzM0NQemNzV200M1hTTzhLSjVxUHdDWFVmU0pCeHJhY1E3RGg0cmV6?=
 =?utf-8?B?UDRua3ZvMHAyNTh2SFZwTGNOYzdKK2JPUGtUNW1CR0JzMmh1UDEyRk9pM2Zt?=
 =?utf-8?B?Sk5JOCs0WUI4Vk5LQzNNNm13YnlpaWxraDNUMHBZQW1hQWsvc2pxSmpxTmp0?=
 =?utf-8?B?YW14QkFHSWxsME5PeFhwK2JVZXlvMnlhVnJGRlc2Y1dsdWZnWVNXdlNVY1Bz?=
 =?utf-8?B?WjZPdjBYT21jNzZrU3A0cjBFa2VQUTcvS0pGSU9IYTF3UytNcDVuTit3WXNC?=
 =?utf-8?B?K2lDbXZVekhIL3ROcHNjcVhjUlRLZjRWNXRTenp5NWVWZnVWalR0eGVxeFJH?=
 =?utf-8?B?a3podnQzOEhweWw0dWtIN0RQVGp0QzM0dDdYdWxXOGhUdDZ5TWk4ekV0bFF4?=
 =?utf-8?B?WHhSZmtLL3BHNUlhRDd4dmtHTlVmUEx3c1BaTy95OU1JVU8xNm52Uy82TmYx?=
 =?utf-8?B?N09tbVo5cndIL245ZGxYai9lWjFSR0NKLzNxb3JNL3Bxb0tPOUZPUngrT3pt?=
 =?utf-8?B?czBSVXZOdW5GOXk3NXluQnRNU04ybjhBOFpiUWpWT0Q2OU1WaThabm5FL3k3?=
 =?utf-8?B?OEs2UGxHSmpyaHhTZTRvNkU2dHBiNkV1cmMweGlMVnQrRUhqRUxMcW5hcEFF?=
 =?utf-8?B?dEg0d0Yybmk5ZUhGZVdFRXV0azVXVGJOU2E3OEl5MlJlMG5iVGpITW1HTWJD?=
 =?utf-8?B?YTl2bTU4bHljUkFqby9EQ2RIZUlkREZsSUNzNEgzODI3eUxMZTF2Z1ZDZDNu?=
 =?utf-8?B?Um1yZDFSMXRXbk9kT1B1VnpxL01TdzZMVTRWa1d3eTh0YzZva2ZZakFsNmtD?=
 =?utf-8?B?ZW1hWHJ4TFRMSGs3R3d0UjJlWUdkSDZESDNzTHQ2aVVNTENISGhsWXhwSXdv?=
 =?utf-8?B?WUZLNC9Mb0xMR3dKT3JkMVdjbUJFdExpb2cxcFFYZUdPR1BHdnVoWE1EVEFW?=
 =?utf-8?B?N1NtTEE0TDJJNFRiZkxzdFVZbzJRc1BaUDFrSHBpWHYxbVV3NzZyMlYwRlVk?=
 =?utf-8?B?M0wxZDhCanZHcVpBWTVJTUtOODZ1Q2JUUHJ4T0hTc28xdE54eU14QjRRU1Fo?=
 =?utf-8?B?bjR2K0M3L1htMjVYaExGd0xrV2RDSEs1TXFyTkhteFZNMklCSTNRVzdzQk9u?=
 =?utf-8?B?ZzcwQWxTVk9pZW9IS0Q5V1krODlvQ2JSSkQvSXZKdVNCdzZJYlI4MFdKRlFX?=
 =?utf-8?B?Vkc1ellvdzE0emlSWDIvSjZHUWZJVHpPMlhWcEJlNzhCK2dzOCsySzNRTXJu?=
 =?utf-8?B?SVRySVFwQXlncllTSzFYeEFQRVpVVFdjUlluSVp2MHFmdTYyV2F1QVdGQmdJ?=
 =?utf-8?B?c1NYUjVxeUlrczJycFhCWjdBMm02YjlHUlMwaXBkZmpRcjdPbGdUU3BQUUpz?=
 =?utf-8?B?ZitNN3R3NnNIMUc5NjBwdjB2a2pwM212a0xhQkNlS2xKdktaWTNZZWEraTE0?=
 =?utf-8?B?QjF0NWdCZERYTURNMVpjSWFrSkUzL1FqZmF5UWIzUlpaOXZoRUdubWZJamx2?=
 =?utf-8?Q?jn6w5dmX6KkHH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elJ5Rk1LdVZNQzBvQlZNT1d5QU5sVG5NNitqeVhCdEMyV3dsNnBFbXhKOWpC?=
 =?utf-8?B?aDlyMitZV1ZsU1dqRHJDUVBqVm1DOC9PY3hzemh5ZWtHeWgzSmZkZVJoVDY3?=
 =?utf-8?B?MlpVRThOSFU2N2x6VHQvN2R2UnB1RFBnOURESlBOUTlwT2IrQ3NHRGxLdllF?=
 =?utf-8?B?TlhYN1ovVEdQRW1EeVFFOHFSSUhhdzNsb0xxTWFFd0Y4czd5bFc0UzlRcHlt?=
 =?utf-8?B?NHMyajhaYUxBeGlGU1ZFcDgySHBNOVZxOW9Ock1SRlhmVHhJQVNkU0tSOGdN?=
 =?utf-8?B?Z0NlUEJ4SmRQeDh4UHFnRCt0ZzRhSTZBditWMEV2S0R3dUxoZGpwUUZMb0hJ?=
 =?utf-8?B?OFc3UGhuUXlwblJ0eTN0Y3o0UDQ1amJPZHBVTG96Rzd0SURPdnlDSlBnKzM4?=
 =?utf-8?B?SzRLZGw0RWwyclA2YzlvNUlKbXZ0bWthSlhvVmhNSUFrTHB0V0RtVmRML3RS?=
 =?utf-8?B?RHcycTEvNUg2aWlwQWE2eDFUSWZxazRkQit0cEpTQjEva29nTXRvWnYzUVJi?=
 =?utf-8?B?MlVBK1VSMCt2ZVpYNTRKNksyTW5tRHFJQ2wvWTAvUXVjeWRRaGszT3ZyM243?=
 =?utf-8?B?RU5lMWlOQ3AwUU9EY1hCNXB6OFQ5UDlDNHNjRnJ2TG5yMmlud3BJeGxrUFkw?=
 =?utf-8?B?SVQ0S0JUc1hFZzlkcTNjYVFXRk9xOW9UNjhsZmtPcFBXRGNtMkVMdEh6bXAr?=
 =?utf-8?B?YzVXL2o0cklLUjM4Qjd5WW1tdTBmdFBiV3p4VyswTzdhT01sMnRLOHV0cm5t?=
 =?utf-8?B?YllnV0pvcWh5QkhRUXUxODJISzB5TGN2WmVMOGdRbk0zSWhYM0tudUgwYWJ6?=
 =?utf-8?B?cEQ1T0Y2WmtQd3Joa0Y1WXNwWVpiWll5RHZQYXdsditTMzhOem9nR3YySkhn?=
 =?utf-8?B?U2xhVEVoUFQ3d1FHTzk2WFZZUGl3R2FMNGFkR05ycjdMbllRZVZBRks4SE9x?=
 =?utf-8?B?WUtyMEIxdENyOXRoaEJLSFU1UTIvNGhJZTVQbWwyZkFVN1FtdnROZGQ4SFBt?=
 =?utf-8?B?SmhvMGZseVlnOHViM0paZDNybU1DRldWYStQdWo3Y29KcjJRUGdqbXFLcHA4?=
 =?utf-8?B?MWtscUx0ZUZQWlJSY1FyYzlWNjI3bzk3MTNscytvckZqWTlVeXJISXRUZUM4?=
 =?utf-8?B?QVN6bktYZWc5SlhSQkpReVR6RVBSVFRjdXYwcWN2UFIybms2V3ZPRkdxbDNB?=
 =?utf-8?B?Q0dnZHhZMTFZSWo1RDFoKyt6YzNzVmM2MHdnck9TemRRVzhtVUdxWUZCc0hE?=
 =?utf-8?B?Z0ZuYVFhMVBHNmZwcVlPZU1GUmZKMlREeTFLM1UyK202RkRuaVErVHg0bHJI?=
 =?utf-8?B?VCtoK2ZJdGpMbXNKTDBZLzExMThVMnFENXJjSnBGakZzUFdHeEdGNTR1OFpB?=
 =?utf-8?B?L0xGVEdSb01EMXNHRW40QStlVmlsMkltT0N2ZVVPVmJvdGVzdGtwUVZPRkVa?=
 =?utf-8?B?eWFDd2xjTFZPTnlDZWs2bjNSM2tKQUxBL0RtajFiZi9lYUxpbjZwYkEwSDRU?=
 =?utf-8?B?ci9xV2wvS1VaM09kZWpCSHFTUDhsbEhqam4zaFR3UC9oNU5ZTzlmcEVGTDNZ?=
 =?utf-8?B?K0MrV3BFcm00bWZaUmIyaUFtVUkvcGlMajNOMnFKV2VlQVlOcVhIR1NXNEFx?=
 =?utf-8?B?dVdqNENTMHVxUVEzR0tza2l5RHlEdmRxUXFXS1RJUmNybTZGZmNlU1ZURUVz?=
 =?utf-8?B?eTZ3MTBQTkxuQm8vZXNscDY1RWV4T2JrTkZFazhkMFE5bUxQUXhMclNJSWpK?=
 =?utf-8?B?dXhlaUIzV0FCY29QUExkS1Y2bFdoOHFxSDFNbEZQMjNBOHZ1cG51dERhNXgz?=
 =?utf-8?B?Y1VDcFZYL1grL0ZnZFZibDlaZHgzQ0JVZzFlTFB6VFNEZTZEL25GeGYwVHFD?=
 =?utf-8?B?bzZwbE5COU8xQW85ZW1SRlBJUTBvZ3JYdCs1YUxxdWV4emN2dkRZZTFmT2l3?=
 =?utf-8?B?OTU5ZmlzWW44eGpuRlhsd3dSdmdpcEo5Zm5FNmRCUWF0QTAxSU9kZXpoaVlp?=
 =?utf-8?B?ZWZHUmROUkQya004cEdxcFhqQnZUUXlZNkd1c0ozNjJCRzNXb1h3NGZZdENB?=
 =?utf-8?B?QWhESzNCSW9yNkR6akIxRXpYZEl0TTdBOHg3UU9SbzdsZUJNekZYSTFiSG4z?=
 =?utf-8?Q?xJAiA3rQa+cLrfcOTUMuddY4f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18434be7-70c1-44cb-c350-08dd76b5871a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:53:38.7009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ON4cIJygRxbPRmnCF7DcjC1jfi8GGJTkCfx4fCc3NAWbS+dhdQlOA22me4oBEK8QDMEhFJNSKwR+U5rSD6qrjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324

On 4/7/25 14:59, Ard Biesheuvel wrote:
> On Mon, 7 Apr 2025 at 20:05, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 4/7/25 04:25, Kirill A. Shutemov wrote:
>>> On Fri, Apr 04, 2025 at 08:07:03AM -0700, Dionna Amalie Glaze wrote:
>>>> If the GHCB is available, we should always prefer it.
>>>
>>> I believe we should consider the cost of code duplication in this
>>> situation.
>>>
>>> If the non-early version is only used in the kexec path, it will not be
>>> tested as frequently and could be more easily broken. I think it would be
>>> acceptable for kexec to be slightly slower if it results in more
>>> maintainable code.
>>>
>>
>> Is accept_memory() in the decompressor or efistub only used in the kexec
>> path?
>>
> 
> The EFI stub does not call accept_memory(), only the decompressor
> does. The only use case for explicit memory acceptance in the EFI stub

Since EFI stub never uses accept_memory() I looked at moving enablement
of SEV to be before the setup of the accepted memory bitmap, as SEV
enablement doesn't need any e820 info. But that didn't work because the
real issue is early_setup_ghcb() calls set_page_decrypted() which calls
set_clr_page_flags(). The latter function is not meant to work with EFI
page tables, so there is an incompatibility.

If we had a way to check for whether we are coming through the EFI stub
vs the decompressor, then snp_accept_memory() could decide to skip
early_setup_ghcb() when called from the EFI stub and call either
__snp_accept_memory() from the decompressor or __page_state_change()
from the EFI stub (the latter having to be updated to return a value).

I think there are other areas that might need investigating because I
noticed that efi_warn() is successful before efi_exit_boot_services()
but blows up immediately after (possibly in the EFI #VC handler having
to do with addressing the string?).

Thanks,
Tom


> is process_unaccepted_memory(), which accepts the misaligned chunk of
> memory that cannot be described at 2M granularity by the accepted
> memory table.
> 
> Remember that the EFI stub no longer calls into the legacy
> decompressor at all - it decompresses the kernel while executing the
> EFI boot services and branches straight to it.

