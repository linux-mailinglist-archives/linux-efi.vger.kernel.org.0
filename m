Return-Path: <linux-efi+bounces-1193-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD0F902900
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 21:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5952D28512C
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 19:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE3585626;
	Mon, 10 Jun 2024 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uQoZkpWe"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871C85285;
	Mon, 10 Jun 2024 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046474; cv=fail; b=J8sv378JWKtrGCFgeu71S6Zvo766+7nUEPvdZBfEuW6UP1eTwgQOlj/elk1gZ7cZ8bmi+jvpyiLwz8NCbujvRPX4idZVzLAwBYnhPanE89+F+yM/koY7Z89nvc1eHV3UphtsjZA1ilQ8EFVL6pmd6d50EjQHqZrFM5drtkYCws0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046474; c=relaxed/simple;
	bh=3jFigltHPS2kgoXe8GTXcKqYEieww0ib0744r1i6yss=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=lAz8Ks9XqplLefyHQJWyxsLUE7vMTLv2Q5877NI9FcIS5vd1vx5PoCKIcy6e5vSGsTo7RDPmQKZzIDN+l3TGrMSAIeefrjJQmh3S4mZ7zt83BD9jicjDnquOs1BvjZ9hsG9QStegfuwhWvff4kcGvOFhzRoFrEwcided+Fzt7aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uQoZkpWe; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrFpiaXQiQyTlhFiJkYEpyD+6MfhYrwgVsDKL7Ce6FfcePfBKHJozXtw1e6OtFIoDjWskjCWn8Asm+DOlZ3eWuvXBj26v/g0j/neeRXmCrnIqVd+pLZ9ROABV4XH3lZX/2nezyteLMM6oBYOSk4jOldGmVqdDr/UJLOPBGGgBG/qLc0XiQiu3DS8wBBkbhtOkiDS8GSTy6F/DSH2z3s5lEOgvBfaNM+d+O4to/Uwc4Zw003ymmRNWHLLF0YhVIDtBT3dzUY5u53zeG4c14LCu/lQBJEwNxPMwfWVBqwS0irdiDB1SStnw2hbMpaE24zdkSJb0NdX9UGA96vuNVY5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6Bvh10FB5Xl8XvNWEkEzpdOU5MervGmJltn4QfnkuU=;
 b=FNI+Ub9WH8kCHwYxCk039K2uA8zHLNFer2OFcI9nshGLS+KpAmG6wSadjSmAyKfqtJ7/KGDx0jN9cul687+iVoM2xfuRwNoX2cYhA8sP/4ZDsuxspuqojT0axmtaeUZVwHH+uYT4eyODSqZoCrB/h03DJjBJ0j1yJr/bkDm+L0mJvmMebzn2KrZGxkXsMEcBQZ5z/dxqo6tL0vK6JeDBs4DvGpx81aqhG6D8bUKwI2dRBYIKKkhg2YHnG+eMX5sYbXgwDzLKsfndL9JZYieCQrvNk+3XY6DvkO496TWthq244SJTeSCEfH8TGaVXvTef55ZVtvgQAXQDarX95eYK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6Bvh10FB5Xl8XvNWEkEzpdOU5MervGmJltn4QfnkuU=;
 b=uQoZkpWeeGuJJ8CDiiBUDb+6qMZMDQ3ASmgbq7YRNEle8+Nc2MgM/eIrc3KKY+5XThlVq0BIUXA+bwYYGOSiyGbJ+CVsfigY6AMxXB+iWHkzRJUZOXI+OFfU7t2eNrNxmsytFfM6CKc1gWik/B5W0dZZWpzMn50pfr2YZGOp934=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 19:07:50 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 19:07:49 +0000
