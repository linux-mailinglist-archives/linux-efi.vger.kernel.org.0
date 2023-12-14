Return-Path: <linux-efi+bounces-219-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B92B8139E6
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 19:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA531C20ADB
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 18:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A699E67E79;
	Thu, 14 Dec 2023 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbcpNtH1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253B5CF;
	Thu, 14 Dec 2023 10:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702578279; x=1734114279;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rD1iekt3mcmDSqVT5FL/LX4KO77llj1TKAqs5saF8YA=;
  b=IbcpNtH1HLuSVROjh0ihWouoOLXlUVn9iQCOfWmN7DJMaWFfePwdy90q
   ga+v3qCZeW0clT+sbQ/zj6jRdPOX8qUHUfJv+T7WowaAi+bRxHq1rTXgZ
   Lrn4ysJdVggZDO4Tf9RBTBsWfuwhiEujmLVIhlSvy75CUL+hxWeGDJNeD
   ypSWOXJUiSsKv4/Yj1UvZXQr39fwgZDJxzOea4UhWyw69PWWSQ5WZy7Ou
   6tPb0yKwlcYhzteYzMG5OIY/bsZXPS+vKC01VGg+zFdPHt6XWIdJDNPW+
   AXm2qHsK8NzKqVm5EF/Ze7sTsNZMLeo38NWOlRQ6kAlCed6Y/xhoatqZd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="481359735"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="481359735"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 10:24:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1021637995"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="1021637995"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 10:24:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 10:24:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 10:24:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 10:24:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt4HVCaZWk987w77mYl6UQvEPDBZIXrdqEE2fZ5UDU4VzNEduLgm4bWogSyMxS/KYSjMHYObhx/bajmCMILyWwjPmsTemqxrYWiGPeIM4MaickgvAwWAsvmZXlN6XiRxLXVJ26f6waCfMCSmrUZ0l8h9YCpcU3YhS5xi7yHtvBsx04LH+6GeLfXSRbEI4H/IcQzq1qo2egq+0natSix+YsjuE6sSFpzoeZ74cSwSm7DroJwCixZ1ky/2GYGJIUi9FAk7Yh8NisuyTAeM/QVHMoSrh/CYT7QDjoeL5o5CcxAr+hH2TGq6v7dC1KGylelTfIyinM4wvtDvHEARjA+XQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4kGGSCVFia1JICuyMZBAJBFa0OPG+Zx1g/9FVeKHU0=;
 b=Gilfe/E53O+fqFHrZd18CPsgKuzK6iHcRjocgMPuSH2LKfK4y/qxFwKBlq+fwTvFpdec2IYRUlXZNvUAyP6QGW5T11EWhKI+rBg/4mR31WLZjD9s3nGv07aUsMEnPCMVoJox5iciBH+OvjBwV8JYl8/QhECMj7BeLjhoHIBs4JqZvXza6QNaDXvCsJUfMB679h1KHvJAbIKqUpYSQVvPmSFWAkEaAJ+1AUEcxFrStnrKcZcGRr4reqWbT1gGETA+tU+MgbTShCAkfSOkkyZWiCFSH7x5j5D8+RbFUmzmPRUn8jwhYteZ43ark10Q7t3SmzWYqeSrmdLvhL9SyR14jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM3PR11MB8682.namprd11.prod.outlook.com (2603:10b6:8:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 18:24:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 18:24:31 +0000
Date: Thu, 14 Dec 2023 10:24:26 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH v3 6/7] firmware/efi: Process CXL Component Events
Message-ID: <657b485a49a06_273ab0294ae@iweiny-mobl.notmuch>
References: <20231213-cxl-cper-v3-0-7fd863dd0d25@intel.com>
 <20231213-cxl-cper-v3-6-7fd863dd0d25@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231213-cxl-cper-v3-6-7fd863dd0d25@intel.com>
