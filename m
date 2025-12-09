Return-Path: <linux-efi+bounces-5829-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19606CB1357
	for <lists+linux-efi@lfdr.de>; Tue, 09 Dec 2025 22:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B76D8300F8A1
	for <lists+linux-efi@lfdr.de>; Tue,  9 Dec 2025 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252852C158D;
	Tue,  9 Dec 2025 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xrOZl11v"
X-Original-To: linux-efi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1C168BD;
	Tue,  9 Dec 2025 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765316177; cv=fail; b=OnYVocfsGuWl/BGA1j65DS1WpWbBt5jbOn9hFvD5KxM2xwztO+qsIePNd5SVT0WztvwjilmhYVU2CKJIh6TzmYeDR4geZDYmyhcZA+u2XSkxHyc5Hl65VCbyNNSbWbC4nDkcNTycwn967S5LC/w4tvJ+YXQF2yDEaXOxswDFC4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765316177; c=relaxed/simple;
	bh=gGvn38aGMt28snUTbrcx2p99YM28vqodxI32DCWSRQs=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pmMYLVh6l58TfMiJGe5JAfFnbYYN/VmxR181jJgfoYu3iLk/qWsgKhglmVX/Zuq3f94vtRF2BAikA5tW5zKIceH6d/IurEQMjM7feQ/RMFaPAlbb9H72VAhXNFB6XJ37pHIdZsH6sU3lYkxP6ZZ8rh60/sRPqe5wrU7upy45n30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xrOZl11v; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqss3Pp3kcy5McHRKCFpJUMBWTQqTIhFGKyCBCqba25nSv8N4ct9uMR518SJdo6fiXn87ZV4KwGqwflJ2qK6YWo3rDE80WnwBg+KDzyVWZVwyHUhoXeE0HHnVeh1giAXDHPlPFUcpD/ZL1OPMJKz3PpxOCX7aYvuRHLX1ufkpdpSzw0j0f9TkJGIFDdZZYREXOtk1yTiH/azjPPkS7s6YOMkoalvg0pzNqq1k0eMrefqeUrakCknkr5Y0y4Htt9v5xkc+dD0etm81YsDJe9FNFM+APkDM3wpj5SvIBN9qF8vT+Sp6QgtQ7kzjLSjmcxmvYtmnp232lxBjxRA/8st6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeI7UCLvYSgKRyeWIa753no/nA1OSiw9bEr9mhAQCJ8=;
 b=qj+N2I5NsQ1gWaE1TAQvKFAP+6ZdQWSYbjcLwG6sBfCcRlaU4tqsKL8tuQkzxH9U+YLJjXo3FkHdYs+5GSojddRhSTDtiwvi3gXHjLrbjilYd6ytSkF56tfuJBBAudwqhU53yLNty2pdmJ0o8hDUGq4gPoLQjLtX20HRTSgXIn6iNGjKdxQawHEWWc0OTdyPlw2423DdQmkwbtTHv3Q7N/sw82Ofg1K+O+9KLIOYRwKVzZ4LWiG/fLs6zp8KEGwNc5hA/7TrjmajSrwDlLeAw/SWFRDMjI2ikJKXtXi2XAjoPa+fALNewiNVvlPRUNZ6P8wdFl9BCg3tZf5iyN+K/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeI7UCLvYSgKRyeWIa753no/nA1OSiw9bEr9mhAQCJ8=;
 b=xrOZl11vBEZFkWPZ1/mfAMMxeREx6oEU81LGmAZOaRroCRTRBMfYfK2zgernvuXB3+v4yVCwSbqw6L4FuWbHG9thglJ8tbvluNQtbrQSbWzOo52Fb0mISZe4pBaCmoaYkvvvo+QQA7Ep4HC/1L1JN9D0hVqZUGrAT90i8J68eCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 21:36:13 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 21:36:12 +0000
