Return-Path: <linux-efi+bounces-5061-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F05BE0C85
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 23:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945A519C2304
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 21:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D732D0608;
	Wed, 15 Oct 2025 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPWGPuNI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0481DE2C9;
	Wed, 15 Oct 2025 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563050; cv=fail; b=LNtjoOY2RAIdlPK2D142QcgxOIxOLnKcZQNhnrwDZFitLtvL4SHgCfT7R4tKqa3UcX0GS+XuNXcN0bNIudOplXgemp0HLK6EMLb2ndg0kdiAvKVq9qtnTwGgSMgb8cUouB3eiDYiaKfOFA0DbNEqb9F9Fs8PZFR30L/RCpTdvj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563050; c=relaxed/simple;
	bh=wwmetStLRole0fMUbRcpfYFkLixK/o+xdNkNXUTuuVI=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QAi7LiQXP30d2aVUTQeEfqZOygO2psyXmuxhzQ36SWP9fE7U/C9Ls8bQlgHZCSsFgM5sIJisgGedgbL6dipOF2Ltbv1BwLIk6mhqsTIqdAbfWmOSYeSkSOQVpxP0fKnch63QYAOnFkKJDLMnWkN84xJgwjvp8DSTxMwzVIinvvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPWGPuNI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760563049; x=1792099049;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wwmetStLRole0fMUbRcpfYFkLixK/o+xdNkNXUTuuVI=;
  b=jPWGPuNIab7cqpupwlvbdzO8gU0pEy7g2QC6aBpXkOLs8+yd14yyCDkU
   k6iUK4LhxSWrbsNi7ot66cnGn/KZOhyqTx6uRBVwj7bveIw5537WfUB27
   d2yq2S4WLjHLg2elF6K4Cqbj1GEX4H6OhjjovFWDwp9CltW9lCb9WGT5P
   ZNdmetUYahjyykWvYPyaIWiCnawkk0aYjArWYKFAm46BA33OYJ2fxv5iT
   RREizV52qrEV15uyHyRD4LeL9Dnm76oJ10UGz2DoFkpP6xwUCheiNL2Z0
   J+ipwDU3y0ZJkmu6aUgnGPE/rzhaVNcOHVG02l5ve8kfzJrDD7Ja9K0yY
   w==;
X-CSE-ConnectionGUID: 6rvq68FcRpyaqpR8Y4BvEQ==
X-CSE-MsgGUID: nQQo7qHLRV+yaV0/al5qaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62644318"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="62644318"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 14:17:28 -0700
X-CSE-ConnectionGUID: 16IQMmGLR1igcjcmpRJi1g==
X-CSE-MsgGUID: +GoEST+ATduop/2SS/FW2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182686905"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 14:17:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 14:17:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 14:17:27 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 14:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JF6IdbgJ8hxd0FiSMIpXTw8SYvFqqzxC6Td+zfXp24s2hHAPyo9p4QErzLO4N6+J7sI/CRQoCNFFTxfMTBDVfKzt2g3uHhiqSQMbcqGk2X8i6OgNJQYI46s+6TRO6B9US+17FJpyN8sbdXe8nEmtC1Oxs5OxWa42bP4KNosKv+yVKyPBMW50ycMXD7zOm2DwNwdCFSdIwKWV7Qz4sPbbQZTZ78IKVkNDahdar1L/k9MFbKxA6887ypgwTrdFRyOlKBGWw9yxokTvMraB2RXBAtG9srKYqhxtgGlpoo+s+mrim3LQMm21g1GBYVaaUW8fQB5Cbc2BvlSNMF8CqwAiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfMAmHBHmbNpnccoexXCqhbeMZ4EJ1+R0yR1xe/Mmzo=;
 b=LCdKNhP5s2Y+DfV+zUco2o4Dp9u5muyqStl14LH+nahGbs+DxXqM2axx7yz/5qoDdAJV+ousg/L8j4yuf6puPOYRg6a+VADNDAAXEwlBC52xS+bZxfITF4GnMjvtv/+XXNY7JXnJKLQxwzmrdZdlSoBpKQWirlo/ka3CDFyFze/jEGaSkGzYd9plgd/0YCAgAUzoUZNvQdM4sn/A8pPI69lBzp8cAOZEo2xM1zSgtQRTD1Si45EUe/a5xtT7s1+frZ/Fu3wR29BXGqqoLK6ZcbSPHB+ferUCIwfuniD7UTKrlUvUKa7ZikDMxB4jvdEvTikw0CCcbN8slrdFZY2jLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DS0PR11MB6376.namprd11.prod.outlook.com (2603:10b6:8:c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 21:17:23 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 21:17:23 +0000
Message-ID: <5e259c5d-3367-4efb-8291-69fbbcb0003c@intel.com>
Date: Wed, 15 Oct 2025 14:17:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/15] x86/cpu: Defer CR pinning enforcement until
 late_initcall()
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"vegard.nossum@oracle.com" <vegard.nossum@oracle.com>, "xin@zytor.com"
	<xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-6-sohil.mehta@intel.com>
 <171d197d80701224b83e707948ae5e0a33e27b28.camel@intel.com>
 <6a71fb30-32f2-4847-b4da-e52b67433ce0@intel.com>
 <14038b019ba53dec91ba6718802504580848879b.camel@intel.com>
 <8a324a4d-f135-496d-9718-19ac2a7f6af1@intel.com>
