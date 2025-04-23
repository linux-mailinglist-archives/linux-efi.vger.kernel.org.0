Return-Path: <linux-efi+bounces-3445-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B68A999F3
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 23:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8922C16BAA8
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FE326A081;
	Wed, 23 Apr 2025 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gyK04edq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JqOmUKvX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C72F32;
	Wed, 23 Apr 2025 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442531; cv=fail; b=gLq224WobND9AWPSfwi/RNbJRQGW+4StrOBqTNRh3p5ZdJWL58VWx4tKhHIfKQRz0fz8UnRCSNZC3Bb3juP2yD+DumfuQ7lQnY2wU7Zt1cuavL73FQtUDm8DIQL960wehZF4n08AuAOgEzOpNOy3oFnqTuS/sti0zvy9g1UQWRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442531; c=relaxed/simple;
	bh=Yb37NOALkdEZ/tijP4/iCgKU5JDg+bbkKKZlzFevk6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KY7nMOZmmbPcUxICAgeH2Du7Jwd3Xm8DAW/pENvy47m+b+5lUgA6JDVMlrGLg42mgR1wCb0/lA/Oyx3d1r858pTzNGOFJMZkVMJ8/ge/6+cho1npdCinL+pIHPxphfaSYnLHXkeeXaeQ4yZzvj+/G2VuGD76MAyQg0uFvP1AZf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gyK04edq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JqOmUKvX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NKBsGa004669;
	Wed, 23 Apr 2025 21:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Il7z9nBtuxhg0NgKa9SaIbJ/KhH9oO+vBGvBScW6hXA=; b=
	gyK04edqM2YbE6oH8b0t49JPvtOtyBkXsZHgWa1EjlK+uchRc5oyKpfThmumyd5L
	HNpIt2MAnb8XSnkD5PdM/yObMHXMXgA2zKNB7WLx0N1ST2sydnHnkUbjexnv02P5
	JYs4BJt5MHZmPrQZ4GtgTOi461AMMX6DAYPz1QXQ7rdkptqxJABlgn4YxY52bc+5
	OtOOigDednQJLTT5diRw8ToFcrnJvefYtl88ZTaphZNgSmGRB4ImQBWgaT3P29qL
	YxJNn6fzKj2S70kdg9xOP/gE8n4LUA1h0hzjKPicPM84ojxHK+HJjd3vwGlj2xb/
	3PXluR3hgsSgJPBfzYcnoQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha2bn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 21:08:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJhCUO017326;
	Wed, 23 Apr 2025 21:08:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jvfnxc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 21:08:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhH6wrG3FOD6USGxgOxtR5HodiXfPz11uUgU2FkuOhKrYeBfT+rnL1turobIgZvQJ3UgNk7Whl5EPZVaz8HOIW4b/cFE/xUVX4sCnjP2qtsSHeCULMpIJnOKhnrzE2s/ItE1E6vB8Zd6s5Q4z8tafextepykka7ziRotC662CHiebFiLluS2nJXpX08X7maMfFgo5p/HQ8xi1a5E71jqnkzU+rHPXsuMY1/zTYAW76TcBlYnJQ5YS3+xDY8t6FfMcK7fzys32WVWN+TNGgbgJGCxvm2Zzp4w9qJEc06vyh8n6XBjzwQWQn+Xa0HU91sl68UuHPGDMXCfYy9WAWnKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Il7z9nBtuxhg0NgKa9SaIbJ/KhH9oO+vBGvBScW6hXA=;
 b=UG9PalBUT7G0wnLChMB5RGwzwPqEIqgkkt7b/0f8JPTlroUg74DV9QuWRifvDKhRO55YUE+UnpYXnSR55WDoZHqJvsIU4101VzoENIdqo8/e3kM6VSnXgpzikcZCTasvsHJZy+MM3wTZSDeQO/Net8AdNuMfPQmwtlB61lC4qBxDtlYdsBpx0AcBHlhkbYK8CFg9NiINrkH99u+ZYn6qZf+iq6e2w9yPAGTkEk0f+vmhVifMy2Pmo6VMIsnDWFrdjYjy+YE0vNsJo3wNGu4g0hjQ2ZFUw0N9xSYb7SKRDvbZkdUjqw0KyclsyRsGX0PZdi4Y13+XR+9CKqb2OYrDQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il7z9nBtuxhg0NgKa9SaIbJ/KhH9oO+vBGvBScW6hXA=;
 b=JqOmUKvXgD2qkDSKxhefsou2PejPca4xuIq5bvdTPm9xWECJBYnbGJWU5l5ZgxaJsrUjaLgu/T0N3N1v6pIgtRW3Z13YzKCFopyWLv6BFM0tD93E2lB0dHNAFv7VNvsOrZqOTL3pkIAmiMXNSQHhQyOon97DVh/gMnCw2rbcPAE=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SA1PR10MB6662.namprd10.prod.outlook.com (2603:10b6:806:2b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 21:08:02 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 21:08:02 +0000
Message-ID: <06d3a0ee-9f27-4f57-bd5e-5c493a9caa46@oracle.com>
Date: Wed, 23 Apr 2025 14:07:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/19] x86: Secure Launch kernel early boot stub
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org,
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
 <20250421162712.77452-10-ross.philipson@oracle.com>
 <d1f86aa1-2e37-4cfc-b62d-7529ac58c8ba@oracle.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <d1f86aa1-2e37-4cfc-b62d-7529ac58c8ba@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0095.namprd07.prod.outlook.com
 (2603:10b6:510:4::10) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SA1PR10MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: e44a8957-9b54-4e50-24d6-08dd82aaef15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnVkdDFqK2hjSXRqaXB4d2lVNC9rMzNNaW5FcWRPcHgrdnZWd1VuRmc2aDFq?=
 =?utf-8?B?NmxKWW1aR3pyVklXK1pBMG1CcFZldGo4RzlZVEpGd3dLQldYUGZQTGJBWHZo?=
 =?utf-8?B?TGhlOHZBYUx3LzI5ZkFZdjJkYml0emhHUWs5WjAvRm11bU9BdWdoWS91ZDB0?=
 =?utf-8?B?Q1BlVmtNQ0w2SjgzRnM3WGxTVVN0Q0xwek1oTGtLTU1pZXY2Vk5PMUFiVk1x?=
 =?utf-8?B?MXFEaXE3YzdId09hWjNKNlhUR2tYTVJXcUI3U0l0MGwrcFkrTG5yNkhjbTZ1?=
 =?utf-8?B?SG5jZzNFaE1zbWIrS3M3OWdoZnlQNk5DdSt1cWdWZU1hcDBZSjEwWWFEWGVl?=
 =?utf-8?B?Q01GcmhrN1J0aEp0Nk9wN1djenk1YnRRKzVpNnRPNmNJd1Y5Mk9Vc3FQTytY?=
 =?utf-8?B?ZjRFSkdIQXNXRzk3anovajNrWGVaOEZlb3NydFJSR2U2WjhhWllpUDF5R1hs?=
 =?utf-8?B?LzB1Z3ppbVFCOXBuM05VL3NFMHBCaW1QaGY5bWZOOVV4cHhHaUR2VFVoeXM1?=
 =?utf-8?B?OWRYMmU2eFpQRXdDelV3WWlYTm9nOEFLTFQ2ZUFTMFNyV0JRODh6NEYzY3kv?=
 =?utf-8?B?RkxvTlluMndMamQ4UTVjQ1NHemN4cUhFZ3c0ME1EOVcycDNRcjIwOHFRd0k5?=
 =?utf-8?B?VkV4OS9LeWNkaCtmaEgzVnBwSmpBdkZJWDgxM3owM3JNVnBxUXhnbStRVDJU?=
 =?utf-8?B?dkxpWGcyTkJPQWtpMStmKzJVdzVqWkQyMW9haHdYZEtpTjRzTXpvYkFGSnZr?=
 =?utf-8?B?UEhnYXFGakZjMFhpamxobzRpRGZiZ2ljTEJKeVYvQXdPakxVSHBYY1NDQ0t2?=
 =?utf-8?B?R09MMk5HaXRlb2pHc0ZBZ1NrcDkxR1BNcW1QTHM5RWsrdkJpSFdIblhPRzNt?=
 =?utf-8?B?Q2lDd1RhMlZmRUl6Q3pTUFpkQm5VSlY5bFZkKzMzQTBJYnVxWWUvQmlRb0JB?=
 =?utf-8?B?UHYvdzMzNzFORlh3djFVNjc2ZjJNT1VNM0tFTXlGNm02YzJqSHFtWklNdHpE?=
 =?utf-8?B?SktpbjRKWWUvSWpDalNZTWs0OU4zMDl4Z3hOYVN1bm9Yd2UzMEdYRVJ0VnFq?=
 =?utf-8?B?bFZYVVowMnl6SEpQZWFsczBjaVl4M25XWEZZOXFnbzRzSnJhcGFMMmVQQXJU?=
 =?utf-8?B?b3B1Sy9FOUZNSFdPVUx0NWozdVRIdjE3a3lpZENPc3lSTXYwbnNVWkxOUU00?=
 =?utf-8?B?ZW81ZlhoRGNabVlldW5SdnlBaXo5dmJqblE4Q3RsbXBhWFExeVM2cFJ1bFBM?=
 =?utf-8?B?R1NML3Q0dWIxU284Z1VpN1NaZGZrdDQrUDdLVmp3aDdiRnpKcm9oekVSTkpr?=
 =?utf-8?B?eVl4aHNIZ1RTSUlVVjZGNUI3T1c1czVwdjlUOS9tUU4wSjdQem9HNWpWck5j?=
 =?utf-8?B?YlR5UkV5RjJhY2tnTHJWNnI3VUo4TzlteCtyZnN1Wk1rc1dBTTJsSTZObnhV?=
 =?utf-8?B?Vmx5ZGdiZkh1ajVHRWprNW1hNEx2QXkzU1YvUlRLQ09ZeFh4Q0NiZVh1MW1r?=
 =?utf-8?B?L2JQV1g0SUd1RlBKZkdSdmptUjJFVkc3S2NQSmhDa0ZpaFAwMEpQU3VxRWxp?=
 =?utf-8?B?N01YZXZycXVyenkwRURiMHd0bTF5VHNmS2tzcTBsSGlqb0tEWTFHS0s3UGIw?=
 =?utf-8?B?bXBoeDZkVGJ4MzNYRWQrWFoyUWF1Q2RyS1ZmSnQrNmdsM3ErTnJzdzJqU1My?=
 =?utf-8?B?Y2lwclZaMkRpUkxVaUN0bnJ2dmhCWDdsWmZsbmJUb0d0S1J4MktKSGhtNFBz?=
 =?utf-8?B?bmdpdnR4b2FiZWZnNXcrWWNVK0NKKzV2NmVtM2s1RmxPN2FKT2ozNkVwS0Z5?=
 =?utf-8?B?YWpGRHY3T2JrcDR5UUxEMEc4V09XWmNibzhTKy9PQVRiQ2JSbDd6TndiWWF0?=
 =?utf-8?B?ZGQxQTFwd0dpM3ZTWm1VMjdSVTY5dk5SWng5aDVmbUFWV0RZL1FuelA0aDBu?=
 =?utf-8?Q?H81JQaKkYns=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmQrY1RCRGtmN0VwTmdSa21RY2QxK0x3WjAyNlFscWhpWTk2NHNDVmx0M2V5?=
 =?utf-8?B?UXBuSkxLTExPcFhPYWkvTkhjM2ZVb0MvajkyVTZaTG1pKytyZGkyUTVjTXdL?=
 =?utf-8?B?ZkVxOGNLbTk2N0kzRzV1MHdiNjNxQlFyQUpHN2tRSjFzVTJ2UC9SeThWdEUw?=
 =?utf-8?B?WVhUMDNIUTgxczM0b0FFaGVWQUlJQm1BSi9BMit3MURxTjZHZVFSZVhYck9l?=
 =?utf-8?B?WGM4SHNwRWRtVGU4akgzQjhEdG5DdlRnZmdXMEg3WW5tS2JLQWUrTjZtZ0Jh?=
 =?utf-8?B?VTJXc1NFTUFjUVFCRnBPazIvTEdqN2RXRW52bU16RnhLNUorWHJrdFVMOWZE?=
 =?utf-8?B?UE9aeTJFcUM3LzZKbVVHSlZVNWpudXpRYzdGM3lUR2dnaFRQVlZVWDlCR2Zx?=
 =?utf-8?B?ZG01Z2ZoLzdmY1M5MDF3c2pqT1RCUjZoRGtLY0NocTFzakVxVTQ1L1NyMSt1?=
 =?utf-8?B?d1FPT0hPYjdLZ0tsOUV3cy9kK3U5SW1GSEhDaElVc1VxdzI5aE5XZ0N1Y0V0?=
 =?utf-8?B?Q21HRWlHM3M2UHpmUnhmT2Jsd0FzVnVRUWMwMFRSOTQwQUFBWlR5S3JSSnNM?=
 =?utf-8?B?aUkxcHdHcjN3aGl2TFhRVDhkay8rYVdPZXR4SFVWcVhZNnoxUXlDRGd1b3A4?=
 =?utf-8?B?L3lPVTZtZXl2K2wzbS8xdk5qdWZBTFNqMXdkemlqekpLUDUwT2xta1MrTTNa?=
 =?utf-8?B?SDQrMDRndnJLT1BEM05EdGQ3QXNXNnR5SjQ0OUVYMTRDVkszQXYwNGJWem9o?=
 =?utf-8?B?NDl1THozL0EzRHlwU0plUnN2bFNJelhicVlCWXA1OFM1TUNCaStSa3AyTTdn?=
 =?utf-8?B?a1FuVEZTallaeUhTU01pd0NaZUF6ZWdnbDl5SUhZcGNyb292QnhRYVhPMVdw?=
 =?utf-8?B?V2NwandwZ3d2Q2U4d2Zqa3YxVmFUMHd2WE1kM0Nyck1MTHlPd0xvVjEzbVg1?=
 =?utf-8?B?d2tQd2hKM24xZnNkR1hkU0Vhb1pORktMQ0Jqd0ZaM3c4dDJzSUd0dEx2S29D?=
 =?utf-8?B?V0t5alhyQXFMN3I0UC9pdWxRODZBTWRVYlB3T0FwbkVwVVJlcTYvaEFac1J5?=
 =?utf-8?B?MThWVlFhNGpTU3NwcDBGRUFKU3NDTzVjQy9MbzgwQ2xLdlhaaGZDa0RIMGVT?=
 =?utf-8?B?VEhidUJzQ1JTWkltMGRJaGxyNmZtOERMUFRQMmp1aHo3VXhBTVZTc2NTdTNN?=
 =?utf-8?B?QVNadERYOW9mTDBJYW1lMkZIa200TXdvSHB5Ulp2TUlEWmNUb3hWeWlLQnVa?=
 =?utf-8?B?Z21NZHBiNnpGZVVFZXlNN0dML1VOTHFpUFhRalFNTVBWZFRvQit3Y2YvR1lG?=
 =?utf-8?B?a0FRMUlzU0ZTS0JldmxoZmRVUjQwS2grSFpnZmlIcTBTSU5DYzUwWU94Vk5P?=
 =?utf-8?B?VHVKQ0NXajYvOUxyMGhOUEJ1MTIzNGRkL2Q1YjZSdTZuaFBKbVN1a1hhT1hj?=
 =?utf-8?B?Z3NudVdvZ29iR2R0RDNUTHU1TW5UUGhCMENlNitqL1k5RUppUmFxdWVVZ3Uv?=
 =?utf-8?B?RE5seGRua2Ryb0JhbHJHaWZtamVVRU9Hd3VpZHlEZ3BDVzJSMnMyYWpiWVl6?=
 =?utf-8?B?Q0twWlZKT3BLYmtENSt3NkNVemhMbUEwbHlSV1pnMmk0S2RndDR3M3h1RXpJ?=
 =?utf-8?B?cHJDNDl4d3plM1JkRVVwMWhlZG8veWJKQ0VkU2srUnI4T01GS0RmUG15M0xN?=
 =?utf-8?B?NTNtRCtta2VWUDMybzJ1L2ZNQ2EyMWtsa09aTC9YUUdmeTFWVXJxYzcwSUdD?=
 =?utf-8?B?MHVPMFZoUmZTeFhKalFIWmdmVERLK1cvN1ZjVjErd29Ed1RpYTVWU1RQUDZR?=
 =?utf-8?B?c0YvZGVqMENLZy8yT0dvUGJ3K2FXak1DV0VVdmNSK1NxKzRYVjYrY3dlbFJs?=
 =?utf-8?B?RU9NUndoS2dUM2daeWdVcnZZaWVFRnlTN2dFQUpFSnJDTFVuT3M0aElQSmZ2?=
 =?utf-8?B?eG50V29QNkNFbWYvVGxBejMvUElJUkQ1TFVkWGp4MVFsTjFlclRjYlBCTGQ4?=
 =?utf-8?B?R0hGS282ZnJhY3RGTmdDVzZ1VjFjRHBtYVhpekMrQ1k4d293WWZMV09JSzFS?=
 =?utf-8?B?SEVSSU5jRUh3QjR2OU5qaEU4SEFFdURYN3hJNnhxWlNXWllObmJYTFkrK1Ny?=
 =?utf-8?B?VHAra0xoMTl2Qno1Rk9zNHltQTljSFVjYjZIbjE5anJJby9yWHl2c3Z1Vk12?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vP3gbrHPhN3vB87hp5/aMvj9/+YiDPSyJkm+qsmAOuU2ubRFS2MMpo44Q7lAoaQmO8VZiN+M/g3twVNg37scjHgpZyA01uRxAIaH0ry8+nOseS3UYw4JRTSqlh8gyFAERp/pf3iHwne7NTk22je1FGX6uhYFEXF+5S2w+QEfey1IaRjUQs3YaePZq/sikAM3IFY4eMiKM75JdQf/Oqf18CkhqfyuE5XGKcX3hFR2vEfuL0tULsWYFmBBVH0cN54evaB6qRNhQddADBIrr7xQy3WVnqKNNhgwHKKXkPRM0UDOpTyQlVqoZuF9pk4WArL7l6ndXr3fU4CLreVDedcSfanBZZK8WNmirnrf2LJvIWZwdgB5fnbOmAJ//xWLEyjtpW7+X0PxWlr7OG7PdUMxuS589IsEkGKLN3MHuY0gq3v+gVkzmPVt2mhBCm5LjqNjxoVg/oMHNv/UBVPbPo41DuGfwwd9L0g+csvsiHjQDzFo+4rKgM8Sg8ND6RzCiYgYPIDcrv6HrjpMHd8nlwhB/0RnwuywPDvO1UkEhxeEidI5leMewf1tl/sDfmeUr6jFw0Y1lVsldED4sORSqk+xUT30T+tb66RaZoON8t2meuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44a8957-9b54-4e50-24d6-08dd82aaef15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 21:08:02.6421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyhUmeqSSiYrnn3NxqoCObJWMU9WL6RpVBHsBGW9PqPqkKP93H0WxeOCz4XuhRZj2OCmfML/D9Mnb9M59flteVJwM/zZCe3o8YYAvEzKNSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_11,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504230143
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE0MyBTYWx0ZWRfX3AkSSXUf//fW HTcJ2W/xhkfGiqicBZ9pqQC3xXnNihikTj6rGct78gytg0biqQe/z4dDbDzSTjdxNetwDXKnyrA Rl5XpkaQCPctxKgy8yL5Ryk0QIShe4SE8OBEOZMVyjrsMqgBFGtZaEzudytJI6zasLWu98fj8Vh
 pvlc6ju0g6XES1MAksh/XMvAAVug32lW0Z05gTqUbjCMeXvuZfgbyf6z0M8BFeVHPPVdriXjBqZ XpxlPQF5B4hDMrxZpO7iStpunLcE96ai8P/y+0g0mTABJT0Nz8YgSq4jWTak0OxnDanggKehy9v uAdcXLNfPcWwkHpBAnjaysV0GvrricIkLaVqKn3S1svEfgh+mvrLIY8aw5DjqOcXFup5Ti/bbcw v1+LUN33
