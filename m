Return-Path: <linux-efi+bounces-3087-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49145A706FE
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 17:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD65116C10B
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1E325B691;
	Tue, 25 Mar 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gxgHp2He"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287F25D55A
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920256; cv=fail; b=kxwOjJfSApEjQVXZiZairjX3kB7QI/Ih3Zn5xdc6qTCPyR/pIOPeXwgHOvs/hjIRd9hewL5QToEYpp1cG5XzVIrGkVBKwfeFmkdhgbzAVm/0OQ7tHMtL2cdtTr5TngVHiq8fScVMnyfM9TqkZst0AyICgbE4dFd54TeUOSe5zeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920256; c=relaxed/simple;
	bh=ht0jdKTZ7G1o0tSYcii7O3gqNFE9Vk8k6s+jmXCh/Uo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lJfAQ81+6osT2kZu5XT0wczw/YGZGOaAUh2I3aGpJMsdZhMHVRETFMki1N5nxc/5oJKAN1qK0BmCjPONbQK0uoQQeHwxAFqnqS3hipEE9IKb7OFcKjQbs3y3U6QPS8ZhGZqx4+vqP4B5p01jFTjDd3tb5zkV3VwoR1e/tkQk1Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gxgHp2He; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vH0yeoL8Z2W95Y0NSTKEZJOCbI7S8B20Lx5A1jjpcaG/NWTPrAEew51ezKcJIdKw5DYNkcotdiP9d1mrD82/Q0O4G1l8Klf5vfFVhrexPsD1D6OlUp663AfJYE4JNcdrQC3ex2rMyupqVnSSAyZd8cY6acjy0duVOh5U3+j3BrbxCbmsQ84iUZXWv3kaKSv4hlBHMMKpJ6bm6KuMqX8ebgTZ3oRe2atlRsDiQ1j3oA9wTmkk42twyEW/hk929IpyUb9+dS/OpAfsx6eBcxNWciS58h1vSs1vF25xnGX72YZplUHnVgbQo19RkCjwW6Qu5ePwEVO/a4eLbtykpyEBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBRcBSZGnpo7vUglJJq4CvU3TMWwYz2eDyKM9rJ1IRU=;
 b=Jd3aqsRy8LSnq3nxYDL9sA8X5Y4xksMBQvo5ZcKHiXZcA5i3rD0Ds2AyM2mb5T353b6ui8PcshbANNh/LGJTk0YNOYDyqM+HcDArqqJr1dqArT7bmM0QxQMxIllwHqGN9HbWyt5NrFCya/p0MEuEoYOsqC42MzKQzlfcrGuH6umCFxLt0aZTCBTFeaUmUdo/+Mlv0259CWInzlb2mg8A4MrWLBBrfGC+03pbSAjdb4ugv8ciz7kKCEiutjVue92qZeO77hE6yCgF+cjNlpEPCo/wRDi9/N9Ezv3/jufosvPxEOOMKSf3Snk69TTuwf0CMnMfiFG//nkAF7FkZlbZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBRcBSZGnpo7vUglJJq4CvU3TMWwYz2eDyKM9rJ1IRU=;
 b=gxgHp2HedU3nKKrvNeaMpw+1//EZHY//6ATWtlF3KsdPYF5Dx6Mg0J4ai+WEj93vhH5i1f+SQNtw9PuNFJiDD4kuxPJQk6XRsq0+H879JEesbG3jm+NB4TavLIZMyfoxuE6bBia0DC0H2qQXHa3bE1OzI2MJYP1pbo8VKqpCdhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 16:30:51 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 16:30:48 +0000
