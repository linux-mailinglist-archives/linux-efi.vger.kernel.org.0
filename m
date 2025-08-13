Return-Path: <linux-efi+bounces-4544-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91480B2551B
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 23:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0951C26D30
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D12D979B;
	Wed, 13 Aug 2025 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Zhd1SlC8"
X-Original-To: linux-efi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022130.outbound.protection.outlook.com [52.101.43.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F58122F389;
	Wed, 13 Aug 2025 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119982; cv=fail; b=GwC7HWaX9DbXsKg1mSr1okWyD/ezreZG4X2KqpmYSOm9gZh1HXS2rBM8z1rPIhN7iys5+tAh3Zo1a22ufchnlSYOtMr76HMCp+DVuHarC3FmAPUsWlTyaeJ1TxtxL4vvjQ3eJ1m70QuJmmYh67O3YtTyOImOfyIJ53oPu8kSVpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119982; c=relaxed/simple;
	bh=MJUaUZZOR8MU5gJdGjaD7ImMzVPJIT5zoxE16shBU5k=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=nswuoEO4j8Jt0ldpppRgvLQWT+bHghGTv6NL89ZFGvIEI8RHBD8sokdP08xPf9OBrUXdbbAl4ML9M+gyVyQg/P14iGPWQrqbaW0NJkyvHKn5J5n5cjBcYnJOYLnQaoqa2muMKw3dJqDEmZRoqR4TVA99wLWQIPEByvRKqALZqSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Zhd1SlC8; arc=fail smtp.client-ip=52.101.43.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO+1HbazljDcz2NuGwwp7P9Mmx6T1Sy/qxvMhuTk+6teMhAHdTxL5yXJYG0kztuANJ7nmF61dksLlF8gVVQboOx3cbipTzJcbCJ9pAokXIFnsxXaygZ6A3i32JGWFW5/boY9ycgvQTos58Ivi9SUSzNuuT5Evn0xh1FhS+GY+pTGUN7wCfr14Z4lQbzVn10NkGaM/taC3tIwhwBimltMMtr1AQ73sSl4Kaqhby/53j1MX7Zy5tYCqtzPjDCEt2bbyDk8SpYgCXqqCeuBj9PCH8+9w+c3YnTSBoQxpcZve/ERc4R6md6GLTBPoWw+qAqgIh7udp3LeA0/XsDNiJ8lcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ssz/pOd+LIPTiLCapGwCl8VScqMruUB11aUKhqbX8b8=;
 b=ydIe3ddGU9NkKRG1hX1WT3aFaccTcfoL67TztuTGZ93XgNTFdivMRuVJByLEJvLVutGWpDEmRMMLcy9OswkS/GjklLxDcr/d23MCGGccgEjjjcNvGVu+nziJpnecG54ByPqM467sP/ZM9A2WWhDSh/pPwm0uO4zmbNo527AeJBV5tEAO2MGMn3lgqwmTHVt956CkGwZD883ThEvzrRm1sxNg/eWXoQItYkLBscqX8/CgGK3phAlXJXgylKvm0gRI1hpzCaVaDysFtI6O7EfCRN5Q2LJRSsoChF3aGXjRoIl5bYl5xdtoKXv7yJ9wSROlIRN3/pjEbss0BbGTy0hjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ssz/pOd+LIPTiLCapGwCl8VScqMruUB11aUKhqbX8b8=;
 b=Zhd1SlC8agbuXNbsMcmXqw/KDJGA2A1nY0jOmNQs+FvtULtO7ii3EWgzHT2PfEFMGcot2H+SRWRXYc1W0tKLAHVY2HwDXZyVKuzWf3a7k+qeNED01aJuS0s4eNm1MwxexC8Vtai0wJbTjBZYEOKTySJeDdazdBdxzfroDHoYP6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 SN4PR01MB7423.prod.exchangelabs.com (2603:10b6:806:1ea::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.14; Wed, 13 Aug 2025 21:19:36 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 21:19:35 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: [PATCH v5 0/5] Fix issues with ARM Processor CPER records
Date: Wed, 13 Aug 2025 14:19:13 -0700
Message-Id: <20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFEBnWgC/22Nyw6CMBREf4XctZcU+qCw8j8MMRWu0AWUtNBoC
 P9uxa27OZPMmR0CeUsBmmwHT9EG6+YE8pJBN5p5ILR9YihZKVnFC5zM5t09cowKC4VpUyKvtRJ
 a9STZA9Jy8fS0r9N6axOPNqzOv8+TKL7tz6eZ/OuLAhmSkVxXstai6K4u5GZayFPnpmVb7TzkK
 UF7HMcHxVXbU8MAAAA=
X-Change-ID: 20250731-mauro_v3-v6-16-rev2-3986486de50b
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org, 
 Jason Tian <jason@os.amperecomputing.com>, 
 Shengwei Luo <luoshengwei@huawei.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Daniel Ferguson <danielf@os.amperecomputing.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Shiju Jose <shiju.jose@huawei.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: CYZPR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:930:a2::20) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|SN4PR01MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 3670a3ae-8883-4440-49d3-08dddaaf1a88
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rko4c3U1UmdlZGxOMUlyUHRRWUg2WTRObG41SE5LcjVnWDRUMTR3QVFxT05w?=
 =?utf-8?B?c3dhYW5EWW1SdE0wcXU0NGFQa3hyUTRIWllBSEdSOXVQUmtOZ2hZZ3J2YTU5?=
 =?utf-8?B?TktyR0hRc3F6c3g2VnBodTVGUDNuT2lqd3U3WTFGemNhcVNzQzdtTW5wUHVy?=
 =?utf-8?B?WnNNM1FsOG8zRitPVG52anYwSm95NHRySnNPc1E4cm83REwxb1BSNWZZOXRG?=
 =?utf-8?B?Y00vVEZwcTJzNEdTMVJQci9jRWlYMDdPeWlPOS9ZN3NBOExDNkplZlVSVndj?=
 =?utf-8?B?SEJaY0tFcU1RZkQwQmpRSjcybU9vTm1aNkNhNlpwNFRtLzZ0VzNwQ0drT1JO?=
 =?utf-8?B?aU1sWXNKZ1J4MzdCeUhWWnRjdWkzcnphSzNFaWR3bDAxNTN0dXdxT1dpZ2Yz?=
 =?utf-8?B?bXFoeGR5bGh6TVZscjQxZURyUFRTeGVqZSt2U1dkaFA4UnJrRzlVTTEzQjAx?=
 =?utf-8?B?SUpnaU12V2NsSWNZNElremFPYjIzN3JtdlE0aVdiZ1BhemNrUEtIaW1Cb3Np?=
 =?utf-8?B?MjkvL3ZyYjZuYkhyY0JzVXI4Yzh2OEJhQnoyR0F1QWxFajVJNWxua0d0WHJO?=
 =?utf-8?B?S1hYelVJTW9PT0xNakdRUXl0bDBXV0pEYkp6NnhKZ1JHeEt0eTRHdGt2NFRr?=
 =?utf-8?B?ejZWbmhUcVFQL09BNWJhM093RVlLTHZNZWp0ZTNVdE9QWnpSV3JIalN4ekQ4?=
 =?utf-8?B?UHJvdnk1QU5wMFk5UU9pNGF4S2ZZUWhSU0R2UkRVekx4WkVDSHBVVDlsTTFM?=
 =?utf-8?B?VVRxWUt3UFVUSy9lSUlIbTFtVFhZTFhaY3dRN1JWRFErOEV4ZHhKUTZnOE0v?=
 =?utf-8?B?Ykd3c2h5Vy9razFDYXdwR2UzSVI5endBSElRbUpXbkVUM0ZuSGt4dE8rdSti?=
 =?utf-8?B?OWdCbHJIMUV0cVVGWHY4RWN6MHlVRmIvQkRNV2FkM3RaZlR6NmpTSGFOMXk1?=
 =?utf-8?B?alUwa1l0V3BLemp2ZXY3K3I1MlRWcEF5MDZmb2dDeDhVeFNJS243a1p3NGVq?=
 =?utf-8?B?RURFZjRpamZPK3E5TmFkQ3BOL2dWdnpEQXZNOUFRaktzdFMwR0VJeFNnVG9W?=
 =?utf-8?B?a2ZXY1p4UkcvaStaTjVLVTFZY3hUeHE1K1hVeDFtR21zSHBYTEZ3NmdmTUJP?=
 =?utf-8?B?VWlmTEJsOUFKQ1g0aWpHM05Ob2R1dTNTcXBlYTdOTkpKclB1L0pmUFBkMTds?=
 =?utf-8?B?bFdwNFBmS0lVZ1h4K2hQMDA5QmFZVTlMVUcvWHJpUkVKL3ltd2QrOVFzQXhI?=
 =?utf-8?B?eiszN3JCc0lHdHpWZ0RGTGhiQi9JKzF5L1BFRzR2M1BsVjNtUXJJL0JPdVNV?=
 =?utf-8?B?N2lvSkVRYzl3aG05QitUUnpYL0pzaGZXL1hMOXZuRVk5NjNKMDZnY01aMWhh?=
 =?utf-8?B?TDRqWTVzckJjYkJqaG9ZU3dNUzhQY3YyMUlRbDN6V0xxU1pEbXFTV2JKbUZs?=
 =?utf-8?B?bUNJT2Y3bU11WitvVDl5ZmdUVGkyYkNmcW9YMGFUNjI3ZnNydjJjWkxrelRu?=
 =?utf-8?B?aUQrMVNvM05ad3JhNmJhc3NBYjQ0WHZFQ2t0Y1JTYXoybERVVGVadnh2WmJY?=
 =?utf-8?B?NkNGZjVNaXFjWFFZS0kzN1g3TnFBUHY1VmwrenNhUHkrcjEzSGFRL01oM0hJ?=
 =?utf-8?B?dDVDZDZtZ1REc0FzNGYweXZnOUZpMklBbHFZclY1ZEpYc1JoQWM5ZkpWaGhu?=
 =?utf-8?B?Z2VxWVExQ2QxWDlOQ1BEMmY0b1RSQy93cHUrQUlVNzBDVUw5UnFNNG1uNGZW?=
 =?utf-8?B?dDRUOTBBcUxsditEdkU4M0xkUTJFL0VkeEd6T29Hd1hLMlI4b2xGUUVYUFhQ?=
 =?utf-8?B?RFBWZ3NiK25CVXZZT2NiWGRiSmVYYTBqb1Z3WmtaR0ViMThUVFZZQ2lvL05M?=
 =?utf-8?B?VjFuZUFRT1FrK0pHOFVyVFhRb3dMN2NycFhadXlmclpvMjZ6OCt0OEFHTnlZ?=
 =?utf-8?B?cnBsOU85bngrUk4xaGVJRUVHRnB3MkRic1JjUUFUUVdiVHhLL1FVZnZVZUV4?=
 =?utf-8?Q?s24ws0i5QbQ9dA+o6QO0vF6XaE4jUA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFdNZkErRG5RTkl4bVZ1RTU2a1JLUjBVaVRTdDVteU5zWThGc09WanRyNDVq?=
 =?utf-8?B?N2hhVU42dVp3OGYrVzFLL2piaTdCMGxSTFZhMVFHYjNjYVhFc2tzcitmWER6?=
 =?utf-8?B?dmE2Unk3aDBWSXErTm1MREFpN21MVDRkVXFkc2tDY3Bad29ZNFZlSmJGMUxw?=
 =?utf-8?B?bXQ0QjFtSkFJbVVRVDFoOURmNUVySi9YMitXZVhmZUtnaVVJS3FML1dReE1O?=
 =?utf-8?B?Q2ozWGFyV2lrSlNxeDR6ekNTYjExYjVtbW0zTURXS0d1WnhwV2FsbjlOajhX?=
 =?utf-8?B?dzVlRUJHTXFCYi9RdXk5cnhxendHMGs0Y3ZmVXREVzllSG1PYURmZGdzTnFl?=
 =?utf-8?B?UkxTMHl3NGRiS3FUc3ZicnhmanVvNDNkRnRYTHpnYlZORWJGaXdWV3Urekc1?=
 =?utf-8?B?QlNaMXJzODF3dzErWFFqQktpL25Yb0IwU1BkNWYzV0N5N21CN080OTNCTEg3?=
 =?utf-8?B?cEtLMTJ1QTN6QW5HWGxLU09TYW5PK2h5ZEtKSU1SWk51NDJWTEJiVDlHUXNK?=
 =?utf-8?B?ZXVMV3RhOVliSkpETmpSRzdHeTU5cW5tWlUxV0VkcHRMTzhMcXVRN3gxc09X?=
 =?utf-8?B?a3EveVpweWpSalY3MWFVSFRXZDdzTk5lUFh5SjkxZ2xSRjdUMW5wTXJWdE5G?=
 =?utf-8?B?YWE3Wkh0U0dBMWdxVWNOTEZXNkNRYWd1VXc4UE81ZURzUURtemF0KzdwNWow?=
 =?utf-8?B?ODQ2Vm9Nek9FVEZTYlhCV2IzZEpzcjlycldqRENIRFNmY1B5WlhGUTFnSkVB?=
 =?utf-8?B?Z1ovVHhZVkpzVkpGWnRqYlpwRTNicDVHNWhyOWtkYkRFbGdWWTJOMmVLYlor?=
 =?utf-8?B?ODl5MXJFbVY4cmp1R3JIdWllL1JxelJJNDNXa0dUc1lyZkk5ZFdmZk5Iamho?=
 =?utf-8?B?VVZ0ZTNzRys3bCtjQmROMm5pYmNBQXNmR1pMZnpCb3hqMEFYblJyOHNmN1RY?=
 =?utf-8?B?OHorbXB4QTgyRUxnQXNZR1hIR2ZFY3FTQjMrOUFvTVpjWWQvTVJKQkwwdUMy?=
 =?utf-8?B?Qy9GQStVU29tUnMvNGtKVVRzZEFQblowUG01cDY4cnRRaDhkam1mdERRVkth?=
 =?utf-8?B?TVJwbEFLSHFwbktsMWhGWFBKRFJjTWtVSEJsa2NaeUxKa1dZWVh0QjR2V1VW?=
 =?utf-8?B?ZjE0UE4rdkRtdkg2RjdDNmNOMGw5YXVtcVY0QnZQZHN1WUJJVkhBVU1kUCtB?=
 =?utf-8?B?aEJvUmtsWDZIdVhlYzVkcitvUW1zMW9NbFpxZHNFZ3Qra1p6ZGhOMVY3OEF0?=
 =?utf-8?B?OTV2VzA5NU4vRjBqYU9Vd0RHQ1h4eExyQ3Q4ekkybVVEZ0VTbVhGQUNZeUxP?=
 =?utf-8?B?aU16aXV0cTdGWWsxQ3g1SjFRdm4vSHF1Q3pXMXRJQ0xFS3JPVHBsdjJSU2tn?=
 =?utf-8?B?VzVUWFZlYkkvek5sbkZvZkVpYXczakRidXlQYUZuVldiYzlDbFBkSzFQeGUz?=
 =?utf-8?B?ZVBmdHcyY2VqYkNRKzA3dEtWNUJ2MnNPa3BSZzhuUmFGTmZ0M1JBdVRGUGl0?=
 =?utf-8?B?dENiYTYrenU4SWdPdDRhVDI5RnlrZCtKQ2RQc0ppZkJnMjB5WXU5RzVGYkEv?=
 =?utf-8?B?N3pJNHRSM0pNWVkyc0pxSmJLcU51aFF5ZmpsUmxuTjlBYnJzQUh3U3ZUaS9q?=
 =?utf-8?B?UmF1VTRrRWgyc1JEVHhYMkwzczdBcW8xMytUNnpCUFdjVFI0U1RRb044aXhP?=
 =?utf-8?B?SjRsRHRrYWd5RHhpTE0zcHZnSmxrT0lpWDhJUXZLM0RZVVBTeUtVcnRhblI0?=
 =?utf-8?B?SkJhYy9XN2dGZ084aEliYWhsRjltVUlHK3N4K0s5RXkrWnV3blF2VDIrZGVq?=
 =?utf-8?B?L1dmcnhSL2tZLzdoMmxxb2V6cnFZL0RwUlhySHRyaFBOQmp4VlZveDRYSm5p?=
 =?utf-8?B?b01RYWJUdS9TejhPblUwcHd1YStMK0s2TDA2bVl2RnoyZjgyZDd3NGVLZHA1?=
 =?utf-8?B?QWQ4MkU5c2h2MjdmYXJ3K0xBVHQ1SWJJOTFOSG9iMXpGbHIxTFlZTGp0NEFR?=
 =?utf-8?B?TFR0cnV1ZG5tMTRDcUQwaTNHY3g2eHM5YWNjVVVWMUo1YXd3MzZkNkFZS3ht?=
 =?utf-8?B?ZVpnN2h2d2s4RlQyNEU4c2Q4QkJaUHdwLzF5d1dKejBpdEoxT0I3Z21zR2lB?=
 =?utf-8?B?VExFOGtWV3JtQ0lPYkpqVHRjbHVMZitpQkUzeEgyU1RUQzByZE1hNXhPaU9v?=
 =?utf-8?Q?ae3ySEyNB7uj4pvKg8zCCxs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3670a3ae-8883-4440-49d3-08dddaaf1a88
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:19:35.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCDFCPKzk64xsdTFznTEo9m0D98dkSUJ/dDPDas4kHIWVTYxxNyyG3ilPgMbikPTfcTxYc0TxcvziFxpYNpD1w/fzGnl85VMZfSSE0HpqyJU1tncITGzpp3c9El8aKLV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7423

This is needed for both kernelspace and userspace properly handle
ARM processor CPER events.

Patch 1 of this series fix the UEFI 2.6+ implementation of the ARM
trace event, as the original implementation was incomplete.
Changeset e9279e83ad1f ("trace, ras: add ARM processor error trace event")
added such event, but it reports only some fields of the CPER record
defined on UEFI 2.6+ appendix N, table N.16.  Those are not enough
actually parse such events on userspace, as not even the event type
is exported.

Patch 2 fixes a compilation breakage when W=1;

Patch 3 adds a new helper function to be used by cper and ghes drivers to
display CPER bitmaps;

Patch 4 fixes CPER logic according with UEFI 2.9A errata. Before it, there
was no description about how processor type field was encoded. The errata
defines it as a bitmask, and provides the information about how it should
be encoded.

Patch 5 adds CPER functions to Kernel-doc.

This series was validated with the help of an ARM EINJ code for QEMU:

	https://gitlab.com/mchehab_kernel/qemu/-/tree/qemu_submission

$ scripts/ghes_inject.py -d arm -p 0xdeadbeef -t cache,bus,micro-arch

[   11.094205] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
[   11.095009] {1}[Hardware Error]: event severity: recoverable
[   11.095486] {1}[Hardware Error]:  Error 0, type: recoverable
[   11.096090] {1}[Hardware Error]:   section_type: ARM processor error
[   11.096399] {1}[Hardware Error]:   MIDR: 0x00000000000f0510
[   11.097135] {1}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000080000000
[   11.097811] {1}[Hardware Error]:   running state: 0x0
[   11.098193] {1}[Hardware Error]:   Power State Coordination Interface state: 0
[   11.098699] {1}[Hardware Error]:   Error info structure 0:
[   11.099174] {1}[Hardware Error]:   num errors: 2
[   11.099682] {1}[Hardware Error]:    error_type: 0x1a: cache error|bus error|micro-architectural error
[   11.100150] {1}[Hardware Error]:    physical fault address: 0x00000000deadbeef
[   11.111214] Memory failure: 0xdeadb: recovery action for free buddy page: Recovered

- 

I also tested the ghes and cper reports both with and without this
change, using different versions of rasdaemon, with and without
support for the extended trace event. Those are a summary of the
test results:

- adding more fields to the trace events didn't break userspace API:
  both versions of rasdaemon handled it;

- the rasdaemon patches to handle the new trace report was missing
  a backward-compatibility logic. I fixed already. So, rasdaemon
  can now handle both old and new trace events.

Btw, rasdaemon has gained support for the extended trace since its
version 0.5.8 (released in 2021). I didn't saw any issues there
complain about troubles on it, so either distros used on ARM servers
are using an old version of rasdaemon, or they're carrying on the trace
event changes as well.

---
v5:
 - fix a few code formatting issues
 - remove "Co-developed-by: danielf" because his/my contribution was
   removed in v2.
 - adjust tag block
 - Link to v4: https://lore.kernel.org/linux-acpi/20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com

v4:
 - rebase to kernel v6.16
 - modify commit message of patch 1, and adjust white spaces
   per Boris' suggestions.
 - Link to v3: https://lore.kernel.org/linux-acpi/cover.1725429659.git.mchehab+huawei@kernel.org

v3:
 - history of patch 1 improved with a chain of co-developed-by;
 - add a better description and an example on patch 3;
 - use BIT_ULL() on patch 3;
 - add a missing include on patch 4.

v2:
  - removed an uneeded patch adding #ifdef for CONFIG_ARM/ARM64;
  - cper_bits_to_str() now returns the number of chars filled at the buffer;
  - did a cosmetic (blank lines) improvement at include/linux/ras.h;
  - arm_event trace dynamic arrays renamed to pei_buf/ctx_buf/oem_buf.

Jason Tian (1):
      RAS: Report all ARM processor CPER information to userspace

Mauro Carvalho Chehab (4):
      efi/cper: Adjust infopfx size to accept an extra space
      efi/cper: Add a new helper function to print bitmasks
      efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
      docs: efi: add CPER functions to driver-api

 Documentation/driver-api/firmware/efi/index.rst | 11 +++--
 drivers/acpi/apei/ghes.c                        | 27 +++++------
 drivers/firmware/efi/cper-arm.c                 | 52 ++++++++++-----------
 drivers/firmware/efi/cper.c                     | 62 ++++++++++++++++++++++++-
 drivers/ras/ras.c                               | 40 +++++++++++++++-
 include/linux/cper.h                            | 12 +++--
 include/linux/ras.h                             | 16 +++++--
 include/ras/ras_event.h                         | 49 +++++++++++++++++--
 8 files changed, 210 insertions(+), 59 deletions(-)


