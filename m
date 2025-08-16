Return-Path: <linux-efi+bounces-4565-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA71B28B32
	for <lists+linux-efi@lfdr.de>; Sat, 16 Aug 2025 08:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD5958283D
	for <lists+linux-efi@lfdr.de>; Sat, 16 Aug 2025 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2B211491;
	Sat, 16 Aug 2025 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="R+/16kaJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753A1F3BA4;
	Sat, 16 Aug 2025 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755327130; cv=fail; b=rnBBhVcZS+2SbDqvm/uRiIP0I3+WTJ0CcHSX53xPxiPrRzFrFGSdVTEe8NgMU/+YW2Sig8EFZOWJVHZIXApVLuYcPA1i42pfsYeqHebqC+FBE3PzehUCqJhl+aqor21xEv1NT5xlmb3bv2SagBdqphZXDezeqOOYW1QIoMf6a+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755327130; c=relaxed/simple;
	bh=W3dwjaDsLKnb3YESYIwkbsMwI1SJv9mZU62Y/H63eM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bm1gL5ZMkbgcuBtU11HAnStREsLrNExqAdg8VERXjDxUBHerT2EU4tXpQG3DeMIwRGlSlX0/Q/UJnuVN2hSvkLThhUq1J39+p0LLJZCvH8TceYTI5U5uWjEbk9hteYb872wfdwQRmMDnptT0O5Y7mIjL3jS7hrXxBa6I+XbHgf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=R+/16kaJ; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfaROIkNL3qEgWwf9FfLn40xQE4iQJ/IEzQt6URZ7P89WZ0JpNHHBw3DUSrwmEA6jzU5L5jKwZ3Kv5mp8d+srwaiBOIdOG0yaHnIvlucI6KxrLWFO30KLYRwRj4L923q7Ewh6SiW1uWKKwMF5+eSO4edYkDMtUy3NCszJ+/AijCHxGuvsei1vSii/nvJf7SK/eOJ9+AtQg7NaqVhDjmarN2QCV5/XY5HoXIk3mGbD3/3vCXedJXsKi0n1ZxXrE/kqMIUVdJS7uIfZJqkjJGiYSYW2abL6sHjCDQXZx47WQMZecshk+HoH4Y7V0f0KxafAShVeM7YLbDsjq3gaIkceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYe8xaiLTrtf6L0NifXi1uIf2m6a5X1yT8Z0PpWKpgg=;
 b=W7hCYgz9mUY+O0Ckm+iMmSEsOeaw4dZYDROXVMVuTY2IRe4/BKohVT34b6Q1yPv6AWd+whAW9XA9D5VfU4jhTLjVw3W1+5bfbLtMVQECj3PiIsOrberIzDDt3XbsESeNB7+w8ikslpYhre+L9GBLkHcMuS6eRI5t3RD/Ju5W/CyDafMopJULgNPhRh+rc1cV9qgvmq00hYuGwZEbUh8otVUs0+mdfTMY28enZPA90dt5vITdQn8+zfuAH26lIhkBxiF5ZgdhI859TyfEQquHi6PLCmK7hFTrtzML8n2u3tcyXGlOVlZa5G50tJyc6ZsnJ0tbSwghfv8O11Yjk1Uy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYe8xaiLTrtf6L0NifXi1uIf2m6a5X1yT8Z0PpWKpgg=;
 b=R+/16kaJddBYHNmFjlbhONMHniNWhDVkbBNLOEndrLjTGjhSQITDHN0Et91FcamqsCMtl90U2vhKEYlPMMLfJpXLKLpgzV8B3+dq3hgDNG+fZIBNB3MwM/9dHCU569BXH2w9yiF0w7hUrpEYr/wrJPBM2Zud/4vRalur2Fhk4/N4O1EEJBP43XKrEW02ecicyPd1Hq3CrqpUWR0vSByB1Ce0BiFnHozJU0iHgNVRYO7h8hbY6Az345p5nAcKBBAH1507Xpiv6rsAb67vMJy1PVnY+rojcJWmmLvKBCv/3r6fubot+EdyK63hCHCG2zGTDt8/1Tc6ae1YtFDxaeIL9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB9PR10MB7988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sat, 16 Aug
 2025 06:52:05 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9031.018; Sat, 16 Aug 2025
 06:52:04 +0000
