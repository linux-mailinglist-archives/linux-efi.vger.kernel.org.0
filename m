Return-Path: <linux-efi+bounces-1901-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A89F98F705
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 21:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1A21C21EF0
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 19:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEB01A4F23;
	Thu,  3 Oct 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ccldlfor"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF0768FC;
	Thu,  3 Oct 2024 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983915; cv=fail; b=fAgJKqX7dykyY7S6pKCAuBF4q9SRlB8JcQjRSzcPMg5yrmVMVbUzujujeanrrEbMFRa8R86vHvc7MVtTz6Gz6XfJkLYLPboIso7S1sSGzsBzFwAB6YVxYASWAwo5EDVpXanlsqI6PvKEHbJoeYv4qeGZl8pMIMhrEUAeXybRK98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983915; c=relaxed/simple;
	bh=1z//8Da8IFJE9+pUOAeyKQMLRYFcBFiyIme1N83d0iU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=Rl/ZG5LmVg6KLa+hZfjF3QS6SW42lCvdrhj9aQ0QDvCBE4sZnVJuNTSaosbLxgcga+/OzyM+vEPukEdh1iSDf/9efRCUsdtQY8lI/nUumPKLaG0DohZY7TyTPNvIYhzEU4Nb5Em8SIIqZQY7TLVh+wuFU4jwNVEZlaQ74rqp+qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ccldlfor; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=un+47gotIafTazLZUI03D4fc0cea0+UhMEJRSpqyQahXo5LE2f5NSv6X7VCJ2p/y+pqNoDKaCU0y2nBOOcKR5sY5cX3ORWYZRxEojrSmIzM1p+jcJzu3Euk224mswPUe5g6ZyDSM0fwpdVIaHrtnQfS6ee0bmATbNHlb68MJmg3ugcNw/ILG0q4dHFcDja86e+cSwDO7qdUoIcE2ksPSnkOMPDjPC2zKIKIF9ditGRR7rjjq80vOivwtGUlvLHUBMqLgWY/73wLH4YhTadFfDH8dHe8BezDy2cNFh5/1YrU3BeEve/7Q41c31v+gUyj8Sdfj8ydexS0NVPE8JLuqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peusX9c1ihW7xEkav1DOyRfth4pQUWLIqkLOxvJYSnk=;
 b=fHE+gCcNylX5XQk5Uz1lqyZKxBAiXndUkyTn8u7TMZEUZWKwXWKXr0VGHw0++QlhIsE4gznDOMmbwKkYmh6sP5NYVBTNQfDC25Q/5TR3uNKowJ2cjjKof8oVTt552ynCuB4bBGMGig2Va4cpMmmeWC1/geIdZ75E43ABvHZPU44cVN9fzrFFsGV/mVHtolBgcDzzgWztDWRUexplnNPSdLOoIzUcrBGGkziC+gEPYXX0WicYDiCM9v1dapaVVhEQk0lCiF5PZaS9evCA/NquZhL6NIBRZI5ubcEjdSgCdPcyEo8Y0KEi482SJQyaOEK5IbYRr80KoQZOLdZra29aAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peusX9c1ihW7xEkav1DOyRfth4pQUWLIqkLOxvJYSnk=;
 b=ccldlforRqAhBO3OOah689YnxOBTiU615fw6/SDuuBjsQFQggCdDTpfDez65C+DWkZgM7f/xN64EulzDUUj9sa7AKzDEE3BlQiH2v1/U918OPES0NBguwTgD3tAZ9NEDHqdjLNy4aw/IqJC7JIsGrh1SxX4m/bFM8IvNaY0rqv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 19:31:50 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 19:31:50 +0000
