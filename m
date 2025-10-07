Return-Path: <linux-efi+bounces-4994-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C491EBC2B27
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 22:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BA134E55B0
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 20:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609DA23BD1A;
	Tue,  7 Oct 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUmf10+I"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F5234973;
	Tue,  7 Oct 2025 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759870167; cv=fail; b=W6f0YwpurhrwdL6A/Jx2E16UR3aO4ONhn6fdyO4/faF+axi4SwZd58XlMR/6na//tUO3YLbDEgIs2NvaoE3EdBalbTeBDih0qjInbcv1EFKG9PgAexsp9b3DJGKgqMd1cagaVRGRBtZzieQJMUYJVAgXm1sPtAP+Q+5dxBJF5MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759870167; c=relaxed/simple;
	bh=pTNOKMZ6ooBMnd//H/EmXiaIQO5AdJSSQ5jhuN0UNqA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jhhx1TZK3dYq5CJxWxQF9XJZvI5VfoeSCDucnYr24wv8K4/kSKxQQr5GvObyzZ7qKH+isjwJKF4HM53Cr19vvKmEoB8ubratmHwRTJm96kmXnnp+4XrUy1T2/Ew0IanrcrDHjxs7MfRXBsMAqZX1JV11w1CruxKwU8NdsSle+hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUmf10+I; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759870166; x=1791406166;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pTNOKMZ6ooBMnd//H/EmXiaIQO5AdJSSQ5jhuN0UNqA=;
  b=nUmf10+Ikbp+I+RsF+r8A0C+VOTaWAC1V3s4NXm880H8O6DXXA90Snry
   I7pZOPV35SiUgyV5pzixksWjLITyZApNrD8941fPpstY/Na+0TQAjNc3A
   wPOFzMelDn7YlG0G6FpupCn48jjPRSkv47Usd8RzNW94RNxZ1DvcONES6
   7LwZBR6XuSu7ZfaHxv9zh/vwObZPRkmWwHDGUxvD0sAfLikl1NEQPkGgS
   fQnbpF766f2Nmx8pm62LkC8AmKI2MsFdjEzQtC4ZQL9BqaBu2ZdOFHhBT
   6o8A9UYYwJ74h1OQJOC9dtxPpR+EV4VCIsXJCutR3D+JCBjdYAag7ZNnv
   g==;