Message-ID: <45692a2c-ba3d-45a2-9ab1-cf6982dbf788@siemens.com>
Date: Sat, 16 Aug 2025 08:52:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efistub: Lower default log level
To: Ard Biesheuvel <ardb@kernel.org>, Aaron Kling <webgeek1234@gmail.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708-efi-default-loglevel-v1-1-12b80db5af16@gmail.com>
 <CALHNRZ9T0dHzbXBUdBa4hE-Ao8ebeLLPRX+1ThkuLT+Rp8_Jeg@mail.gmail.com>
 <CAMj1kXEwyaHUkO5aO-sL3YAN=qRoSTuotHMRpBDLX9BhERnN=g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAMj1kXEwyaHUkO5aO-sL3YAN=qRoSTuotHMRpBDLX9BhERnN=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::18) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB9PR10MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: c0212a3e-7ebb-44eb-880d-08dddc9168a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzVmZlRGNFZhWmlaSFUyZjllaDJ5ZnRPVHl3ejhwRFVDY0o2ZytCNUYzWHlV?=
 =?utf-8?B?ZmVRK3F2SlFWSjF2WU5kaHpyNGN2RVVWV3I5VWV4by9rRUFnTEFjNG00dWdu?=
 =?utf-8?B?Q1d0UWg5ait1UVlIQW5VMlJoRUdrWVRqeU84dTByZlRZL1piM1lzT2VoQjlC?=
 =?utf-8?B?SlRHdzhYdWk3N3h3cDZhZzl3K2l6STlNazgrYk8xVEFJT0pVSjA0OXI1RkpR?=
 =?utf-8?B?dzNMSUJuUGxWdUROQWtJc3Zyd2gzR3VXM21LS0t0eStUQU5ueTNhZ21tOG9Z?=
 =?utf-8?B?NkQyTmJzWm4reTJTU3g5M2hZaEd5UkgwTlhoeWZmUEROTDVjUGF6K0R4MFJw?=
 =?utf-8?B?R01zVUc5bzNBdUwyT3BET0dSTWRyRmJUTXVjMEh4ZENQV0dRQlZKRDhXbGRG?=
 =?utf-8?B?K3FUSEtjOTE4Q081aEI1eU93Mlg2WnZmMkladkJickxoc1l4VkdtN2htYk5n?=
 =?utf-8?B?anhmcTZuMjUvZ1VoRkNqaGNQSjJZL2dqM3lKWlU0cVE5NU9KZGhkcFR2NWFQ?=
 =?utf-8?B?OXRsOVkrZExyMEFjSS85dkIwQ0RGdGxVYUx6Z3lYTjN6Q3U2RkpuTHpVdzVQ?=
 =?utf-8?B?d2libkVUNlZFaWV6UTl3cjlZNWFIemRlRGg0OFdudVhOdTBlcEdvdHU1Qm4z?=
 =?utf-8?B?WEpaWGp1L1BVVmpQdGFCTDRaQytZbVp4N2xRcnJVbWt3TXVBOURSZ1hQblkx?=
 =?utf-8?B?dzRDYy93STY2T3FFb1d0bFM0SnM1aDE3SkN5R2V0SU5ib280V0EwWGFiNW83?=
 =?utf-8?B?YU05aU5abHpLUzNUSzd5RzdWYzJBUEliY3BhWXlOc09RTUhlVXh4ZjRRUWQv?=
 =?utf-8?B?b3ZqTFFZaUdJekp5THBXeXh5Yisrbm92aGpiaFUxK1VSNlhCYk5qMWE4dm1K?=
 =?utf-8?B?b2R6QVlpY21OclpTb2RFRkF5MnkwMjVEOExHSjlaK1c5cDBzYWk1QVZpamdz?=
 =?utf-8?B?Y3JJb0VXTzVzRmNvTXVvVzhYZnFmZXFjSjk0aXFUMkdwTkI4cnIrYlZPZjRX?=
 =?utf-8?B?TW1MRGVvaWpDNERBWHozK2tFNGlMRmQ0cWVJYWVJL2x5NXdNa0U5eUpXWWh0?=
 =?utf-8?B?ZnpXU2FxMVFSVVlua3I4YUh6QWZOWWIvTzkwdkZuVjJjR1pCK01hRVVVcEp2?=
 =?utf-8?B?Z0hNNmcxWE1VTFJ4MktsTjJLSDdvSURUMEFJcDhoQmtUNGphaDljS1UzRkVi?=
 =?utf-8?B?Yms2L3RJWU85ZFNod0cvVWpjdzlMa3RDZSsrU0p1SmtuUXJ4T3BwWVEybEEy?=
 =?utf-8?B?VS9xUXdqSXlmamNSendhaE9rSFJXbkpVakxFNzl6cG10cU54OHF3eEtjVzV0?=
 =?utf-8?B?d2dCeVA5enlldkJCMG9pZmp4cHhIeXdnMnE1S3krR0VkdzdFQUpqVjcxTm93?=
 =?utf-8?B?aE40NW8rOVdxVG16dDkxYXQrbVBLdEdZbDlYM3o1UmdHd1RQeWd6RFhKRkpF?=
 =?utf-8?B?WkIrd2ttZ2s0K3E0dTUrMG5mczZzRjZta2NpeDBIRkNwRVprU0gxWDNkamlG?=
 =?utf-8?B?eXBQOHBPQyszUXpDemRCbUR0SGNLMTVQeG5hSmxaRUhnVkpXNTJaczhCUHo0?=
 =?utf-8?B?ZGVqeTQyeEpuYlBRUjdzdThxRFdNNWtxZHZhbVZBbnBKRCtEb0hScExtU0Ux?=
 =?utf-8?B?cXpvMXdSUmlSMzBkUjJFZnFXZ0F5elpaT2NKZ1RmL3ozZXlnSmtia1UrN3dH?=
 =?utf-8?B?U28raFNrQTJkMTA2bitDa3JjMFdoendGaWFiZnVsL1FtZ3VVTHV3ZUhFSVRR?=
 =?utf-8?B?WGFoSVhVODFoQ3cxOFhGbHN3bkRqTldqQTFmMEtUdkR3ejczUjRBQjljeGs4?=
 =?utf-8?Q?RMciP7qjAo5DzNAvEAfWrd78bOuGkN8K5VJyU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzZRZ1B6Q05VOG04dCtTYkIvY1VPMHRPbi95dWdBbmpIQmQxSlZUcDRrVTc5?=
 =?utf-8?B?dUJzV1RMQ1BrbUNiN2pFdXJkR25vbTR0ejNESkczOTlGTDdKcTAvVi9HMWxS?=
 =?utf-8?B?NTNvM1ZoMmpwc0daQ2hSZmVINUNtZVpIWFBMK05ESm1QRHUxcW5BYm5wMkNh?=
 =?utf-8?B?Uk5OM3NaRkRIN1JWYzd5Q1NhN29XRVlFaHBzVjk3ZFRSVG5ldXUxc1ZnQUYv?=
 =?utf-8?B?dlBFTzc3VW5mL2ZJZXBlVWJKVmFnMW83SHlyZWp2bHlSamVLOVBicWRmTVhT?=
 =?utf-8?B?ZWZYYmlLWTRWNzFvdEFnc1lBZG1YZzZFNmVJRldRY0FqRVc0NHVhbXhYVldz?=
 =?utf-8?B?L2o5UC9NbkRqY0VQK1F5VUtTRERSbGd1WTNjNlErVmRyaTMyRkZlS3VyVTd0?=
 =?utf-8?B?eGF5dlVQYUcxODZrZGZwWlJKTndMNC9WWExwZWZLMVBNOGh5SzQxZlVGcnVW?=
 =?utf-8?B?d245UTRVdFREWnBEMEJoQ09FR2hCOWZNWTVvc09aVVBiYXNKWmdhYUZyLzNI?=
 =?utf-8?B?UGN4L1kyNGhOQk1pYjVyYjN2RHFzakdVbzRrb2R2VlZZL0JVZUZDbXNzRjZ0?=
 =?utf-8?B?czMxcS9rMDZOSFFWMDcxN0R3V0gwSFBrSmJJd0JvcmZUU0hHa3lNZUdQelVt?=
 =?utf-8?B?OExUeUVRWExqMXdkQTUySktQNDZtS0RNK3Q4WjhvSFdhalN2eGRSZjFITis4?=
 =?utf-8?B?ZlVYZlgwTmNNYWs0ZlZSY2ptYk9LQ3RxV282L01iQU9RZC9OclZsTkMzc0ky?=
 =?utf-8?B?NjErbWhla2ZvdzAraWdBRy9IQ3g3ZzR1aVFvWmdGRXU2cjdpVVZVL3JQSE5x?=
 =?utf-8?B?K2RkNnUwalM4dTRWM2hjdGh4QVF5Y2N0bi9TdXpETHZmUTE3R25rK1hmUEov?=
 =?utf-8?B?ZlBBTGNQUkFQQmZJMDd6ZXlyZ2EvTXF1R1lkTkdDOUU1YlRCc0FMYitVcENl?=
 =?utf-8?B?SmhCdklPSWh0dGNSTEZkUUthU1MvVVRWMElEN3EyN1FoR0s1QzdmVTFDMkFP?=
 =?utf-8?B?YW1PN0JLL1dzbmlSUnYvSlMvWmtGd0l6RVhrczBtaHRLbXIvS3BWV0ZTeWlP?=
 =?utf-8?B?V2ZZOG1kU3JDTWdYQkdYYlN1UkU2RUpCNFVQS0JEVmtjdk1lOVJRNW00L08y?=
 =?utf-8?B?YmxIaDVvUldnbW9FM0RBR1JtZ1kwMGVWR1NQTVExdjQ4Ykw2QTlDRHdReFl3?=
 =?utf-8?B?RXRWbElFM2M1T3k3NllrUlNVN0JiTHRLQ04xR3NEN1ZmelJua1lFdlNGWlN2?=
 =?utf-8?B?TFR3RWhsUm1jWGdBTEp3VThVazlDK2pSRUNSTllZOTFFMzViUEVuYmJzZnBx?=
 =?utf-8?B?eXdNQnNXWGQrY2o2dThuNDFjN254SVFqQ2ZydnlpbUlVdlhsMkRRdVVpUjdk?=
 =?utf-8?B?SUZITnBQbW1hUDhacTlZQUxVWlNTYno4N1IzaXAyMkFnbXp4bWJJZjNkUmY4?=
 =?utf-8?B?eGdMRjVzSi9LSmtZRnA1OUg3Y0dZb0JmMk16QTVnRmFrNHRYTi92NndPT2Rj?=
 =?utf-8?B?bGxtQ3dyWXVQM080ZnVTVmtIRVNieUlPVEx3RUpHbkQxS1VWSG96L0RINmsw?=
 =?utf-8?B?RjI1YnV5TXMrd2FjSTZ3V2xXYjlxNUIyMFFnTFhxWUgxOFppYU5HckFZUXNZ?=
 =?utf-8?B?UVNXa1VTRGpjSjlLamJGeTQ2RHJVYUU1cWw5TVhYalliODJkY0t4N2hlQzVy?=
 =?utf-8?B?Y3pacjdwSm1YajBiL25pSWhsYlJaS0tjOTgzVUJnblNrYUQwd1UzNEJXQVNL?=
 =?utf-8?B?Y1ZucE9RWjBqdGNObm1PY3hLNUVDaG5qMVlIQ1RNbWxSSmt6bzFUWkdzcHpY?=
 =?utf-8?B?V000WHhyRlFIQmcxNDNzeHJzZ0VBVEJFYTZmVnRIVzhWY013WEVKRC9vWWNp?=
 =?utf-8?B?UmtXcHdPekpaZXJ0cjBIK05OY0FrN1NQa0xmOHgwUjkwSlI3SmhSejJXMUxF?=
 =?utf-8?B?N2xUa1NCZ1I4blVGVmdoaVpTQVZBdjQ2bVd0MDhhNXk3VjYrNkkxRmVXZWw2?=
 =?utf-8?B?ZG05REpUdm01ZUxHRlpBdFdyclorY29vRnlLdWYxQlFhR1lUUXV0bFpUOTVS?=
 =?utf-8?B?T0ViOVc4UnRwV1RZZDhnYWE2Wk9hQTJDc2YvQTdUT2JPL21vOFoxRDJHeisy?=
 =?utf-8?Q?qfDv/hpGaft4sqlj7ntOhh9zS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0212a3e-7ebb-44eb-880d-08dddc9168a5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 06:52:04.6993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6U0IxWzLRKVQA4oE9vQ/U9BDWs0fmgizXda6cIrU6pf9hElJzZI4aG30SxJG/Zb2901U3D/aXSmeJm3q4MSGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7988

