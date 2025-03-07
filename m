Return-Path: <linux-efi+bounces-2935-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B30A5726A
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 20:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D58F1898A78
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 19:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A061521859D;
	Fri,  7 Mar 2025 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V3qZmO97";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iQ55duzv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7D183CB0;
	Fri,  7 Mar 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376725; cv=fail; b=PJlQg+e8EzW3d3Gyi9ucJviV7F3PF7uSzyPP02nRwNvfHFgo+7YZXKUsS0VnuwKWak3PNBinp+ep8pOvhsNGwIxPxDn6+MJo1ilRxCYorVSKEMXyjrgqHJimYbWwWBXo6zexHQhyYlLviC1WKrlTBZ2EHK/N5l79MQb1sAOooMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376725; c=relaxed/simple;
	bh=XbrEUFEKIX1W8bOJ6FCGVMBUp83+3s0NPd6mXHozedQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dy+iMjNqPBliJKugZknxM5ZeHlhcRqqXzl+sH4LvhhPR0YVo/SSvHDim1bbWC9sPr9w+842qs2M0YcIqF+Hgs8k4nprmH0drwZPG8GBQmhiEUzhGEpYEmFCdU5v3ALYd+c6W/fa2Bvk0qHgA4IbmfX/itkPa/EP/eg5nqYc/YBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V3qZmO97; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iQ55duzv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527Itmd7018161;
	Fri, 7 Mar 2025 19:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=S7xylLGCrpRCjDbsZbitRn5qJSVzHOPDEobmC8v6oPk=; b=
	V3qZmO97ld635Wt3g/ezcIjtpaFne+En2o+UqHwe7hHOgaS6yJFkoLASd0YbM1bW
	iKApMz96glJboswOP3sF9e7DRoDr73EtT7W/eJ0d+ptUAr5tqNCPCLHOZER7P2h2
	pXN3DRJl1SQI/kzHEjjHkoOEx30WiMg+Z5CSpZzXIjeLwtzoVKYAkOS/8/IxudwS
	EwP28dBjG1RyZsqj4a9HkjHKiS6oTBz3GSEMtp7PvQVYyWGF7ENydfcIWpntbav0
	TXC5F+3wL0xOh0mzbbZKdZBYc2kvff1OReJyRIn1r2h812eG6sc6r68it1yhZ4if
	C6Bb7ry2j60ODDWdeeBMzQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8252dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:44:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527IETZ3015758;
	Fri, 7 Mar 2025 19:44:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpf13bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:44:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzmIvY5No1Y8pazpeHuV2ys5K5gEJQgXnmf0ED1MgPhD+FuSSwPwnhX7Dk8GwflOXx+RAKXriWUmFMG/f2i5lTINg9B1yrjy/vo0KC5qMDRNaaiTDN5mBDrBLRFOQsKulAMoIJS0xd8RLXPZTDEepztm/YfpdcTyp9brOyecMKhPdE1gOh2zrHLzmAw9h0BLMkT1L03rwF1blrI7SKoKy9MAuq3Q7UmuwL2s2XwaTqq5U9DrwrvHPUB9QuX45HBDPUHuRn6r1TUmqxPPS+z0xYYK3jK+VhX/5UHJH7Th+4ZE9llpwXWDFG+6iqcNKA25C+hYMPDVGg5Na5SEGkiDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7xylLGCrpRCjDbsZbitRn5qJSVzHOPDEobmC8v6oPk=;
 b=NVsUvKWS00rJwQ7Z3d+7dVFCJD8cuLwfeI85aSc1v0LpeH/O2L2VLZQvrJ9bUgSo42jObOa16ikZiK4I8br1PJaw7Sl1JNLW57eMJ26FD9YZicA/vn4hzp3bjBLMPKDd0WrV+zWUAKb6fiIEv5RW4oEB9j6FTpaKf8hF++Fbq5O/+ZxFmwCZtB2z/cgdRuiGgBGUwPE6yTS+ZBPWkvQlv7PHDBh0sWQbuqn2+yrSNJw1oDy/iJA1qNvy7n1b13IsnQxBBryDp74IF8EtfgIIfRLEeqylL5DgRdxgps4DnVs5aZzI0Iqj4Hw04dESIrLBnbegeVL1JScffxe7cjB73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7xylLGCrpRCjDbsZbitRn5qJSVzHOPDEobmC8v6oPk=;
 b=iQ55duzvjjNvYYUZcOQGhRn/uTzLzDI/mRJCvmigBYontMUrRWNG/4mXdAwp2VexYF9UuvaP6AHY5HQ6ACQU92Z+vw86KbvphSTCwrF6FuHEzrEGL/w5ryLFhEdVb0epGC9yO/mxUW7uiZRLZPcxR5p+R8Sq+zXexM6rrWTvWzE=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 PH0PR10MB4632.namprd10.prod.outlook.com (2603:10b6:510:34::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Fri, 7 Mar 2025 19:44:46 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 19:44:46 +0000
Message-ID: <4b1d9f3a-4a1e-4a9f-83fd-f5945217fc11@oracle.com>
Date: Fri, 7 Mar 2025 11:44:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 03/19] x86: Secure Launch Resource Table header file
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-4-ross.philipson@oracle.com>
 <Z8qE1B47InxE7n-v@kernel.org>
 <de143ab2-44b3-4609-a575-63c47d99ea09@oracle.com>
 <Z8tJZBl2Nh4RJGDS@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z8tJZBl2Nh4RJGDS@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::19) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|PH0PR10MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: f576666d-d135-42f5-363f-08dd5db083cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlI1UjJCdDYxTjZBYjgzMXdsU2JZRmVja2w3anZOTmJUZ0pyYWJSN1NjWEh4?=
 =?utf-8?B?TjVaTU9jTWcvMk4yVzFSSmUweHVJRVc2N2J5WnpQWUZzeVJ3Q1UrSk85cVJl?=
 =?utf-8?B?MjhGYXRacXprcFJpdGcxWUE0dG9PQXBTdnZtZEVKM3doazNlVzJCbEczS3R5?=
 =?utf-8?B?bFhhbVQrem9tdWZrUld1M1lUdCtJcWxlR25FbVVYcGF4M0l5RFUydlBnNWZS?=
 =?utf-8?B?QTRwYVQySmYzMjNJSStmeHRmZ2JSVFEwaXlKRHY2M0NFd0w4RktYbFBvdVhT?=
 =?utf-8?B?SU1OTUJlRnpqeDRuZVJYUEhiK1JhcVpYR0gxMUlKTWZZdDVvM0UzZ0VEVVhL?=
 =?utf-8?B?UDFEMFU2dFdSQ2prWEt0V3ZnT0xjRkNtZS93emJmbkQ1VnowQ3pxeUhwNm1i?=
 =?utf-8?B?bWhMZnlhODdWTThwdTEzODZEZUtYTTZ3dmdlR0ZJb0xrcmp1Y0IwQkN6Qk1E?=
 =?utf-8?B?dHZwaDlhNk91OWhxVCtyaWFnK2ZvTFVhaUYrNlRCMy9VNkVUVDF4YUU3Z2pP?=
 =?utf-8?B?NURQS3ROMm5WZVZHN0tOWmRTemw2K0NWYWJKdlFPNjZUcEhwTVVVbVNMK29j?=
 =?utf-8?B?NUNJamtJd25ISWZ3SzJKbDRzVmhvNU9ZUjBTWDh6RU1YbmZTTXRxNldiYllZ?=
 =?utf-8?B?NUhsU08wcWRHRjY0ZkVveU1FdDkvUzFSRXA0enNpbVNjSXpFTDR0TGhXTEpw?=
 =?utf-8?B?K01kcnZ2VUt4ZmVWbStReVlOVEJMaTczU3Uxa3hyT0NvNVRlVCtTNTdNTHRZ?=
 =?utf-8?B?M3ViUUxGWUZneWFxS0trc2RSWWNzbktWRTFwSDJ5WjQzT0RjT3BTSXcvaTBI?=
 =?utf-8?B?MjlubFBYWHVCa3MxUE9aV240SDN5VFhidmZvR000M0NZY29NWUtIZjJBV0Jy?=
 =?utf-8?B?cFNOdEl0azV0Z3dQcnR5UVhBZ3dOcDdtaGJvUFd3M0s1MjhHMUpwVTdPbG93?=
 =?utf-8?B?cXBLZnc2a2x4bHpGU0hLRXg2aW41RTBxUHhvSklyUkE3VDdXbzdOYUh0RnB0?=
 =?utf-8?B?WXBDcmMrZ3JTYUt5bUEvZDZDNEt3R2dadlJqSGFRMVQzQjdWWkZ3L3pKbVhU?=
 =?utf-8?B?MTh5bE56Z1hDL3k0SnMzSUFrTzFpRmFxcXBCd201TDdkclM1T0ZNNXVRTnhJ?=
 =?utf-8?B?eXY0Ly9XWm51V2ltT3BkRWw3R2FYa3JMWDVpNVYyS1VmK0JTeGVURTlINzNF?=
 =?utf-8?B?UU1jMFAzakxGUk1wSmo1Y3gvc0QrSS81N2R4YUc4TXllVWRkVDRZZzZ6aWNy?=
 =?utf-8?B?VjhyR05BZlVoVnpKNFlsOHROOGpReTdRZG1oZEdKTW92WXlqUmN6VHIvNUhs?=
 =?utf-8?B?VWlWbW1sTEU3NW41b3R1b0lNb2dNejY3eEFwcHoyUXN6UTFtQVNPYVdIL1hJ?=
 =?utf-8?B?V2lQVnJEcUxvWXFIN0lOdzB0UVpHSmlDQUhPdDdxTlA0MVN6Ym9oUGhuODJD?=
 =?utf-8?B?WjhETWEwK244Vmw3KzkzLzVQMlJlUGFxeFdjQ3VQUnhIUjQyc1c5NFBvbm1W?=
 =?utf-8?B?bm83K2puSWpsdUpqeUYxdmJkd1RCRkZmbUZlMkpLV2c4RjZDdWJBNFdTOTNE?=
 =?utf-8?B?NU4wQUQ2SHIwcGF6Nk1UMjN2ZjNIVzd6TmZmQzFRa1BTQXdySTFFTVRob05P?=
 =?utf-8?B?cHhpWXkwVE1kWkM1bXQ2NEJQekQ1Vk94bmMzcHZnb2lxbmpTMEtPQWFnTFAw?=
 =?utf-8?B?R2dwMWRnWG13anh1K1dyT1FKSkpKK3A2UGU5bUxETStSZHU4VUppOE9tWXNK?=
 =?utf-8?B?UTJueWF5ejNxK3E5ZGl1VFJBM2NXWC9ha1JGMmVJRzBvMmFmOWFRb2N4eFlu?=
 =?utf-8?B?TkZla0dGWC91VE9LeTZHNzBYRmxZNE1FRWU1YmczUy8wYVovUUZWSmVZbURV?=
 =?utf-8?Q?EMllxkiYRhsmf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXc3SHUxS0Rud3pEdTJ3UXlVeVJCUTBCYkxFais5dWV6cFNDRkZqQVNCOHNE?=
 =?utf-8?B?dG9yR3FjdWQ4N05oS1kwaUlrTlFzUUxMOGY1eTUzbXRHWjZET20rbTBnSWhK?=
 =?utf-8?B?Q0RGQnJieTcwenBlUm1HSC9sSGJKQkNkUUZldzFlclVjS2QwamdFbmY1WGtW?=
 =?utf-8?B?dGFrUGd3YkNPV1JWemY5UlpLbUtBckYvNTBIa3RKaFpBRlRrVU5McHdvTmZu?=
 =?utf-8?B?clE1ei9MU2c2YkVxVFFqa2pxc1dHWDZrTWNTenNEcFRNVTVvZUMzZVZOMi9C?=
 =?utf-8?B?WUx1aUxDQ1NLWmQ2d29seFRZbWQ2dnZwYWRuTjgwTXdFdHExcjhweWNQK1po?=
 =?utf-8?B?ZTlXMUhhMktNK3JjNGkvcmVVSFpNbEdwWDJZZW9uMzNXQVJjU3FidEJnaVlC?=
 =?utf-8?B?bUxIMTJMVmtrYmZzNytvcE01MTBUZ2dMbFZQQ3h3Zldhby9ZTWRJVnkwUzI1?=
 =?utf-8?B?Y1o1TTFndXZseVFYM3lsV3ovRTRuSDFMOVFBZ0ZLcjB3N1pScU5BOEZraWRE?=
 =?utf-8?B?VTh2YjZkMXA5KzdZN3dzVjF2VEJGVkhhakswUFZKUTBZMm1MYzQ1a0JxbFho?=
 =?utf-8?B?ZzZ3Mkt5RDZ3TWRTbWVnVDdTL0RLVmtPM3lkYzRsVnVRdXl1b2JneWlFVFBN?=
 =?utf-8?B?aHdvYm9QZFlVT0d2WkhZUHFxcXpIaGRoTllwSm1RNm9HaDdOeHBDaC9rYWdV?=
 =?utf-8?B?OXFoNGdpS1NCRDNEREdpdzZ5N1NwSlFXNjZUVkpuaUNYUXErZnVUZmd4YU5O?=
 =?utf-8?B?cFJlRStpYitLUXlMMXJNR3dlYWUyNis1ajhDekFxQ3JIeXA2Ri9PMjd5Zmo1?=
 =?utf-8?B?SUVhU1lYWlQrYXhjQmRlZURkU3ZMYzAxUnFYSEhabExlQjhiSG40VGkvS0RO?=
 =?utf-8?B?MmEwVVRuY1ZSWFhJUW5kbzdnNm1nQ3pRMEYvQ1VTYXo0QURuV0hBRmFVeHlW?=
 =?utf-8?B?V0tkekhtWmdneEhPTWN1ZHc2Mm1URjJwOWMzaFlOajJUb0t0aHRLVnZpTnNJ?=
 =?utf-8?B?WjlORmZBZTJiQUoveDUxeWJIMDh6L0EvVGN3SUhRb0JrQm9QWFZMRmJ3d0sx?=
 =?utf-8?B?ZlRUTTRWbTlnUHUxdmNsSlhJR1pJblFwRUdXWFFzRkZUL0tPMmV3aTBFZnZn?=
 =?utf-8?B?SEZXZjc4dVpzYlZ0c3V5RUdkOFQ0UGdCczRJdkRCSXZlWHprbEduU2U1eFJQ?=
 =?utf-8?B?cU0xUXVyQmRLQllpNzdpZnViUHdXYWZjVTdFMnF1SWZMSHNaL2g2YXI3dmR1?=
 =?utf-8?B?eXpweUF1Y1pBTUZZWnNveWpvVURnbkp4dDkrckxOOU9KSE41L09zZ0tjU1dD?=
 =?utf-8?B?d1JqdGlVOXgyTWZjcDhhdUJDNkg2aFVDSGlEaDJUd3p3b1RYcUQxNXFoTXVN?=
 =?utf-8?B?TE5zdTlxMFA5NklkZzlhZTdFUm9ibkxRTFA3MnRuMEo2cXR6Qi9adVhVOGU3?=
 =?utf-8?B?bmdXK25CejRaT2JGQVdrYlpqT1N4VDlQeTN1cmJvejdvaFB0VGZQRE5MTFlK?=
 =?utf-8?B?Z2ZjMGc0ZnFsbEZDK3VRUWErWjJwbkR0bGxCa3RpcDZCUHVkZTZWMEtURC81?=
 =?utf-8?B?OWQrSk5MSXBNeEs2NUdTYjgyMm9PVUdSWXV6WnBSYUt2ZE9oL2Z1K1o4dFpG?=
 =?utf-8?B?UndxdTlVakhrTEdMRVhBNzBETFlpM0NvWXRMY0JXWnlCMUZYUFJqL3o1VGZv?=
 =?utf-8?B?YzFlV3d4NFZPQjJsazg1K1BMbVpHbHRBNzVvVlZMUkVoa1RXZU1yWG15UkRR?=
 =?utf-8?B?bmdQMVRjN0VUbWNwK0hPNkdQWGtOb0p4eW9JSmhyemVXTHl2WFlhVUhqSk9Q?=
 =?utf-8?B?L3NMSjVHalc4TlBuTlhYSEJPZ2tEOG1ycnd1RTdlaFVsNzMxYzNKQlpvZW05?=
 =?utf-8?B?S3BnQldxdGI0dWJBV0dBdmk5clFzdGN0d3FpLzJmc3pQT2lQREl3eE45dGVt?=
 =?utf-8?B?QnlVSlJMZGJUZFpCVWlhSGRMN1Mva3R3dFcyTDAxWHRHSlprWHBIUEZtYTYr?=
 =?utf-8?B?L3g4NzN3TEJnbDUwTGdTN1FpRGZ3d1J2c2R2bTlkKzdEemw3TnZDeG5EMjNw?=
 =?utf-8?B?Nmk5cnE2U2VTbHdRSGtrT1BiWUM2V0dOQ3BEclJNdkVYNExLbWlxcnVNb2lC?=
 =?utf-8?B?STVKRXRFQXpmZ0RFQlFXQXNNSTk3d1I1TFlLRVBzSzJOMzJJNUM5TkpPd0dh?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RnSXkCj9q1rLpkIJixBKpLw/Y8dPSiE2JlSOl0DXZj9YyjRIX+SuqQq9m7J4xnaH0MV2x+2T66v23ZPE3ss98MKYr9C/rGjZRfsOzisRLKSpYgsvbRQzBxVuOQ9RrKgu5gO8TztlPbA58TSKz34ykSduHSM4crqb/DG9ydpbWmPV8GWh0jLD3/9fE39OYn5q45ZCIWW8Sf6gh8WFwTQ2lCM0St59YinNSfxho52YBqhTTbSPVFyG5FbDrjcfUo03+yw33hjL+tLvXLImt5iKlmf9JYJf+QykpNCJ1oSu5JiAMoVNKjmi3VjZEAcUXwUsmHmdlWkA7mjrCPKTRYZ1KxT92rxz/tI8/gb+OQ1sR+CTJq3fBc45s5kwcDEthJZq1C6gXVhx7cpeDXhlbIsIgRtnaSxxWgWT+v2kpju1GyDe/lkvGe3KzZ46brd5zp46QSJqY3JiPj+/xI/ErW4tjfjIH65XHVsQtTCNYMBeic7z2zLixV13a/AkvwdDY+FzDflL54eEvtAma6Zaat7kWC56DAexnDvmG7d8Qv59AeVQ2cdpn6j+VgQ+IiKXx7a/OIjFkJYazYZBQCfXtU+AOMDHgtsnv/hhS7e4a+vx4QA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f576666d-d135-42f5-363f-08dd5db083cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 19:44:46.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPCVRu3DniB+KD4Wxn6DvZ+7hJU+EecW7KWKZT9zqeFW1xxgB9fKNIVSU6uIvF5e0FYIAgPZxRA6kT8XiL2X9koptVpllyIYuITkcXOLf00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070149
