Return-Path: <linux-efi+bounces-1902-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961EA98F7B6
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 22:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCFE1C20359
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DD517BA3;
	Thu,  3 Oct 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tAYdOPBq"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944A4C8F;
	Thu,  3 Oct 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985788; cv=fail; b=TCY9DOAlLyy+TWB3sEBkAbyr/MerkvGSlY+PrYYzWYb4uObWT1xYWpoLwLt0jT3zmRQvrSQesaQgXy3PBDz4s8AJislQhehpMJokHGMP8R8wZPTSVCUfqx8kH7F7Xuc9xKADfXe7snS6j1CZZk1E4jgQwshy9uQYmoNtpaE/074=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985788; c=relaxed/simple;
	bh=I5gpeVlZeRcbg7r051cPe3W6GABeC3NU51fkozvt00M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=NL+iuO3NVmmYT0uzK2Hd8TEBQLP2O/3/skC/cjwMOn/5mnmXXf6jpaE11Sa7mMykxMllEqEZA5e6U2+khjTOXHETWy/eFyFR7SbqqjKWIvhmZhEzyOOWmTcbvawLNE/zcQnFjqFX3f7Uk1aUPuJ3vWj5pKfyt8FAQ0F0646zRfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tAYdOPBq; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRHjdCnbFAFt/EL4r5gdJSoSepgThxza5hA6bcZwQlkxLFn7VAvQQzLKjoBE2F/txpItaKcMrvHZ2u+w6t7w6zX+1hlG3uz618JJS4EbTyPbXwYzWqZsu1KaVp0uUluj0j1nJHRMG+kRUIVwnraC0Vok7KsJTifClIxCQZ/82qAIeF9IOKzmjIlkrcw2th1XDuyBnvGOTPsSSk68/7kAv5pSATyuGEYleUNzlE8Eui5mtCOPS4+SrGAHKEGWwhY3CsvWAE81trF4LTrTpU3g9aFXbRH6mAC5lVeWLJKw/WUHE9YD7Ota8NfJJdTw8zKWDDqELl18l8hYzE3I9ISRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OxEQqqn5rSgvKKgGPnnJetqW8d4nfRxsbYrCvq0ofQ=;
 b=DqpgHTVzzeLFIshEHNVQbYw19x8vu24DnPWA+HCHdPc7hRIC3MHsh7/IrgLesz4+LBtYDduGo3ClyBGuMx8M6btaHr9LFqjkcAjVpLPAqAh1JUs8osu600ca1XqTDhbjVBheXd6vEzm3mjSHVPE5vcqYF3jccfe6ekwMEqUR6DwEyuuVFICFwe2V4Q10bmDA8EM66JMdhYo+Rr7J4mAPn0F+Yrdc5WRZ9wgCbACyf1RryFYXetr+84bos0wA5EY4SLrOoU2Tt7aK26o5LW3ZrI6gdVm1+vuXQDvmuSXBJrRkJGZ34ejGwpciUw8HUIRLRNhp9PR5B9+uFwtgi5IpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OxEQqqn5rSgvKKgGPnnJetqW8d4nfRxsbYrCvq0ofQ=;
 b=tAYdOPBqFjTFLDAn6jt/9ms/MM4w2Wc6nwUTxPtjfNAzOeQVqwKmkMrvLPdkivxF+uT4csaP1HJOQUVeEhLR7+TCSYOR2pMU43pEQmuJ5fvxWcXBxahKvleAY45CSX9OAxPnq8uPHQQCOSCQuvY+CNH78oHtEu5s2KmJNWbYHxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 20:03:03 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 20:03:03 +0000
