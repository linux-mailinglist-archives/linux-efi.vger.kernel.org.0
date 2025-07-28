Return-Path: <linux-efi+bounces-4489-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2802B14040
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jul 2025 18:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3047A12BE
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jul 2025 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2E121018A;
	Mon, 28 Jul 2025 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CEl80BV6"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8C1A254E;
	Mon, 28 Jul 2025 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720019; cv=fail; b=X6sCFOF7Vu45XDPexSDAMNRCc1C3j3uUsn48og0dBY7qi6lXfosnKA/hfwBlrk9RGKwBac7k/cNVpeGlooVBuJFJx0/uo+UVSNHT+bT8TbbYCs7D2YF9yO8up2NlRSN0FTzkYFwKsMv7cpe4Os4VTmXjkfAnltLPrzIfkdEq9OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720019; c=relaxed/simple;
	bh=ey21RX5tvmgD3gJPRXySOEuXo705mdzarcuuLvAupxo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PLJDkgyUCYR8nzfEPvPgjWtWeFPu4MPo28BrIXKWDaJyfr4o172ZMbW46fj65KZYkfvRTZ7Tq8Oi3GRhVYx+kbo+PIr8IIADXEXHwl50Vkp4UnqXOi5wJZ56ZiXHa7H5crsmikJktdm2MVC/B7kH6Lc4q4Ci7ONMQmhE91zXov8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CEl80BV6; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJJXaJfOIyGDA1dmJSJqEwam6CeE4pNXr5CssQV1hxDBku8fvZvCDeWA60kXGkH6oVEBlEzmWy4GEQdjxZ7bnyfGSQQOY4Ww8SyMscvf/Mr0Dq8JsXe4Tda0BnPQJaeS65b2Is0rfNXfTSiaeO9vRJCgSWc7U9He5BDzGxMsOHBffLTi7FOJSQjU5kK4PqDKua0ZLBGTDCHvT6K7ITjqyRoqdG4T2K1gpxLUkCEnxny/mOe5FsYZw/i+V3KFGHJdPKpAl+jf7J+yRUYeBc1Sr45uQ4J0pJz+mdkqXhyQ1vXSuulpJ/PbBtmyrrwiuBooFgDVynldgvu9nhf7acdT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpHkCqOJCwTXGAOmcdSDeKQH3Blc3Ff3IAD6/LtOmRA=;
 b=tN/DTGAg0CdD/peNrN1w3dp3plncC1ICzPr5aHt3NW9r0Vwy6UA+OB5kXr7H1/VC67FhEzBhKZN/Nnc8ZYb6eEfFHxWbN/NtF65xOOXOq+HJeTjAugysqDo8IwkNDF8+EIguigq7BC94AaCi3GtqmZd3FPrGIKAK+IZI8Vk8HbxFiRh7w5kAL6qi1Gj8C1HiLY5JxwJ/4O2EQcbyXnmAxrjey+5rSa+K0AiHHC47pKDmM6+uXR8ZpwEC4zeLgGJjGg5ck7YhpZn3kAWVsRYrxFtAJ9eHsxiC0HGFqlzCDqb5DvDl/F3mRcFN/ocSe1qmcwISaEANfxZBvDWyPx0LcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpHkCqOJCwTXGAOmcdSDeKQH3Blc3Ff3IAD6/LtOmRA=;
 b=CEl80BV6fyhcAxuBsnB232ovbErJ8HiiwDs1YXZVlWX6BCGXnuM+raxxeEhoaNrnWncZCNn8e5iZ85N3jaVpQh9Je6iOlaY/bF8thv1+d+g4FjCoimgKiu/2c3PlaS4XylUWNPk5rSNwqiNP3FgwQ9HZhB0QB4NB1fpyC2m0COY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::991) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Mon, 28 Jul
 2025 16:26:55 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 16:26:53 +0000
Message-ID: <dfc6cedd-c125-4201-a98b-cbaa84a4f370@amd.com>
Date: Mon, 28 Jul 2025 09:25:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: "invalid agent type: 1" in acpi/ghes, cper: Recognize and cache
 CXL Protocol errors
