Return-Path: <linux-efi+bounces-2053-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385169B5623
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 23:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552D51C21947
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 22:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A534F1990BA;
	Tue, 29 Oct 2024 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGmA3vrw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296E194A59;
	Tue, 29 Oct 2024 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242777; cv=fail; b=h1MALhH/VuomN2Opa4B1vLhPsTvRpqe9Va1ypsZFw4dYHNrPeodXxhrZ5aEy/kaNa9X4i9ZUt8yESM9K/R3/lCl2ZEaZ2/kJSs07UxbC29KZDvUlkVLlVzKevypgZ2goTrh2q5r1M1cR2pYNsFAkahPuvnp4zuS0KYY6LMuYTH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242777; c=relaxed/simple;
	bh=ol3ZsfgSQGPjFEJJcOZYhekzSI0qNuaUapHRefbHfF4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gBB1fUmBLm15HYubwVyWy8mZFbiADYJTQEuvJMVRjC/9H3qku9J6Fhzm1i/++pjQ7kOb/442bC6zovjcreZx2ZGU3BgDTGclI1JXroQICosFJx/KgbReYN6UXZyYjJU5GXc6bVqD/B4XzQMjPrltq0P8kaCHQklMVHe7F+eZv6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGmA3vrw; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730242775; x=1761778775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ol3ZsfgSQGPjFEJJcOZYhekzSI0qNuaUapHRefbHfF4=;
  b=hGmA3vrwCRivWuPGOrmbLfhszeIkjCcFc1q9B8iXTIdAK3pgATnP5MDW
   uFdXCL9v1U9g09nRbCnuSc/XyrrNR7gEvVGQ1HLHWqYoeutiOFH4TukBD
   Mn9UGbm/R4DiS9mdeGIQ11p64RI8MHsmMGYkdjdJhi35DiXLxDvmZS77M
   0exgjTuDG6HLsaAh3aE/E6hoQliGiXjqnq73AEj9m1aWxTt4i5NVorefN
   yeCvKJ0LWKan88q0zTbRfCSvTFw5TVVqn/w31tJuAyG34zQ6JpSLhG/8g
   /FmKOrvjwnTEkpKf/tamiCfCMymwFLWHbL0auClK2jf4ZxJ0lpu3mMxgd
   A==;
X-CSE-ConnectionGUID: hwzzHZarRBaVEyQhK7togQ==
X-CSE-MsgGUID: NASRbZeaQXqAjFTopsVJMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29365264"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="29365264"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:59:34 -0700
X-CSE-ConnectionGUID: 5oTTz9KFQHaM/xjmqzTeQQ==
X-CSE-MsgGUID: ZIKvkSS9QvqmNo9fASj+3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82445639"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 15:59:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 15:59:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 15:59:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 15:59:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+CbKJwQ/LZVBVk4GkMrLnb3XXp8v36C4Tt9aZW7gf6KrNW4ve2d0wgikR5u5D0jxmWn8kDPzbGRj4Udqppfupa6v84LhAj2mKLCAaTUnKmG5X3E9HAK50MDe7y95RuTGpewP2u5xEj5TdbMhwca2dvPS+Ky9kaJMQVVJ0HZnsREl/sMe0XW8+wmh4A8eWgXu4Ikl+s3XaSGRWvlYdCI0VMHE2BsrtHQBj+igHsvfAlnN/9FKVNhsQjyBhdoMKbuUCHacxNL5DmoCHpheAxEBTP7JzHZ4b8PyOVxj1k2f7dDAqMV5pOoJTUSORzmasku6yyOxL2vwtPuhzGCV9gm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol3ZsfgSQGPjFEJJcOZYhekzSI0qNuaUapHRefbHfF4=;
 b=YAaTkVbKAw1cytsECOeK0I1m90e3Zy965t5HsuR6Sly7e3UKhcb1XS2mkvPui8ayhv+oeJNNhHi7A+tou9FL2gi2gLIvOXxkU2c+G3wSmaec43KsBio4Whrx0FvryrZv13y5bbUAtcg7hHam+XWdFvCVXN5d9mZNnWUT4mWmcPjWeguUrPNH83Wlzr4opIciaq4HryT1CAJ1ugAQNMbcJN7g1a/o+qqzQPEYElg4BTp0XUGQXd46KWBrWw4UyuT8NCRxxDibVV2FvDUTSPb7Rj25elSmuRxvgJFfEnpTGQtEzpg6hUFlh58HRHD6NsWi6hZJK4aupiDoyzP3z6P42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 22:59:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 22:59:25 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>, "Li, Xin3" <xin3.li@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Alexey Kardashevskiy
	<aik@amd.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross
	<jgross@suse.com>, Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook
	<kees@kernel.org>, Eric Biggers <ebiggers@google.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
	Changbin Du <changbin.du@huawei.com>, Huang Shijie
	<shijie@os.amperecomputing.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Namhyung Kim <namhyung@kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>
