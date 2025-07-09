Return-Path: <linux-efi+bounces-4256-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B734AFEEC1
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 18:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F2F560681
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6221D2E612B;
	Wed,  9 Jul 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JKzN20Rq"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1148F40;
	Wed,  9 Jul 2025 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077643; cv=fail; b=Th0ZSNGm7bKbxzMmWZoFuOdcDwPn/AzwrkGA72F0X5TYBTxrkslTXbFaCGQL3JWGOwMCjGepIQdHIzw2UGszb3xy/XieryuvFEXy68fZv91ClIYHhZMl7701v3dBreS9WXanHkI3P9mmG5y2jy3o/4zeAh/O5M3xdQoeGwGheW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077643; c=relaxed/simple;
	bh=m8qzZceCDpsqgJdupZOrMfDu5EsKAvUIh/y9kZ4jnuU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OmPae6Bz0GU1DaeH/dlAv3rCflrqmG4cl8rkedbk4Kz4EjqShpdTwRG3hxb8TPi7ItY+qLfeHrnz7yj5FPFD3/4JpUEPgyCcOKpC0B2IGl4xXa4dGIHK+zJPGqaF0XToKKFuDD4OeUSMQ/dqVJMCij7Db0PRpUaISUshnaKbnvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JKzN20Rq; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxtnJbeDFrDHb931yG/Hv+TsSiQgm4vlbivMYiDt0mpYjdRZAafAgVAc+DU8HYmPeZJ2HT0604noIAzht0rwOOXUzJeLTNPZHAbPjcyw72EDBApVbAS1WFpvx8TnLr6yv9PaVwQyTea3eORjCiVjONOtYRc8sdXurismKQb8uXukajEKCoXo/JpHqKxzXMK+6MlMqSz9tllln4d3xsSHvIcO8TkuIY5m+K9RdKx2Cek+EvlI4mWibsFM2iwfGRkC91ElilDln3Zl6AfL4+Ciw/Nbj+azQwTHAgt0/t/E/vjMf+gzm2wxPK+PszVHiIJ5tKjex7lYW3GKRVQ/MxhKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuTAVHuyh3Fbbb9ubeado/2N95hCRAcCDjHeN0R1J5M=;
 b=SiyArpUSziatRNRpCDn7hmstKnwAWqbda075mE4DjQ92AWYV8NuQTB76Q6yS403RBzldD++b251rGuMRQ5Toq2SKjFYuwR3BxuEjzN/0GXlzuJoff9sV4jvLydbHnWb4OlnXhchbcOz7cOVdDx65Y3pUA1HlFTJP2UWEsVaFzmn3IlMUp56W+Ez5QFzMwTDtKCm3lybQoZNs4dEsctMn/pg6NEqFH9cpqkrN5mnrd89iGVYxP7vT3fKUqQ4dVGFvhGPoCnqf7LPWwAbFVIDsxhXgMyNiCGLROMaeTfV6UnGTiEgL/tMBcVLCFKO4aGgCT8UX+A+C7ZFITw/5A0NQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuTAVHuyh3Fbbb9ubeado/2N95hCRAcCDjHeN0R1J5M=;
 b=JKzN20RqrEeADz8PhGnKwEPuTtbtXc8ae0WxZs7vdw9lUcP10opFBnf/Yi+M3ruNdt/y3Kq5P3nA8rxteuIkIlG2yVhryI1hbw9RSTXhnprTiaxf3oLRTeZxo+ltxNZVDTIPlZqn6TMYkZZ/Bz7gT5yETwvT60r+MMK7Ed5j8iI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 16:13:58 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 16:13:58 +0000
