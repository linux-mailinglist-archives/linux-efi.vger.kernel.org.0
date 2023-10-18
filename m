Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9647CD263
	for <lists+linux-efi@lfdr.de>; Wed, 18 Oct 2023 04:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjJRCiU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 22:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJRCiT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 22:38:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB06AB;
        Tue, 17 Oct 2023 19:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697596697; x=1729132697;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A4rJ9TYXiYQDEbx69bAd+y3iKXWYMrS9RbSGP9Dh2Rs=;
  b=OpoeCk0+031K8j62hhjxWyP35vlRRb2W4NvWeH5Fmpyn9cMmFsl0ifhB
   gRnO15hykwB1f/cCsX8loQM/9K0mdrhwQZMD1USBIMpKp6fQA6rSDUKlV
   QvpiV2LLftNqDcPPW1NUskNmayA5A9UwTURMPM5wWekm5CelE4vEgJTd8
   WGcFQBLPt2/9PIF15YDIGUA6gcO/QRAQdKYOPLL8o5Lg56ZN2uVv0zF4O
   4EJM+4aEhKiBKvyL8AjVoZWJSweKskGDDrdHl6gDg8SRsci7Kes5jdsLa
   zsS4oe9QBr7/BIEB++4waeNi6pd/QXiPZ+HEd1Lmu+QOkF55F9pmKhCm6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383145220"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="383145220"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 19:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822243301"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="822243301"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 19:38:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 19:38:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 19:38:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 19:38:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 19:38:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgoyXaRKcKVwis0U0N4NDHE4qW0HHf7ddk4ZF8YKg9qZnCFrCaebaLrXrNhcqs8zXe0i7fUWQ/Nk6KRIw3bTlvlMkPuzcS3SqWXaKEOyGMndiORArzmk4mEJQ23k3lI7HvXIz+GbP2EwEP76V4R6B+tsPKFKNOSy+zxXRDq94dbZZpCX36Z7wSF0ZMwVK1FdpKEkrlwTdqzMPgy24tDbhNGO0KsPuMRRKfq50+zk0uAkJGtkcuohrR3UEg6ZFqA6XX5wo8F/vm+X3NKIkvmIxtoRGcFi7m4uHqSQXE5dI35YvbuNA32PPlN4MZGd30iFh4+8Dj9QzlTso7X8sYQz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5H9TP7A4hqHifznvJNJNyTVWPEC7ViAXt7IM6FFcik=;
 b=iiK2x2vEVu4/lK1p6K4qPojyEw3nKfPS/6exFeU17WNil5xGoKaNDMezjWrj5zcHmwvI5WT3vnNX50LnJWJZuT+/nykbP7nUrU+6WU9K7Hgkkwb7u3HhGZ49TXhAj3aq1OWhDRDPQ0gwscDEuMYxvHsJNnD7rJwrD/DkdAGhZeozzl5+3Xl6cNSIKNDs9rsUq8BLMC/I7ngtKWNxQEOUKpv9ypactoQBm2EY7T1T4gevqTfxx1M+sY6jKS5yE4dj9Go6TeptxIHIqXTCBwb5uquzH6TRMCiei7LiveMjWLHJsWWfDAKQUo6QnWD90tBKj1LFXEDbMtXYxHNli3qTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB4843.namprd11.prod.outlook.com (2603:10b6:806:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 02:37:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67%5]) with mapi id 15.20.6863.046; Wed, 18 Oct 2023
 02:37:59 +0000
Date:   Tue, 17 Oct 2023 19:37:57 -0700
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
Message-ID: <652f4505231c7_2bb07d29483@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v1-0-99ba43f8f770@intel.com>
 <20230601-cxl-cper-v1-1-99ba43f8f770@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601-cxl-cper-v1-1-99ba43f8f770@intel.com>
