Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726177C7A5F
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 01:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443065AbjJLX0X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Oct 2023 19:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443006AbjJLX0V (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Oct 2023 19:26:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BB1BE;
        Thu, 12 Oct 2023 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697153180; x=1728689180;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pg1MvHpvDAODgWLTPHGAmwuGuQwXtvK/qRju1pFItuc=;
  b=G2LOOVzFpxdGvcVMLCzlas2fbnePzllAQXzsb1Ive2Bwj/NZTh/tlLLL
   iHat2U0w2uAcEwkJzv4EnCrz9mEOa2T3WyEH6D1M8xVeV/qZPMNJ7tL/N
   AzRpptoTa5ocAmY4aBTjgUMSAFlPbepq5TwONGCOiOncpNuQ7nTxN6hTt
   SiyViBSDTInmnvAeMiNZZZXHPL+AVeCZb9zJ32OBnIlgslzBsiUjR2dXP
   6yakWyjAOaKnbtL5uXNs3tASexGv26en5t8WRZTH10xHuWLMN15CAtZga
   FGvsm67CZ6A0ZEtxlWvFu5dQY4RrKLbhWsf7GvtGN94da4WebyZsFstG8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416114158"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="416114158"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 16:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="783907010"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="783907010"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 16:26:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 16:26:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 16:26:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 16:26:18 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 16:26:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHOwSQtVDwtP3QA7Q/oRzK9/l2XckR9XKuhCNTA32n69fqriIECGa3JkwfNs/Vit3eAtImTPAbrbn0VwqNjtIPH6EBoId2GNy9/u5Xqorn9KQiU+EZmgOf9oePscfKGX7rL6bWMpNeLJSfXXlHqm1EMQiTEWj6J0OjSfSZG9E/fgZaeIxR5B8lo8YdTpz9gynxC7KSmdUixa1Pb4d9ExanOf6Fow6MycEGz7TRPmGtLc1PTUYdRQI6OzCvTIAlNP4kDlG0qDExwex3IDsTaN42jaQmWb/rjHJ9/K4dCjYIh2k3rEL2mo7N2WZEMiiTvFVA0gtTDjxXZIZINZOmyU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb30Wc4h4XVlltel6nk3tl6HqRSZQn1nhtNSxHxj2CU=;
 b=ipxxKeAbJ9MRQEgJ6pDwRTfPxo3PtlBBWXxGZI3lm0kbyukWSQtk+Bl3cvQInIr+g+Yi4/bZMi32KCCVkNyAp/SS+CZF/ODws82BtaqRdSlRIZaZdXt1Jivr+kt1ZCPOKJhWojTd7/piHnis760omqXAmRLJPCivTddk7LIbj27iwFWiJL1qIfOJfbjQPO0VYDho5uGVSexxmlUD1pAwQfAwKjZ72ApP5vJrJ3/v/2ZaACzkcRRhSNBTjjDWktX0q8hsex041s0EQ/A6cEYOlNa7zkqGnrwaxuOoZnN3StUa61Xfih6Q3BBWKt9sHITSBoXJnTtlybyBXXCQAlfmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ0PR11MB5893.namprd11.prod.outlook.com (2603:10b6:a03:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 12 Oct
 2023 23:26:10 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::66b3:c77d:472e:4baa]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::66b3:c77d:472e:4baa%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 23:26:08 +0000
Date:   Thu, 12 Oct 2023 16:26:05 -0700
From:   Dan Williams <dan.j.williams@intel.com>
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
Subject: RE: [PATCH 1/3] efi/cper, cxl: Decode CXL Component Events General
 Media Event Record
Message-ID: <6528808cef2ba_780ef294c5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231012230301.58500-1-Smita.KoralahalliChannabasappa@amd.com>
 <20231012230301.58500-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231012230301.58500-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::14) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SJ0PR11MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 505b3a88-80c2-4589-fe76-08dbcb7a9d0e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8LlbNj6VMXqba/rs0kz/Sz50iAspDmkedW0femSw7KOqRsjVQGREibYD1V+aWFPlpx1UVUmiBFsCeje+TNcCJGTbiWewFcwJtjZz8ijS/aELnXnuWCZVnu9KG8A/Jq2+DOQWOtU+epMS10pqFQcd2rPcAwKMf3uKqfky6LywgPmdIqqwQABheH5EHBbvJSVMoAQGTzY4nY/8IvIiG6Pn5tIFYjCL4G1sE8WrV8y5Cym/ZWznH8aXx19gx3CPlXqh5a+YM87sSN1N6Ex+JkB7ssAf43V6HfVv26ipGFNA/8OOKYWbfLLsadE2sWqtq5aD9V5XVW8lU8iiWvcj0H7fDl04Ws7QCGGh6Bl9tqASvW7F5nM+e0AdMIiBAkgLXVbnymwcOWGQanccjaL4RrcOQPzWdbrjxUBWDRU8hucCK2iS/iMgVuVNbOrQ1yhYKdHjG24j1NKyx9Fr4D98GdcCmjexJOrIB5P9hah6+GPCKAC2B3cUMOvASj3JA0C+SAUexUt4e6fLtlTO/kuXw5sXU+wW3czSNNt3xeBVRD2120bXe8UUxu0jr9VBEF5chbs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(9686003)(6512007)(6666004)(478600001)(6506007)(6486002)(86362001)(38100700002)(82960400001)(2906002)(316002)(26005)(5660300002)(66556008)(66476007)(66946007)(54906003)(8676002)(8936002)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MSTPaijI5l4KaiuxInNyb/0zSFoBJthBK7orMHof2NK6Mvh61l84N/k7oaYH?=
 =?us-ascii?Q?4gIGtxziSNV7HOT7R/y4xlWlFn/Ulx0fz7o6J46LxM1dot53PA3DsTaFFpKK?=
 =?us-ascii?Q?bpuhlkLCKw608hsozwegmp4puDIAC9xpC2AzfuSdMYSk0/+b/8Snk7OC/ntS?=
 =?us-ascii?Q?kSs03I3jUNw8Gdi02PQPA4JyF4f5hmHNzZzELCPskHq8XpzJ1cmVAE0NwXxZ?=
 =?us-ascii?Q?nz5S+5iqzG/nqGXnCcNeJ+3KxLEzksmD+3+o0XKklP0ALiz7EXALgxRguHEP?=
 =?us-ascii?Q?+nROqV/N8dOcrd6Cqsm0RUQY7QO1JtAF4b01UpzZ/04ZR0GfE+80kOQC2/nv?=
 =?us-ascii?Q?aavAcV3Fr3SNtREDE29eo2rf3pqN399J9/+tnW+CMOypRTgRCWx+YFxSrD2x?=
 =?us-ascii?Q?76/z8j6q7xGiJPotqQTPci+LfR7/CyDBRxTjz/FsLl2GwxIEPBR6QTA5xi09?=
 =?us-ascii?Q?5av0L1UDj5RZ/onQTCyrS0V1iemIQopisjV9cVRpBH5DbZmxhslUBRarK1GD?=
 =?us-ascii?Q?QWAx8Rj53GV1AJfmFXHJPdK24xpJY/O8w3jZyaKhfb+haVowJg2recj2CmJQ?=
 =?us-ascii?Q?oL2iY0ZWYAj/vF5/TyGpxh+Fi5iyYsAETEnip3940x7tFDtYtKSbEh4cdJnQ?=
 =?us-ascii?Q?oha/WUr4oK7jLmjHt9p7aIq5XdBrA5fkcqQ7zngVnRhdtGrIaMIG+OeQs5t0?=
 =?us-ascii?Q?hK9uh2raKBAl2Y1OfXDcjDkf1tcgfZjucD5/Wu/Ed2IUFTSqxyzqWRxRU52F?=
 =?us-ascii?Q?ONDr4+MTERx8wze9PkmO0LSm/Fj+80Za0JRnFttR0gMXzhCxqe9AiwNfU8dQ?=
 =?us-ascii?Q?AlJfVXTNZQxvaCVIpiUeoLDSyP7ht9/WTBwGOz9Qhcx9GazQzGISe53uFbFv?=
 =?us-ascii?Q?ODivLnD8Nb2zQ7p3vudhxCzxb2AJXXM3IwgGdFAU7mm8VOVNBaD9+cM1xt34?=
 =?us-ascii?Q?KA9lq86nA860CmHOb0H1daiL8WBbOF4bo97g6mABH26/3HOSSBDGk/RJk2zp?=
 =?us-ascii?Q?54786+yaiXttitB6jqed8Spuxhwp1wtSmiPMqxAI6RewmZMeWB+7Pfk5DSZY?=
 =?us-ascii?Q?m9HcdOEv4nISePFmzWCCHTVdkXcp1GkL2+9BPwBVeV/Ko3VF5YRnbowCD/aL?=
 =?us-ascii?Q?wb1FFYB3qUILKtBHOudbfZc2DL5p32xUjrl7JjsYSgFzTMoeAzi+W5Rs3pYs?=
 =?us-ascii?Q?5oyWJknWqnxss6qntxXZIOjdC4788Ua/WvYA7gGFjF36QZetDrfT8RnTDjwQ?=
 =?us-ascii?Q?cDLuS6m1aWUm9PrDERgA0ecV+dQ0Al0DDIFHqzsHRfr/JZs0Z9McNOtFwGKd?=
 =?us-ascii?Q?coscsAebx0xm9JI7U88aoR4Y1zyYW07vbs7T34MXgWYzLJ9OElnGA8v2/wr/?=
 =?us-ascii?Q?0zMi8N4qCuoou/8Kao4DobPajTpc+tJs3ApnU3yFdxPzpp5WisljZzJyuwlP?=
 =?us-ascii?Q?HNFKRo1e0lIMZvjS6nPkHOYMYfzL+hrxMNADoo1cIlSS/vEB6hsDbZIpUlZ/?=
 =?us-ascii?Q?o4ZYeF8pBtDaT5tNozcobojZBqD0CnzFowoq5mOgDCPXAkNTk5rTBUmGYvkG?=
 =?us-ascii?Q?K3XM2k1+BJtpwZhFpJbB7TXd51zTqAzVXDsxQhTa5ZjzgyOLC/0fn6WMLmgR?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 505b3a88-80c2-4589-fe76-08dbcb7a9d0e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:26:08.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8cUeGJloYph9GLEDe2lD3ikMVWcwISWq1JJT5OfUBacPLtieYpZz3ybmSYWdAjoBNiy1xkDDqCrFKnK4OICfYm054vwPZJgJgDA195mvEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

So I think this is missing the rationale for the code duplication.

Specifically, who is the consumer of this parsing relative to who is the
consumer of the event records emitted by the CXL subsystem. Given the
CXL subsystem event parsing already exists, and unlike this
implementation can support DPA-to-HPA translation, why should Linux
carry 2 emitters for what is effectively the same data?

What I would like to see is the CPER code post these record payloads on
a notifier chain for the CXL subsystem to parse, annotate with extra CXL
subsystem information, and emit from one control point.

Otherwise if folks would like to see this printk() version of the error
records then they also need to answer why the CXL subsystem should not
also emit decoder error logs to printk?
