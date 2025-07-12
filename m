Return-Path: <linux-efi+bounces-4298-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7402B02B8A
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 16:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B250C7A897E
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE9284689;
	Sat, 12 Jul 2025 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eBA8ZL36"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F497262D;
	Sat, 12 Jul 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752332071; cv=fail; b=O8cp2qHNVs0mU/U7SPY84+nfuzg9TqFZ87lbk+T20Qkjai5wGNy5PGykb87F22nLlNduc05D9N08ROhTFCS4llJxFjTv1BSuqsHnQugzSau2zZ16hWHbC+FpEwBztI041gbbViM4xVoCKZMSWrWFSV5B/Pz0Yp7CtlwTv0NzkGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752332071; c=relaxed/simple;
	bh=YcBxixtT/rlJv6hTO6vGoWEJmBtXZhyUZpd6kH0cKPo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JJoDNeuq2uQQuZF93rrwjpYNG7o0vgoWbY6s7u5/cqOw/iH/U64318d4EK9QbYA/3nkcoLc7aWgrKwJcgOYi5aKIh80a0OuUUYvwuk+ymRNR05OT1tGzQrlRPIzcEcDlkrv4qfSzmoGClw4xROEdm4jY5NADHmTayN6l4eekiC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eBA8ZL36; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhViOcjz9cFhqtaXL7feHDPlyFjne/nG9aFcraFHxmZCTdyWeFeEUxIOgHJR/E6YihJhusiUdo5/Xwa8rCmbmull9paA8Kj1dAJoylTUNufGrscR7NFy+RopD8VbVFh9g0ksI21/fWSNgJYgkcfkbgHoxsue7S0xIiosepcME9h/mUE+i6+Hvhq3l/DF+ebL94kYyqFeffntxf0ZyvpOP8QscK4AyZrTgMAmb3C8ZhNeeuOzItOaR1jJQ4RpqQj8q9Ub0SGn3AVIwd2sWmVXjz5P8znIi5BZ2HB/4nnlV4HBNmuG6B9fm7zhgMc46I+Fcwl5pL5JG6037teD8iI/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp43xNGPlW/diiUJWC6FptnewT5KuIE9gaSaqWOoRuU=;
 b=XYylNAFjuZdNUR4Vz9h9WNPY6guBPWGnE3Tscby2zC1eN7XNs/wThWEeVLt6MomJ0xkXYcU62sYqOBCwmO4zmfVa/76gA6BpfvDsbGibjLnLD7dt3BsFjHvwwMlj4KDKEAss288YpLnIqLj/PstbGudUMqnYxVKbmqsEl0/SPIcpKVhC7KqY0X/fzMwyCRUOfazK6jIvGVYBQQU3ufuVDMtVUb7YJbCA6rhJZAg3SqXAIMMZ8IhZ8LB8chpbHCt3+lrON+wkc8bzFj89oCvfc8TSP91liR3klbaSM5KzIKdFovP8XXZvstu1QdtK+kfWAG5lllLgDEVsNOArqmZgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp43xNGPlW/diiUJWC6FptnewT5KuIE9gaSaqWOoRuU=;
 b=eBA8ZL36w+D3saJ2knu8hx9OW+Mos76yWuS+vjMOQdEGJpSWuasS0pz7nQ9lri8z1QqSVxv2vcM94ZRFYEXuSWYCY6kPRNq1ls1jdgqkeNiLNnBXxTPAoNUX9WtQ9Gxcn560NzPSniJKL28qphsuhCM871akxQvRTYHLZ4cjjPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sat, 12 Jul
 2025 14:54:28 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8901.023; Sat, 12 Jul 2025
 14:54:27 +0000