In-Reply-To: <8a324a4d-f135-496d-9718-19ac2a7f6af1@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0131.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::16) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DS0PR11MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbcbf59-da5a-4511-061f-08de0c303b7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkU4YnpCVi91TUYrWENrTG1LSWh3WHNCWlFndGN0Nk12ckpKRVdSNDNyblJ4?=
 =?utf-8?B?VGR5QkZxck1iMEYwOGpwOHRYeStKaGVQcWU0TUdsdnhhWTEvMFNjd21NdWZC?=
 =?utf-8?B?bGFsSW50ejRXQi9md2lNTno1NHhTSVdKV2JCdFlnbjFDNy83eEZjdHlRWnR2?=
 =?utf-8?B?c2ZmWjF6VWFyYkRuUEJvOTJXalUrMXYyYXhIMjdVc1RMMUV0WXlDREJUUk1h?=
 =?utf-8?B?RzhkUTJxRlhYbk9vZXZqeG9KWlBHRTBxN0ViWHR4b1o5cjhDRG41VGVWYXJO?=
 =?utf-8?B?MDhhOElPY3NZMkdaOUdZazM0WnRka2duY1M5c2JSR2FPdWU3WXZZWUlnMkVx?=
 =?utf-8?B?ZjluV0t0NUVNZ3V0U0xmNGJ5MHBNYUdKMGdiYTZibWJYdWdORFNaRkZjK0Jv?=
 =?utf-8?B?amlVd0lGL3oyS0VBMzZ0SXNGQVUxYkdKcG1aTHRYOC96TjVXSFBPT3lnWFdt?=
 =?utf-8?B?a1U4c3d1RlozbnNib1JNaHhVcU5lNHk1K0d1VVhkRzFpYkNBZ0tBRFhCbkVs?=
 =?utf-8?B?aHUwQ1ljRnVweVRuUFhlMHgxa1BKSUtZUXNUYmg1Q2ZOVlZUVUpOcjlEWEgz?=
 =?utf-8?B?Z1dBcmk1Vk1XSDV2MlQ0TEFOTER3Z1lHanYzWkxtZjc5Y3MrUHR2T29UdjZv?=
 =?utf-8?B?bnAvczdwRlVUVUljSUhuR0Q4bDNDczdrWnlXWFdOcVZ5SGxpMjlONWl2elBV?=
 =?utf-8?B?Uk15amRncjdFNmZldFJwSXFkbDIzeFRKdkRoRlFqYUphL00xTUxiSytmK2FQ?=
 =?utf-8?B?NTNoZVp2NkRyTkxqRjZMdWxURVZiV2xLWXJsYVZmMzdqUWhFdHNsREhGUWNB?=
 =?utf-8?B?dFl6MThQaWdNVk1MSDVhcDJPdlNlOE1uSnQyMjJSdFFrQkJrZU9SOVdZcDNx?=
 =?utf-8?B?b2psRHlJUzUrdEZzb0tra3R6a2dibnVzR0Rabmw1dUtFWXl2OHh5bDJQNDlP?=
 =?utf-8?B?UVlJNWlZQUdGQlZtMDJhdEpwNG00OHlXclBpTlJMeFRwTWRDQldFVWJHRmtM?=
 =?utf-8?B?blRVRGdFb3diMXJYQmFzRDZuMTJXbloxRFdEZDlrQ1YrVVJQM2RjalVjQjdp?=
 =?utf-8?B?V2lNNExEdjMyUzJTM2JNMUJoSmN0WWRFUnZzMGtsWjhJcHpVVnIyQ3FldEVL?=
 =?utf-8?B?UTRkQ1pNNjE0S0tqc3REODFUWmVpbHJYcWhHaGtKM1NxV0o0U2FKZy9TS2xQ?=
 =?utf-8?B?amo0UE5rWnRveW4zZjNvaVB4Z2Z6bjNzdEw5RG80S0ZSYXovaFUwK3VZa2oy?=
 =?utf-8?B?YnBsSCtPZnFjNHJOSFUrZS91RG5neHU2My8zajFoOEtxaXhXeFpENXcxdWNo?=
 =?utf-8?B?NDBEeXo4c1hBM05zOUd5dHNMWXVnOENYTXNmQ0RFSkw1V29LWHNPWXdJVDE0?=
 =?utf-8?B?ZDVuVlRBUEwzcXU5Sk1iL09Eb3BHSnF4NzRYZ3A1MWN4NWlWTkVTMTVjTzFY?=
 =?utf-8?B?UnVSYXVSbm4yeGlhNno5T0kvWDFIT2dlSkRPeVVIZFhOVDNvekhyYTIwSXQ0?=
 =?utf-8?B?Zmthb2hheUZMMXFNSEx5MStmSk84TGhrb05FT0QxUXNKRFZOekN1OFZubldC?=
 =?utf-8?B?M0l0OHRyNFZ4VTY0NGk5VzIwV0Y4YlRRRVZ4Z3dCK0wrdmxaTXNwcnptV2tj?=
 =?utf-8?B?Z2pFbzdlWmV0bk1kenZ1cEQvdjBsUGNOb2Mxb0dFNlB0SlpmbXZwMVhWRnk5?=
 =?utf-8?B?WkNGUkZuRUxCVmlGKzIzTGZObTNRbHBEMGx4TDlrOWtGUTdTVFVZbElNTGxB?=
 =?utf-8?B?cGVVME9qdnlvZUYzd0lpVlIzSTFNOWl4TmFrYUpCM1NoRlQ0OFMyaHVDZE5P?=
 =?utf-8?B?UG5rMkpxRVh3Q0FFTkc3NEtmc1JTWHNkMHBnbG5yMkVDZjVaUFJKWGErOTNW?=
 =?utf-8?B?TzhLYWlhUGhITE9rNDZRVjk2YUdOdkZ6d3BKYXBDZmV3V2hiYWozcUlkWm16?=
 =?utf-8?Q?X6Difqii+RYoSTl5rTJWCCgkkvhkYfOG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNjM1NPcm5DbFpRV241QmR0M2N0SkJWakdJQnhmS3FwRm1sZUYvSGVka3Nx?=
 =?utf-8?B?OExYSGRScFZZVWlrTEg0cWZYbHQ3c2RqNVNJMGMzL2dDWDZwaDcwVUxrRlFR?=
 =?utf-8?B?ajRtcDdTSCt6RmJmdFNPUFJPM3FpeTZDQmpNT2owOXBqb3NZVmMrV0tZWGdm?=
 =?utf-8?B?V3JwWWw2QUJHb1h4R3JRdkxyU1htR2ZOUThocXZTektSa0x6b2FOcUNuZjRy?=
 =?utf-8?B?VXM3YXpWQUtoanB6dGhYTEdMcTNZME40bWdvQlJXTWJlMDR1VGliQnZOOTBJ?=
 =?utf-8?B?c25qcmRNQ0RpcGVCYS9oYytmRWowVWdBRUF4MFQzTEM1bmdCM2ZPcE1lTGJR?=
 =?utf-8?B?clEyUmhOY3hCb1JHbzdmY3E3Z3dLOVpJNkkyOTEzM3U4TWdvcld3Ti8wYmpY?=
 =?utf-8?B?OEZSUjVOUUhqSFFjMnRTTmhMYVdmc1k4bHkxazcrb1VNd1AxamVLU2lOKzB0?=
 =?utf-8?B?ZFh5NGtrSld4em15YzNNVUl4ejhnTlNHejgwQ29VNE5wdnE5aDQzTFlBVU5M?=
 =?utf-8?B?eVg2a2ZEY3ZIWnZEQWMrK2Z6WUp5VEhpSUViQW9qeDdRa0tnaktKUm1LNDN6?=
 =?utf-8?B?aHREOTRyR3FpMHhPc3BlSlE2RWhndmR6T3c1WEduR2EwbU5BTSsrZE9jRi9Z?=
 =?utf-8?B?QlRxWnN3ZC8xemY1bG5zbUtYcTdNVjBFbnVEeXhxVWVuN1h0UTR0RlFFMjBH?=
 =?utf-8?B?eVliODNnSzM2aGllZXY0WjNUcjFVWXl4bFNsSm41ZHIzbHJVYktXSEhxM2ZT?=
 =?utf-8?B?VnlVcmZKOUZDWFAwaFVVNUdPVGhjMEoxZzlmQjM0R0gyRkZmTUxWaG92eUd1?=
 =?utf-8?B?WTYxcysyUDJ2L0s2dStkd1lvQVZ3dFFjSWZvNDdQa3h1KzM4Vm9JV2ZCMlEw?=
 =?utf-8?B?U2p3bGsvYUZXY3p2UW1yRXc2Y0xHZEVCL0hYU1lqOUJVd0xEdGtwNzVFZzl0?=
 =?utf-8?B?ODR0SXZvUmdQaDMvRzczSFdPSW5ta3BvblMwdDlhTUJoZ1dLNHBZVklQSHN5?=
 =?utf-8?B?L0d2MEpZQWZ2Y2FHYVZzRmJRa0pWOW11RTRvUncyYXFaOS94SmdPRFp6clpT?=
 =?utf-8?B?bXRFZkMyd0kwME5KZ2U1Mk4zOWZxZ1hhaFZLN1VHZDF5K1RLcHdDclg1eU03?=
 =?utf-8?B?enZtbWE1UitXbXpGN0RpU3ZoRFAvWHVLNVh5a09lV3crUklKYjRRY2Vsb0tt?=
 =?utf-8?B?bWlya2FQaUlZalZrWlBveTN5dU1sbkFheWt6VzFST1NYK3diZTlzc2hZRWFv?=
 =?utf-8?B?WEpEbitoUnFqL2ZUWUhmSmtuSXlxaHZoaDdRUHUxOGpmSC9kSkRSTG9ua1ov?=
 =?utf-8?B?a2ZiMGpBL2lsNHhGZUpMTDR4VWZUMjZieHkxQzRiWCtaWGtIdG9vNXMwaFB5?=
 =?utf-8?B?R2tQaGFBb290SWlvYmZ0UVNoQkZhN09IWnYxVm9SNm1iMXZqZzl1REs5dWp0?=
 =?utf-8?B?ZG9CY0xTUHZic0txSGJqYTdBRE9EZmdWVFpJYnZrZEp0YTd3dlQ3TmkxV04y?=
 =?utf-8?B?NUhXclBtZUM5T2dvb0p4bnBkSkVhdW1kdW1XREVvSkVOR21yUVN0aHIvOXhT?=
 =?utf-8?B?eDBRZkxMSk5TMWJ5MTVDNXhORUsxTFg5cllEYUtMbkFiejRBeXpqVkhVcU9X?=
 =?utf-8?B?RnIvY1lGQkFTWjk4R1Z1LzZXbEhhdGlLa1lzNGVTZHlBVHRhbUhWeTN0Y3VK?=
 =?utf-8?B?cWJkQzNDZStnc29odTZrNVRGbTcwZ252ZDhHUGNtNFgyNnhzWkdsWWRyRW9K?=
 =?utf-8?B?Qmt3STZkek82UUFKRGdSZXgzUFB6R0JjUFFGc2t5U3lLcTFvb21PVWp5YUcr?=
 =?utf-8?B?a3laWFZVak4yTG1KQlBsQ3Eybi9xMzU0MHd4d2Zpbm9ISmxjMWxxcERVT2dm?=
 =?utf-8?B?ZW9pRW9mc04vN25PUGZuTUNlK0N0K0RnQzR4eUFLazRTQTVNQzVxRWFLMmZ5?=
 =?utf-8?B?WFVHUU5PbkYzd05QVitJZkYrQ25rSGFhUlNjYkJIZHJsaU10YWRyNWEvOTA0?=
 =?utf-8?B?ZU9RcEhQQWhpVHp1L2FPWWZkaW5GVGpPOVZISjNReUZRSlEvVkN4OExaT21M?=
 =?utf-8?B?OUtvZ2ZwQ2hibjVqL1RWd3dFTVM2c0hoM0wyaDg4ZDNhS0MySTE5NDdMQlVL?=
 =?utf-8?Q?ao9dHDQmUeanOBGkDekcM7kb6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbcbf59-da5a-4511-061f-08de0c303b7e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 21:17:23.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZjzZBG++2QWaVFqLsMOfjPq+LvWEFZVpwmruBenzJWD/E/qtIHUXuWhzu2savF9zzFU5gXPa1xkXUJqq4z9MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6376
