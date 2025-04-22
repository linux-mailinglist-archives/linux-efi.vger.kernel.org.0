Return-Path: <linux-efi+bounces-3412-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CD5A971AA
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD711896A91
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60D28FFCE;
	Tue, 22 Apr 2025 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EfFdBhSp"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392CD28EA67;
	Tue, 22 Apr 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337114; cv=fail; b=ugS/94DdiQWpOX+5qxdcPGR2pyLYFvU4Gcixzuqqs9+SvexVL5awIIVZyE7Bos7eBZPZnoX1kdzPx98hi79hzT1ABVMrMk81tmK+sYcsAU6jbAIbptL3tw2eEVpGd+gbUV7yvE4UcBPfyVitRZig0quYHgxDL0OIW1Wxm93kc28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337114; c=relaxed/simple;
	bh=gP4h1EewqDz9MXnzne3yuXZUo3AdhAQyaIo8fiKu1/E=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=fnFSKJ9lt93afdNItZHL8xbeZQbfYMRNxK1kmHs0abi8YZZwrAHJ8QQ+0NzAQHRu9mYLBuwX+aQcKdeiCxRDmQDwaRUBT9Btoi594Gr0lmePe+Sap8c1lcnLFKrCzP3JiqR1bqKC33YfjUX3kPh3PvrV1Np4wwQDadBsIgIVDFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EfFdBhSp; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfA7ZgakKxt+sMdluKFxr7hLEhFzQ3PrNCPuaGlyCOZZyFoTcpawMChMdBYm6SpMtb2RgtjksaNf3n5XHCFoxTiuFLHO3SdZWLU7aQ11eRvCoPRxumk7LtV6Qa87jFWRo1n/KORDdZBx6ngUy2YA9aPnYUKNDhhnT9oJrkk2ngPtaNUcsuFEqDpbttnAysMopiHl6P8h1G1XnZCTXKloZFOiZ+elkP/NgmrGZIC1sNxhKsJFLrWKIO37lDhxOkJpkWLJcxL6o39yE+eqvD2i3Fy0T5wtVj9PczKvXS7Y/MeOFLTffOlF7lCB8jjZl52X/Zte4vyw0iM4hhZOprXpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYkxjHAfnhWXWAtH5kVlfpHCtk/vXTT/yvCSIW2EFOU=;
 b=Z3S0jnR6TI59Uq5JzaiLg4PqzpnL8ij1jnb0rE2WvoQ+qiu09cRXdTJrp+vxQxPWvHtQ0oAEQ/FGmyblDbMKa/Mm6xL4w9/UetVxz+7KRqndBXXkYmqcwufl/UXdFChooFs+5WMiO6MISryDBAHMmDKatA7qN5aSFzb995+EclEizrAFjCR/j6yRGj8cSOtjyhbFr4WDgEno0jERveRYUNhTdt4EYt1WZA8wBYiA2wD7BB52B4zqAddBexp7PZ27wZxl2JlIErMyD3nFBOgaLs6rpbe4/ZFREjzX/Y/U6B6BZEbZVQemRKj8d3vdYyy/UfCQmBWIsOroWQ9iEzAO3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYkxjHAfnhWXWAtH5kVlfpHCtk/vXTT/yvCSIW2EFOU=;
 b=EfFdBhSpJBkcn+fsS6Qg/O+V8DkcH1JaMl1g8qnOJbfvxGjnDMgkSMs3/OAyblKfRuc6ZK8mKPjC4k7eJLBjWvOOpP41Yio9+9Mqi2KNY98wjbaHBFI+hWwJn6fjsKCuFUyOPe00jyjdErLCLTMGm6aSq1sVxNiUoGwDuJWlMpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Tue, 22 Apr
 2025 15:51:50 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8678.021; Tue, 22 Apr 2025
 15:51:49 +0000
