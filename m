Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F27CD269
	for <lists+linux-efi@lfdr.de>; Wed, 18 Oct 2023 04:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjJRCmE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 22:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJRCmD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 22:42:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9157FC;
        Tue, 17 Oct 2023 19:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697596916; x=1729132916;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lb3bj4a5/jlC4wp3W3NWiCY5pN9B4jzXiWyJqnnlZVE=;
  b=G80NVptMYFnPlSMbkVOGF9b17P2dpTmcZrd/8yQV+qPftzveddk0EPIC
   UtzKfd1iccJPehAVAgk2kwTMTZxDGzAg0w3ExhTmf143gNWR1YMdPi6bv
   vWBB5X/9ZES/RZu4+fgDOfQrJ6UI4R3KIyUP+prOeSlWNBJ+6lgAwZvHD
   S7obwLRfvCGnvZPPh4rc174MXsYUI1ZijOXsI1aBP5UjAeFERDbFBWKuQ
   Gcl0ST60MdUYZn8IqOpSZecLZs7zaiZTx2sDwRFvLfmMfyM2Z4nAxYChS
   hZxtAoaqRxExo4AToEZBg524fR9uqhX12vNPwsVJ3V+Yo1sehrSwkxh5K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389799352"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="389799352"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 19:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822244447"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="822244447"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 19:41:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 19:41:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 19:41:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 19:41:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 19:41:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny6Dp4yOSfcVnOVPEwikpz76zTThKU3RAYViZ3II5HjJXQJQetpPKmgFyM98QumD2H3t1B8XyfelvHrlIW061IYYsmT3ZC99bU8mDDC8lqU2f1riiCIfB77Ec17qz4cbYQIaJvI56xSBBflqCQSJ79zoGGyp/9ObVUV3PZd/btvkHhiPIgpnP83Cmme9in4uxSRYIwi7X8/dNvaJ1PAOXQSVydIWgtxFhT8TeH5ew6/Hvxza7Gadq5PjgqV68OwCQyRFBpVa4irFEJwFwJyImrcwdRWS5iN7rQLYMqgRsWmQRe0de1oxbGcakrN7VmrQDn7ymvMqnAxy1jnGTXeAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAWHgpDnMkRge+dwzg8I/2tDuxyaZa/nBW8yFalmet8=;
 b=MDgZY4YvHIhjhSR2Jo6tNiwAMrwFD/AfNoXV7uejV3LyoiLbrGntb8n3FhCh/aOj76vI9YAnbkABQ1zWzwEVk8EEmPWimykq6kh4uvLPOUPgMDLOZzS2wMmyKMmAdw0D96pvlpebhgdhvEJ2+vYcSD4m83lcLmUq2rV2dk+vZtvM4ubxR2tmsgQxgz20nwJLZeFtjs3sxtBrSwa1iVvnYKd56Xdo3f/3HxL16lhFly6GHoaX6L4xoH+D87EJ1CHP52k5ExDk3hRnhJuTRQM8MNXaSbYle/a2Y8IheEthKpQXbJYVr9BQY2BnueXX6naRAou9NqXr8uNk92Nixgb/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB4843.namprd11.prod.outlook.com (2603:10b6:806:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 02:41:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67%5]) with mapi id 15.20.6863.046; Wed, 18 Oct 2023
 02:41:40 +0000
