Return-Path: <linux-efi+bounces-4745-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E62B54F95
	for <lists+linux-efi@lfdr.de>; Fri, 12 Sep 2025 15:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8353B7CF1
	for <lists+linux-efi@lfdr.de>; Fri, 12 Sep 2025 13:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDE226B769;
	Fri, 12 Sep 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nkIh0Un1"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C62DC791;
	Fri, 12 Sep 2025 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683966; cv=fail; b=TLNBenR3Kfks+2Ax4IImKrbKfHuPjBYhAKONYvQ7Iet/PEFShMvlIg4iiUOtLuhrgMdsXYc0IZAVfy40ltRR5WLervjz2xnSP/0H5OisTaew7xU7xwoRYL9YdbvHb+0idbnUSUj/+biS1Ybdit2GysoNOlLpReWMKTKIG68TnGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683966; c=relaxed/simple;
	bh=CtLL3kyYAomKvxlgkuEg73/OKQ769DyIr94+/Ti3eqE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R4elhltWomhOrfqULxKiAGnVPkCqsaHRL9H4h/mkiOjIoCLQ1VnDoPf2VKf4rPVNAEQD4qboaDo5OxngX8B39jDewx4lWe+3Z1p7PqtF7gFDGiihWjFx3aoR4MlFV9nYNG/0LA3tNHBwkAotcPExNVAzKAAZK2LuS39jUgv6Z9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nkIh0Un1; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPwK2bF8X5humRJij5s4HKo8h6BVTf1Xgk4E+JCZBT3iUN6EfjorzBvSzD6HZcJ2Zj+E6EnA/3ySIr3xkeSh+PvzmSmXXlkhr7ovRDChSuluqRVocGBwEKBZVcVy+v7cJU9gaJDKJ+l9eK6sr0agY0lNHlPMPUCVZz8j0/GpY2wjdd+CXrBVPaBUIv7GDBfjI/NJ4tWxHuZffESNwPfe/Oq1LTK8S9Nzn6wtj3umBKqNCseCphmsZVT7FmgwUFeYAW9NLrX5At84qHZYVk5ILuIJZCptCVqg78NFFuGavbZf73ufS0yCavb1WzKiLyf6nDnoFil4KxxCKXKJNzlqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R//Wsz0A8C0HAjXAnWhYVeZn6LZ+8FIJFqoBwwy4EY8=;
 b=FayxUlhqqNxqcmVKC0tZ7jgNvHDpkmAS2Dde/0mI1pjzelVOX4cPl1XiZxqd+UETJ28FYj4ziOwjL7TuKRwQBXPKEvRyJyLE2cCZDUIET1i/oNbRywHWOoedcJUZXOYy9ua6rkLE+2jlLkmCDW4VChHf4W3Qbf3narjZb3vq3Ilc5QWH8J+qcljGu77XiUdtLDJG8XZ84ULJVYp1mjJFmPdF7VH4TSnEevjnUVUCHWHE/fsDuIukeRrcChFmLdQA/gNjVhnPDV/HvJv7NTz8xQcRIyodz4Ilfr13cBIWH6g+MXV3fhdKDQV7p38iwQRiTDMgEEkxbf881jFKl0fY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R//Wsz0A8C0HAjXAnWhYVeZn6LZ+8FIJFqoBwwy4EY8=;
 b=nkIh0Un138JNz2TZQHrAoKAo4l5GSkx6zi5/sl4tS3Waouzd8UUY0jrF8cF4aDJ/FN/1QKOtvPUk97P1ypOfwoKd0F10X6ti1bNjxeLf9UH/BhV52OrZIia/EqTeeHdeHXw76qua5P1BX/CkSAY6eL9p+kQF7wWqC5MFVGpBKM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 13:32:32 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 13:32:32 +0000
