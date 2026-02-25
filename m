Return-Path: <linux-efi+bounces-6223-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGTsGzWAnmn+VgQAu9opvQ
	(envelope-from <linux-efi+bounces-6223-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 25 Feb 2026 05:53:09 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A39191ABA
	for <lists+linux-efi@lfdr.de>; Wed, 25 Feb 2026 05:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E961304302E
	for <lists+linux-efi@lfdr.de>; Wed, 25 Feb 2026 04:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B42BD5BF;
	Wed, 25 Feb 2026 04:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qq4GbVEH"
X-Original-To: linux-efi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C8D1E8836;
	Wed, 25 Feb 2026 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995186; cv=fail; b=XM4jzp5a2VM1dAPcKwH6FOc4bRfeT7JpTCriv2vaPiz2+6F8FYl0l9SGVPP2Vmj01SHs3ETpvChCuKEQvBq5I0xSgg1/Km22E/ZqZN589hKoAj1byNLn5Nrg/p9tQC0863oMqkDKi6My25xgdRouhCsMNrg1tNf3jdnHR4jOzSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995186; c=relaxed/simple;
	bh=BDmzeStdMECzdAa+5395kU2Mzx482sgtlJ+q1m7Zt90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LnLQNSWaw8ER2iEL0HR0UgvQPJudRj/mF/FzrJgcVcjCiflxSXXAh8lJZGFzErZysIAlw0z6H9Ti9VB+Gk2yJ/FgIiSszizNGY5lWB9RShbnXPgV3gvDp/wbv/6KaXsVqHEg0/VPsaFf4Fgd+6+hPNyF6VPuG7eKDXQOMgF7yLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qq4GbVEH; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDmWXZ+i6gGdb0M51nr8gu8nxg/+JnRoBxBB3XlR0nyPktvSeC9O5S5OE4sqD99cw6PT1kcZ6icrai64/FDpzFHpWHkkLK+wmnXekbS6fIit+N4B/M6P+WUm9ECYV0Hfg+i7tknE3zF//i3pMeqRj5xzJVb2oZOhqnSwHFy3/LIOMCJtPiLjk0TlaFpyqD+yFVECeGNjJenZ0AIyOKL3UMIuvh41AWrtICHJM/csmWCD3WCdvAFvj9kXd+Sev5AV8yKe9sXGg8SsLB0PuFGodHT5HrEzafhWwquUw6jjMitbTvcBDmJhUtF1aFfQC9RSg4Fl8lH3UWjdNa1FhsliyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLr+bIYFNS3iVIuLjyQSAD8d8hG4K7PfTLJGARq1kFM=;
 b=j9VQOJunKeshUVjx0yU8gOcaZVSFnUnJxaDRMPRIV7yo4XqONBb2EnGxZLnOxZIVUB7xkBe1PWwkdiRcO9T5ZOKk3AxoK4/PjwTSGbxBMNckCizLAAzgd/M/8SKZbox0KISN9nYKpdT/E4j9e3cjsNjeDmrUqC2I0TSbKSGYxkG4fhnIF68kxMjvCb1yBRb0/Ly7tEjsh0pzdfruEwD5MroIOXkBtt8e43mq+R2ccv+bfml1XBscZoLjAqk/Keyr5kS4gtlxo4pK/xwl63Gz7mLgyEJheEYVBZXtiqg+Cc75qMFUSgKhPbrscNlEV0ZY5wRBS7gZN01swA1gr35UxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLr+bIYFNS3iVIuLjyQSAD8d8hG4K7PfTLJGARq1kFM=;
 b=qq4GbVEHCd+fWTff418xXHEwVBs+KYuCNqJEwpzItZRya2HbcQ7AtYZVz+4qcjK6c58OTO0EB8uf3HUHc6bL4Iov57LqCAF/9ZsftSXsQc5FJlTPcaRvfXXpwwDa1yrLxtNJL7v6I/mnUulzJfonAhIzGrPF4wndihBj1jNIYILspz7d3qz7rwDO8TsbdYlnSZUih78NVaxbfMMwYKCkHTYxyyy4e9fz/3xfxDrVYuFXxJMc9pkFe9b8o8Xz3ochQr+P3VfJHWZES69DMdsGYATyMX9w62mCDvSUr/gJLI/0lxwwzRTiBju3MYMHukPq/sqXs7wR6VD7aKFRRjbzbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 04:52:55 +0000
Received: from SJ2PR12MB7917.namprd12.prod.outlook.com
 ([fe80::6e3c:d0e2:fc8b:4e34]) by SJ2PR12MB7917.namprd12.prod.outlook.com
 ([fe80::6e3c:d0e2:fc8b:4e34%6]) with mapi id 15.20.9632.010; Wed, 25 Feb 2026
 04:52:55 +0000
Message-ID: <66901350-8a4e-4282-8f56-a2df844a7ff6@nvidia.com>
Date: Wed, 25 Feb 2026 12:52:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi/cper: Add NVIDIA CPER section support
To: Shiju Jose <shiju.jose@huawei.com>, "ardb@kernel.org" <ardb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, "Guohanjun (Hanjun Guo)"
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Morduan Zang <zhangdandan@uniontech.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20260223064924.6449-1-kaihengf@nvidia.com>
 <786211585e2b4a1fbca58c1427102260@huawei.com>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <786211585e2b4a1fbca58c1427102260@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:820:d::18) To SJ2PR12MB7917.namprd12.prod.outlook.com
 (2603:10b6:a03:4c7::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB7917:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4820c0-f02d-4953-2dc9-08de7429bcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkVtZXBqb01ickMzcERzNHh1V2g5OSsrTmszd2w3MzFnRVJzL1R3RWpvNG1u?=
 =?utf-8?B?bmowOVN4cGlYSVVuOEc0Sm05VkJya25IaUc5ZE52c2paejl6cWppWjNVdU4v?=
 =?utf-8?B?b3REMUh2TFhXNXZEelhYRi9rb244UC9BWHpUZWdDOUZSb1dvcFhic3lFeEti?=
 =?utf-8?B?cEEyaXdSTFZjOFZqQjN2S2x4clpaN0dMemJWYUZuZ0pZUHFHaDd4c05naFpM?=
 =?utf-8?B?dFRDeHpmYlFrVG96UUtpcVFkWnRzTnBESDhxbDdDMWxPY0lsbmk1R3lkM0c3?=
 =?utf-8?B?ekVuZmNEYzY5R3FKTU9hQUdVcm05Wkhyam0vbk5rejRWVUdSZHhmNWpvVEdp?=
 =?utf-8?B?NCtiUDlGa2Y4WDhlWEJIMERaZjJyT2h1Y29aVU5pN3l2MUE4emFLUU4xelph?=
 =?utf-8?B?SlU4UFVxU3BJNGlFZVFNQzMxMU9oY1VlZC9RUjhNQ3dPTzRnYnlTdzZneExi?=
 =?utf-8?B?M1EzYVY1cHZWTUpodjgxWStjN1NVcjBuaFd6VGszamdxbmZLLzh3cFJqNzBL?=
 =?utf-8?B?a3dsQlgycnczRDl0em1SUGkxRjlVRWM4aU5OcjBhK1FRUUV3dkxQQ1JoQksw?=
 =?utf-8?B?bHBUMC9Dclc3cG1xakY5ekMyRHp2a1E0d1hOaDlQNzJzYUd4RWk4U3J6MXk4?=
 =?utf-8?B?OTVhb2kySHorem80eWRHcngrZS9EUW9wYVd2azcwcXhZd3k0Nlp5ODBQem1S?=
 =?utf-8?B?dmh2RWYvRnYxQ2FTK2NGWXErVzdkOER5cUpTc20zcGgyQ3JJdm1NRkJlVVRr?=
 =?utf-8?B?WFVqL3VKU1U4djdXblJpNThWV1p4SDZYRzhsU0QvSURYYSt3SEtsY2pHWVN2?=
 =?utf-8?B?MEtSL1R1SDI3RkpISzJGamF2bFNEVVlUbm0vdUNvMVo4bXFlZmVvejJOd25M?=
 =?utf-8?B?VGFHNFJ5ejRxbHlRWjl1SkJ5bnNuT0ZCNXprMDl5Z01qVHdoUzdQUlV6YnZz?=
 =?utf-8?B?MzJxNG9YdUsxb3RGU1FqejVrNnJ6R0k2Zlpxc1h4WEFmR0JBZUZTVUhBVmxq?=
 =?utf-8?B?WkMvOFcwWkI0MGlOVnJnbFpLOGNyRGtPMEsyNnk0UE5TTHpGcUVGNUQ2RW1t?=
 =?utf-8?B?ZnNWMmpSM1liQ1BpOGlURDY3eEFWSnpBeGwxUmtLeElrTW1pVXFnN3AwTndM?=
 =?utf-8?B?Y3dYQmYyTEo5S0R3SDZCK2RqRFJuZlp2UTZNOFpLdnZkdDFjVUR4dEZ2UGF3?=
 =?utf-8?B?SE15VmJveHRLUWJodC9ZZUV3SUhlaldVWWFHcGNMNEdYTjNtY24rS1EwdmZz?=
 =?utf-8?B?dWlNMGNDcWJBKytvUmVNZkNPN0NUS3ZvODRET0s4R0xPdHNUd2RXb093cVI2?=
 =?utf-8?B?aUxGSENvSUcxb2pWb1huWnE4ZllmZm9pODYrUzNJT01wRUM5SUNVK21tWmE1?=
 =?utf-8?B?VDJ0UTE5LzRkVTNFTkE3WHgyU2JPalRSeS9WNkE3ZldiNGNEcWZWeTB5eVda?=
 =?utf-8?B?Ry9iRkVYd1h5K3E0UHBXVitQS2JianpYcktvQTJpck9qcmZIeUJ6NnY4WW9z?=
 =?utf-8?B?Tlo5OTBaMW5kWGMxNjBrNW1yWXhZKy8vNGV3S09aNzFTRGc3OWZSVG5nUjdP?=
 =?utf-8?B?d28yb3dob3Z6QXZiWXVsQ3JYWERoN0IyRVBrdzVWOXlLWUJSYlVzdHB0VURk?=
 =?utf-8?B?bTVIMk9vL2FFSDJ1eFpmdjJMQ2lzd0VQZ1VDUTVGdkt1WFlxdFRDKy84OHpo?=
 =?utf-8?B?YWtCSXMwZ2hBV3RReTZBcnVtZzI1bUR3TUpFOEk1SEFNRm5obU0wTFlpTTF3?=
 =?utf-8?B?Wm1JYzlndTBLRzhDbVVrQzByQ1RZYytmK0o1NnkvT0ZqSFpzbUxzdWZHOXEv?=
 =?utf-8?B?SXdHNzVmdHBoU1VTTmpMZUw3RGNlK0NTZ1NZSU9tT3pCNlFJTHIwN3ZnTU9B?=
 =?utf-8?B?dUR5Qjhlb0pmT1VHem0veEpGcHdoUW1LY1dnbDNvcDUreTQrK1VCTzY3eTN5?=
 =?utf-8?B?VGU1WXdwcGtZZ20vbTJha0ZXNEhueE1TWWZmYUhTUExsUWJrejRSRlFlcmVL?=
 =?utf-8?B?Sm03UU45MDNvYWRMRG9wUHlWVmtOUk9ZN3NOZTh0OHVJTTFtSGI1U1k3Z1hm?=
 =?utf-8?B?djd2ekp0USsyMDRvR0d1K0IweVNETVhqcU14Z0swWGJPWkoyMEN3dllIVFJW?=
 =?utf-8?Q?Rkj5fHLEoWEeDfDA75a8Lcp7B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3pSd2VOVVErUUN3RkgwMWF6bzVlNStJZnBHNUhQTmdvTk9ZYnoxdjdFTVUv?=
 =?utf-8?B?K29wU00vMFdKWlA5RERuS3hGeEEwZG9zWFhoQUI5MEJleGwxaTV5bjY5a0tp?=
 =?utf-8?B?WTFORVplTjBNL2pMcWQ3TGJnV1pTTHg0bFA4MWVzNGpJVklpWW9od2MzUmww?=
 =?utf-8?B?UVJPaGRTZ1FlS0dVSTFlUG5VMzNJdnh2Mk90UXpyaUlaMG1iREZVMHlITnJI?=
 =?utf-8?B?eWc1cCtxMmxUcnZmd1NnanlDQlU3NE9PQXowNXlBWHAvM2JydC85VlcyOWJr?=
 =?utf-8?B?TjFuNXQ4VS9IRGVwb1IzZ0Exem50UDN6Um1kSWpDNE16bXljNWlnUGlCci9k?=
 =?utf-8?B?cXh6NTVKTEhQU0ZSR3ZzdklKREFHSkpYR0lXV0NMTnBMeTZ3dUtsb2xQWnY5?=
 =?utf-8?B?YVc0QlNDSWZ1QXBPejlPTitvVzR5eEJ0WmUyZ3NBMFdRTDY2ZDdyUVdYL0My?=
 =?utf-8?B?YjZlM2k1TFdZTjdIZUlEWnVaRkJaUDJRdFpBSksvTmtuSlcyMUxtOWdKbysw?=
 =?utf-8?B?eFF6K3dlZWNTVDB3REppNm5MeG9UN1RWMHFzUlVxT1c5amphTkJBUnhxbDNm?=
 =?utf-8?B?T0RvNnA0eFQwbmZUWDd6V1RRbjhFUkZaSC9CUXE1N2J5aW5kbG9keUhBRFoy?=
 =?utf-8?B?d2ZQbVQ1VllzNVdaM1REMi95WkErNk1wK3l6bk9IdmhqUHhRb2xwZ29wbldX?=
 =?utf-8?B?N09IZC9wcm1SYVZzQ0RHOTNDWThlbkhlZWpjQXBPVFNHcjY0L2ZvSDVBSFM3?=
 =?utf-8?B?MmxKN005aDJoRjlqOXpBZTF1RjE1OWkwRUpWQ082M05pcE8vczdGelBSQklM?=
 =?utf-8?B?bEo5eS9aY2Q2SnM5TkY1a1VRSTJvcno1QnZOUlpTTExJNmh4MHpLc1VHbk0z?=
 =?utf-8?B?STU2MzVwV1JxdFJWSGdxYVgrdVNSaTVITDRTb0d6cWhaMXpLL1JtaEQ5cm92?=
 =?utf-8?B?d1h4R25Tczd4bzRVdkoraEE1cXFjNG5YdHNFVXdsRXNKNksvYXBYbCszR3ZB?=
 =?utf-8?B?c09Gdy9PVCtKUGF1NDNSTDJqUDFpOGMydEZSbGJrRnhVK2tTVG10azZsOFI3?=
 =?utf-8?B?WnJrbkFxMkU1d1VwTU1MTWY0aTlrUC9vUDFEdytzNHhkTjFyRkEwWjF2SFlD?=
 =?utf-8?B?a3hDUEdidW9WNmdhcVViUFhsNEtxdmZsb3VJSndzTFEzQi9GYmhLalFXM1RU?=
 =?utf-8?B?a2tVbTl6Q3lsWVhsQ3MwRGRuMFI4WUV6R3dBUXRxc0h2WnAveHlMaDhTclFw?=
 =?utf-8?B?T0FVYjFUSUJ6ZEVhVEJKL2c5QlZLSEozQnVIeUZDMXY3NWlwNTlvMGNLRUFZ?=
 =?utf-8?B?Sk84dVlDWTVncjFPZzFuWlBYZ0JtbTZwWTY5d3hpbjQveEJ0aEc1RGdYWXlW?=
 =?utf-8?B?WlFydXp4VjAwdjkxSkdtUm5yUU9kYW9TcFRzd0dGMUExck11UjZmK1ZYeVl3?=
 =?utf-8?B?RVpxeDBId2FCMk9pTmtRV1BEaGxSN3BkZ210NzJWdE1zNEQvRXI4WVNTVWdC?=
 =?utf-8?B?djNWZmxXVUVxeklGKzhQUUtvZXlkZ0tyTWZtN2t2TWFJaHBYT1hKc096b0lm?=
 =?utf-8?B?dkRyM3VWSXdCT1VFbkZHQ2RYM1ZPTGF4ZWxZR0l2R1Z1bm5tSTZiajBFb1Bq?=
 =?utf-8?B?RGI0NXRHLzlacHlkYks3enA5R1NzcGZIdzFWYzM2RVhONFRVQWtERHJlbmRZ?=
 =?utf-8?B?QU1Ta2pNWWV0bVM3Q0dmRFo4OUcwZUM2NE00cGdCdzZuWVdQeWN4Q0xKdWxL?=
 =?utf-8?B?WWlDZ1orKzFxc3Y0OHAzdHJOMkpNdnVhQ2d6TnZUc25GT1dEbS9ITGlkMjhZ?=
 =?utf-8?B?c3hDK3ZJMk9tN0dZdVdHa1pxb3MyTUVDVWNYclVmbHN2Z3Z1UFVmT3JHVFdB?=
 =?utf-8?B?U1ZoMFp0MEIwVzR4Q25NNHRWcDRrOExCZGc1eTZadThuZzRFaSttV21oM2gy?=
 =?utf-8?B?cks2MGRhMnIreTF2cEtKbWFDM2dPdzN5czJlODd4a0d0ckVKT3NTaHIvVjYv?=
 =?utf-8?B?SHZIamo3eEt4NG1nOENWWi9MWm9KdVRlU3NYWUJOZlFCcUh2NFR3Y1djZnBE?=
 =?utf-8?B?TGYyTmJhb1k1MzJQSEJMVEZzLzdoRHhzMDcwOEpOK2doY0RxNU5oNmo1TWdZ?=
 =?utf-8?B?a3lHbmVqZmZNN3NhcnlZSjVyQ0VJZkx2THlUUXdnTW9aamZZNUZLQ3JXZzhI?=
 =?utf-8?B?MHJlSEZ0cjM2QmVRNWdWY3ErdGd1aEN4Q2Q2MjByV0I5NVFOVTdlc0NoWVRl?=
 =?utf-8?B?dFUrK1drTzFoZUFWZHNZaE13RVRoaFVTMDlZVjBZN0J5L1ZjMlFKMUpQRVFG?=
 =?utf-8?B?aUlOMlBpUDRLblNVZ2dReVZOQ2hBQzU4WVEvZytSQlhoeWRwUVNBQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4820c0-f02d-4953-2dc9-08de7429bcfc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 04:52:54.9568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAp25D2VEwJH+MvD77O1EFrAKncm+KqiLDlQMcLfYsuykbrHKIoOXU1K1qhK+LwgErIP9Nz0Dsy1WPTKxCXZiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6223-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaihengf@nvidia.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7A39191ABA
X-Rspamd-Action: no action

Hi Shiju,

On 2026/2/24 7:23 PM, Shiju Jose wrote:
> External email: Use caution opening links or attachments
> 
> 
>> -----Original Message-----
>> From: Kai-Heng Feng <kaihengf@nvidia.com>
>> Sent: 23 February 2026 06:49
>> To: ardb@kernel.org
>> Cc: Kai-Heng Feng <kaihengf@nvidia.com>; Rafael J. Wysocki
>> <rafael@kernel.org>; Tony Luck <tony.luck@intel.com>; Borislav Petkov
>> <bp@alien8.de>; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; Mauro
>> Carvalho Chehab <mchehab@kernel.org>; Shuai Xue
>> <xueshuai@linux.alibaba.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; Morduan Zang
>> <zhangdandan@uniontech.com>; linux-kernel@vger.kernel.org; linux-
>> efi@vger.kernel.org; linux-acpi@vger.kernel.org
>> Subject: [PATCH] efi/cper: Add NVIDIA CPER section support
>>
>> Add support for decoding NVIDIA-specific error sections in UEFI CPER records.
>> NVIDIA hardware generates vendor-specific CPER sections containing error
>> signatures and diagnostic register dumps. This implementation decodes these
>> sections and prints error details to the kernel log.
>>
>> The NVIDIA CPER section contains a fixed header with error metadata (signature,
>> error type, severity, socket) followed by variable-length register address-value
>> pairs for hardware diagnostics.
>>
>> This work is based on libcper [0].
>>
>> Example output:
>> Hardware error from APEI Generic Hardware Error Source: 816 event severity:
>> info  imprecise tstamp: 2025-11-17 07:57:38  Error 0, type: info
>>   section_type: NVIDIA, error_data_length: 224
>>   signature: HSS-IDLE
>>   error_type: 0
>>   error_instance: 0
>>   severity: 0
>>   socket: 255
>>   number_regs: 12
>>   instance_base: 0x0000000000000000
>>   register[0]: address=0x0000000004f10008 value=0x0000000000002019
>>   register[1]: address=0x0000000000000000 value=0x0000000000000000
>>
>> [0] https://github.com/openbmc/libcper/commit/683e055061ce
>> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
>> ---
>> drivers/firmware/efi/Kconfig       | 16 ++++++
>> drivers/firmware/efi/Makefile      |  1 +
>> drivers/firmware/efi/cper-nvidia.c | 79 ++++++++++++++++++++++++++++++
>> drivers/firmware/efi/cper-nvidia.h | 33 +++++++++++++
>> drivers/firmware/efi/cper.c        |  3 ++
>> include/linux/cper.h               |  4 ++
>> 6 files changed, 136 insertions(+)
>> create mode 100644 drivers/firmware/efi/cper-nvidia.c
>> create mode 100644 drivers/firmware/efi/cper-nvidia.h
>>
>> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig index
>> 29e0729299f5..ed1f53b8e878 100644
>> --- a/drivers/firmware/efi/Kconfig
>> +++ b/drivers/firmware/efi/Kconfig
>> @@ -329,6 +329,22 @@ config UEFI_CPER_X86
>>        depends on UEFI_CPER && X86
>>        default y
>>
>> +config UEFI_CPER_NVIDIA
>> +      bool "UEFI CPER NVIDIA support"
>> +      depends on UEFI_CPER
>> +      help
>> +        This option enables support for decoding NVIDIA-specific error
>> +        sections in UEFI Common Platform Error Records (CPER). These
>> +        sections contain additional diagnostic information for errors
>> +        occurring in NVIDIA hardware such as GPUs, switches, and other
>> +        devices.
>> +
>> +        The NVIDIA CPER sections include error signatures (e.g., PCIe-DPC,
>> +        DCC-ECC, GPU-STATUS) and diagnostic registers that provide detailed
>> +        information about hardware errors for debugging and analysis.
>> +
>> +        If unsure, say N.
>> +
>> config TEE_STMM_EFI
>>        tristate "TEE-based EFI runtime variable service driver"
>>        depends on EFI && OPTEE
>> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile index
>> 8efbcf699e4f..a571b6086860 100644
>> --- a/drivers/firmware/efi/Makefile
>> +++ b/drivers/firmware/efi/Makefile
>> @@ -42,5 +42,6 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)     += capsule-
>> loader.o
>> obj-$(CONFIG_EFI_EARLYCON)            += earlycon.o
>> obj-$(CONFIG_UEFI_CPER_ARM)           += cper-arm.o
>> obj-$(CONFIG_UEFI_CPER_X86)           += cper-x86.o
>> +obj-$(CONFIG_UEFI_CPER_NVIDIA)                += cper-nvidia.o
> 
> Hi,
> 
> Is drivers/firmware/efi/cper.c the right place to log vendor-specific errors,
> given that so far drivers/firmware/efi/ only logs CPER information defined by the standards?
> Vendor-specific errors are currently logged and recorded in rasdaemon.
> https://github.com/mchehab/rasdaemon
> https://github.com/mchehab/rasdaemon/blob/master/ras-non-standard-handler.c#L52
> 
> If some kernel-level  recovery action or logging is required, we can also register with
> acpi/apei/ghes using ghes_register_vendor_record_notifier() to receive a callback.
> https://elixir.bootlin.com/linux/v6.19.3/source/drivers/acpi/apei/ghes.c#L652

Thank you for the info. There's indeed an ACPI node for CPER purpose. I'll see 
if that ACPI HID can be used for implementing using 
ghes_register_vendor_record_notifier().

Kai-Heng

> 
> [...]
>> +/* NVIDIA Error Section */
>> +#define CPER_SEC_NVIDIA
>>        \
>> +      GUID_INIT(0x6d5244f2, 0x2712, 0x11ec, 0xbe, 0xa7, 0xcb, 0x3f,   \
>> +                0xdb, 0x95, 0xc7, 0x86)
>>
>> #define CPER_PROC_VALID_TYPE                  0x0001
>> #define CPER_PROC_VALID_ISA                   0x0002
>> --
>> 2.43.0
>>
> 
> Thanks,
> Shiju


