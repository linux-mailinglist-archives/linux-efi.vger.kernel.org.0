Return-Path: <linux-efi+bounces-3468-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7BCA9D09C
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 20:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A10F3B3802
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 18:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D629521767B;
	Fri, 25 Apr 2025 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1NkaQPT4"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192B9170A11;
	Fri, 25 Apr 2025 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606459; cv=fail; b=Eko1K4cHoxnRKVy2KikWEajZ3mjnO6CQdAo4JGXivaRUaMm4PXnaHP6VtT0kV7z4ZEm2FYqUDdjweDQoXVkwWfmVqDeo/hAmOMh8UgkM1j0NmdgSuuRncB5/jtwOANzIv45kkOW9CdEfpmEUwTz+ThzIO50o+L0mqV+Y4GGJ34Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606459; c=relaxed/simple;
	bh=ixU4qlVCcE/AHjbNFIAS2Ai5vISnWROOSAbwOWrxOYs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+iMornaWcIrnUGHjSRh6zxfQPrAtiLb5Z5wars6JptVNIbP6yPm1Tj8UcSwH1RSayhidufyFTK+SZJhF85NN8PutpAZBSdg4jfChJF7QjCvJib/NADlgrN8yLJGTb0iNuLmN2MPkQ+6kyyW6ML+ZcCBqkYUzpfIOM/QM1l48go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1NkaQPT4; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1yV5VG7PnhXZJMwX36YHC5+ac4wXv4JkdSSx6koD0MQadUaMmpmF17eofY9cwZyq7IyZNTXtTn7HxVxoqiD07w9X7Sm/0WCG6Xzs52LTRUNyo7jQzCqxUy8YGmxQYX8pCdx3H+kZcRvv7bJR+L8U1sr5Jvgmj67zDEhkOYF8kYWQOb6d5ySlR0Gm6+k9Hx3rrcJfFuW9QWBW71GI503pl1PpBqVL0WVJoT5vb4tjrpLqhMCxXBH6iyljyxWeUyoB6nguwxBPGgy+h/B9uTWZx/dDcyvlJfk8jKFTFGsZXZMXwd21txR9JomGzoDgAaoA9yd1XYSHfIKXrkODx57mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6PDb9VzLOxi1n+WwmqVlYLaHEmX0OuSD9haJn2AcOU=;
 b=rWZndsKkhTtISSr86tPQtcXP9878YCqa784RTf4TIkUYlFkzBxqJSKZKDKA0tV5X3XwLA6fj3iIZZfT477myPGZ+0N32Zg1JdeC9zxMssojs63dBWQ29IRM7iswEQbYK7ZlsUQTifBZH+RZe8mX4bfnDvLBBwuCMBU7I8Ca1AejQpEVI+fO6OMxNxVir7EhTGIPIRpZfj6CwdRRnCPuly3CVqt9ewJl8HHzouFpmCgHhJV635UQTBuhkHyj81x6k/1QW+wulzXcrsOWB3YCwiGI26FEOo+rCngguuTGH5EHypi7ejWWzruwjCuk022fPZJ9gOLcyu84go8lTvo8VXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6PDb9VzLOxi1n+WwmqVlYLaHEmX0OuSD9haJn2AcOU=;
 b=1NkaQPT4sEMF/fHjnM0544rs9w6VUQEVDYjJ+6zqaoDHiiC1JKUk7FCPmzciejdOiIFAfGWtDDABIYoie5iBaikmLrQCH+RmP6AZpTYRpxRv0fRRuW8/VIGVxuvSCkcFcBcNhvdgu5/EERo3CSjtZvEYsLlz13XtQoemhZIfjcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 25 Apr
 2025 18:40:54 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 18:40:54 +0000
Message-ID: <aea21a34-e393-0f50-006d-d88b3a4a7a94@amd.com>
Date: Fri, 25 Apr 2025 13:40:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/5] efi: Don't initalize SEV-SNP from the EFI stub
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb@google.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
 Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