Message-ID: <88cb44b0-62bd-e753-9aba-82502d162749@amd.com>
Date: Sat, 12 Jul 2025 09:54:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 01/24] x86/sev: Separate MSR and GHCB based snp_cpuid()
 via a callback
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-27-ardb+git@google.com>
 <74889161-adfa-3547-d8a9-3ff154098c7a@amd.com>
 <20250711205944.GDaHF7QAvRhPZOWMX_@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250711205944.GDaHF7QAvRhPZOWMX_@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::10) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c967884-b73d-4561-1aa8-08ddc153ffb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEkyMVlKNExxYjY4OUl3akhxZjViOXVmOEZpWUNXZGRSNjd0aVVBVWRubFJN?=
 =?utf-8?B?UVdnQUNyekdRd3I5dUlCU08yZWs2Qm9iSm1nb3oxSExXcGFyN2dGK01MLzJO?=
 =?utf-8?B?ODlMaGtqRFFUM3NSd1FHZXY3bDYzMUlra1JHQTRqSFBrc3VpTU1VYkVCSUx6?=
 =?utf-8?B?NkNHOW1ZcUN1TXIzcFI2enRwdS9vS1lRcVE3S2tsak5aVG1BYWxGSWxsb3ha?=
 =?utf-8?B?c1Q4UGdwUzRZUFh1VDNpMElMMTVzMWRHbVdackY0NXpzQm9xVzdsekdRd2x4?=
 =?utf-8?B?dk94TjZBdmRPcG4yZHVmS1pmSU4vanZQT3VLUUNzcXdrQTJzb2thakMxVmEy?=
 =?utf-8?B?S0l5Y2h2eFU3KzVJNWZ0WDZKek9Kdnl1dUZhM2QvdlkzMnFwS2w3SXpCNS9x?=
 =?utf-8?B?WWR6OXFHeHZZMzFrWEgxTkI5dHU1bWlWUVRvY0NiYlZURXk1aVJkbG9uSFVa?=
 =?utf-8?B?bW5CYytqdjg1RkdmdXpJLzJueHRaM1VETjBQK25iN0pjL2RUS0x6UUp0ZnZu?=
 =?utf-8?B?amtTckJwYjgvcXBtSTZDZmJ3V3VFR0puaDhlUzliNnFxa0srSDlNMHlGTjd6?=
 =?utf-8?B?RkkyaGt6Z0lGRTdsRVhMNWgxS0tvbE00SUVNaGQ4czdETGdrQ1FLQll5dmg2?=
 =?utf-8?B?My9uREw2aE9FSkJ2NUxqTkZoWjRBQTBFSjdXWGcvOHpNa2lWZzFBVzl4U1BY?=
 =?utf-8?B?VGtmbFR6RGFsSjcxSlZoWVRHUDNHZm5wZzJaclowTUhON3I4MkEzWnJCUHEy?=
 =?utf-8?B?TUNmN0hHVk1qa2V2SGVOdkdJSU1GeHZCSmwzUmNjSFhUNVNBUUZROFRuR1pX?=
 =?utf-8?B?SUoxUWwvOUdSYkV0UCt1VEV5ek9BcW0reUUvS0pWeHk2U1hRQzYza1Y1N2sw?=
 =?utf-8?B?UDZzZlZCcEttaWErTHhPaC82THVoUGhKcng1OXhGWFNQUDFGWnh3d2s4QmFj?=
 =?utf-8?B?cUNBQUdIZ2w0SHhTVG5veDd6M3NrNVVTclFtZWdieWJOTTd6MUZyQy9BWXJk?=
 =?utf-8?B?d3d5RFk4NVpnbndvK1NoUHFOYnhFbHdXc3hNUzJsZnN5ZFQ1SHY4bU1iSEor?=
 =?utf-8?B?MWh2RUZ5alk1Skl6YzcwMXduaFBZSEg4TnVIdjRqZG9FRXA1amJkTXRpTjE3?=
 =?utf-8?B?ekVPN2ZUc095akFON0FDd1Judk5Ib281SmZWM1JnUlU0UzBnVmJzbHI2dC90?=
 =?utf-8?B?YVM1Vm5IVTl1V3VzWm1JWVRlcWQzZFBud0RtMEJ1RmhSWU0rU0FnMGJhTnk3?=
 =?utf-8?B?MXhOR3pPR2pWY1FFTDIzY0dHVzFMQ2NISGNTYndDVmpCTUFKT0thbkp1emF6?=
 =?utf-8?B?cTY3WC90aEJlQmdlSGswR0RKeG53YTVLMUI4cDFJN05DbVltbzBIcnZqZ1FC?=
 =?utf-8?B?SmR5UHF3eHlPZ2M5Qzk1RWFGVEMwb2JMdllWMDdxbWdKdW4yQVlINGZVSmpY?=
 =?utf-8?B?M2JNWGVOTkxwSm5tNnVDWVp2ZXBHd1o1dlpoMXNuUzd3SmY2TExhSWYrNTF1?=
 =?utf-8?B?b2hqa0RCbEU2UEcyV25QTlZSQ2ZCd3VFRVBQTk1mVGZtb3E4elo5OVlBNTNH?=
 =?utf-8?B?N2VRam84UjRjVFhEVDRTV00rNVZjaW10cFdaWEM1MFdPQ0N4YzdSMXlES1Nm?=
 =?utf-8?B?LzlFYnVIcGsydGpvb0l1Nk1hMjkwRE1YOGtObWR5R3k1WEtFc3BhN05iU0pX?=
 =?utf-8?B?YVJyU0Z2ZjBTRllxeUlrYzdJRzl0SkpPYVkya0E0bUtVekk1b0tJNTVYTlZx?=
 =?utf-8?B?WjZXVUVhNlpUNmdJLzM4SWZhVUtWUGRucm5oOEcvTFZ5VjhMOXFiL2hpcEFt?=
 =?utf-8?B?Tm9ZUk0rZURNY2ZKYThhVEV6YW8yZjlnZjVxbmZiVjA1VFZSVk8zV1BBWUdT?=
 =?utf-8?B?dEJuY2JTQ1MzMDk5RFI1aDNkUlNIRUt1bEJrNFVTbVhoUEN3U2VsbU8ydmJJ?=
 =?utf-8?Q?5WcLlj4+ubU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3JkeTJ2ZTlKbVoxU2hRd1VnWUxVaG1IbUtmNFR2ek1NZGhYRVZXVk1rRzlp?=
 =?utf-8?B?dzY3ejhCZERPWU5Xc1YybU84MUpxYjRwMnlDanRiWkN0aHRDRndlSUJHbE9w?=
 =?utf-8?B?UUg1a2pzaXkyVzRTWGNBQ3BkaHlkWFQrQ0d1OTh2QysyNUJ1WlVLakhUbG9y?=
 =?utf-8?B?b1JoM2R1T1FLK25BRWFmNHNqMUFJQnNlbEJWcGxGWHJXMDBMT2dyeko2TFBq?=
 =?utf-8?B?THd5ejdLcGFxVjBMbFhQK2NKRmhyV3llblZEVzhKWnhlUlg0U2xJTE12eFpm?=
 =?utf-8?B?WU1TS2VKamFiQXE0MkxkbmNsa29RK0g3YVNLeVAvai90SXdHbVJiOWRlMGx3?=
 =?utf-8?B?Z0E3TEpROVNXc285ZUlraWhHd1ZGUGVwaTRjVzN0YWY3SVVwc0t5SFJ3NVVJ?=
 =?utf-8?B?dW04WmNMaTk1N3IySEdaWDFTQm5LeUNLSU5ZcUg1SjN0WFNnc3JMdkhSOHNt?=
 =?utf-8?B?SldTMGkxK05PTWRVUFE1MnhTQmJaTE1OOGh3dmRiK0RmblZMalpMcHhSZHp5?=
 =?utf-8?B?RDlHQytiQWQxVzMyN3lEdjlyZWxEMVNyRmtqODNxTUxzck9pdzIvc3FKc2hr?=
 =?utf-8?B?VlQ2S2hDOEM5a0dRbE5jYnN2eTM5cVBvS1BqMDl4M08wbmF2MW5wNDJ0V3N5?=
 =?utf-8?B?cWYvbnV4REVockxMRDZWWmsxeUY2Y0tocWFHcFVxTTlKSWdUaks1emVHVnFz?=
 =?utf-8?B?NjVraW9pa1hSNHlZdGhwaUVDemRQQnRtQkdXblBUQlBFMmlmcldzeVFyZkNC?=
 =?utf-8?B?Y3FrWjA1Zko0ZEhPdkxUZExwcUJLd1RUS2M4U0plM1hvdFlHVm5xNFhZdVU1?=
 =?utf-8?B?Nms3OVkrNS9xelkwZG1XUno3ZVNwb285WDl1L2RHblIxZGtud0h6ZGJWdUlT?=
 =?utf-8?B?QkkvUEt0Wm1UL3JqMksxRmdaNDFkNVJKLzRnOTdVUUFtTnExd0hzbXNtQy9t?=
 =?utf-8?B?KysvODMyZHkyekp0empUbXI4VTUyMzRxc28zeWRCYzMrNlVKbHRvVlFDUmdQ?=
 =?utf-8?B?emRTU3pSSS9nc0dmaFd5K3pFOXloSzk0NHlZL0kxT3l6dDVkeW4ySTVVQ0NO?=
 =?utf-8?B?Qm9YWWthZFgyRExZbzU4N3dYdmV5UE0ra0hkNjBzb1ROZDIxM29UUnRwVk1p?=
 =?utf-8?B?enE5UFpRaVc3YVhtcUR4djRLeWpSWjMvS2xlYkJzTVBMblJnZVlvNUd1OFp1?=
 =?utf-8?B?NEorM2hVOGlNUldpbnFkUWhmVHZFdTljUy9XOFVKbkV5UHg5ZjJna1h1MHk5?=
 =?utf-8?B?UFplWG92dUU1ajZuR0hNOEwwQlJJWHZtUmJUVnQ2Y2dKbWN1dXpOSC9tUGF5?=
 =?utf-8?B?S3dVcDlvdTZqaXRKVWJ4S0I4V3FzcDZ5d0hWNnZyZmtrdzA2R2xwTjdmeFVC?=
 =?utf-8?B?bXpNcjhxTnlmTDNJOW1la0thY21aYW5IVEVzWDNmSDNrZzQzaGF2dDJ5dEx1?=
 =?utf-8?B?TTRJbzB2aUs2VVhjT3l0V1FUWVZXeGZZWDVOOUpTbTFXaU5URXQ0cDArWlZO?=
 =?utf-8?B?NTMyTEV5V1ZSYXIrVllNa21ncjlySkUwQ01nTzZQTnppMFZXMGpSY0VGcGk5?=
 =?utf-8?B?T0dGTjcvRFh2dElRcEF2Q0xrMTdIM1lPS0xLUVE4THk3VE9pZU1BK3Jyc2U0?=
 =?utf-8?B?WnhRZk45Vll5WTJMbGhxT1RrSHpxU21scWEvOUV3MTMyaDZPeGdERmxQVFZS?=
 =?utf-8?B?dnFhKzJZbTB5a0p6a1FHbGQ1MGlLY25yT0NkbHlva3l5VEM5dmZUMXpEbFhw?=
 =?utf-8?B?ZUI3TE5HUzZYN1pGU0xmMm1HQ1VTbjFZWUZPZ3VQTTZmUDNwcjc0VzZBVm1O?=
 =?utf-8?B?b0NMcTBBamZSVWN0UXVLTnJWcTJ4UmRqNHdoS2gxdU1ubGtnU2dhclk5a25Y?=
 =?utf-8?B?ZFh0dWZkSGpBbUdzaG93U3RhU2FDMFBBL2h5aUhQOUFib0dVS1FDTTdPMlQ4?=
 =?utf-8?B?VTJHMmRpOEZYVUpOS1ErNWhSZlJTZGtKTE1WMFdFT3VPb282clVSTlZTcGxW?=
 =?utf-8?B?bUxpZlJ0V2M5QTlhL3ZrU0pLN09UVnluOHhHOUhZQjZOaFZza1dpR2R4aWNt?=
 =?utf-8?B?T2xFSFBvTFI4NE14N1c3VHZZQk9TSWtmSHUzSFl2VksxNlNkTFd3d3pNV2lB?=
 =?utf-8?Q?bRsH5f2ZADKYc1SY/rLq+dqKs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c967884-b73d-4561-1aa8-08ddc153ffb9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 14:54:27.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4lstRNMeKtEQneAlC18X5vuZXHDhJWe3+9sYVEL8Nh/8aG3dhJk0GU7N/Lg/tMtqogC23oEyOM38zKBMPs88A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817

On 7/11/25 15:59, Borislav Petkov wrote:
> On Wed, Jul 09, 2025 at 10:12:48AM -0500, Tom Lendacky wrote:
>> Not sure the renaming makes it read any easier or say anything more. It
>> does add extra changes to the diff that have to be read through, though,
>> so I don't think it is beneficial.
> 
> So it really comes natural to split them into a msr_prot and a ghcb_prot
> variant. If we added a separate patch ontop that does only the renaming, then
> that would probably be more churn than necessary.

Right, they already are though:

  __sev_cpuid_hv_msr() and __sev_cpuid_hv_ghcb()

the first one meaning that the hypervisor is being called using the msr
protocol and the second one meaning that the hypervisor is being called
using the ghcb protocol.

That's why I made the comment. Just changing

  __sev_cpuid_hv_msr() to __sev_cpuid_msr_prot()

isn't saying anything more in my opinion.

Thanks,
Tom

> 
>> Maybe rename this parameter to snp_cpuid or snp_cpuid_fn or similar,
>> because it can be very confusing to see "cpuid" on its own like this.a
> 
> Yeah, that's a good point - snp_cpuid_fn clearly states that it is a function
> pointer and not *the* cpuid() function.
> 
> Thx.
> 

