Return-Path: <linux-efi+bounces-5316-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7524C2683C
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 19:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9302F4E29C3
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A622BEC20;
	Fri, 31 Oct 2025 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDu/8QgP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F91B38D;
	Fri, 31 Oct 2025 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761933803; cv=fail; b=tboUt5+PaO1Up6vV0Ujr7xuGoXtQYJhRVTLIZGrV6wDij+b8BI5g5Y03SaeextCiWY6rfdbBaD/PFnac4atm5ssinEiaMziNxiC6uNnrmNG+xnmDGlMaEUc04ANXNZg/ATcn5WoSDEpuCotwXuVenUnP2RXb9CCLaxtaJhtVia8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761933803; c=relaxed/simple;
	bh=0Fjp5URvHhIgsVUUgdzeyiog+Vvooqjx9jPGy1uJXt4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XRBuvABj3jsGV6qrO+sNbXDQCihi9nyTnOsQp2skJb0TI0Pqx53P8DKjqtZohqN5Ao/s3wIjO3v69Qe26KzkaLv4BGvnNf19Sv4sFfCH8tqa5v/2QIU/49MFfqqrPY00xOnyevJNmJwT01lsXi+hBC0hKJtqmAJ+YrlQjs4bZ1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDu/8QgP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761933801; x=1793469801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Fjp5URvHhIgsVUUgdzeyiog+Vvooqjx9jPGy1uJXt4=;
  b=BDu/8QgPGWewnF2rDDZRN5ubi4mKqRbSMn+tDSuVtKrROEg31SnBpye3
   z9Z9CLKZX9toZO5fuVDlVeuUuHHuJvOpP67bpOB7scrTZxyG0576b0QiW
   ZDapOw/8aEdQeVdgsZJAaqlCEVMpNZtqGvESdZLl0xiEa5OY26IZRBgP4
   iFvVtKU6wc32tmd2/kTt8x5RfnS/haxk4OwB0UZUd8GYezOvyCEfew73k
   OxiqQjg/m82HsnB+xbTeuuBq9/+1vgI+QcfcFXfXqanEq402sf6hi3CcZ
   PukxdWtIWdScbOu0Ew3NIYHcG3fJ5i0+qu6O0QwnRHxi/yIRYXzbw2onK
   g==;
X-CSE-ConnectionGUID: a/LPl6+fT1+UjIUBds8ygw==
X-CSE-MsgGUID: tYuwi7JnT7O4ma1tq2nEjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="75216775"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="75216775"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 11:03:21 -0700
X-CSE-ConnectionGUID: WTgzj0YOQ2assOUmgrUV4g==
X-CSE-MsgGUID: TVQ43dB3RsuCIgyS6n2ECw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="185960056"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 11:03:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 11:03:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 11:03:20 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 11:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fK8AuM/8Kqt1wGwuC7lZV8JroFVFsEIu0QXttM5PXYv7QjsH1UA3dkZKjfdnqf79aRI31FEfizhrUVfAhaBFF4jIGftG6y82FJuTALys8Dpv1mqnFfZX7FjGDH6gECVExg1kwvlotPvBhiRrhYwea9bp7scFka/vS1B2OhByRvv1LN6QrUmeZz+KqmwyzH2yCsg1InMUcupYA4wE0+cXG3ksI4tIo6zbife8r5j+Urd37vRrmIibyB/pBrolCkPdSRKprlW1YVoipr0HOUuVY4jKpBG0zDWQlE+3gJaU7pwOcczyc0nQwLQn0XsiIzQgF1NBR1cqi57y2FEVb4J5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9HysKsqcVWB/xmJO0gYvyUgO1+G/V777nW4Jh8dc8o=;
 b=nfK4hIoT7DaeOSjewcARjlK7dBgV0pjW4uWMeL+zQPFRQHVXlW4z6PiJ1UoKf1XPk+uKHKvWwJcuyaxQ8ODrJAJ8LcpJH8ukJ3DYwKLtVzE8UOQ75weB4aQKZhXSX+m3T+rGiFLDM/jOLFFOSK5ayKY0TWD4GcXLbEcrPUz/8WpzimGRn0sh9nkHmDK1MROIssMaouHqtpxTZzql6ZJX68yNoMH12WT1t0pu+zd5oTjX75LovZeBsUC8Enc1+a98U6KRZSTXK0L80MV0SI1CAK8/Lj0sfUOeDRc1vsV8clqGTLxR5h7S+lcUGRrQqrf7FiUEwldQYoo+q8M74Sqs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13)
 by SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 18:03:18 +0000