Date:   Tue, 17 Oct 2023 19:41:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH RFC 1/2] firmware/efi: Process CXL Component Events
Message-ID: <652f45e29915c_2bb07d2949b@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v1-0-99ba43f8f770@intel.com>
 <20230601-cxl-cper-v1-1-99ba43f8f770@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601-cxl-cper-v1-1-99ba43f8f770@intel.com>
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: b3134174-74ea-4c25-a920-08dbcf83c204
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACnThqvLj+JvsopeVNjmOmOhVGJXOou6rEPQnXZh8yk5vyqlIcflv7hcfdY/k4hSC8dWz6612bz8YBiSBPfWwraRGmIbQYDEvlzKA3hdxc+9IqkCs5MPYwjf06gEzWFx7VTfwUm4DaXkWl8F/zAkS72WSCBVWkbWLK2IXtHslxJyNoHr44l7yzrxO28Z8tdZBij8Fs2vKPtMK9AkJK0LpvjaBKpCI2BSNAGBKMk/nMT4U0LsRXaloGEe9bRazFtSlm83FSvsIGksaHlTrb7CUcaAAopUvPU0NPFZBEjVvh9Q/t5AZtway0aH8Vrt7pKE2pcxER3qZIkBJjP4vIm0EQOy6PRlEMsun8wcygof+6KIr1DQjPZI9CLFrQSaXJ4VyWyCByPdKxvWNriH0iZpsbCgWw8hViNAPxdjJJXCW558iyOixvi+97HK3YKX/xfWwkTy6vOwmbPx+LJOh0sXbqiVnefQHB5VlCVxFnywFhlPIesBX2US60G76EnEt/hGNVGAjuutvvr6g75tJK78msipDC2sHfzLbfjPeAEl9zUWgnILcNYsoAXkYnzmKziH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(54906003)(66899024)(316002)(66476007)(110136005)(86362001)(66946007)(66556008)(44832011)(5660300002)(82960400001)(41300700001)(2906002)(38100700002)(8936002)(4326008)(8676002)(6512007)(26005)(9686003)(107886003)(6506007)(83380400001)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bg3qo/hBW3efdh8gTKAperE1rG2QkHkinS1VTrgbSb15R0ecS3rKB08x59ae?=
 =?us-ascii?Q?/larY0p01V3fyMOiEtvB0+0JML20vC8zP8vaXDh3TipyTT5smtIuFWx9lpmr?=
 =?us-ascii?Q?IXfbX6tjvDhOR82NIiH35uzIU/hlgXi4CQn6hf7ptBuds3kO3hAFDgFYyYDL?=
 =?us-ascii?Q?jq7YFbBguk8EYyWAUk5X3a28uiuSKcEU2qUkFM8XhO1zN43cTag5q8Xcbu4O?=
 =?us-ascii?Q?wh0l5Dp36RFF7K1FLpgmYp3iQfcXvmtISWaCmb3EBGNdZE46EcU0qAXbWjo0?=
 =?us-ascii?Q?a/3unH8tObWFEyG2VREcv5/2ZdXW6GBE3J7eZdM2dfavewFvlc8VHgIO/A06?=
 =?us-ascii?Q?TjB64NR2e3Wuq78fbP0RRqM9f7bF+v4adoRAUyh5Zo8EhLKyYJdl9x1UficK?=
 =?us-ascii?Q?BnsHeZPzzm68uz5mCRew952JGmTYAx9fQ4hvwvdEzdBgn3HRhjOrzmB12SAY?=
 =?us-ascii?Q?y58PfZxS9UwQxINui7AzLG0EkuYWCB7S21AAf/1d0RQGHz/xY7o8AHVMRUPK?=
 =?us-ascii?Q?4vH0lSgbkNnSgykrAXLTbzQyEzap4L42SP1/ye0v/pEep/7sqwSSy3DUxnuA?=
 =?us-ascii?Q?jXmRrPeJNtkV85S2USMFBysNTtrf/La9udoAKX545glTtch6XIFMEBu+ZhdT?=
 =?us-ascii?Q?e7M2lRT2B40qFdBT4qM1lvj0SQyOsCQMzC20PXv64ns5jV50Chh1vo+S5R1z?=
 =?us-ascii?Q?P8NUL3Qo0HMRcsB8Hda1XxHcbcyCqErIHxzIES1oFt7xieG2K3JrgHXsSu/b?=
 =?us-ascii?Q?hg+EofGoHb6Nq8QJm6KKZBjGzfg8iA1hK2yJfFllwO6TqWhDYKWOgNwE8eow?=
 =?us-ascii?Q?Mw1GPVIkrwd0IJ40Fe77Gur7ABVP2nvjSEQFhOxxZYhYPLXhiaJbXukYVRI+?=
 =?us-ascii?Q?yKHqSWsCJAd4DuUTMgLKR9xpcBdESAD45RhpMTQyS2WoWut7lWaRCe+b4wdP?=
 =?us-ascii?Q?shVH/zY1hkUd8kYy0+xzXW2u2pkl/vvYkMKynzuvnMRtm3HYHbOeulRHWP9R?=
 =?us-ascii?Q?a5fk8m6yjEcXiV8q+O8mSQlNqDubxEZ2fKc56LsMxsSokrOOvAbLXXDDa1Ju?=
 =?us-ascii?Q?TVmATsmMR//S4duYfuF7DWVdQ/Fod7uf72ozEciT6xmA45E2ZrctnGSCAhre?=
 =?us-ascii?Q?01HjpwdcF8f8YFeK80rwi2++4smoVIp5Z73dtg4uMygwfWbg/oAzgV82DE2g?=
 =?us-ascii?Q?Oj50bXM+G/fYlqhUcfIEOHA1Aog3qTZFPRHGRZMn8Wzb9DeZrHzU6r03DcIk?=
 =?us-ascii?Q?OxmqOHsBuxp9i4yx3ra32vWidevhakDZYDWSB2YrHmix7wuaYLlDAhk6KwHJ?=
 =?us-ascii?Q?l/LotWBXpkYBVU5UbD/x0tTy6CQAgiCxbemzYR4eLkVeRFDKMevtDJddIUPL?=
 =?us-ascii?Q?3MGupRV+9FafiUf0d2oyDSq4rpYEhPqfkShjvoNHyew4c54eoTebpKpwrSWj?=
 =?us-ascii?Q?RRrjcNmpriKNPKq+0yiato6BFPCteN38btHKMlurtmYHW7IfhJKHaNdjLzDi?=
 =?us-ascii?Q?RKTIfHZ9jZo0dwO9jBHJBuS93tS8fE8FgDX6CrUtGjiXyTyI1oR6b4OtZsCo?=
 =?us-ascii?Q?FKyUZcAhjuIqWz2h1n/l+wMBjhnRlw1VPEJXkaDu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3134174-74ea-4c25-a920-08dbcf83c204
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 02:41:40.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+Wm+yJmNB54pRwykR/FCXZW24ga+HSl0amVSyNOwK2ER+IwgUxnDL1GcC/VQOw730AuLRZKI3yi3b8EZGD+Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4843
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ira Weiny wrote:
> 