X-Proofpoint-GUID: B34uLyDRhi5aoT88NKEsnoa_6h5uEnzn
X-Proofpoint-ORIG-GUID: B34uLyDRhi5aoT88NKEsnoa_6h5uEnzn

On 4/23/25 1:38 PM, ALOK TIWARI wrote:
> 
> 
> On 21-04-2025 21:57, Ross Philipson wrote:
>> The Secure Launch (SL) stub provides the entry point for Intel TXT to
>> jump to during the dynamic launch. The symbol sl_stub_entry is that entry
>> point and its offset into the kernel is conveyed to the launching code 
>> using
>> the Measured Launch Environment (MLE) header in the structure named 
>> mle_header.
>> The offset of the MLE header is set in the kernel_info.
>>
>> The routine sl_stub contains the very early dynamic launch setup code
>> responsible for setting up the basic operating environment to allow 
>> the normal
>> kernel startup_32 code to proceed. It is also responsible for properly 
>> waking
>> and handling the APs on Intel platforms.
>>
>> The routine sl_main which runs after entering 64b mode in the setup 
>> kernel. It
>> is responsible for measuring configuration and module information before
>> it is used. An example of entities measured on Intel x86 are the boot 
>> params,
>> the kernel command line, the TXT heap, any external initramfs, etc. In 
>> addition
>> this routine does some early setup and validation of the environment like
>> locating the TPM event log and validating the location of various 
>> buffers to
>> ensure they are protected and not overlapping.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   Documentation/arch/x86/boot.rst       |  21 +
>>   arch/x86/boot/compressed/Makefile     |   3 +-
>>   arch/x86/boot/compressed/head_64.S    |  29 +
>>   arch/x86/boot/compressed/sl_main.c    | 597 +++++++++++++++++++++
>>   arch/x86/boot/compressed/sl_stub.S    | 731 ++++++++++++++++++++++++++
>>   arch/x86/include/uapi/asm/bootparam.h |   1 +
>>   arch/x86/kernel/asm-offsets.c         |  20 +
>>   7 files changed, 1401 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/x86/boot/compressed/sl_main.c
>>   create mode 100644 arch/x86/boot/compressed/sl_stub.S
>>
> [clip]
>> index 000000000000..5e0fd0d7bd72
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/sl_main.c
>> @@ -0,0 +1,597 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Secure Launch early measurement and validation routines.
>> + *
>> + * Copyright (c) 2025, Oracle and/or its affiliates.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/string.h>
>> +#include <linux/linkage.h>
>> +#include <asm/segment.h>
>> +#include <asm/boot.h>
>> +#include <asm/msr.h>
>> +#include <asm/mtrr.h>
>> +#include <asm/processor-flags.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/bootparam.h>
>> +#include <asm/bootparam_utils.h>
>> +#include <linux/slr_table.h>
>> +#include <linux/slaunch.h>
>> +#include <crypto/sha1.h>
>> +#include <crypto/sha2.h>
> 
> consider header reordering For clarity and consistency

