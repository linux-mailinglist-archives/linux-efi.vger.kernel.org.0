Return-Path: <linux-efi+bounces-193-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F3C80F3E2
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BE71F21736
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77E47B3BD;
	Tue, 12 Dec 2023 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rr1tfOrT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D007A95;
	Tue, 12 Dec 2023 09:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702400476; x=1733936476;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3410O6vBbNBzYb56kfXVqGF8agdDn64q5jMUwC3JV0c=;
  b=Rr1tfOrTrVCffj2ntJ0EJCdTjOWOoKZz57/K/AzE+lxPYEWUyjM+PrwN
   ksnUcoZXo4byl6X8fGDVQt1W5ZIP+3EoR2Qun2S/oDf/FX0jAuPOXBKDJ
   wdIAbfpE1ZN+nvFbSYGwhuA8o0Ic9yVUdZG5M88Yi77P5LRJrRcILHfue
   qABXge3B9FJdAlaI5VAGLCeI4V0aEZTU7yb+27iV2isAk4K/zXUDaND9g
   wQP/gMW9K0XsTEPK95b4aZon46f908iOeahk3gl4HClucuWepd9FkMhCN
   pMfDI9mNqjtPe114LFQi8rs9/adnUDObYIJb1mAdTv0TANmzie8pCMsJ6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="459155258"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="459155258"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 09:00:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864272739"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="864272739"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 09:00:57 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 09:00:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 09:00:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 09:00:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnHtfseqkEEFreC7VoPNaxcdzdhsR2cAagbEg00Nj21T9MOH7HKC1CPNhx4VJoE57AW6WCwehdaK9SFo+q0wciLNTGMVIiqz9MYdb2bPEvoEM+uBwNCMsiPflXskZzi/VwQr5sINFxdn2BfOgWASCpsaA/jZwQ0olEszyMBE0uK0uNT3Ed/+IRvv6tFx6CmObX7thoMxrZcJPiINs991GT8w56chTJIyzW2y0j0+To9/XJqNCEsVuydFUtALJr/Es1eQB8vYFjdt8Y5NY6CVKTYbRO5fOlbU2hVueGcYqkZaBqMsS3ulva5iFzj1gtDeXN3NhMEbb2JdGzRWh7aEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+wWGI4CcNV2w5Fy7xr7KXwuO/VbkOAkPqpLtwXcRZY=;
 b=fVOXRqzR1q/eKRwVOQM/EuZcw2T2PPE0dFvuF9q34+5SIPghqeuC8+25scH7mULiYExMNIqv4aflw58Rn5UrRdLMwIZRBEwKtn8LVxodtV2W938Cw8XoBHgyoHD70MB/gKnb9ZWUIzX2E53YRFQejXO+dOgx72/llB8LEZLopM4Pd3TmninoQgGLv9wjip/DYhVgoE+hnBVSCq95yiIaDbjizCQByGdVBY1SUcmNrcmTcQCEz4eb060xrNcgDVhDbMBidBTaqtR76Lio5rhg4BPmWBn4HBWUuvv53nyV/YatAUW46vp0wqZuKnnHqHQW5i6f6mMtjcfE8VI473T0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5076.namprd11.prod.outlook.com (2603:10b6:303:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 17:00:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 17:00:51 +0000
Date: Tue, 12 Dec 2023 09:00:43 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2 6/7] firmware/efi: Process CXL Component Events
Message-ID: <657891bb7ec69_269bd29421@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231211-cxl-cper-v2-0-c116900ba658@intel.com>
 <20231211-cxl-cper-v2-6-c116900ba658@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231211-cxl-cper-v2-6-c116900ba658@intel.com>
