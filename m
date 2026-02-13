Return-Path: <linux-efi+bounces-6122-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKuyFk7ijmluFgEAu9opvQ
	(envelope-from <linux-efi+bounces-6122-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 09:35:26 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE431341C6
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 09:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D25B0300380D
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41C833066E;
	Fri, 13 Feb 2026 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=edgeless.systems header.i=@edgeless.systems header.b="apM9d4G0"
X-Original-To: linux-efi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022085.outbound.protection.outlook.com [52.101.66.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFF833AD89;
	Fri, 13 Feb 2026 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770971720; cv=fail; b=ETH78vf3Xkvz+8IvczKXhE/4Pame8SCIrfgTCQD2BDMNCUjLZ+6E3TvqR2ls+rC7XJA5hDwT+wOE0GQxUbxtXgi+BTd9dthYcAUKJz+nCb9MWJ1DKlZNXirgkd4ukboFNV7t11T9Wpk8uudZj+W4Nac12le2bA/FZVwvdGrJUQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770971720; c=relaxed/simple;
	bh=3Z6hlISXTYwB49umrIx810pBaKwhPMlOWTNBTn1sLVc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nqpGQNrugK/8BtxQO25YXrBtl59kaCh0blCsxco/6aEP5j+esoJoSTETKfTGiTkoSLhWPUPpDndz/V4Y2zwJ4FBdeTQfoDSziFf+2lMaKKF8dOWfnlGMs2aNGuRAh3ogXswWTK+zVRmi6ReoD0laCoeERkceKHuGcVFwPy+m4iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edgeless.systems; spf=pass smtp.mailfrom=edgeless.systems; dkim=pass (1024-bit key) header.d=edgeless.systems header.i=@edgeless.systems header.b=apM9d4G0; arc=fail smtp.client-ip=52.101.66.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edgeless.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edgeless.systems
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyM5WpTxJuo7IjbCkxYj9Trk9Tazm2CaORfXWKLu515qhAUoKgx1RKuMiU8jY82r0Wqh6GhGstM1uec0D1M3U9ezwwPn0vHVqiIWD+JQleGzE9zAZYO7gfhFHiTozJRiXYqhmQKVPqo4mzlTfV2WMNbugSANipOK2Th6fznZjK8CMUggndjnHzhL8PPt5NPlaPn8LEqsJ43j9AOXuYSuuB94A47/u6PRZwyOlGiTKopzq+nBfhbdSkpFQvwNlC6FYBGp6nKx7Hwc4TZgLIiPV4ilVtNFSQkY3LvEI3SMfc9tCU5haKnBwBICSxyNux7x5DoV3rtqKCgD13P2bcBt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZRuH2eT4YoL/pLg1MU7WucbU8ADAx0MFpMy9AWWXLc=;
 b=PR02Flr0vdrgzk0kk2vnYCZ1YbGe51WlNh0RpkFtE39b7I6dYbohpqbuH4emIX4Xi0reqkNVOIIVk59s+8yGBl8BwVH0mmq0jpiXwjQePlpvKCKKOcnJn/dTMve1sJ8AMZlhdb9EGc8eOLAIWsBC6Vob55rq+it4jNpRchiOQkHywsKjX7Hitm75EPoSzz6qcKOP5UMeXuISWd//gnLJMk0O1ZOYf6iPhZYOAO6MoGvtwKKDWFxQv+2aEN6fcLgpZ9G7YGWmU4XRXBFBDsbSe0dlFUDJnPpnuLKoj/RXBTChS5Yq/0ml81zLhQKqauUaWUdhPJM/2lULmEEpAo/hFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=edgeless.systems; dmarc=pass action=none
 header.from=edgeless.systems; dkim=pass header.d=edgeless.systems; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edgeless.systems;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZRuH2eT4YoL/pLg1MU7WucbU8ADAx0MFpMy9AWWXLc=;
 b=apM9d4G08NYc2cF0mQ5dYNDlt+1cG59dvKC3zoOh0CXwtzZWiO4mxS/dvwVv/kI2S5kqLlt8d08nUxKZ0YUkpZ4SDjzu2pFTe1r5L3gym9Y9hjMM2M9bAuLQQGay+SjyTrzBMb7vJYk6xhGYoM7WwpcoQ0Drqt6VodjJ0Y71LVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=edgeless.systems;
Received: from AS8PR02MB9459.eurprd02.prod.outlook.com (2603:10a6:20b:5a3::12)
 by AMBPR02MB11993.eurprd02.prod.outlook.com (2603:10a6:20b:720::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 08:35:17 +0000
Received: from AS8PR02MB9459.eurprd02.prod.outlook.com
 ([fe80::815f:fa6d:197c:2470]) by AS8PR02MB9459.eurprd02.prod.outlook.com
 ([fe80::815f:fa6d:197c:2470%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 08:35:16 +0000
Message-ID: <cf37b7df-1265-411c-8aac-f82c3732fde9@edgeless.systems>
Date: Fri, 13 Feb 2026 09:34:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Fault during memory acceptance for TDX VMs with certain
 memory sizes
To: Dave Hansen <dave.hansen@intel.com>, ardb@kernel.org,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, "Weiny, Ira" <ira.weiny@intel.com>,
 "Wunner, Lukas" <lukas.wunner@intel.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c2632da9-745d-46d8-901a-604008a14ac4@edgeless.systems>
 <b6f00f31-ab39-4a76-b758-b3cfb1b0dfbe@intel.com>
Content-Language: en-US
From: Moritz Sanft <ms@edgeless.systems>
In-Reply-To: <b6f00f31-ab39-4a76-b758-b3cfb1b0dfbe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::10) To AS8PR02MB9459.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a3::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9459:EE_|AMBPR02MB11993:EE_
X-MS-Office365-Filtering-Correlation-Id: b0eefcf3-6480-4385-7de2-08de6adad082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWY5bFFBTnR6TXFSK29mWVhaMytLYlNZOUhhb1ZlQmVsL2twVXBvWG1sY0VE?=
 =?utf-8?B?enMxMnZVRW5UY0p6eldsb2JIVlhzTXBibXJ1cFd0emM2UW5mcER3VENBcks5?=
 =?utf-8?B?UURNMkpOYUM4YVFJdHZRb2hMdFFhdXJSaFRHTkpBZ2ZueDVUWTk3TUN4R2NW?=
 =?utf-8?B?cnA5bXBhdm9WRHNtQWdGaGhQbWttTlZiUGVtTU1XSFFiWEx4eUl1SjJNNWMw?=
 =?utf-8?B?K1hXMFRkMEhMcW5uTzczV2dQeWVra2J5N0wrVVNIS1NXSUUzdjJ3ZDl3aUJL?=
 =?utf-8?B?aVc3WHd1Z1h6RXVIOVpvcTBkTVAwZndIcXhLWnA2NURIaTRtZEgvMG91Qy9u?=
 =?utf-8?B?SWZCSkE1d2NNOWErRjJlLzFjR21YTW9mNnJMRWRpbXRlMFhVSmxPT09RMk5S?=
 =?utf-8?B?V0ExeFRGOEtmUzlaNGZTRG1BUUVsRVNIZHVyQUY2QjJIcnZmVDB1QXRicUE3?=
 =?utf-8?B?MkZSRTJWRE9hYlNJQ1dGaERFYlU1anRCTnZuTnBlazBwaU10UFpGcXhYWTZK?=
 =?utf-8?B?aTFEaTUwblNlbG9iZXc2MXJncWo3YVF1ZFpwdnhCRm9SS3h3NlNLQWJkelZM?=
 =?utf-8?B?SHFwaUZwMnQ0N0l4QytWWW9RUTdvY0F1djE0OWtPSWZYY1h6bHpVWmQzOFc3?=
 =?utf-8?B?aGtPUFJBT056Sy84aG9QbjVNbUxTRU5TUlA2VGdaQWxhVXlSbWhGaHZlV3Yx?=
 =?utf-8?B?eFBiWncyKzFBN3pOZTMrTlBQS2MwSzU5QUVQNU9hdzg4UVdrc3d4UmVnamlx?=
 =?utf-8?B?bTNWNFB1Y1EvcndvVkhyTFNvQzZVdHYrSkw4V0dTekVPTXBGQU4wbmN4RTVM?=
 =?utf-8?B?WjZaZEtHMnNPaHN3V1g5cDQ4R3EwUGdSS29lTnhPSmlXMmVTSDJGbTloMnlR?=
 =?utf-8?B?Y3BSd3UxcFQwNkZIWEI4YithdmNpaWlpR0VUYXkyNC91eFZlWEJQNW5uejJT?=
 =?utf-8?B?TXFKWExTL29Qc0VPRjVVczZjM0dQWHpncWt6bkNxZHRSZTMxQ1ZOdmhGd3k3?=
 =?utf-8?B?VytkMkgyNGxxbjRJQmJSZk42c2xQNFhva1ZXK21Ca3lwOTFISkRBV2czV1NZ?=
 =?utf-8?B?aWV3USsyRjVNUncwYlBMNm5YcnJ6eWE1WExHWnRlNmtRUytDYTRqeUlpNDkr?=
 =?utf-8?B?OThGLzhYdjU4TVZ3VHQxN00wVWp4eFluT3pyVUVqVmRqbzhYbm5ST0NHRzVS?=
 =?utf-8?B?T3liTlJQOHdYREIwR3FDdkxVaThTV2RUbk1TRVMwOFgxWFpROTRWZnF0Q2ZB?=
 =?utf-8?B?Qk53UUcvOThCaWlrSFJxU1d1bTBXdVN6TklDcGhrTW9LZGJsSVQrY3V0dVo5?=
 =?utf-8?B?VVZlblRnVW1ZNjhWbE5jcHMrRHZucjFTNXlyRDJaZzlPL09HVGVwQjRHTHR5?=
 =?utf-8?B?bTZ5YkRvUUhzajhJREpOQzNzMFQwM3c3MGV4M2F2VGNaQnM2UGZra3hYYmdE?=
 =?utf-8?B?Z3NwR0ZodEpmRHQ3dWhldXg5WlM2WDQ4WXZLNFFYV3BJUE5zR2IyVUIyRENM?=
 =?utf-8?B?NW51UlFCdWtuMEdvOXZtb1g3MkpsZklGOG1DNnBDSlllOEg3K2x4RXlwRmNp?=
 =?utf-8?B?cHR5WWZzMXczVy9LaFF4elRkc2pZanl6YkY4Q2t0WDUzdEs2UlVKOHNrQjN6?=
 =?utf-8?B?bCtEYWJ3K1hkemwyTSttVjkzYjhjbTZxTGpjbDZaOVphMFhJMzhWVTFyOHFt?=
 =?utf-8?B?TGRBTkZtUXhDamgwdjVaNVZLWUNtTkM2LytpMHg4Z0dTYy9UMnNEMDFZek5I?=
 =?utf-8?B?WVJvMDYxZWN3RVhnM2R0alFJcXorQlJRcWhnTCs5WTRCYmFQcGtTUGpoTmZ2?=
 =?utf-8?B?bG5rWnQrdGduejFhazlneDJyc1kwcGlJMWE5SVEvcXlXRDdZcHlVSnZCR1g3?=
 =?utf-8?B?SnRnUGEyWW1LKzI0eEQwNng5a3NyV2ZZaWVDUGlXdnpBREFsUXZjYjJNYU01?=
 =?utf-8?B?NDU4UTl1YkVNNXNQRHNlaC83QU5UeUhBT0hXVmpkTW90OXplVTlYaFVYMzlm?=
 =?utf-8?B?YUcwUlhablh3ZTMyUHkyakxWMHgrQTcwVmhPbGtpRDVUR2pORlViR1AydDlq?=
 =?utf-8?Q?9das+H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9459.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTNJZWF4MW1haGNKNTRKcEZ0d1NQaUVQNFdMUTd6QTQ4VUpudnlSZG1IcUty?=
 =?utf-8?B?bU9QVXR2aTk2dHpnR1RlU2NpU2J3eEdHU3dkR1lMNnJuRU9ObzBJZUdDZStu?=
 =?utf-8?B?bDZPWkVpU083Zk5xMW1OczRXRVZWVm5LRWNhSlc1WWpWN0hRaUxmL2lPRDJ6?=
 =?utf-8?B?ZDdsQXJteTk3OG1CMlp0ZCtOTDFLNXBJbjN6NXA3cnpwMGk0TU4yUEFTZEs3?=
 =?utf-8?B?ZW4wUUlIMmYzMEVLUnp4M256V0hGVy8vSERtSGlYd3l4ZmJmUHdPdG9BTStq?=
 =?utf-8?B?eWpLTktkNlZ5RGlOcFQzRXpCM3V4eU1mbFZwOExXaFlxd0xaR1hSUnpTMlpx?=
 =?utf-8?B?a25USTdKVjVFaDltMVZsQXNzTlhvOVF1dWxWajFsZXFBRnhmTURWbmxQbnZY?=
 =?utf-8?B?L09xQ1NBenN4em4rREY1TWNRTHhVUzVtcTIxdy9mTXB2YVhuVkRMeUlKUTVR?=
 =?utf-8?B?NXhPRFVDOGdlTUxuT3FVdGhPeGFpU1NodEtMcUlDaWpFMlY3eHAvSGFvWVNS?=
 =?utf-8?B?cUNKaHlMQ3QvOUFadGxuUlc4MTZnckd1c2JJVjd5cTY5QWZVVHloZjFWelhr?=
 =?utf-8?B?ZDZydXFUZ2RMWUNTN2x3M1d4WG9wVkpwcGo0NWxUa3FKeUVEaVRWS2U0YVhP?=
 =?utf-8?B?T1ZsVFJReEl6T0pibUVnaDd6MmRKczFNbEYxa1FmT3pPWDRxQnNiZmpVYzlL?=
 =?utf-8?B?L2M5SXlweDUrMnBGM1JNL0V5amJFbHVGTmlEbXJXVTNNVzE2djlnZmdBdDV4?=
 =?utf-8?B?aDZ5WjlkNFNLUWVLNTgrQm52WVFSNGY5MGlMcFRrbjl2S3NmajFSQjlWSHY0?=
 =?utf-8?B?SXpsb2dUN0tXR1JBZks0Q0NHVVZ1dVFSTXhLTUxaWS9CckdyK04za3cxdU9Z?=
 =?utf-8?B?Si9STVdNcjRjeTJHY0RzUlVjKytyR2oyRGZNcnd6Z055WGIvYmpvam1Ga0xH?=
 =?utf-8?B?V3RFY2t3S2l0VWJyejBVL3IzOGtJZ25uZXp6SkZpRzdrV2QyZHREN2pmQ0Ft?=
 =?utf-8?B?M3BmaStIbWMzTW5YakVwM3pYaHRQNmdSUDBSMy9TOFJQaVJnaC9qelpBeWZa?=
 =?utf-8?B?Y0JuNDE3UUJpWEhWQlNMSDFvVExyeDlnOFZQRSttWXY1aVdWK3g5dkNvQVpB?=
 =?utf-8?B?RGZKU1haTHdHSHE1dEF6b05KQnhRZkdJaVQ3a0J4ODdZWmRGelVBUCtJR2Vz?=
 =?utf-8?B?MHliWlZFRTdBN2N5dVdQUSt5c3NzeDVzTW5OUXFOM1pldkNhSTc5TlZ4MG1K?=
 =?utf-8?B?azJERE00ZzU2dDBxR0tMSUFhZGxTTGFHZmwyQTVPN2wzVURlbVdPUVU5dnVz?=
 =?utf-8?B?Z2VrclUxQ2VMNWhUOHJHVkpYemwrWHJVNGIveHJGMWV4WnA5VWF0YUNpTGN3?=
 =?utf-8?B?NkN2SVFtUmFrOGpGWEh0b3dYeE93ZU9SUDkzaENaeUthWkxvaCtmWDZHZUt6?=
 =?utf-8?B?Ky9OdW5QMEZydHNIVUZZL3JGaFhqdCtSMEVKR0FoODgydWVYTStZeGhhc0dk?=
 =?utf-8?B?RlZvMFZwN0JIdENKemFzMFhPdkxiYk90Q3c3NDRiSjQrL2hLR2tqeFM4MHVO?=
 =?utf-8?B?WUg4OVQ3S2hHVXhwMnJDSjcvNzR5VVFhdWl6ZldQaEh0cDRkR0JUazR2ejR0?=
 =?utf-8?B?ZXAxelRIM1VVRzAxOWNWbXZldjYzbVFWeUFCZkQwOFFsdXIrYlRIRmxIY2di?=
 =?utf-8?B?QU53VHdMYk5uWURZRk05bUMzRUxoTDErdVNPQmtTelM5b09oMWVKQ1BkTVht?=
 =?utf-8?B?QlNPajUvK0NVZmxxd2ZJR1VlSENjdFRPdzlDcTliUGVKTzRQSHJERkN5dGhD?=
 =?utf-8?B?WXBPWTdHcVUvSUlncmhtSE1iQ2hSbnlTb3RGRVlKMjRSdTlEZnZ3SnNsWE9m?=
 =?utf-8?B?QjVmYWJySFJpelVYbklWU05GVm0xczVPb1NRR3BoTms0c3dTTEhQQUpWR1Vn?=
 =?utf-8?B?eURIV1d0TnRqMzJnM2ZUL0trTWVvb3hKRzczVDROTVM3MzBKNUI4NnJEL1RD?=
 =?utf-8?B?V291R3RQUDJtS1VkdkhLZGtwZThXd25NVFprWS9BZWxIc204Wnc4WXVBdFNi?=
 =?utf-8?B?a3RIOE4wN01QUk9JS2tHczdlRDNYRXlzWkJwaU1QeWFSRkRoNENudStSN1o3?=
 =?utf-8?B?SkVQbE9vWTdrNE5wUVM2NEVqQ241dGV3V01TR29NUmtEcmhBZnRqb0VlOThq?=
 =?utf-8?B?VFZvdWl5Z3JPTmxsWnNjajBBV3d6WElmZXZvZ09vRGxqS3VJRFQ3S0diQmpY?=
 =?utf-8?B?WkFQSEV3ZHhqRkpTY21YNGJ0TEhkYjVoa3RmMHRmbDZJZDA3dzE0RFZQbEV4?=
 =?utf-8?B?SFN6RTdYQ3Y1Zk0yV0RLaitteFRyczU5WkxEZ0loMzF1SlFIQkd4Zz09?=
X-OriginatorOrg: edgeless.systems
X-MS-Exchange-CrossTenant-Network-Message-Id: b0eefcf3-6480-4385-7de2-08de6adad082
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9459.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:35:16.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: adb650a8-5da3-4b15-b4b0-3daf65ff7626
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g67EY6HPfU1wSdipmKXp/U1KKoVZWP8LvcSuTyrwGz2i1GMkGjiZGvMpASTq0UpK2M3O7De9xIe2DfsbhaE/LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR02MB11993
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[edgeless.systems,reject];
	R_DKIM_ALLOW(-0.20)[edgeless.systems:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-6122-lists,linux-efi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@edgeless.systems,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[edgeless.systems:+]
X-Rspamd-Queue-Id: 7AE431341C6
X-Rspamd-Action: no action

> Any chance you can throw
> a bunch of printk()'s in the kernel and see what all the fields in here are:
> 
> struct efi_unaccepted_memory {
>         u32 version;
>         u32 unit_size;
>         u64 phys_base;
>         u64 size;
>         unsigned long bitmap[];
> };
> 
> Along with the address of bitmap[] and all the calls to: bitmap_clear()?

Thanks for the guidance. I've added this logging via the patch in [1], 
which produced the following output:

```
[    0.033292] accept_memory(start=0x0000000000099000 size=0x6000)
[    0.037860]   unaccepted: version=1 unit_size=2097152 
phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
[    0.041469] Using GB pages for direct mapping
[    0.043090] accept_memory(start=0x00000010db600000 size=0x200000)
[    0.045311]   unaccepted: version=1 unit_size=2097152 
phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
[    0.058123]   bitmap_clear(bitmap=ff1100007d624030, start=32475, len=1)
[    0.060921] accept_memory(start=0x00000010db7ff000 size=0x1000)
[    0.063142]   unaccepted: version=1 unit_size=2097152 
phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
[    0.066865] accept_memory(start=0x00000010db7fe000 size=0x1000)
[    0.069096]   unaccepted: version=1 unit_size=2097152 
phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
[    0.073705] accept_memory(start=0x00000010db7fd000 size=0x1000)
[    0.075908]   unaccepted: version=1 unit_size=2097152 
phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
// unrelated logs omitted here
[    0.134988] accept_memory(start=0x00000010db7fcf40 size=0x83)
[    0.137152]   unaccepted: version=1 unit_size=2097152 
phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
[    0.140828] BUG: unable to handle page fault for address: 
ff1100007d625008
```

Find a full log attached in [2].

Please let me know if we need to gather any further logs - we're happy 
to do so.

Best Regards,
Moritz Sanft

[1]: https://gist.github.com/msanft/13709e1ec9976a1b4b2723b98163a04b
[2]: https://gist.github.com/msanft/d102475bb28baa4b7958ed35e001e962

