Return-Path: <linux-efi+bounces-4259-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0EAFF021
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 19:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8FF7B43E7
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 17:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B06236453;
	Wed,  9 Jul 2025 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0l/bXm/H"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703F22687C;
	Wed,  9 Jul 2025 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083383; cv=fail; b=VqxhwHWAu0zgfgpuC4gkf9c1ovRzvDNW7zxGxGBB+AOPhosuvN1KlTYaq1V6+bKpMEHwPjiskOgRKRxHKvs0SvICyiTAfLbMnPag0v6ZQb6oris4RpktaCrgGr8kWqbnycpLI32KZ2OhpB/2t2dWHi+kR1ssixIsRPeqZoPCo5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083383; c=relaxed/simple;
	bh=op32t/PjgigaNAxNZYPYpWDOV/w1Li/vPfQZ3zZKCh8=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=jmuCQwNf7Be7p3T413iVxRvCXHBiCb3C28XLoK5qxCbSPSU6eskdFD5ZFrwpxNamt3wVruuWdYdrZr9T/WGxpRreIsbneCpQe9elvfN/D5MreBD7+yat7ZXIsCVTxM60fCFQis4K54UCb4I8K7et1D08AUnkyytp+l14B+AAV7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0l/bXm/H; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWowFFiWHOdPqLj6RLfCcCr4M0DLU+fD5FcOcd10alRvM8bUgr33s3cGudsnTK2yfnEt768H1Irzrwy0VqVz9Czx7ZNoQ+loRa+du+Mum2CkYQWFwdL12X2ebZKm2b6uDvlQp4zkL8hABCVnse87+DXV0ADUs5hbb7PzmzJQjU0NECn3P+dfRhmF3nJlEgh+chYNtz+gss/+85Y9sQjbbS99J5gyy5V38PXyAfOCA/KqwnqgOEIARQXdtHTcjACKXM89Xfserm3N0z51oqqVTDziuLFpqbpPxilvG5jdT08f4Qr6gdkB8l2QGWFEOWsSIKTXyjfXkAg7c7piF7V2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arMzKwdOKEogiZdbxV3io6rdf4+Ut69H6rUvb9C1qDM=;
 b=WC1Fmaeh+P95Dg3LMMGzlhZFmtqACDNpVMhEWN7i8WnzzVApRK2C8vC7hHe86FCkLHC4GKM43TdJySbHYqsQNBF3BDYgK5zVm0AGFgNmkC+3yAv2szQ34oHFn50VlwZjJqPS6FmspzzU7E7hP2LRIO6CrngcYfGfgUmgQ/sM8+87ptVaDbea9ryIHKGIQhr88gDdkvaZSTP50k6qkkPKmYl8FyAPGwVsl9TCsXoE3HR3xjd4mqSX0qhtU90tRGTRxBmNp3YKNmOwJarguB4Sqf0jarZSTriELSZWwfrPSQDsbHoyms63tXId7JwYMEzluDVkv1Yo9xQQZUHSITArDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arMzKwdOKEogiZdbxV3io6rdf4+Ut69H6rUvb9C1qDM=;
 b=0l/bXm/HgY/hnJ3Z5Dhp+nCf49xHi/sLYdJ9oCnnV7fh72nOWtSx3foMLJK3iFIwxPyh0gz6UTtSAa7kbc/UNVdtlLICNIRHF3emvl9Y3+4J7GpZlZOaGS+EMM1rIPGbHIlkXwUuDwboa7XyAmeJGFzAP7dFYejrn1wuAGuJcBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 17:49:39 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 17:49:39 +0000
Message-ID: <576ba828-14c2-4983-8c06-7ce2b3fb21d1@amd.com>
Date: Wed, 9 Jul 2025 12:49:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-32-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 06/24] x86/sev: Avoid global variable to store virtual
 address of SVSM area
