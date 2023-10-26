Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F33B7D89F6
	for <lists+linux-efi@lfdr.de>; Thu, 26 Oct 2023 23:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjJZVDC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Oct 2023 17:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZVDB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Oct 2023 17:03:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F051AB;
        Thu, 26 Oct 2023 14:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698354179; x=1729890179;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QIMUvNAMum0nONllAtxiog7Du+oQmlk8WBIIf2oKzxw=;
  b=iR4TDWM+YXbOKthZVduBe4alFXJEYlMyxDe2gVIjpiBF+CoEQ+KggyG+
   i6/WfMorau25ly0XzeP5D6CRnKxQ5s4O3c5d3aNz9UBwp9rOLZg8IQDlZ
   9DOwJ8EA8j70xJNbKndH2368CsrQV1K2mbAaTwkirYZk+lqA4vnLThO/T
   cxJPJ2DeKaHdrt+IAkPh/M1yPkX3uYU9LG4pLn9a+6ERDyryp8MaP+9Qp
   7N/kHm2qxudnDtry6/F1eYtt5RARvhZLfdxMkwXImlM2sZ+/qUM9Bis0V
   dmztk9mL6rqgoMyaAiLHemTH0YEJ8lEYqzDcy6FHz9NtFJgomw3r6nonF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="386536331"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="386536331"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 14:02:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="825117660"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="825117660"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 14:02:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 14:02:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 14:02:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 14:02:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifjBY/vzlAkEdYplF72x64SpUbgsUR5QMTgrmp0AsfqhosqpKoWSvEqe/ghTWXKQgGWcRqBM1a68VwZT4bqFf3pHyLdDSbNIZr7cllURxWDS96sJoYhL83UuvcLvnqby9KgCHS3VwhE2Aiwi28YUdB3UHRquZSd6ZosupQsSLa2MIUZOHYdxQ+3cw9KtSmw2B6oKKn9c4c2gmi2dm+di7LxEvemJPqjEn/sMRfaBRgakj11VMfTZSoWdO0fTP/pKMfGipO6pSEpuSV3oeggFZbuX11xl2IwO+1D/ZdkyIW74K3nC4pr9FUsO6/J050n1cRNTNhHpgkhFxcvYTqDn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNjlUmfIGiKKlo3MDuzclbs2mlnr4uHaAoKncMxu7PY=;
 b=lmXbtPuA0NhRbv4HJ9iko56C2qL3ed9sEAdcfNrNWgNeC8wyRC2HI8pJLRla+RCskEnvsnqqQQZeK+Bn9t8ZNjM3YuQPPtm2+t3wYwhzZDu3EMyWjxH7Tf9GSj6ZwWZF0syhE+bHnJfxI++pJzWGoJF7zukxn5DqbkvFbmZc+TZG06/OQzIsj53d06QqILUGpWuiWbHwwd4EEc+fiLiy2lRT+hsthEideUD6+sWOzTxR2qCZ2EdTEwyj9qX8kfsTPmCFqio0qxEkxV1nFMBKyQsGH82kYBTIli5PGVBnM++Hh8aQ1abIIrQPMRxU8kCfXU7q42NjDuauTHOAtZramw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7128.namprd11.prod.outlook.com (2603:10b6:303:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 21:02:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 21:02:52 +0000
Date:   Thu, 26 Oct 2023 14:02:49 -0700
From:   Dan Williams <dan.j.williams@intel.com>
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
Subject: RE: [PATCH RFC v2 2/3] firmware/efi: Process CXL Component Events
Message-ID: <653ad3f9d3711_780ef29495@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
 <20230601-cxl-cper-v2-2-314d9c36ab02@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601-cxl-cper-v2-2-314d9c36ab02@intel.com>
X-ClientProxiedBy: MW4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:303:6b::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 5116a7a8-0d5e-4b2c-657d-08dbd666eb17
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Vk8xczhwkVwMlfSq9X4hGtwa8CLj0w/nv/BExg+PPWbt+5FLfXzdE2/hpQbFKTdnSaBS2RqvZ0l0smgyny6jkJ4AjjAHmVB6S4BXL+aO90s7UHNNpkwV1ARxyNl0FlR4516sdhNd8tfZ3ymujSGgtUCA1d+LtFW9jcgwER+IYP6XVwM5B6vkmoqBWPqEGRGfnsJBMkjuDwCuNRcCfF9pnSE1ZmprlfOzLfEXfTIi0FgcF4WtN4axhXzKhAVSLQBi2xNf1NNwt4WZGCQB4GBi15u4BK03zGZ286e5QauCi9eGjmAFWr0I1ccAi7K4aZ+ObMQxAIErPECqhTrEcjgczyya11pcmPhguY1SSf+G4lvN+Nf3MjdxNP9QK1h0vbpBy6YaxqDgQDAGGLJpXwP8t1fy11vhaq++PKNNxXFS6NN7MHiGxnehOTkJl3iLBoJYfc8pcKMfkfxU/T8N6uwYdvUlNTz5y5MZ2sbWHmFxxhFRZx8THFcXSmHH7ZxKpgO3GadY5cmkJydMElIyaeAE4sFip6dBC1BSqGyJwDC53UrIvAK61gE9418POdj+xSa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(8676002)(6666004)(9686003)(4326008)(41300700001)(8936002)(2906002)(26005)(6506007)(107886003)(83380400001)(38100700002)(5660300002)(6512007)(110136005)(66556008)(86362001)(316002)(6486002)(54906003)(66946007)(478600001)(82960400001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1JQkcYhZw9PYKZE1jTCQnlixKj3/XM0U8UQ7XDGRp3OdctsRJLdYIo+n36fz?=
 =?us-ascii?Q?14DnS7Xs9KfysW5Vl2O1+heMjqlnikUIAjjML0U1iyV/41fIUSqwCyVM1tbd?=
 =?us-ascii?Q?gC5MbInie+mjn6CJWn4pI3cFUNUiVejX0B/k22KQDgI04CKPUKD7r1atGS3M?=
 =?us-ascii?Q?g8qu08SfyFhKHxxabrE1dVd5NwSOy5SaWkLqP74VCTlG6o7j2hYvp4Vrw+50?=
 =?us-ascii?Q?Pro2UkLC4qdz6+Bpb+hFH/fv8azcgBa4OP5WZsokieNtLfPeM71W/XmolS2J?=
 =?us-ascii?Q?VxhjBbhCsEwadsFY/gmsjv1NRnOgRdjo3jOdVYceDDp9/VtdN0FHWGdD0/X/?=
 =?us-ascii?Q?w3teHZf7AwovRazxwK8whsK3WFLsFG2JzQ7YM8cMdA4YhOZzTWH2B5JcvUz3?=
 =?us-ascii?Q?6h1l6mmqwRS/Nl8k65wZ14BqtDBNK7N3PhfzEDYry0etCVnrTGiWRNx2X3gf?=
 =?us-ascii?Q?/J3cFMCOKtf2zZJStSE3kVCqK1WFICbHRZ82PZhH6LSXPXFl+GuIqmtWfSwL?=
 =?us-ascii?Q?MdvCieWnrywq/oPbwTgnw6fmvEMTSztaNakniDhWmfQ1xxC2ovn9CnuNRZdg?=
 =?us-ascii?Q?fJ5KWMCngQND7xkDXbsGouzkwygni/IfQOdhLYRmEs+U4klUFSmdEPMJ1l4K?=
 =?us-ascii?Q?HPBHHK1FYkOBAa2DQZbkDPDcaXknPm59KmR8byCtQXIP25vEdkU61Wx6GSRa?=
 =?us-ascii?Q?frDr7wSGI690+sF45ceQP177fpVcetvbjAgPQ2KSXHiDS5rK7n14jjwAJhPt?=
 =?us-ascii?Q?MpWaP6EwKkVgC7b1Xw8dw95m11F4PH6yWB5DGspfIIZjZgZ2kFqFyPbCWZjw?=
 =?us-ascii?Q?DBN9IIbX1kCD+Qf2SY8r3QzGbwDJY3kDFZWzvC6n892iMbbJ+YnzvtQM42GM?=
 =?us-ascii?Q?S/KAPIwheq2tq9ZLAnt5Ghx6GLKMbmDhBR7phEPnvJu/eJI8FXzm7437DoBG?=
 =?us-ascii?Q?ZZPNdYFaPhxRO4sO6WRmjutvJIVK1DJYbBoP4uQu/YeM5C67DrN4onvJuTZT?=
 =?us-ascii?Q?VNOoCPAiIo4APmqDcOVzyegSKDBXcjrXGvxhfEIiKAAnwVrLaCTcIrZNIJD1?=
 =?us-ascii?Q?8kJ5BsJrvXO+QrHnh3GrcSy5eLOtMH7xcIHyFwdhpLIfYBDk6fihtKZFysJn?=
 =?us-ascii?Q?w1uslccKTNl/ZLDl3QHgshwRGKVWhaGKXko8jUuZFyX5CiXUNKs2Qkc+8blt?=
 =?us-ascii?Q?aDM76B4CkPmXRQ6scVx9gVJD7rVdqy6fKENWYwbssj3yzBkB1d4qTX06ByRG?=
 =?us-ascii?Q?W1bHFs+XUc/PoBOtut/jHbWpr4DyMBYNt/mDQxJ03Iee3bQmWQMviZg/Uf4x?=
 =?us-ascii?Q?DIuFgH4XBk9C1XIVG1BFMrBf450pve83cOsujVUDOYLW2yks25UeCXswQo2i?=
 =?us-ascii?Q?jVlAVGf+QeFVAIr7/b8+Za72gi77E7KdYZB8aDdU+YvEiA7aI+5u16jc+bQC?=
 =?us-ascii?Q?eCt0ItJAPWzPH20gqW+DdaOKjl9bRGIGRdv74YMOc3AUnupWq+azWmr/XeOc?=
 =?us-ascii?Q?JkkQWlXjCeh2azPuzGG18vm/owqtki2vWohg8qPBgmS7UVohmmdFjCJdyOx9?=
 =?us-ascii?Q?dUteoInxFzsTUlFPkVOR4CkSEirkUBikzDccmdVyrZu1kGGpQ1Nhky+vXmM4?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5116a7a8-0d5e-4b2c-657d-08dbd666eb17
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 21:02:52.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DfYUkf+UG7kgOdFd9avLGrEoeVNRoJx5SdT/qy9tMLV3WfooJ1CkbmHdc5QPtJPQ7Cy6oKOAzWgX382/SKD4C8twGchYmFjpeme/7blZvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7128
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
> Section Type GUID defines are duplicated from the CXL code.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from RFC v1
> [iweiny: use an enum for know record types and skip converting GUID to UUID]
> [iweiny: commit to the UUID not being part of the event record data]
> [iweiny: use defines for GUID definitions]
> ---
>  drivers/firmware/efi/cper.c     | 16 +++++++++++
>  drivers/firmware/efi/cper_cxl.c | 40 ++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper_cxl.h | 29 ++++++++++++++++++++
>  include/linux/efi.h             | 59 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 144 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 35c37f667781..d6415c94d584 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -607,6 +607,22 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>  			cper_print_prot_err(newpfx, prot_err);
>  		else
>  			goto err_section_too_small;
> +	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA) ||
> +		   guid_equal(sec_type, &CPER_SEC_CXL_DRAM) ||
> +		   guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE)) {
> +		struct cper_cxl_event_rec *rec = acpi_hest_get_payload(gdata);
> +
> +		printk("%ssection type: CXL Event\n", newpfx);

I would say that since this is going to be hanlded elsewhere the kernel
log can stay silent.

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
> index a55771b99a97..04234884898d 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -187,3 +187,43 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
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
> +		nd.cper_event = CXL_CPER_EVENT_GEN_MEDIA;
> +	else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM))
> +		nd.cper_event = CXL_CPER_EVENT_DRAM;
> +	else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE))
> +		nd.cper_event = CXL_CPER_EVENT_MEM_MODULE;
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
> +EXPORT_SYMBOL(register_cxl_cper_notifier);

