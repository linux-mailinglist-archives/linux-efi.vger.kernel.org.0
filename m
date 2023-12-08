Return-Path: <linux-efi+bounces-137-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2889A8098A9
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 02:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939161F212C4
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 01:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B215D4;
	Fri,  8 Dec 2023 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7q2dYw6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42AD1712;
	Thu,  7 Dec 2023 17:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701999637; x=1733535637;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aDW8L25ya+NyIsHwJZIpDw5IJQMC8cMGrp+zvHkH/W8=;
  b=n7q2dYw60pm/Z5Np4Ryqr26xcjHTWTk+ZOG6RjoeMKDPMKYVKLc20ZFL
   Og2HhORcpby+ennP2PUQpzcSL/9BA+EPUKWfwzVs69SeMQbIi1mjxfwgk
   QCr7vMK3PGUEiZTZnQHNFcufXm/hygD/5GAido/cuKE86y7WXUv4ShQsx
   jLRRD030cpAkTIHE0QtUZC6VhsL50NZqgm42BZ/38vYSOfDarm00xzLRg
   Sk4x0hKuNZvXRWA/4WtnKpSbwEjKJf+wKgIgEQEE65ugY9RLXgVuqhp8S
   RBtj0S56hZtYD+VIbUSazY1tdJZR6ibL/SEoNsysuriCTSwtmX9yIMDln
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="425477498"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="425477498"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:40:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="13323975"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 17:40:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 17:40:35 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 17:40:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 17:40:34 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 17:40:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ereCiOXqxBW1APgho8I3P0dEKKmy/4bqTKXeJ/5//6B/9uGamyRO5gm9A4LcIN0TKslLW/Re7deHmPFAAJLV+HDRImzN8Co+FfYab7hQF2QC6uovsp3HN3RWqxmt21kIkYjN3VBcm98IQu96cN6sqwa4aenZsi7uJZ7H2GeY3XttC0rMLkxv/OOITdWgaYxdRqz6WxHN5UTDdwATyJ2pX9W3f5tjNCcA6JFSfIIBTLD2DWGeI8WzAPoRZb5Qq1mPVAhynzo1DE6ROFspornoOXuMXleXa03aD0ofvrdXpNtwC5V8iD9UP0GJejJWiFVvGJyIFVH8Gw+P7I7iGq7Y2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plxoFr/XSRecGgtM2C1WiQB6y2Tuid48Gmf1OdM2B8E=;
 b=A7vtL/QrzUUvivh2YpKNn0saYNPIwCGih2x3MNOTIWEmU4R+Un8r9UbAMcNBttmgK+2W4W4pt+3vuCRtCFBcjOHQ/GjVjtob/Jzucn8pzFzQ3blc3uR++YmCasHO4oLt2WHFnqgY8+JLglMPYDdcI402matjxM4HoAlOagXS3l4T8ncTLJ8W9XYIT3i5Fo6+CkKnWOV3T0yRPv/q437rsewAeUlHfrBokBdFh17qpNh4qBSEbHGvhUiIIBNP/w9dF94us2Djea6bG6smAJO5JbhW/c4lZAlLvUohA+3/Wm5SogHV/9rFLlQ9EdS7jpEeNYAVYdUmd2WkjvGc4tI/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7714.namprd11.prod.outlook.com (2603:10b6:a03:4fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 01:40:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.025; Fri, 8 Dec 2023
 01:40:28 +0000
Date: Thu, 7 Dec 2023 17:40:25 -0800
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
Subject: Re: [PATCH 5/6] firmware/efi: Process CXL Component Events
Message-ID: <6572740922eb6_269bd29445@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
 <20230601-cxl-cper-v1-5-d19f1ac18ab6@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601-cxl-cper-v1-5-d19f1ac18ab6@intel.com>
X-ClientProxiedBy: MW4PR04CA0363.namprd04.prod.outlook.com
 (2603:10b6:303:81::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: a6cc5488-a81d-4abe-7fdd-08dbf78ea832
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFCWeslbmgu9BA0y7+ScxpizbJTotpTuLEK0sjNQ8Q08kl+OEzbTm2BvW14yvsXAr1SwFS0mNrn3voeJwgKhWPeGxEdoD6pxwFZ0W4jpBwThdAaESt10eIzwvKuyMiBWa3eUX77Q8Y6Q3TKp4LvBEmGjgvE1bYRq/ZzYjPle0yl75ItyGKr3HH+ZGM0VYMeLo+M1XGIB0j60jh4/3ijZDGEFSm7MCm/kjP47ruCf+eOsfOKip1zZRxBU9Loaj/nya/p6zIhhCWFflqcWlgD101j8IB8uOYcH5+seVaXgFV+4ibNtvzgIXbJ42px5KbP2j906fnBEB6AXTvZDP9Lp+cCZ68QNuweFPMVDpz9eNFavf+SBfy01l/2fva0PXV1P1I3bBVpb936r/GyWiqWT/DSf++SgXSPuMnv7OmlHAE7NnkkOQfpkVrfGhTNTu9rOQL1nD5tCBMVXFrQxNSLXo06nCYxjHhq8JDNns+8u8TQpr0y1exRXUNPRYuuIrVKa8oQ5BovG1rVmul1AHs8IA2feMBd8e3uFAQ1vREdWErLRkf3q3P8yH6vfihkEQNSx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(8676002)(4326008)(8936002)(5660300002)(316002)(82960400001)(66556008)(66476007)(110136005)(38100700002)(54906003)(66946007)(86362001)(6486002)(478600001)(26005)(9686003)(41300700001)(6512007)(6666004)(6506007)(107886003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hfWUVyE4Gejvf/mFPxCRiGOBExJGDjPni+z3+DOO7/eMvHhil1P50LppMc7A?=
 =?us-ascii?Q?r5nQrkkkh9sNdnN3G91T3IPcUSTIv6xB2rIe675C6BuEco5WR45bJp7J6CYF?=
 =?us-ascii?Q?qyCsF7kY+VaLmnyDiYjB6IrvuvqGi2DvfASIw7gusz6TvfqCw8c+vX5dM4XP?=
 =?us-ascii?Q?Hsb3CMQT6VJ5seFhyR2cxyweYbctP6fmTS6GkKKGE5nxfc8F94u7BSUhlqZJ?=
 =?us-ascii?Q?tMBI6uDE0U34CbDd2I7WgjYPmxTU8BkE7Lspc2pHQ/ra2vavotVR9R8HucVN?=
 =?us-ascii?Q?Zh7o3hkzCyo6TLb8qKm8M7PVDEI1OKkOTy2jXSYeZqXB2Jidm/9ixssxEuQk?=
 =?us-ascii?Q?vKfznpxsa7lRGmFfd/R0eAkQR55QKSpm9P2qWEZWmDQHG46DAVo6pavhA4Gg?=
 =?us-ascii?Q?TgXWVcpoORby4ggbhvdCTsceszFp8AeQVnHDDSWNdN5TVs9OP1cRqZ11Vkw4?=
 =?us-ascii?Q?GvnHIika6ukuymzTxIRqdmBLBRG4y1R4Z0cLPnGMUtqEB2FPOPmVAOmPUvsK?=
 =?us-ascii?Q?RKPH+TvZ9/ngITXy318aCEBGBy0DZJSaYf6g78+jeF6DM6HC/MonGXAIQQjF?=
 =?us-ascii?Q?mQ1i9mJlktX8HuKpkb5tpQNlCeDMDYxSjpK40eOC2FIr/FJhwC3UF9HNLcCN?=
 =?us-ascii?Q?vMeMKN6+41Q9WU2fee1BrWUHTORwHBMasoLy2r8fVyAFuTSB3xckk3p5jZUG?=
 =?us-ascii?Q?gf2/GnEG+cGhcY9V8uCZD2M3O86z3u03L9MIeD8+NNJQSvRE1vLxanERdgO9?=
 =?us-ascii?Q?bJ8Qz8XaaY4VlJO4LM23ICMWc7kCzfaw+CLN0P089KhxISNm7ND49PqWxAFx?=
 =?us-ascii?Q?CC1LDfxqq1vKhM2WEa7WBfaw9lrFLlC/5+GdhjwkWv1GLKGZLq9R4yf3r5bF?=
 =?us-ascii?Q?0JqfjWfcCz+u9Q+bn1PwAZX2m0DTWS/3mmStm9q84E3yzUA6NwcQ/P5tyCAp?=
 =?us-ascii?Q?QlpzCDMowOSeppe82ed9lj5GSAnB/LXLCw3G7AVv5NjAc9hhiMf8IqOEmYNa?=
 =?us-ascii?Q?r8MP7mk0DrsOUo6AYTujUgQewXX/cOR/0Jzm13AnmK+vBvR0PMhWPrvw6OVM?=
 =?us-ascii?Q?RpVeK4jqYU3R0Ab58vfSRjtsiB5pBy57dUKvr0WQeCs37NmmE15tEfpTOLDh?=
 =?us-ascii?Q?PgX3CojnyRVBUSg/T3ApWPG6jRIBEESnHCDe+x2hzASZcABEQdtRFR5PdpMm?=
 =?us-ascii?Q?4lbEcs8cvwczOjiKiAaeidibGJjlBaPq5Oqy/d4FFjM2RQBVkXX72EPkjQ75?=
 =?us-ascii?Q?eKUhx/KGfCNByAZF3SKTxt/pjy3FqHjTVTLdQ/9eogrTyBc+Xi7efx5F+2Gz?=
 =?us-ascii?Q?xIxJIuygUFd1lGweAkhRPlcXCU6nMsHIiimCH2jbRoPjxtMQJtMEdjBMIkIl?=
 =?us-ascii?Q?0O576l75Wlao5fswrJ9nxeh6lvtgFLY/B3ze2kYAA1BkUedt7SkRwRmcpnDF?=
 =?us-ascii?Q?va6PnYyvXa7HjXdOxvJ2qbvq2oPmC6Tgf9mBBJToBU6uOde02TWOG7y5335c?=
 =?us-ascii?Q?sjvm3JKaXkqP/HrelnYRxGwjNjaNKJz6NBc7rDYJq/LGry8QdHrvujMcV/iu?=
 =?us-ascii?Q?PSKWdYcaJS42yGmxGvb80eNLXVto2toWLVWniy+L6d4gSCEKhnspLA6aMya+?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cc5488-a81d-4abe-7fdd-08dbf78ea832
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 01:40:28.4773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd4yfRGp8ECQYUNzcczxtZF4i15i4U/dOkl44ig8GThloVH7oLzodtBdkPZMfBqTnylcLLEsHi5QbfNxxq1/CbTemSkMgXuc3Z6FOCZrVeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7714
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
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from RFC:
> [Smita: use pragma packed for cper structures]
> ---
>  drivers/firmware/efi/cper.c     | 15 ++++++++++++
>  drivers/firmware/efi/cper_cxl.c | 40 +++++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper_cxl.h | 29 ++++++++++++++++++++++
>  include/linux/cxl-event.h       | 53 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 137 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 35c37f667781..3d0b60144a07 100644
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
> +	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA) ||
> +		   guid_equal(sec_type, &CPER_SEC_CXL_DRAM) ||
> +		   guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE)) {
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
> +		cper_post_cxl_event(newpfx, sec_type, rec);
>  	} else {
>  		const void *err = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index a55771b99a97..bf642962a7ba 100644
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
> @@ -187,3 +188,42 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>  			       sizeof(cxl_ras->header_log), 0);
>  	}
>  }
> +
> +/* CXL CPER notifier chain */
> +static BLOCKING_NOTIFIER_HEAD(cxl_cper_chain_head);
> +
> +void cper_post_cxl_event(const char *pfx, guid_t *sec_type,
> +			 struct cper_cxl_event_rec *rec)
> +{
> +	struct cxl_cper_notifier_data nd = {
> +		.rec = rec,
> +	};
> +
> +	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> +		pr_err(FW_WARN "cxl event no Component Event Log present\n");
> +		return;
> +	}
> +
> +	if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA))
> +		nd.event_type = CXL_CPER_EVENT_GEN_MEDIA;
> +	else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM))
> +		nd.event_type = CXL_CPER_EVENT_DRAM;
> +	else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE))
> +		nd.event_type = CXL_CPER_EVENT_MEM_MODULE;
> +
> +	if (blocking_notifier_call_chain(&cxl_cper_chain_head, 0, (void *)&nd)
> +			== NOTIFY_BAD)
> +		pr_err(FW_WARN "cxl event notifier chain failed\n");
> +}
> +
> +int register_cxl_cper_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&cxl_cper_chain_head, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(register_cxl_cper_notifier, CXL);
> +
> +void unregister_cxl_cper_notifier(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_unregister(&cxl_cper_chain_head, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(unregister_cxl_cper_notifier, CXL);

So I am struggling with why is this a notifier chain vs something
simpler and more explicit, something like:

typedef (int)(*cxl_cper_event_fn)(struct cper_cxl_event_rec *rec)

int register_cxl_cper(cxl_cper_event_fn func)
{
	guard(rwsem_write)(cxl_cper_rwsem);
	if (cxl_cper_event)
		return -EBUSY;
	cxl_cper_event = func;
	return 0;
}

...do the reverse on unregister and hold the rwsem for read while
invoking to hold off unregistration while event processing is in flight.

There are a couple properties of a blocking notifier chain that are
unwanted: chaining, only the CXL subsystem cares about seeing these
records, and loss of type-safety, no need to redirect through a (void *)
payload compared to a direct call. Overall makes the implementation more
explicit.


> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> index 86bfcf7909ec..aa3d36493586 100644
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

I like these defines, I notice that mbox.c uses "static const"
defintions for something similar. Perhaps unify on the #define method? I
think this define also wants a _GUID suffix to reduce potential
confusion between the _UUID variant and the cxl_event_log_type
definitions?

>  
> +/* CXL Event record UUIDs are formated at GUIDs and reported in section type */
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CPER_SEC_CXL_GEN_MEDIA						\
> +	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> +
> +/*
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +#define CPER_SEC_CXL_DRAM						\
> +	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
> +		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
> +
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CPER_SEC_CXL_MEM_MODULE						\
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
> +void cper_post_cxl_event(const char *pfx, guid_t *sec_type,
> +			 struct cper_cxl_event_rec *rec);
>  
>  #endif //__CPER_CXL_
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 18dab4d90dc8..114f8abb7152 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -108,4 +108,57 @@ struct cxl_event_record_raw {
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
> +struct cxl_cper_notifier_data {
> +	enum cxl_event_type event_type;
> +	struct cper_cxl_event_rec *rec;
> +};
> +
> +#pragma pack()
> +
> +#ifdef CONFIG_UEFI_CPER
> +int register_cxl_cper_notifier(struct notifier_block *nb);
> +void unregister_cxl_cper_notifier(struct notifier_block *nb);
> +#else
> +static inline int register_cxl_cper_notifier(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline void unregister_cxl_cper_notifier(struct notifier_block *nb) { }
> +#endif
> +
>  #endif /* _LINUX_CXL_EVENT_H */
> 
> -- 
> 2.42.0
> 



