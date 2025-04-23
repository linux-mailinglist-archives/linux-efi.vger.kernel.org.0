Return-Path: <linux-efi+bounces-3433-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A72A991A5
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 17:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CE07A5EC3
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEAF2989AA;
	Wed, 23 Apr 2025 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EEWtc8Ze"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00834189F39;
	Wed, 23 Apr 2025 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421758; cv=fail; b=lZWEUpqmrF6p7kXDpowkYW0BDhDtiMHbYUs3rWKtaxF5J/bdSSYd3dYoZk5jAfr9gcYbuS4ezAjyQnjNMhsPWUxMJZqxvCnGGNnziJ5wWX/Exj3GXUO3mffFMb9aRo0NIk8hZr6/JTeWezdsn+jJ3icYNnqTVtsrQM+abfymQhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421758; c=relaxed/simple;
	bh=ZMM197778NZ1auNyetMD3iAe7n+nuQTExdwWzhlJQF4=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=TsvzDBC7VMOUTHM42P3M8Pa+6ImndnsDKjtPwSR84z57Ic3n07L3Bww5SIWhh3MXp4CAXrN7VIf7ZO+9gyLJPuD1YMxtNmgWlzM5AB3rhDzLB622A9fizG6qIieQE9uejdSeHgr/dwUvwwzDU/YcIKRDdjS/u4GYKcoGeVYX+jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EEWtc8Ze; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UY3e6u4OWogujkJvfNeQ9Ba44ku+ZJwdg7zDPzFcNpmIRO5tp3LWXOeiIUzm7feAJFbJ/a5l5OtCtT7ED4Utk6LAiuly6P+ndkKxEGs1ia9g2Hd6umqk2HP52dCim1pLU5n2ZzgAYEkxIzkjvXm2WVsXIh1t/HGw3GXKKblbiir0lU7mjlzdJ5tLa/uKXN5oIFlZ79tB350XRiMdYW6sCa+rQ/gUBhBGcmFs4JeFxA8u/qwehtXM5bSEEbR/FWQ+jTMnt+/VyjuhpnIIa1Mzi+CI8EFufivDh2K8IG10hudeA5wklHUYdz+4ura79NN5APFXsEwR4bnoaBZoedjk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdTuRsjVehEAZR/ThPdzwxNxFwfWIGbaq3qp9wDiwg0=;
 b=P86h+MesPuIKWshsxzn1plAKjWANT2Q4h3Wyl1M0KFoN9ct2vFhH6s2O8zZ/KMSdWQgLxPAHMJJdrfYl1Y/exTma5Bt55yv5bXvzvCyFzFg9yoMcQfAEyOsoK1ouHRcA2ckYUbsNBVlmVis60qOBJXEsiaWJrqBYTtNtuDuZdqm3VgLdlR9d0Bngyg5enERd+fxEhpVmHGRRTHJtd8MNto6w88TrULD5wDgdI3Lbsl2tvxXgiErRF4ffmv7l/pkZAL67o24RXP51dbiURr19+zLuQmVySjTXjryapvWPo1IaK0J5V13HzXxw8WyvrCOvdZoR039RfI91/+odKXlvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdTuRsjVehEAZR/ThPdzwxNxFwfWIGbaq3qp9wDiwg0=;
 b=EEWtc8ZeahyxyqpraJSjc4EK4z9NSdYBB4zEq/rCS+BKnB/5oQh6rIaIMdUVncXvpuwxrbgAMwI3ud5HS0bcCT1AHBDvcf8ZLCh4LIpyedx+VMDsiH3SW8qmOqopdMv912nt6/CYBkziQ5BEnD7kby7pHgpK9vxkDhSrmTo6g74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 15:22:33 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8678.023; Wed, 23 Apr 2025
 15:22:33 +0000
Message-ID: <cf878810-81ed-3017-52c6-ce6aa41b5f01@amd.com>
Date: Wed, 23 Apr 2025 10:22:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20250418141253.2601348-8-ardb+git@google.com>
 <20250418141253.2601348-11-ardb+git@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v5 3/6] x86/sev: Split off startup code from core code
