Return-Path: <linux-efi+bounces-2878-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9338A4EB99
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 19:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74EB8E2A1E
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4406029B23B;
	Tue,  4 Mar 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePMIbcbE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD227280A39;
	Tue,  4 Mar 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110310; cv=fail; b=QAVMNZqpUI2wRbtH4Vsu728N4f8Aw/dgQdl8TE4FVNY0Gh4UHQ4TC+dwHSA1r3+kkC35h8PW2KmldEYRJovLsbkw+Lv9p628a9JNuNTWSljMH9k/YR5uBAdC1sHp4sFDgQmjjspslXXvd3uLiX0lRFOS3OHRZ0u/uisv3vrVM9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110310; c=relaxed/simple;
	bh=EE8wEzacgQ13nXfFANyuZaWD6sGtHhsXiQZSGhKf/aw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nc4LY6+obHPVGccR3EbZnvgot0b5XtbZsqP4hNlkbgZtKZbZY6z3SUCrViKR+u9+Oe9YDWQxmkI9I63/OI5o9IRegGiRvplVwi0SHh5I+dt+GZ8bO4KRHArC3XalD2ePpcuCelfLEH4DsPxSeWS+5bdL9szF6OPFGXsQlwiHqGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePMIbcbE; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741110308; x=1772646308;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EE8wEzacgQ13nXfFANyuZaWD6sGtHhsXiQZSGhKf/aw=;
  b=ePMIbcbEjFycax5kUjfrG6xyajMi8aotcGUJs4j/nGQtI8HqPHluJg6H
   7fAqENLEe6HUEIM4qSZ7/Eu1BhCirLFvdNtokuNceYPiNZzK/QSWy7n/X
   QoIS0Qpp8gnct53XBl01W2UC2y8NylmRNjhVZooJcamYyvCAerewUjOb6
   NZgqVLN4qJBJVJ92KL5x15/OsStr8JhdfGhIGAwFGZ7Ny3au4g9AGhKSg
   wayqL2GMNMuJrX1LK+5c1v6F3gUPiVKbZw6/6hUmARvGnJu2PpNotAy4k
   Q3UThLZpGO6Hj/CDf55nW6A98mTLOn3oQXrqDyGowf6MwWoQJeIXAGVWg
   g==;
X-CSE-ConnectionGUID: NotMpxt8R/W6sJybYtOs1Q==
X-CSE-MsgGUID: kXoxiUuZSi+slsTgmsUAXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59456617"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="59456617"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:45:08 -0800
X-CSE-ConnectionGUID: exlnTAYrT6+gMpAC0KOOGA==
X-CSE-MsgGUID: FvU9MDQTRjOsv478JkNNHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123564111"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 09:45:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 09:45:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 09:45:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 09:45:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rhrhhpo1qBHM4esGaA/S7r6TqvqIChtgxj1ocvuFqHem/914tRKCy6xTaM/k8US9bv8fD6H+iD1MkC/dH4CsxF8UYlpmJRg5TFoRQc8Gevuni/l1/fH953ITkL4W6LO+vCy4QPKBDkbD2w10DtadamjkmY/Gw8WSVSGGlee2tjqVyCJlBawCXblkeEB/S0ruiOZQobSX8zPGZ+EeZQ4pRXdM/NCWdbzD3AKowE/Ru/7KvrCEMmKP50Ml3YAHG5YXgk030PVqfSdTHXsPWu8G1WAFmDhoUcq71rT75Y0GPs71pTn+HUtbrhdd3s5/JLEyAvxkD6DK0HKMHFC72WvLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifC3OYSM2tV3vYEk/HUxn1mRLNmPM9RMaTNmXrKiWs4=;
 b=jRfsrvaeVHRBKlZsS5lY3EzOCzqxsLsiutqnsylLjiROeev203dherGZFxXmud/TcJ9Yi+VAauZDfqdkhQkyad9dqVv31vwSKi2Dz0c9Ziczx7zKEor664/NoVRseqd3wRNkuQS33QWKwJjxQeiTUXp8VKhNYatz+ONPhgBx4fPQYj0aE+K+GJGCMAYw3pBZZhJR4TNRmjKtr8sB3adBIjLU1DOkC3fJmEgEq1xsKwft3jplAEkvU1gOSAvGvJb7J46pT8zvFqSXga7MRBl1fbnq6RWhp1QkBDYTuS9jUn3/PLCAgZuBcD0RSjA1bfe7fHABLaiHQxFxbu5Pl08lmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 17:45:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 17:45:01 +0000
