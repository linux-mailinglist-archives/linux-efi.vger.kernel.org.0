Return-Path: <linux-efi+bounces-5003-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BC0BC5F31
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 18:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162914064B9
	for <lists+linux-efi@lfdr.de>; Wed,  8 Oct 2025 16:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974829B233;
	Wed,  8 Oct 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUeIG2tD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145978F3A;
	Wed,  8 Oct 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939250; cv=fail; b=tAcJdhZ2BHWpgQiFZR3BcItOzXB7OnuO6GnCfNf/y5eYdBINhlcBXi5pP3AA5sN9Kcmu/md60ysfxEula2gL/6FcL3W2dy/fZxEbDxomLezmU7zwj0CTITIH+dQ5l0pPjsDhMtZWhbjzD997yoLkuwDjQZqO3qjXqcluOBbJQgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939250; c=relaxed/simple;
	bh=p5osHn9bPLuBqZY1oL0h7tK2r7+FK94Sge5EeXXvy5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tileJr60NGQ4pM8d0gyTNnqBlmumq7vVwvPki/RzTS/JjH/dD/3EhRHvHgDcc50JMQ3LNoVEFFB9nhvfE2VwteKmQWBlrv2ZLCusZ7ViH/iCpZQHfX+i8p/DeJz55E8jjNW8snSdLXuyzjfB+AF0pKilDZOu6Fq3esf3GrOMows=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUeIG2tD; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759939249; x=1791475249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p5osHn9bPLuBqZY1oL0h7tK2r7+FK94Sge5EeXXvy5A=;
  b=lUeIG2tDYqIBAd8JZxCl+b6oQI5JeCwuHqYV1uCZejxqIblv8zTvAZdz
   ONJfXWVa7JkIlCdKThYL2so83a3W9TRG+PLsN5pIK50AzH05Ou7nfzvim
   lpMMnpLzOruZ2jairXqFH2zXx/NoXdisx/Uc0vJauEjtHOnsJMz0R/iJ2
   nvT2smt5DuvtV5CEcEZWboiR50Rmj5StRmTRADAr5yLDZ83tZbXmRMGEW
   kBXiZcKzlbF9efIAB+ng3rjaomJqhRct2YyS3DF7cKz5QTshAMUivxU0t
   t0wK/pR/L3gtjt7toDVj1Dl5+bZC0/142Q4QdCfhnFNHsLqZfPOyQPwvW
   g==;