X-ClientProxiedBy: MW2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:907:1::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: c42ac28c-ec51-447a-83bd-08dbfb33e58d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibcNoiKpk6NCMjkHTkNupF3wg/382JdimvFAYRJJQ7N00KHpyKxlET1VrsQlXGIqjD0BwBtVICpRSUH2Y2Vx55cHUZslkTlh2cXWPkTkDiVobt8LvzQ/WxoE4gVKaFCWPhUJFj2ZazTE8/oGbjEh9EMrvqk+olZ0Ny9sEBua9PAJpHb2bjST3ywzxx/E+7PXtYUMGaDhRXUl+/n8j7trvMx8oD+UsjQivQsQzignEi+vWKy0XY/Wgm7AqKAT7pGc2+ndF0OpENivtAq7NjRCgvMJhcKir5zKJrfF7AByqn8gHl7OHmqKTsRyz+Iyzxv5G1M1Bg21Me+jCxhZmYaXnqfCYRC2/EU0RDBZ0bvqdzS/Df15uzTUW1T1E3ZF+IqvcO006MYj2XTMYgpogSrYB1byF7ii3xLGm4KrsI8i+hycuQHTbrhBfQvEFRyLwJxemFH5pzRT4QEgo1fG482rjFjob3I3znZDwq4RJwKsXPPupHTUQGYra2CyvbjV+2FpBJOfw5KWg3JnvQ0CYF26l4BPum8Dh9qGzhHoGHclEYDxSY9YnqXQ6CBDSPfIol+P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6512007)(9686003)(6506007)(5660300002)(26005)(107886003)(54906003)(66946007)(66476007)(66556008)(6486002)(2906002)(83380400001)(82960400001)(86362001)(478600001)(41300700001)(8936002)(8676002)(4326008)(110136005)(316002)(38100700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IMRAq6SUr4wWClcMhcaL0Tztg0lgdvEGZ1QfLp/46NyFQTlIkckSSdY31J6N?=
 =?us-ascii?Q?bvTJQ0HQw3jo31SG7xBfDhrItEQA/8Tt8l30mn3SmhR0ejVW49pO+CRyaRw8?=
 =?us-ascii?Q?+n9KgE2BHkWaYuyz6GGVLZ4qEUGOYaVtZUfIEzGi4M+Sxb3kpoMDeijDjyaF?=
 =?us-ascii?Q?5wQWL+GQSn1Ca7P7pJpRt8ztBGfemk0nP8Zlm0ieI48hWz7rqEbOw98Kmk5U?=
 =?us-ascii?Q?iGVS3RnXqa15VcU3MO1QNEhYVc3L78aC+OJFXbFCQgpNvjaY+ZdJKwVoGnRc?=
 =?us-ascii?Q?R7oCLt19r9NdkBCYraGhR643xmV5cpkAhJwyQTGI9l158NJgAjCMY9JDms5s?=
 =?us-ascii?Q?IvkUA1KJ8/nn+m74u0/3vc15XXduofrWgNCzw93AotaR66F5Ujzvih3sy/A2?=
 =?us-ascii?Q?8MM/0TuX6HZt/4N7//Bi0S2W5VtxA7lol4ya3vAyZPWtEkzC1h5+LXQgRLvB?=
 =?us-ascii?Q?UVzudOHRBbrFaA+M3jhamdmpW6aLxkh06S26CYmoDyvVX0zgSk9pZp95wM9P?=
 =?us-ascii?Q?byJKXdiMqITQhHFcrcxa7FQAc+8J9zM5my226J5POhy7rnGKpzRRyZHwATAm?=
 =?us-ascii?Q?wv2W/BOgI7bioZC2lWBH5ySjvdetNuLaa1XoNYn49HyaDWxdAD5cibSMzGCy?=
 =?us-ascii?Q?ELnyr9y/+DvH5Of3EY03rb/YhBvpDwKX8zUg2tdJAoLaVYVZZEvnuO/yW873?=
 =?us-ascii?Q?0paHKecTpF2DEAfvkzJ8hEyMjh1zqIyEBUW2BRWZl02jTNiDjgT5Tg14mUmp?=
 =?us-ascii?Q?7YRlBa/bu3y7nGCIQMYxWzejCjHF4GeMm3MXS3gdBnKOgQITtvQLsmcQYGKE?=
 =?us-ascii?Q?b76/SLxECDkSkoxMypIuNNrsPiO57IKfNrT4opULSrd0ahDjMKJ2zTbXtBlJ?=
 =?us-ascii?Q?GKKHGpPxmaXW6ABMhVgJSwab27g+L4z7dlo0L52HtqXNMdz7Xto3vuEQlNIo?=
 =?us-ascii?Q?GxGDKltYA9ubYb+ETiL0zyfDX16xu6Ezq0C1/5MJ4T0oNaQGcIzQS3j7xU7O?=
 =?us-ascii?Q?FCniR/hOnWFG4cghKUYpvW0YUw/W4UAVDrJfK8D/X85iE+k/We2fDSLJDh75?=
 =?us-ascii?Q?ecXdMrDUh56TDrLfI3x1lG8PedNAcKhzVUnyR/dONnur0fn1KuMQTy1QjmAK?=
 =?us-ascii?Q?soED2d584P4fm1AVsvrACCnKzhRgjet52oVrHpC448Gv1VzGB869Q3jk0BI7?=
 =?us-ascii?Q?2Ka/6NmM8KU4UPB9b/S2STj49kThitFouqj0kKrAyIQ21mMwBAznOVekoa4m?=
 =?us-ascii?Q?K43bPczQXZrsKp7XOAleP9YlFFSx3dmC9MQWywiyaAJX/t3DQVaRmMraYW9E?=
 =?us-ascii?Q?JKseyiU+IlgVmH2c5vYKjvgUar8BZ1GUD2n34CyG/2jWS/Blcm0cpQbQvYSJ?=
 =?us-ascii?Q?2xvFxFhReVzwOBXB2EwBFelI+eXFh1rhOJgD0tB/4WUKVcFv+5obbEVjh5lK?=
 =?us-ascii?Q?z2g6MSWs8HyBDf3Bz4n2mA3JBK7qZp5UIaVT9IBac7oo/ZwFXzmywlp8/yo7?=
 =?us-ascii?Q?wwiOhzt2PEKPULHZZFIyunw8xrKp5sX8bCeA7cxwFXbM+tRTKklfEt/K+iue?=
 =?us-ascii?Q?jMq1cuMSHiiqtmcnB+XMAF8LtGnCE9JwLRwmRPm7QcEY6f5R+u1D3dneRD+b?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c42ac28c-ec51-447a-83bd-08dbfb33e58d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 17:00:51.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKJCy2ln8VS2NehzX4WbJFFd+l21kqmNCd0l+TgddCJhGr9OHS0zpTqMWSM7WkDUJJSrAPi3kK00iaDA+4PdqKmGTJLt/TCXP7l6E6CUGXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5076
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then send
> these events to the OS via UEFI.
> 
> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The difference is a GUID is used in
> the Section Type to identify the event type.
> 
> Add EFI support to detect CXL CPER records and call a notifier chain
> with the record data blobs to be processed by the CXL code.

It is no longer a notifier chain in this version. I wouldn't even call
it a notifier, it's just a registered callback.

> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v1:
> [djbw: convert to single notifier callback]
> [djbw: append _GUID to guid defines]
> [iweiny: clean up function names]
> ---
>  drivers/firmware/efi/cper.c     | 15 ++++++++++++
>  drivers/firmware/efi/cper_cxl.c | 45 ++++++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper_cxl.h | 29 +++++++++++++++++++++++
>  include/linux/cxl-event.h       | 51 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 140 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 35c37f667781..39c65733ae9b 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -22,6 +22,7 @@
>  #include <linux/aer.h>
>  #include <linux/printk.h>
>  #include <linux/bcd.h>
> +#include <linux/cxl-event.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
>  #include "cper_cxl.h"
> @@ -607,6 +608,20 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>  			cper_print_prot_err(newpfx, prot_err);
>  		else
>  			goto err_section_too_small;
> +	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID) ||
> +		   guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID) ||
> +		   guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
> +		struct cper_cxl_event_rec *rec = acpi_hest_get_payload(gdata);
> +
> +		if (rec->hdr.length <= sizeof(rec->hdr))
> +			goto err_section_too_small;
> +
> +		if (rec->hdr.length > sizeof(*rec)) {
> +			pr_err(FW_WARN "error section length is too big\n");
> +			return;
> +		}
> +
> +		cxl_cper_post_event(newpfx, sec_type, rec);
>  	} else {
>  		const void *err = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index a55771b99a97..669983f7956f 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/cper.h>
> +#include <linux/cxl-event.h>
>  #include "cper_cxl.h"
>  
>  #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> @@ -187,3 +188,47 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>  			       sizeof(cxl_ras->header_log), 0);
>  	}
>  }
> +
> +DECLARE_RWSEM(cxl_cper_rw_sem);
> +static cxl_cper_notifier cper_notifier;
> +
> +void cxl_cper_post_event(const char *pfx, guid_t *sec_type,
> +			 struct cper_cxl_event_rec *rec)
> +{
> +	struct cxl_cper_event_data data = {
> +		.rec = rec,
> +	};
> +
> +	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> +		pr_err(FW_WARN "cxl event no Component Event Log present\n");
> +		return;
> +	}
> +
> +	if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID))
> +		data.event_type = CXL_CPER_EVENT_GEN_MEDIA;
> +	else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID))
> +		data.event_type = CXL_CPER_EVENT_DRAM;
> +	else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID))
> +		data.event_type = CXL_CPER_EVENT_MEM_MODULE;
> +
> +	down_read(&cxl_cper_rw_sem);

   guard(rwsem_read)(&cxl_cper_rw_sem);

