Return-Path: <linux-efi+bounces-1898-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCBF98F66F
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 20:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4DAB225EE
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5D1AC88D;
	Thu,  3 Oct 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f0hzwgZ7"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A371AC44F;
	Thu,  3 Oct 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981065; cv=fail; b=ZwfMFvt8Ocbfz8hk4O4YCXzhz7HGYo+lqWUUM1t3qFDibax1UZU5EkSQPCPcw/a8mzcdAbN+c9NWgXWXigXoNkGW09e9Yre7KVHnqcGYGjMcZveP7nz4oPDiy2IUKza6Cc9Es2RX2I9gs0qNhOK2WZjbHREuXreL40lvDsH70Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981065; c=relaxed/simple;
	bh=ZyUgNjZSCbbnIRy2TZ+ey7O5JYE6zhV09jz85n+jQi0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=hM/KSwGB5jBQeQzGwg07AdhZ7E1KwIZ4eQvVR/Bs9M/4QXm9FJnZ+wYJN1LlpUNzNIGS1u2u29q0ot5lBogeRQc7cS78ut5nDgtQ89LoHT8FIgDrEkHRLWi35r8OiPZDngpWE2BpXLaUAcJPeaj2tgE/BbCRQxJYhFrKLTAitlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f0hzwgZ7; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOaQdxwur9Hx4ByOINFjd1EU52VgEUui0VcKuwsqteEr7lOSRfw0JcUQHmLenJSPRMV++/rjCGo0e6FRV3PAdGwit86BLjWkwuHoQrN9htbg0r6oqC3RTNtagFymMy+fU32iZexUQdKKsVBWvaNbynqP69IvqJJ2rlVRJtEdJmu44sKMbJKQeQ+frUN00tEY3hLc25mNLyd6g8qpiczHTixC/wuWg1zQzUnQHyPJUxGHZaFRx0eMh2N0Mvgxs+JFxmn1k2ukAbiQfysweKw8b2zvBmGmJf8tdJxdVMfZJWOgeGPTOoZ0AiSXNDpdO0/eC+I+vDcpN1DzXZUmNkKHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwQKrpreN9LCjvp93T5RS6BEKWEBihtDG1bFWpS25AM=;
 b=YiiLhHX6wqJBQQuQL7/SAe6VASi6Nok2Vcgad0QJ5IuxJQYZjYGqvYHIJwtxYDEGNjd638qZvEkrhHJLsrKVQot+GL3HSthSiVxV/jLXcACIYJcxawc0H/VmsM+rvZLs92341vxpO2fjcxaVBUHSC4BVgm2ogTFHHM2qDjB8mlbluy12+zNEPIA6ykypwYFODtJSLmPtF9vg4dSIkIIAJmBzc1TvneUwDxV2nXYFY08sNfP4Ax3Pufa2QVQtz7egMKMoUm3Ri37F7sHeNsTudj1v+kHGMkrwu3sfyNLmHBDKN6I1wwDTlYsiKcCuM3O9Zt1xmbSihDfTnIoxD5+Wqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwQKrpreN9LCjvp93T5RS6BEKWEBihtDG1bFWpS25AM=;
 b=f0hzwgZ7HL/7UggiN4EgaYkz07RyNa4rUNWU4E7ffPz4yXSeAP5trCY7hyvQFj7wpoYYl/zC6ZvxIjo9FSHWXkqIIsIOx/l3jDO49IniWE/rbqIwVYVhtvbL8zDinKHbSPc06pU8qoyQMWG6iuXSINvQLozqhZAHth7W0nwV4Og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 18:44:19 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 18:44:19 +0000
Subject: Re: [PATCH v2 2/4] cxl/pci: Define a common function
 get_cxl_devstate()
To: Dan Williams <dan.j.williams@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-3-Smita.KoralahalliChannabasappa@amd.com>
 <66fdd178bced1_964f229451@dwillia2-xfh.jf.intel.com.notmuch>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <bca60d5d-a395-9733-5aed-b83bc924cbe6@amd.com>
