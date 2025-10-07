Return-Path: <linux-efi+bounces-4989-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA04BC26D9
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 20:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D93F34ED851
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7124D2E973C;
	Tue,  7 Oct 2025 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfjZpROF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59621E25F9;
	Tue,  7 Oct 2025 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862620; cv=fail; b=hcvMVwg/wL5udwhTNduCa1/WERvjc9o5tX6Fx8JlVvm4t5lo51OEBxnXsZBQxdKR+j8payEqiq6tDmtwAzXJ/rRVtOLhojUE7rSuHgJqWsV3NTMqE8+VYkw02eKm4pJAX6e1FKLgTCF0flRipMDoPxoTU/V8PVy2vKoIv33IBDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862620; c=relaxed/simple;
	bh=BaSHwV+RReIuyV3MoxbGdoRRkvgIRGYBRDfOahnrVRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mv7uZSwTU11dvDOjiJCTDJbEFHoJCHNOlIbuu9xpn/GF6G4u2Nd1eWJp42lfTbaGLhoShIDJyOkHuMMsAmNPiCp1e+KBrHcGNWRQ/tKs7jo64UzRrlzAFmDjuCHJ3XyV3EnXGXln5QtPaRCNGzIXb/5DYo+PkMMhI4Ytq8rErVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfjZpROF; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759862619; x=1791398619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BaSHwV+RReIuyV3MoxbGdoRRkvgIRGYBRDfOahnrVRo=;
  b=LfjZpROFU65ijE1IesGAHOZ5jguiX6VIZCEIm0m6bqpbM+vw6NoE3+/Z
   B62uwKA55xpm47tz7vKYMkPAtviLEJT82E3RYuWfPp9Clve2I26xOeeQQ
   nyHp9ZRqaz2CZHIW7kNa2IYIkxHykJ76cuAtgi11O9W69GSokywuOgX0Q
   Bk8ltzQiJRxZ9OT4JqbRMaMxW9LAaqE2XDZWc68+rgpteHN7V5HvpykcU
   q8xXvodQpvEv8Z79qXA7lw6SAxrjmMtrEVv16lo/g4GaYoSuJxY+SDAKD
   xhHbKSM6Yjx2dlMobOLnIA+R+00y+Z7hPxXUp1m0yFVF10qpXf1wTdpY2
   g==;