X-ClientProxiedBy: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: 384ef02d-e5cb-4676-2f16-08dbcf833e1f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7qaHCt8RQPK5H1IPnkyCx9PCRw7R9H//62Y4CACTh5DDo4WhCOVP2VdmXs/PyUNYSQc7X7IRANPhbaY6q+QhcEq01vYm/UQLd7s/aTwlJ24DS2ZgDGY/jeHaaqH2qM6HVyl2XSaL2IDRCgWqE1u4iC8u5rDBHmzZ+GZtxQn6W0LUX0scFlZBFiTb6QuI3ireoVedEIMdb18Q01QJCMd3YClKnJZ9qhpKRXONxRJF6/2XCw0T9v3wv5LXC7mDf2Pr5snA7N8vgfBWALKxxKFOgmfrJpL+ZU2N0B0Zmf6xB4KNT36iDwJG7V4Ksymw1DcAbshB8dZfQQWbNxY+sLwKA6Clj7ecBlJkhi2rPjh8E/3vkzGGAAuD2qo1t/BgwcT2ypXkB44bPUaWyhMLrc7y7igWxJkpr+yorIxPCaTKe+PsVN6JDJjnRTxHOgIWLjTUTIHp53qh0B4ajfPX7feMXniQDA5LLylaTT6aVdvxOazabx3HJ+zAZXwMwfSiU/jCvea2pQCNmU7mnsr2SGKXAlC2PEUJE0Q8KFkN4AOLaDHeoboABm4Pndx+fKovlGg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(54906003)(316002)(66476007)(110136005)(86362001)(66946007)(66556008)(44832011)(5660300002)(82960400001)(41300700001)(2906002)(38100700002)(8936002)(4326008)(8676002)(6512007)(26005)(9686003)(107886003)(6506007)(83380400001)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NrCJDYmXOLF8mtuzTOZAg9SKYiCiEzpU1WerTAYxmjLBQJfo/SjaNVFYwW9L?=
 =?us-ascii?Q?e1DRUz/4DM4u4IB6PoinpTPUA0owiI7DRA7iIpS2PyqI6Jg35Hg8z83Yi3Xv?=
 =?us-ascii?Q?Gfcz1BmnhIJG8V1aqdXO3gI692CSgqYN5SUiSr8DoCR9m+EHYhfdI07hT5ez?=
 =?us-ascii?Q?I84rAwYL4dwrvmm8htW/SgzYG3FclJGWjJiY5poxr6y5u9KEf8HVR5OqS8Yw?=
 =?us-ascii?Q?dNuXmt36iyUljMXJka8c1wYDMtgPDWhAfOIUA+Rb+e8MTGnHHj2GFpfXhK0W?=
 =?us-ascii?Q?szbmN3dy4PMIqUC9OXyWvj+Bqft/L5YrtItfABMyVaWw+yj4bxA8UcAgDmbn?=
 =?us-ascii?Q?wX6su/31Bm6+A/f1duT7tTXV9ctu2TP3uk12NFtaeG/usyf/3Qd+SmHBYdkx?=
 =?us-ascii?Q?g+EZ/xWP1plTK/rNpi+CoAEhqh7/CK/nvNGjRWQqSF4E5wDeEPxqljJ/ZETS?=
 =?us-ascii?Q?yuBwpQrkGlG84aZTxa2b/uNan/y09SiLk++lX/hkk15gVmiQZWeUbxBbxF/A?=
 =?us-ascii?Q?YbUBZJQCupQpzTj6mjLWXKAkhqtyDnMp7fccHywwPvaHDzPRIUdYql6R+8dO?=
 =?us-ascii?Q?7mw5hhXp5zh0hauzQqEkCFtyu9cPpmEKFcOZIzAIsynOYDcXxZrgi0qX82J8?=
 =?us-ascii?Q?zlocEFii5SvSjDXN2W7UWK4tSRIK9LqsqIHH9UagIcFKG7UD1YVQQsii2s1r?=
 =?us-ascii?Q?iRG2/2awlCYCEs01+tQ155NrwPgk9d7eJ0Z3fbRt+AG7eV+QW+h1mGBiLfZG?=
 =?us-ascii?Q?Nk7SYerUwUpMlsLIom2TpPewkBM4QqVWWtsmj5SWBaBbE68JHanX58PI+Bvy?=
 =?us-ascii?Q?3qFcAiZVa6j1zyCqf3C7yu+PrSRF79VJB4tWGL54KMiexs+fyGZN9qFG+osk?=
 =?us-ascii?Q?BefF2/pituDSBksUx11xVLVstLTylISRv/CdkIUr65dxME7DZDuLGgKUBALD?=
 =?us-ascii?Q?Qey1DA340SIufFgqmXBN5Ks+q2W/QLWhYxjV0RAvkwFpyYLpU8lJtXuXFWCd?=
 =?us-ascii?Q?4MfK7tnr6EYnoIHPHyKI+H1TH6x40JB8wBq/kTFP5RX4d+K+H6rnivhNPpzL?=
 =?us-ascii?Q?ODKqLEpK6q6wtrkB+RPKHp13hF7tizwXC5DcYn3L7QTJW5dMlAsHaTIpFko9?=
 =?us-ascii?Q?fVXIL7aStCY2aHAvQ3iDBgk59gZBf3an8VOhhLaBldz82hqBoRXf1asM5eck?=
 =?us-ascii?Q?VOiEtUVoV4cO91WVJbRDrRSKbqDsdSR+7kigQmwTNlNX5zoB5QWZz5euyj+z?=
 =?us-ascii?Q?3ie0ta8YDPBxSyIVjlzsjgwgtlDycaI3Kg9FQD3rYEikLTYzwl3gpjViHwyK?=
 =?us-ascii?Q?RMJRA7S4p4GW4+qGEBwj61TPHHidNd0iSjx7RYBfNpWe3AJULzVI+4XT17aU?=
 =?us-ascii?Q?x31ICwCE6abVnuuaMb1dbn9p1IXXJ26g/wXGzyeBL8C3YXqTuzYq4MKh/Ycg?=
 =?us-ascii?Q?XEkny/BvJOoJIOEFOPa/505FaygOsbZF1JNNpRGz9LkjtifohcGkK3sbcyuw?=
 =?us-ascii?Q?71u/1hZQ3KL6tPHBwq4XVoAJphSs9oJPJaEYxYSR186B4Dop14Moul13BJht?=
 =?us-ascii?Q?+lzJMP201R8aWOCaz+mOZwOTXIUBMCdtT3/sHu74?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 384ef02d-e5cb-4676-2f16-08dbcf833e1f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 02:37:59.4301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3pSO9oajPBo2sr9vnfPxQVEjDpoE/+G7tGW9EORuC7sAXOtNdq7QVzBrRqRcZ381NCdQ+WmS2H64TmC9t8QTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4843
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ira Weiny wrote:
> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then send
> these events to the OS via UEFI.
> 
> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The only difference is the UUID is
> passed via the Section Type as a GUID and not included as part of the
> record data.
> 
> Add EFI support to detect CXL CPER records and call a notifier chain
> with the record data blobs.
> 
> Note that the format of a GUID and UUID are not the same.  Therefore the
> Section Type GUID must be converted to a UUID prior to being used by the
> CXL code.  Make that conversion and send it along to those registered.
> 
> Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
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

Smita,

Dan and I were discussing the processing of these GUIDs vs the UUIDs in the
trace prints offline.

Here we could separate out the comparisons and use a token for the events
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

> +
> +	pr_info("%s cxl event guid %pU, uuid %pU\n", pfx, guid, &nd.uuid);
> +
> +	if (blocking_notifier_call_chain(&cxl_cper_chain_head, 0, (void *)&nd)
> +			== NOTIFY_BAD)
> +		pr_err(FW_WARN "cxl event notifier chain failed\n");
> +}
> +