X-CSE-ConnectionGUID: BMYYSctASEyJ6jUOWVwDNQ==
X-CSE-MsgGUID: P8gI9UMQT9u0O4BddK20vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="87600408"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="87600408"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 09:00:48 -0700
X-CSE-ConnectionGUID: YTfBySUaSbC3H4LMZcImtQ==
X-CSE-MsgGUID: J2q+jJQ5TGWFS0BAUfWeBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="217576051"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 09:00:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 09:00:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 09:00:46 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 09:00:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJX+fsMtaXm7KsBlzz2fZMOwxbcjqX09XHf4P8f6bjDkk/n12T2eajyLqWpJMjNeXJvECqY0C87GLiDS83daZ+n0BS2OLk+O8zUnfFSHdi8Y7MHwN/Igay6Wsefzr+DFh21ugVWEH7amXZg1wlCVz4nLf4STxNP1DwDjOedLvrS0ewBfEnksmmKl3wkVBZ8xgJ9o0+bM6c87MQs22HeDm1Uqn4fI329mOMJT1ctFs74a3b7qe6G1FYP6uAIrhrBeWq+/WBN2w8mtX6sVusEbbtfmd5jiQbxXHu/YURZCBdWcaB7zTerpA4R6MbTBoTvAufwghpPlMwVCrayspzT7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5osHn9bPLuBqZY1oL0h7tK2r7+FK94Sge5EeXXvy5A=;
 b=pqKJTmQRO/HVBk9DZN5S2FAOhH0c6cNKpmzCjaUKXGMpJwn2k8OKPDKLwqnXb5lONVyCD9zHGs3NIJVZC8KuOHI1EGSd6pJs+JL9vH2fm7uRaN3DlicASaAgxu3JQPG12SKdvkfJ5KTrAIB6srhKj5Z160uWoSH5SL+cCp9a5DruNhHYwlgzmM4MRQL7BNbWBH+H4EI0u24Kkd56BBnd9IU1DOeSei6WdoraN8syQ1QIECI6FmnqzXc2szmQoSzX+QN0gPz/WQ28oCVN9QCJcrmq5YoBV/pbvR48798eQQRd2tyeswXH26izGJihm87uEBJNIU7n624PmSilNQylBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) by
 SJ0PR11MB5151.namprd11.prod.outlook.com (2603:10b6:a03:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 16:00:41 +0000
Received: from DM4PR11MB5970.namprd11.prod.outlook.com
 ([fe80::e9b1:6f0f:1a91:2c79]) by DM4PR11MB5970.namprd11.prod.outlook.com
 ([fe80::e9b1:6f0f:1a91:2c79%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 16:00:41 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org"
	<x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "xin@zytor.com" <xin@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"vegard.nossum@oracle.com" <vegard.nossum@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
Thread-Topic: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
Thread-Index: AQHcN1ctIPgyjz2Uhk2A2Ka753Z4xbS2/zEAgAApzACAACklAIABGJIA
Date: Wed, 8 Oct 2025 16:00:41 +0000
Message-ID: <5236e34ae036ce1ed808ff21c524caa1e67e1701.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-2-sohil.mehta@intel.com>
	 <47fb7efd89698f46a305ca446d0e4471d1f24fbb.camel@intel.com>
	 <e82b48b9-5566-4bf2-9b9e-ee529d59e9b5@intel.com>
	 <7a5a28a3-baf4-4915-8585-eae8cd323895@zytor.com>
In-Reply-To: <7a5a28a3-baf4-4915-8585-eae8cd323895@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5970:EE_|SJ0PR11MB5151:EE_
x-ms-office365-filtering-correlation-id: a21d5703-b3c3-4789-44c1-08de0683d4da
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WmErL0xPMW5GKzNicitVNjdzT3ErVEs5bXJGQmJDaFhmSmdTTis4RG8vMHE3?=
 =?utf-8?B?eTVmWncxQXhtbVNzNFdGdWY0aFhLY3U3RHhldFNFK2JTamE1QVlrajE1cXE5?=
 =?utf-8?B?eVUwOGRobjdXem9PQ2YyMEd3NFBRME54M1dFOHROZE83N21RWUlRdURCM2Fz?=
 =?utf-8?B?cE16LzFTUDhhNWtvZ1c5TEdLQUdHZE1IU1N3NVVZemZVaWJlZTNnWkRDWmhH?=
 =?utf-8?B?TTVzUmIyajdWZEhIT0ZJakxTSWNXQk00VGE5SkIxQVdBa3B4ZmtzdFgwWHhE?=
 =?utf-8?B?OFZ0Q2d6Q2pvanlIbEdQK2wxbGk2NndMOWk4TnovUTB6M0ZSRE4rQldOVWc4?=
 =?utf-8?B?OWhkTFNYVVFndnp2UDlHZWFvNTV5aUJQSDg1Sjg3eFM1YzdEaFR6TXpjeXhF?=
 =?utf-8?B?VE9ERUlxbHkzemZGM1dod0p6MSt0SHkrL0dNRjgzY09USmdVSXNGODJabDFm?=
 =?utf-8?B?d2xIU2M0aTNiOW8raXphMzBIN2lzQy8rYzRFM1kxL1EwNFdvSlZDaTVPK0V2?=
 =?utf-8?B?Q2R6QTgzR1hEd2tvalQrcHZiSTd6dC9EUW80OCtzYmxQMXJLYmVYVnRINHVk?=
 =?utf-8?B?VnVnQ3ZqVmRNNGZNRGNyVlFEWU10ak9HU2k3eUh5amYxajlPNmRXcFcwYnR0?=
 =?utf-8?B?dWRjSXQ5NHpubjlsR3RiZDZyU0RJUFBRNjJGZyt1eFd3b2RlTzByZ0NlMEZ2?=
 =?utf-8?B?c3hpbTZCWTdmWmJLazRSVkNrZWxJWW1CL1JLTS9lUWVrY0tYUGc3RmUyclJ4?=
 =?utf-8?B?ZHM1SkUxTU9reFV2WWJkRDd3WWs3Tjh0ZTFiQmhTNm4zaGFHV1IvRktFbUhz?=
 =?utf-8?B?cjNuNGFpeXB4U084QXZXc2s1MFg2NmZIYnZsMVNMSjRMaUNwZmRPdjdQVFdV?=
 =?utf-8?B?UDNCQVlSck5YVWtFOWM4eUJWVjRiYytid09BdmY5SVB6NC96WHVHQXZUdWtt?=
 =?utf-8?B?L3lmWXprekcvM3V6aWxsV1hDL2JyNHdBK2tzT3Y1QnV4QUlnMDdqL055TklH?=
 =?utf-8?B?VXdIL2JOL013RlE3d0tKYWt2VWRUV3Q3U0dKbVJqU2dPVjYxMlczcGhqc0Ew?=
 =?utf-8?B?V2liRnZSTVVzMi9YejB6dWJYdytOd3FVb3RPUFVMZVIzWHhHMXhrTkN0aGlm?=
 =?utf-8?B?WExoQUpoS0VHWXdMNUMxcGlXbzN6ck5CTndnK2R3RS9Ed0JmTGxGRHVTa2kv?=
 =?utf-8?B?Vk8vTWkwNVVwN3ZEMlg2VXNKT1pUcmo4TUtEUjkyMkNUY0pjOGl1eDNFbFhV?=
 =?utf-8?B?alkxVmdzVlFELzZKcTdNdXdEVy93UDhyaDduSlh1VDF6S0hyQmlYMmhhTERp?=
 =?utf-8?B?dy9WR2FzRkdWdlNoVEJXRXdueCtuV0xpcTBYOHVkSTlhSlh2WjhRU2RqTWc3?=
 =?utf-8?B?UTNaTXJvdEtSOFovWHVuUEJBalF1MFI1dFgxKzdDbUdySmZVRGlaTHRjN1o1?=
 =?utf-8?B?K0p4Z0ExRmFYMzlaZWtlc0s1OWp0bi83L2lTY1pOTjd5WGJnUFRkemNSR01x?=
 =?utf-8?B?N2wyc1crRysvMzJ6MmhYQ1JKU08wWTB3TmFYdTk3RmlHVERaWnROZUlYUXRL?=
 =?utf-8?B?THJXNzlxazhVN1p6ZzAvTXp1R3RxM0dqTFlnQVQ1blNQTE5BdXBUalhNZ0ky?=
 =?utf-8?B?MCtoalVCYWNKc05HckY0cjR4V3lXaENDME9yUEdobktBMWw1UWoyU1lqTlhp?=
 =?utf-8?B?VHJRaWJuVnNGYzhBc3haZGd6NDVaa1A1TUZSNE9wMWFQMG9sUy9WZG9OR1ly?=
 =?utf-8?B?ZWNLVzk2MlBUd3lkaU14bk9KY3RzQUcyeENqcndra3UxaU1FUXBIQjJIVG1K?=
 =?utf-8?B?cFBGRW5PTEdmM3NIRy9udnZGR0hmMzEyb0hKbFFrYmhVTFpwMFRWcGUxOG9n?=
 =?utf-8?B?Qm5YaGJnRlBOL1gwTE5kT0lubXhEd0F4MkNuRkNaQ3ZTQUUyMks5WldxWVNk?=
 =?utf-8?B?TWo1OUZPL3Uxb1pCaXBreng0azZXa3ZtQ0Y2OU00VzlQNC9FMDBEL1d1MzNs?=
 =?utf-8?B?RVBVWVdyWUJ1dk1IWmdmdTZFU05YREJSbFRtVjluSnEyNGVwRi9Sd01zclJ3?=
 =?utf-8?Q?2hYv3a?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5970.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnRlT1NNVFhGNS9vMlpORnN4ckRrVGt0Q21LY3RUVXNZWWpWOTExb1FPQnhG?=
 =?utf-8?B?VGwvajBpQXhoM3p0eUpVU09DcGlPZVdvNU91VjF3MUhrNFVrNzZXcUVNcHhp?=
 =?utf-8?B?VVVhWUFxVUJTN0dpT3lFUFN4SCtwVzZaVSsva0FIYXBWSVJFZkNKb3gxWkM1?=
 =?utf-8?B?Um92R1JYOUdramgvMzJQQkprZE9CdUoyTWdDYmhMemJMYS8zeXJ3cHd6bTFZ?=
 =?utf-8?B?VWhlQjUxUTRtRUlvem5BbXlVTGg1U2hzL3oyYVlxV1RnUk0yRDZKQ1llWTkr?=
 =?utf-8?B?WFpXT0tsQ09xVHVRZi96ekVlZE5vWE5TSGlNa0V2VGlmTFUzSGhLbWNNVE8x?=
 =?utf-8?B?UmM3cU9JZGhWUnI0bXdxd0hGWW02cnBYeVUwYkdPbmNhSW1KVzY1eVNRS21E?=
 =?utf-8?B?LytGVHVkbGE0dmcxb3NUenRXWGh0NEdQRjNCbVZoRGxJVUxVVEdyV1BBaGhT?=
 =?utf-8?B?U1hGMDc2cmMza2xmdkNoWUVaVlQ0R09VVEMyNWpPbXRSU0RWOFB1dy81cWM0?=
 =?utf-8?B?cllRYnZJbTRBR0llZCtqRW5LZFhRd0kyWHVTVkJrSkhuYUtmY3FnK0t1Y2tr?=
 =?utf-8?B?UXdIbC9mS1U2QWZqTHQrNDBvdEdSd291UHFnZDVFWVN2aWUvSzJNSDRUQkg2?=
 =?utf-8?B?a2JmSDFBL0hFb0M2Ukt6aGMvenhZTmMya3Z5aDhoUGE3KzdpT1RzMDludUhv?=
 =?utf-8?B?cThIWmJZcHZHay9GVXVSYWNtaml2bzd2ZVcvb1RtZ1BidDU3VUJSZE9Pb1Bx?=
 =?utf-8?B?eU11L0hQejVRUmZTOEovVmIxcFdEY1VqTHE0Wlhhbm9BMmpyN25KUTFyQnNF?=
 =?utf-8?B?U1VPb2ViR0ZORXIyaWNtejhXMVFYSjBSVGJubmEwckxhUXZZQTc1dWc1dWVp?=
 =?utf-8?B?R1Y2V0ZsL2pISHFyWkVMWTI3RE9rMjFRVU9OZFJrTCtvL1RoMU1EcnFmZlJk?=
 =?utf-8?B?MTBkN09JcGtzanRkc1NHWXN0RmtTOThMdG1iSVZDVFZoNlJsZGdUTlprSDB1?=
 =?utf-8?B?cGhTbGpCV0Z0UE45aGZaeXVqUVJKYWVhMVlQaHY1L3owNXRZK1dVekdyNXZP?=
 =?utf-8?B?dDVMVGNGQlF2bmxCdDNwc0h6NkpqZy9WOC9tSCthSlpEM1VBOWlmaERESEF3?=
 =?utf-8?B?d1pQbU9ranljS0lyNXVqY2dwZDZaMXp4aEMwQ1J1VHFWQS82TFVKa1FZOVV2?=
 =?utf-8?B?VXlMaDJ1WHVNWEhyb0doOEFwSXdvRWtEeFZtbG1wN1hnM3hkVmtUbDVEMnBr?=
 =?utf-8?B?ZnQ5N1pORndhSkFUWVFjMTBMSVQ3cWdCR3gwREYxYWlpenNsWjVpRnZZa0xt?=
 =?utf-8?B?VHZTYjE3M1pqd2Z0UG5LYmxWMEhVNENUcWE4SzU5TkFqN3EyUEkwUFM3MHRO?=
 =?utf-8?B?WjJtaWQrMlpORWU2S01OSW9obDFyanhMTWprTDgyS0VWT01yQ29WZjNJbDhL?=
 =?utf-8?B?MWhyYndwaTNrS1JrRERPd3dEeEJGNmw0N0U1R0I4S2JQdzVubEJLZmJRRmdX?=
 =?utf-8?B?dUFWbm13enpHRFpIbTVjQXFYcUQzaWcwT29rWSt0eWtXeWprUjJCbFhYbnZX?=
 =?utf-8?B?TDRGampDQ0dyMmZmQ2F4cUVMbGVxZ3ZPWS82RmFRc21GdEEySGlWR3FNL3NU?=
 =?utf-8?B?bzAyNysyeWF1SzZJYld1WlR3azA4d2p2NkMzdTZvWVJQNjZrdklHOFJQQVRz?=
 =?utf-8?B?YUhrbXpjc3pyYlR4VG40VU5VU0lBdFdUQVdzWURqT01oUldvTVAzcjA2THJz?=
 =?utf-8?B?YkpSSlZHVm1RbWF3ODJpSUxGRTZvYjFhRmFBZytGTzZjaXZKSndXb3BFaFR5?=
 =?utf-8?B?bzFITmZrNTdZMFVWN0hoaGNVK1cvUENqRXkwVnZQcGNiOWNUMFNRTmFzRXBM?=
 =?utf-8?B?MHY4b0JlWTJwcURwSG1rMnpEVE0rSDNRMDA3SzNBWHA1NDJrSm9PMklmblVT?=
 =?utf-8?B?dHZFSE1pRTJPRlRramlONFhpNVVUVS9ZN2lGQmszTDN0Y0FHdC9RWFlMWUhU?=
 =?utf-8?B?NmY1djNsYnVzWGlMdHJzZ3lHMGFlOVVUblcrUHpIWDlQanY5bkcrUXl3NFJa?=
 =?utf-8?B?dVM4bE43aGY4cXlkeExwdUFBczJWQ3hwd1o2aVNrcXdGRWZLODg4Y3UxYWVu?=
 =?utf-8?B?VnppM09Db2RvWUVJdVN0OTVXQnJKaE5pTmN6VzAySytxRVNGTGN5U0JnSmN2?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A69F5E06772E3E48A58C29FBA6A7B44F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5970.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21d5703-b3c3-4789-44c1-08de0683d4da
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 16:00:41.4660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXR/9DtjJjt6JgqVHKHepeRveSrPGAOzlVWNCBhWcq9i5gIrebsHR3iGdHM1DDE0eJ6sNhCmdP7UueJHHMTnxuMmKtTieIjJfrPGDfcbBe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5151
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTEwLTA4IGF0IDA3OjE2ICswODAwLCBYaW4gTGkgd3JvdGU6DQo+ID4gDQo+
ID4gSSBkb24ndCBoYXZlIGEgc3Ryb25nIHByZWZlcmVuY2UuIEkgZ3Vlc3MgdGhlIGluY29uc2lz
dGVuY3kgbWFrZXMgaXQNCj4gPiBjb25mdXNpbmcgYXMgd2VsbC4gV2lsbCBjaGFuZ2UgaXQgYmFj
ayB0byAhWDg2XzY0IHVubGVzcyBYaW4gb2JqZWN0cy4NCj4gDQo+IEkgcHJlZmVyIHRvIHVzZSBY
ODZfMzIsIHdoaWNoIGlzIG1vcmUgZGlyZWN0Lg0KDQpGaW5lIGJ5IG1lLCBJIHdhcyBqdXN0IG5v
dGljaW5nIHRoZSBhc3ltbWV0cnkuIEkgZG8gdGhpbmsgdGhhdCBhbnl0aGluZyBsaWtlDQp0aGF0
LCB0aGF0IHN0aWNrcyBvdXQsIGlzIGdvb2QgdG8gbWVudGlvbiBpbiB0aGUgbG9nLg0K

