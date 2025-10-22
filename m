Return-Path: <linux-efi+bounces-5087-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEA1BFE1CB
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 22:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B2314E5683
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCA02F83B5;
	Wed, 22 Oct 2025 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALyugJbO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29582F7446;
	Wed, 22 Oct 2025 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163391; cv=fail; b=t1AsCt6YfIBz1qmLXrVgGHBIH3akEI0diIQnrmgtES7LMZvGy4c0gEV6pmpG3TTuG77+qwUQCBNEgxq533G+3Z5ML0KtyR4nxfyq/E4OcJuOW7BZ6J9Ue5x9FnOwDRheTiOCDecZIRklp6DZT/wPEfmrdtFsVwLPfFE+NGs89BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163391; c=relaxed/simple;
	bh=IydZbdK1bEoznsxAaN7pxK5hlm/5zKfENejqNowyUq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g/RH0CYNOqYevcF/VTSX7FNDdciCpaR1MHwR2aoqGQM0iARlvz+3dvaBqYr0feNl3ALAIjxYv1e378Rv6i6ttmjcsVeVlTtSdcHoQuH4wdtCn7tstl10sxiNuF0z9W5gOTMdEk/J1VoOBNEZXtVuKeKbuv3Me5DvwHIifnmlF7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALyugJbO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761163390; x=1792699390;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IydZbdK1bEoznsxAaN7pxK5hlm/5zKfENejqNowyUq8=;
  b=ALyugJbOcr+vJSumkm/OFTHw3zPsGdclV6CEfavhRdPYjKc2H5T14GEw
   OvGB9YDsHiSJ5E97HheVx2xy0+vV7XXEW9hX8gSkCmb94nOhephb7W1vN
   FHKRzrwYUggVJKH0Eiq7ey67GtJ0DAMAlz87jPeXbWUKtVtjOOLYq3DNe
   Cxe0A8GHpk5+hlW/+4SQwcLmxZfyvGxq6sJP37t/UL0cUmD4dbNykubWk
   10qJNktEKeOU7sh2kqcYU+43CErc6e0EBAWD36yPYLob0r1AlNu24Hoia
   CSqEgsYKCMJ0DazoS410YTYyHYzLusNARgcpFkM9+fzbunRe54xWi+Mqx
   w==;
X-CSE-ConnectionGUID: +LhL6Br3SJKNdYtgaGachA==
X-CSE-MsgGUID: m7yNre4iTf+8DdVJMCuSKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67159912"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67159912"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 13:03:09 -0700
X-CSE-ConnectionGUID: IEmKyxR0S5S9Ye909xjDaw==
X-CSE-MsgGUID: V1uWnXyCRHO6yeNnJV9OXg==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 13:03:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 13:03:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 13:03:08 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 13:03:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7+ZFRzGG+Y30Po6BqMyaP6pzFyLUCqHsF08IhuZ1vkWqFeMManosg9LOnorzy1BN8Tvwk5Anq8OYbGuce+D0lj7kiSEcaYU4UmqD6U3oaLKPgJRQdBUGHopChDkW3ZivO0vFhgXCx3pYBE4P1W5PPp66YJ1O+xqdFo+6ltYcSqkm9dzMaCQ7lQegacOqpy9RTxKD32OPRPFqJdN7Ggx3Dp2Yb0o1CNNfTXZU3iEO7K+ZDWSMnNSb6NjrveQ8feiM5oR9sz2lK0zGIB7PsMbt59UH0gDEmM7ALl4hHsvti2+nU0ZoBDN97bqnC7oOGET4kI9gQ/C0X6dXNwK5tkY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IydZbdK1bEoznsxAaN7pxK5hlm/5zKfENejqNowyUq8=;
 b=eq6LWjJzKcYsG1KMRXGlzFmimOBScsK5a0lfTo5qxypP3Umx6xUiTBSfg6+qm/P3tepKM3AsJehi/H0iK/z5M5qmfbNkHyTqucNcHJzrnXdpEECT5BDYpUxoOevojgW/6PJ691vr25M11+G6lGroX8pzprGorN5YOf0xFZZHmDZmNb+eu+exgSbEoJoTncqIIRvuOnc3oYKh0jidtY5ptWQcakzlmkRw0A/x8JXx9xWaBqZxjDUiZINTdFzRQH0/0jopl6zCzwbYfvjKLBLMM60Il7WowIDgp/2xuIvWylP+pRMZ2nVh/tDCh1iOeFcYca/ra7NP8TY48MsDNCwMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 20:03:05 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 20:03:05 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, Borislav Petkov <bp@alien8.de>