Subject: Re: [PATCH v2 4/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
To: Ira Weiny <ira.weiny@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-5-Smita.KoralahalliChannabasappa@amd.com>
 <66fc1ad9ad68a_b5d94294b3@iweiny-mobl.notmuch>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <d5d2eff8-0c04-51c5-0128-b6c7e848552d@amd.com>
Date: Thu, 3 Oct 2024 12:31:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <66fc1ad9ad68a_b5d94294b3@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::31) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SA1PR12MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 37372757-9b6f-42ca-ec50-08dce3e20749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1VFeC9ZTmpUR1o2T1IrVUFzWjVIdU9QaWZQZHBZUmIzMC9aVENiaVM5MWxW?=
 =?utf-8?B?QktLQU5nelpUZTZSRnowWU0zaHpCd0JGZk5Rbis0YWVtZDlLM3M2bEowVHNh?=
 =?utf-8?B?VkR3TDFqMGwzU29VYVZUTGtuSHNRdkhsOHgwWmthdFErR0k4T2Yrd1BWYndC?=
 =?utf-8?B?Qmx3aWk4bVZlbWJnUXZJTVhsdWJnQ1JmNkF2S1ZYaDJhbElPVU1kYUF1ekNE?=
 =?utf-8?B?STBUc09Ua0Z0Mi9qZzN0Yk1sWFAzQzkwZW9POEl0eTlEdGFNeXlIN3hMUjh4?=
 =?utf-8?B?TmlGa1ozbTNOSnlhQzlTdFptTlFoNm8vVjJDRU1TaVlLRWxBQzZJeGdoc1gx?=
 =?utf-8?B?bDBxUy9kR0owOFFic3dNRk82amdhLytmTVlMb2FNdUlraVA1L3h3M1Jodml5?=
 =?utf-8?B?QWpKUk9RT1lDcTY5a1FmVjh1YnViRFowdXJwd2p1Nk5GeDNiQ1FDQ3VHcmRz?=
 =?utf-8?B?ZUhQdkRJUTVRc3BmejA1dXdHclB6TEl3elJwRDV6QlpnWTdiSEdGajViU1JM?=
 =?utf-8?B?WFA3RkJuT2lVMG01OXgrZXV4aDFrSHpWMVBjV3haeHgwQyttNXhjaUVEQjUr?=
 =?utf-8?B?VzVnL2tYYjFVL3I1THVoOW1kaS9RWVY4c0NLWlI0YzNva25aRnJxeUVENUNk?=
 =?utf-8?B?aUN1ZTBrbEU3b2k4RVI1QzdqbmFkLzEra1dmNUMwM0NkUHZ3eU5CY1dDTi9E?=
 =?utf-8?B?VzVFWFNSZ2tORmcrYXl0SDZmSit5cXFkMDliajM3K2Z4Vm5Pc3hTZ1paV3pq?=
 =?utf-8?B?U1AyamNZK3ZhM09nT2N1ZnBRdmtUY0YxSVI3djdxZko4NkQzamdiOVdUMG9P?=
 =?utf-8?B?enFXdFZKbC9KejNwWjh6Y0c5Ynk5YmE2b09NR0VPdHQvc2xqT1ZQMDF0bDRB?=
 =?utf-8?B?RStTWXpSQ2wwS1JvUW8wMHFOT3orcEFDQ09iRVovWkpQVXlEZ1RYRmw4TnFZ?=
 =?utf-8?B?MXdTL2cwc1JJcGgzVmNsdGRYeTZKMG9WdEVzMHlOd0h3VStFa1owREJITFl4?=
 =?utf-8?B?N0tXc00yQXpodFVob3FEaEYxZElkRDJZODhyb3pVbFBaYjB0Z3JBRG9FSklQ?=
 =?utf-8?B?VG5sTkRXYWtUWkRCbTJrdmVSbGlJVFE4aU0wSzVUVVhGM1ZhK3drSnRMdXFG?=
 =?utf-8?B?TjBhSDB0T0Yyd1hTNGJUNnBDNG9XWVpMVkkrWWRKakg1bHhyOElUKytRQjlG?=
 =?utf-8?B?M1RpMkttTWlVaGdSL2tSejlnVVJQZEduU0JZaG1xV2djME1xRjVCVnJISnN1?=
 =?utf-8?B?Q0gzeVplWC9LSFYxQzRZOUIrWWNmcFpDSTlUYVdrTTgrREExcHFhVlB6VEQv?=
 =?utf-8?B?SXJtZFpUYnBuZktkT1I0blo2U3lqeDR0aXRCRDBnaXppOFZ3ZmxGcEVMT3hG?=
 =?utf-8?B?czlLNTVWVDVQUktXM0lRcXVYN3p2VW0xaXhVNWJiNVdTTU5zNmpqZWFYbFFr?=
 =?utf-8?B?MjEvRVBVc0ZjNVh6QWN0YUVETkdJRWZxdjNBYXpvby9vMFRmYUprYU5oNEUz?=
 =?utf-8?B?M1F1ckxTQVRMdmRDSEgweUlvTGVSc0lZSllURC91dFN1c3VrbWRWN2doUDl3?=
 =?utf-8?B?SWJUK0NWdUEvUVZ0K0U4ZFl0ditTRDVWRGErMHdRUzNzbmxlNTNzelkxVTFI?=
 =?utf-8?B?aWYzNGNLdHJMYzduVGhKR3k4T1hxRGVkb05WTEpuLy95NUp0U3JONFlyUmxo?=
 =?utf-8?B?dURManJ4dUl3ZzhsMFQxODYxYitPUzdQelNsM1FiN1lRZVZ2d2xKZUpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1diOGIxME1BalVOOERLNmdhYTJKazlmalIyd0xodkE3c0JZMU5rUEJ4bVRt?=
 =?utf-8?B?UTNvd01sMHMyeVVKZlYzeGxnY1dEdExIZHMvZDRDTEovSUxuQ1BWNStsK3pj?=
 =?utf-8?B?RXlDN0JPTEgyck5HNVluS0ZWNUxNSjFmMU1YbURTQkJlQzF0OE1kZzFSTVNC?=
 =?utf-8?B?VDltUlRLTXZJU2M2M0RhSlhKSnhaSE5uMFZZN1p1NmN2Skp6dlY3d2gxY2kw?=
 =?utf-8?B?QUs0WklrWTVYcHQ3V2NJMlByNFdFZzc2VVgrak9WQmF2K3V6MTdSYkFtR2M5?=
 =?utf-8?B?SGhLSHdURjM3dW5DVkFIbzA0ZTFsckUvak1UYkN0RFdwS0FoeGhLVHVHMUVo?=
 =?utf-8?B?bmltUlVWMXF3ME5MNC8zSDZxOWRnNlRFMnZLWDlYRVBTNFZ6aXYxTlAwQTA3?=
 =?utf-8?B?NmRhdnU2Q05RemZjTkduVjdOUXdGZnZQY1Y4dHZaS1JNRWVGcC9WbjhDMUIx?=
 =?utf-8?B?amtwNjFmYlJOZG85NWxLaTZmR0tPQTYzVk1KaXo4aytNbFJWUDhjUjF1Z1Nn?=
 =?utf-8?B?Qkg4T29KdTNXdFhWODVqYXpWT2hQcnlvYmJCTW1IVXY5VDZqOEV6cHhmYzBD?=
 =?utf-8?B?OGMwNDN0NGl5M1pwcXMvNjhhQlNHSjFNeXZCbkF3TVFwUVE4OEFsdE1CQnM5?=
 =?utf-8?B?S3N4cjhTV0hZbGRsM0hIdytaMEJzWFdETXNFbDczdmpBcUpWaUFnU3FFNXlS?=
 =?utf-8?B?aXZXcUYrWmlKZXJBazlUMERIK3J5NGxGUmE1aXBIU0dqZXNvSDlSWlNMeWR5?=
 =?utf-8?B?VUEwaHdDeDhXaFBINnREaFdoLzIzQkpkdlJyUkh1UHFQKzB3LzdnakRhTHdQ?=
 =?utf-8?B?Zk16TTNVbFFOQ0dTUUtpeFlLc1hKcjZjNG53a2RRZDZFcmpiV0lGcGg4enpw?=
 =?utf-8?B?NGxWb3NLam5VSnNOb3hJU0hIeXRHVTJWeExkREJSQWd0ZzBUSzFTVjVoWTQx?=
 =?utf-8?B?ZnNMQ1RvMzMyUi9WQjFHM1NTZDBXMkR1cnNhTXRLUGR0dUlxUTRyYnRHbndq?=
 =?utf-8?B?UDEvRTlzekJYN0dvc0hndThCZFc1Rk9hUDFzcTd4N3VQVlppSllwL3c1Uzls?=
 =?utf-8?B?cjJMK0JuTUpkODJub1QrMi9JM2xHeWIwUkw5dkd1TUFLMmpLdGdFZ3VzQjNH?=
 =?utf-8?B?cCtpMnBIQUtTV1lQUjNtU2FCTVA4T09Nb2RNYkJnVFhjTEJKUXliWnZmTnlm?=
 =?utf-8?B?dVMyUHpPTFhaSENRZGJjQmlKYngvMlhXUFNlcU9lTUdGeXovK2dVb2tKVURJ?=
 =?utf-8?B?Ny9yTHEwZDAxeE1jU0ZXZlFHTlZxUkF2Y0paNDRmbGlYNVIvS3NKVHozclhJ?=
 =?utf-8?B?dnYvQ0lSTWVDMU5ENnBkUzZnTEVWOGIrbTVPbkVwMlgvZGYvbTIrbWd0NnNR?=
 =?utf-8?B?TEF4bzNHSTFEbURlRTlFTFh1bjBXbnJBL1J3V2t3K2tSWjdzRG5USnRja2pp?=
 =?utf-8?B?NmdQWDBaaGpxV1dUODRoSmhoOXNTcGxtaXFyMGZ2ZFU3b3p2V2dkN0E1ZEth?=
 =?utf-8?B?M3U1bm9vaXRoVVRQQ2NyM3RQNHFZb1Zhc2U4UVV3ejdoelhTWS8xcU5xRVB2?=
 =?utf-8?B?cE42TkcraWpJTklvTW9uZHhMOW1pRXNPTHlFN3V6T05MWTc5WlNaRms5MzlF?=
 =?utf-8?B?VGNib3BsQnBwVjNiTHRpR1NuUS9YaDNRd3p1UUZ5OEpiK3c3K0VnWFVTWndF?=
 =?utf-8?B?UlBCZHU0VnhNQm5oUmUxbjBEUVkwU3NrZDhMSFV0Y2YxdExaeEVkK2xtNTdE?=
 =?utf-8?B?aFR3QW4zZTBuTnVxK1BGK1N4aFplZzVPTktCckU5UDdTOE5rQ0t4N0lubU0x?=
 =?utf-8?B?OWRPSGpBVjR0ZWhLV1luUXM1c3NaOXNDMUdINVprSHNFSjBrcXZwM1RVY1d2?=
 =?utf-8?B?elUwaTRFUncvWkpyeGN2Nk9XejQ0ck1jRkxXdmsyVDdZYm5PQmtWbCtLUW01?=
 =?utf-8?B?U0p3b1VrTkQ1dU9iNzZEYmJrV2hDS0s1SU5Wd0U4LzJTZGxUMlBjSzZjRWtC?=
 =?utf-8?B?ZU42d0pmU2E3cU1jN3pQblE3a1RjZjZManEyU2wvc3JtWTRwd2tyWjZIT0g3?=
 =?utf-8?B?MzdWZ09tU3hyQmJVNE92VjhVdGRuY0VKQ092SHllWTlZOENCZTlSMWszRS9Q?=
 =?utf-8?Q?xxGYEn3IYrVGnmXobytmJTxz+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37372757-9b6f-42ca-ec50-08dce3e20749
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 19:31:50.5514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qcj6gVh+0/YhgCU+dtdwW3lAbYB1oQqAzsDdOjEmxYZX6iCh645mD6vsVLIQsWwd81ap6WJyVS1kk+tNaUUZ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600

