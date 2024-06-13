Return-Path: <linux-efi+bounces-1217-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EC1907A35
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 19:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC681F25BC3
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAF914A4FB;
	Thu, 13 Jun 2024 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RGlEZ4NU"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEE71311B6;
	Thu, 13 Jun 2024 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300855; cv=fail; b=OJ0pBBXu01jzGMs2NYOuAf0Vb+qpKjsVgZGPWupHBFRoQAidHwCh/LlbAEn3nH47IcfWnpr4wXgu6id4zELqX7CtqrBZ+CVstta+yKwskzJ4eBVT0La22v7ZpLbBiEpqh9wRmWCo2vwNYGgtlDivVtuO4/2z67/0qp/3LVVezsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300855; c=relaxed/simple;
	bh=KroFyhsAFv4t/bM2xiKhylETPMF3MbrVJOygo49SMRw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=taK35EyzLW/s8Q7u7YueqTKU0uPm9kRUvsrILuJDygkk9UATrwToTijQEWvKGrzKYmLeB0+195Imp97GboS59yde6jkhxE7c2hEoNNFbzML6/mleTP0/LmyqRYO5WYgvYlCSD96JVyWI0CazrcIWjg5LZMOuhEWRxyeqVGNO+xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RGlEZ4NU; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj0E3aAhxrtpk8NI8XjW6N4jFMVVFko4M3MWVAYCnVkL0YRIPwcDsHWZrDUdO4uYNr1UKBm2NmLcExH1+c2g9Z2DwRJh8KoQuUj0x3iSbBl/F4ef6gYXZhbJpjOhsqbAG32kg7UU65DeStUW6UbkVF6zLxxIKb6UL+iSDyG/Z0xeyXBe0RlYP0TY41X4MuoNk5vviaJq3OFxEfqBatYDUiJhPGjqHtxrSOjmM2C/DLUsBWksnG2J7uWMH7CmkE8ChNxkKKxzjMCKETiy5pzfE7k5pmBumsKaMl86EAHtCwoQAEYgITpzMemVq4WMcEt7KX9YoRhNW8aT+XYnX74eSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNfJdgqwE2GlBuI7qI4OzGxAh37wsRefBnsMbx4wN7M=;
 b=cdmVDLsQiW7o4Z5FyVAkkZLEU97mq82aSRsdMN9OglePVfdus2vh7mblvvwoaDfbGSDktbh8F4V8wsAVGVescJoGfY5LViWyddB7VaXIXmErZvr4YP86OLcvbBUTXDeVtDoYQjtwba+HrSJ2nGgHNPfNh6fux7NjTvBYuDn7ms/nXWPolTsfYEtO/NA7efica6NmSog7r6HxcMzOer8d3oex6XU8YCRjxjx+rh1pzbAjYM/dt0iE1VfL+VInh6mGpHy6OInTrBJOTbmA09jR5Qkzi4/eTWgLe/T45uzQhxG1cMNFz5nGX1ld3vk6bKEYY2pJ4SIc7Ft8QsYXPnQw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNfJdgqwE2GlBuI7qI4OzGxAh37wsRefBnsMbx4wN7M=;
 b=RGlEZ4NUepn4CkhmSs/irGQ8TxT/ei+yuf4tJs5WUF/nvdY0oi2/oFAVnVQlU7q9WS1FgcGviJ067pIewHaIoIe7N/9VsX9iYlSdOj9ZtfCN/orEUN5P5Gj1r5L820IvJ2qXkhE8yfou+fBhfpSQW97QQLIDV8E8OYS1R9hZ0Ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 17:47:27 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%5]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 17:47:27 +0000
