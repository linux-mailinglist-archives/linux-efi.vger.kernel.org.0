Return-Path: <linux-efi+bounces-5004-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5254BC6019
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986D1189D325
	for <lists+linux-efi@lfdr.de>; Wed,  8 Oct 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD228B415;
	Wed,  8 Oct 2025 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPVbosO5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E0291C1E;
	Wed,  8 Oct 2025 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940568; cv=fail; b=omQTqk9zq5HeIr211Fdk0rYm50bY256+7HVe7R3/zjgfXECkiiD3y+9AqUjquwPk8lAqJsyznb3roSDAKBygVeo1ObxTKH0xBbt18ajk90lmo0vyRdhprIzo9ts/s8+NWIpGtewdqAQKkoDm2Y2Ulwiv1ulClSOVYs27k96aWcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940568; c=relaxed/simple;
	bh=5601ZRpfcdynOz+ni4QNT5I7AZpOe57EQo9ykWgtjQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XK+tQurbKZudcjLCjgXxBt1giAVfW7y680Fc4QOgqHNqZ5wM77SwytVhMba8Zub5tvGoJ9VGEHYedQDExzCSamEJW5HXp1YkqyJAD6tkOIs92l25RvCIc44CMm/7UAp9B47CpOjGIHmmMCdPtQZ+pvwZgB0Dn4A8SjniVal86iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPVbosO5; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759940566; x=1791476566;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5601ZRpfcdynOz+ni4QNT5I7AZpOe57EQo9ykWgtjQs=;
  b=VPVbosO5R9Xj8kOLjSuAY2VTME8S9OD8v9VJsauwYNhV6RVIYl0Yg0jS
   eXBkz0k2lRPtERo6uQecqYaPbONweFOY1b9RbKXmPtdDpROhFt1WJmR+v
   /lSIDn2DfKIt1kE5+4zZLO1W7Zcsed1zneqpY2K0Y/E0H5ptCLEBnBijT
   hKtl86dNQCmI32IbtsUjsNG/19GUS0aIpLBAYyP+GZqlpLfqWaOLNyLpa
   WasWxQFLzJX9VE/h4uwQEwW3xjNv3h4aA/gwU/uvoBVlvtmJ2xDVXQ+9P
   ng6D7d20ubx/C3ynQpOrdp42EqJckvwE2VZpTUxb2RrcTOpoXDi3tBJ1P
   A==;
