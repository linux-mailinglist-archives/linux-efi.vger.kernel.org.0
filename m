Return-Path: <linux-efi+bounces-267-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 682A7819548
	for <lists+linux-efi@lfdr.de>; Wed, 20 Dec 2023 01:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E172285EFC
	for <lists+linux-efi@lfdr.de>; Wed, 20 Dec 2023 00:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2C3184C;
	Wed, 20 Dec 2023 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvI8gPE+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F271857;
	Wed, 20 Dec 2023 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703032157; x=1734568157;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p+/2b4Svswb34S51gM2UmZA0WikjjhK3jS+2AGDABcM=;
  b=KvI8gPE+t09jhH1nAjCIE+EGav13SOVQAXurtCUbPDUM54u52BE8K4K9
   WR7m7itqsPpLHw2Aypof35e9Rp3QabpzsVN95+prlkOYS+14rrKJT3bH0
   wdYLTB0bxVSRvmrn5+BC4NqWHmUlH/6kzv2WiIeAIKeHqZzQl9lzfRywv
   dqoQNGNgwUkRr9anC7NIN/6+DXcyBTJY1t50zhWyGZoUMfhoERHWzTBOA
   ZoikQRxFqn3oowd66j0jVy/Px1WgIOMiDfPbu/0k9AoQBD7Vf1XqpbtgR
   4YdO+xKBJtYZj0iIrqw9VD5XYTDX7VAKpzclD+bsApsFS7p+/ItqYME6a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="481926606"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="481926606"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 16:29:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="810406706"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="810406706"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 16:29:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 16:29:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 16:29:14 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 16:29:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsQHV919oSofyLaT88086JxTZK+ntio8VgunTSWCahWgiu3UacSmv88gIa9ZdkWrgzlNhwC+OF5pOWHcfpndLe8zHzqb8uO7NeQeJUD67jMdRJv1xTE5+UEAxkM5cll5/tyM+O4Tw3ma5QljSJlIOGqBRSUYWOrXYJQ6ageNctT0RI9H1WzRIUMWLVhK3k7AXTl94q0DEZNMKgIWg/NYulPsRfmYDlOJTSjbj1eQtDlh98OwwSP/fY6QQEUtn9DN+iL8xspbEtjCJHPTH3woXfuQfeXoH1589BdN+7GJFVyu6QM9YRgSFWWAMtZddYRNCNhwoApaFnOcnDm+ekSwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HCRiH7JXiKdbk0VaE/0USN3hVUUgdQIKtXX1gePwp4=;
 b=PK/NiEo8bh8gM+mV6byeMVDOut5DwgXX9nlojKGC1MZy0yf65VjXfcSa7vTmA+ODdN4ycg9+DzLnnOTyDh8VoehVa8Dh/r6u8Ht5JY7UlAAoaFFvrOQ+w8rOHt36ZShJiy5SsSe7qaAXOOzyoJMERM2tvjJJLl0Rv1cOwAST9yHk2Z5sg0e1Ym3jn2x0BGIiNLVk/O1XTJOJlnSAPL2Ssr7d377qpY6ebuDpRw1+mIp/jI6ZJ8zBTbLZHrlaDoTetIdgkUT6lstKVJhixRi+rN2gWU1HD59YD8CK5SkteadZCzCY6lONSze8cdr3+X4A3gkDwl86K8CAD1ORz4iBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5454.namprd11.prod.outlook.com (2603:10b6:5:399::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 00:29:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 00:29:12 +0000
Date: Tue, 19 Dec 2023 16:29:08 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH v4 7/7] cxl/memdev: Register for and process CPER events
Message-ID: <658235548ca6c_2edf029490@iweiny-mobl.notmuch>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
 <20231215-cxl-cper-v4-7-01b6dab44fcd@intel.com>
 <20231219143732.0000181e@Huawei.com>
 <658226c9a49f3_277bd294fb@iweiny-mobl.notmuch>
 <65822909ebe4c_269bd294f5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65822909ebe4c_269bd294f5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5454:EE_
