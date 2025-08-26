Return-Path: <linux-efi+bounces-4611-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBC0B35593
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 09:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4833AEBD1
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 07:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D072F998D;
	Tue, 26 Aug 2025 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aW8Hx9Om"
X-Original-To: linux-efi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065C2F998E;
	Tue, 26 Aug 2025 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192994; cv=fail; b=uWAOI1pYcVxNRkGpAabgRmyg49RZD8ETAFGKyTngrQg2pmJDuq1gWs5wrTZ0Ya1I7N0XmVO0vfalr4h9XjNV1bcZ4aCGo1V/+kXskEndr9Yfvh+liAyfqPS6sVNsbO5pKsqYnqjfvy9z/lw9meVXw+l6U6nH73XjEIOrbDiI5dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192994; c=relaxed/simple;
	bh=sWXponsZLoCcR7fjbAdoiUGvtI8Rylt3k+eNPhPJ1TI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jdr+CpmYlQp58oVgxIrdBdYSXk3XEb7xrW36Z4xl44oBwfL24f8aKiAQ2uEZfRPGQ8nLRY0Fl7KIEbztlvxN92KcDxsazJLpchYM7vl/AfJZdvIgXE8NU7eb4kq6cDUL+78xub2o0T6upgvoOcuJc7ezomhzmen/gqIddxwmCgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aW8Hx9Om; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFlTeEgai/QUTiN1DihZGrn4dIhGZh/jH1xOKqX9K3NRa/xT74nrVLHtONQ9XIeoc6Iw2zS8AUnCHnp2F0V8nGsovTDq/QZjOcCklfMwcxRHL1cV46SsxXHx1bOZCmWfIeHJ5+/X6uua2SampWKMkdZvPD8skptIqKrw+KI6D1u/MTLaHIGUPoAj7R6Q6czvsrIV02vfjGHmBbz74ExJeVHwSP+2xGWlj6eM2gHoaOBEwLzRffNh4W7IaAnrUa9b9kq8HLmuSNdzKAznDYKCBozlbyA3+p5Xx7GR1XmRGqU04HO4gvA8HnzPsPxxL5t5Cg5ruK8YopVerSDcrI7+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxWB8Ktzk1GxmFxT1Tp3vknYNGtWbXFHT+NieoUpz3c=;
 b=lXCeUgyo9y6zqbAeTniI8NFrPpqr02PStSaJXFtBDMPL4KqRvfpJMELWdrF/qGDvao+tswddTck8/Pr+X/LflNtWUn2XkuoPKqHZfvJSBq4pOoeteLviIZWfazVFOEqh4dglPEbeSgmR0GTLoxqBFVZjY3d/3xAzY1p/LqNpznXmzx08zQFbWota/ZPCk1S71tAOUka5euC0zjzfkaJVOEYlZ2WHXt+sreLXh0++JbUgWf4DeOLLllli/BqCtQMnQXiMAAHs05h5BmsDJPQ8aOuLmKB6vcseKD/ehVXWzkUFB6Gs9foUOYCxpeeSt0mhYRMJEOYSnER3myDbn3CjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxWB8Ktzk1GxmFxT1Tp3vknYNGtWbXFHT+NieoUpz3c=;
 b=aW8Hx9OmpOcFBlDjvFpiGJ3RgWgv2SbjK9rQql0rkz6n8nW8lakbGBr0yHH7vVdI6zlHUNK8QxcMKReVE1JLAR7P9OKBTRVqOamSkSwyv5ZJMSx3NnbpJV0/i0BwIC7o/rnNG2Tpofzs81lP5EiP4uOFaFdkRlic47+vtuEeeRcyO247PsbzT+nAuj2ENySrsgW+TkDcKB4XT+vFwAm7e5Py1XH9xiZzMKhh6wp1eNASU+fkQyVxVcdoAPY+XG0pWzRYrst/NVu9rIeFsZP5oPNRU7qB9Lb1dUxra7biRbYU6DMCLCva/PUH8V1KWkeEELIUR5U6bSz+InEnVPjPZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:342::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 07:23:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 07:23:08 +0000
