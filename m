Return-Path: <linux-efi+bounces-1079-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0694E8CDBD9
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 23:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250C71C22F56
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 21:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F984D06;
	Thu, 23 May 2024 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WFM8+aZw"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8785274;
	Thu, 23 May 2024 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499306; cv=fail; b=CICv5AFH/OKWIFnmJAAsErzNiKDblhkxxw8MMvOhfH1CuewDyB/qOK6BRKMxzDTOc+wn07SQJkJvBiXpEU4LYGjE9fgNCdQrh1ssGe5KPgrzwwYMxGT5/cERMrffYvRKYZsNQH+rrHziz6XpfcXBGdIclRapPDvxK2AKt0UphwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499306; c=relaxed/simple;
	bh=/QHqTYkFt2c0Uf3v12g27PtBoB+B00876+IsjK85fcY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=thW+C5S5MPMDzAvKsvL9SiS7xjXdecZ7ubnbbmRjZPUX5pP1XgWVA7PR8UjnS7nNIQswNinoLvQmASGUusrFr90WTab6YOGPhhWjXgGGFKHj7gYtGbS+jQ6aLxuWzxutjMwbHab/iuv4n40kKUAEXx4NUVmeRlqKSN0pOljGgBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WFM8+aZw; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REY2lQahniZNZd5mZ8A3iRDIPE7yBQaANXFQ9hApxTFFwah/VKMQVXa4IAEypcuHzdGi7T3w0vzCqklDaYpZHJ8HvuVy0tSMRaPk9esAmoBBbMafwoxtvkQp2b/SLAOH+xt3wAWcftPxHP7yczfZVcF8kspiZOGqdn3II2YsHEthERvZmpGfwtXkqgt0fRCcf3WHFfk8ng96EJLazAMrw2NCPxL8t+uaxLwlr8zOLvOhqiRg7tzzMZXKSC3+OqbRpP0no/0JYSMhXFWe04fnXg/Kgc/t9KGOcrJWJNewRNhWbhLNzcCl6+koTsEZxOPQo/QDsUYETi+0CHhGQfpdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=po+AQQCyY2YiX39Vi77TV9aL0CwNs6laQwy3iPVxET8=;
 b=T/dDljfTiq89iiOpd5Y3yoxgADuVJr3oeP7XdY6TbWf9qbT+BgQugk2ZLZxzcUAUuCfK4K0J7GWvwZpPzAgghRtIJZh7YfdQ74Q2r73gu0P9+RI9k5R/F5LS6LaWh5I6vPtgtQo59q2bcBuRh7k4Ih7v+rKJ84nH/iLlqbZEIkzI7G/F1ocJ7M1QXgsyeL3qJIgY+Zf3SaB9chuNaerpxmMtbf0quXkF4Ozsuh5mrPlMM26A91oyGhoOIG+teO2zzrN0qdxgqWG5xXaHJ+f8nW86uxb1C/MIh8DiUkvaGjAnjdsgnAPuEtLtWih0Wrq/HwByONCM3R9zJLGG6am22w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po+AQQCyY2YiX39Vi77TV9aL0CwNs6laQwy3iPVxET8=;
 b=WFM8+aZwz8SB00QqEDUZZzaMdd7Dah+gYCSPtMVJGnBdnAmT2d50YqzeZhdDkzOqUe0X/xa+Kc9h7Ao0GRAoO2Do74VBwfdWniiFP8+Iau0SZuCacUc1/TVkPmoerNm9Hne34p5jnfPKNyKJMAXj9BNgQrGh1DWeDIpIhHZYCdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 21:21:42 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 21:21:41 +0000