Message-ID: <d00c9119-5e8b-2615-8e4b-2d25732ff71a@amd.com>
Date: Tue, 22 Apr 2025 10:51:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20250422100728.208479-7-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 0/5] efi: Don't initalize SEV-SNP from the EFI stub
In-Reply-To: <20250422100728.208479-7-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0239.namprd04.prod.outlook.com
 (2603:10b6:806:127::34) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: b51663cd-7ee4-41b2-471c-08dd81b59804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDdYWGl6V0xMTE5zQ281OGxadGtrUE9WaVJ4OVVuQWNLaHo5TVB1Y1krSVpy?=
 =?utf-8?B?ZEsyL1ZkWTdQSEpjVzZGS05jeXh0WXhYSFQwbWowNDhmVkFNOHNCbDdNdEM4?=
 =?utf-8?B?N3FoRXdMSG0zeHdKalJ3UXdaOXEvY0VFUCtGYllZNnNTMk9KR3NjT1UyeVM0?=
 =?utf-8?B?eU1jOXFDb0ZwR0I1Nzlhdk9pWHVWNENHdnI1STJ3b1lOZE0wTlVWZ0Rkc0Yr?=
 =?utf-8?B?cFV4TUNDWCtiZGY0MjQzNVpwandxNW0rdHNiZngwTks0Q083QzZ0MFQzbmov?=
 =?utf-8?B?OUxKdEppYXZ5UUJjSi8vSUdHUnJJajV2bkF6djRjcGNWajhjMUd0QUZBYXVY?=
 =?utf-8?B?MkwzR21aMzhzbzE4R1RyZGFqTWdLZmhVLzJZZE13SVNQUlcrbjkxS2R5QjdJ?=
 =?utf-8?B?elZuNlIvWEVEeUJTeHJINHRTUUszZ29zQWxwcG5ielBxRHN5NDFFUHp3dkFY?=
 =?utf-8?B?TEZnVkQ5TUdqVzJSR25ua2Vjd0s4aUFrcytmRmx4eXRMQXE1SmdhOURaaHRJ?=
 =?utf-8?B?d3BoY1RXTTRhTTd6TWJ6WVd0T3hRV0RQeWRFK0F5cUt0TlZ2dVlGenltTmx6?=
 =?utf-8?B?NXJlTXArSTJPc1dsZUU4aXBaNE50WTV3a1Q0T1p2Zmh4VUNJcldRNWZNeEVG?=
 =?utf-8?B?REUzS2c3VDJYKzZGMk1QVjdTT1BYY0RtM2JVNUFxL09iRERRKzNNNWxzS2NF?=
 =?utf-8?B?Y1lld2tqRDNtd0hGOEsyMFFaVUtwWnpXcmpFenNiRGdMZ2gwVlZqSXVLbEpy?=
 =?utf-8?B?VTYwQ2s2Q1R0WUpXYmxvdXV6ck5FYUp4RmJrNDl1bkRoWFFGZ2Y2KzRDbERS?=
 =?utf-8?B?YWVGckhMa1kwV2g0WDVlb25rYXdjYjZNSWNNd2JRd2dNeGFYOWRhSXo5YXI2?=
 =?utf-8?B?M1J5ckw1S0RDR0tuamNuSHJCMjRzOHN0bWZ0ODFQT3lidGMxcXI2eld0N3FC?=
 =?utf-8?B?RjBvZmE4SDVtRUlOc3kvZ0pEaHlncEhNQzZxaGFhdkltRmhGMFFleEVDZ3Y5?=
 =?utf-8?B?OHR2cEdKTlZMWFVMemNWem81T0o4MEt4S3MwT0VOd1JLMEVXNWdDdzgrdVNo?=
 =?utf-8?B?bFd4RUlPMmN2MTZ3L2drYnpTenhGcmF5TnJtTnJKOVNOcjRuQzl5MFZKTUEv?=
 =?utf-8?B?cEZqTUVLZWg5V3dvTTVKMEJLVTVkeElPc0x1UGVPeE9uVVJIQkRXUnh1WkhT?=
 =?utf-8?B?dEx6NWVXVjJYWWdwZW9NY3lQd1Q5WWFESGR6MDloWk1nVk9HNmJZVmNCVGJu?=
 =?utf-8?B?UHhHc3VFNm5pMkt5czlSckcxTExDRlY5OFI5MDhHaEI4WWp3MDlPdFZSZktP?=
 =?utf-8?B?VXdxNDVaWUlSeDdncWNEV2JWZnFnaTMzbWNtdGRRKzZoSlJpWDZ1UGhxVm93?=
 =?utf-8?B?b0loeFF0MkZQSnM4cGlkaUR0R1V4RWljZFJmNVYzZ05EVU1zT1loM2tDeTdW?=
 =?utf-8?B?V1lUcjFiSVFubmRDTENLc3gvcVhKa0ZRTVlzT01LOTdFU2hnaWFsdFF6Zjlt?=
 =?utf-8?B?bFNadzA5VUpUN2tpaVlHcXNlTEVZbGh6bWpjM3RncTdlbUNlWEdUNUdtS09m?=
 =?utf-8?B?a003eVNZQnRFWWZZZjRHYlhJb0lWbnlqMEg4ZlNRRHFaaVlORWovV3lBZzhk?=
 =?utf-8?B?Sm5CSTVXeldQclVLcnRseklqRVAvMkdhb0hXR01PcGwwc0s2bGptM1A5Nm1K?=
 =?utf-8?B?bmpLUjlQMGxpaElRekxUUWZtc1Zzc1BXNG40QTh6K0Q4SWVWQ0krU3dWZHg2?=
 =?utf-8?B?QUx4aTVwNS9CWUFxZlRHQkpMd2tFcVU2aFk5UHY3eVk4VnhZamNNUW9GSEkz?=
 =?utf-8?B?a3NyZUFpT3ZVOXUxc2gwMTYyUUdhZ1lTajU0NE5YUDdmSUVwbnBBOVRVQXVD?=
 =?utf-8?Q?qVjBxVSY4WP37?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXVvMk13QnRyQTlPMElGcG1nNUtTRFd0Z1JGY29GclFHVHRWOFdrMFpvM1Za?=
 =?utf-8?B?QTR6aGlwRHlLK3dFZ0QxNTIxMzRrdGVpd3hpRmM5QXYrcEd5NDBIdEt2Mzd2?=
 =?utf-8?B?Q0U0VXBpSGNqbmV6QTFBb2J1YjNjbFJ0aG1OZlVtTHhmZ21RaXkwclVKb3dB?=
 =?utf-8?B?UVVjQldPNCtUNXYzREdaV1Y2RGx4TkxzaUViZStsSG1jZHlTdjdnZ09FYm1r?=
 =?utf-8?B?UDFnVUlnWUNHYld3ZjQ0bW93ZnQycm1KRXRBZ1ZvRGRKRnQrRnF0S0xQVGRu?=
 =?utf-8?B?NTlqQ2trU3ErQ1ZrQVd4ZmVWRmFCUjJ0ZlZGWi9uZit0V1hubWNXMW52YTNr?=
 =?utf-8?B?cG42RUVxT09WTFBneFVScEpJOW0vYnRaSERidDJSTmMxQkxsOHBnUGlPTWZy?=
 =?utf-8?B?MGFTcTA5aEpoY241UTVPVmd0TDZ1bW5wemhWUUhFVUY5Q2JQNTNTNDUwZDE3?=
 =?utf-8?B?MDJCMjRDdm9yRmVHK0xBS2xnTEdwMkRDOXBKZFMxZ1VTVlp1c2svTUc2ZkpC?=
 =?utf-8?B?blhSUU1VVmJNRU5oQlNmSGFFdmtyWVhleWVrUnkrYnRuaDA3ZklFd3Z6ZDNZ?=
 =?utf-8?B?Wm5FTmdXdGxHY1VCNi9hbHIyMHRuTjFESnM3Q2V1bG9WK2VZMjc4L084YkZC?=
 =?utf-8?B?YnZRei9BU0J4eEFvTC9XYm1IME9JcVNFYW9yY0NjTmY3RWpzSE5EYjZZMEVx?=
 =?utf-8?B?S0dQRDZ3b0Q2U0ZDNkoramJnNzVCdms2cWxBVllJaUhDYzFqSEt4NmJ0ZzJ2?=
 =?utf-8?B?ZnNWVUFZdDB6emhXYkhodDJJVXYvOEVPNUpuaFZYc05BRGM4Tml6S0ZvYzI3?=
 =?utf-8?B?RU8vT1ZuNW9KVzdGUStRdWdVUSt2NTM2REozM3Njc0YrM25raHk3WkZDLzZT?=
 =?utf-8?B?enVMVXlmYkVaWG5tNE5tU2U4aEdHTDJ5ZHdEOGZ4NDljajRSWlkwZ2h4V1Bv?=
 =?utf-8?B?aUpmSi9CMHhSbHpjUGV3MWlxaGc4cXJaNlI3Yy9vWjFqK0Y5b2RxM1M4L3dX?=
 =?utf-8?B?bkNSNURwSlQ0RmxsTWgvajlVTUtsNThOL0xzWWhOaGtQbEZqVjkwVVBpWERB?=
 =?utf-8?B?ZHJGQWJJSGtSRjdzUytESzN5RTdRUk9rVmZtY252VDlmVmk1Z2ZNQ3NDUTNY?=
 =?utf-8?B?V2h6Um1oMG4rZFNwRUJmZWJYbmMvMmw1Ty9uVWVmSStPb2NjTzR5dWs1SWVh?=
 =?utf-8?B?aDFHQ0ZWN1pFb3RML2dYVnRROWxzbEZiK2NKcEo1RWcvZ3V3Q3A4RkloV0dq?=
 =?utf-8?B?V3pyN3NQcTJjQUo1UU01b1pManZURURvR0dNRHNuMy9neDBXOUJQMzVzRlRZ?=
 =?utf-8?B?eVpwWElWY1d2anVSYjBHL1VreGRzL3NVemtGUFpPcnhxcVRvOVJlMjlQK0lw?=
 =?utf-8?B?Ujk5bU9lYkF2aGx1Y2UyYk9oZnM3bW8zek9JeEhmQzA3OTk4eERMRnF2N0Mw?=
 =?utf-8?B?VjJicDBrT3dsRm5yN2FuMklROEJWeHp1bG1RaGZ5bGp6elNKQzJjaFVYUnpZ?=
 =?utf-8?B?dVhaU0RlUitmaXFreERkTWJ3VDhhS3dXTDVDbDd3UkVuNExBOGNxSHQzcHJn?=
 =?utf-8?B?dEVqNzRIcG9GcjV6LzhaRVNEb1M5OXh4NzNUSk1ZSEFIdGE3ZDlIQlZSb3hm?=
 =?utf-8?B?TzdLQVNEek90cXVZSXpjNmdROWU0eHEzNkN1M0NxTjNFS2o1NXBsWjBPbExS?=
 =?utf-8?B?emx6b0lPdGE4NU4zdjhzbmlLdHJwUWQyR3N6ZG56cmg1U0dWYmZpYkJXTnJz?=
 =?utf-8?B?cmRwd3N2VkdnTzdmMUl2dDVURGhtNWd3Q0hPdjhkQWgrUVRpcWF2Wi80ZWRD?=
 =?utf-8?B?MGVhWHVuSUd4TVl0a1lSTWZMMTZQcjNTSlQ0b3ZIUkVQM0ZmZmUwc3ZiTkk2?=
 =?utf-8?B?ZC9mZG5ZVVN1eGd2byt0bDNyMEJPbVc2dmozeVVtbkdNTHZvekF4enZqY0Qr?=
 =?utf-8?B?MlMvdm1PaGZ4cVhraFFTY3MxaS8zS2tQREJ3b1B6MFdBUDRIQ210TFk4UkRp?=
 =?utf-8?B?dUY4bGk1OEV6U0dWMVFhNWhTUVY1QVBsaTRETnJrNkJGNkM0bXZTS01xQmlL?=
 =?utf-8?B?YjhSRWVvaUltanR5dGttUjlOazB5aWNCU3pZT2NmLzFmMkpybCtQbGhBOW04?=
 =?utf-8?Q?gWOPULM8BGcjtCfsDvF7qWNWb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51663cd-7ee4-41b2-471c-08dd81b59804
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:51:49.7702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKFnonC728b1RJGdhrS+d+QsxleByp+huSHpC9/utp96SG75GXX2GQzL+0EyDPS1GIFH1Xtw5yxER9n+FIUiWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

