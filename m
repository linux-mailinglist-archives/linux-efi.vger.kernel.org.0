Return-Path: <linux-efi+bounces-332-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A2B82479E
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 18:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E8285875
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C44288CE;
	Thu,  4 Jan 2024 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKK3qHzw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89D286B7;
	Thu,  4 Jan 2024 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704390122; x=1735926122;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XppQ0Z5/2+KDvZiMhisTMbOrup02pLM/LdLLZdIw++4=;
  b=lKK3qHzwSwWaiMuUYuy8OvYgtXhwgRHO148tQJ+S8V/Ty1F3cS/4C9fX
   v1YFWFh2YR1mB9NelCug6Mi3LzxffZeV66ZuUyYUxUL8jfSlwTeHS3CT8
   5yPTIX0t4nr6aJtxBl6CUEscZJILyv8h8Eu3igegCpUnvJEsNfztkb9YH
   roojLKTZ2xWMGJkhaE11f1yB804vsmB98F0FCwzhMShECyf2SuSjamJjP
   MuvZteqcqPUvdopnNGIS7EiTe0PPX28LeobyzohLI+g1DaOtaAwTQkQ8K
   F49v7DahGfrdx3sF+vvNvh94LjvKNQbq2Iu87nFBxPExTPi/3tz39Mrbh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4425448"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4425448"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:41:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="953687933"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="953687933"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 09:41:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 09:41:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 09:41:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 09:41:51 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 09:41:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+5zxOtwRODQi/9h4oKFFbXYr8bmdyw5rYgpNTX68LEjXDy6727UO55Fdc8rA3WIgcB9sqTk57EVQOE7lWbxpRv4UfoSOTMoj6/zTpbB1tYQHX2u686Khz16Wd53C/7hu1WM7RqVyoBjKOpANwWX9p8d4JRMFXcVhOa6DjbfMsQnSKwy1uMFVda5OLwPSgJJj3DI0DjrvhJNmcQnUCtRYeuk6Gj15GuVuwE8g5KiXyqi5AaZwl/wKN+WB2Yz9I+MEyi9NYTFA5SnO3XsHJNFhDpIeWkarYllCtSy1Ztp5EXhxdCbVMj4ACjCN5QviErmamkLlbRRCnCF72N757OS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZpPY/DlidciaE2+x+PFOxI7I564CVQswSgdgnqjqfk=;
 b=XdSfZwV/XEK5TEk62VgCKpn0yDT27EGXuWfmvCQWOtDF8QVFbL9OIF3CDCVI61RRe8ll1je+ZwG0VjntJ5YzOTOiY/5pmgTVnXznuzAAiH1h0U5STKa0aMiPYtVxEfrOXR5J222UseZEHkmFZexrAOE324yWgyrMc4KsZc7X5vZ31lCEltwqclbNax6Srf123RfIKnoccCk8tDZQZaumHBnKyDvyOxPMYNHWrIq1KXoOOVzs5u1+XU2rGn8oCzHKa3BABo50GiSBlogauWDxkkZmy8pwlWkqDXy10Ay82cwyHt9XRPShdknWRvgn6tFINmTX3DjMCksnMjlIJKpTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7698.namprd11.prod.outlook.com (2603:10b6:806:332::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 17:41:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:41:49 +0000
Date: Thu, 4 Jan 2024 09:41:46 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>, Lukas Wunner <lukas@wunner.de>
CC: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 8/9] PCI: Define scoped based management functions
Message-ID: <6596edda327c8_8dc68294b2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20231220-cxl-cper-v5-8-1bb8a4ca2c7a@intel.com>
 <20240104060528.GA10504@wunner.de>
 <6596539c9729e_8dc6829476@dwillia2-xfh.jf.intel.com.notmuch>
 <20240104070235.GA13468@wunner.de>
 <CAMj1kXG0QiizpA_oTkV4h2DaF4KuM454_KBno3UngvO7fRm-7g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMj1kXG0QiizpA_oTkV4h2DaF4KuM454_KBno3UngvO7fRm-7g@mail.gmail.com>