Message-ID: <89b28d47-bc33-456d-9b8a-a8d4ec27da84@amd.com>
Date: Fri, 12 Sep 2025 08:32:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] x86/efistub: Don't bother enabling SEV in the EFI
 stub
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>
References: <20250909080631.2867579-5-ardb+git@google.com>
 <20250909080631.2867579-8-ardb+git@google.com>
 <802166ae-9420-41f6-95ed-6570ef660369@amd.com>
 <CAMj1kXGmgXRA=hO5P1bcTU1ya-RypU_y3_kahO632U5iPT7vaQ@mail.gmail.com>
 <CAMj1kXHqhWpb2OZy+1N8-oPa2Kk0d56NS6tYH46Z92ui3h5wMQ@mail.gmail.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <CAMj1kXHqhWpb2OZy+1N8-oPa2Kk0d56NS6tYH46Z92ui3h5wMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::26) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: a717a08b-fe69-4677-aa5d-08ddf200d392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjBFOHNVRnJhenJyTHY4VVVzWmsycHlNZ2NlOHdxU1VVaE1JOHJZanVrVjFk?=
 =?utf-8?B?a3FkTWhPbllrK2lxaHJTWGdlbytVM0hrYjJJZlpiTEEyOVc2SUd4YTVJSGoz?=
 =?utf-8?B?Z2pidlJJNFAvWXJYVHVGdkpnWFQrVWRlRW1JZ2kySXNaWVprcTVqeXp3bVV4?=
 =?utf-8?B?UXJWYStBcHg0RVYzOG1jVG9RaFhFYngwcWRxQzNxQXZyS1QwV1MyZWM0Ui92?=
 =?utf-8?B?R3JxMno3Ry9QUEV3M2h1TnhSb1hLT2ZNdXp6eXlraTVNaDNuQklpTG5ITFRH?=
 =?utf-8?B?RjRKNmdPZmlrRHBoeEVVei9ueWlLMzZITk5IdXFFbjVwSlJFWVU3bHE4SFFh?=
 =?utf-8?B?MDdod3hTaWJ1WVFzQW9qZHVMU2wvUlk3bUdKT0dHK2lLUGZHUytoMnJHbUFV?=
 =?utf-8?B?UGJuNFJ3K1JEZ2JtUTFreDdtd252VUc2SkdMOWRLc05TbTdpcG1ldk9FRGsz?=
 =?utf-8?B?MmhuTHRzUGhoTnBlbnhUZCtjc1VUc0szMzdZblJRZlhCMUZoY2hEc3F0NlhK?=
 =?utf-8?B?TkwvYzF3MzE1OGJVU3RBczRrQVlNQlhMeEN0K0d0ZTkvbkRqRWJEeVlYTzJn?=
 =?utf-8?B?ZkRsWnhRNFQ1TTFaMHFxSmczTC8wOHJ0a1Z5N0FleFh4T2tLVGZZWUsvM1pu?=
 =?utf-8?B?YUFIZEhHaHUyUXpTeWNOQkdTelJXblZlUzZFK0JPbXFFSk1mUWhlK3dCQ3hl?=
 =?utf-8?B?YW4yWk5takFYcFpJRjVmQ21QckY2dDBkQ05BdWtveUZBdzVQTTQ4bDZ2YUdP?=
 =?utf-8?B?WUoyNVNnRitnUDBaZnpKNjRVL0pzL2dxNkJXOUNzK0tkYUhkbTlDRnpCNzZX?=
 =?utf-8?B?SXd6S0VqZ3N1MWdMYjY0Y3ppYThabmppMS9sNkRNN2hSbkRNd3JPUXEzVTFw?=
 =?utf-8?B?UThweWdTTmd0T2J2RklManpJL3crb292L2R0ZzJreTJNaEw3OXAyWEpXVVhu?=
 =?utf-8?B?UVRUdHBvSmZtZ0l0eDZ4VUQwWXZ2MHFERjc1L1VSTmFWNnlVVU1Kd05Pb0px?=
 =?utf-8?B?RmhpeUdHbXFKVzR6Uy9mbmoxR01tUm90MzVyMUNNSm5pUXJvVWtqZmFVME0y?=
 =?utf-8?B?NWQvOFptaU1JMEE1SC8vL3dyR3BHZUJwcjI3SEZPa3plTG9aU05NTnBENlR1?=
 =?utf-8?B?d3hwckcvRmYvMWVrQjJOcG8vV3VuVmRQTnZid3RIOHUxSjZ0cVduVnc4WFdX?=
 =?utf-8?B?VFJjTFpVaHhPSTlQaHVFMXJ5TVdIa2w5Z3dZSGpUMlYzeHBhVmpGUkh2U2lE?=
 =?utf-8?B?SWZSem1WM2djVVJGelZkN2syZEIvMzdLOWVQN1Z4WUkzekNhVUVycWF2dzA1?=
 =?utf-8?B?Nk1tMDh6bzd2cElsZmZJV2ZZU1U2VTNvdGd3aEt6ZjFKYnl5UURuZzNFZ1hy?=
 =?utf-8?B?OGdrRnF2UDFlTkN0QStRRzZucUQyRDBXY0tqU2VmK1ZBWU9lTmROeVdxcm1T?=
 =?utf-8?B?RnMrZEljZnF0eHVQMDEwd3d3cC84b24xRHY3S1RvWjlpT00xK3U4cGt4TGY3?=
 =?utf-8?B?QlRORDRUZFJGNkhWSWZ2TTlMcUl3Mml2dmUvaGFpWVRMVDFSZ2pBZWpVSXBS?=
 =?utf-8?B?TW1qUjlST0xaZVpaaXJ3MWtObFBucW5UWEdjemYxN2ZqbkJwSG5wTFNwRmZr?=
 =?utf-8?B?aFBkRXh6RDNWWU5wMVhTWVdNc1V2ZVhnOWR3cTNVYW9FbWQ1a1VaTHNSOWdr?=
 =?utf-8?B?SUdaNDdiMHlDRzdZMW1hc1ZEZjgvZkNMa1hhMW1JZURQalVYMXp1WEZKS1ZC?=
 =?utf-8?B?S1IveGIwRUd1T0RQR2dGUWw3KzRtdUlYVlQxRm1YTkdIUUtaNlZTOVZ6MUdi?=
 =?utf-8?B?OTl3RUY4YnNnNlpNaFN4VVhrQWhPcXNRSWloTThpVXVLbTNua2V1WUhyZlpp?=
 =?utf-8?B?N2poOHVYdVJyRmE5bE9XUWRMazNJWi9PREcwTzMwd0cyclJTMFlxMmRTblRZ?=
 =?utf-8?Q?MUM9NCiQ7yc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TURBeVhubTZTS1VpMlpub2JSTDFZdlhLTnh0RjJKdnFtaEdIbC8xcmo5MjRw?=
 =?utf-8?B?OE4zTklqYTg3NmlMMUFUendFNjNFZXdIdkhrcGp2dWhyelA3aFVnK1M1aXRX?=
 =?utf-8?B?QjE4MEthV3NmN08xb3RRYUdxSFRncE1WZ28yWlZEWDJ5empLM1diVlZxZElp?=
 =?utf-8?B?bnptaWtlZUQ4NGFnYzF5WFU5QjltaW1JRWdZdlZ5ODdEd2JDeXBRb0hzdUIv?=
 =?utf-8?B?d1ROaEhMcHdyN3pXbmdFR3VGb1RLdHpVcjJRSElxS3NvZ3psakpVUnlsVDZ5?=
 =?utf-8?B?NHJVUWV6M2l5MUlpRzIwRFcvZ3RhbHZuLzhGaENyYS9HWGZjZEJvQ09WVVdw?=
 =?utf-8?B?VnA0RFAySktsZ0l1emQ5NkVlS0MyZGJRaVRFRFZZaHFrWjAvS3ZFaUx0aS9D?=
 =?utf-8?B?R21lZkVsc1p1VU1wZDB3eldyZTdqelZCZHNGRkZEV2FXMjhOSHdYM2crOG5t?=
 =?utf-8?B?VlEwY3VQVFVTVnphTkZKOWpvVVRJUEtxNmNPTDVRZGVVWTVtdGEwbWZmUlZQ?=
 =?utf-8?B?VldpaFFnazBlYy9aSEpqbVI0Q0p0M0M5YUR3TmJVVzlCdnVoSXlqSWRNZlB1?=
 =?utf-8?B?eXdpMm0wNWpiTFJTZ2JQZ1liMnRDZDlScmlPVTY2ODRUdDB3MXpHTHQ4TGcr?=
 =?utf-8?B?TDMwUUlPbTdWYzVqK0N2c2xlNG9QTVhyK211eVZqLzBxOTZNNkR2VFVUd2tQ?=
 =?utf-8?B?U3I2SHo2VFFkUGxJL1VJTW8xdnp0RHhwRUIzNGNLR2VNTXF0dnI3QkdhMEpW?=
 =?utf-8?B?aGZ1WGJQcjRmREJDa01ObUZjMSsybFRCZ0tJaS91UjlsNHNTYVlyKzZoVldi?=
 =?utf-8?B?Mm5qWjRic2dtVGc4MFJqVTBOU21lVXRWRHM1a2l0N1NBR1p2ZEFWSWRZK1Y4?=
 =?utf-8?B?SkpJN1UzZDJPSXhENms5Rk1IaWNoemhFRjEvWW9uZWhMRWZzNXpaZWVOMmpq?=
 =?utf-8?B?TkN5RXlaMDc4emdZczBIVkVtc2EvMTZLZSt2dmhzdXJYT1krL1JkdDB0MUkz?=
 =?utf-8?B?WXkzYk5CbHJ0S280WHZySHZZaFVSYm5wdVVDMjgrc0l2MzRVRkhaeC9vMHVL?=
 =?utf-8?B?Wmx2elR0aGM0Q2VkUU9KcGhXN2ZMa04wMFBwZVd6b0RhdGt6M2x6Sjh4bUNq?=
 =?utf-8?B?WjN2MVNUbUVzb0lXZ08zeHJsZWNqa20wU2dZUzJrMFdpMVhkYVFST2VHWTlq?=
 =?utf-8?B?ZXpLdjE5TVNDd2lYS2R2elFpVjNTUWZKQVFDV3NXWG9Ia25xMy9rSFp3Vkps?=
 =?utf-8?B?YmpETkVpQ08yN0ZFbnRVL25ydGF1eWdPRTVkYkhQbTNQTXFFbTcwUytHU0hR?=
 =?utf-8?B?ZVZ4aXdpMEVaYUFiZzB1OXA3Z2xlblZRcHlJNDhHdEZBL0l3M1RYbGVOa0dR?=
 =?utf-8?B?WGdVSXZ4MTlGMHQrZ1I3UUYwcEVtK0F5dnkwUytJd0ViNG1CU0ZKTm84Y2Zo?=
 =?utf-8?B?SGx5U1crVFdJSWU0dXhXTjhCUm1aQkhYRGJuVGZ1ckZSWHZZT0hDYXorTFFq?=
 =?utf-8?B?U1ZZVjRHeFhMdDRDR204clZ4eHRRUG1CcGtNQXhWcGd0SVZpMnovbncrNWlu?=
 =?utf-8?B?S0FrSFFQMG4rWk5lOUR6TnNOU2JLUURlSVVQb1puY2NtR3J3WWsvRDlEK0pm?=
 =?utf-8?B?a2xQcGxXN3o3bmREd1IzQW1hbVc0d0g2M3N5ZFg2VjR6czZSUGp0cjBHKzdB?=
 =?utf-8?B?NXpiMVJpK0pZb2thSWhaWHlsMGlwb1JmQW9mem9LRTMreDA2SnN6WFdMTlpY?=
 =?utf-8?B?L1I4WDVZMjJPeUowaUR5N3pXUWtEZlJ5Nzh6VDdXRFNySTY3MXVnZHFIREsy?=
 =?utf-8?B?MWh5UG5uZTdGNFN6M3hPSFl4ZDJIOXp4WXZZbkY5MHRBdXRaUzNrdGtqOUFk?=
 =?utf-8?B?eG9URlJYS1lOR2ZSbGxic2ZzOTEyUVpEbnAzMmlaOXBQdXRSeVdnbSs0Tjhu?=
 =?utf-8?B?bkVpQ05IaHhEYVdKRGROMTFqUk1URWp0R3JnY3FGNE16S2YwaGdWNVl5aVBM?=
 =?utf-8?B?Q1VMT1I3ajY1ZUdTYUZ0eWJFUWlXa0E4bGNlUFdidVFQamZMTjluM3FBSGZ0?=
 =?utf-8?B?RTZLTmtZcG5qdkhldm1wR21jQ2FKR2dKNGdZWDNkSk5tdTRUVmhNdVNVNE95?=
 =?utf-8?Q?ay7nLJecG/VgujhRHAGHrpRgF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a717a08b-fe69-4677-aa5d-08ddf200d392
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 13:32:32.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQz2fqRPA/b9LZ2BxJYUljYP/4gFajbhcYkyBAQCslfcAjW3tyZk8HUtyhLE/vNEN2p+iS33Px6Le8CGomBZeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152

