Return-Path: <linux-efi+bounces-297-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA2B8220AE
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 18:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDCF2815F8
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856EE156CB;
	Tue,  2 Jan 2024 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0QxgC/A"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B495156C3;
	Tue,  2 Jan 2024 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704218322; x=1735754322;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eJZ8ciZe8a24mg+BprQO+Th8Pwq29KYGtqy/APL40SM=;
  b=V0QxgC/AM9SlgwRpmQByUMantRycasXSXER7wqFn091hq8La5rqv6NHF
   6dqPsmbPEwqB68Xlmv1DUQnNP9RdeG5w7/1CE6QlctJ0xWFmhDF/oyQoc
   od/bMTrrSJ5BHJomu1WixKqM9xFX0lf2mkX20LPaOuz99p/iypsn1jziD
   3IHBxxte33ZwT2r5OmdQugfrkhmbsQ14bqUU81uBqX/362H2Bpc6zWVzl
   l66W/YNf9XVSlNWUB1alUQUYFeIp820h4jnGsuV/reduy9B9Bt2+dqJrg
   Y3Vww7YQZqQMgevOvQjpg16bSc6dXKq5nrO7u7vO9JDOI9eXVjmYKB1nk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4245345"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="4245345"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 09:58:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="14249305"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 09:58:34 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 09:58:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 09:58:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 09:58:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 09:58:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMBMhSCl90jQooG/nU6J9lxpA67odR5KzvDzf7e7Heu3l4WkSZP/ZWuVdvTT2rh2PP3DOhbAQ56h4yJSfSqDfIEtFnWgwvux3Sq1aT5tZK/Z+e14F+wKzsNEHEh/vFhDvNOAo2IQ/i1C7pfnXLbfFWuYTvG/qlnz8z7OcxVeSj8sBZe0Zcm9dFCOCakNxDKrmWt0KIrRXDIFUS4nTvcu/lTFDq4CqTyTD3jSfuPHzrLvW42hRaK8OHTQecWmeSjw1RWVUBSJUIyH2kUZhetLsTF5YX3VtSxTIwbL1JAbkyDwcOF18KlCqI6u9GrhxicX1Bj9x7/1itVPkSU8GFiR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpHP6Q3puExpimicJPOutL1Owi9RjOqL9vSisokRvF0=;
 b=GzdvDFsc0Kz0djPnjzCyd+B+ISJV75iqcnM3ChDj70mTeekx/8Z+rTHVe8HpcMPrjPuYtuMgk6TDiHoKA1Ho63sqjhfU5ea5rPXd8SY4STslJ41akCmM6wfEAPCGCMYd0rtgAyHVW7MGzfuvps7XGEZ+H6Ycj8IicfEp0IHPkQiBV+PDtlTMGeYY2o9JcYz5mataYXrN4V8X/bvHh27HpfEb8fd2LlXuIl3LzO4Qyq6yyqPywHS2d7aHljqZ8SD1RWTTWmTl3fO9h7c07CO8n2ZUZOpkAWBzUOHcegnM2+kru8brPvo7n3htUoq/0U6TjG4MR0E6e/+mqZaB+Hsw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB5138.namprd11.prod.outlook.com (2603:10b6:303:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 17:58:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 17:58:31 +0000
Date: Tue, 2 Jan 2024 09:58:25 -0800
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
Subject: Re: [PATCH 3/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
Message-ID: <65944ec1dccee_151dc1294f3@iweiny-mobl.notmuch>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240102150933.161009-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240102150933.161009-4-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BYAPR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:a03:100::46) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 961efab8-26e5-48ff-6fa1-08dc0bbc6df6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCAgsPBqR1oO2U0Eb9PTzyFfVpIUdqAQEHy7MzcbGM9/tK6pRcjjzUfIl9pEXPc7/uMmBRw7YhbILFQMpF9BaHPXAzV5knS99Qg8wWNmzqbGkQEVEqV/GnyErP7rwNozatFYJ+GlvNxqSPwTzf4rF8eI2tkuWQWZg2X+6nx5CS/4tcfnIvogPOdyAgNOnKTnhjPKITPij0iU0cJtfyYhyPIiyRRJtGhUrj8Bac+2IXMiOi6SAO04NexqQCbXbQTZie+5qfGyLNTltr9ZJ4291m0soZfauvzcaGFY0mXZU1DXrkqArftSvPNkCt/+L35L31UD25qANXIA6l4yD68ysCwC/4G2znaVoPHFLQfBrjXQIX8pLDeRMD+tRvRuKTAZXolMTm6tq2RO3oIn7nIflIXE7Hpj9pCdnVPm14y713WggvtHDFs44dwNkgGEAw3Dud7JQTAKhR0wjgj18LCLQivNtnbET/gtpgAhSZiQ9zdsB45/4/6YJbSsH5v3kmsK/X0vQK+Vnvv+pwEv7su8B9CBDx4d1+ZKNCqM1QtVgP8Xk9MH1jfR2pWkZsrW1BIA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(82960400001)(38100700002)(83380400001)(66946007)(66556008)(66476007)(316002)(54906003)(6486002)(478600001)(86362001)(2906002)(44832011)(8936002)(8676002)(5660300002)(4326008)(6506007)(6666004)(9686003)(41300700001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ijCPuBOSJFGueYv3UlgK4vGHWppR2Z3F3QBSWsA0eLuaSPgg+IkKb+XyL1aZ?=
 =?us-ascii?Q?eKLKuR7Z93mGrCuB/L4QHQcCJvgL3XWRJaVW6GkG8YRQtPAUqpVRHylyw8PK?=
 =?us-ascii?Q?cbG9TGlJ9KAQnAn0JABaKk8sZOZ2tDX4DKGX7+EMlr44g8dAs/N3txkeK5IU?=
 =?us-ascii?Q?rldFe8Bt1Fz4ocHF77soy+3mdVGqfPI0oSE4CmEzOunLwGTG1dgoRVWPj+/L?=
 =?us-ascii?Q?0nR/Jm+fALfsPToDwHFI0JXgMxGaZyXl7aRArpPO+9Q+WMwBFJyU73v8xQ7T?=
 =?us-ascii?Q?NvX2DNVwzLk2fzixUY5H4lr6vJJPfJ1DbNRapM4ABFstc1gOq+zkEPIktclI?=
 =?us-ascii?Q?0wyQMjbl/En50yNGSo6zmETNC+lbQXsV7eKx9QK2ycTDWQX2GSVsNlkSqlue?=
 =?us-ascii?Q?dhuhg3PJjzmXRySTf5vLQiaYy+Jbxejcd/HaneBQdU1hDiz7krj7C11nU2eP?=
 =?us-ascii?Q?dumsnUWDe3P8iKtuQz0OrTIsRSy572g14m6gw4DHAL97nEF75d+P0zHxGQ+D?=
 =?us-ascii?Q?djvz1Qdf8WFLfMnw2cab7qSFDhjbkaHBV+NJ8qSrCd6jQmr7lsVBCPectqHJ?=
 =?us-ascii?Q?XDP5hcWEBFUrsI0SuQu2NSZCK7LkTpOO8K79JE6ajvlBrpVe9VWJB3IdROv/?=
 =?us-ascii?Q?7/bXeuO41hSqjXW4GQOIZ2OwkFVkSvymg2lFUzSHZJO+C9cyfC/1oZhAmYd2?=
 =?us-ascii?Q?y7GCq+B/2t81P8cCnwBj3qOAa9LSHuzCEtdf9iNN/0ZH2RNXea2WiGY9ICgV?=
 =?us-ascii?Q?24CxDiYKGSKQ9aY7mx+3bCDhBKbALFyS4AS5Cg0vMYqdWtI0B7JuDgkjyRHc?=
 =?us-ascii?Q?f0VzxnA4yoHOkpnV72/YkEFnrqEs4ltoq/JV8JM0/EVvUyFI8hP9yRSRB1bX?=
 =?us-ascii?Q?TtgUxBMa45T9zGnyfI8YcaKaVEnFiHXsA3gAeHcm4sLXbvkYtUV1hU8m4PhO?=
 =?us-ascii?Q?Ls+bUbMK5LaAaZ/3ltrxfA8vpmBSXC3upwu9ZpX+kfdVzsZ+CPH5Vx8Z0Uey?=
 =?us-ascii?Q?f+1GOY67647jk1sLISkrcwYZNbwaJR0MFwROV1mKzGVn0GyjezZZ9n9Rxmph?=
 =?us-ascii?Q?rDc+3idYjxyuqakDftDM0NQYMuUBYA3a6m6hYZ/w49aUE0FvU2H2RwOlSSLA?=
 =?us-ascii?Q?xoULp83nwQd5fnRujR4eEFX9eW34Yi+xhO0MqV9Mb2XxRXYiRjkWjT74w27M?=
 =?us-ascii?Q?YkNKVe6HKMwqJwqNdHFVko6Q6bb56CwxHN5XTcTQMK6vxPLwUUhz5byMkzna?=
 =?us-ascii?Q?DhTcZsVOjNezri7YmXwyfNOPnQfBqcbDaMenx1+TBgeJiUywNosnGTjlbGnW?=
 =?us-ascii?Q?jhDNYZeQa1nUj5oq+BYIPpkMiUXNimiKq5Uz0Ywhv4tTW28Ax/pSiPv4vcFB?=
 =?us-ascii?Q?KP2FPZhhcf+pRv8EBCwDTpVSpcl1diHJIcTs70FG2Na/kJVXzzAH90yR1nX6?=
 =?us-ascii?Q?j3/amzs5dJXxoSvS3lEcYbIc1Xj5nzOxQUMCF5j5cPuS54M+Rk9eKiOtGUTM?=
 =?us-ascii?Q?0CuSKOjIX/Eehjc1BSAv3Oe9Ch+Z0T4dKoNgHJsse6naVABQepmmZdqNmWzX?=
 =?us-ascii?Q?pfiuVQufucm+f9tVYSyq4JkeN3Q7H9jfFipHJxwc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 961efab8-26e5-48ff-6fa1-08dc0bbc6df6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 17:58:30.9228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiFjxlfwt1IfNsIn4oVP+c6DHKaNxMQZNygavty2//NY3FK1h8daRfUlgFie7BUH61BOnwgI/XswNVQXJETHUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5138
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
> 
> Add GHES support to detect CXL CPER Protocol record and cache error
> severity, device_id, serial number and a pointer to CXL RAS capability
> struct in struct cxl_cper_rec_data.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/acpi/apei/ghes.c        | 15 ++++++++++
>  drivers/firmware/efi/cper_cxl.c | 52 +++++++++++++++++++++++++++++++++
>  include/linux/cxl-event.h       |  6 ++++
>  3 files changed, 73 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d6a85fbc0a8b..6471584b2e79 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -714,6 +714,18 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  		cper_callback(event_type, &data);
>  }
>  
> +void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
> +{
> +	struct cxl_cper_rec_data data;
> +
> +	memset(&data, 0, sizeof(data));

Does this need to be done?  Could cxl_cper_handle_prot_err_info() use
something like this initially?

	*data = (struct cxl_cper_rec_data) {
		.rec.hdr.dev_serial_num.lower_dw = prot_err->dev_serial_num.lower_dw;
		.rec.hdr.dev_serial_num.upper_dw = prot_err->dev_serial_num.upper_dw;
	};

The serial number is always set even if it is not valid.

> +
> +	if (cxl_cper_handle_prot_err_info(gdata, &data))
> +		return;
> +
> +	data.severity = gdata->error_severity;
> +}
> +
>  int cxl_cper_register_callback(cxl_cper_callback callback)
>  {
>  	guard(rwsem_write)(&cxl_cper_rw_sem);
> @@ -768,6 +780,9 @@ static bool ghes_do_proc(struct ghes *ghes,
>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>  			queued = ghes_handle_arm_hw_error(gdata, sev);
>  		}
> +		else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> +			cxl_cper_handle_prot_err(gdata);
> +		}
>  		else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>  			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index 4fd8d783993e..3bc0b9f28c9e 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/cper.h>
> +#include <acpi/ghes.h>
>  #include "cper_cxl.h"
>  
>  #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> @@ -176,3 +177,54 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>  			       sizeof(cxl_ras->header_log), 0);
>  	}
>  }
> +
> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
> +				  struct cxl_cper_rec_data *data)
> +{
> +	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> +	struct cper_cxl_event_devid *device_id = &data->rec.hdr.device_id;
> +	struct cper_cxl_event_sn *dev_serial_num =  &data->rec.hdr.dev_serial_num;
> +	size_t size = sizeof(*prot_err) + prot_err->dvsec_len;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> +		pr_err(FW_WARN "Not a valid protocol error log\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID)) {
> +		pr_err(FW_WARN "Not a valid Device ID\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The device ID or agent address is only valid for CXL 1.1 device,
> +	 * CXL 2.0 device, CXL 2.0 Logical device, CXL 2.0 Fabric Manager
> +	 * Managed Logical Device, CXL Root Port, CXL Downstream Switch
> +	 * Port, or CXL Upstream Switch Port.
> +	 */
> +	if (prot_err->agent_type <= 0x7 && prot_err->agent_type != RCH_DP) {
> +		device_id->segment_num = prot_err->agent_addr.segment;
> +		device_id->bus_num = prot_err->agent_addr.bus;
> +		device_id->device_num = prot_err->agent_addr.device;
> +		device_id->func_num = prot_err->agent_addr.function;
> +	} else {
> +		pr_err(FW_WARN "Not a valid agent type\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The device serial number is only valid for CXL 1.1 device, CXL
> +	 * 2.0 device, CXL 2.0 Logical device, or CXL 2.0 Fabric Manager
> +	 * Managed Logical Device.
> +	 */
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
> +	      prot_err->agent_type > 0x4 || prot_err->agent_type == RCH_DP)
> +		pr_warn(FW_WARN "No valid serial number present\n");
> +
> +	dev_serial_num->lower_dw = prot_err->dev_serial_num.lower_dw;
> +	dev_serial_num->upper_dw = prot_err->dev_serial_num.upper_dw;
> +
> +	data->cxl_ras = (struct cxl_ras_capability_regs *)((long)prot_err + size);

I think this is ok now because the cxl trace code processes the data
before returning (in next patch).  But I'm a bit leary about passing a
pointer to data controlled by the acpi sub-system.  At some point the
event may get cached to be processed by another thread and it might be
better to copy the struct here.

> +
> +	return 0;
> +}
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 90d8390a73cb..7ba2dfd6619e 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -154,11 +154,17 @@ struct cxl_ras_capability_regs {
>  
>  struct cxl_cper_rec_data {
>  	struct cxl_cper_event_rec rec;
> +	struct cxl_ras_capability_regs *cxl_ras;
> +	int severity;

NIT: When I saw this without any addition to event type I wondered if the
series would bisect.  I see it does because the record is not sent until
the next patch.  But I wonder if the 2 patches would be best reversed.

Also, should cxl_ras + severity be put in a protocol error sub-struct?
Does severity ever apply to event records?

Ira

>  };
>  
>  typedef void (*cxl_cper_callback)(enum cxl_event_type type,
>  				  struct cxl_cper_rec_data *data);
>  
> +struct acpi_hest_generic_data;
> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
> +				  struct cxl_cper_rec_data *data);
> +
>  #ifdef CONFIG_ACPI_APEI_GHES
>  int cxl_cper_register_callback(cxl_cper_callback callback);
>  int cxl_cper_unregister_callback(cxl_cper_callback callback);
> -- 
> 2.17.1
> 



