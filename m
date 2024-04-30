Return-Path: <linux-efi+bounces-1007-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077858B809D
	for <lists+linux-efi@lfdr.de>; Tue, 30 Apr 2024 21:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CCD1C23483
	for <lists+linux-efi@lfdr.de>; Tue, 30 Apr 2024 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CCF199E91;
	Tue, 30 Apr 2024 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lE3Z8+/N"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A37710B;
	Tue, 30 Apr 2024 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505643; cv=fail; b=FEJ2/CI6UUD1M+/H6BXlO5kl4Ibr17YSgWCh2clqfFQ1zYDYxZWGDhowvmi+2KGRh4+J5bC7aHaxaD+kP7BAuUfSM4pPe9G5RYiTypl7yPC25Wzx2cUwShGL6KRB+B6QTHS3ilC3G34pHpHmELtTVmfQjIFn+/ZhZ4EbCouUIY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505643; c=relaxed/simple;
	bh=4vbej4OyZBYGbnKCzW7ARh1Ry67gQZ5Cii21XPe7n1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BVH8P+Kpl0XdOaDp1lOkh6swlPf+exRPBV+3i9CdUFi6TnNb/ldURk05FVnVi0c5/82J2svOI5NMxJykPgYoHIPAoixunsYfn2ICYfTFXOrrcfsz+nKJX4T+vfT2bLaR8sz/KRqUiga/G4vqp7HFroLsdc38+R92imR+vME6e2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lE3Z8+/N; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714505641; x=1746041641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4vbej4OyZBYGbnKCzW7ARh1Ry67gQZ5Cii21XPe7n1Y=;
  b=lE3Z8+/NEB2y7aWkpEyCoYxQch0tnM+eEKxTyHSkG05O8+oQM79H5LNI
   iUIAyjdExf5YzphNi5vgXVm17x/kxPvG95Zb42F+RhNGSr/U0dfHeTIAw
   82Z7hHQ+h5kahjbE7pSmXtP33bUyYwcg3Gk9695amQLyYbjVW/5Jghz67
   7qv7WTbtSbecN+5lC/6xyDGMbc5/aCMe4HxWhIVUyjmUva2leg08oC7ci
   E39enINd1dQPUyR43CaJAoxJn1VmcP+zyi4xiesB9rUQKzrnUB+H7yRd/
   LhenTD1Sh9QndwiFBu4YYombIaNdOnu/LTrJVrY0IWUz7pcGbGDgfCQgu
   g==;
X-CSE-ConnectionGUID: zrKa+fy9SA2BEQcc6LZ1KA==
X-CSE-MsgGUID: 3gpd9IO9TGi85UWMyjLXLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21382599"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="21382599"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 12:34:00 -0700
X-CSE-ConnectionGUID: 4u+X4tGXThiEAjlG19Vz+g==
X-CSE-MsgGUID: I0jYlZjVQ4iHeC5W67xpBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31362358"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 12:34:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 12:33:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 12:33:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 12:33:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 12:33:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOtfr1qj1OXaJuKDQRpe35EPtuc7KY7L+57OOLnynjk/p8s9uKToUtEq8eiBWsps9fmPlNA5HqRzBeVj6R637xSflzC4KRNKK5oaCm2No3vR0rjakCFJ0vjoPHNluuP35BEiQ21iBWIFhz3eaYGs9nKFm0DDQ96sjNMfGB4hYAirgDTutzEl5qZHMex0o72NVtHqo+fJDnEj+YVuMg4jWfFqbo8qj0+ko45JzIRT5J5FOuWroKdyg81pAWC/5gA/V2QUQYqH/KVAj+9xIKwRBBRPy1FqV2QpLGznm5itWjLMhbs+Qbq8S5ut69M3SnLezmnyjnpQasyoquwPJNMe4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVlWyZdxByZrNFrnH281Vnsp+XfPZQkACfGQ/v22kls=;
 b=IvehKGBFUWgRkhbc7nnW38RLYtOWdhZgafXRa/bQNqcnvkLIY5tRQhWeKtLRAkeyUkCZfVpxPnNk6akquYO6s5JpaxDbScIgfLnb9IqHLhRzlLsKHXXdvnCmJCV6d9ndEAqw2wwSmCJkvTm+v7ntjiGgLxjwcxjuoxMqonIGZrOVsxV+VzesaP1tVPDWp5G9gBwfXfjelI6LxEEzVVfdBAGeG9hias53p68Yy+tFusGO/vWW08rOIHSK5zou8FPvpwSUoqz048kLK5x/PfVaVvZnYL1kFkEkvzuIr+TGUZaKGbXSkEU18PGpiR2Pc6cxN1ES5rEDrNuNmv7lNjrJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7956.namprd11.prod.outlook.com (2603:10b6:208:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 19:33:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 19:33:50 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Weiny, Ira" <ira.weiny@intel.com>
CC: "Jiang, Dave" <dave.jiang@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose
	<shiju.jose@huawei.com>, Dan Carpenter <dan.carpenter@linaro.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	"Schofield, Alison" <alison.schofield@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH v4 1/2] acpi/ghes: Process CXL Component Events