In-Reply-To: <20250418141253.2601348-11-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:806:f2::11) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 5064ad62-4eb7-4242-a799-08dd827aab7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGJZNUFMYy9DV3FKd05HejNLbTF4dU1TQldHRGIvU3dCaW83UG9GRDNoK1NW?=
 =?utf-8?B?bjc2dG1NQnNacXh2WEU3Z0J3dHgrZ21CeThSTXYweW95Vm5PSSsyZWlMaXBy?=
 =?utf-8?B?QmYzWUtTdXlNL1NoSWtkaUZtYis0U1NGUUFtdEV1aWg4UHpwc1FEa2d1aERl?=
 =?utf-8?B?QVdQR3NXakVwajM0bHdlc1c4aWdrN2ZTNCtSbTlFSE9taWYwNEZITWVrd1Ew?=
 =?utf-8?B?YWJ1dThxYldPUmNsRzQvYy9leHhsVjFNSU1rb0FUdTJMMW1iVUFLZlh4eGh6?=
 =?utf-8?B?QThOdUZ0QVJPV3NhSDVtNzlQSFNqMzhCYnh0Q0pCVTZJQWh0Z3QxN0pSUmZX?=
 =?utf-8?B?bGxxbWRQdDEwSjRxNGZOT1o4K0kyT3N0MkRURlI2RzhOY2VuUHBYSTV1a1Nh?=
 =?utf-8?B?UEdLalk2d3A2YVFvR2RBVUw5RWs3V3ZlNHV0SkdSVTRkRG0zREdvNUtFWVBp?=
 =?utf-8?B?Q1RFc1FEZ25EeDJyQytweHhlRkFLQmt0c1RQQTVtWnhTdHozenBKS3ZuTGps?=
 =?utf-8?B?Tnp2d3E5L2xRcjFJeXFGT0NsWXUwYVJQL1E3NFp1NHpXZExoQ2hCUkxDTC81?=
 =?utf-8?B?MTh6UElOQ0loK2wyMFpadm12b210R2sxditFMnpBWkY5WC9CWHRFK2RIeFRS?=
 =?utf-8?B?bG9RZDdTMXZvQ2RwVDBrL2IwWHREOG1zOEJTVGxKem05cEgzRm9sRzRkUTVa?=
 =?utf-8?B?QWpzK3hiOGZOcEd4aThWekQ4UVlzL1RKMklQcEladCtnZDMvTVRTaWVkbWkx?=
 =?utf-8?B?ajA3NDd5Qko1blhKbXdDbmdVdjRNeXYyYUhSZnlIMElWMm1PZzFYK1ROZjN2?=
 =?utf-8?B?TDR2YzFSVEJ2bmlSR3hxbG1PdjM0blVCVlpFZWRtc1p3anFZcVE3LzMzODM0?=
 =?utf-8?B?cWRFNS9yZXZYTTJhcE5LVmFpZFdjY1BJWlVDQmtxQ3I5K2xTUDZ0aDF5Um9E?=
 =?utf-8?B?UGhNQjVqdnlqdFlEREdBaXlTYkZjNUx3SDZveHp6Rmw5T1V4bnM1L3Y2SjVK?=
 =?utf-8?B?TkpOYlUxRzZnTERUb3RYZy9HWTUvNU00QnRsU25EZzk2WkRSL0QrSmltcHN0?=
 =?utf-8?B?RTV4d3pDV1lSVDdRRnZsWTdPSzRUTVNsZ0ZObWlsb2hiOHpML3ExUUhmWkxX?=
 =?utf-8?B?N1d6aVR1YUJYY3NCdFBSRnNEYUFwNHlnVlhuaXptenlaY1hqK3RwamdNZ0hs?=
 =?utf-8?B?bXZKRVZ2blFlWUwrQURkRVcxaEoyVHB3VlNxSzdPa3lTbnNUN0pJTkV5SU1M?=
 =?utf-8?B?dEF4a2pCV2dkdGZ1b2NreVdyWjNmR2RYbllMQkRiZ2VwOVZ1NVZjZ1JTNEVh?=
 =?utf-8?B?ZFFFUTVYMGphN0o5OE10QndUY1dCemZnT1l3eDg1Y2RYR2hOTnFJVEdZUTNF?=
 =?utf-8?B?UmR0WGRFbUViSldKMngzZjhoK042WTF0YWludStzb1R5MUovd3hlYzdTRS9B?=
 =?utf-8?B?VitkNllXT3p3OUJMQWFzVVRaTGJ3ZDFiNVpaOHlSaVRQVlpNNWl0ZWpjNDNG?=
 =?utf-8?B?SGtpOUJyUmRXMFFreVJPR3lVVjZQUmhFNzdnbHN6RTBTRnJQL1pKdFJUMGdp?=
 =?utf-8?B?Z2gxQ21PSkJlWDNrYnd2ckhjc1NlSXhQM0FXL1BxZDBVSnJKSk9iTW9LeXIw?=
 =?utf-8?B?dzlnQlladkVpZHN5Y3liS0NoWW5uZ2xvWEc3RUpTazl4SjdMYUZoa0xVaGZ4?=
 =?utf-8?B?VFh4WFZacWNCZTdSU0VKMGhTKytkZXE0a0VwbFFUNGpudHpxa04zckxRVjJl?=
 =?utf-8?B?YitwdUtrZDlZcUFMcVJsMW5BNTlPZGJsbnZKRmswMWthZmFwcVgwQUhQRkUr?=
 =?utf-8?B?TnJzcXNRUndqekxpWitxSVpsVkNjSC9RbmJTR3lJY1RibnB4S2ZpVWlMS2Nn?=
 =?utf-8?B?UU1ENHErcXlCbzRtNkFCcGJEeVdrTE04MG0zc1NBaHZCZVE1eUk0TkoyZ0hJ?=
 =?utf-8?Q?PzapfKh40SM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGdVQXhkSTJTOGo3amprRU5zUDlJWmxwMGVpc0k5M1pvcjZoTkplbGJpYWNl?=
 =?utf-8?B?aUo5V0VCTGRCQjRRbzFuRFRjQ1lqcy9JUzZYay9VRlVjbkFuYzM5cHdGWmVq?=
 =?utf-8?B?bWFZY0M2b1FEaksxaGZoZVo0WGFMaFNSZHNLUFMxTHcybThsYk1yTHZ0ZXdS?=
 =?utf-8?B?bkp5WlBzRFl2c1hKajdLZ2V4R2MxL2JSMjFYQjBYbHFsRzRtc1U4UllCV0dF?=
 =?utf-8?B?aUk0TDJGV3N5QURVOE9HOHA2TFBuano5ai9lY2JXT2Q0R1JlMW40T1YzcHpL?=
 =?utf-8?B?MzRNeFZ0T2tQMnpQZEhrc0FxMFkwcm9WSHllQlpiVC8vcHNMRGIrQzFsdXhX?=
 =?utf-8?B?eEJDa1o2ekJqbzRXVjk1VWFKcllsQTZKZjR4VkdUVUhVM0xwRDY2amlGa3pu?=
 =?utf-8?B?T2Zxc1c2MmY1bFNteDJZK3BEek5PK3V3S0JNTkpUb0JYaE5NN2lPMDJOeTAy?=
 =?utf-8?B?S2FCT0hhdWg2M2VLL2pXSzFTbC9uRm5JU25xbUFrUGU1SENlc2dJUWVqL1E4?=
 =?utf-8?B?YWF3azI2L09acEd2OG1uWjZyZEtVYjVPNFdKV0R2Z1pZNXlmMGpwbkhMNS8x?=
 =?utf-8?B?L1haU0R1UHFjQk56MHRoekRWb2VLRU9JTXRVbkMwYXlyREl5R3Y0cmtjWHJn?=
 =?utf-8?B?MnAxZzNwQU9tc2Zza1d1OTBQb0NJaXpRSHhNZDZpeXNwd1Fmc3FtU2VtTGNj?=
 =?utf-8?B?d04vUFM5RThSS280cXhNNE9PaXcva05GSkxxUDc5aEd4TVhwZjcxK1haMktk?=
 =?utf-8?B?a1hiUHpsR3NOeVIyWnRwMHBNTEtveCtvQ2pYTFpwbUpJU0NCdFNtclZBeDVk?=
 =?utf-8?B?QWNpczQ4aERUWkI1clNoZnZOR3IrdTlUa0gzK3VndGg1aHRPN3QxL2h4bTgz?=
 =?utf-8?B?d04ybXBTTFpOd29vMFdpVFVzZWtlem5sNVhLeDZYU3FDeUFJeDVjdDcwK0FS?=
 =?utf-8?B?V0xieUQzcGQySUNxMTdSOUl6WkhucUFsUm41OGs3MTNFM0tFSXhGcGh6MVoy?=
 =?utf-8?B?bkNXTWd2WnN2L0IwK0wxNDNteU43THVsdWtiZ29DQXRwL28yYUV6dldsSk1F?=
 =?utf-8?B?MjM0T0NxbVFPeVVDbG1VeG1Tcis5UnZ3VGVGY3A0eDN6ZTFoYTFqY1FTZkhF?=
 =?utf-8?B?aHhBSHlsZ3lFS2tPc1U0bVJBQmdpcnNSZXVtL3dsdVRNai9jK1FDNDBSK2kx?=
 =?utf-8?B?Ykd1R000aGZ2VHhoVk1MMjZ0eng5RUxRZlp4SmhkT0ovWHg4TUFJYnFucDNk?=
 =?utf-8?B?R0xyeVRvWTRhUXZxSHBrQ2xHdDg0VTd1N2g1dlRYWEV0aGN0TVU5ZXl0b3hR?=
 =?utf-8?B?SmlCbjBNR2RLU2dlaGRMd2dmSTlnTXNrTmF5ZjRTc01QUkQ2STA1WjJhajcz?=
 =?utf-8?B?NVBaclgrWFQzbE9pRE5WZDk3eWFRa1lDSjc4TUZueUZqRlVFU25VbHA4VU5I?=
 =?utf-8?B?dkd6VmNxTWNTUzlIeUNxZTdJSUNia0RDMllubUNSdkovbXlwVk5Icnh1bFd0?=
 =?utf-8?B?RUJ3UEN5K05KMnBpZUtLTUdCWVpNczB1N1JTeVlNdDJENWkyOTRYK25tVWZO?=
 =?utf-8?B?cVR0dTgwc2d2Y245R3gvTGxCdlR0OUE0NFBkS3VGY2JDR3hvdHEyR2RjTENO?=
 =?utf-8?B?TTFHeElJdUxlWklMUHV4eEIyYS82UytVT1pWZGlXRU1xRW1GS3VNWko4ay8z?=
 =?utf-8?B?bGxYUXZwTWJ4YkRqK2diQitkZzUyVjBaMFR1bUJDMmhiMDdvNDV0WXZ5SWtG?=
 =?utf-8?B?RWloQXpYNFZIZGt6c1hsNC9yUTZ3dHVEcHFXeE41T0JXM1hOaFN1Tk5GUXMy?=
 =?utf-8?B?dGRmZ1RRZDZwWE9oUm1jOThDOFFsZWpHUVkySlhWRzNtQ1kxNGlEVzlMMjhh?=
 =?utf-8?B?ODRoTjQzSFI3aldwZ0Y0RWtGWkRhcUhHZVNVYWVQTGpXZ3hueGcrRytvQ0ZR?=
 =?utf-8?B?V0U1UU9pTm9Ebk0zVnJSK0w2SlN4czlsaUpFTm9qamMzVk1hYmN5VVNYRlpu?=
 =?utf-8?B?T1A4ejlwOHEwdlNzM2pnRFdMUjdYVkVpL3c4bXo2TGxVM05CaGpNdWliUFd2?=
 =?utf-8?B?UlQ2NzR4dFgrdG85dytPbStDeHZ5bDA2QlVmTFp5Y0gzT3ZHR1o0MnJ4VkZ6?=
 =?utf-8?Q?Z+c2997LjOjNUjrLh5rZ1qDCi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5064ad62-4eb7-4242-a799-08dd827aab7d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 15:22:33.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHIaJ79ydPEyvgIgGTN/zJsFqNQ7SAbMGgeknenMBsabkO8DUe9wnWmgye2AiGM/uWTcDfh+YTpj74j3WpBxhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574

