Return-Path: <linux-efi+bounces-6087-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCnDEpF9g2mHnwMAu9opvQ
	(envelope-from <linux-efi+bounces-6087-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 04 Feb 2026 18:10:41 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A1FEADB0
	for <lists+linux-efi@lfdr.de>; Wed, 04 Feb 2026 18:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA9DE300D90F
	for <lists+linux-efi@lfdr.de>; Wed,  4 Feb 2026 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702C133D4E1;
	Wed,  4 Feb 2026 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWGPvpr+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3F7319615;
	Wed,  4 Feb 2026 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224909; cv=fail; b=UGpb46mTd1LRETZHCT5Q6yir7dM4tg09B1W4J/hRhISchWej5ijfm21PV3i2TDW3N1y+9PJCQeVNhPJjX8NkUQw7r7gYfZRLXRH2O9odrSfpbPsBWgJtu6VdO2/aDyV6/bmwkch1RybZwW0dHQ9LWkhAagQZDrsNBAtWcOdjOc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224909; c=relaxed/simple;
	bh=HECw0txhpXwZnb+V0H5Md1tjFwj9hVfhPKn5i2TXfiA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=brTCvLIXBRQOq/ClqiBrl0f5XKAYixZ7GIxKQ7P70TZBwSgIMiAGl3X2MyOOhg4gbRLUGASeZiGWb1VktQbonDlpZisM2kpV/XZeXALR1UAgp7pDm58nIf9xLl3esiXHwvdF9rKdwGTOvNKAHmN3BZQqus6kAp6eqkcFikmCK9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWGPvpr+; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770224908; x=1801760908;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HECw0txhpXwZnb+V0H5Md1tjFwj9hVfhPKn5i2TXfiA=;
  b=QWGPvpr+tQaVs2Sqe4eZM/9fSXuYPJoE8cdj+lYTN/bNRzQVNL21O3Mz
   a6bCm1pQegbqkHt7+q0BbXvvb8BDqMAFV8dQnvSR7SLD3NhWEmb6mD/QM
   iefU8fHvCuOMi0CykoS0XbXqtt4Nm4BW513d7TG88t16PHdWz2AavnRpf
   4mzHekectUT3UVL9y/x1sx2NoPB3gF6Ue9IZ4VdBUpnfZhBD1J2pxDFK7
   mmJ9L9j9rcM+1GNgWHT2c+cjAi4JbiEGzdAQ2IElSGh2miOW5R2yMfZcK
   JJBDZd8raTRKJgEhz3qJ0KvL3ypwXkKXYEsLZ0V8Df9ZMzbUrKSci3EnR
   g==;
X-CSE-ConnectionGUID: rnrVGNgsRwe/0XgPV+vDew==
X-CSE-MsgGUID: +SdMoOUcQnqOnqZAucsOyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71320385"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71320385"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 09:08:28 -0800
X-CSE-ConnectionGUID: A2c3gwwqS72PIjKION8hRQ==
X-CSE-MsgGUID: +sE/8PwaRe6iMQ5baE/oBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214713877"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 09:08:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 09:08:27 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 09:08:27 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.18)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 09:08:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs4CthLUiNs847Fp0lXaBKV85Itup3k4pud7xQ3Jk62nKa6SmzQb1xAvqWxiDjLccd7vckuRBZTJRDHxI+wd/3rrSBOQTwtjrgZY7kD9BGS6vXnSD6XUQns273IoFBsB/YiNsd4FmrtDlNMDU1D+b3JhEnya7f6oQVhcLMrfFZ9WudP3DZ0p9sYY1emdRt5+csINN99WLcDPr9x+cioALkJdQ7yR8PbVg9vXmEDdCU1LwCBMbOovv0hf0kM5tv4qto378tTbX8mwKAzl4mMNoYsUhg/upHQzCVtsXGzjoASolsygN9lWGc0vvmv3z2fZy93E/U6zfpz7d7jyNJ7pSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTGzYT/e0B1NvnUXHc1s9u9NaWfgHnaZo2gasj5CypY=;
 b=FWLD1jduUzWVj1CNGOiLsS09Pl0nBRchvaV7ZBf5fCqQ9WbH3G9oD+OOdV3lGG5IVWscDwZYXlBPnL3ixU0L+/cLAPfgIjgiAYvQazjzbHgytQhmL17cWMZ6zDu0U5zrBa3q+RYEf45Bmfg7kwi5Iq/MqgCVS/3h1ArTwbYxdBb6HsJ/rwp3iJiJ7s1wwvj9t4ob0jGSFJDByqnVaHXbAkdwyhIKBk9xeU2b2QsIxRLw1JE+xAYHwO9z75r3fbOhEo6BXky9nOkS6ndPSf6iJNXNkk7c3Lr8aLwmARxdhGRnAjhW3ggW1tmTroPWwBGSxSrgEFpIPzcU587RwRHfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3282.namprd11.prod.outlook.com (2603:10b6:208:6a::32)
 by PH3PPFBA2AA2BA3.namprd11.prod.outlook.com (2603:10b6:518:1::d46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 17:08:22 +0000
Received: from BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19]) by BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 17:08:22 +0000
Date: Wed, 4 Feb 2026 18:08:14 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
CC: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, "Kirill A . Shutemov" <kas@kernel.org>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tony Luck <tony.luck@intel.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] x86: Extend LASS support to EFI configurations
Message-ID: <aYN8jt0CLSy4aZv7@wieczorr-mobl1.localdomain>
References: <20260120234730.2215498-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120234730.2215498-1-sohil.mehta@intel.com>
X-ClientProxiedBy: DU7P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::31) To BL0PR11MB3282.namprd11.prod.outlook.com
 (2603:10b6:208:6a::32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3282:EE_|PH3PPFBA2AA2BA3:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ef8047-18b5-4f21-658a-08de64100045
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2fOsRbm8lIUnL2dR0N8Xz+8FPW3gLhm5UCIYqaxYLHSbMqTPILnPKgbCfJ7O?=
 =?us-ascii?Q?hEmxoZNKg6U3Dqp4Sj5rRuuM/OkZRGUlPlldxH94pYCA3zk8tOyBeOyUIOfW?=
 =?us-ascii?Q?RTyI/imcIkL2kpTxlNdHEkFGlX+RvHVkqAMjvq1mVHJ74xe1CheYGUGUYJuK?=
 =?us-ascii?Q?gZ/4Dg0nix++ocmbgdN08b3fEpT3gxXi69CXrdzotZ6xYNjx/YV0vLM5pghd?=
 =?us-ascii?Q?GQXDkvyk5OSQhRnsdAK81ubS0rHPW0vNDvXMIKmrlXQXg34HdP45EI2iM8Yu?=
 =?us-ascii?Q?eU1NI480Vn/0ScuPkb7uXJ+3qWKgU7J5ELX4BdsSr6nR72c1JezRRaBHwGIy?=
 =?us-ascii?Q?Z02oM+0yYmrz+rqinV649l/QDo9T9phvCrcI7vJaHdADiSyknbAy6mmv5Xg2?=
 =?us-ascii?Q?d92GenhZfCZ6RVCbdy96aLw6cEpdcwRp+lS+4al7NT3/HyJfyqxvV6AYjpJB?=
 =?us-ascii?Q?P1vqFVIOFI+T8mXqq54ov0IfmgCDCoqHhlX7vh0QFUbJrYxf++vsBIapIG1q?=
 =?us-ascii?Q?J15gXTk0SXQYUjZARnm8S/lZ3BDHFfOYuA7Jj2i+Yn4JAG8U2zrc9rpX6NwE?=
 =?us-ascii?Q?i/Mck+uHl0efd62AU2TwIpoMjC4c38WkfbbnCyyOn3og6wNV7REBOSmg+kwG?=
 =?us-ascii?Q?zIJ0JRJhix1J0HkUl6d7KVUEmuuVwkVuMJTwer4DCdHcrCDMn0hy3nbCHpMr?=
 =?us-ascii?Q?eS80DvPhly4LlPVQ3vC+3YePTjNoNei8tK1WdUMXTK/voZX+ljCuP9EOEQ4y?=
 =?us-ascii?Q?NTlmZEnKjZZL8T3C/IXlC/4/hprme5epsU8+G9IFrSfiwravCZLCddOM/s9p?=
 =?us-ascii?Q?xopS5BN74OL4rbYJC7esrd910VSe+4P2gFQIbK0AFnpT023mxC8kvTLIvlCM?=
 =?us-ascii?Q?HFGFY3jzqZ5iPy1jZ6aaCYGXYtbSpLH6DMHMvNZDO0frgDm9vIh26kXcW3oF?=
 =?us-ascii?Q?/GGyj28cKRYUb1lcXc+7V/7TKbMvjpWFoAZA/EizCf28Ii6hIvShRaCmyJQk?=
 =?us-ascii?Q?oEiWUe18rZNkVSQtILOq3QPp18NcvfwrS17jKW+Cmyw1mpRQBlmZKo6/tFZ7?=
 =?us-ascii?Q?FqZHHsbcc2PpnE1bPlsbDH8Ij5j40HDuGseb4hMRF8pIb4y6nGypZhsvfAFq?=
 =?us-ascii?Q?97NYQtfV0N7GLEkJtcPE63ZdHlQmmnEdgTeV3pmMvUaB1T8a+Yef6pE6K/O8?=
 =?us-ascii?Q?pM4lJz6lN5KP1oWZd65d9ygu7HeJw62XTboM4Elhnn0Txc0J1z1tGkwOLUAF?=
 =?us-ascii?Q?8FWTSlo406EvHF+keY4M27XY8wao/Qyu7FZj3D81s9SphukaHYMnOqkG/k0c?=
 =?us-ascii?Q?eM/KSUTNTYqTjC+P2SaBZqZ4DZGklm7amaioz7VM4Ai5JrjYvjFBVjLCg4ES?=
 =?us-ascii?Q?ztPPcw6dN97XA9dic09OMUD06XnJUdw+L3jmGJ2580SuJW6a9PoLdl4n7DuQ?=
 =?us-ascii?Q?apXGVw+tTg22KVejyLqBrDUjKCIqt/w8qbgIC4gNXILX2dPdWPuQ3MnQifl8?=
 =?us-ascii?Q?uaXhfARq9hHpRguzRzkF580HbPs1xa0wkfSj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wi8VhYXNJXJDuiMdasBbNTMwWFUY30NRz5WHsYi+9MLmLvtHPf05erWblj7E?=
 =?us-ascii?Q?eybGGqgHhN4205BOkeJ0i4HcM2lyJbTxJadvxACDnc09l/LR310VBeOGny1W?=
 =?us-ascii?Q?EMYL90hYbRr0y981I4/HIvBbujcM0CnThgUPQsrShTzY2igE+FKXsLT7UW1j?=
 =?us-ascii?Q?n4YcnF5Xndraea/l1oGZn2qGuZpXxVqJcqdQRDDooKdKoVk7NU08G2z4tZfF?=
 =?us-ascii?Q?+gUw76o6EFvWpscvj6k/Z5rdcSox8TApUZ2q3A4nduOyn6T6Ybl0jMNqY5XV?=
 =?us-ascii?Q?LZAPwEb4zPqLOaFMXfbxnxWn/XcjiWABPhuiSR4iTOI8A5NJTn/BzeO0fqBo?=
 =?us-ascii?Q?buDsuZNWz5fSh8yiMCwDYaKEPUgUMgJtf+49thuBdrXnGfOu3hVHpvwIZHxc?=
 =?us-ascii?Q?abTXrsRnr0yAZKBWO8IyXI+2VbELcN8OzII0LteXeJwEUNa3Fl7ZpexTvYzq?=
 =?us-ascii?Q?fOtDrC2pme/EPFQnBw80EcLmN3NMVKLwqLF2M6OWLBaMD0EHjRt0lZJlISTr?=
 =?us-ascii?Q?rEAUiQa1C0Zl55hS8tOaNcxx+gcqJKz7n6rt7BWVvgw6+wQelmUJUum71uzt?=
 =?us-ascii?Q?dd2KCgmDg9OGLikYcM25Le8wJmiMTPW6yxc8rtkh1XEEtsOj/D3E48Yanmou?=
 =?us-ascii?Q?gBaI//wEzmARSFxIHaTX7eEe1YSDBxmY47BS9Rfk5PATBNRxRr4FbqPiBmqk?=
 =?us-ascii?Q?P4KkiygenoKh4WAWHOgYmjRjGZW9KO2EY3AZ4f6BMJbFMcpH+7lfUFwVwKRw?=
 =?us-ascii?Q?NXTyILrugkc60Q1aCJFjkkBLPIicTSjNYeid8fQfLazqKJskJz1ds8JdsLpi?=
 =?us-ascii?Q?VafuAVcQHwKrwCAYFYwDQAv7zwJtntI4IDvwnTfWn2/V65DbyPZNHoPPK67A?=
 =?us-ascii?Q?CFzzRwrNMe3Yq0CkCgTr/EVmiDsqoMYlvW/A95wP/hXVhWM3ErpV24XpIZt8?=
 =?us-ascii?Q?x66ajT96uxM8D57PakDyz042HSzLRA/pnsH2aLoYSnj6/KIUp7LO0WIl+le+?=
 =?us-ascii?Q?9Z/jLuTcjjcVgERj78vNDrPRNHIYmKj55OpSZH0Dq0DUrSzZBhPVO6ezxY02?=
 =?us-ascii?Q?UwBkIyGsJy/Z8266kkq5WO1+URgQa/9riRVL+DrjdaaN+3tQGWen4uTy4VeM?=
 =?us-ascii?Q?HO91NP4jMuxzQAV3GcM8zR31Ew3rD6fzSUcZdzfGXMh3YQd0+0kE8e38Yy6V?=
 =?us-ascii?Q?P01Wo0nQGBEtQXXbo2RzOnhsBzd5I/dlAmAd4CvLeV36/PzZ03L4DspSiqUq?=
 =?us-ascii?Q?7JLEOzaJVGcGC9Ph+Pz6q2p3sGOXtBNlFRm+YT3nBDI6rT3dEB1ISw+Xj0k8?=
 =?us-ascii?Q?plnlKGo+VW0IelclKSR38HcKJIeC61oOMPl2dD7BUuDboSpwQ6FTW6SgMYrT?=
 =?us-ascii?Q?r18hHFqxf5Eyiqq1VH3JtiA7+/iGXLUWlxJutKLDj/KbKAtHjJ6Z9htOjA+y?=
 =?us-ascii?Q?uzOP0gYAdDo9PHtTHWPl2uj4zLzUaSVXjMbY/Wtd158Zl87eG69FvC8HZn11?=
 =?us-ascii?Q?/pq5GqlIT2/9516FzcqPbdr9wn5Sh7VE5z2KmItWkICp7NXA1/oKJJO1cNbJ?=
 =?us-ascii?Q?2GC5xzM8jZv3M3T+rVxlRKSdtKnGzSgK3Qy4UThyPh/9J5E1RYlgT1V1iEgb?=
 =?us-ascii?Q?lnX43E0bim3MKQM1YidPkxZdNWKWXadMaamZ0+db0bdobRKM5VQhgbI/epvP?=
 =?us-ascii?Q?80JnF6B0j35it1MnQQ3+IISoFaCWNsDntlrpFOHD3t2DOYjG1r7EfDpBN4RU?=
 =?us-ascii?Q?LjuhJ3QkmpboveaRFQh5uKLHhN/+HtTQBXLnS6HUJswmaT5AmyEn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ef8047-18b5-4f21-658a-08de64100045
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:08:22.2773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4/zr8C0v+db1ReQ4Awp+Bwja/2wmr6W211oiYggJKx66n1UeWmYXL/w+ZKJIe5QegT4DbnbemD5Gl8vnYuc/y9+HQcrB0caO+4W2l8rV54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFBA2AA2BA3
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.wieczor-retman@intel.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6087-lists,linux-efi=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: D4A1FEADB0
X-Rspamd-Action: no action

Booted successfully with the patches on a Sierra Forest system. Checked it out
with LAM enabled and my KASAN series, and ran KASAN kunits without issues and
the LAM selftests also worked as expected.

Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

(resending because my email client ate the in-reply-to)

On 2026-01-20 at 15:47:27 -0800, Sohil Mehta wrote:
>Linear Address Space Separation (LASS) is currently disabled [1] when
>support for vsyscall emulation or EFI is compiled in. This series
>extends LASS support to EFI-enabled configurations.
>
>Changes in v2
>-------------
>- Rebased the series to v6.19-rc5
>- Improved commit messages and code comments based on feedback
>
>v1: https://lore.kernel.org/lkml/20251204072143.3636863-1-sohil.mehta@intel.com/
>
>Issues with EFI
>---------------
>EFI boot and runtime services are incompatible with LASS because they
>end up accessing addresses with bit 63 cleared, which is blocked by LASS.
>
>  1) The most obvious one is the SetVirtualAddressMap() runtime service,
>  which is expected to be called in EFI physical mode [2]. 
>
>  2) Some runtime services fail to switch to virtual mode properly and
>  continue referencing physical addresses even after SVAM. The kernel
>  maintains a 1:1 mapping of all runtime services code and data regions
>  to avoid breaking such firmware.
>
>  3) Some boot services code and data regions are referenced long after
>  ExitBootServices(). Most of these access use the kernel direct map so
>  bit 63 is expected to be set. But some odd firmware implementation
>  could access that memory via a mapping in the lower range.
>
>Solution
>--------
>These patches take LASS out of the path of all EFI boot and runtime
>service interactions by:
>
>  Patch 1: Deferring LASS enabling until userspace comes up, which
>  ensures EFI has completed switching to virtual mode and all boot
>  services memory has been freed [3]. 
>
>  Patch 2: Temporarily disabling LASS every time a runtime service is
>  executed after boot. Runtime services execute in a special efi_mm
>  which doesn't have userspace mapped. So, the security implications of
>  disabling LASS are fairly limited [4].
>
>Please find more details in the respective patches.
>
>Alternate options
>-----------------
>One option is to not support broken firmware implementations (by
>avoiding patch 2) starting with systems that support LASS. That would
>trigger #GP faults if runtime calls try to access the 1:1 mapped
>physical memory. Even though this is expected to be rare in modern
>platforms, there isn't a clear benefit of keeping LASS active during
>runtime calls executing under efi_mm.
>
>Also, client BIOSes typically get validated with Windows during
>development. So, some users could see in-field failures when they start
>running newer Linux kernels with LASS enabled. Though Ard suggests that
>things have improved on the Windows side, it doesn't seem worth taking
>the risk to me.
>
>In the long run, to encourage BIOSes to fix bad code, the kernel could
>trap invalid accesses to 1:1 mapped physical memory and then warn about
>buggy firmware. However, such an effort should be pursued independent of
>LASS [5].
>
>Links
>-----
>[1]: https://lore.kernel.org/lkml/20251118182911.2983253-1-sohil.mehta@intel.com/
>[2]: https://uefi.org/specs/UEFI/2.10/08_Services_Runtime_Services.html#setvirtualaddressmap
>[3]: https://lore.kernel.org/lkml/ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com/
>[4]: https://lore.kernel.org/lkml/F707CA45-DA37-460A-AEFF-C11AC6AB6A05@zytor.com/
>[5]: https://lore.kernel.org/lkml/255724be-a6d8-4aa6-94f9-1e6ffba3a3cc@zytor.com/
>
>
>Sohil Mehta (3):
>  x86/cpu: Defer LASS enabling until userspace comes up
>  x86/efi: Disable LASS while executing runtime services
>  x86/cpu: Remove LASS restriction on EFI
>
> arch/x86/kernel/cpu/common.c   | 30 ++++++++++++++++++++++-------
> arch/x86/platform/efi/efi_64.c | 35 ++++++++++++++++++++++++++++++++++
> 2 files changed, 58 insertions(+), 7 deletions(-)
>
>
>base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
>-- 
>2.43.0
>

