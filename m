Return-Path: <linux-efi+bounces-1893-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778DC98E8E8
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 05:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BCF283F92
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 03:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DF4224D7;
	Thu,  3 Oct 2024 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NW8NeFdb"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD76184E;
	Thu,  3 Oct 2024 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927133; cv=fail; b=rAKfmA5kq0b/MpXjqoBtZW03oE5FClfqM1mckDPxw5tf6OwTDTgv5oSXQHVencbyEB2s2Aprzus7tkAfIxWCs0tV41pFYYXFC7SUBDBsiAWaz8Ik0o3uzvJ6RJrNMIBidezzRPor/n7m0nAMCrdgcSB2MUqkmhaTiVgOZCGGL8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927133; c=relaxed/simple;
	bh=LJWCTo/iksYAQ1ZRRL8dSEKwM5L+5ui8lxbZ4QWanjI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KHkhijIOU1HtEdGTqtmN2KHfxI4N5CMZUfiLaGNzraZKEzwP6G1eibdMgyMbwxijbRt2k9r22cjOQBBNJOxfbxVytepUhoAa1bwKfQFo6VjFyxmIbZhmzlCkYyDjBg0HHsw6Dbr5OW+UGu5dpwYRgaT0wZnTQ/GFIx9H1b1SeBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NW8NeFdb; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeRrqylqzi1Osx7I8urufbN9Ac7rLq3xSD1VpsiyizCAgkXcKpE1WFt8XJNHwhUkNB9oB5Q1z6dmlC6bOeWvXuffwrkwfygcOGOyVYJ5ImQzLtljqOoMn5YI1MR1eBfi/ieQCRgtv8nXlE1uVMKtA3ESnBgUdcUSLD+WzuMr9PQNpbHRtEDS7dNG89a5aWPAFmPfQOsuEUhSoyM7ZJ05GSr4VOy4Xm5CQ21iHK4aa2gUVSHXe5yoCcN1Nqoqw8WFANuL+Ow18OL3cGhdK977Z57nW/aq7wk9K4P+QDTgR48jvz2S7c+CyoAfz6tEgEfpixBnffsSdr8V5G75j8fksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69DJ0VA6r8ERAZC7AVI1SfhuImr3btkh2zNxtZbABHU=;
 b=PJJO9q1NYkCAY1tNatY9QY7pxIAu0Gjn9ajvVwM9uooFbQAttIMBrgnAh4gZRB69WgyDAB6gHFxLGoGNcYmIoBv1ZObAxdUiMRVziMSxzKUMWVsdPHfbGCtg+d2H9HE2Y7wtZ6+zJI1Y/KwFuwUecbEX8EpAFoeE7518THMNXxiSScUvIO8C/ynWLvuXoBwDY4woekz0JvY6vpcYwfAXgwt5EXLEXY8qBXMYS2w4blMgsHLpBXKXDcwdQk3e01SNaHGN5qt/AiCiuUoAmT6oDYGaOV0AtNY97pKnpMnEiFjQzW5RPQRApQR9RpiwJrRukChGwDPVvK2S1sCWjN7+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69DJ0VA6r8ERAZC7AVI1SfhuImr3btkh2zNxtZbABHU=;
 b=NW8NeFdb3g2UBprNlitJNzXjoQs7uqo1VQDK/ry3zLnTtVkq54iQ/JmTdzDr9hseklFQfGJIz8CDqs/uQTszQgWs+gLB2FY56pwQUMfHWZ7a7JYLUaGMPK6Xy/2Y4tigoEb0fwcSXocMtyRyiRJF3Bzfp4SnaLjR6L2BlbO+gpqqboK8WFUnsV7CCe3x5IRfRahZgcVMF+jhwaPPD5mMY0RmdzmEEoJEe6+Z5ILuJhbrxs0Dgc10ZhMRlvrZMHedTwE+2CFPwJcoxayuW8I3jOquVgfD0XqmioNIr15I54Hl8j/f6e6sQBOt9oC4TcoSPgNy+ta90A0VxlS6exKwGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 03:45:28 +0000
