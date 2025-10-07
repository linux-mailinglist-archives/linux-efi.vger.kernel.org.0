Return-Path: <linux-efi+bounces-4998-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F488BC2E30
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 00:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD60E1892115
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 22:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86BB255222;
	Tue,  7 Oct 2025 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlXwgrQ7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4473023D281;
	Tue,  7 Oct 2025 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876903; cv=fail; b=PqLNIvFpuycCgHJuBoUTVwA9h5VMR29yWhw5bcNa5yD6b7k4Gt7jSO2PAR0kaku4Cp+ea7ska/cyf3N8wWobDGeH5Wp7xh3fi8s46WDF9Z7PZ8rfgyAebKPkx+fqXeKcmnFyFOtaWisvWGVOhHmg4O0mfhnILcrKXl9uLx6+qQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876903; c=relaxed/simple;
	bh=5ovSUR5cm2UgqPBqdmBmwvAJAhzH5wXNigJ89ePe+XI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hOuxYBWysKCUhaQdDghpqBvrppG7PhY3Ez+8G1Ocd/tVRShyAsSNKJjXQh7649Vvbe79VrkjzZcKvGd6E7p0QMktoqKd9gc1tnKPNXNL1/RF/6NXUle1CPdJCau1OptKNkgKYvDz31ThmkyWH5DVLbqclsVJZ2TUsGQ4oWxfZ60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlXwgrQ7; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759876902; x=1791412902;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5ovSUR5cm2UgqPBqdmBmwvAJAhzH5wXNigJ89ePe+XI=;
  b=nlXwgrQ7vK6zBayTkv96UmaQYlevrx6xbgr78VBvf0EEGyZ7iMi7KJIk
   oFl0RY7Q4GikeSXZsoGmdN6Rn5Hdca+nZjsGXNDNNghwcPt6oKysg+3Qw
   xSPVdhz7GwzCL0cDV9SQOWfZIke6fO3/q4VeJaGz8Oy4j0UsPR1K1o7Y2
   X4RLBw0hNEomnhhoc/54XYaCPHRIfWpGbF2nnVEwaDudZPEqtO2Xeilvx
   7tCjsXtGrYPh4tJEPlN2q7QWZLQQt3n0YmYinTHqlXyJH2C+pE354Ypfl
   G94qdbLXWEs6dZ6eq4S4c4/6/cjElAAOxjwwqogSpidNDzfY5tujbKopq
   Q==;
X-CSE-ConnectionGUID: 3utN5PqwQ/OYew7M5JYZuA==
X-CSE-MsgGUID: Fa7XIkTHTdWqM+Gal1TLWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="49623935"
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="49623935"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 15:41:38 -0700
X-CSE-ConnectionGUID: al7SOisdTEW3hTFp8B/4oQ==
X-CSE-MsgGUID: KVukJeJmTBGi+o9jBbQKyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="185575872"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 15:41:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 15:41:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 15:41:33 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 15:41:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JO7on10b6IG/Swe8S6RbkMu9GgCKNtXyPJwUs5URz4AVKlRQma5iL5dgYBsxn3POKHC6Xtuidl5OMPSTTbyX5W+Rt6j5mkOIa1Gu5tFUdtpS+Ze/g7i1oxMrnsB/K7sqClhmLwsOcjfUDVCoPWZaKqPCfddqITot4LaHdGpI1OxIfOe49sgc25ryIIzEluR0Z6vEFAkoi2twVmMt79ZWl7Y1ZsmyTf5EH2DUbz02V5oipusw32CUmw18IllBojQ9gGEYYkU2sgoOgr7zpsuoazh2/2d9g1lcfbRRalxBZtgGYh8UHhTPL9LzOGbilLV7rBTunb9BRTixol5THHv7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuO3pAikHmz7z6tZnFB+TG32hIPKLAI+QXTt0ZQCWqo=;
 b=oD7oL8dDlxkSkfj/skdLbFK15VIC5KPDgccbER8YfBNZnm151az+XrgugqC0G0Hm9ZCgXSTSxsCIJ7yJ0uwnb5308w7sVpolhkzn17PxbZwpmcfyR+990PuzZNkvGGOGZOXojDNWSkPTM/Pkz1SxdUVwPPOoL4wmIEKUxW4WRLJysMdaWgGmCT44AoQqmUp4j52ZFflx0CAVExiWCzAAb4xqKr4Z9VwWM8Sqe5abX9SqwOg0NAw/uC2JZRgKVv+xXECQ3er+QkmWa+u2xXyHpXbWbhktk2FkXAG+tABeGXfXl7u8uJ9TRPhFsXeFmhOheUz6hiCQGrOTdLzqVWiAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SJ5PPFBC9025319.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 7 Oct
 2025 22:41:29 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 22:41:28 +0000
