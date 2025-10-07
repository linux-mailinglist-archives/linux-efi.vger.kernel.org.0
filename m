Return-Path: <linux-efi+bounces-4977-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF2BC21B7
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 18:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DC004E4A6A
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CF2E7F0D;
	Tue,  7 Oct 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="By//YQvx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9995F2E764C;
	Tue,  7 Oct 2025 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854234; cv=fail; b=lT/dZUtvFbvAU9XodfAVSWflETmPsTMDhGuKOnQGQqojChsUlYqMgsKmG7MFI9ieWTts97qJUa3u9ovxtKcHfsKbrGS8VAV9k2/C8fUfcM+VWIsNnwi9twwFH1ht23+T2+b3dsxMCiHrjByDBkR8RYSjo/tc79GBfak2uqn2JM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854234; c=relaxed/simple;
	bh=rHwoBIbskLejSXW8OE5uCJoDZy47tOHHPNpjJYkXDRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IIWTKBi7UiYyhdlFy1TlpgIIr+SIX1weiTpsX2SpjlMnPC896NPcabI7MerOIfpUiQIhJzg/uBxGWzhffYuLh/AFUi57vUJ8Psv2KgvulIC+qB4GWllApDeP3RjuplY6yS8V5bToGrLmr47uPCQylyG/kSWJSLWymup2B0lc1GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=By//YQvx; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759854232; x=1791390232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rHwoBIbskLejSXW8OE5uCJoDZy47tOHHPNpjJYkXDRc=;
  b=By//YQvx6E0aRcZQPIdYLQWyiPYkK4xmKykqTS9jnba9WHDm/9t8lNpN
   lqCUo5kEASxDc+hV6F9v8KMUNWDBrbQ9LnRE2u5rf+VXUF3GcAw3xb9fL
   tGRZWuQ9IeN1nlDxKXZohaAKysVsJL7WizET0xKm2J4pb/Es3OLNhbG0S
   vANjZ7W4mqClrusNYRDFuXgjpNrVh90kNGrE5MI5VEzj73DdhV4Q46xIB
   8SOXJALXLUWf+O+M8eOFli1ghbNBcIqgcb4pLeK2rtfjzRZiyi7/2qrDs
   pY16Cz9Sx+G1Z5OQQ0tEBe+22hBnOJ10zmMNQnZKs/hpbsFFG4hSYMhqa
   A==;
