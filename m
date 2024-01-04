Return-Path: <linux-efi+bounces-321-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438D7823C51
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 07:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1601F24E1C
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 06:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B811CAAA;
	Thu,  4 Jan 2024 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsTz4Um2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE7F200A0;
	Thu,  4 Jan 2024 06:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704350628; x=1735886628;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yqhMjcoUKO9Uyjj6bWT9L0DDtEFR6c30SLlvZDT999Q=;
  b=nsTz4Um293nGFbT97+bY08JlO3/PZs/APLy3gz6B2TqxeU4mt31hptxM
   ge9JePbD0m3Tn00qJe7kqTqHdngC5Xmi95Um+QBfrpQbBrP99T+7KzvI0
   cTMdQMJ7FVdCD+4hKn2BVfQ2Y1Z24M1yO6RHEjzdUWc7zOTlV7uTUocW7
   ghGq3M9CreSyVmQn2h3BtO9Tz/aUkg/DXoBc6Z3SP3d4tUqtpkfWSysxR
   fWT6TZcJLI4uyPGdlPUikH39PzOLLZPPpUanm8IAKTog62VTYyXDApO3P
   WvA0uj6NmwawfsGOigaHERWyN5rtjZVNdIJO42tdAZswrKJhv7vSHPA1N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="4234478"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="4234478"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 22:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="22367485"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 22:43:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 22:43:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 22:43:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 22:43:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+axxo+r99LCboAQT3tDPgkmBcsNcqixgQJcXKUK1j9dXo5BHPUE47pMcjPBJttqm2hKKMIGramkU+9zum0+jFCoBvFmn31rcwMw+PMowjvTZYe7CAnGTll2f98z4vIrG8bXK8uAiqrXV+h8RmuLorg1KA3cx7q9ig5JA93AMDUhaOFnDWPsCL5QjYkRw9OZEtMyGne74HiMdA+u7b7dhGXJzE0FF7XVdFrirD2ywe7JYY3OiYyY6BrDCXUDNAG1DeKMG+NBqTSlLweTGjSXlzCXvpwK0SQldS2G/oYZSLNy/+SGassWw5ae+go8sBHDxYAXW4q2xI371FTsBDoxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuCXcv/72o9R4hGILD8C/KK5e3SqYnlJTpw1dQcSMMs=;
 b=MduI8m/VIF2+GanicSdED3XgnmTtdFNWLdK5m8jF3txUHXD1KnNZ46NNMlLii+UCx2NSHX0No1TOHVc2PDeTNWb71xk0+TEhZJ7V4bvBT5jLbfggkLGrlNaglBQB9TWb1hB5+0MDPmqcf9xoG6RlLnP+Fk9VBynO6Qr6QQL2kKDvwceWXeqHVMi7fezCz+1pvC27mRgqVpDY1NUBP31/F+i+hGYlmNnUaQU7A6wWL6SZGjoUxYKqNuImHRXl2vi87/TszjLazqrR3TIwP9bbiZ6k+xd7nTTfzB4xaQYGeK20KZ9lGysnw2RgmnekEp1KZxhskZVrh5MZw6DJJt/P0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5352.namprd11.prod.outlook.com (2603:10b6:208:311::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 06:43:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 06:43:44 +0000
Date: Wed, 3 Jan 2024 22:43:40 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH v5 8/9] PCI: Define scoped based management functions
Message-ID: <6596539c9729e_8dc6829476@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20231220-cxl-cper-v5-8-1bb8a4ca2c7a@intel.com>
 <20240104060528.GA10504@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240104060528.GA10504@wunner.de>
