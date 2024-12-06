Return-Path: <linux-efi+bounces-2311-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCE49E75AB
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 17:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB14286E21
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF93720E009;
	Fri,  6 Dec 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XnSSq3aL"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DD20FA9A;
	Fri,  6 Dec 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501768; cv=fail; b=doWsK54pvWoVbdj8K6d2FRSx4hsLZVdlRZJRZ1iKCMDcMK7aqW7E4kEb5oK2fU7eQqzHQvqb31N8A6FEyd6n87rXZxZUPPTSlreWRlK3FgNKeXzIs+BTb2u3QbfF+5Q5Jv+LNfB3nmyiOg5y1R9woh387jmJY6n+BfRDXoh1wO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501768; c=relaxed/simple;
	bh=ZYPP0/SOj5MavLjWOleTvFQhRKgRSdS1KTCxDT2AOKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ueairPyTH/naJyGdvaAVz01ZBwkk8qdXey5oBbXqooQ6Wx9RMEp5cWBsX5CSWsb/HXf9IuenLi1ZGan4p7DoiNGnJGap5H7r4miV8HsaQLYjHsBVTg/GTzzXRu66SSIxT0Yo+5WrPvKZrbroNBbtLQXpdcuvA0Xkw44joO6QcWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XnSSq3aL; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLmG/TV1l+GHRK/vRw+pEB5lQ1fHjyLSWGPTSGnyguJwaxrozaKY+g0ztyyc2U9GS6RDZ7MHDsO9W3fcAIGRjBGdrMFhlhnCdBWqQI7h/GC7owgDERvS6Z+zlKdjssA/OtLAGEhQOtgPlgYyotdKFPBQ7vqNk05Ck9DaWZnXRF9/GWbAY7X9xeKO25Mbn3gRB/sOiJIQ15HG4DYT3XUcUawwuNz9WRS4KBRlrzfhMYNlYepaJXZx97xfx/n7/J8YT3T9ZvzLtY54JfBXhplLjAmljQpAORr/mdsB2ttwR2w7j/nhev29Zt5lhZ6g9cWc//yW1BRQstug80HOjqIZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IyKCYd0ayqcdna2xg0k9sEpblTuqRPSgngikeFqRXI=;
 b=Gsnhy35g6PUVE8VC922Pl5kwCzdXX46Z+uuY4QPAdOuRFkJfgxvI+3jQSIu4hsi0s6ZRs6fOtJzxrmrP0MRiIv4Lo0tLiql0WgSxzEUh5n7qwfYW+9d0kn9knakMvuqAWblUVictjvM2QjwpZnrKWz0CSf8ro5FWw+W2OgPhMR4xRx+0eBYW5aKTcXh9WbihsFD2Yqw8N7k+gpk81MzEwtJ7uUi4GXHMA+5snMv5KBVX7dRo9tnGve6qWy0Ta+JoZZkch+9EBND60/h2SkoB5LraLxwHynpd9gxSDU+t5rR8z3updJVs+Qg/vtTS26Q3If6yzVbakRtSMlk6AjWskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IyKCYd0ayqcdna2xg0k9sEpblTuqRPSgngikeFqRXI=;
 b=XnSSq3aLe6KUmYsRbq/wf7Rag0RSxVaI5QCELMpIF0O9mFouL/LHx5wPy4OSyKf5f83mCIbtec85eQbtEalSE0ZapqI82C/aOg7QFLbqOo/Wi2gpdNSFcsdvvRnuptZ4ztnNXRlR33L4+FQYrFiTa5SBn/KX/BQgaf8df8rOtoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.12; Fri, 6 Dec 2024 16:16:03 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 16:16:03 +0000
Message-ID: <03f21010-56b5-48cd-9e8a-be1fbf21cc44@amd.com>
Date: Fri, 6 Dec 2024 08:16:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] acpi/ghes, cper: Recognize and cache CXL Protocol
 errors