Date: Tue, 4 Mar 2025 11:45:08 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v7 2/2] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
Message-ID: <67c73c24431ee_f1e0294e1@iweiny-mobl.notmuch>
References: <20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250226221157.149406-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226221157.149406-3-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR04CA0301.namprd04.prod.outlook.com
 (2603:10b6:303:82::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8c5ce5-5d1e-4525-0e32-08dd5b444a1d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K/5d0fsWzQ0VqRKn0qRKL4vI/bgNfxkxfpHZ+9AF10NBQ0CEUIfhnavF+yKO?=
 =?us-ascii?Q?E+Zd7CTIsrT8oJCkMoefQa4xSINNcQAuOMfMBBgKCk10wPR2ofxQr38jV0Wa?=
 =?us-ascii?Q?ZN9GxfbCEJkqH13fV05cgj7muWNVMtllIa2s14Mb6of23R8fyVx06F7PN3xe?=
 =?us-ascii?Q?fZITfiMHbAwuQzaU6DZ2IU+neykfZXNNOPG4kZkuwqNpa3GSrPnZ2LUtyZHB?=
 =?us-ascii?Q?vIzEQl+pO1yJwFD0TahIcRbWX+j5ONEt77hgHLlVFO/AcKYrqlvV7+zAinpy?=
 =?us-ascii?Q?kvhNOUUPZ8jJJTkaRxIlDIG0TDh2d2aihWp1SG8RQQuXU8EHyTi4pjCtunnp?=
 =?us-ascii?Q?/qHeSrbl0bpEhL7wY6Ujdj0naE7LbyPNRMZGksfJVO1FVS96opgaOb5T6ztz?=
 =?us-ascii?Q?qX4ag3ubPB1T5thUgUPotu0VwZJnHjTTV3SMTZoa+MLahsbXJkesInruB+S2?=
 =?us-ascii?Q?GSxfPX5pI9JwXANhQG8P24YPw+/W5mrvbH4WJAN4wwfehRvVtdA6LisE2HH5?=
 =?us-ascii?Q?phMZWhkZ9m2H9g5wexOo9cR78lf9DEEw1QUzrKmUlF6zZ0M4XnhR+l+mkozP?=
 =?us-ascii?Q?2AnKPtPuAlbr1CwEZ1toeiDGKiMZd8NRYIv1bRJiO0U+EmnPGHBLolH4fpTN?=
 =?us-ascii?Q?Hyn15eglYfFsxuPbYGjEbURmRr20bE2dlkjcdLMk3nmOStQ37Z5gbb0nRo5l?=
 =?us-ascii?Q?K/8QHsGha+ki8mEXpLKQLisNVRNTXowJluzORzj+PlnlpmQSAhK8QfGaFcFM?=
 =?us-ascii?Q?TMOnn/zHEerN683TU9WEphFCnvD7QyAp49rBzHg3klUQ8AUZEIlZnEX8TLC1?=
 =?us-ascii?Q?sT3YD1/nG028AcZkIGy2Sk/2QM66FVuUnSZvbSGWeR0nHRO9iw4164Nlr/i3?=
 =?us-ascii?Q?lp5gaqbbjOD72gMhYLwC5TDsHOk8kWpQJLyH+QvpPnVDMeWqy5pQJ22zv1d+?=
 =?us-ascii?Q?ECPeLpn93Kj2DKZmZ5bc0TJ8/1E+HayZAOhoq2Zo/omx3KPQTtk1lV1ejJfP?=
 =?us-ascii?Q?1vZK/m8Z7b7IR0PVJ84GypQdp3qC+ANu7WIf+l3/BWT+ICJS32e+AY9rzR//?=
 =?us-ascii?Q?SmtotwHZmbrXS6fEgIxjWHAEtqpgAflMtUYu722GCnpitLPMgcItByB7vsFk?=
 =?us-ascii?Q?OpaAsCy3Ngc7oamr5C6S1dmSAucAMFgI1GBJ74s8vMqtWthcnjAAPCbiLyjO?=
 =?us-ascii?Q?ZMlDyRhDjZuPS67KWaSkcS68IK56Yt719fw44CMjARZbDwuMWO7f4TUhm2y5?=
 =?us-ascii?Q?k1cCJhsF64bOdVG6Q/naKf6OB7aeLw6nukFrxM+ljdFKx271d8FsGNBR07BE?=
 =?us-ascii?Q?8E+58esC1idjT+cOBLD8STOMQXr1bDfP4pffC1G9doVF6Kcrly8Spw/g5Qfm?=
 =?us-ascii?Q?T12O8WEaa58AOCepTkYi6JJiivc9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?19tZI0tUBXX2JpaCc1bbSBdAPrQxndk0h1e3pohuTPVtOsZEyfgOFXG5KCDe?=
 =?us-ascii?Q?Jo9det0p8WGXHq8zYbsa9IT/7FPZnYUTT2j+q7bl64YnxoVBuzuaaEJWBoX9?=
 =?us-ascii?Q?8LQKtDT95rkT5dWecVs5eHyWNh5HlxZk9eWNdlhEikFmJyKml4DC1U5P/nHX?=
 =?us-ascii?Q?wSLnXnZVM1jSqy4J/Tfz6n+CDN10NwjQiq25sn/jZnUfTICPdKUGj8boq/HJ?=
 =?us-ascii?Q?mmgiYTKAFSTA3omVcNAuWHIbX+c7rc/npn7lUCWdadjNvhk9Z3JsuyQXkMMC?=
 =?us-ascii?Q?ZdYwY2JOhsca4MpCCyZKdeMLxTUVR1Ss7LEqTgYge6h07YgGF4iyZIuGKlPO?=
 =?us-ascii?Q?by9gwTXR3UI8JSMey2ESYPZNkjUTb+I5sHHxMbSJvHYIhli9Szu+mpntnv8s?=
 =?us-ascii?Q?F+/TemLH1NIcTjaSMb2xmlX9wOf/zjTvlHMbjRgfBStNBCLrfBCIyM7z/27+?=
 =?us-ascii?Q?ORJ7r/ykW8d6O7t79fZHaXu0Iet+YpxYOUXmczHtcTn2SgccYPlZsD/1h/BR?=
 =?us-ascii?Q?9zbgYr0PBWhu/e5MBeuHUa5zyKBb6+iqfLy/q/mqNAN0xhFRECDNzX0HyGlH?=
 =?us-ascii?Q?hyiVanVgzC3hIbLKNNA3bbNvuRNT9uZOqbB0lCj4h//eO4SS3XwCtX98UUs8?=
 =?us-ascii?Q?pMzB/81/wB+s1Ls7485I7aa4jfDCp60bJJYhhSmf5KQL0M55OBZpeBz52gyE?=
 =?us-ascii?Q?ixYbeHowWiGmdcTPpMutK7u7QwaSb8fD3luJuEBm70fkwCudYy9/b9ZTAj6f?=
 =?us-ascii?Q?UHyB0DU2SGfBPUUW+yMUGk6wn8iFenNu3gM/7q1oTpVP1Ho4d9cRC/F65vZP?=
 =?us-ascii?Q?JeyAE68DcV5sqmIGpmZFDnrYieFNvZFDGQq32rPYjwH8bz20iKd6Xla0kQKm?=
 =?us-ascii?Q?iBuk5oemaPBikpdeb3K0XZMS5l4AKzbPmlsOl/962N6VPSH84NjV05dqyrqY?=
 =?us-ascii?Q?czbK/aK3TXTswotPBLP6lx7/Uoy0GsQRDEWyo8N3c8PGoa9GrTDBBj0udJeQ?=
 =?us-ascii?Q?OTNqM1kTNfrsPdd8RM4LZ8tsyPeP56DF3TJXl07DtwHb3hZkKXTWe0oYWdTK?=
 =?us-ascii?Q?wPTzIfKVv0XbNnny5fgbAXEujF0YCMUM+zvACxzzgMQ3diCthvIde3F1VWOZ?=
 =?us-ascii?Q?RRThA0ah1tN8QqVWcoe0IPURWjC60OB+tHy+pq+2Vqq74TUUH6v1YnmR3aVy?=
 =?us-ascii?Q?SfMU7USJaVcXuNP89MdFv78ft5mwIkHmcbVWTUeg9eo8sD6uUzWsOuFbAO3G?=
 =?us-ascii?Q?GU4PHVrH+r2JmO3qAmgds6G4SyWxggej5Q7xYqeYDfEMEywgdXmiIC9G+hCC?=
 =?us-ascii?Q?UjWZxqDM15cGvGmC6341EE2JeXCFP/9BgH7Xr33HirWqFps0R1zmi1TxZNfN?=
 =?us-ascii?Q?2+8Ghu91tetAFAL/1ZlqaWsqM8G51AG3zBLJq9+BQ7kD0QY9ZfO702OsInWj?=
 =?us-ascii?Q?gmFUVBVu5EKF3zsaK1Pp+I9+cD0xqRntj7+QDdICYYByz+tQOSWt0TDKx6aZ?=
 =?us-ascii?Q?mWtdo36Sly/0Tis7aRRa6WZRQDQHIdnV9F+xFqfSzRkfKWhWu+ccWYJWIbVt?=
 =?us-ascii?Q?GHFNYpEXQTm485Lh9Wrdh2Qrw0UrvP10+jE/t/2h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8c5ce5-5d1e-4525-0e32-08dd5b444a1d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:45:01.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zl5Y0PDwF77dl/EoftfgWTPJaCfIVwx1Pece9kkiO7fa0I+llA6rmgJKN/vI4Ej6yMjNJO9ySO6bfMUdpLwQ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> The CXL drivers use kernel trace functions for logging endpoint and
> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> Upstream Switch Ports.
> 
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Use them to trace
> FW-First Protocol errors.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