To: Marc Herbert <marc.herbert@linux.intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, tony.luck@intel.com,
 Gregory Price <gourry@gourry.net>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
 <074f5f77-7bef-4857-97fe-b68ee9b0afaf@linux.intel.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <074f5f77-7bef-4857-97fe-b68ee9b0afaf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0081.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::15) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: 1631365c-cfa8-44c1-deef-08ddcdf38fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?USswZGEvRGZseW9NNVh0Ymk3eXVlRUE3WG9zcWUwVW83cldFeThtQ3hpbkNS?=
 =?utf-8?B?SEFvdlBpcHhWR0FlVXJzOURhMzZqY3pvWUpHbStiRGlkaXpHd2xFMWxpeUhB?=
 =?utf-8?B?NGFJV2t6aEdYYjNCdktldFVQUmF0WENUeFk0VHkrMXVVTklsM3AvcHZRS3pJ?=
 =?utf-8?B?K2ZUeVRmV2JMbWlkNGQzbmVZVEk2RWJpenRKSlRadm43VlJieXJ6cU1zUVBH?=
 =?utf-8?B?bUNVc2d6Tm5rd0dJMjdwaUE4dzE0cHg2eDcyWktscEFTK3c4UUVQZXNtTEpt?=
 =?utf-8?B?TnRTcGE3MndFSHJUYkZvM25CL1FCY2p0WjFVQzVCQW5ycG0vWFNubDg2Wm81?=
 =?utf-8?B?STdEZDdhczZGbWhjZGFOSllOYnBZNzMxeGtvYUtBdy85dkdTZlE2OWxPa0FN?=
 =?utf-8?B?b3dUZUFiU1BYYTFMTUZhSW5GQmdjZVUrTkJ4Q0JhL3FtYTBLT0I2YXo1MHBB?=
 =?utf-8?B?b0draXo2enQwTjhmOWgxb1d3cHVkbVp3U0lrNERpa0JUY3BOYlhkdFYyc25Y?=
 =?utf-8?B?QXczNE9QU1BMNUdIMG8wOEJPVS8yd2RIeTdOY0JFSGlLTWFObHJyY3llZHRE?=
 =?utf-8?B?b1orbDdyVVB3UUFWR2huSUZkaGFDd3BqeUNMdjdDeDQxSkZxUUV0ZDNSNjB5?=
 =?utf-8?B?Z0VVOXMyMTFScUhrK1dhOS9sREF6dmtOb0VOeVN0dGkyY0dyQkoxc0MrZjI2?=
 =?utf-8?B?eVBkZ0RNSW5sdDhkS0g0WUhkUTdOajk0MlNpRW5VcDNteDF0Y3BzdHdkd0Q2?=
 =?utf-8?B?MUpQeVJQaTBTaEt2MU5zUnJrMWprc3dOZWs4VXhZRmVnNmZiVVdoTFVRVHhs?=
 =?utf-8?B?NVpVZVhvTkRrc3FhdTJjanYzOE9aaDFXa29pRUpmdzR6MzYrZk5xYksxYzVw?=
 =?utf-8?B?SExYazRKd2t0YlplOTZKT0RYOTFTazVHL0RmMzlBa0NpSm1MTTN5UWFLa0pI?=
 =?utf-8?B?eWNwZFdDZm9XQ28xSmt3WXZEY0xRZTBxTzk5TUFrY3N6cG4vYVlFNWlHWjJX?=
 =?utf-8?B?MllGcy8rS3hoaHBhelJSeWFOaEdDSkpoNjJoTzNHaTg3c2ZMWXl5bXFpdE5J?=
 =?utf-8?B?NnBJOE9KUmF1Mzk3VVZhTEw2WXBtdXk5U2VzTHJpTlpvSllFRzlGL29SUFpD?=
 =?utf-8?B?OVdVNHlYUHdoRFhqVTVWbXJEMzhiOEpadU54SG9wM0g5WnJWenJTS0FHdVFN?=
 =?utf-8?B?NVVPdGFRaGdiUWhpVlRscERtU2NtS3g1d3J6a1UyZy9NTllueGY4cU1YTTN0?=
 =?utf-8?B?akFXaG1PWGpoZ1p5NW9UR3FkdnYrOWN6aXFzVVJoR1ZGYm1GeDVVTFl2d09S?=
 =?utf-8?B?aXVCN0RrMlN3Y3Q4SjloTlVGRmIrckxQd2Ricm15bWhlUTJuOWh2K3FPb3ZM?=
 =?utf-8?B?UTUxZ0JUSW4wOHpBdG1obXhkb0JtU0R0cmtTTll0Qld1eGtMSHFsL0sxQjA3?=
 =?utf-8?B?Y2xnMGtmamFpVVZxak1jekZYUVNZS3lvZnc0WWd3aStjeHhoZ2JkQURFbHVq?=
 =?utf-8?B?YXcxRU00UERwOEhhYXlaMXVUNVorOEdjZTNxZkZtRGx4TzY3Z3h4Z2R5em5j?=
 =?utf-8?B?SzQ4TW40bGtHM3RhTzc5SjlVM05mbzZEOUpHSFVkOWovaXNIc1BoYUIra3h5?=
 =?utf-8?B?YVBac1JIY3RzRGp4RFZwUUhVUjEyb0hYNzQ3NU5RSmpybzFsNVhpa3QrMUdz?=
 =?utf-8?B?Y2d3NjNXUjNaeHZhT0V2VCtXRVJjc3ozZXhSaFFmQjBoY2xRNUJIaWU1QVpI?=
 =?utf-8?B?cnJhRk9CQzRyKytHa0lYK3ljWjk2SDJ0NzU3TCsrZWJmUGtjTkNuanE5N3BV?=
 =?utf-8?B?L211NitENTZrWHc2bUhaK3l0eTBEMTk4d0VwTmFuVk1aZmZ5Yk15dlhyd3RP?=
 =?utf-8?B?eUx6OTZlQXpXVGlUTHhPb3ZrV2tyd1V2bXZqN01zYW8rUFFEa2J0KzBWODlj?=
 =?utf-8?Q?+JICfg/BoSc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTV6SDRCd0JnRExPbkJIVStvczVTck5TM1QzdVZQY0pPM012clFtc1ljYVE5?=
 =?utf-8?B?YkMwTzR6c1NxMkVEZmdMa1M5REtNMUdsNmhoSzY2d2dGbGZ2VmhWbHpwZWd5?=
 =?utf-8?B?c1FHR3ljUXQvamthVkRZenAzZGZWZ2l2Mm5vNXQ0MGo1aGtEUkM4bWdGSnRn?=
 =?utf-8?B?ajR1WnVjVzRmNkdLemN5Wkp6OFJxY1dwYm8yWWJNbHg1OHl3eUd6eEdyWlA4?=
 =?utf-8?B?MzA0VFlIeWFnQjR3SFhadW0vcjg1bHU4NURoUHIySTFZNkFlaEVRMitlbTZX?=
 =?utf-8?B?ZWFKM1lMOTZsbHdrdXRFU29DRW02eENqMFVlZEs5WVdEOUhiSHNsa3ZYVnZm?=
 =?utf-8?B?L3RIT1FmU0NVSFhzdGY0N2FhZUI1ZVNwYU1QRWFGWm1oQ3FKYWxHa2tBRHlz?=
 =?utf-8?B?eGZFSWVlWllmbWtJdjNISTBIcWZsbjdwZ21lM2dldHRpKzc3d3daWTU3dlFi?=
 =?utf-8?B?UkpRUWozS0hWNndVWHhuNlhERG1BekdTYnZJL2pHc2R0ZWJrWSs0aS83clNk?=
 =?utf-8?B?Lzg1ZW5DR3UxeXJLUlBNTG9yY1RkT1hyRkp3RnVIN0pRZDhQLzVXemZTTDJU?=
 =?utf-8?B?cXZDV1ZGMWI5UTJuOHBMSVp2OFZnS2cvd2h1dUh1SG1WeFpNK3RJWXgxSzl5?=
 =?utf-8?B?NTBiTERrNUpEbnFPd01kakxmc3BtdVN2dDE2MkxDSnZ0SklyR3F3OFJQc05m?=
 =?utf-8?B?QTRUUHNoM3pqdk8wamNDN0wwekJaTEgwUDlwaUFpR1lEcFRXM2tQVzFGbk1J?=
 =?utf-8?B?VlVPa1RBOHB1TVJiZUNxb0dxY0Vnek5CSE5mVmhMWWdDUDdETWJYSXpnSnRV?=
 =?utf-8?B?UnRqOFNsK0VoZ2xXTjE4dEllYXBCaTRtdkx5bDFpK3ZYYUVSV2NXTEc2ejhX?=
 =?utf-8?B?NERVSFdhZWY5T1VvRGt2c0p3bi9YaHY3a1lsRjdIUXJIYWdWUDFyTGIwNWNo?=
 =?utf-8?B?M0U1N1BPVHBLYUI4czUvYU1nQnM5S1RiWkoyQUNLeUV2OVNPdERPMVdVMjVS?=
 =?utf-8?B?Tm14WFVvUk04anVDWGdVdEt1b3pwekpUSzQwR1A0QWN3NUFwcUU1WlNKQzVC?=
 =?utf-8?B?RHcrMldoTkx3aUZtelJ3YWFrQWN0TWpjN3EzZzl5N05UYmhleEwwbmNCWGRE?=
 =?utf-8?B?YUlYWnYrTGRUSHFlZkVDcFdTeHdlajBDVHFWRzA2azE3ODZTclFRRE14YkhI?=
 =?utf-8?B?ektEMFZPSU1Xbmh5K3JsK01Zc3d4MEdTMUdEY2VIeTEzRGdDN0J1MnlVeE1N?=
 =?utf-8?B?NnlNU1llaHJBRTllWDNSV1gyN2ViaWpIazFvMU5IYkxOS25ld1NtSVppNDZo?=
 =?utf-8?B?c1VwSmhTOWh5cWlXSStST0FrcXp0M3ZSNitoVnRBSktPSXRKY3YzSDRpSzdx?=
 =?utf-8?B?MjlUbmMwUmVUUThrMFBZQTc4UGNTWVVudDZ4bC9mR2tQZllLS1ViNXM4ZnNH?=
 =?utf-8?B?Z05vNkpaUlgrRkcwOFJKQXYzVGhyTlBLZUlXdFFNbVh2UHBYOUpLekU0R2xP?=
 =?utf-8?B?SVUwRExKMVlPNi9TTm0xbSt6RzI3L01PeTkxNWQwTlJWS0l6UTIwclV1T21N?=
 =?utf-8?B?UmJzTEQ5a1ZUUE5tdHUzcVA4OXkwcHBISDQ1NU1KVXU2Nm50RWtoNVB0QjNB?=
 =?utf-8?B?dVdDTnJnNENuVHJUZk9yMVZYbllOMjRHcFpiY1pZbE10NVFUYmR6TENZWGFw?=
 =?utf-8?B?MzBramJCOWhsQ0hpYVNXcm5CaHBqZEtGaXVoQVlackllK01QWDBJUjlkTCsw?=
 =?utf-8?B?RzFnZGZUL21vMHlCTjUrWkFCRmJWaHY2NE1oZThpY1BqSXdYMXB6ckpJQ2xw?=
 =?utf-8?B?MXIxZ1p1TFMrc3IvbzY2M0pCQmpna1RKbWRrTzBUM25hdmlydmtyR3JZcmtm?=
 =?utf-8?B?K3J1REloT3YvVDg5N0cwekU4WDhyQUJZWThnWER3UjBwUmw1TlFtQnhLQmNx?=
 =?utf-8?B?U1dpVG5IYU40clVpSWpyelVvZUx4bDlXS3dzMDFGWVRFVzZRUkc4UmU0VUQ2?=
 =?utf-8?B?YmhVSUNQelFPb0ZNUlB5UzJYU1Y0MllVekF3cGJ0ZGRTc0UwMzZ5ZkNhcy85?=
 =?utf-8?B?MkU3VG9hS2JmSG5zVUFsL3MyK2JmanRaU3FHZTIwL0ZSVmVTODR2aW9TZnYy?=
 =?utf-8?Q?qmrQ/bLELS1FasubKXujOYnU0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1631365c-cfa8-44c1-deef-08ddcdf38fe6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 16:26:53.5637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGzAZEOh8mTUnuT8Kr7rTy/L8PAPVc7uHsxehTrJmNa0xwSysVUiNEZ6rsD4jMXiP4DxKFtded159JmDt/1vKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70