CC: "x86@kernel.org" <x86@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "H . Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Kirill A . Shutemov" <kas@kernel.org>, Xin Li
	<xin@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>, Sean Christopherson
	<seanjc@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Vegard
 Nossum <vegard.nossum@oracle.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, David Laight <david.laight.linux@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>
Subject: RE: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Thread-Topic: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Thread-Index: AQHcN1cvJk5gQzxSEk+bcar1Zred8bTNHNkAgAAOo4CAANo9gIAApZwAgAAC1YA=
Date: Wed, 22 Oct 2025 20:03:05 +0000
Message-ID: <DS7PR11MB6077262111C66261BFB4D676FCF3A@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-4-sohil.mehta@intel.com>
 <20251021200328.GMaPfnEDibnBrhNTmQ@fat_crate.local>
 <144029e3-30ea-4e94-9afd-4da53ce4a657@intel.com>
 <20251022095657.GBaPiqaYxPMonQWLtw@fat_crate.local>
 <34d91e30-9a94-4bbb-9a57-3679afbede2e@intel.com>
In-Reply-To: <34d91e30-9a94-4bbb-9a57-3679afbede2e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|PH7PR11MB5983:EE_
x-ms-office365-filtering-correlation-id: 021f5591-bcea-4e2e-ff01-08de11a6039c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MjBZcndNdXArYWcvUjRhRS9yVHBPYWQ1aXdFNXp6WmdzNXlZR3lKN0ZMVyt2?=
 =?utf-8?B?MElhalZwcCt5QjVpYVJhNWhmcG1mZ1dPN3RHbHVCcEg2S3Roa3hOSDViMGNW?=
 =?utf-8?B?RVo0NFlRdnVhTDcyZE11Q3dQQzFONkRMOW5jY1BWSDNhYkR2UmExaTNETXYv?=
 =?utf-8?B?OFJ6Ri9jSFN5SWl3Q2p4VzVxcFBZNjR0bjdPLzFrT1VkM2JuL2d1Z1QySS9h?=
 =?utf-8?B?eEJnRzFWbStjZktkTHAxTDJzSTZqVXh2Z3VEMHpDU3dxbEN6c3FEZzdCNmpz?=
 =?utf-8?B?WU9tT0dSWDhlbk5UaVVJOWt0dkdhSHpCSGdLZ3JRbi85UGhoWTFjU1pMT1hN?=
 =?utf-8?B?RUkyb25Dcmp2ekNkckM4VXNKNmgvWi9aOVJyZFJURStWRnIyNTQvRW8rT0Ro?=
 =?utf-8?B?WjcwNEVESXh0NW5qcWxINEdFR2sxV04xUE5EYjFKSDc0VE96Rm1CSDdxVWU4?=
 =?utf-8?B?MUZBTmxvMmRBZ0kyVjUzdnNvZklocFp3MEMyYkI1MTN5UTl2V09xaWk1L25S?=
 =?utf-8?B?aWxzNmpCSEpuQ2hpeEJnbmNCVHNQRU9qNlFQV2RXdTRhUEZVSnVoeCtJLzBY?=
 =?utf-8?B?TjVSSUd6UW5rck9paDRMRE5Hbm5YbTI2bGxLUnBsWGZLNWN0OFpteGF3TXlO?=
 =?utf-8?B?T09iblVHekU3UVUzTzA2UFZ3bFpReDl0NkROM1p3ZkFpUmhZZTBBdThLOGFS?=
 =?utf-8?B?N1N3NHFaNUJGbUJpMEplUFF5NGZ5QWcvL21jTmZCWmhlTFBKYXRmdXVkVitJ?=
 =?utf-8?B?QWEvUHRDRFRUaXJ1NmRrQ2sweFpQSEdKV3FSc2Ewb0ZablpkTmh4cVhMdE1I?=
 =?utf-8?B?SksyL1FVQllodjNGR2wwaXRGSUhIV0FvNWJ3MkprSFJEblFoekNBaGowV1k0?=
 =?utf-8?B?ZWFHTFR1WVVwM3BaQ29ZendRSkptdWpXcnZGMWhXWnJiSmhpbjBDNkxodXFo?=
 =?utf-8?B?MEZUSUVVVWNRY3hldjkrM3o2eG1iMVRqV3lqU05hWWl4czA2eWNQUGFQSDNC?=
 =?utf-8?B?WnNpZGpMM2VnSVQ4c05xaFBneGNIZnNWb3VkdTRtL3UzQTlnTWkyR0tVNjRj?=
 =?utf-8?B?YllpZWZ0S3NDMVF1QTFkOCtTdU9icU1MSVJScjAwcWZsUEZJTmRFd3hsTVMr?=
 =?utf-8?B?MXFJV3NaeDlHcVR2MWtJeGYyTEYyNytkWThvd0NTa3VGY2RVSUExaXVvNVRp?=
 =?utf-8?B?MXhFS0VYMnVzZTVqMjhPcGhGMG5RejhnMUhwYzlDeDhkOGtUWWZVU044UUlt?=
 =?utf-8?B?WjNxcFcrdlJMMnVnalk4c1RYOHUydkdCdmlrQzUzUHRrcWFYSXJnK3lEdHl5?=
 =?utf-8?B?N3pDWmRHOUxLZ0NkS016bWQvUFB4ZWtFRnZJR0lSNU5hYUtaUk9uMjJwOW9j?=
 =?utf-8?B?ajhLMGEwWjMxVXM3OW14RVY1d2FkYUJuSHdWNndveTNSRGtPOUtRUmkxTnU2?=
 =?utf-8?B?bVNLZFlLRmE4M0E3S2xNZklCUldNOVhZRXRjY0tqVWYzenNOUEdPdFFaalBW?=
 =?utf-8?B?Y2ppMjE3QUlselBwRTV4NXNxVGJmS0hpU2E5V2dudVV2SDdydlUxM2dYZ2Jw?=
 =?utf-8?B?Qk9uYTVJbFNsZGR6K2hZcjdIeTljb0hMTTdPNHh4eE52VzZvV3lHQVpHbUFR?=
 =?utf-8?B?R3ZuT3E3YUpLc3NqSWVXaUptN2NlbWdqZHNodFpsSGx5cGpsRjlpUGF3clIw?=
 =?utf-8?B?bXkwcUtCTkdueGk5S0FNNzZzeVdNdS80dGNhUlZCdnM0VWM0VXF2T3hQSXFs?=
 =?utf-8?B?djB0aWpMQ21BcHl0aHZoeExHK1crWFpSV20wdXpKNXJuZ0krTU01WkVWNWcy?=
 =?utf-8?B?d2dSMk5BTkpLeC91TmxkR0w5aFZkWG9NRys1T1BTVVhobVdKU1YxdkVXbSsz?=
 =?utf-8?B?VlpNNHc0NmVKb3Y5bGxGc2hoS3NNSXhpcVc5b3BQZ1JwSzJGUzJObFMzV1l1?=
 =?utf-8?B?WTZvMENKYWhDZ1hQRUcvZ25VWkgrR1Y1NHowRWxqTDdGNnE5NEREM1E2M3RM?=
 =?utf-8?B?MUVtSFpRdkNVbWJ3VUVRTm02cDNDRCs1R2RBUkY2L0ZBVjRiSURDaktUS2J3?=
 =?utf-8?Q?HZ3PFT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlZNL1czMFFHMFhxa2tYd004STNaMUJ4QjBJVzdYRXBEQmFXcWgwbFZXbGlM?=
 =?utf-8?B?NmRtSXYwVXRlZVRoU1FHVnRCbUhPSGdQQXhKM2tabTIzSmF0d3NHUk1mQnZy?=
 =?utf-8?B?TzZHVkFIYy9DT0o4Z3FDcHhHUVErbzF3ZjBOdmw1OFE0dGlXVGtMZnVYSmdQ?=
 =?utf-8?B?ZEFjMi9ZZ1hoT3d3VDFKc3R0SUxyYnduaTAyL0lLZjhVa2Jlem94NzBiWEpz?=
 =?utf-8?B?RlovcmJqRkJ5eU9KRUx5bU14QWhwMEZmcEFtNGVDWkR0NTM4WEdWZjY4NDJk?=
 =?utf-8?B?cnM1d083UDlRUFkwQTJQb1ZzRVQzT0dxR0t1akJtZzd6MlRBVUJRMWxBbmIv?=
 =?utf-8?B?S0l1Qm5qQlBDOVNkdHhTVUNMMGpFTTNjSHVSYmpwRU4xOWJUWWdiTXZvS2p4?=
 =?utf-8?B?aUswZVd4OXAwbTFFd0NMdnQxM3luV3loZit2TW5KWkxhQmhxQzdTYVQ3NCt6?=
 =?utf-8?B?TzZjaFFZTDRqWTNMOUJ0UkRqZWFCZ1pKWjgzS3o2RjFLZXZ5SzZLYnVzUDYx?=
 =?utf-8?B?Mnl4SElFOWZ6WmhqdHlpTnRjbUREYzdGbm5VdGNueEFWZFBoeWsyRnA0T0tI?=
 =?utf-8?B?dEh3S3BLaGhKc2htRVBzSFBnU3I2WGVYT2o1RE44aVc0S2dXUnFEYk4wTEFJ?=
 =?utf-8?B?UE9TNFlINWJNSnZIYjJXMytRTk5lYUxQeldJZ1R0UGxiK05xUi9KaHovNms4?=
 =?utf-8?B?Q3ozNzNjR2dHRG1HblNCMkN2Nzh5VDcxME9raGlreXBBSzAvZmxmbmhkQjlx?=
 =?utf-8?B?QVFvVitaZjVMSXN6UmI3UkdLUU5zL3lIRk1xOC9NRW50aWJyNXp5MkhMMUYv?=
 =?utf-8?B?OWtxclhqTTUyMWtVQnFlNFg3Q0hlRXdHaklMTVVFajB5bE1xV2YwejBtTFVD?=
 =?utf-8?B?UkNWVE5WZFVOMEVlNW5tdzl2eEtrZGNMcmZRVGN4U3RmKzd5RkRmUUp6cjg3?=
 =?utf-8?B?L3RaK3BrY0dFbkQrWHRoTStWVFJaSmtac29CWDZlNXlvcTYxdTZXbDRIR3R0?=
 =?utf-8?B?Rnp0N21FNElSWHVtTXBDZEE4am9CcDQ3Si8wRmdNTWZXaitnK2MyZEhpclpT?=
 =?utf-8?B?ZzZvNGs3RVdoNmJOejBGTENiRHVMZzdPV0FsZnIxQWRmdVlhNnpSVG5sQ09Q?=
 =?utf-8?B?KytkcHFVU0xpdG5DOGpvU09aZzNUZkJ4K2kyazFCSTNLdFN6dHBOeXVmL1lZ?=
 =?utf-8?B?azh1SUx1TDJCWlBkRENEQzh0R01jaXE3WGgwckhiYTVFdldKY0hXOXc1SkUr?=
 =?utf-8?B?elhha0ZEYjAydDNSSWc1cFVwWkplNjFBUk1jQ3Byd0Vxb0srR2l5TGFXZ1p4?=
 =?utf-8?B?UVB0c2JQRWVkTzBvZE03Z0RCSWRpNGZMa01jdCtHczd2TTRHcnNNYVg0RC9V?=
 =?utf-8?B?cDJzWWlBakdYRXlNbXFuWmFEK3VMUHhPU2U3OU12OUF1Y1J5dDluQjE2UUc0?=
 =?utf-8?B?NmdoY2k2cEZWc1k1TmFvUTRjNkwzQSsyZDYvNFRMcWlJdm52azNqWW1EdnBW?=
 =?utf-8?B?OC9HeXA3LzNMV204NzdIcDlobUVvSXpTN1lKZXgrd0ZUTXVlaWQ0YVBpSVhP?=
 =?utf-8?B?Ky9uZDZtMXFuSnBOSmgvMFlRdXNXNEVxUFplVzBEMmtwMFFva2pUSEZJTzZK?=
 =?utf-8?B?bWxBMzVTSkIrTXdobmlXYitaTVlMVmxONFhyOVBnRmNiRGpBTmhYek4xdEd0?=
 =?utf-8?B?OVJhUW9HaDdIZW1BQm5YM21hWmRKcUY0eGZiZ2YwZlNxYkVhOFljNVE5NzZy?=
 =?utf-8?B?QmFtQy82RlhGN0ZZaFpoWlYveVRCY3MrK2ZsbnNOUWpSb0U2aFRPd2lJaXJw?=
 =?utf-8?B?a3htRisveGJ5NmpUbmducm94b3l4RXBBL3p4RW44eXVkeXBvTmJFVTF3UzZn?=
 =?utf-8?B?d29oTDV1R1JRVTlNTEdldXB3K1NCcnU4ZU5MYjdiTUt3Y1VtRW4vcU1nVHdN?=
 =?utf-8?B?UDRCekxqM0ZyOXFucU84TzVHZkt5MDRaa1UyeDVLUXlXbThFNStQejhnVXc5?=
 =?utf-8?B?TGpROU9kREhDMkhnRmN4SXBxSUVpbkxWTTJRdFNIUEpCOHREdHVPclFBSFR2?=
 =?utf-8?B?VU5QclRTOVIwQ1hhZ0s1bGQrTnVrbSsrM0VibU5vZU1jTFVrVVRFaTY4N3hw?=
 =?utf-8?Q?5cgXvIM9Gy6W8f3sG02IydBfn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021f5591-bcea-4e2e-ff01-08de11a6039c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 20:03:05.5905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpPEq4roiSgtwLtQCV5PKd/YX+Q6PwzIdd08ZylHLgAUCGfj3UOf6W+ezMWyt4CxvsQyiaOp/MarvhQ10bM3Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5983
