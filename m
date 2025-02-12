Return-Path: <linux-efi+bounces-2790-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A8A3311F
	for <lists+linux-efi@lfdr.de>; Wed, 12 Feb 2025 21:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6AC63A9F5E
	for <lists+linux-efi@lfdr.de>; Wed, 12 Feb 2025 20:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FAD201018;
	Wed, 12 Feb 2025 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cdT5liuF"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C51FF5EF;
	Wed, 12 Feb 2025 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393869; cv=fail; b=gPSV4JmdbXTSwAI/CWONFKrzaVFlbXQl7lOgG18Ufi/jhfKHjpPbb68ym7xzBfapTLk/DLlhiyMilJ9RYgfy1cpy3Noylo0REMK3zl31RxrgDZRoRPTj8ad6pil7B25trV4/8meMy790h/FWmK4GAuB2er02/3J+qlwnx0Txxrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393869; c=relaxed/simple;
	bh=vGdpuFY8G1kyS0dON6i6iKSUiTjhog/m4ZgDb1//aDs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mKFJXXLnZVzK7HZ4Z/fwHSryQ3cQJ300WQcW6GNrq5AlNQW+dMO3c+UWy7azUIp8fnAKO4UijABL4PNW1OkJ0mZrf2oRkwlZ5+KhuCUdy8iEU/hfoPRHDxQMGvRwR2M19fei+RjIn3pSY6LNijsJ9JeG5o+sg5IwnD+cWckfKxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cdT5liuF; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1as63Ntjqt2nfUCKxZy6oR1CTpFV+cNbUmNuR9+oidspfo0DJOmop2W5xKBjNzJBgym/etdcqKTsJwpjy6yjMgaDONyssjQ9IglEBWjpT2HAcb6MFUht57Yw2mdIFQK5MY2ISsPk4PVrsHBN9QZdI35m0K+hALzKUmM4p8K1vNQ4xM4pC17emk6RqfkrfJsgmIrdlF7Z0Q5mFqLP8LSPWfNFBIirsfr39dl0imH8dKKhH1TQ8MllIjCXGmz4fMgFP2cOpkHfNhSoyLZ6FV/YQ4GeHqoPASmUAQoHYQ/BjrGyauBvuVxvFiRbEsc3XZ6gw31KFgtLGJUnDM8mrJaJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lv5QYUxZ7BKPuc4wTTWL1apdEc5utg91QzIvmy6VtQ=;
 b=d7bXszdsRI/b0RLZoaVNwuDH9R57LwfKatJ5AZI7VHID0YOjPNO6yNV+hA7PmofXGhIwSYCVp6Y5eJoGma+9Cs6osUTM0hFZFYEerTATLY2hpmG3tg306ia8/+EnvIRxOii1QPRZlq16rk3bBWHax4TFYfcOMWys3oVpAwtCSkeA6fXZVQkqWHfDkW+s7Ml8HxEr4aFtzN2aLteCYIkn3ZX5pNUXZzMAgdx3y4KCGpAQqbFczEfvxoafGkK0klcadWAQllI+lSfQYzcM977Bf0qrmI49NLY5sDJu9IZzi0puD3Rb+w39ORS80E4vxb/6vs1iPTEcYYPgZ2geM8mf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lv5QYUxZ7BKPuc4wTTWL1apdEc5utg91QzIvmy6VtQ=;
 b=cdT5liuFVP/ZFqT9W17Tb4ND/y/5amTSLF4lJFiipZgJ/ruOnixD+9BPOz/dAb6uvEKA++QhNW8LZsVDjBrvIh14sj3E8AW1+pE0Kfb9HB6Oetvx0g6/5q8jsteoQiGAM3hbONn5/7NO52R3mOcA6tCbRk+Qb5CtsKCw0XQos9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 20:57:45 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 20:57:44 +0000
