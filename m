Return-Path: <linux-efi+bounces-5895-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EE9CC9397
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 19:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3FFC3034D78
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2578B2874E0;
	Wed, 17 Dec 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gggfRdTV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qJsageVo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00EF285C85;
	Wed, 17 Dec 2025 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995119; cv=fail; b=pf8Ep56c5/vrdQebjDFsPp+A5Evcz918RDy309TNBhG2WiHri4rPKobmhnf2jxPonKvP8SUHzekUf7D9ojV4ED9P6PSlUkwLsOuvr7JKqExop/+SYFEUo4HyAoUW9TO0+RMA1g8R3pPHzrMOPfeLcZNW4c4+cF6tokKj8PIR+pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995119; c=relaxed/simple;
	bh=Gj8suighnNrE0zSgvpQ5oNle9KUi+GYgxYBIOYqC69Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H/pCyHLOLoV4kY4Ygc8ZOcBMWbyO+kCdAHkKwG1eAKscqbQd2ylf+c3Sx9ri+oI3FmrC+pT3/LVIqb4PxGt7JQvcs2SmhyULo9QD+wtyHEtlo80dgsIzBAKvL1JbRu9y2TWm00IXGn0DHEQawbmH561aTNVm9M3SCR7XgeRbaVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gggfRdTV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qJsageVo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHH1W1V3141006;
	Wed, 17 Dec 2025 18:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0axmbYz+ZiEh5CBA249qSilhdSvfu213BRPfCBZ9hwM=; b=
	gggfRdTVyZIKmf1jxY0KHD2bN97XxcV2ml2npDpM3kKgCi7bQx1JnbdeCuiS7CXM
	KKalDPP4r0XoGziBT1H1/pqDldGG/jZ27zc+RrFLhc9ajt0BnShBhoaBbRkiV4EY
	4YbUiTNOUK5F+6BDSoB0PCJEHWXEBvXxnkgZmu/6R2t8Diy+F9eW1p7Nfphkc4Fo
	J9T4fxnaD1DI1jRCM9qVRXgj2DNPQXuoWiWQagxv7RKBALmqNzwhceVXaTNNYM0s
	8EM/u6YjJfkNUyJ162/6J3nTagGWESDabEMZUMMHcZlELIDW9snu1px1RGKkcgw2
	BU7NOg0ZnePPj9WPY+y1Kw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja6bdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:10:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHHDIkG022544;
	Wed, 17 Dec 2025 18:10:58 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkmwdcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:10:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAGjyDgicZuyFrM+VURWB5V7zidS8DbeKhs82+GaHRxztaZg517vcuY1DfM7uTMQegEOSZlTaLZLCE0GETiKdL/sfWd2JLjzGUZYxZLfNDCJB2hwg4knnHKfFUJviAOGWp366qf/gPDSK5szusyX9dzQxZx8mZlZKstMAkfLtnD2//boXotMqNaS2PDlIiZsXYeASnjOm4ie2Uw9sxU05rHHOrcEwFybZkS2HoPXjeN5myag6kHeYlTcAXR39yHv7s/Z9WWTqF5DsaTxdYunzG7SdAahR24CES0l/73aPYSL8UMFrypDEzGDUow+8RRdt6KUmwSjAN360V06+iWHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0axmbYz+ZiEh5CBA249qSilhdSvfu213BRPfCBZ9hwM=;
 b=yKTy1IeQySIGxOjEwGd2GD8JZ25dfRE6gMVMl1g8+B0EmDijPbKYvUbG0jWfeCAc8GnyY2ilZ+oc0bKbrPV3C0kGVEl8kBtHv/DCVjJpkSWdE0Ms59f9pJWy1bxUB+eOr/gWi1/GddcMqcBb6YzJ0lWPpoL11Y/PhRH7IqinWXfPXKdoviDTF7mxhSAQhmEJmBlSKeeVOrLf0MhK/uOt7OBmt82z+6R6nN1DEPVt5Ct5tlQT0Z1fqpym3sojlfJfxLoDXNJkG2FenF9jFk9bo3Q+ydJ1qX2mqH2O25fqcAmhmIOW7GgedTTwRZr+fXPGlcrKn1UTtyEHL7Hhu6Ye0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0axmbYz+ZiEh5CBA249qSilhdSvfu213BRPfCBZ9hwM=;
 b=qJsageVoycY3d2gDGZ61fT7pFt7DplOLHWzW9IVcIMIkJVE28qpbCWyaibFlwo7UFWMRqMDeA2j6V5TAw6EovYCmt/CO7KhFVb/cx2ySv2Opda9W/TJTNVCRBgAMLPZbeXoPyKDLCMA4HTrHzlyLSO4E/YyQ3Jo7YGafjlCbBjY=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 MW5PR10MB5716.namprd10.prod.outlook.com (2603:10b6:303:1a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 18:10:52 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:10:52 +0000
Message-ID: <83cd48ad-2534-4ebb-85fb-9bf414010022@oracle.com>
Date: Wed, 17 Dec 2025 10:10:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 17/28] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-18-ross.philipson@oracle.com>
 <20251216002150.GA11579@quark>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <20251216002150.GA11579@quark>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0136.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::8) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|MW5PR10MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d835aa-a119-46ba-baf9-08de3d979d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU1rbm9ScEh5djlxRXp1OWZGMDF0ZDhPWFFERnZRdTBvMVFreGZESE9aRi9E?=
 =?utf-8?B?citFVXJlSXczaUJGWUowS3h4ai9kMExPZUxXZlRITlF0NHBwNVdqQXRSYkRH?=
 =?utf-8?B?NHdicVRXc1VJQ0lNN3didmh5Qzhzb0tRMkd6TmxPVGtXdFJ1c1dYb3pxWWRF?=
 =?utf-8?B?NjFJWnRoV3BJTGdEdnh5U1RaYVJrQkZNNEJSUTdFa05EeWRLYk1Ea2JTVlVF?=
 =?utf-8?B?cGsyNm9xZUtmK2E5WXV2R2ptZjhjOGVpMUhHaFhoc0tleGRkeDZiRFZNb1lx?=
 =?utf-8?B?ek5pQkNOc0k1YUpUdEMvMHhtL25sY3VrYnBHMUdVQUhPS1UwQU8rQkRveE82?=
 =?utf-8?B?NnBEQ3JjSkwzMmZ0eWlyc1ZPRDZLM2tZNnRWTm5wUWM2QzFUWFZTVE13dVdn?=
 =?utf-8?B?SEZaYmZSUEw2M1BWb0RnZWZqN1RzZ0c2L2hGTHJWbDZ5SUVzTzNSVkZOREJ1?=
 =?utf-8?B?RXdkU2xFbDY5OGVhelpLU0ltUVg4UnNkVFI4VkRlZlpGVndvZUViMlBtMnNx?=
 =?utf-8?B?aHRIUnBvQlZJSGU4OHAzdGFFazJPMUEyc0Z6RFlDQU9XeGpuSGVlQ1dWM1dP?=
 =?utf-8?B?RElib3JhUkxLRVFQZzRIc2kyOXZKampqcE5xZXMxTjdIUzlrS25nSXljNkZE?=
 =?utf-8?B?MjNZS2RMN0NveThOSzdtTTRlMUVMV01OQTg1b1JjMjJ6S1Roa21YTzJjVUF1?=
 =?utf-8?B?N2dRclpmK1BsYzdIcGVJMnY3dURIVU9NaVQ1cmd1VWREcVh2UllFT3hSNEFn?=
 =?utf-8?B?Zlh6d1ROdFd0T05MRXlaRXdEMDFCWEl6WEt0OHZzK2RCeWV0UEtnWEJwc3No?=
 =?utf-8?B?MnZXZ29GMVI1MkIvUU00b3ViSTNqTXdraWdQNm9BYWhhdExMUy84ckQyeXBs?=
 =?utf-8?B?Y1F1VG9FUGFRUHJLQnhCQllzL2I3Z1djWmprZ01EamZ3SFNwNjF0bW4zc1lj?=
 =?utf-8?B?b0UrVFdNd1k5ekplbERUdk9RTlNDSHArRFVWMTZwTFhvZU10cTBVM0lkckdy?=
 =?utf-8?B?RkNMMDJqK3IzbGFNckNtd08yellUU21oMDIzQUhreVhkN3lmeWVXMXFZOXow?=
 =?utf-8?B?STNvWW1KTEYyek1LSWNYdHdBZC9aYzRKcm12QVJPZllManFsWmR6QUZtYWRT?=
 =?utf-8?B?Ly9LelQrYzMxa2E2cVAxeWZUWjlPQUV4RFVMMkR2MjdETjZYcnQ3ZXRDNlhE?=
 =?utf-8?B?U3piU0E1dms4Ui8vL053ZHZMcFJoazQySEJwbmQxU051QWFVTC9ldHcvbWVk?=
 =?utf-8?B?ZVdjSWtKY3dDVGY0ekNsVkhGdGhSQW5pUjN2emplT1lXbkNza3crRlE5NFNy?=
 =?utf-8?B?NUlUaWtESFJpTTVERUZWVFN3aVVpSWpjbzVCeVZCaWNrNjkxWENaUDZTNE05?=
 =?utf-8?B?dzNJVHFtSm01U2E5U3l5cHpwT2RLVDAwYVNLQzQ2cXVtZm93V0h0bDlvdzVk?=
 =?utf-8?B?Ui9oV2xxaVVEODFCTCtzQmowUXI4ZlZmUzFWbjh0bkxzVFIzbE5mNHY3ajUv?=
 =?utf-8?B?MW9HYnFJT2ZLcW9NSnJuU2dybGpPa3RxRnlRNGFkSEw1bVErQm9EemVQbUVp?=
 =?utf-8?B?d21zeERVYjIyMEpxUWs2MFlvOE5iUDQ0K0hMTzIxeVhKaWF3blg2RG9KZGpo?=
 =?utf-8?B?Ukd0djNVTTRkUUdFdkoxS1ltS05tWWZTZnBrNEdrL0h4cXB3VVJVekV5U2Vm?=
 =?utf-8?B?MCtmdEYzd2J0V1d4djZGa3hwSHVtOFcyTGViSnhyZkttc05xNzFiZWU0TW1n?=
 =?utf-8?B?NCtvWHEzZjlSZ3VCUmw0Y0dtejJVRmFjZTRtZ3RORUFnTHNyUkQ3TWx5empJ?=
 =?utf-8?B?aVBmNmRCOFpXWGhwMTQySXdPdk9Uc2g4bmlna3dLZDBvZEFrWDViMXFvekFP?=
 =?utf-8?B?OEFYZG9LNDVaZERRd0F3UWtjSUx6KzBXazE1TkIwME5tNVJhbXFzQnE3U3kr?=
 =?utf-8?Q?EyaP8xGO6jISecLiYt1U8G9wppxZdW2a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3k3bG1VeEVHTnptbEJ1QXFLL2p1MytENDFuT0F1NDF6bUdxVkpmTkpGZzgw?=
 =?utf-8?B?Z3NqYU80M2VmZWRKZjZRUnlwaUxKUjdxVmlHYXRtbkFNVEVyMnIrRUJnZjEw?=
 =?utf-8?B?Yy84RWkzVVdOUDZBL2wxMGZpQXRMWUdaQllDWXlwN0lKWWNkU0c4VVIyY1or?=
 =?utf-8?B?Sy9XZnFoSk1nOTdDVXcycGpvemhIcnpIaThLaU4zQng4TU54Z2NwTzlWZCtn?=
 =?utf-8?B?Q2MxbDg1MjlETkJSVVRQajFucTJNNEJQL01oOWVuTlZzbGg3MWNZN2UzSEpI?=
 =?utf-8?B?aDRPWGdmV25TTnpnd0dQK3Q1OWN3YUJFdzlHaTNwR1BCSVdsQU44ZmFvTFhB?=
 =?utf-8?B?RlNnUSs3VUZhQ0F0R3E2NDc4SGVmakVsTE1lMGRqL1hTU1N6dVNBN051ZERB?=
 =?utf-8?B?akdKNTZodE5PdURUV1lyOXJvNEtVS3ZadVJJYUNwNWNKbUErYXkrOHJ5bDFW?=
 =?utf-8?B?d2p5VU52akljWXNVbjhRTWhFUld4OVR6OWpqTlZFMWtBMEJYNDF3Y0pZTTMx?=
 =?utf-8?B?SnFtWGtnZUxmZS9FY2VweDQwaml0TnNpc3ExRXRVUTFYWDNGOU5kbmEyclpv?=
 =?utf-8?B?Nmo2ZVNHQ21SZWE4VTZhSmJBU2RKdkJaQ0Q3WUpWNkFQc0hnSGEzQWRTblJz?=
 =?utf-8?B?RllCd0xDUzZSSnFkaGRXUlMralpIZVgvK044WFZQQld0bnNEVEowNDVRaWcz?=
 =?utf-8?B?cWJDK1lJSXErZ1JWaUNTV1RNSGowNXI0d3RBMVFla3dhZThQbCt4d2IxY0Ew?=
 =?utf-8?B?VndsVEk1ZFhJUUxSaWU1dXphRmw0NnU3NmlrVTI5WkJiNDlLSXlXSW9xWEpv?=
 =?utf-8?B?OVp0TGkycDJmUEhFcWc5Zmc3N2gyMnExdDU0b29jczRyTGw4VWp6cHFobUF3?=
 =?utf-8?B?RkRuL3VSVGlyaGozN0Q2b2RMYkV0YVJpeUtJOUw3WXVubkE4SkRHczB6Wktv?=
 =?utf-8?B?cHYxUFp2V3NJNnE0MEVveUxFcG91c3NoZEhFSzhyVWlUa1NVKzdGeWVsVVFD?=
 =?utf-8?B?eTljdDdMdDR2cmRaUldLVXE2L25kMzVSd0V4YXZ2RS9PbGhmTGZJTHBQTVg4?=
 =?utf-8?B?L3JTRzc0RWFRSjRROWpuQzBtd2NqYlRqUHpsRExva1VmenZwYWZVSlNvbXZj?=
 =?utf-8?B?bmtQaVhGb3JFMDROYk14UmN6SS9qQ0RqejNvVXRWMFRLNSttUE9qN2ZiZTEz?=
 =?utf-8?B?TFZvOFVCTkVEK0JVQmFTcHVNYTV2aUpaUVBITUY5Y1pxVlduUXZ2aGk5YkRu?=
 =?utf-8?B?d3B6ZFlZQ2I1QWJVdXYxaGhIUXh0V3ZNd1FmRE5rWXlOUTVxa2xCSlZNakl2?=
 =?utf-8?B?TXlaRCt6ZzY3eFl3TzZ6NVFxSGtLb1A5dG4yRmhoSjNQcGU5eUR6Rk1mbjIx?=
 =?utf-8?B?N05pL2x0TU5LR3N4cThNMzIwa1g5WUtibHpacUNFdU90bzhnVEJlcW9DOWpM?=
 =?utf-8?B?Smo0TGZIaXBqZWgrOENuNWxLemtZS3hnelBoUFU1NnFteVdZdkJ5ZXl6V3Jx?=
 =?utf-8?B?T3NHWTFTcDBTT3BBY0pOV3IxdXBrN0QwSVNhTjZmcW91YnZWK2lZY0RQTVEr?=
 =?utf-8?B?Y3d2MERWVW42eVd1S3pwOXU3V3N1bGtxYkIwZXJXdEZ3dis1SHhhNC9CRk0w?=
 =?utf-8?B?UjVTc0NBR3hEcnZWbzZuU1VoK09heEVJWHk4SUQ5WFlCQVRXM2taTjRzTWtR?=
 =?utf-8?B?Szdub3g5UlZEZEVqQU9vK0wvd1FUdFpwK3ZNYmZTT2RSWkNLckpZZEFVejZQ?=
 =?utf-8?B?dWVoWWxXQnp6WU94c3VwYmFoUXNWa1RWVDRLNWNYSVNwNlVsRi9VNXhaSHNr?=
 =?utf-8?B?MHI0T1RZODBmSWdRaVMydVR5RytuYkExeDdveVVvZDVTekFKdGhNMnpialdW?=
 =?utf-8?B?Ykw2UE1Jak1NczFkK2V2K0pyVnhNMDJSUk1nbm9NcGp3SUtoUlpsamw0OEti?=
 =?utf-8?B?WE5QaXB2RHEyWHFlcjZuMklJUWE1YTExQlNFdG1DUXV4U2hDSWkwQmdJWUts?=
 =?utf-8?B?ZkR3TmNFdHJ6WDN5YnM2RFpFa2dnalRiMTRncWJTbFVVTnM3TkpsOGxLNVFR?=
 =?utf-8?B?T3RuVDhWbzZINzI1WFQrNG1EUWNnQmRickc0NjZ2b0ZtK25YSHl3Q3Zha0JU?=
 =?utf-8?B?UmNtRWduL2xrUW1YTWlwdVNUOFB4a0krWWJpKzVUN3VuL21iZlZWQk5LTmcx?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i8s/M91Bo4odj6vUrtRbPQkPMua6jFKtVNhkufm+wRlMB5hx5YNJC86mtErdaYSSyHiVn9HNt2QlW/j6JdDA9YRBXH6ogMtlIiizdSkclAy8oyU8L7TXmgPji7GTTXEIluyWSBiFodnghGSDIKI7wo8wQt1LwuNROYaacJByrtecDwQPeJglm8+LI5BikpeH8XteNGe9ArHss1j/cz7sw/YGBjk/UklscOm/U/99jhcgVU+6opaDroWgiJ7+LtWTyJsYKu5wGvpVc9jtR8BxRekLoGmUXJPpOausfUyO0Xq7Ms73O63laID/3Pry4CCr5U7Rl0mzKqEha+vXBlbzx9XOGtZJyOoVdQzQCyV6mLM67LJxUdh9vAvUhtxXy9FmNHtHfvPYV9UGKZdn/7rzSjmLOFmPkgqDGrojzCcyuSJwaLUyLmT90+Aai267BiMUs8QHAAe+1/7bOFUS4yNkSZ6KE8K8vRiDkXK2S5SjvAysm0b46G+1riKCN7dqFjR4UGMQLITwRCi1WgEs+8hlc8xSWiAuovOuYooAIQTVwXkr/8aV1jrjLhGfcLrpky1C2Qb+E6fYRDdRzfUXIhxXllAYQSut8eRP9YBmjs1I110=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d835aa-a119-46ba-baf9-08de3d979d05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:10:51.9392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZoUvW+LRha0ScJDvgYTzsIkAJ2Tc55otvlD2c8pzdA92DeqRs0F05/hGXWY0+ISVDWb6skQibYfzsHL3hgp6tt3Irm7rpwKL3IDar7mU9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170144
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=6942f234 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tuqz3DAfR-s7zrzl-2cA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE0NSBTYWx0ZWRfX7NpXFNZeYplk
 fin118dvj06DEYgdHjQ8yX62aFAYfZm444zk30AYYSFqV0gY4+G2MA9zIiQfD26pB5UEV7PBRhS
 CzjBOUR01ab0BIbyCcHqQfB7X/uf+8xStn/lzLKkCCiNRR6YQVM4jTWhyQ5DTDAFMDWMURNgxsg
 vjMO2SxvLwLB1b2cD9ZVn8Ev+77Oo7hQXwbP7h9YyjfN5MYc0u9ooRUf7kt/3M2vASv1d9mciyK
 x9nTph7i7QS7J2PD8SiOTF6NcMzzVjo0aFR5uXXuO8cun9hGqbr5+63y6b22bcudQQrs00Ixv0K
 er+IA8FuWJzzZ+i5NhSykV/LS+tdEWyFm6Jewg3ixqijOqFOD31AByrDGbspCZ4cC3xL7ZO1zhe
 oliKkaXUy+r11B54W3XdzPuxRvLvILBwO9aCv9oHimvk0UP2YYE=
X-Proofpoint-ORIG-GUID: dPljvbcQmwuosItgelBLtiQinYEc6bVM
X-Proofpoint-GUID: dPljvbcQmwuosItgelBLtiQinYEc6bVM

On 12/15/25 4:21 PM, Eric Biggers wrote:
> On Mon, Dec 15, 2025 at 03:33:05PM -0800, Ross Philipson wrote:
>> diff --git a/arch/x86/boot/compressed/sha1.c b/arch/x86/boot/compressed/sha1.c
>> new file mode 100644
>> index 000000000000..dd1b4cf5caf5
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/sha1.c
>> @@ -0,0 +1,7 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2025 Apertus Solutions, LLC.
>> + */
>> +
>> +#undef CONFIG_CRYPTO_LIB_SHA1_ARCH
>> +#include "../../../../lib/crypto/sha1.c"
> 
> CONFIG_* options shouldn't be undefined like this.  It seems that you're
> trying to build the SHA-1 code into a pre-boot environment.  This
> problem was already solved in the SHA-256 code, by making
> lib/crypto/sha256.c aware of __DISABLE_EXPORTS.  The SHA-1 code should
> use the same solution.
> 
> - Eric

That makes perfects sense, we will address that.

Thank you,
Ross