Subject: Re: [PATCH 2/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-3-Smita.KoralahalliChannabasappa@amd.com>
 <Zk6H5jTdVfN4aFhF@aschofie-mobl2>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <09e0d961-e19f-30d6-5306-1b35609b7d79@amd.com>
Date: Thu, 23 May 2024 14:21:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <Zk6H5jTdVfN4aFhF@aschofie-mobl2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:332::26) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 4763cd42-ca68-427b-5118-08dc7b6e56e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXE5VDF0eEViZ0Y1djg0ZHEyRlpmZGZpTDlaV3Z0L05lSy9RTjVObjFRWVVt?=
 =?utf-8?B?VDdWRnl0QVBwTlhDam8yZlppYmdESElrbmhtN3VQTnpzOTJnclpBZ2l4MmlT?=
 =?utf-8?B?bm8xWng0YWk4L3pZTTNVMkVGWWZ2WGhqckF0cTRpNXRML0lwOGZwZjNUSytx?=
 =?utf-8?B?VWZSSTVOQmhrbHlLc2RKeSsxREFhRFhmM01pTU5rN3R6dVhXcUY1WnI1MnU1?=
 =?utf-8?B?VHJyYnE5ZUtjSUhlTkxDTzlDOGswemFDeWFoOE81TXJYWk5rTXhHSnNVME94?=
 =?utf-8?B?TUV4VXlwOVRORDNCVjZ5alNwdFV0UG9pY2JrK2ttK09SbEZTem40SEdxK3cx?=
 =?utf-8?B?VDRxcXlnUzQyTU0xRmNDVksrMzg4ZFljNFRQeGY3VmdlVnJKdTh2MXZHdWU4?=
 =?utf-8?B?aGdabFE4Qm0vZW5MWUhCbG81bGZKMUVXN3grd0VOQWR5V29CVzNUbU1wdDgw?=
 =?utf-8?B?SEs4OE54ZHJIY0ZMOWJtMEZTaWRPWXRkRXJTaWhVRnd3ZU5Sc3pPVGNxRXpo?=
 =?utf-8?B?NDd3UTJxM2JWRGJsZVpWa2piVjl1YWorazc4ZWZsUjJoVnNybXB6TlJrdkly?=
 =?utf-8?B?M1dyVG1jeWMvVzdtTEdRcDVWY0R4QndCM2VOQ2ZRQWZ0eXhxUThHSk9pR1Uw?=
 =?utf-8?B?WlR3YkpGMlBzQWRnc2MwbVFwSzJqU3FNQXFFMHBKY2o1VW5mdkxOT3hpV3Nx?=
 =?utf-8?B?MnQrUFJ4RnRkVi92ZDRFaTBzRDQ0c1llZGdhOGEwMGFoTjFTbWdxMzNIU1ll?=
 =?utf-8?B?ZUpTODQydWczWmQ0dFpGWTZLVXJZUFVEQ3k1MmhFZ2hBMXpVNGNUMWc3Z2Y1?=
 =?utf-8?B?aVpldGZ1UXUxWEJWelgwVmUvbVhJMW9mNXFoZmJqeEtkTWtVaDRSejNZSmkz?=
 =?utf-8?B?d3VyZllEUlAvUjhtQnVGTmszdzlFRlNYanhsVkt0NU5kaXFQbWJUNXRpVlpp?=
 =?utf-8?B?VVY5VmhpN0NTMko0eE5oZnB2czlIYkpPSGIzL2E0dVcwWERabDRGNXRyNWR4?=
 =?utf-8?B?dmlVbmNWK1cvaDI4Q09XVXk2QS9OS2xjRFpDV09TbHdyaWdqNHFpNENydXN5?=
 =?utf-8?B?ZDN1VStBWlQ5MXdjdG1nTUxCeFhXeUpob0hMU1hVOTRHcHRXN2pGelNORVNS?=
 =?utf-8?B?UDJiVmdNbWxlaDdoQnFVR1JLa1dTUGpMU1JmVVphb1B5azBlN0oyaU1mMEJG?=
 =?utf-8?B?aVVRcnZtNVFBMnB3SkJ2YlFqUUlpWHhEc2d3YW5HUjg5d2hDUlducWpyR2Rl?=
 =?utf-8?B?NG9oOFgzT3FDd0IreDk3ZnVDNjdIZi9RaW1GMldTUXlMNy9WVCtXVVViQnZR?=
 =?utf-8?B?MDRoZk1LZ3QzbkxBT1J0blhIcHFuTE95OHZwK2F0SXB2YjNVQzgwUXZudDVV?=
 =?utf-8?B?RFNkeFFHU2Q5N01lWmFBWkllL3BRcmhRcGdpaElySFBKZjY0em1XTFVET0Rw?=
 =?utf-8?B?ancwVGlMWnBtY3hSTFZ6WWl3WDZGNFY5M2tkZmE4bmQya3c2elpJTy9VdzRM?=
 =?utf-8?B?YWljR2s0bUY4c3dFM3RRbmlTWlJHdkhMclZTTFZKRCsxZ09KMXNNTWgvQUdX?=
 =?utf-8?B?RUc3VmtBK1RYTERUVlpVL0tSTlRJTG82WFB2N1V1NUhOYmZ5STc2MHB1NkpT?=
 =?utf-8?B?MG9kekYwWFd4cXk2NFpFQmZjSEpQcVJYbG1LZ0tuNjBTRHE5S00wUm11U0Vq?=
 =?utf-8?B?MnJ4RlBqcGg2akJiTDZwWDZKYmVVK0g0L0c0NExuS0xFVHFUMko0a2V3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDJTYm9xWmxMKzRrNzNQZUM2cDM1b25BOXAyR2pUcmxTSDY2ZE96RzR5eEor?=
 =?utf-8?B?UHRiMzlDZmlYMmRHck5NOWdHb2MyNXFpd3c3aFkrb2tuMFV1OEdEZTZZRXkw?=
 =?utf-8?B?eWg4TjJpWUxHUGJCeDE0YWJXaWp6UklPLzFETFVTR3VONUpVNUdJY3VQWi8w?=
 =?utf-8?B?dVNhK0FZUVNsR3djRFBHNm9ZektmZ04rS2lOa2x0TXh1bG1SYk13TmRURE9P?=
 =?utf-8?B?ZlcvbWxTTjJmRkJUa3BseWVMNTNRd0dxd0Q5V0NBbGUyeVRJSW41cnBxY3FB?=
 =?utf-8?B?by9ibEh4TmwvaFhvcmsveVBoTklqVm1aeXpkUnV3YUNma2hMTmIyV0lJTzNE?=
 =?utf-8?B?aFFiTFd0SGROYkR5NE9ydlpuVUJMWVdCMENzRnkrNjFaR3YxQmFtQ1U3VG1H?=
 =?utf-8?B?TDYxajZPOVFlYzYzWVRIUW45N3BBcmRtTDJ0clRnQm1uTU1ZcDZpWDlWRnJ1?=
 =?utf-8?B?cUtVR2xRTGd2dGhJL01zNGlyUXIvZ09NRGs1TCt0M3R6dXFrUGZoUkFsYXg3?=
 =?utf-8?B?ZVNhUU9MZnhMZVJkVDYwYmJ5Yldzcm8yRWNMYzRLakhMdDJ0T2ttOUlUL05G?=
 =?utf-8?B?Zll5dDZUNmJ4MkNJRTJiQ2NhY1lkdTV2QVFnK0JhS1FmRU5mSkMySkE0cEZz?=
 =?utf-8?B?eFlkRVRpbnBRWCtDR0REOE5LSHgyekRweWhQK3Ryd0haVjRVTEpDZUUyU1F4?=
 =?utf-8?B?TVFKWENUUVVVUjZMY2IzcUdKaU9sWktKTGJLc0xkU3U2TG1hakhGVStqaDBS?=
 =?utf-8?B?RlBDekF5SUwyUjZhaHBrRG1iRTB4d2pZcnRxWHhCWTMyeUgzQ0dXZWcyT2lH?=
 =?utf-8?B?VnVCK1JlaWxnbms4eSt4Y1NBd29KY1U5bHQrWGs4RlZlcWdBcHl4cFFCaHl3?=
 =?utf-8?B?QjlNczN2dkdFazdDalFZZjRXM2x1THRhZkFNSlpCa2xOaC9MRHNlVGxka3RW?=
 =?utf-8?B?WkY5MFpHK0ppZ2ZHNUk5cGVwZEk5U0dCYVNFMTBRbXNGd1luSzhVK3Yyc0JS?=
 =?utf-8?B?ZjA5eDQvazgzUXpCLzQ0bE9pOXFvZDJrUWhoQmlFSlc3cE9STHRIOUFRVVlx?=
 =?utf-8?B?SmdmVWsvU0FKR2tBbC9pREJjSGlVNG5ZSWErLy9nRFJIeXZyMnRuMlZRdHNo?=
 =?utf-8?B?ZWxSWkJGQmRLTjMyaFVBVjJvN3VYeWlDT2ZIbzVnZGhjTU84NDgyenZQWFdU?=
 =?utf-8?B?cWxpNHFhbWNTK2MxbEhudUlQWFJnbmhxNHVtbDN2NDZ1UjFHZE11VmJ2M1Zx?=
 =?utf-8?B?enFDUmplNnBJREhYMExGVCtpTkVnRzUrT2Z0WXBiTVlsdWFhUmRXcEVTbklx?=
 =?utf-8?B?MFl2WmlMaUQ1MG1iMW9rbEUzOEk0VXJmV0Fvc2gzM295Y0RzamFFLy9Pa0lZ?=
 =?utf-8?B?cjV5ZHdmUWhLc0JLQTdXL2ZhU2drck81WVdaRzA2a3RjYXhlTkZsdVJuVWNH?=
 =?utf-8?B?dzJtbmQ5ZDFaZ1ZHUEdMb0lOQjk0OE9URTAwZFROV0d5QWs0Y3NuL1FVb2VH?=
 =?utf-8?B?Uko2ZDhLb2ZnUG80MHZKVjcwcm05Y0s5VS9qbUxLS09UdFpDK0FOa3UxN0sx?=
 =?utf-8?B?R2g3aXFESXIvSmQ2NW9LelBVQWZudjdJYU5vWWQ0bE1ZZlRYU210Ujg2VG1M?=
 =?utf-8?B?aS9LL2N0d3Vnb2szeDhZN3NQMk85Mk41UzFsNkxPL3FzVEY0M1ozSDNacFNv?=
 =?utf-8?B?V1hlSWtiS0t4d2lCbjBheG9aVndBZFM5RCtaM0RjVFg2aHluNnBxMkpnUTFr?=
 =?utf-8?B?U0pEenc2K2lWNXFBdmRKZXBtRUQvKzNwUnpqMWFFdktlRGhhNjBodmdsT2Jx?=
 =?utf-8?B?Z0RhTGhsdUxVc3haMzYzaWovemp0L216Sis2T29qQ0kwVEVIT0dDUUdNV21U?=
 =?utf-8?B?a0lTeVVhU2k2dVFxNms2aTA2RDgzNW1VWGRzUEZwQmE1R0NlNWFJY0FuN2pk?=
 =?utf-8?B?VFlTZTMySkpnQWgyQXl5ZDF0eW93ekxLQ3JBSlNjMEFSRjV6N3pqN3J1VHhp?=
 =?utf-8?B?bkRNakUyT3NnUE5mdCsyVFIzYzZkemdSSWV0QjNYWWFiajI2dFo2OUNWMnRk?=
 =?utf-8?B?aDMyUWpOVmhhRmVtYmZYbkVISk5jRHpXMVVRRnRJQ1cwMzFYa3ZjRTdOTzRJ?=
 =?utf-8?Q?LatyyMSxKpMOu5e9ghFdZnrfl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4763cd42-ca68-427b-5118-08dc7b6e56e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 21:21:41.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEG/XHbscqOuNaaSRbvXEMVYAcIUQycs+x8+4i/Bm8J/2HwTdgdO1zGS2l+3bBHzpo6GxrfStnu3OUEYnOQAKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862