I think this should be EXPORT_SYMBOL_NS_GPL(..., CXL) since I can't
imagine a third-party driver use case for this.

> +
> +void unregister_cxl_cper_notifier(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_unregister(&cxl_cper_chain_head, nb);
> +}
> +EXPORT_SYMBOL(unregister_cxl_cper_notifier);
> +
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> index 86bfcf7909ec..ca26126cd9b8 100644
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -10,11 +10,38 @@
>  #ifndef LINUX_CPER_CXL_H
>  #define LINUX_CPER_CXL_H
>  
> +#include <linux/efi.h>
> +
>  /* CXL Protocol Error Section */
>  #define CPER_SEC_CXL_PROT_ERR						\
>  	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
>  		  0x4B, 0x77, 0x10, 0x48)
>  
> +/* CXL Event record UUIDs are used as the section type */
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
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 80b21d1c6eaf..b5b8b46c8deb 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1355,4 +1355,63 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
>  
>  umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
>  
> +/*
> + * Event log size adjusted for CPER
> + *
> + * Base table from CXL r3.0 Table 8-42: (30h + 50h)
> + * For lack of UUID: - 10h
> + *
> + * (30h + 50h) - 10h = 70h
> + */
> +#define CPER_CXL_COMP_EVENT_LOG_SIZE 0x70
> +#define CPER_CXL_DEVICE_ID_VALID		BIT(0)
> +#define CPER_CXL_DEVICE_SN_VALID		BIT(1)
> +#define CPER_CXL_COMP_EVENT_LOG_VALID		BIT(2)
> +struct cper_cxl_event_rec {
> +	struct {
> +		u32 length;
> +		u64 validation_bits;
> +		struct {
> +			u16 vendor_id;
> +			u16 device_id;
> +			u8 func_num;
> +			u8 device_num;
> +			u8 bus_num;
> +			u16 segment_num;
> +			u16 slot_num; /* bits 2:0 reserved */
> +			u8 reserved;
> +		} device_id;
> +		struct {
> +			u32 lower_dw;
> +			u32 upper_dw;
> +		} dev_serial_num;
> +	} hdr;
> +
> +	u8 comp_event_log[CPER_CXL_COMP_EVENT_LOG_SIZE];

Rather than define CPER_CXL_COMP_EVENT_LOG_SIZE I would prefer that CXL
and EFI share a common struct definition for these common fields.

That would also remove the need for BUILD_BUG_ON() since they literally
can not disagree on the size in that case.

> +};
> +#define CPER_CXL_REC_LEN(rec) (rec->hdr.length - sizeof(rec->hdr))
> +
> +enum cxl_cper_event {
> +	CXL_CPER_EVENT_GEN_MEDIA,
> +	CXL_CPER_EVENT_DRAM,
> +	CXL_CPER_EVENT_MEM_MODULE,
> +};

It follows from defining that common data structure above that this enum
would be a generic CXL namespace that drops "_CPER_". I.e. the CPER
notification handler and the native driver translate the event to this
common generic sub-structure that gets emitted.

> +
> +struct cxl_cper_notifier_data {
> +	enum cxl_cper_event cper_event;
> +	struct cper_cxl_event_rec *rec;
> +};
> +
> +#ifdef CONFIG_EFI
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
>  #endif /* _LINUX_EFI_H */
> 
> -- 
> 2.41.0
> 


