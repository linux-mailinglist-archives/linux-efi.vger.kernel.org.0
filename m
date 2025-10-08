Return-Path: <linux-efi+bounces-5007-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E84CBC62B7
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 19:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD00F3B7286
	for <lists+linux-efi@lfdr.de>; Wed,  8 Oct 2025 17:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF582C029A;
	Wed,  8 Oct 2025 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcEuz/iv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B12285052;
	Wed,  8 Oct 2025 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759945381; cv=fail; b=hou1kqh+6yKcNDZrseApOL6eWbj4rJmWIXI/4BvuqncZuWFeYj01bnbvgcjgzHcOmjjVdfWmY2w3N/TBbejd1o/Nkree9M3f/fioK83iuHxBjaeyhnWHDFOD3ACoc16rI7ROjfu3LiAQ/ywFAtpl1gG4mfjoBT9qOpzT6IFA/Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759945381; c=relaxed/simple;
	bh=Z+xVm9NVHFMn/onKWWJcnY+H8ibChGmDg6pLpucyn5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOVr4HnAhbw2X+WQ6bZvbB6/KWIeIUsujBcFgOguFn52NAtGCnM6B+Bau2VDT0RKOzKD5Pd8CYHGS169FzMkLUM6ydXUgTxDbYN9pe8dDNm5pISZysEJx3u5vslF+/xdypjGo+ZA3wk6QIyhjw9o63HFHSJHxZNKyxoFGXDq31Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcEuz/iv; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759945380; x=1791481380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z+xVm9NVHFMn/onKWWJcnY+H8ibChGmDg6pLpucyn5o=;
  b=lcEuz/ivr+0OBmdXCbA8HWOtBaf62qj2w98N/NrIa5EUmiTcYyzP6qPn
   Zb6dNDwz+/jXPVJ+jJqHfqBcRMYR9Jb5kgL9F9IxD6qWw7aJUOSTyvfhh
   h6ysuFkht/vRf6cXHo4Eads9ITfs7WsF3LJKvUdXoI7UQnpnCLwGctMyn
   F0u9sJNd3XuUFfnzOGEFuekOpBg29MBAHEijjQ/oueIBO1ypbJCrhRvQl
   sClnapsvujAJ9qySSc4RB1C+OsjQ5qenWPuteOHlAUAtrmIXrioBy29nD
   bHtvXNpGPkbqoqrlGZJQYyf9zPDOcOJA2L1rHSz/1n3XBntpefpSubTHw
   g==;
