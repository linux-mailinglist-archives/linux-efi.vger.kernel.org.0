Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E6E7C7AD3
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 02:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjJMAZW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Oct 2023 20:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjJMAZV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Oct 2023 20:25:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E168B7;
        Thu, 12 Oct 2023 17:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697156720; x=1728692720;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dBlmOBk1C5tVy4C8K6RZ7qCFDHwMsOU4Ol9hFcf5LHA=;
  b=eaK2hLFRYuOLX65Lr612VmN4huxLHjhe6MR7HRhkwgvuS1dAzN3pnc4u
   9fshJI/LPdkXTs1nNm4b91REp8X85HIOAfLCtbQGx1Up6XFaj8ocKcmyl
   4qUhKm/AngpnyNHMgOLv1RqF9VPJLGSJ5vHLzzz3n1iz14L1tyeybgCtt
   CiqIow6wr/D9MbPNB9bHpEnhvmorQa0sMnzLq0p9w0a5H6DUQlo9hc1qr
   Y5p0/ccvQJG8z5ukuOgYbWu/ETgM3AEwnOFchVpDjQuPbUwynONJk0Ff0
   uu4ILAd1ozJLTEQgTkg3nsB1e7JfOJuSDYk1IrUDPt0FHzSJ1b813dcWD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="370142944"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="370142944"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 17:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="758268476"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="758268476"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 17:25:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 17:25:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 17:25:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 17:25:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 17:25:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNqAZcTiqLB7p20cyy7sav6saE1DzxhPGdGWgtwrAZv47q5/iQtROvtR6NhiBVYfU/uzq++5f5JWZArGLK8EBH5mFZvAhM+7h+kIKbw1ukQy/+YyE3fkb1+HrZarQxJlY2iFmizL90N3ngSW4BPmqHEicxTusDFxfKxY1iFq0GeVkIxAFClQGHn86Og1O0ab0qOmg9lGnbHN0Mjnv8xKaknwJlkPYyOaKDcwWwiS74VMy7o6udZNrHUVT/wnruGT44V2DiU1ubcWTXd08w8GrOhepefdGV627h3GYspzSi77e8Uxglg07EVT9Yj74F38r3GitQi/yxz2i9sswqUHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYlmkEGFO7NwBGK9kunjKWEXGBmZTb4h2Bai1LrzmPw=;
 b=YLcpgGOW7i1fNmSRhh0+G7nz7xYQWtg5AyGj9ASUi13E9r5njCl2BTdEmy1b204MwjfL9AX19MRHOlPEzUntw/B7uPSEpmDxL+4ZCTSQZJRehYKL71k5Si4n6/V+Ivk9y0k6O9lBADbOP/mQ7VqEaYV7GnRwU3kQmWO/aPbZAXBfUH/fYbLG2Azt3yG6RUA7hq6OC9l1a3V4BCNj/S1UqIbSmm+JAfUK1PaXGkLELw/hoY8ubo4tgeSI+5+7lVj5oBsCWWhZ/eOXIacZEjybijk19aNo3ZAETWE4UT/ILfaxy3qAlZ6Gdo+9lTKP15XTw6ADSbE3wxFR/iKltFRSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB7280.namprd11.prod.outlook.com (2603:10b6:8:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 00:25:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67%5]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 00:25:16 +0000
Date:   Thu, 12 Oct 2023 17:25:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <linux-efi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH 1/3] efi/cper, cxl: Decode CXL Component Events General
 Media Event Record
