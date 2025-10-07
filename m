Return-Path: <linux-efi+bounces-4981-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A20DBC24B7
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 19:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B52ED35021C
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4E22DFA40;
	Tue,  7 Oct 2025 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3dce75h"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B80C10A1E;
	Tue,  7 Oct 2025 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859195; cv=fail; b=AYRfzPwhdNLzFFeizm3G9qatqxL60FkixACnWDpok9WRPZo8buEqAd4hjfcfa+SJTYd7NbIrVoTHHQ1Gs3nXxAcNChyLIp41kuLhgB81Yk+2n9uVMN5PPPFvYoLTW5RvwGt/34O4Mei3wP1liLVdLb2XUb9UWe9dP6P6FT/vF9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859195; c=relaxed/simple;
	bh=2P2Hzf4bakKWFuDKmP48OGCDWnGdVCicipm3Q24eW1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5n5CQC2+RqT2fXv1Y+hC1o1s8NON6rvbc3TVhqyzKVHRfcOPnS1JqAXn+krt1YKyPC1GVjbN7C8+oqBGH8X1IznP+QOc3cnmuIOM5VY65Ft1UfR/nMvIe3OVNETbT1qN2GKAtOufV0tj1wMopaJPBxc7f7Svh4UX90YxufND54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3dce75h; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759859194; x=1791395194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2P2Hzf4bakKWFuDKmP48OGCDWnGdVCicipm3Q24eW1I=;
  b=Y3dce75hLLuTsrB8e23FlvQdhdnlnRPy7ZLDYXASdwsWqmdcgpvLI62t
   6UJuXbncyUGftAOEvD7wC2NQeVzOYgvdvyN8YROAueSKe8wrxLydYVlla
   YYJxdopDoEZst7BdM16ypa/naJuBJ9OoEpiE1jv2q8xtHEXjPLORwHAlo
   LigvIy52P65P8hpol0It43OS5g2dHel4iu9b3jETjkWgHAxEBLijkkD1J
   PRsYl003eT/wIvIL+SVKdFgkCTSmtgc0ZJO8iR55rokjfZ1vuhYFSDS0v
   wx2cc2u5AXgKjIr87NQ9xvRzhI2b9sAq4fJdbcHDlEV3VWkOhCkibtnPt
   Q==;
X-CSE-ConnectionGUID: yOGq87cLSq6F/2SfKCijdw==
X-CSE-MsgGUID: 3b7+YjQPS/qe8YScTd7dCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72308574"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72308574"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 10:46:27 -0700
X-CSE-ConnectionGUID: hELZRCT3SKiVrnf+Jf77Xw==
X-CSE-MsgGUID: A+tmegF5Q12Guo5zs3DarA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="180259514"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 10:46:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 10:46:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 10:46:24 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 10:46:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fa6dv0H2UBvAkNS3iok3MapzBtDHSoVIPbpvUECzXZPhDjS8hbmF8ufzSdWEzZacdiMqBjb22IToB51ylmH2QkFroDv2A7IWQbE1GPcxKbEKPsB4QTwjMkCf4c8g0NzJ49lsbL1F7O8tsCXLLvTjW9EU8XW+64+I/W93bAjpKrM0iKpy4Mip9Vn39RqLDn7XnugF4+ix5HqN3hXB0tfv9Uhx+77fT3BuScxu/8yNwpLv219iN2T7WT5uCtVnQ6ivy+O0ZrYOyHd4urPzcjWmZjN5ZNIXIMXDw8egSvcZAbKul4k5x8TVfAmAvUbd+mE/HUV/d8TWLmcnld5Tkg4hmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2P2Hzf4bakKWFuDKmP48OGCDWnGdVCicipm3Q24eW1I=;
 b=iSA26DwSrSmlQhKX0HRzktvzAwMfU3ISkSKN2/loXcVHzVKWhxCvwNVTLUbs/bSmoqGUp9RZAZNgU+5yCKhp9B1bmyUi2+WzvuLsIBrVGai3k1JekgE/4LgL2XDSLPnyHDTGifWmBrtEDtgDOsKKVnPabOLKDOwEiz8Kqj8y6DQwNTGAf97NUKbIEMK+/YH3f8bdF3dkyi+/N8fthFUPkkmNxTOfaxNSs7vmjS10cAUdkmWpIgksvROgMFO4P/NcXE1WUebD8lpmLFJd0n02Qf+TWcXQJjmRD4cVpr48o9M4KCpYhwe181ocErovIB6Oi9jNRG45oPmuZLQw0dOfqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 17:46:17 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 17:46:17 +0000
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
Subject: Re: [PATCH v10 09/15] x86/traps: Consolidate user fixups in
 exc_general_protection()
Thread-Topic: [PATCH v10 09/15] x86/traps: Consolidate user fixups in
 exc_general_protection()
