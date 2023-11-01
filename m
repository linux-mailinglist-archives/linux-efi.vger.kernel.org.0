Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D37DDB8F
	for <lists+linux-efi@lfdr.de>; Wed,  1 Nov 2023 04:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjKADgH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Oct 2023 23:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjKADgG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Oct 2023 23:36:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B8107;
        Tue, 31 Oct 2023 20:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698809760; x=1730345760;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x+L0TwUjzFdTma1GOhO3Nmtnj5x0tFCK24XJEnNVyZ8=;
  b=gzfmIpL2hRSmJIBa2HhzN1rc7IOMzm/qfWZGY7iQTLs4M5VCqoUUS9dz
   jLerU6sXqCrQIeQ7C4c3+i/KxNoZliZxD8a1cCiP8n7H1a+mDt96TvrXC
   s9Iy+S2x4hCeO2QqZ6uXnndnhYjrFLuszuvDmJh4l+zbLzDCAjUTqxCcm
   ws3ef2cNHYkAcwtu7HmkW8i7+1FxND/10c35XT7GBB5BkUFVspx0OLrmp
   5C8JAldXPDBHvvhizJemogFTl7oUPKlOIDZkEYapqWSz+pDePL2CA6jlK
   t/dHbixgtkxmH0Ij/fWbyS4m/wtriPFW1gmKf0QtQC4vW22BC2/mhjgs3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="368635156"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="368635156"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 20:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="737275426"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="737275426"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 20:35:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 20:35:57 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 20:35:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 20:35:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 20:35:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ly3qOyJBLPVMVBJSB6Q1AJcF9YGURXxLT+R7WM1N2qL4gN+WiOvbQtyDRcXRnNpf0VjqWjjkXkOf+/a/yWnZu8ZhQ5bVwNE9UvepZ6UbhbI68DGEGRzMPPBfokALBq/KUU3Bf+5Yl3oQS4cs+cH5WtaUztOLbI79LT9p6dsuuNiJ/Q9CNVTUPlj9We5SMes8m0SAY+YouocbpP4z5UFAuZP7p/2PRxZ9ANgXlmW9qr4qUqYKY5TqzwGTG8AcBPbAzfwGCwjBYbIrpUR4m2xEaD4vuVVR4zDBBTQitT98p7N9RW5gPUwfUTUUz1XDu5evHx7UnPxZcgXkMxxKINsiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D/dFe2DAG7vNsaAVXnyznZwt6UE13JnXpPdtxf8be4=;
 b=Kmgq/EQxlWMb/LefqjAzYc6iX7LZOs9ZI22wkJ2WBiR3MZt84WvlSCCd1VcY5qEbBJFE8OVI1PEVIayFu7TDUO4uQsF781r8J3liewY8GwoSMRPf1H6UxM4lMMsssBmjDP+HILJZDhb2Is/8ZdNhcQJQIxtiCwVZe/xnIaCnCPgOHeUQubLrT/z5yTKnOgei5afIm7JZWnxd7r98mlkWKNose/cvsn32okFY6d/yXACjgQliIk1jM6OptGxXHaH94iSrWoO/4v0Iw5hp8yvro9NILH4u0TwJXcqskaCm+5/pbH69QJBLIB20OALIvhg/Dz8u+qz+7H5iqpFZCq3WEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7937.namprd11.prod.outlook.com (2603:10b6:610:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 03:35:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6874:74cc:1c23:7f1c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6874:74cc:1c23:7f1c%4]) with mapi id 15.20.6933.028; Wed, 1 Nov 2023
 03:35:54 +0000
