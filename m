Return-Path: <linux-efi+bounces-264-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBE8818F30
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 19:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B27628860C
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 18:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3874341AC;
	Tue, 19 Dec 2023 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUMtw7/J"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F793D0B9;
	Tue, 19 Dec 2023 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703009040; x=1734545040;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Iofk6GuEqwdnxfJWfHq83f1hVUmHfHFD8RM+z9xQ9lY=;
  b=cUMtw7/J9rGLGpRzJAnnWF62LYf4J2VqwI9F4KAkK4rCUaKlrwzaglet
   Bh9ml9Va0dUjlFrc6PWeZD7qgvbnjMtLhR8lXef4d6OKf2oDVS7TSyULe
   IZ59f+mljDN1ZvXzgkGLUfqKd5vSgjRQ8sxO9IFDbtYyyRUYiPxPpuI+Q
   BZGABjhXJb4xEOwGjYVt2+p+H1Vq9CmkStXrqlE765ZQgy7izNBrZ3scF
   L56Ai4oJaEgU1e1KhkEzDMEmEhyNeftnmNO8u48YOqkp2fEeP+J7IvZXS
   iRsH9nu366lQlgxWV5AOMFX2PZKtCHdCUoBajudJgxDdE74K1sWma7O9X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2549827"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2549827"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 10:02:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="17687697"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 10:02:12 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 10:02:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 10:02:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 10:02:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 10:02:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKek5T7pZmq3yBEVeul08arL20AhSFnEeS5mHNXtPtlR1dHgHQdcCCjcV6GUZ0xaZJ9wAeR/5tH6TA1K/mht3UBJ+yEbh3EWB+NZSL8M9aDurBVW+1BdBt1iAK9jh52f4tPBxgJxaIPUyAPbXJrr+2iEcYrY6oJCkYAk35xmbwpo1nmrNSGyWUACiV4TnDFaI/Z3lrpZ9oj6wO8rivESAYyd7g+iXIKSQPaLApLAE6thTkRAvih39d5Q97UM8OjEyHF3rqSU3+dBncX5UmglbOZX3eb/I53TJ0i80tZAH1Jf2Tzha57D5lvIqqqi2Rx5HSoVhL4BXkIUY2NqqzAzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI5+4Vb5RRtyWjPsSg0A44BMdY4j8KU/cO1oQpXM8OM=;
 b=ltFo/HqBnqay6sQPjxGrjJwMnYB36STGzOQAn/OuFeQCVEMr8u2Dy1cyp0+XH3hw0MawSJlx6lv0pRm3o+RQKe22OGZCGxUDVERHLZNi/Z7u7Gha8TSEJpeFYp+HPlvHtMBoOaTmmc1Diy1iGRcW9gjHd720eaVeTLJ2/k3faGYBAbSRGlQeTj0ynTzju860g57uWamanfL9VLZvk0xdeyNwEjCGrxYII5CSWyiMFLzct6YJGU7HsvkdpvXOSEIY3nvuwThzEnl+2ygNiOofh/QXmpjHx9c7di40IheuC5r5T211u47/ZUI/FEpzu3+jhyoJdD1K4+ffD1phxTbsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB5137.namprd11.prod.outlook.com (2603:10b6:303:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 18:02:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 18:02:03 +0000
Date: Tue, 19 Dec 2023 10:01:58 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 6/7] firmware/efi: Process CXL Component Events
Message-ID: <6581da96e9817_277bd29432@iweiny-mobl.notmuch>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
 <20231215-cxl-cper-v4-6-01b6dab44fcd@intel.com>
 <20231219142401.00000c80@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219142401.00000c80@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e18dcd-885e-4c06-c9e5-08dc00bc9ae0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +opqDPTC8gMpC3eDNOiitjFqRaS0khwK+2gxwbTDaqxo9iMnvhTpo6oI/AmPkkUMoI7IgZZ3AAw0Y4UEDn1/BfDcvfcPnYopiRgTNpPXk8fnkvurG+cNHJFpWIqqCdQsKpaLIQahsN2rIoWgtCnZie4cXtTn+QrxRuYLxdbz1LLuOfIytoLIGGGI5o1j/Yag0VLvuOZi4O9KofQMdFnb7pyfx0QRU4UOeBZvv6WwJYjLwHXsaRLdV+VXaKszpGEN90QDb2oHFqdoU344m/o91JFVtoErfcyc9cnMMNhKAHT5Q7mEDJGmXWfwBwtLIpdi2KqjiX4H8XFah868pNjqghNjM57JFBAlue5NWoslQ0pNS4CFzv/xvy7TsoJqf4sVdvxSRcnhXqZcUr54hmGu/1BsOdjQAaP1kiLyQSIyc2rniK4HoygReAP88xDegOJyNRBIiVKYxusznJguFoE29InrJhPOm0IYaEB0aWO3zAUZWUrW9raRk9JcWnd43nSKxBP9gS0yQk1ezZO3yi+1hI1ZRGxMdh4fzSxbriSOMmt9mdUWhOtCHlA58TPrjyCu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6512007)(9686003)(6506007)(8676002)(5660300002)(41300700001)(4744005)(6666004)(2906002)(6486002)(8936002)(44832011)(316002)(4326008)(478600001)(54906003)(110136005)(66556008)(66946007)(66476007)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDWEVf4W/JFqIInJ854mpcG4sgABL9KWr7DMhcEW/KgOEPI4BGtlJ4s3vQSV?=
 =?us-ascii?Q?sw04u1Ndu+dPSQjVPwuRgZkEBBawhEJJHcxPPQk4F+0qYlTi5oZadh9Fx7DT?=
 =?us-ascii?Q?vvg1Fq//3Pi2aIvME7l3zKZIpyBlIHTVjaSTmQyBhDFonIt/NxnlSa0NHZRV?=
 =?us-ascii?Q?r3kh1LpNFpN+HWgNlBPscDxWBeHtFc7+ys2ytGzkxtVrYVeviHqGqsVoAuTy?=
 =?us-ascii?Q?eD2257T2P3V+akfXH2ktEpCwwTNClEGMXK/WB24QUQZjGoncZquq0ZsO/b8r?=
 =?us-ascii?Q?TP4oo7rLtBRX4nvXkh4iCw38pTaj3KTeVNAls8AhB04IClVZRxNBdoaUzGHj?=
 =?us-ascii?Q?xqsUDTDIzrk17YiCD3xum8PViNiOcWYVdZc2D2RGvvc/P6uL1mFJmCH+EyPm?=
 =?us-ascii?Q?MWiRcpRvFmyKbZNPbXQ4z4tBJqaOs4FX1U0uzVKyKpDUbw9UtYs9xLlpUUN/?=
 =?us-ascii?Q?ZwV0SaGV8aEuF2WsCd8OvjiQ3HE3ZsuMSuwoqRhbI95jZV8mOXZZtTJupFo0?=
 =?us-ascii?Q?6l9LDG7Sncam9CVkL/k+9T9Ie3T/KsTX9THLmCaXOWD821t3vnjKRKXHFCGq?=
 =?us-ascii?Q?sd3Eq/TLTl2bGNfTY9E510P4kn3Ws8IAjuT1c2E1SnB/N4htblsUqchcAEZB?=
 =?us-ascii?Q?xjUVMd4xaR1gH+HUEqCpA6Bk5mF+Lfi7W6+WtEvJwSOZDfE0RaXN4cRZ3KkL?=
 =?us-ascii?Q?YfiHaZ8MH6ccb8zMRgqx2r8k1SmsAddsBrkmE5H8osgUlYfcugRX4fXZtpz4?=
 =?us-ascii?Q?LOQpWPP8NST8FoZG09RoQvgqi88x2bqpzuxCi+DAUJCT23FGQZfAZc2ZBp/c?=
 =?us-ascii?Q?/br654D808fForF5ZULWBY84xRNC4WtbvpTgAtC16hGbW/T9sz1WLvFId/Yg?=
 =?us-ascii?Q?c9LQFv27SnyhBE6m+0SJRUammVmzcZpyHCQbiq9LYBw+4IbOhMoWcS5AvzvA?=
 =?us-ascii?Q?NFlyQcQDtaJoT28MZWdMYHpWLLAeTWCUO6ta1yJBztFntAl4Aj+H4c05Pn83?=
 =?us-ascii?Q?mIif5HC04tsziK9KR0bmmpN4fADvmrT1P1qCio8gAOLs/sIQFs9OolpMYgMX?=
 =?us-ascii?Q?uYM5J2cAWPL+Qfbb4v0uHRbUYmlEwTYMTjQMRg/TgjHGI5lrsMHj6DkqQAYl?=
 =?us-ascii?Q?jYOIhwfxyrXwAtiKFe27VIiP46EjRyYp94xCIvQlt7pvhe/3Ya6+FDlF/GWn?=
 =?us-ascii?Q?cgku4URujTa+T6uakoaEYm81NII/+9f64l4qFwqgD7Gq7FcaqQA+9EldEZxW?=
 =?us-ascii?Q?hFXW1Gld2hPUYom7ziU4BvjMYYuLMquNCLWywruiopJr3zwtWO1oOIFrZf3j?=
 =?us-ascii?Q?2vxNv0IZV+dDW8x8teuVldAnhQuviT94GtBiTLziDEdAe/2u/6ok4I1g8Wcr?=
 =?us-ascii?Q?TwyHV5t0z8+O4BUTo4iArah59PP9OixM7RcZixp4sho5yC2YBDXXC9l0ghoG?=
 =?us-ascii?Q?8YULChXP/T52HckgtqnNFzG5I7pmjHMAPRAKM8ad/ofubilyx2HTW405C83A?=
 =?us-ascii?Q?avRuhFe9JtMPuXiv1nxTRxD4nEDxqWwLHk3DcZpPAUb5a9nJLgkh4w854hNO?=
 =?us-ascii?Q?lMW4L/2sx/efUSh2v8qpTKjb3lCK1xKosxauC9PTIMzXwJWj2qbY4XgffyQk?=
 =?us-ascii?Q?cpJNno8qREaiYc3mbh2mCbgPKIK20fVuCOqybnUuymhi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e18dcd-885e-4c06-c9e5-08dc00bc9ae0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 18:02:03.3322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhQZb344sr+6nmMZCiuUtapC+xRPpdjTftMjrFmStetTZPdPwCvri7YcZzzTtccYyrFf2mYkUBOq56jj+QmaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5137
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 15 Dec 2023 15:26:32 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:

[snip]

> > 
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> One trivial thing inline.
> 
> + Agree that notifier naming is unwise given what that means elsewhere in the
> kernel.

Changing that.

> 
> > diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> > index 86bfcf7909ec..71f27b3e2810 100644
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
> >  	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> >  		  0x4B, 0x77, 0x10, 0x48)
> >  
> > +/* CXL Event record UUIDs are formated at GUIDs and reported in section type */
> 
> as GUIDs
> 

Fixed, thanks,
Ira

