Return-Path: <linux-efi+bounces-1202-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1A59047EC
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 02:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77881F24654
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 00:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895C2382;
	Wed, 12 Jun 2024 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOuaJr6/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614017C;
	Wed, 12 Jun 2024 00:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150875; cv=fail; b=tlSCp4TrXzoQ2KQ+uN6//n3GtYkaNP6BUf5pg8RyAr4tSpiRd71HJpkJGOYb5uNhapoamLBHUxS8eG7qfkXm967McFKha138BPKcZXxqNPORaq2/pR3zIbXbpA+nntcCXZ6C2i/jLNuHu/k85EJui6WX/d1RKxCcxoRKyIkM71s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150875; c=relaxed/simple;
	bh=YSeUVzM2WmmHg22O7AH7I4pJbWFDzgqZvuTaeFRzCgE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jU3BccLxxGex1LcaaHZonQjcP5MfRsmI1y/OhjhpPHuzmF4PYvDrHvIQUMT7S4wQBq/oxp7mboHPwxGoGrlT36GoyUeihd4W2w2DnHuv6HH/4a7B/WbDvncKqchcRKUgoHMmaMVwmXD3igDxTsaU6J/DPK383m3MM8AW+jfSf2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOuaJr6/; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718150873; x=1749686873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YSeUVzM2WmmHg22O7AH7I4pJbWFDzgqZvuTaeFRzCgE=;
  b=hOuaJr6/Ovsbc3A6DPz0NQ6LHvZJ7gH0zs6m5lEL1igA7hbUEpG5LPo+
   /6xVRljS28ALx/Am+xknxqU8kUV4SXAaJT3ykCW2dzEn/Cm1fVCvS92SH
   a/zKQbAtVJBDwkENDN1pJb/BMHBjv4iH34NwDsqOPLB6xpnHpYQAN2Rw/
   Jw+W8Dz5nLbWM1Hua1x5CxtFZxmKuEKdjL1+KX9YxI6/FaXjGUH91H1l+
   IDepoCWtpG+FdNAz2TNVJPmrzKnCSQ9s7dqKaP8KbjEoYIMK482irlIEL
   vdiumH3BO5YKH61s3PC5ynIu8VDnoBK3UXqVksyTbpbnjWgJcuUQUmbla
   Q==;
X-CSE-ConnectionGUID: lNimc8RcSA2VNjEuEnL6+w==
X-CSE-MsgGUID: kr9mZnPcSryEsP36MpPw1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14854431"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="14854431"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 17:07:53 -0700
X-CSE-ConnectionGUID: n++EwdctRu+1xClhrNzFAQ==
X-CSE-MsgGUID: yJBMf7KRQH6QS70NPWVqFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="40314758"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 17:07:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 17:07:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 17:07:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 17:07:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcLN0IzAvmDW6oqYV/JIt37MjBuCi06P+9fo/ds1XnHokZginYD/3MHkXC4WVUGRCqv1ejN5Pe/6c6P4b81mo49Qn6cQ7kLLOSHr948nPtZkwY+8s8j67ra8x6IGhoQH+7mHvcaczgnM2rfP1O5k5+LDeq+JdizPdAHcn3SKCy0UOjkNmmEYARuB5pk3c46Dw8N3K5Als8qF/AOUPSH6mDXx/eUxZV6UyRxWqrv8NvU7hErs4R+i5G4jE5WB3V24Bg1NB4Lv6hOC+ATdHMjn0wfGKZwU1YDZgx2IQfiEyQSYSJvf9VxmlbUsYRRiLc9Me/3ifdoR7B9FtKnF+ilOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUtKoVK5ireAU2HMi68aSibYuimanWMyFU87taEJMQc=;
 b=lZmpvkGno9U8YaeYoTiRMqTM/uWoSCYY0LXT2AhPsBSkJtUpthNQRJBgWui65EKsa1bRGG6uzkpEDugONeYL/id4Gos7kWehKGPkcWjfZH4ulNs37WjVa2NU3jh405WRkYyYo2GC4a6/Dym4IVDYe//uxISsShC87RATWt1vCmCtxLzS0FejT5064FDymznwTPSD0KNA8jDjwRuAPx9+ZiWb/7+omC2+vufLFDL8Dc1uq+IaQD7qNsvF6sQ4KiBTFjLL2VW5TFKbDhHGAEsfAwrFU3a24oo3qgzn0U+9o7IzEljAACnRL593d3L4c1KIax4Z/soYYMRDjvoy98qcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8058.namprd11.prod.outlook.com (2603:10b6:510:24d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 00:07:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Wed, 12 Jun 2024
 00:07:49 +0000
