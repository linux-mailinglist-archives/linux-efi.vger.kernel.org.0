Return-Path: <linux-efi+bounces-3881-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E28CAE21F0
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 20:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C733A994C
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9573821516E;
	Fri, 20 Jun 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqe3Z7A+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC049641;
	Fri, 20 Jun 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750443335; cv=fail; b=Oqb/D3kmGHfDGj+YqGhll14DHCZGvDXg+UbRpgpM8MGjynUJ8SuoG8rjJdpXCCfY16JU/D5tGqcSl66wwWw7Y6O8hMFncHfhIgZMj/YfeyP0RrFCR7kSuYAtQXRffZRCwDWFnKnxnx/msriURaoel2VeCfBYjR4Y8dINiFNZlv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750443335; c=relaxed/simple;
	bh=AGtFTqyYXqphcjuhKY0jGD4hYbL2dbJLcJ5c2auJ7Ac=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HiHSw/eO1V6Jy3pY2Q9ByHUtjKWXgUSxqLiclhq1xp5O0HUbl6/0VUiYupO/dpdE8SWkLN1yPhe2MsqT4NgVoTK6hEXPTYcFPWVNlh6r3F/coazT7Gmgkz6mexf5McYl+Xv0G2q7jknbxC4KsW/yvx20be0mzgZHD6g0kkZXPyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqe3Z7A+; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750443334; x=1781979334;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AGtFTqyYXqphcjuhKY0jGD4hYbL2dbJLcJ5c2auJ7Ac=;
  b=eqe3Z7A+dKzvSwUZUnO+lu1ZMEpv/gN3lEMbyD5pI2TYdRXdK6ajbcS8
   /Qq/5FLSfHd54LkW5IE5m3TdB2BheOpFsBFwuxln2+xhWApOhsLLi7p8i
   cq3Qr6xP5l9yRIgzXtrTmFvfu3NA4/zjPMzlBeASsj6XIoZoZCJjVcRWW
   gH0MiBPgMCYPt/sHh3mDRqJ195m9NyyI8sVVs4sTxddiP3dbW1+VmDrwd
   Gux+lksJYrj2SfRKTG0zxIjXoL1JOeqE+xEkV4sL8w5/2eR0W0mipQPDM
   fKIhKd4KAYSKTSZAUk1fLb5Sl80onpUbKLOcmQ2IVKzokp50PPHyKJN0q
   A==;
