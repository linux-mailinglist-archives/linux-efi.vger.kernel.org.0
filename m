Return-Path: <linux-efi+bounces-1918-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FD4993D74
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2024 05:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E521D286B7E
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2024 03:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8871633986;
	Tue,  8 Oct 2024 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTDN+PuL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC81E49E;
	Tue,  8 Oct 2024 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357896; cv=fail; b=IU54yIOcGmlOBi1mgxFDoaP2DLRkBU6cDzejvD9ctnLvHn5oVKWcJdqPjPWwT1+PtGPFbIjBlTU2iCENIBHRIoJIFlT/zhR5JAencIbU0I3x1tIBFcwUFvS3hE+pBWVxs486xukWvYpU3LjuqJZm2Ga3Enu5S+dtVR4H/Lv4gfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357896; c=relaxed/simple;
	bh=q8+JeEkFy+INlzJ7jHTyhE2OBoDZLMqNaiQ1agI6TXA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s518owMeQF6rkk3xSuij/wOQfbDxA5OWk4kvbM0YaRlinNGwjYiE7kxCarJTc3Y7OQQfPtshe/BhfePrkuSRiBjoRLnrqqitlbPhQ40itspB9dm9QVgdTilzYfDN9gpCVUkpVw77K48201r8xqEqQpKET7DSlXYMYSHpADUDFdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTDN+PuL; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728357895; x=1759893895;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=q8+JeEkFy+INlzJ7jHTyhE2OBoDZLMqNaiQ1agI6TXA=;
  b=XTDN+PuLYfK6vkZNAzpADXOaHs05xx/9mC3jT2yE++UWOVxB2924jbeV
   20fKM56sgjFVWtO294dzLJU6x/XZo/tBzkUGsnP6wZR196/Xk6G+PBddt
   CrqSHyLpgYFhEMIZypzFQa9LHl7/ih0cm948L13oAj6uqGLlRQkAOdvBs
   R+oW6vXPrn8cLwIKLhVXrAprmOULZyjM6CfiY8E+aASHl/FlFFYq3K8Qr
   XLPa2BwddA6T2oaYiNBflL627L2tLxgASILgyAbmSvqUod6kAQlrnNK9y
   ZyRg0vES9tmeyfDnkBUteKYxpvvUKv2f7vJ5l+FirhpXxTGvQ47Nuj+4G
   w==;
X-CSE-ConnectionGUID: H8GTPqRKQ22hQij7cRpWrw==
X-CSE-MsgGUID: QS/QC7IbQ6mHkadI7IEiJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38917139"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="38917139"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 20:24:46 -0700
X-CSE-ConnectionGUID: mgrVUASBTTusx5dGhL63Hg==
X-CSE-MsgGUID: +BHK/Y4FTRuL4KLs+jKF6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75692883"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 20:24:40 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 20:24:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 20:24:39 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 20:24:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtUd39Hq/qgqWOK9YyOHKccU6qFfWwt0lD7N2Ym55j1F5IiViQ2G0EpYe74VqDOosDWNiGQLeQsWLZQV0XX0a1KgomnGzF6hHVJfdUVcltMbbMex88jjAa+3KD87qCIaAaViDYw24co0Hlv+ZCKQ4hyuIVmUhMkec70fg0XLji3RUTmAzb5FKnNO++tNifAULvO4wkR+x649kufjUCyh7927Gt8as5LWO0JcVpZjV90N6BB3Z8cGrj9Ft5ZDJRvgp7lg+aJrp0yu2H1+Nz467UdmZuBNc3BDvij5prGdFleQzH1e0tmtA+nEALSFjzM2c7Aij1WJ/GvezSb3iCViBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8+JeEkFy+INlzJ7jHTyhE2OBoDZLMqNaiQ1agI6TXA=;
 b=BdYGByOxQ1mxjbJD7WyluoVHnBJLKPM7srqMaFqD1eph9AMWZOrmsXLbKQgU82GkAZnbhh06adijmZ4toTrTj0if6Dc9j3hW9hkQySZBh3dNDjQe7wbdnqRnw0+XhN/8oz6HLmsaTqy5cUrFYlxN4UPalSSNBZG975lSuW3F2FGP6iRYIvPbCZU6+LIMBL/PEspp3NtGvyEZG9gMUnm0LJXxQViVazOPtKQUvUkHBsmcxO1Ik/6geyPsPtDFFwRK3TtdrEkbgdWrZKvEnUls0dSN9eeXNKtghBPG0mRYkbHff/Vt4gmr6ifclJkK4CIBRKocwqw/ERlbYrsgPZLplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW4PR11MB6618.namprd11.prod.outlook.com (2603:10b6:303:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 03:24:36 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 03:24:36 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "mochs@nvidia.com" <mochs@nvidia.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "Ko, Koba" <kobak@nvidia.com>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 2/2 V6] acpi/prmt: refactor acpi_platformrt_space_handler
 to drop gotos