[snip]

> ---
> RFC comments:
> I'm still not sure if the 'CXL Component Event Log' portion of the CPER
> record includes the UUID from the CXL Common Event Record Format.
> 
> The 2.10 version of the UEFI spec says:
> 
> "For the CXL Component Event Log: Refer to the Common Event Record field
> (Offset 16) of the Events Record Format for each CXL component."
> 
> This implies that the first 16 bytes (the UUID) is not included.  It
> would be nice if the UUID were included there as a copy of what would
> normally be in the CXL event log.  If so the Section Type GUID could be
> used solely to match for a CXL record and ignored in the CXL code.
> 
> For now convert the GUID to UUID and pass to the notifier users.

Smita,

Dan and I were discussing the processing of these GUIDs vs the UUIDs offline.

> 
> Smita, Another idea I had was to add your cper_print_comp_event()
> function to the dump here to capture that CPER specific data in the EFI
> log.
> ---
>  drivers/firmware/efi/cper.c     | 16 ++++++++++++++
>  drivers/firmware/efi/cper_cxl.c | 39 ++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper_cxl.h | 29 ++++++++++++++++++++++++
>  include/linux/efi.h             | 49 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 133 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 35c37f667781..af2c59f5e21d 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -607,6 +607,22 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>  			cper_print_prot_err(newpfx, prot_err);
>  		else
>  			goto err_section_too_small;
> +	} else if (guid_equal(sec_type, &gen_media_event_guid) ||
> +		   guid_equal(sec_type, &dram_event_guid) ||
> +		   guid_equal(sec_type, &mem_mod_event_guid)) {
> +		struct cper_cxl_event_rec *rec = acpi_hest_get_payload(gdata);
> +

Here we could separate out the comparisons and use a token for the event types
rather than passing the guid through to be converted into a uuid...

> +		printk("%ssection type: CXL Event\n", newpfx);
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
> index a55771b99a97..9b1a64ed542e 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -187,3 +187,42 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>  			       sizeof(cxl_ras->header_log), 0);
>  	}
>  }
> +
> +/* CXL CPER notifier chain */
> +static BLOCKING_NOTIFIER_HEAD(cxl_cper_chain_head);
> +
> +void cper_post_cxl_event(const char *pfx, guid_t *guid, struct cper_cxl_event_rec *rec)
> +{
> +	struct cxl_cper_notifier_data nd = {
> +		.rec = rec,
> +	};
> +	char guid_str[UUID_STRING_LEN + 1]; /* + trailing NULL */
> +
> +	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> +		pr_err(FW_WARN "cxl event no Compoent Event Log present\n");
> +		return;
> +	}
> +
> +	snprintf(guid_str, UUID_STRING_LEN + 1, "%pU", guid);
> +	if (uuid_parse(guid_str, &nd.uuid))
> +		pr_err(FW_WARN "cxl event uuid conversion failed\n");

Thus this conversion is unnecessary.

> +
> +	pr_info("%s cxl event guid %pU, uuid %pU\n", pfx, guid, &nd.uuid);
> +
> +	if (blocking_notifier_call_chain(&cxl_cper_chain_head, 0, (void *)&nd)
> +			== NOTIFY_BAD)
> +		pr_err(FW_WARN "cxl event notifier chain failed\n");
> +}
> +

But this will mean that the trace events will have no uuid printed (probably
not a big deal as the trace point itself has that information).

(This would change the 2nd patch as it would no longer be getting a uuid.)

Thoughts?

Ira


[snip]