References: <20250422100728.208479-7-ardb+git@google.com>
 <d00c9119-5e8b-2615-8e4b-2d25732ff71a@amd.com>
 <CAGnOC3b2XBFw+xdMhTtpfDYG480BG-KwfkPMWOiOP+13XeHFfg@mail.gmail.com>
 <CAMj1kXFCqLnWDw7hJVL9FShF9V=YZ_Ucf6jSSeq0E=BeuENdkQ@mail.gmail.com>
 <2294bbdf-7860-f6c8-0162-992ee79f4817@amd.com>
 <4ea54b5a-1a2a-8677-0bab-95a61f243a6d@amd.com>
In-Reply-To: <4ea54b5a-1a2a-8677-0bab-95a61f243a6d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:806:22::16) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c81144-8d3f-4fa1-2fe9-08dd8428b5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGdTYThEVDFVQ1RpdUp2Y2tnSDlQRDBEUzhKayt1V1hTNklzMXlhZG9UQjdL?=
 =?utf-8?B?bCtSbngrZC8zdHRyT3kxbjdhZHNKbTFkdjhnNHpnbXp1VjQrOFFyV3BSazlJ?=
 =?utf-8?B?QjZBbDlmR3hZcFlYeXIzUTBySURobVg2ZDlEWW4xdUxEQk5CblRUN2thRlMw?=
 =?utf-8?B?Z1lXQW5NdFgzWmNNelBvYk0rb1FXME9oVW5iYzJVWElHNFhiWDdFbWNLZ01P?=
 =?utf-8?B?ZS9FZTRCVm5pSHFEQ2I3VHB5cm1iUFJHbiswVWZkbXVQT1ZUbGxubzVKK09G?=
 =?utf-8?B?b1FXbjNJZTJ1OXNRK0lwYlZqVUc1Z25XRlE1dG5aWlhYenJiN2VpU0xqUFBy?=
 =?utf-8?B?eEJ1UlUzRFlsTmNhNG9HbkxOUmNKeENicXY4dTFtcUVQbnNzaDVSRVBBWFV2?=
 =?utf-8?B?SEFIWG8rb1hjRUMycXZYSkt5UFFrUUdXSFpYeXNoaG05TjNsakNnU2xTTHJG?=
 =?utf-8?B?THhXV2VXZkJkaDl2OExCdWtMUmpzVG9VK1pxekhzWC93cE9HODVMME9xbjdE?=
 =?utf-8?B?R3l3UU5SNHhWM0lCd2cweU1kcXRJQjUwTEl5VU95NWRWdVhoeDFkVHdjS1VO?=
 =?utf-8?B?N2VIajNyWkpCWUNTMWt3cnRkYVRhRGdjcWhNRlNlYjhiM0owWk1mc0svZjRo?=
 =?utf-8?B?ZmJYaE5FK0dySHRHYkhZQnZWOVFRTllvQWpyUE56OFBHZ1hHRGh3ODRNb0Zn?=
 =?utf-8?B?aklIOXpackg0aVJwRnFWc3FYa0pLaGpSSlRDOE5DRFdIYk9uZmdRdUlMR0lS?=
 =?utf-8?B?TUo4cnpLUmtRUHFYU2I5K2JTSmMvOHE1TmN2YmJ1Y3pFNUE3T3FQT0J1S01O?=
 =?utf-8?B?S3ExMndCR2J1NzF3aHphOXBOWGo3Y3lYMmNneUN0SjBPSVlxcE5mS0xqM2pV?=
 =?utf-8?B?UisrYUo0aUhJcXUrMWU2c1RTUjBrYitqYWkrdHRlbW5PMVAyOEZMbE1PRzNt?=
 =?utf-8?B?ZEM0RWRXYW1NZHJPYVJWZ092Tzg3dmxKd0xNOHduckEzQWpBTStTUjJtR0d0?=
 =?utf-8?B?bURjRzZYSnBxdGxZMlhSZlNjTFNWVzJoMDRYeHVtV0NiNERoNk80enNrKzBj?=
 =?utf-8?B?MHdFcGYrMHd2VzZEYjFsS0ZucmFFT0hCVnNaZURUK0xyZjB0dW90SElmbzlO?=
 =?utf-8?B?dVlER2w2azVBMHNCeDBUdkwwc2lzMmtjMmt6VTU2RkpFN2VDNW1XSU9ZZ1Fn?=
 =?utf-8?B?WE4vNFRHTGdKZzR1LzlTaEkyZ09ESE9rczdad3htSG9mYmRtMW1QMmVTUWw4?=
 =?utf-8?B?RmdPRHlGbEw4a3RiUnlodDFDTmpOYjJSeHBzT000MUZkMCtPUDNWQlN3L3VK?=
 =?utf-8?B?QkkvelZnbGRzN25YN1dxVW56QkNMeUNkV1hQRFYvcGJNZG9JcVdUQ1paVGIv?=
 =?utf-8?B?V3B4eW5OYldNMHp5Zk5oK1gvU3AzZVVVdXdtUUM2Y2NScHFTRzBkSWd3MjlH?=
 =?utf-8?B?ZHl4R2grMEd4bjlYRFREbkVoSEZmckgzbXdSN0FwRHNHSGM5clkrRjlBc3k0?=
 =?utf-8?B?NDhVWDRwdmFXN3ZHWUdGelNvQnJLUXVVazNtOGtSc1hjd0FtUklkV3VYKzh1?=
 =?utf-8?B?Wm9MSjlrQnVzdUU0MkEzZ0dmUURZbGZ4M0hpOEg5TUp3MGExOGpZOVlmQzJq?=
 =?utf-8?B?K04zbW1NMzhzOGZaN0F2WFA1NVhXTHdScEVUQkxrK3p3TUIwYnMyQTM0RWpL?=
 =?utf-8?B?VE94Mm1PNzc2Ym5wVjE5NmxuZ2ZSRHBFUkVGZ3dubUlzd3VnTmxTeW9XcEV0?=
 =?utf-8?B?UTM2QndacnpSVnF1NnV4aEM3Snd2eEFHRVFqV3pianpWM0VKVXdOZ2k5ZnVj?=
 =?utf-8?B?djdsL3dzY0RuTldtb2RKVEh1QjRJZVpFUXBMc21YbXh3b3Y5Slc1amxLTUFz?=
 =?utf-8?B?UGtaZFZiczhMcjhNcU9RR0plSVYxRkltNEg3K1RTRVM4cERVd0JhUm9BZU1R?=
 =?utf-8?Q?TWAmFiXcJK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGVJSGJLQlNDazVrczJhWnNETDI2cW9BOVN6eUxjSFlWSGpweGVqYTJycHhX?=
 =?utf-8?B?UUtFTjY0Q3VReGR3Q1RLRTNwdmpCVmNPZHoxVVp0ZkVadWVJUXdLUEorZ2VV?=
 =?utf-8?B?ckVkeE9OZUtXeTBuT09NRnREWVJ0dmcxVlV1WEYwV056bi9mWTh1TFU0eWNz?=
 =?utf-8?B?QjdhUHFLK0JncmorZEpKcXFuUnlhN1RRSmE2UUlreVpEUlp3a1FzcGNVUnAz?=
 =?utf-8?B?VkZFV3JwZ1dZMW1yOXVtMXpWaVFzdW1xMXNVL1dvTWtlSFMrTE8wOHNYN0Vw?=
 =?utf-8?B?bEtyd2NGYXBYdytVMXR6eEw2SkZCSVY1Zk83aWFGSUx5TWJXaXlNeTFpQjhP?=
 =?utf-8?B?WDRxRXh3OUNYSktoZTdOOHB5eXpKMldmb2ljWC91R09mTHhrVWFQanpIdnlt?=
 =?utf-8?B?WkZiVmV2cUMxRDcxS2tuQ0Z4S2lia3dLZmhmMzBWVDJaMVV4cXM4TGtNNjhC?=
 =?utf-8?B?OUpFQ3k1dEUvU1JLSXJZQlNWWDJac2huOG90MFFaUlZhRzNyc0pPNlJ1UVBL?=
 =?utf-8?B?SlBsdlRpMEtrOFdOVEdnQ1h3RHAxNlBZQTYzZlRpNHIwa3YzWXF0YlI0eWNF?=
 =?utf-8?B?VXhQTlJjTFJyM2kzclV5ajRoamhzTm92RExBa1FNVlBlemNyTGZqV3ZQQkpl?=
 =?utf-8?B?ckIyK205emdnREV3MGMwOXhTQkV6aEZjUU9rWUU5NndPVkUwQTNCbWYzaFhG?=
 =?utf-8?B?aDlKY3Q1K3pOck9jSEtQYjQrOHlsNTRpSWxkckVWZWRjbDdIZ3dIejdtSDVV?=
 =?utf-8?B?TXoxVSt5MnhnbTgrYlhqdGVDVCtLOHNPZkF2ck1KWXB2RjlDMjYzdW9nNTk2?=
 =?utf-8?B?RUptMkJFdVlmNGpNWkROQWVnMDY0UFlNWlVJMEZ4UFQwR1V6bW04VDZreDFT?=
 =?utf-8?B?aVRPZU92TXVRMzlEVU1wMFpUdkFvK3dIamZEMkZXN2IxREtUSXFzeXRpTzk0?=
 =?utf-8?B?dHd4TU52WHptbE4wVk9iSUlqTllqRHZNOEVJZVBPL0RTN3Q0RW5hNHJ0QXR2?=
 =?utf-8?B?b0k2NnVCNjkxNzZJcXF5ZjJOMjM5c1lua1krZXZpUE1wZVNwYmRTTTlNdy96?=
 =?utf-8?B?VVBBSCsyRDIxUnJOb0wrMzJYNDVwKy91Vlp5bXo0SEZpUmlsU3dZSVFSaHBT?=
 =?utf-8?B?V1l6bEpFS09JWC8xQldrdEszaGR0Rm9FZGVhT3h3UmNqUkg4ZTlMYWdHeXE2?=
 =?utf-8?B?YUd1OFI0N2N0cHd2YmU2TmMxS0djQVZvdTNJRXRJZWI5RUlTdTNIcjBnbmtU?=
 =?utf-8?B?OS9lYlEzS2VUZXBMVXM1K0FtN0Z5QzMrdzR1TS9sbCtmQmlHT3dIcjIybGVB?=
 =?utf-8?B?dmtrVVR3Vm1yTEZGVTlGNGVUSGtuN2xYY0FkR09maGo5S0pUSkZrNkRZNTZz?=
 =?utf-8?B?QlM1Zm5GQkZHVkpZUkJSOFZGUzJaVEYySHFIUjFTLzNwbFZyRFdRb1AyVHdK?=
 =?utf-8?B?R0NYdEY2QnRuTTA1VEhIekNtWk1LcmVzalRjK3d0ZkxjWWJsQTlqYVFNd0ha?=
 =?utf-8?B?Uk1FenRvSnZKT29oVjVTVWZORUxFbE15TWJVNVJ0cndNaUd5bFk5WWRLVUpM?=
 =?utf-8?B?WnlwUEF5T0hwdkxvYklHTFdZV291WW93dUhRM2M3Tk5TK2hURGVqUjhTckVU?=
 =?utf-8?B?VTRRUTFBeEdVem5SR3h5RWJYNEJHTzJnajVVSkpqZFdid3BxZndWQy9GMEhL?=
 =?utf-8?B?YjRrWmduQ0N1MjVVRzFmcXVGWTZqckU3NXQrMVV3dkY2Ukx6dmJMU3J2eTdT?=
 =?utf-8?B?aVFUdDBXTE45ZDJZSzZMUTFzUzNYaE9zQ2VrVWF6UGx0cDhub3pJZE1GQlEw?=
 =?utf-8?B?VHY1dTRFVlJteXdOeTFwRlowUGxUTk1LMURJNTNpcmNCbVFBSHU5b3NhSlMw?=
 =?utf-8?B?MXI3SmdDNk9YakxXTDRueUZTTDZXczBad2ZGMm5jRTlXWlhablB5S0RadzM1?=
 =?utf-8?B?VVdSNFloR1BYVzFIbHhkeUFZOHVyL2ZsbVdOUEFMRzdsNG55Z0dpVmNaaGhH?=
 =?utf-8?B?QXN2UXdvUVRHY0xyU2VFV3JOb3FqQytYN3lEdjlZUTV4QWJURXpZaUZGa0wz?=
 =?utf-8?B?Q2dmUnc4QmNFWGdocVM1R1N2SXVCdERpMkgvY3pPSk1MUlViR2xxMlIvOFRt?=
 =?utf-8?Q?juYYE0yMwUqDYHlGiZR3kqs7J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c81144-8d3f-4fa1-2fe9-08dd8428b5fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:40:54.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qDjnoFJ3q5b39eLlKzEbds5O4PjrGmN+34ZwFKEXcOVVFUSluk+3CYwmw58v2YoNfFMps8bqwCoBWbl2StuoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093

