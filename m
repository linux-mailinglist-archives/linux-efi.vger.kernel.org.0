Return-Path: <linux-efi+bounces-263-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31682818DC2
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 18:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2051F27343
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7AC20DE7;
	Tue, 19 Dec 2023 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvLDnRny"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E6224EE;
	Tue, 19 Dec 2023 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703006238; x=1734542238;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sNCcFiDhIZRJJSadr1L6RONC7vW1blL8kqd7SDbb23M=;
  b=UvLDnRnydjXD5cGYdeTED0TGq2mZ1YmbM27BGoCrgJUmy7aBQTEaKAoZ
   Vh+Jfzk6Cx64scSkVRfl6ldzewtRd6SMnARXTSVmZO/or2qWdJ1xidUsU
   kGCZqsf2hsVvuAygJbd6F/HyWbkbgz4qzDNZILkPWrv+IX/LsYvkXmZYu
   iNFq05W/awKZDzcnKMg7wiACmbla+7ZGrBValw98E5z4eOsJryguWQB8H
   cnPzpMUN/DFar6hqeDuU101AO3L4BtOE0IJEhVah4H4xxzQIz0ADsL5mB
   qekcHSZJ+7nVVCdabm6xlIbO5wxkxhzNie+8TFVivXRfSe0CdBkbfA9Yd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2923311"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2923311"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:17:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="17673575"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 09:17:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 09:17:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 09:17:16 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 09:17:16 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 09:17:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnH6sZXsNqHVqVvaHyLnmVsP2DTL7dTXL8P8IIWQ9qZDOVveRNIPuPjilOZIjKN/IwaUZEl0pGG+eKr6hekBNE1W45jsRByThWVR//Mm/CCTbMRisqymcwP8UnSvehXMwoljHNOD/Gl5QcibGny2v0utY87kyeB0X68D2nOuOL/wxl2+gJaUTPTOBVPb3yDOPFmmWTN07/CHQVHDtJ8xwoEDE66NXeFR+yvpXhWzITbHo7qJXHtJHHjBr8y5kIk+a35NaYWklQq19kNCCLBixmnB1OQE5J3XLRKTTTNRkfhbcDN9jvhYbdq0x6QsTiQ4m3LA2/hKftoQxnNGkc/hPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNx5XdoN12Sq/dUZdaNB0Y/q2Q0doHJnamvZtxc8R60=;
 b=PGC6JzWwTFm8vfPR5s9ykqvre6omg7oGGbCfLxXqK4PJKUush46/dJBpLuQe0d1YqHcQIATPbHIm/jKBwJX+WALj5J7KPerLIvAS2kXCNaLZyNVOiYM6xGn9lB+rWcgIZzGKMMInwQvBiXw/KkdjopUJB2QvJ6+6aDtKkF0yg5rUYIrgyQIcBISpO9zUXTkWoKpIU9oAOY6A26kr4SP6xpLbb3Dr7dCS4SZsDrAmaZitmq3U7kHXVSutV0bL0qf2Fx/bS2f9IBRxV7YAf3baBqDkwih9V22wk10vMnwg4VTZ8lnWELsau1NIfNSOeXxgythM4s49NO1I0K/nUzI0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 17:17:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 17:17:13 +0000
