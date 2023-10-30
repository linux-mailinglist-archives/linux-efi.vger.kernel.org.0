Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFA37DC23A
	for <lists+linux-efi@lfdr.de>; Mon, 30 Oct 2023 23:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjJ3WC0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Oct 2023 18:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjJ3WCY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Oct 2023 18:02:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AA9FA;
        Mon, 30 Oct 2023 15:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698703342; x=1730239342;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gGmju2xtUvUYjNeT5s/igY7vWoMAz2AP97sPHkXg3X4=;
  b=XMHh8MMHAaxT2IJkN/tG9jfNFSJKsdrOmx7/72qHWcveVDezGrhA7JTz
   OiOgxwC6j88I2XjWABkdV78ZZQ7jlxuhg8HK7t5vscRbJuJiVeQ1tNZca
   1x9E17TQ3QsqhwIev1hUfDm+Pfnb5caGZvdYpqk28W0ehQ477EJmToTj9
   xVcVtJUuZZhb65WoJJaFp5+xL/bkdP0LWtYtFELb+hWpSjK6nHzLrL0Sk
   cJbFEj3mepJmmS24MFIZ4GTkDnGh1qGAI5ETgMM/k96EJKI6qdjsMPuwX
   caCSEHq06aSIX9nnsbzXi999CDURExBsaED+8x44JLPVbduJX0mQ6Q7WH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="378557898"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="378557898"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 15:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="933913722"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="933913722"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 15:02:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 15:02:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 15:02:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 15:02:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 15:02:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOrjXXEq2q2o4FFvVogtm/dlxTaYJQbC5qtoqqm3r2AdEfAROrmeQqBFZRaCaPXXB4L0gn/CqM4hktWnVx+ddFDhAHOV1JJNfyYmo5rNpruqBSA0F+Yzwya3koSXV2jCN95hL9skiBKHkTuY0vnqKA0cfdshJ4KNAbn6XLbJ6HUjsNbnJg+eVW/bk3J73+cBgKeGulqEIG3AgA6d6NY4SDStJr1+ZZlvSOWFDE4SmeViKN7q7OPZ7gKle7/Z0ODV0KuvaMrEAQnDEUX9VGrxDJYvN3bwqGS7L2qiRehV3oZcuk5Q5jAwBikWoHJpPQPTFH6dC+eNZf6XHrbgoOwRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCwkCZOEGcl+ZjgeKrDObx74zkVwWun6pIUoZPS7Cbw=;
 b=hes3Ur+Cr6po4CkHDp+dEDEIUL6as5eLhICShXWgAFXUatVsohLkUaQ09GT3HVXcVl11BXgvQMW9pmqP3qG8e/ycSaT31xloKACQtcgzxCQy08AypmJ99EXHfkOXGSE5TtvzckNxHFaHiSsYUV+YY0lNBr0bVaN9SecJAIHlHpkjuLiPkSfG2aF8fF1L4Sau5Sgs7xh0F0j1gbADdBWBlfgWFGr98/kIkZWbrBIKWz3IPkOK0yom2mpQZyAD60a0yCscf8HBSdLn6UswB3c6H8zP4YAW9UXQv2F2pvQhIQvABAkmvpS3/k0dI5meQVV4Pc9EG72BuDEPPXWKmyF5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8461.namprd11.prod.outlook.com (2603:10b6:408:1e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 22:02:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 22:02:18 +0000
Date:   Mon, 30 Oct 2023 15:02:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC v2 3/3] cxl/memdev: Register for and process CPER
 events
Message-ID: <654027e6562a8_3f60294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
 <20230601-cxl-cper-v2-3-314d9c36ab02@intel.com>
 <81b90308-fdb1-3686-33a3-1e7ec42a7ef8@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <81b90308-fdb1-3686-33a3-1e7ec42a7ef8@amd.com>