In-Reply-To: <20250709080840.2233208-32-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:806:27::27) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc50df8-f483-4b3c-3688-08ddbf10f9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2dtRFpiYk9FdFhPUDBvZENTL0QzSVNHUjRPQStqZEhRRkpRdk4wWE1kOVRJ?=
 =?utf-8?B?UG83bzVXTWwzMHltL3p6WmpsZkdBM0VLV3dZZ1FWQjU5OC9TaUtXSEtnaE5l?=
 =?utf-8?B?NUd6ZStwc1FEa21DWHN2cDcya2VKKzJibFpzSFdXeUpIeFUrTlNsUVFuM1A5?=
 =?utf-8?B?b21Zb3ppSG9xaTlkNjdHQnp4aytQVUYwL1pVZzI5N25wTldGZ28yUTBYUjdW?=
 =?utf-8?B?MlJISlhpUmdjSjJYSmpGSjJpMVp6Sk56M3lCNlFvdm8wajVOZi9yK05hSFB3?=
 =?utf-8?B?dC94YnRIUmwyMHBTR1F5T0Q2a1I0MS84TTRZeDRUYXNXN3QwSjJXUXUvNnhu?=
 =?utf-8?B?TkJOKzgzWkJQOGtPaWRhMTVjV2RGaVZnZUpxbE1rOXNlM0FvdXJsUGE5QU85?=
 =?utf-8?B?bHdjaVdqakV5TE5zVnM3RFkrb0Q1bHRmTHd5YVBtR1o3MXVuNXpWbk5HYzV2?=
 =?utf-8?B?eFk5Z3VKN1J1Z3lHNUd6RnJPbE9SRk13eTZ6WnJrS2htQTV2NWJNZHRXWWVE?=
 =?utf-8?B?dDJKcVJ5NnNHL3gzS0xLT2NqYk8xOEpzM3RuTFN5T3dMTUdGVHR5emVZMG42?=
 =?utf-8?B?UGhwaVNqamVtK1d6RmpRdlVOTU9rcHNBRVZ5anVOZVhVZlFvdWtQYktOUHpn?=
 =?utf-8?B?aG1Qb2RoK1luV2F2SVRCclJGcUxQbS9hOXJCQmhGdXIxUFl2Um9HcWpHaVhR?=
 =?utf-8?B?ZjkyaFB3T0xveVU2a0wyR2dZL2pwZ2NTN2RPa04vOGtCZ1dNYnhIN3lWeksy?=
 =?utf-8?B?VGJxNkpIaTQ5Nm5URytyVEwzL2dYRmZ6WDFPWG4xai9jMDYxS0lMdWxGR0ty?=
 =?utf-8?B?UDJxZ2QzOTA2VGtGM2xMSXQ2dWdzT2FwMi9QVFlqVHhzSG1Wa2xDY25RUU1B?=
 =?utf-8?B?ZUFWL3l6WVMyc2F5aDVDeUJmMEpic2l5NW0rUGpWUEswWWxNZUcxeXhVZ1FG?=
 =?utf-8?B?cTNyT3Zlb1cvZHJUK3pXVlZheElrbjA1TWc5ejlVSm1kS29Pc3BCazhHTmlO?=
 =?utf-8?B?VnVUZENVY2dQY1pjcEw5Zmd6VFB5cE1kQm1WaFdzOG0wc0M2ellPOTFPOHNO?=
 =?utf-8?B?OGl5b0VYYnJ1akxQRk1CNnMyVzBubmZIeTRYNzRpS2tINXFKNkVzRXZ5dUVD?=
 =?utf-8?B?V2JQcTFqSlQrRnUxc2hFMU1qZWEwcEdSMTRaZWpXbmdzeE1aU2ZQcG9KRVpn?=
 =?utf-8?B?STEvZ1UzS0NsVFRsZVdlS1djOFhXeTdteEp4cU9GKzhja3NNRHhSMTM0dHpZ?=
 =?utf-8?B?NVloYXh5c2wrSXgxSWVKMkdLTmQ3eXVsaDZ4SDZWT3kyNWZvVkJWMzRtNEk2?=
 =?utf-8?B?MnR0S1J3WFNxZ243aUxhK3BBenhWbXdWNHJ0dTZJeUdjZFVSaHh5Z3QvbTRu?=
 =?utf-8?B?YVY2UnhRcGFYcGx2cm11eXhtdDFxdUUvRFpmTzR1UTRjeVZQdXdjYWkwSWJp?=
 =?utf-8?B?Y3p1NFFVUmhDUnNqQms2YURXb3oxMWE2NkhtbnloY3FZUm5xVWNHQ1ByUUxB?=
 =?utf-8?B?Z1dDN1dydjhpcFZvQWpHRmpBbGZZbUl0cDVGVDdSSmU4SENTMVZmM2xOdnlC?=
 =?utf-8?B?SllZbkI0YWhqQVNmaFcvMUlGTjNBeDhRR3BXNXN4NzBCSDY4QVpuMVNzVVVa?=
 =?utf-8?B?OXUveXR5UEQydk10UFZBSkkwM2ptQVJQc3NTaWZjcWZaVlNnUDJRUW4wckFN?=
 =?utf-8?B?dTJJbUV4aDN0N096eC9Cd1kreC9YeUZ6Mk9hZG10c29HNUdFTTBLaW8vMlpo?=
 =?utf-8?B?YVlSblJ0QXRENGVOZGdnbXlYcmMwMk00M2FRMlIycEUzeFV2OVhjaVYwenNl?=
 =?utf-8?B?MHlOcEdhTjQ5cXpkcGZiRy95UHBBbDRQaWYwUFNyemJ3SFhWZVovSHJySGZu?=
 =?utf-8?B?bnhxZWxacGQ1clUxQlAvRVB3UFN2dWNlVHZ0VWM3Zm5LMWttSnRvaDBLY2R0?=
 =?utf-8?Q?0NMRgp/n7jc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFVyaXBoZ1hVVEpPM0o0RytJY016TVpieTFpSXpKNkhuYzlpUmdob0FTeWJK?=
 =?utf-8?B?YnV3aHpTZnBLYjZ4cGFkenRMb3pmMXlUZVVxRDRwMVhSdGFXbVFSdTltc3lH?=
 =?utf-8?B?bkhYRHpzc0dMWkUxNEVOZGQzT0dVUkNQYVNmN2NTK290VTNsNmEyTE1LRE1i?=
 =?utf-8?B?MlVqNGJhRk1kMUVjVi9xZUNEQWQwUmh1ZGQ5ejZCTmNuUWJBekQ2VnFCTnJ5?=
 =?utf-8?B?ekUzeEdEbDQ5NnZUVXRWaGRxU1Z0RTNEVTR3TjdkNGxQZHRvdG1MM3BSazF0?=
 =?utf-8?B?U2Q1VWJkTVFlR21pbTdCY3p2ck5HSitFNFNCSlRVcGVLMmszVGVoUWxWWWh5?=
 =?utf-8?B?ZGtZUmVyVTh6Q3dIRGQxS0k2eFMyM3ViMVBTY25nekJsZ0ZyUnF5MDVpcHAr?=
 =?utf-8?B?RXZMcGdWUjRLQkpjRkpsOFpTcU12TE80M1grYnMrajFJSGJRT29zN05qaEN5?=
 =?utf-8?B?bndHaHpaR3JlWVlRVFpuKzJnWkswSEtkYnkvaGg3Y1dHUmw4ZC8veFZLWkJi?=
 =?utf-8?B?TE90ZmNTcEtVOVNNZXE1RWExQnVGcEdOWVNYM2x1RHRjeUVyZm9CT2ZxUDhQ?=
 =?utf-8?B?Vkd1WWlxbGxqMmlnTmhLVlJPZHB0Y0hKa3JCaEhBa2tHRFRzUmw2OThsYzVD?=
 =?utf-8?B?TjdrRGNZTit4Q09sT3I1c2QzNGJlVklRZWM4b2N6Y1BNaStOL3VVNG1mSll6?=
 =?utf-8?B?Rk9rNUpCTm02UjljaEFWcWQ0V2trdTJCUlFWUWtIaXQzUWdiZUo2aVJmcEM0?=
 =?utf-8?B?NElucXd4eU9uS1pFWmQ2QlNCajNLQmJyUmJuLzRwTTllbU4wQ0VQOW1RTTBH?=
 =?utf-8?B?SHVNaHg3eFV2VTFzZC9JanRhLzBZb0FqakZkTGpjdGVhYnkvZElHaXA1dzdm?=
 =?utf-8?B?dkVRVUhPdUEzVXBTMmQ0UTY4UjlneVArMmxhNFh3Z2l5WU9KaEpNelU5S2RT?=
 =?utf-8?B?ZWtjTlk5cE12NmthMzZkSmJUZnprTGF1N3liZ0wwMVhwd2lDK04wKzMvSzFD?=
 =?utf-8?B?S0tXN3VqOWFES0k0Vk83R0JEcmpkOWJwVlZDUDA3WFg4QURqMXRXa2ZzY0l5?=
 =?utf-8?B?T2hJaFk5N0ZQRU1seDNUc1hsWnBZM0lCQUxhZjZ6OVo1RUJZd2JBYnUreXpK?=
 =?utf-8?B?c212WitHV1YwYUZOc3VLeENYNm96TTVTT3haaTAvNjFvclpQa0ROdjZnbHlH?=
 =?utf-8?B?TmkvMmxCL2JPMmJ2WDlQK015aEpBaUdvd0N3bysvL2xTS28xZTdVSGFVYkhx?=
 =?utf-8?B?bTJrNGdtNDZwOVQ0R1c3bllXamptYldlaEV0MlJmUzQ0eXRlTmo3UFVnYzBO?=
 =?utf-8?B?RmNLS3hEeWVKOExLb3RhaTBVWk8wOVA1U1FscE52Yyt6Tm9EeFNaM1h1TmdH?=
 =?utf-8?B?dFhnL0xKa0pqN2swaW85cm1ZL0s1dVViSHFxYUdUK0RlbzBFU0U3eGdkbDRT?=
 =?utf-8?B?MWhzZThNcmRhdjFtb2ZlMlVGK3VYWmdaTGVXQzR5dFZOaWpjVXdzcWRqeitq?=
 =?utf-8?B?MUxEdVNnVFFtdFRqK1VuTURBSWVzMHd1MS8wajN0TDNOQWhNM2FzbERmS2dY?=
 =?utf-8?B?M0JzUExkRFNUMEozcWlud1Z2TVk5U3lNYkNJcFdQR3Y5dGhFc2JVeEFyblZP?=
 =?utf-8?B?ODM4K1plTkhCWjZmYnE3M0hhQjgyTkdpdnRlVUFkN29qR1k4WGpUMXRwdzRo?=
 =?utf-8?B?MnZUSDM5QkU0c3QrMUhuZUlwT3pQUjlPUVpic2xlNDNDR2VkKzkwbUNDay9P?=
 =?utf-8?B?NXJkY1l2Mm43aFJ1aEFTUWhxNzU1aG5NajNNZW5VK0trdEZyTmI1QXNRVXlL?=
 =?utf-8?B?UEQzNXg3VnAwRVpFTEdXYktkU1kwK01iendtbnNYZ1Z5dnlHUU5iVk4xTUFV?=
 =?utf-8?B?L2xBSUd0MnNkcG43QnVLUjIzRDNwdlVCSGk3Y2Z0aFFsK0F3WlRkekJvZjFI?=
 =?utf-8?B?VzBRZTdjM2JrdVk0R0hITEtPWXYxUnVwNFN5Z3J2bFZJQWErdHJIOWdhR0kr?=
 =?utf-8?B?NXhqWCtyTEQyTHlBM3VXZk55endZb2FrZFl2RnhOdFlqSnZFbUhnRG5EWTdQ?=
 =?utf-8?B?Y2ZLQUY4Qm9EM2l2a1FtQzE0amVpQmpYN0NLRTlySFdmamFpV0FVb1NMMWQr?=
 =?utf-8?Q?DflbDqtRc2gCBG+dViynZ87qT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc50df8-f483-4b3c-3688-08ddbf10f9e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 17:49:39.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZORax4qLaRr1/7iRQYZOlYtjEpK6USLUuWlQfC6B/G7KSABBSEfkG4Ju7W6gk97rjVcKEYnQ9euFMYUpKT88A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093