Subject: RE: [PATCH v5 05/16] x86/cpu: Defer CR pinning setup until after EFI
 initialization
Thread-Topic: [PATCH v5 05/16] x86/cpu: Defer CR pinning setup until after EFI
 initialization
Thread-Index: AQHbKVP0cuDlVV7xLE2PM0asFJfZPLKeTCEAgAACT+CAAAl+AIAAAQCg
Date: Tue, 29 Oct 2024 22:59:25 +0000
Message-ID: <SJ1PR11MB6083CA923D92CD70AE6C5FB9FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-6-alexander.shishkin@linux.intel.com>
 <a95a624b-214a-4b1f-ac16-dad5a9270bf8@intel.com>
 <SJ1PR11MB6083B9854320176B6301C530FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34dd023d-3ed5-4655-88be-14a7a300b91e@intel.com>
In-Reply-To: <34dd023d-3ed5-4655-88be-14a7a300b91e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB7276:EE_
x-ms-office365-filtering-correlation-id: 081a7f50-1725-43c8-b5d4-08dcf86d55ff
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?c0xWTFdmQ2FGaFF0M2gzbk1XS1ZMdjl0Y21DRmdieU1ZYTVMMmVQNktUWlJC?=
 =?utf-8?B?cFZkY0MycVJEcnl0VmJCUzJESjJqQUQ2NW8zSGJ4cG9pZUVvNnNyWjE5SEhy?=
 =?utf-8?B?c0lRRTRKam1ibDFmcXhseWp4cUUxRm9ZODc2b3VOd29jalB1c2RjYUlpRXRX?=
 =?utf-8?B?ZnVCSWV6aWlZSFFMWkFFelhiaFU4RFpETE10Sm9HdXdYZlpUNmo3d2xIMXZK?=
 =?utf-8?B?bDlLWkdXa1BCbThMQ3YyYnVacmtzRzVJdnpBR084dzZzMTF0cWJ5WmluU2pS?=
 =?utf-8?B?d0FpZGxnNHgrVjFWeEpvbjdFSUNFNFlxb1Z2cUl5dDBMdHlzekFGUFR6ay9w?=
 =?utf-8?B?TXlFL3AwYXBtWW4rckV4NmZqUmFRalNUNzE5V2huamZkRWhqZDRJT1FkWlBS?=
 =?utf-8?B?S3NQWnBtT0hudGdJRzg0N2o2ZVZQM09oTWUyam5GUGZoQ241M2RadTBaSmdh?=
 =?utf-8?B?cHo5VHhDWTlaQzFYckVXLzNJc2FJenh0RWtnSDlpTml3Z3daWGdxQndST2hx?=
 =?utf-8?B?L09DWE11bDIwVWFLdVU3WGVsWDZMWGNNdHNTQ1lVTC9mSGxkcitYTTFEWFYw?=
 =?utf-8?B?ZERqSDNTVmVKL3ZBVjFTUjBSZ3BqUXRjQVFYS0tya0pzQ0t4S2ZxUGlxeTNi?=
 =?utf-8?B?Nk5kdFBERVY3UlNuTFB3NUtGalcxWFQrQ05YT3FqL2RyZ0VERk00bzBwZ3R3?=
 =?utf-8?B?ZVFKbHJ1UzFuMkM4L29OZ0QrYlJsWGIzeG81T3laNkVSYkN0TWZlU0l6SGhJ?=
 =?utf-8?B?bG1LT2EzRE1Sc2hVMktuYkxlV242NlZvTWhOMkt2aEZpcFlzVjVseHJsWlFi?=
 =?utf-8?B?bjhvcm00Qkx5Z29pSEFNQ2Z2MTdzbjRZalBETDIxeS9zUytCc2NvZ1ROZmVG?=
 =?utf-8?B?S1JBV0thb2Q4ZzZGZnRwMnVHUVFjbVlrV3J2QlBDbERQZGYweHFXVkNoakp5?=
 =?utf-8?B?RW9SdXB6aUliNzM2U3ZPQXdkbEpJWThkMUZaUWRRUVZ4VHYvcmNmK0xwODF2?=
 =?utf-8?B?eEtBcFdGMm5lRW5nZjlYNktxaVFraVZwRXg4UGVRZ2NBQTcwRkVFVnEvTDZh?=
 =?utf-8?B?cE9CSjAzTWROSVA3cGNqdEpQSlk5QjdFQ3pqM2VVb0h4aXgyd1pVSzQ1emVy?=
 =?utf-8?B?aTJQamNycmxsdFBUS055dUx1TXRpdEU0S3RsWVY2MGhzazkrS0JHWTBxV1hL?=
 =?utf-8?B?TitnNXNPeW9ZM0hOTDhwZWYvU0diUk03ZXBNcGFtektQcVV4YkFwSTVUTU1q?=
 =?utf-8?B?Y29pa0krbDA5UmNWNFYxcGRMaFF6alJQMU10YU1WZVBuU2licUpKUGNYRjV6?=
 =?utf-8?B?RVk1TDl6c0V2VWxyU1IxVXpvVE5PVWE2YlNTWmxETHl1Q1dtdjNkYTB5MXdU?=
 =?utf-8?B?MWd0YWtaOWVHVzNTQnBTNWd6bXFzYVRxaU1UMXdkQlVSVk93ZzhJQklrV2xL?=
 =?utf-8?B?YzJQa1JDTW9iWk8yYVI5cFk4bTdZTnJRU0Nva2ZpN1U4OTZEaS9LQW0xRWNC?=
 =?utf-8?B?TStrMGoycG1UdUxrT0VnYmdOeTlQa0RiZ0kyTC9McDJZS3FVSDZpTmk5a3Rl?=
 =?utf-8?B?cHhFcFRzK0Q5ck9TMjF4UnNiV3lpdXNwZE12T3ZYZWF2UThCbmJrOGVwaE5a?=
 =?utf-8?B?VTdFNWQ1bGpYMU82SW4rRW9MaVJhTEd1MytXSGZndkJsSWRuRFNXVzZuSGZ0?=
 =?utf-8?B?aDI1YmNUa0NYalBXMzRkeVpENHVhdHdBcW5aQ2Q3UGVJM2NkWjg5SEdHZlhQ?=
 =?utf-8?B?cGhSSGcvVU90UXA4OEg3dHRJWThuQUsvV0hhbm1YODg5UFlpa2xoM2prVjd4?=
 =?utf-8?B?Wkh6dGk2WDVzQjYxckcwNjlVczZTOEx2RkpBY3VQK0x1MHplNHMxRUJMZlRY?=
 =?utf-8?Q?QO1utynfQCt2w?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDJwbkE0QzMveDFVN2ZuZ0d0M0dmd1BkSXZaSEhURmtLL2NHb3pDSDd6WUY1?=
 =?utf-8?B?K0ltQndTSHRMZ0ptTjdQTUZRTlFKS1ZYRTFRRjFEdXQ0eXdnZUJQc2dZS0sv?=
 =?utf-8?B?ODNKZ2c5REhIQnJ2enkwLzdxc0NGMFBzVzlMRk15UTJ0QzdHWlVxQU5Mamd3?=
 =?utf-8?B?azBBTDdpTHpHT0xlcXRVOThqbk5wZnArVGhyUDR0czZrUXR6NUtjc0FpcWRN?=
 =?utf-8?B?b29EMlN2OUFzOG83ZmhqVmRkdk1BNXplQ2ltTFhvc3hNV1FKQWlaTUtYVTV0?=
 =?utf-8?B?R280NHJ5RmphYy9Od2xFL3MyOURrYlBsdEd0aEcvOEQvNnZUTmprNVJpQ1Ev?=
 =?utf-8?B?bzErNUEzMHF0VTg1d0dHOGpPZ3ZxRGVEZXYrdlkzVkxMQkRaTlliTWdrbmlO?=
 =?utf-8?B?V2s4MVdjb2NQbVU4STlwMUJnYVYrM0hxVjlybVdNT2ptS0Z4VGx2SVI5YTFr?=
 =?utf-8?B?MDB5ckVIc0ErRXBqUldGRGRBaFF3MXdVT2hZUEtJdEFiako5OEFjYi9ScTBa?=
 =?utf-8?B?OVJZWlpkMEJZL1VUaEV6YWR3MHRtM01zYk1XRCs5QVFOV1JtTS80MGJXdnpZ?=
 =?utf-8?B?VjFkMHJWSldnTGNGR2x6YTcwWVRPR0RlTkFiS1J2aFEvbnZna0ZKcnRpd0xC?=
 =?utf-8?B?N1hkQjlSQmgvcGhwYTlIbHdNcWFmZ2JaNkU5RDlWWVFGNTNmU3BxSkpPYURa?=
 =?utf-8?B?L09lWlFpc0x0Vm5mWDIzRS9UR0RxczZsK09USmVQanRsWUFXbkxFeS90L2Mv?=
 =?utf-8?B?MzFpbHN6YTkxVm4xZ3I4MlFHT2F2SG9SVG0vRC9Nc3J0RTQxbkpPSVZKWXRW?=
 =?utf-8?B?djlPcy9EWjZ2UjRVNWNMTjBzVmpWMHZjNzJsdk01M2JPdzAySUI4STUwU29Y?=
 =?utf-8?B?aEpuN3FsZkZUamNNVmhKbTkyd2MwQ0JhYzlRanpMclZZUTFLSUJaWXN2R0xZ?=
 =?utf-8?B?aUFZZmxmcnBLbkxBOE05WThwVnFmRGkrbTRCNVpxZmVaRFYyV1V2WXk2MzEr?=
 =?utf-8?B?bDR1bCtrOVVEMldBNGVOSExMM3FPTjN0NG1QUFh6MTJZMTRrQUxhVk5YUWMr?=
 =?utf-8?B?TXBBRWhtOUw4dTV1ajczNU5MTHlydUxtSlFMSm9tdzBjVWx3Q2V0SFdYNDBC?=
 =?utf-8?B?YTVxS0JzUVRqNExqZy9mT1Bobi9JWDNlMGZDWWp6TWU2RE1hbWQ0RFphM2NJ?=
 =?utf-8?B?U0pDcFpJZjF6SW9wNjZlSHhkcERVUlo4Nmo2N1hack9qZFlLM3d5bktxNkh0?=
 =?utf-8?B?dUk2MEtKYjV3TXZjNzV1bUhZcGErbHZEU291RUdGOVAzd3lFRDNiMUd2WVo2?=
 =?utf-8?B?cG9FMnQxallUMWdqQ0VWSUJVL2tCS3hWeHB0ajdZcmpJdjhNK2huTENoUEh1?=
 =?utf-8?B?Uzljc0ppWEZ6RDFTc0NkSzVZZE1sLzQ4ZzBkUXZwQXlBUGJ0VW1qU3FEemt6?=
 =?utf-8?B?L2xiVmdXZDZkUUp1RmNlOWxKNkl0WUpXc1FMMUEzVlVWYmliRWU4VkhFOTN4?=
 =?utf-8?B?ckdXNEwxN052Rm5HY3dudW5zZnl5NGlPencvOTMxR0hFVUlzbU1IWnJnQWpJ?=
 =?utf-8?B?TUErTnVQR25TU1FCVkdUV2JCdXppOU9vOXFDMFA5aWhiQ1ljQW9jSHprMkk5?=
 =?utf-8?B?SVRNWU9iNDFCRXZzeTJOYXk1MHF5VFdpNXpYRm9MRmRMT1V1M1lIcFdBZkJw?=
 =?utf-8?B?dlZDWFFrSGl2NWR1WXlCeWlyTXRSek03c0haRUdHSE5PWWN5ME1YbzBBNzBE?=
 =?utf-8?B?eXEyME1jaE5PTmJDNjhxVWErQlhmOXVLL21lbXE0Q1FqTkdTSGdyTmVOZFJl?=
 =?utf-8?B?VUdEb2JndU8xd2l1bmVLRUJXZ3diQjRzRXIzOUY5QytMNVU0U292Rit0U0Rh?=
 =?utf-8?B?RmJzNmMzbzFZb05SZTJiUWYwNjNoN2lJQ0ZtaXVJREVhRmxPK2NCUHlaT282?=
 =?utf-8?B?NTRDYjFvZ05PYlJIbmdVN2wwTWo5OFZGS25YcXZjWW1yd1lvd1FzblNlaFNR?=
 =?utf-8?B?U0I1WFJGcXM3YVZEeGlFUVVqWW9rK3VsRVcwZ0FhM3ROeG5CQ1pReXc5NE9L?=
 =?utf-8?B?Q2txQ1Yxb0pDRjRFOE5yTWVjL1BFdHJxeVZCM29td0hJV1drdlE2a0hITHZR?=
 =?utf-8?Q?86Cdk4lFXFrssxcn2FXInkVpi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081a7f50-1725-43c8-b5d4-08dcf86d55ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 22:59:25.7552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58Rer0F80h/HTPdOO5SavtbfiS1xd920BztfcibiK5dzhmwrg/I47HamcsZQg+xpEwdt8moMBQqMVrs5AI8S1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
