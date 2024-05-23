Return-Path: <linux-efi+bounces-1082-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ED98CDC31
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 23:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CA31C2362A
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 21:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3C811FF;
	Thu, 23 May 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HHBby78g"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A498101E2;
	Thu, 23 May 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500258; cv=fail; b=O1p28aGUgK4yHCW1oRIOxGFz0ZbT/RRNDgpptB48s2EZ3aNa7lltuKo8OADHDBxeWimfZ+12cUpPTcP2wKQuwd7xEfyvAIYU3GBDPixjyS52el1uq0J5jdRpiLxZSl4EHi+T3IQqcfE7eKZhwIj/sEoha+uTNOZ8zygL8gQloxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500258; c=relaxed/simple;
	bh=fxQp7p/RbdCLgjOnobzikWMeZCzGaYAl5Civ9tzWI9k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=ov2z8Bro1p2uo5MQD2KVuO+5/ebaBEh0JyyNTk8Oop6SSWdKDoRHvu58HOPlor5oPYY4ZTF69s8GztRe5d0cztuVrJ8RxEPgihQ1ITVTvKlmMQJo7v/r0i2RYXtEGUyqyknWdEpKr9bv/r1wq3Zc2+rezufUMy2hRh0EwvdelR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HHBby78g; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZFvWQ/l1vDUNDUA3D8OAlccSPHIGmNNabSAx0lWezLGLWivJAOZ2DzPiqqCHICCSJSjPKm+K4VTCih/NMnQs6htnYed0HRS1L6O5abzzt+7hOMgMj0M3NxuqbzBhOq778QpgTL3UFKDB3x+moHHwxty5dmYk3OXI7hTTF9NYdOKUp/+uy+ZQwzmAJLga7TVaF3TfIWXwZr01L8duc9jRyYWdPlyk7pzdTFbs+y3j4WBnamdeKaS0v57dqTRb3H84mH2jZB9AtQphJnY+fHEqsMpKsZAIHoqWu2eyOB/gbRZmyf5YztdJgy959y4u6vkjDtKsZPP3LSCgZyPYkpyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3Wpz2x+I3ruAFjJDpFZiccr9mBzXhB6Dhf8OOivAus=;
 b=oH0mplo9j57l89R1dH7RGfE8gulvKtq3FRntXQ2JcMk9kWWmNVBuUAGa2ncBkivOJFMluMalbghUiHJf/R/DElKLwdWR3LzPqgj7x+4a6EKynsZaBJUWR9wPKXKW5D696/uMe7x7WLUid8rOVEnKbUxyDtcj8UejZmPH05M7vbwlVZrlRTyfzbvvNVeMSod5cTG2LnT4I2TZskVjTQhEwBdkyUQQrcG53I4LaAuB63Y/2g6j0fzjoObev1iwB+18cZmkTXvkH+ygS3fiFkS/a2a5KK0joR16gq9fz4T7/Zx3UV00sFo8K184xbSIvTsJZOz4cVhEhug9xfIpou5lCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3Wpz2x+I3ruAFjJDpFZiccr9mBzXhB6Dhf8OOivAus=;
 b=HHBby78gTnq7w6U+wC0upprPh/QL1b1ekdFtwSBD6/QSPQgczwS3aeASf9VD7fxSvquHmcmqXp62WJ8xv+IDgsW1ztgZsNwcdTf9fXPnxRKaEfgL3fe7IQdJGLYGCGrg6/mF6C5xynZOo1iBvYnv1SCwt4RRfpPPJD1ATJSpgYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 21:37:34 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 21:37:34 +0000
Subject: Re: [PATCH 4/4] cxl/pci: Define a common function get_cxl_dev()
To: Dave Jiang <dave.jiang@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-5-Smita.KoralahalliChannabasappa@amd.com>
 <dd0f3183-e10b-4a3d-98b6-c6963dc86512@intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <07d6242c-b6fd-f651-3c72-e3fe26eddbe5@amd.com>