X-ClientProxiedBy: MW4PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:303:b8::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd4dfe6-8891-453b-efc3-08dc0cf07edb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRIgLil/KSe0wtA0RZHh+whUb5qAr47RPPH07oynnldH4ThUblH39VLVZBRE20tzNjZveYvDggQiEmcmEEB1w0V1r1MYyO8yW6GVFTK60xI8KnfR9bogrbr3pSd5hqY1RDkdEwXbng+jtESmikIUwoIX2q1TTR0RQfmSDoKVAKFWcUWh9xS0BlNUuHpZ4PG41JALntmfIpOtVWSDNgTxo70R5o5TsAFhOE37xnsFtWGCF50AqHXtJY3FptpUHvDQ3AkzMUHXpFELMSn45bZqW2DYdAiBk4QrIALchLLD4BM0gsBZqrc81oGj/nmNkGgEQgenbqoiyrFNg8Hy759t4nUpAmE9dPJQgsiD9Rpxtw67ACw4Z0In6MGd6JjV17B8wSHBBCBvIOxfb0dFSKPKdp7ahUGeLJRx/0evBjvPhcvt+I/RtH78BeWmeHDHM2LCFE09ZZF9exAjYn7gjBBAjWDcwz8x8+BHv66teB0SOn3jNV/yYsSbpldbvCoR6Vd21I9xlB+kXgtLDgyylTlFpK+95dYb/MXmLdR1W02Pggg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(9686003)(6512007)(83380400001)(966005)(478600001)(6486002)(41300700001)(4326008)(66476007)(6636002)(316002)(110136005)(54906003)(8936002)(8676002)(66556008)(66946007)(6666004)(6506007)(38100700002)(82960400001)(86362001)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZ4Y7cR7UoCrgt7btqeg2OIiaIPICWBpGRHhnKJ482ckgkUWUKHFhnOecU2m?=
 =?us-ascii?Q?6bo+bsJwrNzrvcVnB7Zhy0/1V0/cZr22BZZvciL+C8dyB6nIa6fcxwPZHd+y?=
 =?us-ascii?Q?vC4t3HTivWp3DS7/V9jgq3GHYJtf7Biv8tXR1ZOgXb7zsLh0b3oRKdKh/f0u?=
 =?us-ascii?Q?LsZTzUqy5/sCY+Bez3OG3/FVsZTEye/4hZVLPSn0espXFKBhTFF0+a1gD17O?=
 =?us-ascii?Q?LeP4r8rQMU2VRWphTTqIJgTJZxPEKQMECxi1f3unjLkjplMOhsKo+9T59CZK?=
 =?us-ascii?Q?ktVBmQ0uDwI3vNpsGY5klWaHiSXETSdRri4L5bxfTaHQHMcRjLzTChX9u1em?=
 =?us-ascii?Q?qyZmPPDHSMaGnuCYmBluMk9pdDGkC7lk1Y1liVS1KsOYZcTL2EnFHtwZSZAE?=
 =?us-ascii?Q?zDtCwnB+c4opFDLGl+eZvxDm0LoPYXk5AvDoqe9nnHh2XRsQPoymuEs7rekO?=
 =?us-ascii?Q?y4rLVwiE2zEJocDxUR8jbxD56Sbgi9xyxZzUeHcCIdyu9gwRc5OSlAeHc9N7?=
 =?us-ascii?Q?v1po58hWVUDJgHW4/I3XQPHggP54q0rziewZFmYjHspZYEzqL2pKSioBKhcN?=
 =?us-ascii?Q?Xt7KlxfcwRaB7nowVnPgF3o3RmwI2mmry95EPc6s5JX6LA09OJB322CWdUpS?=
 =?us-ascii?Q?b4SUXhohY+xXBWmscQ2dyIbtXkeq6a90SBxUck5ffRkOVjevccEK/UvW20wl?=
 =?us-ascii?Q?t2LXaBCWfqPfqb8dFDY3GI9nfA74fdx7gEaDOBiArO6tuCjY3RvvWkNR2Ja+?=
 =?us-ascii?Q?pxLli/xviVz+2mzjPea+UhQ9k3P1FA9HqDhG2WIVEXCBB7F5+69W6424EGj9?=
 =?us-ascii?Q?qjVxtpgH4BHLxwWXNcTn8Kgyk4O3FonnKhFrcd+UdHD1sNBP8E14N2qDUqoq?=
 =?us-ascii?Q?Ztorl2jrVtLOJ76b9V/O5PMAzlN/lVTdC/2rM6/rxMx8oTAPIW+pkHUTSigq?=
 =?us-ascii?Q?vfFjJ8p+w/OPvgTIrcLsriLVqxQkAN4+p4t6UdYOvOs/T3M8ByBIZbHWQtyS?=
 =?us-ascii?Q?6z4v1rQdrrjfTWNyM+MJmcef+xAwtylNKnEL+xqYZwTimcQjvCWYl8o3UTZV?=
 =?us-ascii?Q?Vh2GJykUZuRnwjcNND2mN4vB95mBPaMmwtkjG/Gbz+VuimphBhVcpABGZi3H?=
 =?us-ascii?Q?fHLbptXl1ZfhqVqdf5ahGVo8nw0dLxhQRyWI28oyFVM1Tr7cxM/WehfhAll9?=
 =?us-ascii?Q?CO9aBzDXaoh8Zu12BijoE3t01XlemO3l222hJq/zRnPamiwdT+kWukZQzdLX?=
 =?us-ascii?Q?i0kyHq5A/RGHzWt+Q7ffy7NcBzBFOkz25/349xCC/LSHxJ0q1+pwIsoZ8z4x?=
 =?us-ascii?Q?ukNQemBepZNZ8qXIJtsEC6Lm31ZVRmZ+jMmw3tew5eea+hvNFIW+RXYozpyG?=
 =?us-ascii?Q?33Zpe7ISz97bsGoh+jhBE4K2CUsVKqI8MuhB+ddgeh7jMcA1VhOwAnfuYjl8?=
 =?us-ascii?Q?/Fx6qrdEnJBuNhlapPuTyo4YLJcDaYGp9foGVJXRLxZW+F19HpV/KUeD9LhM?=
 =?us-ascii?Q?FHUj0FT4pb4DM/KaGgGeJM9KoStMbTXZ5MgpYnpq4mOwzDINmm0syQhW/Cmx?=
 =?us-ascii?Q?cBltVghqU/6E0GNRdkEw9JSv6xn/Omy8q49iFjASYXBnOa3uF3rHYUyRsTR5?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd4dfe6-8891-453b-efc3-08dc0cf07edb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 06:43:44.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uo/8V75jlevDr4P30cteT+Z2PNCO9biO5dwaQoJRzmVmS+b39+IEvtiFSAeokxlX4HOLFiNkDZCwu8cDUZzhk6tDopBOEu7jVBhnFAGT0/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5352
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Wed, Dec 20, 2023 at 04:17:35PM -0800, Ira Weiny wrote:
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1170,6 +1170,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
> >  u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
> >  struct pci_dev *pci_dev_get(struct pci_dev *dev);
> >  void pci_dev_put(struct pci_dev *dev);
> > +DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
> 
> pci_dev_put() already performs a NULL pointer check internally.
> Why duplicate it here?

Greg asked the same for the introduction of __free(kvfree), and Peter
clarified:

http://lore.kernel.org/r/20230814161731.GN776869@hirez.programming.kicks-ass.net

Essentially, that check is more for build-time than runtime because when
the macro is expanded the compiler can notice scenarios where @pdev is
set to NULL (likely by no_free_ptr()) and skip the call to pci_dev_put()
altogether. pci_dev_put() also happens to be out-of-line, so saving a
call when @pdev is NULL a small win in that respect as well.

