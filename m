Return-Path: <linux-efi+bounces-1045-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEEA8C7BB7
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 20:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E4C1C21C3A
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06308156F42;
	Thu, 16 May 2024 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KsMyAiLf"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B615688D;
	Thu, 16 May 2024 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715882390; cv=fail; b=aovRBJ3mnc1Ad5YsfoFVv+XouRG68HoLwdLWVpgQ4sDYvESCxboBMUCXD5BiLiY3VGc6U2n4sREpgr2E2yuirfHB5NanTZNSf7P+tMGrrfE2EpboapD9FTQfsMsHtq2Fm2whr7ViPmc4dXnQbSjlZInr1GF0dVF4G1QitHK9ieI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715882390; c=relaxed/simple;
	bh=MNQCcEMeA5adg9bbh1CL9mhI/3WQQQwyngqsxEAMro0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=Ir4xMupAwACEkMz2hHik6LAyWjfKM3SFgy89T3cmnQfgYQRwqsQ7gL66PrbmrK9ocJiK7+EBgMpCcqIPzX9FZcf2b+BHHSZYWn+uL5WeJ4p5LMa+FwD3x6GZ1dyk8YOm6V34CccQDkHVZ8FcjUI/58xld8tel51XwyVF/TyJwTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KsMyAiLf; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U86s23RHwDuwuPBcEhn02lZXrQSgNEoWjPZOD1tIsIaDHhKeUH0/prDHznAkIvWXYQDf40HKxqDDYqiClGT0+8RflTJnnKhW1w5/Qo7cP9C8+p05NQ3FpnXDnzz9uJ0ahXF3npF86UeZ948kkZNsqhZQgTgov55SlpsVHzlhsbpNy11JHHqvV1kz4TzadBTXj/M9YNb7tbWScqxxj/B7VSAprknTvBH72rs3NnO6fwP53uc77Rk5vLboaaQP6p28YTwJQB7dIFitfj1r5SbNxiQnP5TEgTEjtBEwrR6agNlYcVEqR1J4nG/b854/0F+ec5Yb2U11uMm9Tdjd7uCAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX5XwwJ0S4J0mAj88ukJqqSPzxtb3uFrKzfAftZwczE=;
 b=VlIBGorPNezLKEAmP3nJRr/8y3d3ZeVqDPyypOivFzl1fos7EAPl1gXBeiE1j0roIs9jcOcWpUWlhNGlPi+PbYnjIK9C0IadPy/jskgPma0QY4yK1f/jnSjgA4Ft4eNFIvnzPzuUXzuB7HjMXQ9PkMzrcz5U941V1iDnq5QFju4pgqXTF427deY+UZCOic5vVI99nfSz2Pbtf4brsnMNYjly61emjjWbqGWrOYQpC/sX/GF9AZNcviquVsC2kwy1+/m7GURWFR8M5X7WAVSYfiGS2fPKcrhInWXU23SiIqRvmxRLlGWHPzFZmEm25Vk8uX6RK2tvrk+7wrVYX9RUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX5XwwJ0S4J0mAj88ukJqqSPzxtb3uFrKzfAftZwczE=;
 b=KsMyAiLfQdeW8opXS0XZ45QiMBiO18nlnwF957Mah6Qa9odvd2AhY9d9Imgf30EZcJc9B4Wst6hfiElx/XKvAsevY8E6OVALtR1GHJL6S/yn4XY0dvFpDAMD2dd9KEaTC6hoBt5Z68589j2SJ1phGXYxD2fKyZpxIbH57a2TuEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 17:59:45 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%4]) with mapi id 15.20.7587.026; Thu, 16 May 2024
 17:59:45 +0000
Subject: Re: [PATCH v2 0/4] acpi/ghes, cper, cxl: Trace FW-First CXL Protocol
 Errors
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
References: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com>
 <2649256.vYhyI6sBWr@fdefranc-mobl3>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <43ab39e9-c9c2-bfe4-7d1c-bad462221c9c@amd.com>