Date: Thu, 23 May 2024 14:37:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <dd0f3183-e10b-4a3d-98b6-c6963dc86512@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c75da61-b282-4c72-5d89-08dc7b708ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzVETTJHWFpKSUwxY1VrYkw1MVFKNmpMbFVNbk1MbGlxQmgyTWpYbGhyNVgz?=
 =?utf-8?B?N3RYK3VqeGdGdHMvbWZieCtyNlgvN2RBc09RcVZVek04dDB5dkFwWjExaTZI?=
 =?utf-8?B?N2tzRy9LOTk5bWFOQUpCaG1kWnp2cm5pZ2hQYWJKeTd4anhESTNIeTBBNTk0?=
 =?utf-8?B?Ynp1MEs2aU5tY3hSL3FDdmJsbyswdEZpck9LSTY3c0lKVEhrWklVeVpKaVVl?=
 =?utf-8?B?SmdxcTZWek5MUm5SOFMzSll0bk9wMG5wTndEVFYyRVp5dFNFWVRITnNlK240?=
 =?utf-8?B?cVJwT3oyRE5CK3VXcTVibCtlTWFJTzJDejAyTmRWb0FxK1ZIUVhFVXNGNmcy?=
 =?utf-8?B?OSsxZVdBNG11VG44WHFBMTRvVG9lZGFBNGNDN08rNWxXTUVreGt3Uko5RGl6?=
 =?utf-8?B?cm5jQ09uUDRiOXNvRkwzTFVwTTdSUnp2eHMrak1ObmtKZzNWYUY3WHJLZUw5?=
 =?utf-8?B?ZXNkMG8zeXRUKzQxNGRCREJDMTNaeUtxMEk0dFIrenNlVkpTdWY4YU1tTDk3?=
 =?utf-8?B?ODNzNFp5NnNOMDVTOTB0L1VtK0dIYm4xcDlKK1dhbE9xTFhLZmJ6YXhjSitQ?=
 =?utf-8?B?aEZlNC9RNjlhTHpwWGkxeFNRMzY2anRSZ2xOYzFxUTJ6RmFKNE1hWGdyS0s0?=
 =?utf-8?B?M04vYnRIdnpYM0FFTW5malB3dWFhZVpWNE9qL2s1aHZrUzhSUmF6ZExwWFQ0?=
 =?utf-8?B?RmRhTElmNXhZRDVXZ0RiUDRWN3N4UDA0UTlRemNBRlp6VEQ1eEIyd2ptRVZZ?=
 =?utf-8?B?cVRvNmEweVZFdlZZKzkyRXpyTk9JQnlpQlpkczFWZFRKc1hrdWFSZlNGVmRh?=
 =?utf-8?B?eTQvOGQweWJRbGs3Zm80ZWJJenBSYWlCb245a21LOWFTR3R3aGxhdFFSaHJ4?=
 =?utf-8?B?NWcwM2twbnY5emxRcVppKy9nMzZ1M0g1cldWTm41OEhNaTM4amxxeGoySk5N?=
 =?utf-8?B?ZDhLUG10NnFSNHdmUC8wN1lrODZrbGY2K0plam1DS25LdElFMnRTM3E0b1RW?=
 =?utf-8?B?em1HVGZKcFlOQlV4dHVrck1nSUZMblB6UWRzYndKbzArYzlxZFoxSTZOcmR3?=
 =?utf-8?B?YnRYenFKV2tQeTUrYlJzL1phVXJZbEpsOUdMNnhPVjhMZ01iSHRORDNFcTVy?=
 =?utf-8?B?bTdJL29ubVBYakZhN0x1TTlCVWlMbEVzUWkvTWxSRkZrZWZtazVkRnJzTjlZ?=
 =?utf-8?B?TEpwcGczcE5YY0hhMElWWlNqQlVFV2hKN3RxWWN6U3NrSkRLSUY5WjBRTjll?=
 =?utf-8?B?dCtMQnJKMDZ4Nm80OU01WHhuQzVhalBjanpORCtlMGZISGlKVjEyT3A0eVl3?=
 =?utf-8?B?Rmw3ZTRXN250c3p0WVdlZk42bEhKTkpTRTVQZ2VZa2hRZnN3ZG05QU1ZS1d1?=
 =?utf-8?B?MW9ZV2h6dUJFdStiRkJHU1N0SzcvLzVHYVF5K3BwRHdCN1NFL2dCUHM1d2l0?=
 =?utf-8?B?aUZZS0xCdDVDaU9PNnBaNDdCNnlFOGoxTGlqTDdoc2JHazI0SlpjcHNLTHJo?=
 =?utf-8?B?N3BYVDVmRXMvazA1UE9tb3Z5RFg3ZDNlaGZmRkRVUi9BenM0RVk2RjkweUNv?=
 =?utf-8?B?VStsRUp3RHVYMVUrU2plRnJNSVBVTnpDWEd5U0NCMWNTaFlXT0EycEhleldt?=
 =?utf-8?B?Y2pGenI2VnZpVkRjSEF3aE9OSlZ0QUtneDB2MXFTYnFFMG1mVm56aVRzMGZS?=
 =?utf-8?B?c3RpeEhwUjBUckFQZFB0aXNWdGlzU01KRWs2bnZlMDJhUnpmWTQzUThnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0J4ZFhjTFN6WEVGekdRNk1jdXpwc1c1VEptN2VOR1dRTjFuUzNRaFd4ZXpE?=
 =?utf-8?B?bG01N0F0QlJXR2ZmNStUTCtyZGgzd25MeHg2bjlnTUtCMjlpZmFUNXZMSFV3?=
 =?utf-8?B?c0Z4UjZLZkcycEpMdk5LWE5BdTVzNnozK1JpM3FqTGdYVUtFUHJWbHQ3TVNr?=
 =?utf-8?B?OTVXZ1JoWjhqVlQ3aFUwbmQxdUxkTGppR3RBZ2t1WFp4SDRkcEVEL0NQajRD?=
 =?utf-8?B?bFdSUzBDNS9waEV0YTFWSStzSS8vL1pCcVVmMG9CME8wU2JWaUh1UUZmc3RR?=
 =?utf-8?B?MC9ZaWxMU2JEZlZrUFZibE1hRzNpNmprWnhIV2pmT24zQnJPaEs3UmNFNmdj?=
 =?utf-8?B?dzBQazB2VkJiRzZVOGpuUWhkSC9DZnRYcElYK1dHbjdmUFVPSGx4WjNtRVR6?=
 =?utf-8?B?ejNnVHV1cGg5VXlKZ1pFM0pEYTJOd2I1V2wreEVCMXUyTU5DZU5DYXdRcEYx?=
 =?utf-8?B?clJKTlBLSHVtNkttcnJEOFFQZFlNVU1HYVNtakt4THBURWhTdGw5VjNDVlo0?=
 =?utf-8?B?eldFSmV1ZHJaUzdBMVJLMERCVnBhVUVrRVNKbG94R1Y1eFNhcmMza0pETnFS?=
 =?utf-8?B?eWJwMkJaSzV2bXA1ZmRwdjVxOG5GTWNtdkh6V1ZoSXkrSUkxL3ppTzN3WEVG?=
 =?utf-8?B?MlYwUzMxaWh4ZVpjc0ZBVWlQWFlOOW9qSWNQejQ2OUxiWERjOHcwT3h6Uk55?=
 =?utf-8?B?aFhEYy9wUm1WOW5kQ01VcHR1SFlIK2h5ajFEeC81NlE1ekxlSU5VdVpReFl3?=
 =?utf-8?B?YU9kdURVZGxvaEdSODA5S3Iwb2h0OFlSWU5FT3puRGFPNUM2OE05cTJqaS9r?=
 =?utf-8?B?ekxiTzE5Q0lXUGY0R3NmVXNqVWpKRDNrY2d2SlBINGNtOGtpS21ld1VncGRP?=
 =?utf-8?B?aU5qNGR6VDJRb3k3akMxUDNTZUhWQk5sZzgxZEZPWWlHbU9PNGU1ZlRDak4v?=
 =?utf-8?B?Tmkzd0NZOW1WaUxKanVVcW01SW54L0tGNHBIYXlQTTBoQmlJNkJlVFFxNW9x?=
 =?utf-8?B?VHAwNGNZZEJzZXF6ZWhsOWlNSjhvVHh5M0N2RVBKRVppeWJvRFF0eE5wVHVW?=
 =?utf-8?B?UjlPMFhFMDRZRzFlRXVnZmFzSTZFeCtRUFlrdS9MR05vNmZmUkw0Vm9Cd1Ns?=
 =?utf-8?B?WkFaZFZENTgyMFdnYWdBODl5Q2V4eDYvSVdUc2tWc0dVSHNjVGRnTVR5Z2Ry?=
 =?utf-8?B?L1Zuc0tBYTdiT0dhZXRyV21jbGRkV1RCaHR0MHQ3aEZNNFJUSmN5NFIyQVdm?=
 =?utf-8?B?K3hKRDVjdG52QnVTUzFSRXNYb1F5U2MwVFNYWDM0YWpubVk1Tnk4dStjUC8y?=
 =?utf-8?B?dURkeU5lMmhvMzg4bFlYUm8yOXJ0Uk1qd2hWZ21WVlAvd1JaOGl1aTZ0SnJJ?=
 =?utf-8?B?UUpUaG9NYTJXVnd2R2Y4MGhoem1KaHRqaDZUcGxqQkZoYjdqRytCNEdlWU9o?=
 =?utf-8?B?WHRJOTIyNVkxRnpOTlMvN3pnS2FIdStQaHo3ZzhZamwvaE0xSFo3TG1rcVFU?=
 =?utf-8?B?cXI1U0gycTdETGp6SkdKNCtSN1RaVDVsWFkrOVlWZE1ia1AyTklaNFhRb2FG?=
 =?utf-8?B?UTdhYndsSDZ5TDRpcXpjdWxPTHRPNi9ESzE5WjhSWUs4S1ZDVkRIWnZSQXpH?=
 =?utf-8?B?SlF5clBwNDFTYTVkdzZRa0xEWXBUNEZzYWlrWnJqcTgxSG9GeXRNU1JYU1hl?=
 =?utf-8?B?VjErZmZER0F1Mm9WQXllMG5sbG9vSzFkaHpEeGUwRjhrckhkbXJJTVRDQ2NC?=
 =?utf-8?B?WXpycW5haFBmVHZSbUhMNDhTOUxyV1RJeUhyNllkdkpEd3pOUXQvRklYcmlM?=
 =?utf-8?B?cGxwSUlNVzFWUGlvdjJvSngxMkd3QmR6bWZ6cllUUEl1MmZTamlhaVFrZk1Y?=
 =?utf-8?B?VkJqRUFzZlVQNzhld3JpaEpPVVAxMUo0UTdZejI3YVdnbUc3cTltMjY3M0pt?=
 =?utf-8?B?am5TUDZJL21iWjR4RDdVRVl3V0h0SG51WmprRGE3UU9Bcll5SFp3NE5JdHVq?=
 =?utf-8?B?Y3VtV2FGUFRCZHVIVWI2UVg4WlVkd3lucWhiVGVwTzdlc1ROd05YSGNmQ0Rz?=
 =?utf-8?B?N1NXNkRuWXlkMytpRGh2TkVSeHNXM1pNL2FTdHNSOXBYdHROcjJpWU1nTHJO?=
 =?utf-8?Q?peIB45FfiZ3ME4ozccBjIy4Uo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c75da61-b282-4c72-5d89-08dc7b708ee8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 21:37:34.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKVFE3v0j62y+7zhjMKIL7w14O3P0HdBft6G6tlmscUFHPqXNJtBjZvQ80Kb8NpO8Nmh08XOyQdpNda4oWtP0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856