Subject: Re: [PATCH 3/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
To: Dan Williams <dan.j.williams@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-4-Smita.KoralahalliChannabasappa@amd.com>
 <6668e6d28e9bc_310129473@dwillia2-xfh.jf.intel.com.notmuch>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <73a9acb8-92ba-cad6-3dcb-d2479939db99@amd.com>
Date: Thu, 13 Jun 2024 10:47:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <6668e6d28e9bc_310129473@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::23) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: b77e6bcd-d8da-4b1d-1c89-08dc8bd0e3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXI5N1B4bk5qTm4ySHc1bCsraHlsZmN6RHJJRFpwK29iam9yV09XMTNlSVpK?=
 =?utf-8?B?NHZRVWNhVG5kTStNWWxlbEdFc3cxZm9YV05tVVZkZkVMV3RVRnB3SmlYcjlV?=
 =?utf-8?B?eHhEY3lpbXNmbERtUDBFQk5nTnlWcUJuOXJkZzBNL0V6RS9XY1BlSmJ5MW1t?=
 =?utf-8?B?ZUtJYjZrMzVTTmVkVERaMGR0Wm5wNXhyOS8zWDl1a09DZm9wRC9JeVd2MGha?=
 =?utf-8?B?UXV1bUF6eWg3bTZrMVBERlFaWFoxRVprQnM5VzVMNEFmYTgxNmcyZXhUOTRl?=
 =?utf-8?B?NVFSWFljbnpyZ25mRmU1OVY1eVp2RTNWL2tHbDY3S0tlQ3VQaHlhY3Q0ZHBR?=
 =?utf-8?B?YTFKUVU2M213Y3ZRQ0FXY1BYdFRNaXR5T1pZa2FjL2JNbEVuNENtMk5qYXRU?=
 =?utf-8?B?OHZ0SXZEU3A3WkdtTTl5bTlNL3dOY0pXU0FMVHpkWHY2U0tCQTQyU0pveDQy?=
 =?utf-8?B?dUlEZjIrNHpheXZSQmRnejNkZlVZQ3hlRGU1L2Y3d1RCZ2FueDFWSWUyVVRa?=
 =?utf-8?B?S1YyREU4OVBncmdZdUl3Q3VYVDhlTktDZ29jbDV5WG96MDdlbDM2K2o3OFVW?=
 =?utf-8?B?Y09aVkFsamttcDAxTXFGT3oxMjVOcitvNFFnWmdqc0Q3UkVnZThKeUpvWWQr?=
 =?utf-8?B?b2RpaENJRndwcnE0b25vbmZob2dQR1gvODlselNZVjhDNmVhNW1hbU5uWm1Y?=
 =?utf-8?B?bWRoV2xjTFZBb0UzVlk3czBzZDRUbElrNlVLcjZUZ3l6aGpGd3ErZm91ckZJ?=
 =?utf-8?B?aW14M0Jqa1AwTUtxbkVhVjlxTnYyczM5SUNwWW1tOVBoV3JSaHJIbktYcXFk?=
 =?utf-8?B?NXA1YnRYUDR1LzVLR0QrVStZZ3IvT3hrUnYwUGhyZnh0eXE5NWVqdTJ3V1RU?=
 =?utf-8?B?RThvdmdNa2NpMkljYVVvMTNvY1N4dXdwSHVWZGg4UGUwYzZ5aXI3TkxnWmV5?=
 =?utf-8?B?ZnlWa2tpWGJoRWU0WUY2U1kxVTNsS2RIV0srM1k0a2JHSFJSZWo3Qko4SkdC?=
 =?utf-8?B?aVpkU0RqeWFUUGVmVHMyaFp2TmRFQ0o5azJHejh1WGhoMVkvZHhiTHk3Q2J2?=
 =?utf-8?B?dDNLM0grRUVSOGZ0OGlTMTdaSENpUlkzbGw3aGpwVnZldCtTc0wxRHA3bUlL?=
 =?utf-8?B?ZGJhMGRSaUV4RnpvRk1EZTFiNWxQazhrakRteVBCaDFEcFJCTXpIOHF1NFFZ?=
 =?utf-8?B?alpuL2lxN0pyK2c2TTU4UnYvVlU0WVJINkdsdm1MWVlQaXFLTXFXaXFqRTdt?=
 =?utf-8?B?VDRnZzk1Y0Y2blVhdlNDUUJMNUJCWTNTZjhGbXJjSXo5MGExcXlXNHNzWUJS?=
 =?utf-8?B?b1ZkT3V4YTlYYWV4aHY1dUNMYTBOMUhyNGkxMGVCbndLWXZiUWlpc1pnTTE0?=
 =?utf-8?B?UlZZNXJQWEFZRkMyMjIySlNYZGtWV1NHZnpFVENwbkZ1UmFJNTFJU3lKTUFY?=
 =?utf-8?B?dUpiYytzRytoeGZ5QnIxb1JOb2lnSGxPVHZNbm9VNGV5bzNWUDRsQXczUzdJ?=
 =?utf-8?B?OC84TEpVbFVmV2hwdGhlUkMyTG9wV2Q0d0FURG5aSTJrOERuRUpZdXVNNFNM?=
 =?utf-8?B?ckY1am1pb0NpMCtXWlhFTk03N3NuQzRZeEgvejlhcDN1RXkzYVMvZkNmTUZR?=
 =?utf-8?B?M1M5N0RzekF2MTFkVDZDRzBoamU2amt0V0lnMTVmTW9ZeDdJMXdPTUFHc0tk?=
 =?utf-8?B?TVRnVEZJZisrSDBreUZIdExYZ2FMN0UwWnVQcTVSbjFScEtLOFBtYm5NWkMx?=
 =?utf-8?Q?EFWDuA/xMVGGfADEz543gsMkTKWrI4c6aJGUtsa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHJFZ2NaSmZrbEJzV0VRNU9rQTludGYvNFZibVRZRXZvckdZZmdZY1UzbHdz?=
 =?utf-8?B?RWYzQllleW15dWlLM3g5UTJVZ2RjYkMxZjJ2ZFBaZWE1U052T011Y0I0Vkkx?=
 =?utf-8?B?a1BBTUJ1dTBoMWVNWXJBVkkxZkRuMUlTNGdwRmJQRzdwZVB5VkJrVWxVZHVq?=
 =?utf-8?B?M2tEeVA3MU1WUDlWSC9wRUpxeTYyVkNXU0ZlMnF0ZFZML0VIWUJHNmZ4N2cw?=
 =?utf-8?B?M001KzlhMWU2QkZxejJkTFhEa3pwZHVFNWl3UGhtL2NGdG1QQW9vZ3k1b1N2?=
 =?utf-8?B?S083QkszK0VUVkdFanZsdy9RaWJmR09mZmtLWElmaHkzWWZXanBHUnBkSUx0?=
 =?utf-8?B?eWpubHB1WXJIeDR5WG12OGJCSEwwQmpzamdwOUR5Nmc3SWgwUTdCQldFWlRJ?=
 =?utf-8?B?ZnNFRlNjZmx1WjlCWmlBeVFPNExnSHVKcE9NK2tHVmhaTDVDZkVxZCtsY0dl?=
 =?utf-8?B?NkFraE5UK3VZMkxOTTVGdXZ0TExvMWM1UHprMU9VUjZyVFlYT1hCRjMvSUNh?=
 =?utf-8?B?RXE4VkZGWVRib3lDTzFoVU5pOUlkL1RYNU1kTkUydDdCWGZYak5XOTVhWXVD?=
 =?utf-8?B?OEtzbEdESjlYSWxBTnpNNW92cnVMdkZQczVwRGVPSVMyenRpeVlIR3prRk54?=
 =?utf-8?B?dE8wTGdIRkFEVFR4TGlTQUhRc1JwL0E0Y0cvL1g0UzlUd0VsWlZmYUVlRjI5?=
 =?utf-8?B?L3NYRUxHOEU5Y0tsdTRDRTBnRUhrOGFla0hLekFoWTdYUlozZUFjUVBlVVA4?=
 =?utf-8?B?eVc2SERpeVFBM08rUVphZWJiSGtJRDRZY0ZrdXNNRkZUQy9FRURDMVVvUUQw?=
 =?utf-8?B?UEtnRjMxOVk2SkRXSFdyNEw5M0JHZTVsV1RlZ09KY2FSRGlQaDZpLzNrbzFk?=
 =?utf-8?B?MUpTemtpOE1sY1Jaa2k3WTZydjJKSWp6OHZKQnRhbDJSeVczSmliTzJqaGIz?=
 =?utf-8?B?MWt6L2szL0pCT2JIUFlVQWpzUktLQllXVERZMXZydXRENWlFd2xlUkVrZ2pN?=
 =?utf-8?B?dXNCUmIydTJHV3Y5ZThIZ1phdER6TzRQelNDUEJZU21XaXVEZnhpTUxhOHM0?=
 =?utf-8?B?bThZZ0J3ZWE1eDhlQmZKU2ZmTEdPNWRyU2xNRmhiZzdzWmZpcW1HNzJ0djdT?=
 =?utf-8?B?YWtJN1RTcTd0NWJBOUx5eWlKd0lUemJIaFJZQ2JyRnFxSTZGcE11Y1NrVEpM?=
 =?utf-8?B?V3EvZVB3S1RpeG1uaDcvU0tOallTdGpkbEtFbWpHZmdjY3hhalB1ejBuc0c3?=
 =?utf-8?B?cGtIWlY2MmhONTJhdDJ0NlBvTUtpeGFuM24vKy9ETU1oOXU4Tm9lZjBScHFp?=
 =?utf-8?B?Ykk1M2xNeHJXOGY2THZEdXQ4WjVPWEExT2tBMkorek11YmRWVVR1MG9yMGtT?=
 =?utf-8?B?V2N6amtJN2Y3Q25KaUNmeU1zZGRLMGlVYUpoQWRjWmVQMXFla1JBQjlhT2dR?=
 =?utf-8?B?em5ab3B0S1cxSXFYQ2d3L0FLSFE0cXF6NUxOcCtlSmhUSUtTMlBnd3BGL3p5?=
 =?utf-8?B?azg2ZGVZeVhnckhUUHVmWGo4eHlmVlNoTGNhQlFxUHY3SmdHMmJxbzVnSEtW?=
 =?utf-8?B?L0ZxeHlJUXFtdDNORklaVDJnRVJ4T1JBc1psOWtML25yUk9uU2hBY25RZ1dq?=
 =?utf-8?B?WG4xNURENUxPVkRSOVMzalRUb2ZvNGVIQjJHL1pzdjJqakliTG9Ha29OeXMv?=
 =?utf-8?B?MmxXS3h5S3libTB0NndOdjEzR0VQaUhHZTBtYU1JaXN3UTJWZDBMSzQxMjZY?=
 =?utf-8?B?amkwNmhyNzJCSjNVK29YMk9UcWFQN25mazkveUVzMmZyMzNPdUJ5Y3Zsb3J6?=
 =?utf-8?B?dVJaWlYwS1ZlSy9JemZtblkyM1hxUDY1ZERFRm0vaVJXcEFaSnpMdGtaR2Vi?=
 =?utf-8?B?b0svaFRJeE4ydkhRai8rYkZUb1NvUmpXQWFoM0VKeFdydGFjNkJ0czdpNk9E?=
 =?utf-8?B?ZGRHSGlXYmp2ZDlDYTJ1a001aUN5ajNHMk1HZmlWRHRIZEVGNTFYVS9nc3FF?=
 =?utf-8?B?NTY0KzdKUHBMK3U4TTBKaWdnRUdrTi8zNzhYMWR2UGxuV0FQY0FhclZhWk1E?=
 =?utf-8?B?ZkhOT1lIUGc2VHJKcnZKNG92b0xxNDhtTjJSczFlbW1QdmtzQlErQk8zWTNy?=
 =?utf-8?B?YTNyekdaaVBZaEppS01MSmRERmVFREthZlZvcWQzSGlLVFNoN3MyRU52VFlo?=
 =?utf-8?Q?AHsWyUUCIMgC0ehm2yCfJ0fTR2WU0klT9bYy8lRXvYw3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77e6bcd-d8da-4b1d-1c89-08dc8bd0e3c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:47:27.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DxYB4cslFNXM/dR1lCqf+DcoXoZJj1RP/PhIbIE7SIA9GZbOXPLGVBxK9Dqpf9jZWkmbz/1GgdLvhngmIhMBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383