Hi Marc,

On 7/22/2025 12:24 PM, Marc Herbert wrote:
> Hi Smita,
> 
>    The code below triggers the error "invalid agent type: 1" in Intel
> validation (internal issue 15018133056)
> 
> It's not clear to anyone we asked why you did not include RCH_DP in
> the `switch (prot_err->agent_type)` in cxl_cper_post_prot_err() below.
> 
> I can see how RCH_DP is special in cxl_cper_PRINT_prot_err() and I can
> even understand (despite my near-zero CPER knowledge) some of the
> special cases there. But in cxl_cper_post_prot_err() here, it's not
> clear why RCH_DP would be rejected. Could this be an oversight? If not,
> a comment with a short explanation would not hurt.
> 
> Marc
> 
> PS: the newer cxl_cper_post_prot_err() code is longer and does
> something with `wd`. That's irrelevant for this test case since the
> function errors and returns earlier anyway.

You're right. RCH_DP was excluded because it doesn’t report a valid SBDF 
in the CPER record. Instead, it provides only the RCRB base address.

I haven't thoroughly investigated whether SBDF can be reliably derived 
from the RCRB base. There might be a platform-specific mechanism for 
that, but at the time, it seemed non-trivial to implement. Introducing 
additional infrastructure solely to support RCH_DP felt like it was 
adding more complexity.

