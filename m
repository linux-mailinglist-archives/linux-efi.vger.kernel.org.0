Return-Path: <linux-efi+bounces-2495-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3288D9FFFAD
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2025 20:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2433E3A3CBC
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2025 19:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7451B218C;
	Thu,  2 Jan 2025 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="phkjSFGn"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B387E0E4;
	Thu,  2 Jan 2025 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847577; cv=fail; b=bdpPSN3xOflf3PNWt7W5rtEGbt7ioUMbEcZXGdgKLzIKQUy2WPl75gX8M76aHomS9/fO03NriMn7Ty1WgxVXEObtQAJDN+8+1RH45mZyrSNASO0YyzTWg1eN/kzL/+YqzsIhHAFV1IDtlTrhPMHlwMu7M5oivUZidhn5zoUGb08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847577; c=relaxed/simple;
	bh=q7zXnax5h2jYNVLFLPZ+2mKaYW6UDdo/dFl8wP5V5js=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g9zCVRnl139KMiwHHJ5I1BR62PTGW9pYiotn8RlRXKJPWg1N4wrfbvKyqhQ/vqBiVUR/jaHR+Jb2/Z5kpdzmPhT6d+SPFhULejsKbA2teet+S+QgVHobirkoeBy5GTFuKkD8wePqLWULBXQuMwdfyHixFaoB7qDE/GS+Gednm6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=phkjSFGn; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rawa6AsEZdAPj0Ixc5pd8p0bryVnXvrR1RCvC8ur1cdHHIOeU5T94vxd4mu9yymDM0zIRheaDerhsBMdErLlMg555ZRAr+XMyZd3ica/ap3Is3Q+MhBcVkEBamx1ZCpEnq+fX3cKOYXpEtefBrt/XRvOLs9DlGMkUeW0Z4SCNU7Ngj/cArKW2YDO9l22dabe9gWpTafqgxeLdJHovgzyNZZMBgnsz2DJ8Y2hFPxDBYNzOtqnM11UscWNGZtq+CA9YaJ6B6CZMf+G7yKQxawcu8mYuzPt8hpPJWpZ/G6kIMN/G9owzm+zG+QCFxVkLNlEzwU35sr1MhT1hHjX7hkwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPUd2aKKJOruTsri5K2FH0kM0N/I0Sx/xebxgL4uZ8U=;
 b=B40sfQHYSOTZF+W1PaXrimFRSvJU9b99PqXGT1yf/tGSb1AI2RVJcJcM/SHYjgTo+B++h2hfdfwzePnXQdDrri0vys3ARR6XBGaMp11mTt4jhfTZcH3F4b/u8tFMOKRtXoyP3dfOZZWCh3er3D8nZZJUGOOT3GR+hbBM9f5oDgkdve2wU9OVnA8APDj0Q/bMk5uM/shxiGZp9Xxfa91ilLEjHmYqPQr/iNBEQzcNF/BOJRWX+Scy90FeAuIAbQ6lvEA/nOz1jXuwze0kadkiHHpv0isr/gRXhCxwWfF5IuHlnxpzBeWwZvJzMsyPtTAgPT4LC05+d2W710Cn0va9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPUd2aKKJOruTsri5K2FH0kM0N/I0Sx/xebxgL4uZ8U=;
 b=phkjSFGnP33B1DpRN4zhyyHAZK2IB4aqII4uNUgt58urvqHeafi/vAwjxGTWWLQeMaD8Dd5w8ECWUIdUKZAogP8xw1rRlVkZzb30XIpzFfYP3pPBN+VgmunwaTcz+4qOswJ1CPGoQ8P/trYpDpNAP61CBQsV3PjIa26/n0X4gAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 19:52:49 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%5]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 19:52:48 +0000