Message-ID: <65288e68de994_2347eb294c2@iweiny-mobl.notmuch>
References: <20231012230301.58500-1-Smita.KoralahalliChannabasappa@amd.com>
 <20231012230301.58500-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231012230301.58500-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4d2e6a-c2aa-4347-cdc8-08dbcb82dfad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uu7hdXQc1f6ZVTd39U2qLGK0KuURTp09XGYH9pF4y7R/OlOVDXMaK365aQilAqj15xTMLB9R4ZjD/5CRzcJD6va0mPZXbyJHQVasJYo366TsqiZxffK9v1d3cvD2TbvKkjoqzNnBIZn/EnusIU/yGGUyTXe11c3S6FTXXFwi/rar1qgHpmR6/L2jOlOdTbHzlqovIZGKgXmur++cKVRRwvZzMOAOx63B9s7/cUlCDe1xXmv3lIFM7pSu3DkvRtrHR6SIlTDFHHXIU1EjZDTdQVFDqCaUE3eVOcCpCvEknHCk2TEcq2euMyEajOyHMNZTt/xLsq9yMNtcsUmlbBn8kLHvwLIZOQhuwJrrxsy66g9P8XELHI046n4jshtaClR6dCahoHK8Dg+CcIefl2qhj935PgbYAky4T/WBbWGdzk2iljoWFyrk6wxyPB4cGVrJC4a03LSkp/Re+HAFautv08gF2S/KowERtWSCz+5Q9qREOeyjrAZaoSHO4rGsHs31NoU4Dyi1C7BYAIK14GohgFbmDKPdQ6e5/oJQLhkM1Z2PtOafrQ1NiXXlCdHgYUTH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6486002)(478600001)(6666004)(66556008)(66476007)(54906003)(316002)(66946007)(8936002)(82960400001)(2906002)(8676002)(41300700001)(5660300002)(38100700002)(4326008)(86362001)(44832011)(26005)(9686003)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N6c2XdmkPBWlS7VAbvr1jgqmxzx2MWOeJyKMQfSPXzcEe4pNWWpn3Nr8iat7?=
 =?us-ascii?Q?NrlrAmSeuPwenO2rQ8ZTlxo6JViErStcn3i48VdQhxFgxbK+/Be/8Bi6JiEZ?=
 =?us-ascii?Q?2RQNothS34BhpjtU/BnLuXFpJoBhV70OBYQBuAFJqCCfyvSLxLzIZyCHbLks?=
 =?us-ascii?Q?Q7S2D1Mg8pc+NdQ/tIIU5/jn6gYd5rvB8a+HfS71nLGnWOBTCEAazVhTCpZm?=
 =?us-ascii?Q?xeOpBsjtgckB3QR/MZFI+i0FcVJq1fAjHsYPHi/r/yKu8clHmOEaTnKJY7cb?=
 =?us-ascii?Q?rLPmBpQDRgNOvjCnK0iXqLTwp/bmr1XNTASUmEBHaLlnpn5oyE+a1tUXISZS?=
 =?us-ascii?Q?unwb7Fwsc/1ofD0ba11dtRvV8VJO40ohRWhkcx6z5QGN24cMtDfMkogFFq+f?=
 =?us-ascii?Q?r5/iYAPgU6p1RlVt5lAAzBY32Ts2tTlEPEixMe5mf0MhUUUSCxnn6ugdgGBe?=
 =?us-ascii?Q?23PfyCzFMIH3/qVpaLOD71ffuFitLMwt4/6p42YA8m63Wz2gecggC+qSXEtI?=
 =?us-ascii?Q?wupRD6lDDnaXJU2dSELfXC8NaZz/Pt6tPY84gC8oYO1+z5rQ7EBeNdKJvrBC?=
 =?us-ascii?Q?TlgHkXj8HapLFBbF0GfnQhTS9NduNsPEMh6Hs7YNz1mEqIgdbfnsqsy6eIhM?=
 =?us-ascii?Q?AGQI0pLTLvtXM1PBlLa7fIRsIdAVJ7YUWSvE2sWU+PdZS38JlZM46MbfZRBh?=
 =?us-ascii?Q?XRHLiovDY6SHB50+xAcQi7+Hrf5XwRgJjYaOw6OtTWC7j1pYij3vQJtUI8Ky?=
 =?us-ascii?Q?JMCYX//xxrcUzRMJTQ8nHrdjTEsex77kFEO9mkfSE/GJTt58LXatLkObNn2+?=
 =?us-ascii?Q?A7hcmVPicbiPwHW6JtB5uliwAc2fHTOS2iX6waEk3r4vDwX25/jf1GFyk13M?=
 =?us-ascii?Q?pKmn7bvFpWEwvOv9O8vwI+Bxr2PmJkghBnhTkgK+jYTny7dUd7NY0kRceXJJ?=
 =?us-ascii?Q?n1F0D2QzjlJQIl1bP43gHOaO5XrOhY+a5+g3otEI/Ki43vGKHXz6tZ2CnAzl?=
 =?us-ascii?Q?boi7lDTvkFU/ttuVQ2XWpPCG/Nlt5Pdw5t9cA2X5AJdvOFWZYVlaE+OUBQC2?=
 =?us-ascii?Q?0pGudQslPtwBIcaRlmQx8vZh2MacbdBJ7Ku0C5WVWTBzUplBC8TbLVbMRMif?=
 =?us-ascii?Q?uVHAfgubMB5sloLzKYwDlP1Zz733cd2mHRGS2h3Hh1iNXXbodSbetcDDLmGJ?=
 =?us-ascii?Q?evJrkP/egsj+/PO4xKijMJ0RYND8WzS4rTbGGueNV469Wz6CLuX7yg1fBD2g?=
 =?us-ascii?Q?XBGpEZ+p+Wh8U426f2QogdF1OWi584DbRaLPOgEhFruL1YWx2AwD+O6zNio5?=
 =?us-ascii?Q?gGuZDwPegjGoMENKriqkTHRRc/e6aeciXcZZnwN5oOUqFaHvvxQhycADjHnP?=
 =?us-ascii?Q?ZlPAA5VG6XErnDeDiKEA7hZjgScBZ+YZ/WSIizEcRnLK3Msp7++KbncejaoZ?=
 =?us-ascii?Q?C2EasXzGEZJQe7rYVu857kGMfWvMqZTpfkv3d7Ohji7V+F2G1UW1z2F2F6Tm?=
 =?us-ascii?Q?lzrFaNHSDUo5lY4OewoL0ML5LVv8DlcxwXC03f8UNBQwEPLf5YlJtYBdnRjM?=
 =?us-ascii?Q?EwADtktlu/+YIQUMAL53KUfdM5X35b4J83gAC0W2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4d2e6a-c2aa-4347-cdc8-08dbcb82dfad
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 00:25:16.3644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46psLbW6pd/aQeUUdbcjlE2TSwEhAevNGmRqsMcrGF1mtM72x9UnJvIwbCjQ3CLuX5FM/c/Tjk68NecwS73djg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7280
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Smita Koralahalli wrote:
> Add support for decoding CXL Component Events General Media Event Record
> as defined in CXL rev 3.0 section 8.2.9.2.1.1.
> 
> All the event records as defined in Event Record Identifier field of the
> Common Event Record Format in CXL rev 3.0 section 8.2.9.2.1 follow the
> CPER format for representing the hardware errors if reported by a
> platform.
> 
> According to the CPER format, each event record including the General
> Media is logged as a CXL Component Event as defined in UEFI 2.10
> Section N.2.14 and is identified by a UUID as defined by Event Record
> Identifier field in Common Event Record Format of CXL rev 3.0 section
> 8.2.9.2.1. CXL Component Event Log field in Component Events Section
> corresponds to the component/event specified by the section type UUID.
> 
> Add support for decoding CXL Component Events as defined in UEFI 2.10
> Section N.2.14 and decoding Common Event Record as defined in CXL rev 3.0
> section 8.2.9.2.1.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

