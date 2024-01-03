Return-Path: <linux-efi+bounces-315-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B304B82383B
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 23:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B752B1C25CDA
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 22:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358FC1802B;
	Wed,  3 Jan 2024 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMTeKIDF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA3107A0;
	Wed,  3 Jan 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704321012; x=1735857012;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RMvCuVlo/Y1WHk5Bj7qbOwa+Mp/VSaZKBQfTjdOjIPc=;
  b=DMTeKIDFlKwvAgTYUzw8kDBvhjJUNytUKfNzAs6nyrdnsUbVA68hr+/W
   ZhoNbm9kc/JAJ5N07oCP4ktkv18xfD7n2qGDrSz5iqC4oWemhvgL7X8wq
   bUAgFsG3p42u/aESFAVuGf6Ho+oMD+YRHRaKxOj6XmIjskgmmyA1GAQU/
   IqFWtnOgP1i2xwDqfU+0BeLVs9B2gtuJC8Q4rzbbzNFHF8PRFBF6f6VBD
   6P3JnOAuYLCGmUWO15gHdJp4HM0gKmiVZtEYi2TTtAqQZ3dPorXlYr97J
   zZCW3uZfyRt53zurtbYI9m0FtvvobdujqQ+13pa+/pPZYsbzXsnBbEYch
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="377234437"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="377234437"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 14:30:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1111507504"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="1111507504"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 14:30:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 14:30:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 14:30:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 14:30:09 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 14:30:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTi4p8X/d5Q4UnaNkBJAK7P53OSDASTjBRJflynmzRJfHcsgOsvC21U8DwT0SXVzytyTTVrMgtCqPaC+cvBrgT6fxJDOpQ6YxtCKc+/4rPDTnL7rrnbHERBj0w8+IeH3qall8+hV72MpGLf3DjLpuxil/IMFOEECNXdyu8Fy1S+Lfp+h8TXtCjg7GSyrOngok5AOzEfpkQmnDdkpC7JOUP0jXV1G1XolCP+MT3niLXpL2eTncVdcmSVXiSYl6MBjweBhUqxHpq3Fnahk0bDjkbQWZsBGkZke2W6FOnRDO27jm1a+n6/25FXbMtASZ1zizaK/dULaUwWhzNu+/yKCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUq6oAOLIEbPQNdcT2OImfnddYVbBVEPG3CSDcS5+j8=;
 b=PDAjO/1DJIkbKRIrhD3xDcTf4ZyX1+pqmO6fUh6eS+cBUXXoGb5A8RLJMf+r9QMKkqqF/sYCw6yt7vEcNM4zBhi4z20Jqp6uJ5Lc/e3rBFa6VLUJ7m12b61JkK8tksiMvg0FpHn11TeUfjTsGFVsQmm5oVO+5SFic1wcoVf58Xc2ToRRfbA/edW1XcDOwP2Gsq8kUS1LtlGeisKOiiIfG3LM2lh99bVvamqtcr6WJCMjeB/Fi5SFjIdPGlgafYJZPSmyC4ME9ENpWJLmW7bnXoefMVKoTPjX5fkrqPpMwpndLya6o2jvW8GcMhaJb/+WlTnRYSF6JCXYyv0G8Zcslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Wed, 3 Jan
 2024 22:30:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 22:30:06 +0000