Subject: Re: [PATCH v2 4/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
To: Dan Williams <dan.j.williams@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-5-Smita.KoralahalliChannabasappa@amd.com>
 <66fde27512fa2_964f22945e@dwillia2-xfh.jf.intel.com.notmuch>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <1dd9cb74-5b88-06ca-81d2-97392fe14ce9@amd.com>
Date: Thu, 3 Oct 2024 13:03:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <66fde27512fa2_964f22945e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 379acfc2-07a9-4007-3523-08dce3e6639f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWhDdWVTdVczZllza2FScEZEaG9rOTRVYUNHemRxZkdkdVY3K0FSTFErWTFT?=
 =?utf-8?B?bFJuWHVETGFsWnQzZ0pDb2x1cm5pWDVpL2tmSFVqM0wxVnVHd1lRbkppRjBt?=
 =?utf-8?B?ZTNTc2Y1UnhrUG82U3VxazA0Sjl4UlBmZUVvWnZWcHN4N05GbU8rVDBFTEFm?=
 =?utf-8?B?OUg5U29NbEFPdWxETDdrMWZOYVVVZmI3WVRkemRINHRyRURObm1NQTViMFoy?=
 =?utf-8?B?c0hMRnRZdk9yTXlVeWI2MVg2Z20vYkF3ZzIvMU1xZzlLRVErRFlydUdWbTdy?=
 =?utf-8?B?V3ZXVmdQdGtQVkpKZlA4MEtNNCszbktrNWdKU2hxRnFTU29MMGkwVmN5UG11?=
 =?utf-8?B?Z0ZSQXdmVzlLZE5WWlNvUmZsRXJhaXdGV2g0eTkrR1JDSFY2ZnJyQWJVQWVG?=
 =?utf-8?B?eHVYWXUyeFZRNzFJMHFvL1F2bE44THBRK3ZkbmI4L1pqTkVDcFQ1SHJEUVRH?=
 =?utf-8?B?bUFTM3M0NkhwYU90UWdtLzg3UlVzaXBQRnVoeVhHOUY0UFJvWUFLQmJZQXl4?=
 =?utf-8?B?WFY1S3BlY0ozd00rMXpyODQ1VDVDcGlKdWpCQjN4WU1CdW1ZblRNTzZSQzVP?=
 =?utf-8?B?WjJJTm5CTys2WGR4eElCUEdmTnpoR1p5VERMMkcrcUUwSmViZ2xDVXpsWWF6?=
 =?utf-8?B?L1hEYldLVm1TbVZmK0EwQk9OUWRsU0V5bVRoSDY4MWw4UjRpcTV6YlAzdUJz?=
 =?utf-8?B?Tm9oUUU0VW5aZnhNVmlSV2FDZE1RdkUxTm1LbFJSbEdVd3VQQzFRWFJUTkJs?=
 =?utf-8?B?R1ZwZjc0cm5Eajl4Qm9pazRZdVlsVEVuQzVJMFRDNWJuOVgwK2VJVkQyUk1w?=
 =?utf-8?B?eUU5NS9FNTNlOVpRK2NqeHl4U2p2dzJmRS9DT0tWVHFtbFd1TnJJclMyNFY3?=
 =?utf-8?B?cWhoemFyRE9vb2o5VWlGQzVNVGxJaVdsdTBsb1ErUnFsWDVRVW44OHNMNzVY?=
 =?utf-8?B?NVhtL1V1V3dUQmc1d1pzczFWbGd6b01qWU56dmZ1cytVc0M0d3NUMXBYNmN1?=
 =?utf-8?B?dkN0Nm5nblFQckpUdmNTbHdTLzdFd1ZYcmFxQnVlaWJJMnIwOHVXOVFrTEls?=
 =?utf-8?B?dnRyK0Z3ZVpEQXkrQ3p6a2xzUExwd08wS09wd2JMVmFCeHNvTndrZ3pjdXpD?=
 =?utf-8?B?RVkwdVlSZ2NmQkxQUzlsanhpbnRuQXpEOGJJQVZTY0M3VnlkaXFwbStRWlQ0?=
 =?utf-8?B?TTRiS2psRFlqVkJDRzVoUUtQUDdiZk5QR2V1clBjQTF5QklTSEpzT0pibjBq?=
 =?utf-8?B?cUt6cWVUTnp0cUVNUXpuTlg4N0lHYmVibmEzZ1NITldtekVPZy9RV2tjUzBX?=
 =?utf-8?B?UEVwSStIVm8xVTZyZXAzcjkvdGl3UVpZL2dsQ1AzZk8vSm0vNUhHSE53a0o2?=
 =?utf-8?B?S2l5YTNsWmpoV1ZvZExweWp2Rk9ZWkVudDAxREJqdnlPeENtZW54SG9vcmgz?=
 =?utf-8?B?d2VxUUUrcWRSdUQyRThJS2dtc1N2N1V2UlNTUU9rK1hobFZ3VlZmNzlxV0RI?=
 =?utf-8?B?ditqNlk4UWNGbEE1YTZhUEVjeVNueWk0WlpmWHJ0WGs0UjdNNlRYMXB3MG4w?=
 =?utf-8?B?VnFWMWEydEQzWVBSTy9UL2wrWmovWGxobnZCK2xHSzlXdHBVTVhFekp6K2JP?=
 =?utf-8?B?YURWY0hmd3ZFMWxWZi9WNGRZbEJGaHU3RG53MTVjc2ZiLyt6dFZlcVlYV2sr?=
 =?utf-8?B?ZThIcnd6NnY5RndBQUJGQ3l3N2ZFNnptb2xGN1lab05pN2dSRjVwdnN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czZ0aEFYSis5dktyNE8vV2o3Wm11VUtWVVlsWmpvQzdOVUhnVG8wN3Y2bjRX?=
 =?utf-8?B?ZWFRMVBEYUc5QWNmNlYzVytPRVFETG5ST0poNHlrSXN6OURET0txODlvVkJr?=
 =?utf-8?B?SENpWDRSNWtYaHQvZk9zUFVHZzZKWE5iMHFja1hSaEZxYWlFSkRCaG5mbGNM?=
 =?utf-8?B?Zm1yYkhLRGc1VHpoekxzc2RqOG1QMkRKb2dINWlOM2lCQlNXVFRmUEpUKzFP?=
 =?utf-8?B?S2R3dHpodVlDbzdKUVI5RUN5NGJQSDZsL1JqOU4ydHdabzFqV29XRUl4WjBU?=
 =?utf-8?B?Y2RUMENzMm9oZytFdjdiRnFmcFhjY3F5dzRhK09lOXNCeVRTSjQ0L3Z4TzBL?=
 =?utf-8?B?RlhsYzJteENVNU9xYWJpT0pPcUZhUXYyRVZjOWlDSmdDaWk5Nkl3ZzlkZ2Yw?=
 =?utf-8?B?QWl4Y25jd0U1WHdHZ2M5TkRZdmZibjdDUWRNWWtpamUvYVJtd2F1RkVUSnRD?=
 =?utf-8?B?UUVtQThuMWVFMXlLa09zQzU5cTNyZUczMlVHMmdCRGYzakZpNHJZOVlXdUhl?=
 =?utf-8?B?WGJES2JvQi9oWkZ2ZkRpdUFOZGZzV1ZlVGhqYWEyYi9OOExObkdBajNWVUhC?=
 =?utf-8?B?NTc2ZlR3NDJSVkdTZVdTRERSMXF2R0hyQlVjZHlNU2lNRi9YNjh1MVAyNjFi?=
 =?utf-8?B?TVJDMXlmUW1QRDJBRW5pSFlzenp5WUJRRU1QbEorbnI1Rzg3M2V1MnJscitl?=
 =?utf-8?B?d214ZEJ0VitZR1hnd1V5b2ZWUi9FTXUxRGdwSlppY3ZsdytGdUsydE5jeEVu?=
 =?utf-8?B?MmhCT2hSbzNJRFF5a2x2YUZWTUlhMnhiem1QZ25GMlZtVEx5Qk9pNldmeEVH?=
 =?utf-8?B?ZkJrKzd2LzFhUmpxZDQ4aW41VDVaYVRwdTdUMXVNbk1WV0xaSGtodEVvMmJt?=
 =?utf-8?B?MSttWUpvSWlzblJPdnNIT010QTRQY1ZZNlIxWXNmaWMyWWlraDJQNXNnQjFL?=
 =?utf-8?B?dHAzajlDVGxQK25hTTkxWFBkRFdmenNWbE85bTFCMXZ5MnlOVUg4eklSNklH?=
 =?utf-8?B?a0o2UnQxZTk5RGpYQ0djdkdIZVRzMDJGNGpRS3dLaWV0a3IvT0p2Qkp2cHBI?=
 =?utf-8?B?Mnp3RXlLUW00RDJoNzhGWks5Z3dhOWxNNXh5OWExaTI5WWIyd1Y2WjdkcFJ1?=
 =?utf-8?B?dDIzSW02K244VCtrSlRubzRlZk9tY1RZSmFvNWVidjFaeEowTGRReFVQTkp1?=
 =?utf-8?B?OVdLYjJFcU8yTk9aNmlNRytjejBTckMzeTZZZk9uQlZvWnc5WFZXZWRjUWs5?=
 =?utf-8?B?S2NzcHlkb0ZEQXMzQzRaNitSSFF0RSs4TVJBRmJBUGxhQTFqSHZNejAydUk3?=
 =?utf-8?B?V0U4a2ZGcnduVmc2aUVmT3hLOU9UaWtCeEVuZmIwdnpKU0xCdmdLOFZUSWJN?=
 =?utf-8?B?Z1dXRXQ3SEI0em9FZkcwazMwMXdTR3Bvc2FKUGczNERCYU94VDVVVzZRYVNm?=
 =?utf-8?B?TEhUcHpaUzVMaklGY2RBN1JYeGFza1Z0MFBSZnhnNGFzekFndjVlaW94Zjhr?=
 =?utf-8?B?eG9zNTVVM3FCNmFkWVY2azFmRjRGZkJEMFh4dm1XcXMwMktuaWFLR0dYaVR6?=
 =?utf-8?B?QW5Lb2gxbmVYWnVJRGRnRXVIRm5Ud1dHd2Z5YWlaVHZ6RGZMR0RVOUtObEZx?=
 =?utf-8?B?MXJEZ0tmK2NreDd5K3V5Tk5ZMDBtb2Z2S0EzQisyWjVFVHN6T1IyM1FSQ3c5?=
 =?utf-8?B?WkxJbmM3YmJ3Mi9vWEZRdnBBOGlvclEwZ09lVy9pRnVQOHFqZDlBRWRYZTlt?=
 =?utf-8?B?NEFoYnB0UjVRcENzV2x4S0ZNdGZieWJuWkZKeHJhZVFLQjdpb3kvRmxIZUx0?=
 =?utf-8?B?YlR0MVdNaEZyTm93c3hqYVFmR3ZGbmloazQ1clNjOUlCZTBLUjFjR2UvM3dN?=
 =?utf-8?B?NGNHaWdsZlpSb2J2NjdpUmZxanRzY29xWXUyTm5jWjVJWE5TQVJDRXNJZU94?=
 =?utf-8?B?Z0JxdE5VNCthSy8vSkcvb2M5M3c1d01EeUh0R2lXTXVtQlZSYjF3OU8ybkFo?=
 =?utf-8?B?NkdCazJWRUYxc09Nck9hazhacmFadjZObVBWdkdxTUdQMU9EMHZrcXZPV3Rt?=
 =?utf-8?B?RUh2d3cwT1RrRUV3RWVmWlF2eitONzgvNjNmRlB6dEpLeTF2OU1FQVJHK3lF?=
 =?utf-8?Q?jsAB/kW2Faqz6NxX5hs2u21fI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379acfc2-07a9-4007-3523-08dce3e6639f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 20:03:03.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUmQKVfyxf8Hr7JxNvnApyEr2CJsOs+ifAC7/Z0WjOx9q838lBXboerO4PvOeU+n6YwKrWg2O5d7IRop5jNdGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167

On 10/2/2024 5:16 PM, Dan Williams wrote:
> Smita Koralahalli wrote:
>> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
>> CPER records.
>>
>> Reuse the existing work queue cxl_cper_work registered with GHES to notify
>> the CXL subsystem on a Protocol error.
>>
>> The defined trace events cxl_aer_uncorrectable_error and
>> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
>> them to trace FW-First Protocol Errors.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> v2:
>> 	Removed pr_warn for serial number.
>> 	p_err -> rec/p_rec.
>> ---
>>   drivers/acpi/apei/ghes.c | 14 ++++++++++++++
>>   drivers/cxl/core/pci.c   | 24 ++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h     |  3 +++
>>   drivers/cxl/pci.c        | 20 ++++++++++++++++++--
>>   include/cxl/event.h      |  1 +
>>   5 files changed, 60 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 9dcf0f78458f..5082885e1f2c 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -723,6 +723,20 @@ static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
>>   
>>   	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_rec))
>>   		return;
>> +
>> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
>> +
>> +	if (!cxl_cper_work)
>> +		return;
>> +
>> +	wd.event_type = CXL_CPER_EVENT_PROT_ERR;
>> +
>> +	if (!kfifo_put(&cxl_cper_fifo, wd)) {
>> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
>> +		return;
>> +	}
>> +
>> +	schedule_work(cxl_cper_work);
> 
> The cxl_cper_work item is only for cases where the cxl_pci driver might care
> about annotating an error report with driver specific details like the
> impacted kernel object name, 'struct cxl_memdev', or address translation
> for DPA data.
> 
> Protocol errors that are not endpoint errors should never be placed in
> the cxl_cper_fifo. That is exclusively for errors that cxl_pci needs to
> consume.
> 
> My expectation is that similar to aer_recover_queue for PCIe protocol
> errors CXL needs to grow a cxl_recover_queue that at a minimum triggers
> new trace events to dump these records to RAS daemon.
> 
> I am struggling to think what useful information cxl_pci could ever
> append to a protocol error event.
> 
> What is more likely is that later when Terry adds port error handling a
> CPER protocol error record could trigger a new cxl_do_recovery() to
> react to CXL topology errors that might impact downstream CXL devices.
> In that case the notification will come through something like a new
> 'struct cxl_error_handlers *' hanging off 'struct pci_driver' since
> accelerator drivers are going to have distinct error handling from
> generic memory expanders.

Hmm, I agree handling device and protocol errors separately. Unless 
Terry has something to add here, I can start working on a minimal 
version of cxl_recover_queue as of now.

Thanks
Smita
> 