Date: Tue, 11 Jun 2024 17:07:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH 3/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
Message-ID: <6668e6d28e9bc_310129473@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240522150839.27578-4-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:303:dd::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4fef44-c1d8-45a0-48c7-08dc8a73b1c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WUHBVtFBKoevM7eaa82av+KT9S6Fk09yw+lp1RgjPUXa1JQDmMaPd+RWT+/5?=
 =?us-ascii?Q?N4QDm2R7+9wPa232Qj8YCMfRIZwrezq8kwjd67+dXN06jylp5MxbT6IdpNmr?=
 =?us-ascii?Q?qd/Gxey2iGaJSYFjDNSiyu7TPwiyfEHLNBYI1WWdq/Z+weWUlHPnXYoI+A3g?=
 =?us-ascii?Q?pnT+8Rwa/94WPO7Ykf0ewGwp/ZzBivpKabWMg2iqt3i6vB6M85lbAYWlnvtu?=
 =?us-ascii?Q?E65KJDk2b5mRF98rKUQ8wAXsY22ree3siNuB3wcBFKEQHdJ2IXR9NQe92l0g?=
 =?us-ascii?Q?rUcY49PBT4OWGMzva5bxQFgCxm4lYXEFkhNbJ6F+oX5JDBGvrRdfG9AM+qKq?=
 =?us-ascii?Q?wYZuYhSG8sTAXlEPj8zHfANkGjudN8I4biCaedguC32k/g7/ncvaAKTc2L+Q?=
 =?us-ascii?Q?4h2Z5OMzzIxTOQARZQ3PphJTUvw4eL75qN5talAEmVIaXz9zkBiUnH5RioC9?=
 =?us-ascii?Q?2Ep+0JbXS4AxI2akw2Ptd6PYiBlCxYCm5WR1wCewIs5AGEgy92PYIvQ9paCs?=
 =?us-ascii?Q?4AV36SE5IDKl0DTBntkFy7pmyJ01A2jS+WEkvzWp/8wSna1I365pIqL/SiF8?=
 =?us-ascii?Q?eD3afP0RfzHR3SSBRkn0zJkbcaTTpPFwL9wrCEr14xsmpeN77nGvZNBu0GHc?=
 =?us-ascii?Q?HGEYNHAADqXC9LBTAU28K8spTIKOCxBojTK1MqkBbvyy+VpanieEVVelAIoo?=
 =?us-ascii?Q?3t11oniGOOUzKOR0PcghzbgzeBSR51AJJaNGd+cXO3nWlQPFozG500DYoVce?=
 =?us-ascii?Q?cgIyfuY4RRSO7WLt1PvppE9J1OWGkMJKomnHUExyvLqD103CDqXpvCkVbs9v?=
 =?us-ascii?Q?LpWffFpllR2Zd/t7BSNYyFkK4ZVFuPOhVfHDv5BKk+15ZPjoDLlD8lbdPOdS?=
 =?us-ascii?Q?+v1Nv/aOMWZgEF6ld4UxKgUpg4Q3lzIXFzKyh7rqkKs8vqZyJfPdFmy3e/s7?=
 =?us-ascii?Q?2M0hizE7dgUm6RiFVfEYbpqlQT0x/myf26AoTIV56IBznkK1wdZA4jodaCPr?=
 =?us-ascii?Q?aFb6XysysLG751y/tVNv0wfhbkrgBH0XIDgQ4VXJhj0TaL0hUBMh3hIa+c2I?=
 =?us-ascii?Q?4sUfN1ersS4nwARFmeR4GpaPba42SqS+DMA093YE9KCq+/wH+JCDTzy3neX/?=
 =?us-ascii?Q?v8QhJa0KHJjWhLszOVhNuqhe+cRf0fZPdTiZF5Zzw++C4KDBcV2iiMJhxdfl?=
 =?us-ascii?Q?UFAl0zhJ8SGt2TMsut7pHtt8hiBKMyrb69CFcsF5wk5UNutjQXufTLHca/3T?=
 =?us-ascii?Q?RsT8vYWgPvlTzRDOm5jI1C4b7JSPvNLKgl77z+T3U59Lx51od+put3nmO/2N?=
 =?us-ascii?Q?dUs0yRzFew3C7+zCcyP3ZYJ2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LlhkrNGIXeGSTpfen9CFOXsl0g+NKc0rZAIpWr7shNtF3QK/1fi781WlCfE+?=
 =?us-ascii?Q?0fLqXCnCHUW4CA/T1LQFoz0zsqFRI0ZgZnMgKAOQs+Jm2Sd7DCN+R8nUrPtk?=
 =?us-ascii?Q?t6rCFWWSachikt68xaggbOqK4DuFRRe1BPWpuEe2xG0eWxw8RACFKjQG036Y?=
 =?us-ascii?Q?UMawh6l/rgFSYbNcVdGSnD1TIqNn2tJuBNoRizelVBgzn1Wp8+n01fRADRw6?=
 =?us-ascii?Q?jbdw00ahuP6WEWuTshCJ+TzTjSWT4TjL0/l5sb3+Y98KJU6fQ0qIDd8RhwGb?=
 =?us-ascii?Q?0XOMn1A+v3GJSWvgh7PcGr/3Iz6I5g6GyL/i7RCOUH0eHs+fxnf/BBX0byZ8?=
 =?us-ascii?Q?ne8jCuf9yw/RAYddfS4alsN5fryXPWgrpN6922ZexY65chsN2qgYJnY99PYG?=
 =?us-ascii?Q?Qs1VIvREYDDRimzPeMEGuqBcYxUJAz1+TSAdRXwia/xDnz7Gl2iTAT9titzu?=
 =?us-ascii?Q?DSV2Y7RSxmSK3NzgjZiGfUElcRzjTp6boVgB8iYyqJAGsGQAKEzZgp01fau/?=
 =?us-ascii?Q?EwxmISd5zJj5X+D2sBzvTpaulCwrPPirm3Tq1v8RaSZLuXKfqkbW6cKpMhLM?=
 =?us-ascii?Q?c7e5OuLSSKHF2vdRBtfTXCToKLmqVgqgTxhHhZ9CfzGL1kGwyK8hvusdFIlQ?=
 =?us-ascii?Q?uLN5QfgFPjDJdeoiWsJpGCGqC+eE4VONav17pc3FoitL90PfpK76EQIdVvxd?=
 =?us-ascii?Q?Xc4Wu5GnwNfQ3wMrak7pTGC6fnklykyGkkutZX3ni6krGGQANMdfyw4aN10f?=
 =?us-ascii?Q?Ucpk7JF8JHVSc/+4eqzqMJhtLpGaZuD9XM9c9fotIS5+YfJ+hJAwpoorNfU2?=
 =?us-ascii?Q?Z4Q16jE18to5zGvxS57yCvDnN+I6eyWgnRXF4pncnzXLFn+2MnP73yBxzK8/?=
 =?us-ascii?Q?JptigNKMRQjzgFw6m2vdXTjBwqZp+zXPY7EJ5a7jsfvGlXJapqB4SkKPDWRT?=
 =?us-ascii?Q?mzxqpcwQS4Lz8TFjisvd9XkbTm13B2EBEgthfRtFnGP0LopJcZak+vfohOdj?=
 =?us-ascii?Q?KVKNr7aW5Nd8su6CxVklzfqCXYQtjgEgpJQi7gmzDx7VSXa9Ekx+nhW28Ifu?=
 =?us-ascii?Q?aRyOToNPkmldsAUT6TmugrLo0HkJpKTVkdW4AKO4NlWgQIKOalqsEZj3GqoK?=
 =?us-ascii?Q?IZ9H0DZLLomasByI4zFrvV0ScQSCmx3e1xu1AkLjJnMuTyvqGlb56TBLhDZe?=
 =?us-ascii?Q?vuVJBlA8w7UbznvYCcqk/wucayoRakFaAhn+o7/WHz3PWcljfrSoTiF+rDfq?=
 =?us-ascii?Q?xflXPCm/SZPOxhdjCPfj5sqBjyb6Ph8oeXIGyTq/I11GkEGIxfA3eNDWrcn/?=
 =?us-ascii?Q?O+e0eXk0aw4apwrOQ9wYeeIRpmVhk1y9V/vgU3NZiAvWLRu1D5s9RZaOtAue?=
 =?us-ascii?Q?B8BH7h/rMEhIbxj9MY2kFwHrcKmk5q6Q0/B8svVyR/1/KqZfkQdj14Votvtf?=
 =?us-ascii?Q?+7tXOl/slc/98ItZDeeRYpSEeP1QHoN1LY4Aky1NRYRW64NFqfBi61S2clx3?=
 =?us-ascii?Q?fhR8lY6K2PbkVO0H3Hei+IfZ899kHRTpaW2MHNp/1BOLi4SoevUWFN1COlcl?=
 =?us-ascii?Q?wFnrqzNNWUwEkt+6NzBkz6V84kYyFeCe5rERsMvfJ2GUUcKlv8dEXrPwKtGl?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4fef44-c1d8-45a0-48c7-08dc8a73b1c8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 00:07:49.0149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QErUrp16Ugol/rFj1iZMGXXXQ/zCqCOk6kdyKfIu1gbGYzQN5uSkcTWudyf5aY1kTYIqJjv9UB3B7kFfo1W0tACeafppA27hDZWvt/o4GP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8058
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records.
> 
> Reuse the existing work queue cxl_cper_work registered with GHES to notify
> the CXL subsystem on a Protocol error.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
> them to trace FW-First Protocol Errors.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/acpi/apei/ghes.c  | 14 ++++++++++++++
>  drivers/cxl/core/pci.c    | 24 ++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h      |  3 +++
>  drivers/cxl/pci.c         | 34 ++++++++++++++++++++++++++++++++--
>  include/linux/cxl-event.h |  1 +
>  5 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 1a58032770ee..a31bd91e9475 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -723,6 +723,20 @@ static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
>  
>  	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_err))
>  		return;
> +
> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> +
> +	if (!cxl_cper_work)
> +		return;
> +
> +	wd.event_type = CXL_CPER_EVENT_PROT_ERR;
> +
> +	if (!kfifo_put(&cxl_cper_fifo, wd)) {
> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_cper_work);

