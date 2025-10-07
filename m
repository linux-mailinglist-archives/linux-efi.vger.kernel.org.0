Return-Path: <linux-efi+bounces-4980-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A52BC246C
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 19:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF3D4019DD
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1893E2E8E07;
	Tue,  7 Oct 2025 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsewT+GP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473F2E8DF7;
	Tue,  7 Oct 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859014; cv=fail; b=IJko7Kwt3qO1EJU9tI7kmtbV3hhMnMNqGqTVHfyjBrqUoqP11eALNcCsqhvOZymcurlNYFLERb4sAtQ/7Ma4xQOEg0PuaS+6N/cHy6MYCOlA52/rMwVj8uZZo5bNpgz2/sWas+emzJF7l2mpoEc2Xp0fUZYu/moGEfpPkAZlvHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859014; c=relaxed/simple;
	bh=M/ySDGMSD7iSTgOq5Nw3O5sgA+FAXZRbtTy1chGURXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oMIga74Jo6YAtvRe2DojarcrdeTy5taf61QtVtKN08ljS60SJklKbIQvgG2UQwlWX4mHmDjjeys9c9jetm855wnm4Mo29AkFpK5URQ+OKOZevNwTXfz4spP7WusPcdow+riaJBJMKAwt209CgZs8cOXCllZJ1aOfQqwDv500pJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsewT+GP; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759859013; x=1791395013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M/ySDGMSD7iSTgOq5Nw3O5sgA+FAXZRbtTy1chGURXk=;
  b=GsewT+GPzAH8Ahc/sLqRWygo6NwXu86mRX8k+wT5PhqJcE/5NSQ/OoR0
   goA5sQdt6COT9Oz3wKY6EVGn7JMygZHH2AlCXTuot3QvqYiLOUVQw4a69
   7tyy7n+NiXR6E71vpQsVY6a0LJ9d7NiKHWnlg3UuuuvFy1n0JRNqWWmYI
   GgH0+YzQ4sADmCk211VYK1PYmd11sMH/XFHJ6TEnmo3gGVUHQbaDS+U1G
   +rRkhMmRnfdGPTSbupNVWXepZk+yQaoY396gpqKhsDDEwiIzn/OuBlRfB
   fptttDwZ1WEFyWhHNseyUIVdLGRTUyjFsW65GNcsiy6V0/i6TGCysTIts
   Q==;
