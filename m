Return-Path: <linux-efi+bounces-682-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C7E86EB8F
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 23:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5559D1C21352
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 22:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A0359146;
	Fri,  1 Mar 2024 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6Gm0IKL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F85822D;
	Fri,  1 Mar 2024 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330409; cv=fail; b=TSiAT/2aOikZpGV0qusn42fdjhiLiYGAS/Ho1YeYthA9/oCFumJxPBIrGalG6FY/yDXOSN73LjXoEGadVFd/eHrPHmb82H0oXDWgykEJzI7/0DRdPXV3R2HSVXohZW64PJVNOjsU79o093tDGxFjva9tvwDVZZx/AnPf5jFZKKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330409; c=relaxed/simple;
	bh=RNwaHv/oDWieemv3wB6CLuLUCjbg9UyFklN1GqgnIwo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cThN3eLwP9+Fes2YfhBGXM2UBobCkFh9cqkdwpkwcJJxR+om2v561VgRshpphnS3MyR7Tr6H+2aC0UB/Z16ARNq6A5u/zVwuegwWswiI+DFzMUzMUX3k5P244wwDS40b5kLx39UCzAPbsCy4ir+vloT67u7/GPAbvwHis73Mc9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6Gm0IKL; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709330407; x=1740866407;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RNwaHv/oDWieemv3wB6CLuLUCjbg9UyFklN1GqgnIwo=;
  b=Q6Gm0IKL2y2q7I+2ed0mWgTer8fH2Qb4yP+T6UyQJE28bcvp7NxHCupH
   pM9fXVYiuyGtDFCu4mi01PPiOo2ujU9d65yWdpo+FKBtqi8iD8efA2uDT
   LLQ6x4uCN9yicSj3EaSBk792EZAYKi4bRUj/fwvYcvx/gXtkbsIDseJOR
   cR1Ol0EirWDMqXyDLdVsghBCw4Zo5+s4MqSmZ2hzFAQ+xyjHgoS/0vthW
   bO0wyJF1gJGixBdBTPGWVbP91l5Z928pXNFTbV6dPlGQyLhz/373bDp6I
   RV6BWfaPENmDgOhYkUlFag1EjpW2ZFxmI1ZIK53RdG/tv5CRAOIgoKNRk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3813576"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="3813576"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 14:00:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8225744"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 14:00:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 14:00:01 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 14:00:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 14:00:01 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 14:00:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCQuD1gptPriB4nUaBx+x0lKwFaWZjpvkVoVoTO3xR4M+8mf2+HQwfvdRuFH9T0MWhmSE0Xm5Z5rVrjuz4WmXwYlmh2ThGr6DRsuOsZp+Acs0VUhYlL5f47XnIQqmTLKIwBYp5rIcXkGkh1fPyyKkgk685Xj7oIcUem0Z8PapgobR8Bl4ExDoNCggJNRFpjq93Pez2YadD7AwyRmF8quXxCMBArkvBRfgofa962Ku1lE4vNJcIBgIhr/yEz0qodDLWnou4PjTRBP8WmBHxHI4ZbNul2oN0h9+Ny/OJuii9C+gDJ9byVW4c+eiGfxNirGSMVfBZ85sv4/yrwL5e/KFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3lTN+GMrbidOlXd5lNHMn3IS2ZMgLFEndtxXlgPYkU=;
 b=WXw76QEVgPn1zAjfy1Cj0FwMEwOlGX3/i2HLsJKwOUuebzgnBIdNXh4mtJMx54q+m0cIdzV5bH4EOy5uyByUT5Qc6dc1zxYJ9fSvQhEKkxal3HzmraoSurFqJSwmA0EBEVXM6lZmmmg3CzskGqwEHvtBw2GJ1BBnxfFAGA79CTFnnnkqvCzxcyd6rUBEtZrN4zQ9amW+ZvdcpXsp+0bsCRaZkO3r1qH9VvNusr1LDkdrU7sqkbIZqt3TqQU8eTadDgAIL2ksua9Y8lovkScis2WV+EA0LaCaf5A7Dnm8S909PP5NtgTtXJ5pMmTV7p+9/8YFfytN3bO3b8eI4N3+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4614.namprd11.prod.outlook.com (2603:10b6:208:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.16; Fri, 1 Mar
 2024 21:59:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Fri, 1 Mar 2024
 21:59:58 +0000
Date: Fri, 1 Mar 2024 13:59:54 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>
Subject: Re: [PATCH 4/4] ras/events: Trace CXL CPER events even without the
 CXL stack loaded
Message-ID: <65e24fda80e44_3651e29440@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
 <20240228-cxl-cper3-v1-4-6aa3f1343c6c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240228-cxl-cper3-v1-4-6aa3f1343c6c@intel.com>
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4614:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f18680-674f-4b49-a0ad-08dc3a3aefa2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZLmWlXZ0sPURMGrh6hGFyqRuPX+2w6/q7gWB4amF0l0ZFk0nVHY04j6tYQ9KStqvrsmsYEIrtm98yByPE1qGMZ02cwZC3PmbMkJzYcrtLaaM0tMh7Xs8hyQ2fAoDq8YVjpBrEgWUfJP+J8FN/EXOK6gbTlyTyUeDPjMETkTEIJa5elTNR7Bw+48l9x6VPhqKXe0o6SjwaCy/n27FHuXDFX99yRit7fBsr4C7f4ZGz9CidO1xxC3N7bTcwc8N5AvqKhgoLMKVDXELtiN45ovh94zdRMhs408/+XUlFEIzq4eFWQEtPiP9OeE4i5MYPf2i5FKdj35qGOqYf3bcZMYIHV6wCWj0PyAmsL0iiYFkX83EpgmGndo4X08dGYQyHTxny7H+vA3wFS7c7kWjom5Uyn7EYo9XFHAqt98dGyfte8BDL5oavEsYa8Re3HkNV3+Vk1+A5BzXtQ9ryZx6CUCWQeHcwGRuzKJ0m9rtT81KdIn9eehGfHkrY0MdxePA6A/dNVLVurtP0wKyz+6YD85F2V6N9BOJWMGknB4RQypcIFGh49khRD7u+9EgeT6vKucRreC6e3P/h97hF0kAWrzvZlh3/HSRuIs/hruYWZQZbe4V4FlGJ4gx8+9396cMA9V8uImlql+WTS5XhdDLfSRuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sfI6ffGbF37/AnixK7cHVsjWBXx2Q+rO84InzLOynUIjXY3dMzJIABcplAPz?=
 =?us-ascii?Q?afnSrwq4OEdwPK+RdU8wc0ttlcmJdqp0ACKDzes224qAoOZbvHtongsSHR+1?=
 =?us-ascii?Q?8CDM3bjnlwh5L5e0EON2wE0lXeDn+hBlFr0dNyfV8GlS+NLjbRv70CFteXmP?=
 =?us-ascii?Q?s1fxEDCPYagNEGszrFnSy6dtKblN7t666S2qf51qWlej7XmB9dmand/axeuD?=
 =?us-ascii?Q?2eBbLy8QzvH03PIXuGQE5yHxCHmTvsnSjiX7zCI3r+zlSrd8e3+GqCrn9OmW?=
 =?us-ascii?Q?niOirxIPHabWzxsqQRiQDaRI6XJd4sgZZ47osedlXvrQQKhj0doFSzHg/oG+?=
 =?us-ascii?Q?KUYNH+oGv7yX/D/nri22OzLqD1lXZADh+Rl2yK6JSFavfqhPG+FQxGN6+nfG?=
 =?us-ascii?Q?p51SpB5dANpdGHBbsXmPvo4t44no7R4MRYpxxD4jTsfI9/6OTU63F743ykYW?=
 =?us-ascii?Q?srTNk9jirQwWN2MGKud3/yzg6bGCST3TZeZtEBZs1n1+H8eAbDVowRdeoAbf?=
 =?us-ascii?Q?Rm0pOi0RcHM9T7gu93lc9ahtQhzH2kjmcN6HOK6CN/JQYOsTJE3ny4JSibHy?=
 =?us-ascii?Q?4KBdqQ2MEklpVHaiODvUT69fT054Fx7Xqm8/PJEPuC+wSBubHYQseMBHwAIl?=
 =?us-ascii?Q?scjdmHN38sBIZ3yZ9h015uWZLaYX7dWWRPjWzdVzcdsxWEB/ySLV5U9KWD4U?=
 =?us-ascii?Q?w4KPG+huxpr/n9YFiy1oqHwmPsKqf+WbT/ZIEbnUEpxjZiP2Qh9p68I5DQ9R?=
 =?us-ascii?Q?t/P1N0gmNe6hWYdnaEoDlt92uZNRA3Lf4JLfocc5+qdVHlGdzGP3QqpkTfMO?=
 =?us-ascii?Q?dRqShLrDipQDvvUSUXutdGNTVCWmaITxWOmVfdHx7zcCWDTFBbZPg7e2/L8l?=
 =?us-ascii?Q?YZBk93yy2TsBakISd6XqqMzfC2NkOSvJjo2yQ1dhd7EBLF5V3YocNNLl3ymB?=
 =?us-ascii?Q?20GYzZvtaxeQqaEmt0uy55p7k/iko2ayM4xOErU7GH/Sp2AnCT4aYQLg/Dth?=
 =?us-ascii?Q?MxCLN0Qof60amztUvpoWrVuRz+N41U5VSC2ZR1cCz3KnPFuETcEkLe7/qz1K?=
 =?us-ascii?Q?Tg7NZECaT3VenDnyIo2s4+Lqfe+OLQtcncC8EBoirzSZ6FjJYKLSWAhZRhkO?=
 =?us-ascii?Q?91MV8ebgMAqhO0hA+6i28km8nbfVOgdNpnpocCiLaYAOKTKmnpdYM+yjwfLO?=
 =?us-ascii?Q?/RBaXU8RypB4neEznS/M6mvaOxHtIQayvfocOzE4h2pFwepm8wVK6YE8cfBW?=
 =?us-ascii?Q?HkjzEkcRYqRmUQAgjhNRs5nlUrA4irjtCfjF3n/3hN9HmVdNJoeB5a7nw8SI?=
 =?us-ascii?Q?fO3REbFZGKLKUPm0C7406p0WQGYh8ce4cAJi3yCAiCyxec7jW639B0zPY+Df?=
 =?us-ascii?Q?M5nE0q102PL75YuRWm6TpsRYmiCMctyrBsaObLBIEf1ptm9d+IuCsbh9dqdM?=
 =?us-ascii?Q?xiqb7RE4ett47ZlnU+vGvyjX7u5LB53l7TgE3sZrY5lTeVJtTdx3Y6q3Ql4a?=
 =?us-ascii?Q?QGNFSqUNAoVsJpQJ3MvjMYGiVt81p9hVv4LUS8vbjWgfNv03qYz2t1ZQrTUB?=
 =?us-ascii?Q?JLRFzcCt8QLj5Ma2TqguCTFGibr1bZfDdLtN5UiW4BmpwKVTKcbJw0LCVB09?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f18680-674f-4b49-a0ad-08dc3a3aefa2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 21:59:58.4478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mmmz+SSKcRDJO1wxqWvDUj/+SKsGkSiu0cAJdY08i7LsI/fbGU+kbRW//gGWpe2r6UJCfkuVkbpwf8xzJyRL9IuIQKaaFVq/EjLKDL1QyVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4614
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> If CXL is solely managed by firmware (including HDM configuration and
> event processing via firmware first) it is possible to run the system
> without the CXL software loaded.  In this case no CXL callback will be
> loaded and CXL CPER errors will not be processed at all.
> 
> In this case memory device and region (HPA) information is missing but
> omitting the error completely is not friendly for such a user.  Some
> device information is available in the generic event which could prove
> useful to a user.
> 
> Utilize the local work item to trace a generic CXL CPER event.
> 
> Duplicate the pattern of decoding the CXL event header to aid in adding
> future trace points if needed.  This was an easy lift from the CXL trace
> points.  But stop at header decoding only because this is an unlikely
> configuration for the system.  Further decoding can be obtained with
> user space tools or added later if needed.
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/acpi/apei/ghes.c |  5 ++-
>  include/ras/ras_event.h  | 90 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index f433f4eae888..9ac323cbf195 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -729,7 +729,10 @@ static void cxl_cper_local_fn(struct work_struct *work)
>  
>  	while (kfifo_out_spinlocked(&cxl_cper_fifo, &wd, 1,
>  			&cxl_cper_read_lock)) {
> -		/* drop msg */
> +		struct cxl_cper_event_rec *rec = &wd.rec;
> +		union cxl_event *evt = &rec->event;
> +
> +		trace_cper_cxl_gen_event(rec, &evt->generic);

So it was confusing to read the empty stub function 2 patches back when this
change was coming, and basic reporting of CXL event does not need the
workqueue indirection. Note that EDAC triggers trace events directly in
the atomic notifier chain, so CXL could do the same.

>  static DECLARE_WORK(cxl_local_work, cxl_cper_local_fn);
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index cbd3ddd7c33d..319faf552b65 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h

This is more heavywieght than I was expecting and defeats the purpose of
centralizing advanced decode in the CXL driver itself.

I would expect this to be just the tracing equivalent of the
ignore_section logic in cper_estatus_print_section().

