Return-Path: <linux-efi+bounces-3453-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE25A9AD97
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 14:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C949C5A6B28
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C31927B4F6;
	Thu, 24 Apr 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYmOwWhE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563FB27A93E;
	Thu, 24 Apr 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498226; cv=fail; b=T6d9rEMK2EHw98S8YNxC5tevc7KdvlHmzQCSDfRJK0u3o/PPNjWw9+hokBMWlcbYI8w2q9gYtzXRW4gd6w59zzTujGNRYIeFHoA9BzLnG1xCPvr9g/UY+T1wjFM8limAlx6Me/FjSyYJU05kYRAjjARtn6ggsEuSmpUzoNxaf4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498226; c=relaxed/simple;
	bh=kjAiB9c4y2diybooZ6edvPaEuiCm9kWOOoCxlOr+Bho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZodlrNJZh1ZLEEi69StbOONwQVAvg8iFpN0A8ZuHtdcQfnVcSQOYs+TTPQuwFM4N3idWRyaL7GUVMEjxiRuIHAYqPei9krZ9ApyaJXut8ED17rw+BJSyh1XQL9t7mu5liC/usWKUqW4C0uty3TYPY84TFiwMJFt3UiNRXVrujrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYmOwWhE; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498225; x=1777034225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kjAiB9c4y2diybooZ6edvPaEuiCm9kWOOoCxlOr+Bho=;
  b=FYmOwWhELAtRZ9QHBvsCWa89e3IqThCr2xBRfCvgQQxlJ5JNYe0xFTBX
   Yp0AqrgBBxl9F0in+68C/MZhsLebDSfBELnvAt0S2zwzOgkpkqxWugQ9v
   VanxxI6doV1WUIodlndC8hQSpvOyXc2SUDoumMqmWBvdJ97nzuKfWRBqp
   2LvcCprvROox5QNW5suEBHU2+GcObZDKS3nz7sxbLRfOJP8odhAouf2d+
   dExnUVfEWNlRsKslwfIFaSRIxAt2/cVeFl0BsR+sMv5tUo16Z85hJuAdj
   vbi680ZOMX92Hrfd3cZAk/qJSOpdzY98pc9FU8KiYHLbppmayh+JfLlPO
   w==;
X-CSE-ConnectionGUID: QFgG5PLJQpC0MnEgYYh6Rg==
X-CSE-MsgGUID: tGv/0qQoSJ6gMhPrz17R5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46359275"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="46359275"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:37:03 -0700
X-CSE-ConnectionGUID: h8fbqH3HTZCFEn0qvxVvjg==
X-CSE-MsgGUID: vndl5xJRTryYAvcKEdbVpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132590868"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:37:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 05:37:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 05:37:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 05:37:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T81Odf1duUiSxRWgkNAcwyeZqScHvvKq/rIupGFxR7n8/bewfkWjfUbe8iC4JFIwzvIKByq0Ca7c5tkq0iltE5EWoCMFfZMTNMeDxhH7Y1tKu6z6djQ70ZSQkxytV8lbRD0JT1HeJF6UkEDQE/URd7p440/VBLwizTYIc1hk1JHJtsW7hNpAIUSQZ+t27SxQY7t+/1vjOV2gCFtUKcJ++z8lCEbs9vw6Air4JoZxKwgr/TZjnlFArjMBY9Kj5GspXN6KSr9cpCkGZwqh5KW0CmTRm02nrFSAjhqrIUur73xIowvXV/AQWjCKk9PSaICriFdFXOjMMYfAYtYzeZSMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjAiB9c4y2diybooZ6edvPaEuiCm9kWOOoCxlOr+Bho=;
 b=OW9nfKv4tS+DuxZ7amftuDctrTy+rwlTgAkX0O8Bum+buIpDHz70Q0UpZKg4EB61S4UULK9xttH/EcPWBkV+MquJhMuKpUJSPme1hFxDZOIKCpRWTyt8mUMeqEs5je6TYcKwk2QyjCfRq4HmuRoj3fhEtlBTZEaZptpPl9aMIG4wAnsl1NqopmVXV3ZHXunBIHmAVmNH0CkqCUlcB3539YHQFuGb9UGghxOyP+IV3F+QBDczzT+kU+eGkPIS6p2ht638apFteKopg/hruCbmkfbggIfKzQBFQwcMaynKt+KPgDL99uFrvTkLoQBlLDIvNcpbz/xjg0bT+yzm4KPC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 24 Apr
 2025 12:36:58 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 12:36:58 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "x86@kernel.org"
	<x86@kernel.org>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "ross.philipson@oracle.com"
	<ross.philipson@oracle.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, "peterhuewe@gmx.de"
	<peterhuewe@gmx.de>, "James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>, "trenchboot-devel@googlegroups.com"
	<trenchboot-devel@googlegroups.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"mingo@redhat.com" <mingo@redhat.com>, "Ghatraju, Kanth"
	<kanth.ghatraju@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"luto@amacapital.net" <luto@amacapital.net>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "dpsmith@apertussolutions.com"
	<dpsmith@apertussolutions.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>, "mjg59@srcf.ucam.org"
	<mjg59@srcf.ucam.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "nivedita@alum.mit.edu"
	<nivedita@alum.mit.edu>