Received: from IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5]) by IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5%7]) with mapi id 15.20.8005.026; Thu, 3 Oct 2024
 03:45:27 +0000
Message-ID: <1d88a9a8-c594-4474-ab85-1013e34deb73@nvidia.com>
Date: Thu, 3 Oct 2024 11:45:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] acpi/prmt: find block with specific type
To: Ard Biesheuvel <ardb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Matt Ochs <mochs@nvidia.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, linux-efi <linux-efi@vger.kernel.org>
References: <20240911155536.3900579-1-kobak@nvidia.com>
 <CAJZ5v0gQVPcmMNL4J7UskHsTx8vugJ6pZ_T=Ob3qjsrGmhnFAw@mail.gmail.com>
 <CAMj1kXH+xsEj6vC-+z=NcNyGNA6EVePd35iToLB-J-8LhKdD-w@mail.gmail.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <CAMj1kXH+xsEj6vC-+z=NcNyGNA6EVePd35iToLB-J-8LhKdD-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::37) To IA0PR12MB7579.namprd12.prod.outlook.com
 (2603:10b6:208:43c::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7579:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: 04eb7c5f-8d22-42b9-e650-08dce35dd1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWdyL1VOeUFKVGRzNS9tN0xCb3pVd29KMXRXdkJBWG5PNWUzRG1NKy9mQVJz?=
 =?utf-8?B?bVIzdDNQQ21MOFZEZkJ6VmlvdG9PWGNKSGgzclA1U29OTm9ER3MrT0djSjVI?=
 =?utf-8?B?S2p1Q1d2dzBqdFNwVVhQSXZaTVVQZ2R4d0lsSmhXa1BoQW1IOU5VMnZCODFP?=
 =?utf-8?B?OG9aNUR2R1ptb1ZHNUVnRFN4WjRKZFF4Sm1ZdjBhUVQ5bnFrOU1UUWRmWTR6?=
 =?utf-8?B?RytRQU5IaTZ5UmhBcDhackw5WnpOd2xEYXdFakVkYXllWnhhMXRPdHhvTUt3?=
 =?utf-8?B?RFI5N2VJS0UxVWlCSC9SaldSdUZzVmZKdVZkVStVRXZZV24yYVlrT0VJcVgz?=
 =?utf-8?B?WkJPbzhtYktLQWZCeG9wcmVWZGZuTDhUaitzNXFqYmp6QjFFRGxPZmJremJH?=
 =?utf-8?B?cHcrUjhBdktTbWNKVXd3VmlMaWZhc0Z3UUs2aGxUdytZZG5IR2dOcXlxRUxr?=
 =?utf-8?B?UmJkT1JYY1hLaE9nY0hyMmZOOXFKWUdGVEZSUUJCYVovSncwYlN6RVdDR1Q2?=
 =?utf-8?B?VDh6b21aRUhHREs0Y01CZkVOU1hEd25Lakx4aGlMMS8rTTJDQTdvS2NHWjRE?=
 =?utf-8?B?SHpZMGRhU0hhOTVSa0tWZExONExIVDNucTRsWVpqL3lnYk45aUorN211T1BJ?=
 =?utf-8?B?aHNHTE9iWXlTajdBb2ZKQytRQXdBTFVqNy96RlE1QnpNenc2RTBlbHJ0YXlp?=
 =?utf-8?B?R3ZVS1czUUZPT3hObGd0RjFncnE3NCtyT1h2ZElIR0N5MkNKdGpNd1AxTElJ?=
 =?utf-8?B?dEE3Yy9nM2tXcDlTSVl1VmVkdjFSL3FMSm5CeTltdG5PbXdQelpwaDZUbkJZ?=
 =?utf-8?B?MWF2RWZtUXU3b1k0ZHBCQ1pBMkpLdWxnOHR5SWI5aFR5em8rMmhhdGJ6Um5i?=
 =?utf-8?B?SFp3MVFXeHhCRHYxbFh2a2ZEVU9yTXk1bHp0VFZ3aEtRbFRhN0ZSeGNOUURI?=
 =?utf-8?B?amtCSnloaWNYUjdiR1BDdGFMVGJwVjVOZkVrTU5KeU05UzMrS1lva1puazdz?=
 =?utf-8?B?L1RmZXU5ZUwzakVLZXk5c0ZYZ3pmbWpvU3NEMHJnU28xVUVkeGRVWS9HdE5Q?=
 =?utf-8?B?NnEyeDFOOXVkR3YxWk9wRDhjNlFhYS9jcGRHYWI4R28yeWk5M3U5cjhvRXNQ?=
 =?utf-8?B?SGxKN2tZS2tmN3diVjlTRDVSWXlTaG9kMThwSWdqZzdlRTVJVkFMOG1ScldY?=
 =?utf-8?B?YUVkeXdBYlI4akFJRGhaQkZySlNwME9Jbm5ESktaNElTTzJlMzJ0UkcwWVdZ?=
 =?utf-8?B?YnZCdHZiTW9NMGNFQ24zN3Y4cGR0UW1iakE4SzRrRmJ6YWxnUnR1M1oxSUNh?=
 =?utf-8?B?TzJPNGsybXpBZktlY0lpQ2RsRzMzZWNBYUxycE1YMUgyZHhlSGFMajBRRmNl?=
 =?utf-8?B?cTlzTkFaSFJxZjlUY0IxbzdIYmVDTWtISXRXbVNQQW91RXkwaXFGMHlJcE80?=
 =?utf-8?B?RlpLVkJEcDFpaXlsUWc2MHUvU25qTDFodTBqOXI1L2hSR2VVRkJLSlBLS3d0?=
 =?utf-8?B?VVdtcXZGeUJVLzVseUZCZXlZcWFzK29RNERVNW9WaU5pVG56dkdLeWlENkJa?=
 =?utf-8?B?VFM3cXJBQk51ZUNsV21Za0pKZGJuZnpObU4rYnpmNVJqRGMzUzExOFVtNnkv?=
 =?utf-8?B?Qk4zdzVQVTd0L2V5TzJ2dTNHN0tha3pTNFZ1aW5oVE1ta3J5T2JUT3phbWpu?=
 =?utf-8?B?Ukh6V2xlV0hXbGpJL0RCNjRFVmJlOWJncG1lQThsVm9kcHFySkVMYnZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkFlaGFuZEVQa0tSV0diMWw3cXhNT3JOTnJQN3EzRTEvdFd5VkJVcWU3TEZp?=
 =?utf-8?B?UXhmclpUSzJyaFFFZmU3L2VZcXJTQnZONkVGSU5VZmhoVnNuVVA5akJVNjA1?=
 =?utf-8?B?NFNGbWFKbUNpNUtoKytkTEJPQjVSZ3BzRW9NS2lkcW41OWZHdkIvTjdTMWE1?=
 =?utf-8?B?dVM3YXQ2OTUwektxQkI3a3pSa2xRSEp2OHVCcHFXbm00RmVvWXE2SzNJRGdF?=
 =?utf-8?B?T3I0SzNMNUVINkMvVllQWHVSYUw4SjJMTHMvcVErd1lReWpCdWs4Nk9uUitw?=
 =?utf-8?B?elMza09pWlZJSmpOYmxOWDY3TVBSOHZJVS9aT0I3blpJM1YvZERlUHc0R1Vl?=
 =?utf-8?B?TFVLekFlU1VYZWpuaGQrTTdWZkNlN1VZRmZ4MWdWdjE3UVEwZEZQRU04OEt1?=
 =?utf-8?B?anFxTlgvK1kyV3ZRYi9YSTdTR1IrdzNBSHRsRk9DRjhzZE5yN0VTWURuMVBm?=
 =?utf-8?B?amtRdk8zc1hrYStwNTlOblJrV3FRTGNwZWRIZmVUdlFRNkJsVWo3QjVFdTlK?=
 =?utf-8?B?dVVPOUJDM21YSVhYaFdhOXBMNVh2R0VKMDJxSVlKSU9sTHIzRWFRQjR2dnZt?=
 =?utf-8?B?WnhSaXZ4UlM4RTRpRWcwSGJHTi9TUDVUUXg4YzRRQ1NPS0V3Y1hTSlcxMVZq?=
 =?utf-8?B?TUtocU5aVFNvdUhhLzAyVlpUaS9KV2dXY3BqN0RwQ21UNjZVOTQ3dXVxYjgx?=
 =?utf-8?B?MnpLSkg5L1pUWVJjcFJUY1dGM01jdnpSRE9YVHBUTGNJdlp5eGRseWFpYlM2?=
 =?utf-8?B?YWI4RTRGci9odkRFemhVTCt2UmlUVklaN2hqVXIxdjY4SytBZ0tKNHFtdmE5?=
 =?utf-8?B?ZFBiamxNZW1MNXRKTnF4VEVGZUdNNHROcmJtbU5TcDR5OFRlYjRTMGVNTk5j?=
 =?utf-8?B?SWZIQU9DdXNrMTV2K3RnMGRwNjZxcVNiUjhtNEZGUnkyalBOcyt1VmprUEJi?=
 =?utf-8?B?ZlJtWGV1SDZpTDRRbVg0a01iOEhydWVFaGZmcXIzR0VwbEdXTnRzeUExOUZG?=
 =?utf-8?B?ejIxems5WHMvRTM3NHh2bGp3bGxOZVdMbEFydXFCYVVVKzJscUN1eFhtZkZZ?=
 =?utf-8?B?RzNwcktyYVhwUkdVSUZoaTdXeC9SZUxCclhJTHg3SC92ZE5rRnFGdkpWRDN2?=
 =?utf-8?B?YmlEWmJDVWZCSmdHK1RkQjc5TnhiRkdpaEoyQ00rMCtVOHZ5WUJIcnRYbjRz?=
 =?utf-8?B?UEk4Q3ErUU1GS0RrYkVJK0MzREE0Y0wwSXRxcTZyWXo4TnNpVjBCOTBKZXJ5?=
 =?utf-8?B?VjdRaHorcWhVZlN1SmR5Rm5EalV3VHRDaDFnazNJZmJIZkRPN1M2alQvN2RH?=
 =?utf-8?B?MDkrdmdPQkNuVi9vOW55ZmgwcXZVdXJXMGw1UVJWenZHa3pvZDRmM3dWNGoz?=
 =?utf-8?B?bXY2QVUvbnZOTkg3MUU5dDBBVHp4U3RocjdnQjBsMWRadVN2dE5qZ0UyenZN?=
 =?utf-8?B?MW82aFJ2ZGF4MkVPYSt0WC9GNlVVLzhNOXlwWnkvdjhnVjcwSlZDZTJTeVlj?=
 =?utf-8?B?YXlVTkZtalZDeW9Xc0hHZE00V0pWQlArUzFhT3NUT1JjbU5HRXI2UjJMZ0tD?=
 =?utf-8?B?b0dlMHFmVjN3d0JiN2pOZzNmY1pRMHlVYURsRVBZYVMyeXNBTllXb0JZWDdE?=
 =?utf-8?B?a2pmd1hBZ1NIUXQ5c2ZQcXlnUnNiNWNhdU4yQzdpUzZwN3BPZVUvTm9wZk15?=
 =?utf-8?B?NzR0cDBKZlNZRHNsTEFiZWhQSGxFTmRuQWYreHg2NmJ1cU5qdE5rbUhRZmRI?=
 =?utf-8?B?SnZRMGhIdjA2MENYamh1T2dGQ3pVWGV5dlo2Mk40eTlZTEt1OE9lSENZajZS?=
 =?utf-8?B?WlhSTHZVamtIY2ZpcS9FbnovMlBZQmtQKzVnalpJdDNYRm9NWGNyNnhvWE12?=
 =?utf-8?B?aW9CWFdLZ2FGQUlsR3c3VEowK09sOGtjWk1NTGQrcldTOVZLRnNiM0I1TU5K?=
 =?utf-8?B?S202SDNvVWExZWZFNU1JMkJFck15TkdQZWdtTzl3aG9wTmsrSFRYZmJSaS83?=
 =?utf-8?B?WG80ZWxXOWxkMjVxMjhjeWQ5Vll2L0RmR3lXaTRtVTR6K3QrY3pUVklpaVZC?=
 =?utf-8?B?UndKdUI3NjczNzhpTVhWOWhRanh0K1lUVHZWWHFLS21VcFhwR3pyYU1QYjFl?=
 =?utf-8?Q?eBu7MWh9WwEwHjyUyA9XAe/vI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04eb7c5f-8d22-42b9-e650-08dce35dd1d9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 03:45:27.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuivIhi22FJ3/2bUJCahNeVgROY1ufDIak39mbtZrJLN2utdfkonNd+/sMi3PUIO/2s35gOWM49Z8D26td1AgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113


On 10/3/24 05:11, Ard Biesheuvel wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 2 Oct 2024 at 20:06, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Wed, Sep 11, 2024 at 5:55 PM KobaK <kobak@nvidia.com> wrote:
>>> PRMT needs to find the correct type of block to
>>> translate the PA-VA mapping for EFI runtime services.
>>>
>>> The issue arises because the PRMT is finding a block of
>>> type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
>>> runtime services as described in Section 2.2.2 (Runtime
>>> Services) of the UEFI Specification [1]. Since the PRM handler is
>>> a type of runtime service, this causes an exception
>>> when the PRM handler is called.
>>>
>>>      [Firmware Bug]: Unable to handle paging request in EFI runtime service
>>>      WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c:341
>>>          __efi_queue_work+0x11c/0x170
>>>      Call trace:
>>>        __efi_queue_work+0x11c/0x170
>>>        efi_call_acpi_prm_handler+0x68/0xd0
>>>        acpi_platformrt_space_handler+0x198/0x258
>>>        acpi_ev_address_space_dispatch+0x144/0x388
>>>        acpi_ex_access_region+0x9c/0x118
>>>        acpi_ex_write_serial_bus+0xc4/0x218
>>>        acpi_ex_write_data_to_field+0x168/0x218
>>>        acpi_ex_store_object_to_node+0x1a8/0x258
>>>        acpi_ex_store+0xec/0x330
>>>        acpi_ex_opcode_1A_1T_1R+0x15c/0x618
>>>        acpi_ds_exec_end_op+0x274/0x548
>>>        acpi_ps_parse_loop+0x10c/0x6b8
>>>        acpi_ps_parse_aml+0x140/0x3b0
>>>        acpi_ps_execute_method+0x12c/0x2a0
>>>        acpi_ns_evaluate+0x210/0x310
>>>        acpi_evaluate_object+0x178/0x358
>>>        acpi_proc_write+0x1a8/0x8a0 [acpi_call]
>>>        proc_reg_write+0xcc/0x150
>>>        vfs_write+0xd8/0x380
>>>        ksys_write+0x70/0x120
>>>        __arm64_sys_write+0x24/0x48
>>>        invoke_syscall.constprop.0+0x80/0xf8
>>>        do_el0_svc+0x50/0x110
>>>        el0_svc+0x48/0x1d0
>>>        el0t_64_sync_handler+0x15c/0x178
>>>        el0t_64_sync+0x1a8/0x1b0
>>>
>>> Find a block with specific type to fix this.
>>> prmt find a block with EFI_RUNTIME_SERVICES_DATA for prm handler and
>>> find a block with EFI_RUNTIME_SERVICES_CODE for prm context.
>>> If no suitable block is found, a warning message will be prompted
>>> but the procedue continues to manage the next prm handler.
>>> However, if the prm handler is actullay called without proper allocation,
>>> it would result in a failure during error handling.
>>>
>>> By using the correct memory types for runtime services,
>>> Ensure that the PRM handler and the context are
>>> properly mapped in the virtual address space during runtime,
>>> preventing the paging request error.
>>>
>>> [1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
>> I need input from EFI people on this, so can you please resend the
>> patch with a CC to linux-efi@vger.kernel.org?
>>
>>> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
>>> Signed-off-by: KobaK <kobak@nvidia.com>
> Please use your full name.
Hi Ardb,
Sure, will update.
>
>>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>>> ---
>>> V2:
>>> 1. format the changelog and add more about error handling.
>>> 2. replace goto
>>> V3: Warn if parts of handler are missed during va-pa translating.
>>> V4: Fix the 0day
>>> V5: Fix typo and pr_warn warning
>>> ---
>>>   drivers/acpi/prmt.c | 49 +++++++++++++++++++++++++++++++--------------
>>>   1 file changed, 34 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
>>> index c78453c74ef5..cd4a7f5491d6 100644
>>> --- a/drivers/acpi/prmt.c
>>> +++ b/drivers/acpi/prmt.c
>>> @@ -72,15 +72,17 @@ struct prm_module_info {
>>>          struct prm_handler_info handlers[] __counted_by(handler_count);
>>>   };
>>>
>>> -static u64 efi_pa_va_lookup(u64 pa)
>>> +static u64 efi_pa_va_lookup(u64 pa, u32 type)
>>>   {
>>>          efi_memory_desc_t *md;
>>>          u64 pa_offset = pa & ~PAGE_MASK;
>>>          u64 page = pa & PAGE_MASK;
>>>
>>>          for_each_efi_memory_desc(md) {
>>> -               if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
>>> +               if ((md->type == type) &&
>>> +                       (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
>>>                          return pa_offset + md->virt_addr + page - md->phys_addr;
>>> +               }
>>>          }
>>>
>>>          return 0;
>>> @@ -148,9 +150,18 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
>>>                  th = &tm->handlers[cur_handler];
>>>
>>>                  guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
>>> -               th->handler_addr = (void *)efi_pa_va_lookup(handler_info->handler_address);
>>> -               th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
>>> -               th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
>>> +               th->handler_addr =
>>> +                       (void *)efi_pa_va_lookup(handler_info->handler_address, EFI_RUNTIME_SERVICES_CODE);
> Wouldn't it make more sense to test the EFI_MEMORY_RUNTIME attribute
> rather than expecting/assuming a certain memory type in each case?
> That attribute is precisely what controls whether or not a region has
> been remapped into the firmware's page tables.
Please see the below
>
>>> +               th->static_data_buffer_addr =
>>> +                       efi_pa_va_lookup(handler_info->static_data_buffer_address, EFI_RUNTIME_SERVICES_DATA);
>>> +               th->acpi_param_buffer_addr =
>>> +                       efi_pa_va_lookup(handler_info->acpi_param_buffer_address, EFI_RUNTIME_SERVICES_DATA);
>>> +
>>> +               if (!th->handler_addr || !th->static_data_buffer_addr || !th->acpi_param_buffer_addr)
>>> +                       pr_warn(
>>> +                               "Idx: %llu, Parts of handler(GUID: %pUL) are missed, handler_addr %p, data_addr %p, param_addr %p",
> Please improve this diagnostic: 'are missed' is not very helpful.

Are these good for you

```

-static u64 efi_pa_va_lookup(u64 pa, u32 type)
+static u64 efi_pa_va_lookup(u64 pa)
  {
         efi_memory_desc_t *md;
         u64 pa_offset = pa & ~PAGE_MASK;
         u64 page = pa & PAGE_MASK;

         for_each_efi_memory_desc(md) {
-               if ((md->type == type) &&
+               if ((md->attribute & EFI_MEMORY_RUNTIME) &&
                         (md->phys_addr < pa && pa < md->phys_addr + 
PAGE_SIZE * md->num_pages)) {
                         return pa_offset + md->virt_addr + page - 
md->phys_addr;
                 }
@@ -150,18 +150,20 @@ acpi_parse_prmt(union acpi_subtable_headers 
*header, const unsigned long end)
                 th = &tm->handlers[cur_handler];

                 guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
-               th->handler_addr =
-                       (void 
*)efi_pa_va_lookup(handler_info->handler_address, 
EFI_RUNTIME_SERVICES_CODE);
-               th->static_data_buffer_addr =
- efi_pa_va_lookup(handler_info->static_data_buffer_address, 
EFI_RUNTIME_SERVICES_DATA);
-               th->acpi_param_buffer_addr =
- efi_pa_va_lookup(handler_info->acpi_param_buffer_address, 
EFI_RUNTIME_SERVICES_DATA);
-
-               if (!th->handler_addr || !th->static_data_buffer_addr || 
!th->acpi_param_buffer_addr)
-                       pr_warn(
-                               "Idx: %llu, Parts of handler(GUID: %pUL) 
are missed, handler_addr %p, data_addr %p, param_addr %p",
-                               cur_handler, &th->guid, th->handler_addr,
-                               (void *)th->static_data_buffer_addr, 
(void *)th->acpi_param_buffer_addr);
+               th->handler_addr = (void 
*)efi_pa_va_lookup(handler_info->handler_address);
+               if (!th->handler_addr)
+                       pr_warn( "Idx: %llu, failed to find VA for 
handler_addr(GUID: %pUL, PA: %p)",
+                               cur_handler, &th->guid, th->handler_addr);
+
+               th->static_data_buffer_addr = 
efi_pa_va_lookup(handler_info->static_data_buffer_address);
+               if (!th->static_data_buffer_addr)
+                       pr_warn( "Idx: %llu, failed to find VA for 
data_addr(PA: %p)",
+                               cur_handler, &th->guid, (void 
*)th->static_data_buffer_addr);
+
+               th->acpi_param_buffer_addr = 
efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
+               if (!th->acpi_param_buffer_addr)
+                       pr_warn( "Idx: %llu, failed to find VA for 
param_addr(PA: %p)",
+                               cur_handler, &th->guid, (void 
*)th->acpi_param_buffer_addr);

```

>
>
>>> +                               cur_handler, &th->guid, th->handler_addr,
>>> +                               (void *)th->static_data_buffer_addr, (void *)th->acpi_param_buffer_addr);
>>>          } while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
>>>
>>>          return 0;
>>> @@ -250,8 +261,16 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>>>
>>>                  handler = find_prm_handler(&buffer->handler_guid);
>>>                  module = find_prm_module(&buffer->handler_guid);
>>> -               if (!handler || !module)
>>> -                       goto invalid_guid;
>>> +               if (!handler || !module) {
>>> +                       buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
>>> +                       return AE_OK;
>>> +               }
>>> +
>>> +               if (!handler->handler_addr || !handler->static_data_buffer_addr ||
>>> +                       !handler->acpi_param_buffer_addr) {
>>> +                       buffer->prm_status = PRM_HANDLER_ERROR;
>>> +                       return AE_OK;
>>> +               }
>>>
>>>                  ACPI_COPY_NAMESEG(context.signature, "PRMC");
>>>                  context.revision = 0x0;
>>> @@ -274,8 +293,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>>>          case PRM_CMD_START_TRANSACTION:
>>>
>>>                  module = find_prm_module(&buffer->handler_guid);
>>> -               if (!module)
>>> -                       goto invalid_guid;
>>> +               if (!module) {
>>> +                       buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
>>> +                       return AE_OK;
>>> +               }
> What is the reason for this change, and the ones down below?
As per Rui's comment, goto can be replaced with return.
So I modified them with return and PRM_HANDLER_GUID_NOT_FOUND.
>
>>>                  if (module->updatable)
>>>                          module->updatable = false;
>>> @@ -286,8 +307,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>>>          case PRM_CMD_END_TRANSACTION:
>>>
>>>                  module = find_prm_module(&buffer->handler_guid);
>>> -               if (!module)
>>> -                       goto invalid_guid;
>>> +               if (!module) {
>>> +                       buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
>>> +                       return AE_OK;
>>> +               }
>>>
>>>                  if (module->updatable)
>>>                          buffer->prm_status = UPDATE_UNLOCK_WITHOUT_LOCK;
>>> @@ -302,10 +325,6 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>>>          }
>>>
>>>          return AE_OK;
>>> -
>>> -invalid_guid:
>>> -       buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
>>> -       return AE_OK;
>>>   }
>>>
>>>   void __init init_prmt(void)
>>> --
>>> 2.43.0
>>>
>>>