Received: from PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba]) by PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 18:03:18 +0000
Message-ID: <efd6ec82-5576-41f1-a244-2f80d72e93e4@intel.com>
Date: Fri, 31 Oct 2025 11:03:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/9] x86/efi: Disable LASS while mapping the EFI
 runtime services
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC: Jonathan Corbet <corbet@lwn.net>, "H. Peter Anvin" <hpa@zytor.com>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Kirill A .
 Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>, "Rick P
 Edgecombe" <rick.p.edgecombe@intel.com>, Vegard Nossum
	<vegard.nossum@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-6-sohil.mehta@intel.com>
 <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
 <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com>
 <6dec8398-3f7c-44db-a30d-33593af0217f@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <6dec8398-3f7c-44db-a30d-33593af0217f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To PH8PR11MB7989.namprd11.prod.outlook.com
 (2603:10b6:510:258::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7989:EE_|SA2PR11MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: b71f9b14-d41b-4b8e-5c61-08de18a7c52e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEJoVFZ4OFlKb2lpSENET2M4MjhmSDRJcFc5ckxkWU9jSlhBMDhYZnptejRZ?=
 =?utf-8?B?S0V4eHRBcVRPVVBCeXh4M3BLWkJwSEQzeTU3OHNXN2FDWmJXQ0hrSWR2UEMr?=
 =?utf-8?B?TTZaKzUvbDNMck1VeVpENWp6dU9DeG53bUpQYTBCelVIWEdXMHdSbUNkdUJL?=
 =?utf-8?B?V1Z0MUNnWnhVVkRCdW9mYmFMMnBraExlTU83OGI4UlVZd2VXUmwxT0ExS3Jx?=
 =?utf-8?B?eDRGcnZTZC9sa3NBWE9wYXVxU0pPOFdBbGhFSFB1M3JXdXFDU1QxaFB0SzJ6?=
 =?utf-8?B?a1RuOFl2cDAvMDgweHh6bjlMZTBiaE03dVkzUWF1Yi84V1BURHdpRTVuSGpW?=
 =?utf-8?B?cnNNUXFJUXBMM2ZjcElQL29sWUhTV3dEamZTcGp2a2VvYUprcHA5S01XUWlz?=
 =?utf-8?B?QWl3NTJWM2xMb2dEc0l6MzBqQkVXWmFyUVhtRUJQSU1iNlRWMXlIT3lmWVFG?=
 =?utf-8?B?SWlodG1UOTZqRU1CYXVvdUpiNTRScUovOTQzRS9oTVRxb0hWTU1JVlBtT3NF?=
 =?utf-8?B?eE1BQXRkMUlRdkdZU2graU9lUlpqSFljRXJEK0ZYVTN6c1FDMlRYMFZsSWNN?=
 =?utf-8?B?aUhkeFR2bEF5dXhISm5NQ0JncDhXeTBCU2U0bnY2aHFyK2lHZG9vVUs0ZFdv?=
 =?utf-8?B?aEltTUNTTzQ1bE85c0NlYVZuM2I4NlI3UFZQTWVQVkxmV2NzVHJ1UnE3dm9V?=
 =?utf-8?B?RVAwNXA2bmRqR0ZwWkdLdE5jS2ZEOHJZUjdsS2Y4Qkp3dWs1MHZuRVpYenlK?=
 =?utf-8?B?RGhrZ296ejE4RUd5T1BLeEhiZzBBNmdqYWJHa3p1S1pzanAzUlJCMDVQVjQ4?=
 =?utf-8?B?SHdNeEdwK3NXTUUzN0gxZEZEUHluR2tFeW5QSGNOcDQ0UjlEbVJMYmRiT202?=
 =?utf-8?B?VUhQOHpjODBWK0JxcisrZVdiVm1ySU1FYmZFdjRXelNjakNrV0w2eWNoL0RQ?=
 =?utf-8?B?T1MvM29kbW1KdmtJMWVDdzRaOGZqNllRK2t6Q095d2IrRlFFRytuME14RXZS?=
 =?utf-8?B?SWVDMlZSUXBEMlZHdXFLbVVVL1R0TFpDZ01VRHUyenZCd2NFbFBDYmtsTFRT?=
 =?utf-8?B?OFJSVWhNYWxINGlvdndwWmgveWRnMGg1OGloRnhvV0RMaFpQRCsrbHc4QXFG?=
 =?utf-8?B?VElUa0x5YTVwUGdXa2RtVVhCc0kxVXU4N3NkY0JjUHBvV0ZEZm83Sks4RS9F?=
 =?utf-8?B?a2lnNXJNMWpsMjl3ckZRbmp6VjcrR2lXSE5mc3RBK1ZiWkcwN0tUOFU2SHY4?=
 =?utf-8?B?VHhycEpWMUszQ21hUjh3ZndIQnYwL2N0cXlvT3FsWlNkL2VuWWpuNkw3WnIv?=
 =?utf-8?B?OE9wbTVnSVQ1ZTVJeDNEblI1MTVuTk5yWXhRMC9QdTIvc1dqa0VDcWJ5QWxx?=
 =?utf-8?B?R1dmMTFmYVJHVERTaTFzWFJkK0Z3ZENJS05UUWVkOHlQWUFpQ0Vwbk9nRmRB?=
 =?utf-8?B?aExEVkIvWWJGdzFnUUdKR3d4U0VXQmNmblJMY1JaN3lvTEpTK2hPZXFlNFBN?=
 =?utf-8?B?WFowb1RTNmpuME9kcGFVc2t2aUdqZHNySDMzcG9UdnpCamlUdzdsNkVJNURa?=
 =?utf-8?B?Q1p3SWZRcHU1SDFvSUJwNG5wckhIdkcybTV3RjdaV1pla0ZrL0dKV0ZTRGsr?=
 =?utf-8?B?UFI4SHNwVGx0bW9LRjUxYnl1dGVjcWhTZjhzbS80WkNHUFgxSFhjcnl1L2Vl?=
 =?utf-8?B?ZG9NaFFRckJGSDBxTnh1dVRjZUY3SUsxbWw0bHpwdVlEbnJScU5lYzBLS0U5?=
 =?utf-8?B?UkNCbVZSNVJqcTFENmprMmVlNnh0dE1pTERhK2RiV1Z5aktsSm5pUEkyQVJt?=
 =?utf-8?B?YS9IcWpwOWpZWER3TDJBWUNVVHJ5UkZ5K0xlT1FkbGk3MUN6SUVVNWdMQ2pw?=
 =?utf-8?B?SGY1cm1YR2had3Y5eWJJa3h0WlVvdXZVT2I3WTlrQnJxTVBRRVRmNzRJNUNT?=
 =?utf-8?Q?WtktV/qYhJDONrWie5uEjXX7MLXPPY1K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjQraFhpL29hVWEwM21MR0YzN3JoNWdaaVdIMk9DRkk2ODdVR3c3YkQ0U0gx?=
 =?utf-8?B?djE3Y1FUNFJGMkpWZlRWbDF6ak0xK3VmMStod3V4YkxLRVdDNDQ2WDhaR1ow?=
 =?utf-8?B?ZFFnQ0VRajdZdXhNQ3FNdEVIZ0lTb252ZWV6OE9ibDhGaDU1ajRtZzFjQkU1?=
 =?utf-8?B?a2lXdGw3bXRsbGZiOXlmbzRDU3BqOFViN2JYL3lsL2lWNDJpSE13d2VObVor?=
 =?utf-8?B?UGNiNFBjbXo4NktIN295RTdzamhydkJHMm9lYitqT2lGZGF4NUhBZU0rRFQ3?=
 =?utf-8?B?Q3VCTEtybTU0SWMwOEZnNnU3cEV0eVhGZTg5OEVyaEwzUFhsUGsyMmhhVGlE?=
 =?utf-8?B?YktqMnVFd2loWGlTYW9za2VaMjYwY2FjMlY3WFVrWEU5R1c1YTFPYXIxem5l?=
 =?utf-8?B?SmwrNUx0Zmx5Q21RZUVkOW9UV1VYWWFQd3Vvd1ExSzNhL1MvNUx2Q2syN2Fo?=
 =?utf-8?B?VEYvTmtGT0x5ZXRLUk1ZN3hOR2hJRENnM0I5VUFOTmdyVzJUZXRTcmpZbmk0?=
 =?utf-8?B?Zk9kRzJzUldnUGFSNHJmdzljTlZ1KzFlcEw2TVpqZlorSDQwdVp3eThSa2Ni?=
 =?utf-8?B?b084RG15UXJUazFiZDhGRGdwU2hSQ0t3VjczQnhESzRUQVR4V0tkWU9UYVhW?=
 =?utf-8?B?eHp2WlRQQUN3MkxDeE9HRmM1YnVuS3pVbG5SUlkyRy92WmgvcTZkVzdWWU5N?=
 =?utf-8?B?aGx6MGxOSHdTM1RPbkVvU0NJV3ExaC9jZk1IQjMyTVV0TmFwZDRIR1l3ZmtI?=
 =?utf-8?B?ajVSdnhYVHEvZTdCZ2hDMmtWOHJ1NGpJUVpST2F1RUg2NFZJd0RXdi9LU3Fl?=
 =?utf-8?B?NEdyMHlOYVZqaWM5NVUrQ2dqaFcycGRlMytMUndObzhKUUpIWC84emJEODVO?=
 =?utf-8?B?ZmlYV3FiQXIwQ29yVStzYXA5SGV3NUM5dG9kakN3ZVhGTC9KdDlIQkRRVHVZ?=
 =?utf-8?B?OHpsZnhyd21DZHFWZFQ4VnQySTBuT1R5aGd1STZacDhzYUJTRldWQ3BTdC84?=
 =?utf-8?B?MVVtQUZsQy9MdlBtdDFWcEFvR0ZDVzVHNDlPbmlER053eHV1Q0FXR1B6OGU0?=
 =?utf-8?B?SlNYT3gya3kyWDBZTlp1MXFVMEZRUWFnOElxaUpsNTFuMHlEcjMvUGtDTHBB?=
 =?utf-8?B?cDFleG52OWF2S1p5NUdaQmFXRjM0ZkE2ajlZMXBnVUtESWMzUlF1bHZNNjlp?=
 =?utf-8?B?bTliT0hyTjNJZjVaenEyeU9IZFRsc0V1QVE0TmN3R2wwZlRvN1ppZDVrbG9B?=
 =?utf-8?B?TnFuSm5MTGtUUEx0alJhem1KZkRSZlpkWEkxSURZVy9OMHkvZEdnMGxIeXkz?=
 =?utf-8?B?dGFjSEhoaEJxQ1o2ZHZidTdJMkdLQ0hhNU5JMU9BSmt4VUx3RG9aRkRIaUVZ?=
 =?utf-8?B?WVNLWDBEZG1YVUtOSm9HczF6WE4ySG1NVUl3aFBMMk14bitBaFJPWXNONnNE?=
 =?utf-8?B?eitEdFJTRThGUWtpWjVGRWN4cWlJYUdBT0J6aWgyaml4K2JSNjRRVkQ2VVNs?=
 =?utf-8?B?aXZLYUhpb1p2L2psQjBXSEl0a3BCQW9OVmxlRUtERWVjK1F2bUMvZXE4WGNE?=
 =?utf-8?B?L2grMGhlenJiRVExN1liakZxOGV5WXN3N1BuWE1wQmljcUMwL1hSTVl1czRV?=
 =?utf-8?B?bDBFSDJtK2t4OEZOQ0dsRFJTSm8zOEx3ekRYb2Fsa0twVU92TjJGTFIyS1BZ?=
 =?utf-8?B?bC80ZXRBazBYYzc5N01KUmkxSVV6YTdhbVpoVVNOMkp1Q0piMVErNmYxcm5q?=
 =?utf-8?B?d1hSQVo0emQyeVBQRXRXRmYwdjlkU0p2aGp2NkNNNFpFbVUxVm92bCs3R0Iz?=
 =?utf-8?B?cTFOZlhXeG4ybnNQNS9FVENsS1VsZHlaRk9UWlBLTk4xRWszemRkb0pKSC9E?=
 =?utf-8?B?MUZVU0Uwd2tIc1pZVzRLWWpReHZVYXdwU1k4elJhQmpoSnYybHV2ZTVaOWRu?=
 =?utf-8?B?ZXcyZmV3WThFcWc5ZkhHK29KK044SWNKc0pKSjYvQjBtTlAzUitlY3FINUd1?=
 =?utf-8?B?SUFZY3l0U1JFSHFjMEc4dUgzUXplcHNCMzZhT1dHdWhIRXNvUk02SC9MVVNW?=
 =?utf-8?B?L2hIVXVuZHRITnZzNUZpSkJWblRXR2xPVVFGWmtTNW4rWFd2bFVKQnNoSlpN?=
 =?utf-8?Q?IBXB1A+5hZjbExIs+ChwtZVhr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b71f9b14-d41b-4b8e-5c61-08de18a7c52e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 18:03:18.1770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Vjg5keb9AbukyJD0FVUwNQjCJI+V37DeYIo5E/5Zv//8crc6tlx7UofMUizWTb79bJ0xCUGMD6uQfcHz24L/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
X-OriginatorOrg: intel.com

On 10/31/2025 10:41 AM, Dave Hansen wrote:
> On 10/31/25 10:38, Andy Lutomirski wrote:
>> Am I imagining an issue that doesn’t exist?  Is there some way to be
>> reasonably convinced that you haven’t missed another EFI code path?
>> Would it be ridiculous to defer enabling LASS until we’re almost
>> ready to run user code?

> Deferring is a good idea. I was just asking for the same thing for the
> CR pinning enforcement. The earlier we try to do these things, the more
> we just trip over ourselves.

I had suggested deferring as well to Kirill when I was reviewing the
series. He preferred to enable LASS with other similar features such as
SMAP, SMEP.

One other thing to consider:

Doing it in identify_cpu() makes it easy for all the APs to program
their CR4.LASS bit. If we were to defer it, we would need some
additional work to setup all the APs.

Do we already do this for something else? That would make it easier to
tag along.

