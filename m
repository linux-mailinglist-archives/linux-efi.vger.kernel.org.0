Return-Path: <linux-efi+bounces-339-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9FE824B94
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jan 2024 00:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73311F2371A
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 23:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6B02D042;
	Thu,  4 Jan 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+Cy8w5P"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636B2D021;
	Thu,  4 Jan 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704409230; x=1735945230;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eUSl6twQDRvrorNSmJ/BZ9tkh354py9VtT/zmjpFypY=;
  b=X+Cy8w5PBs4Bx94DGrPqr+cUmq5jcTF8e+1LzT166/EGsQtWSba4s3el
   /kOvFXlxSmHl0puMl02R39iF6VgDDxDCeqdXPzsKchVwf92XxW5kAvjJp
   cQMn1RyJSqE/k9uCqLR8KfI+F99YjvfEPAYIArH8RaLiaZrJxAOaAhfnj
   Hh70hyXZC7ExgdxavF5EfRmBzQiuSN6A4l7ZYp96wFlEZPkVDCK+Ewb+1
   HqMj0CP22fbU0Vbz5CRN/aGUKWS0Xu4v22RcEvaofakV+8OoqFz1Gjr8u
   WcGGRSlhYBbsMcg7n29LoFQpt9ejS+hRVimKZg4vsJbhkmj6PFh3s+hnW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4753067"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="4753067"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:00:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="903974938"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="903974938"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 15:00:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 15:00:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 15:00:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 15:00:27 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 15:00:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFFHK21s0tHS4Ge/8WQzLFxNaOXkzsxVHuBj0baK+5qO9alu1jjo7q9LTempxr3JF6DBc8yVzwxTk0Vn3wQ8EP6LHBq5dEymWmHLqZNu/dSa/APWLe6GBlNHQbMa5PfDZCVK+tS3JsJK9gS0MYFqOC2phhO0yygZorwl6u5yUhWNp8w9sOIGyX8tOpmXtcX8vPB/76TPxGEKiAra3x4rCM6GPoaUvOpQWIISdtIXj97bxmEcCWYnv1JKmKbFOoSC4w6DoM37cYNmD3f92JVu+GRDRLFD4nvCB1PjnxyhHxtvE+pIF5qzCnizo7VJTtu8zbz8RW7duedSz6iTl5Vy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d/mMwiNgC8br4rhhsDvUrlcQ5z7d0yRzRjFottYu+U=;
 b=ZF02Uvj1fE+rNbubZ23Aw5vokVbpMDrUfoVmgpd4v3PF6GitCcLFDdhM7p/J4IHVr5O5u8/UIGR8VHj04m5XV3MJ7cjnoo6XwkcI1SekjUQMmbtdkMqwSDnsyzYmno9NRv8Njo2rrOeJLn+8+4RJbagJ9B2yKFt0toieKtPxL0EQsSn80UNaMR6cHIjKayG2fVB/MQ2JJvRGbXHLx/H9irATl9BjwhweHI5RGZNsjbBCgEpFWKRO4Tp9gmc1lKvjGnpDNmOmeR8PuHAvexe07apZbHMnuJdeU87gd9itB7zzNDrDnZNsxMqul8I9vvQsvaL8kSQcxDJXVla4vZ9f7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 23:00:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 23:00:25 +0000
Date: Thu, 4 Jan 2024 15:00:21 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose
	<shiju.jose@huawei.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 8/9] PCI: Define scoped based management functions
Message-ID: <659738852ffea_2dc8629466@iweiny-mobl.notmuch>
References: <6597275045fbf_267e82949d@iweiny-mobl.notmuch>
 <20240104223725.GA1829769@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240104223725.GA1829769@bhelgaas>