X-ClientProxiedBy: SJ0PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM3PR11MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: e746706a-61a6-437a-6f83-08dbfcd1e9db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POCN9m70RBJHbwE1Dz4UZ585cMcckgz1YohYMM9cjqYVO5eyhMNZd/gxUj2ADLJwv5fhrHwreR3hW5hNFBJOB5gj1/NDS+qN+EslJKgSCupNe2YJ8t02kaQmDlOQeyme209bE3+1NnHM0KhxM1uN73KK5272VEyd0Eb3v6+qRdBrmZLuuOXva7Vi/w0XrSZMsVhK8lyMppX1PyReplG8yNMmOgW9Tg0kOFGlooqmyTnHbknui2rnUYDZoMu8UNjut/2goN33aVdSgbwtKOLOAsbRyj9G6fcx2V6h08/Zdj3X4eABu3CREosJbp9b6kJCAbP8GSMHkVbaLNOX5BP7yukpRK6qmuP78ZByNzlxbWHxEwBHHjN7dmRSLZYhaW2T8YkoQ7Ew9E7XxUdQZptivmNQpn/To5n5GFYm4Vyn/pggz6GUkejG7i24DYQ3I/oymVeAJIVJXMF3UaO6OeP8lmZTcZhrDuURQsnwl/H2jwyDLc/ZXd//NMrH/NutgjCvmXoJNSA5e6ncaHBJ888P58/0pfde7mk6pr4Ikk1jJYU2LQ253OB3lRbnnJ8oBvx/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(82960400001)(41300700001)(6666004)(66556008)(478600001)(6506007)(66946007)(54906003)(66476007)(26005)(9686003)(6512007)(38100700002)(83380400001)(5660300002)(2906002)(4744005)(110136005)(316002)(107886003)(6486002)(44832011)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?thiIyRjfIE5nWWNliEa0ueZRzwkueH+IYHol/jKfXJx1sFhjbTplKOA/uCXr?=
 =?us-ascii?Q?O6ESDFkGX+eeNXLi1VfJ4uOGxcvFFhiBJ7rQe/g1W5JOe6zCrWcVoHmIbQzr?=
 =?us-ascii?Q?5Z7Y+d9GMsOIZMuXCb/5sIpStteztzddy26+DbUeu4ooA7cdcLWaDTRxQ/Kr?=
 =?us-ascii?Q?FpvXvobSSaHGqfrNE8HaEp8LpWLbaXTowEYJTqqEmIDwLYtZavHJCOWYwSrI?=
 =?us-ascii?Q?x8EWxCOoUxXPcbu3xspFDGSqNaYgrV4/o8C37j3XKWOjBmdkr1isW3i9jSiZ?=
 =?us-ascii?Q?DuTwSnz1kZFXTz3muUWGArAmxeQUn//S7qngGzub7peMOyg6mGrfZF5BEDoB?=
 =?us-ascii?Q?vYAPw+3xKYkoIvjuhgF5RiSqErXWBoOwVOygCyqQGP0Vp0utejTVeNh/QHwZ?=
 =?us-ascii?Q?VvV+RpS/C6Sy87sSDTDSAAY4rlWHQT+yg/S4QUih6ivDPsWunppUrIuZsc+T?=
 =?us-ascii?Q?AFZwB8abIeSzfcTZ4vKWep3XC0L34rU8SZN61rNpAtD457BwxJljmzkecAWS?=
 =?us-ascii?Q?FPKCnOeztZJ3u3m+bFZdW3HWm2mzpcyvUKkHj8qZ1Aks2yT/AgJ9hjkeAAKy?=
 =?us-ascii?Q?+NFTpROhOKlbtE/aTiAKlUeTGVHP5XvQUh5fNo+1y674z5w3qCMUQY/yTen2?=
 =?us-ascii?Q?XGLIiqn2u5SVid/q9XmGsNpBuTupjumnnMKFzBBz3kJbwe9Lv2Q/gU8aVsR/?=
 =?us-ascii?Q?q/Z+eYN1aY020STvvQjG2JcLhCZLX9iUYJEnU1OUl9rDWyB2G48mfahRK31I?=
 =?us-ascii?Q?s9XO+c8K+vyk7O0jtUXkiWMnkoNuubmZxcGnhPMuIqCQq50ralU9Uo2PGcmM?=
 =?us-ascii?Q?7MN3dEBLDzxvwtydS0qJwbDfgZD/tsoMqGqwiOBiXsG/Dn7cztcfh2ANowHV?=
 =?us-ascii?Q?Wxl8Wn8gt9tdykKa+V01asga9HWWskOE5OLLMsVstZyeHVxJ0eiFeu3cQ7qJ?=
 =?us-ascii?Q?emsT9tBNSurnryoP9SexmWPDM8ogQKHRcUinjrnma2AnrNZyraOO223L0i7B?=
 =?us-ascii?Q?E/Ts2WVDsa38reFmjfQFcq3QBn55RSzWGufeeNSbk069IfQ4c77Gfkj2PsVq?=
 =?us-ascii?Q?UT976XOlJDOf66DNjMoJerQHgNXma1eYgn6D3Inr76/TLEDhp/Lgo1o430a5?=
 =?us-ascii?Q?KKdC7SQlEa2ac0KFldpzy5rUf2bw2kLpbUfrvpSxpVxCZm5vmPja+BdpbwH8?=
 =?us-ascii?Q?Hy8d4lrix6CscYkIvnbw9jnXpfvti8oEaGVKZE2o80lkJyDMWYNdOi0gDl7t?=
 =?us-ascii?Q?0ddlVlqyqoXvn6jf/NHJHJgAoTvrCWirKnXhQEDMlEFTGZVdhx2vTofQF3uQ?=
 =?us-ascii?Q?/zr5vK1HNq+lJ/Y36CmPff5TYHs0m+kPF4r3OpA803uNVG3S/zI4oWbBYXFm?=
 =?us-ascii?Q?Amv149mCd/UBAIdZ6jVBczK+iKC7TloNYik9qhIoMotb+xL5ZwXCJsBfcuSD?=
 =?us-ascii?Q?Cm6CEodJJ48Nchz6AWwwwNhVRkhkilYv2CDrLIyBCDduLbVEdECXN3f5CfOw?=
 =?us-ascii?Q?efy2uMN6D1MeTzYaVt0ZqcXv3JMJgiEPN7NqW4U1HgZT0kXamKKqrMyRX55g?=
 =?us-ascii?Q?aKrVXBZGtGGLcNljKNYP7W1kEaOnUHCFq/Nc1QeJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e746706a-61a6-437a-6f83-08dbfcd1e9db
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 18:24:30.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5BusJFC8zyIhAir0aEznoK8yCOXGzrW/bzOrJEseEObJC67VcPhbYPefaAzGBU71oYaTN0sVy0CX/aDE9ixAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8682
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then send
> these events to the OS via UEFI.
> 
> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The difference is the use of a GUID in
> the Section Type rather than a UUID as part of the event itself.
> 
> Add EFI support to detect CXL CPER records and call a registered
> notifier with the event.  Enforce that only one notifier call can be
> registered at any time.
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

V4 coming with 0day build fixes for the CONFIG_UEFI_CPER=n case.

Ira