This seems wrong to unconditionally schedule the cxl_pci driver to look
at potentially "non-device" errors. With Terry's upcoming CXL switch
port error handling there will be a native path for those errors, but
until that arrives, I see no point in this code trying to convey
root/switch port errors to the endpoint driver.

>  }
>  
>  int cxl_cper_register_work(struct work_struct *work)
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0df09bd79408..ef9438cb1dd6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -686,6 +686,30 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>  
> +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
> +			struct cxl_cper_prot_err *p_err)
> +{
> +	u32 status, fe;
> +
> +	if (p_err->severity == CXL_AER_CORRECTABLE) {
> +		status = p_err->cxl_ras.cor_status & ~p_err->cxl_ras.cor_mask;
> +
> +		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +	} else {
> +		status = p_err->cxl_ras.uncor_status & ~p_err->cxl_ras.uncor_mask;
> +
> +		if (hweight32(status) > 1)
> +			fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> +					   p_err->cxl_ras.cap_control));
> +		else
> +			fe = status;
> +
> +		trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
> +						  p_err->cxl_ras.header_log);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_trace_prot_err, CXL);
> +
>  static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  				 void __iomem *ras_base)
>  {
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 93992a1c8eec..0ba3215786e1 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -130,4 +130,7 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +struct cxl_cper_prot_err;
> +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
> +			struct cxl_cper_prot_err *p_err);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 74876c9835e8..3e3c36983686 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1011,12 +1011,42 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>  			       &uuid_null, &rec->event);
>  }
>  
> +static void cxl_handle_prot_err(struct cxl_cper_prot_err *p_err)