Subject: Re: [PATCH v14 03/19] x86: Secure Launch Resource Table header file
Thread-Topic: [PATCH v14 03/19] x86: Secure Launch Resource Table header file
Thread-Index: AQHbstt3c9WWZcxdN0uFF8Ct1r1PBLOyxWcA
Date: Thu, 24 Apr 2025 12:36:57 +0000
Message-ID: <e5f5a76b5cc93861df23bd96642a94b7d549a467.camel@intel.com>
References: <20250421162712.77452-1-ross.philipson@oracle.com>
	 <20250421162712.77452-4-ross.philipson@oracle.com>
In-Reply-To: <20250421162712.77452-4-ross.philipson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB7572:EE_
x-ms-office365-filtering-correlation-id: dd87b796-7d9a-461e-de9c-08dd832cb418
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RzBmYkpqbW81V1BZakdHU3NWeUZubVEvT3lsTFh4VWF5aGVKN2RzOVoxTSt0?=
 =?utf-8?B?YkhEYVdxTlZhODlsSHdybGYzOVZBZVpNSXZOWnpTci9PSHVTNmtPcXhXRG9q?=
 =?utf-8?B?SmV3N1llSTZtcXVmdzVsT3ViZFlSQTMrZElmbEVrZVFWMElMNC9WYlN4dmh4?=
 =?utf-8?B?cExwT3ZmR3hMaE9mRnNjMHNzeEFQcTh2UkVpcVd4QlExMmdabHRwZXZIakQ0?=
 =?utf-8?B?WHl4WllMYWVaWFZhdGJxU1JPdGhZRGc0UGtLY080OWxIS0U5S0RqNy9waVZW?=
 =?utf-8?B?NDllV3Y3ZFprY01qbUk2U1IwWjdqZ3QxSEQwVktudWNoV2s5OU01TFFjTk1V?=
 =?utf-8?B?eXZlbWNNcEg1UGpBQ0VuWW1zQ2tqL2RJRk8zMVFWM1lYdFNFYmVTenhtWlI4?=
 =?utf-8?B?cmM1Y29LbWhxZ0hxVWlDY25OZUxyWG9LSHkrZlBxV0gva3FGcGc2c3Z5L05X?=
 =?utf-8?B?bEtadnd1cHNNbUE0M1dDL05VQS9rK2RIcmQwY0hpU01od3dTd3RYcENaNjJO?=
 =?utf-8?B?L1FaSjRKM1Y2ckpXbm5wQkFhQzZPSG1KTVh6WTFRZkViQ1VTSHc2VnRUWGpU?=
 =?utf-8?B?SnVGaFJvT0grM1Y4S1lVcEpWWDdiQWgxT0ZjYzhXaG1JSzdvdW9wTWxEMHIz?=
 =?utf-8?B?WndTdENidk1FdndTbmRiQ3R1SzYrVzhpbnpiVTIycmdUMGt5cmRJVEVkT01T?=
 =?utf-8?B?N2JGZUhYU3Z3cmNMbXBjNXNXbDBQRnJUdDA1OTVHLytSUjAwZGhNejdBdkNp?=
 =?utf-8?B?RWNQMWZCY3FrVGlJTDNwWmhURk5WZHRpWkJtWXM1VW5WUGlRNnRFcDVqRWVq?=
 =?utf-8?B?dnd1WGRhbFFZWlB4ZENLUDQ0eVJTQzF2WlpheGZMeGdZUlJtZmFJcngwZVFP?=
 =?utf-8?B?OFI0SjYwRTRFQXU5NXBMenFINlNYdmxxZi84QlhtRzlVWmNzZXAxRFVINE5l?=
 =?utf-8?B?ZEg3Z21IamZQT0o3VVNlcmgxQ3hVRjQ3cXJ1OXNlZk96Lzd3R3pkclZlUXJy?=
 =?utf-8?B?dGpIM2JVZlBzNnpiaEJPNlNyK082bHhBUWFJYjhqNGsycmF6eVNMMzZvdWRs?=
 =?utf-8?B?ZHpZRmx4djVHTFY4dDFqSVBRb3JhcjRTalZGdnBUM1JzRFpyQlgrdUV2TURn?=
 =?utf-8?B?eGE3aXIrS3NwUkNMSWJqSEhiWStaQUJYdWhYZTRwSHNZbWpJbjRlMVYwQlQx?=
 =?utf-8?B?ZGdaNm5FamtWWW9iKzZBMnA5VisrczNEOVM0YzVpMWR0a1lPSjVnQlVqSWtU?=
 =?utf-8?B?WVczM1VXa040VVZtek1QY3l4K28vTWlqZWxEV0FkaWRTU1pUQldGWjVlSnFM?=
 =?utf-8?B?NUJ5THlzLzA3dEZaSzREQ2NPTHVNdEpkbTNCVkQ5bFdCY2NSelpTeTZYWVFY?=
 =?utf-8?B?V05XWkZKK3hRcmJDcXZ6KzZCdGh5YnJwczdIWXJKVkxqWG5CZUlOamNabHlB?=
 =?utf-8?B?c0xSN0NsdWpBNnpNWktLL1NJUC9zcGkwblVxUXpTZjNhajZMVFh5eUV3U2t5?=
 =?utf-8?B?cysxeVVUWDB5d1MzRytEeXpkMU1INWhraFdMWFVmMjBFL21UMk55S1JBRmgr?=
 =?utf-8?B?WGJXMDFoaWpsaGQxdXZ6MzV4QW1jNDArck5lSXRCdWIwcS8vS2EraUtHRGVR?=
 =?utf-8?B?MzhWbzZvQTFSZlU2cnUzNCsvS1lZaC9zckladjRwdjZhYk1teWlSTTYrZ3Zp?=
 =?utf-8?B?V0l2ck9TNzFUTE1tVGt2NzlyRHl3MUw5ZTM1dXJwUnUwRzMwR09RdCtjdWZr?=
 =?utf-8?B?REZjUENzamI0a29nQXhnTVdwN3N1M1lqbnBReEVWK3Z0QmxaZGh2QWhmek5R?=
 =?utf-8?B?a1RRNDRRZzJWNWtoRUFvd0hRbmU4UVNXSzVReXhndVYzK3ZGaklxcGdXTHJs?=
 =?utf-8?B?NXk5QXdWbFhJOWVUS2haM1lYRXgyWjBwQ0lUczdjZXBTTzFVMXUyUENVMG1R?=
 =?utf-8?B?TERRbW84YnpUclpvU05qemJCcjZYSXhVUldaVjViWlA3RGpOMHhBL0xrSTVy?=
 =?utf-8?Q?0KklPVfhtT1Krsz8GqcTC+cyfjuI0U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTIzcEg2R05mY1dyN1JudmdlbmltVlNISFJWWlRvb3FaMytSanV5UXdES2ty?=
 =?utf-8?B?dCtlSnJNTS9udFZzaU1RMm1yUWNNK0dYcXlENFgrN1BEY3d0dmZWMURjc1JS?=
 =?utf-8?B?dzhEM3htZGF6SnBGZWI0Q0FBYjJsUUhuNk16VWRPMlA4MERid3I3c201ZE03?=
 =?utf-8?B?UjgveTBXN2NPZUNUWDBVUTlTemV5M0ZVdkNPMVVCWlRtaERtUmx0Nmw2OStV?=
 =?utf-8?B?TUQ0OUpwYklpTzVHOENHTmkzQzY5c0NMKzZtVVc0VS8rWkJNMERZSFlMMjFh?=
 =?utf-8?B?S3UrUGVzTjZTU3pyMUhmb3IrWG92dmZvRTlidVFRVkpxVHcwRlE5Z0NxUnFw?=
 =?utf-8?B?bHgvWWtIN2pvU25Hd1B4OXowVklqOUE1ZUtiUmpNOUs2UFJaa2pBWE5FUkl4?=
 =?utf-8?B?UlJieEFaVUZSMHF2VTZZRWpLZlRtc2JZaEhpYTdZK09jTG5pSTFPOFBjKzd0?=
 =?utf-8?B?MlJIU0FGTHd5VkV1Mk9NeXhiSVp0cU1RVkxUcW9TcjhndXA1aGlGd1RoUGRp?=
 =?utf-8?B?cXVQT1FwdGtveXhmbHJYQ0o0N05RdDdueWtQYk83QjRXQmJiU1RPbTQvMlRT?=
 =?utf-8?B?WkdCWVk2STRQUDVTeVBoTmhpSTRMRFdmNEcrYnRuOW1CSUxuNU5KeklmUG9j?=
 =?utf-8?B?L21YdzV3MzBMUk5WM3ZOR25ob1Z6TmdxeVhlMWhsc1hhRnJjRmtNQlNWK1dU?=
 =?utf-8?B?K1dWV2xJZHlyaDZPaVQ5RGVqcDRndUowYi9Va2Z4ck81VkJjcys0WlptMEN2?=
 =?utf-8?B?c0NaaDU2MzkyYmszZkZXamMxSHFjZWpWR1EyYmlsbCtmeDdHU2VzdDl4WG1M?=
 =?utf-8?B?eHhBUU1Fd25uUE5IRzN4UGx2WVkra0lvY3Fsd0xUOU1jdFd2Lzd4Sk1oQlpO?=
 =?utf-8?B?V0ovNXdvN0JWUFo5QmxZM0hpSW9Oc1l3SU83Nkl3c0RKQXNicUZ0NGRiVWEr?=
 =?utf-8?B?RzhPZHBCbG8zZ0lBcXpYQms0K1AwMmlUQ3U5UUFOTkFUdUxaYW1VWmVPYmpF?=
 =?utf-8?B?VkMrTkpiR3BDR2owUGVoMUhhdFU5RW1JNGRQazEyNjg0V1N6cSsyMGszRDhH?=
 =?utf-8?B?K3FFTXNiMmFjMitVakhzNHloRnUvaGhJRk5EeUZQclAzWjF5eHBPc0JwZU1C?=
 =?utf-8?B?THNaY2VoQ0pWTmxHLysvLzdoWWZXZGJTY05vcmJLK0FhNUg2OE9XQVFiSHF0?=
 =?utf-8?B?U01XdGpRRW5xNUxIZjh5R2NDYnFGQ29zVi9JNkVjbTN4eHhzY240QThOOHhl?=
 =?utf-8?B?V3pMbk5IMWdLMFYxYTNreDArZExZQ1dTWXVaUUtLQXZ1QmVtVnowakFkdGZB?=
 =?utf-8?B?ZU5EU08zdC9xc3A1NHROUC9IcU5GOW5ZNGR5T0Izb0hUQlBVM0crT3BFcjly?=
 =?utf-8?B?Z0IzOG9lb0h3NkZWZGxHNVlTaENVNHVEUWlTQ0xyV0pBOHNNUzRFTFQ1ME1E?=
 =?utf-8?B?R2o1V0FpWG1CQ2tMRHMrTWlLZFg0eFRsTTA5V09mRlRPR0pGNS9Ha0Rpc3Ax?=
 =?utf-8?B?VUN0UnNGZzEzcXpjUXliMWVaVnV0SVZHY09IR0kzazZ1VXFOWFNFemVkb2FL?=
 =?utf-8?B?K00rOUVsMnhZUnJPcnJ6NGJzMjI0ejdOZkNmWWo5dXd5eXJLZStpNDFPeFF0?=
 =?utf-8?B?em9PRms1cVdHRElONUFrQjM0M08vOG40VjlBSEkvU2xkaW85QTRJYXhBdC9J?=
 =?utf-8?B?VTM0SFE4aE9uMEJLZUIxVHpIeVNwYWN6L21teE1qRGJYQy9SY1k2cExMai9o?=
 =?utf-8?B?ZFZWQjVIeVk5N1BsbndyTnFVY1V2QWpFemhDS1pJSC93MVZrd3BnN3lJb1I3?=
 =?utf-8?B?UDR1L0ZRVHFoTmVOd05CTHh2WStmWk1aZVlIV05UalBmaitHaFFNRWFWOFZN?=
 =?utf-8?B?dzVzOHV2S05nV0M0MVZzYmwvREtLUXF2c3VmWE0yZ1RKNXFMMjR3ZmZ0SjhJ?=
 =?utf-8?B?cUlqT0tvV3NrV3kxemJsb3h2aHhOcC81SmtmUGg0Mm5kdHdneFhwM3RSdEdy?=
 =?utf-8?B?TlZhVkE2dTRyc0dlNU5FdGhoZDQ2U0hvZG5rR2RPTVludFNWT0lHb3dCd0tZ?=
 =?utf-8?B?VjVGcDVSamtjSXI1QW8wWklKcS8xYXU0OUlXZG5OcnU0elpiQXhOQXRLU2pv?=
 =?utf-8?Q?vmNXvb7j2BzleEyorDz4/X9fQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C5A122E35EB0D4DB3C396D237843C16@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd87b796-7d9a-461e-de9c-08dd832cb418
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 12:36:57.9474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTFPoXFkEryaB2s5kKbO1nyt9j5e4h5c3QwAi+2u6110pMVpVh2sEaKuBSMh6adpI/RJYkXvA5AE9pi8rtQrKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
X-OriginatorOrg: intel.com