X-CSE-ConnectionGUID: /KGGVhvfSTCtVxlkN0BtaQ==
X-CSE-MsgGUID: pKOxx946SiqLFuaDD/1NWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="49607195"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="49607195"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:43:38 -0700
X-CSE-ConnectionGUID: eP+s7jbMQR+fEM1Jr+pLJg==
X-CSE-MsgGUID: 8PtOEXWNSOS8UJTzQ6y8UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="185378542"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:43:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:43:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 11:43:37 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.16)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:43:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xA6oj5ezcwbpFVd2lH88s2UDjoecFEp0AGFPxCkvLS8eQit5POdF9dCT9lZTHxqyj9mkjUbsZr0Y1P1jOJRdM+KuSem+/89p/ih3c65ZE5JCvktIqc4R4+588hfrQFGPTrE/xfTqc8uqwn/IV4lREz6U99f4V8qcNLiThiauVn3Z7l1Nm2ag81BKzDVrY3jK+f08eFlfVM/z0d1ittrXKHOF0Iwcau6rL/vRIRRcS1gxqr2k88I0vAnS8VfppUe6eRsbxYEJphG4C517f/u+Csk6Ndao9lYwGszoHE7pPlWnYKTL/JQcCRFLCAI68c+LS1aOipcIb5RrFRCzHZL3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaSHwV+RReIuyV3MoxbGdoRRkvgIRGYBRDfOahnrVRo=;
 b=xxC1FySRkDXMUL75eII+zL6G7C5+CS3vDRZEt/FueSUspCzB4pkWtfkmVxPxTuaODkwZ4qQ5yxOtiAS1UJfBN7EQE6qeru4+lBzc0Dnj/QHcpiBXWFgTNiKPt9Y1NHT9yMIu9rU1tO4bZWdGxFitEgPbjbV33/6AqirBCVqikcmorgKhgfVqGJPDd5om2LmcLKo1wH9kYhK1s5LAJW74IOsv1ylXnWcyR/qXy4jXv6j/rDdsjdS5HC0hD4sY5IwnP9JqIu6yeKqwdh0wFFOUBnG9lwNpgq68HyeQoYpXchY46Ytl4Bzor+6gzVvmfJOq+IMFE6alf9ZeVXWaFZ9KhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6713.namprd11.prod.outlook.com (2603:10b6:303:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 18:43:23 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 18:43:22 +0000
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
Subject: Re: [PATCH v10 13/15] x86/traps: Generalize #GP address decode and
 hint code
Thread-Topic: [PATCH v10 13/15] x86/traps: Generalize #GP address decode and
 hint code
Thread-Index: AQHcN1czwcS2U49AEkiKm9WPOiPvN7S3BdOA
Date: Tue, 7 Oct 2025 18:43:22 +0000
Message-ID: <835065a95a465b1d4cb20411842266594e8493e7.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-14-sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-14-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6713:EE_
x-ms-office365-filtering-correlation-id: 6185ae7d-f164-4674-ba0f-08de05d1646b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UUJGMDk4b2YvYWlveDdlSVNsN1MrTnBSRG1WU2RyUUJwMXNLb3pPZW02T1Ra?=
 =?utf-8?B?V2dBWVhZaUNyb3A1VlVmdE1rUXI5eWhlWXFDS1dMSUpIQklRRDFkRy9wQ1lW?=
 =?utf-8?B?RTNWRTZWdFZhN3g0TkZrOVU0bldrN2lJdEJVMHJseitTZThUdnQ3bGRGVG5L?=
 =?utf-8?B?N2JPR0ViM3FDOHY3TlN6MFhpcDV3RTJsMDl4Wllpdm9GT202N3NYNVhTaVg0?=
 =?utf-8?B?WGF0djh1d3Y0Ym1OaHcxUEh0WU9DbGZLeFRRMklpWDVhMGdHWm9ZWjFnSHll?=
 =?utf-8?B?ZXVWdnZMcGFha0xtemxrUXd3cE5meHRuYUxxb3dxWVlWT3JlY3ZXU1J5bW9x?=
 =?utf-8?B?NitPRlltSW1pY21GOEMrNHlTWGZnUmtFTGRiN1pHb2M5WkxUb3g2MUl4a0Ju?=
 =?utf-8?B?bUVHT3VJQml3UXFRendqOXYyeDlNREw2V25GaU5tSzk5UUlhZTFxZXdidFc1?=
 =?utf-8?B?am5aMzEydTJzc3k1SEk3TE9OanhwUFhNK3BRSGwvKzNGemFHUVlzcFVIUzJP?=
 =?utf-8?B?bGd6RnVXNnJyaGMxd0NMRDNXYWtsMHdwVCtPeXBMN0cxeThnbGV4SmxTYk9q?=
 =?utf-8?B?QWpidXhHT1hZNVpoWDVzN1JzMURIREVKUUp6cm8zbFJZaHlXRkQ2NzduY1V4?=
 =?utf-8?B?bWJlaVl2WXo2MFdFb3lIZytmbXFGcmxKdXdtOU1yQWRWME9kVTN2a2FMdk1C?=
 =?utf-8?B?bXJXaGw3MFdUaWZyMUpZNUlrS3ViZlVydTdWSVdkTFo0NklTb3BJL2Jac0gw?=
 =?utf-8?B?TXA5Sm1xRGVtYjB2RjdrMHJGWnUycktqbHcxOXJGb0k5aEpxOWV0RTZIZVV2?=
 =?utf-8?B?eXNwaGRSZFRyR2xjWnQ5YkJ6NFBUVFlmTUdjc1RORTIvWSszeGtGeCsxMFIy?=
 =?utf-8?B?eHlxV09lMk9xeHV2NHZHYzVPYWtQNW0yYktZTHZBajBCWGZBOGRTV1VGVFh0?=
 =?utf-8?B?L1FVVCtIZGdLTVlVNkRDN2dnWmw3TjgxTDBIRk4wb2ZyQXFTS0pNd2d1VWNO?=
 =?utf-8?B?OUlweEZ4dW9PYThQUGJQaWlhamM0UkdGekpUTGJhUWFBS1gxN1hkVk1XU0dQ?=
 =?utf-8?B?MkJTOFVwOEM1dW1BdXpOQ2drUVg1N2lMU3IvTkJCZzJsdEN2Um5IakVkbHpJ?=
 =?utf-8?B?dVJzalZOWDNseUJVZ0pEYlREd3o3YkVWTkdiZ0RDVGpqK01WT2JUUXdPRG9s?=
 =?utf-8?B?OXpob3VpWGxUQ01PamlIVDhMZ1A1d1hTd0hTbUVJZXZCQzlxQ2NSaFRQckpM?=
 =?utf-8?B?Q1JlUkxqSEpDeGk5VlpxUDZlOWdJcHdyb21RY0pQenpScnJickFiNzZCVjNy?=
 =?utf-8?B?WFk4NUNNaVZVT295cjl3RmlTU1dNTkpQWUdBUDlWSEhBNzl1ajB5dUdud1Fo?=
 =?utf-8?B?dXRObzFPNDdNcERDcXEzUkQvbUZIMitvQXRBRndJRlBZRWd2M0IzaXpQajZ5?=
 =?utf-8?B?T1pWRHlZNnhvQWRXcW9qcTFpR2N3RXJGVTVJcEdHK0FIUjFKWVhDVkM4UkJj?=
 =?utf-8?B?M2kycU5BSkVpM1RTK1pGUVhzeER4NWJ0RUZWNjdlMjJ1OUVmV0l4L3Y4ZUxz?=
 =?utf-8?B?T2RkdzBXaWR4RWV0cUxLYVQ3MmtDTXpOWkxTUkN0blZpQjVnc2RZc3JNdTRX?=
 =?utf-8?B?T3ViTW8xZTFGWG81SVJEbXhUUCtvTm5aVWxyUnI3MXJNTGs2aU43YzQ2c2Nt?=
 =?utf-8?B?V2hZMGd0MCtpMWVXTExFOVpiaENWam95TjhJL21BVlJYTVB1UzlsMExLbGlV?=
 =?utf-8?B?Z1BkNXI1MWFYSDY3NGNNNlNibTlha0NkTmgyTWRrbVN6eVY3OTRZUDlYVnk0?=
 =?utf-8?B?TUZhWFhhYjF2Tkp4RjlZOGNCcnlTdCtjMTNYUmtmVUxwSnlpb281Y25pYWJa?=
 =?utf-8?B?UnppMHRZVkoyNEhOYTREbUlocXNoZzJ2MlkxVUFkem1rUng4bktEZ29DNHRs?=
 =?utf-8?B?cUY4M25kUCs2ZjVoYnpYNU9ER1RveGMvSDM0cDhxanBhSTg5UXlubnlxeGpG?=
 =?utf-8?B?aHdiN2NwbncwZ1FtUGIrVEdEUUlaODljczh4cDJzY2lLdHp6VlYrWXhUSFV0?=
 =?utf-8?Q?CkGUF5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHVUaXhiTVpXcmxwYVByZWpRUnYxQ2RWZjB2STYwa1ZFeVJpa1NyL1M3SnJB?=
 =?utf-8?B?WFF5ZEY1UytuK0YzL1Ftb1ZkOWUxMzdXUTNqKzJGZEpSWncxL3NTOHUxZEh1?=
 =?utf-8?B?SDE2Z294U2p3VWxmN0hURVZia2dENlRnb2VlTkc4OWhmTlZQbjZybEEyanhN?=
 =?utf-8?B?cEtkMHZ0ZnRxUUpwK1l6aVczQ2syNWRrZ216TUFnSE5CTWx2Y1I0dXl5cXJ0?=
 =?utf-8?B?Y1hNUmZpT0xCWU5hVHVwUGdxcjRZRXVMQ3JITjRTcTZ6Mk1jRE1KSkoxSGox?=
 =?utf-8?B?Ylk0VmNjQ0RUdVFsVXNDQXpUZ1M0c3BveUh5MTlTcGVIK1pFT2dmSnRYNE1w?=
 =?utf-8?B?MUh5QXNTSGcrTENFdC8rdWtEMmZsMTZmQVR5cEIyY29GVVZ1MjAxNFljSm9o?=
 =?utf-8?B?TlRKb1ZFUWJibDkyRk5jVGd4bWVNSkxVdDUzUEtqcTVhM212aG8rN3RpcE5M?=
 =?utf-8?B?Wjd6UVNCNkFrRTY3SHhVaG5HRUc5SEdPWWRXc2IwQ01oNzBNQWZDaysrR2F3?=
 =?utf-8?B?Y1JPZkgweHRUMnVJS1I0TU5rdUJyUVNIVWlZZXhwQno1UXNWL3UzOW54Si9j?=
 =?utf-8?B?ekJCRWdUMjFZQ0tUK24rQnN4ZlBnWUIxRm94Y05QWjhUQm1tZFFqcERVQWhv?=
 =?utf-8?B?VU5Xekd2VnRrVUt4akFISWkraGJiYmhkeWpoY05TbUI2UmNycjNEd2c0NTNI?=
 =?utf-8?B?N2E0T3F5dVBPZ0l0U2l2QlI3cDhlS3BuSDhocWlJbnZRS2cvMVQzaTRlRUpZ?=
 =?utf-8?B?d3hEVFF3RU9LMkJRWkY3ckJJaHpGZUdUbjVrMEs2Qy9OR3k1ZmJ1U3ZxbzB1?=
 =?utf-8?B?Z1VOYUxzZG91RFdhbnMzRnZiRjBrYVEvd0JCTFRwNXBaTExrMkY1enZHWlFM?=
 =?utf-8?B?QlY4TXlsMnovUEdLbWw2SHprbG4vM2ZlS0d5bndFblRUQlhxc1Z2ckRjS21i?=
 =?utf-8?B?MjBHWGtDNzJUcUdacGRDdVdEaE5WRGF4UkcrYW1kRmhOQlZIc24vU3NmeFU2?=
 =?utf-8?B?WjRRN2VuUkFhYXEyU1NPYWNMM1puVG81SGVkN1dkbitDaFVDbEJRNXBoTUpH?=
 =?utf-8?B?dHREMkZVaXA4bHp5ZXVSS1VOWG5zenREWlF4TzFuaU5OYTFQT2EwbnpxWlBo?=
 =?utf-8?B?VlptTkJ3ODRqNUhOUjhjUkh3RldVR216Wkw1cUtXZDRlTHV6ZjdQQWttOE85?=
 =?utf-8?B?S1hycmtrdC9mMFcrSzYzUXArbnYvb1lmaUl2MkxvOFppcUM5aE9tbTBJN1h3?=
 =?utf-8?B?a05WVHhhMEc3NXBMd3g0N3Y4aG1qcE5VZXBkL2RGYVN0dmNZdVdpeWJoWC9j?=
 =?utf-8?B?S1pwNFJGRzZtZlpUY0lySXJqdGdNVWhiV1l6MHp6MU5rSVFvTTk5Skc5MUk4?=
 =?utf-8?B?d2k5NGZ6VXJFbUhZZWg1STdlUFVyWThiblBTRElUOGgyQTdxdEdOejZuaDJv?=
 =?utf-8?B?cS96RFZPblZHWEtqa2xHWkRjdzViVnZmTzJacjJFUHlPY2NyV1IzOWhKeThR?=
 =?utf-8?B?T2VqOEwvcVlxYlk3Skc5QmhoRXZ5TjNPL1RqT1N1MThJcDA5YWlLNG4xTGFv?=
 =?utf-8?B?c05yemVqMnBieHY0M0l6UWdyTlR6Qk5xNTN3bXdKZ053ODFqb2xuSVB2Qmxy?=
 =?utf-8?B?QTN4cUpOQVo3ZzB0Q1FpOVJyT0NXTHNENkpRa0RhSENGM01RNVorSFlGOTFL?=
 =?utf-8?B?WWwzTGZ1R2pqai9rcC9KS3Q0cjR2aGZubUpTNUJUancvNXlBUHBsRGp5M3pk?=
 =?utf-8?B?a1NXdFN3RUVmdXhyNmlsczRzVVMxNjd6VUN6bGdQZDh6a0lBMnNRRS84Nk03?=
 =?utf-8?B?dmhCRkVtbVVMQmtRSk9BYVZtcnFoelR4bUtzOSthWng5MzFSeVhubTNOUk4y?=
 =?utf-8?B?ZS9uTVVBbm9vVXVPYS9CUE9vOWFPL1VaOUo3Vjk2OElDQ3U0UXJEcVJyRnFt?=
 =?utf-8?B?YmlxQXlqWm4zdXZiL2NZZDBxL2xHTUhHaU9GeUd2NlpjOTdZVUZRSkdCTEF4?=
 =?utf-8?B?S0pIejJ1Ukk0NGUzdEdiRDB2eG96bUVFTTZoeXEva25ZWWtBY3JvL0JtWkto?=
 =?utf-8?B?alRHdzVWdGxyeS9PUExMZEF2dE9Qb2dhcjg5Yk5SZWM0RFNqaGJaSTVHdFFR?=
 =?utf-8?B?U2V6bmdyRC9TVWEvYm4yRHR6ZjljRXA3WFRQNjF6TUJVUTBBMVIxZ0dPaUJo?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <730FEC7F3A6E654F902562C972A9E1B4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6185ae7d-f164-4674-ba0f-08de05d1646b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 18:43:22.3504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ku42Aa0JVPiRHTYSkWYcL1YmZ3mL8yLHT+KXLzYwQ38rAjpWw4wwmt+SPz2Y2R16Wp6wuYP4lUpc3aHp53Ns3jiyFU43USxtcWE0A/lGhlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6713
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDIzOjUxIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
RnJvbTogIktpcmlsbCBBLiBTaHV0ZW1vdiIgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5j
b20+DQo+IA0KPiBJbiBtb3N0IGNhc2VzLCBhbiBhY2Nlc3MgY2F1c2luZyBhIExBU1MgdmlvbGF0
aW9uIHJlc3VsdHMgaW4gYSAjR1AsIGZvcg0KPiBzdGFjayBhY2Nlc3NlcyAodGhvc2UgZHVlIHRv
IHN0YWNrLW9yaWVudGVkIGluc3RydWN0aW9ucywgYXMgd2VsbCBhcw0KPiBhY2Nlc3NlcyB0aGF0
IGltcGxpY2l0bHkgb3IgZXhwbGljaXRseSB1c2UgdGhlIFNTIHNlZ21lbnQgcmVnaXN0ZXIpLCBh
DQo+IHN0YWNrIHNlZ21lbnQgZmF1bHQgKCNTUykgaXMgZ2VuZXJhdGVkLg0KPiANCj4gSGFuZGxl
cnMgZm9yICNHUCBhbmQgI1NTIHdpbGwgc29vbiBzaGFyZSBjb2RlIHRvIGRlY29kZSB0aGUgZXhj
ZXB0aW9uDQo+IGFkZHJlc3MgYW5kIHJldHJpZXZlIHRoZSBleGNlcHRpb24gaGludCBzdHJpbmcu
IFJlbmFtZSB0aGUgaGVscGVyDQo+IGZ1bmN0aW9uIGFzIHdlbGwgYXMgdGhlIGVudW0gYW5kIGFy
cmF5IG5hbWVzIHRvIHJlZmxlY3QgdGhhdCB0aGV5IGFyZSBubw0KPiBsb25nZXIgc3BlY2lmaWMg
dG8gI0dQLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRl
bC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNvaGlsIE1laHRhIDxzb2hpbC5tZWh0YUBpbnRlbC5j
b20+DQo+IC0tLQ0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJl
QGludGVsLmNvbT4NCg==