On 4/25/25 13:18, Tom Lendacky wrote:
> On 4/24/25 09:18, Tom Lendacky wrote:
>> On 4/24/25 02:22, Ard Biesheuvel wrote:
>>> On Tue, 22 Apr 2025 at 18:40, Ard Biesheuvel <ardb@google.com> wrote:
>>
>> Let me take a look...
> 
> Initial look at something like this works (along with the fix for the
> mistake I made in OVMF). I need to test the kexec path to be certain,
> though.

Ah, this version doesn't have the part in arch/x86/include/asm/sev.h that
declares snp_vmpl_checked as an extern. But other than that...

Thanks,
Tom

> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 478c65149cf0..d2f9cbbe943b 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -142,6 +142,7 @@ u64 svsm_get_caa_pa(void)
>  int svsm_perform_call_protocol(struct svsm_call *call);
>  
>  u8 snp_vmpl;
> +bool snp_vmpl_checked;
>  
>  /* Include code for early handlers */
>  #include "../../boot/startup/sev-shared.c"
> @@ -241,6 +242,29 @@ static bool early_setup_ghcb(void)
>  
>  void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>  {
> +	if (!snp_vmpl_checked) {
> +		unsigned int eax, ebx, ecx, edx;
> +
> +		/*
> +		 * CPUID Fn8000_001F_EAX[28] - SVSM support
> +		 */
> +		eax = 0x8000001f;
> +		ecx = 0;
> +		native_cpuid(&eax, &ebx, &ecx, &edx);
> +		if (eax & BIT(28)) {
> +			struct msr m;
> +
> +			/* Obtain the address of the calling area to use */
> +			boot_rdmsr(MSR_SVSM_CAA, &m);
> +			boot_svsm_caa = (void *)m.q;
> +			boot_svsm_caa_pa = m.q;
> +
> +			snp_vmpl = 2;
> +		}
> +
> +		snp_vmpl_checked = true;
> +	}
> +
>  	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
>  		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
>  }
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index 173f3d1f777a..5cca01700280 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -1342,6 +1342,8 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
>  
>  	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
>  
> +	snp_vmpl_checked = true;
> +
>  	/*
>  	 * Check if running at VMPL0.
>  	 *
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 5b145446e991..5011b3a93a21 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -99,6 +99,7 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>   */
>  u8 snp_vmpl __ro_after_init;
>  EXPORT_SYMBOL_GPL(snp_vmpl);
> +bool snp_vmpl_checked __ro_after_init;
>  
>  static u64 __init get_snp_jump_table_addr(void)
>  {
> 
>>
>> Thanks,
>> Tom