Message-ID: <92da314d-b523-4ace-9b09-eaf263b263bd@intel.com>
Date: Tue, 7 Oct 2025 15:41:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/15] x86/traps: Consolidate user fixups in
 exc_general_protection()
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
 <20251007065119.148605-10-sohil.mehta@intel.com>
 <e314fabf0597e3ca4acc549e33fd483e64809dc6.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <e314fabf0597e3ca4acc549e33fd483e64809dc6.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::21) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SJ5PPFBC9025319:EE_
X-MS-Office365-Filtering-Correlation-Id: f13377c6-1cb0-43d4-4899-08de05f2a76d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmhGVHV4bUhYcXV0TTRlTExSdUttZnB6VTY3cmErRDExcjNPUVM5YzBWbmNa?=
 =?utf-8?B?eDhXUG5VdG5QejZsWU1jMk1VRkZZNDhiOEN2c3Iwa0ZCd3Q5K3VBZ3pvOXM3?=
 =?utf-8?B?Q3hqV0s1UHZMOXVIZUpvb3krNitaUG9OTEc5TjBsSkN0V3ZoL2xjTXRhS3VM?=
 =?utf-8?B?SlQ5YWttMUdON2IzcHJ5c0QxOWV3YkUwK1B3UVlMYm1PT0VyNy9JZDNiTjhr?=
 =?utf-8?B?ZUFXVjVCV0d1WHhwd0lSeGFVTEdHQzVVTFYwZmNqVSsxY1BjekJIcjUybS9E?=
 =?utf-8?B?aTY3Y3hjdDlLVkMxQzBCSDFsTnd0akU3ZFExbXNCWVA3ZWRIb3RMY09WM3Jx?=
 =?utf-8?B?QUozWnRQRWNSTmF1UStpcmxmV1FCc1IrZW9vREpiQ0tORWJ2d0U2L0puR1l4?=
 =?utf-8?B?bnBtRVhGclFSbTFFdWpjcEo5eE9QUzgxZHFCN3NDWGdGUlcxUGFSV1NMbmNy?=
 =?utf-8?B?Skt1emZMVy9YU0g2VUxBMGVSSGhwUTRlcW9WcUdOQUhMU3hKcUphaWxvVjc3?=
 =?utf-8?B?RXFZd0JMbzFweGNIaEk4bFVyRytFZXlHNlhhS2t4WG5nb0NCaEVqUTR6ckhR?=
 =?utf-8?B?ZSt0UEdkUWY2RlBOeHBYOW1LdkwyN0lhSS90RFpqT2lJM2RLRFhONXlFUFVo?=
 =?utf-8?B?Q3lqeGZSR1B5Lzc4MkFMK01mWkNlSFNLZ1RRK05udjIxZXMrc2tPcXREdWRB?=
 =?utf-8?B?Y2NhQTN6RWdpcjBDYllvdnlYb0U4SFJ1TlB6L214MzZ2TndYdXBLaGVESUZZ?=
 =?utf-8?B?eElZWHpPcllRelNUNnBqdjBBTlFKTFgvby9oWmExMVNyN2JGNDhuYUtqQ3px?=
 =?utf-8?B?aWNzeHdZTENDUUJSdGxIU0xidUJ1VnNCb1pSKzV1TElVSFd0a25kREhkTjlE?=
 =?utf-8?B?RVpjeUUxN3p1MU9xSlJnTkpPaStsNUxCOHFrMWI1ak1CdEV6eVExcUFEaUJJ?=
 =?utf-8?B?ZFEycVRKajFFWm9RQnlsRjBYSXE3RURQOTZOeFc3d3phekZURDVpTzcyQyt4?=
 =?utf-8?B?R0VWbkFEekJEdXJHeVVyUHFHYURBNXNjZ2JFVEJJeXcwdWZwN29OSjAxcEtu?=
 =?utf-8?B?S1lCYzlnSlRSbEtjL1ZoL2gwb01WVUNrNzZHVi9iNy9FbnRSNzJMQ2RDQTFT?=
 =?utf-8?B?b3JOTjQ3Sit3TFFPWU9EQjRxdVBhQjdUbTUxT204ejR4bUxIT1pyRG0wcHg2?=
 =?utf-8?B?ZDdLSE14R1FDb2E1VVE3NjNnUllIR3V4K0wzcm9LWmI3MS9FYndvdzlRbzZF?=
 =?utf-8?B?Z3hjZWNUSDVobkt4cHYxNDJadmxNZEduVmdOT2JWNWt4bitaSXdoL0dpcVpt?=
 =?utf-8?B?cHBNWEMwK2JhTWQveXRRL2FHa3VVdWlCekxub3pjNisyUHhQdWY5aXd1THps?=
 =?utf-8?B?MlQwS1RPcTNXSFE3Y2RCNHd5cmhiQ09DbzA4NDE1UFcvbFR2WVJoZllOU3ZB?=
 =?utf-8?B?aHpHc3o1SE8rZVAvMENsMWhOZ3liakxWTzdINERjNUNRY2dKTThQZEx2NVJQ?=
 =?utf-8?B?T2haSjdENG9ZSTR4dHRDdElKajM1WXY0ellkOEcxUXNGM2tlc1Y3M0lzcUVu?=
 =?utf-8?B?Q2gvOGU2VVgySEpCaTVxVlZtRHMzOXE2M1pob2t5M3RhYkJRWE9WN0x1OW5F?=
 =?utf-8?B?aGRPdllzbUJRTVk0QWZCV2s5RmhGOGNNVFhmUHZaSUdWQll5Y3FRMEVXM1F0?=
 =?utf-8?B?UHVLckg5VkozOG42TG0xUHcvY0JTaHh0TmhvamF0RmpsVk05Qmp0d2graEZh?=
 =?utf-8?B?RVpWM295MDk5dWpoWm5EM1ZZWHMzOHJuVXpCem84RmwrbGtGK3JRa0dZRS9V?=
 =?utf-8?B?YXNvOXVSWGFSTnJjOXZIMG9rdS9OeXh2NjE1dnNEOWp2OGJaMDFjR1BpVWVO?=
 =?utf-8?B?R0gwdmJERUJ1WVc1NjIySHEwdzEwaTF0Q0hmck82RXFsOFQvN2gwa2dxWjM2?=
 =?utf-8?Q?REk92hBk2LaJpNUt2zbJ4xw7HXk6Kp+j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmVjeEE2WUVpQXU3R3NpYlBTcDNaUWJabytuQjZxelh4WWlTa1QxTXBzbjdP?=
 =?utf-8?B?T2VXZ1hsSmJLUDUxYTByU1Z0Wm0vek02bEFuUGhPck0wTjlEUjBqSDQxcThy?=
 =?utf-8?B?NHZSUG9HTlRITVVCUVQ1dVRzdjlxV2c5M2REb0t6NS9WaWJFVTBpS3FIakNC?=
 =?utf-8?B?NGNMZDI2b0M4SlBSYU9PYURybFFlcGJJckIzQ0ZNanMrOUFOMnZRaDdPWUdw?=
 =?utf-8?B?ZGtBZ2cwd0V5WkZGNGV5clRINDk2ZnR4bXdpSHlMOHJtcGhJTDdCVGhRb1Ex?=
 =?utf-8?B?SEs3UHZ2WDU2bVZxU1NMNmtpRk11RXVpaUV2SVhoeHduaHlqYzRyT052QUJ4?=
 =?utf-8?B?cHByMTNxNmNXZWdaaUY0QkQvb0tEa2dCdi9lYXNOTjdvTHhrU0IxREVLV0lw?=
 =?utf-8?B?b0YwSUNYWG9qSGx3TDFndDJtMDk5THhWbVoxeVB5Z0c3eTAwbGZnd3dyOG91?=
 =?utf-8?B?ZzBsa2FhMU4yUUdnZ2YzNnBjZ2ppU2tiRTFZVmlGd3M4Sk42MlBhakRldjF0?=
 =?utf-8?B?b0xnMVU1T3EzeTdPQW1leVdNanAzaGUzQndiSm5rYUV4NUhBc1lBemhBUGFa?=
 =?utf-8?B?RkFXSk5VVkdnSkFnekEyZWVXVzh1SGNkeE1PNXhPY3dqTzlTaFBIU1RjRURV?=
 =?utf-8?B?Z0hoT2ozckJ2SGowRkxVSzh2RVJYYldoejJrb2VZZVJXNUNpMVpZS1lZdjd2?=
 =?utf-8?B?R1VhQ0dnREQ2U0RmWjRnV3dYRmEzcU1PUlFNRVlkME1aekpCNDZ2SFF6eTRE?=
 =?utf-8?B?OEt2azdaMEIzMU5nMVltMlNTc0MxY1YrTXh6Ny9qdUZJSUFiYzdvNWlJTjRq?=
 =?utf-8?B?NlJjS0FwNTQ4TGhFTmlrUzJIOXkrdmdpeUN4UjZJTGtmZGJ5emQ1VWtVbWVN?=
 =?utf-8?B?Qkdob3J6REtrRXZkSHdsTklKQUo2VFoxN0IvbE80SldZeC9kSTFYOUpiUkJ1?=
 =?utf-8?B?VlNpRjZ3b0o2Y1Fwckc5MGNWb1hFSjhmeFU3b3BwUldTNXhXa1ZJY01NSnlh?=
 =?utf-8?B?dDVBcGtuTFMvcUJSandDRmdWN1d0KzV2OGFGQVRMZ2VGZ1F1UUF1cEVDM09t?=
 =?utf-8?B?UzNKQVNpektBV1VoSVoyS2Y4T3JwdWVpTDhXRlYrb2VsK0JXbjFnOUlCNmFZ?=
 =?utf-8?B?aEpPSDY1TW9KWGNoMUIyZEJwdzYvT2pIS0tuUzdGRXhJTE02MWowbTlESTkz?=
 =?utf-8?B?YlhjRUxFSjBGOHJIOXF4d2pYQVVwMnVwSEMrdVYxVmV4UnpxOTVXMC8wNXpS?=
 =?utf-8?B?cjFYMHUyL0FYMm1WZmdOSkFuQWVudkdGeGo0SnBLMXplN3NnQnR4cTY0VE9i?=
 =?utf-8?B?aGMxWGErWGUrdDkwTSswWWpsMEVnQ3dkcFEwSmVqcWtQaUhZbHdjS0s2dWFa?=
 =?utf-8?B?R3ZVY1ZHdTh5eXJQeHp1Q25WSCtmNnJKMkFqNllaem01OUdmOFNsaVI4WXhz?=
 =?utf-8?B?UzllNEF1N2o0QlRwSS8wTXFJRmwrb1NZclM5Y1RMZmxVYXFRNFArd1ZGQlU3?=
 =?utf-8?B?aEY3UTRNcVdra0srUmZoWUVnK0ROc2ErZHYrT09jUytVcEN3ZlVpcnNma201?=
 =?utf-8?B?WmpKYzl2OW1yUHpVVGxFVDVOWHJMK2JSYWxPaktMR2lHb21HNkVqcHRhNTZD?=
 =?utf-8?B?Y1VDdWdRYmpoZG5YZWZSYlhUUTRxYzlLQ0ltaHhSUFBZSDdQcnlGOUV2dXlX?=
 =?utf-8?B?Q2k1YW8yaXpaSjZ5TzV0OGdTbjRET0JWaytLSTRhR3NuQTAzMUpHdlM5Tmc5?=
 =?utf-8?B?TXhMQUd5dDFqclpaQmp4TDBDWjE1Yllneit5empPV2lKRE1aOTVjd05DZ3U3?=
 =?utf-8?B?TnZTN2lEQXovS01rVm85dk9nNGxpMWZ2ZGN1Vk5oOFpBZmhqekxZWm9ROXNZ?=
 =?utf-8?B?TzdLUGZ5SkI2QU0xL01RZGNmclQ3d1M1blcvMXMya1lwSGdoa256b2NDeEN4?=
 =?utf-8?B?aGFoZkZmMitELzlWY2NZemdJbnZaK0RiVHlkOGY5OXM0Sys1VUVLSDhlSW9z?=
 =?utf-8?B?SVprSWdTVGZBVGg5SDV5MEhEcnQ3ckNLZzY1bnl0bXpsNUdWK0dLMXBrVDNF?=
 =?utf-8?B?cGNENDJaZXZDbVhKQ2N3S0xIakVNQklRY3VDVkxtZXJaQ0dxa1hKbHFsZitr?=
 =?utf-8?Q?WK5nv5RyOhnG2Noz4LNQno5hZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f13377c6-1cb0-43d4-4899-08de05f2a76d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 22:41:28.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JN0+1aIbccAkMi2Yslkrhr3MMZuM1AD8dsX+lS8cZXHUF+A/0Z7Oo8Fu/ce66W1LHYXC+m54GC0RvFp3ovnCOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFBC9025319
X-OriginatorOrg: intel.com

On 10/7/2025 10:46 AM, Edgecombe, Rick P wrote:
> On Mon, 2025-10-06 at 23:51 -0700, Sohil Mehta wrote:
>> Move the UMIP exception fixup along with the other user mode fixups,
>> that is, under the common "if (user_mode(regs))" condition where the
>> rest of the fixups reside.
> 
> Can you mention that it also drops static_cpu_has(X86_FEATURE_UMIP) check
> because fixup_umip_exception() already checks
> cpu_feature_enabled(X86_FEATURE_UMIP)?
> 

There is no existing check. The current patch moves the X86_FEATURE_UMIP
check to fixup_umip_exception().

I can add a sentence to say that the current check is split into two
separate locations. But, is it not obvious from the diff?