Date:   Tue, 31 Oct 2023 20:35:49 -0700
From:   Ira Weiny <ira.weiny@intel.com>
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
Message-ID: <6541c795e39b_2e75b294e0@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
 <20230601-cxl-cper-v2-3-314d9c36ab02@intel.com>
 <81b90308-fdb1-3686-33a3-1e7ec42a7ef8@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <81b90308-fdb1-3686-33a3-1e7ec42a7ef8@amd.com>
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8b536a-55c5-48db-f9c7-08dbda8ba63c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOAkJQJGzjAoSmbcLuG6YCCEEGZ/GRKeNRl3rRvbmxLfDsfD4ALHx4IC7EnM/J8uJV1JcATsbAwJoWr6wf6XaqWnef9pqGM+8WooC3Dcrvta1cw28IeX/R0SH3njqW3Rw3S7l2sx0dQxKM7t5dG/J6aRQtiWZR6uithUUhgG3Bq8EdWBEi+vKtbmy+wqbbQwabmC/odMQB5ilHCm4fX8X0e6jeT262uvC0kBa+YlUf6JR02Ehv1J+VyJFmghIsRbl+yCmx3BzRSTgVrnKc3EwZCbtG56F0EHPWqIyJlU7vK+kYRaJOuzTp6FWpCEfgQ2L1DK8aFRRoWGLT4JIzXqNQ6I55Na5K/LaspFTVNaUUreta0bh1xcQo1QU4dAgsQ7HKgWau71Mx2ajG5DE+0/mp0FDUffC7Yk6oK8KcNhyiyilKF1CaIHqdOfyqqtsMrbAANHyBzNzLQJ/OUtrI9yKfkMNKb3ugCi1xFSxMMV/yFgR1X3w0s5Y52t1D8ILJuDFlHncVjglhsxhKpUzltzNjfqBwZNY5dvSBxr3X8vaDnx+PMl798V/9+cm5Koa4Sh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(44832011)(316002)(54906003)(41300700001)(5660300002)(8676002)(6486002)(4326008)(2906002)(478600001)(8936002)(66476007)(66556008)(66946007)(110136005)(6666004)(6506007)(9686003)(26005)(66899024)(6512007)(83380400001)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r3aw+HhWzUGTlsE3XGr68DIFWHYsnjOgXUW6PkvGgZuinYWjNoXwUwIFhHms?=
 =?us-ascii?Q?aoYGEX+7geYNo9D5+z38LwCtJHIED3JX2Wt7vsUsOlkpPxMP9qv0k7gJM4kP?=
 =?us-ascii?Q?wYbQXbPPtfA/v0e43i+ANcW5ZWdAL+H1FXvw9qtoI5Wvmxr42b1A+hCu3tZN?=
 =?us-ascii?Q?JXRlbEtTRKePIayUGZPK6W3Tcu0nP0S5YBMmcnCosJ1nJV3VUNYnmo8Yxl5h?=
 =?us-ascii?Q?P42BHtRtR/p5TvEFl8nTvWIpp7DGtlAm1oMmj6s/KxnNdQHHLaM96FXUlYim?=
 =?us-ascii?Q?gCL30oAu/CzOd+3YeemNcbaldbA8UjXzYYfNz+GlZ39Cou4br1nrNgpwWTlc?=
 =?us-ascii?Q?HO43jxwnFJZKfc0OyGmsojAbHAjSdv4AqxfscV1VZiu29whajnNw0D3/h55Z?=
 =?us-ascii?Q?a9x/v0dflqumSZviuKg+GambWTJdLr7fYY/tfgdV33+F7VX+y2+xYplQmKr/?=
 =?us-ascii?Q?LETQqWDGAeXYRWFj8gpp6pTbE3FXPx1VWxm3gJNtTbscTp+A7abuXbuBU3p1?=
 =?us-ascii?Q?+29pEjI/zjJSDIEpJMOcWRbgPdxZnmujJOx4KVz0Opilw4IlNEoHXQn9coWf?=
 =?us-ascii?Q?/mWHq54MfBYpA62t4qaixjI/4P9s17wGfMMK3HVGV7SREjBR9f67rWjoPIbH?=
 =?us-ascii?Q?Fna+amemEDbng0zeiO2fwhEMftl9Q1FOmSkTWFa2T9yz85QzbzK7eqCQJl8F?=
 =?us-ascii?Q?yp2wWsU8ht/81oK+7EhTI1VqvwVbJJymxH7mB81mvZkSfl/v+vPWp7vKrizJ?=
 =?us-ascii?Q?O1L3xqmyc1+GL5Yz5HLEoCEwe7QF0qR0GlSfpGuQ+NxfcP9j5UpWPvDwhq51?=
 =?us-ascii?Q?sK5qs0DI1C04bzc070ZMh4DUQ6J/zWoCdRpq+RM7zlyB/bpXC2l48q3YYsf0?=
 =?us-ascii?Q?BhocNp+Mk13sHeUYGWlOmLsgNwlDAd/H4Ql+durJBr4gTc0VN/Hq3MGmgJW/?=
 =?us-ascii?Q?1Tu9RFHXOygRA9T8vFc4kmPbadzhngMyAfWigUh2S1qLDCjJRT1dkRjitFLQ?=
 =?us-ascii?Q?cV6RkMQUPGGCR5P6WmMFR+RpVFB1tOuxhNtj4u0AQxStpz6OwGuPQ6SlNfKL?=
 =?us-ascii?Q?u02RVGIGfLvMpjG488k+Yz3SMFviGtFEVLPSDI6J/qjRxoLyTa6Tm2e4J5Ua?=
 =?us-ascii?Q?T4hlqUljJcvIW9fhGFX00F7LPn9rCg9aJ7x3R4H2NYiEtUwrqY0sp5bAHbsP?=
 =?us-ascii?Q?WzsDAE2jfasYgNIEOPc4/ydrHK0Vl0a+lDec+Opyi0I63JIU36Vj8ZRmTmTG?=
 =?us-ascii?Q?5oT2or95lSvLdHnzqAmqoxUwQ48VyybXFtDh9geu1pRM/USnEL+9Q1/OXdiI?=
 =?us-ascii?Q?scznfFNF7UxKmKkNjisHIgpLOgt+NKa+2o0A8M5s1eahoE9ohL0eRNsVfJ5O?=
 =?us-ascii?Q?gjGOAupZEAHQrkBb06eL9TBrNgMmhvFGkFsDnvicW7QDueDZvSyta3RBg2q5?=
 =?us-ascii?Q?+I7LnZolw1W0lPmFsgovZHE4FieHBW58gXg3ejerGTTEG1Dm4bFQ2BHRF+5U?=
 =?us-ascii?Q?Wp7dA8UVj00OwyfGwxDN/i/k58YCyV72ksHb9ToDnEM7PQ1KpmDCehYMkNj0?=
 =?us-ascii?Q?/TE22JMK1h7z05YSBiKXMDsGyowV5XIv5C39evg4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8b536a-55c5-48db-f9c7-08dbda8ba63c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 03:35:52.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AP1GCjc7uJqmcIc5snltuC0RgdMTED8sXdFy/+smbQFwo8fi2hXDMfpiM2slEMS0lN5nMCLStpH98GJpevs7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7937
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Smita Koralahalli wrote:
> >   

[snip]

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
> 
> pci_get_domain_bus_and_slot() and pci_get_drvdata()..

Checking BDF is reasonable.  Not sure what you mean by 'check if cxlds
exists'?

This will be called on each memdev so the cxlds should be valid.  Do you
think we need some locking?  I think the unregister will block device
removal if this is running.

> 
> > +
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
> I'm doubtful this will do the job.

I'm not sure why but, see below...

> I think we should copy into each 
> field of struct cxl_event_record_hdr individually starting from length 
> by pointer arithmetic (which is definitely bad, but I cannot think of a 
> better way to do this) and then do memcpy for data field in struct 
> cxl_event_record_raw..
> 
> Any other suggestions would be helpful as well.

Based on Dan's suggestion to share the structures this memcpy can be
avoided altogether.  Let's see how that works.

> 
> I can make these changes and validate it on my end if that works..?

Any testing would be welcome.  I don't have a test setup readily
available.

Ira

[snip]
