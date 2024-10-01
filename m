Return-Path: <linux-efi+bounces-1869-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131CE98C210
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 17:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6F31F26501
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 15:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC98D1C8FCE;
	Tue,  1 Oct 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LqtKNfI4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C101C7B73;
	Tue,  1 Oct 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797998; cv=fail; b=NNgaJeQRXEcramXfWHI5Q5dkARdyTt57kN07LioaUWmWQAmrqxDJiSy4cC4LW4Uf/p8RmfIhXCQVYBlDscs1ShFb/SPjH5qamDVbbPxhmzYx0TCsFhPBk5CaIRbzvgxaEWw/n5fFtUqHjneHHvIrxSPk2QizFqDO211Tuar7rH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797998; c=relaxed/simple;
	bh=vqf/hFUCKphqAtH3y2/dnckjofeZtfvCZkXDd4UynN4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AYbag6ke2InIL01XbejqCjIc1aVb5o8UtdZ0MhZo3OhkZFCTy2D5C7Q6WyW4H5mG2X1w9tTNxGTjzzZck1YTdWxSfwAHwI04rUNwytJ7EgUeloUTEobHzHzXdVQKStSUxjhIBYctwsWEvUGfSDja1GKXjPQ4Dq/8QddnBkII/Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LqtKNfI4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727797997; x=1759333997;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vqf/hFUCKphqAtH3y2/dnckjofeZtfvCZkXDd4UynN4=;
  b=LqtKNfI4n6REZFT9hQPuDxTuS14T/Ms8JWoq7yXPt9VI91Cih4MiXs2d
   JPjTaDbDDRphkIwqoHOqPJrmSCLeFfPiz5zGZfsnZWqC6AuNBIRyCmCj2
   /XGnOH04kvTZtBU07EddKogtLmu75R27PH2ztQx9qzZDesp/iq4IKccJS
   U5543nhVBHx88Ba3Y0GCgNaY0Aa0WqGC9gGnLT+eaKyp0d8g9bFKXoMVU
   qwMhZIjuk604QwUHyCmz7+GkrE9tuTFOlv/xK09c/oAfcep/9P+hZ8E+E
   S/TyFSvUY8fbLlw3S4H3A+6mDUTDFDyE9T7fTSXU/c8B79cGLXeHnQZYA
   w==;