Message-ID: <a97b760a-ab43-4974-b76e-e0da344496f1@amd.com>
Date: Thu, 2 Jan 2025 11:52:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] efi/cper, cxl: Remove cper_cxl.h
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241217022032.87298-4-Smita.KoralahalliChannabasappa@amd.com>
 <20241224181037.00003ea4@huawei.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20241224181037.00003ea4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::41) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 3367f971-422e-4bd1-ec9e-08dd2b6708e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTNVMUZUVzBBekw5Q0RVQnBZbmRoZGlqOHN6U1d5TnR4dDc2TUYyU3VqaDRU?=
 =?utf-8?B?VmtoVUpxWHdqL0gyWXltRGl1SUJnOWRzNy80aTU2eVF3Smt3WWpiUjBmL2pn?=
 =?utf-8?B?ZytrRkllaG91NTBySm55LzdVcmNVUEkxUWY0WE4xQS9KMlNhK2w4MUNyY1N4?=
 =?utf-8?B?NTlSTmZZaklkb09ZVjhzb0xqRFI4Q3QrK1dpY0ZXWlpCQnNZOVlOQ0ozSGdl?=
 =?utf-8?B?eXJLSTVPbFZtbXoxRlV5UVg3ZW44K3ZSZ29JblIvT3hBMVptODFyMVFOUnNQ?=
 =?utf-8?B?NzVVbmhUaFlweWMzemJMMkFjbzF3RU0rOHF3QmtzNWhZY2tWUy9VVEs4ZWM2?=
 =?utf-8?B?ZVpkR1hDcHU0OTdScU80OWtUTS9iQ0ZLMHRLQmV2YmZNOVMvZUtiNEJQNTJu?=
 =?utf-8?B?YllxQ0VEWlFralZNU3pwNm5QK1lmU21IOEp3WXdoVHM0YXAwSzJHazlnckVz?=
 =?utf-8?B?QitDelJtTkVzelRHMzZuc1RmK1ZseitBTnYyK3pRd2p3Szh2NERmRms3NUpZ?=
 =?utf-8?B?SHNYU0FZd3QzUFRQbndQWkxIOEN3amNaWHp3Vkl5Rm9vd0ViT09ta1FGYmZN?=
 =?utf-8?B?L2llQ3ZFbWhrZXE4bFdMeXVDNWJOOXVZZWhaZlFGME5FSnIvT3ZMUG9FSzY2?=
 =?utf-8?B?VUtqenhwVS9Fdldoa1JMRDhZdTd6emdOWXJLT1Vlc0RLVVlHWGRUSkNkVVFr?=
 =?utf-8?B?bTRKOUZTRHY3SFpHdnJMUUlBZy9hRmFORWdGdWlBN3B0aFpLcCsyejhZR1JX?=
 =?utf-8?B?eGV4SUlCL0F6Q0twT3huUVVqaDdGemw1cXhKVHVkL21SVkxnWWhFZDhqS2to?=
 =?utf-8?B?RVgwSGpSd2xXQjRoZkpPRlNKdk84S041eDBscWNqSDNVNGw1Z0kzU0IrNEhF?=
 =?utf-8?B?UDB4YkViT2RoNjJjVjRIRTA4cjRJd1dubUxPNkd2MDl2bGFYejBoUlJ6UFp5?=
 =?utf-8?B?d25yaWdBOHM2ZFNlekdIaHRaUEZkU25BSnJVdit3VGxSNmF3dTl1NVJsV3J4?=
 =?utf-8?B?TUFPM0ZMMjNiYll3MTNrQlhMbmFYMXVGUXJTZ29jNTNUTXVCV05tM216NHcx?=
 =?utf-8?B?QWZwRGZac2hZbURrdS81ODlwQzd0d2ErNlVJd1BBS0lxUFRaK2xLeitZMHd5?=
 =?utf-8?B?Q2VDazl6TVBlMlFGMjBHMzJyQkRzZVZibzhsZ05xSGtKeGxlUGdvY3hGUzVm?=
 =?utf-8?B?MkN6V01PeEJLVEcwSCtvSG5FYzRsK1R2Tk4vOXMrMjZLK1FxR01hZlZFczln?=
 =?utf-8?B?Q1VEaHVEQVRTcjAzNUdaYlVZN0VkWSswcVFDYmZGQndla1czZ0s2clRNL0VM?=
 =?utf-8?B?SzhQbVRhcFpxWUhmUnJ4cmVFZ2RjZTg5VFlIVUVQazF3bVI5WUNkblh6cnht?=
 =?utf-8?B?bFpmMzQ0K2RzTmM0cHorU3pEa3FxL2F4M0lQZG51ZHhweUVjMHB3SVR4K0l0?=
 =?utf-8?B?a3RDYjhBaktrdytXRXpGNSt3ZS9SOGt6LzlmQzhla29zVEpQYUVmL0xqOFdG?=
 =?utf-8?B?bm9XMHN2SkxXb0dQTVB6SFhTeUMvbUZLWTJKNE9tbWZlQzV1ejBGYVVFc2l5?=
 =?utf-8?B?R1pUZ3hHdm01ZG51UVhlY0tvTDRydFo2eE0vN0p0c1FSU1c5aWpkWmIvd3dQ?=
 =?utf-8?B?Q0N5WFkwSkRrVC9VUFZlL0ZGMnJxVmNWVkJnZVArMTE4TmhFRHI2NmgySDR5?=
 =?utf-8?B?eGxYY3ZKYUZKUnJsTi9va1JPRVlGS1RFckdHdzR3K0JkbkJOWkkvMjFEc1Uv?=
 =?utf-8?B?VTkrSkVMQnU0UHo4RFlya1AzQldDM0h5dWI1aDE2SHAvOGlEd2MraVYyY1ls?=
 =?utf-8?B?WC9nUEpKUmhXcFBjaHpuaHZJODZhS25jbU5sV2FmVVE2Kzl6YXF4dG5HTUFX?=
 =?utf-8?Q?+x7SHDWvCb4wa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFl0Mm44UmdXeUU3bG4vc3VTSEk0ZFpPQ3FpbnlRYStPNjdsY1lkUk1JZmgx?=
 =?utf-8?B?OGk1NGNHNEVFL0JDYzlWMDhINE85bGt3RmJCRHdDUjQwSjN1M09NSlJNUXp6?=
 =?utf-8?B?TjZYQ2RBN2JtdG0rSE1qYnQ3eVQvM2YrRUpmY1M3YkdzZUlmSlFvZjlCK2Ni?=
 =?utf-8?B?eFA0RXZ0L1RaaVBvdjNNNlJiUjY1MDR4cU9YYTdaeE55em5PblFhSjYwN3po?=
 =?utf-8?B?ZnhVc3VqNjd4TzNFM25EMUVLOHR5RDlZV0IyZlZKTVJONCtiandlaElOemIz?=
 =?utf-8?B?VVpWRHQzTHhKRnhwUFhiTUx3Z0xpckpHbDNsVE9CeTdCbndWeGZ5cjEzYkhT?=
 =?utf-8?B?YlBidGF6TWpOMzBueUdMOSs3eFRDbUtMdGFHUnZ2OFhnbC80cmhFV3JEVDIr?=
 =?utf-8?B?WWFNeHRWRFdldlNyR011TWZhQ1k2Rm9yOUxibTlnTDV3RFNISVA1TjVXeVZP?=
 =?utf-8?B?TFJEUWRkdzFOd2ppbTBabzcrRlRWSkEwSFVyTGhyUG1zRktCdVdrLzZ4YndE?=
 =?utf-8?B?NGVYL2ZFeUhIdzQ2MVJpWDRXSWRZVlRzRTl6Tm91eitzVThZVjMvSm5hYk5k?=
 =?utf-8?B?V1dyWklkNXQwVXp2RVB2Z3VHT1ZJRGJLV0NIMGVTWXNtREEvZ1ZSME9zYTRV?=
 =?utf-8?B?WE91MksrKzBZOWRFMnR6YU1PWVYyRHJlTlVPNlk0N1dMaGhBN2l5bHNMRWpL?=
 =?utf-8?B?MmY4RCtuZ1REeDNWazRINkpSUDltbEVlbVkwcHpTc2c4WDQxT0dDbE43ejVS?=
 =?utf-8?B?ek52WnV0MzVxOU9GUm9ZOFBhNy82TXdtcHdUYWh3eVhNa2JyWVVEK0pvcVBM?=
 =?utf-8?B?Y0RIY0MrOTJTNTlaODd4YXkycVNraU5aQnhvcHhiZU1aTW5tUWx5WVB3TlFB?=
 =?utf-8?B?eFZHY2FHMXAwMk1PZkZ1RExMQVhsUTFRaVhNUWlhVzF3bzc3UkxodisweHYr?=
 =?utf-8?B?V0RIRU1HYnUxVnNGOVI0Y0FVR3lHOXVVMnd0dXkxQ0xlRHoySjUyV3o4N0g4?=
 =?utf-8?B?dG1FWDcxa294djVBSzlPeVlwK0hwalpyMEo1ZmNabXNuOGZoZjlQZWFIZGRL?=
 =?utf-8?B?TXBtZk1rR0lQTFhvQ2NBTDRaSlRyTkxVaFpyZWhmZ1Rsc1BXZGxPdHB1Zng4?=
 =?utf-8?B?cUpuR1pXdHNJUU02TnplZytnZnVxeWRMV216eTBuSzBKOG9hcmdRRmtSS1Jk?=
 =?utf-8?B?SGRsNUtlOWNDMUphZEtXYlozQjAvR1E2b0RXS3ovTVFqMlJnRk1BK2JnRFBs?=
 =?utf-8?B?K3VyYTdHMlFWQ1JKbUpzWTJub2p0ZUo5V1FSd0FHTnZXN3R3U3dIcU5ieGhX?=
 =?utf-8?B?Skg0ckhNdkphZUtvR2ozWGVCdDRwTFNtQmF6eHRlTmxMTUdRckQ0MEFFbWdH?=
 =?utf-8?B?Skc0bXVlY0x0ZWwyTlI2RlNXZUE5N0prSHRrR3RlalJzc3RRaEZ1SkN4OXpJ?=
 =?utf-8?B?ZzZqTVdUSThYUUZzRnNNT0hEU2c5eCt5bmtsanpKZnZIbHF0RmQrQzRNWkxm?=
 =?utf-8?B?SHZTWVBVOTQxWC96N0lISExvZVhFcEVlREIrMmxjS2Z5NkZhWWtudDZvZ1BH?=
 =?utf-8?B?aUFONEY0RXhCMnRUNWxOZXdzRzJwNGxQRmZNYVdhMTFNTnRaV1g5a3RCU3ZE?=
 =?utf-8?B?OG54VGdOK2V6NWRXOTJMdlJCb1V3aVF0czZBQnhmbEtKSlpaUnBiem0yV0xv?=
 =?utf-8?B?ZG1yQWc4Mzl3OFNTRVpmbXAvU0JEc2IvVWM2cDUzV2prT29RajdoUEp3NEJG?=
 =?utf-8?B?SjYwS3FZSzdDWlNEZ3J4NnVjMk5YT3d4K3FhdjJsZDlWM25ESXZaZzNYNGtW?=
 =?utf-8?B?MWU5R2E3OEU0a0NPcndocTl4S1hTbEl6N1grbFRzaHFoa1A1UFY5NjlFQy96?=
 =?utf-8?B?NlFYM1lna3RNK0xmUlA1dTFwVWU4cExTMnh3TVNRNEo3MUd1emlqb3RMNWFD?=
 =?utf-8?B?YTBLVTR0M3dmNkE3UE9reFcxdG9CUkVkVGMvSzk3ZzNYWm9ZOExmamVvSWpT?=
 =?utf-8?B?TytwTWVlZi9WcjkyLzErdUtnMndpRGcrQnZNMHdtb1U1M0VtTUpOa0ZQano4?=
 =?utf-8?B?a1JxcUlXK3dIU2lsekVhd2RSOWR2Q2lNTjNlSFpYVG11eG83RkoycDJWeVZN?=
 =?utf-8?Q?mQAs7ZqYYXJA5CuWKQ/xILRqM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3367f971-422e-4bd1-ec9e-08dd2b6708e0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 19:52:48.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P02gmHutYqLT++4fxklOoIwsuK4JrpNFHg22ukspO1S3DkgARU4AWA0omPU//cRkjNeROpFHb/sTP8sB7fX5VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

Hi Jonathan,

On 12/24/2024 10:10 AM, Jonathan Cameron wrote:
> On Tue, 17 Dec 2024 02:20:30 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> Move the declaration of cxl_cper_print_prot_err() to include/linux/cper.h
>> to avoid maintaining a separate header file just for this function
>> declaration. Remove drivers/firmware/efi/cper_cxl.h as its contents have
>> been reorganized.
>>
>> No functional changes.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for the review!

Thanks
Smita