On 9/12/25 03:26, Ard Biesheuvel wrote:
> On Fri, 12 Sept 2025 at 09:29, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Thu, 11 Sept 2025 at 23:53, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>
>>> On 9/9/25 03:06, Ard Biesheuvel wrote:
>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>
>>>> One of the last things the EFI stub does before handing over to the core
>>>> kernel when booting as a SEV guest is enabling SEV, even though this is
>>>> mostly redundant: one of the first things the core kernel does is
>>>> calling sme_enable(), after setting up the early GDT and IDT but before
>>>> even setting up the kernel page tables. sme_enable() performs the same
>>>> SEV-SNP initialization that the decompressor performs in sev_enable().
>>>>
>>>> So let's just drop this call to sev_enable(), and rely on the core
>>>> kernel to initiaize SEV correctly.
>>>>
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>> ---
>>>>  arch/x86/include/asm/sev.h              | 2 --
>>>>  drivers/firmware/efi/libstub/x86-stub.c | 6 ------
>>>>  2 files changed, 8 deletions(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>>>> index d7be1ff3f7e0..b017e1dab705 100644
>>>> --- a/arch/x86/include/asm/sev.h
>>>> +++ b/arch/x86/include/asm/sev.h
>>>> @@ -462,7 +462,6 @@ static __always_inline void sev_es_nmi_complete(void)
>>>>               __sev_es_nmi_complete();
>>>>  }
>>>>  extern int __init sev_es_efi_map_ghcbs_cas(pgd_t *pgd);
>>>> -extern void sev_enable(struct boot_params *bp);
>>>>
>>>>  /*
>>>>   * RMPADJUST modifies the RMP permissions of a page of a lesser-
>>>> @@ -588,7 +587,6 @@ static inline void sev_es_ist_exit(void) { }
>>>>  static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
>>>>  static inline void sev_es_nmi_complete(void) { }
>>>>  static inline int sev_es_efi_map_ghcbs_cas(pgd_t *pgd) { return 0; }
>>>> -static inline void sev_enable(struct boot_params *bp) { }
>>>>  static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
>>>>  static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
>>>>  static inline void setup_ghcb(void) { }
>>>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>>>> index c4ef645762ec..354bc3901193 100644
>>>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>>>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>>>> @@ -938,12 +938,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>>>>               goto fail;
>>>>       }
>>>>
>>>> -     /*
>>>> -      * Call the SEV init code while still running with the firmware's
>>>> -      * GDT/IDT, so #VC exceptions will be handled by EFI.
>>>> -      */
>>>> -     sev_enable(boot_params);
>>>
>>> I think we lose the check for GHCB_HV_FT_SNP_MULTI_VMPL by doing this. It
>>> might need move into svsm_setup_ca() now.
>>>
>>
>> Currently, this check only occurs inside sev_enable(), and so it
>> happens too late to have an impact, given that the core kernel will
>> set up all of this state from scratch right away.
>>
> 
> Hmm, I only just spotted that this check only happens in the legacy
> decompressor.
> 
> I think it makes sense for this check to live in svsm_setup_ca(), but
> what is your take on the need to perform this check when accepting
> memory from the stub using the CA address obtained from the firmware?
> (i.e., way before sev_enable() is called)

Yes, it seems like it should be checked before memory acceptance if we're
using an SVSM, so early_is_sevsnp_guest() looks appropriate. But since
this may not be called, the check also has to be performed by the core
kernel in svsm_setup_ca(), too.

Just wondering if it is truly necessary to check in the stub just for this
case. Theoretically, the SVSM should have validated that the HV has the
necessary support before ever invoking the firmware. Just putting it in
svsm_setup_ca() seems enough to me.

@Boris, what do you think?

Thanks,
Tom