Message-ID: <d6eb83a9-d1b1-7028-9cfd-1ab3fa0d6269@amd.com>
Date: Tue, 25 Mar 2025 11:30:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] efi/libstub: Do not accept parts of memory before
 ExitBootServices()
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20250325091614.1203411-2-ardb+git@google.com>
 <32zavhk2moqarh4vd76rnhwte45kkc3gqy3shls7mp5lemhy4k@o4gibpdf4sj6>
 <CAMj1kXHkM2hBHkfjFuCKpOA2APX+BBR-zrPfRkpiEf609UMKjw@mail.gmail.com>
 <ervuw7mwzvcyizkchy3nz4357ahz5kdfzc227exlrc5yabq4im@g2kzsrdbkdf6>
 <CAMj1kXEzzNnohJat5REp5mAUCSd4v_ft6F=P6vB95z6+f1MMfw@mail.gmail.com>
 <4xm3bmuhmdbnn6fkmhmnrtkcdiwj76dcr7gujam45nqvgupvj3@caytleltmyzj>
 <CAMj1kXFERrdioZ8_07rwDVUAoq=OLDvLCRUS6BN3GXnJoJPuAA@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXFERrdioZ8_07rwDVUAoq=OLDvLCRUS6BN3GXnJoJPuAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0188.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::16) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6fb086-7250-474e-b0b1-08dd6bba6645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjZ0dHpZcisxaUw1azdwMzM3OTFnTnpBNzhKTk10dmFVZWtZOHdENENVMTEw?=
 =?utf-8?B?VkVVc2k4NTZURXdJNVM5LytlbkxpdWxuVFlha1ZEcjloZEkzWThwaDEvUC9Q?=
 =?utf-8?B?aVd1RnM3azQ3K2I3cmRHMHluN1NVczJWOWtmck1ZZnhhQWs3dzdNY041VmFr?=
 =?utf-8?B?SkdrckJJN2FIUzRva0g1NXM5bjhPM3pHalo1V25JZWR0S1I0cE1LUXhxZWVU?=
 =?utf-8?B?b2RHZGNGanQzbmlkMGJ2QVJhS256NDZ2WmR0YnJQQ2ZQS2lJa3JpeUFzTlFJ?=
 =?utf-8?B?QjBMNjZ4YkhjQ1haUFg5N0xmYnVGQWNtdVN2Tlc1Qkt5aysrb1lDcjZvb0ll?=
 =?utf-8?B?WU1VUnhKZXNBaVlMcEVlNlFCSXYvU3luc05XNm1PSTZhODNuTytJL0RXU2I1?=
 =?utf-8?B?K1ZPd2cvQ1RDVGFBaitsRTFhakFRR0lIcnFkVXNFWCttdlFrU3BFN3FMVE1Q?=
 =?utf-8?B?Q0hNWHlhL3B4bjJDYkNPZFp0TExKb3I0ZUZSSFdvaTRyZCtYNkg2YkNocGh4?=
 =?utf-8?B?aDBnQ0pxaHNzZVhCZ1dIcWczOHFZZzE1cldObkViRjRDTy9kTFNKS0pHZk9Z?=
 =?utf-8?B?S3RqMDB3SkZtbElIUEhxUENYbExDUlNRTWR5bEVmbE9vMXVtbmZVZlNkaUhC?=
 =?utf-8?B?aGk5b3E2cnI1cFpqTEtudm9zRTV2RVJDTWY2VkhSNjVVQkQ5N0dyUDhiZVFT?=
 =?utf-8?B?NU5La0VpblpHam43RWtTY0kxSzVqSWVuUUFiY3Evb2tVOG9XR0VUYW1BSXRS?=
 =?utf-8?B?Z1JtbHIrNm1PNjJ6Y3k2ZXJVRTdLZW1rdXJncnlEWVFjd2NYelhZMHhwVmNW?=
 =?utf-8?B?UjJadjIwcFBBallhVEhQZXIxck5reDloVFpoSG1HbStYbXdrT0M0SGNXZ296?=
 =?utf-8?B?NmJHbmNJaUlxc0RDUzRtN0E1RUhxbm5Xb3p3aEZZbTVoZ3l4ZUFvR3pZR0hR?=
 =?utf-8?B?VS9zNGVZWTN4aENiSWs3YmtUaURpM3RGUEttbjgveU1WcHdDQUJWVS9nVkI4?=
 =?utf-8?B?SkxQeVdnb3NWVUxZYU5QN0Z1TlRlemFJSUU5SENaQndQTkh2cUFpTG5WWlBT?=
 =?utf-8?B?YTdYWkRiUG9xaEVhWU1BOU9VUDZXZ2pxbnZhYllieUdiU0tDd3ZLSVp1NVla?=
 =?utf-8?B?dDJCcFg4clo4MjdMdVJJdWVyZHdMZ1lqbldEZHFneFVGRUQwaW94SUpma1NM?=
 =?utf-8?B?L29jRHIzclpRR1ByVVpZTVZ4YS84Nm10bG5NV3g5MjdLb1VmWmw3Z25DOXFR?=
 =?utf-8?B?cFFsVGFEa3UyT3A1RVVXY3pyZUxTNUhJZUczN215WTZWYmVJVW9BaTNnWHVy?=
 =?utf-8?B?K1BwMnlyV1YxanhJY2d0ZFd4RCtJM2dGaDZFanQ4MU82byt3SzJJYmxwTWZS?=
 =?utf-8?B?dmJRSmx1S1lwTXQ3d3Myb1JROHFzWGZLVXMyb1J2WENjdTI1VHZRS2pRRFU1?=
 =?utf-8?B?cS9XdlMxZENQbm5yeDdUTmNHZjlJTjIyaXZGWk1EUFdBbE5OTVU5ZWJrR2p6?=
 =?utf-8?B?d1JTcHo0cG55U0U4cVBlK0ZROUgrQzBFbzhvUGcyQ2UyQTZNMjFtZldkY2Fz?=
 =?utf-8?B?a3FVN3g5c01kaEVvV1RTSjkzZGk3U3p4ZWN4WnJEaTI2UGZYaW94NjdBMlgv?=
 =?utf-8?B?ZVQzNVdlcHBBdHB1QmQ0OUFVZE4vUSs0YVFnOWhOOFo5ZXIvcjk5SC9qMlg3?=
 =?utf-8?B?SHJWQ1pqZ1BVblNON3YrdzN5RUVFK2Mzb0txaU9sS0RxRWlYSFNDajRIWEgr?=
 =?utf-8?B?b0pOWGFCVkZDM2Noak1LQlVyd0UrRGRTWlZPckFPU3BLS3hpT3M3b0xQTVhn?=
 =?utf-8?B?S0pubzgzcW10SnY1MDU1WFRUbkU1c0V4UEtGbmx3YmMzUENZWnhDNjZhWC9T?=
 =?utf-8?Q?+pwJ42nE+Fs4+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDlBbk9GVDhIRUtpRE1sRUVqQWI0WDNiN0xHTFUzbEpYTXhTWGdPV2h3T0dl?=
 =?utf-8?B?VDcxdjZJenVmWU1EOEUvMlA1V1IySlFSWWJVVW5tN0Z5WFJtbmtiQ1ZscWJ6?=
 =?utf-8?B?S0R5dVQzN0ZhRmhPYXlGS0JDY1FZckJyditGWGdYRFIvZmtub1JNRFNxYWpl?=
 =?utf-8?B?VVhEZzZSV3BUUDE3RkwxU05DM0NMb2ZNZFFXaWRSSU1qN3k5NFJjSDBZYngr?=
 =?utf-8?B?bHc0bnc1NGpJRUVaN1A4UnFnMTA4SVpwbU9QYUcxY1hxeDVTeWQwMnJLdEhL?=
 =?utf-8?B?czNyZDNMRDhnQURBY0R0b083dCs1bm9lOHhyVUdLQ01vNkFiRlBaeGY5Kzhu?=
 =?utf-8?B?ZlE4dXFsWTFmbHpsWTJLT1ZOMnZVNWdaVHhxN2FWUTArOUF6TjUwc2ZCbmNQ?=
 =?utf-8?B?a2FlajRlTDl4VjIxdTYzaUo5WkFGOGN5amowVzNuNkprY2NTY2NYaTNzL0po?=
 =?utf-8?B?eld0d3FNcUl3RkVJMXFpeHFzVDF3T3NMTEo1OEVxMFFDcG9sMDhDbHJURHVB?=
 =?utf-8?B?NXI4ZE53bWw0b0xSampDdnVlQnZycllGU3VZTXJmV1NRaFdjYm1QRkFTaVRl?=
 =?utf-8?B?d1MwWDBUMXc4clVSNGlZWkJxVDUxR3JtcnBiZGpkZk1JcFc4U0hMWjd4b3Zy?=
 =?utf-8?B?WGJmN3NpVnZiYXNsZGFXSzhweUlqMkppK3JDdjlJVmRMRlpWV0JQeVhpdGh5?=
 =?utf-8?B?enBRNDJzQmFzV2w3bWYwYTMxRVBXQk1YT242TExmUG9MaklLSGJGdEluQTBJ?=
 =?utf-8?B?U0dzYmlwUjEyQzByZWtHUk5FQnc5bVBQTkNtV2loSk9zQU51YlV4WGRlZGND?=
 =?utf-8?B?R0tSOXpNRVgwTEhER0dXQTZRSU53RjJiZ1pTcjhlaHplUDk0MDk4aHZPV1dU?=
 =?utf-8?B?SDBXTWgzVHFsOXZqYXJydmVuaGw3bTk0bEJKeDVqWWhrSVoraG14Y3NNNHNs?=
 =?utf-8?B?cmZadWtKSW9iQmhxYnNlZVdRaC9ia0lvODBndUh2MHNaOFFRUzA5SktrY3h5?=
 =?utf-8?B?bjc3V2t5SG5pWjBzN2VDdXd1dEpGNGgySkVORmU3VXppbmMyS29Yc1RTUmZr?=
 =?utf-8?B?Tis5UkQ5YmhaYXFiNGlsNEJteWtMWWdQakc0WDhxZGJZYmZ4d2RHOW1YcDZK?=
 =?utf-8?B?dC92NDlBU0JFak5Na3ZsK3AyRnR2SGQ1cEs2a25JdTZvVStaQWhyQnpua2ll?=
 =?utf-8?B?aXR1ZlFiKzQyb1NSTjJVTFREL1VSNTlzV1p1UHdwdysxZUp3YnRBZEJ4SHY4?=
 =?utf-8?B?ZE4rZ1plR0ZuR05qMlpNTWx4SjcyT2h2YzBtSE9yNTdSQ1hVMloxOUQrcmxi?=
 =?utf-8?B?WGxvNUIxM2thYnJPWGdXVnoraVl0MUgvL0ZESHpsK1pWeUErQ25LVDhBOVg0?=
 =?utf-8?B?NTN0Q0RCN2cvTThueHNIN0lqeVI5WVV4ck45NjlCaU1hNmJxcUFHYUVSKytG?=
 =?utf-8?B?UjJxSzBleUZ0RXlHVm1sWEtwSjUvWFZvMlRud25qZ0RoSStTVTZYTzgzOEtT?=
 =?utf-8?B?ZHF4bHRnNFdtbnR5WmtnMTVKbkUzcVNxV0JrbXE2akpZKzVSeUNXQkZkd2Rs?=
 =?utf-8?B?M2dZLzNUbS9sYU5BV09WMzZkTGFWenF4aWtpRzM1RkluYmY1YVJIZ2Vac0kv?=
 =?utf-8?B?bXlwZ2pENnlpM3VMaTZyMDBXYmwwdlJSQXBZNExGK1R2R1htdGljc1g4Vnhm?=
 =?utf-8?B?dFpzNy8yS2tmejZkeFRIcndpWWRNWTlndEhOSzMvZC8wQnVOMTZqYW9tQWY0?=
 =?utf-8?B?a3JWekVJSGlKRDQ4T1BmTUw1SHFQa1RiUllsUzF1NDh3czh4ZWpjUGpYcU5X?=
 =?utf-8?B?aWNpNE9UOWpKVGQ0TGh4a2k1RXhaTDMzbHRwUkVGL2s4RW5WL1lhQktkZWdu?=
 =?utf-8?B?bFF2K2doUlh0K2tPTDk3ZU9ZL21XSG9jS05ZcFM2enpJS0wzWSswdzkzdTZs?=
 =?utf-8?B?ZGRGSGMweHJBZ2NSdy90MDdIMkJjeHBuQTVETkg1cmR2NS83ckY3ZWZoNTUx?=
 =?utf-8?B?TE9xVnZCVWJzbEpGcWdQZjhUaSs3SWdOZWxnL2ZuUDZ6Q1dOZVNhOTdkQmRy?=
 =?utf-8?B?eUNZbzBJaXJ5am10NXZlSTdSTXFrQnczWkxoZHRoVDg3RGdnQW9rYjhJaDVB?=
 =?utf-8?Q?dFQb/7Qoakr/plVbvji2FAwA3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6fb086-7250-474e-b0b1-08dd6bba6645
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 16:30:48.1911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+EharWX09EE2ECdC8RVRVubVjfQpMgw1aOUmty8Uwcf6iWf6NjXi8C2D8EM9YSjTNMTwso6b7jWCB/hP1spXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116