Hi Dan,

On 6/11/2024 5:07 PM, Dan Williams wrote:
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
>>   drivers/acpi/apei/ghes.c  | 14 ++++++++++++++
>>   drivers/cxl/core/pci.c    | 24 ++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h      |  3 +++
>>   drivers/cxl/pci.c         | 34 ++++++++++++++++++++++++++++++++--
>>   include/linux/cxl-event.h |  1 +
>>   5 files changed, 74 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 1a58032770ee..a31bd91e9475 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -723,6 +723,20 @@ static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
>>   
>>   	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_err))
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
> 
> This seems wrong to unconditionally schedule the cxl_pci driver to look
> at potentially "non-device" errors. With Terry's upcoming CXL switch
> port error handling there will be a native path for those errors, but
> until that arrives, I see no point in this code trying to convey
> root/switch port errors to the endpoint driver.

I see okay. What are your recommendations on this? Just confine it to 
CXL RCD, CXL SLD and CXL LD? And then extend it to ports once Terry 
sends patches?

Also, I'm not sure about FMLD. Should we just drop it as of now?

> 
>>   }
>>   
>>   int cxl_cper_register_work(struct work_struct *work)
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 0df09bd79408..ef9438cb1dd6 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -686,6 +686,30 @@ void read_cdat_data(struct cxl_port *port)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>>   
>> +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
>> +			struct cxl_cper_prot_err *p_err)
>> +{
>> +	u32 status, fe;
>> +
>> +	if (p_err->severity == CXL_AER_CORRECTABLE) {
>> +		status = p_err->cxl_ras.cor_status & ~p_err->cxl_ras.cor_mask;
>> +
>> +		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
>> +	} else {
>> +		status = p_err->cxl_ras.uncor_status & ~p_err->cxl_ras.uncor_mask;
>> +
>> +		if (hweight32(status) > 1)
>> +			fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>> +					   p_err->cxl_ras.cap_control));
>> +		else
>> +			fe = status;
>> +
>> +		trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
>> +						  p_err->cxl_ras.header_log);
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_trace_prot_err, CXL);
>> +
>>   static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>>   				 void __iomem *ras_base)
>>   {
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 93992a1c8eec..0ba3215786e1 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -130,4 +130,7 @@ void read_cdat_data(struct cxl_port *port);
>>   void cxl_cor_error_detected(struct pci_dev *pdev);
>>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>   				    pci_channel_state_t state);
>> +struct cxl_cper_prot_err;
>> +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
>> +			struct cxl_cper_prot_err *p_err);
>>   #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 74876c9835e8..3e3c36983686 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1011,12 +1011,42 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>>   			       &uuid_null, &rec->event);
>>   }
>>   
>> +static void cxl_handle_prot_err(struct cxl_cper_prot_err *p_err)
> 
> Can we call this variable @rec instead of @p_err? The data being passed
> is CPER data which is a "record" structure.