On 7/9/25 03:08, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The boottime SVSM calling area is used both by the startup code running
> from a 1:1 mapping, and potentially later on running from the ordinary
> kernel mapping.
> 
> This SVSM calling area is statically allocated, and so its physical
> address doesn't change. However, its virtual address depends on the
> calling context (1:1 mapping or kernel virtual mapping), and even though
> the variable that holds the virtual address of this calling area gets
> updated from 1:1 address to kernel address during the boot, it is hard
> to reason about why this is guaranteed to be safe.
> 
> So instead, take the RIP-relative address of the boottime SVSM calling
> area whenever its virtual address is required, and only use a global
> variable for the physical address.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Just a minor comment below.

> ---
>  arch/x86/boot/compressed/sev.c      | 5 ++---
>  arch/x86/boot/startup/sev-shared.c  | 6 ------
>  arch/x86/boot/startup/sev-startup.c | 4 ++--
>  arch/x86/coco/sev/core.c            | 9 ---------
>  arch/x86/include/asm/sev-internal.h | 3 +--
>  arch/x86/include/asm/sev.h          | 2 --
>  arch/x86/mm/mem_encrypt_amd.c       | 6 ------
>  7 files changed, 5 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 3628e9bddc6a..6c0f91d38595 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -37,12 +37,12 @@ struct ghcb *boot_ghcb;
>  
>  #define __BOOT_COMPRESSED
>  
> -extern struct svsm_ca *boot_svsm_caa;
>  extern u64 boot_svsm_caa_pa;
>  
>  struct svsm_ca *svsm_get_caa(void)
>  {
> -	return boot_svsm_caa;
> +	/* The decompressor is mapped 1:1 so VA == PA */
> +	return (struct svsm_ca *)boot_svsm_caa_pa;
>  }
>  
>  u64 svsm_get_caa_pa(void)
> @@ -530,7 +530,6 @@ bool early_is_sevsnp_guest(void)
>  
>  			/* Obtain the address of the calling area to use */
>  			boot_rdmsr(MSR_SVSM_CAA, &m);
> -			boot_svsm_caa = (void *)m.q;
>  			boot_svsm_caa_pa = m.q;
>  
>  			/*
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index 7d2415d690c9..7ca59038269f 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -26,7 +26,6 @@
>   *   early boot, both with identity mapped virtual addresses and proper kernel
>   *   virtual addresses.
>   */
> -struct svsm_ca *boot_svsm_caa __ro_after_init;
>  u64 boot_svsm_caa_pa __ro_after_init;
>  
>  /*
> @@ -697,11 +696,6 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
>  	if (caa & (PAGE_SIZE - 1))
>  		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
>  
> -	/*
> -	 * The CA is identity mapped when this routine is called, both by the
> -	 * decompressor code and the early kernel code.
> -	 */
> -	boot_svsm_caa = (struct svsm_ca *)caa;
>  	boot_svsm_caa_pa = caa;
>  
>  	/* Advertise the SVSM presence via CPUID. */
> diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
> index 050e071504af..8edf1ba78a48 100644
> --- a/arch/x86/boot/startup/sev-startup.c
> +++ b/arch/x86/boot/startup/sev-startup.c
> @@ -252,6 +252,7 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
>  
>  static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
>  {
> +	struct snp_secrets_page *secrets = (void *)cc_info->secrets_phys;
>  	struct svsm_call call = {};
>  	int ret;
>  	u64 pa;
> @@ -280,7 +281,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
>  	 *   RAX = 0 (Protocol=0, CallID=0)
>  	 *   RCX = New CA GPA
>  	 */
> -	call.caa = svsm_get_caa();
> +	call.caa = (struct svsm_ca *)secrets->svsm_caa;

I would be good to add an additional sentence to the block comment above
this section about how the identity mapping allows use of the direct CAA
value from the secrets page.

Thanks,
Tom

>  	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
>  	call.rcx = pa;
>  	do {
> @@ -289,7 +290,6 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
>  	if (ret)
>  		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
>  
> -	boot_svsm_caa = (struct svsm_ca *)pa;
>  	boot_svsm_caa_pa = pa;
>  }
>  
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 15be9e52848d..bea67d017bf0 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1643,15 +1643,6 @@ void sev_show_status(void)
>  	pr_cont("\n");
>  }
>  
> -void __init snp_update_svsm_ca(void)
> -{
> -	if (!snp_vmpl)
> -		return;
> -
> -	/* Update the CAA to a proper kernel address */
> -	boot_svsm_caa = &boot_svsm_ca_page;
> -}
> -
>  #ifdef CONFIG_SYSFS
>  static ssize_t vmpl_show(struct kobject *kobj,
>  			 struct kobj_attribute *attr, char *buf)
> diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
> index 6199b35a82e4..ffe4755962fe 100644
> --- a/arch/x86/include/asm/sev-internal.h
> +++ b/arch/x86/include/asm/sev-internal.h
> @@ -60,7 +60,6 @@ void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
>  DECLARE_PER_CPU(struct svsm_ca *, svsm_caa);
>  DECLARE_PER_CPU(u64, svsm_caa_pa);
>  
> -extern struct svsm_ca *boot_svsm_caa;
>  extern u64 boot_svsm_caa_pa;
>  
>  static __always_inline struct svsm_ca *svsm_get_caa(void)
> @@ -68,7 +67,7 @@ static __always_inline struct svsm_ca *svsm_get_caa(void)
>  	if (sev_cfg.use_cas)
>  		return this_cpu_read(svsm_caa);
>  	else
> -		return boot_svsm_caa;
> +		return rip_rel_ptr(&boot_svsm_ca_page);
>  }
>  
>  static __always_inline u64 svsm_get_caa_pa(void)
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 135e91a17d04..f3acbfcdca9a 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -519,7 +519,6 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>  u64 snp_get_unsupported_features(u64 status);
>  u64 sev_get_status(void);
>  void sev_show_status(void);
> -void snp_update_svsm_ca(void);
>  int prepare_pte_enc(struct pte_enc_desc *d);
>  void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
>  void snp_kexec_finish(void);
> @@ -600,7 +599,6 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
>  static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
>  static inline u64 sev_get_status(void) { return 0; }
>  static inline void sev_show_status(void) { }
> -static inline void snp_update_svsm_ca(void) { }
>  static inline int prepare_pte_enc(struct pte_enc_desc *d) { return 0; }
>  static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
>  static inline void snp_kexec_finish(void) { }
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> index faf3a13fb6ba..2f8c32173972 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -536,12 +536,6 @@ void __init sme_early_init(void)
>  		x86_init.resources.dmi_setup = snp_dmi_setup;
>  	}
>  
> -	/*
> -	 * Switch the SVSM CA mapping (if active) from identity mapped to
> -	 * kernel mapped.
> -	 */
> -	snp_update_svsm_ca();
> -
>  	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
>  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>  }