X-OriginatorOrg: intel.com

On 10/10/2025 1:45 PM, Sohil Mehta wrote:
> 
> As we discussed in another thread, CR pinning has expanded beyond the
> original security related bits. They have become bits that are never
> expected to be modified once initialized. I wonder whether we could run
> into issues if the initial CR4 value on the APs doesn't have one of the
> pinned bits set. From a cursory look, everything should be fine (except
> maybe FRED). I could give it a try.
> 

I tried this. Getting rid of the cr4_pinned_bits setting during
cr_init() seems to be working fine.

Xin says that there may be an existing issue with FRED, as CR4.FRED is
set before programming the FRED config MSRs in
cpu_init_fred_exceptions(). Any exceptions during that brief window,
though unlikely, would cause a triple fault. I think not setting
CR4.FRED might help the issue, but, I am not sure. I'll let Xin or Peter
evaluate this.


> But, is there a preference here? There is no additional cost of setting
> the pinned bits because we definitely need to program X86_CR4_PCIDE. Do
> we set the pinned bits along with that, or wait for the AP to go through
> the init flow and set them one by one?
> 

As we are planning to defer CR pinning enforcement, I am inclining
towards getting rid of the following check in cr4_init().

	if (static_branch_likely(&cr_pinning))
		cr4 = (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;

AFAIU, this change shouldn't harm FRED. Resolving the existing FRED
issue can be done in a separate patch.