> +	if (cper_notifier)
> +		cper_notifier(&data);
> +	up_read(&cxl_cper_rw_sem);
> +}
> +
> +void cxl_cper_register_notifier(cxl_cper_notifier notifier)
> +{
> +	down_write(&cxl_cper_rw_sem);

   guard(rwsem_write)(&cxl_cper_rw_sem);

> +	cper_notifier = notifier;

I would enforce that there is only one registrant and explicitly fail
attempts to assign more than one.

> +	up_write(&cxl_cper_rw_sem);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_register_notifier, CXL);
> +
> +void cxl_cper_unregister_notifier(void)
> +{
> +	down_write(&cxl_cper_rw_sem);

   guard(rwsem_write)(&cxl_cper_rw_sem);

> +	cper_notifier = NULL;

This could enforce that the same callback specified at registration time
must also be passed at unregistration to disallow anonymous
unregistration.

Makes the code self documenting that the registrant is a singleton, and
that unregistration must precede the next registration.

> +	up_write(&cxl_cper_rw_sem);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_notifier, CXL);
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> index 86bfcf7909ec..b1b1b0514f6b 100644
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -10,11 +10,38 @@
>  #ifndef LINUX_CPER_CXL_H
>  #define LINUX_CPER_CXL_H
>  
> +#include <linux/cxl-event.h>
> +
>  /* CXL Protocol Error Section */
>  #define CPER_SEC_CXL_PROT_ERR						\
>  	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
>  		  0x4B, 0x77, 0x10, 0x48)
>  
> +/* CXL Event record UUIDs are formated at GUIDs and reported in section type */
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
> +	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> +
> +/*
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +#define CPER_SEC_CXL_DRAM_GUID						\
> +	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
> +		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
> +
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CPER_SEC_CXL_MEM_MODULE_GUID					\
> +	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
> +		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
> +
>  #pragma pack(1)
>  
>  /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> @@ -62,5 +89,7 @@ struct cper_sec_prot_err {
>  #pragma pack()
>  
>  void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
> +void cxl_cper_post_event(const char *pfx, guid_t *sec_type,
> +			 struct cper_cxl_event_rec *rec);
>  
>  #endif //__CPER_CXL_
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 18dab4d90dc8..c764ff877a6d 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -108,4 +108,55 @@ struct cxl_event_record_raw {
>  	union cxl_event event;
>  } __packed;
>  
> +enum cxl_event_type {
> +	CXL_CPER_EVENT_GEN_MEDIA,
> +	CXL_CPER_EVENT_DRAM,
> +	CXL_CPER_EVENT_MEM_MODULE,
> +};
> +
> +#pragma pack(1)

Looks like there is usage of __packed a few lines up, just pick
one-style. Prefer __packed vs #pragma when only a small handful of
structures need annotation as that is easier to check for correctness in
patch form.

> +
> +#define CPER_CXL_DEVICE_ID_VALID		BIT(0)
> +#define CPER_CXL_DEVICE_SN_VALID		BIT(1)
> +#define CPER_CXL_COMP_EVENT_LOG_VALID		BIT(2)
> +struct cper_cxl_event_rec {
> +	struct {
> +		u32 length;
> +		u64 validation_bits;
> +		struct cper_cxl_event_devid {
> +			u16 vendor_id;
> +			u16 device_id;
> +			u8 func_num;
> +			u8 device_num;
> +			u8 bus_num;
> +			u16 segment_num;
> +			u16 slot_num; /* bits 2:0 reserved */
> +			u8 reserved;
> +		} device_id;
> +		struct cper_cxl_event_sn {
> +			u32 lower_dw;
> +			u32 upper_dw;
> +		} dev_serial_num;
> +	} hdr;
> +
> +	union cxl_event event;
> +};
> +
> +struct cxl_cper_event_data {
> +	enum cxl_event_type event_type;
> +	struct cper_cxl_event_rec *rec;
> +};
> +
> +#pragma pack()

> +
> +typedef void (*cxl_cper_notifier)(struct cxl_cper_event_data *ev_data);
> +
> +#ifdef CONFIG_UEFI_CPER
> +void cxl_cper_register_notifier(cxl_cper_notifier notifier);
> +void cxl_cper_unregister_notifier(void);
> +#else
> +static inline void cxl_cper_register_notifier(cxl_cper_notifier notifier) { }
> +static inline void cxl_cper_unregister_notifier(void) { }
> +#endif
> +
>  #endif /* _LINUX_CXL_EVENT_H */
> 
> -- 
> 2.43.0
> 



