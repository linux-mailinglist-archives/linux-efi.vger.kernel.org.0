Return-Path: <linux-efi+bounces-152-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F780AC6F
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 19:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 561FEB20B2C
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A632FE2D;
	Fri,  8 Dec 2023 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhbNiZOg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E3E0;
	Fri,  8 Dec 2023 10:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702061279; x=1733597279;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GEg0PGqImt0QXJKWPSV9baySDlDK8MYDh/7Tz1ABQqQ=;
  b=OhbNiZOgpT5eC2Bk0BtRyMJdpQFu9tP8lpGJ1qzh1fphvN7xQ3cSIRXw
   WR0YqQ33kmDUN7eKBeTBKYMgtuwam+DqK5+eL1Itm+2wQx+1HLz0KYfsh
   FHkHihdgYdrsAl79MCFAqfqGYzg8TnP8uKl0gCv8TllHmaixo5bRSBt4O
   GJjVfLCGQilbtfDO8tubuf8iHhgaT1dDFErPhw/qWl6qpUfx8gT3+EtGd
   tzZXCfjy/UN2ok7nrytQ3lCLJwooJ1cpf0lsiGD6Aut7O/HrlD4iS4gGT
   lrBw3flCfAXfUby6uiCu89e1sePMyjIBPiMwhxBRRuG7DQmYhlwrrwbvx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1324979"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="1324979"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 10:47:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="775883498"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="775883498"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 10:47:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 10:47:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 10:47:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 10:47:58 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 10:47:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQrHU4AK67RggZLIbg/2rL1Lji/VAaoCwcnI8gjh86gYjlr1Dz/MoqA57FeVt2gXQm2ApO1Pogs7byv7saH48e65dTnQx1hdV/jKKQj0/Eex/mLkbN8vdNgNbnz9z2+HnK4BJjXWD0col8v4g/WwDWTMxBVyLQV5EueI03X/Q8+Jj4zDPYZvTbjWLlRcmfGwlhNvfon3pAksCzbAuLIsQzGtQEpev9gmLcj+VUkWYZgnnHWEG2RdvgU4Wf19mj3bGvdhWQCXI402X8ycZMm5GsecahRBqXIvYKAfM2Qk3iBHEqhMJFfwNwMo7BZVkYZAqRJ/vpzzZijKfRh6t11lDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELOqEpoDfxa/0Ha3EXr+uZY/Rk4afCnYLqBFDPsFKOA=;
 b=P+oYmSqtsk2GKSSDCIGELLuX1O5QgMnjDQDdJF80q08pCF7gCEAEhkgOuJ0VUgSCvvbM35dA9+8eP5gEptQWpGAteWu1jhJ6NZlclGw4tN9FBLpP5JKWrzXz90dyqW6ZIrwxi5H6OKjhMZ7jMq7hlBtDXB3O7aDZaQImQBM3rGVsauB9yP3VwKis1K6hwn92G+Z2/RzJ8uos7IuI+IOp/6OSHzDhx4vzTz1qf2DZh4dFz8Yf+uhjlYV8EAIMsvoo6DVervzp6BKG08rfG8zrf4ZXxo/KiU8PrF4k9Kfwjv/GrNXp6+UriqCZA1uDTdXFuti/663wi+yBTic9cW46BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB8150.namprd11.prod.outlook.com (2603:10b6:208:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 18:47:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 18:47:48 +0000
Date: Fri, 8 Dec 2023 10:47:44 -0800
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
Subject: Re: [PATCH 5/6] firmware/efi: Process CXL Component Events
Message-ID: <657364d0aaa9b_1e7d27294ec@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
 <20230601-cxl-cper-v1-5-d19f1ac18ab6@intel.com>
 <6572740922eb6_269bd29445@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6572740922eb6_269bd29445@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BY3PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e68413e-677a-4f71-2dd9-08dbf81e2c2f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTqToQ6Fj9lCyR9KqAJel4w2mHGwVug/Z8or0qpTGj/4FlkiBQf9OyzYvhkWhGXJ3ENrLUAl5cDrQyITR7wL56PHEzjM4g9VILYl79K0J71F8UixmBjPEqWlAwgE3OFONuWUPnXOYmhS1QIHVJwR0eM54nTuRfOffLaUOAb6DL7ezXQ6i0oTuJQK+ZuFVNGrua5UeMEc+h/Svx29X0a6T7+s+doIP882XTu0uuW44ZCAvGocAd6dZdjjdehCVKZ2MS6R+VcRWAviObSzYVCfs8SdVGT0LmdJa7HmztPTzv9e/cacC4Cjhdwq9mq4GJ0F2KZg30JGLJWkC+Ee4IxrNNZI688nQ+BQgATn9hcUDw9tTF6z+rSF+4A3k01t6TE07VQQX2Adfx1RVCPQiGYZTPKjRas7tcnm150uYruPVGGiWmrh/axWs4QoMdInWakrP6tawg8d2VX3MdyhymV4pJSAh/wdhNBkWgmrckdBPOCX8KWVvmP6JPRpYtNCpOMP4EeHA+r33YUINbKo5jgO6jzLQZuX47TrHC+8X+GUusMPqym96jYsdl+2k/I9MkZA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(82960400001)(8936002)(8676002)(9686003)(6512007)(41300700001)(26005)(86362001)(107886003)(38100700002)(6506007)(6666004)(478600001)(6486002)(66476007)(66556008)(66946007)(2906002)(110136005)(316002)(54906003)(4326008)(44832011)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DTWv1McIrG2FmnYaWVWiw7jk41QkRaetTzp0LLx000brDYph6fHn1y0HC6e?=
 =?us-ascii?Q?oLpAzC8d+OZ5zSsWQ2Rvdi5FZom8vjrPNwK2+6oC060hXS5QvWqLqBjxWkjz?=
 =?us-ascii?Q?v1eZVqJtx0miL/yOPPe10lGIdNbsJuuwqz1tmq6MA/nycsu1o04wYZ1nYnGd?=
 =?us-ascii?Q?up+8pRngQWuGaQa3szDstqn09mYrRbYJLHIfs3lphhK7EU9Pv0vVtyy6QghT?=
 =?us-ascii?Q?M79TXTfXndz4ZJ6dnX8g3hlhj+nPJAsq+XrQkwICwIlN0maQp55a0dpepfmn?=
 =?us-ascii?Q?RMZRvqSIdKhOP0WmJuch/ol1hpFEtZNvrSmMcBnwDPm1TGyTuLffCkEsOyhy?=
 =?us-ascii?Q?xdcH6hObx1Qe5Nl7U/Uf4omKtkX6a6QU01RynDp/UnZP4uvtWxp7pvM3mrwu?=
 =?us-ascii?Q?jqHOJDW7OezlJ+jDjqgVDCbu8KpafPDuXkQD2PzouvGbW1DADoZQfbmuRs5S?=
 =?us-ascii?Q?UY/sBKmoXjZCA+h3hO/tvLW/0ttBYppxGZIHU6v7ZhcytvLZcxNaZ94Z/gkI?=
 =?us-ascii?Q?84HVgcnpB6lwKnxZ2gyoIm1wfdirqTSo58+uniTth4xRaLcAbHjKTIK36ZHP?=
 =?us-ascii?Q?r9helSi5SztrmO1QttIlHKR8i7RfCoV15ybaNePch5/IKEscUkdDT7XEzBii?=
 =?us-ascii?Q?ajtc0kmGGOrga/3DMyQes+b9/zlEf5S36JkXKTVqAYvOXnKPMwGUijUMLnSG?=
 =?us-ascii?Q?zFkCqsrkGlS8M1AVvg18EUD//XbxPVMziO7UAMDYzIMgxkdmfGZ56SKpYMvn?=
 =?us-ascii?Q?9m1HXyWe2//WhtVkFVoi66NUIpD4x1JHv1ZgPzX385vzR6TilyjF2fPAvOc2?=
 =?us-ascii?Q?vvcXSe1NkXIE3+3CDmDm5LUxe2J9mRf6on9xsPexJYSQZJt2nbcuxjIS+7Ly?=
 =?us-ascii?Q?KAiY6IWdgP4rzH4OcnYL4a0cFXVW0CP6iw33nhc9PDBOMg5s/+BK/GJWdb6o?=
 =?us-ascii?Q?Tyu7yp2Vpelh+3rQ7ybWzT//wcOJ+WmSWcz84RlSgGp6zajEc6PTjdvfkSQ7?=
 =?us-ascii?Q?a0l1gWLKTt0wCg/i6Wkp6k/pyf5ipgwwzwk6FEfnLNIQbWtihRyCWtmei7kj?=
 =?us-ascii?Q?/q7+lAwH/9CbDSYqkI5cpTjge5btvzF9Fa8ew3hi1MmuQjKhVP7sHo0wbpY8?=
 =?us-ascii?Q?9Rzl0hZWUOarcHVMCMypMgfkPBhhthd1MfeFff2jFSvXPbkb9a9aQ4oOLL99?=
 =?us-ascii?Q?CbxQapo754cOfMpJJlCXzyvCWW1VS75S4nRYdBDlYOnXm9nFfqK6uTTgXo/0?=
 =?us-ascii?Q?55q/Ddk/1TqqwcIxo/vIMhN45xQ6OHt5mi+1Y3q8ObdVwSJQWlxdZjTCb7op?=
 =?us-ascii?Q?R+JX5rFK+FKmoYoXZbo7v0zcQOZWkkE2yDfMEqC5f6gX2ltV/5oGbD3wY0QE?=
 =?us-ascii?Q?sD9CVfbFgivuLOuj+Ti/3Zf+cuhkBgLbFr8jD7bjHdEhFdiVSm8+024c4dyr?=
 =?us-ascii?Q?LPLVxIf0RXjJCVlhY+X9jM8u7SdeXoET2vcW8Z3TliUP9P2USu6R5cYwdaFx?=
 =?us-ascii?Q?MZ3oBWkaxM4Ue0Kcmy88LTmHm4uDnRtS8t7829nRKGALd9uTD6tjA9gZGNph?=
 =?us-ascii?Q?mbYTKPWq43V7uOiKSVBzfgMuKFi+aGFwGQqIvWn8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e68413e-677a-4f71-2dd9-08dbf81e2c2f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 18:47:47.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGI0h+z/MsQ6YLJg1oJ4NBu4LSDG+QTeHlQ7E9H7K5atiEdRTEJK+nnmkqzync5v2QAbClV2YJB530rG9y+2hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8150
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:

[snip]

> > +
> > +int register_cxl_cper_notifier(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_register(&cxl_cper_chain_head, nb);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(register_cxl_cper_notifier, CXL);
> > +
> > +void unregister_cxl_cper_notifier(struct notifier_block *nb)
> > +{
> > +	blocking_notifier_chain_unregister(&cxl_cper_chain_head, nb);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(unregister_cxl_cper_notifier, CXL);
> 
> So I am struggling with why is this a notifier chain vs something
> simpler and more explicit, something like:
> 
> typedef (int)(*cxl_cper_event_fn)(struct cper_cxl_event_rec *rec)
> 
> int register_cxl_cper(cxl_cper_event_fn func)
> {
> 	guard(rwsem_write)(cxl_cper_rwsem);
> 	if (cxl_cper_event)
> 		return -EBUSY;
> 	cxl_cper_event = func;
> 	return 0;
> }

This is easier in the register code but then the CXL code must create a
loop over the available memdevs to match the incoming CPER record.

By allowing each memdev to register their own callback they each get
called and match the CPER record to themselves.

> 
> ...do the reverse on unregister and hold the rwsem for read while
> invoking to hold off unregistration while event processing is in flight.
> 
> There are a couple properties of a blocking notifier chain that are
> unwanted: chaining, only the CXL subsystem cares about seeing these
> records,

True but there are multiple memdev driver instances which care.  It is not
just 1 entity which cares about these.

> and loss of type-safety, no need to redirect through a (void *)
> payload compared to a direct call. Overall makes the implementation more
> explicit.

Let me see how it works out with your comments on the final patch.  But
the additional chain state of the notifier made this much easier in my
head.  IOW chain up any memdev which wants these notifiers.

> 
> 
> > diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> > index 86bfcf7909ec..aa3d36493586 100644
> > --- a/drivers/firmware/efi/cper_cxl.h
> > +++ b/drivers/firmware/efi/cper_cxl.h
> > @@ -10,11 +10,38 @@
> >  #ifndef LINUX_CPER_CXL_H
> >  #define LINUX_CPER_CXL_H
> >  
> > +#include <linux/cxl-event.h>
> > +
> >  /* CXL Protocol Error Section */
> >  #define CPER_SEC_CXL_PROT_ERR						\

FYI this is not added code.

> >  	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> >  		  0x4B, 0x77, 0x10, 0x48)
> 
> I like these defines, I notice that mbox.c uses "static const"
> defintions for something similar. Perhaps unify on the #define method?

The static const's are defined such that they can be passed to the trace
code as a reference without the creation of a temp variable.  These only
need to be used as static data.

> I
> think this define also wants a _GUID suffix to reduce potential
> confusion between the _UUID variant and the cxl_event_log_type
> definitions?

The UUID's are never defined as a macro.  I also followed the current
convention here of prefixing 'CPER_SEC_' as per CPER_SEC_CXL_PROT_ERR.

> 
> >  
> > +/* CXL Event record UUIDs are formated at GUIDs and reported in section type */
> > +/*
> > + * General Media Event Record
> > + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> > + */
> > +#define CPER_SEC_CXL_GEN_MEDIA						\
> > +	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> > +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> > +

'CPER_SEC_' is in my mind different from an actual '*CPER_EVENT*'.

But I can see how the macro/enums are similar enough to have confused
you.

I can append _GUID if you really want.

Ira