Thread-Topic: [PATCH v4 1/2] acpi/ghes: Process CXL Component Events
Thread-Index: AQHamFPEcj60tQNEyEGE6JP2gc0nSbGBLgDfgAAKrIA=
Date: Tue, 30 Apr 2024 19:33:50 +0000
Message-ID: <SJ1PR11MB6083E2C92E326D3CF41479DBFC1A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240426-cxl-cper3-v4-0-58076cce1624@intel.com>
 <20240426-cxl-cper3-v4-1-58076cce1624@intel.com>
 <ZjE5O87IxxMAoaFz@agluck-desk3>
 <66313d869fff9_1c68422945a@iweiny-mobl.notmuch>
In-Reply-To: <66313d869fff9_1c68422945a@iweiny-mobl.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7956:EE_
x-ms-office365-filtering-correlation-id: 1780cc80-b2f2-4fd6-d420-08dc694c767c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?4cizOZ5EsvsJwEay5bQwuoX1QdAmzjcoFqhZc2ETfpHGTl5EifmU5EVzLrV9?=
 =?us-ascii?Q?DG2KOaCX7Vl8Qwk6OeggLckQLimxg7+I5B/z087STONzX9HdQI9MFtD1B+8l?=
 =?us-ascii?Q?h8fpk7GTDe80VZQ7urxLPx7lovRi3VK84MGBpBXcABR7mgi5scCWuUvpiy9V?=
 =?us-ascii?Q?2SIKsAijEIu4jK1b1CbucPqFd0s0uJ6TI1nPJQhrVATQGKXX5uip1fyHyanR?=
 =?us-ascii?Q?XE+nrvRgTavlaRAXlcq6DsbaGYUEjjglPEPpbSQCyGGik8JUIat7c7t+W+3D?=
 =?us-ascii?Q?kowiH520PYqYPWUjimLAtku/DVEdbp9nVUtv68KDvpxkPHkqHHuzfIeT1Y9+?=
 =?us-ascii?Q?cQTh2ZiKKJGPF8g9ImqT216oU0VK6I3H9io9D6QuDLcZhqIOCMT577JIJsIB?=
 =?us-ascii?Q?KjayYEehFySVX1t4QABCnra/weTeBqm4z3yWB3XoqH1jVb+IorYPloREL2eK?=
 =?us-ascii?Q?nS6eunmDCP3E/ZyehC0f5u7WuFUKAZFbQ02U6w8sVZvnDj70edwLSAM3xPe3?=
 =?us-ascii?Q?z0lY0WwN7+AaqZTZlFd2pDNR61zpbs6y08KBH8B7DBQ3Eqor6wNJ+HWDKggi?=
 =?us-ascii?Q?FTWo8wnkW4dbE0of0t9jOmr0h3FGALYkizgZK55UQI7Fm4cZ//9V9h3kVLg6?=
 =?us-ascii?Q?tnPqfuef8ctp5CcDD+l7T4kwHFMRt9LRk+gqHgffZZha/j/KJsisy4cv50F9?=
 =?us-ascii?Q?q+VZItvHqQLeq0hanLEp3IRYjVTLxdgpSpHy/3zjZmXJy7XbLBWWzbqdkZoW?=
 =?us-ascii?Q?2QvxWV+jlM3F0rG5bAaER2UqveinjhyEuKBtaS40Em9Z7k8dytvl21fORRu8?=
 =?us-ascii?Q?cDDFyaclGY92JM1rUfOc1NlTkN1rTS3JgR7+1hV7XoTWTcPdsR/z/JEhnpmW?=
 =?us-ascii?Q?Ld1l8XWIEztg5LfX/DI8L9Xg08V7C4PUc+jvWp3fQ7bHQkAe0gNjMTEE4P5/?=
 =?us-ascii?Q?N33JzdRyBvYJwIATT5eg50taCynqlglGFQbuTxi1YALUaN8vqBvM1GWzIJ3o?=
 =?us-ascii?Q?0oVZr0LJqTRe73mpPODoJ2+idMsXwjPz8JY7tzQdD6DG3X+GDHtkBcW63Fho?=
 =?us-ascii?Q?TKKpZS7Gdbh37m7Jz/Ms7mbGDtBaxWR+oMcpA2kxqFXH4lepFFUpIn0gmlU7?=
 =?us-ascii?Q?IgBCeD5F1pmO2vFxXeVUU4h25QMzPcSbpJ6aDJfZkFTyaYR42u6IorfQKZuB?=
 =?us-ascii?Q?q+4j8SBADtMBrN9U/TpxIor8bXfD69gj/ayuYPgmnm7QEm99aqtOyRPtqT9n?=
 =?us-ascii?Q?OCx1aGfXu7lUyh4ODOrgcwX0bfGa38QWQEes6tZ5bVpcvPcyzBkeC5aCQond?=
 =?us-ascii?Q?+yknnfQ5h9f+iMLY+r9A9HPvnUjSo0ob9GDxoGM3pV0Mgw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6xizJHTlf2JVfiHLOqNBC6hYIZQ1uxgkaWvQPwsJGO4EdAFrs35gp8qICuD1?=
 =?us-ascii?Q?tZl1jj2goljcHJfylZEI0J2tunP+FUZhuzKVwrq5YBeWSdzn3nLCQ/2AH9qI?=
 =?us-ascii?Q?G7+wiYEFUrd6AQHZtaSTeJiO+DkROPuplrVOknFQgHwhNSCOGvpXoUj9ri2Y?=
 =?us-ascii?Q?JlSX+BpJdvAR1Jv4zK5AGoMp6jv8PFWkIJG5JNfDPqwVtwafqwWzfeOdOg3H?=
 =?us-ascii?Q?0SlCL892pOkc2uH+LjvvyftRtPq8Zvqt1YNURT5RGLIpSH4RsvAPBS5mn1Lz?=
 =?us-ascii?Q?2Dk6REeERwo55R5Nyb9Ip3QcwoaTQFxMZjkMwpRqqV3YwYPutRCuDGn15+IL?=
 =?us-ascii?Q?YDzgu57w96uR2JcSFIXE0hZ3Fs2LWKXjxRny5VLZoRchBikir6ImS0eklfpd?=
 =?us-ascii?Q?ehTkZorQoqs64P3y1fz4m9m0qgJjUU7doWNjFBOpJAhdNOrGQqZiC0PFkl4l?=
 =?us-ascii?Q?qfHl2skNom1i1DBFjM2PqFajHRBUhY5fEqSxWZ0iy4u745TXyEsFe2EGxRyP?=
 =?us-ascii?Q?c/4T9V7UXDHaJxQPi17O7yKHTKEYsxMjwm4IqYlPTmyfqV8g0D/886z2mAjG?=
 =?us-ascii?Q?75kKk8ny1H+p7xyg92j+aDUX7DGHaENDf9LnSpQwRK9NBuswtEBnkxfqiGiJ?=
 =?us-ascii?Q?2p/SBZCDsnv0uL8nbfSCPltusC/GyDfS3EKKR1KhzGnfbB8Q4MwsYIGZZWOy?=
 =?us-ascii?Q?jwSZdWX+tK7fgmJscqB7UmMfoeujbs4QaW3zmOEFKavEVsbqPgfIeXBFn3dH?=
 =?us-ascii?Q?47FxXdXVJtgVcsCYJmUBFN1WhBjdHY1VIjtz9B/QX1RZLZ84Tdo7fGGZ3BGt?=
 =?us-ascii?Q?najY45FhkSoZfZDKAD3kXjAy4fxg3LZ7r2/oz7qBYhcHR7yCfPL6xXrTumHW?=
 =?us-ascii?Q?ihEsLg4o/NJp/PnAfHKXqo4NR6QQkIcM40L83Ruo1Nq/+0HFneKylbYESB3E?=
 =?us-ascii?Q?DDqE5ZUiBvhh3EGSAkG7KYdWnf+F1EWEJM2hiefkG6sesmygtbBLlO3UqcWA?=
 =?us-ascii?Q?lRL95QBdSJIBvtkPGxhdFreRIUeQjhU2gq8RbrxgxiGXeOaYMkHG14f7OTQQ?=
 =?us-ascii?Q?fWgtaEzKee+nEdNsEq+aV4/EjpLWkmry1cFkUVJuu6KXkga24b59WmzIT7+e?=
 =?us-ascii?Q?zqm/flthSk1OwSGbKqNS75ut6EuQoP/VnobtaC/wWnoZBfM+7DcW2LoaLmkQ?=
 =?us-ascii?Q?yUG508bkGIxJ0wNkfa2MxfEMllSBfcM+Exz2bLpSaLGVP8HQvDr53mdKNHC+?=
 =?us-ascii?Q?qjqpZ4bLQIIbHqwQMI59I3V4AZClnQSfwCKuAp+/HNOrM/eCC1I9P6rAdZWE?=
 =?us-ascii?Q?4ShsZ7cimS2Yj6wVxN+oe0JXxd0fPIGu6XTOK+Bpg7q3s+Q8PFZGNy6+cQcx?=
 =?us-ascii?Q?x9ffoAazUxoZUe2O2ir+nRoDdV6LODxiIuRGMM/MRPlZufwSsMJocHbPIcxF?=
 =?us-ascii?Q?rkCO9G7XD6c35niwwSkp5Jr2kLk6A80L8qVbj4ptWDc7EOtY5c9iBz3+L4jf?=
 =?us-ascii?Q?vtzt2Us2v4iqJIL7YsyMtjUHVEq7Y6FpIqwbImPgdPKbHQeOXdmV8Bi4RnZU?=
 =?us-ascii?Q?/DGQ7dXRCoCHhFEn6+5XjCMA2fLaAvISzLDcadAx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1780cc80-b2f2-4fd6-d420-08dc694c767c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 19:33:50.5845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJFnlV4gVsxhOi/5W5gwqbA4uVVUVBZOJv5uyaFIf7iAXyy02bvQXh6Rj9Fe4yqbAKj62BKc5hmJCrMLiTgvtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7956
X-OriginatorOrg: intel.com

>> What's the lifetime of that record?
>>
>
> The lifetime is contained to the cxl_cper_post_envent() which does not
> block.  The kfifo_put() copies the data to a cxl specific record to be
> used by the CXL thread for processing.
>
>>
>> Can it be re-used/overwritten
>> before that other kernel thread gets around to looking at it?
>
> Yes because the CXL kernel thread has its own copy in the kfifo.

Ira,

Tracking down the call chain, doubly safe. You first copy that record to
a local variable in cxl_cper_post_event() and then kfifo_put() will copy
that copy into another place for processing.

That was my only concern.

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony


