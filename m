Return-Path: <linux-efi+bounces-4991-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE894BC28F2
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 21:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12B4D34CA0E
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 19:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECB228CA9;
	Tue,  7 Oct 2025 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3E4PPA/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F57221D87;
	Tue,  7 Oct 2025 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866812; cv=fail; b=HaWnPR1rVXPwxGx/l9mpAcoI1SSYTU6YhqiuVm1ZOPfDVXDv5Naq7EUlfo4biWk8HtmrlppwS/Om9IRiwncl2tR5uDmnFF6XpVQXw3mwhz8ZsTGM6yM84QdXNn+xPLnFPIIIWh17uGquXd/3fepNia9D7wc3NwjnEvDaG44NLes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866812; c=relaxed/simple;
	bh=mdMYYPaLVRYy+Ehkh4hGScpPzF9aAUu3/rAlqIKPBN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SGWVaHvL+UFTNEGDQ3bwpOHEX6Lanqn2d8Cpyumk4expZGSUMpg7e7MJHdlSJdMiOjhMXgoxmCBSNIJpvqhcap47dKvptUABiA6PxRixE6prboOZpV4xGXDDIvHNaCBrNg45FLNFd+kwaAbtMUcRss8T+BnvC9gJoBlf0evCwkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k3E4PPA/; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759866811; x=1791402811;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mdMYYPaLVRYy+Ehkh4hGScpPzF9aAUu3/rAlqIKPBN4=;
  b=k3E4PPA/Beaja3vAhpHJ5PQxQMQkiKNNUWc8RSg5aDQzgiAPuENlUIWg
   hylGHmXLO3Q6v/AggWYkZysjuXv6sUqN3+nQ7jdeMCrPJRSpflQgbw9u8
   aowODyylNWZssizPneEPtHhq9YKqX9AnHloEI8es6mI1VhCmn2EvS40Vo
   E8lN1inYABH3AxPiBsDEF1FXAbpWdWoOWTiIzLibu8BIXXkSqmZuE6xnv
   v1h5ynJRVY65xGbrhLDhT0wzw7V2vQSZAAe5/+XGwMtDTFoKV2QIgPkM9
   oRADobx0cBMymZHKE/qUfTuo1NXik3kkfNWPn2SOyzHU9dbWcCoOKSLj4
   Q==;
X-CSE-ConnectionGUID: WJNnoB4zRWSeL+S69WlUfg==
X-CSE-MsgGUID: xMFP7CmXR1O7jgHfuoaSQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62004684"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62004684"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 12:53:30 -0700
X-CSE-ConnectionGUID: w4PMfnE/SSSBerQhr6Mv0Q==
X-CSE-MsgGUID: M2Zfq2cHRpq0LUJEXdEqKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="185534308"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 12:53:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 12:53:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 12:53:28 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 12:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY+mV9YW2BMynkOVSvxQ37HRpXVU7nN8xCguXp68iGTkRzl+KocTJb6Dlg5DGUMnNxFhEd6FVUyQ+c1ZR16BHoNtLXS7miGzoimnccpDA4Xc/kR+pG7KP0zUAOd/ejQSImLQ/4iKa9D6c2RcS12PvW3UyHrFeLpqw0oZ6NXS8NkWBBYE9BFSPAXMC2ca/c6eABBI/2r3xbolBNP0MXXUK9W4NsoLVxY1BzRcRuV7JrrJ2Bsor29YFcyfXzrhBKG3Zw8+2WaS/bKoJ0KdM1lyNg8QOMUomJbTopDRDHUHrXKyDjKnbg1ntXXsy4IpVoic1nZ90//bYjdkhcDrK8mMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdMYYPaLVRYy+Ehkh4hGScpPzF9aAUu3/rAlqIKPBN4=;
 b=bB2ZG7QVt7jvAVI6A4j7pel1RQuH5s/vIOB54fNpKYuhCyaCtLtkDv5Cd0xJKobnHgIgf7S4L9dO8dR+bxQUIN1LiEVVmc1prK3mB2gFfS1/byLq2DNehpipaxc/IX9qwtIJ8NyIVsWDCF/bgefqmtVnnaczacXc1nTcc0wR4FanoznHta/GXnT4k18XRAjdhpkh12XJUVE6v8zFUyzAyqmt0w+n0gBstQxYpfsbgDGt/0wlKVlL8fYpNq7sCQRAnenEXfJWuG/8Zp2t8shcvcHYkpL1cuVFz7f2E6UXaQJ+hNht6fOiyeOwBGjgcPfKwpFwRdJAgpqCHOGfjlfzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB8211.namprd11.prod.outlook.com (2603:10b6:610:15f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 19:53:25 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 19:53:25 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>
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
Subject: Re: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault
 emulation code
Thread-Topic: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault
 emulation code
Thread-Index: AQHcN1cybBcaoDcZbUCUg2EjTwKZL7S3BCwAgAAC+oCAABJAAA==
Date: Tue, 7 Oct 2025 19:53:25 +0000
Message-ID: <3c078d53409c3fbf6eac30966e8d68e097d7a6d5.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-9-sohil.mehta@intel.com>
	 <a33d59c7add98dd9ef352ac95178821dbcd0ce0e.camel@intel.com>
	 <3e3d2426-6296-4a61-beae-4e3ff5d60f2c@intel.com>
In-Reply-To: <3e3d2426-6296-4a61-beae-4e3ff5d60f2c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB8211:EE_
x-ms-office365-filtering-correlation-id: e9337e33-0d40-417a-362b-08de05db2db8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RWJ4WHVzeTM5d092RWtubDA1U3o4SVFqTFJibW1ocFlFQUhaRmY5YmJZeEE0?=
 =?utf-8?B?MHY3SThjQWpITFhXUnNaTDBvVmpodk1sdS9aTU5vbENwdit1bkhLbVR0VXFV?=
 =?utf-8?B?RWlsQUd3YkQ5R0kvWHVGZ3FBbWtUdnFaQUJaTEJhMkxGLzUvYWZMN2QwVVdr?=
 =?utf-8?B?Q2w5OUVkbGNOaU95Z3lSYi9nZXRIa3BUYUc3TGJucWp4QjNOODI5S0Zyb2Q2?=
 =?utf-8?B?VFZMbmovamtBSGllNFd4aTlJa0lHSkVTcjNYaVRRdkEzYkpnMDNjTG4wczNC?=
 =?utf-8?B?REw3QVJSVE9kcGpBTUVDNjREU3BjUHNxMzBwTklOOVh5NHRHUEllZEtBQ0ZK?=
 =?utf-8?B?QWVMNG81ZFF1TnpQMm91bUU1V1oyNGVvK2xqME1tTk1POG0zWjk5L09US2RW?=
 =?utf-8?B?K1RWTGZsdVBjVjRYcThqMXFHK2swcGVTd09aZ0RXbDFYYkpsZXd5NXhuWE5w?=
 =?utf-8?B?T2RHSEVpdVJyUmJxQ2NjTU8vT1N0cDR5NzVMZ1RxQzhQNStEaENZUkRHTklC?=
 =?utf-8?B?TlpuNFVJekJHam5OSEhMMzJDTWs3dEg5dERlWGdtOTc1UlBqMTF0R3kyZ0Z1?=
 =?utf-8?B?QmZmRzBQZmhJQXdDNHA0KzZTeXRQdS91WVdZYW04aGNSTXIyYXVVZlc0Q2pZ?=
 =?utf-8?B?U1V6Qno4ZjhGSUs0NC9SaENDMWpvWEZhaVdRNFArQTlNRXhMWHdRR0lvMTVm?=
 =?utf-8?B?bEppb1g3UTFmTzM3RzFxVEsvYnJCbWhKQ2ZadXJmbmNQM0hhTXBZUWVRTUlv?=
 =?utf-8?B?Unk0RFdna25TRmtZSkFPWlpWQmdIai96UzRUWE5kcGk3cUh6bkZMOEZ2eXBm?=
 =?utf-8?B?NU1zN0pjajUwcGFDMkZvNUdsekxtTHZRVGc3MjFwZDcxUDMyMjZ6ZzVnVVFU?=
 =?utf-8?B?bHh0MnVWSUYzTnBmT0c1MVFEQ0FNcWR3bjRpT1ZuWWl1ck52ZS9qaDNXZWdr?=
 =?utf-8?B?bXdqSVJ0eVE2dFpNZkU1bW9qVWwrbkg2cXBrY3FlSHc0UmgvUTNyaDl3RldK?=
 =?utf-8?B?alhhSVJUOGFmYWdTbjJqVEN2RHB0dDdqekd5UDNYV1lPOGh3MFMzNmpwaE1k?=
 =?utf-8?B?WEFENExGSmMwNTFBWjZjaURDNWtJSVdTVFRocmNkU3NsVEk4eDhiaU1WR201?=
 =?utf-8?B?b25xRDI3VFRZaW1tNy9JRm52amxnajc5Zm8rR0s2dVJES1kzSnlXQWVFSTl2?=
 =?utf-8?B?aXhoK0trMVIrZ1N3MUl0L1J2Z3B6K2NIdy80RU5mb0ZmdTBCdHBqQy9kV0xX?=
 =?utf-8?B?Qy8xYVNmRVYrVUhUc20yb3FlQ0dKVUhJVzRST0M1dUN2R3lhdUVWSmFrTHZT?=
 =?utf-8?B?OTU1NmdkWmM5T3dkNzU5eGVsaExBQTdEdlp4dlVVN2s1a0JvNWJhTkFZR0oy?=
 =?utf-8?B?b2ZxTmlDcFpvRzdsOVFTY0ZGQ0RkUEpsaS9vaC9VTlZaUk1palBRTmdsZWVa?=
 =?utf-8?B?cXdPNjh6UlVlSEJUbXd2cFpYTTdQaG05NjZ3L3pGN1l6ZWZyYXMvdGt0OXdo?=
 =?utf-8?B?Z2g4UTQ1QkhSb28zalh3T3kzSjRRajl0cDJZWUZZcFJ2NEFjQm9DbmtBc001?=
 =?utf-8?B?dnlUZ2tCbndqZEdDMTh5ZHZvVldYa3F3UnNQWEZkdlpINVlJa0hXeUI3cnVw?=
 =?utf-8?B?Vmk3TnNXN0ZKNFVmVkZYekVjc0dzQThEcjc2KzFjdm9WZDZWTzlHMGI1WDJ6?=
 =?utf-8?B?bjdVNWVzSVB2M1NUNkdEMFFJWWJpMG5jNjZKUU1hWUptK0dpaTU0Sm1FTTYy?=
 =?utf-8?B?Z1BNN2dMSHowa0N3SzZYZUlEWUZXZTh4ck9zTGxpUmJicnAySjJnTUVtTnhm?=
 =?utf-8?B?aDE4dU1ZRGFGODBoNC85M25Ba2h1UHFFTE1uYW05dGtGOEUrTG9WZE8rRytG?=
 =?utf-8?B?cnhaNG5tSTVDZitWdFgwaEN5NUZFeWl4dlR2R3ZBakpSN0VwVGhURVJzYXhG?=
 =?utf-8?B?eHhpZElJVGg2OGlnOGltdjdRY3krTmNld1g0OWx2OXN1dVJSenllYzBsbldU?=
 =?utf-8?B?Nm5FNHdCU1dVUkxSRzUzNzBWaXFuRjBkQ3RpNnV5aTlNaXJVT0dYOUVtYzVD?=
 =?utf-8?Q?qtmWMc?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWtHeGVCNmdMYVFBUWgxSFJLa0hLRTVlYjlrUXcwSTRuS3BZVC83S2Y0VHAx?=
 =?utf-8?B?Y2RWNHhjbGRtVGZxR2hiTUp6bjJtZDhaVjJ2UGtpR1dVaUhEcDh5VHRNQXEr?=
 =?utf-8?B?aDBiUkIyMXIrb2s4a3AvaGFJV25jTGs2ejZ6T0twK09IMUVyY05WN3h0SERx?=
 =?utf-8?B?a2lRRUJKUXdrc3hNR0QrdjRLeHk5ZjlNVjBuOVhlUjMremx2eWVPZGNtWFNy?=
 =?utf-8?B?b2lJOVo3b3FDdEVNY1VQNDEyTXNSTGNHNnRRQkR1ZGJjbEZtaWhmWlptY0ZJ?=
 =?utf-8?B?T1grNWVaNlRDN3dEb2hLclhKVmoxT0phWE5kVzBqaDAwRVRSMkVTcXBpTzFr?=
 =?utf-8?B?aHBxdjlhNDZHWFUwenZUL1RqMm9XWGJ6LzVKbXBiL3RZTmhRcDV0M3JrNmJm?=
 =?utf-8?B?b1lEcDI5dEV5bkFQQzFwT1pJd244bXBBc0N2eGxNeENEb282MWdZcmd1T1Nw?=
 =?utf-8?B?cUVteUtjVzlDdU5nR3ZIYUgvNTZtajd2dWVCN0tMUGwvVmZTVzdmQzk5Mnhs?=
 =?utf-8?B?NVBwNmluQm9vaE9vT0k0eGIrSkw3K2h2OWIvbnExTldTVzMxampMdjNOc2Zm?=
 =?utf-8?B?ZE41U3lrdzZqVWo4OGJDYm5ScndUNnZmRHJOWFlXNm9URmk0M3pXWGJtZnVU?=
 =?utf-8?B?TG9YSHpqbWFaQzFWY2VhejRNYTF0Yk5adzhaL0dPNU9YZ3paMHJJcDhkWUhC?=
 =?utf-8?B?dnJDdlVlMTgvSEsvSURrSlpxS2NRdFBYZ3hCakFhVUNKU0Y1VUF2VERIRVd6?=
 =?utf-8?B?SmQzNEVMcitseFFmdi9QdXlxdGlBd3F0aFF1ekUrUGZycHRvYURtNjMyejZP?=
 =?utf-8?B?bTI3V0R0U0RBUmR3YmRpbzhuaDZKQ3pIdWFqRnVocktJejdiV3UwaC9zeU9t?=
 =?utf-8?B?c0F0UG9jcTgzaU5icEFZZkhjeVdlbkJkaFVGaTMzeWdFcUFmc0hidXF6VEVK?=
 =?utf-8?B?Q3pKUjU0bXBMa0ZGeVhNaW1CaEdmcy9BRVR2ZjFNeGRGZHdBaWNKc21GVDlq?=
 =?utf-8?B?VEdaQnozZ2EzejBCV3VaUmF4UU9yWCt4enRVNUh1SlE0Vis5YXZ6cDZHRGpn?=
 =?utf-8?B?dHdCTDFZT24wVDR1WkdiZ1NDMFZEejl1TWtqbCtiMnFhTTgyNmhlaXhrbVd0?=
 =?utf-8?B?Nklaak1KVlNFM2llbXd3TzdGR3NGaEE1d1QwVXZPcUE1ZGZZcGdWOE5vTmdJ?=
 =?utf-8?B?Nm9kcGQ4QTIxZ3NiWjV6MW9NY1oweXpiU09ZaVVhRHJKQkg3VU1vMXVSbEpk?=
 =?utf-8?B?ZDdGa0dFL0NyaDc2cHVXMTZaR0h0TkpBUVlRcUdQRGs5TE0wSk8zVjJaaEFt?=
 =?utf-8?B?TEN1RlgyOUltVi9BeGdwckRGQ3h6QWduUkRoeWs0MStFUmxEMzU4Z0p4NkRH?=
 =?utf-8?B?QmZZTm1nSW9GOTJtQ3NVRXBTaWp3TGRuSWU4S2hiNVZVenpSTlZ1dTJ0K0tX?=
 =?utf-8?B?Tm1xWkVKSnRPTTQyNU02YUNhQTFHY3VOSDlyVUVqbTFwbXlrNzR5V2hUenRM?=
 =?utf-8?B?SmhTVzFZUlNxYWVVc1VwOWdLc2FmdytiTmVYc2wrYjV2Q05oSVFBaktYTE0v?=
 =?utf-8?B?WGlKb3VkaExtcWNSR3p0VmVwc0VCNTZIZ21tY3g0bmowejNMcGRVTFZlS3lW?=
 =?utf-8?B?bm9tS2JNVUVNblN4L1p1ZXBDcFROL2FPdlhXemlPbjYwNTRQdVpxUjJRL1h1?=
 =?utf-8?B?djZudDNxbXpQVFRmdnhmeEhHVklQQmlPU1lTbkNJLzNpY0pRbmVmZ0RIK3Jk?=
 =?utf-8?B?cUFUQXQ1Z3h6c1VPVUhNLzF2TjFJdENmUmVQR1ZFYWkwSjFTWFJSVm9TcndV?=
 =?utf-8?B?Tlo2Ym5kOGU4WFlQVU1COW8rZFEzbDNYYjZpWk9OY3p4RkJiMlhQVHpybUll?=
 =?utf-8?B?ZVRMUEtlbW1sMm03Qkt5eUh1YjMvaWZnREhiOTNKRzJlMXJTWUdCT0M1eHFT?=
 =?utf-8?B?Tk5vd1FHUS9uMU1DQ2wvSVhtM0o5T1RlNFF0bnU4aEN6QkRVUkFKMUJYVE4r?=
 =?utf-8?B?MTdxbFNoQ1ZTZ013RGlTK2hsWFVyT0o3OEZLYUMxcHhmRmViaktnNDlKaFpX?=
 =?utf-8?B?bGZBL0dIR1ZYZWJyRC96bm5oZGljbXpUK1ViL2VtTXFtSENqSTBBUjVTbHRY?=
 =?utf-8?B?bWhBbnB5UjZjV2N5SHBDeDdFOFNGWXlOUS9BdU4zVUc3RHBHRTlnMnBnSzRk?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9955AB6E37AAF48BC5AB9EEAB9483EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9337e33-0d40-417a-362b-08de05db2db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 19:53:25.6073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tb7PSOvLLM0tJTg3VotrgvqbLHQQ9oWW34LDhACj5kiBe5qtq/00Qrvh1h/SAoZNTJebtS7zshE1KiSkBRDZtC8SO4/0zsA4rSKuMpiK/8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8211
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTEwLTA3IGF0IDExOjQ4IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTAvNy8yNSAxMTozNywgRWRnZWNvbWJlLCBSaWNrIFAgd3JvdGU6DQo+ID4gPiDCoMKgCS8q
DQo+ID4gPiDCoMKgCSAqIE5vIHBvaW50IGluIGNoZWNraW5nIENTIC0tIHRoZSBvbmx5IHdheSB0
byBnZXQgaGVyZSBpcyBhIHVzZXIgbW9kZQ0KPiA+ID4gwqDCoAkgKiB0cmFwIHRvIGEgaGlnaCBh
ZGRyZXNzLCB3aGljaCBtZWFucyB0aGF0IHdlJ3JlIGluIDY0LWJpdCB1c2VyIGNvZGUuDQo+ID4g
SSBkb24ndCBrbm93LiBJcyB0aGlzIGFzIHRydWUgYW55IG1vcmU/IFdlIGFyZSBub3cgc29tZXRp
bWVzIGd1ZXNzaW5nIGJhc2VkIG9uDQo+ID4gcmVncy0+aXAgb2YgYSAjR1AuIFdoYXQgaWYgdGhl
IGtlcm5lbCBhY2NpZGVudGFsbHkgdHJpZXMgdG8ganVtcCB0byB0aGUgdnN5c2NhbGwNCj4gPiBh
ZGRyZXNzPyBUaGVuIHdlIGFyZSByZWFkaW5nIHRoZSBrZXJuZWwgc3RhY2sgYW5kIHN0cmFuZ2Ug
dGhpbmdzLiBNYXliZSBpdCdzDQo+ID4gd29ydGggcmVwbGFjaW5nIHRoZSBjb21tZW50IHdpdGgg
YSBjaGVjaz8gRmVlbCBmcmVlIHRvIGNhbGwgdGhpcyBwYXJhbm9pZC4NCj4gDQo+IFRoZSBmaXJz
dCBjaGVjayBpbiBlbXVsYXRlX3ZzeXNjYWxsKCkgaXM6DQo+IA0KPiDCoMKgwqDCoMKgwqAgLyog
V3JpdGUgZmF1bHRzIG9yIGtlcm5lbC1wcml2aWxlZ2UgZmF1bHRzIG5ldmVyIGdldCBmaXhlZCB1
cC4gKi8NCj4gwqDCoMKgwqDCoMKgIGlmICgoZXJyb3JfY29kZSAmIChYODZfUEZfV1JJVEUgfCBY
ODZfUEZfVVNFUikpICE9IFg4Nl9QRl9VU0VSKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiBmYWxzZTsNCj4gDQo+IElmIHRoZSBrZXJuZWwganVtcGVkIHRvIHRoZSB2c3lz
Y2FsbCBwYWdlLCBpdCB3b3VsZCBlbmQgdXAgdGhlcmUsIHJldHVybg0KPiBmYWxzZSwgYW5kIG5l
dmVyIHJlYWNoIHRoZSBjb2RlIG5lYXIgdGhlICJObyBwb2ludCBpbiBjaGVja2luZyBDUyIgY29t
bWVudC4NCj4gDQo+IFJpZ2h0PyBPciBhbSBJIG1pc3VuZGVyc3RhbmRpbmcgdGhlIHNjZW5hcmlv
IHlvdSdyZSBjYWxsaW5nIG91dD8NCj4gDQo+IElmIEknbSB1bmRlcnN0YW5kaW5nIGl0IHJpZ2h0
LCBJJ2QgYmUgYSBiaXQgcmVsdWN0YW50IHRvIGFkZCBhIENTIGNoZWNrDQo+IGFzIHdlbGwuDQoN
ClNvcnJ5LCBJIGNvdWxkIGhhdmUgYmVlbiBjbGVhcmVyLiBZZXMsIEkgYXNzdW1lZCB0aGF0IHRo
ZSBjb21tZW50IHdhcyB0YWxraW5nDQphYm91dCB0aGF0IGNoZWNrIHlvdSBxdW90ZS4NCg0KQnV0
IEknbSBsb29raW5nIGF0IHRoaXMgYXBwbGllZC4gVGhlIGZvbGxvd2luZyBwYXRjaGVzICh3aGlj
aCBkb24ndCBpbmNsdWRlIHRoYXQNCmh1bmspLCBhZGQgYW5vdGhlciBjYWxsIHNpdGU6DQoNCmJv
b2wgZW11bGF0ZV92c3lzY2FsbF9ncChzdHJ1Y3QgcHRfcmVncyAqcmVncykNCnsNCglpZiAoIWNw
dV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfTEFTUykpDQoJCXJldHVybiBmYWxzZTsNCg0K
CS8qIEVtdWxhdGUgb25seSBpZiB0aGUgUklQIHBvaW50cyB0byB0aGUgdnN5c2NhbGwgYWRkcmVz
cyAqLw0KCWlmICghaXNfdnN5c2NhbGxfdmFkZHIocmVncy0+aXApKQ0KCQlyZXR1cm4gZmFsc2U7
DQoNCglyZXR1cm4gX19lbXVsYXRlX3ZzeXNjYWxsKHJlZ3MsIHJlZ3MtPmlwKTsNCn0NCg0KSWYg
aW5kZWVkIHdlIHNob3VsZCBhZGQgYSBjaGVjaywgaXQgc2hvdWxkIHByb2JhYmx5IGdvIGluIG9u
ZSBvZiB0aGUgbGF0ZXINCnBhdGNoZXMgYW5kIG5vdCB0aGlzIG9uZS4NCg==

