Return-Path: <linux-efi+bounces-1081-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F348CDC2A
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 23:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979691C235E1
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 21:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C80B84DF5;
	Thu, 23 May 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ywNjigyp"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDE101E2;
	Thu, 23 May 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500158; cv=fail; b=Avi76g/ADKfaf7Fj3HRrTn3+4GfCgb0MjwfCaiYLUgNE+AjafgvCT+CvxdGir9stTsjlDkKIt7kyV0eQzh7GoNRPHCPJJUN3ig2wozghn+HvxOQD5ryVlSCeRmBMnX4qdT1LpIHDYLJVlw3wFd8M5LnZ5K9EZy+KolBw1R5Qfqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500158; c=relaxed/simple;
	bh=tp5RJ7W4nk1cas0BLNjRz0MCuTxcon5BuxEvybRQBic=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=LZgyX4Bd0bfjFIgMKRIG6kEj3x0HmI6oiXZV2O512fazosapRW4Hk5aKHjvh5Izw1azpJ32rJ7dk/2bANfS5H2J19LSyXluEyulcb1pF9sPsuYF28wn7BQEDteyUQihpQsrU5TnjpTBQxapBaHohdtxSquXvQaw2iApvz98x5W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ywNjigyp; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0Aljfa//oOJyROEs+fAZwzzV4CCrf8Iua4OZnklu0n/3EiD17wud/Pj18n9Mgqcbgp10I4Y17IU0Paa/yUraLSjgzDnOFROj/mOk9Gigbre3P6tInjQmCXnu3SAOwxrQLwb7h5w0B2WJT4K1TUS/ntwFOadbBhpJx/eNgfKs/l5uxRTCF261mEOGm7OGX5FmkOerR/DjVRF373MFR18YmMAKiaAwlHQ7xYDlSoaDX9wrwk465PsYZClISwuBxpjIXOF3dIa2F2R+1blQ+T1/c/2+WQzR8SGQRSbHqyZBPXiNfBrxCNKXCdOA7sIVkvB/VjDeFbJuQ4pCq3tA14YTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4dqnW/Ojq3nMIfl41+2OxNYrQA0e+l/NdPVszK4bn4=;
 b=Uh8GzpGpNXxQF7O9h6h6Rl9hxu114aLTEr26By9wRJb1+aO/klqHLs6RJYPL2pmexTcZlwbaWHq061PM3w7bdrK59PG4oGa+0kQCF0qzw7K/0f67MbsqmPkvHX/s6zSiaRDou9DSQz79rVgfh27FfT/J36T4fuc1fqrsRf8eLr4gCJH/g5B19NF99EaJiBDGRmLKHjkpXgXY8Fu3+1FlCVJT6z7CQXChnMEF07gFeQfIpVyhM27Vw58ua9Qrr7167E2jCPGNlYRBG78CcXDWwU/fa5Mo3QTn7KNCa+tJkuX/jFvy/+j9TWGRW8klu0RjchlwzMpWLlSszKTcS6GKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4dqnW/Ojq3nMIfl41+2OxNYrQA0e+l/NdPVszK4bn4=;
 b=ywNjigypM40G+6TPpTQ/uOFsaGG1VgShy46TFVWgv7IxtoGuRxZgOI3DfgdOMO4D4QIB0gWMgl9mnSpLyR7oUQMtMLpFQNxSK2uiYsyQGE1uW1DXAPT4ubd93bNLG2fueeZ+gB67twmv4VZqBUFk5ocMt/cC+CoTPQIjIYZIWq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 21:35:53 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 21:35:53 +0000
