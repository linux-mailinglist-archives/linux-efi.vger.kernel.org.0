Return-Path: <linux-efi+bounces-3355-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29859A923EE
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 19:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948481893F0F
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 17:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882412550D2;
	Thu, 17 Apr 2025 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AOPIUXLJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A314F90;
	Thu, 17 Apr 2025 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910788; cv=fail; b=U3UXFpZ3jkfR2ViXQAgEgEQ0MrQCPGC4dwf9APqWcvKPN2sebGC2N1+gS7jCaubwSO5zuS/lW2kxcDzN5S4uxW2E3oYFyY9wtofKESZ39m0/pT+J3p9PLo2aQyN6NF+OHs4Fg3W3nHVQLkU1cBAS+GtrzXrIGPNpzgNdV8xxn50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910788; c=relaxed/simple;
	bh=U0/uTWp37k5JmT9yp70okt/nHk+M2HYHxb6WN5pkVFU=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=iqMhKv19MR8oR+16XoFYgR6moYNn7WfNujlii13c4GI4yNBXerk5FqaZm2VbyhQ0po2O5oOUwLpAriq58Nmjcd6Pzk11Bzg/dSD2UMkN2TyWdY7Fr/jBCoGtexL/JPhgW2F2CwUhCBoOWAqyTieFV7gE1V8jwuR7teY1kTWpdFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AOPIUXLJ; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGiYogiMtDQal/eFtD36+s2zbWPUtNap5Kkob6Dc7/gepQQD9jMPup0wG4nneQpC0t7efvrjizqRE9GumYdhVAqVGO1C1ppqCxsGdf9ZdIf86Z+K0VH7ZRX2u9j5VnieQYS2AuhQ9U1kfTTnApT/u5Tn0dZYAp6wAUcE3XghVg3kYJSQIPhr6pzJ2C5BDX/ovuzQnsmma1MJLwiFeAO8/AKVQhus5paVwk1bguuo/+FrguCnQdihwFyAvh1G2Jr8lqKHSr83vkq/0+HJMaGuyR1o21Cyt3XHnH0GPx1QTsxl6h6o4PSCX6xD0cwpFsDmkl2qp5vqJDNRT2KCiZkwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBezDr8VvXVsSGcWALQBUZtqji28RAgJwS4sKkOLBLw=;
 b=sNPfQh+1fC7fiqo+mSXTyJiezuRyzgiLIbKr24TwFpyJTzumKoMBk9iWF/wjuTS0+vPD42wDjxtXptocxTMXvwokyGVrn0zcB/g/rZYuJ827j6xFJeQNNoaipKE43PaLBRrmU+bDdQHzzkBlnXLpyS7v+6roOhcNr5jqOYkSNpx8QOONvrcLOsfmzxkiHrWRNTCI+uVRglTwgpSBRfTQzJ03SB+Uvek1pTSz9T60/eIeebytlv3V3ihvwHSXSLdbs2B0Dbbg7DKZJZ4CkqkLW/Ji5GxbtutXLJUGPgfzHOkx2rYgyXmQLEi9mtx3Gw/StaLhD3AqyA9iY+o/JBX+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBezDr8VvXVsSGcWALQBUZtqji28RAgJwS4sKkOLBLw=;
 b=AOPIUXLJCrLZ4iSET7T0wkauYESOLxMPEqvDaAu1aytKJHq6cfUDNaXUuK0Xl0jInHbEiDGlOY/CIAF9hc7Ca9MTLHUo5OsRvqyvkwpcXpksyCDWMbBN/LbHZpYyvQ622M1FzpZs32+KgksUDBj50zRY4MuXqOPdm8UDz6bocJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 17:26:24 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 17:26:24 +0000
Message-ID: <3196bc53-cb39-5501-b585-de175eed83af@amd.com>
Date: Thu, 17 Apr 2025 12:26:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>,
 linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20250410132850.3708703-2-ardb+git@google.com>
 <20250411184113.GBZ_liSYllx10eT-l1@renoirsky.local>
 <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com>
 <3f2b0089-a641-1e0c-3558-0a8dc174d1ec@amd.com>
 <CAMj1kXGvLQwea2J0E72tMhY-9iDCTmQm3drrHCTLyZ=hCP_iAg@mail.gmail.com>
 <96762dec-616b-b906-02b3-e006d43a8535@amd.com>
 <CAMj1kXFVeygkdnhtkGHsKfRgGXoMRpdjQ-wTO1RBLU_wERs_=Q@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3] x86/boot/sev: Avoid shared GHCB page for early memory
 acceptance