On 4/18/25 09:12, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Disentangle the SEV core code and the SEV code that is called during
> early boot. The latter piece will be moved into startup/ in a subsequent
> patch.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

This patch breaks SNP guests. The SNP guest boots, but no longer has
access to the VMPCK keys needed to communicate with the ASP, which is
used, for example, to obtain an attestation report.

It looks like the secrets_pa is defined as static in both startup.c and
core.c. It is set by a function in startup.c and so when used in core.c
its value will be 0.

The following fixed the issue for me. Let me know if it can be squashed
in or a full patch is needed. Although, it likely should be named
sev_secrets_pa since it is no longer static.

Thanks,
Tom

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 617988a5f3d7..a2c984b31fc4 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -80,9 +80,6 @@ static const char * const sev_status_feat_names[] = {
 	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
 };
 
-/* Secrets page physical address from the CC blob */
-static u64 secrets_pa __ro_after_init;
-
 /*
  * For Secure TSC guests, the BSP fetches TSC_INFO using SNP guest messaging and
  * initializes snp_tsc_scale and snp_tsc_offset. These values are replicated
diff --git a/arch/x86/coco/sev/startup.c b/arch/x86/coco/sev/startup.c
index 9f5dc70cfb44..9fd5c28c6417 100644
--- a/arch/x86/coco/sev/startup.c
+++ b/arch/x86/coco/sev/startup.c
@@ -55,7 +55,7 @@ struct ghcb *boot_ghcb __section(".data");
 u64 sev_hv_features __ro_after_init;
 
 /* Secrets page physical address from the CC blob */
-static u64 secrets_pa __ro_after_init;
+u64 secrets_pa __ro_after_init;
 
 /* For early boot SVSM communication */
 struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index 73cb774c3639..45a7fc24e37f 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -5,6 +5,7 @@
 extern struct ghcb boot_ghcb_page;
 extern struct ghcb *boot_ghcb;
 extern u64 sev_hv_features;
+extern u64 secrets_pa;
 
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {




> ---
>  arch/x86/boot/compressed/sev.c |    2 +
>  arch/x86/coco/sev/Makefile     |   12 +-
>  arch/x86/coco/sev/core.c       | 1563 ++++----------------
>  arch/x86/coco/sev/shared.c     |  281 ----
>  arch/x86/coco/sev/startup.c    | 1395 +++++++++++++++++
>  5 files changed, 1652 insertions(+), 1601 deletions(-)
> 

