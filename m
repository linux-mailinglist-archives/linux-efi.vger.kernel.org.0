Return-Path: <linux-efi+bounces-298-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 114A582228B
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 21:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4ABDB22387
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8381316413;
	Tue,  2 Jan 2024 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qk5DWZsk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8416408;
	Tue,  2 Jan 2024 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704227263; x=1735763263;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HsQ8M1rqiT1Uu2mo9zZ9hkQXqeQI5tmMukHRZqt73jA=;
  b=Qk5DWZsknu29+Dn5/EaSA6LxuZI55VJ/8PHMhE0yji60O3Hx9hQPlp0V
   svZ+NINl1xN68e7evt2WyRsiIe0L2k7e4tpHpyo0D9KO0oW/JWPFsJn0g
   c5MabaPtHn6DTy67uK5bD3yLUKGYGrVwuzk0y9jdBKEIgNy1irpumVbCe
   AJ8lWbNsIf7KRiDkEDxQ+86KOORlPbP9tkqKodNM5+NJ6pF9pX3mhyiMV
   zSfp7bs6Tqls20H5tKwQrLsL1z6hC/qqxqucOSkGB9zKG1psnRzpBlOzS
   5P3GFrFUhIJssGkuSziE5Plu0PYkcPQsKmqyE5uPukWtQuA8lrBC21eQ2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="18459097"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="18459097"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 12:27:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="772942478"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="772942478"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 12:27:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 12:27:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 12:27:41 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 12:27:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7zFT2YKeKsagWCKwQk6cSBY0U1ALYiT7esJ53T5F8XhAFMhVfajPQlvXoHe1G0m6NePvqQjsp56XSYBwY2LON1SXL/hXjofJuZ6n2oXjCHmHgPUjdWfnuJ86toKM8KeTWrKdZSJ1S+f8f9bSMOtG67dc/d8MM9fnp3ApLlTzzI5Y1o8YSvDqDD1IS2RuQS0t8QAnKZOWyOx9FdL+Sl4u/TUBrR9w7km83nry2TTyxQgE7uN2/ER6ntaxk5LsvZPpTFNkmXfg4TqyNaP35fawe4nQ9JWQQ5bI9eLpK0RtMdwCJ8AayQqIaYMh7dvwRYXg/ufhwAS2t4OBLU9BrHR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXNUoiGdOZ1bCoidXuUH8HXTuJRxHaL5svU9U9ZHwFo=;
 b=ft4gepglq9MQRh4pePR6Klp/8ViNowigwqQ4j8yLg9jSF0ILpOw09jNalTN61EFED78T5AURCnhqtpdvwyyPIQzL1Q9KUW6yq+jtucdWmhfZbUKgwTG/zv/UvRUPAKtzMl6iNy+EKjUyb/Sm40wmnF1fixwWjLlatct5R8iAO/F6RoEXfhoIunlpRR2UXDTMMK5I4JELhyt8lMmQGY+1WJ/81wdDXK0eZvzHlxtvPM9JUjymfKGXW3yuanlNSXSelDYp4YTQTZXiPGFxkgd0RuvmOZNNVJjs0iAo4czJGSspGjw+AGb62JCSGxdNyICmm6J9+PXg8kAVVLdg3Uqezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB7045.namprd11.prod.outlook.com (2603:10b6:510:217::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 20:27:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 20:27:38 +0000
Date: Tue, 2 Jan 2024 12:27:34 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH 4/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
Message-ID: <659471b5f33bc_151dc129479@iweiny-mobl.notmuch>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240102150933.161009-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240102150933.161009-5-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BY3PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 682c5435-a3fc-489e-f1b2-08dc0bd1435a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YskD3HucSFdc/Ykstbg3pimyW5Yjj8GI9xgBzV+mZ0D2+35qrwnqp8cg1ZinSzJxTiopUMckLCrbDl2LK6DP18A8yeR2TcL4phgO9s6lMNmvk5NTPityjazCYC04TDgs1qhuGHHcz5hpNV1nfoQxypJumpkJ7Cpa8+g4cTmakQ65oETloHkNw7FmarXwa6vRsKnGeTdxAAG4ujU2tacxNPeW76TyN253xdYto/wvCwXqmeZgh8BwgfJudEqmbaDuRRpHhchr+WruJ0jT5PlbaHrzkMfHrDf8kZJn1efwvjmhTuOiHkXM9QZuI3IYT4rbAmG2VwIH+sxrlRKnaVWCR+eDwPBnqra8Y6eAJwMQXgTH1jElYnddhU0fjfoNHunzPNdTMg6JAJjhTG62uqAc12gln+LgQB/R/kRiINIbswfwE5AvdTWVurf/5gUQwEMvCVml8127rAKA3nTrXQfdN0qg649xBJ805JxHqBvvTSsPv41L4xzugN+lmJZilxkcT6/x7BGmI6zmXRZ7GV+uHd9l13R5GoK1Cjg+kRFxYTGdvbXkHflX9adwBqOPejpfj87VXIZPbHyIseD59Z00tO0CUb2WAoIaDgMHKAeFfi00UpUIXrhGUqZWYPGQDyDQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230173577357003)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(26005)(83380400001)(9686003)(86362001)(38100700002)(6512007)(6666004)(82960400001)(54906003)(44832011)(5660300002)(4326008)(6506007)(8936002)(8676002)(66476007)(41300700001)(66556008)(66946007)(316002)(478600001)(2906002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4mK4Hk3wwXf7o/qbwZFXPCidTbP0mcg4SySEJp4R1yXBxpM5k94gJBqqrpkF?=
 =?us-ascii?Q?Quz7fg2aMvV61sz74TSCG+zBKLEyFT82n6WjymoPcfa7Jd9qadqkxlgIC1sf?=
 =?us-ascii?Q?UHt2MnZ3VjWm4YVOyBDG9IE38HWFJ8pvTDDjjsHea0tqlmoXY1YISWqLlvkJ?=
 =?us-ascii?Q?t0ojX1vUPdtUPJHMPCzElfAJteQgYwf+jskP9SEnwjDnPnSeU8sJJYYWBfqB?=
 =?us-ascii?Q?YjwReBPLpzNVxRxaA4ULAy08krL/ybRRCFWJcKqUWjMpdBrN6mS2l4MyyFsq?=
 =?us-ascii?Q?vuXKY6k4lvoFHQY4O7pGlAJ6zW34H2zopiN2SUdscOxGZAPrhZGFemNmUWvS?=
 =?us-ascii?Q?dPkLNviMEULZiK1pr2d8pUopF5GSPPghW/vh1ozjbzQghDd6+X0NKv1WDHwQ?=
 =?us-ascii?Q?CZSKvm99PV7D94mw9kM+Qrdzx/EgRQjHIpHCdkpHChRUpGgGZTsxifmDPYJ4?=
 =?us-ascii?Q?5+Au4wXxJ8CRt3WaXBxkYOqe4WfPT2IvmzCTtvLix6WUE3adBGMTZtHWj4x/?=
 =?us-ascii?Q?mYrDi2aGZ/OnQTiy/AjhuS/pohw/SnNTqU9GsAS0dX16IYul0Sk5JdRa2tNA?=
 =?us-ascii?Q?Zn3kNskJ2m6RFIM2Nh2OYIFQmGafHLDacehjB+RSSVs/Jx1SZtPkLUHuQ0bd?=
 =?us-ascii?Q?OqMjhiqZxuDn0n3sZ6VFJG3JOeUQovEs6yDrCoOGEYZcStEtwcWZqBUKyZ4i?=
 =?us-ascii?Q?W6O30vf35gRp+0qMbpGuWCXAyC2yPhOEDh8DMDq5+xc1IePcnnj//vogGbzh?=
 =?us-ascii?Q?TpHSMDonHY+Zm5qfesaqaZMnzmUY3cfNuogbqp6AdQugfUGiz/GAOXPhuJbR?=
 =?us-ascii?Q?ThPGPC64kBztXYc4wrv4MCEE9F+JmImYmv1ZK+zdFOTyeV7e68v8+Dny+cHA?=
 =?us-ascii?Q?ZUYZ+19KfrmuW9H5BbURlp7erN3mIEb5mEpkEGTZjDAauNvBT6DrKx3pPDax?=
 =?us-ascii?Q?Gn5XO3rhdUPUmH3vGIK34AQvqHqJymX4/sAUosd232ub64Qx7HmXQkgaEDUP?=
 =?us-ascii?Q?zJWa6TXubgX2Xzbinac9EOaDpssuKeUwqZs0lVZNyRXkWd3hw6wFqGymZTSA?=
 =?us-ascii?Q?ZY+xzTIiuzRjYd0G/GFoQAfZsgXaTCLSgc8N3tBwDfVqVpKtPhcYUfKNUhY0?=
 =?us-ascii?Q?ynxRwgelH3Xhi1TXbu6yPCErmvi2DrC4TvP8jW2IAlPu+j0CW+jJvDDH/RzF?=
 =?us-ascii?Q?2U0WZ1bbHBeMsYHUiH409O9R76x4EjdIIPIf3iCfouHZMmn7D08kKe9ZsVbW?=
 =?us-ascii?Q?nyVYrzh4gWCKLGkFqe+6WPO9fC7YNqIlqopNIcNa/fQnhIw2O9SzV0iyYCLD?=
 =?us-ascii?Q?sFDSRl9IZKT2Pui/jLOYXNAKpDDwXiyiGH9THQiJZ6YxSvhfqtKCiSUnbLIn?=
 =?us-ascii?Q?U71HWF8cwDE7GC4pBsIyTC8tT8YPyzvLvXPhyjqokzCbK7s1hXcipK4eb4JO?=
 =?us-ascii?Q?xf+NFQ+e1gtS3rzV7KURnEYsX8648+sY6Ch53EJnADexyWiCwEMHi4znJYCR?=
 =?us-ascii?Q?iss2IIy/Soa//is+XM7ZymqPk+cvEdoYF6Z5LWikbQW6ccAdCNVJZP1HQ9sb?=
 =?us-ascii?Q?XzxFRwqB2XwkJYCeD+sAxEZsV38HWE3hGC9NFj/S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 682c5435-a3fc-489e-f1b2-08dc0bd1435a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 20:27:38.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1j73D65pxtMlW8R5yLAecvzrus3+YsyKi8xvSLBH/CeK/8rZIhbCyZpzZw6FSEB8xwMsLzE3e9vEDQRud7I2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7045
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records. These CPER records obtained from GHES module, will rely on
> a registered callback to be notified to the CXL subsystem in order to be
> processed.
> 
> Call the existing cxl_cper_callback to notify the CXL subsystem on a
> Protocol error.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
> them to trace FW-First Protocol Errors.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

[snip]

>  int cxl_cper_register_callback(cxl_cper_callback callback)
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 37e1652afbc7..da516982a625 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -6,6 +6,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/cper.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -836,6 +837,51 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
>  
> +#define CXL_AER_UNCORRECTABLE	0
> +#define CXL_AER_CORRECTABLE	1

Better defined as an enum?

> +
> +int cper_severity_cxl_aer(int cper_severity)

My gut says that it would be better to hide this conversion in the
GHES/CPER code and send a more generic defined CXL_AER_* severity through.

> +{
> +	switch (cper_severity) {
> +	case CPER_SEV_RECOVERABLE:
> +	case CPER_SEV_FATAL:
> +		return CXL_AER_UNCORRECTABLE;
> +	default:
> +		return CXL_AER_CORRECTABLE;
> +	}
> +}
> +
> +void cxl_prot_err_trace_record(struct cxl_dev_state *cxlds,
> +			       struct cxl_cper_rec_data *data)
> +{
> +	struct cper_cxl_event_sn *dev_serial_num =  &data->rec.hdr.dev_serial_num;
> +	u32 status, fe;
> +	int severity;
> +
> +	severity = cper_severity_cxl_aer(data->severity);
> +
> +	cxlds->serial = (((u64)dev_serial_num->upper_dw << 32) |
> +			dev_serial_num->lower_dw);

This permanently overwrites the serial number read from PCI...

If the serial number does not match up or was not valid (per the check in
the previous patch) lets add a warning.

AFAICT they should match.

Ira

[snip]