X-CSE-ConnectionGUID: B4YOEDeyS2eVBcegnWn+OA==
X-CSE-MsgGUID: 7H7K8iliR4KAcIezAEM2UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="78123152"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="78123152"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 11:15:33 -0700
X-CSE-ConnectionGUID: Fsjd8+PfRciKTRPXOZSLrg==
X-CSE-MsgGUID: gEfD3VXURii2YnUsAV+Ohw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="155367537"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 11:15:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 11:15:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 11:15:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 11:15:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7vJ96xlanttr6xX5NOEZ0JEhHIucgPgSmFZWakXfrwIMr8F4nAKMx7ifg6qNJqTyt9rQDnaY2dR6esZhFhDJ0zX1KoP5eOQ85eGcWQG/TWZBNYbh/dJtTMmxYmOGtakxsJ/SejGJk2n+JdMKRUvzsvz0kRwbfirDqS6An21kEfr4cB9G1RRFX81Ok6w7TxEsKMlIhFUDvLitqVta5lGt2jIklFkd1S87lidlWzXx3H4ynZTpZ3TkEXJ0BWbTQZlk1JhWjRlwjQliXgiQYxq0ezS+4lyFGjfs0Uh2HIA6yPnPpSyy7QokGTtI3qqpWp44YD6xnaD4D+A9UZ8NU1c6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp77A6v8ER0+ZXLeKWfFmY2JR6f+dfOSHkn2csOlwKo=;
 b=ShUA0g9i3swNy5Hy5VifYHUSWRL03aMZIkVlPNThVVKdYBBf2ALtCXkO0soBbYFAoC94Cd+q4Nu3J0Rb35ECdMxJ6JjMqA6Qm+3sSDCvOToFCAVqTmg4B2VefEZsdp/hu6hiNI94ZshuLTVipwFEZW/ObaQaz+izWL+u00PwqOiIwzgNqQU4mGjbZEG/cueJ5Jjc9CC4qgKWiRxCcgM6c2V+3Y82Gs8twMgxqY6LzqaSahUbC0t5iWCftQucsGZEV7fB56AeRTASKDeIsBukNlqs87nEqvGjEEzKLG4BV4/TwGSLxru9BrBgYzddLF6tCgj5Mh5MQv632/cdOdKUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW4PR11MB7008.namprd11.prod.outlook.com (2603:10b6:303:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.38; Fri, 20 Jun
 2025 18:14:59 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 18:14:59 +0000
Message-ID: <248e272c-79ec-4c11-a3a8-dff1de2147c0@intel.com>
Date: Fri, 20 Jun 2025 11:14:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, "Sandipan
 Das" <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, Hou Tao
	<houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, Vegard Nossum
	<vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers
	<ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu
 (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
	"Rasmus Villemoes" <linux@rasmusvillemoes.dk>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du
	<changbin.du@huawei.com>, Huang Shijie <shijie@os.amperecomputing.com>,
	"Geert Uytterhoeven" <geert+renesas@glider.be>, Namhyung Kim
	<namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-mm@kvack.org>, Yian Chen
	<yian.chen@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <peterz@infradead.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>, "Brijesh Singh"
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::20) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW4PR11MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: a933fe90-769b-4db5-dec3-08ddb0265e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVB6K3lwRVJCUlhMZng5RGFlbWRqY2JVc1A4ejlpR1YyK0pDNUZqUTNNQkQ5?=
 =?utf-8?B?Sk41WEpjYk9UdElmdVcyQUdBKy83SUpMdmdwQjBzck9ES3ZUQWgwSUthQXdt?=
 =?utf-8?B?cmFFWkp4WXRZQkNMMGJnMVRYWlpuUWNLQktMY3dpNUZ3VUdMMTJYUjdTLzFM?=
 =?utf-8?B?NmtTZm0vejRKa3ZMdWZ5RjdZZ2dJSWdlSUJqOWhCaFordVJuRERLdm5uY0Iy?=
 =?utf-8?B?dWZjUkhTWlVZMnJWaHZXbUFBMGUxaXdxQTI0cThoOFJLSU1MSExZQ1NadUF0?=
 =?utf-8?B?TUw1Z2JvRXBEcnNFVU1MaFRzZlJjOXRaRWl1Sm1RdVFGb3lSbTh3T0tRVkFy?=
 =?utf-8?B?MEZpUGtxbmFHK0FDZVRJUjl4V2xVUVNxTXQ4UDUra3lrSC9uRFNiNkdLNGJi?=
 =?utf-8?B?eDJlbVRxSWdmT3JOOWxrU2RHNDJOODQ1eEhpeGhpWG80Tnp5UFlWMTBmSWNj?=
 =?utf-8?B?TDRUdE9mc25MQnhXRXY2L1VVRXBYUGJZMFkwVTV4NmpoaHl3Ymt2WEF6VWNm?=
 =?utf-8?B?eDNhT0ZzNU1zanBrdStmWEEwQ3UvWEQ2dmkrdE5abXgra0lXV2FIa1FXSUIw?=
 =?utf-8?B?RDhucGpMSHdrbGtIR0VLZEZSUnpYVWsrRFpjT3B1Vi9wdklTTS9ZaGdPcmVO?=
 =?utf-8?B?WWpiUWVDZlZMVkE1Ni9DUWtiVTRNclFZQTlPRFJYcGlOY09kMjEvYkZIVlZr?=
 =?utf-8?B?SHBwOFowNjd0UElkRmFHYVd6aGRjeDZQVm1YM3RQTGd1Z1E2QU5CTGs1ejlv?=
 =?utf-8?B?QXRJeG42MG9TSFdRU2VvNG9KdlJXelAxL2p4T1pkb2VvVmFJVTcrOUNHS3J2?=
 =?utf-8?B?Q2UzVXcrd2t1SnFDR2x2NzE0cXdDamJHbVhsSlBqeTJQRk0wMmFudXF1Q0Vk?=
 =?utf-8?B?NTVGUjFBSDMxVWdFWjZVUG9jUmx4RmdpY2lPL29mWFk2RzQwSmlxYXZmbDhZ?=
 =?utf-8?B?RldLNUN6L1QvTVVOajRQZVJ2RXE1UmRkU1NMdStTdGxiS2s1L0FmN1Z0K3k4?=
 =?utf-8?B?OUZqbmtFWjlBS3BIeHF5Q1ZaTWY4T3l5dEhTNC8zajQ0bVYxVWhVOXdtcXZH?=
 =?utf-8?B?OE9iOS9BNmxHQnU0NVo5ZEFDbXl2QnJBT0NsMnM4ODlZdXNINHNIeHIxaTBY?=
 =?utf-8?B?Tm1LYk1SL05JaklNVGpjVUZWVVVqNGJLZUNKdWY5WlN3d0FtNkpqR05JdlMw?=
 =?utf-8?B?ckZkYTVOK283WWdFa254OEs5Qld2N3h4YVlWdDlZWkNiTEswenJOVlRmVVhm?=
 =?utf-8?B?S2lCclRIVm9HdldHZ1lLeUxQMDc3UXBzUkJydklPdnhjcVdYREtQeUd0Zjg3?=
 =?utf-8?B?VC92b0hlR0NRTVZWajlsM2xVSjBmVHl4cXJ3TG9JN25CRjdhZ1QvanJ3NkRL?=
 =?utf-8?B?UG1MN0pXU1pSVEFBOFJMa3hRVWx0dkZMS2NKd3dkV1c0bENSWUNFU2JxTWpJ?=
 =?utf-8?B?a3BlNVk3emg5T2NzMlBuL2ZnUmE2T3IyQnlHd1RFcGRTWHQ5UVNHM3YzNW1n?=
 =?utf-8?B?bS9EZGp0SnBZaGRWQzU5RU9maS8xTVBlQnZxcW5jeFF6dk9OcVM1Y3Rzd1pB?=
 =?utf-8?B?OWFkRGRGaGZsSjRCeW1Zbk9LTFUraWFwT3RSZnNnNXpWcWs3NWw5bVB3dDdF?=
 =?utf-8?B?QXE3MGFpeVhJaVpBdXpxank1Qkt2WGl4UTdSaUREb0MxZlRHTUYxTXkxWEJt?=
 =?utf-8?B?ejY4ZE5ZZDFkN3NOYVFRRjlLRnN0ZjduTW9iRW9SR2VSV0U1WDVOUDBxaW5K?=
 =?utf-8?B?YnlkNS9ZeWpmeXNYL2NKOGt4TFRyVDZpT2FZcDBBL2dDWkZBQm5WRkV6RGF4?=
 =?utf-8?B?dGVoc0d5T2hpd2NsNnp6dzJ5Mk8zUU9lZVlqT1VWMFhMQzR0UklYdno4SVlq?=
 =?utf-8?B?elRwbUhZRUNDQ1p3c1B4cERNZ0Jxa2N5aTNQWnJBbE0yOUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzBBVGVrUlc4TTE4cUNyelhlcXlHaCtzVzlBSDN1dFFSaEh1Y3p1L2VzVVlZ?=
 =?utf-8?B?M1ZGRVcvSXZvT2FtWURKL0lJZk1UTVdXaU9aR2NqRXV4S3hZV0lsMmZpZ2Y0?=
 =?utf-8?B?TXhseGZjUWxLQjVxeVkycCtoL3dCdzViczE2QThhd3lUei9DUWdRMDg4eHpV?=
 =?utf-8?B?UEtOVUhBMVU5eWN0Z2l4aVd0QXVtM2c4ZGg0Vk1UdjJvTVBCWTk4K2kwOXg5?=
 =?utf-8?B?NEhTbEQ0ZVRQNXRCcVVyMzZCbzVDc1JqOER0Vk1GMXg5ckNpVUx6MDloSmxC?=
 =?utf-8?B?T0NJd3IyTUxhQmVMVG5oK1FGRDB3NjVNbERjU2ZFbVlTd0E2WXVEUFp1cE4r?=
 =?utf-8?B?VW9XS3duY3ljdHp5NzRlcFBvKzl0ZnBvanNJWUJwdjdWMzhLK3VvdWhneXFn?=
 =?utf-8?B?Ly9sdzZETlI0TnJFZEdxZHJxWWxVQUFqWEhFYXB0L0kzMDZBZEh1ZTZ3aEo4?=
 =?utf-8?B?UVhlcldMN1MzQjZJaituNjBXeXJtQUUyTFJvWTZBODg0NWRTUXY5MFBDSklE?=
 =?utf-8?B?anc5anRGQ1BMb0dkdHRPd1dyZ2p6S01NY1Q0aFp0N1VibEVuQUJBeWM5STNR?=
 =?utf-8?B?cUYrNEJ6Zng2eVlmVUZ0aU5uSk41TmlkRE1pOGwzMmlHeUU2SnJvcXJRZU9M?=
 =?utf-8?B?SXpwajJNeUtWTGgwK092Tm9HVzdpQmZobS9nWmUvcUEzcHVQaDRmVm1JYnk0?=
 =?utf-8?B?a1BKZ3MyRGdac2NQTG50SWc3T29lanh6YnIwNHFKVzZKR2hXWTJ6TVJESWxQ?=
 =?utf-8?B?WHJ5RlkzWEJlVlFHNTRmYndwTUJITHVqbncrUUhOTkdnSll2d0JLaWFRem1w?=
 =?utf-8?B?TXhFbU1scTdQSXVBelgrV1Fyb2kySytQWmtsRnNXMVlEVGdDaWw4SG1Xb0Jn?=
 =?utf-8?B?V20wdXB4RWJ0TVRDNU9BUUdDRHhEVEp0NXVTODFHK09yZi9YVytoSHlUdGx3?=
 =?utf-8?B?UGRYa05WTmZzL0J5UTlOMk1HODdwRmFWSGpSWTZTUHkyRE9GRURHcHYyRkF3?=
 =?utf-8?B?aFdrbnJ5TXFPd1RHL1hEWm5VWUlZY1RoZ3liMTNxNzJPMjgwVElaYmFVNXlK?=
 =?utf-8?B?MVJnd1RCc3IxT1BnZElpS2N0emhBUVl1WS9lUmFoTGxrb2x1b3JoOFRvVm4y?=
 =?utf-8?B?L0xGK3NTTGhGOGRkSUdHSDlVNUhqK1cxNGpvVnRsczJmTFliY1p6NXdKNEg3?=
 =?utf-8?B?d3Rrd3Z6YUIwNG55Z1NiVlNzeEhjUGs4V0JPOEZrV0hhMGRHUWJmeXhPd2lB?=
 =?utf-8?B?OUJMZzlxVmFCVUFMNnM5UzlkUXdoUlBmSkFNRHFEYjZFeTN2bDMxcHIxUnh3?=
 =?utf-8?B?N1F2YVY0VmpzTlVWMGpNcTl4OTZOSVpBN01IYWZzRGlNTklTTGlrSnZZSEtl?=
 =?utf-8?B?OEZzWUlRSkpnQ2NJYUI3SDMxOGlMOStVSVg2dGFNWUdLaXhUV0NyZjNjYXdu?=
 =?utf-8?B?L09SbHc2ZGNCQmFOWUFRTDVmSFdRM29Nakx1bFgrUE5PRzU1VHJxUFlyL3Zs?=
 =?utf-8?B?d1FKb3QxUlJNWE1XN0QvSmR6bXBySVU1Tyt1ODdKbWNaNHc5aVVLZU5ZN0pM?=
 =?utf-8?B?VVFpdnVtbjZTN3NHQWxReU0wVFh4dTNsTFI4MUdTNzFiUDZLQitSYyt2RXNq?=
 =?utf-8?B?blZia1JuZi9MWGJnaVpVTkhRNTdpcVA3ZHNlcWNOME9mMENNOWdvcGVpREtJ?=
 =?utf-8?B?WWdtNGlISFVqcHk3NVJ2b2hmR1BTUDJKUG9nSU9vRldQQTNpRFJMbFhCT0M0?=
 =?utf-8?B?MnpRWExwc0hJeDlLNGowdlFkL1ZINXkyMVQ3UWRBSDUzNTlodjV5RUt5Tk8w?=
 =?utf-8?B?VDR0Z3JmMUV1bzFDRHFON2hBN2FrV0ZDOTFZSWxMOTJNak9HM3RsaHNIdWF1?=
 =?utf-8?B?MjdhTnhHYjNBWGU3VUkxWTl6OUpoeXJXa1N3RUlSSzBaOHR6eXJlQ3plWnVW?=
 =?utf-8?B?NTRtemR5QzhSa0VRTmIyRSs2TUQ1TVFMdHI5aWwwYUhLMGw1cEpsUjIxS2hl?=
 =?utf-8?B?S1pqTXBkTzc2bUx2eUlBY2JwZFdQbnhIWTZRcUV6T28rTFRTNmJYMEJBSmJX?=
 =?utf-8?B?aStjTWhDcVBMRXFvVEFlaTkzRkUwa0tmSVdqY0VRKzJRRHV6cWdqUDhRbkd4?=
 =?utf-8?Q?s/PXNYPIhhJWpGgqGFWJDBEJS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a933fe90-769b-4db5-dec3-08ddb0265e25
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 18:14:59.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOxbWkF3xQ472Vk5vBioWLdX4Mry6D6q/9DtfOtSKbl7uQGogSjmKq862qMYvV8IW3gDqPVdA92OdMDw076R3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7008
X-OriginatorOrg: intel.com

On 6/20/2025 6:53 AM, Kirill A. Shutemov wrote:
>  
> +/*
> + * The CLAC/STAC instructions toggle enforcement of X86_FEATURE_SMAP.
> + *
> + * X86_FEATURE_LASS requires flipping the AC flag when accessing the lower half
> + * of the virtual address space, regardless of the _PAGE_BIT_USER bit in the
> + * page tables. lass_clac/stac() should be used for these cases.
> + *

Is this supposed to be "regardless" or only when the _PAGE_BIT_USER bit
it set? The way the sentence is worded it would seem that the kernel
could always use lass_clac()/stac() since the value in _PAGE_BIT_USER
doesn't matter.

Please correct me if I am wrong, but here is my understanding:

X86_FEATURE_SMAP and X86_FEATURE_LASS both complain when the kernel
tries to access the lower half of the virtual addresses.

SMAP flags an issue if _PAGE_BIT_USER is not set. LASS would #GP in both
cases with or without the _PAGE_BIT_USER being set.

However, in terms of usage, we want to use LASS specific stac()/clac()
only when _PAGE_BIT_USER is set. Since this won't be flagged by SMAP.

@Dave Hansen, you had suggested separating out the SMAP/LASS AC toggle
functions. But, the difference in usage between both of them seems very
subtle. Could this be easily misused?

For example, there is no failure that would happen if someone
incorrectly uses the SMAP specific clac()/stac() calls instead of the
LASS ones.

> + * Note: a barrier is implicit in alternative().
> + */
> +
>  static __always_inline void clac(void)
>  {
> -	/* Note: a barrier is implicit in alternative() */
>  	alternative("", "clac", X86_FEATURE_SMAP);
>  }
>  
>  static __always_inline void stac(void)
>  {
> -	/* Note: a barrier is implicit in alternative() */
>  	alternative("", "stac", X86_FEATURE_SMAP);
>  }
>  
> +static __always_inline void lass_clac(void)
> +{
> +	alternative("", "clac", X86_FEATURE_LASS);
> +}
> +
> +static __always_inline void lass_stac(void)
> +{
> +	alternative("", "stac", X86_FEATURE_LASS);
> +}
> +