X-ClientProxiedBy: MW2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:907:1::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 3388bd88-567e-4676-3dde-08dc0d4c6dfb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHfn0J24AD0Zmley0nrgEzDFf10fvpI2oT/bXc3jBW0LJwA/AcQBhYv7iPvMVv39bQeIwtFtPnB1zx9Meh9o72XBKR68/+U38nG0dwq5IHmos7Uc/4Qgb92+KtRcX7qAIRa2e82iLz+dt7q6XawWryYctxS/8lC8No694xPLK8igBvv1KirC6/lhlHpcrHgpBoS+JtcIDuzbjQSb7TlgJy0738Z91s4r8z23vC2ZZifYn+KB/X4Xz32G1/TaBvGfmfTklawBftYkjCJ6DE59t2nsWtLfev9B3KEeHLKTXb6IsDoOowevOCC5Yq9Wod7xpXsG1jXjA4WA0KgiwsKGm0gb9SPOxhxMCI5UVMsnL/wG/udLaFxAQnS+hPyIca8CnruKLqgC7FwEtSHvqaR+zTbrA2+bnMc/mGCzBlscnBXZgfGb0vEUCvRW/LI9UDTVtxWrthuGBBYXT9K6k2ys8lTze1uZwRJFk2lhUnmj5scnlpg9so2ptdR+OBJ+p1vwFbhZVoYAh9xiCnWfg8tyWZ4GRo9QmDnspYnmi0W3S9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(5660300002)(7416002)(8936002)(4326008)(8676002)(316002)(9686003)(66556008)(110136005)(66946007)(66476007)(54906003)(6512007)(26005)(83380400001)(38100700002)(41300700001)(82960400001)(86362001)(6506007)(478600001)(6666004)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xKSoU30XBxnWmYQODcdryHs3NpjR4LKgJy3HQrqzSwYhrmQHtjqPeuSrbUI8?=
 =?us-ascii?Q?pMuf/fDqsOFLsMUesTthjyrZfZkbIpnbkARsPasmn1klIAUw5OvhjtS36H2n?=
 =?us-ascii?Q?s7nxOeD3vnRKf1tFUbpQS3Nm/wTAbqySDwJWvJns5smj7EsoNAFklUVeV88c?=
 =?us-ascii?Q?9X13d1HihCyEY8jnQTxXbRKX53Sf+gEZ/j6dg2kCpB99v6cHfT8bZKL58IT5?=
 =?us-ascii?Q?ndv8pIbad0lx02Fv/eUKfOcLACfAYAUtTtfefrlZ5//ehYcy4zxYCVamzJzC?=
 =?us-ascii?Q?FwFGv4+yRp9GVCAos3RQSwSpQ5imVAXpOOZoDWWHZv42ifMTQL27FyWuEHe2?=
 =?us-ascii?Q?StpJOvoVpbN9d6kVWyJ+zyyFuwiuwXt2VfV2MhCcy9mkVQzhCNu6xeJyr5zL?=
 =?us-ascii?Q?chP8BQLxt/XYsgpw+NzjODTujVtLtXFPm6KZdCT20kUAUCZXwSx4tJc1z+Uc?=
 =?us-ascii?Q?QGGriMp43AulrtT9IWGIa/Wr9hcqzePTYDa4wfwZMvLuGRbSGrBzn9THmCIi?=
 =?us-ascii?Q?GKMfP6h90kMazCLkvFnr1sRaqHkSHHSOB9B6Md8ViwP4Afaqoaq1BBSNmnAl?=
 =?us-ascii?Q?DoLbgJs/dv4OWweg3Pw6zJ/iw3l4aPYpuOwW8Jlm62fF3ZZv35hPRuXyACMG?=
 =?us-ascii?Q?pPdM7YfdjGi6mN0aULZ0Fp9A6h3w5mxPI4/nnT4d9c/kHxZbJzD1iABp0lzt?=
 =?us-ascii?Q?OWkrP3XaMwamrQHSLDxk/Uk5+uODVppqoB1tX6y0u8LIQ7Te1qlqzUFKIzNo?=
 =?us-ascii?Q?ciS0Bkyh3kcY+dZ7u3BKIaHKtPIOEfef7rT5RjUBAmuEzLpz/S6kSFegifH+?=
 =?us-ascii?Q?Z7LfFfeDSlKjneJ1uQDv+FzG78Izq5QYUEJ+GN0aWIB/OguZyDkDxTL7tkvU?=
 =?us-ascii?Q?rDFcD4ufwpkyplKqdUfklh7sf5WhwEH34hcsMWyeAFRws01D4RS6w1seBIJn?=
 =?us-ascii?Q?rXQvBIlqQMvfBDfjq/KBu7XGbIcwav1SHp/tm3RSG1AO20ooDXZj1OKFKzWT?=
 =?us-ascii?Q?O6aIpApQ9lO+p0eUjI2BSmZbY8iIzPWBF4AJREoz+MSjMcH2Ymph2b/oG+tX?=
 =?us-ascii?Q?q0u0iSd2E5tHrfQWAh3B7XEMrgfo1TBi6TZTdkExRnCEPZpzJrmp7zlSzAFN?=
 =?us-ascii?Q?53Th8HMuL7qAF6rxaFjBueWeW/j60k7xEdELA5KtvixmKGPhz26kEjp0o6HK?=
 =?us-ascii?Q?ImCr9D8diHhQEZkcHgnpe3RxzkyInUYF9rNUKNtVrX2O/FvGsldzvT/f8V87?=
 =?us-ascii?Q?v7M9937nBuICAKG+3sfhT62Trc5fkPbb9kLg6RgjAJmV4CLKGasHP57pmPVf?=
 =?us-ascii?Q?j133lp7JsgkbcjMYm6ZZpBpfO1WGhZ6/ExHJwMvHCecCeN4lebb/uDbKasuK?=
 =?us-ascii?Q?yk3El8ubRwfjjLZgLvm3CT+c4aC5Cbbo06KKX2OPgsfrRhy1afqJnevcFWS8?=
 =?us-ascii?Q?8Dh3R4w4GbUd94PMgdVfl82TuRbFDisKTZ1RLOHKzPZSnpyV+GWWtt78bEUp?=
 =?us-ascii?Q?b2tkeL4KhdV14Z58fErSh7NkjBWCEWGqZ58XORXcXLUhrGYektOtLUgqux83?=
 =?us-ascii?Q?Z63pQn9Hab2Cwu96CYCupCZSMkBdSJZZZnfmQVXLVpBt5ZPnxDSenPieO552?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3388bd88-567e-4676-3dde-08dc0d4c6dfb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:41:49.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p55wI54Jse3GKzqKG1A+2oc+siGDzHtji0RoBbtkOltZbonUlKOqpXxFJILoGduK6Y10+vlkTnjRaKbLqA+wBDjbNOqmkitUE8ABHDIHMxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7698