DQo+ICsNCj4gKyNpZm5kZWYgX19BU1NFTUJMWV9fDQo+IA0KWy4uLl0NCg0KPiArI2VuZGlmIC8q
ICFfX0FTU0VNQkxZICovDQo+IA0KDQpBIG1pbm9yIHRoaW5nOg0KDQpUaGVyZSdzIGFuIGF0dGVt
cHQgdG8gY29udmVydCBfX0FTU0VNQkxZX18gdG8gX19BU1NFTUJMRVJfXyBhdCB0cmVlLXdpZGUg
bGV2ZWw6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNTAzMTQwNzEwMTMuMTU3
NTE2Ny0xLXRodXRoQHJlZGhhdC5jb20vDQoNCkkgYW0gbm90IHN1cmUgdGhlIGZpbmFsIHJlc3Vs
dCAodGhlcmUncyBzb21lIGRpc2N1c3Npb24gYXJvdW5kIHVhcGkgcGFydCwgYnV0IGl0DQpzZWVt
cyB0aGVyZSdzIG5vIG9iamVjdGlvbiB0byBjaGFuZ2VzIHRvIHRoZSBoZWFkZXJzIHZpc2libGUg
b25seSB0byB0aGUNCmtlcm5lbCksIGJ1dCB0aGUgeDg2IG9uZXMgaGF2ZSBiZWVuIG1lcmdlZDoN
Cg0KICAgICAgeDg2L2hlYWRlcnM6IFJlcGxhY2UgX19BU1NFTUJMWV9fIHdpdGggX19BU1NFTUJM
RVJfXyBpbiBub24tVUFQSSBoZWFkZXJzDQogICAgICB4ODYvaGVhZGVyczogUmVwbGFjZSBfX0FT
U0VNQkxZX18gd2l0aCBfX0FTU0VNQkxFUl9fIGluIFVBUEkgaGVhZGVycw0KDQpTbyBwZXJoYXBz
IHdlIHNob3VsZCB1c2UgX19BU1NFTUJMRVJfXyBmb3IgdGhlIG5ldyBjb2RlLg0K

