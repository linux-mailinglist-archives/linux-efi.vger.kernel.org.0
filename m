Return-Path: <linux-efi+bounces-4584-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5712B2F971
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 15:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB34AE1512
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8203231CA79;
	Thu, 21 Aug 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cMtzYLbG"
X-Original-To: linux-efi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B61F936;
	Thu, 21 Aug 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781224; cv=fail; b=PSTqju2wgRcUWQDbPVIuZlzQWdIRHsnv5fyx1cxQLvcY4ofnpyyueqw2+pleZUD1HSi5WW/6BBs24sc2hRimi1/FipK/0JbiUHiYEurBsfkDOK5TARbaDHyjbAtYUVK7LT9g80WgW28SBhjksl5UDcS42Bv726KbfEVQIwoKKMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781224; c=relaxed/simple;
	bh=JvJg21trKHPSzder3uB3A4sWXGhG/IzvRZqHSbjztto=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cMFQjG0xrSTagQcRIp4n/ydCpIZFNabB4I04+KN4/bMWQUw09Ruza1/XvOhYitTXPdf5q/hLjqQmDYn5dxF+4+qQYNIMzFiSLXUmqBde1HrB6ne1sRBmV1lHuvV4OYSFFAWsFMsOI/3cuAFo8h1JoXl1c3wqnKACljXBettZuJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cMtzYLbG; arc=fail smtp.client-ip=52.101.84.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMxg1Jhhn8Nck8OND3XCji5g8d4Y5nNHpazDgAes8y06BH9h2s3k3AlPthxqqo4I+ZCI0UPp3FsSy1BufJFS8XWOJ3r39V5zS1bs8KvUliLNTHH6jg7kgaH6Bwl4Ukl7v36HMUrlUE2Y3FZT8X4pXp+iTOxYTkyAY4Gx10NizJKs/rNjeccoUkNt2Je+L0Broe4KeVSRoE5nRAZrluBBS33hz2JX9TDLUrvAYGT6ZXVOJA8sNN0jHoHP4Xa3doO1oOM1550q0L0LQ1kcPPTE3ySycxPI2pU+TZWU/05yyiYQ/8/vILOpA53ui9KiC9Qlt8KxWg1UTPDagae7vGvcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vf241BFWI37pE7+KP/XrcwxztEjYdU+Oo1p0krERRtw=;
 b=F9B2ubxm5bn35WCt0B8GVWnc5MVrfq/qFQtim+qIl09jM/qLxEPOjmkkUIPt5F/iCQ5SG0YjD63UPo40pUNFjX4JFrzep7MbyL2siRh/g9aApys9hSTkNhSgOlzYfnNgNSqo/+wfMYsgpoRIOcE3C3/kmllIMxAa0uEyVfK0tp7cSuatBlVSq+lMS8XCcMQvmPaC5yqoB4nMuLr8+FvULyv6zMsZvlBo21XEmA2Tg717VeeIlNx+PBs3J6P116G3uJlNW5PPG54M9Q2NX4D561L/w8AWjrfK6R3DTCghrv5ixNLKL35iymQSqTnvaGrD9681lUx9lHpwVcNwE+M2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf241BFWI37pE7+KP/XrcwxztEjYdU+Oo1p0krERRtw=;
 b=cMtzYLbGU9c5lU7seuqrbHBghHzlrGrH9jmCCWG34vrzXlgOv0pCd6nVDoVvlJLTGNIAwa2+DmL06eXQxMS6kmUCQI5DYOcxGUIniFhi9Lu7jeH4g8GaK1bAn9g1OkVGbctiQS6vzSr60RblG651SHrynWyRsc3SO3XK3T90zeGnpUTcAeRmZUy8eb8j2hLFbFG1THHIbef3+59u4yw/nnUsbry0cjOJ5SPdq9q24wGC3MRb5BAf3m9i33cApjq77OhDd+9MGELIlSYu3Gsi86CCdst3vLP/IY1HeT6Wy8QSspPfQGjQ6/N498vaajVyBMPqmNqvoOAkIUUbYJ9qsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB5670.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 21 Aug
 2025 13:00:19 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 13:00:19 +0000