Date: Wed, 3 Jan 2024 14:30:02 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 2/4] efi/cper, cxl: Make definitions and structures global
Message-ID: <6595dfead80fd_3ec8294ec@iweiny-mobl.notmuch>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240102150933.161009-3-Smita.KoralahalliChannabasappa@amd.com>
 <65943a1da3368_151dc1294c2@iweiny-mobl.notmuch>
 <e75e6c3a-c84e-a64c-d438-cae15d2e1f62@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e75e6c3a-c84e-a64c-d438-cae15d2e1f62@amd.com>
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3e0cef-dd91-49b3-dbac-08dc0cab8946
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dy/IdHJ2SaVP5Pxghp69d5U+4+qQlIiflK7rqnMtfKgwkHWdh3E5+XHS5HwxcdgE6n1T5JtZ58lrNx9GS56xtGOCtk0tR/XOrIrNFjW9+KxhSOn5up1IE+ysEsFX8RWSKtOHJxacrnbFBd7Hdm3zK60zS1BLppqne4cma+KYWxtfoPGOSHV8vUF09lQh8LL6VM0fKKgqWpWqovlxNSwzHe2URcrRJ50ZNT59qZ7ZcUU6PfnJZPqGpzOzCsmB2NICPWHgUO5zlU7d6SL95UMoAuMPlYcZNT8nSqgABNHy0v7ABIfLlYrUraXCWw0Qa8gKCZE/ZK+MIX4LgYledUqmEQ8eNQyd+wEqxyEs9F3RHcsW/758wKnKibJWvpffpRcmV2Ly2ARncNmEeXe8YRiQm7z3XmTzOZE+Qk5ays7sC0mnVJgr4cnSLzTK4yiv/c4WQ0UXJOM+YysuW7Ee/nKzg+BneKuVXmzWemfjkCiDM//jteLG5YD4g6XBWInDoOSU7QoZ4NYVXD6NqfAkuJuUhACzY5hVJs9ct4wz5tLdwbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6666004)(6512007)(26005)(66556008)(9686003)(53546011)(44832011)(66946007)(5660300002)(2906002)(54906003)(66476007)(41300700001)(110136005)(966005)(478600001)(6486002)(8676002)(8936002)(316002)(4326008)(6506007)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5tG4rdXBxcC1jQ3IBvhn09QdpbCPc4BheYsEdSj8V9N81XueI+msgJx/UCDh?=
 =?us-ascii?Q?r3SPzXUpI4EIImHV53BmGybakHDtFa/0cMk5IFr0clKV0V3YwtBHIIXgU5CD?=
 =?us-ascii?Q?Sq/qTF065HSmmNr4HGJAkNhC7mZPZwzZStOh1uKosy9Bq8r26YIDDBeoT2HN?=
 =?us-ascii?Q?clRZo8eIb5uURnErJAKBeao3SCYSKlLcVWxMj9EXfd6JAkobpVWJp6ucV0hm?=
 =?us-ascii?Q?2UB1lrEAS0hnRQINF9zLXVjmvcX3CBDH+WNHj8uCTErrrE1py+O2g5NLk9F+?=
 =?us-ascii?Q?8p4Hwcvk99jOfO3MB3sfZMnH8Kz2IWBuzQ3dAaYExIQRa1YYDou28rWKqqSN?=
 =?us-ascii?Q?V067C9mvDSciOmWpthYISiE5EuTx12JBStRiCyvFfQoXmVfjYBnckPB1My0z?=
 =?us-ascii?Q?hToUJFkST+a29/jWGtT+unS0mC3ht9B+pDtfLoFMpWOXsoIUaPggIYG06FqS?=
 =?us-ascii?Q?Bcmm3m77tnk7d0yTZykjV/FXmua6yF2w7WN4q67Lap/77vuhyND/aZrSf3vs?=
 =?us-ascii?Q?uog0PAxe8dKhRC7oZxHXunTZK7Vywc1msrs6sRMF5xvKt02NEwMoCoxJXVwg?=
 =?us-ascii?Q?ufxIZsRuL3zh0dH0k+bGFJAJpuqwIRiLqvHoN/ytyAxzM5w879Icx1wtZX7L?=
 =?us-ascii?Q?69Vm/u1Qykc10zb0C+h1YPFGMmeLSTNPHjH2E+sF7i+xsghLyi9/tJk01n/K?=
 =?us-ascii?Q?nywmNLSrLy6qHAtmnZtavnzTh5kAhl9J+6eYW+RNXa4Ii2eQ4mkM9KLLHYU8?=
 =?us-ascii?Q?/EqV5dBJOuLVviRVujqSYeytYmqg02PeJMNieIYXMwsg57LWLll4kOIzekbg?=
 =?us-ascii?Q?vAYBg/TgFmT8EMVup8P6tSU1sRKHDd2RSYOofVEg5QzRvAu/ksE02Uyt2rHz?=
 =?us-ascii?Q?fmI91cfQqCpbqrx+fax8TnJvd++6U9cD6kIj2IQv+9OofclG/Hu8zJY6Q4+p?=
 =?us-ascii?Q?/TRF6Jxnh8rNThbxJHBCaFDEcWA34eFqNbctNWTpdnTeeJg9pjvQAl+EjjJM?=
 =?us-ascii?Q?3rQ8V++RH7C/fzDaUPtCa1ZDx5iTnS+4MP4L55HKiPBRh/OCyvrz8xFyKe9h?=
 =?us-ascii?Q?ZTxPYgKeFXoIGAzETMzUJPrsy/uVUjQQGsTK4uIzTqsmdHf97wbatZ4nA/V1?=
 =?us-ascii?Q?CKiL+lV99HU52fiKWtW+XaZqD4Iu7UMr0/QzZxplr+5xyzx4omiGAXNP2T09?=
 =?us-ascii?Q?BZYBBhY1pYgr6ViHbbCg7UxOMJisdrfmb1Q4d/H5xsfin+Wpx0o79vLFaXFV?=
 =?us-ascii?Q?1ly7OC5spAaE6CzXtaEuTCV2NcAOS+DTGi6roVZvbxzv77UkA7ULVbFgWGzR?=
 =?us-ascii?Q?2gYqOa9WMXuYKx+IwdsdEv789sUNNNUr+vazVheguZhbav0bjDWOBMMtNVAj?=
 =?us-ascii?Q?Ck96f8AJX3Xnk/3dNaOA08mQ7/QgIaHnnc4MZZYf1rrCggb4jGmtibWcWeqP?=
 =?us-ascii?Q?xK38apGok4MDDGrfwQjfv9+sEq4Emqu3/NkG5p4tIiAwukTWrUlKu85273gx?=
 =?us-ascii?Q?lzPaNM+PpJSO9ZQSXr2j/hQ98yyyIVuSH41pwymPjGYq/bamFLgXDcOnoX+m?=
 =?us-ascii?Q?WbEsV9XztBDxFuikmtR0UyL4F9kULFLMqx/t3wUE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3e0cef-dd91-49b3-dbac-08dc0cab8946
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 22:30:06.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CShRjLYuQjmvjJboM47tYc6PAPRdAftnD7ofd01CJhP+r3sJnfk9fRM+2I3cjMJEPkhiGjEIDUEPTtYyZoysoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> On 1/2/2024 8:30 AM, Ira Weiny wrote:
> > Smita Koralahalli wrote:
> >> In preparation to add tracepoint support, move protocol error UUID
> >> definition to a common location and make CXL RAS capability struct
> >> global for use across different modules.
> >>
> >> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > 
> > [snip]
> > 
> >> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> >> index 86bfcf7909ec..6f8c00495708 100644
> >> --- a/drivers/firmware/efi/cper_cxl.h
> >> +++ b/drivers/firmware/efi/cper_cxl.h
> >> @@ -7,14 +7,11 @@
> >>    * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> >>    */
> >>   
> >> +#include <linux/cxl-event.h>
> >> +
> >>   #ifndef LINUX_CPER_CXL_H
> >>   #define LINUX_CPER_CXL_H
> >>   
> >> -/* CXL Protocol Error Section */
> >> -#define CPER_SEC_CXL_PROT_ERR						\
> >> -	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> >> -		  0x4B, 0x77, 0x10, 0x48)
> >> -
> >>   #pragma pack(1)
> >>   
> >>   /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> >> diff --git a/include/linux/cper.h b/include/linux/cper.h
> >> index c1a7dc325121..2cbf0a93785a 100644
> >> --- a/include/linux/cper.h
> >> +++ b/include/linux/cper.h
> >> @@ -89,6 +89,10 @@ enum {
> >>   #define CPER_NOTIFY_DMAR						\
> >>   	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
> >>   		  0x72, 0x2D, 0xEB, 0x41)
> >> +/* CXL Protocol Error Section */
> >> +#define CPER_SEC_CXL_PROT_ERR						\
> >> +	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> >> +		  0x4B, 0x77, 0x10, 0x48)
> > 
> > Is this shared with code outside of GHES?  I did not need my GUID defines
> > outside of ghes.c and further becuase the events are defined as UUID's I
> > chose to keep the GUID definition as local as possible to ghes.c.
> > 
> > Can you do the same with this define?
> 
> Actually, it is shared with efi/cper.
> https://elixir.bootlin.com/linux/v6.7-rc8/source/drivers/firmware/efi/cper.c#L602

Ah ok.

> 
> But this would be something to look into. Should we continue to support 
> logging from efi/cper or just confine it to ghes..

I missed that you were not removing the efi/cper print.  I kind of thought
that was part of the series.

> 
> If we just log it from ghes similar to component events, we might loose 
> error records from RCH Downstream Port and other agent_types which do 
> not log device_ids.

That is a good reason to keep the efi/cper print AFAICS.

> Also, I'm not sure how useful are other fields in 
> protocol error CPER, the ones like Capability struct and DVSEC len etc 
> as the tracepoints doesn't log all of them.

I'm not sure about their importance but if they are important I would say
they should be added to the tracepoint.

Ira