To: Ira Weiny <ira.weiny@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241119003915.174386-7-Smita.KoralahalliChannabasappa@amd.com>
 <674dff76fcd_3cb8e02949a@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <674dff76fcd_3cb8e02949a@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c87ada-3d88-423c-6b4f-08dd16114795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0ZlcTFTVGdaYkQvUVh3NnU4VzVlN2NTUSthRHFaT3RwcXpCajNGbDFzQWlK?=
 =?utf-8?B?YkdOZjhsY2pRQjdZZnNOZDJESmpJK2E2SmpGUDRBYXh1M2xoUS9Da0lJYTlO?=
 =?utf-8?B?TDlwWUxpL3pzWTVhWWFMaldkTWs5aG1vbUYrRUtXcGY0NkY5aWlVditpQlVo?=
 =?utf-8?B?Q3FJN1BNM3pFbkNLT2JDVUoxY2RrT01iTjJnby8wUmhLdnR5cHlDbWY3TnFn?=
 =?utf-8?B?Tk9IME1TbkFrRUZRRmNFdHVKclRxQlByNzgwY1hwKy9MellINmNxeHNreFpp?=
 =?utf-8?B?UHF0YUxuWWxuS0VYczdVRVV0TUo1enUzUHBsYkFvdGlMWDBHbUpwekdZMmhV?=
 =?utf-8?B?WUcwZVY0R1k2aG85RWQ2VnhxS210S05UZnhyUTRHV2t3MjBDcU12SjI4dlJj?=
 =?utf-8?B?dGROV3M3TmVwZ3c5K3lXOENhbFp1STNQY0hkUW1FM2I5NTk2OGdjYTlNa0Jj?=
 =?utf-8?B?WnpFZHFhZ1JoUGVIWHcrRWRydGZPSTFaaFhNYkE5S2kwOSthR1Y3WXg2ZWxC?=
 =?utf-8?B?eFBGMmFSdUxXWW1xUTA1bE1mZjRuWnpuWmhleGFIZDdSK1lBNDN0bkVNOTNn?=
 =?utf-8?B?N2dJSWhSUE1tNFJyY0dIaVVQTDFSbEZ3di9pWnhVVmJobm9ZUDF1aUQ4UzR0?=
 =?utf-8?B?WWtYVURtMGFwVWRKbUYxeXFObUExWW0reEc1U0ZIV2M4WVozU0xMWjVkUXIy?=
 =?utf-8?B?VUxzK3BSZ0JobzhMRUFUOW9YaUlSSkRFeitDTExSVktUOHNPQ3VUNURnVzlk?=
 =?utf-8?B?VDQ4WFNMaVFVVjhtV2tuS0hwanppazNCenM0OTRZYXRkUG83QWdaSmZlZDRq?=
 =?utf-8?B?WTB4SnhVQTErOHlSRzZUdzVLR0FUUWtCZVZJU1IyNHhwVmZ2b1IwSElSeC9i?=
 =?utf-8?B?Wi8rSFlvYlVCNEwyVm5JU3JqZFplTXhxQjl5ODcwblhTMHlUd0M3MHdKcGE0?=
 =?utf-8?B?eHQvWVYrdS9sMEl1SmVpSjdKU0hEbGFWbTRGckRGVllKdWdLYmY0ZGV5aHc4?=
 =?utf-8?B?MklVSjRmZ0J6LzNzQTBVSndHWDlTNjZKUFNoRUpUV3ZSREdoWklSbjNSbU5H?=
 =?utf-8?B?WVlNY3p6L3ZFNWk5c1pOOGRCMis2OFl0cTY2K2IyTUhHNzBaTjIxYm1pc1ZE?=
 =?utf-8?B?NUJYYUtOa1FFS2gyY09nUVBSb0d4OE1CbjkrZng2L2gzWVdJVjgxb3N6T2x2?=
 =?utf-8?B?Z05iUFdFRFVxZnplMmpsQkxiR0tTckVEa1hSZkVKRDJ5NkVZOVBFYzVYL0pm?=
 =?utf-8?B?N2VEVkR2Wis3ZU9WVjdMaFdVdEYxSHJRVWk5Mlh2TjZHSDkwa25lbkpGVGk4?=
 =?utf-8?B?MHNaQ3dWSzhyc1IwemY1WjhVY253cEJQNk5CNy91S1VLNkF6QllwQkdqUERt?=
 =?utf-8?B?ZkZjNlBzMDdRMFZXZnJ1ZlZSVjg3SmhKQmR4M1JWWGMrMHNONEoraEIxZDdM?=
 =?utf-8?B?a2VRT05wODZ6M2l5Tms3aXNDRTZzWkExbmxxQ0l4UkY4RW9lSjUrZFNGa01p?=
 =?utf-8?B?VzdjaTVvbTYxNzFHREVIaVd4U2NYb2I5eDl6Z2p3N1UyQ1hLUktCbktlWGpN?=
 =?utf-8?B?STlwOHgyVVZodXo5YW41K3ZSZnVSdkFaWmZZaFEwSkdtNjgzYVJuVlpVY3Rh?=
 =?utf-8?B?dkJuaTBpbmM2Vkt6WGtnbVlpWW5mZURsK0ZSQ3l5RElueEtnT0I1empYWkln?=
 =?utf-8?B?VngvOWQ4TDBIdmJWU2krSWplcFk2d0xuZFJLcWdoekVFVnpENFFWd2tDZXpG?=
 =?utf-8?B?dWVoOWJkTENiazJ6czhCcjlTdk92SFhSTEFQVFoxUUhudHhoalk4dElZT1Fa?=
 =?utf-8?B?Z2pVOGpObitRMHo2L1prQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0NYS2d5MkZxOVhRTzlzcFVKejZPK0lBT1IyK1ovTG5vbHdXZ3Z5Q1dtRU5s?=
 =?utf-8?B?RFQ2eitXUU5sR1RNcXA1a2pDT2JvNVdSenJYaFNtQjdVVzE3TlRLelJsQ0gx?=
 =?utf-8?B?ZTF4dHRxeHRZdURkT0lIRjZkRjdqVmY1MjBiaVRORHJkSDZHTGtYc1lWQWFR?=
 =?utf-8?B?ampuMkRZOTN1M0JuS2J1QkQrRlA0ZnZaSDhYcVg0VGdrdm1mMDVKNHM5V0RE?=
 =?utf-8?B?NTVmRm1zb0w5U2RlenZzcnJkK0RoNVl3NHpKSStyS2FacmV0TkJQd0N5dTQy?=
 =?utf-8?B?YkhjcUV4T1JiKzUvcXJrUEY4NXZwRXFoSWJUb0F3UGx0MzNIdzV5TndDVlEy?=
 =?utf-8?B?aWpIS2h4VmczZlQvbWhHVE8yVmVSOTQrNGNWRjFmN25tRndmQk9BWkI3WFRM?=
 =?utf-8?B?RjZSem0weGV2RDkvRk9nMlZjeDI3cVdXS00rMjVlNGJLUDZieVR0aURDQ2Jh?=
 =?utf-8?B?Rkx4MnU0NDJPQ2Ira0Y3V1A0aFJrQTUrRHlkaDRkeVRpcXByUU1KbU5QVnFU?=
 =?utf-8?B?NHhGVEtxOTNXR1JaVVUvQ0lFVU1WQnRsOEZ0WFh4VUNzRVlWcVYyeVorS1p2?=
 =?utf-8?B?RmQzOE8ycmZKc2JhRjZPblJpY3Fac1FtclFscGRTYi8xeE0rd2R0OXVRMVFk?=
 =?utf-8?B?ZHRJaGw2UkhhSUY3ZFkyVUluUUx1aEdGVWQyWDZhVjBkOFo2S0JneFFoTGFh?=
 =?utf-8?B?N0tkOGVvUDE0b2ZrL3B5UE9WTnFMWSszUmZnaEM2NjVTL2YyRk13NmdTOXcw?=
 =?utf-8?B?aEpXak82cVhwYnhRVEVKRUNaRDA3K2gwVUhrMUVjby9raXFRdXFKWFBjaEN3?=
 =?utf-8?B?NHlEQTRBMm9va1F4U0VDbUNidURaTDdaeUlWYi9YTzk4d1BvbWhtTUNnVE5r?=
 =?utf-8?B?UXU0VzZnbFlIbml2YVNNUGZkbVpLL1M3NEl3dnBGZ25Hb2tuUEZpelVSTU9C?=
 =?utf-8?B?TEk3UzVNdFZuMlkwQkhRUTZGa1Y5N0o5NGZmbGZGRDlzdVcxT0JHb3RvSXYy?=
 =?utf-8?B?aExvbVUxdzJvcmhrN3pNRGh1SXBGTXlTNWVGNUVQM2VsbHJvVEF1R2Z3Umxh?=
 =?utf-8?B?ZTdjS3hselhMZ0g4ZFBkdHFUeUFXWko5ZGdGMDVKMVpJbDQyWXRkZG5LKzhu?=
 =?utf-8?B?WjBUTGZrWUVIa1B2MFJuWlR4UDhoYnJWbHZ3cGdhWFJaMVR0c21CMjQ4NEZ4?=
 =?utf-8?B?elhjK0JkbjgvUngrN0NtYnNnZ0djbzZpYXFwTFJaYU55Mkc4eUdvSEl6bCs4?=
 =?utf-8?B?cWQ4SFhraG5YQkFzNzBNTmpmaGY3cXJ1ajhaVFNwaDFzMy9Xa2FIUERlSXFO?=
 =?utf-8?B?djc5SFR6UFY4NDdUQ0k3UDJ1MTV3b3diQ1hid1hiMkhmTllhMDdXTVg2T3VJ?=
 =?utf-8?B?NkE2U3VNbFdTTmszQ0hzcnd4VFlqSEdhWVVaMWVuNGhSbTBmcjA5MjgrOEhy?=
 =?utf-8?B?Z0VQc3k5RS9NSzFaNWUwVDNGcjFxQVlRb05La3R1WktncEE1dmJzWjFaWitN?=
 =?utf-8?B?NjYrZEZmVUo4amtWOWQ3Q1JDL3ZtZ3F3ZVJsOWNIdHUxL01oSlM0Kzd3S09r?=
 =?utf-8?B?NlBTSHl3SHVpaUgrQUtpdEhNR2tMR05heUtBY3Z0c0JWTU9kS3hBOVpWeC9l?=
 =?utf-8?B?ZnhSdXpzdStucVhqTW1TNWIwZlRacWdXT1F6ODJPSGp5cHJoY2hieTB4S0JI?=
 =?utf-8?B?aUVpMUplbThJU2dPVis1eThROFRoOHhVRXR0UHJIbzZGREFnQzRoaVQ4TS9Q?=
 =?utf-8?B?NlRlbFhyTnROSTNIMzJzelZ4NFYyTHdMY0NpTTBpejZDSyt3cDhIRGRDUE85?=
 =?utf-8?B?RUFyVnVNQUhnT0U1MzNibFhhTHhWRzViRmJlcnY5T2czenpmUDRKYjd1SmVo?=
 =?utf-8?B?d3d6TzlQbE5VUis4NTBpY0d0SUdXWjgrV1hpT1hDQVJNNWVGOHNDV0dNUk9H?=
 =?utf-8?B?RytYVzlWTi83ZzR5cTd6MFJqUDFUcHJGRzlQT1hTZ21DWnEwV2JVQUhmclJV?=
 =?utf-8?B?MjNZK1FCcG9BSForZmZjRzU5KzFXU1QzRlN4K09iWXQxU0FjNmI3b0NlZTZJ?=
 =?utf-8?B?Z1Z3bWU5blhmMzN6L2JQZ0szaXRYSkxITytFTmJUK2dneGV6cytOZEFKQlNy?=
 =?utf-8?Q?GlB9qyqaOR6ymnyy4xzNqS9Tu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c87ada-3d88-423c-6b4f-08dd16114795
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:16:03.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpPY5AHQvA7XIERgo8NzE4ygX0So/r2xt09VFclqXtrsEIpdJF/+TZoISFOscNiPQ+yU3wKmGlbFl3o9RrQz9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414