X-CSE-ConnectionGUID: RSJoDq/5SPypIJoJJSuAig==
X-CSE-MsgGUID: pUv3DDdrTe6neItKkUAQiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73569234"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="73569234"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 09:22:45 -0700
X-CSE-ConnectionGUID: 7nyR7CHxQuK7nA8n8H+MOQ==
X-CSE-MsgGUID: pXS5BX92SMuckBSc3fRgOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="180076282"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 09:22:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 09:22:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 09:22:44 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 09:22:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9l608TqKWW9hf6JZ/Qrd10f9vMJ8YKDkEh+9qmsJSqd9sX2wv0s59FQz3GOVlc3k2CROtgTwFt9BSAkAkrr3U/cuk+KHdnU0DJlGBMIaFlOKUzNeV0OvHF98JMo88xiDk2yJPLd3WZFGcntmE7R9TnfInruLfLlWT1VHRhs6nfyp5uUN3/A5e/uSp87v0oqUJf5O7135jiOyIk/M2rnGf1OOwc7RxmgsC7O6mlGAi+HskfSaDgkeZAuU1LmkM+jp74eIrnZcwr+JPEEOwk7Djm7+ziNpGGk7O20InUiZLXpOvm32InYPjPuzpzTOIwGRF4uXXbDRBU4Y/ixu861Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5601ZRpfcdynOz+ni4QNT5I7AZpOe57EQo9ykWgtjQs=;
 b=Wljwhg9LWlqWfy3dvtOPapmoHZqq59HkPk7vqI4cwR5SSMVDce2BWXjsMaEh59iJh9mXiH4BuKKb53erl+aEm1oialbtL5n9fv0ga2bOYU718iAlAMLpmeiUESxxywBP90Po/f1H/bZK7HKIxlOKgUI+XpaGNDOaJ0th7Yc43MEzGSYG0X107yhB+bXSN8uHph3yVqgiFuMRMGWo/s7cGQv7WB+UBUrj7q8ndYfve8YxrN+WnHymUEmPHWrXrknFf3uTeMfq6WskoYvb5HV3eqKxwbC7vEz5BAGwj/ksqQma39ZTgh+FU++bHyJqeOeAI55MHbmL6r38+7kcQHrEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) by
 DM3PPF8F79256C7.namprd11.prod.outlook.com (2603:10b6:f:fc00::f37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Wed, 8 Oct
 2025 16:22:41 +0000
Received: from DM4PR11MB5970.namprd11.prod.outlook.com
 ([fe80::e9b1:6f0f:1a91:2c79]) by DM4PR11MB5970.namprd11.prod.outlook.com
 ([fe80::e9b1:6f0f:1a91:2c79%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 16:22:41 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "tglx@linutronix.de"
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
Subject: Re: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Thread-Topic: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Thread-Index: AQHcN1cvIlCMw/NuHEiY4j7oPv0k3LS256gAgABdHoCAASwUAA==
Date: Wed, 8 Oct 2025 16:22:40 +0000
Message-ID: <2ac89a5fc103f895a185010f11c81014dcb58d9b.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-4-sohil.mehta@intel.com>
	 <9240edbe689108f920d4b0c5c786278aea47d1d2.camel@intel.com>
	 <07cce6e1-db01-46ad-9848-80cc96f3b468@intel.com>
In-Reply-To: <07cce6e1-db01-46ad-9848-80cc96f3b468@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5970:EE_|DM3PPF8F79256C7:EE_
x-ms-office365-filtering-correlation-id: a966f563-e765-49e2-e1ea-08de0686e743
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UUQ2dCswSTQ3aUgycEErb29Tcmc3LzhLdmRTMVJlTHFSSDQ3QkNkK1h4ZVEy?=
 =?utf-8?B?cU9TdUdQNTcxSVVDaUJBZ0tiQWQzODl2bEFuQzdXdHN6NDdGbzM5anVyUDJt?=
 =?utf-8?B?Rnp0cHY0S1FUcTU5Qnc2ZGl1RDhucGs1RFhiVGpySDJ6anF4eTVsa1hXZUdC?=
 =?utf-8?B?ZDF1Unp5c2xYdUpsdWM2UEIvRGJLTW5nSEFtL1lLemNTam8yTWNqK0V0Rktt?=
 =?utf-8?B?NmI0R2hmVjJjY0oralRHNDZ2UndVMVd3YnpjaS9YNDFKcE9Jc1hLeURTSSti?=
 =?utf-8?B?WXZKdFByeHBPZFlObFd4dE8xVmtNUGlFSm53RDJzT1Q3eDlSN2FjdU53V05a?=
 =?utf-8?B?ZXFlSkpKamU0UXQyTm45VjZlbmRWdE43N1NrMFdwbmFBMXhyR0dzemR2RlpG?=
 =?utf-8?B?bFUzc1p1NWp0Y0o4d0xHaENJS1JEZEpidWM5dmk3ZzJFdmdtM0lDNHJlY3Bn?=
 =?utf-8?B?WExVZUhXMUdlVjB3OVA0Wlpsc2Y5eDM1cFVteDlhZkp5SWhBTGYrdkU0WGox?=
 =?utf-8?B?NlhsTkJrTTg4MHRBNmYxTENPcXN0ZWNBUjZTMFdFcU9aTFdRaEs3eHhaM0dW?=
 =?utf-8?B?TXJpQm03dEFTVzNQUnM2ZVFTWGZlWHAwV01KQkJpcTUvc0d3aTkyUFFNdDIv?=
 =?utf-8?B?SGFrbEZJbmM4c3JWYWZta0dVYWVJb001cjVUaWg0UFEzc1ZTclRrQ0h1T3gy?=
 =?utf-8?B?VGJiMXk1NDFNK3ZMRGw4dFJZWFlmSGR4NmFnbFArdGI0aFVSQXhOU2VoeVls?=
 =?utf-8?B?ck9ySEhtbGczRTBYOTN5WDhyRlJ0dmZvZUFkVGNsWmV6Z3Q2T3ZUdjVDSURO?=
 =?utf-8?B?WThyQXN5Z1hzYUs4c2k5WGhYUHIrVkdCNC9lVGVUamQxWW84VDVjZFlObm42?=
 =?utf-8?B?TkM0d093a2ZPbFM3TUdTRzlwb00zdHdObFNCZXcyWTZNMExYT0FheWpGU2Nl?=
 =?utf-8?B?NzhQTHVtRkhYVEJJbVYxVlBDMDNSa3NZZUlYQkFiSEZ1UEJUekNrcjhPUktM?=
 =?utf-8?B?SUZ1aTM0NWdEemtPVjdxd1gvTnJ2d3dWRlVmQ2ZLeDRldjkyYUY5eEtYSjQw?=
 =?utf-8?B?WFBTclhzclJFWnRCWDlWYVJkN0JKc29qY2NmZXJsamlDSEFFcjF2TklIbFlo?=
 =?utf-8?B?dS9tMTRyNUhrY1V2NFdKbysrU09RWVg4Q215NjltOXcvajlWL0o3ajZzQVlG?=
 =?utf-8?B?OG5tK2Q5TkFyK3E0TkpWMTA1UVpKcXl6SXVxTWx5MWp1V084TlFpY0V1OGRV?=
 =?utf-8?B?N1RaYTJoV0c2ZC9ZbS9jdUVXbFk1KzlnS1VKVHExc3JZSHUra1BSb1lUTEhE?=
 =?utf-8?B?ekI5emN5ZTB4Mkg0aFJremhLYXhYdjNhTjNxZGRtYXVvNzJQQS9rNEFnZE5z?=
 =?utf-8?B?cDN2WUpwZ09HcUlaM0IxaVNEL0tWSjlqaWlkRmtmZDVLL1RDVXFBYmU0T1Ew?=
 =?utf-8?B?ZXNIZkRRdWZXM0tKOUJFRlBDRnZkWnY0Uk5WS2kxOTFIUW45MS9xblh2MDh2?=
 =?utf-8?B?ZTlwQnpOWmxiSW1zN3UzUlVQWjVHQldGRVlHWUFmNi8yeFNtL2RJL05DaWp6?=
 =?utf-8?B?YklBaythbFFVQjY2TVMvUVkvcldhYllUNVRZc1hxWkNtbXpkR1JRVG02MEJB?=
 =?utf-8?B?bENCV0djTlFCTGNkSGFyRkxMWGloYTRvZ3U0V05zcVduWW91QkFNNHBnUS90?=
 =?utf-8?B?UFU2Y0o1Z3ZWbUY3Vi9EaTJESjZrcVdnSzFSVi9jd29NRzMwOWNiOWpCNjdO?=
 =?utf-8?B?bkgyYkZpcnlxNk95NDUvYXJxRThmOEoyYUxIYldESmw2TEtOd3N0TWYxaFpG?=
 =?utf-8?B?VnBTLzZuTzFzcFBmVkorL1FvMDkwNmdFWEZlLzdRL1p3RkdlTGtzSXFDVHVu?=
 =?utf-8?B?Yy9uWFBGMzR4RVZMU2dGMG00dSttTFhzSXVHRWxWSER0eEtMQkxuYmt2QmI3?=
 =?utf-8?B?NEFMNk0xanNtb0ZEdExMeGxTN0VrYTdoSXdXbDRRR3ExbDQ0bGxGUUtyWWhO?=
 =?utf-8?B?bW1ocDRGTElTajV6MUpHaHdpR0NobmsyQkFUaVJ3OEU1OWFHczYzSS9IM3I4?=
 =?utf-8?Q?IlQA6q?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5970.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zjl5UmwrditXZFVwUCtFTFZKc09xcXhrcWtIcjdKYkRzRjUwNkJpK1c0N1dr?=
 =?utf-8?B?T1NNZXBjQzNpZGNEZldMWTNYRDlzdTdiMTY1RUlyS1JPN0xKK0xpRnhUS1N2?=
 =?utf-8?B?MVZ3azFzdkRpUTR1NCtnZ3Z4RklXSzZaMkpzbjJqQnhXV1lHcWFhYUZkVEdT?=
 =?utf-8?B?Vk9FV2p4S1VuWVAyeTFtZlI2cHh1aVBRZGZRK1d5VlhRek95cEFxM1ZXTnhD?=
 =?utf-8?B?a3U1Wm1KankwQUlWUForZWVyWjRKRlhzUml0Mnh4ZHhvZmdwd3FLVzYzTXMx?=
 =?utf-8?B?dFluTkpGZ2lLVDAwUUdOcDFuSks1SWFCT29VeVZKdDFSb3BLdG50cUJSWTZr?=
 =?utf-8?B?TXVIN29YTFlkUnZzdUFSZnB3Z0lycnJxNlcrRWJNN3FIaG42WURjOUZBaG5u?=
 =?utf-8?B?WXp3MU42L21reXQxc1hOSVlXcDhRazBNSFJRV2pWZktTUTByTXRMazhoYWRr?=
 =?utf-8?B?SDRra3BIZnlnQUIzT2JJNEhad2k5eXZlczcwMEJrMnVsckpWbWtXUHJVRmpL?=
 =?utf-8?B?RVVVL0lXQ3pOSkNvMU9tbXpSTGpobDlRRDcrWVNjVjgxNnQzZXdvL2FmSWl5?=
 =?utf-8?B?d2FtRDdIc2FOaVdzODdZeWdZbWpvUkVJZytyQkZHZWtIVW9saTVnZ1cvdEE0?=
 =?utf-8?B?REdzS1RHWUFtRFp2aW9JeXdEZW1RUXJnNzl6Y1ZWN3p5QkltV1Areno5YjRW?=
 =?utf-8?B?Njc1M0NFa1JJZ2VjSFdzaXhkOHF1cHY5ZnV5aHJ6R2NERVZCeFJkTUE0YnQx?=
 =?utf-8?B?ZkttUHdKODRhNDdnWU9Ma2hvYndXM2pMcE5uNnAwM1BuS3ByVGM3TmthRk9S?=
 =?utf-8?B?YkQ1NVpUeVVrNHo2QllmMEhqZkxNV3dtbStDWjZLa1JodWtqV01rWjdkTExK?=
 =?utf-8?B?UXpCWTdJM1RSZUpFOWpCRHM2dVlaVmtoMTR5ZVNuc0JXOTJmbU9sMHlndG0y?=
 =?utf-8?B?NWFKYTJxZkE1R2NwYUVtdkVRMVljRXFIUkxHUTZhdHJLME10Z3c0WkFqSUd2?=
 =?utf-8?B?YzJPV0RHZHdVdW94Z1E2dGE3WUxkd2RmTUVmd096d1JZTEkrZERpQktMaEUy?=
 =?utf-8?B?S2RiN043QXJwdk14NElwNUEwS3h1d3hTaGo4TEpHSlhJR1NzSks3SFVkWDU3?=
 =?utf-8?B?UjFvWGhwemVaOWlwaGJsZzVEUzc3bHM3ZXBhbjdrN3UrUXdBNzJTSnpaTkFn?=
 =?utf-8?B?M0JnMEhWRTFaT0c5L0hJaStqU2JGSXlBYWZXYTBEWHJmZkpTcGJScGNoQlhi?=
 =?utf-8?B?dGRBcFBVZzFzQ3kxZ2ZYL0tIN0ZOWnNEQ1N5L3JsNEI3YmJPKzd1TjhZM0t0?=
 =?utf-8?B?bXNOVUNJaTNUZDFyMXIzYTVXbWl4ZytDTm5xZzJtd1ptRm9ma05kSy9BWW1o?=
 =?utf-8?B?LzdWY0xyQTlST2sxb0hNYkFqdktTTnAwMWpOYWYzUlRFUGQ2TmQzcUVHTlpO?=
 =?utf-8?B?MUVnVVZYQ1pRL3ZNN1RlQTNDSTFYdENwWUY0N2tVSmlCb1NPQ0Z2MzVtbGR5?=
 =?utf-8?B?dDhzK0tGbmFwa3gxZjJIM3VWdWpuanVGT1pBejFuR0ZIbUtHWGFqVVZ4RHZn?=
 =?utf-8?B?blI0ZDh0UHBib2xiMnZ1bmtEMDJLM1pLNW9BcXhtQUxtdGZNajV3WUY4clZM?=
 =?utf-8?B?ODF4MWNZY2xKWG1sY2ZXYWVQSmdYTVpzS05HS2ZGVXdlU3NNZHJiYkxFeEFB?=
 =?utf-8?B?dklIdXMxNHJsNUtEZUpSdTdMY0tnNldyYlBaYzlXYnR6L2IzRDhaYWFSWEJa?=
 =?utf-8?B?K2xzWDFmNDJaaEp3d25NeUJWTU1FUDdNb0lEZGdjMEtlbUZoQlhHNnNOM2Ry?=
 =?utf-8?B?ZFhOMEx5d3NiRFNhNklCb2I2ZmU2OFBzY0U5TUxLV1VaalNvaURVaDNiV3Zh?=
 =?utf-8?B?enZ6U3lrOEp3MGlBR2s3T29DN25ld0xJTm91T2U2SlVFUUpJd3hNRys3azMr?=
 =?utf-8?B?dFM3OHZZOWJJaytLanpaSFNMb0JJK3dKbmVyRFdmVlhCZitWblMrWHBsNXBw?=
 =?utf-8?B?WmJGZEpMZmNSMnFtNUF0QWdTTjFQWlA0cGUwVllRL0NnMU5tbUIzQ0Rqa3Bj?=
 =?utf-8?B?RElGN0ljeE5yOXdjcWFiRUF2UEdoYm5BN2RSNEtTL1J0UkxURDFpcnNvWGly?=
 =?utf-8?B?aWFic2VROGUwampLMzZDUjhhbkZSRnlsRk42bWRldytaOGR4OHNkZkJZZlM2?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85BD8DC6B2847847B1560BC05B2F895C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5970.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a966f563-e765-49e2-e1ea-08de0686e743
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 16:22:40.8411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvDlURY/BozXThmjlYJUvcGIDwY489rFdZlWc0ZN34wsHvzJYoejckee6/rdpw4lJWvcmkjMvsYdlzgLXzKqQvYqd+b9KdAcA/USA10m7qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF8F79256C7
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTEwLTA3IGF0IDE1OjI4IC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
T24gMTAvNy8yMDI1IDk6NTUgQU0sIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiA+IEl0J3Mg
bm90IGp1c3QgdXNlZCBmb3IgYWx0ZXJuYXRpdmVzIGFueW1vcmUuIGJwZiwga3Byb2JlcywgZXRj
IHVzZSBpdCB0b28uIE1heWJlDQo+ID4gZHJvcCAiYWx0ZXJuYXRpdmVzIiBmcm9tIHRoZSBzdWJq
ZWN0Pw0KPiA+IA0KPiANCj4gWWVhaCwgSSB3YXMganVzdCBiZWluZyBsYXp5LiBUaGUgZmlsZSBp
cyBzdGlsbCBjYWxsZWQgYWx0ZXJuYXRpdmVzLmMgYW5kDQo+IHRoYXQncyBwcm9iYWJseSB3aGF0
IG1vc3QgZm9sa3MgYXJlIGZhbWlsaWFyIHdpdGguDQo+IA0KPiBIb3cgYWJvdXQ6DQo+IHg4Ni90
ZXh0LXBhdGNoaW5nOiBEaXNhYmxlIExBU1Mgd2hlbiBwYXRjaGluZyBrZXJuZWwgY29kZQ0KDQoi
eDg2L2FsdGVybmF0aXZlczogRGlzYWJsZSBMQVNTIHdoZW4gcGF0Y2hpbmcga2VybmVsIGFsdGVy
bmF0aXZlcyINCg0KSSBtZWFudCB0aGUgbGFzdCByZWZlcmVuY2UgdGhlcmUgXi4gSSB0aGluayB0
aGUgIng4Ni9hbHRlcm5hdGl2ZXM6IiBwYXJ0IHNob3VsZA0KbWF0Y2ggdGhlIHJlc3Qgb2YgdGhl
IGNvbW1pdHMgdG8gdGhlIGZpbGUuDQoNCiJ4ODYvYWx0ZXJuYXRpdmVzOiBEaXNhYmxlIExBU1Mg
d2hlbiBwYXRjaGluZyBrZXJuZWwga2VybmVsIGNvZGUiIHNvdW5kcyBtb3JlDQphY2N1cmF0ZSB0
byBtZS4NCg0KPiANCj4gPiANCj4gPiBUaGUgYWJvdmUgdmFyaWFudCBoYXMgImEgYmFycmllciBp
cyBpbXBsaWNpdCBpbiBhbHRlcm5hdGl2ZSIsIGlzIGl0IG5vdCBuZWVkZWQNCj4gPiBoZXJlIHRv
bz8gQWN0dWFsbHksIG5vdCBzdXJlIHdoYXQgdGhhdCBjb21tZW50IGlzIHRyeWluZyB0byBjb252
ZXkgYW55d2F5Lg0KPiA+IA0KPiANCj4gWWVzLCB0aGUgc2FtZSBpbXBsaWNhdGlvbiBob2xkcyB0
cnVlIGZvciB0aGUgTEFTUyB2ZXJzaW9ucyBhcyB3ZWxsLg0KPiBJIGFzc3VtZSBpdCBpcyB0byBs
ZXQgdXNlcnMga25vdyB0aGF0IGEgc2VwYXJhdGUgbWVtb3J5IGJhcnJpZXIgaXMgbm90DQo+IG5l
ZWRlZCB0byBwcmV2ZW50IHRoZSBtZW1vcnkgYWNjZXNzZXMgZm9sbG93aW5nIHRoZSBTVEFDL0NM
QUMNCj4gaW5zdHJ1Y3Rpb25zIGZyb20gZ2V0dGluZyByZW9yZGVyZWQuDQo+IA0KPiBJIHdpbGwg
YWRkIGEgc2ltaWxhciBub3RlIHRvIHRoZSBsYXNzX2NsYWMoKS9zdGFjKCkgY29tbWVudHMgYXMg
d2VsbC4NCg0KVXAgdG8geW91Lg0KDQo+IA0KPiA+IE5vdCBhIHN0cm9uZyBvcGluaW9uLCBidXQg
dGhlIG5hbWluZyBvZiBzdGFjKCkvY2xhYygpIGxhc3Nfc3RhYygpL2xhc3NfY2xhYygpIGlzDQo+
ID4gYSBiaXQgY29uZnVzaW5nIHRvIG1lLiBzdGFjL2NsYWMgaW5zdHJ1Y3Rpb25zIG5vdyBoYXMg
TEFTUyBhbmQgU01BUCBiZWhhdmlvci4NCj4gPiBXaHkga2VlcCB0aGUgc21hcCBiZWhhdmlvciBp
bXBsaWNpdCBhbmQgZ2l2ZSBMQVNTIGEgc3BlY2lhbCB2YXJpYW50Pw0KPiA+IA0KPiA+IFRoZSBv
dGhlciBvZGQgYXNwZWN0IGlzIHRoYXQgY2FsbGluZyBzdGFjKCkvY2xhYygpIGlzIG5lZWRlZCBm
b3IgTEFTUyBpbiBzb21lDQo+ID4gcGxhY2VzIHRvbywgcmlnaHQ/IEJ1dCBzdGFjKCkvY2xhYygp
IGRlcGVuZCBvbiBYODZfRkVBVFVSRV9TTUFQIG5vdA0KPiA+IFg4Nl9GRUFUVVJFX0xBU1MuIEEg
cmVhZGVyIG1pZ2h0IHdvbmRlciwgd2h5IGRvIHdlIG5vdCBuZWVkIHRoZSBsYXNzIHZhcmlhbnQN
Cj4gPiB0aGVyZSB0b28uDQo+ID4gDQo+ID4gSSdkIGV4cGVjdCBpbiB0aGUgcmVhbCB3b3JsZCBM
QVNTIHdvbid0IGJlIGZvdW5kIHdpdGhvdXQgU01BUC4gTWF5YmUgaXQgY291bGQgYmUNCj4gPiB3
b3J0aCBqdXN0IGltcHJvdmluZyB0aGUgY29tbWVudCBhcm91bmQgc3RhYygpL2NsYWMoKSB0byBp
bmNsdWRlIHNvbWUgbm9kIHRoYXQNCj4gPiBpdCBpcyBkb2luZyBMQVNTIHN0dWZmIHRvbywgb3Ig
dGhhdCBpdCByZWxpZXMgb24gdGhhdCBVU0VSIG1hcHBpbmdzIGFyZSBvbmx5DQo+ID4gZm91bmQg
aW4gdGhlIGxvd2VyIGhhbGYsIGJ1dCBLRVJORUwgbWFwcGluZ3MgYXJlIG5vdCBvbmx5IGZvdW5k
IHVwcGVyIGhhbGYuDQo+ID4gDQo+IA0KPiBMQVNTIChkYXRhIGFjY2VzcykgZGVwZW5kcyBvbiBT
TUFQIGluIHRoZSBoYXJkd2FyZSBhcyB3ZWxsIGFzIHRoZQ0KPiBrZXJuZWwuIFRoZSBTVEFDL0NM
QUMgaW5zdHJ1Y3Rpb25zIHRvZ2dsZSBMQVNTIGFsb25nd2l0aCBTTUFQLiBPbmUNCj4gb3B0aW9u
IGlzIHRvIHVzZSB0aGUgY3VycmVudCBzdGFjKCkvY2xhYygpIGluc3RydWN0aW9uIGZvciBhbGwg
Y2FzZXMuDQo+IEhvd2V2ZXIsIHRoYXQgd291bGQgbWVhbiB1bm5lY2Vzc2FyeSBBQyBiaXQgdG9n
Z2xpbmcgZHVyaW5nDQo+IHRleHQtcGF0Y2hpbmcgb24gc3lzdGVtcyB3aXRob3V0IExBU1MuDQoN
CkhvbmVzdGx5LCBqdXN0IHVuY29uZGl0aW9uYWxseSBkb2luZyBzdGFjL2NsYWMgZG9lc24ndCBz
b3VuZCB0aGF0IGJhZCB0byBtZS4gV2UNCmFscmVhZHkgdW5jb25kaXRpb25hbGx5IGVuYWJsZSBT
TUFQLCByaWdodD8gSWYgdGhlcmUgd2FzIHNvbWUgYmlnIHNsb3dkb3duIGZvciBhDQpzaW5nbGUg
Y29weSwgcGVvcGxlIHdvdWxkIHdhbnTCoGFuIG9wdGlvbiB0byBkaXNhYmxlIGl0LiBBbmQgd2l0
aCB0ZXh0IHBhdGNoaW5nDQppdCdzIHBhcnQgYSBoZWF2aWVyIG9wZXJhdGlvbiBhbHJlYWR5Lg0K
DQpXYXMgdGhlcmUgcHJldmlvdXMgZmVlZGJhY2sgb24gdGhhdCBvcHRpb24/DQoNCj4gDQo+IFRo
ZSBjb2RlIGNvbW1lbnRzIG1haW5seSBkZXNjcmliZSBob3cgdGhlc2UgaGVscGVycyBzaG91bGQg
YmUgdXNlZCwNCj4gcmF0aGVyIHRoYW4gd2h5IHRoZXkgZXhpc3QgdGhlIHdheSB0aGV5IGRvLg0K
PiANCj4gPiA+IC8qIFVzZSBzdGFjKCkvY2xhYygpIHdoZW4gYWNjZXNzaW5nIHVzZXJzcGFjZSAo
X1BBR0VfVVNFUikNCj4gPiA+IG1hcHBpbmdzLCByZWdhcmRsZXNzIG9mIGxvY2F0aW9uLiAqLw0K
PiA+ID4gDQo+ID4gPiAvKiBVc2UgbGFzc19zdGFjKCkvbGFzc19jbGFjKCkgd2hlbiBhY2Nlc3Np
bmcga2VybmVsIG1hcHBpbmdzICghDQo+ID4gPiBfUEFHRV9VU0VSKSBpbiB0aGUgbG93ZXIgaGFs
ZiBvZiB0aGUgYWRkcmVzcyBzcGFjZS4gKi8NCj4gRG9lcyB0aGlzIGxvb2sgYWNjdXJhdGU/IFRo
ZSBkaWZmZXJlbmNlIGlzIHN1YnRsZS4gQWxzbywgdGhlcmUgaXMgc29tZQ0KPiBwb3RlbnRpYWwg
Zm9yIGluY29ycmVjdCB1c2FnZSwgYnV0IERhdmUgd291bGQgcHJlZmVyIHRvIHRyYWNrIHRoZW0N
Cj4gc2VwYXJhdGVseS4NCj4gDQo+IEkgY2FuIGFkZCBtb3JlIGV4cGxhbmF0aW9uIHRvIHRoZSBj
b21taXQgbWVzc2FnZS4gQW55IHByZWZlcnJlZCB3b3JkaW5nPw0KPiBBbHNvLCB0aGUgc2VwYXJh
dGUgcGF0Y2ggdGhhdCBEYXZlIHJlY29tbWVuZGVkIHdvdWxkIGhlbHAgY2xhcmlmeSB0aGluZ3MN
Cj4gYXMgd2VsbC4NCg0KTm8gcHJlZmVyZW5jZS4gVGhlIG1haW4gY29tbWVudCB3YXMganVzdCB0
aGF0LCBhcyBzb21lb25lIGxvb2tpbmcgYXQgdGhpcyBwYXJ0DQpmcmVzaCwgaXQgd2FzIGEgbGl0
dGxlIHVuY2xlYXIuIEVzcGVjaWFsbHkgd2l0aCB0aGUgbm9uLW9idmlvdXMgU01BUC1MQVNTIGxp
bmsuDQoNCj4gDQo+ID4gPiAgDQo+ID4gPiArLyoNCj4gPiA+ICsgKiBUZXh0IHBva2luZyBjcmVh
dGVzIGFuZCB1c2VzIGEgbWFwcGluZyBpbiB0aGUgbG93ZXIgaGFsZiBvZiB0aGUNCj4gPiA+ICsg
KiBhZGRyZXNzIHNwYWNlLiBSZWxheCBMQVNTIGVuZm9yY2VtZW50IHdoZW4gYWNjZXNzaW5nIHRo
ZSBwb2tpbmcNCj4gPiA+ICsgKiBhZGRyZXNzLg0KPiA+ID4gKyAqDQo+ID4gPiArICogQWxzbywg
b2JqdG9vbCBlbmZvcmNlcyBhIHN0cmljdCBwb2xpY3kgb2YgIm5vIGZ1bmN0aW9uIGNhbGxzIHdp
dGhpbg0KPiA+ID4gKyAqIEFDPTEgcmVnaW9ucyIuIEFkaGVyZSB0byB0aGUgcG9saWN5IGJ5IHVz
aW5nIGlubGluZSB2ZXJzaW9ucyBvZg0KPiA+ID4gKyAqIG1lbWNweSgpL21lbXNldCgpIHRoYXQg
d2lsbCBuZXZlciByZXN1bHQgaW4gYSBmdW5jdGlvbiBjYWxsLg0KPiA+IA0KPiA+IElzICJBbHNv
LCAuLi4iIGhlcmUgcmVhbGx5IGEgc2VwYXJhdGUgaXNzdWU/IFdoYXQgaXMgdGhlIGNvbm5lY3Rp
b24gdG8NCj4gPiBsYXNzX3N0YWMvY2xhYygpPw0KPiA+IA0KPiANCj4gVGhlIGlzc3VlcyBhcmUg
aW50ZXJkZXBlbmRlbnQuIFdlIG5lZWQgdGhlIFNUQUMvQ0xBQyBiZWNhdXNlIHRleHQgcG9raW5n
DQo+IGFjY2Vzc2VzIHNwZWNpYWwgbWVtb3J5LiBXZSByZXF1aXJlIHRoZSBpbmxpbmUgbWVtY3B5
L21lbXNldCBiZWNhdXNlIHdlDQo+IGhhdmUgbm93IGFkZGVkIHRoZSBTVEFDL0NMQUMgdXNhZ2Ug
YW5kIG9ianRvb2wgZ3VhcmRzIGFnYWluc3QgdGhlDQo+IHBvdGVudGlhbCBtaXN1c2Ugb2YgU1RB
Qy9DTEFDLg0KPiANCj4gV2VyZSB5b3UgbG9va2luZyBmb3IgYW55IHNwZWNpZmljIGNoYW5nZSB0
byB0aGUgd29yZGluZz8NCg0KQWggb2ssIGJ1dCB0aGUgY29tcGlsZXIgY291bGQgaGF2ZSBhbHdh
eXMgdW5pbmxpbmVkIHRoZSBleGlzdGluZyBtZW1jcHkgY2FsbHMNCnJpZ2h0PyBTbyB0aGVyZSBp
cyBhbiBleGlzdGluZyB0aGVvcmV0aWNhbCBwcm9ibGVtLCBJIHdvdWxkIHRoaW5rLg0KDQpCdXQg
dGhhdCBsaW5rIHNvdW5kcyBzdHJvbmcgZW5vdWdoIHRvIGRvIGl0IGluIG9uZSBwYXRjaC4gSWYg
aXQgd2VyZSBtZSBJIHdvdWxkDQpub2QgYXQgdGhlIGV4aXN0aW5nIHRoZW9yZXRpY2FsIGlzc3Vl
Lg0KDQo+IA0KPiA+ID4gIHN0YXRpYyB2b2lkIHRleHRfcG9rZV9tZW1jcHkodm9pZCAqZHN0LCBj
b25zdCB2b2lkICpzcmMsIHNpemVfdCBsZW4pDQo+ID4gPiAgew0KPiA+ID4gLQltZW1jcHkoZHN0
LCBzcmMsIGxlbik7DQo+ID4gPiArCWxhc3Nfc3RhYygpOw0KPiA+ID4gKwlfX2lubGluZV9tZW1j
cHkoZHN0LCBzcmMsIGxlbik7DQo+ID4gPiArCWxhc3NfY2xhYygpOw0KPiA+ID4gIH0NCj4gPiA+
ICANCj4gDQo+IA0KDQo=

