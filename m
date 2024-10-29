Return-Path: <linux-efi+bounces-2057-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EA29B56A1
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 00:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813741F23A01
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 23:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C33320ADCC;
	Tue, 29 Oct 2024 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIhjGchw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0720492B;
	Tue, 29 Oct 2024 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243917; cv=fail; b=SJSZMXvubcA+7ciYShb4z3xMFUFd8XtoFySG8faKk6ROjVhRuYFfnoECyXJftkMkYNfcF1UHVD4MYaKybjDhjfLu6brzi3ZQb4bCNLbl4BiYUQAiSfgGcFbLvqdBw141sspwtC5vR/Zrb2JlxYfLGibOKQKybUugpMWKCKRmXKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243917; c=relaxed/simple;
	bh=w9N664Nxf3sCp2vxl18rjMbhxNwbj5bQbs4e0j3m3+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SEwgNXAqwN7vz2VY9ihaYzKVfHqybekGrEkI+F78Ov36DwH2yrBjos4SAabS2Adx1cJSofZrUfaFuPxzvpdEIFz5t5AKhkaNWN/qvLcRRIfuJMQOjjSrDtawSi6eB6PgVeNDBsONC7MZ5fChHAjl5OlusG5GGPFTqvQcpChjBHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIhjGchw; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730243916; x=1761779916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w9N664Nxf3sCp2vxl18rjMbhxNwbj5bQbs4e0j3m3+U=;
  b=JIhjGchwAq7Delabfz1LKr9tT2LSdQ332ZF++rhawQpQIfOTJeCohMsO
   bWR64v/TtK+4UhTAO9aD1QgyRveSQt0uf4aLmah9Xfc5mYQEEmQ2efrkD
   AtucReoASYbSaRe5OQwrTNqitFmCilsQtJQGShXQRYB80u8xSDX0dnoLJ
   DzWqfRJv8Ypn6YKwePjcEaSbN10xuc5s8TVmCC37+cYnGogPn2xhFFOdQ
   XkXEG0NaAiIyoSFHRYi9pksALtY9D3Iy5rIpG9NgNm7WMcawXZojkS9W9
   fGAOijhkQMwEH7SP4x0iSmgbJmjnmkO4BnBR90rmDVwlPNPsD932gLRR5
   w==;
