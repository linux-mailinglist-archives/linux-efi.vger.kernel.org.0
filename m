Return-Path: <linux-efi+bounces-317-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD2823843
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 23:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C408A2861AC
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 22:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5134E1D684;
	Wed,  3 Jan 2024 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfI5gBad"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC41DA52;
	Wed,  3 Jan 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704321544; x=1735857544;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jDKNwvN2IDrJINrMgYQsAzTa9nVaFogB5pzxoYieMCI=;
  b=SfI5gBadMAvs9T0tYvxFBEwgbLGs4p4lZQZaC7GIJMq5gHKIGitc8Hnd
   ad+mxZ92kjuKMmmejRSrbp0ySEEJc/0kTuCRdEGevBjnfBBK/NXbQOgtM
   Du9KM9qKtBxgovjEYnWaFCCqAAUwKITekaW7mX93XsHKiFIONa16JX0X5
   wXfla59qmeUG8XNfsg/21JCPR2cy/pP1hH5WImkH9niuyWKA5k0O3E/T0
   KnBVUKQwD6TsH+oTLsVk8E1Y4yBPfdcci21880tB78pBgRqQUGIiizPGB
   WUwUi7+Q6/0btZKzPl6AeNKUsyS8hnWV5cJSVL6lt8bxKe9Yo1vfIg6fR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="463485555"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="463485555"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 14:39:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="808990764"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="808990764"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 14:39:03 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 14:39:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 14:39:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 14:39:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1eGnDi94sbvi9bwYGInXOLptXUf7BqvzgqgzErgsQA+UetPS5VjvUYheBmZWRCt20ZviQdH+X5M2vp1GBlFIEfjzFRllKdHj+w9D4CzrClEvkOOtuDonuwBDCa71xxjIyqaqsh9Sdq3tMN2L+Optf6IC5KDwr91/eJOZ79rKVpieQ+wy1ehAS54xW44ZSMEbgfUAIVeM0an3TaqnSxuxRYSbn05NV7eb5B4JDNd8qxn8Y3Cfy7vSqp5PmQw2UPgnH9kjtoRqT4FcBHxVCCI1DZtE83PwstYaj3NEQSop4G2V/VS/Fh0J3hjfKWSBWn7bq164CY6g5tLCixKGmWXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrlbvqZeZMM2UMrJYB2hAgtfe/AAzO47NO53howwFgQ=;
 b=CQfd60/wGc9kC5xBi0zVKYaDU8rldSxYp5KvxrYd0oY6/oDfOxH5XOg05O0xdpMh+H6eLetQEw4U0bfjQSebTh/8IOsv/p3AH3fcLMgjEWqCaOquwPPCi+r/F0F9bxGl7suPUxr0YrR9sgGLTNztiSZSpS/pN1NBVhM0ReCPBtGjAWx6VJSnzfpiadVYwoSkGNSikFCL/tMrXBTjRbxdzXbinDleQtVj7K/fYiTmHySUUQH3JY5HQXlXlnstpO0C1BOGTD4QpBKYOhYt18048o6dp9DKU0ehkUDiG8fTJ0pnGv46yHM2OZtoVG5J28k37WnDCIDYPb63Xyh0bFLeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8600.namprd11.prod.outlook.com (2603:10b6:510:30a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 22:39:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 22:39:00 +0000
Date: Wed, 3 Jan 2024 14:38:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>, <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 8/9] PCI: Define scoped based management functions
Message-ID: <6595e201beb4_be7022944d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20231220-cxl-cper-v5-8-1bb8a4ca2c7a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231220-cxl-cper-v5-8-1bb8a4ca2c7a@intel.com>
X-ClientProxiedBy: MW4PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:303:8f::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c7c666-848d-48fe-1636-08dc0cacc782
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESab7cIA6TIoGp1q3H2demDLP3IA+gHIfuDwUhW3HlYibCapXZ0YOoS0cHInUGvX6WG28OEmvEm3eKget8k7fVjfWXY/swRU6F19mIxW5HU/kqTQMg1yR9Z8BaInMeX9k3WWO0SuVzLwFO5batYN9+8+s5PJvfn5jQeoT0HgcwhVDmLJSFq6JD7BINDCD1p9yCBc0lOlEFqXLlWRwbq8Ucczdg6XmhPzxpM0v0VpFigSpk1AxoL/tnk2k5VWPc+D+rHhsNy917n7G8qsqyEi6GCqSHowbrkxs/2jgsFvkyYeR+seIMpaXWmnjogShysVVUIW2on1xBIsKeo+qm/8oUZSoG9M6nE2d6fmhc6uhm7V1PMrXPoVovhHWCLfYCe0W6BeOnKhXpQ6dwzX3v3v/yROYiqBQsURpT+Ou2r/HeRoeGtTWbBTgdqWFyk5dB+P2vN5Zyww8APcmrUsnPQKd5Ae8quTlaXA+jzlk3m+Z+DP5IhXhQez+DpsYh5lo+osW4CILZJRKCJ2PvDljmK6HiPrsWL5s9oPPzZg00ms9xgdOBL8mtXwSJQ++NbKNDnb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6512007)(6506007)(9686003)(38100700002)(86362001)(66946007)(66476007)(66556008)(5660300002)(82960400001)(6486002)(2906002)(6666004)(26005)(41300700001)(8936002)(478600001)(54906003)(316002)(4326008)(7416002)(110136005)(83380400001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hyZ8VIUcW8i9sD/I7c+Sn2ivdVJYLg0LxINXKIcbe3csB9CJQR40FFWnJlMP?=
 =?us-ascii?Q?6+ZEFXHIbPjpv+4Atmbbu6zeWNPP9Tlq1iBb0ZilR5iuas5Ues7UrSvNXWKJ?=
 =?us-ascii?Q?S4qsyTRLbDlj+rzZUKFHmwdy85Yd81R+gca1Cx+y96jcUkD5vdRj1BZFeG5J?=
 =?us-ascii?Q?MKd+aqt+TxCQd9ZVlQxs3WEnDHnRUbYkkYLblciE9xfM9jRLkVpxGiIDsMSU?=
 =?us-ascii?Q?cpjqDyegyPX8psuD6rcTOidSEAWEvILxII3HhxnqbT5kPw2/+nNwFXgnfzo8?=
 =?us-ascii?Q?LQ3n3vfr+eEcqHrz0BH5ySrDITMeZWchbp5Cyn41kWKd+2fGcmuwp1P97haM?=
 =?us-ascii?Q?m5BXGyCcrIRqRWg/LegIcpRcmL0usRkT5poyecxIrC0fccIfZF3MPIiCZIfB?=
 =?us-ascii?Q?8jhJk4oqjtzQZsezWzw7fjjmvV4bxLI8d3y8TtIDya/uu04Gt4oTDpuUooFX?=
 =?us-ascii?Q?xvsXA8Jpgc6usW7IKNCBJPkLoWTaBZJYqLBlLr0l+xp/MWPd9pL/yRDQZLVa?=
 =?us-ascii?Q?jW7auguqVunOVS0D4IZCtfBg8txO2aNRZx5C/UJ6yv1EkoW5QGroceZyN/iw?=
 =?us-ascii?Q?JtgocJiaYgeAZgJujgrPCd4JB6d9cvVCCaKQObpDAokEXbU3doGnb3r2aNmC?=
 =?us-ascii?Q?0kljXuKQ5PlKu2jxpK8v+lpx5IDx858aZ7yQDadcDdeh7SZOpf8BcuZ/L2xq?=
 =?us-ascii?Q?GLrz+hLpJN1MuFXQ/KvmvAAPFTxBKUvg6zKAchUvYsr0WUiCm4teM6MUYV/q?=
 =?us-ascii?Q?inD9ky40h8K6R4I1kl1hdprDbiGRr/NJRzxqaVEHFsbc/AJEeJuFfCCQbBKG?=
 =?us-ascii?Q?5VI2AKynM2cg4z3Hqk/nptGoZfITd5N/dFTrUCkU6UAaY01xq1jSc+vxJfId?=
 =?us-ascii?Q?RNaAtdrciI05m8EtyxeMUWbUpbFVk/+RpIiMh5+GSJA5C57zw9k3vuJXM7Dh?=
 =?us-ascii?Q?LMnhYfRM0uPbcOzrtE+wd3Lxv0rvZuf9gxvS7gFWpwjss0a9tLtW8zTxO5xb?=
 =?us-ascii?Q?RAmbADoFS3uQuHA/HT1IyrfPSKAj5/7uKjHePBxuL9ETIYH+OFxSXr7YUS11?=
 =?us-ascii?Q?RuNpZaviSNTcpiHnKe81E5pLU8Q1N39ByZShE4/QkMnG1trUEgf58byBuhas?=
 =?us-ascii?Q?7ookleAexnVFibDVwBymrOOwE57QM5Pj05yT6Z+hUDFnT9zhGMOJflH8yr+A?=
 =?us-ascii?Q?brj/LatSd1A6fbZTOTcD/C9n6Q4amCcujyny/tLUYgQ/NIK4nBiB5hrttMr6?=
 =?us-ascii?Q?fOO5rEUGwcPzlF3IlN28AmZGF1zO+tJBIKvypQv7nzp14l0w4b7TTNR5qEOO?=
 =?us-ascii?Q?SNbr/EeaFShIq0+CTt++o62DpSXC4OAV/tzpvzwVO1rdkjvNdCcm+WvW1/tE?=
 =?us-ascii?Q?gdTp0Chmlu0+BaOC1iPSZQ7qauBCrV88ZiWMcghzNGqc/lR3LHA6OArDWxLn?=
 =?us-ascii?Q?OEQdWLdjfNDJchWEOxV3mUeZFwDv0tvxtlDYGbZUQGthnJyamsFKJP1m5dwW?=
 =?us-ascii?Q?46fReX6Df7eOlz+3fEz61zMw8XKP0x2GCZs1VOoixq3pRCNtOhlPtiR+U7OM?=
 =?us-ascii?Q?BDpCn4TSD9zzlaTFxroNHNggCY+tjyZUlr7wo5xI9vo+aKQeQC4VO7Kn3X0x?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c7c666-848d-48fe-1636-08dc0cacc782
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 22:39:00.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PybQ1f/VuFaHJlpYJjvUfEbnXoau0B3KFIqB/fn21tjJmhOPs0Hw20iNFxWPSsx9zwmfex4+CxPqI4J+Ld0JJ1eVrhOL6t/yrlA4z/0QHjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8600
X-OriginatorOrg: intel.com

[ add linux-pci ]

Ira Weiny wrote:
> Users of pci_dev_get() can benefit from a scoped based put.  Also,
> locking a PCI device is often done within a single scope.
> 
> Define a pci_dev_put() free function and a PCI device lock guard.  These
> will initially be used in new CXL event processing code but is defined
> in a separate patch for others to pickup and use/backport easier.

Hi Bjorn,

Any heartburn if I take this through cxl.git with the rest in this
series? Patch 9 has a dependency on this one.

> 
> Cc: Bjorn Helgaas      <bhelgaas@google.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v5:
> [Jonathan: New patch]
> ---
>  include/linux/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60ca768bc867..290d0a2651b2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1170,6 +1170,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
>  u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
>  struct pci_dev *pci_dev_get(struct pci_dev *dev);
>  void pci_dev_put(struct pci_dev *dev);
> +DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
>  void pci_remove_bus(struct pci_bus *b);
>  void pci_stop_and_remove_bus_device(struct pci_dev *dev);
>  void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
> @@ -1871,6 +1872,7 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
>  void pci_dev_lock(struct pci_dev *dev);
>  int pci_dev_trylock(struct pci_dev *dev);
>  void pci_dev_unlock(struct pci_dev *dev);
> +DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
>  
>  /*
>   * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
> 
> -- 
> 2.43.0
> 