Date: Thu, 3 Oct 2024 11:44:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <66fdd178bced1_964f229451@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::27) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 03469542-caf4-428f-796a-08dce3db63cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW15dEVGQXowaVpDUjYwQnRscGd2ZVVzZm9NVE1wcjMxZE1vTDhod1JDZGZL?=
 =?utf-8?B?M0J0TmYrbGVBR0N4MCs0WG5OQ2M5NUV5bDB0OEl2dmJFQ3JnNjFnbGhWUDZ5?=
 =?utf-8?B?ZXlJeTVEWW9jL05idWVOWDU0Umo2V1djSlVqU1p0WGk5UXRJczVMRkdTT1Mz?=
 =?utf-8?B?Wm91TTlHOW9CeVVkRjlhOHpIcXcvTzErNnIvQTRRQnplR2lyYmg5NjVoNDhR?=
 =?utf-8?B?YjRnOE03SmRMY3NtTkJNZmovU0hLNElqY2p0ZUkvQkpxRW94bE53Snh4REpk?=
 =?utf-8?B?QUJRMjEzN3BMeXM3clVuY2wxOHNHNXlESnRYc04xK1hraUNHblZibEQ2V1NP?=
 =?utf-8?B?dHkxOWErZkZucDBIM1l1R3NlNEpjamxtMmdFUnJCTzNhMzZtRVIvbmhlaDY4?=
 =?utf-8?B?SnFPQmNkUSthTkgveHI3T292WVZlS1lBRlVZZ2NwN3FLY0x4MXMwSjBOU0N1?=
 =?utf-8?B?SUt5cFQ3TEJCVHZKNEdwcFBpd1hBNDhCbVhHd1l0azZZdS8yZzV3NTYxSjRj?=
 =?utf-8?B?d2ZYdnlLN01TdkFNcjhNamsraFBla1IyZ0s1ZDQvajhRQnQzS0hWRSt4YTBZ?=
 =?utf-8?B?Ykx3UnY5OTB5Ukk1U202WWR4Z2RSNWI4UWhPeXloNTlSc1FuM1BwYUsrdGpG?=
 =?utf-8?B?MVNJVVBzV0JiSUdFRGU1eTlmZlI0ZitJN3RyZ21hRVdrWE03SkNxVlZkT0NM?=
 =?utf-8?B?c1Q0LzcvcjkxQ0NkTFZZdHdzMHdZZmswMmhVVWJ6Sm54ZU9BbGFheGxiOGZS?=
 =?utf-8?B?djZ2T1BFbXR5MGlwaGhTY29GNG56T1VqK2pIanVCZEY3Y0N4ekZQa3ZCNk15?=
 =?utf-8?B?OG55NERIVTJIYUtNYTF2ZVpFYzE1OW5RUmI2Rkd3bUFwTmJCOEJWVE5McnUy?=
 =?utf-8?B?NjBlbkdHTGdhV1h3NXQ2ZGxKd2JGOTRNZE41VDY5L05TQlZwbGdIYVV0bDdC?=
 =?utf-8?B?WUp0ZXlsblZ1UTU4Y2tvV2tKVG5RaWhSdEUxSzZWZ0hOM2tMODlQR2daWG5h?=
 =?utf-8?B?dkl6L3g3R2pTdUl3dU9NOEhXMjNBbnlpMjNlMytiamJiVTMxbXIzWDBFZmJZ?=
 =?utf-8?B?VzZoOG80Z2VrU2MyUUY3OFBFVDFhTnRJK3NLTlIvSXh5UEhBVU5vT1QyMENF?=
 =?utf-8?B?MnBhYS9KLzFzbTNiNEZISExrbUFuVnY5RjVCcjErWHpLQUdWVjJTenlDOWI1?=
 =?utf-8?B?T0FaNVU3TW01RzlCcitJaHhvbUkrV25rcklhMWxzNjJvSlpaQmg3TlhYRUxk?=
 =?utf-8?B?d0hkNHdDS0kyaUQxTFRJYUlzeUVYUVlqTFZ6Y2xCRzBEQm9EV21BVExwdFFM?=
 =?utf-8?B?NS9zVXNoemVUTXFsZjFzMmJZQlNySjJicysvMEdjQUg0Ukc0ZEpnamhuRFBQ?=
 =?utf-8?B?UURrdThkSjJlNlBWb21HWjV6d3lieDBzdXpObVJsYmRWN0tOZm12L25BODJh?=
 =?utf-8?B?bW03WjYrVEZtREdoVGIrSXRqSk5kaWFPVDZFbFdDYlBxbzI4dHZqWU9BUFkw?=
 =?utf-8?B?cU5PQkgwOUdtb3ErOFlBMExtY2NUUjBqbWc2aGZQU2JlTUJ2TlA4UFozQWpp?=
 =?utf-8?B?bmdKYlVFc1lURFN0U3hSdzVIUEllcmZVWHRWamtYOHBOMWdjSnNpVHdnL1BG?=
 =?utf-8?B?a1RvVC8rK3A3QU9telVTLy9MZHR0QVI5LytmbDRwV28wL1VaT0lHOXdKVnlh?=
 =?utf-8?B?b2FDSHc4aWtpZEpwVVVKN3NHU1VTaHVYNk9vQ0ZHeEEzWS9Wc0ZPR01nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WENTYW1BeWdmWlNzNEtKZE9ScXIybmJqQVhWTDV6SW1IL2NqRkxSOXh0Y1FN?=
 =?utf-8?B?UStvaUlBeXpwZzRrdUVkK3hBMUlocFg0Z3o4TjFGZ3dUMjJHTXVRTzhsV3Mx?=
 =?utf-8?B?SlQ2ODRsQWZaK3FqS0daSVNGZ2M1RWphbzBvNWFJSFdGS094SHJyUEQwYld5?=
 =?utf-8?B?KzlEU0xyMFlTUmorcGM3dTBxbkwrUXVuNGRKdDlVV2MxcU5BWkJtNDdsTzJE?=
 =?utf-8?B?a0JORGZhcml5ZEVTOUNiUk0vbmp3QU5TVlpJcWRmcHBKNFhtZXFvV1U4M2lq?=
 =?utf-8?B?empodXYzd0dBQWh6YUpXMlo0eFkyVWhJd21XQWRQOEV6aXJkOVlVVDUvNTV6?=
 =?utf-8?B?TnFyekkxSHFSa1N1OWVHRlZmL2lvMk5YNGdEa0tFVGllRHV4WGt1VzRHRXZG?=
 =?utf-8?B?NHREQ3Zrc2kydzllRCt6SE9BSEdLOUIrdDZPV0dzTkZjYzNvVGVSQ241b2hU?=
 =?utf-8?B?b2RSVnEzQ3I4aks0eE9UdnM4d1ZDUVhjWlpMWG94MkQ5Z1FySXN2WTFZMGor?=
 =?utf-8?B?UldzdWJXTDQ5UnNtMXRSck5KUUlkTjJDcUl3SVV0akdRbmhqMHUyek9mUFY0?=
 =?utf-8?B?Y1crRmFLTDlLVGptTy9QcHJUeXpRVXpqN3JPbC9PdHVhNVFESUp6b24xQXVY?=
 =?utf-8?B?OXJlc2MrR2tBejBWSkFXcnhjU0tQSGFrcXVENFBBa05MV1FvRzhNcDhJRmoy?=
 =?utf-8?B?UHI4a0t6U1NKbmpYY3BXbGh4ZDRJMGVTUWJkazh1K2xhcldmUTlBTzRQZGlh?=
 =?utf-8?B?VThYOUlSNWlwcEMwbTNLRnB4d3lNMDdIQzd3eWl1SHRYVG9wNEwzcy9sOG1D?=
 =?utf-8?B?WGhQNk45YVFCc2VJN2JyN2ozbllTajNSVU9jT0R4dDVQbGl6SzdqaVBxczV1?=
 =?utf-8?B?QWJmK0RueWpZbDFSeWZwbk9rMG9Ra2kzZExYdnJnZHgrUUxoSTFEMUluaVNs?=
 =?utf-8?B?cHB4UTRoOHlIV2hHSW5pWm1CNVppU0M1UjJ1N20yR0E3ZVJPaDlZWk8vbFVI?=
 =?utf-8?B?bFEvNThFNmViU3pCTUdqR1pmYVBZcWZ0K3QwRUh3ekQ4RmJsUXBBZHBmUmhV?=
 =?utf-8?B?R0kwOXZWNDhTZlYvd2pxMk9CNVZrTDlxdWp2dHU1aVZ1Y21QRTZkakpYbndy?=
 =?utf-8?B?aGJWbUR1SEkyS3RPbkdhckQ5d1ZTWnpscCtUSytMTEpLZVNDUzVqWnBGUlBS?=
 =?utf-8?B?eThKcTZZYThvRG00RUNYaThDait6eE1xZ3MwUzMzbFpNeEpOc2p6RmltcEF1?=
 =?utf-8?B?WVlkSlowQjI1M0UrNDk2Umh0QkxyaGJiQ3BuUlRIQ3YzRXMwdGp5bWpjRlJV?=
 =?utf-8?B?ajNrY3hoSUpQMXBKbDlzd2JNSkUreGMxYlU0MStVSUs5emdSVS9wbWRUQXFS?=
 =?utf-8?B?dXlDN3oyTXcyWHY1OHFVY2V6VGd0V1FVcSsrQkY5QnhmUEZxVHVZeWR5Mytw?=
 =?utf-8?B?Sm13RUY1NU9hNllXTUQ3eE1OQlZncEtXQ1dQaVpCVFRwNVBKMGw1eHJaU212?=
 =?utf-8?B?NE5BcWtsMmE5OWFQM1RzT29IazUvbFVIS0ZmYXRwNm0xVFJ6dXB0b1oxN2oy?=
 =?utf-8?B?Ukl4eG1KOTUzQlIxbWRvSmxkNGhqbWFDWEJVTFJLb0UrZjEya1FPcFE4UHQw?=
 =?utf-8?B?M3JEbTNqMTY1TVRqVG9aYUZSbXFhQ2R4bW5aOHVTd2srSUdyaEFPenpIaFBR?=
 =?utf-8?B?blZSSTRGUCttS0JiN2s1NXV0YXZXV3FnTnZsKzJNU1NRNEFuVDBidnFpcnFt?=
 =?utf-8?B?cEJXbmhFSmlDMDJGYVBrVVZpU2tOd2J1andSRkxOOEdhSmhXcEJRKzAzTW5W?=
 =?utf-8?B?Zk5UQWV6MVFsTHV5WnpDdmUyeVlwTmxzZit4OWZ3by9IVTlBUkNXY1N2b2s0?=
 =?utf-8?B?VGEzaytjYW5QZGJHUEVoZWJ6VlppbVJEb3MyazAxVUttZ0lVWGE5Q1F5TEUw?=
 =?utf-8?B?d1UrUTVzV0daSVpweHM2SHNydDd1dEtFRFRqa0pUREZ2RlpHcitGQjh2amVh?=
 =?utf-8?B?bkZ2UVRCdnU2WjJGME5ZQ1Vsc2w0UTJUYWlVQXBkY21BaTNwSjA4SjJmcFFm?=
 =?utf-8?B?aVFVMVFtZjJVem1SWnZxbE9scit5eitKRC8vTFhOVTdjWmMwYnVoU0hnVzll?=
 =?utf-8?Q?TIA2aj12k8UR8TAh78CikZRx8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03469542-caf4-428f-796a-08dce3db63cd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 18:44:19.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FB0sruIYIXMgB6X4ySFxXEq57Lv+dKH883YcNhhJQULaML4VCC5KYGb5BqWiGZK+6stJeKayKvyCgE/nWIsN4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330



On 10/2/2024 4:04 PM, Dan Williams wrote:
> Smita Koralahalli wrote:
>> Refactor computation of cxlds to a common function get_cxl_devstate().
>>
>> The above function could then be reused in both FW-First Component and
>> Protocol error reporting and handling.
> 
> Ira caught the bug in the cleanup conversion, but I am otherwise not
> convinced there would be much reuse for a helper like this given any
> endpoint-flagged protocol errors would reuse the common
> cxl_handle_cper_event(), unless I am missing something?
> 

Yeah, the only intent was to not redo the BDF decoding at two places. I 
don't see a problem in calling cxl_handle_prot_err() inside 
cxl_handle_cper_event() as Ira suggested in 4/4.

However, I think all of this would fall off if we isolate protocol 
errors from cxl_cper_fifo and handle them separately.

Thanks
Smita