I agree that a brief comment explaining this rationale would help. I'm 
okay if you plan to include a fixup for this along with the one for the 
device serial number.

Thanks
Smita

> 
> 
> On 2025-01-23 00:44, Smita Koralahalli wrote:
>> Add support in GHES to detect and process CXL CPER Protocol errors, as
>> defined in UEFI v2.10, section N.2.13.
>>
>> Define struct cxl_cper_prot_err_work_data to cache CXL protocol error
>> information, including RAS capabilities and severity, for further
>> handling.
>>
>> These cached CXL CPER records will later be processed by workqueues
>> within the CXL subsystem.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 54 ++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/event.h      |  6 +++++
>>   2 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index b72772494655..4d725d988c43 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -674,6 +674,56 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>>   	schedule_work(&entry->work);
>>   }
>>   
>> +static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>> +				   int severity)
>> +{
>> +#ifdef CONFIG_ACPI_APEI_PCIEAER
>> +	struct cxl_cper_prot_err_work_data wd;
>> +	u8 *dvsec_start, *cap_start;
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
>> +		pr_err_ratelimited("CXL CPER invalid agent type\n");
>> +		return;
>> +	}
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
>> +		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
>> +		return;
>> +	}
>> +
>> +	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
>> +		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
>> +				   prot_err->err_len);
>> +		return;
>> +	}
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
>> +		pr_warn(FW_WARN "CXL CPER no device serial number\n");
>> +
>> +	switch (prot_err->agent_type) {
>> +	case RCD:
>> +	case DEVICE:
>> +	case LD:
>> +	case FMLD:
>> +	case RP:
>> +	case DSP:
>> +	case USP:
>> +		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
>> +
>> +		dvsec_start = (u8 *)(prot_err + 1);
>> +		cap_start = dvsec_start + prot_err->dvsec_len;
>> +
>> +		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
>> +		wd.severity = cper_severity_to_aer(severity);
>> +		break;
>> +	default:
>> +		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
>> +				   prot_err->agent_type);
>> +		return;
>> +	}
>> +#endif
>> +}
>> +
>>   /* Room for 8 entries for each of the 4 event log queues */
>>   #define CXL_CPER_FIFO_DEPTH 32
>>   DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
>> @@ -777,6 +827,10 @@ static bool ghes_do_proc(struct ghes *ghes,
>>   		}
>>   		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>>   			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
>> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>> +			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
>> +
>> +			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
>>   		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>>   			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>>   
>> diff --git a/include/cxl/event.h b/include/cxl/event.h
>> index 66d85fc87701..ee1c3dec62fa 100644
>> --- a/include/cxl/event.h
>> +++ b/include/cxl/event.h
>> @@ -232,6 +232,12 @@ struct cxl_ras_capability_regs {
>>   	u32 header_log[16];
>>   };
>>   
>> +struct cxl_cper_prot_err_work_data {
>> +	struct cxl_cper_sec_prot_err prot_err;
>> +	struct cxl_ras_capability_regs ras_cap;
>> +	int severity;
>> +};
>> +
>>   #ifdef CONFIG_ACPI_APEI_GHES
>>   int cxl_cper_register_work(struct work_struct *work);
>>   int cxl_cper_unregister_work(struct work_struct *work);
> 