Thread-Topic: [PATCH 2/2 V6] acpi/prmt: refactor acpi_platformrt_space_handler
 to drop gotos
Thread-Index: AQHbGAWCB+b8+DGFp0K3uiLUupBPV7J8MyUA
Date: Tue, 8 Oct 2024 03:24:36 +0000
Message-ID: <406588af4aab38f4d746fe34291f4b853ca18452.camel@intel.com>
References: <20241006153611.1165482-1-kobak@nvidia.com>
	 <20241006153611.1165482-2-kobak@nvidia.com>
In-Reply-To: <20241006153611.1165482-2-kobak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW4PR11MB6618:EE_
x-ms-office365-filtering-correlation-id: d43bee13-2c3d-460e-4ac9-08dce748bc3a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmJhV2pabkVuVWZ1b3pHa1FiSk1Hcy9XN3JNNUxKcjg0QmM5NFdOREZkVlox?=
 =?utf-8?B?dkV4Y0hZb2VNUnpHbFNhNExTa1dSbHVxWk95OVNFdExXMHBXRWtpUDZJaFRU?=
 =?utf-8?B?djZPNU5hencxNG1pTkpQM2M1WmlzaGY5dFp5R29yZURLbU90UDJVMGxRVzlH?=
 =?utf-8?B?bXZqcWZGWFFsclRJNHZzVWN5LzUvWFJjVlI5Z2ZMRy9VZWltcXpEbmtVZ01E?=
 =?utf-8?B?Y0kycXhEQllXNmVCbUNwU2hQb2Y3ckpZLzBnSzRyaCtPZVg3dzZZVVFuRjVD?=
 =?utf-8?B?dkl1OG9OTEswMG1aMUxyVjZsVkM0Z0FPNjVRV1ZDL29MbHZidThlL2x2UHdt?=
 =?utf-8?B?SnBEUElRQm14RDVpV0prdlJYNEpSZFdsaURuRXM0T0RsN3JiWExkMU94NUww?=
 =?utf-8?B?MjJhOWVPNS90Nnpkb0RBYkdlSkx5MytyTk5EVi83dVlvNUNDSGV2R1BsNE5a?=
 =?utf-8?B?cml1NEEybmNneGJwWGdQdWJOdk9XQTlUMUc2cmllUll6Q295M1FlbkNSUHJm?=
 =?utf-8?B?eURZOGpaV2JSeXdLTTlvdyt2bVNBZ2dyOVJPY2VFRGFRU201NHY4bTIyQWxM?=
 =?utf-8?B?a1d2WkJka3FiNU5MZk42RG0vemZyTnBJcVB2Uy9DS3lNYVIzRHgvdGtyYVQ0?=
 =?utf-8?B?bmdIWDZiOFpsL0g0Vkg2VSszRitzdStWM0RGQ2tES0UxUTAwcVpuY0tEQytj?=
 =?utf-8?B?TEgxUWpleGgwRE9MZUp3R2lHYjVlSTA4TURiMEUrOG5HYnN4eWlRZ3N1eXZ2?=
 =?utf-8?B?NG9RUUhMRnI3WkNsWlQ5STBObS96UDk1UGdjcXdpbnNtbFo0V1F2czhCVVZU?=
 =?utf-8?B?NWNlUE5lNWJxL2VKMlcrR1J4R1FBakJEQ0NYSkpEUjgvd255S1MybUl0OFRu?=
 =?utf-8?B?ZjQvOGRzODFNcDBNdG9GV2pIbWxIMENucHk4UGV4dUl2M0Exc2RQRk5ZSU55?=
 =?utf-8?B?SVNMVkJiMjBoeFJGZEFpNDNiMTRNT3NJUkd3ZVVNaFVzZENWT0xTZE1BbnUr?=
 =?utf-8?B?VWY5VGlLejVjUnJyZDgvbXdQSU5LWGZVak1Pb3hzemdDRURMSDJsaW9iYkdn?=
 =?utf-8?B?OU1hUXliUUNCbDJNVEpYUUZhYlFMVmhJcThjWGRwMWRGZDZmbHRPWmw1Znlq?=
 =?utf-8?B?NjdmdHdsVkhnNFo5b2VJTWlMQmNTZE1PUXhyU1hLNVJ1NVBKaExXTU9MUVg4?=
 =?utf-8?B?ZVhnNzU2T2MvZDByQWt1YzhNbDU4WDA1SGNuN2pzZVZ3c2lSR3lLTkJPNXEy?=
 =?utf-8?B?ODVqNThubmxTenk5aU1CcysvK083MEVpTkViSE95N2gxUll2TDZIUGRtTktq?=
 =?utf-8?B?ejBXaEt1NGd4L1Y2aG1vTXcxRGpGZFZDNXBXd3BYeXJvbXhEM1IyRGVCSEpV?=
 =?utf-8?B?S0pFV3cvdDFPRHhYVmJUZmxFTVBXVStvZGFEeUhWYW1OSjRYRzEzWTF1V2xG?=
 =?utf-8?B?RWgwOVBBVkVoQWJVUkMya3RFMTJ2ZG9abDZBZE5uQkEwaDJzbGJFalRENGR5?=
 =?utf-8?B?ZzNaVkl0MVdNeGF4OXJTUFk5eGlSUVJUQWYyUUlqQS9oOVVUZUJ4ZWhBZ3V6?=
 =?utf-8?B?WjFtOXZ5c2FSOElGeVJkNVFYZDM0UGYydmJ6blVhek9WS0ViSHMrTHJ2eEFn?=
 =?utf-8?B?c05WQUN2bkZob0ZONDBBY3JqczhEQk9BS1RnR2pIR0ZNek04QU5wVStRMFVr?=
 =?utf-8?B?dVVpd3pJS1QybXMzblUyTjI3TFNtcE5MRUhudEx0ZXU3cDNuSVZSUUF1blZu?=
 =?utf-8?B?VmhjUGlBTnFNUkUwNFVkSW9uUzhlNkNxVGo5STQ3c3pvWjYzQnlNZEZkdTY5?=
 =?utf-8?Q?J3x1e5kXdZ9W19oY6fMvtchBwM/ISi0UowDyg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW54RWVKS1BFRGhzT3pHSzJ1L0hhbFhKOSs0UXEzTTdrU1I3UDRSZFcyQjVU?=
 =?utf-8?B?NXl3YmRYa3FqOEY3Ty9JampOZjBac0FSV2Y0ZktDZzV5eG5GbEJFdU5XMnNK?=
 =?utf-8?B?bnhnSnBrOS9KWGpTaUJ4OEJaSXlTUU92RDhHWUdydDdWQTV2NC96aENKSkNN?=
 =?utf-8?B?VklaMW03TFpIRlh3RWtpaVB4WWJjLzZoWncvdzNPQVlaMzF2eXpJTDl1SWNI?=
 =?utf-8?B?YjhadHhDRjFuR0lieUdobGp2ZUExOFZybHNaVVgrbzl4SExZNUY4Q2trTVoy?=
 =?utf-8?B?a29qZVdZRmFmTkN5enZxd1NqS3dBckhXMVJsNUx5UmczamUxcWZnQVdWcXBF?=
 =?utf-8?B?VXJQSXRaclg3TmJBaGg4Y0Jna05meWk3bmRYR28zb1dHWjRvR09EK2xVYk0y?=
 =?utf-8?B?VXlBTW9HOUJMQXVZdXg1SEhwRldScnF5M1hwSkdoUGxscHB4TzMxSHNqb0V5?=
 =?utf-8?B?YUMrTklFRklSMnNyYlpLclc3dUFZQTVNc242ZlJsclFXZGJ2KzVERGFUak9o?=
 =?utf-8?B?ZzNtZ04wZkNhV0tjcHVpODI4WWlKdHBlSjRycFFvNnV6RmZNb0hPWldCZnBm?=
 =?utf-8?B?ZjUzOVgraWhHQUpkV0EyODQ5V0h3bU9HRlAzam91dUtGZVYyV3VvNThYa2tp?=
 =?utf-8?B?SFM4UWpqcTRBSTFoeWpSOUdLN2Z5UDZZclVDMjltZ0x5VmtQUUtBZngzRGh5?=
 =?utf-8?B?aXpBUzhKa0dxTHdIQW9BWi9DUk4rMXNReWlVbU1YYSsyMUdEeks2VHlRRXps?=
 =?utf-8?B?RkZTQmsrUlB3Y3Rmck5jZGZkZEM5OUQvR3MvcUlTOEtFOER4cElaZnI3TlFu?=
 =?utf-8?B?TUxYTUxhMmpRYWphS2IzMVZ2MXFuNDBrWGlGSDRueDhRK1o4NlZVMTZCV2Fi?=
 =?utf-8?B?TjQvTXhwWW9XcWlwQkc2YkRIbEF3V2lUbW1UcXdqWnJ6ZmlZSEpEYXVxV0xF?=
 =?utf-8?B?VnRPdU5VWXRvUHZ4S2VXdjhwNFBDK05KL3M1RXhHc1hqYjIyczlhTkZKbXha?=
 =?utf-8?B?WWRKMk5zU0daaGs0ZmJhTVlhcmxZRWZCWEdyOE1Dak13eldJVUJHMWo5M1Vs?=
 =?utf-8?B?V2U3UU5EK1l4aFgvSUxpcTBWWlorbEdCU281RDhROUZxRmlKb1RmTDA5Vlpn?=
 =?utf-8?B?Sis4VTI0VmJGUkxHRGI5bW9FTW1KY1d3eHJVT29BOHcrWHpSOFBxSllFRzJ0?=
 =?utf-8?B?OVBqSXZ3cnpFZUZZWlJOemtZaHJwNHJyZ2lFUmFVWFZNeDZhZmJYdVBkRTV3?=
 =?utf-8?B?M09JR3dHTEdxU3NtUE1UNnEyK3RRQjl5UUFKM2dzVU9kRFZxZ2VUbEFUVFNR?=
 =?utf-8?B?R1FGUldUYTNmei8xN042MHJ6MGJ6VC9jT2tBd3haSmJPWnMydktkZVhBbVlo?=
 =?utf-8?B?c3hRTUUrNDlZbERzM2E0WkF6RmVzaTBJSXNrQTRjYXlnZjJGRVBRV1FwSG51?=
 =?utf-8?B?R2s4a0ZrekVrUVJ2ZEFJUHJZcUsxR2xtOXFkUXBtUFlJb21QSE5BWU1YSkNN?=
 =?utf-8?B?ZU5wL2JaZGdaZUFTVld6OXdJUGJvQXhqZnRkMlVIM2NaU2lMMVJZc1FwcFNv?=
 =?utf-8?B?WkZrYWVSNHAyNjMvWkM3N1lMU25JVWd5bTBsNTlDTjlBd2tXQ3hKS253cnRI?=
 =?utf-8?B?eGwrVnVwSmlqVStwaXl0SVlwd0g1Z2JuUzRMa1JzdlpDUDZrVC9BT3pmeDhK?=
 =?utf-8?B?aUVFbzVYbSsxL0Jub0JYZll0QU81T2piTXI0UEcySmNtMGhZeXZTR2dPT0JP?=
 =?utf-8?B?UHU4RW0xb3Q5UDdkT0FyL3IzYmtlZVZvR2EyT01JRnRkRGhhQUQwbUcxZlJH?=
 =?utf-8?B?TzIzMWsvM01tSSt1c29XeGRzWUxNcElscVUrQXBTcTVJRU5Cckxhemh1UHIv?=
 =?utf-8?B?dHhlS0lvbWRRWE9jODNIRG91Ym5nQnFHQlRwVnAwOXJQTldaUmFjSk55K2xi?=
 =?utf-8?B?blhPUVJaZHRPZGZFc1d4Q2JKS0NYM044bjRUdTI5TWFFbngrZGxkZjdFdkdp?=
 =?utf-8?B?UVRJV0RoLy9oU0Q2emIydCtVWFl5S3VOOHlGUW44R2VvNlFGb0xkZEZnU0J3?=
 =?utf-8?B?cUFoN3hJZXMyaGVKbmsrNFJqNEsrelNyZE9qUWluY3hFVEJVVVhVQlZrRGRs?=
 =?utf-8?B?UEdnUnZ5d0hYcmVTdWdYQ1BuQWVjZVJJc2p0QWlCZWFmMG84VDFvdlYrblhr?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <692BC4714640864FBA7A3524BE4E0F40@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43bee13-2c3d-460e-4ac9-08dce748bc3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 03:24:36.1158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sXPTFP/sM9CUBZpPXeGI96QXbwjlXFtRB44YaH5cF9KMKa+cerd0iuvuH3seILpLMJVOqzcmBXYG8m0z1kx4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6618
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI0LTEwLTA2IGF0IDIzOjM2ICswODAwLCBLb2JhSyB3cm90ZToKPiBGcm9tOiBr
b2JhIGtvIDxrb2Jha0BudmlkaWEuY29tPgo+IAo+IFJlcGxhY2UgZ290b3Mgd2l0aCByZXR1cm5z
Cj4gCj4gU2lnbmVkLW9mZi1ieToga29iYSBrbyA8a29iYWtAbnZpZGlhLmNvbT4KCkkgdGhpbmsg
bXkgcHJldmlvdXMgY29tbWVudCB3YXMgdmFsaWQgYmVjYXVzZSBhIGRpZmZlcmVudCBwcm1fc3Rh
dHVzIGlzCnJldHVybmVkLCBzYXksIFBSTV9IQU5ETEVSX0VSUk9SLgoKR2l2ZW4gdGhhdCB3ZSBy
ZXR1cm4gQUVfT0sgZGlyZWN0bHkgZm9yIFBSTV9IQU5ETEVSX0VSUk9SIGNhc2UgaW4gcGF0Y2gK
MS8yLCBJIHRoaW5rIGl0IGlzIG9rYXkgdG8gZHJvcCB0aGlzIHBhdGNoLgoKdGhhbmtzLApydWkK
Cj4gLS0tCj4gwqBkcml2ZXJzL2FjcGkvcHJtdC5jIHwgMjIgKysrKysrKysrKysrLS0tLS0tLS0t
LQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+
IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcHJtdC5jIGIvZHJpdmVycy9hY3BpL3BybXQu
Ywo+IGluZGV4IDk3MDIwN2JjOGY0YS4uYjBjZjQ0MjhmN2UzIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvYWNwaS9wcm10LmMKPiArKysgYi9kcml2ZXJzL2FjcGkvcHJtdC5jCj4gQEAgLTI4OCw4ICsy
ODgsMTAgQEAgc3RhdGljIGFjcGlfc3RhdHVzCj4gYWNwaV9wbGF0Zm9ybXJ0X3NwYWNlX2hhbmRs
ZXIodTMyIGZ1bmN0aW9uLAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBo
YW5kbGVyID0gZmluZF9wcm1faGFuZGxlcigmYnVmZmVyLT5oYW5kbGVyX2d1aWQpOwo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kdWxlID0gZmluZF9wcm1fbW9kdWxlKCZidWZm
ZXItPmhhbmRsZXJfZ3VpZCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgh
aGFuZGxlciB8fCAhbW9kdWxlKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZ290byBpbnZhbGlkX2d1aWQ7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmICghaGFuZGxlciB8fCAhbW9kdWxlKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBidWZmZXItPnBybV9zdGF0dXMgPQo+IFBSTV9IQU5E
TEVSX0dVSURfTk9UX0ZPVU5EOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIEFFX09LOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB9Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghaGFuZGxlci0+
aGFuZGxlcl9hZGRyIHx8ICFoYW5kbGVyLQo+ID5zdGF0aWNfZGF0YV9idWZmZXJfYWRkciB8fAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCFoYW5kbGVy
LT5hY3BpX3BhcmFtX2J1ZmZlcl9hZGRyKSB7Cj4gQEAgLTMxOCw4ICszMjAsMTAgQEAgc3RhdGlj
IGFjcGlfc3RhdHVzCj4gYWNwaV9wbGF0Zm9ybXJ0X3NwYWNlX2hhbmRsZXIodTMyIGZ1bmN0aW9u
LAo+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIFBSTV9DTURfU1RBUlRfVFJBTlNBQ1RJT046Cj4gwqAK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1vZHVsZSA9IGZpbmRfcHJtX21vZHVs
ZSgmYnVmZmVyLT5oYW5kbGVyX2d1aWQpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpZiAoIW1vZHVsZSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGdvdG8gaW52YWxpZF9ndWlkOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpZiAoIW1vZHVsZSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgYnVmZmVyLT5wcm1fc3RhdHVzID0KPiBQUk1fSEFORExFUl9HVUlEX05PVF9GT1VO
RDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biBBRV9PSzsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobW9kdWxlLT51cGRhdGFibGUpCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kdWxlLT51cGRhdGFi
bGUgPSBmYWxzZTsKPiBAQCAtMzMwLDggKzMzNCwxMCBAQCBzdGF0aWMgYWNwaV9zdGF0dXMKPiBh
Y3BpX3BsYXRmb3JtcnRfc3BhY2VfaGFuZGxlcih1MzIgZnVuY3Rpb24sCj4gwqDCoMKgwqDCoMKg
wqDCoGNhc2UgUFJNX0NNRF9FTkRfVFJBTlNBQ1RJT046Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoG1vZHVsZSA9IGZpbmRfcHJtX21vZHVsZSgmYnVmZmVyLT5oYW5kbGVy
X2d1aWQpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIW1vZHVsZSkKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gaW52YWxp
ZF9ndWlkOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIW1vZHVsZSkgewo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnVmZmVyLT5w
cm1fc3RhdHVzID0KPiBQUk1fSEFORExFUl9HVUlEX05PVF9GT1VORDsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBBRV9PSzsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAobW9kdWxlLT51cGRhdGFibGUpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnVmZmVyLT5wcm1fc3RhdHVzID0KPiBVUERBVEVfVU5M
T0NLX1dJVEhPVVRfTE9DSzsKPiBAQCAtMzQ2LDEwICszNTIsNiBAQCBzdGF0aWMgYWNwaV9zdGF0
dXMKPiBhY3BpX3BsYXRmb3JtcnRfc3BhY2VfaGFuZGxlcih1MzIgZnVuY3Rpb24sCj4gwqDCoMKg
wqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gQUVfT0s7Cj4gLQo+IC1p
bnZhbGlkX2d1aWQ6Cj4gLcKgwqDCoMKgwqDCoMKgYnVmZmVyLT5wcm1fc3RhdHVzID0gUFJNX0hB
TkRMRVJfR1VJRF9OT1RfRk9VTkQ7Cj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIEFFX09LOwo+IMKg
fQo+IMKgCj4gwqB2b2lkIF9faW5pdCBpbml0X3BybXQodm9pZCkKCg==