Subject: Re: [PATCH 2/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-3-Smita.KoralahalliChannabasappa@amd.com>
 <Zk6H5jTdVfN4aFhF@aschofie-mobl2>
 <09e0d961-e19f-30d6-5306-1b35609b7d79@amd.com>
 <20240607162622.00000819@Huawei.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <7fe041ed-9ee3-7cbe-ddce-fb727fba12c7@amd.com>
Date: Mon, 10 Jun 2024 12:07:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240607162622.00000819@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::30) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: bd280052-4ebc-4ed7-b5fa-08dc89809f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K29KMlZJMk1uTEpVcWY4ZEFZVFJSa0FwSkZBY3FxWnZ3OGZmOE1TZEZTbkVL?=
 =?utf-8?B?Wmd3MEF1aEM1NzMycXpCUWlpczZyRmVwajIzVTZYVEZOeittRXdDNWhqWkxG?=
 =?utf-8?B?Z2grUXNGaEZ5Tng2ZWJzWGQraXdTblBLcHJFZHNGckJlM2l1Q2svUWtFZmo3?=
 =?utf-8?B?YllabVBmdDAwd0dvVDJKaEMwTGRNcThJeVhMT2pJclRBT2RlRk42MkJVN21M?=
 =?utf-8?B?cGUwcU5FenZjaUVkL3dNaXRsV29vT3BPaTljd0NSMnVmck9FdHJJMlNBWXp4?=
 =?utf-8?B?ZklIWkJCL3ZPR0RhdFROY1BvSlZUYkttd2tYTkhLMTJmUU8ySEVhclg1Y1Vx?=
 =?utf-8?B?OU1SQ3hsWXVhWWVTM2VyY1RTNnlvUmtib01SdDBlVDNHaHBMM3pJMnllejJI?=
 =?utf-8?B?cmFkbG14enZDNHJmbmFKSWRRRnhnRGJSOGYzQ3pESEsyN1d3Z0dXNXlGYVZD?=
 =?utf-8?B?aDNpcTc4dktvak1MQUFNb1k5MXpzMlZFUnFkLzJKOFNiSzRtMmNnV2tJSGM0?=
 =?utf-8?B?M2twSy90VjJYNVpnRmYxS1FtRDltR3hZUUNKYk81NDEzb1liNml5WkN2TFlz?=
 =?utf-8?B?clVMWDdMczFDcVovWUxVV2x3Tk1mYjZ2L3N6TWFScU5HMVhGK1VIUUppbTYy?=
 =?utf-8?B?U293VDBrOENCVGg1QXF2anE4OTB3MGVWZUdWbDdxM1cxMjRCRnBZK1ZVVHlq?=
 =?utf-8?B?MkllcFJ6RU1ETzZqcm1ocWhtZ3hVMWkxbVA5WXN0Vnh1V3ljdDIxaVF0c0FL?=
 =?utf-8?B?blAwN3JMQjJSOEhyTUhPZDlYaUxqRzgwYk9jaHE5MGt5N1hsK083MDhvOThR?=
 =?utf-8?B?cmxXcG9oZkhRT2kwb0tYV0pWNHdmQkRQRWR1UHBGWG9tUjRBc1pKWTZMZWF0?=
 =?utf-8?B?TEtqRk1UUFBvbktzZWhPWTE4WkF5UnFOcG5GM2NCMkRBNnF1bmFDdGdvNXBn?=
 =?utf-8?B?MzFtUmFIRHl4R3BNcGQvSUVZOHNrRmY0bWYrMk9wcVhqM0tNV0EzVHQ4ZGhR?=
 =?utf-8?B?ZEt4cGJZY3ZMelVtaDQzU2dHUGpKaHlzZXUrMGJqK2ZDQ3pmUFdLajNVNGtn?=
 =?utf-8?B?RTNCdHUrQnVKeWFIdEx5RksyWm9PeTJRMjZSdjN1aUg2enV3Y0MvUUI5WC92?=
 =?utf-8?B?dHhIeS9GNlFmY1U2NXdsamFNK2ZnK1M4UDR5U2RnajJvL0dUN2VZZWlLaFFp?=
 =?utf-8?B?YWFyUWtFMFRJT01iQVdlQzBQSkUrSkxqMUFidjFDU1h2ajZvMDd5ZWc3Rk5V?=
 =?utf-8?B?SkhqY0dWWThIc01qRmhhbDJMQkpUWDQwSXN6M05kODJiUHJvWGJ1ZzBBS2FN?=
 =?utf-8?B?TFE4bFJ0S3B6dG0weUVHRUNjaE1YeGt1YzNVNUErNWFsNjk2ZXBFVU85eWwz?=
 =?utf-8?B?TG80LzgwNndCRUJteFI4c3J0c1diaVYxVHZEYWhnbU5TNERrdHQwSUN0WHFJ?=
 =?utf-8?B?c0xRRU9wR1N4MWdkMllFOEp0elRibGpKTGtXcmhYODAraTVCL2VuVjE0QVNi?=
 =?utf-8?B?K09BclRGRGUrVGUyQWZDbjFFS25neHlpUktzNndRcFNXNVh3ZDh2MXVTMkRX?=
 =?utf-8?B?V1dhYjBPYUt5UXdzb1BTR0ZMQ0xteWkvNzVGa0VVbklJcDNORzUwcDRqbUVn?=
 =?utf-8?B?RnNpbmlmZWNNSDAvTHNiYUNnekNmREZKRy91OStxc3l1Nk1ZemlRVzJ6Z0pv?=
 =?utf-8?B?WnpNcHc1YVNrRVlZS1RUTnJRU1FHdVFBcGdoOGRtbUNpd2JLQTZoZW5Od2l6?=
 =?utf-8?Q?PPNlDx7IMqSI9N0TqRNhHvAsHJPoCqa8eGJM5na?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUtUYXRYbkw1ZEI1bVB3TGVFTGZtTzNQZ09idnNkSmRiTUE0bGhnTStCcWRD?=
 =?utf-8?B?MDVkcUFtVHd4WllwZWlYNEFjN3FsbFFOdGdSNFVFNXRidnpIa2tLVEhUZHZR?=
 =?utf-8?B?UTBoWmN3YmVMZDVLYnRxdC91bEFDVG11ZnNaQ2Y0NlN1ci9qenhSTGpxOWcy?=
 =?utf-8?B?UklucUoyb2VwdWtCSnNodkdFSDVsTG9TOXNhNkc0MlBaUWh4alBoUlM5STBh?=
 =?utf-8?B?bmNrN1V6NjhmUmE1dVQwRDgwamM4R0F4T1BzN1EyNmhTYXNnVkJucU02VTVr?=
 =?utf-8?B?bVIvOGJTSEpHeHFTY0NpVVV3Z2FleUlLK2xOZGVEYm5DZGYwRUFDa1czRThh?=
 =?utf-8?B?TXU1WGxFQWlaOWprVnVqSEVORFBlNWJEQkdmSFYzOXphRjRTL2trM2JKbnor?=
 =?utf-8?B?VDBwU1JhN0lNMDhxOTBzNi9oNDd5S0RBSUtlbkFiVmp6MmtEZGd2YisycnF0?=
 =?utf-8?B?QmpWTGZEVHZUV0wvaTM4WDIvcjRUTlU0Q3BweTYyb3E5MlRIdFdLWXNmeVJu?=
 =?utf-8?B?cHAvbVhjS0x2cmpvVWxISVN5NXZkWGQzZ3p0cmU2R1Q0VG1JZlFuYmQ2ZXlR?=
 =?utf-8?B?OWRiWXVCdmVCSGR2VW5vc0hsUHp6ci9OYlhyNVVDdXRObG10OHc2dUoyNW9O?=
 =?utf-8?B?bmRkaGtVQnp1NVZJczJ3OFRQdGh4UFhyTFp3TGFjUUdiMVh2MHJ5OVRZVGdm?=
 =?utf-8?B?L3pCR0RCbVFyK0RwYjlNR2VJTHZYOThjVnBDNTVLOW9rTG5tMzJDNnYrZVFk?=
 =?utf-8?B?aWhXR1NnWlFNQVBhNktHMTVHWTBFWm1IVzBHMVRldHNFMEV5MWpsZnlsVkw1?=
 =?utf-8?B?a0tEVU9QWHZBQ1N2OGJEL1c5NmgxTDJNQ1M5K0VaR05FbHZ5c3ZSRTBTR1lv?=
 =?utf-8?B?M2pJejEzRGhWVFVlTEp2WmZVd0k4d2I3NHUvWmt0MGRYakV0MDBzV1RXSjBo?=
 =?utf-8?B?dW1DTEo5dGIvbXo3eUV0N0NDdWdmblFuTk9UUlZldTJWQktEaUVla2tJTWVN?=
 =?utf-8?B?elY5a2V6OVVTTFJzT2pTVExRZmsxaTV3WGVTU1pRVE0yVHhTaVZPUWxKVjVo?=
 =?utf-8?B?dW5wWm44MW4vQlVkQndITnorNWJqWjIyOGlOZWlLRDdGYkcraEg3M2xZRlFZ?=
 =?utf-8?B?SGtDcEpmVzVaVkdvdVdyRmx1cFE5bHZEOHUvbytiQ0NKTXJVK293aGdsbk93?=
 =?utf-8?B?UVYyRERlOEt6cDJxNlppMHFjU3BUanJqS2xIK21Jd0dMcThVU2RDU3Z3ZDZD?=
 =?utf-8?B?aXBXei8vb3ZKT25yRDAwUmZvTEZmNjYyZ2YweWMvTDFSK2ZwYkN4S2ptWmpN?=
 =?utf-8?B?NkV3TDBjM0Y5UFVvRVNldTFWcmw4NHVaUGhwTmpwaEd3OXNzbmJ0WW1UdFdo?=
 =?utf-8?B?d2JRV2d3aWI2YzkwNnlXUzFTOVZyTmFGU2FCWldJbjNBM3E4aVVKUWxDUTFG?=
 =?utf-8?B?Ym1TYXI2NDIyR08yZVZWYjJMV0xqd3ppbDUzWjduU1NZSVlKQ2xKb3kvQmhQ?=
 =?utf-8?B?Y0FyUHlmRkpKR0p5OHovNzhxa0gyOXl1OUZ1K3ZESzFTSExUZE13dDNoaTB5?=
 =?utf-8?B?a0YzU2lUVE1NVnZEaDJkQnAxNE9jRWtGWC80ZUErRUZtYWVEanhUQUFML1I3?=
 =?utf-8?B?ODZyclNOK3hocGpwUG9NODI2dVFjZGJPaGtrcUQ5Y3lZWnBZQWhlZGhWcGd1?=
 =?utf-8?B?bnY5NXp5TGNoL05yMER3R0tPY1lEMmhUdE0xZ0QvOEdKTDJDV3dSaUN6NFZH?=
 =?utf-8?B?MjNuZDhEYVJrY1YyNG4wKzE4V2VoV2JxdC9QWjBmckdoSFZSbDFCSlNCSGcr?=
 =?utf-8?B?S01EaWZIL0dBNXNxVmQ4a1VmOVlScm5LVUJCWUZHWXNGQW1jRjJacGUrTnZJ?=
 =?utf-8?B?U3o2VUE5WCs0YXlwWXdNckx3SXJvRWM3bVNmK1hjOUhjbkxFQUM2ZEcxVFJr?=
 =?utf-8?B?a3QwaDd5SkdrOUx2WnR5dk1kVzBlSDBsZWVIQkhWczd0SWRsUlA3QjdxZWNo?=
 =?utf-8?B?TTNHT21OTjdZdStrWXFrWGw4d0ZDYTk4eFowZllVYTdsdTNXWGZKMG01OVE4?=
 =?utf-8?B?NTRYc3JyWDI4aUErKzhsYlE2MS9UWGVNS3hDemttQkNQVmc2NmIreG51L2gx?=
 =?utf-8?Q?Bbzbx1yDBfsE2Rx4UpVQ/qk+b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd280052-4ebc-4ed7-b5fa-08dc89809f1a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 19:07:49.9099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gp0KZHHsMl4Gkg0yCTKDQW3hSWEgY2SWnL/534JOStseKg5QWdl7+dJsxvQVuw8y6ucO6agwqctRWSGFy2XdTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391

