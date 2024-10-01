Return-Path: <linux-efi+bounces-1868-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFF698C1FE
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 17:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD6D2835E3
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC231CB338;
	Tue,  1 Oct 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+a414/Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C31CB336;
	Tue,  1 Oct 2024 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797650; cv=fail; b=pO/hAoi70czgSS3ieN6vE1eIyGpPJsoD+0s8YnKZuckUzDLOcPWRkXyd+ocp5wTmEI++nfTKqL450qx4ju9aR/nTZj+PYF9YlwkVfTWao6QQMKy58dR2bUiruNBYOrCKnUVrqIoq4pCXLsNgYNc2B5THQpFs0xqBhHbZUenNjGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797650; c=relaxed/simple;
	bh=HRKMFjkKIakCJTAvAe7OeAC5BPGE5N659YUBkBCLuV4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RDAx60dDwWwVzkfM0joG6ImrpMM65Gb6c7PghVvjClqX1Du5KDlkuuNRRCOx+21vz4wWAn43xwpS0HYDmU8EZ3gZwt1J9AITFIMix8jhfizHBYSC2udxBR2AANtfL732g3wPMmSllPWAjLNbcaUHIplOIsk1lXisAo2VENNGymA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+a414/Q; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727797648; x=1759333648;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HRKMFjkKIakCJTAvAe7OeAC5BPGE5N659YUBkBCLuV4=;
  b=g+a414/QJLGfqcXwI8H5bF4KIIgmQdl01mvRg/Tk+Gt/y2/g5eFQfse4
   tmGj/dJHpQhz4/DcruJwraewo/T8fa4HXSHJh2o2nGBRPuEYOskSB4eJ6
   R3fHwUHai4M6OKXDlK+E0n1grfZzX1nsgmFiw7+L5lQ8mPOu6IQ/Yd5LH
   SXdG50ifco/XlhN6hWlQX6oDnq0jBNIEg4ykFFN3pamIOkYhswPTUDTzV
   PiapxwuTgF8MDuwmJxifjJnAV7BZ1Tndn2xVFkQJjdql1qQTQIKst5MgQ
   IaViQXpw51clh7osmriMqJwDbREVZ5uyVLlItu7gKYMosvN7i0+iP6brV
   w==;
