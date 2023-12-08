Return-Path: <linux-efi+bounces-155-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931A580AEE4
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 22:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2FC1C20B30
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 21:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B35788B;
	Fri,  8 Dec 2023 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRdUxSgU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F6D54;
	Fri,  8 Dec 2023 13:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702071569; x=1733607569;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N/C1Wthz3+WoAcdDchTAb/e+9HBXEA6LpT76jd2F67g=;
  b=gRdUxSgUzdATwB6dIRLP6iPbUKoTPyCgZJxkCTNHpmZTkEOUK4SnlOla
   /rJAK/bqJon/PClIbgdAvOXDGY8vWybQCct2TdmPcD1xMLCBBKoTpVPNN
   yHXkl7Y+13Gbx07mHD1ryRXWk4//Fde4eC3mz3KE7n4jpRGmmjsA4cU3O
   spjNUrVmVmYrEHjrK7zhP2VB7tZVwQyimFcsQqXLWMjD1ovFuAh8elRsP
   AYhOlP4bCfQSHGVwst3wQtsdRYAPoC4FzyO0Daubz+LIOw9Njg8nSZJPl
   g7fucSQ6WAQIIfetFh335Ammh+YZCfGByceMW71ZZnCUKHtULgwpVMDcM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1553034"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="1553034"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 13:39:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="842753766"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="842753766"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 13:39:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 13:39:28 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 13:39:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 13:39:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 13:39:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a59J9ALW4vYUE73Hbk+M4unA9aH29c06MOd99+POSjXuCF54Lo4G+gyyaMv2mAv7apgWlE2EhoImoOQrWb/ZrrRYGIS8GSWvgMy/NTEFw19zxsllE5MzKQ/z9cx0xU0BuaCvY0RAqpMJXk852S+zh/Ri2rkuUVQetRUw7Pfn5o/P0gPt5tL+Qw6547HlHR8syaz15vUCdKnqrFCd6fy4ArSMxAyLkwpmw0TnARVR07CK/Kb2RtyeWkbxsvwHSlHcb1I4szOz3vAsHTNmJTNzg7DL0lZ4S6RfmRmPM2ev9J2IOI119g0nOkjzz7Gk1N5U6iFPRyH7QqD73QLbNOA7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voQHQcFrJ3VvVc2FMcur4RtB+kG8bJKSWCNHMGXC3oQ=;
 b=kzdeMq4BS0fQFdF12cVD6OVyo1RtSE3NI7lZ8SaetbXo3xfRWBHEhA/BUQtt1gBhbkb0alNolyZUq0PdMshVq2uD9JqQgObGVG6ZXDCR4nXEpkwKNsXhjWPS+V8W6I2Fa5MlQsDBf8vgCoPQeQk+ssyYd09kqcgvizFSM+QevKzKSOJCRiYgE4RNp2+zv4aeuc2qpI+/MQjAebQLCVoavl5uwxYBy/W1CwhpWwYLR2KQlqsgQSIhM0mW8pG8MuvlgPNQetJx9VtYB763244lY/qdmD5kB/69xwdtgOF12IKAKldjun9AP1P3JCSa7MXfuo3MdLhqIsrvd1SK6tAwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 21:39:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 21:39:24 +0000
