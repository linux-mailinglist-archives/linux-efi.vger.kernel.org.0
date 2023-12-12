Return-Path: <linux-efi+bounces-196-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D941A80F871
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 21:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA891F218E3
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A5265A75;
	Tue, 12 Dec 2023 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtJNMB+H"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C748188;
	Tue, 12 Dec 2023 12:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702414301; x=1733950301;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oILEYhUTyld4ghsJPZrm2tbqvnMqj8g9TOUzrDYg7Vo=;
  b=WtJNMB+HoQRrUeTE2tlunejiod4AUpbjfzOtmnBqX/dXxi5kbV5XzULo
   h4IEUN3g3dRhLeKfx/CVA9F+9TFXHE0eY5z9yo3sBSRsLON825eMrxcgW
   epL4wMFQ5obkxFAGckeTAzy304K0P56QJe0SNihWmqjyV+fd5+C9TH3Bc
   GWLVEJFnDVrauPy90sPbk3Z6vnMhPFGc5/tMVo1quVBTWZXrrMBI0ES6E
   R6AtrryPDrqy9V/K/BztuEjm//OepSRX0aLO1go1UyDNVFO3fhFe0vzi8
   cs/ORe0xP+nvwVC4WtAHg43CzxlEs6YTO/zajjGLwoeRI0l/qVlteJH5J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1942481"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1942481"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 12:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1105044618"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1105044618"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 12:50:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 12:50:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 12:50:51 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 12:50:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqJkSCYeppyLAQIuCGCaNzwQMk1h5r7/kXyUgJ2N6VSAKIoXnpDnTrRt2DTeAtgN5y9/ijpycrKmDW+Yo9ntjzpe/7bzBskn5VJeY6uyKabM/g3XiEQHFDfVkKtOd8ITQmcttrASjQv3EtREjEoyJ3OPJyexG3u6dnnD0/thjvCsNbagTJSkAa7dVoKGF9Ysw2nv7Ju7ra11NyZQYANaEpl3arUvplzmNfZfrTdZk9wpqZr0OAQofYF9YK2qPRYXYJLYHerfSWgS3Gvv3g7jAl1hjfFRNI4iq9PeLz2SIIq/xbVjvlRh4wYYQi0ccHBp328A1wa43VBsIGWEMAGN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uv8Vj7lcfWwFSG13gl5gV852yM+F8Ykmw+zmFLfOoQ=;
 b=iqDL0QJqGI/0MH5Oc18ruQrHtAfmNDtc2kH26gHV4HPAzUjfMRFGT6vtKm6vM+V208iqgxUJhxe3NnVtXTVwxsvIntFE71WXNmdLVtCPqTC4W6cQveWY+DUrJjOhJ8DtsYp/anj//EakBxNQDe0mtTrWJ3VKNpBWcmSaXg3Ha+hzRQnrl7SywkGUKzWJB+VAJKGLgzrsdwcHXNaR2ia2c1x+YgkVKAxJknuYkX7wMxB8ZD+1w/30d9I+KOuNRe9GN5T0Cfm8hJVB/9ZPC8Oznzg0WjjqXsu0T6m1uME0ded24hUQ0zAEm7LTtQfwTs4Z3KHEvwMkeI9jrcvz5tbcrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5205.namprd11.prod.outlook.com (2603:10b6:510:3d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 20:50:46 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 20:50:46 +0000