X-CSE-ConnectionGUID: 4nO4AspKSyGV/GA034e0dQ==
X-CSE-MsgGUID: ZH0B8CAaTa6dVmygWYeQyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27115631"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="27115631"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 08:47:27 -0700
X-CSE-ConnectionGUID: V7pXjOGnQ1yvk80QVUpMPw==
X-CSE-MsgGUID: xjeMtICfQOSCaNwASKiYIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="74027529"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 08:47:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 08:47:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 08:47:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 08:47:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML72ZNR7/JyaVVpO/dt1yUMuA4aDPyqvekVAsQgcGbWNSDNPWH/LGNc5B1a1D8g9Q2n4qkx0MJGAwTxjBPRR6XQOLhKPBHsdLNo2WAJXrqabhJ4R9xy55BH3OPyKYZjEFdxQ/v3UkQEZFObfeQgXXFPN+O4y1QIO/ryvxqk79Xvvqg4M/5xgQGMiDht5SyIKvvHVWKb2npB9l3QX35wma6In6ayXD2LKX9zuoIbdXgfr+xDudaUqM6xXM+I8zYL0YHcg6iAEw1Gn38gR5bH9G5xxg+B8riuqpRDhl15oV3tyJII/wwrj1uf+LWzOBbMeenByhkRpEHvQRGnKHJI35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRvF2SMNFhF6CKwdMZr2nN8A1fVZJuvKtRMiohcY5Ys=;
 b=rRAeG/vKEc9lO6TVIM2uPz/rprqrkKBa+GFhfhbLFsnzLeSH2R+stPs2j0gM436eoM4J4rOwHaMuQZCqPW2nt3KrNzZevJWoQuMKDpFc8UPHgUvOGn79racfBks7GdX9d5vpessE0mAcjbAMDhwNCh1KJmcCfevVSkJaEw4bonSTUYRT/uL3QO/5gf2m7iNlAWn1Ke8u7DfE26SSiueajyNX/2v+loovOwZluaI4JBBBsdXth9y1IuC3fOFeLpgtZzDf8wwakk47fYB/f22cI0HrnvdduS1Y2lrISujKfe73YwC1cgX21++w90Kg0UfOHhUvPOHajjFYkbfzCDHyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7456.namprd11.prod.outlook.com (2603:10b6:a03:4cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 15:47:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 15:47:16 +0000
Date: Tue, 1 Oct 2024 10:47:10 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH v2 3/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
Message-ID: <66fc197e1993a_b5d942942d@iweiny-mobl.notmuch>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001005234.61409-4-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR04CA0156.namprd04.prod.outlook.com
 (2603:10b6:303:85::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c14736-486e-48df-a169-08dce23052fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Id/RnSg+eLIasrXge7hOhTNLcFRSgUpQkooXCLGAocTeVZOnuFTXD3SEEQ+?=
 =?us-ascii?Q?KzR7wfE9UQx2czJsDmY/Nh3CrktovcqoZGsiN6UurP2jb6wqBayZQ3OVoMXp?=
 =?us-ascii?Q?F4HxvGUQsuLBWhDE9wjbF0bNFszPADIJisubv7eeMpafXJ+SK+UmOTLKV40f?=
 =?us-ascii?Q?m1vVMJwELb20Fpj1Kpaf2srB9pkRuh6tx9h5eet3NGcemwWeavOeEv7fPHJ5?=
 =?us-ascii?Q?dBt/ULZS1usazqm5E5E2cbIrrk/HVCyMRtrgb0n1Y3TemtMUZBKf3VdkNE5o?=
 =?us-ascii?Q?M4jsTtsukUXXTz8TQC7xuRrnEi7oK1/xgbxx7k1oOFEB84CKoHCLO0DsLrEL?=
 =?us-ascii?Q?geQqWgPogE/ko/DXrqcqU2CGU7mGDsexq3NZSWLeKtha7yfJVWu4qaWKMw3F?=
 =?us-ascii?Q?uvloAut/4Il1iHTWmtEn7lHGVesGRAT81ZLsJYW+YUT0dYKZ6r7rV7XPXXQA?=
 =?us-ascii?Q?0AsvV9vD61PbxcweD/MoVJt2yaHZvUz/O+2Wlr0GjyCZ3RPP5Eq1iHiEM5lQ?=
 =?us-ascii?Q?F8/TzzBG6xmYIzJjBEXQbDpgRP5R4Dz/mEITuLWhxWi2bb3NgcM4KH63HDmf?=
 =?us-ascii?Q?t9XkCaCjH069SoyoGRJorhSDEoNJA+e3X9UqViuzrfkqvtaFhXXjyPI00gqb?=
 =?us-ascii?Q?IzcBXgcmeQdVBIxIy3MMIfraIaq+vpo9oHMzZKOBCcWP4bw3iCZ+8c3m0Pwt?=
 =?us-ascii?Q?CxpxHK5BkfTRTPU1dTMsGj/bwepwv4HEAgQAKths8cXiaQD8z4KGpD83s0W/?=
 =?us-ascii?Q?x2rxv0zHokgQKMKXqaCSRKq0SL59ZBJTsT45uj+WSuVc8NWVNRyoOejDmtoI?=
 =?us-ascii?Q?5AibIYoQjPLsJ2i6zp8738+x2/Gr8qXOj8m8OUWkFkqYWwiHcWK8zQ5fetO8?=
 =?us-ascii?Q?3/75X1+sUt9hl/shdfONK1G2jibRcyYe/AsMEy00/kSxP8jBUmEfR1QdVIdl?=
 =?us-ascii?Q?6VSyR5PRPcOvhlBxCBaI/wImOkXaQliBcJopTnpmNJGDLF+hvZrqwkK4Cs3o?=
 =?us-ascii?Q?L4oeGMPOhGQitKbJGGJHY3FkmI7jKKyGFss9yK7766xK6ekpT/d7eMiiBi+k?=
 =?us-ascii?Q?VHUpDKlCi2ZVaxXcgWaJAJ33Sc3s9LPBcOqFssAOggpxvnbZTkP8K+EjOjSR?=
 =?us-ascii?Q?T75FPya/6ohiav0C/DJYko1U6ntzHP3vDGZL3IPFbj23HAs0hevpra5mWyBh?=
 =?us-ascii?Q?ZqhWgaO9hDMNmTzRZ3kH4RObFQeG3r4EhGbdMYMelRZCkzbRAh3isOKXTdtr?=
 =?us-ascii?Q?hLEbA+XJBjt7BMOtCmFbePSKer70xp7Tno3zrnUzaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ArfMjRmsU3jGSeg5UmEY07tOFHmdcO2DtjuthuMCRdIQDMNsM5+OPIBpHB4S?=
 =?us-ascii?Q?PS4xusPbyOA8oh4GRcMB5AmKt2HHrAPM0fX0Wfh3H45MY0O+D+1B06OjONqL?=
 =?us-ascii?Q?N4eydoJdLwMPc1QULWQmPIwHXlhpvnr3xEDZY9vrVjMMbWoOfnoBgkNj1W9G?=
 =?us-ascii?Q?K6rJ0ZXQWB7wmAtYcuQSZjHkO40EGck7pyGdS+0HCLd03VWE9fhaPDij69M0?=
 =?us-ascii?Q?v9HCuoSlIvQwCWLmF51V4j9ivZ/+4Z4faN80/1sDL4zoIW8e41OLaPdAY6I9?=
 =?us-ascii?Q?rOfT8SJba/ILzjspXy/P6iWYB9N4Mjcim05+hMKZHLvJj5rn2BKdN6fvnIKW?=
 =?us-ascii?Q?N1JGSbkhwIui9VapKLGPPceyghcoFd+IIWnePAIKmU1u79D1fZ9qC5A1Qn3t?=
 =?us-ascii?Q?aYOJMc7LcLmY4f++3m5TgeOHSgjPmJIGocO/lAG+MwlwUZhAvycoDi+g7ZGh?=
 =?us-ascii?Q?XFa1VFl7aYLtcn5CnSwbC5Dc3iemQigPWImeNSRemWnH/MaqO4yTA+czyio9?=
 =?us-ascii?Q?hSSa74NhNvJzSxNHsMB9TSSPO5+/CvG11XDIwBElYizJ3SJMIzOspTFqLUOs?=
 =?us-ascii?Q?PXr+cqGqiaxjyUWmzMKBpbkQwKndVXvIT47wtQsxYzlKLdJYBOCHO+LUDFBH?=
 =?us-ascii?Q?N0tDJdqPGqX4qWAKKP3VUgSIbRx2LMVo6ULc/pwpmK5DIGqrALXu7RzlhJFU?=
 =?us-ascii?Q?NJX5EURyiy2CSJqoKAYWL5NqVKD9L4bX+hI+tvYsSqBZ9deJXRZUQleCF6JU?=
 =?us-ascii?Q?rOvQqhTyR72LGTuOprf+cq82cuD1XRnwGHf2S59VwB8wWz+/624ftNkQEs3J?=
 =?us-ascii?Q?gcKnxcPxhdPpUmwKikys1k2iV2B9pA0AYvW0Uw3CS5EoC0lBONHYCYWYG0Mx?=
 =?us-ascii?Q?oTCCt8R6VOa8McYgytEkB4O/JJGRY8sGVjuni4d7TYbXqtgCw/H7erDwBDFX?=
 =?us-ascii?Q?wjv6fU8nXvDmi7OsOd7JkNQ67pWwpVoUav6rxsoqsjd2U0vQqNU9fQKzPkQI?=
 =?us-ascii?Q?0h80wyWK7Txv9YqB/15Oco7qFRS3R7KIAuLYMYeaLMe8iIQD1kHgKndxaw+r?=
 =?us-ascii?Q?JznlxPouapA4pioA8gHccAmSeAqZBvdxRM2Dh5pFfNkVoZcqcSkfeecPuhoV?=
 =?us-ascii?Q?t4NuWjZe1HnKJFaZfzhdkOX87JrWNxMuWEkAQCfX9ldKkSW9ZXncfY3acBC1?=
 =?us-ascii?Q?xaQP1rrd6wHvsrYyN1/wTc432iCzWlYeIFpNCqWOkBDppimZQ6GksD/T2FY/?=
 =?us-ascii?Q?+f0qsyvqoHG6xpdTpQ3RieS9Xx1s4C/rM64Tfq63L3wTRTsfHCSWhSx/rrtG?=
 =?us-ascii?Q?HMIg2J9/VccHa5aAlQwmM33YE87H17Sm3TXdohKZ68b7Hx20iSGfnpmIm1y6?=
 =?us-ascii?Q?PkKX8sFpZYq03EV8D6EnLXMBRjv2yVfWmeszFgEhbobuwqKvpYxoHHVQB0Ti?=
 =?us-ascii?Q?Ez5u/BQUQQ4loA+9DfeGtgJvlw8BykGwIO4J+jc25omUVfZhcrM83EnU5Vxg?=
 =?us-ascii?Q?Xj7rdvauUdOEj7WYx4N8Mumoq9uxzFXZ5snQkFisUO8L+G6XDTClUgxc5JJs?=
 =?us-ascii?Q?MdrZeNN6izy1+Y7O8YV7GCwuwG+n7CjrW0zqSDt4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c14736-486e-48df-a169-08dce23052fa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 15:47:16.0358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLn6UUpM5MUr3lv0pHHhQLa1aEN/zQDoFPJ9qSrvcPut/etL8Z9jy0cX6qlVL76Ti5M3Gw7KiAXHVEPp1SGZRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7456
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
> 
> Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
> Severity, Device ID, Device Serial number and CXL RAS capability struct in
> struct cxl_cper_prot_err. Include this struct as a member of struct
> cxl_cper_work_data.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	Defined array of structures for Device ID and Serial number
> 	comparison.
> 	p_err -> rec/p_rec.
> ---
>  drivers/acpi/apei/ghes.c        |  10 +++
>  drivers/firmware/efi/cper_cxl.c | 115 ++++++++++++++++++++++++++++++++
>  include/cxl/event.h             |  26 ++++++++
>  3 files changed, 151 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ada93cfde9ba..9dcf0f78458f 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -717,6 +717,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  	schedule_work(cxl_cper_work);
>  }
>  
> +static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
> +{
> +	struct cxl_cper_work_data wd;
> +
> +	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_rec))
> +		return;
> +}