X-CSE-ConnectionGUID: yn6G5w00SQSoMjARZNdt2A==
X-CSE-MsgGUID: AkYDodTWSXa0OvMF45oxRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72308066"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72308066"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 10:43:31 -0700
X-CSE-ConnectionGUID: ca9GVG2sRimMELxlR85rtA==
X-CSE-MsgGUID: +iUqo2WsTXWiG+uNuMp1Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="180148426"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 10:43:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 10:43:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 10:43:29 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 10:43:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9vHDNoPIkkg8i4jKO5zJZPrL2r3XqSXpBZq+u+nQh1P+NiJJEg4i5kHnjocClMh2VVFW4UwJFASqnoO+a3vf7+vGJja75PVYYefGMwmtwJT0TRdvrQnO7hNDYHWR6dYXd8D89poycIQqHe2x1UwdMkJu2V+aWnVSYlPnY3DmupVDPWDAveF5Dd64xVbvDLj3KrAmdG2dUpZINT5DCPswTEeYZ7iRx9fhLGmjoopz7Mj6H/cYK+cNVfUlG0k+c1J9pSQ77nEew/n7jTW2UuiGZYxrlcuuRUuHYe35gCtT+S/HZyTLF/+P3atgiFYgeAw0Xc4a66lxIAvfyZdYPlVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/ySDGMSD7iSTgOq5Nw3O5sgA+FAXZRbtTy1chGURXk=;
 b=nTbhtIm7EZxMnc7p3RfoEiNyxGbelvXQW9PP6cYi2k1eGbJz8I9OYrMv/2HqeT6PmKwQ93JSJgr7JC11gXSpjPl9gyIlYOA5WbBYGamdYHeGdM8ndNgavwFaGfWYK2ajk5tMlN52WIy6LPUGXTsXzD6ly25VVA+JT0LaYryKGLzJV1HQWm59xVTLFtVe6GcQxdFYWMtKf5tdPnKFXsQTJI4s7a+vDCfBOKgW3adORbHK58mvJdgAXPr9Fv8M0uyjdWuDwWgq2x+FZATzHMek9xOUa7mvfDmEB41ZUIDZMa6RwrualeUs4xfMVqKnDLMY/P8jiIFYVWrUW/X6GYgiuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 17:43:22 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 17:43:21 +0000
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
Subject: Re: [PATCH v10 07/15] x86/kexec: Disable LASS during relocate kernel
Thread-Topic: [PATCH v10 07/15] x86/kexec: Disable LASS during relocate kernel
Thread-Index: AQHcN1cw1iifwbsLkkexwFTCfMQ1QrS29Q2A
Date: Tue, 7 Oct 2025 17:43:20 +0000
Message-ID: <91d9ea3cc16bf76e682b43f6b0e3f9d53dce7724.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-8-sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-8-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ1PR11MB6083:EE_
x-ms-office365-filtering-correlation-id: 20747df2-c64e-47fb-b389-08de05c901cf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dmdkQU9ScFN4NVhLaUZ1UUhSR3FXK3JhMUc1cXJTRzFhU0VCc2VTTlh1Qkgr?=
 =?utf-8?B?djFhVldGWUh3ZWhzZERNTDJzR3NGUDVFaU5ON2pCQTlsdHdjYng1M0tweG90?=
 =?utf-8?B?UWxEeEVCWXU4MnhtOHp3Yko3Y2JxKzM3bnJHYVBnaERrL0ZGSlM1R1psM0du?=
 =?utf-8?B?ZFlGT3ZuaEhWSElzSFArQUFGdTNHQnB2ait3SXFnOTFZTDR5eGFFakMrZGEy?=
 =?utf-8?B?KzByL3QwK1cveWx3YlpMOGpsM3JzV2w4bkJMZFRJaG1yclRXQ2hSWGhrT0h6?=
 =?utf-8?B?OWNXUmxMcnB0aE5wMnl6MVN3M2tMUEpqYW9lMFlTc2FZWGVQVERHblZhbFZl?=
 =?utf-8?B?T0tKMTdpbzlHdlVtMnZLaE1Ma25xYXVUNDZYaDhpaXJnZ09OdzRBU2ZmWUhG?=
 =?utf-8?B?TUFwS3Fvd3dCMG94Y0NmRys0Y3JTbEV1MWw1M2pUY29vVTI3TWNVVzVieFlJ?=
 =?utf-8?B?M0dMM052ZzM3MEgvMkVkK3dBYkljYUZNRkVGWHBWOVYvZ3pSVDU0dEtLSEFz?=
 =?utf-8?B?MngvWE1LTEdJQ0IvRkt5RTdwdE9ybWR1UDFhdUpBUHFOTFUrZnlIY0RoU1do?=
 =?utf-8?B?N3dlaW1zNXo2OC9pNXJXd0JYVG9rWDVlVGEvSGVOeWNBbzRMMnQ5OFF0T1Q1?=
 =?utf-8?B?dzdDU2JWcTRZOFNsZktQT2dTNmJyT04xaXcxaDJZZzlORzVtcmRIeGlUNlhS?=
 =?utf-8?B?eHV4M2Z3a0xQUFlIRWJTMGM5SUIveGZDbFNaazdKOXNjOEx0ZElvQ0xMSkFq?=
 =?utf-8?B?Wm53cE1XbVltcXJ2UlJ1QWZ2U1RTdmxmY1JBMDkvSnA1czBUSkp6MFFmam9Z?=
 =?utf-8?B?dzYycklCQ1BqZ2MxSm00Nk4yZ1kwMSt2QXpZQlJwWjNPaENvTDAwWmNPeTNz?=
 =?utf-8?B?QllWYldJMDg4RTZaS0NwcU5oeExEd3Q4VzF2MjNRbm5TSHlxZklGam9VdjRM?=
 =?utf-8?B?NnBQVlViT3JobTYwR1Q2bjhYSFlXc3FBcWd1YUsrWEpQQXJRT3VpbllGeUVX?=
 =?utf-8?B?K1NiZnhRcEFNT0IvKzFNclZvTnd5OUJGSUc2RHR3QUx4dWFxNDVvb2p6K3dk?=
 =?utf-8?B?Zy80WURXUkMzVWFleE8xV2h4OVd2Z3B1TW1YdllhRnZab29BYVlkd0Zvaytk?=
 =?utf-8?B?TXM5WFA2a09MUnlIcVltZFhXVTdYemRhbzY1QjhWNFdhL2JUcWtidGxXazJG?=
 =?utf-8?B?MFhtb1dobzdtM09sdWZRbUppSzNZWDIrb3VGRnhVVERvTm5iR09iQ1FoR0Y0?=
 =?utf-8?B?L0FsSE9tSVF1MkJ0RVl5WTV6cExuMStOWnREcFZGWDN4ZFlVT1BQTnRFRG9y?=
 =?utf-8?B?QmZnSFBWbXBpNW8xUWhZalVETGFuY3RTY2ttK1d1d1ZNSWlodk1tTjJkK2s2?=
 =?utf-8?B?dTYzTis3bGJBeTd0ZmJRaEdaMzhyOWs5TDI3VGpTZkdGcmJXQVdCLzd4aVli?=
 =?utf-8?B?ckg1VjFONDJicFlpVUZqYlVmclRDN3VmUkkxOU1ZT2pnSDVRNHVCUmd2VEpo?=
 =?utf-8?B?NUVsNHJyWHZNaDV5dUdaWjRTWm1XTzVMZjVaYWVSaGlwM050R1NKVGNVdk05?=
 =?utf-8?B?R1dQZGdOM1NkTWxEeEc5dW5mQW9hT2hIL09SMzE3YnlOMGloaktxZ3F3Zzg3?=
 =?utf-8?B?K0dTRFcxeitTUW9EbnIxQ2p5RG5LTmdldzQ5VjYrNmJRUWZzRGxMZ3NlUmlS?=
 =?utf-8?B?dEMzUitiSjRjTmlHYjNKb25kaktzUTBIUEsvalp3R002TDRyb1Y0SlpDVnNY?=
 =?utf-8?B?bWNvR0lKbmx2TTg2QlhETXRZSFVNeDlpcmxDVlVUaWtwTGF3ckMzR0s5ZU9L?=
 =?utf-8?B?a2F1RXM2dGtiVE1FVFFlRXVUWU4vV1BVbzNHTUNKc05KY3ZXRVZ4NGpUdHli?=
 =?utf-8?B?b3RmMEpqM3ZhU1VGQ05lelk0QWtmSEpwRjVicVlUWWtLZnhwZExBdlowYysw?=
 =?utf-8?B?K0Z0dFdVaHNvVXpwM0hRRnBuMTV4b29rQ2sralFReXlCU0Yxa0VNNWZuTi9G?=
 =?utf-8?B?ay92enljcndUaTFDaUFVZXlGa2Y3NG1VUHFMNWZZUWJiTWNscjlxY1BtUkxa?=
 =?utf-8?Q?L6aKHn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlpuRW0ySi9veXdjaEZWM0tMTytzNGg0bzRORUdrR1ExQnlQaHJFU0xRd1ov?=
 =?utf-8?B?dldRVExPRVlvaGdGKzdac2hvejAxUXQ2VVg2N2U0U2RkUW43RG1hcndEdGpl?=
 =?utf-8?B?K3dKTHNDSWtUL2YwUFM5TGkxMWxxdVg2YmF5bDhXZGNkL3JXUUFNaFVjSXJl?=
 =?utf-8?B?RFhBN3doZEpJa3pldzIwbk56YmhES2JuYzJPN2Frbm9RMXVPdU1BTWxpSCtL?=
 =?utf-8?B?WktiWCtuOXdCSjQ5R0s1b1UxaVZodjJwa0V2Yy9VN1hUVnBLcXpjbGVUNlUr?=
 =?utf-8?B?ckdKQVAwTDZidmtCc0dLOEYvT3ExTnFZNGp2MEJqQituc0hKaHlYNXY4aWQ2?=
 =?utf-8?B?RWhMUEovVEtFZjRzQmZNZDB1blZSaVRCd0NoVXhNU25BRnp3cjNEU0kyRnJv?=
 =?utf-8?B?MzdBYURRcjJ0Q3Nod1pqL0s5YTE1a3orYVdUcmlZWGpaMmhFUDJmZFNtWkh3?=
 =?utf-8?B?bVRNK0dXTEh4L3QzWGo0bE10eVBHVmtLRHZjRzA4UVdsUlRmbzQ2WmdwQ1Jm?=
 =?utf-8?B?Z2Ezc1pVOXF4NVU4TEJ0bTJTc09BdlN5VHNRMTVQYmZNNEsyN1R1RTIzOVl4?=
 =?utf-8?B?Q25DZ2Y4MWxrZGJjcjM2czcxOWpvaTFjWENqMUE3TW5oSFR5T1cxMjhzanZQ?=
 =?utf-8?B?TG94Y0dlWnJabHIxWmVzdlYrY011ZXZGaGZ3S0o5Z21laWpmcmZkVTJBQ3dZ?=
 =?utf-8?B?ZXdrVlBpYU4valFGUkViMVpYSzBoT0tWTndpOFJ2UzdUcWM1ZVBodExlbUt3?=
 =?utf-8?B?ak42c3hQWjVyM2E4OUk3aDlQRFJ6eEVFMjRETGxVc2xTRDFldDdWVGRWK0Fl?=
 =?utf-8?B?cTVzZU9vT3hYd1hDSW1PKzNSNGsxV1Uya2xJLzlpMGc1RUFaZlJTOU9hNmVX?=
 =?utf-8?B?NTdrd0pjK1Y0M1cwUi9JME9NaEoxajA1dTc0c3BITTI5UmptcDVlM0tuR2RU?=
 =?utf-8?B?a0tndmFTdWI1MWhkWFRkS202UmlHT0QzNFcxNjJwRng3aHdwYWVNWDNieUdM?=
 =?utf-8?B?Z1BHM2x0azE5UVp1TUQ2NFptUitBSWdScW91aGl5dEhvWTBLMVNBaTJEdnhB?=
 =?utf-8?B?VnpUK2FwWjZiT2ZsMkVwM1h0TFd2d3dRZXU4Tk96cUFyVTk4VDdDb21QeFY4?=
 =?utf-8?B?VUFXUkk0Z2RNWG15UittUU9iZEoyZzkxSkJPRmlKSktvaTFtYXFRTFZsVit0?=
 =?utf-8?B?aWhVOE1HM2ZnSCtNbW5pT1NYeW0zU0FnZmFNeFBWS3ZxdjdtMU9lNmU5L3ZK?=
 =?utf-8?B?blJIT1Y5aWxPWFlaTDhYSXpMZGwvcVo2bXUwM2VXMG9uNjlkMXAxZ2VmTVVH?=
 =?utf-8?B?RHUza01NMXJlN2NRN2VwTzE4R08wT0ZweDlyaElPSENzNEtFMkVOa1d2cDRS?=
 =?utf-8?B?MllTTzdpTEk3R2hXcjJRTVU4ZlY2NkcvOU5DV0hCUmRxYVZzYlNicDVWRGEy?=
 =?utf-8?B?YlVKcllDUjkyb0hISXpVRVlLVlBYZm5hRENNblNuN3dhRGlteGMzc3pHZEh6?=
 =?utf-8?B?ZEd6cnZqVW9Rb1NReUtzNks5SHRqdXBuVWRkZk02OUh0THdOYXRtTlpaT096?=
 =?utf-8?B?N1VkcHJiRmpkblMxVy80ZHEyMFpDUE5vTy9yMlBsa09QSTMxSWVYeDd1eUtI?=
 =?utf-8?B?YnhHUnBxSGZ1bEJyckZ6bVZxUU1TdHpDVmUxSmdUZGY3ZVcyYTRmSDR5NEpr?=
 =?utf-8?B?alViTGRHMDJwbS85WVFpK2M0WkVGMjlxT2JiZkQ4ZTNSTHJ6clArWVpid0ky?=
 =?utf-8?B?YllVTGtUbGVxQ3Rya1NjTURtaXArZTV5ZzRsOC9UNTQ4VTZxNFZxbTUwR2ww?=
 =?utf-8?B?R0hxbldweFk5TEJkMVRiL0pLa2JGNW9KVUJXZUtsdU04OEhxdFlKVzhtOG5S?=
 =?utf-8?B?aE1ZdkUyWXM3ajgyaHZiWlQzNEZmOE1waEtnUlN5T2dhc25mV0lycmJXNWtN?=
 =?utf-8?B?dzZWS2xEWFM5VldxNW1Od1FXcXZkejhkb3JNazhCK3QreE5RTFpZMDZTUVBo?=
 =?utf-8?B?MGRXZDJaQ3ZkSG9Wc2IrNWc0djdoOWFmN2ZSc0RWcHRmYnZZak5landKc3M0?=
 =?utf-8?B?eUFHUlhtVE5EWXhSQTJTQS9xakhFRkJObUduZFdSQ0drTWVaOFltSTUyUTgy?=
 =?utf-8?B?NTZKRE1rUnNmWmhHMDloM201SytPdVZYS054NTdralRSMThIOGpwVksxTEMw?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B99E61E7B7432E4693B277AD2E3F16AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20747df2-c64e-47fb-b389-08de05c901cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 17:43:20.9959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYEKF4EkorPNC7wCz+8M6AN+MXdqBW9cvEbFwft1S1ci+Zc8MyeTTXrOz4/5qkEw4GwAXp5HC9JVtuBhRx52EgMbuloLA3XnXbElmWZuYIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDIzOjUxIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