Hi Ira,

On 12/2/2024 10:41 AM, Ira Weiny wrote:
> Smita Koralahalli wrote:
>> Add support in GHES to detect and process CXL CPER Protocol errors, as
>> defined in UEFI v2.10, section N.2.13.
>>
>> Define struct cxl_cper_prot_err_work_data to cache CXL protocol error
>> information, including RAS capabilities and severity, for further
>> handling.
>>
>> These cached CXL CPER records will later be processed by workqueues
>> within the CXL subsystem.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 52 ++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/event.h      |  6 +++++
>>   2 files changed, 58 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 62ffe6eb5503..6cd9d5375d7c 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -676,6 +676,54 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>>   	schedule_work(&entry->work);
>>   }
>>   
>> +static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>> +				   int severity)
>> +{
>> +	struct cxl_cper_prot_err_work_data wd;
>> +	u8 *dvsec_start, *cap_start;
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
>> +		pr_err_ratelimited("CXL CPER invalid agent type\n");
>> +		return;
>> +	}
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
>> +		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
>> +		return;
>> +	}
>> +
>> +	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
>> +		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
>> +				   prot_err->err_len);
>> +		return;
>> +	}
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
>> +		pr_warn(FW_WARN "CXL CPER no device serial number\n");
>> +
>> +	switch (prot_err->agent_type) {
>> +	case RCD:
>> +	case DEVICE:
>> +	case LD:
>> +	case FMLD:
>> +	case RP:
>> +	case DSP:
>> +	case USP:
>> +		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
>> +
>> +		dvsec_start = (u8 *)(prot_err + 1);
>> +		cap_start = dvsec_start + prot_err->dvsec_len;
>> +
>> +		wd.ras_cap = *(struct cxl_ras_capability_regs *)cap_start;
> Why not memcpy()?

Thanks for pointing out. Yes, I will change to memcpy() in next 
revision. I think

memcpy() may suit more better here due to consistency and as well addressing

alignment concerns.


Thanks

Smita

>
> Ira
>
> [snip]