Message-ID: <4b50e347-fedc-d94a-9670-a5003220db57@amd.com>
Date: Wed, 9 Jul 2025 11:13:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 04/24] x86/sev: Run RMPADJUST on SVSM calling area page
 to test VMPL
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-30-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250709080840.2233208-30-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::18) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: f69b5ee1-eb47-4ce5-9d52-08ddbf039c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzBOWGtYbTBad29ocmpyY2l3c0Vhbjgrbm00SWN4dzVFYVIzQkZ3cjE3eUpX?=
 =?utf-8?B?UnlVNGVDNUdlSWYyNzhnMUFiRGc5bWxDeUx0UnFCVEdEdVZoZUlwcE5zRDlw?=
 =?utf-8?B?TTljdzZsT1Q3NDR2b2FOYUJLTThRdUZxcTQwa3JWTHU1Z0lDVGpRLy90SmV6?=
 =?utf-8?B?TUNBb2tFd2x0WDRuSGx5UGZGcHpKN3NQbUc1ZEpuSlNDbXdoYittT1hScnRD?=
 =?utf-8?B?dFE2cTllNWpWQ0pyZFVwR2Rac2dpV3JYSmpTR3BuSG1leFBnTUlwRTNRM2dJ?=
 =?utf-8?B?TzRqSVc2LzRnY0RiNmxtbXpIcEYzcjcyb3ZXcVN3YVQ2c090ZWJSZVRUQjBY?=
 =?utf-8?B?MngvUTdoamsvM3BzR3FNVE5RVGxmMS9xM3hQOHlMSmJLUUpUYzhZcDUrMEZv?=
 =?utf-8?B?U1YzNmg0SkNVa0VtUGw1UXVjVEcyTzNGMWVhSkFJaFhIcFdKSXBibVZDY3lB?=
 =?utf-8?B?TXA4VHhZNldjUFFqRlBkbWo5ZEk3b21IYmdwTEh3TWFWbjE1em9qSVpPUGxr?=
 =?utf-8?B?OWoySDdaWUVYODBraU5vNHRhSlJZQkNWNnVrQldyWWNmQnF5TGh6UHp3L2NV?=
 =?utf-8?B?WGZENkF3SjgwR0RBek5KcnRaNXZlRkZaaUV0bDVCSk8vMDVqalU1QjNodWNO?=
 =?utf-8?B?aDdpWGlvaGZNZFNjaWh5MWNDNU9vMzhkejUxZ0NZYjQ3RnhoLzVhb0hIcWNI?=
 =?utf-8?B?NnhyK0ViNGlYbTUyd1NsS2lyS0YvWVJBbEZWb1VRNWhjQS9WczJGczhPYnFh?=
 =?utf-8?B?RStOWFByS1kwZFhQeEh5djhCWVAxekNBRGtoakgxRUZlVTVRZS9McE5XeTJF?=
 =?utf-8?B?REhYdGNLUUdvNUpoTWhoajhqTjFmclgzL3oxemlGVU92eGNlaVJrb1cxMVJw?=
 =?utf-8?B?THNrZ3p1ZkQ0QjVNSnh4NVFSOXVvald6K0RZVEc1eURpNllHRk1rV1JZbGpW?=
 =?utf-8?B?ZWNickhCcURnVGJQbmlNMG0zNUNweGNpVHQwcEY1MjljZzJLcmFwbXdlNFRB?=
 =?utf-8?B?R3MrRVZPRkJjVjdkcDZJWGlobnd3RUNqcVFSZDlZNGFGUHREWi9SVXNBZHR5?=
 =?utf-8?B?enB1SExSY1NtUllnRU54ZWoyenRHa3JpWGpFcmVVdHIvL0ZpVHh1Q2gvTWdK?=
 =?utf-8?B?b2RiN0lwN08rT2gySmhEOFl0b2h4YXAxbElDb1RzeHE1YjVvMW91bnc5MFVa?=
 =?utf-8?B?YzM2dzI2RUx0WGtQdU1qTDIwRGVzL29vUFdTMWJLNWlXbXBTMTkxOTJ4QkNX?=
 =?utf-8?B?dnBDUC9FZDE4bVROdG13YWRiWCtYR1M2MFAvRjlNZ3I4bFB5K0hzK2RZaVlN?=
 =?utf-8?B?NEhjdnZTaUFndUhaOFE1cVZhSVJWTllhSWdGZ3VZOHVLa2lqenZLN0djbkhM?=
 =?utf-8?B?ZmFxbjdieDI1MUgzWnM1WFNzRHkrUlc0TDRkVnE5bnFBNHp1UFp6NmdMcjIz?=
 =?utf-8?B?SXA5UTZPOUZYMEhKS3MzK1BYQWJmaFhXdDlLRW5NclM3NENBNWVKUlJnQVJO?=
 =?utf-8?B?dDk3WjAwV2htcjNpUityZHhPZldKTUdVOUg3elJvTHJ4K2o5V1FWU2VVSTFs?=
 =?utf-8?B?YTVLNnpiNnFCbGZzSVJuNHNMR1QzSjRueWdGaldnc3BVeVJmYmVxK015ckZn?=
 =?utf-8?B?c09Wc0wyUFlZZGx0RVJzU1VBTGJoQVJyVk5TZE4wZk1HdCtvL24zTTdRYzEx?=
 =?utf-8?B?RkQzTDZxMCtxL0pmQVFlcVNuanRGY29EYUI2c1B4SHVaQWV0MWJyaldqcTdk?=
 =?utf-8?B?K01VQTU5dXBKblZhRDNxS2xBL012MWROT2ttN003UDBkbjMzdXNCVFdLQVR1?=
 =?utf-8?B?QytyeHhKcFVUeTVGN1ZCZ1hsaHczajNCUWxadkhTSmdUU1hqMFB6K1h5VVVW?=
 =?utf-8?B?d2FHZDkreFh2TDVjeGp0MXJLRS9ZR1l0NkkrZkpXQUlzTWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG9tMjEvYlFFWkM2NHVCbjdwUnI0M3hROC94ekQwVllRZHVpWmxQN3M4TzNx?=
 =?utf-8?B?Z09WaVVLZHh1WktXV0pNcUVaeUlrZ2xyUTB3aThDdFovdnhmN2N5WjM3Z0lo?=
 =?utf-8?B?ckROOU1wRnVkMW8vQkpBQ3J2UytrNUtBMmdvT2E1TUhiUElQWlcvdk5NWXht?=
 =?utf-8?B?WEdUSFMxNW4xRkNaaFQ3dVZwYjlPVVk2VG9DMkZQU0lQNGhTOGlJR2tWWkRQ?=
 =?utf-8?B?S1RURm11N3VXYlcvZTZ5RGdtTVk5SDhoYmphaGFTNkJvRS9maWlhaXp1TzN1?=
 =?utf-8?B?V0lBb3d5dzFYOFJzblpGWjRmNEZmNXdYVGZlM0lZUVZVTUs3bElzcUhHeVRy?=
 =?utf-8?B?OUE5bFAwZWhoUUoxWGhpa2hLY1phVEZBL0FaVURJTHVCWDRpeDhZWXBDc0d6?=
 =?utf-8?B?aDZlUmkrRVE4em1hUk9rQndadzJBbldPQktLQzFieHFSTTRLNm5OWjZYd1FQ?=
 =?utf-8?B?UzlIQzBudzNNcU5JTEMvQ2ltQlkxYjJJTmVyaDlHVUJnc1hrcWF5MnF0Tk1i?=
 =?utf-8?B?ZUdubFh1RGlLSXVRYWYreXFOVEE0SUc3L1V5b3d3YnZQZFZNSXV2RG1vSDh1?=
 =?utf-8?B?ZFI3WG15Vkl6cThGLzE4S0VQQjRacVFvdm5qM250alNpQWV5YWREYUNkcmwv?=
 =?utf-8?B?enBZUU9pbFZheThaa29hOTg5NjQvaDI0TWdJV08rWk1LNG5mU2JoVEJYNFdE?=
 =?utf-8?B?OTVpZTdKQUpuSGtWZzEzVjA5QWYwSG9acUVBSGdXRDVJVjc5S2tYL1BJUUls?=
 =?utf-8?B?U2JDSjVaTHpPRTlaR25zN0RaOXAzTnRXQklzOU5POStWc2pWdXdhWFd1U3Na?=
 =?utf-8?B?d1hxc3VXbmxPM0dBSXJnQWlCZUpzNitYTjR0NVFSWDBzbDR5Y3FQdGNxWGlV?=
 =?utf-8?B?MWh0WlVHc3hqSURYdWcxY21Fc2RSRzBrZGRFRG01cVVsYlIvZGk0RWpTOXd2?=
 =?utf-8?B?Qy81WjByTUZydWNpQUNvVlFHRTJJeEREZFNDR0diZERTRFhXMlNZWmJrcjRX?=
 =?utf-8?B?QlZJOFJIY3RXM0ZKZzJqVmpweFVVU29iWWFpUGZQbkk5Y3dVOGExZXFzTjFv?=
 =?utf-8?B?d2xSMUxFdVdVRmxzUkVJQ05KMVdMOFBQTzRnRjdZSi9veWd3bkIySlV2UDIx?=
 =?utf-8?B?MXoyZ2Q0bmxFcWFyU2VqSHBwaUR4VUdRclJ4enBjWldyaGhKT29BS3Nac2NB?=
 =?utf-8?B?MXE0ZEpxUVFYZ0ZTblZ4ME94L0RYZENEVmxIckpBK1pxaXg3ZmNkTCtuRUYv?=
 =?utf-8?B?K2s1UGlDTlM0T3ZWcVVkb1hEUFlDY01kRFNPeTVFUXVQL0FhVlkyNVdmc3JN?=
 =?utf-8?B?UUZKK3hxODQ3NFN6TkR2d1lWSVk0Z1U5NlZ2a25tRVg1YTlYWTQyeXpxcWZD?=
 =?utf-8?B?UmtWNDNMemFlQ3p5NFI5c0ptaWQxQ2ZHeUVoZWlCWkhlMEh4Qkd2cnFZRWhm?=
 =?utf-8?B?OGhGUCt2UWRQSzRuOHM1T1JDN2xtdlNzbkFtWkRtSW9vTjFEUU1ST0t3clJm?=
 =?utf-8?B?Q3hRU1VvNHk0YVlkM3FITEVsd1ZnbDhiMkcxYWlqdVBSVTh4QWpqSW51bnc4?=
 =?utf-8?B?T3M0MWVsbEw2Z1djZEU4ZS90SnRFZWNwVEhscE13SEs1b1NJaUZkOE9sYS9P?=
 =?utf-8?B?bHZoNGs4VHZHazZzYnhnOVN4UG1wTHNpUzZxaHEvVVlFL1lKMEdyZTQrRVhS?=
 =?utf-8?B?S3Rac093cExmY0phT2RhZEV3YzVsUi82UTZjNTFHWEJIcTNCZDNhYlJMUFpG?=
 =?utf-8?B?bHQrZkRQcDJDclh4bE43QlYxSTNSbk9Db1ppSGg1T1ZmL1N6WnlXTnN0RjJU?=
 =?utf-8?B?L25ZeW5jbVlreERmdzI3ekNRL29GM08rdlpzM3R4Z0NTQlpMalI5L3FrQnFU?=
 =?utf-8?B?M0tSSkd4cXJhMTl2K2FjUmNmb0dOckVjY0lzaldsdkUyR2NBSDJpejR1d01p?=
 =?utf-8?B?Ym1VMHE0cFdBQWVRa3RBMnlGeDdaSzJLNVJ4SEQ0L053UkpOS0hGUXI2UDZy?=
 =?utf-8?B?cDJNclIyOUU5ekVrVHlSK0svdG5sYkVEQWVhQ2lZSmZ5Qk5uVUxTN0VOSDVY?=
 =?utf-8?B?S09hTGFVMFIvMVFCckFuMjAxRG04eEtLRXZOQkNzWTNiYW1IOUFEV2lJZERh?=
 =?utf-8?Q?vYqyuFTHHblYBW6GVv6JV3i4v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69b5ee1-eb47-4ce5-9d52-08ddbf039c14
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 16:13:58.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgGp3rCCcF0Hyt73otl5WprJLC7ju/Po1BoofP0d4XK8ngV5JrUnPdCY/vYfj4qwaOJ+UXh68/yTMKnmy1eRmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570

On 7/9/25 03:08, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Determining the VMPL at which the kernel runs involves performing a
> RMPADJUST operation on an arbitrary page of memory, and observing whether
> it succeeds.
> 
> The use of boot_ghcb_page in the core kernel in this case is completely
> arbitrary, but results in the need to provide a PIC alias for it. So use
> boot_svsm_ca_page instead, which already needs this alias for other
> reasons.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/boot/compressed/sev.c      | 2 +-
>  arch/x86/boot/startup/sev-shared.c  | 5 +++--
>  arch/x86/boot/startup/sev-startup.c | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 