On 5/22/2024 12:42 PM, Dave Jiang wrote:
> 
> 
> On 5/22/24 8:08 AM, Smita Koralahalli wrote:
>> Refactor computation of cxlds to a common function get_cxl_dev() and reuse
>> the function in both cxl_handle_cper_event() and cxl_handle_prot_err().
> 
> I think just introduce the function where you open coded it instead of adding code and then deleting them in the same series.

Okay refactor first, then add trace support. Will change.

>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/cxl/pci.c | 52 +++++++++++++++++++++++------------------------
>>   1 file changed, 26 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 3e3c36983686..26e65e5b68cb 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -974,32 +974,43 @@ static struct pci_driver cxl_pci_driver = {
>>   	},
>>   };
>>   
>> +static struct cxl_dev_state *get_cxl_dev(u16 segment, u8 bus, u8 device,
>> +					 u8 function)
> 
> get_cxlds() or get_cxl_device_state() would be better.

Okay will change
> 
> DJ
> 

Thanks
Smita

>> +{
>> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>> +	struct cxl_dev_state *cxlds;
>> +	unsigned int devfn;
>> +
>> +	devfn = PCI_DEVFN(device, function);
>> +	pdev = pci_get_domain_bus_and_slot(segment, bus, devfn);
>> +
>> +	if (!pdev)
>> +		return NULL;
>> +
>> +	guard(device)(&pdev->dev);
>> +	if (pdev->driver != &cxl_pci_driver)
>> +		return NULL;
>> +
>> +	cxlds = pci_get_drvdata(pdev);
>> +
>> +	return cxlds;
>> +}
>> +
>>   #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
>>   static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>>   				  struct cxl_cper_event_rec *rec)
>>   {
>>   	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
>> -	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>>   	enum cxl_event_log_type log_type;
>>   	struct cxl_dev_state *cxlds;
>> -	unsigned int devfn;
>>   	u32 hdr_flags;
>>   
>>   	pr_debug("CPER event %d for device %u:%u:%u.%u\n", ev_type,
>>   		 device_id->segment_num, device_id->bus_num,
>>   		 device_id->device_num, device_id->func_num);
>>   
>> -	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
>> -	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
>> -					   device_id->bus_num, devfn);
>> -	if (!pdev)
>> -		return;
>> -
>> -	guard(device)(&pdev->dev);
>> -	if (pdev->driver != &cxl_pci_driver)
>> -		return;
>> -
>> -	cxlds = pci_get_drvdata(pdev);
>> +	cxlds = get_cxl_dev(device_id->segment_num, device_id->bus_num,
>> +			    device_id->device_num, device_id->func_num);
>>   	if (!cxlds)
>>   		return;
>>   
>> @@ -1013,21 +1024,10 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>>   
>>   static void cxl_handle_prot_err(struct cxl_cper_prot_err *p_err)
>>   {
>> -	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>>   	struct cxl_dev_state *cxlds;
>> -	unsigned int devfn;
>>   
>> -	devfn = PCI_DEVFN(p_err->device, p_err->function);
>> -	pdev = pci_get_domain_bus_and_slot(p_err->segment,
>> -					   p_err->bus, devfn);
>> -	if (!pdev)
>> -		return;
>> -
>> -	guard(device)(&pdev->dev);
>> -	if (pdev->driver != &cxl_pci_driver)
>> -		return;
>> -
>> -	cxlds = pci_get_drvdata(pdev);
>> +	cxlds = get_cxl_dev(p_err->segment, p_err->bus,
>> +			    p_err->device, p_err->function);
>>   	if (!cxlds)
>>   		return;
>>   