X-CSE-ConnectionGUID: khcG01sHQjOLBkmfSPft6w==
X-CSE-MsgGUID: BGwGfBe4SNqv4DsLtvVTdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="44465927"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="44465927"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 08:53:09 -0700
X-CSE-ConnectionGUID: KspXjiZ2SHSDoxyqhFgRbA==
X-CSE-MsgGUID: /cnDZgThT3eHshF52U7Wew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78123120"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 08:53:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 08:53:08 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 08:53:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 08:53:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 08:53:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9hJmwhZrHs2fktWBECRyB1ntt1BLKwSjWvnwQItzttnCnR7Ot1bIphJjJX3gWX/1WHMGd3tJycZbM8gyhyqaX8VLjV92wxYRlXlYLml5xzSU98/0EzQvs28cURIj2/FCD+LhCu/E5lx+TprJNm5GcGa6xDHcbd5/x9bHmfDfIwTedwDiVljw2PE+ffCfFozGMr/FZQ8wvk15LrwixZMKhrFVTENpm4ihHE3X4Ts48wHywBM9FbmYKucQElNxhoy6aSjfp74Dc4VXitTZLDORVkFu0TwS1bdAXp6X4Nj6ZLPEDQzpz0umauQhKw9ki3vEQkkBxZzedeUXgutzhc7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+WwTJzUKd/hbRcd3hO2NaqQZjwV423VI+Eo1NFtWdo=;
 b=FJ74jzia0SM9PjeR0mHlo+GAymZRprvzIr6PKGAESmPKh6s67fzD91idORg1HvD0G73k+vjQW/IYaeO8Jbhnu98SRT8/DD3jHYm3K5i0bGjsYw+hmipSCofQlcSG62Ngsvtxc1sudOP3+07tFIwlLWSl/6zH+aYSQj01HSjpt881uZtsIRe3083EJ5yNfj8DYz8EmSa5SuwOj5iwXh4W5OSR+hI9BUz3kl51sjgkzFNxlQPeoi3JPHN+sagImlrBPZcslCj/vMoQyUP7rnh+Y1DonHvSKSMKXq1r/QB4Jkc/9ntlvCJn94Blfh9MjDz/wLdXsOXDd7IL/92oHArwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB7087.namprd11.prod.outlook.com (2603:10b6:806:2b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 15:53:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 15:53:05 +0000
Date: Tue, 1 Oct 2024 10:52:57 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH v2 4/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
Message-ID: <66fc1ad9ad68a_b5d94294b3@iweiny-mobl.notmuch>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001005234.61409-5-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:303:6a::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 026f1522-c9fd-4930-bf6c-08dce2312300
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i3UhRMzX8JRDK8emb9D9daVARsGlpNlmd0OlHds3hczhpdBja5UArsae0dDR?=
 =?us-ascii?Q?nPppQ3flBNmSx4ebLeqKdZRuH70iUzECyv5dUc2erJjxJ+ny2H4P7g+J2SZR?=
 =?us-ascii?Q?a4QdSZM1lQ60GKgWhjKUPY3HQm9zKZ92egr6BwFCdgzH5chLxfIB9P62oIg7?=
 =?us-ascii?Q?ur3t2huL6dl/n2wdn9FfH3k2ivEWisAT0M0+8F3n2t83xATLT9l8jl/lBOhD?=
 =?us-ascii?Q?jGAIlchhqmEe7DNysYOexyxYbVLiqZ6wl/YxXvybNRw++w4mZrLXVIvUieNl?=
 =?us-ascii?Q?bOJsNYYFTlS/5NyaJk+lZ+/vmrEOVTY3yIHgRoMVs1xpoEKZ8n/ICzGttyDI?=
 =?us-ascii?Q?Prdq+kZtTvwh10EDMsn1Pn0OEqSaO0OGan9jrXfpdFRUV4Mr+PygqNp/OG6y?=
 =?us-ascii?Q?zIPtkimjkhCSGdx6Ye0L6rg3VYjj/1sSQaop89vjWlHDPf39VTVM7aMvK1FK?=
 =?us-ascii?Q?p4PnCUau40gXk1h7SA9gSlu3uP8dIYvHxeFp6GUKp9ISVFkl57j5ojmf5+xi?=
 =?us-ascii?Q?TcSR7RCNTWe4uZw3IlRoCraxC6ozRN7zGwrNMyuewX75Qdnqyzkxduysyj6w?=
 =?us-ascii?Q?84jaO/SAq5lkbH03EOYFcROASVqiIr18k63/W9CiowU7ojvc9MZrWqTS4Qoo?=
 =?us-ascii?Q?zTDYq9nFw1WVBj1jJ/K/LlPX8l9nQZIotpJ0pyr3H+06Gf8O3+3g5mA0Cx68?=
 =?us-ascii?Q?j2Rm5Y+KR/RJrz2TvyNsevdKDoXcSsCgUSh31MHbF3EX/1ING+dmiuJrSaWE?=
 =?us-ascii?Q?BaqtXco7272GjFxWi3RZNtRAtoc53ZLX3jx4I33K7P4iFjGayAyXlgRkKRRG?=
 =?us-ascii?Q?W41xc2sn6xW8j5mOmo/XV8to9co4pMZxv9Ga9zBE/U5Zm8nS3otGDoE3Fc4W?=
 =?us-ascii?Q?D1gcvYaFeZrcvmkOVd2VQonyP6fhYSkHz9Gygze35Xrcw2maN4W+i1bfpfkL?=
 =?us-ascii?Q?j/Bl1rk6UcCCQTfaVQ1NI+qC8GA6ogJvkAFNlW5Bl/vqd6ODCEpet8pypvbR?=
 =?us-ascii?Q?NpmkbP4DWCQfGHY840Z8NOE/g4VuMEoMfygk1Q51UBDZypGVsWPB0gaBffBL?=
 =?us-ascii?Q?JNhYI9QiNwGhUhF7ediGpyw8ch65StF0d06gcarmnycgoEJJegmlS+vM0f3o?=
 =?us-ascii?Q?GPWrrN023ZEpx7Fv4x/YPntWHOIJDa19/HzfIWmWDjwIvlqmbwp4xCdOqR5K?=
 =?us-ascii?Q?qdyYLYJ40SSnPDSPcsV6q5rJJOtoY3f5rSFqDQnwz9XprDV/7mzGcKsPgPxp?=
 =?us-ascii?Q?XVBqQooFgC3dmaa4hy/mwJWu/vOORCL4LSPezTbJT967j2JYYlK+bkeSwHrs?=
 =?us-ascii?Q?qBuMXuOHeZZ5MATXsxcYmRp3bcZKn2XjiLj7IVAkU8kpZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kplVfohHgb1Xgeb1g6vWDuONharhSht95QlxZxK6FAhSHrw+Gmr0YL1uV2mb?=
 =?us-ascii?Q?AfU2gTdZM0xdLEgRiU6Wkhpq5ikvQXozQr91tjTPE0Det3fuECz41a0D0vl3?=
 =?us-ascii?Q?MXNkIxN+AVYxsiD0Df9rfrpKYIpDFFq7gExw1JHOgnwoUPlLmgCA84dOM4iU?=
 =?us-ascii?Q?Qeyk6UWnk6Etnl+HrWRRGxTDAIukOH9QjN4UZDSgPGvL8qJafrfhf1b6hWDd?=
 =?us-ascii?Q?ll4IAR7SdeHq2D1tiObeNv5uBXDwkIvo2EZ7bK2AxoeEFfvvSeBStVuiXUQh?=
 =?us-ascii?Q?bGpCjli+P1Ptk5DYHUMxMGO99xzGVkBYY2Q0nysYvHTSq9jAMM9jA8xwsOBX?=
 =?us-ascii?Q?rIFAHHCUHs8cFprlJVgdYV5xF0zG4/iNgs9/q4q/qbLyUb4vj4ljUIQzDbd4?=
 =?us-ascii?Q?Iz6RnNnTTM6W29x1ohZ8UW3B9ZsfrrxWRcoZfC1f7o6B4ORx0QvdvKuEfmOM?=
 =?us-ascii?Q?LLrtJUd8nUz1mvqnzutbc1Z1wo55rUk8ruGIw9Mqi9R1afekOQJqhem25+E1?=
 =?us-ascii?Q?3IO0p5vP4IvTUKiU9sB0B0ALPl/iMkNsZhlMDBmOdtPULtqKfC8P7krpdZmZ?=
 =?us-ascii?Q?kIRajUje4QoJeIa8FFEdkaiZyuJSZF0/7rl8gOky2gfX/LlVO9Zb8Uy+++5C?=
 =?us-ascii?Q?NLg4YTCQXrLkgeSff4969CbhocgPWcGCJ6EBzU8LWkKAYBR+s4PCSeLh26Rb?=
 =?us-ascii?Q?fqOdYpelhJrvIE9IwYvGcSksF4Uu4d2xgyq+qpN2WtlTsywthnP7kLsKCoJx?=
 =?us-ascii?Q?vsdM6fWCn8xC+sxdWObqCcRZZqFWk0ly3E15LW2c64bX+VmrTClOIuwxomXU?=
 =?us-ascii?Q?2bCz42Nm2ViwyDVOLvkSOGCHisrVIV7EJwIPFhG+vXpiLlNKcCFYUW4BBjJi?=
 =?us-ascii?Q?JANWdXNclK5Jd9cDhzFGLgCvYZTxEawbaLQTKJHIww9GYcup5pdOKzApdwg0?=
 =?us-ascii?Q?MoxvivCv9A8ge7W/HJ37NkOgNvTnM4qndYUtJjrf5N+yVexYsh9UURB4c7MG?=
 =?us-ascii?Q?7i/s7iARdlgH1ig2obFTRjeTJoWaCbF2EKrIs+taaGV2RM+TkBAW5NoKfStN?=
 =?us-ascii?Q?7Xa8WgaqeFztEn5hvJSmuVLxebCTvdhwyBnb1u75P8o//f1AXTrVmk2nxW3w?=
 =?us-ascii?Q?vZs12+pyBDeJg+87XIdzk5Qrb1T6iYeBF3TgWQv7Okdx24OiMiYI77cW4gGf?=
 =?us-ascii?Q?G+dR/Ct9hvtrNjyNWkSWP5PwJYJKfTUuH4QDkr8GtjGXSCCQ7nEWZTWZF2/d?=
 =?us-ascii?Q?HuVaQPwU18l8qVVaywT8wlpkkqwzX/vVsiE1Ew5K7/2fR1IF2OOy09UMm3Cb?=
 =?us-ascii?Q?JXhxgqgYbI4QiL7tGrw2plp8RbZYj5u2peairnutaFqIvSg5fCNvrwnkB2YK?=
 =?us-ascii?Q?UNSXoyM7oATcgtKFsT2TKDGNMW9rdIwu5RMLbFT19OSaYgwAoDmT4QNYkwO1?=
 =?us-ascii?Q?2FVErER76fjbW/kMBpkOSWGt6zTe3yh4/5zXrpzL62Q+KLYkK5PTap/94kl2?=
 =?us-ascii?Q?Fos4kFaRYOcwlfDhx8uPQXEPDY+kv3uuNdAkcmnv/Q+GBZ85KCh5AfXV/maR?=
 =?us-ascii?Q?JrSnQvUU4w6/Eks89nlJoxbKmaJ4lY/OL+oe6sRw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 026f1522-c9fd-4930-bf6c-08dce2312300
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 15:53:05.0854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsnaE/UqV+cvFEymdQmzY2G3I8H1453z1cqGBOZEgakh6K9dU2mJ+DFsXjmvVnEpQLGnmrpqFMXFJbzulHpA1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7087
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records.
> 
> Reuse the existing work queue cxl_cper_work registered with GHES to notify
> the CXL subsystem on a Protocol error.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
> them to trace FW-First Protocol Errors.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	Removed pr_warn for serial number.
> 	p_err -> rec/p_rec.
> ---
>  drivers/acpi/apei/ghes.c | 14 ++++++++++++++
>  drivers/cxl/core/pci.c   | 24 ++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h     |  3 +++
>  drivers/cxl/pci.c        | 20 ++++++++++++++++++--
>  include/cxl/event.h      |  1 +
>  5 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 9dcf0f78458f..5082885e1f2c 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -723,6 +723,20 @@ static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
>  
>  	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_rec))
>  		return;
> +
> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> +
> +	if (!cxl_cper_work)
> +		return;
> +
> +	wd.event_type = CXL_CPER_EVENT_PROT_ERR;
> +
> +	if (!kfifo_put(&cxl_cper_fifo, wd)) {
> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_cper_work);
>  }
>  
>  int cxl_cper_register_work(struct work_struct *work)
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5b46bc46aaa9..39ef24c8991f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -650,6 +650,30 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>  
> +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
> +			struct cxl_cper_prot_err *rec)
> +{
> +	u32 status, fe;
> +
> +	if (rec->severity == CXL_AER_CORRECTABLE) {
> +		status = rec->cxl_ras.cor_status & ~rec->cxl_ras.cor_mask;
> +
> +		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +	} else {
> +		status = rec->cxl_ras.uncor_status & ~rec->cxl_ras.uncor_mask;
> +
> +		if (hweight32(status) > 1)
> +			fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> +					   rec->cxl_ras.cap_control));
> +		else
> +			fe = status;
> +
> +		trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
> +						  rec->cxl_ras.header_log);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_trace_prot_err, CXL);
> +
>  static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  				 void __iomem *ras_base)
>  {
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4da07727ab9c..8acd8f2c39c9 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -129,4 +129,7 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +struct cxl_cper_prot_err;
> +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
> +			struct cxl_cper_prot_err *rec);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 915102f5113f..0a29321921a0 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1064,12 +1064,28 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>  			       &uuid_null, &rec->event);
>  }
>  
> +static void cxl_handle_prot_err(struct cxl_cper_prot_err *rec)
> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = get_cxl_devstate(rec->segment, rec->bus,
> +				 rec->device, rec->function);