X-MS-Office365-Filtering-Correlation-Id: 89812e80-f362-40a5-dc66-08dc00f2b068
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: meOH+JH1W5Js479VL8luxPvMVWw6CynPnGJmJOwgvDmva7N5MtJ44Obue8Lc0GQoXUFQlWYZx/wACRmL2SLfq0QBBXmBhkg9rrEriGnZay0lpPP9T1JaDRk35EUAaZFecvkDaz9Br8efsbb48JxOMUarNg+rip2AJ6RGryRapdp5AWsMqlm7zSG9HHn4qVa63cl6pFH19nAgF6bqk/t9/S8AaxVAzggMInApZPufZc4Yx/NJBiLiMW+7fYktTv6ZkLWotK6LFc+UWKJ/EP53Vd/qItDh1p9C0hbgbU9e7LTxfsGaX8CKw1frXO/jsAp5u2NnMzwMiDEgTSTw57tYrzFhdWNN2/fpcME1jAGaH3RrwWcAfyYySGaKeOYKdOcogumH+rH3nP+qQ5TPie0Uu+XW2xpJAqvrS0aTRLrwntZKod8XZNIeGSwBR7kpNQJG+UP3UQhCzoTtULBBqmv6K6hG0wll5ARz+wGm4DaTaGLzvmnpLBFK7sezFdJuzYPYk8L5mx5Om8SRM4Aw4I1Cy4dvtMwJ/gR3cXqe7/62TveTFo8TCkvRGnO1cluP+2V3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6506007)(9686003)(6512007)(6666004)(38100700002)(82960400001)(86362001)(478600001)(8936002)(8676002)(4326008)(110136005)(41300700001)(7416002)(4744005)(2906002)(5660300002)(66556008)(54906003)(6486002)(44832011)(66476007)(66946007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mE6hAs/0AFTBO1qgTr7oWXqz2F9Tba/t9C8WjyU0IQViirz3f7OLwETKlNsh?=
 =?us-ascii?Q?tfNhKmBJa20EPkPsYP38PflAraOrg7okQAaOipNdv8zID+0h/EDwrUcHviZ0?=
 =?us-ascii?Q?GpqBIG2NoMhClpXLBxn3WSmE6s85fVd4SOa2G0kC/eS5l6WAndlFGYk8FWqO?=
 =?us-ascii?Q?hkpKz3vbF1IHBq7Rt8O67lYXjyRctMay1RJ93slnwuiiSTfXjzWn/0PrYHoP?=
 =?us-ascii?Q?MbivJkDpzql8+6DETAdgz6IISAVFrcYnrrU8EB6+p815WG1VOGBIMzfstQup?=
 =?us-ascii?Q?47TRbdwS35EV6V6XVR8dRmYyATaXLPrmzdo+LxHlE5K6kdU7/ouT5m1eCsub?=
 =?us-ascii?Q?YQJWlpWpiDbet0KJ3D+lN4zuOUglbi5hroLGBZwMd7KmoW81RCOjccScj7IU?=
 =?us-ascii?Q?kAddGtTqhVn6kzaYMzzOSU6F+udkN7+C4lG7/6x/k2RYoz1wkapysnQTaSMM?=
 =?us-ascii?Q?Gs+2QxNufCmDus+yAOCk/hHtWrzE/rhKz6UwbqUR/BuADI/YgImSrIerwRjW?=
 =?us-ascii?Q?TMj6xsLI7aUqQV+PBznJHjoV0tjFCoCFcvsiQlmldvIInZllYXrjGgc3IVit?=
 =?us-ascii?Q?Qld1G67AC+Rjnh0LVq7I3wO/Zlnj5UfAuCje1vnNQqrOdI3KQ2OPR7I1W4+J?=
 =?us-ascii?Q?T9gtw7TakS3hO+Dpiun6VrHXXzT8qXAmiP8/BLZXUWF36AsNoiKpyky0/mQb?=
 =?us-ascii?Q?Os7fRDFiBAv4EaEMIpP+2yRA3xzmNIZzvwCmNumEGNXdyhLi3MVN2QY4ugJx?=
 =?us-ascii?Q?hvfVBIXsoTLCzEoZ5l/Y8lz+kwsiQnrDuwznUYlwOTSchGS5ae+/JT33qfQc?=
 =?us-ascii?Q?3dhRvJG+IhrjNwgDv2ji9o3d958LgVLw1zvRZG7vHRYgIwzoGAtzHLeygsBz?=
 =?us-ascii?Q?gucLxo3QXHpEPG2Z+MbuO8ohbt+wOPKOcjt0WEOgSkT/QK9Kiy1vGG0pyK/l?=
 =?us-ascii?Q?sIV+pvHmb1gMWFR0LJ0HyLayLnafb2Dt5+Qik+qQ7+IZrgP0pVyIU+zRHpVl?=
 =?us-ascii?Q?nV86kjv0ZCHHKOZvqvC2P1UMdMLtadM+CyPsqt4KTJoZxPiypwWE1L6q+MlE?=
 =?us-ascii?Q?zr0vMSqK9xYV8Olib/efxhEMNZccTYeWV95fkPiQUSEFa4uOvq56961fuSep?=
 =?us-ascii?Q?3eAkpaHNFsadiusRw7uXFo9D94fkqePlA1OauQbBmNm8MmI3wM4zidAvy5AI?=
 =?us-ascii?Q?bS5yuEki7Ki2MSa8aQDY+42W226lbWqxliRQn+jIw+09nX9+hT+0Upf8SuXP?=
 =?us-ascii?Q?cu8aTF2PuiQxlZIHQVXgY2rdvwZPAS9kP6YClyFxKgoLjl1hwM6i6bgjFe1J?=
 =?us-ascii?Q?PU3pHYoQghcjWhejnzuz5awKixBjfvL6xvz5ked4aXAckYjv2pyRm/p/S4eK?=
 =?us-ascii?Q?HHVfjueS8RoQ+JuZoFSSUqC4BS0toNmzaFS0yJ8DlBwwtCts56plWwUjbmog?=
 =?us-ascii?Q?IZY1jUQeQXzcVfhDyY9zJyDKOmQmB9KI+mGxKfsE2wm41pNC0THWmwuzPteM?=
 =?us-ascii?Q?tjoCMAIwAReWltWTCXu7sbuQl/FxRglhakmOqNsLmAEiRnt7XTuUtRJoFJfn?=
 =?us-ascii?Q?WCV/6eWlwba88MKZfFKPeDmIm1YvT8JkltRtJ5kgDw4UnZz5KIuTHal9yo8f?=
 =?us-ascii?Q?GnNpQ+iFrRUPTZC0KM3oLApmrHfGEMbkEZCK+dZOstFQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89812e80-f362-40a5-dc66-08dc00f2b068
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 00:29:12.3038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyJ4XbGtziBiR+R/U5bJvfcBKuUDLsbHkUtbLghJBJ16CifsVrNxsBu1MccOD+1pfwxX4h1Kh2+FWhdDQbmTAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5454
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> [..]
> > > and drop the = NULL above.
> > 
> > Done.
> 
> The NULL assignment was more about making it clear that
> __free(pci_dev_put) will take no action until the pdev is acquired.
> Otherwise, any future refactoring that introduces a 'return' before
> @pdev is acquired needs to be careful to assign @pdev to NULL. So, just
> include it in the declaration more as a __free() declaration style issue
> than a correctness issue.

I think he meant the assignment to cxlds.  At least that is the NULL
assignment I took out.

Ira