Can we call this variable @rec instead of @p_err? The data being passed
is CPER data which is a "record" structure.

> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> +	struct cxl_dev_state *cxlds;
> +	unsigned int devfn;
> +
> +	devfn = PCI_DEVFN(p_err->device, p_err->function);
> +	pdev = pci_get_domain_bus_and_slot(p_err->segment,
> +					   p_err->bus, devfn);
> +	if (!pdev)
> +		return;
> +
> +	guard(device)(&pdev->dev);
> +	if (pdev->driver != &cxl_pci_driver)
> +		return;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;
> +
> +	if (((u64)p_err->upper_dw << 32 | p_err->lower_dw) != cxlds->serial)
> +		pr_warn("CPER-reported device serial number does not match expected value\n");

Not much the end user can do about this warning, I would say skip this
message, or make it a pci_dbg() because matching by BDF should be
sufficient.

> +
> +	cxl_trace_prot_err(cxlds, p_err);
> +}
> +
>  static void cxl_cper_work_fn(struct work_struct *work)
>  {
>  	struct cxl_cper_work_data wd;
>  
> -	while (cxl_cper_kfifo_get(&wd))
> -		cxl_handle_cper_event(wd.event_type, &wd.rec);
> +	while (cxl_cper_kfifo_get(&wd)) {
> +		if (wd.event_type == CXL_CPER_EVENT_PROT_ERR)
> +			cxl_handle_prot_err(&wd.p_err);
> +		else
> +			cxl_handle_cper_event(wd.event_type, &wd.rec);
> +	}
>  }
>  static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
>  
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 9c7b69e076a0..5562844df850 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -122,6 +122,7 @@ struct cxl_event_record_raw {
>  } __packed;
>  
>  enum cxl_event_type {
> +	CXL_CPER_EVENT_PROT_ERR,
>  	CXL_CPER_EVENT_GENERIC,
>  	CXL_CPER_EVENT_GEN_MEDIA,
>  	CXL_CPER_EVENT_DRAM,
> -- 
> 2.17.1
> 