Date: Fri, 8 Dec 2023 13:39:21 -0800
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
Message-ID: <65738d09e30e2_45e0129451@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
 <20230601-cxl-cper-v1-5-d19f1ac18ab6@intel.com>
 <6572740922eb6_269bd29445@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <657364d0aaa9b_1e7d27294ec@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <657364d0aaa9b_1e7d27294ec@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:303:dc::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c2c867-7339-49db-2ae4-08dbf836258f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbmGtJJhB23MH1ccXFEvFKNQuY/X0pxwlsNz3hO0wQMwckUgMZVhrVF8tQJPcCl0WZEcItkyucxS9ThVhsBIiHrTeyIMns0V/Vxrx2cyU6xADRiYeim3KX4jhBxLfQzCadpIAnfKuv3V0ddh800bA5qbo0ZLHBCdKnMbM6CU0QKjKBJC2zu8vGLpwbVjbyX8SyTq6Hy8y+M8KXnP3XdEP43CG6YRq0URl1tEIdiYbrR5F4HQ0jNMpavyraQHIctJjwHCEfOC7f/wc91+1AviRLff32NG3nH8sqBgs/USLli2lGEXlq61JKgAWJFfKIt1u12nDOGItF6M6H02QQW4wPUlp5iIn5NqpH6unCcNCc8YKlnzzJVe2Rpe8e3fhUTPz+vo5/lHHfPHD0G88YqDiwU/dK4MisrTrNm7y0Xp3fNKU/T4QB4I3n0rEnKldFjZSkmUBwdNuQ8yyt5oblsqJipAb4vOBQPvlyc5BbjnRnUn71Vto4ysaKcZvZbD7DmNd3Jr3zieFDPfL3jibvkEywcAchAZPTdqoBtvfJ8EpjT+Yk2W5DYK1Fud2ba52+sv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(86362001)(66946007)(54906003)(66476007)(66556008)(110136005)(6512007)(9686003)(26005)(83380400001)(107886003)(6666004)(41300700001)(6506007)(478600001)(6486002)(316002)(82960400001)(4326008)(8676002)(8936002)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eUNjp/HCcZ80j9nZZF0/y0uOWgpzGHmj0AeTsPdtiS8a3zl66P0Dym9ocQwf?=
 =?us-ascii?Q?Ercal69Rbvn7I5F+y0bpS3I6h/90RrIZeNk9EwltoX/t8WeE55lAbeHMM4gi?=
 =?us-ascii?Q?nqrmrmtsriqIT0gPqETaB5uvwO45kL9VdLJ+V9cg174aKn4c41dVOvuIbfnx?=
 =?us-ascii?Q?mZ9w04t5mvH4QNotDqBuSBf0n6IeQd4xZElIZ/gNCcGCB+llWyzGb31bMwtz?=
 =?us-ascii?Q?1Yvei1Uskk5PN2ejpXPrsq/mixWOrLVRh9Jpvyu+oiwls8UWqW1IFFC/RkNs?=
 =?us-ascii?Q?7lEGkRKOJrlkCfzt7ZFxQ2qsY/QqaF3dzmuwcOHeql80qY/+qnZvwuXSZu/S?=
 =?us-ascii?Q?4ThRdWDhhqv1dFnC3OO1cvTkfSioZBB5zdfno2ORv+lEQEvEUevtb0GJswpv?=
 =?us-ascii?Q?s1C1D24exh3yJdYol+FTEu3ValHZjYV7k+DVuIhkJUefgKSptajKvuKkZ0RK?=
 =?us-ascii?Q?BXxPulBwdUr30F6IA44l7N5995Ygqt65laN3pPmau3OPgA7CH9mrzm2NyeBR?=
 =?us-ascii?Q?rrC7MyaDXUfTTxqqZxu4vWG64w8LCVkyyr/4Ies29v1vCMTmgjfJzza0Z0l4?=
 =?us-ascii?Q?tEiaeMysVzipEA1cK8J6zKImB8u4CAG0hZCns+Wxw3R/+zoeBoDtIwiwoB6l?=
 =?us-ascii?Q?+M9iloaOjlxkWQPr0/ByQHHNn+h5oZ8zrU2e1ZAbyt9mZMPztY0zsnrk9e+Q?=
 =?us-ascii?Q?Oad3LU1HQNVdVtbpw+hs5paYmjhDxWN2uJQ/A3kjj2wCIgaS5KMSB3dqmjRY?=
 =?us-ascii?Q?0ASP19tCrjuYsfBeslip66mRL94HpCY2GrI0m3bao1joLRnl6lFuF0+a5gc2?=
 =?us-ascii?Q?Xy2vnP8iXrceO/mMlEbzvB5rv4tGwDGsjZKNaERqEhLHQYjBN9P31uelnUmM?=
 =?us-ascii?Q?Kio0zIag/ZUfXUNaC1lc/QQf00TzGaEkPt18/Vjg9++3Lx8Xmws9a5BS0ryx?=
 =?us-ascii?Q?6+CizrxI17Adv7CJXw5mr1a8Vnz6wQYuiZzScHYobFopJgsNu+zDFAzNpkeU?=
 =?us-ascii?Q?JRrxIHDmOJdVpXmqkgc3lv5Smt5rLrTBVvG9W38JJ14eGfZggzIvPgvoX7cD?=
 =?us-ascii?Q?9uIHadRP78WosTcKHCM2H4JDZK2beLA7r8z57kVBieJcG4kfgt1EmLVOTiI9?=
 =?us-ascii?Q?QpWUdhCF4ePPiGOG6X1NSgQ0Q4UmyoU3uP9FBgTC5nesqc4r5gIXllnpG9il?=
 =?us-ascii?Q?NBRcTMKax/CcJxCZwCd/unbHJ2LAt8I1Qlmvj5b9a+4yRL9vJ8YkJvNBEqUA?=
 =?us-ascii?Q?Iw3WRpl1VN5nZDH7E+J0O6C0D5h11hoX5pC4loVenWYpQDBYXW6hjzT40mii?=
 =?us-ascii?Q?kSiiXfeFmXgyQ06W6ihytiNRQERkema0ieFSv/ZWjl69qQkemPACNkQ2zrjw?=
 =?us-ascii?Q?+asQ4kiZ/f0qiLPzC40DdUbL2d47PlaCdMZE5XcsD8OuhO5AYnbDZNJWYc7r?=
 =?us-ascii?Q?Qa+2iK5eQW0SZzTyO2actmh4/5u+kU9CbhMppocuAvackd5siXaQbTNbTXYB?=
 =?us-ascii?Q?KffdR/K1f90Oo7fV4l0C91a+FuOKa4Bfzrub3u4SHYe+ooJJmBThGog02H3X?=
 =?us-ascii?Q?Bxu0aSDxRK1xqDo1+3uur7dpqC7tHe+x7yeVS2GMjctuUfsmnLIFz67Z258V?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c2c867-7339-49db-2ae4-08dbf836258f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 21:39:24.6985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2O6Z+bRHTdaC9I2IM8WOvYtlWm9woloARtUkvD7jwELHw8wsGOo3cibOPKlVQLKTiK0MFRp4ocSKkS+nxUGjAgyBxJDMFSkqawY00tSTSm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Ira Weiny wrote:
> 
> [snip]
> 
> > > +
> > > +int register_cxl_cper_notifier(struct notifier_block *nb)
> > > +{
> > > +	return blocking_notifier_chain_register(&cxl_cper_chain_head, nb);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(register_cxl_cper_notifier, CXL);
> > > +
> > > +void unregister_cxl_cper_notifier(struct notifier_block *nb)
> > > +{
> > > +	blocking_notifier_chain_unregister(&cxl_cper_chain_head, nb);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(unregister_cxl_cper_notifier, CXL);
> > 
> > So I am struggling with why is this a notifier chain vs something
> > simpler and more explicit, something like:
> > 
> > typedef (int)(*cxl_cper_event_fn)(struct cper_cxl_event_rec *rec)
> > 
> > int register_cxl_cper(cxl_cper_event_fn func)
> > {
> > 	guard(rwsem_write)(cxl_cper_rwsem);
> > 	if (cxl_cper_event)
> > 		return -EBUSY;
> > 	cxl_cper_event = func;
> > 	return 0;
> > }
> 
> This is easier in the register code but then the CXL code must create a
> loop over the available memdevs to match the incoming CPER record.
> 
> By allowing each memdev to register their own callback they each get
> called and match the CPER record to themselves.
> 
> > 
> > ...do the reverse on unregister and hold the rwsem for read while
> > invoking to hold off unregistration while event processing is in flight.
> > 
> > There are a couple properties of a blocking notifier chain that are
> > unwanted: chaining, only the CXL subsystem cares about seeing these
> > records,
> 
> True but there are multiple memdev driver instances which care.  It is not
> just 1 entity which cares about these.
> 
> > and loss of type-safety, no need to redirect through a (void *)
> > payload compared to a direct call. Overall makes the implementation more
> > explicit.
> 
> Let me see how it works out with your comments on the final patch.  But
> the additional chain state of the notifier made this much easier in my
> head.  IOW chain up any memdev which wants these notifiers.

AFAICS, the loop over memdevs is obviated by the call to pci_get_domain_bus_and_slot().

The cxl_pci driver switches from using module_pci_driver() to having a
custom module_init(). Inside that module_init() it does the registration
once with the CPER code. In the registered callback it does:

    guard(mutex)(&pdev->dev->mutex);
    if (pdev->driver == &cxl_pci_driver)
        cxlds = pci_dev_get_drvdata(pdev);
    if (!cxlds)
    	return -ENXIO;
    cxl_event_trace_record(cxlds->cxlmd, log_type, event_type, &rec->event);

...no need for per-instance registration.

> > > diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> > > index 86bfcf7909ec..aa3d36493586 100644
> > > --- a/drivers/firmware/efi/cper_cxl.h
> > > +++ b/drivers/firmware/efi/cper_cxl.h
> > > @@ -10,11 +10,38 @@
> > >  #ifndef LINUX_CPER_CXL_H
> > >  #define LINUX_CPER_CXL_H
> > >  
> > > +#include <linux/cxl-event.h>
> > > +
> > >  /* CXL Protocol Error Section */
> > >  #define CPER_SEC_CXL_PROT_ERR						\
> 
> FYI this is not added code.

Yes, but I reacted to seeing enums and GUIDs with similar names and
more explicit details in the naming.

> 
> > >  	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> > >  		  0x4B, 0x77, 0x10, 0x48)
> > 
> > I like these defines, I notice that mbox.c uses "static const"
> > defintions for something similar. Perhaps unify on the #define method?
> 
> The static const's are defined such that they can be passed to the trace
> code as a reference without the creation of a temp variable.  These only
> need to be used as static data.

ok.

> 
> > I
> > think this define also wants a _GUID suffix to reduce potential
> > confusion between the _UUID variant and the cxl_event_log_type
> > definitions?
> 
> The UUID's are never defined as a macro.  I also followed the current
> convention here of prefixing 'CPER_SEC_' as per CPER_SEC_CXL_PROT_ERR.

Once those definitions start being reused in code outside of CPER where
it is not clear what a CPER_SEC is, I think the _GUID helps.

The UUIDs as macros would cleanup the open coded UUID_INIT in cxl_test.

> 
> > 
> > >  
> > > +/* CXL Event record UUIDs are formated at GUIDs and reported in section type */
> > > +/*
> > > + * General Media Event Record
> > > + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> > > + */
> > > +#define CPER_SEC_CXL_GEN_MEDIA						\
> > > +	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> > > +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> > > +
> 
> 'CPER_SEC_' is in my mind different from an actual '*CPER_EVENT*'.
> 
> But I can see how the macro/enums are similar enough to have confused
> you.
> 
> I can append _GUID if you really want.

Yes, please.