X-ClientProxiedBy: MWH0EPF00056D02.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:f) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: f9035317-66e8-41fc-82d9-08dbd993e232
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9lY40LD6zr070zDaTkhvNFfxXLHjmBJ2Q+9Nbut4/gFyy7SP0+KDLU/JsIQzFqnE++TZTC3rl1l80UGctMxjBVsjW5Tks3I38HHROLOoaqAFHXxpqgkGOuqI7elbT61UAV5WLj6r/VYn+lo11K5h1K8cjzdebZt4wnqgn0uoN2BCX0RaYQblsAC/qTvTr0DDWZMmVlxqoqTHomcECC5E99LLjTLltV1atCjkEeX1M1x++BSpVLGL0m4Hg151SdNQ+O/PnKDSYIpTOXSV2RDGHh8yTOAXQr0iJtVoW6axMRIgE2UY24oAuM8wIeVBvdIJE4dK3ficD5DqZNbrh3GDkCkhiGd5uAZzvrLgOK32q9cP0Qclw0V+38nlbSFobj7I2senQkcD40B2I089pKDiYQIC/hr3XrS1vB8Ddrm/AHGQAU8VPHQnX7xuMSeOF8RhU7v4d3YeE6XzarvjUDbAoatxNVawkxfcAF5DatCUmrk+hLT1UP0OaqdAiUPWC6k3Vlsi8nlIyCclkMb8sep1zbg8+J3I0pCUJvlN04gekzw7TNZyM397VNPOIKuPQIf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(38100700002)(5660300002)(82960400001)(86362001)(26005)(83380400001)(6506007)(6666004)(9686003)(478600001)(6512007)(6486002)(2906002)(66946007)(66556008)(66476007)(110136005)(41300700001)(8676002)(54906003)(316002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AH+r4yIJHvgokT0iR2T+/jf20gHaeWlEPh3mOXxMVtvOijNCBzuqXSm/kHNt?=
 =?us-ascii?Q?fxVYtydJBo74ZWzEdC552fmY5SAPGlSgm7dVe7Xoed67Sz5PfkgEkw9vl4zl?=
 =?us-ascii?Q?onSNYS/8UJZcB2Alzu/qNbUOvDa++frU9Cb59/gdawjwdKo0ns8Zq9rD6h0I?=
 =?us-ascii?Q?iFIrTBlq7m8rvZfp6OheDOoC8HkLQ12LAGxCrHmSxqO7MJBPOAB1kfnOxFuT?=
 =?us-ascii?Q?5l/LIld8AEb+DPu1VePU8Fp1z4j21xbS+vkymD1FnhA0MuspMWyL49q5hKcN?=
 =?us-ascii?Q?/d5vtk3d2eCIw0s7VIaF21Oh7RTueVtAagB2u2uYM92loBuQfSOtJ2N1FabL?=
 =?us-ascii?Q?QeVtxc0Rn01PDad9pneWu0cCvCYlir1bRNTpphnqMpR0ug3K3X1+wcY17oDe?=
 =?us-ascii?Q?3d0eh3URKnLFR/BVcsoatEmNCh7LcahdKGVrzOR4IphY20LbdcA8T9kRoAsS?=
 =?us-ascii?Q?t9fV6LYZ9UCLGdRJqPLW9hnojHi6uWw2gC+ds7tTseqsntR5BYHLJAwhV90W?=
 =?us-ascii?Q?9ThQJEVTNx+gRoRrPtjv+rLcFDhhQHkkUqIiQdsYDUEGIB6AQvFW08Y3Cuep?=
 =?us-ascii?Q?zHFvBK0AMQpiAIrlAAK1DEqakgZqMd8guEmF7S1xB4zBhZHSrxaDoARoKlhD?=
 =?us-ascii?Q?uISLVuPtCPkpKoRjrdbLb2KBjdvSnNijcOECLHccprr9E+vmEeM4kpJuLs+g?=
 =?us-ascii?Q?CcaGAX+0E87G9Z+DWxO4CeWD7M1o6G8V5zqwbayY5tqcNpBJI/BHS35qBqRI?=
 =?us-ascii?Q?W4pJUZLKkif97ZJnXt9I+VjlcKX35tYMJUSrPmhk56hmEaYjd4cSiZRVW2Qg?=
 =?us-ascii?Q?/I0wTjcXpLDTQ3Y2P+1c885I81D+vcE9s59VxB4H+UP6orHZnID/a3kPm+Xw?=
 =?us-ascii?Q?eC28yJIw37t/K5VcvyOXYEGKHrmrIs/r0dE5BeJ1CiRT1Ka4un+babAjELRq?=
 =?us-ascii?Q?/OexlNvlD4LGfXAFmuBJWjUAAY/hVCS9K+UxN0GFz0yTwOy8TJNYGdlHLXK6?=
 =?us-ascii?Q?+5QnW0dWZrGtlh5jWdniio2+3NLAC/qHOP+1gomfI+k+tp0V/oAI9mdNjFsS?=
 =?us-ascii?Q?NB/hEB81fTvMFXpNnbLhITW+5tGiwYPIjfKT1s924hopgedlsPqyA8Js0fZY?=
 =?us-ascii?Q?TGzB98mfE6I0CnDiAVIiI4eBbPXFmlu7EATJJOxOctJZeZ7b0pDU/IPgGLCR?=
 =?us-ascii?Q?nPCVU5Td1xyCRIvA5158xrraj51eGJB812/MAEOuTc9fqVdGG1uZgKxZ0n0x?=
 =?us-ascii?Q?afk9IrlZb9CatNYHZZ6O98nQCdF4lMvkxxpsZynUHA+JINdSrR61I3sOq5iQ?=
 =?us-ascii?Q?mtnqk4kBBrX8OQaQeP/gBQFdadPiOZ7XSh8SF8D+HASkY2nJ41IBlfjhmA5j?=
 =?us-ascii?Q?/PDztOGuod4Rf6COmlbco8IGlYhFaTBVWiOoRxsbAUOPI6HoWw3VBwlymQfV?=
 =?us-ascii?Q?SLWTGM0bPfGIyWI8RrU8fzfiUuM4cSWzu4i6drFTtXeKpjsPzXpk0JzRrJ41?=
 =?us-ascii?Q?bjtDmuN9dvxyGQa/0by3X5Vbx9aeyAKcMHcn7Kq0Zbt6vV/YsGf5UPTMzGNH?=
 =?us-ascii?Q?UrTErYpfYcxC2NFJ6bH+wDn1wIvFqfgXvYAGsKESEY/C0EBEw6PSEha3SqQS?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9035317-66e8-41fc-82d9-08dbd993e232
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 22:02:18.2623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5gw2Jtce3QDeom82vtY8vNQBDuiPkhpdm7ILEPuSx5oAjzN5bkwzFlyiHh2fUCI9Rplt1mJl0lOTJ003T0J9+36K+Wb/pGneFDp0nk4RIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8461
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Smita Koralahalli wrote:
[..]
> > +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> > +int cxl_cper_event_call(struct notifier_block *nb, unsigned long action, void *data)
> > +{
> > +	struct cxl_cper_notifier_data *nd = data;
> > +	struct cxl_event_record_raw record = (struct cxl_event_record_raw) {
> > +		.hdr.id = UUID_INIT(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
> > +	};
> > +	enum cxl_event_log_type log_type;
> > +	struct cxl_memdev_state *mds;
> > +	u32 hdr_flags;
> > +
> > +	mds = container_of(nb, struct cxl_memdev_state, cxl_cper_nb);
> > +
> > +	/* Need serial number for device identification */
> > +	if (!(nd->rec->hdr.validation_bits & CPER_CXL_DEVICE_SN_VALID))
> > +		return NOTIFY_DONE;
> 
> For all the event records that I tested so far, this has never been 
> true. That is CPER_CXL_DEVICE_SN_VALID is never set which might not log 
> the records at all. Should we be bit more lenient here and include 
> validating device_id (bdf) instead and check if cxlds exist?

Agree. While I do think those devices are out of spec given CXL mandates
a valid serial number, I think the robustness priciple applies and Linux
should rely on bdf information. I also expect that with MH-SLDs and
potentially other scenarios, a serial number may be duplicated so bdf is
more reliable in that dimension as well.

> > +	/* FIXME endianess and bytes of serial number need verification */
> > +	/* FIXME Should other values be checked? */
> > +	if (memcmp(&mds->cxlds.serial, &nd->rec->hdr.dev_serial_num,
> > +		   sizeof(mds->cxlds.serial)))
> > +		return NOTIFY_DONE;
> > +
> > +	/* ensure record can always handle the full CPER provided data */
> > +	BUILD_BUG_ON(sizeof(record) <
> > +		(CPER_CXL_COMP_EVENT_LOG_SIZE + sizeof(record.hdr.id)));
> > +
> > +	/*
> > +	 * UEFI v2.10 defines N.2.14 defines the CXL CPER record as not
> > +	 * including the uuid field.
> > +	 */
> > +	memcpy(&record.hdr.length, &nd->rec->comp_event_log,
> > +		CPER_CXL_REC_LEN(nd->rec));
> 
> I'm doubtful this will do the job. I think we should copy into each 
> field of struct cxl_event_record_hdr individually starting from length 
> by pointer arithmetic (which is definitely bad, but I cannot think of a 
> better way to do this) and then do memcpy for data field in struct 
> cxl_event_record_raw..
> 
> Any other suggestions would be helpful as well.
> 
> I can make these changes and validate it on my end if that works..?

It sounds like you have a more readily available real world test
environment for this, so that sounds good to me.