On 10/1/2024 8:52 AM, Ira Weiny wrote:
> Smita Koralahalli wrote:
>> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
>> CPER records.
>>
>> Reuse the existing work queue cxl_cper_work registered with GHES to notify
>> the CXL subsystem on a Protocol error.
>>
>> The defined trace events cxl_aer_uncorrectable_error and
>> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
>> them to trace FW-First Protocol Errors.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> v2:
>> 	Removed pr_warn for serial number.
>> 	p_err -> rec/p_rec.
>> ---
>>   drivers/acpi/apei/ghes.c | 14 ++++++++++++++
>>   drivers/cxl/core/pci.c   | 24 ++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h     |  3 +++
>>   drivers/cxl/pci.c        | 20 ++++++++++++++++++--
>>   include/cxl/event.h      |  1 +
>>   5 files changed, 60 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 9dcf0f78458f..5082885e1f2c 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -723,6 +723,20 @@ static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
>>   
>>   	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_rec))
>>   		return;
>> +
>> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
>> +
>> +	if (!cxl_cper_work)
>> +		return;
>> +
>> +	wd.event_type = CXL_CPER_EVENT_PROT_ERR;
>> +
>> +	if (!kfifo_put(&cxl_cper_fifo, wd)) {
>> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
>> +		return;
>> +	}
>> +
>> +	schedule_work(cxl_cper_work);
>>   }
>>   
>>   int cxl_cper_register_work(struct work_struct *work)
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 5b46bc46aaa9..39ef24c8991f 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -650,6 +650,30 @@ void read_cdat_data(struct cxl_port *port)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>>   
>> +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
>> +			struct cxl_cper_prot_err *rec)
>> +{
>> +	u32 status, fe;
>> +
>> +	if (rec->severity == CXL_AER_CORRECTABLE) {
>> +		status = rec->cxl_ras.cor_status & ~rec->cxl_ras.cor_mask;
>> +
>> +		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
>> +	} else {
>> +		status = rec->cxl_ras.uncor_status & ~rec->cxl_ras.uncor_mask;
>> +
>> +		if (hweight32(status) > 1)
>> +			fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>> +					   rec->cxl_ras.cap_control));
>> +		else
>> +			fe = status;
>> +
>> +		trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
>> +						  rec->cxl_ras.header_log);
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_trace_prot_err, CXL);
>> +
>>   static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>>   				 void __iomem *ras_base)
>>   {
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 4da07727ab9c..8acd8f2c39c9 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -129,4 +129,7 @@ void read_cdat_data(struct cxl_port *port);
>>   void cxl_cor_error_detected(struct pci_dev *pdev);
>>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>   				    pci_channel_state_t state);
>> +struct cxl_cper_prot_err;
>> +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
>> +			struct cxl_cper_prot_err *rec);
>>   #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 915102f5113f..0a29321921a0 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1064,12 +1064,28 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>>   			       &uuid_null, &rec->event);
>>   }
>>   
>> +static void cxl_handle_prot_err(struct cxl_cper_prot_err *rec)
>> +{
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	cxlds = get_cxl_devstate(rec->segment, rec->bus,
>> +				 rec->device, rec->function);
> 
> As mentioned in 2/4 I don't think this is going to work correctly.
> 
>> +	if (!cxlds)
>> +		return;
>> +
>> +	cxl_trace_prot_err(cxlds, rec);
>> +}
>> +
>>   static void cxl_cper_work_fn(struct work_struct *work)
>>   {
>>   	struct cxl_cper_work_data wd;
>>   
>> -	while (cxl_cper_kfifo_get(&wd))
>> -		cxl_handle_cper_event(wd.event_type, &wd.rec);
>> +	while (cxl_cper_kfifo_get(&wd)) {
>> +		if (wd.event_type == CXL_CPER_EVENT_PROT_ERR)
>> +			cxl_handle_prot_err(&wd.p_rec);
>> +		else
>> +			cxl_handle_cper_event(wd.event_type, &wd.rec);
> 
> Why does this need to change?
> 
> Have cxl_handle_cper_event() decode the BDF as it does now and call
> cxl_handle_prot_err() there?  I think you could drop patch 2/4 entirely
> and not have to duplicate the logic.
> 
> Ira

Yeah works for me. My intention was to not disturb the 
cxl_handle_cper_event() as that was focussed on handling device errors.

Thanks
Smita
> 
>> +	}
>>   }
>>   static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
>>   
>> diff --git a/include/cxl/event.h b/include/cxl/event.h
>> index 5b316150556a..d854d8c435db 100644
>> --- a/include/cxl/event.h
>> +++ b/include/cxl/event.h
>> @@ -115,6 +115,7 @@ struct cxl_event_record_raw {
>>   } __packed;
>>   
>>   enum cxl_event_type {
>> +	CXL_CPER_EVENT_PROT_ERR,
>>   	CXL_CPER_EVENT_GENERIC,
>>   	CXL_CPER_EVENT_GEN_MEDIA,
>>   	CXL_CPER_EVENT_DRAM,
>> -- 
>> 2.17.1
>>
> 
> 