Message-ID: <3a9eb8eb-3420-4232-8259-3b33ed45dc66@siemens.com>
Date: Thu, 21 Aug 2025 15:00:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] efi: stmm: Use EFI return code of setup_mm_hdr
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <cover.1755285161.git.jan.kiszka@siemens.com>
 <c53346c183ce0c3d02322726ef5808f468441a42.1755285161.git.jan.kiszka@siemens.com>
 <CAC_iWjLMFGp3wg=59PruJQb7heds6CUcy8FMZ_cdT0b2vC5a3g@mail.gmail.com>
 <50f7f2fc-2c6d-4ae1-bbce-e132b1d9c9fe@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <50f7f2fc-2c6d-4ae1-bbce-e132b1d9c9fe@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:610:cc::24) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: a7059549-7211-463d-35e4-08dde0b2ae44
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnRIR1U4UmUyZjlxUUo2TUtzRWhHZWhJT0Mzcm4rekU0cWlGRUppUThxc3hn?=
 =?utf-8?B?VkJuNExBK2JkUjBMRkRtaUFtNjBhdEx0QkVPYld1blhHa1o2aTJ5R2ZLNnRY?=
 =?utf-8?B?bzJYTDMxNmRMdnRsZHlWQnZVd2loUHlwUWdwWWcrYTZEd2ZhTWxvMDRBdFJS?=
 =?utf-8?B?d2J6d25MZUxYZ3IxQzRLV3M1ZFRrbSt1V2dPSTkrR3UzQzhkUkxyUXZsdThZ?=
 =?utf-8?B?TzIwVm9WZ3RVMmFrR0dNd1BudFFvK011SFQ0OHNkNGhscGwvV3BxRS82RXFo?=
 =?utf-8?B?ck9XVytKQlp1OWJhdW9iUmVDTHd5Z0tzSkhCT3F6WlJOaU1LOTJ6TGRGbERL?=
 =?utf-8?B?eFdQZnBmZW9FMjJjVjZHZjFHL3NtaWp3dkhGK3FNTlhHcWUvWElmU3JMemtH?=
 =?utf-8?B?dnVsWEVhbHA2aGJwTVZqQlFGREtUS01aWXZyNGFvQlBsNDJyZnhVdzY4WTVK?=
 =?utf-8?B?NkZWK3crcTJZdWpkbGMyNW9uSkM2TWJkZ0pyNTlNdXdjMlBJRmRQdm5IU1Js?=
 =?utf-8?B?SHVUcU1xN252eUJNZXFUNE0wbi8zMmFqeTJaYWtFaHJZSjhDTGg2U2NpQ0JF?=
 =?utf-8?B?Y1hYL1UrSVpOd3o5MXBKTWd6YmxBOGtHcDBWb2hNOE03RE0zb1VOV29waW16?=
 =?utf-8?B?RUlqd0RSZzRWNHdINDArdTY0Q2dpM0pKcEZuWHowYVczQyt4VEo0dUdFVXh6?=
 =?utf-8?B?NkY4d3hGbjlZWUlpeEFheHpvUWE0MTRraGRocnN5L20xMnViMVJTSWQ4Nm4v?=
 =?utf-8?B?U2hueHFxS0k0Q1pUU1NKWVZhSVpCdGxZUTNMeVRFTzczdGdXMGI5VGNkTGw4?=
 =?utf-8?B?SjJrODdxTWhpRy9tV3RNQmlVMXJYMnlmelpJdjZHZkVRWjZ4VEtGTUY0am9k?=
 =?utf-8?B?bFZ1cytMeFEvcEZ5b0RRZjFienZuSDVPWmMvZVhzQ0xPenVnYVp0ekxIK211?=
 =?utf-8?B?Yk5TeG11MnliMHpYbmZaTE8weTJsbWdCS2NtMFpYMytQTEpqbEVuNm1ZMGRO?=
 =?utf-8?B?V0JETnErMlovazd2ckxvVDNpRWZFUDZERlBSWExCa2daNVBzUkVjMkN6VGlB?=
 =?utf-8?B?RmphNDZBdnFwc0hyUXZ0UnpsU1NnTi84anVlOTRMb1dGOU9ueGpXTllnb29j?=
 =?utf-8?B?S2JqS2pBRkdTQndId09IZStyNzI5V25wZWRNb3lZTVpyZ3dUaU93bTloR0Zh?=
 =?utf-8?B?YVJYNkhHUXZlOTduT2pGb21pZGRldVdIMU0yL2s1TXRGS2dGRm9PZHFEWkd1?=
 =?utf-8?B?eUdXdW1BTEJGdno4K2VFY2dUTEptNEJEcGYxUzBha3I4MUhlYmVOMzJ5NTcx?=
 =?utf-8?B?WWpseDZCckx0SCtrNUhqS053Nm1RSS9nc09kdGxTVHo2UllDQTRkbnFJaE1T?=
 =?utf-8?B?YjJXcm5iOUs4akVjYnhzWW9oRjhTOUNjaTFkNUlZeGk5WWJiOUh4KzYvM3dV?=
 =?utf-8?B?SnRSSnRjVE5RaU9YUzVlK1pncGtoekQ3UUFHVVRPZFkwcEhVZit3Q0Rvd1I4?=
 =?utf-8?B?ODBzWnZ5Y25XUWN5b1hoemRlUTlLeTRoME9yZWptaWtURTBTdHhaU1dtVDFO?=
 =?utf-8?B?VGJkcWg5Sm5SRUs5cGRuaTFXdVBwZFpBQUMrWGh3VU11b3JkdUZZZlBaNXpI?=
 =?utf-8?B?b0dJK0dURFN4SzdoY2oxYld5ZGc0VnVnQ1pVZkNBcnl5bzBRdENlaGFSK3lG?=
 =?utf-8?B?VWNMYW83RUxOUDV6ZWNZSzdIcjFHQjNmSFBGYnZMYytLM0t1aTZjSVdKMVJv?=
 =?utf-8?B?L3hGai9sRHplbEZrd3UxZVFyUUFENXNqaHdqN1Vvd0g4NlRUSmFvNTJhbGw2?=
 =?utf-8?B?bEJUbVg4ZTNmeFNiUlpCendJZ0FWZjlxRTVCTUM4bmJ5NjI4V3diOVJnZnVi?=
 =?utf-8?B?ZUMwcTJidXVoNnR0am5lRnVOR2ZnZDJ5ajRaWkoyYjRqOUhDUG9jWWxBbEc5?=
 =?utf-8?Q?hrdfVbe/xZA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUdzYmRCMXg3QUxKdE1ZUm4zb3FPcWJ0d1o5R3ZwQ25XeW5wc1JWc1pacVZ1?=
 =?utf-8?B?blkxWTRRelJ6d09aWEhiRStmSEV2Zjl0OTJORzZINWJYSWFrZkRBelFSOFZX?=
 =?utf-8?B?alhDaTlaaXdFQk9ZamtEbHpNeTRIYUl1UlR5ZTRhVzRBYk5DeDd6UVFmOEkr?=
 =?utf-8?B?ZmNPVmgzWko0MUI5ZXl6TFNUbWwvU244bE5HMDFvODcxaXJzM1lUa1gzZkhX?=
 =?utf-8?B?b094Q3RWVDN4cXIyQk1VM21MWEZRL2tyYlMwRjBNK3BYSi9Gb0dhS3hVRzR4?=
 =?utf-8?B?R2h2MEF3M0lTY1g0T21lbUtqdDkwQktUSDhsa0FTT1dNVG9YZit6K21WWlRS?=
 =?utf-8?B?NTh6Uit1Y3lTVEhVMnhrSXJxS0E5QnU5bHFHS0w0aTVLbUsrWGRwSVp4WTY5?=
 =?utf-8?B?RVpTMVJQUkJTWE9uMUpDNjVUK3BXbWYvdXlFUGd6cmRMQzYrZC80VGVsYm4v?=
 =?utf-8?B?YjN1V083djZzNXVYLzR3OGxnYmV5WUlXSkllbzR1QlZ2dHN1dHg1SmNreHNM?=
 =?utf-8?B?Zit6cllnTWVsUUF4Q240U084NWR2L1FpdlBtT1d6clVPY1BMN2hGaHVDUzJp?=
 =?utf-8?B?QXN3TDNqSHR3elNndWpJREFVQURQMU80N09TY29kUWl5YTBsYXJITGptSmto?=
 =?utf-8?B?RndFcHJHbldtb04xVFNkeEJvdWFGeWNxby9VQ0UvS0dkUys2aCt4eGxmTXBw?=
 =?utf-8?B?S2tzYkcvNGROWHNtUHZPaHRCbWpYVFIvM1RUUStqblB3a0V6TGdGdzB6Ry9Q?=
 =?utf-8?B?R2E2NGN3YUxobWIyNis5NktBazNEeG55bWZRUnJoOUI5Ump4Rm1MZ2pIV0hZ?=
 =?utf-8?B?eDUrSGdPVWpnUWJkaXNDTi8xY2lFNmhzN2VRalZNNmtKOVhMa24wTW11cXBZ?=
 =?utf-8?B?Q3BjZFhLcFRhYzMrYWlzUEtOS0l4aEt6WWl1RGw2V2tKTCtIVGduTGJZWFNx?=
 =?utf-8?B?ckVCM3Qvb05ld294S1ZidFFLVG1SandEMy95a1hDUnUwbkhaL1Q5Qkp4TU9n?=
 =?utf-8?B?b2dKdmZDSUlJbkQydXVlWGx5cVA5M3BFMWQ2RGdaOUM2Wk1XSTVNbEp0aFll?=
 =?utf-8?B?eE1JRDFKaDJPREk1bG5oaWRKMVBNeUZ1Zll0aFdabE5DelRGNnJrYTNuaDZZ?=
 =?utf-8?B?WWE0WENBK1dhWFVjU1pQRXpVNW9zWmFJTk12ZEh5RmVMVjdSTW8wYVVDa29P?=
 =?utf-8?B?S2QxcW5pUmFIeC95S2JPM1FmcWFqNDFJbGQ2TUlhSVZmYnJUaVR5bnhTclBR?=
 =?utf-8?B?cGUvQlBVZ0k5YWFMSzd0Smt5SnZNRGtCNHg5SWRWclBBZk1jOUgzSVlBSjZB?=
 =?utf-8?B?YVBHaGhEM1NQTFBJdVpJejR0Y1lwNkJiN1NXZkx6Rk9PbjJJaWNFRXNEcG5k?=
 =?utf-8?B?NWtrRXJsVGZiYzRMTmswYnIzOHVvWW9JQnNXSXBYU1JlZE9oaEUyZmZ4OGV6?=
 =?utf-8?B?cmZsSGU5K1FkcnhWU3RDSDBNVG8rKzlRdnQ2VnJ6RisvTjNCakRjT2paNlpR?=
 =?utf-8?B?SXQvZE9xQVBMYmFFczVwV2huWG1nUHhBTEtRV1hUOXBkcHR4Z3hYa1lzT0JS?=
 =?utf-8?B?dXduSGlVbWVrRk95d0gxWkpXRzBjeDRHQ2pTQ2F4NndSeUtZcTJpOHZwVjZp?=
 =?utf-8?B?bG5rNEozMEpRL0pvVVIxNGQ5dUo0eEJvR2VSblhqUWRYUEpPd3lIZGNWY0xD?=
 =?utf-8?B?V3dHcS9lOGpudkFpWllrWmo0akV4YXI3WUxHMXVPRHlrMzdRVHhKajFlVFp6?=
 =?utf-8?B?YnN6TFVSTzN2V1hUSTRPR3FpbDFaNTZkYTNJczZISWl6OFhncUs3bm5Zc0pM?=
 =?utf-8?B?WFYvTDBWMFRJSkk3am1RYmRQYkoraTdvQ3ZsVXBKYjNDbTlvRDdhQWh5QjZN?=
 =?utf-8?B?aVdHT0ZRV3JmUnhXZXFNQmMyb2t1OExOL3drYys1K2p3V2lHWlVlMFY0QUw2?=
 =?utf-8?B?MHRVNW9hdjhJVjNpekIzUzlDc0RONmhHY2JCRzU3aS9Ua2NYaUxqOTRKQ0F4?=
 =?utf-8?B?RHlnMGQySHVUYVg1ZDhrNzlqeUdjUEdEdGs1WlRFdzZiVUV6UlkxOXRMU21B?=
 =?utf-8?B?SFZ1M01UUFBhRGEwWVVLYWhwUHZYL2hzdFQ4d2RrMkVnMlhSUkpSdEtIVS9p?=
 =?utf-8?B?bVR2RC9vM21TMXQ5bmYwRzVtbzZnbEZPZDNFYUoyWjlxYStnMXZlbU1sVkNU?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7059549-7211-463d-35e4-08dde0b2ae44
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:00:19.2618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3z7yygR3hOa6CcKUfBH4Zzdp/PuPnBz4AgXEBnzY5n3KHSqfd288qID/tdAqXf2b1a+Bp9Ki5fxpKJh4buBF8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5670

On 20.08.25 16:59, Jan Kiszka wrote:
> On 20.08.25 09:10, Ilias Apalodimas wrote:
>> Hi Jan
>>
>> On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> If a too large payload_size is passed to setup_mm_hdr, callers will
>>> returned EFI_OUT_OF_RESOURCES rather than EFI_INVALID_PARAMETER that is
>>> passed down via ret. No need to fold errors here.
>>
>> Apart from not folding the error here, the current code kind of
>> violates the EFI spec.
>> If you look at GetVariable, GetNextVariable, SetVariable, and
>> QueryVariableInfo only SetVariable is supposed to return
>> EFI_OUT_OF_RESOURCES, if there's no storage space left.
> 
> And with storage space is likely meant the persistent part of it. ENOMEM
> is something different.
> 
>>
>> Should we also change setup_mm_hdr() and return EFI_INVALID_PARAMETER
>> always? It's still not ideal, but much closer to the spec.
> 
> EFI_DEVICE_ERROR? The "hardware" is has a problem by not providing us
> enough RAM. Yeah, not optimal either. But invalid parameter is clearly
> described, and nothing fits.
> 

If there are no concerns, I will switch to EFI_DEVICE_ERROR and even
drop the error "ret" argument in v2.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

