Return-Path: <linux-efi+bounces-6114-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHYMD4QAjmm0+AAAu9opvQ
	(envelope-from <linux-efi+bounces-6114-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 17:32:04 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BF112F76D
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 17:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D7673072469
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47935DCFF;
	Thu, 12 Feb 2026 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=edgeless.systems header.i=@edgeless.systems header.b="W+dxOqi2"
X-Original-To: linux-efi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023080.outbound.protection.outlook.com [40.107.162.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C118787A;
	Thu, 12 Feb 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913823; cv=fail; b=FbWBKlJJ/gys8kXOH0dk38hurIKS1TFdsFUo4ufAWpQ8xluEO4qI/vSs89cxPhis5vuJtvFC6WTdBA9SHbhq6HiQB40+f3QuD8QDGDcy7s9IvqNKMNSSnHltYRVo5aVPydbDXVr0/whejZvMiOioDwl342T0qtvYe5toqf/s2Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913823; c=relaxed/simple;
	bh=kNfu1SdG5s/layM4YE8zGz0/B7z/yuBR1wyvccqFjI4=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=NgTOWACsPnedAqW97ATdBRb74SthcQhUV9Xx6zgGSTr9Jprzta7rsEOq+zbrGv50ZgfVDe+xgLlfBwZqLGLu1QRHh9ygX8a2wBv48WK8TbEWH6hIJCitsBx1IVVFGXgy8KczLxRVB4q78m8kklapBGDI4jTRLA0617SkxU0Kb8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edgeless.systems; spf=pass smtp.mailfrom=edgeless.systems; dkim=pass (1024-bit key) header.d=edgeless.systems header.i=@edgeless.systems header.b=W+dxOqi2; arc=fail smtp.client-ip=40.107.162.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edgeless.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edgeless.systems
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAOmqhPhI2EI9LlivZIoshynoW1c5EE145kXxVibibzQP0ty1IQgxD1KhoXscjR2sQqXL4+e0eRNs6UXhxEVrkRtI0mOTy+NjC39e/04K3ghCbrbGfXU2QJH1dOWk3qsazulccNut8TtZmmpv0DVoD8QsW9F1XEfIyZcPSNZiwKZrgMtsscXMWKr+KWANRGix30DOfgZ4FUnKerXkjR08vCa98Wkpm+o/vXN6MFfUY+2h+0vnp3ucgq7RoJJLBa0akbkSMzb1lAsIhlzyv4S1lmheUnoG8754c5pilfSXgsS7cOt0p7u8qjEyS9RHBNOA+14wigDhEg4OeLMDEshjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7J0CQgitltlmh28oNh88RVJbY3U7z+vO9pGP6q5jbo=;
 b=RO3zs/wwgnrP5DsYDr8ms9NjDa0bDjyZrEB2I5ZR+GhcxpfRCxjj0zLjIG0ZY4bmysxDyogQTBPLTwWq694nq/etUwYoF3M9MWLwbgCUTazlsJEyDTMC649UgI8tDz+2MlaSpcetu9Dsmrea1kicq57DXtYQkDs20HiS3rCEHhGPB7Js4qi1RUuAHg0TATw1gg7evOcB5daxegb7SvgBQGzKQ59/p1ZYtejYjCbiOu2um60gkvbqm5YiTKCZ08UxR45YL9I5/KKmKzfkyw9lazFVLbDpv30E7OIacX+xb0haQlYlt/cGheKDApLFuWqjLWe3YqM7KBIWR/i6wXnecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=edgeless.systems; dmarc=pass action=none
 header.from=edgeless.systems; dkim=pass header.d=edgeless.systems; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edgeless.systems;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7J0CQgitltlmh28oNh88RVJbY3U7z+vO9pGP6q5jbo=;
 b=W+dxOqi2+pnOPxCoyZALd0EvU99CSM9v1QeT30RYnV4EqePXJO2QjI/00enhGSTxE6wx29siwO2vCGEW5HQHcGF6EyaYWOTpf7XlpUMuNz06LoSl8ola2lEw8jUKNmEsP1BAG9+KBbyvA2g3d+1fYIK+G6P9ULZUj7nygMwPCAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=edgeless.systems;
Received: from AS8PR02MB9459.eurprd02.prod.outlook.com (2603:10a6:20b:5a3::12)
 by AS4PR02MB8720.eurprd02.prod.outlook.com (2603:10a6:20b:58d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 16:30:17 +0000
Received: from AS8PR02MB9459.eurprd02.prod.outlook.com
 ([fe80::815f:fa6d:197c:2470]) by AS8PR02MB9459.eurprd02.prod.outlook.com
 ([fe80::815f:fa6d:197c:2470%6]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 16:30:17 +0000
Message-ID: <c2632da9-745d-46d8-901a-604008a14ac4@edgeless.systems>
Date: Thu, 12 Feb 2026 17:29:51 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ardb@kernel.org
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
From: Moritz Sanft <ms@edgeless.systems>
Subject: [BUG] Fault during memory acceptance for TDX VMs with certain memory
 sizes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0139.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::18) To AS8PR02MB9459.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a3::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9459:EE_|AS4PR02MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 41587d92-5c38-45a5-6604-08de6a5401a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWh0TzU5OC9RMExLTmQ4TGVwazlUU2VEa3o1L1ptU0RoN0RvL1F2aEVoVHpj?=
 =?utf-8?B?aHE4TGxMdEF5aW81c1lmbWo4RUxNVEJVbURkTzA2dVpmTG9scDRQaTVlb3d0?=
 =?utf-8?B?d0lVOUNZM01IdTVCbEc3bmFVUFRkVFduemxMVGlyczJwVUtBSVpmc0pOWUtW?=
 =?utf-8?B?aE45ODBqWkMyQ1o3N0c3WG1WWEx0WnRqTnlqL3kxQ3R4aklyai9vTWtIMkF4?=
 =?utf-8?B?Vi9WM28yMUl6V1JsMGoyVm9qSFdkN0hwVEl4ZkpQd0hocHV2TzhRZDg0YXZL?=
 =?utf-8?B?bTUvVmxMU3JJU0VSbG1oK3h2d2JJbEdZeVVmUXkzaDVVMTNYY3ZqbWJLY3px?=
 =?utf-8?B?R0lOcVo0dUFDcVdVSDdCOWtQZkJ2bXEvYTFmSThyVlkvU1phSDdyVmd5WVlS?=
 =?utf-8?B?eEdlUHgyZzA3MW53UHArMEo4YnlwYnlGZ2dOR1lqaG9PeFdIdzNjTlY0YUk0?=
 =?utf-8?B?RzhTcWJhRWRHSnZKYkQ4L01IemdCZS9wVmNka1ZKU3RlaThTejlTTE81VGdO?=
 =?utf-8?B?bEZ2cXFsaFNsM3pDT01Bc2RWTlMvalMyNXk2VkdsMGpNK2ppeTdZL1VwMXpn?=
 =?utf-8?B?ZURqdnZxVlRpeGh1V1VyMXpQaC8xemkvekJVdDlMS2JLNDl5QTdSRzNCbklV?=
 =?utf-8?B?TnUwWjZ3YlVaS09oVGtYSHhEMVBISlZNZzVDeEdvNko4MFo5V1l6eWphdDRN?=
 =?utf-8?B?SzBVL0t0VW5oZVZESlkxcm1kaEUyNXhjTHBSZlQrTnBMVGt1eFlYdUt5aHhs?=
 =?utf-8?B?T24zcDE3VUI5S2pJZFVmbDU4MVpOQ2UvckpWMStKZHIybHIybHlVcVp2ZWV6?=
 =?utf-8?B?eWViQ09zS2srSERVSFdzeGwxNC8rRVpGM3d6T3o5OW15YXlGVXk0TFNqWnBz?=
 =?utf-8?B?bEpkTitRcWdWRHlQVmwvTElJQkJhQk9qenB0QmFDMzV0TGdjZzJ0djMyUWZu?=
 =?utf-8?B?MjN4anRXNnljbTMrSzl2bVRxUnNEWWhVK1FBUmdLNHJJRnV1ZW0rVEcraGY2?=
 =?utf-8?B?c2MvUlJYZVJONWVlYTN2L2MvK1EvQ1RFbGtDR2krYURBcmU3YTVsRi9jemQx?=
 =?utf-8?B?Y1J3Y3BySTZxRzJnMVgwdWtrUGRLZE8zdGF6VEpoZ3BQcUpESEVRcW9GRWcr?=
 =?utf-8?B?eWhQQjRvdExGOGRZUi9VQ09pU0lKM25mL1pWOURaSHByTkVsVlJINXhMM25X?=
 =?utf-8?B?S1JBNi83bGVQTm93V3VpWXVFNVJxNEp2RXpVbGl3Vy9zUzM3dWtSVjFvWnoz?=
 =?utf-8?B?M3lyWXkxdExJRWlIbDhCUi9NcFhCRUFDVWVtbnhTNTdPelVlWnJFWDI5SE9I?=
 =?utf-8?B?VlIveDFTUXZlckt6bWhuSGJZRnhQeDNOdXVjdExnK3I1VHIwZkJmV0hnUUZ5?=
 =?utf-8?B?emNwU0FaUXMyM3dYMERnaGlnY2RNbm1ybDFmdVE5OTVNSWZRSDhUdDJHQTh1?=
 =?utf-8?B?SE5kRXZ5WGwxYWtXK1FiWllld1gvVUdqMzRVeHBPRjU1YjNhVk1CQjg2R3JG?=
 =?utf-8?B?VWdYdDB1R1AyYVprdklRNFVsbHFac0ljM1Q1RVAvUlc5K2FNc3JybUhzaStj?=
 =?utf-8?B?NmRYRzFVWnJCcWE3Yml4UDJNRDBlTkFrdXJVaXpra0gwRmRwcW9WOFF4UWo1?=
 =?utf-8?B?aDZ0c0ZpV2MxZEdlZUhmM0l4cTlOa0pTVUpKVGFXOG5Lc3hlWmlicmJLVVhV?=
 =?utf-8?B?V3Q1dVluOHRFL213Yzh3WlZHOEFUeE9ORlJJVDJNQkZkY2VRMU1adFZFY0lN?=
 =?utf-8?B?cTl5ZlFvMHRaL0c1eEtEeEdId21ScGsxWWZrUmlyWnZKT3MzWjkva25nQnJU?=
 =?utf-8?B?azJSMGN4MnpENFZSRkpxbVFwUFB1ajFmaGlWMlFjT3JjRDI2V2c3N0xmeWx4?=
 =?utf-8?B?a2tBdzdmcU5PM016NVcvMnJobUY1WlVnZXVaT2tFTVJvY0lrNGxNSkx1dnlu?=
 =?utf-8?B?N2RqUmVON0RxVks0V3BjYjBOZWx2M2FJelBEK0NhSkpqUjQ3SXY2TmdUT0V1?=
 =?utf-8?B?a1VrZ0ErYXlWZmtpNVFYeEoyR1BvVU0zZ09abnNkWnQrS05IN0w2YUlWcEtR?=
 =?utf-8?Q?1OOjp1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9459.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFREeTlBTHdMMVl2ejZMeVBIYkh0U2YxN0RLb3Jxa2NaazF2U0ZnRjZMb3kz?=
 =?utf-8?B?NkYrQWsxcTNmblZqL0Zhc0MyNWx0WDBkdFV5V2dMcXhTanFabVlLdG1xM0hh?=
 =?utf-8?B?elVzQTNiNHB4U0UvODBNVWpSUUxZOUY1dllEdVgybkp3MHorOEM2MGFCWWJj?=
 =?utf-8?B?QzJEMFcyUUdtcmptZ3NXSUlqN01lWHRBL0Njc2lVUGgzdGtObFp5d013Zk93?=
 =?utf-8?B?N1BQOUJNZjJpQVJKbG5ETnlaWTZXd1p4RGJ0TjJleEJRUTRncTlkd1BycHY5?=
 =?utf-8?B?RW9jZElJNUUxbDlHZTM1VmpWdVFENEZjL1U0VTQ5OWsyWlpINUxNN0h0UGFR?=
 =?utf-8?B?bG1zK0gyRHprb2xCOWR5eDlPdlBTdVQ2cU43ZjRLNjI2ZlZGeGZqZ0RiMllu?=
 =?utf-8?B?NXlxNnM0eUxwbk94U2FTUkVTd01ZN2phaktVcFB4K00wb2phaDAzcUdVOGtZ?=
 =?utf-8?B?UjFyUEJxNGVBMWJ3LzZOUUl3dEhkcVRNUnRQczVkTHZSdUFBRis5Vzk3MEdn?=
 =?utf-8?B?bmNBcW0vZlBybHZRY2l1Vm5vcFVMUWprdDJ6a2ZsVG1WK3hnT1FjdndXVmVu?=
 =?utf-8?B?ODlzRGttK2YwRndjVWUyWllwdlhQbXgvdmlwaFd5QytzSTJVS0MyN1VFOURr?=
 =?utf-8?B?bkt6UEpScGFFRllzRjUzcERxTGNXdGJrd2FHWjlOOFgvbWVNaWFKRzZVbkdh?=
 =?utf-8?B?LzlSSDZBcFhnYThEbHZydERpMkpmUE5Hang4eWJzeGUxazN6L0VZck12UUF6?=
 =?utf-8?B?R2ZZeUlvUkYrM2tNVld6dXR6MElHOXhBSnBhRXZ6cklyZXl3N29yK1lTSjcz?=
 =?utf-8?B?VTFWUDVDbU9HdFF0VUNzQ3FNSm1NMnZwV2lqbVJYVW9uK0VwdHpyVVlOMkd0?=
 =?utf-8?B?OHNwK3Z3MXFqRmRHMlBuRDA3TzFKd2JTd0taR0EwM1pGYlBwR2pydlBkbFU1?=
 =?utf-8?B?UVVVMkJIRDJRdnd2S1pqYnErcGsxS0V0NjNCOEgzc2VUWjdpa3dIeUZNem5x?=
 =?utf-8?B?K254WFovMVpYV0s1ZUVlYVl0a3hhWVNQNUZ5VVdpTnhsYXh6SG81SWJsMmZw?=
 =?utf-8?B?S0VwRnlnTSt6aUViNlRKNTdCY2FrUUFPTDU4MWlCaFFkbTdQcjBBU214bzNy?=
 =?utf-8?B?aW95c0N0cUUwU2xnY1Y2ZUlMS1k0RzZtMWlzeEZKTHdTV2RGZ2xaQ0VhRFpp?=
 =?utf-8?B?Q0JsWExiaS9wN2g3elVzTXhUR09vR1VuNkJKT2h5TG5OQS92cGlrVHZDVWJC?=
 =?utf-8?B?dUU5ODdKZEp3a2Q4UEJNR0dVVFU2RTk4TmJJMFM1azRkYTNienovZnljOVFj?=
 =?utf-8?B?dEpXaENHeHp6eWhsdThySDhhQTJsY2x6QTY4b1FhcUhtRm8rcFBHeTBRYmhL?=
 =?utf-8?B?MTZON1pIK1Nvb1ZsMWRObWNweWJvTTU5S0JjVlhIZUJ4U0RJVm1VYmVITTV3?=
 =?utf-8?B?QmsrWXI3WFNsZXNPeE1uNDJVTFcrTC8yditYbmJGVTZpbkhNVEtwQmd3SW9h?=
 =?utf-8?B?eEtzTDRPOSsxTVVLcnFMc21tTTczVjZOSkNJSjlIMGtWWkZwRlA2SDBadVdh?=
 =?utf-8?B?WGxheC9ySDRlRFdoQjFUWk1FNk9uZmRkSVJUaVFOclNGTDB6MG8vV1ArWXRY?=
 =?utf-8?B?Y1g5UVBDVloxTXNNVC9VT1l3dVozdkJzbGxmWDBhcXNOM2lXNGpRU0cwd0FJ?=
 =?utf-8?B?UWRtVXhiZUhob1F1azdHWUV2Y0Fxd0hDVHRyL2hyUzY1aEU1MWpmV0svL0dl?=
 =?utf-8?B?SDhkam9WSW9Gb0x6ZXJ4VU5YQUtpK0EvcFVUZ3JZTXUzSGVncXQxNWNDamVi?=
 =?utf-8?B?K0hrcHZrUlRScTBpTHNYNUp5YkQ1QmJiSm5TRjNicVBHbXViVkNqTkhjQTM4?=
 =?utf-8?B?eGNVam9GUjZ1UFBZU3B4VHl5aWZtcDdZTzVjVEpCRm9YdFNiUFByZFZSQWJz?=
 =?utf-8?B?UTJvS1JMTGhFSDdqZjlkWHNhbkgxTTZaYkswZTNZZmNPT05BOXlzRGlXVllK?=
 =?utf-8?B?L2RNQ0crRHZ5L283Rk9GNi8xVmN2eWJIZ0NuMU4rdDRLdjZhNTY5SlhpYmkr?=
 =?utf-8?B?UWdMVzFlZjZCeGNta0xpdzlEMjRRNjZyeVV5YjdpZlduVGRjSFEwZ2xhNkww?=
 =?utf-8?B?b0VNQS9hVVRzdytwM2k4aVlXeFhYcGVQd0lWUWpnL1Uwai9xcFhpOEoyNFpJ?=
 =?utf-8?B?V3ZRZUU1cDBQNzdvU0Qybkd1U0tTS2hhSlJUcUYxQmdoV2VPZUtsbVkzK2tQ?=
 =?utf-8?B?NG1EWm1DakQzQVI1d2Fka2N4ZDNQTzhZcGRtWFd5Zmk3NE1ud2JhYk9DaDBB?=
 =?utf-8?B?MVAvMHB6dUpaZW45SndLZEY5bjBmOWptYkFJbHk1T05RYmxNNHl3QT09?=
X-OriginatorOrg: edgeless.systems
X-MS-Exchange-CrossTenant-Network-Message-Id: 41587d92-5c38-45a5-6604-08de6a5401a3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9459.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 16:30:17.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: adb650a8-5da3-4b15-b4b0-3daf65ff7626
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5MHrBffspACKmJgdB8dCiygwooBrt6hbe/M1OF0x038oKkoa4L1cugBdBLJfgS983gSmX295QgiyWEf1yj7Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8720
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[edgeless.systems,reject];
	R_DKIM_ALLOW(-0.20)[edgeless.systems:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,edgeless.systems:mid,edgeless.systems:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-6114-lists,linux-efi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@edgeless.systems,linux-efi@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[edgeless.systems:+]
X-Rspamd-Queue-Id: C7BF112F76D
X-Rspamd-Action: no action

Dear Ard Biesheuvel,

We are running into a kernel panic when starting TDX VMs with certain 
configurations of memory size in QEMU. The issue reproduces on both 
mainline and the current 6.18 stable and 6.12 LTS kernels.

Based on our current (trial-and-error-based) knowledge, the issue only 
occurs on TDX VMs with memory sizes >64GB, where the memory size is not 
aligned to a multiple of 1024. For instance, the QEMU argument `-m 67G` 
works, while `-m 67000M` results in the crash cited below. The 
configurations we've tested so far are as follows:

- `-m 66690M` results in the crash.
- `-m 66900M` results in the crash.
- `-m 67000M` results in the crash.
- `-m 67G` does not crash.
- `-m 68608M` (67 * 1024) does not crash.
- `-m 6960M` does not crash.
- `-m 33960M` does not crash.

Note that QEMU interprets `67G` in terms of powers of 2, i.e., a 
multiple of 1024, as can be seen in [1].

The crash happens during memory acceptance in _find_next_bit (although, 
I presume, accept_memory) is the more revealing thing here:

```
[    0.111989] BUG: unable to handle page fault for address: 
ff1100007d625008
[    0.114651] #PF: supervisor read access in kernel mode
[    0.116645] #PF: error_code(0x0000) - not-present page
[    0.118539] PGD 40801067 P4D 40802067 PUD 10db7ff067 PMD 10db7fe067 PTE 0
[    0.121108] Oops: Oops: 0000 [#1] SMP NOPTI
[    0.122729] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.19.0 
#1-NixOS NONE
[    0.125651] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
unknown 02/02/2022
[    0.128650] RIP: 0010:_find_next_bit+0x1e/0x80
[    0.130217] Code: c1 c3 c3 66 0f 1f 84 00 00 00 00 00 49 89 f8 48 89 
f0 48 39 f2 73 5a 48 89 d6 48 c7 c7 ff ff ff ff 89 d1 48 c1 ee 06 48 d3 
e7 <49> 23 3c f0 75 42 48 8d 56 01 49 8d 4c f0 08 48 c1 e2 06 eb 2d 66
[    0.137510] RSP: 0000:ffffffff91603d28 EFLAGS: 00010087
[    0.139634] RAX: 0000000000007edc RBX: 0000000000000000 RCX: 
0000000000007edb
[    0.142417] RDX: 0000000000007edb RSI: 00000000000001fb RDI: 
fffffffff8000000
[    0.145263] RBP: ffffffff91603da8 R08: ff1100007d624030 R09: 
ffffffff91c2d090
[    0.148058] R10: 0000000000000083 R11: ffffffff916beb78 R12: 
00000000ffffffff
[    0.150849] R13: ff1100007d624030 R14: 0000000000200000 R15: 
ff1100007d624018
[    0.153702] FS:  0000000000000000(0000) GS:0000000000000000(0000) 
knlGS:0000000000000000
[    0.156962] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.159239] CR2: ff1100007d625008 CR3: 000000003fe1a000 CR4: 
00000000000210f0
[    0.162088] Call Trace:
[    0.163075]  <TASK>
[    0.163882]  ? accept_memory+0x184/0x250
[    0.165448]  ? memblock_alloc_range_nid+0x16b/0x180
[    0.167308]  ? memblock_alloc_internal+0x38/0x70
[    0.168997]  ? __memblock_alloc_or_panic+0x8c/0xe0
[    0.170835]  ? copy_device_tree+0x1e/0x40
[    0.172368]  ? unflatten_device_tree+0x5e/0x90
[    0.174074]  ? x86_flattree_get_config+0x9b/0xe0
[    0.175865]  ? setup_arch+0x948/0xa50
[    0.177264]  ? start_kernel+0x48/0x6f0
[    0.178768]  ? x86_64_start_reservations+0x20/0x20
[    0.180610]  ? x86_64_start_kernel+0xcd/0xd0
[    0.182265]  ? common_startup_64+0x13e/0x141
[    0.183921]  </TASK>
[    0.184767] Modules linked in:
[    0.185971] CR2: ff1100007d625008
[    0.187308] ---[ end trace 0000000000000000 ]---
[    0.189071] RIP: 0010:_find_next_bit+0x1e/0x80
[    0.190789] Code: c1 c3 c3 66 0f 1f 84 00 00 00 00 00 49 89 f8 48 89 
f0 48 39 f2 73 5a 48 89 d6 48 c7 c7 ff ff ff ff 89 d1 48 c1 ee 06 48 d3 
e7 <49> 23 3c f0 75 42 48 8d 56 01 49 8d 4c f0 08 48 c1 e2 06 eb 2d 66
[    0.198025] RSP: 0000:ffffffff91603d28 EFLAGS: 00010087
[    0.200114] RAX: 0000000000007edc RBX: 0000000000000000 RCX: 
0000000000007edb
[    0.202992] RDX: 0000000000007edb RSI: 00000000000001fb RDI: 
fffffffff8000000
[    0.205779] RBP: ffffffff91603da8 R08: ff1100007d624030 R09: 
ffffffff91c2d090
[    0.208578] R10: 0000000000000083 R11: ffffffff916beb78 R12: 
00000000ffffffff
[    0.211444] R13: ff1100007d624030 R14: 0000000000200000 R15: 
ff1100007d624018
[    0.214223] FS:  0000000000000000(0000) GS:0000000000000000(0000) 
knlGS:0000000000000000
[    0.217326] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.219588] CR2: ff1100007d625008 CR3: 000000003fe1a000 CR4: 
00000000000210f0
[    0.222420] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.226193] ---[ end Kernel panic - not syncing: Attempted to kill 
the idle task! ]---
```

Please find a full log at [2].

The used kernel configuration can be found at [3].

The following QEMU command can be used to reproduce the issue:

```
qemu-system-x86_64 \
   -machine 
q35,accel=kvm,kernel_irqchip=split,confidential-guest-support=tdx \
   -cpu host,pmu=off \
   -m 67000M \
   -object '{"qom-type":"tdx-guest","id":"tdx"}' \
   -display none \
   -vga none \
   -nodefaults \
   --no-reboot \
   -kernel "/path/to/kernel-binary" \
   -append "earlyprintk=ttyS0 console=ttyS0" \
   -serial stdio \
   -bios "/path/to/OVMF.fd" \
   -smp 1
```

We have verified this on QEMU v10.1.2 and OVMF version 202511. The 
former is necessary for support of TDX VM creation without further 
patches, whereas the OVMF version should not be of essential importance 
to the reproduction of this bug.

I do assume that this might be more fit to report to maintainers of the 
TDX subsystems due to the hardware requirements for the reproduction. 
However, I decided to report this to you first, as it concerns the EFI 
subsystem to some extent, at least. Please let me know if you have a 
recommendation on who to forward this to.

Best Regards,
Moritz Sanft

[1]: 
<https://gitlab.com/qemu-project/qemu/-/blob/v10.1.2/util/cutils.c?ref_type=tags#L368-371>
[2]: <https://gist.github.com/msanft/45d576466cc5483aef40946213790fcb>
[3]: <https://gist.github.com/msanft/0be5ee612c51df3fd307e449b1f04461>