Will change.

> 
>> +{
>> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>> +	struct cxl_dev_state *cxlds;
>> +	unsigned int devfn;
>> +
>> +	devfn = PCI_DEVFN(p_err->device, p_err->function);
>> +	pdev = pci_get_domain_bus_and_slot(p_err->segment,
>> +					   p_err->bus, devfn);
>> +	if (!pdev)
>> +		return;
>> +
>> +	guard(device)(&pdev->dev);
>> +	if (pdev->driver != &cxl_pci_driver)
>> +		return;
>> +
>> +	cxlds = pci_get_drvdata(pdev);
>> +	if (!cxlds)
>> +		return;
>> +
>> +	if (((u64)p_err->upper_dw << 32 | p_err->lower_dw) != cxlds->serial)
>> +		pr_warn("CPER-reported device serial number does not match expected value\n");
> 
> Not much the end user can do about this warning, I would say skip this
> message, or make it a pci_dbg() because matching by BDF should be
> sufficient.

Will skip this message.

Thanks
Smita
> 
>> +
>> +	cxl_trace_prot_err(cxlds, p_err);
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
>> +			cxl_handle_prot_err(&wd.p_err);
>> +		else
>> +			cxl_handle_cper_event(wd.event_type, &wd.rec);
>> +	}
>>   }
>>   static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
>>   
>> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
>> index 9c7b69e076a0..5562844df850 100644
>> --- a/include/linux/cxl-event.h
>> +++ b/include/linux/cxl-event.h
>> @@ -122,6 +122,7 @@ struct cxl_event_record_raw {
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