X-ClientProxiedBy: BYAPR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:a03:80::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: bd327c27-d7b8-4ac1-6a67-08dc0d78efe6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUj94XmQS5lz82lwwAxamCo08huL1siUeBf+D9wrWrNNAkbnGyRcWmckEsmLF45wMBPga+ZPk0uGRsYtj9LTe5qGQVt5cyoX4CCiUv1ayE2zYgS7BoKNGDr8sE5/+5bt2bTmtBLFkqPQPq3ESknfcTx6qdiMYiNXmS1U3vY4PuJIad09c6o1yfBQ9qOvqw922D3qgByyBNosyi2/W3ao+OQQ4/r+KzAob+zMCWwfBL02ZA4e4yuigmid+sqwT2QEz6iXV7Zfm5pcc5YEHD8p/h03Z4dl2YTAGJ1O//aoAqj1lhQSQIbmmuoKPd9Sp9tgTYhq2ppI0a4H6Y3vu5ieMliTqoPIxs3EhXJPNR7XD59oARvCuHbOVNccG39jSWoFvXpqRSh/CgeW9XijCzgaAnc3G0DsinIRR/WvTgfZ88jYCRSQ+laWCbaVBuZiUEfgYaDeyC7vxKCI9o6AR8O8kwcG3W9U54A3xit8yzxvBQtcHLGbpI+I0ASk9/wsyPuekuYwsuC0rblHsWLCxKL17y9UQQik5ivoEgN0Hh3FP2uv+PRJVM0y4CWldPyeTovr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(82960400001)(86362001)(6506007)(41300700001)(6666004)(6512007)(9686003)(8936002)(8676002)(54906003)(110136005)(316002)(6486002)(478600001)(4326008)(66476007)(66556008)(66946007)(26005)(2906002)(44832011)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8n6VvNkvJghk3ZwMd+idfi/XC5Kd/WorD1pMl9sxt4+yeajc1I5IEBBxxSLW?=
 =?us-ascii?Q?pzJCG6tMI5qXk9Lk9vuL8wO0clX9XntSAwR7o6x+Zskwq05DEmFQn5mR3CtN?=
 =?us-ascii?Q?4Q9JvIPsl7BVYlj5Z4QKNk+RcD3wJR6zNaSHhvWf49lgC6e558xlbyn8WpAJ?=
 =?us-ascii?Q?cqrh+lXPIqgu8pIZffRLsPyI/d4vmxQnkXinA21SZILVz/DYDc5HiJu9TBlC?=
 =?us-ascii?Q?u8fO+aZTYc/xrgHB68RjymS6b/RpSdDgv9FSQpyYEEMAHLvlRG8XiceB11x9?=
 =?us-ascii?Q?pEBFLpLZ5GBAjvRJBLVLKzYvHjKqpINDUr+j2SZiRA2Ke4YCwnVQSEBosP9F?=
 =?us-ascii?Q?uYKY1oS5z7QMCRpiJWgX2clywi0ouzi3zwb2/TPx/xvdt6rYDhXJmoOporBi?=
 =?us-ascii?Q?aK0sGnyHMii2+IoYzWXbI42w5iBvoFbvoFaJOfPyWmAgTST76q1ftBFC29yg?=
 =?us-ascii?Q?+y30g0ANT7OAhIu3ZqHMvSUjMcXEghIQZ+B5fXexj5jRMuiUSu2JmVq4PNyk?=
 =?us-ascii?Q?7F0Yk33mWzCgWkLp2q9IK5F62QbmGL+6I7sbegwhiqvii19lRPJ6GMLfBGzX?=
 =?us-ascii?Q?by72LKjkVeqdiL6zrng4tzwB84QZuKywZrJ8JeuLbClGgOClbw5Y1qHHSTB6?=
 =?us-ascii?Q?JnWN5h/y9SzCYmSbGX3qnx9lHcOiAIyj0q9DJWH4A2UXEROHZpyJsZtjQWbL?=
 =?us-ascii?Q?JJgr4Ab74jZaKI+pzSDfXWE3yZFz5DH2Ge9EDN2g3MfY5Daz/bnQdrSi53+E?=
 =?us-ascii?Q?7zrikXtop/njY6oYuFNP0eaMJ3otLmJ4pseQ1W7Yfx1LvAcMFflMiC83dw0p?=
 =?us-ascii?Q?ot70wH7wOhsqclfgt+TfV4ZOSeEI+6zUQQAIekRZEaMJi7lMQYhtIX0UC/Sg?=
 =?us-ascii?Q?VbWrae9/IjnehbrwuDpOuRBtpJu3rvqVB2XHOe63ZeWuVeOPFkkQvFsFaab6?=
 =?us-ascii?Q?6eewK8i5pIbJ5QdOQZB3BqR4kzP0sZ3ZLBtFckTTgbntGxRMjye5E+hUZ2Fv?=
 =?us-ascii?Q?cc4C3yRRk1mnaaQrth4BqL+vuuiQFqqPQMSv9qBs0VfPyQ7J+/ayHJ/4WYzl?=
 =?us-ascii?Q?iB//MGryxRqfUA1H8IxbpDIXHPOmXIRSqhazoUrPZvawyMD5l5J2I8hkqIBU?=
 =?us-ascii?Q?aqlI15al0xCsXunIo0zjWGz3ZNChPb9j8B/8DbVkCIAMia1z51t+vN+s9t/8?=
 =?us-ascii?Q?2aW/D0qga2VloLlv0CvZ4DPHW/4Jj2NmJr+G1a2u4vJxZoD7m16O0VWdSlc5?=
 =?us-ascii?Q?M9TjGmWipt6xXJZDuzHgoQ2Dpfoq/Lvchr2RlBoH2TA6W1fMJ1yZ7fZqkDkp?=
 =?us-ascii?Q?oPZO8+T4QyOfLAQyLiWxRupEzaZvdC53Vp3PGfm1GzuqQZyrx2QTDV80kWNd?=
 =?us-ascii?Q?L5q8E+zaA75jKXWJEW2gA7tU4lLJubEj9ZgZuEk1/SZl7OYp4XNun+FeM4Dg?=
 =?us-ascii?Q?oDramcYs5b1h9IiWkRtlh9ebz6cq/EHt+8Nyvw1i8TIlgIQjP445np5vlMRX?=
 =?us-ascii?Q?ec0lrIrIbLNNQfhiNktlyutDlDEgm4+VpwCvWwRZKUIhQS1qNj88VbbQDWNS?=
 =?us-ascii?Q?CEd6+CkRv5Zx4WtFiRQ8uHMCBeIWgAnpOrF7WgAl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd327c27-d7b8-4ac1-6a67-08dc0d78efe6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 23:00:25.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07iHAjJckr+M0veKpDGvaDh54X/bHOcZDP9kaBialIWU66GTJM8h8ev31YpxAieqzsaWCSyrjmOijlSv//RW/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Jan 04, 2024 at 01:46:56PM -0800, Ira Weiny wrote:
> > Dan Williams wrote:
> > > Bjorn Helgaas wrote:

[snip]

> > 
> > Also in this case we need devfn assigned first.
> > 
> > Is the above patch compliant with current style guidelines?
> > 
> > Or would it be better to do?
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index b14237f824cf..8a180c6abb67 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -975,15 +975,14 @@ static void cxl_cper_event_call(enum cxl_event_type ev_type,
> >                                 struct cxl_cper_event_rec *rec)
> >  {
> >         struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> > -       struct pci_dev *pdev __free(pci_dev_put) = NULL;
> >         enum cxl_event_log_type log_type;
> >         struct cxl_dev_state *cxlds;
> > -       unsigned int devfn;
> > +       unsigned int devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> > +       struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
> > +                                                       device_id->segment_num,
> > +                                                       device_id->bus_num, devfn);
> 
> I don't really care about this specific instance; my comment was more
> about the commit log for the "Define scope based management functions"
> patch, thinking maybe the example could encourage get/put togetherness
> when it's practical.

Ok thanks!
Ira