This is a bit odd.  One could call cxl_cper_handle_prot_err_info()
directly from ghes_do_proc() in this patch.  Then add
cxl_cper_handle_prot_err() in patch 4/4 but either way is fine with me.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> +
>  int cxl_cper_register_work(struct work_struct *work)
>  {
>  	if (cxl_cper_work)
> @@ -791,6 +799,8 @@ static bool ghes_do_proc(struct ghes *ghes,
>  			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>  
>  			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> +			cxl_cper_handle_prot_err(gdata);
>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index 4fd8d783993e..08da7764c066 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/cper.h>
> +#include <acpi/ghes.h>
>  #include "cper_cxl.h"
>  
>  #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> @@ -44,6 +45,66 @@ enum {
>  	USP,	/* CXL Upstream Switch Port */
>  };
>  
> +struct agent_info {
> +	const char *string;
> +	bool req_sn;
> +	bool req_sbdf;
> +};
> +
> +static const struct agent_info agent_info[] = {
> +	[RCD] = {
> +		.string = "Restricted CXL Device",
> +		.req_sbdf = true,
> +		.req_sn = true,
> +	},
> +	[RCH_DP] = {
> +		.string = "Restricted CXL Host Downstream Port",
> +		.req_sbdf = false,
> +		.req_sn = false,
> +	},
> +	[DEVICE] = {
> +		.string = "CXL Device",
> +		.req_sbdf = true,
> +		.req_sn = true,
> +	},
> +	[LD] = {
> +		.string = "CXL Logical Device",
> +		.req_sbdf = true,
> +		.req_sn = true,
> +	},
> +	[FMLD] = {
> +		.string = "CXL Fabric Manager managed Logical Device",
> +		.req_sbdf = true,
> +		.req_sn = true,
> +	},
> +	[RP] = {
> +		.string = "CXL Root Port",
> +		.req_sbdf = true,
> +		.req_sn = false,
> +	},
> +	[DSP] = {
> +		.string = "CXL Downstream Switch Port",
> +		.req_sbdf = true,
> +		.req_sn = false,
> +	},
> +	[USP] = {
> +		.string = "CXL Upstream Switch Port",
> +		.req_sbdf = true,
> +		.req_sn = false,
> +	},
> +};
> +
> +static enum cxl_aer_err_type cper_severity_cxl_aer(int cper_severity)
> +{
> +	switch (cper_severity) {
> +	case CPER_SEV_RECOVERABLE:
> +	case CPER_SEV_FATAL:
> +		return CXL_AER_UNCORRECTABLE;
> +	default:
> +		return CXL_AER_CORRECTABLE;
> +	}
> +}
> +
>  void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
>  {
>  	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
> @@ -176,3 +237,57 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>  			       sizeof(cxl_ras->header_log), 0);
>  	}
>  }
> +
> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
> +				  struct cxl_cper_prot_err *rec)
> +{
> +	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> +	u8 *dvsec_start, *cap_start;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID)) {
> +		pr_err(FW_WARN "No Device ID\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The device ID or agent address is required for CXL RCD, CXL
> +	 * SLD, CXL LD, CXL Fabric Manager Managed LD, CXL Root Port,
> +	 * CXL Downstream Switch Port and CXL Upstream Switch Port.
> +	 */
> +	if (!(agent_info[prot_err->agent_type].req_sbdf)) {
> +		pr_err(FW_WARN "Invalid agent type\n");
> +		return -EINVAL;
> +	}
> +
> +	rec->segment = prot_err->agent_addr.segment;
> +	rec->bus = prot_err->agent_addr.bus;
> +	rec->device = prot_err->agent_addr.device;
> +	rec->function = prot_err->agent_addr.function;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> +		pr_err(FW_WARN "Invalid Protocol Error log\n");
> +		return -EINVAL;
> +	}
> +
> +	dvsec_start = (u8 *)(prot_err + 1);
> +	cap_start = dvsec_start + prot_err->dvsec_len;
> +	rec->cxl_ras = *(struct cxl_ras_capability_regs *)cap_start;
> +
> +	/*
> +	 * Set device serial number unconditionally.
> +	 *
> +	 * Print a warning message if it is not valid. The device serial
> +	 * number is required for CXL RCD, CXL SLD, CXL LD and CXL Fabric
> +	 * Manager Managed LD.
> +	 */
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
> +	    !(agent_info[prot_err->agent_type].req_sn))
> +		pr_warn(FW_WARN "No Device Serial number\n");
> +
> +	rec->lower_dw = prot_err->dev_serial_num.lower_dw;
> +	rec->upper_dw = prot_err->dev_serial_num.upper_dw;
> +
> +	rec->severity = cper_severity_cxl_aer(gdata->error_severity);
> +
> +	return 0;
> +}
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 57b4630568f6..5b316150556a 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -158,11 +158,37 @@ struct cxl_ras_capability_regs {
>  	u32 header_log[16];
>  };
>  
> +enum cxl_aer_err_type {
> +	CXL_AER_UNCORRECTABLE,
> +	CXL_AER_CORRECTABLE,
> +};
> +
> +struct cxl_cper_prot_err {
> +	struct cxl_ras_capability_regs cxl_ras;
> +
> +	/* Device ID */
> +	u8 function;
> +	u8 device;
> +	u8 bus;
> +	u16 segment;
> +
> +	/* Device Serial Number */
> +	u32 lower_dw;
> +	u32 upper_dw;
> +
> +	int severity;
> +};
> +
>  struct cxl_cper_work_data {
>  	enum cxl_event_type event_type;
>  	struct cxl_cper_event_rec rec;
> +	struct cxl_cper_prot_err p_rec;
>  };
>  
> +struct acpi_hest_generic_data;
> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
> +				  struct cxl_cper_prot_err *rec);
> +
>  #ifdef CONFIG_ACPI_APEI_GHES
>  int cxl_cper_register_work(struct work_struct *work);
>  int cxl_cper_unregister_work(struct work_struct *work);
> -- 
> 2.17.1
> 