Hi Alison,

On 5/22/2024 5:03 PM, Alison Schofield wrote:
> On Wed, May 22, 2024 at 03:08:37PM +0000, Smita Koralahalli wrote:
>> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
>>
>> Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
>> Severity, Device ID, Device Serial number and CXL RAS capability struct in
>> struct cxl_cper_prot_err. Include this struct as a member of struct
>> cxl_cper_work_data.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/acpi/apei/ghes.c        | 10 +++++
>>   drivers/firmware/efi/cper_cxl.c | 66 +++++++++++++++++++++++++++++++++
>>   include/linux/cxl-event.h       | 26 +++++++++++++
>>   3 files changed, 102 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 623cc0cb4a65..1a58032770ee 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -717,6 +717,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>>   	schedule_work(cxl_cper_work);
>>   }
>>   
>> +static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
>> +{
>> +	struct cxl_cper_work_data wd;
>> +
>> +	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_err))
>> +		return;
>> +}
>> +
>>   int cxl_cper_register_work(struct work_struct *work)
>>   {
>>   	if (cxl_cper_work)
>> @@ -791,6 +799,8 @@ static bool ghes_do_proc(struct ghes *ghes,
>>   			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>>   
>>   			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
>> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>> +			cxl_cper_handle_prot_err(gdata);
>>   		} else {
>>   			void *err = acpi_hest_get_payload(gdata);
>>   
>> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
>> index 4fd8d783993e..03b9839f3b73 100644
>> --- a/drivers/firmware/efi/cper_cxl.c
>> +++ b/drivers/firmware/efi/cper_cxl.c
>> @@ -8,6 +8,7 @@
>>    */
>>   
>>   #include <linux/cper.h>
>> +#include <acpi/ghes.h>
>>   #include "cper_cxl.h"
>>   
>>   #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
>> @@ -44,6 +45,17 @@ enum {
>>   	USP,	/* CXL Upstream Switch Port */
>>   };
>>   
>> +static enum cxl_aer_err_type cper_severity_cxl_aer(int cper_severity)
>> +{
>> +	switch (cper_severity) {
>> +	case CPER_SEV_RECOVERABLE:
>> +	case CPER_SEV_FATAL:
>> +		return CXL_AER_UNCORRECTABLE;
>> +	default:
>> +		return CXL_AER_CORRECTABLE;
>> +	}
>> +}
>> +
>>   void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
>>   {
>>   	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
>> @@ -176,3 +188,57 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>>   			       sizeof(cxl_ras->header_log), 0);
>>   	}
>>   }
>> +
>> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
>> +				  struct cxl_cper_prot_err *p_err)
>> +{
>> +	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
>> +	u8 *dvsec_start, *cap_start;
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID)) {
>> +		pr_err(FW_WARN "No Device ID\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * The device ID or agent address is required for CXL RCD, CXL
>> +	 * SLD, CXL LD, CXL Fabric Manager Managed LD, CXL Root Port,
>> +	 * CXL Downstream Switch Port and CXL Upstream Switch Port.
>> +	 */
>> +	if (prot_err->agent_type <= 0x7 && prot_err->agent_type != RCH_DP) {
> 
> For this check against agent_type, and the similar one below, would a boolean
> array indexed by the agent type work? That would avoid the <= 0x7 and > 0x4
> below. It seems one array would suffice for this case, but naming it isn't obvious
> to me. Maybe it'll be to you.
> 
> Something similar to what is done for prot_err_agent_type_strs[]
> 
> static const bool agent_requires_id_address_serial[] = {
> 	true,	/* RDC */ 	
> 	false,	/* RCH_DP */
> 	.
> 	.
> 	.
> };
> 
> 

Noted. Will implement it this way!

Thanks
Smita

>> +		p_err->segment = prot_err->agent_addr.segment;
>> +		p_err->bus = prot_err->agent_addr.bus;
>> +		p_err->device = prot_err->agent_addr.device;
>> +		p_err->function = prot_err->agent_addr.function;
>> +	} else {
>> +		pr_err(FW_WARN "Invalid agent type\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
>> +		pr_err(FW_WARN "Invalid Protocol Error log\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dvsec_start = (u8 *)(prot_err + 1);
>> +	cap_start = dvsec_start + prot_err->dvsec_len;
>> +	p_err->cxl_ras = *(struct cxl_ras_capability_regs *)cap_start;
>> +
>> +	/*
>> +	 * Set device serial number unconditionally.
>> +	 *
>> +	 * Print a warning message if it is not valid. The device serial
>> +	 * number is required for CXL RCD, CXL SLD, CXL LD and CXL Fabric
>> +	 * Manager Managed LD.
>> +	 */
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
>> +	      prot_err->agent_type > 0x4 || prot_err->agent_type == RCH_DP)
> 
> then this also can be replaced with
> 		agent_requires_id_address_serial[prot_err->agent_type]
> 
> 
> -- Alison
> 
> 
>> +		pr_warn(FW_WARN "No Device Serial number\n");
>> +
>> +	p_err->lower_dw = prot_err->dev_serial_num.lower_dw;
>> +	p_err->upper_dw = prot_err->dev_serial_num.upper_dw;
>> +
>> +	p_err->severity = cper_severity_cxl_aer(gdata->error_severity);
>> +
>> +	return 0;
>> +}
> 
> snip
> 

