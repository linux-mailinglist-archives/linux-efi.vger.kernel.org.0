Return-Path: <linux-efi+bounces-3331-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C3A88BF9
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 21:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4ED3B5B37
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 19:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E028BAAD;
	Mon, 14 Apr 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JzhxK6dn"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE0D1990C7;
	Mon, 14 Apr 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657836; cv=fail; b=TTTzkCSOH/u3w5vTUZGrdEJY1mgtpJIRkwP7f6pfzONkQJtaRK8XecZH/YK7onq4o68Lhi+YESjvLUR/bWlh2fMLyQ3Q4y1BApJuvAnm/aYcJrg101nn321wwv2/kEbmLJjCqWhluqURMNPDqPfK0K7ldelWj0fDHgLsomU+I58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657836; c=relaxed/simple;
	bh=Y9lii8ZZzOUEkxBx0WDmvZfztXG9aDQ4RYU6BmQFSdE=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=MltpBz9HHn3+L7tGEhrpIQwH9gViTjaE2PpndPA/laVUFYRAfm2sZWrBSu6lqt+c+bb6IyNqQn2ycYw80wvsSjVOmR3izHMI5xKqugiitbrcWqz9jga2NkH9QxbkqWYViArpkV9toGFiaOubaJnbVtd1Yf0BgxBt5YZprDhnmzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JzhxK6dn; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hk8Z4mtWEZSfsQdFBhsDeevh9io4TSav0SDfZ8k+w35KQLPsw2zLJ91YaOGL4jlh9+5LCNNEufx4Q3RUEQDmhNYg9Mu9wmOMeOl3TW3OI339IL/81IdCGB6JPqWs6KspMdiDhvMJ0hfbxYCECYeUkkdTsCiqddivvgwIHHsZSIeEvteoTuu5ROd1I7EK9sSMNmOb9hHUnXoWmi+KHuLnH9DTf4cav62FFSqAYREMIRFXi/68ptlo2OM/mbSUa5bPJsv+NjC/fe1fUhN7bTDeC7qbZawAClz/2R2xZ7Pp4GnSrSyaXib1vrf/yclWu43crPW1W0KTzrMs+kDsQLkJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ/g5MN9Vf9jz1qt1zE+rJ+RxPEUaPrBTNNVz+E+jbc=;
 b=das2X1mjOpZs8IoepFkbp8gHanuwjjAulhFMQq0KufXW63APrQMoZTYuORkC/xin4zSnc/uNkkNc19RRHyXDmFeRFcfgVV5FRcFKIMvBiRrf6S33kJGYjyJz/Gflc2Y5NfjAj86HnFXuCYW/YFSOt1VwH6P5PxzgxwoX10GW2kTxx2cs1cMRGUEUrIaka3kjxZTvaPW3cZytMPo5PjXCgSorZP/WVT4kjmpTP71g8tIpJmMNHeUGhDxIPcQPuZMf22DCukEvf//6sOBeSIxJWr/MtKfn6W2BdI3F9zEtxOtNpMpuxOygbcuuyetU+4ZI/RZAdxkguE2V9p+pMsy6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ/g5MN9Vf9jz1qt1zE+rJ+RxPEUaPrBTNNVz+E+jbc=;
 b=JzhxK6dnMHDnD1mjiqGcerpeKxbb9NhodCzxsUslFNsjdRTFHX5TPFLm1RGTszSCIPwxiYrsd8xr/yRqV7HoE6h3FAQgBJc9NehOEitHj7Wdrd+uGcewB9OWmg7d4VbLjq6d/QbLR25RO42B1rMyu30gFeAh5x8pbkoUJ+3kWVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 19:10:31 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 19:10:31 +0000
Message-ID: <e48bf1ad-3d48-0867-35ce-068da901d01c@amd.com>
Date: Mon, 14 Apr 2025 14:10:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20250414130417.1486395-2-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC/RFT PATCH] x86/efistub: Don't bother enabling SEV in the EFI
 stub