X-OriginatorOrg: intel.com

PiAqSUYqIHdlIHN3aXRjaGVkIHRoaW5ncyB0byBkbyB0ZXh0IHBva2luZyBpbiB0aGUgdXBwZXIg
aGFsZiBvZiB0aGUNCj4gYWRkcmVzcyBzcGFjZSwgd2UnZCBwcm9iYWJseSB3YW50IHRvIGZpbmQg
YSBjb21wbGV0ZWx5IHVudXNlZCBQR0QgZW50cnkuDQo+ICBJJ20gbm90IHN1cmUgb2ZmIHRoZSB0
b3Agb2YgbXkgaGVhZCBpZiB3ZSBoYXZlIGEgZ29vZCBvbmUgZm9yIHRoYXQgb3INCj4gaWYgaXQn
cyB3b3J0aCB0aGUgdHJvdWJsZS4NCg0KSSBleHBlY3QgdGhhdCB3b3VsZCBiZSBlYXN5IG9uIDY0
LWJpdCAobm8gd2F5IHRoZSBrZXJuZWwgbmVlZHMgYWxsIHRoZQ0KUEdEIGVudHJpZXMgZnJvbSAy
NTYuLjUxMSkgYnV0IGhhcmQgZm9yIDMyLWJpdCAod2hlcmUga2VybmVsIGFkZHJlc3MNCnNwYWNl
IGlzIGluIGNyaXRpY2FsbHkgc2hvcnQgc3VwcGx5IG9uIGFueSBtYWNoaW5lIHdpdGggPjFHQiBS
QU0pLg0KDQotVG9ueQ0K