X-Proofpoint-GUID: 5R2OSGSJMZLsJPNLCjLcBlDTDNSmWGG9
X-Proofpoint-ORIG-GUID: 5R2OSGSJMZLsJPNLCjLcBlDTDNSmWGG9

On 3/7/25 11:30 AM, Jarkko Sakkinen wrote:
> On Fri, Mar 07, 2025 at 11:22:02AM -0800, ross.philipson@oracle.com wrote:
>> On 3/6/25 9:32 PM, Jarkko Sakkinen wrote:
>>> On Thu, Dec 19, 2024 at 11:42:00AM -0800, Ross Philipson wrote:
>>>> Introduce the Secure Launch Resource Table which forms the formal
>>>> interface between the pre and post launch code.
>>>>
>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>>
>>> Is this interface kernel specific or uarch specific? I'd just
>>> explicitly state the context of the formal interface, that's
>>> all.
>>
>> It is specific to our DRTM solution (i.e. Secure Launch). It is meant to be
>> extensible to accommodate future architectures that have DRTM support
>> available. Not sure if I am getting at your specific question.
> 
> OK so:
> 
> 1. It's software defined set of data structures with no ties to
>     the hardware architecture.
> 2. It's essentially an API maintining backwards compatibility.
> 
> I have nothing against that definition. It is just that speaking about
> formal interface between pre and post launch code does not provide
> explanation on what are the constraints of the interface.
> 
> So what I was not getting was the specific definition (i.e. *the*
> specific formalism under discussion).

Ok I get what you are saying/asking now. We can make this clearer.

Ross

> 
> BR, Jarkko
> 