In-Reply-To: <20250414130417.1486395-2-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::7) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: bef092ff-61f1-4b61-6eb9-08dd7b8806b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TE1QSlZPTENHb0szM3UxU0MycXZ4bSsvRUcxZWJSMmpFQTZ0OVdYVHBuR0d0?=
 =?utf-8?B?b1BnTjNLc0g5eFRlZUxFN0pFaEhOdHJIZDFYRzJRNkFKdmFYclRLTWd1elZa?=
 =?utf-8?B?Rk41RlMxMThWRldSNldWSzBWVllZdFdsSm8xWkFHQm5TYnducVFRRk9WYngv?=
 =?utf-8?B?dXVYS2JwaExiaU5FaXZqdHRYSk5xeGg2Tjc2RGpjbm5ndmlCdndjblErQlpp?=
 =?utf-8?B?NjNyRU45UzBHdWF5UG1MK0hQK3ovMGN0VnhvbHNNTWo1OHJGZUlPamd5NEYy?=
 =?utf-8?B?ZE5uRE51SWFWNW51cUpZZWM0Wk04SExsTG5URlJWcWhpQll2VWJFaTBlZ08y?=
 =?utf-8?B?TzJpV3hkVmtoTnl3VG9lckswbFVQd3ErSG5aKzRPZ0JFY0JTKzdIYkMvamNs?=
 =?utf-8?B?dnQvdW95WEUrdUQ2a1hscjRHTVdzWHN1SUk2L0Vwd0NmWE8wMDRUcWFkMVBy?=
 =?utf-8?B?TWRUd1VHLzVRd2FwYVhNcmlER3ZFZEt0bXozZnM3aHhlMFd3WEd3Wml2cFhw?=
 =?utf-8?B?YmkzQWtrT29KdWZmQnZHVjVad2lnanUzK2t5dytqWWhBcndKN0JURFlNcWho?=
 =?utf-8?B?eEdyN3VRbnFmMk1EVWlXOEU3YmN2SEFRUlJJTnJGSXEzVmxRVUlaYUFiRlhj?=
 =?utf-8?B?UEc2WVhrWjNEc0Y4R1RWVi9LM1czcURMUDdpdmpOajJhRTJSVUpPYkZTSWVT?=
 =?utf-8?B?VE1vQVo0KzJkU3k3YklmK25TeXQ0L2s1WGxYWXl6NlBCckZCUm9MY0h0U0xo?=
 =?utf-8?B?UGo4L2VHRWpYSzE4QmcyczkvZW9MV2hLN2lzdDdYWk95TW9zeG9aQXZ1ZFh3?=
 =?utf-8?B?RzQxSy9WVW4yOWRpNzQ2UUx0eHVVRFVoVWRTYnVmRUJCK1g0RngvQXcrcXNM?=
 =?utf-8?B?R0VSUGhXVW52ZW8wTk0xY1dTbG5vK2xaNk9uOVJZd3M1Y0NFSXFnaUpNNVh1?=
 =?utf-8?B?cmRxYTlUQ2hlTkJ2SE1sdzM1ZHlqeDI0Y2tTUlNWcytXVGhxNDRYUTJCajN0?=
 =?utf-8?B?Ym9HRFQwWktLVlM3bEVTaDZGaFpJS3FIVHkrOENpWUdsSEhXREpxa2QvRnVY?=
 =?utf-8?B?UVRkalhJVm5tcWRuRHplTU02YXRSZGhES2FtZ0NIaVVVSUZhR3kyc1U5eGRq?=
 =?utf-8?B?anU4L3JjRUNiZDMyQ2R1TUJYRnJZVWxSUWI1UjJ0eTRUK2F0bEo5Yzl2UzA1?=
 =?utf-8?B?UmhzVzBqdmVnWWcyWG5zbkE1bStqekNMTlZDNG9RMWdyaDUwNzJ6dGs4dW9h?=
 =?utf-8?B?RlN0UGFHQlRlZVNaREJpZmFtTHdaVjhPcG5Jai9OakhmMEVVaVY3M3NpKzhh?=
 =?utf-8?B?TWR3U1JBVjBEMWxzTVh4VnhYTDM3SFNueWRGOGRYaTBGb3pScU1YL2ppY24r?=
 =?utf-8?B?REVXZUxWcE9aVXRVNFNoMXhoeXBXYzN6dWNwSzh6eWM3dXRQUnVFQVh0VkJ6?=
 =?utf-8?B?YXBBTlc3U1ZFMTBwaVZsWmsxQUR1Z04rbmpNSWk0anpXeHFNY0JPYnd1NFE5?=
 =?utf-8?B?dkV5VjNiUnBtRTBhcVZzRHZTY3RuNVJrbUtnVEV2bnVCNElPUHJNWUxhZzlR?=
 =?utf-8?B?ekwwUVhxc3NaelprcG01cE54THhMT0tRT1o5UVI0QXJTRDdPRGdBeEU3L2pi?=
 =?utf-8?B?RlNHRjRKZEdiaDdBbFN2S2d6R2VpaUlLZXNJT0U4Ykh5czh5RjQzOG1EeWdL?=
 =?utf-8?B?eTMvTno4aHJ6VnltK0haSUJmckl2TGh5OUROaUtwWkxuRFhlaUw3UzhnbEF5?=
 =?utf-8?B?cjBCTWg3NVRTWDNoZkt3Y2JjeHNaQldIbXN5WXdQMW1rWW1GVnFRZVBVYXNB?=
 =?utf-8?B?elV5V3FocmxrMlBDcEFXZE04dWowbVBsaEFyNWpZY2Y2Qm90Z2t3YStNLzJs?=
 =?utf-8?B?QXIySVJkd3ZHWHhVOTMrYjhPL0lBL2lwdkhqdXgvVGJqMHByZmdnVmp1NnRF?=
 =?utf-8?Q?fnZbFDdEeFU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnJrN3NMVW5FSWl0NkFRTHBjWTVQcnl3NmNWWGtqQUc3T1RMMTdJekxKZVRj?=
 =?utf-8?B?NDU1RVVzOXh5NVlkMW02TC9UVDExeTg2M0R6a3FHWnpOVW1aS0dHZHA2UFdK?=
 =?utf-8?B?T1N3Qy9DOUIzVUxEWmhMRmJIVXhSMXQxWjhQM2xtbGYybEJMV3FyNGlLcnNJ?=
 =?utf-8?B?TS9jOEJ3QlZSNmp5bXNWU1ZUVFJrcncxUmdhbWVoQUdIMjYxbEpNZE9zTDUw?=
 =?utf-8?B?THNGVWI5Snd3R1J1OEtmZ3hwN1RhMVo1REJmMXFRQnIyWU11czZ2QlZyd21P?=
 =?utf-8?B?aCtYY2N5dGNwbmIwRHZVZGhadDZXY1QxU2F2ZUZzallqTU82eFZnNGVWYkI4?=
 =?utf-8?B?TkRncEdlK3IxcEE3YkpLR0dFODNpTnJtS0VwT2VwZ2lQV1QxcE1pWDhnb01P?=
 =?utf-8?B?Z2hjSWEwbG5STWx2Y01ocVBVQTlCUFNDUjlHRFdjZTdUNnM3N3Bua1EyQXh0?=
 =?utf-8?B?MmMwM21SU1JFeWxUcnh3OVcxRllCMm9LNXEzTnBwbDkxSHJoZGMvb1NIeG92?=
 =?utf-8?B?SWdVd0pqSGR6dU1tays0ZWV2djRyQ2ZxbmQxelcxQUVGQkw4aW5SK2JGQXl2?=
 =?utf-8?B?cXB5RlFtU0FNY3lvOWhpVmlnUUg0RVhGdGR6NjNlNzF4dG8va2VxNTBMSkxk?=
 =?utf-8?B?QU51dTIwMkZoWXhUZERZSjhBK3J1Nk1pTllMSGN5ZVJXVnpkSUsvd1JGT1Fy?=
 =?utf-8?B?Nmx0c3hEMXZQZENPYkdOekxHZVkwOVE1azZha1pHeEFSMDg5MHR1K0tCMTNZ?=
 =?utf-8?B?SmxNcURkT0o1RlpmUjRRc0VJTnlPNFVkVXk5OVo0U0JkUnFtTE5iWkY2azY3?=
 =?utf-8?B?RU5VS3ZxRjVqQzkzUzZQOXczZDR2YlFQL3VBUzNHMmdrWUlvTGFuaDZUNk5k?=
 =?utf-8?B?Y3BGbDlJbE4rdUVVRGx2czlFWjVSeG1zYVZhL3NXSzByYUZGVDNUbllFWWt2?=
 =?utf-8?B?NmVmWTlBS1I1b3JaNUNQNU5kOWN3ZmVWYy8ycWYrcUVYRzJFOWFsSjBzVzVl?=
 =?utf-8?B?RjdUNjZlS2NFT3dFZWVFTVpJUWJNcFZSRzJoOHc5MWJmL0t0WXpibHROYm5T?=
 =?utf-8?B?aUh1bzVEeko1ZDQwa2NPNkNCN1FhRTJTcG5lQ2NOTVQxaWxpUGVmY2RsbnZX?=
 =?utf-8?B?d3JBZEE5aTlnWVNYUTJmQzJrY01nOXpteU5lWkNuZkx5UmhKRDJMSS9WcEVn?=
 =?utf-8?B?TWFOSXFWaVRGcVFDMWdZWlFSUDltcy9vWlpVR3pxRURKUEs4RWp1b0hrQ3Fk?=
 =?utf-8?B?Q1FMVGhEbFk3M1dlN2ppbWNCTXNoVFBNbEdqU2ZRdTNIbmFhUXp5N2g1SnBz?=
 =?utf-8?B?ZGdGemFlNEZ1NjB5WWltd3U4dlZMendJZ1BPOUwwdVFxL1ZqVGJCMTdVaHlN?=
 =?utf-8?B?b1d2ZkY4eStSQUFUdEd3ZXBZVDBKM2hnUlVKdU9YNVRxRTEvZU5rU1h6eVVE?=
 =?utf-8?B?MmRaY0lsVFc5cGFZUllJbXFSN2lkaUt5ekVySzBub0x1ZjZYY21GOVZzWXdH?=
 =?utf-8?B?UTlSQUU5MnpKN1o5MTFPV1FhK3lHS0hqeUNrbC9VU0pweWtaVnhwbkgvUHI1?=
 =?utf-8?B?YmlCK25TZEFEY2lwVTNLS0VXZmdodG5QOXFXL01IUUxUZFdHT1FLajY2cmtW?=
 =?utf-8?B?WEZpN2pVWXhMT1c4UjkybzBhQ1N0dm1USEc1SHN6UVJDbUZjRGVGRDhOMm5r?=
 =?utf-8?B?WFd0Mm5mMmtBcjlyc0tvWHk1NVVWZHVDYjVrZFd1MlBBM1UwT0JuY2EwTEtm?=
 =?utf-8?B?Qk9Ud2JLK2dUNkpoY2ZQa3lFVVhPQ1BuSCtqYjFHc0lWUGRPdkpuV0x2L1Z6?=
 =?utf-8?B?MFVPT3o2bnZ4S0ZVSVBiZlB2aDNiY2M4V0F6Q2NsWm9uL0lhRUNXb2tsL3Mw?=
 =?utf-8?B?S1BVdXk2d050eHBtbW5wZUJWb0pFczJRdHlLYVB0L2ZWb1VRQ1pnR2JqUHk3?=
 =?utf-8?B?VG9xUTBvUGZTNG1kOG9yWkMrK2dwT0VlUnNWU1lvaE5ZVXhham9vZEtRTGxj?=
 =?utf-8?B?aSszQmVRcGZiZjM3cEt4SVZPR09IOHFHVHBSWGVyOGIvM29HTmtZdG1Scjkz?=
 =?utf-8?B?QzFqTFRMYm1IQzJlVjg2MXZuV25DbldOSnV4RXQ0M0ZFWDBQN1J1Tm1XaVdt?=
 =?utf-8?Q?e2LmS6u2mIh7QxvPKhJkRwhNw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef092ff-61f1-4b61-6eb9-08dd7b8806b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 19:10:31.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/Qx++bspD90L9X5npBCYCeb2/I5weFMvIjc41+39rLPc85tvoSC/d1ulnMNinTjqxdHWpUv3ap0JlOCupVrig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006