Thread-Index: AQHcN1cx4GvzyB6BEU6xTer8KxhLLrS29eAA
Date: Tue, 7 Oct 2025 17:46:16 +0000
Message-ID: <e314fabf0597e3ca4acc549e33fd483e64809dc6.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-10-sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-10-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7958:EE_
x-ms-office365-filtering-correlation-id: 24116ede-309c-4034-fc71-08de05c96ab1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ODJ6OWN5MTYvRzFoTXRTRHB2bVNmSnRubDNka2RRWHVldFJ5WmF5SDY0UmVW?=
 =?utf-8?B?OFFpT1h4UmpENVFmYUQ0TEhUYlRCcDhtWjBTL00zN1FIVFFQUHNxZ1dIRGM0?=
 =?utf-8?B?M1ZSSUV4SC9vWUJmVGVFVUtyZm04L3dJamdXZ2p1V05JeXBka3YzcFpaZVpv?=
 =?utf-8?B?ZzZJSnlBdWFrUVRnaG9ESXhGRGRKSm1UUm1DbVVqRmVzcmNKWlhoQXpvc2FN?=
 =?utf-8?B?RE9yRGxBdjZWWDdSWWh0aTlUYWpnQ0lIRnBMMmVSOU5DNjJ5RnR1MU94TjI2?=
 =?utf-8?B?OFJkTkd3enBXZXg3eVZIRFdlTjFhMlFteDlSRnhJUHBFR04zU2RWYngyRURn?=
 =?utf-8?B?czNaMUVJYmM0Zml5ZjFEa2NUa3FpcWU4cHU4M2pLZVdBSDhaOFMxVXFaWmFm?=
 =?utf-8?B?bGNPUm1MUGNUamV5b0JmbTJDNHcyaFZVMC9ocjZCRk82S3JzZ0pDa25sMkhK?=
 =?utf-8?B?VGpoOWM2VTZVUVhaUHArM1VzQ3RCMmZjZXArY3YySkhYTzhSZ2JaRmtmRndK?=
 =?utf-8?B?ZnFIYUZvaE5aNGpCcnFiZTJsekdRMkdCd2xpRUdJZlplNFdkTkhMN0daWlBl?=
 =?utf-8?B?dHZ1NHdPenFKaXFVZExzRVdaUkdxeUtiekdDRysrWFJIb3JvdGppRXI5TW1H?=
 =?utf-8?B?OTVBWktNc2hXeW9ZRndDdk5nMmhjYWVOZS9mRkNiWWFoS3JwaEp2QVNrYmo3?=
 =?utf-8?B?TVM5YkxvQjhZVit4ZG15dHRLODgveFl6Y2sxeVV1b2RDSW5TWXFiK1RHTHhW?=
 =?utf-8?B?djIvT3lseVlNVURuNUVQNGtpbDlRQVhkNEs2b0xORnpyVnlGTGpBNSsra1FJ?=
 =?utf-8?B?VFdHQVdkd1dTd2tGSVVLZjlFalZZcDdsNFZxOTl5Wm9iVWtVSTlrY2x0RHZx?=
 =?utf-8?B?ZkhJSVVXVlBTcXZpMDdYS1BKbE1XWkVNd2JQSnVWQWdVMENpOExDSXdySEhK?=
 =?utf-8?B?VjJMVGxIMUQrMnlkRDdnMXJDMlJSQk1GU2w1NExYMzZIU213eWg2QUFEeHJr?=
 =?utf-8?B?UkRqY2xkdEpzRU9WSlFqcVdwQjZHN1RIK0pLdWJDNmw3N3U5QXQ3TmlmMXg4?=
 =?utf-8?B?bGU3cU1PVE54LzJsS1VyN3RiTHp6cTNMa29HNFVVVG82TVQzeHk1czdHTHNC?=
 =?utf-8?B?N2JtUC9mVDRoUUFQT2ltRG9Zd0Vwd0lIMUdBVnlONkxoQWtTZUhFYTNIL2ZL?=
 =?utf-8?B?UGc5NkRrVnIyeWJtZDhGaWZrbnJaTU5EeGEzRDl6RnVTRTFwOVZMclo1ODFn?=
 =?utf-8?B?TTV2dGNGYTFGdEFFbVBHeEFCMzYzZklIRmptYWRHdm1yTXJlZXlnSlJPYTQ4?=
 =?utf-8?B?bDByb1FJb3htUlVLZXFsZU44MlE4Zzk1QTEyNUV0S1ZCQ3RZU3VLdk5WQ2k2?=
 =?utf-8?B?SEtEZkZ6S2pyWWU4VHBhTHBWdDRRekt2VzVoV0Z6TitoZWlaQzNhY1puWW1y?=
 =?utf-8?B?Tm5ZUFhsQkNxdmRaRnp3THVwVjkzcXZEc2t2T3ltOE9vOVVGNTFIUUtsRmt6?=
 =?utf-8?B?aHYyNjV4cEI2Z1NYaUNzVFArdndVU29aNnVGd0dZTng4NVpPTVRkV1p1a2Z3?=
 =?utf-8?B?SGRtK2dKYllUL2ppbFptY3NJT3BTajU2akMyYUJEc2llOWxnVVlZSERwbXYr?=
 =?utf-8?B?Q3NHMzRiU3MzOFJOemZzdU0wdmMzcDlRYnkvd2hIZXZNN3pJSS9POUZLWEJM?=
 =?utf-8?B?ZjgrVURTeTFIMndtelROWUJkVDF1QnhjVmVZZWRDOGtScXZrbk1xS3JKTXRU?=
 =?utf-8?B?aE1WMElKNTc5dnJMeXlpeHUrQ2R6cS9UVzhFUEtESWJWcm5pQlBkSGFEbThl?=
 =?utf-8?B?SEZ0WU5ZR3hJRXhjb2dvQzRZOGNDalF6d05oeEJLS3JDb2ZJcnUyV1BKZFE3?=
 =?utf-8?B?WmwwSVdUVzVGMW9yRjl5K2JBMjV4VkExSkZTRE41MlZqWDBtZ2NQbFFoa3JV?=
 =?utf-8?B?UnVxc0s0eHFzR3NUek5VMnhBcG5Sd0dFR1BIYVBEaC9pcG5kdlpMYzRTd1dP?=
 =?utf-8?B?NjJ4NGdvN3dYVmRaK2JOVjJna3NBVm01aHJiY0hmT1RRcUFDNFBxUEw2czBu?=
 =?utf-8?Q?Aag/cz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHZjNnBGRzR5RzBlY3Z4aFRaT3NGR3dWRjNyQUxGaW96Rk5PdVM0Wk1GYWVJ?=
 =?utf-8?B?M09pN25YMnBhSmxaZkxBaUxidEF6NTBqZ3NVN004SktVRzhMY2VmNFA4TURG?=
 =?utf-8?B?TUlFUFplVWU5L05wSXlwOWdpTUtpU2RiRlBCVWFsbTVOZUVTd1JreDRGOFlB?=
 =?utf-8?B?SHNEemovMlFVbTlkWWhzVVdGQnI1cm50S1VkSTZLdGs3OUhFbHNWeHhuMDZ3?=
 =?utf-8?B?ZS93M1ltNVlxME1Ha3FLU3JWOFlPMkcrVHRVc0luMjBnVVdpdi8xc3VHUGs3?=
 =?utf-8?B?a0NhVXFWdzE3RjBiNnRsRVBYNkswZDJmQ0xtQW56TzlyTkJpdkdzd0JDamtn?=
 =?utf-8?B?NEd6TjhxQll6NG81ZWJpd1duTnBZdHhEb01xM0pPRzlqVGRNN25aNzZuaGha?=
 =?utf-8?B?a0FjV0lQSHgxY1NlWmhVUmt3M0dEL3NzcndJVU1UekZWV2JWTm95S2doRnhB?=
 =?utf-8?B?K3VibmRpck1EcytzNXR5ck51Z3ZsQ0ZQNkFmWXhUd2pLSWpMZm01RnlIK3J3?=
 =?utf-8?B?SmtYVis3eUZyaHJML2sxYW80WUxCVWppdDdsbnFLUW1FbWVFQW96VGlESU9D?=
 =?utf-8?B?YjMrYytuMklRM1JWTHl1ZWR6V1RmbVFPRnBPUzFvTFYxaWx2TnBlRy9jSkhM?=
 =?utf-8?B?c1pOWmxWSjI5TmxyeTBXeTVhWThZZ1dFVXlJa3oxTWRzQThTdkpaSjVHVkhM?=
 =?utf-8?B?M1lDYW5nRS9tMXJTcllXV1MzQkw3WDVUL3NMeHpId2ZPZ1VDcU92R2Naem56?=
 =?utf-8?B?ZlEvRmZGR2MxbkpwRVpmUHRhekJiYk9SUnI5ejdmbGxCWlBhemdYbzQxMWgx?=
 =?utf-8?B?L1BNb1FOaHc5eko4bVpENjNFQUZ6cjI3NlVCMmNwMWxITWdiZ3FsLzZBZjkw?=
 =?utf-8?B?WGhUbjVMbjNPcGkzOFVqRWhFOFdnZGdBV0o0U2VUbUF4VHl4RHJQenp4N0o4?=
 =?utf-8?B?RnorUitxUXJkbFJHZkdPdEl6ZkZtalArTGNTMXpNdWMxU3pYR0EvZ0pHdWNq?=
 =?utf-8?B?MXpnc2FlYVdoMFhqVlJaVWZWYU1HNFJCQmRjMDdNZ0lJVElKTGdpRE93TzBV?=
 =?utf-8?B?VklhRGI3SER3VEJPRlF4MGdXK0ZLUnBVSXI2ckxoRjVmYTViNXh6U3czemZa?=
 =?utf-8?B?V2lQYzZPSlVkVmhJWWk5SkpYM1BpK2xVOStPTXpWTjFwU2NVOXdoZU43NE5Z?=
 =?utf-8?B?clFvcHlXb0NiL3dSRjlOczljKzhTUjB0MVE3RWcySTVvWEgrOTZwY2t3czY4?=
 =?utf-8?B?UTlOOGNWd3dodTZLRFdzQzYweTRBOCtEOHZmMElhNEZCNHNiQ0g4NTJwSXJo?=
 =?utf-8?B?NEVGanUzWTRPMmJQYWNBTkhtaFBzZ2MyQ2Ixd2o4UW9KYmx4TmNCZ2t0Sks3?=
 =?utf-8?B?TUk3SjBjbG94SGNiWjM1b2ZIVU1iazlhbTlEUFJuUnRYYkJ2UlVXcFpJR3R5?=
 =?utf-8?B?dTU4aHlDMGZyM1NCdDkxczBJaFB4UHhjeXZCVmoyYUpMbElMT2NmS25hU3pX?=
 =?utf-8?B?dlF6bmdmZk52VnhGbWswdGl2WVJ5REtFeDFtdUk5dzlqVUlIZ1A5d0M4L00z?=
 =?utf-8?B?cHJEbDVCK1BaOFhuQlFnUDRlb0FzbHB5a0NPMVZnQlg2cnJYWTJWbWtFZ2Nt?=
 =?utf-8?B?U3BrQzB0L2hvS0JPZHZRZjk1L242eHIrU3VBRzFiRTNhN3pHbHdUbzI1Z2hj?=
 =?utf-8?B?djhsMlhhUEp6cXJ2b29iVEFLdVNFMkFZSmQ4TFppWGZ0TWQ1Yk1Ha01rSGhx?=
 =?utf-8?B?cEN2T0hiQjFyNFAwQ0NWV1J5VWhWazIxMmVWeXA0MDlteUxObWgyR0tLS2NJ?=
 =?utf-8?B?cWVBaHBGVVZRZEp1QldWOUFjZTk1MDZrK1pHTks3WnMyZzUwalhVZVRBbHlU?=
 =?utf-8?B?TTZSamZZb0o1VzEzRk5uekFwQk5SVjJ0b0lvYWVqdjc4a21Oek9TdGQ5SWJG?=
 =?utf-8?B?ZHFCVEpJM05vOTNzYjAvR2ZSbEc3bVlQSnNpdWdLd0IwaWZxQ3gzZ0VFTW9u?=
 =?utf-8?B?S0NHa0ZNU2VxVVVpK3lhZWd0RVBTR1dFRnpmbWR0bFEzWGw1ZHJSWFV5dnE4?=
 =?utf-8?B?MlcrdDNLcWtLT25RUVRTbVp5UnJsZEYyZ1Ftd0xKcHNFZkdpNFN3eXphM3BV?=
 =?utf-8?B?UW1NUU44WXhVdVJDVS8wUW5oVDZsY3Z1TEp1b3V5SXkzSnE0WmtmSy9WV2h2?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B50406B03B1644CBF36241D6944F9FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24116ede-309c-4034-fc71-08de05c96ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 17:46:16.9749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdYb6HHV7+LBbx4B7aJQNtGKJOKTNIq3JSinWAnA0u4PLYtnBxxI6wyQPxVgGER/aDD9PrRzGcZFTXfMRWJlwabckkfDimEKWx7FEoOZ5fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7958
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDIzOjUxIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
TW92ZSB0aGUgVU1JUCBleGNlcHRpb24gZml4dXAgYWxvbmcgd2l0aCB0aGUgb3RoZXIgdXNlciBt
b2RlIGZpeHVwcywNCj4gdGhhdCBpcywgdW5kZXIgdGhlIGNvbW1vbiAiaWYgKHVzZXJfbW9kZShy
ZWdzKSkiIGNvbmRpdGlvbiB3aGVyZSB0aGUNCj4gcmVzdCBvZiB0aGUgZml4dXBzIHJlc2lkZS4N
Cg0KQ2FuIHlvdSBtZW50aW9uIHRoYXQgaXQgYWxzbyBkcm9wcyBzdGF0aWNfY3B1X2hhcyhYODZf
RkVBVFVSRV9VTUlQKSBjaGVjaw0KYmVjYXVzZSBmaXh1cF91bWlwX2V4Y2VwdGlvbigpIGFscmVh
ZHkgY2hlY2tzDQpjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1VNSVApPw0KDQo+IA0K
PiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCg0K