Date: Thu, 16 May 2024 10:59:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <2649256.vYhyI6sBWr@fdefranc-mobl3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0112.namprd05.prod.outlook.com
 (2603:10b6:a03:334::27) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 854600a4-74ef-404c-1ca4-08dc75d1f816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmhZOStxVElMbWw3azhoTll6WlgvWXNvWGFBZDFNRVRvOHZ6dnBybUVMdzcr?=
 =?utf-8?B?RDhPdW1PMDBZd2hxVEx4VmhJQWREbVhIRXA3dFdXYWdOa21HRkh0Rlhvd3lu?=
 =?utf-8?B?N0d0bjhMTExjVGFVclB0TEY1bGxGQWs4OFhKVkUyN21vNVQxcVlzZXZEVzVW?=
 =?utf-8?B?RmtPUHVKeEdTdnVuWitTcVJMbWs0TlVxM3JMeXhsUXcvVlhJUitCV293b2JY?=
 =?utf-8?B?cVRFY2MvVmtoakFnaVdNcWxoSWU2M1UyeW9nd0Zwd0ZtWDdjSlpkSjlmeGpt?=
 =?utf-8?B?V3VlV2l3clVpYVhJOEhVT2RrNllROW1VOEhjendSZW5RSHpXY05icEVXNEg4?=
 =?utf-8?B?VlFjTHZXY3VndnRzMjdZT3NnRmR5OVZoVW01QUI4Wk9oeU44RkI3anhpRHhW?=
 =?utf-8?B?UWNObVF1d0swZVhpOTFoSklNVGg5bEZrSFA2bzBtcnZPNHFzN1VmVlc0MHoy?=
 =?utf-8?B?MXBadk1iL1IyOWlJeng3TFN0MlE3U3FpeHZZbmVnN2hIaEZUM0NUVnNBdDBP?=
 =?utf-8?B?SHB4Tlo0WmEzdDdlWkljWjQ0ZUdkWWwreUZyRjh5dit2N1h0MjBkd1EwaWxB?=
 =?utf-8?B?enBsaXFwSmwvUXVLVjkvU0pnNmJtWUZiZU0yQ1psRDJPbVRoUWRocTdjaW9P?=
 =?utf-8?B?eTVsRVFheTY2Z3pCSzg2aFZ0NjNLWEtHVnFpRnF2TDFPbUZNZ0ZydWVBSk5l?=
 =?utf-8?B?S1ovOCs0dWM1KzIvOG8vOGh0MkIyTUszU1BvQkZPUFJSa3hsaGpwQnRkY0RB?=
 =?utf-8?B?MnZ4eTg1MldPSEUwcU96cWQzVzdtNlpoanhTdEFKY1hwVm5Ya240MFYrM2sw?=
 =?utf-8?B?NVhKaERmVko3ZHd6dDBHajhJekNBNS81dWVYUDk5OE1FYmtvZVdnTlY1d25R?=
 =?utf-8?B?UGVKMHBBeHQ2NmhqTW5mc1hJNE9aZmQvcC8ydkpRaEo5YkZOMkszRERJV1Y2?=
 =?utf-8?B?Q2VHMHZOQmFHTWxSajBWdGVIU0JpMjBEdVE1TE5YV0VyZ2I0dSt1RVAxQ3Bu?=
 =?utf-8?B?UksrelMzUWxUK1diNU5lQ1B5MkNDYUhPelVJWVJtVkt0cmladXNLMEpCRkkv?=
 =?utf-8?B?Vyt4ZFBqMUhkMFJrZ3I2MmlHQ3NMaC9ldGNSeGZUTGlYcy93N0F4MHB4UlI0?=
 =?utf-8?B?K0dndG1IR1Exblk5TVBiUkJtajdrWGZOREIrOEQvMW5WcjFVRG1vMHQ2dHhr?=
 =?utf-8?B?VjMyTDJWNFpzNVRGWjRvcWl3TzJHaVVldjFZWVY1eVZKTVdYMjZWaGhYV2sz?=
 =?utf-8?B?Z2JrczFMOVRNNVM5eGYveGp5VnB1STlZb3BYZkdzeURlNEt2ZkRndUpKWjFT?=
 =?utf-8?B?cGNuUUtBRWpKR0RnWDlPM2xscVJoaEpiRi80OUx3bExlaFVyUTJqbUNERFhF?=
 =?utf-8?B?RjN1UGlBOER5OC9aMW55SldVMlJ2OFJmWEFhMmM4MkNzdCtEU1MzQU80Vk9l?=
 =?utf-8?B?ZXFEbHM0NUpOejl1M2h4eXFXdmZkYjd2MXpnZWwzRUJzTG4wanZqYllSeHhm?=
 =?utf-8?B?U3Y2VzVTSkNzMTM1Q2EyVnpFM3JLV0dYTklrRnRJb1MyMjJLa29iSVNXTms2?=
 =?utf-8?B?Mnk5ZmdUR0pQMWI4OSswTGJJQnowMExqeFIrZ0FTRnFGVWdVMnpsWGFXdEVs?=
 =?utf-8?Q?wXrKtqF6pkRPCFdsLsykCLoSb3QYcas/SRgqf8+rYi70=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0JXcVJ5YVk0OHBIbTVhckZCYW5tOWFsOVNSdDQxU254cEdOREF3MzNOdFYw?=
 =?utf-8?B?UEtNYklRUExwK0xIaWRvTWZvY3VCWmZDRjNLVVROMDdhWGdab3BVS2tDZ0dX?=
 =?utf-8?B?ZlNseDZ3U0RuZ1NwYXNKMDNJbmpRZnNmRCt1U0hoMGZGdEhEQ3l3cjY5cFA4?=
 =?utf-8?B?LzVUeDNFVE40ZDBHcGlHNFFaWEkwU1VVak52OEpWRHFZVHpYNE1VOElIQnha?=
 =?utf-8?B?OHJwTGZQYTg1NDBuSVRkS2FsOGRSR0hxa0pySWJRV0tCRnkwT0w3YWlvbTNy?=
 =?utf-8?B?L2VZSmI0T3V3YnJjdFJFWUJkbnVBNGlLTGVjYzh2bzdBcFpWYXVpOTZRb1NX?=
 =?utf-8?B?SkRCZy81NTdIeXdnUDVXdGtYR1c5bDNzL0k4a3piYkhUdGZFUmpKc1d3RlBq?=
 =?utf-8?B?T3dndCttb09BSGlFZ3hEeFVDcy9xZXFDbjdnSmpGaFQzc09LWTJyaW4rNXo2?=
 =?utf-8?B?N0hLTkhLbDByeUV4eHRqS21ucWFwWVBqSWErQXdBOWRadUVsVWVxVkNqTVhw?=
 =?utf-8?B?cmY4YXE4Q0FmZmJzeGx6UFRBOXhOcHU2L2hFektaWElEcTJ0Ty83VzVMRVJY?=
 =?utf-8?B?L1c5MWtESEJVZHdwRjV2djl5eWNyVVpOUGtLU0E1djhxMkhLakNpNlZvczdD?=
 =?utf-8?B?b1Q1TGRXWkxBTXRXUmtDaVVsMEhVSnp6a3NLcWNpVjNqQWNLYzJIZTNxQjJI?=
 =?utf-8?B?Ri9MTi9tUEkxYzlJN25BN0Z1N2lYMVMxVWYvdzN6L040RVBiK0xqaENrekI0?=
 =?utf-8?B?dzhxWjUzZXVUaDNSbWp3THkwMlNiZndLWlRlNkxNTnBVVUR3ZHhyRHYyNTMr?=
 =?utf-8?B?KzVKVXNoS0xWY0t3bXM3NW4wNHM1cGg3Y3czZDVLVllSN1ZkUG9vWTVoc2dD?=
 =?utf-8?B?OTlGR0hMK1ExdUdZYk0yT1NPV2FTa0dWQnNJTmY3ZUZ4NFNXdnRRbksyZWZn?=
 =?utf-8?B?dFYyZ3B1SURaSmV6N2VLNmMvZHdVSC9sM25vOHRZYSsyVE9NZVowNzcyTVEv?=
 =?utf-8?B?cmcxWG5jRDlQbmNpZTQ1Vnh2SEV6RzdxU041K1N2bjA2NVJ2aEo1cFlxQjAz?=
 =?utf-8?B?d1I4eDUzN2FWL2NZZ3hpNG9TTFYzN09KWDA4QWMxWXZiMGJ3TWFEZUlsQ1o0?=
 =?utf-8?B?RS85Mks2end4bkZyTDI5SUFsUGgxMGJ3UitlTU9oT1cvMkVhK3BVOXlKbkhF?=
 =?utf-8?B?aUhINzcyV1h6amE4b0VoN3o2MVpqM01DMTc1OFNPNGIzeUlMUXFmK1p5a3RI?=
 =?utf-8?B?SWdDcVptTnF2OTVBVzU4YjdXNmxuQ1IyS3BLWGtJTi9VaVg4b2NSeVJqbGZU?=
 =?utf-8?B?NDR5Ym45aFRtcUpUencrMjMxN25FSHZuaUpYeG5XN3Z6VlRlM2MwdmNUaGUx?=
 =?utf-8?B?MEwxS2wwM003QVU2SU5pZER6QS9SVURuOFRlMVlkcnhOTlBlOURqN2FxVGxJ?=
 =?utf-8?B?dGRKR3JsSldSbHhLSTlHU1FVMDF5enorL3plaVRrNjlwR0ZmK2lha3pwNkNP?=
 =?utf-8?B?Nkd6VDhyWVlnMmxmaUtvaEh1Z3FYWCtNbzcrQUdsL0tzT0RlSVpiUm51bWJD?=
 =?utf-8?B?WTdtNWFUUDgxVGdKa2FmeCt5L25CSU1YelVKUFlPbi9KY200SlpkTmF3SWt0?=
 =?utf-8?B?YzBwWXZINzlKMzZUL2JvNWlrME1sMkEza2lZbmk4TzdGaHBUNTBMT2tqNjF2?=
 =?utf-8?B?WWExTDFuaXhQTkYxS1J3bEVuWkwvODhCNkZSK1Zmdkp2Y01hVzcveUJKd0tr?=
 =?utf-8?B?Ukx6K2pHTkIzdXJoUHhzWjNLUDhlTmN5RWNpd2tkd1REaUZZalVUN2tkRXhk?=
 =?utf-8?B?eElPMytrd04zWG53a0JscjdDeDNoaVBURDkzWndYN3kvS0QrdytzQUdNWXdP?=
 =?utf-8?B?cnJsTTBud3dLVGViZXp5STRTSUh3MzgzZnZNSmxoMEtxZDJrYmg1SFlUSjA5?=
 =?utf-8?B?cjVJc3F3eWtiYTZLSlYvOG0zdWcvaUxjV1BlSFBWMmFlYjBpUTk0K3FiWHVZ?=
 =?utf-8?B?a3FJcVFWamNWSm9KQlNEN2pKR0MrVnp6cVRuN09VREowdGJwSFczVlE4eEkx?=
 =?utf-8?B?VXMvREx2Y0lrcW44bDBQQmtVQjdwYzJKUWZPWWZhZjUzY1FoZ1lqbTJ4UFlO?=
 =?utf-8?Q?YBZUEw8Dcvs36tGDMaSxEVxxy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854600a4-74ef-404c-1ca4-08dc75d1f816
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 17:59:45.2210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwZawdmrZARe9zNqlt3mE+d/KdA3Utt6VT/c6Zg8/EubL5bcg/0oluP9wUDkRltx8zMFvleceO+gH8yu1dDJbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968