On 15.07.25 03:35, Ard Biesheuvel wrote:
> On Tue, 8 Jul 2025 at 17:31, Aaron Kling <webgeek1234@gmail.com> wrote:
>>
>> On Tue, Jul 8, 2025 at 2:30 AM Aaron Kling via B4 Relay
>> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
>>>
>>> From: Aaron Kling <webgeek1234@gmail.com>
>>>
>>> Some uefi implementations will write the efistub logs to the display
>>> over a splash image. This is not desirable for debug and info logs, so
>>> lower the default efi log level to exclude them.
>>>
>>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>>> ---
>>>  drivers/firmware/efi/libstub/printk.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firmware/efi/libstub/printk.c
>>> index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05dd746a9c54abbbe61a4bf70f1a8c4 100644
>>> --- a/drivers/firmware/efi/libstub/printk.c
>>> +++ b/drivers/firmware/efi/libstub/printk.c
>>> @@ -5,13 +5,13 @@
>>>  #include <linux/ctype.h>
>>>  #include <linux/efi.h>
>>>  #include <linux/kernel.h>
>>> -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
>>> +#include <linux/kern_levels.h>
>>>  #include <asm/efi.h>
>>>  #include <asm/setup.h>
>>>
>>>  #include "efistub.h"
>>>
>>> -int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
>>> +int efi_loglevel = LOGLEVEL_NOTICE;
>>>
>>>  /**
>>>   * efi_char16_puts() - Write a UCS-2 encoded string to the console
>>>
>>> ---
>>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
>>> change-id: 20250708-efi-default-loglevel-4da5a36cac87
>>>
>>> Best regards,
>>> --
>>> Aaron Kling <webgeek1234@gmail.com>
>>
>> This patch was originally suggested a few months ago [0], but as far
>> as I can tell was never queued for merge. Since I'm also hitting a
>> case where this is relevant, I'm sending this in to bring attention
>> back to it.
>>
> 
> I've queued this up now - thanks.
> 

And how can I get back the loglevel info? It seems I can only choose
between notice, silent and debug now. And the latter two only by also
touching the kernel's loglevel.

I'm particularly missing [1] in my UART logs now which is helpful in
understanding this essential system state.

Jan

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/efi/libstub/secureboot.c?id=dfd4b508c8c6106083698a0dd5e35aecc7c48725#n60

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

