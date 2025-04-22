Return-Path: <linux-efi+bounces-3416-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AFBA97570
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 21:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD92B189BFE3
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 19:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6A31F5402;
	Tue, 22 Apr 2025 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W8dBTssK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YIkB4dO2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6035949;
	Tue, 22 Apr 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745350322; cv=fail; b=EMg+Khz/zx8V3iBKQezNNiLxb7xcxmO0eI689R7ffeNmwlK1q7Ydpq4F1h87bE+mIhqCAczOfHubuIJfx7XhDlbo95TbfAku+EOFBmlodbk8XB4HSOob7yWL9sRLrM1gwYHE6Had3n9fqdIeaSucf9s1ro7QogORia5zE3YExj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745350322; c=relaxed/simple;
	bh=lIx7zsjamnN1B1okkHBQy0whHOtuJ3+mRa1sqSNsPuI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VWa89/07Wyg/Lb+EoCpS5zGpXjw/03YvWIWsGpX0YQBYTwyXpADohLyji27xWzh46ytP0fWtsIWhOvZJvigT5v7cjCJhVAwTEwTjmPd3Ynlpq3Itd82suMtpLr6lAWRc8Ro0vgXBeUxktyHUog2kzDonOX2XLRG7fBp9huG7Trs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W8dBTssK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YIkB4dO2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MFso2v002859;
	Tue, 22 Apr 2025 19:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=klRNZRUT0LaEvISqox/uvmbGELDUrh89SEEtAS9el88=; b=
	W8dBTssKM1ZNiq65PNLvJ4BORmeD5gYG/4Kj+HdxTHy4Y+9r/uBNzXrzqG4T+79w
	e3ci4JcXE/4i63F6JniToIoV3y1u511SBBzTWEehE6S9B3/436Q6ZKFeAD0iJQVZ
	zcxnrMkgAbWPdO3Ox8bsiHjyi4jRyPZUDor/GdGowvrcgv82aa7QkzSSCZMFC4LB
	MC7qfyOu8OZC5LW6s1EMJp5/sv55TpKn8breHYzjhyuXTsAAuHuz2GCZbWnn/xcw
	XCwXozjo0x0AecmRwDOmoWxuWml62crbKlxzVyIxBCE1HaoIncivBxwoq5YDNxyg
	EeA2zgDC+JkOJz2v2Z1oJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46428c5b6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 19:31:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MHuWDZ005870;
	Tue, 22 Apr 2025 19:31:09 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 465dek1wte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 19:31:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCZIu72f2ESARbuHYqj32bjwaXYoqfV3Sx8cZj1Id0/UKNlMe8eBmObnNy6ONs7SMnwQmEPcP9rVWb48qv0ZJRoSrLdFvF+/4X+h6hTmpVPuyzaCqKeg8EzQqePWKvkCJuA4gC7xbpu0tHzBuhowqSKwPRBAgkoOq0HD0/w5D/CC6lP6iEnvk++fR9OhG9eh9I446y0XuRO1UkOxHY9MzjmpYOh5BOSEzYF342kv9DR+JuhuGrLzgVo6XdKok/zV++dimVzDSh55hSDxRAAfK111cLPC0q8cJyWRnjnQvgYMpahbVacHF42GUSQjx2Jj+yCdxbY22pl8pGLi9lSZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klRNZRUT0LaEvISqox/uvmbGELDUrh89SEEtAS9el88=;
 b=nfvSmGmgyI3H4xgEBhgjBGaoRW3gKQFX5fo5dsdqXV+wkxhiV8E4gwJC0wWDytHytMX/MGDzYieLy4BUb7GVPrtPsbV9mrtpJ+vn6VYpUuwEu2/UvmFOyIt7odSK5nx6giocyxPALfe/b+4qhHKEKZaTw6XRo5FcNPKnS61TW0f37sAWVZaNwFhp65ciYn5aGpaveN9xXWOH78gPsy2IXvgxdYZctqvWk5SY56gVDbAm7p99GyED0AvcUAhr1AMyYCPI5+bA4hVtzs3pqqfVuJBZtvYvwffEBbtgNlVLsPfR8Hl6M+3fEU/7dHxwD/A4g/saZCAajMqkADPGM8rvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klRNZRUT0LaEvISqox/uvmbGELDUrh89SEEtAS9el88=;
 b=YIkB4dO2/7u/ApfLHfQK3BY4CY6FZUOJx4K06B/wpTNlEb76pbKdqwmRnp/+rKhvi1LAG/RX612o51HfynmxXaAGLrLwWtF6EAiYpidsYg0JoUBQk2BMFmqzMkxmdxjU+SC6gJ0H0iy9uhvFLjz4YTcCgYtq1Lkl64wmQwfU0ys=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SA1PR10MB6414.namprd10.prod.outlook.com (2603:10b6:806:259::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Tue, 22 Apr 2025 19:31:04 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 19:31:04 +0000
Message-ID: <84ce64c8-838d-4b62-abb0-cf46282ce548@oracle.com>
Date: Tue, 22 Apr 2025 12:31:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 13/19] x86/reboot: Secure Launch SEXIT support on
 reboot paths
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-14-ross.philipson@oracle.com>
 <26278368-cd3b-4bfb-9091-f3eec4cab35f@intel.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <26278368-cd3b-4bfb-9091-f3eec4cab35f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0113.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::31) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SA1PR10MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 161cb944-6012-4de2-bbcd-08dd81d43889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T05ENmZaZTh6UjBQdFpiY2VoUnJaYURldDZyNDZ0NXJaejJyd04xcHJwbmc5?=
 =?utf-8?B?eXRJZ2UxZWdHS0pmU01WQUdDMkJBLzBiR3krYmd1K2ZGbHhSZFdTVVJ2SlZ2?=
 =?utf-8?B?WFhVbURQeWtjem0wT0JYN0V0MnJuNlRFYUE5Q2RQRlYycHp2a01lZXVhZzFp?=
 =?utf-8?B?SElTK3AxK2ViSVF5OUdvZlhrZkkyMHFvRzdNTHlNV1RoSTVqeXcxWC9Kc0JM?=
 =?utf-8?B?b2JoV05oTUloZ0ZPVi9HdVkyUnhybnFYakwwWnErSUUwN1pSZTFWNXVTTzNY?=
 =?utf-8?B?WWpibkczbk1JZitVZVNydXhLWUUxLzZYc25FcFQzZWxMVDF1TlhMWFM0ejYw?=
 =?utf-8?B?Nnpod2FVTkZhU1RtbDJZN3ZTNEZvdjVHdUNXR3ErbEZWVXMwMHcva1RTQWt4?=
 =?utf-8?B?T0JDZUdHR29Yc2MrZXRONVgwOWJ5YVc5TDFKbmhPU2FYb0w3Wm5raTVDclRw?=
 =?utf-8?B?T1VHQWZHdFRNL1VsMkd5VGw2b0xVemxlMWxDOVpibWFWU1FZajRiNWdGSmpK?=
 =?utf-8?B?YVVLVTJCZXRGTzF6SFllSUJmL3J2WERCR1JNQnZUZFBEYS81dCsvYlB6cU14?=
 =?utf-8?B?c3QrK2ZncTg2VFVNY0xnMElyQWdkR3oxNEhYZzJVdHVPNEFLK2QzeTJUZ0R5?=
 =?utf-8?B?WXhXNW9SbzdaNmM1ZEFscmRRQkZXYmZpOER6WFFJTmROdW55bWRScU9FZG1K?=
 =?utf-8?B?R1JURXhJNVBDblRHNFRDeGFqRHNVSGNCSUhHemVsZWxmeWxnRUZxcERtZ1NJ?=
 =?utf-8?B?L0tEMlZZR1B4RnVxb2xRTHdrNktaNWJyU2c3WWw1Z09JNzRzV0I2Y1o3L1l0?=
 =?utf-8?B?NjRmMExpMGlEbXp6TTVYNUVXYk53WWxLSFZidXlnVWozR2RVbks3R1Vtc01v?=
 =?utf-8?B?cHI5VkRFMDFjZGYwWlZOVnFaWXRPcnYyY0lTVDVuVUd4N0p6NldSSHJPWXoy?=
 =?utf-8?B?THpqWWpvT3RJdmwycXNhYzF4TytxNDM4VFlWbGFNVCtodURLZW8zdUhuZW16?=
 =?utf-8?B?dy9EalViMytBVTZpdkIxTmRaME8wSS94Si9zT2xMbXFkMGFmcWRHd0ZzbVJH?=
 =?utf-8?B?Yk1nRXZFclJVQWJNNDRidDNaNzhmdmxIbExJb1RLQjYxenNJTmcxazFsTUdk?=
 =?utf-8?B?ZGRZUTJocWpDOVA5UVMrTldBblloUWdVVE9FM1pZS3NyZnRKUEZGRDhXeW5E?=
 =?utf-8?B?N1FkMFJiOEhKMzhlL3lHT0Jyd3E0cGdVTWRYQjhyMFV3U3J6WnZOZGFxdWtt?=
 =?utf-8?B?VkVmTHYvMVlOSDJTSm52YW9EWnV1L3c2RkV5YWtXMTlZMU1KZ3ZWVE94MVhJ?=
 =?utf-8?B?RlEwRmw0TFpRMnl3KytMdWhUUHorU1B0Vm9ZQlFxYm5KZ3VFR1F3QUV5bW9S?=
 =?utf-8?B?MXdZaU5DQ2NabUFYeXl4R0cwWXJxRnNrdXpEbDM0Y29rWm9sWHRZWlhjVkdQ?=
 =?utf-8?B?ZFdQRGN6S2ZEdEFLVkg3Mm5JWHJtYVdzaEN5WE50L3dsS3VwemNaYWJQMUtn?=
 =?utf-8?B?SGJvU3RTT3h0U3hVNXNDVzB5YlFaRUQremlqcm9YQ0NOb2E2U2hoSS9FWEZT?=
 =?utf-8?B?T2N6L3BDUkIzMzc2dmo3VlQyazZpZXJ1T0Vnc1lWMXZZYVdDL3FmYktMLzJp?=
 =?utf-8?B?Mk9WN2hCVVBSMUFNR2N3dUJKdDQ4bjUvanBEaFZQT25WNlRXYmhGcnNER00w?=
 =?utf-8?B?NmJ4UXlXK054WCtYWnkxcU5SM3VkZjZTaXdMUHJ2UmF2M3MyaVlmbVVacTIv?=
 =?utf-8?B?WitlYkd1VVgwMUd5ZUJlS1BNdFdZbXpyZlZvblFWWGc2bDBqMmVUeUEwbmlm?=
 =?utf-8?B?anVpMUprOWlxSExVdWxnUXY2VUFZTGFOYjRWMFpLZjJodGlmSzlFZGF6eU1j?=
 =?utf-8?B?d05LdldUZzZ5TDUxLzBPUndhcEgwZ3FOQTlUclowQTNFcWx0eFFKMTl6OVow?=
 =?utf-8?Q?whukgQyKAJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkowMmUwOHl1WmhaZyt4Q1F0c1FuUU1TODB3UEJkUTJEcVNmRno1ZE02cnVo?=
 =?utf-8?B?T2ZRZE02NlF2Vyt0N3VrK2tWR2hYU1FNWXFwRHdzMmxQTUhScFdwb2lJbDRC?=
 =?utf-8?B?Yy9OS3RMV1h3d3FaOHc0SDRFQlFKRVVSM0JuVDFFRzFHRG1QY0pLb25jWEtU?=
 =?utf-8?B?Z2FWeGZWWmdVS3BCanFSTG9raHN2RUhEL1o0RDlkbkY2N3pXbWk1VFNzVnR0?=
 =?utf-8?B?b2VlUW1PMTdPblBpQkhDNktGdEJjT3daaDhPSGdyOUo1TXhHK05aTkFxTWpQ?=
 =?utf-8?B?bGJWVzZVbmtUbXdEVk1jeGZhdnNpOHNjNGNscWFVSVM5ZzI2YlBWbUJtSUlu?=
 =?utf-8?B?Q0c3amlRVlJ5ZVBicE1YRy8zSGdDRVlLOEp1cVlvclk1Z1cvTFhKcllvZGpR?=
 =?utf-8?B?Zkx1cXRsQU51blQzbFEycFA0aE9odVpTeHQ0TVJsY3JBRkNGQjdPOEhQL0Ja?=
 =?utf-8?B?alh4L3g5aTlPU3dVQW90aFM1ajEvV1FJNnd1V3grRGdhT2dTcmlrWk1IQXJm?=
 =?utf-8?B?SnhtRHNkbkwzS0NMeFc4RlBBbVZWU3JLdmd1R01kblBsRGNKUHlna0s2SkZO?=
 =?utf-8?B?aXRKU2lVVXVFbTZzWm9DV0Nob0VkTi95Uy9sMnc1aUkvN2NZYVFhMUE1VkM4?=
 =?utf-8?B?UE5ZTUtPd3RmS3NhbEp1WjI0UEdObzh6LzAxV2hEbTk1TVg3NS91SkZvRkdi?=
 =?utf-8?B?cWsyalJqYUNmbkVaMGF3RFFXWkkyZlhrQjR2Ym1tQmNvVm5NRHQ5WVFXN3do?=
 =?utf-8?B?ZGJ5SDZ1SE5PLzZ3S25wRDlyNEdUZStRN2FpaE5VLy9hdmgrUm5mWnRwOEts?=
 =?utf-8?B?d2JNRGlFbngwTHc2Wk1XRG03ZUI5aHVGT0FFZ1dUMkFYWW8vZXgxOW9iSlVJ?=
 =?utf-8?B?M1V0ZjZMS08wUnBEbzFuV1VGdnFIc3libFZTN2l6UXJndjRzRTR0TlA4ZzlU?=
 =?utf-8?B?WkEvczVZS3dTMkFvd1RMRGJGUHAwNVJmdXJQNUlleUNqaHUySWJEdy9vM05W?=
 =?utf-8?B?S2dycWVMSUV0eEpTUHlhUkdWcUJ1MFhLR3dsaVZ6VUFvMVFUSXErVnlMWG1a?=
 =?utf-8?B?R0pvTlFDZHl5WHJ4TFlIcHMvTUZ2VEZ2a3paMGNLQllBOVFtUmdYNUdkQ0ls?=
 =?utf-8?B?NlRpUU5qbkNTZkJ4WEgvZXVDNGpTcTA5YzZNT3BYVHdZRUVsZkVWWlZab2xO?=
 =?utf-8?B?SzNOREE2ZDFwRDdVOE1lUUIrTVltSVE0cGY3RklsU2VQYjBsZEQ3Yk1uVjlF?=
 =?utf-8?B?c1hxK1lyajZZR1BpTUoxRjZRdmlYWWxFelpsaUIzdUU5c0EyYzdxVFZUTHI5?=
 =?utf-8?B?aU5VWGNVd0xvOFJWU0R0RE1wcXBESWlWRThFSE9IbmY2eWhadjZyVnBFZlNq?=
 =?utf-8?B?cmJNL1puaTlHR0d5N0NzNDJMR2VSZkZSSjNNdS9kMHRLUURTa05YNGZJWGdx?=
 =?utf-8?B?N29Wa2k2anNqZ0l1K29UNW5FMmczOTZpSWt1Z0VSWDNvYml1eVd1VXBYU2d3?=
 =?utf-8?B?M2NqaTB6R0p6Zysxek9qcVFQL3JQMXlMSUpKN1l1cVQ1Rjh6VlhCMGtOVHd2?=
 =?utf-8?B?RnNKUUNwK3NocmZqWUJSZTJhYW9IY1NBU2RxN29BSG1QekpvVVMwTDl0cVZR?=
 =?utf-8?B?TS9veU1xRy9sN0xzZEVBeHE1cnlSYTQ2VGdnWG9wWlF1UC9jYmcwTU80QWlY?=
 =?utf-8?B?QVpxbmZyaEZCakljUFh3cVF3WGk0enNTMGlBUXdBRjlTY1FFTUpKWW5wZ3ln?=
 =?utf-8?B?MmpLWTZJNVlyVTZZVUhZVnljL0Rja3lZL0xTblFlSmxyYWtJME5wVC9UWU8r?=
 =?utf-8?B?Q0tVWmI2cVR4ZUQ3bmh0WkgwNFo2WUt4U3NGZEpPUVRxTkpzdk8vMHdaOU1S?=
 =?utf-8?B?ekZ1MWJUaDg1TmRRT21seW00VldJMVBjU3Q3dlJsYldiUndxNlh1Wmhkc1N0?=
 =?utf-8?B?QUlwNTNBWnFScU0zRTRiWHBFekoreWdOa210aTlBUy8wZW5leWdBNC9FUWhS?=
 =?utf-8?B?TENwS2pUdWxOcE8zV2V5MmhpUTA1cnIzYW1mU3hDNmdrS3dQQWhGWWMwTG1W?=
 =?utf-8?B?TEU0MFZRejZBaEEzR21nQ3F1RkJYWTBlS1VpRktUYWE3YXhiYk1PbjF0N1hj?=
 =?utf-8?B?TUNMdDV4bmlXejk0NVpTZGZURHJsbCt3bFFsYXdTUFZZODRKQ0NsR1BaenVM?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/FgzNW/Lv5j45t6dGjU5FMYLPNsIkBMDjRSOTF/ubou3ij+CwseDVsIp/AFOImjQAyjHxKPfNOdxDBm+3L/Btoa3iKD1mDBF74Z/9AC7g2G/hLIhyr3MeFlvLR4jJKscGewU8WGmlRLiQcrwHRfJ6AtXx44xAe0Fqdz77uxiSZJQraXiY07QeRlCIsW9p3a58zHhbPToUze62DbikAlb8rzmMCWhgGUZw30b/YFjCJjog/wnhzgZxApMRoWWTie6u5vCeI4BH6Ztq6zPJpYOf2E4EWRgLMF/DWRIxWFdahLBzjehGhtJ1HvvJwLXNVV9lujK+vbzzn48Nbq/yJad1G854WKEEyh708BRy9mdvQOCRjvPsONufrFl+1xc6cGz9wvY6BXqUc5XqNs3xhMhZatz9DB5FfN0NPo9vgil38ju+M9oFrbHtHYRiIiaSZGzdj1H/vKa19npj/VLPm/3WTIRvSwG6fsC+duQhRsu3oHJIoi1uDl9InFbbHDxyuX2AESsrqbOd3I+u9bS/q1627BvUwEM36XXPM1Bdit6G5igDJ7QNdymJg/NrlFrlsm2qf0Bn+WGj37XC39nykztmbE8QLEuNclG1l9PzTogP6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161cb944-6012-4de2-bbcd-08dd81d43889
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 19:31:04.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cU7AIwXYsaLPdP6pGp4cuP6nY0Tr8zJ3DAKy0pYGG12Lrj+SXoHNHecliYp1zKPeuI4n2XRavozpvDAb8Mrl8R7v4p9mVh21wg0XnLYr/mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_09,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220146
X-Proofpoint-ORIG-GUID: a2P6PhqCrQUrQaEYfCPQQPENY40tBR6r
X-Proofpoint-GUID: a2P6PhqCrQUrQaEYfCPQQPENY40tBR6r

On 4/21/25 3:57 PM, Dave Hansen wrote:
> On 4/21/25 09:27, Ross Philipson wrote:
>> @@ -788,6 +790,9 @@ static void native_machine_halt(void)
>>   
>>   	tboot_shutdown(TB_SHUTDOWN_HALT);
>>   
>> +	/* SEXIT done after machine_shutdown() to meet TXT requirements */
>> +	slaunch_finalize(1);
> 
> This is the kind of stuff that needs to get fixed up before this series
> can go _anywhere_.
> 
> "TXT requirements" is not useful to a maintainer. *WHAT* requirement?
> *WHY* must it be done this way?
> 
> This code is unmaintainable as it stands.

Sorry we understand the frustration especially for maintainers. We have 
gone over your responses so far. We will do whatever it takes to make 
this patch set maintainable and acceptable to upstream. I think we are 
starting to understand what the main issues are with the set overall 
from what you are pointing out.

Thank you for your feedback,
Ross