Message-ID: <a7ac1f74-32a6-41d1-82da-b338c127fb2e@amd.com>
Date: Tue, 9 Dec 2025 15:36:09 -0600
User-Agent: Mozilla Thunderbird
From: "Pratik R. Sampat" <prsampat@amd.com>
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org,
 linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, kas@kernel.org, ardb@kernel.org,
 akpm@linux-foundation.org, osalvador@suse.de, thomas.lendacky@amd.com,
 michael.roth@amd.com
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <ac479414-e0fa-49be-8a30-8f9c0e7b7d32@kernel.org>
 <73a69c03-feda-4c56-9db1-30ec489066fb@amd.com>
 <938a7948-7882-41a3-926b-3d2a8d07620d@kernel.org>
 <89fde0fd-57c4-4146-82fc-a4c1a56e74ec@amd.com>
Content-Language: en-US
In-Reply-To: <89fde0fd-57c4-4146-82fc-a4c1a56e74ec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:806:a7::14) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b50b7f-1c8a-4e3b-64bb-08de376af97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDd6VVYvZURGSDZtMlNtL3MyVHpncng3VWNMNGlsWEIrRlNtd3RCOTZodVhL?=
 =?utf-8?B?MGZLNTc3UUJqNER5VUNqNDBKSEJJZkgvR2lsM0tSNEpud3pQd3pocGM5aFRV?=
 =?utf-8?B?M21vcnJUeWc2WlZDc2g4SmMwR0xzRFB1cW0xU1RtWGxUNkdzYXVIaDNQdGUx?=
 =?utf-8?B?T0cvYWtJZkYwNG5NakkzY2VON1R4bWxDNUZUWlAxVE1TcitUUDBsL3ZwQnBL?=
 =?utf-8?B?VllXQnh2blN6MXByQmExUDRmVDhlQnhVYjRQSURnQ010aGFHMjNvaGE5bURJ?=
 =?utf-8?B?d21obEs5ZWNyLzhvWUEwZXRXTWNsajJPcjdKdFNhRjNPeTVjS3FsWmNCb2M4?=
 =?utf-8?B?N0g4NGpEYjhLaVFEQ3dhTkpXbGJWaE5kblRVSVRVNWZ2YjlLN0s1VUhkYk9j?=
 =?utf-8?B?K1N3WjdZYXpoaC80czAxblVQakFHQ1V1S01KVUg4T25lTFdqSVcyS2djYUxC?=
 =?utf-8?B?aEdReEF5T1pLNTF5SzVqY1JITjRtajNMZk01QTF1Z0RSdDhoODU0VHZmc2k4?=
 =?utf-8?B?dDFxNlVSWWp5bi9VdDY4Y2lMM1pzWWpPckhNeE5oejVqTm8rWVRnM3NHSU9x?=
 =?utf-8?B?bHMvV1dzTmsvanJUV2pVYmtEQXZqZWp3ZVNJT0wxVTIxeVZ0WW92ZCtsMmp2?=
 =?utf-8?B?ZGVaTFpsMUFnL2FwakoxN2ErendqeDVCb3UrSmJaZERBNWZQdEVSR3lpVnFl?=
 =?utf-8?B?RVFseVlESmdWaEdxTk50VUsyQTZRTGx6ODZVZCtONndEMUxYNDUzR2xhdXgv?=
 =?utf-8?B?WndEaWhtdjRKd0dZZVNhc2NEV2FWZmFyNk45SWw3aFV6ZU1hK0JqL3VJc05U?=
 =?utf-8?B?T2ZJTEVxU3NIUVlVZ0NQZVdPZzZlZUtlejVodHlJYkFKcjB0RTRCYUE5NE0v?=
 =?utf-8?B?VVhYa2lvZjVTM1RoZUlHaUxpREdrT1F3Zlc3dkZWTDR3elpGZHpKV0g2MVBU?=
 =?utf-8?B?WjZ2cVRwUDZsdkhjczhDN1JXbHlKQ0pveVhMU0ZvWGZtSGJiRE03R2l3Lys2?=
 =?utf-8?B?OGNHSHhneXEySmFucnBoWFZpSHJEVXlzUjAxK0hTVDA4a3BGL1dsUjAxazlT?=
 =?utf-8?B?dDVIZ2lNcnB6RjREcGxQUWl6OXUwL09YYlZxOTA3aUVNeFVrZ2p6OU9NQjc0?=
 =?utf-8?B?Zjd4eHhqRE1aQjRSL2RyRk1hYUZ5c1J3b0doK2p2TGtGM1NEU1BrVDlGODdV?=
 =?utf-8?B?dGVIUnNEQVlKREFScFlHTkszR1ArY2ExSWRhay9GLzRjSCtsbWhiOUtaekgw?=
 =?utf-8?B?d1duMkVJeW5ydGNlVEIvVEtYOXczU2dQVXFrUDlQdlplUDlRK3R6RFVRL1Uw?=
 =?utf-8?B?OGt6TVpQR1hqbWIreFVMN3dYWjU2TS9rYS9rNkJVVmp4bk9USFB5OXkwZGE0?=
 =?utf-8?B?V3VIa0FQTVVxTGV4Tjk1TnBYN2F0KzI2SVJFSXJNaWZaVWE5QnVDeDdXRVlw?=
 =?utf-8?B?ajAyRDRzOG5tNzVpdmRkbDluOWZlbUVLcVUxamVtemVmMG5BTkdMbWdCZGo5?=
 =?utf-8?B?U2hkV1loWWFTTVdjMzdITHBTaFBYK3A2UUY5d3B1VVgrdnNnUEcvRXBRVmE3?=
 =?utf-8?B?VXhYVkl1b1BRSjlRVm5sVlR3Mmp1K0NXZDJkaVVPVlVkSk9iVDZJUFlqM2NV?=
 =?utf-8?B?RTd0a0tlTmZPa3RLZ2FOY1p4RnNRTE1uOXBHWmpJMUszeit0WkkxUHJodUhN?=
 =?utf-8?B?bkY1c201bFRQTUlrcGZGcERmKzRIR3oyWi9obm8xOEVyYmFoRnJMMzAxRzJ3?=
 =?utf-8?B?ZElvRlQwbFNpOTQvcVdKOHQ0YUx3SnFqakNxaXFhdGtVYmJvMTZFRG5ndHVY?=
 =?utf-8?B?K0NjWkh5ZlN5NE9QRnNRZy9JemxWc3E4aXE3ZW85TkU4WENrdDVsRzBrYmNr?=
 =?utf-8?B?NCtCcTVYTEN3ejA2WVduRmtlQng5WkZZVVZKKzh1azRvVTB4QlpyL3BCZ3c0?=
 =?utf-8?Q?BCwjM+5y6QPSVarqtQYp4aIz+4+soJFc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUNSaElmSU03NUN3MjlnQ1dqZ2xYRHdSNE8rU2dhcWpSSkI5V3U1UXlnTXpy?=
 =?utf-8?B?cldkNkRqVmRkMWg3S3pkWS9EOW5KU2IrajZzMCtXZ0grVTMvekdLZzFwZDlY?=
 =?utf-8?B?MDVyZG81WHJOZVAxMkZBRFUyR3p4cythZWlhSVlIa2NMaHR3SUJZY3AyNFUv?=
 =?utf-8?B?c2VEZlFUSmpWb3dZcWJpbFpNeWcwNytMYWRZNlV1NWEyYVo2L3BuY1BIRXBt?=
 =?utf-8?B?WnFFUnR0akJVZVdjNlEreCtTYmtTTWQrdnNzczNxREdlR0FDSjRsZUVSYWd3?=
 =?utf-8?B?Sm44dHdqZUc2N0lsMEpDNWp1eElCQXk0bkdGNnFRUTJ6RE9FbFdTaVFZU3lC?=
 =?utf-8?B?c3JwY3oybVozd3BhZ3pGZE9MYTNmNlRoQXhoWTBuMmRBT0RHQ2xRVWN6em1w?=
 =?utf-8?B?L295OTY2MFg0U2RuQjhtYnQvVjQvSFhkZDB4TWFDRDZNZmx3ZGlCaWcwQkcy?=
 =?utf-8?B?MENtYXlBSUpDclpzVEJ3dDBZdWZGZ3R0c2g1bW45Y1FUOVoyZU5hNVJCZjdC?=
 =?utf-8?B?MFJZbC9KNFpseUN5QWM4SlJzeVRZbGdNeXBVMlhURzJPTEVybG03MVU5WHdp?=
 =?utf-8?B?UGcxNWJ1TGdpa1VwL2RSKzdoZURIV29LM0ZnRlZCM0JwRnNKdlpiNkYxbG1W?=
 =?utf-8?B?Vi9uYTZGR1NidEk3TkVIVTgrMEduWVZsVEY5L0dia2xYUG45Y2RSWmN6dE4x?=
 =?utf-8?B?ZUphMUVoaFo4V2pTbzVHN214NkJRNTZBaXlsMVpFcEpCY2ZoeE52SFNKbS9Y?=
 =?utf-8?B?R0ZzanppUEx5dWJXbUVWRVdyT01ZTUhXNitZUzdrZDkvQ2ZPb3Rsd3plcXdF?=
 =?utf-8?B?bTgxRStsUVl5RFBwYm0xL3czUjdnUWdOajJEUm1YaVZ0OVc1RDNkZFBOTHBv?=
 =?utf-8?B?bWdvMjVzck5NRGxONHNHSU9pRVo4ZEh4R1lEekdna2trbDVmc3VkWWYzbGpP?=
 =?utf-8?B?bXFzM3l0NHBHUGhWMzhJU0RpNVZHSHdoS1oySmlkUzg4UDZzREpXMThjcXdQ?=
 =?utf-8?B?dUlQL2xxRkYzRmswY3JBYUNDUnMycHhWc3laa21NQjRYZnd5a0lsR214cWRv?=
 =?utf-8?B?MnhzS1ZaYlFIMS91ZDdHUnJRc051K3N6cXVjd0F5WCs3ckRERjljR1ZCQS80?=
 =?utf-8?B?c0JBb3F4c2hOWVcvWTNoRytmNDRYaUtkTldrOUNTVFhmL2NrK0VCRjZrVThH?=
 =?utf-8?B?RnY3N0dZYk1IdElhMFowQmUwVUJLbHlNbElOYU5uZ2pSMG80cHBpRnI2Ync0?=
 =?utf-8?B?QkZ3cXZwaTFwYlBkVlFmcThnK0JaUHJYcklmSzlZcnBRMm9PbFpmNG44d0N5?=
 =?utf-8?B?U0hCYzRVaDZHdEx4c1ZtWllrcCs2VXM0YmFXb3BGcktJdTFpTTgrc05iZDV1?=
 =?utf-8?B?RkJrNjZHaGFjRFdCTDVabHlRb216aGg2bUJ2SHJBWE9rcHBjcXVvOUJQaXBk?=
 =?utf-8?B?cmFudHVFcnEwNnZzdW5JUTZ2SjdVZS94M1RNM0VJWjlVU2pqb3NpVnZjeUJR?=
 =?utf-8?B?cXNHNTNMakxGMzd6YnQxR21yUUw1VnFZc2o1OWNPajFGUnF0VE5JN0J4K3Zk?=
 =?utf-8?B?NjBFU0xFN25TeDdtdzJOV2k2MG0yMzdCMUQrWStUYUU2NDFJMGVZc25ZMWtX?=
 =?utf-8?B?OUNoM215Y251RE05cW9wUTVmRkVBQWswMkpidDBRcXhRVC9OMUNkZm1vV255?=
 =?utf-8?B?SGtTdHNjN3NrNXA2RlFlU1Rsc25FRjAyNzIyS041bERRckJZR3FSdnpyQzV2?=
 =?utf-8?B?Zmkxd0gxQUM3QWRGeGhiWkdudHdYTTdCZ1JZZ3FhaEdnNG1uUnEzQzdjSml3?=
 =?utf-8?B?Z2sxQTdJTWUwSUpMaG9hNHhFZkRHN21jVTRwK09sL0MxbDkzWmJsRkZxNmFk?=
 =?utf-8?B?aWFIRVJIZ2toNDNLZnVvUVZRSGpxTXBidlhGZENqa0x5K1VPRjNjTWo4ZExD?=
 =?utf-8?B?eGdhZHdMU0dnQkwyT2hmVHBlYlVweFY3THZkMlc1Y05GcUIwZHN2VzhxTUZS?=
 =?utf-8?B?RUVPWGRidnVST29EUTNiWmVEeHgzSmYzMFBBbUtiZVhiSGR4MlhXQ2tVZ1RK?=
 =?utf-8?B?YWhUeVp5dWpsYW5lb2FDWVNjSkRFakdsLzhFT0ZPRmwvc0VHVHZXK0JoeUN1?=
 =?utf-8?Q?x5FjjKKXGiFdeIIXlotxIpL3S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b50b7f-1c8a-4e3b-64bb-08de376af97a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 21:36:12.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUF0D4bkuCJLU7DKCoSpIgdR8eozeil81QHhL40LQZ0dKQhI3kCF9iHvlq+nPu+jLxQbJB8geCsP+/g1wmuf6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073