In-Reply-To: <CAMj1kXFVeygkdnhtkGHsKfRgGXoMRpdjQ-wTO1RBLU_wERs_=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0122.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::17) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 503201bb-12aa-43e8-c74d-08dd7dd4fa1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2ZWRkdyb2lzWm9USGdzcXRkL3d1Zit3eVZiYWduWFdjMWR2ODhoL01qYVZ6?=
 =?utf-8?B?RnZyVXJ3TE85aFRaRjNUeXZsTE9ySlVoS2pOdDRhdm5wcnRuQ09QdWpidjJO?=
 =?utf-8?B?ZkpTTVRZZEFWMjdYRTViWmpoaklFUUNuQlhINnl5Z1Fwc0xLamR3QUtqLzky?=
 =?utf-8?B?K3ZpbU5xUmZ3aFNieExpczJKQjFsSmgzcWRRbmdNR2YwNi9FVDNiakhHZUFM?=
 =?utf-8?B?UG5QYlgyZ2FKcnQwL1hzYkNUSUFnaWhkcXJ1OXlEOUlFTUs1d0pVUGlJTXV4?=
 =?utf-8?B?SFo4TWR6d3hJdnlpWG1FN0VTOWlNK0hweUd1alFZU3lJakJhTkQ3UUQyWlpP?=
 =?utf-8?B?UXZTRXhJdCtNSWxOSjR0Si9PNUxWd29VeEZicG52N1NnZnhYVjRkdDZvUGVr?=
 =?utf-8?B?QllDN1BFSXNhQ3ltK2tsVWxkSFRLSC9UTXpFQUZmTFp1Vlp1eVh2NE9ZOWc3?=
 =?utf-8?B?ZU81cmdMYUFFWHQwQ1I4ZUdLem9uRGMwald0QlNqVW1LWXRteDIxTnNRUE5V?=
 =?utf-8?B?WkFYRTg0SnlxMlpvV3d2OFdCNEJtZld5WENSYzNFODQ4cW9KU0dvZDB6Q2tE?=
 =?utf-8?B?akV6b2NNRS80VVJub3Q4cU5HdUEzWFgrZ2Z3TUhQMlExQ2N5WXY5MDh6cVVs?=
 =?utf-8?B?SUhCTHVEK3QrQmFkQXdUS1NXbGNIVWZMd1BBRXBBZnR0WlVMSmJzQXQwQUhU?=
 =?utf-8?B?WU1COW9vcGhTTEhsdTRQSU1iNGtPUnlmUFZGTVlnWmZONVR1Q3FKYUZ2cmdT?=
 =?utf-8?B?NCtTL3hHWGtUNXRjZ09nSWIxVE91WGZzandyRmc4eGYyYWYvVUFqaXVUd2FZ?=
 =?utf-8?B?QlpKRGk3UEJ5RmxSUkUzNlZTQU5iMlEzRzdOelpXUGcxYnYwLzB2bzMyK09m?=
 =?utf-8?B?bGVneEE5U1kvMDBFQlY4ZWh1SDlqNzlPcSsxcXRJbE1mblNWdWJlQWdHa3ox?=
 =?utf-8?B?OHlIK2xkdzQ4Vk9SZGFhcU1KUjBPeDNEbDNPbTZRVXhRZE1TZ08wZmpqTGF6?=
 =?utf-8?B?VnA5TG9OTldXWVQ4T09nbWNOZldtbVM3UDAvek9BNXkyQ0k2cnRIRjJ6UjVK?=
 =?utf-8?B?MCtrV0k2L0crTTFNZmltUTExU0VSaHN3ZUlLWDh6Z2srRW8zaDNRcTAwWDZM?=
 =?utf-8?B?UEFvOFRNNGxGUkRpV2JHRnVWeUNJVlBaRDNTRUlUWWlEZkdqUElwM3FUbm10?=
 =?utf-8?B?S0RjODBPU1FLU0V1RXQ0UFIvNGNtaXBJR3UzZkRVblA3aDNxbVJzVHhodU1w?=
 =?utf-8?B?UklHdmhuL1FvLzZSek13ZWRjc05sb3VheXRPVW5DNzFrdFgzOTg0aVJEa1o5?=
 =?utf-8?B?Umk2ME5aU2RLdXh5R3o1K1l0cUtGVkU4d25XbmhXcjMxVXpYbXo0YkRLY2R0?=
 =?utf-8?B?M1FsUE4vcno5Ym9DaTdVWmJuNGh0alAvbVRVL3RyTSt3VlJINGdET2xOcWVY?=
 =?utf-8?B?QUc4TDNvZjRJK2lPcE9JZUZjbGY1N1VMQnpuMFYxaDJleklIaWEyY2RsWmdS?=
 =?utf-8?B?aWVRa29yVU9iL2hBdDVaRlpGeVhtb2R0c0UvaVJjTUFsei9KVzRSbHZBWTd2?=
 =?utf-8?B?eVFYcEI2RXJqV1hEdWZYcUR5cGFSenJlMW0wSE1peVgxaDR6U3JlcmlKSFow?=
 =?utf-8?B?dldud1cwbWdTRXdWZi93YjRlT2IwS0w0ODN3SGtUYkVQdExKTlNVNGdOQ0dJ?=
 =?utf-8?B?TnplLzVJQkszR3FUWjY5bnAxWTFhaHM5SHpOQU9OS0F2SUg0c2MyT2FkdGZU?=
 =?utf-8?B?SHY1TTgvTjI0M25QdEgyTG1TT2dFS041UGJYRWt0OGxiQU5YbVRWM2d0cnJm?=
 =?utf-8?B?WHU1ei8xOFlOdS9sOG5uL1dKT0huMGdrYmh3dzYxL0JKSUdnejdqYTRid3Qy?=
 =?utf-8?B?TnJoaGNyM2VDMXBQTEpKQWNMTFJyMHBXZ2gxcmJPSHhkMzQyZ3VMZ0gxSTBZ?=
 =?utf-8?Q?2o+OWvlT86w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnA2ZkczNll6Q1pqSUJVRi8yR1pHK05ORTNmbEl0Y2p2NVpIaTF1M1pDV0xo?=
 =?utf-8?B?Tk1TOVZUcnFFZ2I4NThvaUFHOVlCMG5NZ1VmMkh6dTZ2MFByTGlXWTBteFpq?=
 =?utf-8?B?c1dpVVI0ek0vWFU2ckI3akFRQjJDdExyUEZrVTBaY3RNVFRveThhWit1ZmU0?=
 =?utf-8?B?aVZTZGRkb28wcEtUcUdaOFovWEpGR3YvbTF2dmVEWFNhVHd6akFRVzNtbVNX?=
 =?utf-8?B?Nm92YVI4a0lrWEtmU0pNcHd5aFgrd1ZuZ1R3cjN1dnhrMGovNWJ6dTErdWFI?=
 =?utf-8?B?ZlB3Q0tCRkEwWDBKWHZlQ0gzT2VMZzZyQTZEajZZMVVBa29oa0I5YWhXd1Rx?=
 =?utf-8?B?VnYvaC9MTFJwekdZN2ExdnR5ZGlQcFhXbTN1SnViZzhSRThjb3BxdG8xUVEv?=
 =?utf-8?B?eXVkelZVbkhZaGJjb3RjN0dmSmNHbHVrbUU5cFYveTJGbi8vb3hrS04venR2?=
 =?utf-8?B?MzFURHpydEk2Q2JuRU9tQlBYZFNOdjBBdW04WmdJZnFQNEpJSmI5aVBudjdQ?=
 =?utf-8?B?R296b0ZxZ0NxY1RZMVNTZjUwRFlHcDhZYTRVRUovVmo3TDRPcWxtcmFlUjJl?=
 =?utf-8?B?UTB6K3UwODdsV29Qa1lTK0txL0ZISmN1MFNweWRHRGc5TmJaYkxCUFV3eE9w?=
 =?utf-8?B?ek1rK2MvU3NXSURDTlQxMUtndUJyYUt5YndRZmxBUzdidWttWUlIVkI5UWdN?=
 =?utf-8?B?RE5aM3pmMjJ6KytTWi9XZUZ3bEc3Mmwwa0E2Z0FLc2dxU0hqa1FWKzloZnBY?=
 =?utf-8?B?cU9BSE80RUFkOEFRaTc2SHdGZVp0YS9WaTYvT084T0xsQnFEWDVqaS9sZG5B?=
 =?utf-8?B?Q0lxUTRmMkdMWVZoR2xHUDM2VHRqN0JuWGpoZ0liUUJWUUhXQkQwSmFFZ01U?=
 =?utf-8?B?OWxCUVdncHRQeEdONDNiTlBWWmpkc0U0Rm1NOG0wZFE3MXovazdtMXJsNFFJ?=
 =?utf-8?B?a0U5c1NmT0VuZVJ2U2UxSDlDWmYyanNOZ0xZNkhUeDhZQ1ZCaFN4Q214N1lv?=
 =?utf-8?B?cWlTalJwNSs4d3pLRzEwMkx6UzVXekxFZEZxdGRyZndtZEFpNUhLb3R5N3NO?=
 =?utf-8?B?VXQ5SEhZRDVEdUtEb3gxMmRXR090bXNjTURpOHdiQWpqaFM3VkdILzZsVWJh?=
 =?utf-8?B?YmI3OGJvYWNPRFNMNGp6WCtzL0l2c3BxeXdnRXppQlZBdVAva09pd25nUHRP?=
 =?utf-8?B?K00zVlZOOFdMK1ZERGsycXdoTEZKZ1ZIbFZlNkV4dzl3UHQzQm43WEtNeElX?=
 =?utf-8?B?RFBkWU5Wbzh1ZWkvZjlwcDZTc2FZbkxna1czeWFrbnJCaDBIKyttQWYxSE1p?=
 =?utf-8?B?empneENBWUl3aUFuWkx6ZUlJdjU1Z1pqbmZnWmc4NCtSS3BzSUVWTzF4bjhq?=
 =?utf-8?B?eitLaDdPQjQwV3hNdTR6UVg0NEgrV3lBaVlNRGwycS92VDMvYTNpOFpHRTZL?=
 =?utf-8?B?TXVmMWlSYXRMRG5vT1VXcURrdVRiaXRUYVZTRjFRMGo5QmxUODFOWE1mRkUz?=
 =?utf-8?B?d3FUSFB1bGRBV0EyM0diSFZ5Rmc2V0hHYlFTYm4rYU1MeWJYOHJtR1l5QVRs?=
 =?utf-8?B?WUlGbmVlSUFpRkxvTFlmaVlNSWZ6QnNObUNya1o5OHlrT0gxbkNiV1hxV21o?=
 =?utf-8?B?QmVFSXFDWTFXbVVxOSs2alRmSnlHTnhKdzEzR3VIdE1NYVhvWjQrWWZKcXBI?=
 =?utf-8?B?aFAvdTJHaEI0ZGpXa0Q1dUJDeG13Sk1PMTAvMkQzZy85RlZyQ09vZUZjb3Fa?=
 =?utf-8?B?NEljTkQzNnFCYUN1WHJ6R3VTZ3diRzQyNytYc3p5MHJiQ0VKbjNtdS9ib2hU?=
 =?utf-8?B?Uitzc3NWSWFkUnV6YWpma3MyRHFMSEVkYStDV2RXMWVPN1lodnd5YW96Rksw?=
 =?utf-8?B?VDJ5ekRiMGYrNEtzMWhyNUpRQ1VBWVliOEdxNlhUOXRQaGQ1TzVPSks5eXdR?=
 =?utf-8?B?UzdwVlhGQnhpTWVpMHRsaGRLeTlMNGhzN2cwSWlKRTFCdC9TYUtIYk15WWZp?=
 =?utf-8?B?ZTVYWGR3WnJsY2VpZFUydEw4S1EyODlLK3NKM0RzYk42VTZ1YXRNbERNbjJS?=
 =?utf-8?B?NWtPRXpINElwYzNNWVFqY21vcEoxdEc5WEF5VEpkSXVhQmtZSURucmNNOVdS?=
 =?utf-8?Q?rWvCkFdmt9xjAwLdTwiXCC0ev?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503201bb-12aa-43e8-c74d-08dd7dd4fa1b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 17:26:24.0735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4hfV7frNxX9iktalqjfvfFpghcGZnZbic7Fb625BQf9UV4zYvdUmdX4m6lxgDBO2rFP0HO1oWwYVNXwJAr3wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150