X-CSE-ConnectionGUID: yV+hBy1cQo6SWSv92cB6HA==
X-CSE-MsgGUID: RNe8/oKsT6GG51l3oiZHXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61965695"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="61965695"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:49:25 -0700
X-CSE-ConnectionGUID: OJ2Pi43+QFW2MsSyYJZZ3w==
X-CSE-MsgGUID: 69/hlG9oQWK3BJFfQKKGJg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:49:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 13:49:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 13:49:24 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 13:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aML4ILwXIKJu5H+tRchS5lZYn7c83SANyDPr+TmBCNb9rTf09+tKb809lZ/OmpxMNcbHXUrmsp0056i3eXrZEWpCxkDG82L8JjxbUugcuyqO8/T93Y8fKtpvGqLsJpFqlvb78le6NuVfx/gfV9KhDm5WJ43XTUSNsMVZYFLcej+vA1ukK3xtmJ2QF+a8jJ9/mG9rHAMJXsyHdeagkJOhVSIwRRf6kb+fty6ABSWDexVrAPfWEelFMtvY9Zxqr92MoMFMCH1Mp6hp+PWpXOBX3YFYp4BEiUfTzgOFFHslVGWzDtMe1S15k8J+UmjOBPjbRG9fL++/qVOvQN+oTmJQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bkoz2M/JP3GjSbZfyt3E+cFYubmh9v4t5Bxw58OlQ0A=;
 b=CjJva+EnCR9kyEguqh6pIIJhhDCYaczByjHStFefvb9O+ahA3+55Aw9NDAyGR8SysWeDe4qTVCoCug2OD9h39o2tR8kwvA7JjelnObEYTsrpLckMcLqtu8k9k6W1N1u0JKrP+4tEZx+ssrD1jcONoM7gYAYYzeMGmvHCSXPe+vOo6bOzh+j4jH3pFiwD+k9BHI+Yya6ywd1w94+jIqeuHuEL7IAnh1rOXz2Byb7a70dAvTloPY3zujDGTwsl97tAqbS8hK9VKdPFfHKcZHjFPjQQTZjjbbQ8Wf/npp6FidcI+dLW2BxHlC9LrYGOuaEy2WthscPRXgtwrQSAYW4m1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by PH7PR11MB7450.namprd11.prod.outlook.com (2603:10b6:510:27e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 20:49:16 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 20:49:16 +0000
Message-ID: <e82b48b9-5566-4bf2-9b9e-ee529d59e9b5@intel.com>
Date: Tue, 7 Oct 2025 13:49:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"luto@kernel.org" <luto@kernel.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "Luck, Tony" <tony.luck@intel.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "vegard.nossum@oracle.com" <vegard.nossum@oracle.com>,
	"xin@zytor.com" <xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-2-sohil.mehta@intel.com>
 <47fb7efd89698f46a305ca446d0e4471d1f24fbb.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <47fb7efd89698f46a305ca446d0e4471d1f24fbb.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::44) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|PH7PR11MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad5a2a0-250c-47dc-ebe5-08de05e2fabc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEFiN0RUT1c0a2tEYVVYeFM4MHlOTUpEd3JhNkxkYmdHMEdXUDhQYmZjUS9X?=
 =?utf-8?B?Z2dnd0U3WkJ3a3NBOUcwL3R0RHRGdnN1ZlNmSE0zU0twWVFYdWNZQ3hnNzlm?=
 =?utf-8?B?Nk8rWmNNbml6eFVJbnhSZTFsVHNybDEwTjkzeUZZOTBLTk41Mm5EUkVibVFX?=
 =?utf-8?B?bU1CSVloLzVYY2g3QmdxbTI1Vk04S2JQQm1JKy9BSk1aVklLVFdmcVVldjBy?=
 =?utf-8?B?ZlRZWGxWcDJxcW5oajBFblpQWENrVjFyM1p5Y1RJU0tMYTBseXF6TnAwVE56?=
 =?utf-8?B?dDR3d1ZLNm1sbmxHeDNZUmZEMWxiQkJsZ1JRVHZFajkyeTEzMHJ3eWp4REZT?=
 =?utf-8?B?WjFOeis3L3hzaGNCQ2lzYUVqYityNjJRWStNZjJ3OXEvVHYwTU0vTGZlRjlI?=
 =?utf-8?B?UmpvbW5RbHg4S0lIZWNPRGxIbjQvOEtDdmp3YWFmZDlodUdsYlIxT09paHlB?=
 =?utf-8?B?UkFjTTZkT1dINFlmejR1NGtSQmhobWdVUzB1K25zUlpYTU0vVS9EZGFhellS?=
 =?utf-8?B?UDBMMEh1aVhoOEZ6a1NqaW9oTUlhUm9PeDNDeEZFK3VDRm02K1pEYjV4QjBy?=
 =?utf-8?B?Q29SeEtIaUlIWGpIWDJJNmtvQ09vWkR1SDIyTkdZVENQUXZsMUFESjh6ZEdC?=
 =?utf-8?B?MktFRWxEU0hSVk9LbGdPbVJ0WTVzK2tYVmFwMmxIK1lMR04zQk1nWlh2OU1T?=
 =?utf-8?B?dVc5R01CNWg5cC9PNk9hUzZuZlpCUGRkWHNEQXN6bkdINnFKeFBmUXdJTmVx?=
 =?utf-8?B?elJjYURYd2IwajduU0EyNS90Vmt6NXFDUTVYRzBlUHkrTW8wTHNldDZVZjZs?=
 =?utf-8?B?dTdsL2VJV0xJSE5jVVNiSVVHd3p2R0VPcFFoSXIzZm9YNWxJdytLUGQ4cFd0?=
 =?utf-8?B?aWFyTXZLaW9mdG5HUWh6VUp4dUROSDVRa1lJcGZHenMzK3BRU1RHanFUN0I3?=
 =?utf-8?B?KzZhWHJOQi9GRXk0dDR0RzhZRER2L21CcGdOUHRwcjB1THgxREhsZ01seG50?=
 =?utf-8?B?SnlHQm0ycnVEaEd3T3RyWUJWQnRrN3RSM1BBbFlOVTZnVWdBRmg5V0VGdGg1?=
 =?utf-8?B?ZDhGUlZHYm9oOUZjYzU2bWt3eklmenAyWnhRaCsyR3pMK1hkRTBBSWp5WUFt?=
 =?utf-8?B?Sm5LaElWZVpFdmxDWHM4QS81VE1xTW9aZ3AzZEUwdCtlU2FjWlJEMm8vNTJP?=
 =?utf-8?B?MzZWNXRuNlp0QUZNdDF4NHJjYW9MSTdrTFVKdlJHUk1LV0FpT1BFanl6czI1?=
 =?utf-8?B?NlE5R1owSkRmekluNjBtaGJFOTVFbGwwZzE5cHFRRGdUdmVtQkRYRnpjRlh1?=
 =?utf-8?B?UHorV2Nua3F1YS9BejRBaHdGckc0aWpaa0pwK2NmLy9OclRJOHhDTzJLV0FI?=
 =?utf-8?B?VFVVQzJXWCs2QzQzSFRuUm9sVE9NRUpjMXFFeFcybWRuK2pHd0ZNd1AxUU9B?=
 =?utf-8?B?NEpoMHVxNExkSklTck5IWnAvc3lvcW14b2NlSytxNFZmWXRHVlphNythQWhO?=
 =?utf-8?B?dXlueHoyUTcxRGVSVkppZjZFQmNIZmdwaUVJMWlPQ2RGcElITS92ek8vR1Vs?=
 =?utf-8?B?QWhER0xCN1pnVGhjN3JlZkRpUWVmWXlLRGdrdFVRazFIOGpacUUwU3duR3px?=
 =?utf-8?B?c0FSQ1NlQ2c4VTRKRVFYZFlqN3B4RXdqOEwrRFZ0NjBWQ0lraE1oZjNzTWda?=
 =?utf-8?B?eGlKaWxwZDhYWGFkM01wMkRCWmtVTTBtNFFGRXl5WHZQdFRJQ3NLVGlEbEFE?=
 =?utf-8?B?cnNqNnpPeE1TaHBRajdZTUdqTDlrRzNZbUtXYmZKcEFuQ2VoQ1c5R0JOYjNM?=
 =?utf-8?B?K0VqbHpiLzdzRDFCUmM5NnQzMzVPQmZtTUhQTlJXeHRrZGptVkozNnZ1RlpL?=
 =?utf-8?B?U2hydlB0cFpjY2QwdlYxNi9lVjBxN1cweDJSOENVM2lJeEpHS3VjUXd5UGhq?=
 =?utf-8?B?elZNNDZicE5aY1VkY01pcTExRlp6T1crTSs2SGk3aXpqMmxFTS8zMENsa1JR?=
 =?utf-8?B?YWpBb0NGa3dBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmpFNGdwMmdybUhJY01vUnJJVENHVzRYWGhaZncrZDdnK21rQWdzblJEVVhT?=
 =?utf-8?B?THVpMmZXdUdFRVFKMFhkMGozT1JTVWFLNys3c25nckYrSS93c2xEUVZTa1NX?=
 =?utf-8?B?dVc0bFBUbEFiZzBsQVVLQkxKczJHdjhTZ0ZwRTh6MlNsb3VFTFZSZHRtYXdH?=
 =?utf-8?B?Z1NNd1dNTllGUFVNU0UvN1JTYk9sc01qbW04YUNFTGQwc0RacldmM3RzZUlD?=
 =?utf-8?B?bDdjYStnUmdYRThnU2U3U3FkeklNQy9yU3FsWG96bU9OeElRemhUcnBWYU1H?=
 =?utf-8?B?SmM1WDE1NVhSczU2K3JyK04vWWdVRTBEL3h0L2NzWVdsWEdMTTlqaFlRRnNU?=
 =?utf-8?B?d25LcWZZR3d4cFgrV3pzM0EveDlINTgyZWxpcmpud1lEZlZVdXRucktXMzJj?=
 =?utf-8?B?U3dhR05XVVlWdmc5Zk93bGh3NWZERDdRQzh6LzZvdFovbHpBbWxTQUd5OHJT?=
 =?utf-8?B?MDA4OElzVDBwbmxJQVhQbGhFbUhXZmhHMEV1c3Iwa0lLMkwzdEIzSGJLT3FO?=
 =?utf-8?B?VU9CWDZlL28xRXdxVlR6czRVS2tNSW4raHJqb083dlMxbG1rMFlBWU9kVU1I?=
 =?utf-8?B?UC9ROXRKSTFtT2hJK0FpalJ5SEhQVFFBVTBWRy9tOGRJczUvSktzWUFiejdq?=
 =?utf-8?B?dXB1ZEg4RnFBWDFFTUZRcUJHVkxuTGI4blJsNGdXS01IR2Via2FPZHIvSGY5?=
 =?utf-8?B?M1lEM3p4MmNhV0k3SUVsTEg2V2ZxbzRGVzhsVDdQTStMTVpqSWFDODVCcVRS?=
 =?utf-8?B?VnI1NUdNME94R3AzTVhDTG9DK21GUnlITHpQUkpURHc3NVhjQWdXWkJjTEdR?=
 =?utf-8?B?VzJyd1Jia1VQd05HS0UxdXhpTUNYUUZuc2VMalhBVm1kb3oyc1NkeC95YVJt?=
 =?utf-8?B?bmc2d1VFakJFajhOQjE0QmQ2eWI4SjlTRlJjVkZRQndneENtNTZoeEd5QnNW?=
 =?utf-8?B?Q0VScHJ4eWVZemVzTlJKS3haV1dwb20vUmo2N0xReDNKWkRPWmxzQ3BmR1J2?=
 =?utf-8?B?SzJBRVpOTnRMMWE4dW4yYVMyOTlvUDJnUG9DRG1WTW8wQklVR3Y2c0xWWkg4?=
 =?utf-8?B?QWhEaVR5TlVqc2hTa1JtRUJhVlVldGJtVHJkaFMveDlwem1EWUI4RGJ1VGg5?=
 =?utf-8?B?Z1RHUE9yYzcvWXNBTkl4VittblR4RmFpTnVMQURvNEJaU0xSZ2NOL0o0VmM4?=
 =?utf-8?B?MGJGQ21NU0UzTFVBZHdyWVVQYmFlREloUVppaFZlNTZrVGcrcUhxOXFscjVk?=
 =?utf-8?B?NXNiOGVEcGZYNUtpWWQ3QjdsL2x5bHpyTFFpRDBkeHJzRnVQSGpOb0xmWTM2?=
 =?utf-8?B?OUpRRXJ6VERJQzRibWdQMHVYdkN2dnRyeWxBSUJOR0tCRnRSYVRZSUVMRUM4?=
 =?utf-8?B?cXFveVNtUGRBM0pWeUZteW5FMElrOStZNkw0ckQ1eUMraFJNSXlvcldjRlkx?=
 =?utf-8?B?bUFJc09kcjk4anRjVUh3L3FwazNHVnVZYUZ1WVNRdEd5YnlrYllheHJSRVB0?=
 =?utf-8?B?YjcwWE5yblZIN01zZnU3S1dDL0hYL2wwM0xXTW1xUWVIenMzb3Nvbjg0aDhU?=
 =?utf-8?B?QUdRa3JvTkMzUHFnY2V6aVdFdmRQSXBueVdFSGlkNC8xayt1WDZJR2dWcFFL?=
 =?utf-8?B?OFNUdEE2YWJheWlqcldNNFlBaVh0VTRHdWpWayt1RC9UcnRGdHRMZ3FIT2Fw?=
 =?utf-8?B?bGZMbE54R0tpY2p5ZVRJQXU1T1ljK2FBdnc4M3JBWXRXdGhObGwwZ0psbXJp?=
 =?utf-8?B?UHVzOEF3azB3TXBKMUhLV2FMYUlURk1ETzN4blphMmNpSzI5YTFGZ3VpM290?=
 =?utf-8?B?VGZ2VkU4bG1XWlNPU2xpbHR2SGhwMTg1eXZPY2VXT1R6QmgzNUlzOG9neVp3?=
 =?utf-8?B?TXVoSlNON3gyZmpyZ0JoTEgzU3poYmQ0cjdieERZeERRS2h4aFhzcXEwUHFH?=
 =?utf-8?B?WDhWcG9ocjJNNDkvWnhKZEFGVzBIRW12Sm5sL3p1dUtsdlRvWWVBRE9lcWcx?=
 =?utf-8?B?SnY2T2NkT3lmVnloL2l2eU5KYWI4dFdmYnR4UUdZK0t1QzJiL2FFOUgrMWZ6?=
 =?utf-8?B?RDJvdlorMTBhMDlLUjRTbDJ5UHdDcysyZ0pWNmxuYmF1aVh2dWROUVdhS2Vt?=
 =?utf-8?Q?7ogpgU3tt4mfRJbh3FLoqruUD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad5a2a0-250c-47dc-ebe5-08de05e2fabc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:49:16.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3eZdU2+jSsRrvmNKBOmzaUHyQqK29SPMJx2CjK3+HumVrO7SJ8N3nyS3nR3TjqgtBhHBPQdzBFP+rha0QP3WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7450
X-OriginatorOrg: intel.com

On 10/7/2025 11:19 AM, Edgecombe, Rick P wrote:
>> LASS provides the same mode-based protections as paging but without
>> traversing the paging structures. Because the protections are enforced
>> pre-paging, an attacker will not be able to derive paging-based timing
> 
> Nit: pre-page walk maybe? Otherwise it could sound like before paging is enabled
> during boot.
> 

How about: ... protections are enforced prior to page walks, an ...

>>  
>> +config X86_DISABLED_FEATURE_LASS
>> +	def_bool y
>> +	depends on X86_32
>> +
> 
> All the other ones in the file are !X86_64. Why do this one X86_32?
> 

The double negation (DISABLED and !X86_64) was harder to follow when
this was initially posted.

https://lore.kernel.org/lkml/73796800-819b-4433-b0ef-db852336d7a4@zytor.com/
https://lore.kernel.org/lkml/756e93a2-7e42-4323-ae21-a5437e71148e@infradead.org/

I don't have a strong preference. I guess the inconsistency makes it
confusing as well. Will change it back to !X86_64 unless Xin objects.