As mentioned in 2/4 I don't think this is going to work correctly.

> +	if (!cxlds)
> +		return;
> +
> +	cxl_trace_prot_err(cxlds, rec);
> +}
> +
>  static void cxl_cper_work_fn(struct work_struct *work)
>  {
>  	struct cxl_cper_work_data wd;
>  
> -	while (cxl_cper_kfifo_get(&wd))
> -		cxl_handle_cper_event(wd.event_type, &wd.rec);
> +	while (cxl_cper_kfifo_get(&wd)) {
> +		if (wd.event_type == CXL_CPER_EVENT_PROT_ERR)
> +			cxl_handle_prot_err(&wd.p_rec);
> +		else
> +			cxl_handle_cper_event(wd.event_type, &wd.rec);

Why does this need to change?

Have cxl_handle_cper_event() decode the BDF as it does now and call
cxl_handle_prot_err() there?  I think you could drop patch 2/4 entirely
and not have to duplicate the logic.

Ira

> +	}
>  }
>  static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
>  
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 5b316150556a..d854d8c435db 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -115,6 +115,7 @@ struct cxl_event_record_raw {
>  } __packed;
>  
>  enum cxl_event_type {
> +	CXL_CPER_EVENT_PROT_ERR,
>  	CXL_CPER_EVENT_GENERIC,
>  	CXL_CPER_EVENT_GEN_MEDIA,
>  	CXL_CPER_EVENT_DRAM,
> -- 
> 2.17.1
> 