On 6/7/2024 8:26 AM, Jonathan Cameron wrote:
> On Thu, 23 May 2024 14:21:40 -0700
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> Hi Alison,
>>
>> On 5/22/2024 5:03 PM, Alison Schofield wrote:
>>> On Wed, May 22, 2024 at 03:08:37PM +0000, Smita Koralahalli wrote:
>>>> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
>>>>
>>>> Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
>>>> Severity, Device ID, Device Serial number and CXL RAS capability struct in
>>>> struct cxl_cper_prot_err. Include this struct as a member of struct
>>>> cxl_cper_work_data.
>>>>
>>>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

[snip]


>>>> +	 * The device ID or agent address is required for CXL RCD, CXL
>>>> +	 * SLD, CXL LD, CXL Fabric Manager Managed LD, CXL Root Port,
>>>> +	 * CXL Downstream Switch Port and CXL Upstream Switch Port.
>>>> +	 */
>>>> +	if (prot_err->agent_type <= 0x7 && prot_err->agent_type != RCH_DP) {
>>>
>>> For this check against agent_type, and the similar one below, would a boolean
>>> array indexed by the agent type work? That would avoid the <= 0x7 and > 0x4
>>> below. It seems one array would suffice for this case, but naming it isn't obvious
>>> to me. Maybe it'll be to you.
>>>
>>> Something similar to what is done for prot_err_agent_type_strs[]
>>>
>>> static const bool agent_requires_id_address_serial[] = {
>>> 	true,	/* RDC */ 	
>>> 	false,	/* RCH_DP */
> 	[RCD] = false,
> 
> etc rather than comments would be neater.
> Given two similar things already. Maybe time for a little structure.
> 
> //with better name than this
> struct agent_reqs {
> 	bool sn;
> 	bool sbdf;
> };
> 
> static const agent_reqs agent_reqs[] = {
> 	[RCD] = { .sn = false, .sbdf = true, },
> };
> 
> etc.
> 
> Maybe just bring the the string in as well
> 
> struct agent_info {
> 	const char *string;
> 	bool req_sn;
> 	bool req_sbdf;
> };
> 
> static const agent_info agent_info[] = {
> 	[RD] = {
> 		.string = "Restricted CXL Device",
> 		.req_sn = false,
> 		.req_sbdf = true,
> 	},
> };
> 
> Values made up, but hopefully conveys that moving to having
> all the data in one place makes it harder to forget stuff
> for new entries etc.
> 

Okay. I was considering 2D array without naming before. Something like:

static const bool agent_requires_id_address[][] = {
        /* Device_ID, Serial_num */
        {true, true},   /* RCD */
        {false, false}, /* RCH_DP */

Let me change to array of structures if naming helps.

Thanks,
Smita

[snip]