Hi Fabio,

On 5/7/2024 2:35 AM, Fabio M. De Francesco wrote:
> On Tuesday, January 9, 2024 4:47:51 AM GMT+2 Smita Koralahalli wrote:
>> This patchset adds trace event support for FW-First Protocol Errors.
>>
>> This series depends on:
>> https://lore.kernel.org/linux-cxl/20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.
>> com
>>
> Hello Smita,
> 
> I'm working on a small series of enhancement and additions to kernel logs and
> trace events in extlog_print() (ELOG). I'm interested to reuse from ELOG the
> infrastructure which you made to trace the CXL Protocol Errors.
> 
> I'm aware that this series depends on an old one from Ira which has been
> superseded by a different implementation and, furthermore, that this needs to
> be reworked   because the execution of this code may sleep while in atomic
> context.
> 
> I'd like to ask if you plan to fix and rebase this series to a current cxl
> branch. If so, I'll wait for the next version to integrate in ELOG.
> 
> Otherwise, if you are not anymore actively working on this series, please
> notice that I'd be glad to help by making the necessary changes and by porting
> your code to a current cxl branch (of course, retaining your authorship).
> 
> Thanks,
> 
> Fabio M. De Francesco

Sorry missed your message on my inbox. Yes, I will get back working on 
v3 on this early next week. Couldn't get a chance to continue due to 
other pcie work. Hopefully, I can get something out next week.

Thanks
Smita

>>
>> Link to v1:
>> https://lore.kernel.org/all/20240102150933.161009-1-Smita.KoralahalliChannab
>> asappa@amd.com
>>
>> Smita Koralahalli (4):
>>    acpi/ghes, cxl: Create a common CXL struct to handle different CXL
>>      CPER records
>>    efi/cper, cxl: Make definitions and structures global
>>    acpi/ghes, efi/cper: Recognize and process CXL Protocol Errors.
>>    acpi/ghes, cxl/pci: Trace FW-First CXL Protocol Errors
>>
>>   drivers/acpi/apei/ghes.c        | 22 ++++++++-
>>   drivers/cxl/core/pci.c          | 29 ++++++++++++
>>   drivers/cxl/cxlpci.h            |  3 ++
>>   drivers/cxl/pci.c               | 13 ++++--
>>   drivers/firmware/efi/cper_cxl.c | 79 ++++++++++++++++++++++++++++-----
>>   drivers/firmware/efi/cper_cxl.h |  7 +--
>>   include/linux/cper.h            |  4 ++
>>   include/linux/cxl-event.h       | 31 ++++++++++++-
>>   8 files changed, 166 insertions(+), 22 deletions(-)
> 
> 
> 
> 