[snip]

> +
> +/*
> + * Compute Express Link Common Event Record
> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +struct common_event_record {
> +	u8 identifier[16];

I interpreted the CPER structure as not having this identifier here.

From Section N.2.14:

"For the CXL Component Event Log: Refer to the Common Event Record field
(Offset 16) of the Events Record Format for each CXL component."

This implies that the data coming from the CPER record starts at length.

I'd be happy if my interpretation is wrong.  But if I am wrong then there
is no reason to duplicate these structures which are already defined in
cxlmem.h

I was plumbing up the cxl code to make a copy from length on and splice in
the uuid from the guid passed from the Section Type.

Ira

> +	u8 length;
> +	u8 flags[3];
> +	u16 handle;
> +	u16 related_handle;
> +	u64 timestamp;
> +	u8 maint_op_class;
> +	u8 reserved[15];
> +};
> +
> +/*
> + * CXL General Media Event Record - GMER
> + * CXL rev 3.0 section 8.2.9.2.1.1; Table 8-43
> + */
> +struct cper_sec_gen_media {
> +	struct common_event_record record;
> +	u64 dpa;
> +	u8 descriptor;
> +	u8 type;
> +	u8 transaction_type;
> +	u16 validity_flags;
> +	u8 channel;
> +	u8 rank;
> +	u8 device[3];
> +	u8 comp_id[16];
> +	u8 reserved[46];
> +};
> +

[snip]