On 4/17/25 11:38, Ard Biesheuvel wrote:
> On Thu, 17 Apr 2025 at 18:21, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 4/17/25 11:14, Ard Biesheuvel wrote:
>>> On Thu, 17 Apr 2025 at 18:08, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>
>>>> On 4/11/25 14:00, Ard Biesheuvel wrote:
>>>>> On Fri, 11 Apr 2025 at 20:40, Borislav Petkov <bp@alien8.de> wrote:
>>>>>>
>>>>>> On Thu, Apr 10, 2025 at 03:28:51PM +0200, Ard Biesheuvel wrote:
>>>>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>
>>>>>>> Communicating with the hypervisor using the shared GHCB page requires
>>>>>>> clearing the C bit in the mapping of that page. When executing in the
>>>>>>> context of the EFI boot services, the page tables are owned by the
>>>>>>> firmware, and this manipulation is not possible.
>>>>>>>
>>>>>>> So switch to a different API for accepting memory in SEV-SNP guests, one
>>>>>>
>>>>>> That being the GHCB MSR protocol, it seems.
>>>>>>
>>>>>
>>>>> Yes.
>>>>>
>>>>>> And since Tom co-developed, I guess we wanna do that.
>>>>>>
>>>>>> But then how much slower do we become?
>>>>>>
>>>>>
>>>>> Non-EFI stub boot will become slower if the memory that is used to
>>>>> decompress the kernel has not been accepted yet. But given how heavily
>>>>> SEV-SNP depends on EFI boot, this typically only happens on kexec, as
>>>>> that is the only boot path that goes through the traditional
>>>>> decompressor.
>>>>
>>>> Some quick testing showed no significant differences in kexec booting
>>>> and testing shows everything seems to be good.
>>>>
>>>
>>> Thanks.
>>>
>>>> But, in testing with non-2M sized memory (e.g. a guest with 4097M of
>>>> memory) and without the change to how SNP is detected before
>>>> sev_enable() is called, we hit the error path in arch_accept_memory() in
>>>> arch/x86/boot/compressed/mem.c and the boot crashes.
>>>>
>>>
>>> Right. So this is because sev_snp_enabled() is based on sev_status,
>>> which has not been set yet at this point, right?
>>
>> Correct.
>>
> 
> OK. Would this do the trick? (with asm/sev.h added to the #includes)

Yes, that works for booting. Let me do some kexec testing and get back
to you. Sorry, that might not be until tomorrow, though.

Thanks,
Tom

> 
> --- a/arch/x86/boot/compressed/mem.c
> +++ b/arch/x86/boot/compressed/mem.c
> @@ -34,11 +34,14 @@ static bool early_is_tdx_guest(void)
> 
>  void arch_accept_memory(phys_addr_t start, phys_addr_t end)
>  {
> +       static bool sevsnp;
> +
>         /* Platform-specific memory-acceptance call goes here */
>         if (early_is_tdx_guest()) {
>                 if (!tdx_accept_memory(start, end))
>                         panic("TDX: Failed to accept memory\n");
> -       } else if (sev_snp_enabled()) {
> +       } else if (sevsnp || (sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED)) {
> +               sevsnp = true;
>                 snp_accept_memory(start, end);
>         } else {
>                 error("Cannot accept memory: unknown platform\n");
> 
>>>
>>> And for the record, could you please indicate whether you are ok with
>>> the co-developed-by/signed-off-by credits on this patch (and
>>> subsequent revisions)?
>>
>> Yep, I'm fine with that.
>>
> 
> Thanks.