X-OriginatorOrg: intel.com

Ard Biesheuvel wrote:
> On Thu, 4 Jan 2024 at 08:02, Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Wed, Jan 03, 2024 at 10:43:40PM -0800, Dan Williams wrote:
> > > Lukas Wunner wrote:
> > > > On Wed, Dec 20, 2023 at 04:17:35PM -0800, Ira Weiny wrote:
> > > > > --- a/include/linux/pci.h
> > > > > +++ b/include/linux/pci.h
> > > > > @@ -1170,6 +1170,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
> > > > >  u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
> > > > >  struct pci_dev *pci_dev_get(struct pci_dev *dev);
> > > > >  void pci_dev_put(struct pci_dev *dev);
> > > > > +DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
> > > >
> > > > pci_dev_put() already performs a NULL pointer check internally.
> > > > Why duplicate it here?
> > >
> > > Greg asked the same for the introduction of __free(kvfree), and Peter
> > > clarified:
> > >
> > > http://lore.kernel.org/r/20230814161731.GN776869@hirez.programming.kicks-ass.net
> > >
> > > Essentially, that check is more for build-time than runtime because when
> > > the macro is expanded the compiler can notice scenarios where @pdev is
> > > set to NULL (likely by no_free_ptr()) and skip the call to pci_dev_put()
> > > altogether. pci_dev_put() also happens to be out-of-line, so saving a
> > > call when @pdev is NULL a small win in that respect as well.
> >
> > Doubtful whether that's correct.  The kernel is compiled with
> > -fno-delete-null-pointer-checks since commit a3ca86aea507
> > ("Add '-fno-delete-null-pointer-checks' to gcc CFLAGS").
> >
> > So these NULL pointer checks are generally not optimized away.
> >
> > I've just responded to the discussion you've linked above:
> > https://lore.kernel.org/all/20240104065744.GA6055@wunner.de/
> >
> 
> AIUI, Peter is referring to constant propagation of compile time
> constant pointers here, not pointer variables where the NULL check is
> elided if the variable has already been dereferenced.
> 

No, it is for auto (on stack) pointer variables. Consider this sequence:

	struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(...);

	if (!pdev)
		return NULL;

	if (!check_pdev(pdev))
		return NULL;

	return no_free_ptr(pdev);

...that expands at compile time to a first pass of:

	struct pci_dev *pdev = pci_get_domain_bus_and_slot(...);

	if (!pdev) {
		if (pdev)
			pci_dev_put(pdev);
		return NULL;
	}

	if (!check_pdev(pdev)) {
		if (pdev)
			pci_dev_put(pdev);
		return NULL;
	}

	struct pci_dev *tmp = pdev;
	pdev = NULL;
	if (pdev)
		pci_dev_put(pdev);
	return tmp;

...the compiler can then optimize this on a second pass to:

	if (!pdev)
		return NULL;

	if (!check_pdev(pdev)) {
		pci_dev_put(pdev);
		return NULL;
	}

	return pdev;

...if the NULL check is dropped from DEFINE_FREE(pci_dev_put...) then
this becomes unoptimizable by the compiler without
link-time-optimization (LTO) to see that pci_dev_put() has an internal
NULL check:

	struct pci_dev *pdev = pci_get_domain_bus_and_slot(...);

	if (!pdev) {
		pci_dev_put(pdev);
		return NULL;
	}

	if (!check_pdev(pdev)) {
		pci_dev_put(pdev);
		return NULL;
	}

	struct pci_dev *tmp = pdev;
	pdev = NULL;
	pci_dev_put(pdev);
	return tmp;

Now, if pci_dev_put() would become a static inline the compiler could
again do the optimization, but it is otherwise free (post compiler
optimization) to keep a conditional in these DEFINE_FREE() instances and
not worry about whether the actual free routine is inline, out-of-line,
or has its own NULL check.