Date: Tue, 19 Dec 2023 09:17:10 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH v4 7/7] cxl/memdev: Register for and process CPER events
Message-ID: <6581d01645c01_277bd294c8@iweiny-mobl.notmuch>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
 <20231215-cxl-cper-v4-7-01b6dab44fcd@intel.com>
 <4cb5c275-566c-9414-7088-1e91378a409a@amd.com>
 <6580b21723b2c_269bd294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <6581cba663770_24f6b2942b@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6581cba663770_24f6b2942b@iweiny-mobl.notmuch>
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV2PR11MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: de8c4204-c434-4176-a5a8-08dc00b657d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55Pwq0vAOvHn9zR+ZdV4oF9vknoWGu9v31LulFEoEyUXpictn263QJZQxPgGBCBSM7/2RXX4+9Zo1Io6zgIVhAyU0jdSSYlzesB0F8Xkvemdg9kXFdGWkAwKhSvzzbq71ByJS9T0SdtzQFwk1hfM1HJd/tIVQh1XMhpY2miYoywxto4v3F6U+AVwoMp3ZEZPYlJV/kXd80kP8aOcIm34Lc+UOgeTo1PW01gPzw8rkuPlGcG2B2WeePVE7Ddu3A6c8scPfwVWCD7VjPHwqZqzuEFFv8lblQ0eUtWmTzEQ5kvHpmjDqFMpikCFRDZY4QMrYHWQVx8KwDNTHxaHkYRdGHeznHdfiBlNs5Dk7fZnBHtberCIqdkVLfes8IcLFNJp/xNrqUxFWUI60XQNXGGXxuvm04n5is7uCHELM8AX8/BRilLHgYICD+TeIHyn+SGP0heZGZKgPwFp4OYLJW41f4qaPBcNarG/yZuF0DRxqFrDAAj2wbc6oF+yr43zqlfUhwIL2fQYYUb4+zQWj8ahNndpHoyn6lrQeFOvG7GO09ucNe+/PICbqNoDDfCwsMW6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8936002)(8676002)(4326008)(82960400001)(86362001)(41300700001)(2906002)(44832011)(38100700002)(5660300002)(7416002)(53546011)(6506007)(6486002)(478600001)(9686003)(66556008)(66476007)(66946007)(54906003)(110136005)(316002)(6512007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eHQHmcC2Re96x6np5Ly6tGbepV4VZoTWfGWvjMkiucaoXDNuPCPbiLl78xrg?=
 =?us-ascii?Q?IvJlmAtje5iBDe83bN51o4dUbbiY6b5jGSNVVAcFfsXoKtiMe+kvMU1mW0r0?=
 =?us-ascii?Q?CT/LPQbr1VTtfU2sNdyUxPIaJmEU4AWuPkdlw9GdgmZ9pJ1M2XSpcRdbG6Ec?=
 =?us-ascii?Q?GZsAS40R6KoLn8i01MmAiZTKyvdI4Ge+TIj37EC5XZWGwXYx5SHZ4PYKJDY0?=
 =?us-ascii?Q?CSTcQvTQ3b92M57ar4Ai+rpgqJYdvS+vaxqDRaAvBFjCvrijbwQSXusDhAX/?=
 =?us-ascii?Q?CIwtz9uBPZKkD3Mamuruao93QHlMFR8wXTjHX4+iTPCR9aJXWyTl37fKvbCf?=
 =?us-ascii?Q?Sa38p4Wo1cFlONR6sDWrtV1laCkwL0IUqjl9NjV+xOLvbvTRCk7SQXc0EIg+?=
 =?us-ascii?Q?07EoCFRkiN5NBRaq7kMjQTp9EJjBLFmpbLoobsy3gZoyZrqs6Ob0qd8MMLIK?=
 =?us-ascii?Q?dUBxK0svYbUw4fdwt4Rx2f0N/8NAMlJavZG2h7iDGUyx8dInP48zea04RdM7?=
 =?us-ascii?Q?rd2FLlO/oBgjgebWEo0CsX2yDAYZZyon6hTsI1jtskxxZ05qYiP5ImknjiRS?=
 =?us-ascii?Q?C7gnCNPw7p7sNUyvdv92Gk2wtWK67HJI1xK7sGCVP6G9q/oORmHsJ+UMfOwV?=
 =?us-ascii?Q?ghLbXNWeUv0fGD/HGwmS+6kDU2DVIat3H9dNnhsYiYSPPabaDq1vcBZ7iR8Z?=
 =?us-ascii?Q?lJKYFuUag4igEo7KWHoJZWkL2ELU8rjouNQpywJtsRycJoiIkBtq09iRqOvt?=
 =?us-ascii?Q?b3FaqHLqh+JK2w3zZwWralHK8O55M/5GPS5TBzU+4SHew3E2RDIYNGoOGjT2?=
 =?us-ascii?Q?Ttd+tmz/ZndIPx74Z9AQaYnFBEjPsNRyLBTe2LmDPXZHMNqH7baFiu5ZBb8T?=
 =?us-ascii?Q?0jJFSBHtQKobs5GE34TNmN4QfRhCiDQ0dnu1piGyKxAJvkQ6vdy/tQoNVSJB?=
 =?us-ascii?Q?JK5o0BywTdiL8P5ai9VmncqlfyD/dNM/WPc05Yci/Dwoar4W44rKXurjLHaw?=
 =?us-ascii?Q?MpAA2Xju+Tag543eyt90pQ6bX9jRg8pWkdPy+VOQZwS5DMR8I9OeCnaYNaSg?=
 =?us-ascii?Q?YbkOMsI3t4+jWsp+eGzA2NsoRzl5sTXlTscSAWy/3RXkzOBHzgiFnlxiVQMK?=
 =?us-ascii?Q?Of0aJlUDEpSoNdB7xVQK3r0kVDbQyxkAiDm7T0xExVxcQmliZ3VB7/ljKF4K?=
 =?us-ascii?Q?r9F6sF2iXF0b1EuMRUc1U/EWig18tAMZMrjtxYD+lCI5H6qtmObrszFEYfqj?=
 =?us-ascii?Q?8MERK6B1qBixI84BkYFvBM48EMX9sygl1WAm2zExeNXLDBfdb7qU/98RSa4w?=
 =?us-ascii?Q?KTvrz5OnFeUwgWuTZiW+TQi2+a+Sj5ItkY7wkWv0UBxMrIMzvRt77j+dvaj0?=
 =?us-ascii?Q?e3gjGJkrAdYj3jECDinCTYOa8RbjwUOR8ASO5IqgcGF8KPz27M6rdY1PKzAR?=
 =?us-ascii?Q?AjiDIbHkJOIyiN3s09yoh+IaGDpVT/9dkpQMitvhgFhasW2jfGZKs9Nz60+f?=
 =?us-ascii?Q?DbWsFr1SHfnloPa6I+owzNSn+nfik7YFwx7CH/sgqUrZTqjs3IvU8ulF99HT?=
 =?us-ascii?Q?g5EhvPIRg3nhOCaDhXfhy/v+qnWb1x24GicXXNv08rVpziM/zS6tikNCkx7q?=
 =?us-ascii?Q?JgjoVDs+Hwl7rGhiJDKaj0BsjrwdrzGv8qJXJt1y5VLN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de8c4204-c434-4176-a5a8-08dc00b657d5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 17:17:13.8480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyME1Ju9Q084duNmHlyumgJmeHluqWdwTpTrOduNe49UO60/xUUDs64nGGO8BPvCUewHNtg7lhtseYkpOz0fmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Smita Koralahalli wrote:
> > > On 12/15/2023 3:26 PM, Ira Weiny wrote:

[snip]

> > > I remember Dan pointing out to me this when I sent decoding for protocol 
> > > errors and its still pending on me for protocol errors.
> > 
> > Good point, so I think the responsibility to trace CXL events should
> > belong to ghes_do_proc() and ghes_print_estatus() can just ignore CXL
> > events.
> > 
> > Notice how ghes_proc() sometimes skips ghes_print_estatus(), but
> > uncoditionally emits a trace event in ghes_do_proc()? To me that means
> > that the cper_estatus_print() inside ghes_print_estatus() can just defer
> > to the ghes code to do the hookup to the trace code.
> > 
> > For example, ras_userspace_consumers() was introduced to skip emitting
> > events to the kernel log when the trace event might be handled. My
> > assumption is that was for historical reasons, but since CXL events are
> > new, just never emit them to the kernel log and always require the trace
> > path.
> > 
> > I am open to other thoughts here, but it seems like ghes_do_proc() is
> > where the callback needs to be triggered.
> 
> I see.
> 
> Ok.  I'll create a pre-patch which moves the protocol error first then
> I'll put the events in the ghes_do_proc() well.
> 

Apologies.  I really wanted to make this work a pre-cursor patch but I
see that there is not a trace point for the protocol errors yet.  So as
not to slow the progress of this work I'm going to skip moving the
protocol stuff right now.

Also, as part of this work I think moving the CXL specific defines into
the common linux/cper.h is appropriate at this time.

Unless I hear otherwise I'm going to land the event stuff in that common
header and we can move the protocol error defines later.

Thanks again for all the testing,
Ira

