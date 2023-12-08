Return-Path: <linux-efi+bounces-153-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E3D80AD4A
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 20:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53DF1C20BF7
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C56E53817;
	Fri,  8 Dec 2023 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loxvNJku"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3963A1729;
	Fri,  8 Dec 2023 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702064630; x=1733600630;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yVtmCV6B4GsinhsU0QgoXkFE1V4sR4smEINpoRLPNLE=;
  b=loxvNJkuuqNA7jyAoPqX4wSw6BBrh4OFKzKHM6Zst9TKgO95eX41Y9wi
   oiykujL1yt3zj8OnVtlubkqwQ6+T89zk9nrCNTTpbzzBIHDUj7VdVZTII
   1BHw3aEStvDLVr66Qz66XqWDMg2WXsX2vWGoce6AajxANYFiMN1lrty32
   hdDfznarG7edDobT6AZZ0/2dn3d9DcdNuZVYYH4+kbHNcC+eWrVnqV0hy
   de/I7f3Tmyw26JHuze9HYTkav7HkztFo9Z5WPU6fjPwQe/4mR6iCcRJzi
   TxBTl3gFkm0g6CcO5m16+v1zqznI0cw4NDnmDFQq3/gTQXWii47EtuKoR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="391623617"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="391623617"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 11:43:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="862981185"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="862981185"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 11:43:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 11:43:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 11:43:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 11:43:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKaJlu3Y/nfjI2rw780g/Ky/MydrAqBqrKQ0IFkIyRzEbmy9S/yMjfc8RqAdSm8LiF0VwpRWLf2UVX1wXwTs+VKyiMZUejEDkGrIqI4sSTzBQTA2UIeLKyaFjRw3g4OS5LfPagVCawN7h8fdrPL+SUnymSsFaJ//hAEaeRe3UEu0iNn+eIPq1VfrTNiVVd8zUG7Sly9MSfY5YMa2/RQoQVOxgdpLlmz5e+fT+yeTcuxQgSyb4iwP/LYoZD/aEaShPI5veqokI+9/OBKo3rA4zWHEgQlBQiocmuXCFvdRQwwP33DHP2tCSTZjqD4PDsfhFJsuwmXaRgLBDFjf3bDFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCQh80l2lERo3QKKln9nac9u8hyPFbnKTUXdV9nr4ag=;
 b=ZHAWwseS44bW6QRABrazgEDkCH7juqJlFvUKlaXeAH+IsL/hI2Yka8ku2k76yVGHv4/UPcL4XkpZBdYuH8vqtph8xYaxanNX0yXf4MbivOAPWf/oNGbZl5ha7WTzwf3TXWiloLYonVSpajHZ2HU082N+pmcrr3gYiJAWFfOoG27OXjvi3zYIMH6EDnAn5/i7nVv685nrviYzcLh9XoopXbV2XqFXLe1aZHNn+4EC0dsplFfzFkle+DkJqLZScu9qn749BdKppMzSwUier/D73RV4q3ht3rewKyQ7N6NAwFDQ0ph6QOgsUzg+24JaSo+n+1Y2adJeqwSXy0hr1IO30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO6PR11MB5619.namprd11.prod.outlook.com (2603:10b6:5:358::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 19:43:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 19:43:47 +0000
Date: Fri, 8 Dec 2023 11:43:42 -0800
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
Subject: Re: [PATCH 6/6] cxl/memdev: Register for and process CPER events
Message-ID: <657371eec6ac5_1e7d272948d@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
 <20230601-cxl-cper-v1-6-d19f1ac18ab6@intel.com>
 <657279a68c270_b991294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <657279a68c270_b991294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BYAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:74::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO6PR11MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 746fac1e-67c6-4d9d-345d-08dbf825fe79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8rqoD/rKY1V15nWiFsZDRwW1Dz4as05MXkIFlIU9NHkGDHhRg518mVPt1lXERxEtqDKqbLTK55ZVyLhfJmVnK7x39mYJc7F7SFxg5iZAENLZE3EMwo02oARrQ71mkZfREmvsQ2bw/FepRqa7f8X4WuMfzwVqIippqRsletvvLsT5ijPM5kioxdIniW1TmCqhdKqedkneSf3WHK6HpxAeV4lGkEJNiSEkIt2fVzwv/S0orqYrKo2k7uXPKAcALg+wXpB0Gl2+UbI1435Qe1ZhvdsE/EGtm84tC31S/vraJrVzPGf13YsTy0+MnNI/JEp7C7HbC3athjgmGaD9lSmHuTmfBjrMSI+KIA/CeZ8HlNE3i5afkVwWyaR5OM9aDC72i6jN6qRkSOsRh675GeVByizJSC8O4Zd03TUdIR/WCWYnb2O5LPImW2erqp7aZg/srInLh8ZqvJKSdojpbEIcF8/kb1D/02OAWuwonAAaIQtHJ/IKCDhp4S40dtlSFCO05NzzT9GnrAwleONd+bpXpKJ9N9Vrtlbo/l1W1VErb+rb6kgkApj+4ORl1oJl2tR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6666004)(8676002)(26005)(44832011)(6486002)(478600001)(8936002)(4326008)(38100700002)(86362001)(6512007)(9686003)(107886003)(5660300002)(41300700001)(6506007)(316002)(66476007)(66946007)(110136005)(54906003)(66556008)(2906002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p0RwUSqay91RJ+3FCR6YivK9fsVf+yKbD2I5jw4wPScXz3XGNyDl4o+iVvTH?=
 =?us-ascii?Q?o8NORaxIix9a8gCEjBjCWZDYcBo//UWO8Hzo3p2d3rfKdb+EEAtr+HN7f8wk?=
 =?us-ascii?Q?P4Pvtu1CFWWU+3nUG+PsYW9UuYcRNGjQeLIFumAQKWOX7ux4n0vSH6WDUt/4?=
 =?us-ascii?Q?zXBNxXUBVRU7FuK7ApVWBx4/Vs5uSPkt4u46J8oEjPwdRWVboYJqV4qNkSfv?=
 =?us-ascii?Q?yyQUZkAVovkpKvkNl/6V4e1BxlwMwiclbJDaHuyhUek0SQgdqddb5L1h80tZ?=
 =?us-ascii?Q?hcRJxn5qIKulbYZt+9JU1oZxRTM+o5lLJhhtxYwr7rrQM09oyfscvyIzg7JR?=
 =?us-ascii?Q?M9/WvqeEH1zV4ML5+wGllhFAx7ePJslvl9NKwm0/rUxMuNKyqH2wyhjeIrzg?=
 =?us-ascii?Q?lJsAeyL3XFY6rteckFpKUPLwkzScbsAxXcChF4XzsHTurZnNXETT1q4A3d7/?=
 =?us-ascii?Q?V8swVPuRfxrhojIJswRiCkwXApZv0WvRtUzoNzbxK7HhqO1ksOAsjpGpvk7Q?=
 =?us-ascii?Q?Xu1/U/OCpPbgxPVY6Sz7dxklq5X3CzOH0fcntWWYKii/J82UOaj7mmMP3oLQ?=
 =?us-ascii?Q?oBo6M4PTg9uMqvffpgTpYqjnAZzApcxmZlzpru9ZzoCZxNdKTHCcb46wRu9v?=
 =?us-ascii?Q?IEkcY83nf+mjA/CUY1cVrCgHoIAcPR6yMfH7S5MIh9DpSiqo26scsm6v4YBj?=
 =?us-ascii?Q?o+WOKnnqTmWXJ7kivNQfQU4IleNB/ic9P4OaDCLtUnN6Q2OpYtkM6nIBs/vs?=
 =?us-ascii?Q?tfoc61WJNhaWviZCvpg7RBzLyp0yBOCak8MAcNYNc4fvy6HdRjBYW+3kqC8h?=
 =?us-ascii?Q?MGwuv1UF9g7jKfEKSP0d7VJrXl+ZWvIAZAgysMe3FKkgLZjTErPoseYCUfJe?=
 =?us-ascii?Q?BDbqXW2SIxd0/i34JKaBZfjHFWFV98YCJUboyx9/uR4AeiOphVh1xc4ABPVr?=
 =?us-ascii?Q?9yrBkG5kqM1cNldzRa6vxvrlKsympbyW+bkIaFXy47V//5NgjgdwNbbdiYxr?=
 =?us-ascii?Q?ve7YeOCQ9/sZRD+BY/TOeTQmbpBI5ZEDi0eM/SNzWGB28IxFPOQYoGV8dc4g?=
 =?us-ascii?Q?PtNmFKp4tlEWjnaZCD/GPFr+lub7tjjvbT4VZmhihFBru1zgBwpRfJ5Fm9ph?=
 =?us-ascii?Q?OC5WyEnMSfdj/aF3UfHpBaXPlGBmdH/zH2YIp/eEmCoOC3XUawJyfjfqRW4m?=
 =?us-ascii?Q?YtgUDG2bhDV5lbI2SFu0gJJre2BR2p4srQIaAR17Jv7S7bMmYZS3qPicOtYK?=
 =?us-ascii?Q?DBRVIOfG6guSU1K49zdiZyC8iO1hX2FkZ49zR4jhMvviiwfhLRbCzURewzED?=
 =?us-ascii?Q?hRzlCkaegFoxyy9hoNnQ575M5td0lPWJxmeZUy9Y3Ge4L0OT8IaB76M0Nb0o?=
 =?us-ascii?Q?fa/9fdS0bPzRASY4KVgtdJqSK9eLsNtYPXK1M7WI51IjKuLtjHRlyZemcr2y?=
 =?us-ascii?Q?GVgbmtDGSCtq4aYzl79aoPd9r5neO2WRHs7q3JYPJT+IoANTBilYNUPphknR?=
 =?us-ascii?Q?iD+eJjW2IKrBIz7Fvu6ziBnpFNYr7WbmPVWE7gIbggcrxfFMKO4PY82j2et6?=
 =?us-ascii?Q?9i/0STm9h7jdy6Z4ndKo7SaM/bbN0Sz9PpCo4iTZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 746fac1e-67c6-4d9d-345d-08dbf825fe79
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 19:43:47.1966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mxo9fFFBqt87dSIlwgAOiYwrfupkkp48KfTltlkqoPs9BFVmkTo86VS9DSRfic26XCEmlp8G9Ww4zsSHLycJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5619
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:

[snip]

> >  
> > +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> > +static int cxl_cper_event_call(struct notifier_block *nb, unsigned long action,
> > +			       void *data)
> > +{
> > +	struct cxl_cper_notifier_data *nd = data;
> > +	struct cper_cxl_event_devid *device_id = &nd->rec->hdr.device_id;
> > +	enum cxl_event_log_type log_type;
> > +	struct cxl_memdev_state *mds;
> > +	struct cxl_dev_state *cxlds;
> > +	struct pci_dev *pdev;
> > +	unsigned int devfn;
> > +	u32 hdr_flags;
> > +
> > +	mds = container_of(nb, struct cxl_memdev_state, cxl_cper_nb);
> > +
> > +	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> > +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> > +					   device_id->bus_num, devfn);
> > +	cxlds = pci_get_drvdata(pdev);
> > +	if (cxlds != &mds->cxlds) {
> 
> Checks of drvdata are only valid under the device lock, or with the
> assumption that this callback will never be called while pci_get_drvdata
> would return NULL.

For the device we have registered pci_get_drvdata() will be always be valid.
Each driver is registering it's own call with valid driver state in the chain.

However, I see I have a bug here.  Using devm_add_action_or_reset() breaks
this assumption.

> 
> With that, the check of cxlds looks like another artifact of using a
> blocking notifier chain for this callback.

It is a desired artifact.  This check is determining if this event is for this
device.  It is not checking if cxlds is valid.

> With an explicit single
> callback it simply becomes safe to assume that it is being called back
> before unregister_cxl_cper() has run. I.e. it is impossible to even
> write this check in that case.

Exploring the use of a single register call...  you must check if the cxlds is
valid on that pdev.  Because the driver may not be attached.

Something like this in cxl_core vs cxl_pci:

#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
static void cxl_cper_event_call(struct cxl_cper_notifier_data *nd)
{       
        struct cper_cxl_event_devid *device_id = &nd->rec->hdr.device_id;
        enum cxl_event_log_type log_type;
        struct cxl_dev_state *cxlds;
        struct pci_dev *pdev;
        unsigned int devfn;
        u32 hdr_flags;

        devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
        pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
                                           device_id->bus_num, devfn);
        device_lock(&pdev->dev);
        cxlds = pci_get_drvdata(pdev);
        if (!cxlds)
                goto out;
        
        /* Fabricate a log type */
        hdr_flags = get_unaligned_le24(nd->rec->event.generic.hdr.flags);
        log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
        
        cxl_event_trace_record(cxlds->cxlmd, log_type, nd->event_type,
                               &nd->rec->event);
out:    
        device_unlock(&pdev->dev);
        pci_dev_put(pdev);
}

This does simplify registering.

Is this what you were thinking?

[snip]

> > +
> > +static void register_cper_events(struct cxl_memdev_state *mds)
> > +{
> > +	mds->cxl_cper_nb.notifier_call = cxl_cper_event_call;
> > +
> > +	if (register_cxl_cper_notifier(&mds->cxl_cper_nb)) {
> > +		dev_err(mds->cxlds.dev, "CPER registration failed\n");
> > +		return;
> > +	}
> > +
> > +	devm_add_action_or_reset(mds->cxlds.dev, cxl_unregister_cper_events, mds);
> 
> Longer term I am not sure cxl_pci should be doing this registration
> directly to the CPER code vs some indirection in the core that the
> generic type-3 and the type-2 cases can register for processing. That
> can definitely wait until a Type-2 CXL.mem device driver arrives and
> wants to get notified of CXL CPER events.
> 

Yes these calls will need to be moved to the core for drivers to share
later.  Same for mailbox event handling.

Ira