Message-ID: <2b7e98a3-dc77-4eb3-beba-3bea7febb715@siemens.com>
Date: Tue, 26 Aug 2025 09:23:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efistub: Lower default log level
To: Aaron Kling <webgeek1234@gmail.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708-efi-default-loglevel-v1-1-12b80db5af16@gmail.com>
 <CALHNRZ9T0dHzbXBUdBa4hE-Ao8ebeLLPRX+1ThkuLT+Rp8_Jeg@mail.gmail.com>
 <CAMj1kXEwyaHUkO5aO-sL3YAN=qRoSTuotHMRpBDLX9BhERnN=g@mail.gmail.com>
 <45692a2c-ba3d-45a2-9ab1-cf6982dbf788@siemens.com>
 <CAMj1kXG=zG8j+cr0gNMpkKRvdekqMR-EiEkMHiFgRvbaWy9aKg@mail.gmail.com>
 <09cb03e4-21f3-418c-98f2-66004cc3080f@siemens.com>
 <CAMj1kXHyw3Oi=c3p+7q75vD4iJ+x642JzL7zHM4jpF4k937Uxg@mail.gmail.com>
 <CALHNRZ8YUVvQ--Y-EfXW04WYXiKNsj6KSs-OaLMcEnG3_xDMSg@mail.gmail.com>
 <CAMj1kXE9tNa5R22M9NTmLY8qtnpxbvqMG-Cw0vFpVtr_KoM9bA@mail.gmail.com>
 <CALHNRZ_Q9XwJenTVDBdk4NQ79m2wWKRyxNS_sV1TLuqunE_NGQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CALHNRZ_Q9XwJenTVDBdk4NQ79m2wWKRyxNS_sV1TLuqunE_NGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a6bd73-7746-4677-e7f4-08dde471680f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWhmd1VPVzhWY2xZeWNyWkQ1RXdVQU55dVYwRGVucXQxcFRYZ2JEa3ZiOTlE?=
 =?utf-8?B?RDZxSDlsL0xvSXN3VnVVQjFxTURQL2NBQXpLdTNsdlhTdUFtamlyWVpmbDc3?=
 =?utf-8?B?eGcxMzhZb1l2bkQ1WTd6b1p4ZjAxQTl3ek9wd1RSV00vZW1Yc3FHdmg2L21W?=
 =?utf-8?B?QkNTcjExcmZON29JMU1iS01tOVVub0dtVjFUWXFWcnBDQklHUVNXL2wzQmpE?=
 =?utf-8?B?NkR5RkRzS09RVHRvL2hYM2dsbHhmUXRGUUJwSjl3d2VZazFaV1lvQ01aTEhs?=
 =?utf-8?B?MTB0MDA3ZkYydElvai9kVzFLQjhJeTBzbHF4M3NDYWIwWHFXU1pJWVhNbEFi?=
 =?utf-8?B?cnkybkNpeHhSQ1h5SXZKWmdnY2xaVVhBdE50dHZuL0xvQndKZDdaQmttbjl0?=
 =?utf-8?B?SDI3ZllxSXFZb0dNNFU4Q0hOT0ZpUmUvajJ6bG51Z1g3UHljbDNPTlZWNm12?=
 =?utf-8?B?TkhaekdzZlY5QWhSUVdWYnlweGwrVCt4MjVZWDFmZFhlWFF4dDU3b1lrd1JO?=
 =?utf-8?B?MStiQlJSSXVDbGx5Q0I0UWxIcE40endpcGhneURtaTBCNDN4T2w1Rjd0Ump2?=
 =?utf-8?B?T2VGYkFVUVlSVWxTNlFoM2RuRkdkMVlXSXcyYUVQWS9CNitaWnoyaldRam5k?=
 =?utf-8?B?UUFBSGJmTWR5VlhqbEROMTVDaHp2Z3NzcUV3NjMxczNUMUFxcW1RcmpubmlI?=
 =?utf-8?B?RSs2NTdTTFA4ano1ODFGakcra0plNW5pYUd4bENWdGVWUGNKWkVsRzgwZW0r?=
 =?utf-8?B?Nkl6M0tlOHdHZ05TN2lrbHc3VE1BTTRTWUFzTEN3NU12ZTlXcGtETDdEandV?=
 =?utf-8?B?aW93QWZGYndvd21LZEFTV0krNHFmbUNtVXczMkFjZ3JkOE1MSUkxSVE1N0xN?=
 =?utf-8?B?UlVMVzdRcnh4R2VaMDdsb0NXckViWmRENTVtUHl5WExkWDF3MzJVTHhNeUdM?=
 =?utf-8?B?K0k1Y3FVMDdua2VTVC8vczJTRzVtT1hhTnVrRjczMDlPZjUyUEVZNVBlZWl1?=
 =?utf-8?B?N3gzUGZRSW5yb0wvdHpGTkpWWHFZcndLRFV3NEJSbjhaRWlGd1I5RXloemVm?=
 =?utf-8?B?M1ZUdzFYVWVZOGpvTGhqTDdFbzBYOWJ0UjNvbElRSFFjV1djNk1YQlp4OGpG?=
 =?utf-8?B?Q054UTNuQ1ZMdFRyeStkNUJ2Q0hYZGZTZGFkKzgzZzZZeWQ3RUVRLzVnZVFa?=
 =?utf-8?B?OTJqT2NKNGljQ0xLRi9uUjE2cEIvbmNZU25DZWxWOVFLZ2srN0xnQU4vWkgz?=
 =?utf-8?B?eEZDT2NCSDFpVGVGeVI5NUJvSkV1bkMwQmdSS05EbDF2MUxiRWR4K2F6Vjl1?=
 =?utf-8?B?eCtucEViR2kzd3lxSzZaSkZNUCtMdGU5cWg3U2R5TTFpWGx5Y1FoUGk5VTc1?=
 =?utf-8?B?UjZWU09sWVJXOHh4N1owOFJsWVJTS3NVV2cxOXk1cHZsNGFDd0Q4Wld1bDBh?=
 =?utf-8?B?UVFldHNsVVBDNDBJYTg1bkY3Q0wxUmVzbmNHa3B1Z0g5U2JoSERqaHl4c291?=
 =?utf-8?B?Y1A2bEQ1SlpnY2t4ckFweGlrMDlkQ0lyRWR5V0JrOHEyVUkwRDN0NkY0cUp1?=
 =?utf-8?B?REl6eE9SZ3IxTVBUSTNsU0NWQWRYTUpDSjlObmtOSzdsc3FBbXVsSFhrS2pB?=
 =?utf-8?B?V0hycDE0MjdPRExDaEFZTlB0YXd2NWtJZGJ1dlVMUEhZRUVCWEFDejNTdkh2?=
 =?utf-8?B?WHFzVjlJOVl2U0RISmhuNFNTVUFBUUluWElGUHhNL3dvV2hEKy96K0hzM000?=
 =?utf-8?B?QU45SDE4QUlZQ3RDTHFmZE54eVpZcHE1MjJKQ09STGJCWTJ5RWc4SDEveEF0?=
 =?utf-8?B?Y1U5VXFJZ2VtYVdRK3JmNG96RHhCLzZxR0RkM2hiNmNmbVQzRVRNR3BHSi9T?=
 =?utf-8?B?ZFlBc3YyRHNNa3IzMGU1ZVk3RDVvcG9OeVNmSlJUSkdtZUtCNVNPWHgrMzhn?=
 =?utf-8?Q?knAbe84Gu04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWFwMzNZMEhwTi8zenM4c0dNRFV5RGRpM1JKZHdlZzZya0FGZEVoaTRpUy9I?=
 =?utf-8?B?MHBBR0pydWVsZGV4U0lxTHArKzk2bHZreFl2OHJ2by9LbjNiVVoveG5uUHBR?=
 =?utf-8?B?b1dxakhuSUdZQ2dFcDFrMlF6QWVINVJkNVF4UGtJM1hMVk5oc2hjQTRKZWll?=
 =?utf-8?B?b1NQZ2hKMExCWGxZaDBaWlZQOGlac3NyWnFJUWRVeWJ6cHZISnVGQW82YUZq?=
 =?utf-8?B?em05YmhhSlZ0RllMeXJmSU5qeVZISzRObGhpVXQvNXZSNmkrWmg2KzlEYUxv?=
 =?utf-8?B?M0t1a3lJcjZOTlRrTUJFMTNvbUdMK3JEZzkybmJOdjJaZm56M2NyWlFmV2oz?=
 =?utf-8?B?NWtXbEdTeG5XaHB1dFkxNE1MT3FTVC90MkF3U1JUaHM2dGY4dmRyblowMzlW?=
 =?utf-8?B?QWpoZ2w1dmFJekQrWk9RWmdad01HRmxpTzdaeVh3cGl3MmN4R0NvNVlXZUp0?=
 =?utf-8?B?K3dCZlo5dFovY3VTbEQ5TlBraUVIVUJwT3V2RjRHUkQzTlRFaXFHUU5VVHgz?=
 =?utf-8?B?U1R3eThDUHE5Z3oxNFRsbnlCSjFCUHRBT2pEQ29GNG9ubUNKRDl2NXhQNWFZ?=
 =?utf-8?B?dmdITklmeE9XTE93ckdQVmpsZVJBZVlGMlZnTzg5Rm9HSHRjVGtiMFJ5VmNU?=
 =?utf-8?B?NDJjMWE1TVhqM1l3NnNqdHpBd2ljZ01XNm5QcjNnZGhXWmRldHJwMG9jZkFG?=
 =?utf-8?B?RFlIbnl6OEhDcTdBWGJvaHpQZk1QUitHVFFqWXpsUWk3dndqQ05McmZFdWh4?=
 =?utf-8?B?andRbjEvSTVMSlpqTW5TaW5YQVVnN0VWQngyQVZVT082UUZLZ1cvMG13OXlU?=
 =?utf-8?B?MnNBa0JHbDUvbElSZVRTaS9GNDBaTkRXSzRTaHhjeHJHN2xnMGRBcWRNMmhl?=
 =?utf-8?B?T3YyQzdDRkFXRjhTZHVuZjl2Ym5oREZsTmFhZ2xNRUZBVDNxMEVwTEJOVngv?=
 =?utf-8?B?NEdUcFlDVnBadXM0VzdKb1FmZWk1YU9UVGtJUWxZVDZQNGhYMEI5Rlg0MlNm?=
 =?utf-8?B?TXpVRjY1U2FMMG9DV2Q5MnliNGlzRmFObWY3Mktjc1NNUnZwcklTUHJvNnYx?=
 =?utf-8?B?RkZaZ0cxb3hmSXpvVEJQb3VZWUZHWDVQUUtpSmVXZ29HZjR0RFR4ZlhRNVRQ?=
 =?utf-8?B?RXhVM3REOElsK2NhUGFSSXB0T0JzNHlySGpWRmRsUmpYd0x1SXBpNW1LMEh2?=
 =?utf-8?B?V3VvcVF2Y2x4QmdyY05RR1BJN253akE1SllSZFZjRnd0Tzh6QXdUdUM5cnVS?=
 =?utf-8?B?TkFHME5BQ3pBRFlSdVhrb0ptWGtEY0M0QXlPMXFObXhRS3pManVLU3lQcXNV?=
 =?utf-8?B?ckNsT2N1V1U5THdyclhCOW84Z1pldnNVRW9OOEszdWVkeXBveWlHLzhQR20x?=
 =?utf-8?B?cVZ1emUxQ0RCbnIrc1o1L3Y2WGVHaUZnWW9oRVhUZlRCVmNzVzJRZm02TTRE?=
 =?utf-8?B?VStTZUF2TkNiMDRrRnlZc2Iyd2QwOGFTR1V6c203dkFPN2NsbW1pMVNIbGhH?=
 =?utf-8?B?SDY1U2ZxNzcrQmd6MEZseGtUQitwSHZucWY0SmhDcXIvMUlzMUV3dURQMnc5?=
 =?utf-8?B?elRJZFg4WDNDNmVLZTNZK2pXekdobU9wRE1JSDBMb3dDUEJBQ0VkT0FWQ1J2?=
 =?utf-8?B?UHlNdXM4S2UydjlRTEdMaHFaVG1ZRDdBUkU3STNUZkphNmZBcU5Yd3QrbU5l?=
 =?utf-8?B?aERSanpUc3B1aW8xSWJuNnV5SFcvOTlmalFOUDExQTk0WnIwdjdnS2FEZ0ZG?=
 =?utf-8?B?ZWZldDhYN2lqTE9oVThZMDhVRG5YaVFaWmhhY0NCR1FCdzVHYklCQmsreUg0?=
 =?utf-8?B?YkNRdWw2QUV0NTFPbXhQTXJCdWJrUXQ0U0VpSmQvMzhsb0piUkhzZ1BXUU05?=
 =?utf-8?B?Z3U0d1ZyZmZzSGcxMit4bzZYTGg2V1JuYzJUMTY1alYxY0ZTVkI3QUtnMjVX?=
 =?utf-8?B?ZkdFTzlZcUIxN1M2ZkljUmJzR1gzaGl6RE1WcVBKek9WcS9MTC9PUDR0dTRN?=
 =?utf-8?B?WXlLbmhrbEkrQTE4M1ZvOVI3OHN5SmxsdU9taVMyRmdQMXlrU3I0dzhCWXE3?=
 =?utf-8?B?RTVtdTFtRS9acjFpazBpTkdEYlpob0lzeWkyOERhbUIxbGFJMllIM2U1OFdE?=
 =?utf-8?B?VnVkenkvSEZWTTFURkVmOHZwQTdaNWJ5bFdrOEJCT0VGRGJhSW1RcUVwajZC?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a6bd73-7746-4677-e7f4-08dde471680f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:23:08.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWJN4c0ebN1SpV3UD75wMVLVmMjNdZBiWI6awQ51MdAa6GfQUv7RHQLU4EwPxsYWIfuZVM2rpj9/2oRpeikXcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5170