Date: Tue, 12 Dec 2023 12:50:41 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2 6/7] firmware/efi: Process CXL Component Events
Message-ID: <6578c7a1707c1_2253952944@iweiny-mobl.notmuch>
References: <20231211-cxl-cper-v2-0-c116900ba658@intel.com>
 <20231211-cxl-cper-v2-6-c116900ba658@intel.com>
 <657891bb7ec69_269bd29421@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <657891bb7ec69_269bd29421@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: fef0c282-9dd7-45cd-626a-08dbfb540392
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkKqvRsAI35d/+XM30QFsxUzr20rZne1LFV7GyC6BFKLAQGC7R9e3M/00oImNJWTPtD5cixd91TP8rJCLwm614ddfk5tEmEj2C5xyYBLxkq6Sj/lRYg9iwpGBCZMwSZCaiR/Nlo3EL8qPdZDSu79Op3eUTT6wtie3YrcG2Q/+vmDB5dm4cBT0O51iS4cAx7INFvWRxAyVIHd4kCT1RQhv67c/XQMWIdPsrpAXtJatQO9IFHpZMBzGf7JWICxaWc0E/1a3lP7+phYCuZ2PxysCxeEreSXXRCHcXAz0L/YXl3GakyEWvnShrBGxSUBLaxgaXlekWyUr+lVOfL0S7RnIATkZo614/SyPfqAD6mcovDZhlp5+xDaip3f+LOkNWu/R1jgId3trDaVaMQXlWe5TisMiWZCPreivBiMs9YI9Uy6XMP6WwEtQWsXoB+cTyyhQ6ZOSJxUqAzah7xDkDnhLbnY3ulV1oVASQ78oKYc2FDqE8NTBOeu/5AM6AWmIkyNPz/rb+j2ehuANVunVIqZ2ljTKnG59yz2B3wb9RU9sTd2NxMLzL/4UFH+8ZFj7hsj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(107886003)(6512007)(9686003)(6506007)(66946007)(5660300002)(4326008)(41300700001)(8936002)(44832011)(2906002)(6486002)(110136005)(8676002)(478600001)(26005)(316002)(6666004)(66476007)(54906003)(38100700002)(86362001)(82960400001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfVt99aPFpBlqrANFgwQaS9sVZEpQptxQrlHKBSumVY3hG6gA9XnD9HJQ9uU?=
 =?us-ascii?Q?kyAai6/aM4jQvbhOzqQFbOo/9p+raCkjLwA1u2HDbIauKNJSkvjwWNESw7EK?=
 =?us-ascii?Q?HyMOPGKZtxOQ1NN/P9hlLiVfNnXxInTy79Gk/nE0Qh7JxE0xKhxipaHW4oeo?=
 =?us-ascii?Q?Ojhx+D9P7NYBrXg7QCVu70ia/Lx+CIoyqNsYBZoEApzF/x5hjpWf62jrsNKi?=
 =?us-ascii?Q?siUbTfcJl9U86Bf3jA8O4P0E54WJzvutcDtTjEc9H7RnkbDpKi4Os197rhss?=
 =?us-ascii?Q?H6HvnGW+MTpHHxgZbNCeIJGVkIF+V2WJxaJLQfd1SgGETYkRWxoLsLwMrkHS?=
 =?us-ascii?Q?7eSrW1mBYq2ptfYAcnaHLS573kgvzeS6wj0wSqeslT46LdpHwR/qn/Tl2HB+?=
 =?us-ascii?Q?xUJDx6Rv04VdXWnAAsLTMSNcbnMkRAvkmwz0r1GpDxEiCrw2nTH7uYkaUdWf?=
 =?us-ascii?Q?3BapGQDuhOw9uD0q25GO6oRiWukpdtMmW8axlhOuicMq84QGZDs6Bhb3S2fn?=
 =?us-ascii?Q?t2YHeJJwC1r97rrvhFp8/Srjhin+xBHMD2NLjL3cz8WQ44CHGhn7QF/Yy7K9?=
 =?us-ascii?Q?ZpoOp5/uBDvjS8e6jsrPL17BOROtR75swDZRwITBZ26Hya+O44gRFsYt7Yom?=
 =?us-ascii?Q?YxiACbCXpCCb3rAFqiKPPZ6sK4kGGzx76R0nBQwZhguratLrU4JtR0c4EIkU?=
 =?us-ascii?Q?ekaEb3EFbmRvr5D6E5AvpiesGAtk1VxViB49ANdBg8Tan+jlt+OWh64Zvobd?=
 =?us-ascii?Q?602Ihp2zS33ay9jDe8F76F3J+qdC8YD8ifTmrUZao3+z/CohMDKmmiuIZzeK?=
 =?us-ascii?Q?1kWcl1GGPTd5TesU+Jei77xdb9J1fWU1CQRT477TXt/ESJOXizyK2tTr2P4E?=
 =?us-ascii?Q?MfM0BULNRtIlWOvgJrzyHBM78qxeyjpW87b98xf9Tiv28KN+qDtd1sIreuFr?=
 =?us-ascii?Q?wOZsbW5j089nxsZoDS+pIlILLSQlrA+HI3EJekyMMFmgMMfsk6G37s6V7rAf?=
 =?us-ascii?Q?me2ftT1TeoSAbtJp4dBrq+Qt/lEA5JsXFepwUR0xEzxAtZrZzyMzrulaU8MZ?=
 =?us-ascii?Q?8098uD+IeTG194qRsVg5zpob+KwGQQETW/L7u4xRjibdIUvw0kdO2IZ3zq6J?=
 =?us-ascii?Q?t01UBQMxZ6ncBZhnzvLHctztvUG3ZvPGMmZY065NdnYYHscmzxT/I+6/0j9G?=
 =?us-ascii?Q?j3jBOjoBGwCnKGCA001ZArT94Hzfd/g1b/bm69a4U0SYxUFnVQAE1bwhrNP4?=
 =?us-ascii?Q?dhbK5E3Wl2csElkLotvnwsl8KzZNVFAQBcj4wgJoX3CTj4lNKFESmQBJdIc5?=
 =?us-ascii?Q?l/t11v4P7+QK7Rr1wQFVIYlXOGpLqqNjFXSkKrJWuSNzNW2NU7qxjkqIQ+jb?=
 =?us-ascii?Q?4b3RRWklxbLSg48/dtehZFSNpziSauA2sHTTjdgHjEEXesbCOC03c2KGqgtc?=
 =?us-ascii?Q?Fs7Ow63Dq1R4hMAkB9Nvg8mG4/Oc5EtpO7NiC3uzOR7incwXQjePT/nx/ELJ?=
 =?us-ascii?Q?/1Ori304MDpgSOP+JOuS55WMOe1Wi/ZnTL6mnSEj8n5GwyAWzQC6NrkBjgKH?=
 =?us-ascii?Q?c8ic5WhnRSshOzXmLV6EbkdoSMhZipGx2y++sF37?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fef0c282-9dd7-45cd-626a-08dbfb540392
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 20:50:46.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwyOu3HfqjOaUvaTf/nd1O4ilZwQP6Ryq+mPdcVHS4618bAMVl6z2KnbzMJU0vTPM3IxJkXihamPWlxt9HHWAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5205
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > BIOS can configure memory devices as firmware first.  This will send CXL
> > events to the firmware instead of the OS.  The firmware can then send
> > these events to the OS via UEFI.
> > 
> > UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> > format for CXL Component Events.  The format is mostly the same as the
> > CXL Common Event Record Format.  The difference is a GUID is used in
> > the Section Type to identify the event type.
> > 
> > Add EFI support to detect CXL CPER records and call a notifier chain
> > with the record data blobs to be processed by the CXL code.
> 
> It is no longer a notifier chain in this version. I wouldn't even call
> it a notifier, it's just a registered callback.

Ah yea I missed that in my rework sorry.

[snip]

> > +DECLARE_RWSEM(cxl_cper_rw_sem);
> > +static cxl_cper_notifier cper_notifier;
> > +
> > +void cxl_cper_post_event(const char *pfx, guid_t *sec_type,
> > +			 struct cper_cxl_event_rec *rec)
> > +{
> > +	struct cxl_cper_event_data data = {
> > +		.rec = rec,
> > +	};
> > +
> > +	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> > +		pr_err(FW_WARN "cxl event no Component Event Log present\n");
> > +		return;
> > +	}
> > +
> > +	if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID))
> > +		data.event_type = CXL_CPER_EVENT_GEN_MEDIA;
> > +	else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID))
> > +		data.event_type = CXL_CPER_EVENT_DRAM;
> > +	else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID))
> > +		data.event_type = CXL_CPER_EVENT_MEM_MODULE;
> > +
> > +	down_read(&cxl_cper_rw_sem);
> 
>    guard(rwsem_read)(&cxl_cper_rw_sem);

Much better.  Done throughout.

> 
> > +	if (cper_notifier)
> > +		cper_notifier(&data);
> > +	up_read(&cxl_cper_rw_sem);
> > +}
> > +
> > +void cxl_cper_register_notifier(cxl_cper_notifier notifier)
> > +{
> > +	down_write(&cxl_cper_rw_sem);
> 
>    guard(rwsem_write)(&cxl_cper_rw_sem);
> 
> > +	cper_notifier = notifier;
> 
> I would enforce that there is only one registrant and explicitly fail
> attempts to assign more than one.

Done.

> 
> > +	up_write(&cxl_cper_rw_sem);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_cper_register_notifier, CXL);
> > +
> > +void cxl_cper_unregister_notifier(void)
> > +{
> > +	down_write(&cxl_cper_rw_sem);
> 
>    guard(rwsem_write)(&cxl_cper_rw_sem);
> 
> > +	cper_notifier = NULL;
> 
> This could enforce that the same callback specified at registration time
> must also be passed at unregistration to disallow anonymous
> unregistration.
> 
> Makes the code self documenting that the registrant is a singleton, and
> that unregistration must precede the next registration.

But what do we do if it does not match?  Returning an error will be
ignored by the cxl_pci_driver_exit() and if we enforce the singleton in
the registration I don't see a lot of room for error here.


[snip]

> > diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> > index 18dab4d90dc8..c764ff877a6d 100644
> > --- a/include/linux/cxl-event.h
> > +++ b/include/linux/cxl-event.h
> > @@ -108,4 +108,55 @@ struct cxl_event_record_raw {
> >  	union cxl_event event;
> >  } __packed;
> >  
> > +enum cxl_event_type {
> > +	CXL_CPER_EVENT_GEN_MEDIA,
> > +	CXL_CPER_EVENT_DRAM,
> > +	CXL_CPER_EVENT_MEM_MODULE,
> > +};
> > +
> > +#pragma pack(1)
> 
> Looks like there is usage of __packed a few lines up, just pick
> one-style. Prefer __packed vs #pragma when only a small handful of
> structures need annotation as that is easier to check for correctness in
> patch form.

Ok I'll change it.  Smita requested the use of pragma but keeping the
__packed is redundant right now.  And I'll go with your preference of
__packed.

Ira