Message-ID: <e01db826-e70e-4d42-a91b-b5531e117296@amd.com>
Date: Wed, 12 Feb 2025 12:57:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
To: Dan Williams <dan.j.williams@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-6-Smita.KoralahalliChannabasappa@amd.com>
 <67a3ed1947d5b_2d2c294a9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <67a3ed1947d5b_2d2c294a9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0182.namprd05.prod.outlook.com
 (2603:10b6:a03:330::7) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 46782234-7ddb-44f0-7656-08dd4ba7e5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZldxK0M1UXBSMGk3ZFJkVUs4anhaOXd2N25WbVBrQjV6TncyQ2IyZjlGeW1P?=
 =?utf-8?B?K3NZeHUrLys2LzNxNmxmK3RQVk5uVXJjVEJyNmt0eGdjb0tkRmM1UkY2LzZh?=
 =?utf-8?B?ajJZbjBVdFp3cytFSkYvd2w2SW1yTWZqVXFsL0NFNnlLQm1ETFJRSVQ3cS85?=
 =?utf-8?B?WUt1UG9RR3R5L3dnY3RYZkRONmRKVERoVTNUUEJRT0Ftck1uUDErRmdON2p3?=
 =?utf-8?B?emdVa1FnaExOUEhORU9sbkp0OURsRG5NdVZwQnpZeGo0d1FvemlCNGxBTW9P?=
 =?utf-8?B?U1A4Q3BjLzVMY0JNbitFSzIwSUtRT0syU1FyMlBXaHcyd1F2ekI3TnZiQ3RO?=
 =?utf-8?B?ZUR1QTRiUE9ma1BjODIwNGdVVHdjSXpWaFNtSHlRNUowUHBnOCtZbzBjaDdr?=
 =?utf-8?B?MXlmYU9jM2lTQmdtUDRNb0FQLzRCUmoyeWdxbjJWdVh5Rm8xeElDSUZ6bm54?=
 =?utf-8?B?RmJtTEQxcXM1VGMxanovYVh1VUJrTFZVMVVJV0NITE5BRzRzbk8wTGJUTFkw?=
 =?utf-8?B?VDMwcmhBbmhHVnJUVGtMSFlMcGF1Qnd0WTZoOUlwTnRISHJPdHUzTmdhOU1x?=
 =?utf-8?B?ZzFQdDloVklBZ0IwelB4R01QczNLNjV2V0toeVVUQytrWkQvb1NXWVZwUmNS?=
 =?utf-8?B?WW9WSXFxY05MUnNqS0hJWmdvN3RhWnJzeW12Z1lzY2VycE92M1dXWnRVWVY2?=
 =?utf-8?B?NDg5cDJKRVdXU2FOZUVpNUl4REFjdUllQmp1RTY0WmZ5a21TWW92VS9SUnoz?=
 =?utf-8?B?Z1hxekRlbVBwdjh0SnRuZXJLRmNVNSs4MkEyNWd5SUpvKzM0eHV3ZUJ6aDlh?=
 =?utf-8?B?ZDExUVNWWTEyWFE3N3V1dEVXZ1lwRkliRjBTLzMzVlVoL0hyTU5OdHZQVk9D?=
 =?utf-8?B?KzlXazF2eDRsU0l3MVdmRDdHVm5pVlVlTFVIOEJ6aWxMQ2huVk1DdldwcWRC?=
 =?utf-8?B?c25mRUJHR1ZrSEg3ZkZGSnlJMkhGR0c5M3NNUXFKZXl2UWMrb3VzdDF4U1dv?=
 =?utf-8?B?REdDckI5MXdoR0laK2c1YnBxSmVDRHR4Mk5LenFWNVZNQktTd1RoVkZBZTQr?=
 =?utf-8?B?aDM3cEgzVkF1OEtnQ1U5RzZHQzhwTmNUNVRvYmJ4M3RKa0VuRVZ1eDI1Y1ov?=
 =?utf-8?B?UXJMT004RDdwZzRZTWg2RlNET2I4UUlrcUl2NHlSSlB2QXpZdjR5eHU4U3JT?=
 =?utf-8?B?VmtleDA3bWVXYVU0cG44Wk1xV1JOTmsvKzBqc1NjaE04b1oreXJEMllTYTAr?=
 =?utf-8?B?c0NQMHA1VnVaY0hrUHhVYTNFbkNKMWhGazR3Uy9RNDNrSHNLaFJzVXYrMzgz?=
 =?utf-8?B?K1FMYmhxUGQ2U082dG80bmV5anZ2SG9MWnNXUnVraVFpbUVqRTRLeTZCR21l?=
 =?utf-8?B?K1NtRkhuWVFTQm4vMU1Ba3VzdWQybUpNT0VhN3NlV3ZWZWV0WjZ5Z2I3bXRw?=
 =?utf-8?B?aWp1NG1hZldKK0ROMFBJZUc2dkFXc1B4Z3g3WHEveXRBcVdkcDVxc2RlYnVF?=
 =?utf-8?B?ZlhJN3BmTkduUWdldGtTTmdncHArU2Y0UjF2d1NaQTZHUnRXbWVSVWt3cWVJ?=
 =?utf-8?B?SWhMNVVSeUVrbHB0MWdXU0pUaDJ3b0JvOGtYL2JUYk45SUdKVVRUMnk5OEpL?=
 =?utf-8?B?disyNXhrZW9mSUVlQ3FjYVBEYmtqV3RGZm9kem5MeGNPTHFYcEZWR1B2cWV4?=
 =?utf-8?B?R21XbFk1dkVVYzMxT1NwdEF6SHdKclZGcU9JR29WRTNUZWxKREF2NkovY1dh?=
 =?utf-8?B?NG9KVnNqSXRyOS9YelZzcWdnWmpucC9sVHAzV2FvbnA2Y1pHbnVLZnFzeUpQ?=
 =?utf-8?B?dm9MR1NvcE5jazJNMmJQUjEyYTRMd1FuSnZvOWJEMFkvSFdiWW9PZjZDTVlX?=
 =?utf-8?Q?WKGUwK1Cx7tbG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEVhMGNaejZ5S1NJdlc1eEhYMFdFdzk3L2hURjdhK2FITG82dlJGWEdGamZa?=
 =?utf-8?B?dTJCY2FGYit4cjRrSXJOcktrNGdySzJ6WW9JeXVIdllWSkVqcnpPeURaOU1E?=
 =?utf-8?B?cEFkelNiNG9Nd0hvZTRzTHM1NW1ndkd3VHFkVWp5M3k0eFh4VHdsR3o0U01E?=
 =?utf-8?B?MS81elVEV3FjbnZKaE9mNmVhemFGeG5yRlV0aHdxcm1TUkVzaDZDODJndFNV?=
 =?utf-8?B?dDZHZFVXK3FkYjhPMkVCS1JLcTAwSkRFRUpKYWxjT29NMS9yMkMwNHFsWXp1?=
 =?utf-8?B?U2N3d1R0WXpKdnNWdGE5aEpyNVd1dit1TDd2dWFpVzZ4K2JZSytLeDFrR3Bt?=
 =?utf-8?B?UDZtckVQOWkyemdtN3g2SUFHT0pTMGFCNk5iQTVNWUIrTHovckhsczFBdUVV?=
 =?utf-8?B?NlZyVWtQeHRGWUhqazhTc2ZIVUd4Nk9UeVY0MUN0TklFZTlUbTRIMmRpV1Yw?=
 =?utf-8?B?eU5PV1drSENrUVJVSlV1cU1SMmlJQTVaaWFsQUhwUndoWGUrUGZkREtGNE9P?=
 =?utf-8?B?QjlPVmE3TkdSaUhtc3k2V0dqd3VYeUtvZ3J1azV1RER3QktUckdWa2tNT1Zj?=
 =?utf-8?B?Y1VKeE1RVG8rZ3Z3bjVFSVE2RUt0UWFuYjdXUzVVdGIvRHNtTTRTbjZjdGJ1?=
 =?utf-8?B?TSswc3F4bGJjSlhrNWNqRGtaOE5lendNckJYN2g1OThUTlYrUU5ZeXNHVldR?=
 =?utf-8?B?c0MzVHpLUDlFbTFLSUhSaGprdFBGN0tSYWNGOU5Xbms2eEppNkR2bStIQXMr?=
 =?utf-8?B?bit2VUN2S2FzelhpN0FnbFZXMDV4b3FqZDdpUEdZYTdITUNMR2dmQ3pZQitz?=
 =?utf-8?B?dmYrYk03dGw0TkNGeW5MMk05SjFsMlFLV3pENldCOGh4WlpYRjlnZDNwWGNh?=
 =?utf-8?B?U09nVHk4VU50K1ZDZ0d4MGRDS0lwaEpFbGphYXFhODU3d1VsdVFSekhKdk1X?=
 =?utf-8?B?T1YzT2Y0MTIvU01mWUJGRWt3WmpnMml6U2xwLzhQenVjM0t5Si9oZTArSW9x?=
 =?utf-8?B?SG4wRlBPSE0vVHB4NE5MQzNYR0hmd3BMaGVXbUFkVDBQbVZoL1B3UVVqTisr?=
 =?utf-8?B?M2F1WWlPSlZWeUN5WHVTL3dSUnYxM3R0eFhBUGRuZlY1THNLL3l0YTZyUFNy?=
 =?utf-8?B?ZloxZ3NzTWwveFRPSEp3eVI4U3NxYjdCOWVaMHJjWC9UVjVHN1ZJelg3L3FC?=
 =?utf-8?B?ejEwczFHbnVsQ3kvMFhnckVremwwS0FVMFZMSEF6T1NibjdCeTNlOGtkVWVw?=
 =?utf-8?B?bHJ5anhFWWhYQUlhMlFab2RvaVJTT3o4bTFWN1ZTV2ZtZ29GdUdRSE1hQzJM?=
 =?utf-8?B?MmI1S3Y4VkhpZHNVMmdtMWNSN1U0b2w1NTdFMVJkWHNjeGtyQVdKV2s1Ulhy?=
 =?utf-8?B?MGFzK1RTeTErNlZtUWloWkM1OHAySlBiRi9Qc1hWd0x0ZURrS3NONE9yOStI?=
 =?utf-8?B?aG80Rzkxc3BuYjhuMEZYSis2d0hyQ3JoRmY5cytnU3l3VnN0bmlQeTJocG1i?=
 =?utf-8?B?alBPaS9yd1lpYXh2NjcwSFVhaVE1NjdDM2Z1MnhMY3NOSWpvMHJrVGpOeS95?=
 =?utf-8?B?TlhVNkJHR01oOEQrN2FjTnRzVUg2Wmd3VmFBUWhPdTdFUVR0L2llanVhYWtB?=
 =?utf-8?B?aDVlRGxZTkJSZ3lKSmpMWEpqcitHRHdJanlCa01HbXNVZjRJeHVuVGZ3NDcy?=
 =?utf-8?B?N2pBS3QvN1F1QytYMVNheUVOWHV3Q1JpTmUzcmsrRm9yNzEzVU00VG9vTVpj?=
 =?utf-8?B?SUlqVS9GZHd5TjErRElUNWlSNzNKa0p6Uzg1YVIvWGo4cEtLVnVRMTFJaHdJ?=
 =?utf-8?B?SWlnRGpkWmJXZklmZi9DVXp3TmxJVEFuY3ArbGtXUzlJU0FFY2JndWFhcENz?=
 =?utf-8?B?aEV6QVZKSVd6Ri9HVUlrU0VSSFA1c0NDcCtzMDRDZDdjOTdsVFBMZXNISXhO?=
 =?utf-8?B?SitiRU44MTJoTlFhZUt5b2ZsSy9Ud0RIK04rR0xYVEk3LzJGdVg0T0szRnRy?=
 =?utf-8?B?RVp4WlFLam1YbkpjTmlTbndTSk1YVS9JSVFCb3gySDIwMC9KOUJxdjE2N3BL?=
 =?utf-8?B?czVaeHo4MVFTQ3RhZWNjUlVuU2Era1FCSWt3R3pEcDhPNEgxYjlyR0t2VnZu?=
 =?utf-8?Q?4YrC22UzFuHkgN69ak0ISQ+ll?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46782234-7ddb-44f0-7656-08dd4ba7e5f1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 20:57:44.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jc3oPxqfN+SByPAJy1NSiEVf0xr0kYAZT8PVk+8ARc1WjfSNQqMnvRcr0j6Eg7g2efXRQ0X1qayTXJ/eLZGMIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374