On 3/25/25 09:39, Ard Biesheuvel wrote:
> On Tue, 25 Mar 2025 at 14:44, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
>>
>> On Tue, Mar 25, 2025 at 02:09:54PM +0100, Ard Biesheuvel wrote:
>>>> Since the problem happens before ExitBootServices(), can we allocate this
>>>> memory range with EFI API and free it back?
>>>>
>>>
>>> In principle, yes - we could allocate these misaligned chunks as
>>> EfiLoaderData, and it wouldn't even be necessary to free them, as they
>>> would become available to the OS automatically.
>>>
>>> But doing this in setup_e820() is tricky, because every page
>>> allocation modifies the EFI memory map, and we may have to restart
>>> from the beginning. And there is no guarantee that some asynchronous
>>> event in the firmware context does not attempt to allocate some pages,
>>> in a way that might result in another misaligned unaccepted region.
>>
>> Looking again at the code, setup_e820() (and therefore
>> process_unaccepted_memory()) called after efi_exit_boot_services() in
>> exit_boot(), so we can't use EFI API to allocate memory.
>>
> 
> Ah yes, I misremembered that. It also means that it is fine in
> principle to take over the communication with the hypervisor.
> 
> However, this is still tricky, because on SEV-SNP, accepting memory
> appears to rely on the GHCB page based communication being enabled,
> and this involves mapping it down to a single page so the C bit can be
> cleared. It would be nice if we could simply use the MSR based
> protocol for accepting memory.

We can probably do something along this line since there is an existing
function, __page_state_change(), that performs MSR protocol PSC. If we
change the arch_accept_memory() calls in process_unaccepted_memory() to
arch_accept_memory_early() then we can differentiate between this early
alignment setup timeframe. The early function can also use
sev_get_status() instead of sev_snp_enabled().

Let me mess around with it a bit and see what I come up with.

Thanks,
Tom

> 
>> And it bring us back to the issue being platform-specific. It should be
>> able to accept memory in principle.
>>
> 
> Indeed.
> 
>> I remember testing TDX boot with ridiculously large unit_size, like 256M.
>> And accept logic worked fine for me.
>>
>>> So ideally, firmware would adopt the same granularity when accepting
>>> memory, and we wouldn't have this problem. (Or maybe this is why
>>> nobody noticed until I found it by inspection?)
>>
>> It would be nice, yes, but we need to deal with requirements in current
>> spec.
>>
> 
> Yeah :-(