On 12/1/25 1:35 PM, Pratik R. Sampat wrote:
> 
> 
> On 12/1/25 12:36 PM, David Hildenbrand (Red Hat) wrote:
>> On 12/1/25 18:21, Pratik R. Sampat wrote:
>>>
>>>
>>> On 11/28/25 3:32 AM, David Hildenbrand (Red Hat) wrote:
>>>> On 11/25/25 18:57, Pratik R. Sampat wrote:
>>>>> The unaccepted memory structure currently only supports accepting memory
>>>>> present at boot time. The unaccepted table uses a fixed-size bitmap
>>>>> reserved in memblock based on the initial memory layout, preventing
>>>>> dynamic addition of memory ranges after boot. This causes guest
>>>>> termination when memory is hot-added in a secure virtual machine due to
>>>>> accessing pages that have not transitioned to private before use.
>>>>>
>>>>> Extend the unaccepted memory framework to handle hotplugged memory by
>>>>> dynamically managing the unaccepted bitmap. Allocate a new bitmap when
>>>>> hotplugged ranges exceed the reserved bitmap capacity and switch to
>>>>> kernel-managed allocation.
>>>>>
>>>>> Hotplugged memory also follows the same acceptance policy using the
>>>>> accept_memory=[eager|lazy] kernel parameter to accept memory either
>>>>> up-front when added or before first use.
>>>>>
>>>>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>>>>> ---
>>>>>    arch/x86/boot/compressed/efi.h                |  1 +
>>>>>    .../firmware/efi/libstub/unaccepted_memory.c  |  1 +
>>>>>    drivers/firmware/efi/unaccepted_memory.c      | 83 +++++++++++++++++++
>>>>>    include/linux/efi.h                           |  1 +
>>>>>    include/linux/mm.h                            | 11 +++
>>>>>    mm/memory_hotplug.c                           |  7 ++
>>>>>    mm/page_alloc.c                               |  2 +
>>>>>    7 files changed, 106 insertions(+)
>>>>>
>>>>> diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
>>>>> index 4f7027f33def..a220a1966cae 100644
>>>>> --- a/arch/x86/boot/compressed/efi.h
>>>>> +++ b/arch/x86/boot/compressed/efi.h
>>>>> @@ -102,6 +102,7 @@ struct efi_unaccepted_memory {
>>>>>        u32 unit_size;
>>>>>        u64 phys_base;
>>>>>        u64 size;
>>>>> +    bool mem_reserved;
>>>>>        unsigned long *bitmap;
>>>>>    };
>>>>>    diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
>>>>> index c1370fc14555..b16bd61c12bf 100644
>>>>> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
>>>>> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
>>>>> @@ -83,6 +83,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
>>>>>        unaccepted_table->unit_size = EFI_UNACCEPTED_UNIT_SIZE;
>>>>>        unaccepted_table->phys_base = unaccepted_start;
>>>>>        unaccepted_table->size = bitmap_size;
>>>>> +    unaccepted_table->mem_reserved = true;
>>>>>        memset(unaccepted_table->bitmap, 0, bitmap_size);
>>>>>          status = efi_bs_call(install_configuration_table,
>>>>> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
>>>>> index 4479aad258f8..8537812346e2 100644
>>>>> --- a/drivers/firmware/efi/unaccepted_memory.c
>>>>> +++ b/drivers/firmware/efi/unaccepted_memory.c
>>>>> @@ -218,6 +218,89 @@ bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size)
>>>>>        return ret;
>>>>>    }
>>>>>    +static int extend_unaccepted_bitmap(phys_addr_t mem_range_start,
>>>>> +                    unsigned long mem_range_size)
>>>>> +{
>>>>> +    struct efi_unaccepted_memory *unacc_tbl;
>>>>> +    unsigned long *old_bitmap, *new_bitmap;
>>>>> +    phys_addr_t start, end, mem_range_end;
>>>>> +    u64 phys_base, size, unit_size;
>>>>> +    unsigned long flags;
>>>>> +
>>>>> +    unacc_tbl = efi_get_unaccepted_table();
>>>>> +    if (!unacc_tbl || !unacc_tbl->unit_size)
>>>>> +        return -EIO;
>>>>> +
>>>>> +    unit_size = unacc_tbl->unit_size;
>>>>> +    phys_base = unacc_tbl->phys_base;
>>>>> +
>>>>> +    mem_range_end = round_up(mem_range_start + mem_range_size, unit_size);
>>>>> +    size = DIV_ROUND_UP(mem_range_end - phys_base, unit_size * BITS_PER_BYTE);
>>>>> +
>>>>> +    /* Translate to offsets from the beginning of the bitmap */
>>>>> +    start = mem_range_start - phys_base;
>>>>> +    end = mem_range_end - phys_base;
>>>>> +
>>>>> +    old_bitmap = efi_get_unaccepted_bitmap();
>>>>> +    if (!old_bitmap)
>>>>> +        return -EIO;
>>>>> +
>>>>> +    /* If the bitmap is already large enough, just set the bits */
>>>>> +    if (unacc_tbl->size >= size) {
>>>>> +        spin_lock_irqsave(&unaccepted_memory_lock, flags);
>>>>> +        bitmap_set(old_bitmap, start / unit_size, (end - start) / unit_size);
>>>>> +        spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>>>>> +
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    /* Reserved memblocks cannot be extended so allocate a new bitmap */
>>>>> +    if (unacc_tbl->mem_reserved) {
>>>>> +        new_bitmap = kzalloc(size, GFP_KERNEL);
>>>>> +        if (!new_bitmap)
>>>>> +            return -ENOMEM;
>>>>> +
>>>>> +        spin_lock_irqsave(&unaccepted_memory_lock, flags);
>>>>> +        memcpy(new_bitmap, old_bitmap, unacc_tbl->size);
>>>>> +        unacc_tbl->mem_reserved = false;
>>>>> +        free_reserved_area(old_bitmap, old_bitmap + unacc_tbl->size, -1, NULL);
>>>>> +        spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>>>>> +    } else {
>>>>> +        new_bitmap = krealloc(old_bitmap, size, GFP_KERNEL);
>>>>> +        if (!new_bitmap)
>>>>> +            return -ENOMEM;
>>>>> +
>>>>> +        /* Zero the bitmap from the range it was extended from */
>>>>> +        memset(new_bitmap + unacc_tbl->size, 0, size - unacc_tbl->size);
>>>>> +    }
>>>>> +
>>>>> +    bitmap_set(new_bitmap, start / unit_size, (end - start) / unit_size);
>>>>> +
>>>>> +    spin_lock_irqsave(&unaccepted_memory_lock, flags);
>>>>> +    unacc_tbl->size = size;
>>>>> +    unacc_tbl->bitmap = (unsigned long *)__pa(new_bitmap);
>>>>> +    spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +int accept_hotplug_memory(phys_addr_t mem_range_start, unsigned long mem_range_size)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
>>>>> +        return 0;
>>>>> +
>>>>> +    ret = extend_unaccepted_bitmap(mem_range_start, mem_range_size);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +
>>>>> +    if (!mm_lazy_accept_enabled())
>>>>> +        accept_memory(mem_range_start, mem_range_size);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>    #ifdef CONFIG_PROC_VMCORE
>>>>>    static bool unaccepted_memory_vmcore_pfn_is_ram(struct vmcore_cb *cb,
>>>>>                            unsigned long pfn)
>>>>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>>>>> index a74b393c54d8..1021eb78388f 100644
>>>>> --- a/include/linux/efi.h
>>>>> +++ b/include/linux/efi.h
>>>>> @@ -545,6 +545,7 @@ struct efi_unaccepted_memory {
>>>>>        u32 unit_size;
>>>>>        u64 phys_base;
>>>>>        u64 size;
>>>>> +    bool mem_reserved;
>>>>>        unsigned long *bitmap;
>>>>>    };
>>>>>    diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>> index 1ae97a0b8ec7..bb43876e6c47 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -4077,6 +4077,9 @@ int set_anon_vma_name(unsigned long addr, unsigned long size,
>>>>>      bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size);
>>>>>    void accept_memory(phys_addr_t start, unsigned long size);
>>>>> +int accept_hotplug_memory(phys_addr_t mem_range_start,
>>>>> +              unsigned long mem_range_size);
>>>>> +bool mm_lazy_accept_enabled(void);
>>>>>      #else
>>>>>    @@ -4090,6 +4093,14 @@ static inline void accept_memory(phys_addr_t start, unsigned long size)
>>>>>    {
>>>>>    }
>>>>>    +static inline int accept_hotplug_memory(phys_addr_t mem_range_start,
>>>>> +                    unsigned long mem_range_size)
>>>>> +{
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static inline bool mm_lazy_accept_enabled(void) { return false; }
>>>>> +
>>>>>    #endif
>>>>>      static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
>>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>>> index 74318c787715..bf8086682b66 100644
>>>>> --- a/mm/memory_hotplug.c
>>>>> +++ b/mm/memory_hotplug.c
>>>>> @@ -1581,6 +1581,13 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>>>>>        if (!strcmp(res->name, "System RAM"))
>>>>>            firmware_map_add_hotplug(start, start + size, "System RAM");
>>>>>    +    ret = accept_hotplug_memory(start, size);
>>>>
>>>> What makes this special that we have to have "hotplug_memory" as part of the name?
>>>>
>>>> Staring at the helper itself, there isn't anything really hotplug specific happening in there except extending the bitmap, maybe?
>>>>
>>>
>>> Right, we are extending the original bitmap and initializing a structure
>>> to track state as well. I added the hotplug_memory keyword without
>>> much thought, since I didn't see anyone else attempting to extend these
>>> structures.
>>>
>>> That said, I agree the name is awkward. I could either come up with
>>> something different, or we could eliminate the parent function
>>> entirely and call extend_unaccepted_bitmap() + accept_memory() directly
>>> from add_memory_resource(). Similarly, we could do the same to
>>> s/unaccept_hotplug_memory/unaccept_memory too.
>>
>> BTW, can't we allocate the bitmap based on maximum memory in the system as indicated by e820 (which includes to-maybe-be-hotplugged-ranges) and not do this allocation during hotplug events?
>>
>> If you search for max_possible_pfn / max_pfn I think you should find what I mean.
>>
>> Then it would be a simple accept_memory().
>>
> 
> Agreed, I think Kiryl was hinting at pre-allocated bitmaps as well.
> 
> Since, the overhead to do this upfront is fairly minimal, that should
> certainly simplify things and have very little to no meddling with the
> original EFI struct.
>

Taking another look at this suggestion, I think there may be more to it
than I previously thought. Parsing e820 tables to know what the range
are for allocating the bitmap to cover hotplug may be difficult. For e.g

[ 0.000000] efi: mem110: [Unaccepted <snip>] 
range=[0x0000000100000000-0x000000017fffffff] (2048MB)
[ 0.000000] efi: mem111: [Reserved   <snip>] 
range=[0x000000fd00000000-0x000000ffffffffff] (12288MB)

Parsing of the ACPI SRAT seems to be the one that gives us useful ranges
to base the upfront bitmap allocation on. e.g.
...
[    0.018357] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x17fffffff]
[    0.018781] ACPI: SRAT: Node 0 PXM 0 [mem 0x180000000-0x2ffffffff] 
hotplug
This is also where max_possible_pfn gets updated to reflect this range.

One potential solution could be to parse the SRAT during unaccepted
memory bitmap allocation in the EFI stub. However, this would fragment
the implementation by duplicating the SRAT parsing. Alternatively, we
could keep the current approach of dynamically allocating the bitmap on
hotplug or I could also replace the entire memblock_reserved unaccepted
table like Kiryl suggested if we must absolutely avoid changing the
unaccepted structure?

--Pratik