Hi Dan,

On 2/5/2025 2:58 PM, Dan Williams wrote:
> Smita Koralahalli wrote:
>> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
>> CPER records. Introduce support for handling and logging CXL Protocol
>> errors.
>>
>> The defined trace events cxl_aer_uncorrectable_error and
>> cxl_aer_correctable_error trace native CXL AER endpoint errors. Reuse them
>> to trace FW-First Protocol errors.
>>
>> Since the CXL code is required to be called from process context and
>> GHES is in interrupt context, use workqueues for processing.
>>
>> Similar to CXL CPER event handling, use kfifo to handle errors as it
>> simplifies queue processing by providing lock free fifo operations.
>>
>> Add the ability for the CXL sub-system to register a workqueue to
>> process CXL CPER protocol errors.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> ---
> 
> This patch confuses me. The plumbing to route CXL component error
> records back to the cxl_pci driver was motivated by the driver having a
> significant amount of context about component state and code to handle
> OS first reporting of component errors from the device mailbox.
> 
> Protocol errors are different. They implicate various ports where the
> cxl_pci driver may not have any additional information to add.
> 
> I feel like this patch makes more sense after CXL protocol errors become
> a first class citizen in the core, and that generic CXL protocol error
> tracing lives in the core, not a cxl_pci driver callback.
> 
> So, similar to how aer_recover_queue() traces all PCIe protocol errors
> and optionally lets endpoint drivers recover the link via
> pcie_do_recovery(), a cxl_recover_queue() is needed. That would be the
> place to land general CXL protocol error prints and optionally call back
> into drivers to add more device specific color if necessary.
> 
> I am ok with the CXL core centralizing all protocol error processing
> like the built-in PCI core, but the generic CXL memory expander driver,
> cxl_pci, is the wrong place to handle system wide protocol errors across
> all device types.
> 
> I expect this is new infrastructure that we will get from Terry's
> patches, but please do challenge me if you think I am missing something.

I agree. I don't have any specific reason to place all of this in 
cxl_pci driver. Given that CXL protocol errors affect multiple ports and 
should be handled centrally, should their processing be placed in 
pcie/aer.c or pcie/err.c?

Or would it be better to introduce a new pcie/cxl_err.c file to handle 
all CXL protocol errors separately?

Additionally, since the patch involves calling CXL tracing routines, 
some integration with the CXL driver is required. Would you suggest 
handling this plumbing within the PCIe error handling core, or should 
there be a specific callback mechanism into the CXL driver?

Thanks
Smita