X-CSE-ConnectionGUID: q3ePtrJlTBijcGKvh+BbHw==
X-CSE-MsgGUID: Q4BW12IpQ3KhtwD1Qnb0EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="87508918"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="87508918"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 09:23:51 -0700
X-CSE-ConnectionGUID: raqqqEwAT+GfhSn8VbGPqA==
X-CSE-MsgGUID: eDfJiL91TampRvkKNbh/ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="185346541"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 09:23:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 09:23:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 09:23:51 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 09:23:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioJjDGZvSnNKS4osXngVSaKuysof+ysIMwfRH7TmKpA3h5nwmrAur670wM4c1zeLod3qh/kaZND2usjvVX//kDkIuMgmYJkylMNw6iGiXs9S3UM0LtAobKrpn77zPM9IehqpFeXvGFk6MQJr78Tg6qIuxahUNe0/TEqki4tNC5RbmY8sXpA9fcMrGOv4kV4JDEldgiExRLLU92jPeSP/0fdqIBrSEXIpYMpsoBe9M2ePw4cRxVa53ozRO7H85Ky8AlrZEa0fxOEZOKHb/J2gJnXao4QPRdl6BdT98DwJ3nFONNy5+xQQMSKsn6r+BpljiggPy0ukkOsJh94LjVdqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHwoBIbskLejSXW8OE5uCJoDZy47tOHHPNpjJYkXDRc=;
 b=QKtgV5CLB9lGCxaQJwgZe1CDCfS8rFMzR7g+OCscTHhlpH60C5s1NrOUqx4M5wvn/wS8CKJkBuN3/8yYUJZVWQx+6EZA3kZv7YpZTMqntySecBXnlqw/fNFYwjDskYq47QiEXsdRc3DVGc1h+PMun7ihpttYI/UVgeH1rYWh9UX5TgwDlDu2SYdRKp5MNqU5F4WOPQ6MimH7LzQaXiKrbNV6b03uSQLlh0t5X2SjRkITvfJv3Zr2S+LtLK/MHFogwZn+HgYjUrLNbc3MBAenHYhjnng+lOhWT/z8klCDHTB36QpfSfVxjBhPUEu14keep2Mss+BjBCgHg9NjqoFdtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB9452.namprd11.prod.outlook.com (2603:10b6:8:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:23:45 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:23:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "tglx@linutronix.de"
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
Subject: Re: [PATCH v10 00/15] x86: Enable Linear Address Space Separation
 support
Thread-Topic: [PATCH v10 00/15] x86: Enable Linear Address Space Separation
 support
Thread-Index: AQHcN1cvlSzrp3B090O1WN4mxd4LL7S23tEA
Date: Tue, 7 Oct 2025 16:23:45 +0000
Message-ID: <27fe1dedb151a606ae46ae3c2bccd80b9a64ff07.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-1-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB9452:EE_
x-ms-office365-filtering-correlation-id: c0acfc37-9bba-40c6-f851-08de05bde360
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QXJZTVM2WTRaYUJtUVgvR3AxVHpNeWlYUDhwZTBlOTUwRVFoTTg3ZnBVSzM3?=
 =?utf-8?B?WVAvY1N5QWRxN3NBQUg0TUk2Ynl2MCtLSDBOeVRIWmdXNGMzSG42OGZ2V2lG?=
 =?utf-8?B?Q2Y4TDVkS3lqWkJQT3NhY1A4MnZRRk9tT2VMRldGM01iMDZ1alFxR1VrM05B?=
 =?utf-8?B?RVpVNHN6UDZlRjBjM2xycW5JZUJZTnU2aWVTNWE2dnNMcXZYUEdBRTF2MjRy?=
 =?utf-8?B?RERPYjN1N1hEbm5iN3Y3MEtYZnpScGQ5QVZ5WEdUOGdUd1hpRlRpTmozWmY4?=
 =?utf-8?B?QllWMW94amkxQjUwbjRTaUFqeWsvZ0lRUzUxeGtLbGlKemppNnZuZkF5bmty?=
 =?utf-8?B?aHJudkl5dVNOYXZLTTREWWNjSHE4YWFoeENRaDVmNHdxb1NGR0ZpMWM3VWxy?=
 =?utf-8?B?YjBBK2ZWQ3ZhQWV4WFVaQ0pzYXhmOGt1OUxtVnRDWDhrK1JmdjRvNVNpS0Ir?=
 =?utf-8?B?emVwT1VzQ1JvRUVoMll0LzQ0VjRCS0JNckFvU3d0Zm5NbWFuMzdKdjg2VVZm?=
 =?utf-8?B?ZkU3TVJ5NEVzS3oyakh6UHJSZnI3aDg3UmFOalNXOGtDd1FZTERPaEs1U2ox?=
 =?utf-8?B?M1ZGMmRHWURFL1FlTHI2S1dIWkJQbE9vVjU3cmlLKzJEWDBZeWh0MThZOVZm?=
 =?utf-8?B?MGIzMTVWTkZCbWFiZitNR1drNThlVTRUdm9weTFsbjNKZ0R4UUFnemtvdno2?=
 =?utf-8?B?Z29BYm4vWG5hcWpnZVMwQzNWU0NUMU1lWHY5aW90WjM1MG5lOFBpd2FWcUNC?=
 =?utf-8?B?aXJKYllEZjRIaE1uR011aUdaM3R1UUMvMnlTRnNIanBzMjhnTU96WHRFUkl4?=
 =?utf-8?B?b3daQXQzcTVjN3Y4R1VPKyttMGUxL3Y3d2F0S3lyekMvYkJybzRQQ3lsNTNO?=
 =?utf-8?B?NXJVb2xsSzh2Qm5tV054TUJqVFJzdWpCNkw1TUJJekRGUUwxNXNuWUg5QUZM?=
 =?utf-8?B?Ymg2TEJ6aDNjQ1RWTzBFemd3R3hXUkZiZVlHTVdLRFhrZm5BVUtYNkFrVnlL?=
 =?utf-8?B?TmhGWi9KVVFicnpOMWxSQTkzUmpKYzMwT0p3bFJmaVYrcDBwNDErc1JYUmQx?=
 =?utf-8?B?KzZ3YTh0YUROSlg5YnJmcTNzT29TSWR2engwVFFrN25BQXlPVGJqeHVGdWEx?=
 =?utf-8?B?UVIwdS93dkY0K2dCc3JKV095SXpWUnJSbWU2Y0F1WUtuNE5QeCs2bFcvU1ZC?=
 =?utf-8?B?eGRXQmFCcFM3S2ZDTjZBYlNCNzVQamlWVU1DcUNiTHlRZGtOVlBQU2VRY09N?=
 =?utf-8?B?U3BFNlptL0J2ZzNjbXlXWSs3LyswSnpJUmRPeHM3VGo4M3JhbHRPWmxYMHN4?=
 =?utf-8?B?eTVBSUplYWFGYWs4SUphSWg4eC8rLzNZVTB4RWw5QW93TnA1ajlVUDVWZkpj?=
 =?utf-8?B?VitUdFBWNHZCUUg0L0EyY3gyUVlWa0laNmU2c3RRd21LSmpIa2lMYnFaM0xk?=
 =?utf-8?B?Z0w0amlja3FEZHhnZlJldEZxeGVIMnMxZFhNRUdlMUtwdm1LQUFUd0Y1SVU3?=
 =?utf-8?B?OGNoVDNaYXlEakhTUFd4QlkyUndoY2FySVlUdnl2QVl0RlhlN2JCcEhXZWt2?=
 =?utf-8?B?TlpDdDkvMitZazN4enJxRFJVZWo3SXVYdkxJbE1JR1BNMFdodzZkWkVBK3gw?=
 =?utf-8?B?QzcxZTk2eGxJMExVVEkxSXM3TVVqKzRZVjREZU15WkRqR1hvYnZTbHNzUG1Q?=
 =?utf-8?B?ajhMZXY1K25BbkowZkJ0WHpNdWpiWDk5OHpGcjZIYmFsdlhLdndwMGVkK2lx?=
 =?utf-8?B?WGlMZW4yL1FKdzdsRXgxUFZ0UnRYSDFHemw1bjF5UXhHTldjbk95UlcvQS9D?=
 =?utf-8?B?U0JSSDVBc1NFdGlxYVlKcFEzaTRHcTVBY0xpZ0E0eVdGKzJBWnMvY0lNVnk5?=
 =?utf-8?B?Tm1QTnBHVVY5emtxbDlhTUtSZXRJb0tUZDA3WjNiT3lRekVYdktMb1VXbWZE?=
 =?utf-8?B?L0s2d2xSY1ByMHliNmRUTDU2UzlaQ2x0UXRCd3R1Ylg4Yi96YjM3ZEhpejRQ?=
 =?utf-8?B?bFgzeDM4Y0FXOExvMktHejFxUk1jZFhpb08yWkpZTE4rUWJOR2ZqTUlZT2Rx?=
 =?utf-8?Q?krt9EE?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THVJY0FYdEJUU2F5SXdYOXVHbkJpcTZ3UUdyYW1sdVFCK2NXbkJXQWpaOWZp?=
 =?utf-8?B?SVVBaWRiSEs1RWRCaFpYalRLbnVzcG9mamZKS3pYYmRMNTBacHdqV1BYUEpm?=
 =?utf-8?B?NjNyanFxSzloM0RhYkJJek04aEZJTW1rU3IzTmQ4SEJOazRRc1BDejlTZGR2?=
 =?utf-8?B?dkpWVjZEV2lGZXRkNFRlQXE4WVc3aXZxU01zYi80L3dLdkNIWHNTemNYK0xW?=
 =?utf-8?B?b2lLbWp3dlhEcWRXckFySG8yVUY3dFRWVUNMZ01seVpsem1idDgzZUZ0QUEv?=
 =?utf-8?B?Yng2Q01zdmsxR0JLaHBVWnFsVUNLRTdTZkcrZmEyWmRNVUJQTzFkQ3MveXVC?=
 =?utf-8?B?dWFDZWdENkhrdmF3dzhielc4Z2szNnZwUXAxSGNRaWQxSnhNVlE2bjYyRmpa?=
 =?utf-8?B?UWwrWDJNSURwaWFtNDJmM1dYb00zZXpwVzA2T2tNeEIrWnhNUTFyQ1F0c0hp?=
 =?utf-8?B?bDZFZ0hGV0dYR3lOOGpMUUJvNmVBNXU5SW5vWnRZcDVaL3VpVm9oM0cwTUpa?=
 =?utf-8?B?MjBXVDZnaDh0RGp2V0hMTFUzMzZZdFhDVFlJWWYway85VjhtUzhUWm9EenlK?=
 =?utf-8?B?bFNYcG5zd3pnNGZSQnZaamNmbGxQOURYc3laZDN4cms3a245M1dPcS9jRFYv?=
 =?utf-8?B?U2tad0szTDhVRlJmTDNNWlQ3ajZDclhJWHpMOXhZQ0p0MmhIYWFCMkI1Wk5u?=
 =?utf-8?B?cHhOaTF6MTJlellDZzRyMEZYdjBTUU1jYnZjR1BHRVp6NzFCaVQxMzBSYlpD?=
 =?utf-8?B?OHNhVFBDdmU4Vm1XVmVKU2lwdC9Tb1RUUDdzTVNUYm1UUFNQYW03eE8zZStO?=
 =?utf-8?B?WmlDOGszOUJuTHR5ZENxcFkzY292cUxNRjBWVHM1Z3V2bjNvcjB6YkR4clVR?=
 =?utf-8?B?S2V1Ujhjb1Babkg5V3ExdTRJUndOa1h1TkFyMUtuSWVLeGRBaEs1bHBHN1Jp?=
 =?utf-8?B?Z0FlRG1GSEpVSldrRFMyWjVIWnQwZEQ2TmEyK3lPcG9MQnErNG5tY05XU2N5?=
 =?utf-8?B?K2ZTa2g0SVZTTVBCRVhlSDk5bXNCczdWcVBsNytrMzdOZVgwU2RFbG1PRXM4?=
 =?utf-8?B?U0JrdGdzMmFsamtrcndsK2RJR1FZOXpFWkhsd3UrM1FRWmp0bDE4ZVpFbzZT?=
 =?utf-8?B?TmRjaGc1ZS90WkRYdmVLTEhMbS9NTFJDeEVFTUNlUlVrMkJCQ3dobXhRaUIz?=
 =?utf-8?B?aWQ5SzJ4cm5FZ3dWUFJaaEdnc0tsdVlKcTR1UkZXelpIS0xISTVTOHZyQTNx?=
 =?utf-8?B?bVpJM0RpUWxVWEViejc5K0xua0VOZmh3c1loQjdZczVDZThBSHhNWmhHcEVM?=
 =?utf-8?B?N1NyT3FJbFJjMFE3eVM3b2YrQ1pOK3BtdmxJN0RUZzBpQTU5WjdIWFhENDFi?=
 =?utf-8?B?WFJJWm9vUmt1Y3VRdHlUeHcvdHdneGpDckM0NysrNDl5Unl6RmhCN0cwanJY?=
 =?utf-8?B?VUpUQiswS21NZlcvT3FSNHZwdlNCNDh4WjgzaWV5eUpBYmxpblpMOWVsTmxj?=
 =?utf-8?B?ZWRIZFM1aG1zdVdUOEFQb0tDQS9yV0xacFduVlY1MW5DZS8yYnZpbUFjRVJx?=
 =?utf-8?B?MFRZbG1kbmRGdUYzUHVtcjcvc3lSd0lUWTgyaEtkSEl2ZzlsYVlUanIyRkpO?=
 =?utf-8?B?K3M3c2VVZXRVeFJPSWJ5d1Frc1h6V0IyMUcxNkFvRVpsdGZENVlVQ2lIUmJM?=
 =?utf-8?B?WlZZRFF1SjIyWTYvcFM0N2lkN2lMSWNnSVVUdnFnbC8yajNUU3hzRzY3cU9N?=
 =?utf-8?B?Q1hZYTZEci9tSGxsYnZYQ3l2NGJYUGZwWnZ0RnpaSVZFdTROYlI1dnhtZmpn?=
 =?utf-8?B?V1J6azFna3BIU3hrU2IxTlNxQkpzMC9YOEkwUTc3cXpBbDdQT1R0WlYrRkgy?=
 =?utf-8?B?RmRqSGRKWjNMZXh1MzRCOGFZRUJDZEplNTBWT2JYQmZJY2JMV3NOenN4bngx?=
 =?utf-8?B?NGZYZEdRNXNjNFp2WXZhWVZvNHlvWkI2SnBWaDh0eXRPbFNSUjhDZmRsaTV3?=
 =?utf-8?B?Y3daMDhLNWR5eThvZWdhYXdFQ3hYUE1uVm80RDhYZTR3dk5JUUltRHpWaFBr?=
 =?utf-8?B?RVBlREN6bVJiUzdQMjVQNlJ1MzhrVHczdFI3alJUWXZEbGg4ZzFYUVhyR252?=
 =?utf-8?B?S0NXbTFlUDg5RGV1UEQ0WkNOS1E4Sm0vMFl6WkE3TFAyMUUxWGFiNUppQXd1?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7922BDC8985DA744B66812CED031A0D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0acfc37-9bba-40c6-f851-08de05bde360
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 16:23:45.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVGaAW1FASqwLgnxWFsIpbEpiZRMl/EzWHi27TXzsxeCDqlA7ZfA1t1pnZa9kSnl0nWZRgxOiR3DDpDcFn6zvPk2wk6LzaYpaaC8lVJx4oM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9452
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDIzOjUxIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
PiBVc2Vyc3BhY2UgYWNjZXNzZXMNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBVc2Vyc3Bh
Y2UgYXR0ZW1wdHMgdG8gYWNjZXNzIGFueSBrZXJuZWwgYWRkcmVzcyBnZW5lcmF0ZSBhICNHUCB3
aGVuIExBU1MNCj4gPiBpcyBlbmFibGVkLiBVbmZvcnR1bmF0ZWx5LCBsZWdhY3kgdnN5c2NhbGwg
ZnVuY3Rpb25zIGFyZSBsb2NhdGVkIGluIHRoZQ0KPiA+IGFkZHJlc3MgcmFuZ2UgMHhmZmZmZmZm
ZmZmNjAwMDAwIC0gMHhmZmZmZmZmZmZmNjAxMDAwLiBQcmlvciB0byBMQVNTLA0KPiA+IGRlZmF1
bHQgYWNjZXNzIChYT05MWSkgdG8gdGhlIHZzeXNjYWxsIHBhZ2Ugd291bGQgZ2VuZXJhdGUgYSBw
YWdlIGZhdWx0DQo+ID4gYW5kIHRoZSBhY2Nlc3Mgd291bGQgYmUgZW11bGF0ZWQgaW4gdGhlIGtl
cm5lbC4gVG8gYXZvaWQgYnJlYWtpbmcgdXNlcg0KPiA+IGFwcGxpY2F0aW9ucyB3aGVuIExBU1Mg
aXMgZW5hYmxlZCwgdGhlIHBhdGNoZXMgZXh0ZW5kIHZzeXNjYWxsIGVtdWxhdGlvbg0KPiA+IGlu
IFhPTkxZIG1vZGUgdG8gdGhlICNHUCBoYW5kbGVyLg0KPiA+IA0KPiA+IEluIGNvbnRyYXN0LCB0
aGUgdnN5c2NhbGwgRU1VTEFURSBtb2RlIGlzIGRlcHJlY2F0ZWQgYW5kIG5vdCBleHBlY3RlZCB0
bw0KPiA+IGJlIHVzZWQgYnkgYW55b25lLiBTdXBwb3J0aW5nIEVNVUxBVEUgbW9kZSB3aXRoIExB
U1Mgd291bGQgcmVxdWlyZQ0KPiA+IGNvbXBsZXggaW5zdHJ1Y3Rpb24gZGVjb2RpbmcgaW4gdGhl
ICNHUCBmYXVsdCBoYW5kbGVyLCB3aGljaCBpcyBwcm9iYWJseQ0KPiA+IG5vdCB3b3J0aCB0aGUg
ZWZmb3J0LiBGb3Igbm93LCBMQVNTIGlzIGRpc2FibGVkIGluIHRoZSByYXJlIGNhc2Ugd2hlbg0K
PiA+IHNvbWVvbmUgYWJzb2x1dGVseSBuZWVkcyB0byBlbmFibGUgdnN5c2NhbGw9ZW11bGF0ZSB2
aWEgdGhlIGNvbW1hbmQNCj4gPiBsaW5lLg0KDQpUaGVyZSBpcyBhbHNvIGFuIGV4cGVjdGVkIGhh
cm1sZXNzIFVBQkkgY2hhbmdlIGFyb3VuZCBTSUdfU0VHVi4gRm9yIGEgdXNlciBtb2RlDQprZXJu
ZWwgYWRkcmVzcyByYW5nZSBhY2Nlc3MsIHRoZSBrZXJuZWwgY2FuIGRlbGl2ZXIgYSBzaWduYWwg
dGhhdCBwcm92aWRlcyB0aGUNCmV4Y2VwdGlvbiB0eXBlIGFuZCB0aGUgYWRkcmVzcy4gQmVmb3Jl
IGl0IHdhcyAjUEYsIG5vdyBhICNHUCB3aXRoIG5vIGFkZHJlc3MuDQoNCg==