On 26.08.25 00:09, Aaron Kling wrote:
> On Mon, Aug 25, 2025 at 4:28 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Tue, 26 Aug 2025 at 02:34, Aaron Kling <webgeek1234@gmail.com> wrote:
>>>
>>> On Mon, Aug 25, 2025 at 5:44 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>
>>>> On Sun, 24 Aug 2025 at 16:47, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>
>>>>> On 24.08.25 02:31, Ard Biesheuvel wrote:
>>>>>> On Sat, 16 Aug 2025 at 16:52, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>>
>>>>>>> On 15.07.25 03:35, Ard Biesheuvel wrote:
>>>>>>>> On Tue, 8 Jul 2025 at 17:31, Aaron Kling <webgeek1234@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> On Tue, Jul 8, 2025 at 2:30 AM Aaron Kling via B4 Relay
>>>>>>>>> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
>>>>>>>>>>
>>>>>>>>>> From: Aaron Kling <webgeek1234@gmail.com>
>>>>>>>>>>
>>>>>>>>>> Some uefi implementations will write the efistub logs to the display
>>>>>>>>>> over a splash image. This is not desirable for debug and info logs, so
>>>>>>>>>> lower the default efi log level to exclude them.
>>>>>>>>>>
>>>>>>>>>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>>  drivers/firmware/efi/libstub/printk.c | 4 ++--
>>>>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firmware/efi/libstub/printk.c
>>>>>>>>>> index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05dd746a9c54abbbe61a4bf70f1a8c4 100644
>>>>>>>>>> --- a/drivers/firmware/efi/libstub/printk.c
>>>>>>>>>> +++ b/drivers/firmware/efi/libstub/printk.c
>>>>>>>>>> @@ -5,13 +5,13 @@
>>>>>>>>>>  #include <linux/ctype.h>
>>>>>>>>>>  #include <linux/efi.h>
>>>>>>>>>>  #include <linux/kernel.h>
>>>>>>>>>> -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
>>>>>>>>>> +#include <linux/kern_levels.h>
>>>>>>>>>>  #include <asm/efi.h>
>>>>>>>>>>  #include <asm/setup.h>
>>>>>>>>>>
>>>>>>>>>>  #include "efistub.h"
>>>>>>>>>>
>>>>>>>>>> -int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
>>>>>>>>>> +int efi_loglevel = LOGLEVEL_NOTICE;
>>>>>>>>>>
>>>>>>>>>>  /**
>>>>>>>>>>   * efi_char16_puts() - Write a UCS-2 encoded string to the console
>>>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
>>>>>>>>>> change-id: 20250708-efi-default-loglevel-4da5a36cac87
>>>>>>>>>>
>>>>>>>>>> Best regards,
>>>>>>>>>> --
>>>>>>>>>> Aaron Kling <webgeek1234@gmail.com>
>>>>>>>>>
>>>>>>>>> This patch was originally suggested a few months ago [0], but as far
>>>>>>>>> as I can tell was never queued for merge. Since I'm also hitting a
>>>>>>>>> case where this is relevant, I'm sending this in to bring attention
>>>>>>>>> back to it.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I've queued this up now - thanks.
>>>>>>>>
>>>>>>>
>>>>>>> And how can I get back the loglevel info? It seems I can only choose
>>>>>>> between notice, silent and debug now. And the latter two only by also
>>>>>>> touching the kernel's loglevel.
>>>>>>>
>>>>>>> I'm particularly missing [1] in my UART logs now which is helpful in
>>>>>>> understanding this essential system state.
>>>>>>>
>>>>>>
>>>>>> Hi Jan,
>>>>>>
>>>>>> Is efi=debug too noisy for you?
>>>>>
>>>>> Yes, also because it affects the kernel even more. I'm looking for
>>>>> "efi=info".
>>>>>
>>>>> I don't get the reason behind this change anymore as well. If you have a
>>>>> splash screen shown, weren't you booting with "quiet" before already,
>>>>> thus also without any stub messages?
>>>>>
>>>>
>>>> Yeah, good point. IIRC that came up in the discussion but I can't
>>>> remember the motivation so it can't have been very convincing.
>>>>
>>>> So should we just revert this change?
>>>
>>> I'd prefer not to have to set quiet to get a clean splash screen. That
>>> doesn't seem like an unreasonable expectation, getting default
>>> non-debug logs and not having stuff written on top of the splash
>>> image.
>>
>> Perhaps you could remind us why this only applies to the efistub
>> output, and having the output of the kernel itself corrupting the
>> splash screen is fine?
> 
> I'm not greatly knowledgeable about the efi standard and what's
> happening under the hood, so I will just speak to what I saw in my use
> case. I'm working on Nvidia Tegra devices, newer generations of which
> use EDK2 as the last stage bootloader. The target os is Android, which
> has a pretty strictly controlled defconfig. Prior to this change, the
> kernel efistub logs were getting passed to the efi impl, which was
> then printing those lines to the display. The kernel logs were not
> being printed to the screen, as none of the console drivers were
> enabled to do so. So after this change, regardless of the kernel log
> level, the boot splash will remain untouched until the kernel display
> driver takes over the display and the os renders to it. Because no
> efistub log lines are being printed.
> 

That makes sense now, and surely don't mind having some build-time or
runtime configuration switch that allow to tune the system into such
settings. It's just not so nice to take away the freedom of full-scale
loglevel control from the efistub.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