On 4/22/25 05:07, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 

Hi Ard,

I'll try to get to reviewing and testing this series very soon. But one
thing I can see is that we never set the snp_vmpl level anymore in the
EFI stub and so PVALIDATE will fail when running under an SVSM.

But I don't think this series is completely at fault. This goes back to
fixing memory acceptance before sev_enable() was called and I missed the
SVSM situation. So I don't think we can completely remove all SNP
initialization and might have to do svsm_setup_ca() which has a pre-req
on setup_cpuid_table()...  sigh.

Thanks,
Tom

> Changes since v2: [1]
> - rebase onto tip/x86/boot
> - add patch to remove unused static inline fallback implementation of
>   sev_enable()
> 
> Changes since v1: [0]
> - address shortcomings pointed out by Tom, related to missing checks and
>   to discovery of the CC blob table from the EFI stub
> 
> [0] https://lore.kernel.org/all/20250414130417.1486395-2-ardb+git@google.com/T/#u
> [1] https://lore.kernel.org/all/20250416165743.4080995-6-ardb+git@google.com/T/#u
> 
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: Kevin Loughlin <kevinloughlin@google.com>
> 
> Ard Biesheuvel (5):
>   x86/boot: Drop unused sev_enable() fallback
>   x86/efistub: Obtain SEV CC blob address from the stub
>   x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check
>   x86/sev: Unify SEV-SNP hypervisor feature check
>   x86/efistub: Don't bother enabling SEV in the EFI stub
> 
>  arch/x86/boot/compressed/misc.h         | 11 -------
>  arch/x86/boot/compressed/sev.c          | 33 +-------------------
>  arch/x86/boot/startup/sev-shared.c      | 33 +++++++++++++++-----
>  arch/x86/boot/startup/sme.c             |  2 ++
>  arch/x86/coco/sev/core.c                | 11 -------
>  arch/x86/include/asm/sev-internal.h     |  3 +-
>  arch/x86/include/asm/sev.h              |  4 +--
>  drivers/firmware/efi/libstub/x86-stub.c | 27 +++++++++-------
>  8 files changed, 48 insertions(+), 76 deletions(-)
> 
> 
> base-commit: ff4c0560ab020d34baf0aa6434f66333d25ae524