Subject: Re: [PATCH 3/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-4-Smita.KoralahalliChannabasappa@amd.com>
 <Zk6MWMYUg77HxbVr@aschofie-mobl2>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <34fe7471-d17e-b802-f9cc-a83ad23ef409@amd.com>
Date: Thu, 23 May 2024 14:35:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <Zk6MWMYUg77HxbVr@aschofie-mobl2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: b471c22b-ce89-4da9-b69c-08dc7b7052a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzZhM0FLeEpubHFWeDNFblViV2lVU2svcCtnZThob0k3SEFmOVQ2dGlrVTUv?=
 =?utf-8?B?eVhaRkQyck02Vkk3bmI3WktXVjI5ekV5ZC9DV1pZeTNXK2pFcVNydWRsMXlx?=
 =?utf-8?B?MVlpSWVFTEdrZktBNGpjMkZuMjgrSzR2cElHMEIwWld2aFR1UHNYa1k4a2FK?=
 =?utf-8?B?SDVvbzViLy83K3hLUHBjYWV5K3BYNmxSeVJQWmQrZjZoMTVtTVdCWExBb1Q2?=
 =?utf-8?B?NzNzRGozMjJhUHhTaFJUS1dOQTRTMnlsamI5YnZ1ZlJscDYvUytMU3VJRWI4?=
 =?utf-8?B?bjQ2N1J3VE5yeWZOM2dGalVLZEJ0MHFHdXV2Qkp2dXNXdVdDWUJVTTBZY3Rq?=
 =?utf-8?B?Vzg2THFEL1FDZStIK0xCMVFmczhmaC9zeEFxZnNBQzc2RGdRS205bU9zbW1m?=
 =?utf-8?B?V1RCTzJnazJ1ai9XT3hZcERNZ212TUpzbG9pRmdHaGN3R2NrbEQ3YVk4YUgw?=
 =?utf-8?B?NW1JQjRqdGJrUWFJTlBsdW9LT1NWb1VYRXBBZnVsVTlodlFHUWw0eEtBVW1R?=
 =?utf-8?B?MEJqNVNqbW5GR3JYaHhFRDNnRU56YXdLR1VuSHpuRlNORERyS0xUQy9LQzRQ?=
 =?utf-8?B?aTFhd1kvU2pMVzFvQ2NybGsycmwwTU4zN3NQU3ZYaTdHdHpzUDdQMWRPcWpU?=
 =?utf-8?B?S1BQelNubEVGZ3dXTmZGbnFRaFZLbmh3dGRuNlhwZGNXYjFIUDc4RVowVlNj?=
 =?utf-8?B?dzNEenEzTXE0THM0YVA5ZlRWRjFORVBYeW1vOWFLUWxJdTJ2Z1NNdWh0K0ls?=
 =?utf-8?B?MXZGVXVVNnVtMGRCVzgwRzBndVptRDZOVS9ReFBjU2taVGkrSVdyaTUxcndm?=
 =?utf-8?B?Smt3M1RpK2ZOVitBYlpKODJ2Y0w5UnRsUEI1eERSQVBiQzNpdmhBWVpESjZP?=
 =?utf-8?B?c1VndjdQK3UwNWVCS0lDN3FRYjFyTVkxckUxbTZlVDZGemFTcXErMEhnZlli?=
 =?utf-8?B?Tjc5M3pVZ3pZY0lZZ2dhSlV0Sk5hQnVVSXFNQkV1dmZaUTEveGozWnVYZ3p2?=
 =?utf-8?B?RUJSZnFPM3VMSndNUWJQYmw2MzFKNXFMNjc4SXBKSmFDNTZaTUR1Q3hqR2dr?=
 =?utf-8?B?ZlZ1YSt2bWxtZnV2UmwzeGdsbTRqN3hvRUJKYVFMVW1TNUppdFI2R3FOSXlo?=
 =?utf-8?B?RStTaGNWd1FEcEhjUU1aZ1gvV0x0eFg1QUc5anpZTHBtdkh3UkdXNWNuTVpp?=
 =?utf-8?B?aW16c09VQjVTNzZjZlJ1TXlxZStyN2NOclRvTnVVWjhyU0RVa0ljN25mWUZH?=
 =?utf-8?B?T01nRlNIUVUyTEZBOWxtRUVBdnV1S3c3RklTTkl4Ky80Y0x6Uk9aOEFMdFVz?=
 =?utf-8?B?eUh6M2pEdHQrUWhlWGJNQ0ZkYzBNZnlTTVBSbDV5N0ZjR2IxRi9sT0JyaE1h?=
 =?utf-8?B?SEUvVkpRcFAzTEwrVEhqS2JWNnNkN3B3Vkp2WEI2VC8yci9ObHlDWHZxM1RO?=
 =?utf-8?B?THJRc3BOV3Q5RnpYcUFWdlA3QTRZNEZIR3JsVzdqTXJpRUJRSU95RU5sVDZz?=
 =?utf-8?B?OEpFa0FWUUMwS3U4eWgyVENCOTNMRU5qMmNhMTd6bmszVFBIVEZ2QXFIQWJZ?=
 =?utf-8?B?ZVFpTHJneWx6SEtNalZ4anJNdTNBUVdFMGlvSnY4N2drV01SV01ZWkpNNzBn?=
 =?utf-8?B?eWNtRWZGSEplUitIcUU1dERFZTkvUmNDektuU2kzL0JqUTJFWlorWEpGd2c5?=
 =?utf-8?B?cm1vQjhyVHhVRE4rd2lvWXVHU0Z2OUllTUMxL3FaR2lJWi9WYVAxQ2pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDhtYklUVEJIME0vME8xK3creEh4ekw5VWwwbXFyVWY2a2cxeVBhSWZmZ0RP?=
 =?utf-8?B?ZHViZEN2emtkRjlsRGNEWFE3UjNpNHNpdDNFMllWNmdXWmY1RldJdGFOVzFj?=
 =?utf-8?B?MGd5eGNXTmZIVnRoZ3BJOEVva2VZT25RYUQ3RTBydjJFcnE0bWZxUGpzVU5F?=
 =?utf-8?B?Nzc3WTQ5YURiaTJYQzZESnQxMFVlR2hwd20yaWEvNVFJd09VQmtOU29pdEVD?=
 =?utf-8?B?ajVJNHV4QXVNaHJvSmFsUm90VEFkaTI1SnY2Mzl5S1VVaTRHeHkxeHlZRDdB?=
 =?utf-8?B?T3FvZlNsYjVVTHFNV3g5TzlFVW9xQlRBSXJRemIyOUhBckxVbThJd3dWWkJz?=
 =?utf-8?B?bGsxMTRTZjlzdzFPU1FycGhkNCtkZ1ZLZ0RrVHdTTE9qV3BuQmVudzZYQlBY?=
 =?utf-8?B?U1BsTE5UaXFoRkp3ekdzY3liK1pxSW1JZEgycFNvdmVub1RkYUxvSVRjNUJ6?=
 =?utf-8?B?d0ZnM2ljOWx4RFpWdHhrMExXeUg5dW1jdklBRFZLQ1NSelJnaG8xdVVUbXdE?=
 =?utf-8?B?bHpwMVdWN0w2b2ZRVjdrblMrTEFvcjhoem91L09MZklVNmc0Q241MFRYTjJy?=
 =?utf-8?B?TTRoS3Vsd0dWL1B5a3JnbUpWMjczSExYYThhTmxuT3dUMm4xQW9nYlJqbTh5?=
 =?utf-8?B?M1I2bTNxNkNCNWxkUUdjb0FuTytNNHl2dVJlY0pVQjhtSGNqSFJ5cU9vaTRN?=
 =?utf-8?B?U2FKWGlOWXJZTGpoYWtDTDRXVGhXaTlPajRXeGpBT0ZhMHFtcUtHK24rdk1N?=
 =?utf-8?B?RG1tOWVyODNXdUZac0J1N2lmOFV4R2ptWTNzbEdGZDdyenVLekJQa09zMXcx?=
 =?utf-8?B?dlN3NXhzZk93YjJaMzZIa2lDaEFIMWFYWkxkY1ZIZjZlZ0x2aURKYXFiOW0r?=
 =?utf-8?B?N2lUSmhVc1dqQjhPeWp4K3pFT3ViVWVyN2hyTDByQ2o0Znp6ZzlwSVJpbGt1?=
 =?utf-8?B?QUtpOWIramRzaFhqWTk3bGxHWWlIMHBROHZKd1hLTHlWTzJoRjhwOFJxTktV?=
 =?utf-8?B?a2ZqNldKWW8vS0N6dDNOTHV6dlJwOW1zYUVMNlYyMzRJU1FtcUlvWjRjZXc4?=
 =?utf-8?B?SitZK2FxcDZFWTN4cmhkTEkwK0hJVHcrbkgrNXU0bVlSRjc3MXlJcklleHVH?=
 =?utf-8?B?VmRaNHdrWE5ZaThQNW02RjhIUmRtenFZeDNxRE9iOVVNZFBhT1lQcWV5enVy?=
 =?utf-8?B?RVFvKy9aOXVKR3REYXdXN2JCUFBiYnM1OTBsK1pwSi9URmJTMkhOanNQU1Q1?=
 =?utf-8?B?Qlp2VHVueC8zb0hlVzVsZW1MU0xrdFFEdW1mQ3M1UXFzN1B5M2ZxOUJCZFFM?=
 =?utf-8?B?ckdwTVFvK1MwSUdlalo1TFBWQnA5WXdZdXlqWHlEV00xTVVtbmYvd3JqUWVl?=
 =?utf-8?B?RHpiaTN3VkdnM0IzWUFxQTE4UHZjckdGY3BjYWZFamhGY3ZSak8zaDlTYXZT?=
 =?utf-8?B?MWdBN0ZjT1FoOTBTdEIzaWYrR0JSRVhSODVBeTRFU00yZGJZaThBTXY2dWlY?=
 =?utf-8?B?SWg2MmtqeHd0Y1RHVElLMUdRUlJqaG1hNkMwL1UzbjFPNVZEUTN0TjZZMi8v?=
 =?utf-8?B?L2N1Qkdxdi91cG5wd0dnUmQrMHpIdFJVaUxUakQ1enhmTTdVcEg1NWtPWmV5?=
 =?utf-8?B?RnVQN1Q4V2tOTld0MndDTGpyS0lZeGZ5MEhGdWF2QUtPZU9EdmQxTUdZSXR4?=
 =?utf-8?B?ekx5a01lVTROZW9wL202bnpVNWtqamF2MW9JSFVHU2hZOXJ6KzVUeUg0c2I4?=
 =?utf-8?B?Q3JDYkg1SmNucmg2QUhBZkNlWXM2L1RwM2gweHB0TjV5N2NoN2EwNEJUZTJk?=
 =?utf-8?B?ZXkwRDFKQXZPZ0RIN0JOczB5QVdWemIxdWhkRUR0d0ZEVjJBQ3ZhdUNVVyty?=
 =?utf-8?B?QVpmWlFqaUozOGEyNks5U3NPcHlMT1BQdnYxWnM1SGtzbUtzdVdYaEtOcHJV?=
 =?utf-8?B?S2pUTHpieFF6L09TRkcxWWFBbThUWFN3U3BCOWE5QkJJek9saHM3c0pJMEZI?=
 =?utf-8?B?YjVGemhCWm80T0tiYUFvcmZkRjJkNlBETXhPQlZodlRjS0xnVWpVMStnMDda?=
 =?utf-8?B?RkQrQ2NKT05NTnladEFoMFFBMEd5UytBdjljV3VTTmhjc3RTY0JRUi9Md3hM?=
 =?utf-8?Q?dQ/pTtXhqVHRiTEGFJgIzCgnq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b471c22b-ce89-4da9-b69c-08dc7b7052a5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 21:35:53.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUUkcr30miH15wsSsGkVy4xmBXxDLfdC5cBWDy8otQmSeEdpsiDwwKrpQTmbcfiPLEbwAooV8mMg6s52CTsFmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856

On 5/22/2024 5:22 PM, Alison Schofield wrote:
> On Wed, May 22, 2024 at 03:08:38PM +0000, Smita Koralahalli wrote:
>> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
>> CPER records.
>>
>> Reuse the existing work queue cxl_cper_work registered with GHES to notify
>> the CXL subsystem on a Protocol error.
>>
>> The defined trace events cxl_aer_uncorrectable_error and
>> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
>> them to trace FW-First Protocol Errors.
> 
> Will the trace log differentiate between errors reported in FW-First
> versus Native mode?  Wondering if that bit of info needs to be logged
> or is discoverable elsewhere.

No, the trace log won't differentiate currently.

But just a side note, FW-First also logs errors in dmesg. I'm not sure 
if going forward, we would still continue to log errors in dmesg. But I 
feel it might be needed so that we don't miss errors from RCH Downstream 
Port or hexdump of unrecognized agent types.

Thanks
Smita

> 
> Otherwise, LGTM,
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> 
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/acpi/apei/ghes.c  | 14 ++++++++++++++
>>   drivers/cxl/core/pci.c    | 24 ++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h      |  3 +++
>>   drivers/cxl/pci.c         | 34 ++++++++++++++++++++++++++++++++--
>>   include/linux/cxl-event.h |  1 +
>>   5 files changed, 74 insertions(+), 2 deletions(-)
> 
> snip
> 
> 