X-CSE-ConnectionGUID: nCeadzxKT+2dWwJ15W985w==
X-CSE-MsgGUID: i5jBOyq2R6WzRZsH4pc53A==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65790527"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="scan'208";a="65790527"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 10:42:59 -0700
X-CSE-ConnectionGUID: zV6JDyfPQDqkg/A1hclUeQ==
X-CSE-MsgGUID: 90TLNtv5Rwy13QG2NaCIcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="scan'208";a="180427654"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 10:42:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 10:42:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 10:42:53 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 10:42:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6U/jeD7FPhBVhyROzpi5WH/UQG88nABI6s0nE5Cj/U1yXOEl+mIB5URaT91sBlvGtT+Qii8NOjwy1WdZodNnIeEfi0C2QpvulBK12dkJ5UVqVrCK3NxbVJexhyeIXWGALU0Qw9U/ZmTiC7jUHp1hDU7WbZgbmEHUeYbjF8jwnzr6GH+nV+OToTCzwYcwrGtBWYFAMZRTi2L13VYuu+kfTcMSmjkbX55nKEWzI770pjbZniI0EyhQYeAwTXnKISdOHFViwYMsfiZXH1dvrZMsjMH6Q5XmWYIKLAF07bzyRlIOKY4/mXU2R/S4th/6IwibaH5b6G88bTbgz/4G8YcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+xVm9NVHFMn/onKWWJcnY+H8ibChGmDg6pLpucyn5o=;
 b=SUgEREsd82O3gb/tT+qc4m6xx+CJw/0jS0oug1Ucu6Bkpjgnyllhde3iysMfxssDukUZG7vgQcrXPJEyUxqQsM+XQ/LI73fDumAm2fXck2wGDbEIyS9FLiuVkwTJL9UTnDomhyM84knFxsiSGt8i+6gV/Np1f9g6ar7QZAIzC1xMaxOsqGAAWsoCCRVdw9Ccvm4Dk0qjvsNQVhApgDZUrBmEbQ1Tb8LhP3BnTGX9QiDlmsHe6UkWbgKVCunZ0h7Qnq1g+AufIsAci0n0JcMawhQQc3WVehkg1JKx0x4KYp5tZXXwBnAVnIzDnEdojtooOEwnkNyHg2H4Jbpd0o240A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) by
 SJ1PR11MB6178.namprd11.prod.outlook.com (2603:10b6:a03:45b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 17:42:50 +0000
Received: from DM4PR11MB5970.namprd11.prod.outlook.com
 ([fe80::e9b1:6f0f:1a91:2c79]) by DM4PR11MB5970.namprd11.prod.outlook.com
 ([fe80::e9b1:6f0f:1a91:2c79%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 17:42:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"luto@kernel.org" <luto@kernel.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "xin@zytor.com" <xin@zytor.com>,
	"kas@kernel.org" <kas@kernel.org>, "vegard.nossum@oracle.com"
	<vegard.nossum@oracle.com>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "kees@kernel.org"
	<kees@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault
 emulation code
Thread-Topic: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault
 emulation code
Thread-Index: AQHcN1cybBcaoDcZbUCUg2EjTwKZL7S3BCwAgAAC+oCAABJAAIAAMekAgAE77gA=
Date: Wed, 8 Oct 2025 17:42:49 +0000
Message-ID: <009a98b0999891d59e30b8d818e60adb35958fc7.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-9-sohil.mehta@intel.com>
	 <a33d59c7add98dd9ef352ac95178821dbcd0ce0e.camel@intel.com>
	 <3e3d2426-6296-4a61-beae-4e3ff5d60f2c@intel.com>
	 <3c078d53409c3fbf6eac30966e8d68e097d7a6d5.camel@intel.com>
	 <1f2b0ed7-67f6-410e-b05e-d87ba3ee396e@intel.com>
In-Reply-To: <1f2b0ed7-67f6-410e-b05e-d87ba3ee396e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5970:EE_|SJ1PR11MB6178:EE_
x-ms-office365-filtering-correlation-id: a35020fc-2cfa-4596-ec34-08de06921992
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UUI3bTl2Vnp3ME1nZ2N0MjcwRnYwWlc2dlIrcVBobVRVWlFObmtwcXM1aUZ1?=
 =?utf-8?B?Z2oxeXpiKzdJbjRHd1lkeXdNMlRsWS9HcUVZSkVjenBKdFpkQUxOTXprSU5R?=
 =?utf-8?B?MjNmam1INTlTaGtBckF3Wjl4MmNVaGZVTnJkODJ2QUJyWndSRmlhQWhCN2tx?=
 =?utf-8?B?Q1lWUU1qWSsvM0NScmxQV3dZTitUdTJZNU14RFdtdElYdkgrK1NGKzJIQzRM?=
 =?utf-8?B?eUFBSElZR2ZsYVJXR1pXdjVTd0hxVmhDMVhJdmJSYk1MZVF1ZlkxRzl0YkdD?=
 =?utf-8?B?ejl3SjZjQmxsbmxFV2FVaUpzUDYva1RwNVByU0x5Y0EvbWlXcHRzYklUZ1hi?=
 =?utf-8?B?NFdJZkFHcGJpU2RseXpHNW5ibmdFMkdQNXArQTAwZHgvdXhUT2tKQlVycVpM?=
 =?utf-8?B?TGZvU0ViYUY0L0dzZnZhbTNYYlp4RkpjRlBlYVdYT3NNTTl4US9oMVBZZU1W?=
 =?utf-8?B?QzNKc1d1SE1qeVoycm8yNU5zd3dNMTVJandyY25ZTjZ6c2FvTFlTTmd4cGpO?=
 =?utf-8?B?Tm1SRFBXekZDVjBrSTRSanNQNUp5RUhTUVgyUUQyZWRuVVRxaEJHTVE2Q3Bk?=
 =?utf-8?B?amtiYXkwdTIrb0U4RzJQRHNwcExYSTJpdlVNcFBJMFVmT0lmMlNPdnhDUzdm?=
 =?utf-8?B?azMzbFZBdlYvajBuZGo4OVdBemdmL1hVcUlnYXlZekQyV1pGcmQ3RFNnM212?=
 =?utf-8?B?TkJPZ2FNTURuZlExaEI0amwydmk3V3Y4Q0YveURBNEpLWFQvdjJ1NUNLa3Zk?=
 =?utf-8?B?RGdGY3prSTgzYm42ZEVRRThMWTN6ci9NOHRXWXIwZEtXRmZMTmtoU1BPcUJk?=
 =?utf-8?B?dUZTZGc3dlY1U3hYV3VNSkFySUFPLzR2dVhteWNxaHNSTyswUW1UdktrV2Fx?=
 =?utf-8?B?R1RYeTQydDZFSDVMN1BIdWZtcWhpVk9Gb0RsZWJvQXVXZWFuN0xhcHV0Z0Ew?=
 =?utf-8?B?dk9nbHJ3U1ZmLy9ldTZNZ1Jveis0NytMMjRSUXJRMDlHMGpNVXZreHdoNG1y?=
 =?utf-8?B?M01uZ0l6cnJGNk5tTy9YQlhEeVMxYmY4eWFaY1JYOHJiY1lURmEvdEZUL2xu?=
 =?utf-8?B?dHljOFEwWnZDdE13UGhPbkxNRWtVbUswRm1GMlJtclJnbmsyaXMwcHN1OFBI?=
 =?utf-8?B?YitpT1FRYzJKeWh3RzVOcFVTQTlZWlVkTCtTUm1ML3hQNWFvKzcvQUkvdno2?=
 =?utf-8?B?NlF2UDQ4d2hJYmttR3FUUlplbUsxTmRIdURJR3IraHRBMkpUUFV5Q1FWL282?=
 =?utf-8?B?eGx2RXlhOXhONW1yS3BHRFlVV0lPR0l3VTA2WDg4NlpmV1Fwb2xKcFFhWWJo?=
 =?utf-8?B?U2IySjVucnNVeWNXcXVDTWE3cy83QmtPaVFkNnovLy9MdThkeFRmUXZ6QTg1?=
 =?utf-8?B?clhIYjdPWkNMNURnWUYwMld2NGRNS091bWpaaDYyeFhjRVV1Y2NZbTM5R1RY?=
 =?utf-8?B?MXdqc2pTV1U0QzVET1cwWmgrNCtRS0xnVnRIaXlISHdKVThBa0RPZTFwQkRZ?=
 =?utf-8?B?dU1iaXFTaTJoT005cng0eXNIamFZbHNGNERDdEl5L0Z2QS84Zkc2S1cwakJL?=
 =?utf-8?B?NTZQaFhLTjNQQUliUkVBT0tlZVYzeEdaQ0lveTUrVmpTMm1XbEcvTTd3d3JU?=
 =?utf-8?B?KzlDQWpRdmVpOEpac0E0Z2N0ZXg2bWJUR2Q1RHdpNG1qaXJXOE5PaGJ0RWpR?=
 =?utf-8?B?a1ltYzcralc1VlVrSWdPenh3RGd2TmxxalgxcExibkRiN0hLM3FVZlpXYnZi?=
 =?utf-8?B?cGtKbGlYeWJvOVdyclBXcS8xWEEvd2pMNjR2WmhvUEpscUR4UFFIOEU4OHAw?=
 =?utf-8?B?WldKS1Z4Ymw3YXpwZ2QzT1MrM1lWMUNCQkQ4S3Z2c0NqRDRuTVRDQ2pJK0lp?=
 =?utf-8?B?dXM1S21QNVUxdnc1bFMyalkxbStwOExyMFc1QmJPa3ZvMXEyZFpuQlhoWm92?=
 =?utf-8?B?anY2VE5pTFlLb2ZQVDZEZHQ2VXBST3pra3FKb2FNRGUvbUFEajVNc3pTUnpk?=
 =?utf-8?B?UlJ4ZnFacXQ0bCtmMlpCVmk2dTNTM3daUkVjSWZVckROTjlUSUZhNTJVRHRr?=
 =?utf-8?Q?SyGKQq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5970.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUNhYXIwWG1OUnNqR2d6NUV1YjBLekxEK2NWcWZacXIzMHdzNVdFZ0xLMlVt?=
 =?utf-8?B?bk00eHVzeXlOc2taMG92dnZmaCtUSldwSEt3Q1QvYlZLQ3NaQk5iSUdiTkpo?=
 =?utf-8?B?bFBST3N5K0J4RjRiMXBQTGwxVlZoa0h3d3didVNoaUVQcHZPMVJIMm9CYWgx?=
 =?utf-8?B?UTB3c0VYeWJ4RVdqK0E4YkNIbDVhdWQxbjlDQ2NHTnlueGlubXQ0aERrVlZl?=
 =?utf-8?B?MFh0dXVxQnlodFRlaEtTT3FCS3oxS002ckpQLytVWXM1c0ZpYzM1dVJNcXpP?=
 =?utf-8?B?REVab3luWkpMVys3S0hPZG1oQTB0b0dhYTFHM1pKTUZtbGpudjRCZURmb0tr?=
 =?utf-8?B?TTVoL3RYdXFCNWdwU3Q3dzRvR0kyR245VHFCM1hnczYvT1JnN2RJdkVEcmlp?=
 =?utf-8?B?SkNONWgrSituU0drUys3d3kyeERQY1VLQTJwcUpwRjBpSzU0R01XQnJGdDdh?=
 =?utf-8?B?MFRZRE9qTjI5Sjl3SmVmV2Z5N3VtMFJJMm5FSDhZQXVrSkVMeUFrSUttakY4?=
 =?utf-8?B?VWhaSU9sSTJXODluOStDcWdoc3F3NDJsMHJrZk5kVW5oc0R3WkZ5cWFYVUNE?=
 =?utf-8?B?a283NUpuWm14czZjclRCaHRvS0FudzIzT3R2T2Ficm95MklaUjBDUTZuUDZ3?=
 =?utf-8?B?V1crbjlDamxONHhNUFNiNmxXbm9pMVJGRmZmTlhqbDl2dnE5Y1czS2VYZG1T?=
 =?utf-8?B?cVlJUHNQcHNzV1pZd2RSeTZuTW5KMEJNMzFwdlFXcUh0T2lpME1sN1d2RmNO?=
 =?utf-8?B?dTMxNk5yUUJIM2NtcHlScDZVM0ZRRURxaHM3MVYrMHM0eS9WTk11ZXBaVHpN?=
 =?utf-8?B?UzZLaldaS01mTWpQZ2s3VUlqUzdsMDdaTjNsMlQrTkZYcSt5NWhiTm5HTU02?=
 =?utf-8?B?SDdBcldVYnh2NFM1M2VkZDRWTEtMbXMzSWJwalN2SnBkUGcwY2E2SmF0cjht?=
 =?utf-8?B?T2FCSCtzeWY3dDR2a2gxNEpzOFdNcHNOY1FDWE9UakZrRC9ram1zV2NISzJZ?=
 =?utf-8?B?b0JrNGtNMkdEWnU3aTd0WFo5RGc1czg3SjUzMy9SMnFSa3NLOWhRK2dhWlp5?=
 =?utf-8?B?UWtXUGdSak41SGdmZk8yYzJ1UFkvNWplYmZMYWNJenlZQTlDRmtXMythOVhn?=
 =?utf-8?B?SUJKemRsSkZacVl5N1dHSlBKNjI2R0NjSk12cnlVRUhMWGF6cGVMQzdGSVRW?=
 =?utf-8?B?WGVqKzBRTlp6dXAxNzFVbC9KQnhSS1ZwVDhaVklCSWYvZG9Dc2gxYlVIeWtN?=
 =?utf-8?B?eVRYK2g4NzVUQmdwRkZPVU1XODRvdFZvRWExQWFIc3lMZ1NMT09lNzhwdlBo?=
 =?utf-8?B?MWptUWNSck9pbGppYWJVVVhPUUFtN2crR0NxZ2N6NW1UTFV6K3gxQ1pXVm5k?=
 =?utf-8?B?VGlEZWpxdzJnRjFqUzVoT0hEUG45KzA3Zk5rMVY4N3E3VkhMNG80RWNPZzhK?=
 =?utf-8?B?aU5aRGM4US8vTEY1YnF6TUQrV3B5cnQraHgyV08vREUwTGNJMWYvOFg0Nlhr?=
 =?utf-8?B?SjJibkVsRXJhNURJRmxMMUtqbTJIVUpBdGFFZEE0aVNmN2lpUDNPSzU4T0dN?=
 =?utf-8?B?bTdwY2liZ3V1cUxsaXN2NXdzQWR3bmg0SU1TSFg0eGlPNU81ZGdUUXE3cEJG?=
 =?utf-8?B?UzMwTmNMNXZwSndDcEQ2R29FNGNMc0hqdjNDREpNaXk0N3dXZlkvOGp5c2VG?=
 =?utf-8?B?R1AxOHluR0RDN0lGd2cvKzFTL0lCM3FwdG4wTHRBa0JKM2MzZkpXM0Q4SXpV?=
 =?utf-8?B?anZsUnoySkRUZ3IrS1ozaURoQk9zRDJFR3RvYjhpMGJNQ2xCREQ5eW1GVThh?=
 =?utf-8?B?Q1RKcW5FeWRJSHFPWU82VDVGTFdlTUx2UjkwMzQwckpESTVCMnlWblJkb3Nu?=
 =?utf-8?B?Qk5qbllqdlRQRHRPUTh4ZUN6OWx6Z2ZheXlhQkd4WVpBdjZ2VmZhR1QrU0NT?=
 =?utf-8?B?N0JzSVpGUlFITkZyOXlvdFNOMk1QcGVtR2FYNnVNczRKR2h0emhvWitmWWhR?=
 =?utf-8?B?c2llN3AwYUpxd2Q2ZGIxUFVKaUFRWFpTbXp5QjVYV0ZjU0dKSEZKZ1FXTHlu?=
 =?utf-8?B?NHNNMUhqSGdoazZ2ZHVlbHRodS93T2lhWHZFZmxIVzB1R01rZDFvODJxZnhx?=
 =?utf-8?B?c0wxUXJGbHFiU3J6MGZrMzU3OHhqVXUxSFkvVXRUeHJ6eXVhL1hiUHM2YWtT?=
 =?utf-8?Q?LWtBy5qDqmVGu/sZzEINqi8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F789F4B3AC106A41B828ED96C6FE63A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5970.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35020fc-2cfa-4596-ec34-08de06921992
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 17:42:49.6503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHZsXNhBOrsrg6syU1OHxdQ8ikWi3MdmuD2yvRjig6T7HFytLisLFgDpaVhNZ0YYWsFa8kt9lTtFG4G8zWUqq6CVm5SwJZlrqAC2NBrbQTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6178
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTEwLTA3IGF0IDE1OjUyIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
PiANCj4gPiBJZiBpbmRlZWQgd2Ugc2hvdWxkIGFkZCBhIGNoZWNrLCBpdCBzaG91bGQgcHJvYmFi
bHkgZ28gaW4gb25lIG9mIHRoZSBsYXRlcg0KPiA+IHBhdGNoZXMgYW5kIG5vdCB0aGlzIG9uZS4N
Cj4gDQo+IFdlIGFscmVhZHkgY2hlY2sgQ1MgYmVmb3JlIGNhbGxpbmcgZW11bGF0ZV92c3lzY2Fs
bF9ncCgpLg0KPiANCj4gaWYgKHVzZXJfbW9kZShyZWdzKSkgew0KPiANCj4gLi4uDQo+IAlpZiAo
ZW11bGF0ZV92c3lzY2FsbF9ncChyZWdzKSkNCj4gCQlnb3RvIGV4aXQ7DQo+IA0KPiAuLi4NCj4g
fQ0KDQpBaCwgcmlnaHQsIEkgbWlzc2VkIHRoYXQuIEJ1dCBpbiB0aGUgbmV3IGNvZGUsIHRoZSB3
YXkgdG8gZ2V0IHRoZXJlIGlzIGJ5IHRha2luZw0KYSBHUCB3aXRoIGFuIFJJUCBpbiB0aGUgdnN5
c2NhbGwgcmFuZ2UuIERvZXMgdGhpcyBzZWVtIGEgYml0IHN0YWxlIHRob3VnaD8NCg0KCS8qDQoJ
ICogTm8gcG9pbnQgaW4gY2hlY2tpbmcgQ1MgLS0gdGhlIG9ubHkgd2F5IHRvIGdldCBoZXJlIGlz
IGEgdXNlciBtb2RlDQoJICogdHJhcCB0byBhIGhpZ2ggYWRkcmVzcywgd2hpY2ggbWVhbnMgdGhh
dCB3ZSdyZSBpbiA2NC1iaXQgdXNlciBjb2RlLg0KCSAqLw0KDQpGb3Igb25lLCAiTm8gcG9pbnQg
aW4gY2hlY2tpbmcgQ1MiLCB3aGlsZSB0cnVlIGtpbmQgb2YgaW1wbGllcyB0aGF0IENTIHdhc24n
dA0KYWxyZWFkeSBjaGVja2VkLiBUaGUgc2Vjb25kIGhhbGYgSSBndWVzcyBpcyBzdGlsbCB0cnVl
IGlmIHlvdSBjYWxsIHRoZSBmZXRjaCAjR1ANCmEgdHJhcCwgYW5kIGFjdHVhbGx5IG1heWJlIG1v
cmUgYWNjdXJhdGUgZm9yIExBU1MgdGhlbiBpdCB3YXMgZm9yIHRoZSBvbGRlcg0KcGFyYWRpZ20g
d2l0aCB0aGUgImhpZ2ggYWRkcmVzcyIgdmVyYmlhZ2UuDQoNCkknbSBmaW5lIGVpdGhlciB3YXku
DQo=