On 4/14/25 08:04, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> One of the last things the EFI stub does before handing over to the core
> kernel when booting as a SEV guest is enabling SEV, even though this is
> mostly redundant: one of the first things the core kernel does is
> calling sme_enable(), after setting up the early GDT and IDT but before
> even setting up the kernel page tables.
> 
> So let's just drop this call to sev_enable(), and rely on the core
> kernel to initiaize SEV correctly.

SEV support does some things in sev_enable() that aren't done later in
the kernel proper. For example, we check certain hypervisor features and
save the CC blob into the boot parameters. And as I look closer, I see
that we don't call initialize_identity_maps() from the EFI stub so we
aren't calling snp_check_features() from the EFI stub, which we should
have been doing.

Just removing the call does cause an SNP boot to crash. My testing shows
just ensuring that the cc_blob_address in the boot_params structure is
set results in a successful boot under SNP. So some of sev_enable()
needs to remain and some things need to be moved into the kernel proper.

Thanks,
Tom

> 
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: Kevin Loughlin <kevinloughlin@google.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/include/asm/sev.h              | 2 --
>  drivers/firmware/efi/libstub/x86-stub.c | 6 ------
>  2 files changed, 8 deletions(-)
> 
> I'm still waiting for my SEV-capable hardware to turn up so this was
> build tested only.
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 7427eb233990..1db906d6924b 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -442,7 +442,6 @@ static __always_inline void sev_es_nmi_complete(void)
>  		__sev_es_nmi_complete();
>  }
>  extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
> -extern void sev_enable(struct boot_params *bp);
>  
>  /*
>   * RMPADJUST modifies the RMP permissions of a page of a lesser-
> @@ -533,7 +532,6 @@ static inline void sev_es_ist_exit(void) { }
>  static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
>  static inline void sev_es_nmi_complete(void) { }
>  static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
> -static inline void sev_enable(struct boot_params *bp) { }
>  static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
>  static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
>  static inline void setup_ghcb(void) { }
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index cafc90d4caaf..52ed13ec4fe9 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -925,12 +925,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>  		goto fail;
>  	}
>  
> -	/*
> -	 * Call the SEV init code while still running with the firmware's
> -	 * GDT/IDT, so #VC exceptions will be handled by EFI.
> -	 */
> -	sev_enable(boot_params);
> -
>  	efi_5level_switch();
>  
>  	enter_kernel(kernel_entry, boot_params);