X-CSE-ConnectionGUID: 4rJnt/vGQcGRL1E0Bg+wHw==
X-CSE-MsgGUID: R6khP16mRgaHQ0uP+fsiAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29766401"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29766401"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 16:18:34 -0700
X-CSE-ConnectionGUID: 8607FmX8TzSG1OJmaGpfzQ==
X-CSE-MsgGUID: bYOvz+1HT/685UUN1lUMKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82541389"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 16:18:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 16:18:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 16:18:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 16:18:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOI0M89fTFBfNcJRZPqrxqtw4RyT4/HlHsmbQoh/U5IEvkZo1hJRT4PS9eKQOJt887JuCGUb3Kr/A/qtb9uu8uwi/yJ4u/LtUEVbTgw71YwWZRFYDmpDs9EMAB8FuVvhDEhngs/6Bo81XN0UUha8wbmGy5uVajk4wPybuAJX19wseEB5DQGJgRRdY8LOiDVzofj7MbuVC90DV+/vWNNhXzVbzMbvwBxddx83Zqzbm3KF0JQkIUIkezTIRJ6K7hT49qqzAo4XsXZrUKwMx6NgUDL6IZzfVRyLNXTw/6JhZqXoW/Yjq6gLjjsVtficnRe5921PmU9mZoX7wo9WW0VXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9N664Nxf3sCp2vxl18rjMbhxNwbj5bQbs4e0j3m3+U=;
 b=leZN32Kuf6AxCxda1gt2jocPO9ezZE3t8m+5dh78rrRh6Ra7Odo8i0VN10J4inPWQX6adO67cKZJKb9CCDFbMAHvd1flAI1c1rG33gAFUtyNuYsuUCrrXMk6JQ1GExIQoF4GB691HfhiG5ndHYeQdx8le/Cs2Tx5SrFfj7uaf1BwWEoBr5wUW/cOw7ngLybF9EQL9OOV8E0ErSKCkOIWwaqcAuoK+h7/bPUIAIWUKhiqvBk0gxFJukgelv/8i9rmUSzOUD5pyRObvEjigx6KSJs7N2chqZVS06079MvvdR3TBeY8PoKyR8+xxt2NoN+yaToOKwsyWheXtRqGXiTG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB7117.namprd11.prod.outlook.com (2603:10b6:510:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 23:18:29 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 23:18:29 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ard
 Biesheuvel <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>,
	"Li, Xin3" <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Alexey Kardashevskiy
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
Thread-Index: AQHbKVP0cuDlVV7xLE2PM0asFJfZPLKeTCEAgAACT+CAAAl+AIAAAQCggAAB/ICAAACoAIAAAj+A
Date: Tue, 29 Oct 2024 23:18:29 +0000
Message-ID: <SJ1PR11MB6083BB83EE16AEAD6D3F7C1BFC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-6-alexander.shishkin@linux.intel.com>
 <a95a624b-214a-4b1f-ac16-dad5a9270bf8@intel.com>
 <SJ1PR11MB6083B9854320176B6301C530FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34dd023d-3ed5-4655-88be-14a7a300b91e@intel.com>
 <SJ1PR11MB6083CA923D92CD70AE6C5FB9FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <869c1545-8c94-4820-a861-fbc563056597@intel.com>
 <aa3dc7dd-8939-4042-9e02-96dd29e45095@zytor.com>
In-Reply-To: <aa3dc7dd-8939-4042-9e02-96dd29e45095@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB7117:EE_
x-ms-office365-filtering-correlation-id: f925dc60-acb2-4c67-b229-08dcf86fffb7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?cVRQOUV5ODU2ZCsxM1pMbThid3ZlOERDNjJhYUkvK0sxbzk1NUk2ZURPZ1VS?=
 =?utf-8?B?TUR2T0J6d2t1RCtXWk41bDBEN1RNY3dSc2FiOVUycFoyaDdocHdidnl3ZXpQ?=
 =?utf-8?B?eGRRVE9vbitQM3ZrRDk2WmNodER6aE1PTS9jNGZmL1kwSWFIaVh4ZS9oZWVP?=
 =?utf-8?B?dGttbmkxR01iblVJSEFiMXFZYUtjUDZtWUpMdkRmbDFnZ3Jta2pwTTNGSDNI?=
 =?utf-8?B?SWJVN2NMRC8wdWhjOTJLREZvU2loemtuMTU3cm01SHZnMnA0eGl2YmpPZnUw?=
 =?utf-8?B?eXFmcnozaHVWTTBFZU03djA5NDducVplNHI2ZUdJcHZLTlEyQ2hobTdTT1BY?=
 =?utf-8?B?blhxbkpDbExwVVZHci9QZVhhTE0xRXJIZWlqQm9rZVR2TkdOakdseEs4czJL?=
 =?utf-8?B?bGl2SFVHRjRlbXFsRHpBTURidVdJQUZxQ28xbjR0OGd4eU8wNWs2dklCQXBS?=
 =?utf-8?B?azVLbWtHbXdKQ3Jyb2picmljeDBreFhqRGdyaUNDa3M0c2xJRUxGMFJYNU0y?=
 =?utf-8?B?dG8yV2F3VTVrSGlvMWY2SGNUdlF6bDk3MFpFRy9KaVVvMHRTOEFIbVNybTdR?=
 =?utf-8?B?MmNsSURURG14UjE1SlVpN2xjY0FGbTNBb1Y1cjFRR2JrTnVvbHZvUzBhQ1pE?=
 =?utf-8?B?cnNKSk00d2ZJdDRCait3QUVnKzN0UEZ3VkxzWnpBOUtLSnhvTFVZWXpob21m?=
 =?utf-8?B?UzBYSjBaRVRCVzlUcVhlN096enU1ZGl6WlF3UWZRTmpzL2JMNUl4ZXJvTkY2?=
 =?utf-8?B?T3Y5dm1RNS95MVFjZVMxTWZRRm1WSy81Y2x0ZlJzNG0vN28zOXUrV29iVFVr?=
 =?utf-8?B?cnRBN2tnaVpEOWNweENkS0F3R1Q1T09sUGZKTkQ4dU8wck94WFcvaThnNlpy?=
 =?utf-8?B?eHV0VGY4VVdScGt4cVNaZ3Z6MFJlVFJlSGRNRUR4S2hWU0dmcmlnbFFsMHZi?=
 =?utf-8?B?dlVkeXZTN0FBNFk2M09zUFFPL3JEcmlHNkcxaGZaRlRyZXdmdHhKcy9IMXho?=
 =?utf-8?B?ZlhnYWtOWEZyZHhKOElUYU1ueVEvbmR6KzMxZ2dmSWM3emhPdjZ4VG56T3BQ?=
 =?utf-8?B?VzRmQWErdGx1UGhtZ25PQWhXbzZQMnJXditaMFZWaXB6MHFKbzBXbllhdEtL?=
 =?utf-8?B?MllRQXVCclVOUlFqZ29XcEY0N0RFeHFZbjFSMTNnUFRsS2k3bGdpSnNnQUJM?=
 =?utf-8?B?T00zUG81NUhyRGR5SG9qeHkwZGkxamdEck9VWTl5K2c4emV1eURKWFd1Zzd4?=
 =?utf-8?B?enR1dGcwbGwrV2YzVVhhWk50bW5SVHMxRi9jbGJTOU1pV1Vjanlhc2pxRWNU?=
 =?utf-8?B?TFEvNVlsbHFoa3pDRFdxUFVxdGQ3MFpZbTB0cDJlS3Nwb3ZDYWtVL1Z5RHFF?=
 =?utf-8?B?eDlPNWl3MVZ6ZWxOK2x3UlVqOTFvUnhZbUVzMGpVQXRLVFZhcGtRcEpUeFhF?=
 =?utf-8?B?RXdLR05zWEE1emswcTR1dnlSd1hZcDFoY1ZhMnNzWWUzbGlMU3VIZzBNcXNU?=
 =?utf-8?B?bk9ocHpKMld1dnVpcUFXK21tNm93UzRweENoa3VCK0RDWnVTYXpxeUtYNDg1?=
 =?utf-8?B?VnB0LzBnUlozenZ3NWRWUUoxU2RleHlFYVpqb2poY1lXdjdwQ1NzZ0FGYkNh?=
 =?utf-8?B?YkNGNzlSRUxhVjgxMm9mb3dPVEQ3WXRiazJyR1YvNzFmb2NQKzZqR0REeEZ2?=
 =?utf-8?B?bGw5NGJOQkdId0NNUlN4RHF0ekIxTDJaY2xvR090VElUWnowclNVem5obysx?=
 =?utf-8?B?S09KTEVqZm5JT0pQOWFvMmR5Zkl3MDlzL0VnajIrK1AwRFdHaDZJVzB1aVB1?=
 =?utf-8?B?SklnUnlYUENqYW9oZVV4NXdMdWt0TnRKdC9vcDllRnQweEdCdUx6MlBSN2Uy?=
 =?utf-8?Q?nIQO97qTGawm5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmdWbzdwYi9VcTdUa3QxZ2s3RTlvSngrbEtEY0FsaVNSY0I3TjJRanlJVkJH?=
 =?utf-8?B?cmg5b1UvdEg0dlltU1hkS1g2R3RFeEViM21UVTNVWElZMVFTV2NuQXFtK2Vz?=
 =?utf-8?B?b09xTUJIZ0NXQVFyYU9hVjhFbDZsc1AvOU00UmlWQzFGOGp4cUdXRnF1ZU9s?=
 =?utf-8?B?WHVxd1dTTFZ4U2dJSzA4T0NPdVV0TEYyTnZWMWxUeHhpZExxUEJYaHRqczhJ?=
 =?utf-8?B?QTJQK2h0TVorelZCdU5paDU3dk1YRkd3SUhQYTFJYnczTlJrV3NFckdKQTUw?=
 =?utf-8?B?Wk9CQVVtNWp1NXV2b05WL3l3TjVNbzJoRlp6TGdjZHFiSlNLcDZPZWxJbm5P?=
 =?utf-8?B?RllSWWdUbFR0M1FrcmpGNEZsd29uSlBHTUhzOURYbFBNYTVLOGk4U0dqVG5u?=
 =?utf-8?B?Tk43Z1FaSlVSZ1ROZy9XTkNIc0doaUxGVGhjQkJFTmw0RjRyNEgwc3VoOTBm?=
 =?utf-8?B?L0JwOVlyU3gwTVIxMUtrQ2EvakRWdXVmYjZOTkxUWnJ0US9pSUZuSHhhVHJV?=
 =?utf-8?B?b1BqWXJ0eUhUS2xlZzVobWlUNGo2RGsyKzJyUWt2TTJuUzVOWG10aC9Qc0Yy?=
 =?utf-8?B?R2MxQ1BDMTJvU2d2ZkVQei9UcjR5YnNYeFVJeUxiZ3lyQTNKNzJwMklBVkVw?=
 =?utf-8?B?RVNBVC9PZkpmV0phWHprNHJWK0hsWGZrK2dYOExPVmZMYkJab3dXcExlRW5F?=
 =?utf-8?B?SUZFUmZ0V1BpM3EyWE9QYno4OEhjNm03SkZxeERuL1Rzb3hJN0JWYituZFhl?=
 =?utf-8?B?ckJKVndJYktJenI4YmdyS2IrV3RJMjJkZjkxbFJ5Zkg5NTFPbnF5RFViQVor?=
 =?utf-8?B?NEFRVHJmc3lwU1ZMSlQ0cGdndE1tZHhmdGJHMXU4NTBlYUt2QnJtRXlzWlB5?=
 =?utf-8?B?b3F5MytKWENtMlk4WU1RenRGRzgzN0dEU2huNzkzcG5jUHdlcVJOQURnZjg0?=
 =?utf-8?B?RWNJanppQ1M4aWlyM09KNFZsZ1RoeW5KZk40L3kzVjJnVVRyTkRJa0k4UjUz?=
 =?utf-8?B?VUFVVElySDI3K3Bla21ZZkZjTXN5WWN0RGJxQ2xhWEpYRWVnOVF2OGxJaVBT?=
 =?utf-8?B?VTBMMUN6Tm1rU250NkRGaHFPQ0UzSlVBRkVhaGx3dzNmVnd2SWZxYlFUNVlC?=
 =?utf-8?B?UlRDQmF4aUhYVUhBVTk2UUFXVjZ2THFkL2wrT1EzL3ltR0xYc3FCTXRTaHdC?=
 =?utf-8?B?am5VZGtIZWFwdjJUdVY4VU4rb3lYOXFobzRpbXpHdDM1dzY2MWdVQVcvSWw4?=
 =?utf-8?B?a0ZoOURNUVluRTdtSnhwOWEraDZLMW1kcUx2VURRZEFZWHBZZTM4aHU0WExK?=
 =?utf-8?B?ZGs5N2tiQTBaMDVPV04wK2dMWDlzUlpEQ1I2S1F5c3c4VTEwLzcrZWdRcUda?=
 =?utf-8?B?aFVXWGlSUlRDOXJ1YXZMTURBS2hCVzZ6KzRFR0IxdkpwQnp1bHAvazE3UEJ6?=
 =?utf-8?B?Y0hEN2wzdEFWYUpzV1VWU0FpWVRpY2JrUXp2S0JHWm1aN0lKMjZMSlZYbW1U?=
 =?utf-8?B?SUFvZXJUQ3dCODZ4Q0JLektUcit5a29aaExKVFVtWC9USEl0WjA1SmwxYS9C?=
 =?utf-8?B?M0RGdjYzaXpXbFVkZFVWVzV5OHZnNTB6L3hBbFh1Q25NdUJyQmlocUh6bnQz?=
 =?utf-8?B?eTZ0SGFYbGpTQXR6eUxoUlRYQTdvcSthVzRPek9DWFc3a2QyckVoNnRieFBT?=
 =?utf-8?B?UUpiSVNuWjkvT0xCZ3lhSmhiS3FmTE1uYjRQczdmZDdRRlB1RzIwRExrWmt5?=
 =?utf-8?B?dkU5eVBrWklpTklEaFdMTmE4Z3oxbmQ1S0VPR2M2WEgrSEZLWkRnK3dYcEk2?=
 =?utf-8?B?S3lIV2VoNG56OTl1MjJ4dGlobUJHWkQreHNtRkNGYisrZG1sdm5MSUN6d29D?=
 =?utf-8?B?dDU5b2xwU3R4WTl0b1E5MWdhWkdBVG56K2ZpVis3cHVHS0N3Z2xxUmFVTHFZ?=
 =?utf-8?B?Y1B4MzhhUmtSRGxSOU8wdTRqYitUdWVIZmRmYXNPNURnZWVoalYzVXZlaVc3?=
 =?utf-8?B?MzFWZHRDWnR3YTFEQU05SWRsWVlNQjF2YU5uRjhSRExzMHV5TjVWenF4NEJG?=
 =?utf-8?B?ME5yNXBJcC92WU1yRFViekJTbkMrRFI4SzlwcjF6b0RUVGxLSUtHOUdpTzFT?=
 =?utf-8?Q?8yAqkCYj1yIiAwFVt4QhjIo7/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f925dc60-acb2-4c67-b229-08dcf86fffb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 23:18:29.4499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekvTR+/K5pz9rc8QpIF+AVgIHYqqB3IXNt2U27w0Vx6PsnyGy87XVUzZQVqfqcAF7/IjkHa1hiQj8HDotCYJng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7117
X-OriginatorOrg: intel.com

Pj4gWWVhaCwgSSB3YXMgdGFsa2luZyBhYm91dCA2NC1iaXQgb25seS4gIE9uIDMyLWJpdCBQQUUg
YSBQR0QgbWFwcyAxLzQgb2YNCj4+IHRoZSBhZGRyZXNzIHNwYWNlIHdoaWNoIGlzIHRvdGFsbHkg
dW53b3JrYWJsZSBmb3Igc3RlYWxpbmcuDQo+DQo+IEJ1dCBpdCBpcyBhbHNvIG5vdCBuZWNlc3Nh
cnkuDQoNClNvIG1heWJlIHdlIGNvdWxkIG1ha2UgdGhlIDY0LWJpdCB2ZXJzaW9uIG9mIHVzZV90
ZW1wb3JhcnlfbW0oKQ0KdXNlIHNvbWUgcmVzZXJ2ZWQgYWRkcmVzcyBtYXBwaW5nIHRvIGEgcmVz
ZXJ2ZWQgUEdEIGluIHRoZSB1cHBlcg0KaGFsZiBvZiBhZGRyZXNzIHNwYWNlLCBhbmQgdGhlIDMy
LWJpdCB2ZXJzaW9uIGNvbnRpbnVlIHRvIHVzZSAidXNlciINCmFkZHJlc3Nlcy4gSXQncyB1bmNs
ZWFyIHRvIG1lIHdoZXRoZXIgYWRkaW5nIGNvbXBsZXhpdHkgaGVyZSB3b3VsZCBiZQ0Kd29ydGgg
aXQgdG8gcmVtb3ZlIHRoZSA2NC1iaXQgU1RBQy9DTEFDIHRleHQgcGF0Y2hpbmcgaXNzdWVzLg0K
DQotVG9ueQ0K