UmVsb2NhdGUga2VybmVsIHVzZXMgaWRlbnRpdHkgbWFwcGluZyB0byBjb3B5IHRoZSBuZXcga2Vy
bmVsIHdoaWNoDQo+IGxlYWRzIHRvIGFuIExBU1MgdmlvbGF0aW9uLiBUbyBhdm9pZCBpc3N1ZXMs
IGRpc2FibGUgTEFTUyBhZnRlciB0aGUNCj4gb3JpZ2luYWwgQ1I0IHZhbHVlIGhhcyBiZWVuIHNh
dmVkIGJ1dCBiZWZvcmUganVtcGluZyB0byB0aGUgaWRlbnRpdHkNCj4gbWFwcGVkIHBhZ2UuDQoN
Ckl0IGNvdWxkIGhlbHAgdG8gZXhwYW5kIG9uIHRoaXMgYSBiaXQuIFNvbWV0aGluZyBsaWtlLi4u
IFdlIG5lZWQgdG8gZGlzYWJsZSBMQVNTDQpiZWZvcmUgd2UganVtcCB0byB0aGUgaWRlbnRpdHkg
bWFwIGJlY2F1c2Ugb3RoZXJ3aXNlIGl0IHdpbGwgaW1tZWRpYXRlbHkgZGllDQp0cnlpbmcgdG8g
ZXhlY3V0ZSBhIGxvdyBhZGRyZXNzLiBCdXQgaWYgdGhlIGtleGVjIGZsYXZvciBnZXRzIHRvIHZp
cnR1YWxfbWFwcGVkLA0Kd2Ugd2FudCBMQVNTIHJlc3RvcmVkLCBzbyB3ZSBuZWVkIHRvIGRpc2Fi
bGUgTEFTUyBhZnRlciBDUjQgaXMgc2F2ZWQuIFdlIGFsc28NCmNhbid0IGRpc2FibGUgaXQgd2hl
cmUgQ0VUIGdldCdzIGRpc2FibGVkIGJlY2F1c2UgdGhhdCBpcyB0b28gbGF0ZS4gU28gZGlzYWJs
ZQ0KaXQgYWxvbmcgd2l0aCBQR0UuDQoNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU29oaWwgTWVo
dGEgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4gLS0tDQo+IHYxMDoNCj4gIC0gTmV3IHBhdGNo
IHRvIGZpeCBhbiBpc3N1ZSBkZXRlY3RlZCBkdXJpbmcgaW50ZXJuYWwgdGVzdGluZy4NCj4gLS0t
DQo+ICBhcmNoL3g4Ni9rZXJuZWwvcmVsb2NhdGVfa2VybmVsXzY0LlMgfCA3ICsrKysrLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TIGIvYXJjaC94
ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TDQo+IGluZGV4IDExZTIwYmIxM2FjYS4uNGZm
YmE2OGRjNTdiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvcmVsb2NhdGVfa2VybmVs
XzY0LlMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TDQo+IEBA
IC05NSw5ICs5NSwxMiBAQCBTWU1fQ09ERV9TVEFSVF9OT0FMSUdOKHJlbG9jYXRlX2tlcm5lbCkN
Cj4gIAkvKiBMZWF2ZSBDUjQgaW4gJXIxMyB0byBlbmFibGUgdGhlIHJpZ2h0IHBhZ2luZyBtb2Rl
IGxhdGVyLiAqLw0KPiAgCW1vdnEJJWNyNCwgJXIxMw0KPiAgDQo+IC0JLyogRGlzYWJsZSBnbG9i
YWwgcGFnZXMgaW1tZWRpYXRlbHkgdG8gZW5zdXJlIHRoaXMgbWFwcGluZyBpcyBSV1ggKi8NCj4g
KwkvKg0KPiArCSAqIERpc2FibGUgZ2xvYmFsIHBhZ2VzIGltbWVkaWF0ZWx5IHRvIGVuc3VyZSB0
aGlzIG1hcHBpbmcgaXMgUldYLg0KPiArCSAqIERpc2FibGUgTEFTUyBiZWZvcmUganVtcGluZyB0
byB0aGUgaWRlbnRpdHkgbWFwcGVkIHBhZ2UuDQo+ICsJICovDQo+ICAJbW92cQklcjEzLCAlcjEy
DQo+IC0JYW5kcQkkfihYODZfQ1I0X1BHRSksICVyMTINCj4gKwlhbmRxCSR+KFg4Nl9DUjRfUEdF
IHwgWDg2X0NSNF9MQVNTKSwgJXIxMg0KPiAgCW1vdnEJJXIxMiwgJWNyNA0KPiAgDQo+ICAJLyog
U2F2ZSAlcnNwIGFuZCBDUnMuICovDQoNCg==