I don't mean this in a sarcastic way but what needs to be re-ordered? It 
looks pretty well ordered to me already. Can you give me an example of 
what you mean? Same for the other comment like this below.

As for the other things here, we will fix them.

Thanks

> 
>> +
>> +#define CAPS_VARIABLE_MTRR_COUNT_MASK    0xff
>> +
>> +#define SL_TPM_LOG        1
>> +#define SL_TPM2_LOG        2
>> +
> 
>> +static u64 sl_txt_read(u32 reg)
>> +{
>> +    return readq((void *)(u64)(TXT_PRIV_CONFIG_REGS_BASE + reg));
>> +}
>> +
> [clip]
>> +/*
>> + * Process all EFI config entries and extend the measurements to the 
>> evtlog
>> + */
>> +static void sl_process_extend_uefi_config(struct slr_table *slrt)
>> +{
>> +    struct slr_entry_uefi_config *uefi_config;
>> +    u16 i;
>> +
>> +    uefi_config = slr_next_entry_by_tag(slrt, NULL, 
>> SLR_ENTRY_UEFI_CONFIG);
>> +
>> +    /* Optionally here depending on how SL kernel was booted */
>> +    if (!uefi_config)
>> +        return;
>> +
>> +    for (i = 0; i < uefi_config->nr_entries; i++) {
>> +        sl_tpm_extend_evtlog(uefi_config->uefi_cfg_entries[i].pcr, 
>> TXT_EVTYPE_SLAUNCH,
>> +                     (void *)uefi_config->uefi_cfg_entries[i].cfg,
>> +                     uefi_config->uefi_cfg_entries[i].size,
>> +                     uefi_config->uefi_cfg_entries[i].evt_info);
>> +    }
>> +}
>> +
>> +asmlinkage __visible void sl_check_region(void *base, u32 size)
>> +{
>> +    sl_check_pmr_coverage(base, size, false);
>> +}
>> +
>> +asmlinkage __visible void sl_main(void *bootparams)
>> +{
>> +    struct boot_params *bp  = (struct boot_params *)bootparams;
> 
> remove extra ' ' before =
> 
>> +    struct txt_os_mle_data *os_mle_data;
>> +    struct slr_table *slrt;
>> +    void *txt_heap;
>> +
>> +    /*
>> +     * Ensure loadflags do not indicate a secure launch was done
>> +     * unless it really was.
>> +     */
>> +    bp->hdr.loadflags &= ~SLAUNCH_FLAG;
>> +
>> +    /*
>> +     * Currently only Intel TXT is supported for Secure Launch. Testing
>> +     * this value also indicates that the kernel was booted successfully
>> +     * through the Secure Launch entry point and is in SMX mode.
>> +     */
>> +    if (!(sl_cpu_type & SL_CPU_INTEL))
>> +        return;
>> +
>> +    slrt = sl_locate_and_validate_slrt();
>> +
>> +    /* Locate the TPM event log. */
>> +    sl_find_drtm_event_log(slrt);
>> +
>> +    /* Validate the location of the event log buffer before using it */
>> +    sl_validate_event_log_buffer();
>> +
>> +    /*
>> +     * Find the TPM hash algorithms used by the ACM and recorded in the
>> +     * event log.
>> +     */
>> +    if (tpm_log_ver == SL_TPM2_LOG)
>> +        sl_find_event_log_algorithms();
>> +
>> +    /*
>> +     * Sanitize them before measuring. Set the SLAUNCH_FLAG early 
>> since if
>> +     * anything fails, the system will reset anyway.
>> +     */
>> +    sanitize_boot_params(bp);
>> +    bp->hdr.loadflags |= SLAUNCH_FLAG;
>> +
>> +    sl_check_pmr_coverage(bootparams, PAGE_SIZE, false);
>> +
>> +    /* Place event log SL specific tags before and after measurements */
>> +    sl_tpm_extend_evtlog(17, TXT_EVTYPE_SLAUNCH_START, NULL, 0, "");
>> +
>> +    sl_process_extend_policy(slrt);
>> +
>> +    sl_process_extend_uefi_config(slrt);
>> +
>> +    sl_tpm_extend_evtlog(17, TXT_EVTYPE_SLAUNCH_END, NULL, 0, "");
>> +
>> +    /* No PMR check is needed, the TXT heap is covered by the DPR */
>> +    txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
>> +    os_mle_data = txt_os_mle_data_start(txt_heap);
>> +
>> +    /*
>> +     * Now that the OS-MLE data is measured, ensure the MTRR and
>> +     * misc enable MSRs are what we expect.
>> +     */
>> +    sl_txt_validate_msrs(os_mle_data);
>> +}
>> diff --git a/arch/x86/boot/compressed/sl_stub.S b/arch/x86/boot/ 
>> compressed/sl_stub.S
>> new file mode 100644
>> index 000000000000..6c0f0b2a062d
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/sl_stub.S
>> @@ -0,0 +1,731 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/*
>> + * Secure Launch protected mode entry point.
>> + *
>> + * Copyright (c) 2025, Oracle and/or its affiliates.
>> + */
>> +    .code32
>> +    .text
>> +#include <linux/linkage.h>
>> +#include <asm/segment.h>
>> +#include <asm/msr.h>
>> +#include <asm/apicdef.h>
>> +#include <asm/trapnr.h>
>> +#include <asm/processor-flags.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/bootparam.h>
>> +#include <asm/page_types.h>
>> +#include <asm/irq_vectors.h>
>> +#include <linux/slr_table.h>
>> +#include <linux/slaunch.h>
> 
> consider header reordering For clarity and consistency
> 
>> +
>> +/* CPUID: leaf 1, ECX, SMX feature bit */
>> +#define X86_FEATURE_BIT_SMX    (1 << 6)
>> +
>> +#define IDT_VECTOR_LO_BITS    0
>> +#define IDT_VECTOR_HI_BITS    6
>> +
> [clip]
>> +    jz    .Lwake_getsec
>> +
>> +    /* Wake using MWAIT MONITOR */
>> +    movl    $1, (%edi)
>> +    jmp    .Laps_awake
>> +
>> +.Lwake_getsec:
>> +    /* Wake using GETSEC(WAKEUP) */
>> +    GETSEC    $(SMX_X86_GETSEC_WAKEUP)
>> +
>> +.Laps_awake:
>> +    /*
>> +     * All of the APs are woken up and rendesvous in the relocated wake
> 
> typo rendesvous -> rendezvous
> 
>> +     * block starting at sl_txt_ap_wake_begin. Wait for all of them to
>> +     * halt.
>> +     */
>> +    pause
>> +    cmpl    rva(sl_txt_cpu_count)(%ebx), %edx
>> +    jne    .Laps_awake
>> +
>> +    popl    %esi
>> +    ret
>> +SYM_FUNC_END(sl_txt_wake_aps)
>> +
>> +/* This is the beginning of the relocated AP wake code block */
>> +    .global sl_txt_ap_wake_begin
>> +sl_txt_ap_wake_begin:
> 
> 
> Thanks,
> Alok