X-OriginatorOrg: intel.com

PiArLyoNCj4gKyAqIExBU1MgZW5mb3JjZW1lbnQgaXMgYmFzZWQgb24gYml0IDYzIG9mIHRoZSB2
aXJ0dWFsIGFkZHJlc3MuIFRoZQ0KPiArICoga2VybmVsIGlzIG5vdCBhbGxvd2VkIHRvIHRvdWNo
IG1lbW9yeSBpbiB0aGUgbG93ZXIgaGFsZiBvZiB0aGUNCj4gKyAqIHZpcnR1YWwgYWRkcmVzcyBz
cGFjZSB1bmxlc3MgdGhlIEFDIGJpdCBpcyBzZXQuDQo+ICsgKg0KPiArICogVXNlIGxhc3NfZGlz
YWJsZSgpL2xhc3NfZW5hYmxlKCkgd2hlbiBhY2Nlc3Npbmcga2VybmVsICghX1BBR0VfVVNFUikN
Cj4gKyAqIG1hcHBpbmdzIGluIHRoZSBsb3dlciBoYWxmIG9mIHRoZSBhZGRyZXNzIHNwYWNlIHRo
YXQgYXJlIGJsb2NrZWQgYnkNCj4gKyAqIExBU1MsIGJ1dCBub3QgYnkgU01BUC4NCg0KTWF5YmUg
IndoZW4gYWNjZXNzaW5nIGtlcm5lbCBkYXRhIC4uLiINCg0KQWxzbyBhZGQgdGhhdCBmb3IgaW5z
dHJ1Y3Rpb24gZmV0Y2ggQ1I0LkxBU1MgbXVzdCBiZSBjbGVhcmVkLg0KDQotVG9ueQ0K

