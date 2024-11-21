Return-Path: <linux-efi+bounces-2182-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC50C9D53D5
	for <lists+linux-efi@lfdr.de>; Thu, 21 Nov 2024 21:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1F428269D
	for <lists+linux-efi@lfdr.de>; Thu, 21 Nov 2024 20:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE131CD1EE;
	Thu, 21 Nov 2024 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BS58Bhgr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="drQRZkdd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278F1C9B9A;
	Thu, 21 Nov 2024 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220254; cv=fail; b=lGxCNd0vz+8YZJ4wzAFsmeRXzDUfZvcEGNklLgQWf36kh9M80HJmmz7/XBVJglKaLHc2EXLrQyJ++ryh89I1FaFtCT+kr+PaIEdfJDGP5wod/Ki20OMNXzjOFZZUH0sH4DpYYSRdYCYVo2u7nfqvMs+d3gHmA1WhyJrqoPflXXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220254; c=relaxed/simple;
	bh=W6WXQAM1NrHfA/yv9RcGphasuMjBIWXrl/xlLevSdEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ees0bqh4D9P6mjPzIUV/QIBwVkN+IF5D951ALYsmL3qXPYJvj0x+V8GmZ4wmk7y81nZRnq39x4r2zbSm2Jkyc8wvAp0dnwSGIgcbKVFh51ZgRz7ffkd/FPgZyBqmcbdE/wsUtNDwGjRs6Thx35OxRBOvMTqT/6oWGBOKA6wLjXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BS58Bhgr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=drQRZkdd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALIBXLd004545;
	Thu, 21 Nov 2024 20:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yiENuGXV/+8fQ7zzkTpftLzJZB8rvD1+d7v4tVrnows=; b=
	BS58Bhgrg08oUavqpXMzle+LeZs3K7T7X+8Ja4StKahCPM0JOLGNr8ic2ktj/Be2
	IPuDwBRJzvzg58+2O9D7YYiLWjTxyanK0zSx5s/SVxrnYaTnta4HtWsFiB4boyGC
	3EB3vkHASlAP4i6fk73DwBp0GthRDac59OMvpWH/yvFpmYmp1CEFca+5dQVHmUCA
	7KzzPzkQHEsbtrlZ3AgfZaOIyUnS3oW0giJHVq4w4Rt8ImYiGjh+Hw4HGK33486K
	UYzjtTN2WLbZsKD9hJX8YpU1q8U189XEiX0D24nK2ZBh06WdHOnH5fI82Ak1Igq4
	mhql4NQ0JE1ByDn5tDRJrg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtcam04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 20:11:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALKB6tD007758;
	Thu, 21 Nov 2024 20:11:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuc8297-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 20:11:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0kLZ91brTVP5bYjwyglCE6AVyj14hcj0L1G+hDKfdPN80yHs3QKs0fcjBid5jSPh01gpxqBpvKMI9Sw/C6vKpeXq8QjO2dzx3FZ6SulBSD7Jq/Qe6qOE+tUShLMU3lXUo3knZmAvTFrCeXmdm2LEysQVi2Suy29w5uP21zUHBCqiqEt/K0m2M1og1pNi1JP3Uwg+Y1PSwWivfNiybvnWHOhxWODxQLEtzS0eSx+gNauE+0OqdVaQCtr/dal2x/JQW/vttA5N0knJCPdE6zRMBehGVrEstc/YoMrl6jTbFf607riJT9exrsxlxBN3jezWebt5L52ZZPRAePFGvxukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiENuGXV/+8fQ7zzkTpftLzJZB8rvD1+d7v4tVrnows=;
 b=nGSdUvqfxKt2YALXztMQCOhx9xwoYCdRweE61k4Bpow21l61GNfCO+GBNGb75vmRuSMekWMTxsrFbzKw6vxOdDFITa3PLCpxikmFwMc8R7ep2MRnpZykpuW7R6c90nsFIv3sd3TcKYp4kd6YqhlTrycRPGSXVZsOn0F0wacNyCgK0Jf1SqAU5WAVOfxqTrtqXzyijElJWWG4N4zbJCmemKw7khRKzk5FkQ/Ax3J5nrW/NnYrphQ1JkQ1TG0J+Qc4sQk1BYkMdiMCYBq45rZfht/XkQxmXQdCmuTzoUSK8qFf66ANiEf1unmc4IuI5N06d++mG3twD46qOHsA0McN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiENuGXV/+8fQ7zzkTpftLzJZB8rvD1+d7v4tVrnows=;
 b=drQRZkdddAsqs2sgUWzu8kVsr7KtDwVCn7LoPJ2OhpoJFGON65mY8abHPByTLx4GgGimfueQXrCf6afHWyFBXTbUYudLXHgKO7rMsnCLbfvyj6Cwx/QSYpiPfptaIbkHPinXj2oEoBWWNLkOY8wcua3HQJLXxcarLfuOctxvaZ4=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DS7PR10MB5149.namprd10.prod.outlook.com (2603:10b6:5:3a7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.27; Thu, 21 Nov 2024 20:11:26 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 20:11:26 +0000
Message-ID: <66fabe21-7d0d-4978-806e-9a4af3e9257a@oracle.com>
Date: Thu, 21 Nov 2024 12:11:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Andy Lutomirski <luto@amacapital.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
        mjg59@srcf.ucam.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
        andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
 <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
 <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
 <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
 <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
 <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
 <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com>
 <5d1e41d6-b467-4013-a0d0-45f9511c15c6@apertussolutions.com>
 <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
 <9c80e779b6268fde33c93ed3765ff93b1d6d007b.camel@HansenPartnership.com>
 <CALCETrX4vHnVorqWjPEOP0XLaA0uUWkKikDcCXWtbs2a7EBuiA@mail.gmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CALCETrX4vHnVorqWjPEOP0XLaA0uUWkKikDcCXWtbs2a7EBuiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0001.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::16) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DS7PR10MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: 60845d49-a70e-404f-f5d9-08dd0a68ad99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGpwb0MrMnhGZU9uS3pVYlJlYW8rRDJSVk9XeTFZb2JqRjh1VGdWaHF1YTZM?=
 =?utf-8?B?emVEZ0t1Z2VDY3dWelA4cGt2SmkveEN2L3JUQlZkOW42OG5hZitYZjJBYnZz?=
 =?utf-8?B?bjhBd0I3cWZkbVB2ZDVEcXlUdXhFdVl2L09vaXZ1aDZBbklSWGJBcjAyTmhu?=
 =?utf-8?B?N09DOXBPMFR6UG1pcExJSHpOWlQvUFgzVjU4SjJpaTRmRndDMkFFbU9CM2w0?=
 =?utf-8?B?K2pZSHdWKzg5bUFQOThndzJvRWtvQmJLTHBISjZpbzQ3TVRnelgxYzkrVVVZ?=
 =?utf-8?B?QTduVVkxcHJqaVJ6cDhFcHVqZVp5aFRva1AxREFtYTlSczdIRUg3cEdkb1JI?=
 =?utf-8?B?dkFLSkZmdGh2VU15R3pXMHVDaTViOHNPS2dNZ2xKMlF2bm0xSHlzbUk1aER1?=
 =?utf-8?B?ZWhPenA1VUhHMkFwdmx4UGVPZFhEYmx4anJyWlBYMFI1Ynhva0JiVkRjMDZz?=
 =?utf-8?B?SEttMGRib2ZwcDdqaitsMU1kUjN3Nmw4cWJTMEJkd08xM29SWEkwOXNJWldS?=
 =?utf-8?B?UkVpakZ2RXR3dUFIU1ZkaGZOUURZNHNSZlZOU0ZOZG9ySENoMUFGWklMQk0v?=
 =?utf-8?B?eEJGNnhFTndQeVo0ZHFrQUVialNMRmV1V1FMNHpMSURvVXlBNDBlczFzRjZr?=
 =?utf-8?B?ekYvSTJ3dEdCazBYN1lHTGllbCt1UjJuaWNWOTVaZ25HQnZ5SVlEaWtVdkQr?=
 =?utf-8?B?a0cwcDBoOEloOUV1bTBuSm90bVFZUGRnU0xjcW8vK3hyam8yOWtsNk1SMnBv?=
 =?utf-8?B?T28yczk1T1ZtK2Q2cG54WXBCSlhGM1ovYjJjdVF5aGJUam16ZzFxZHRubkZX?=
 =?utf-8?B?OGwwSkJWZGcyN1VjKzZGTFRrczlsMmtGclR3M2haVXhSTFEzbklCMXlkNzMy?=
 =?utf-8?B?RCtaRkUwZUR0ZU9uQm1pRTBtMjRuUEZXTnZ0MFZIWWJBdmV1RjZGa201eGxS?=
 =?utf-8?B?TVlGa1ZBOXQyeVhSNjNtQ3IrYmlUYXVnNThaeVhiMG85VS9BYXFYTHZDUjNx?=
 =?utf-8?B?NS95aFY5Z2lwQTR2ZU1VOEhKb09ZSWhlZ1NCcEUxbDBRNWhGYXBRTXdxbU1t?=
 =?utf-8?B?ZDgzRll1M0p0M2JpUGltNXh0YXVKRWIzRTFHcllEMDNseUs0WnZZU0xOQVlK?=
 =?utf-8?B?K05SVVowdk9HVWZGRGZlN1ZHU29wdzl5L2xlYVByWUZFbVR6emZVVEw4NDFO?=
 =?utf-8?B?eEs5UStwdEx3d3hlRE11MVorb2ttanNHR0ZhOGJYOXZvak5VL25EOGpObk5X?=
 =?utf-8?B?RGlDSVZDcjRwUnVwcEJiZTFxVlZYdnZuNy9PQno5K3JIREVXTC9LK040REp5?=
 =?utf-8?B?TDB3R2taWmN1ZzloUzd2bWgrK28vOEM4bFNBNmtncjNrSVZIOGxpc2pKWlpn?=
 =?utf-8?B?dXpTWUJLQ0YxVWRjanM5VUU4WUlKc0pubS9Sblc2SWRLOVFDZ3dhS2NkTGw3?=
 =?utf-8?B?dDMxM1pCZ2o3bjRaTEM1YmFLMGNIeGlZOGlPVHlWcm5Ca0ZDVUprWGJLUXRy?=
 =?utf-8?B?dVZ6b1RXdnZncjA5a3ByWGNTci9PYTNSOWlPNFlxWU9uSG9yVEtIUDlycGFU?=
 =?utf-8?B?NjJ6SHNQQThuRSthKzl2SVdROFJGN0lvbjBpSTh2RFpOa2UwWWZuaisvNDlJ?=
 =?utf-8?B?YWhxNllOallBZjBna2VlR0d4TmpXbmlqSFFHQVdDb1dJcVVQOHRhS245aHR6?=
 =?utf-8?B?L20vbzF5M1NSeU1vUndMZk9GRmZWQ3V5MzNsS0Z4cXF3aHZhMEx4VCtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm1YMmNxMFZaSS9yTEtDUG9mN1BudHI1STFKdmJFS0JMMmZXNEd6TUVvajBF?=
 =?utf-8?B?aDkvc0x6U2xZZllWM0srRFoybHA0ZHJvOVZiUk9CSFlKZlVLalloYTZRcjI2?=
 =?utf-8?B?WEkzT3pXWFhEWElRVnRwNnhxaWpKaFgwSGFISm1wZGtGQjdGZHVqMnJFQ1FV?=
 =?utf-8?B?VEUwR0ZKMkFZd3RpU1BlaWQ1NGFKWWVyT2pPYkJDd0I4Qk1HSEo4MXBpOVFF?=
 =?utf-8?B?QkhabHUybHNFWmZ6WkFaamZmU3d2cnVmS25rTTBzNmZ3RU9YcFNhaWRtZlIr?=
 =?utf-8?B?Vjdzdm1rT3llb2lTQlk4VStmMEVqRllLZ09aWXk1UnpDWlF6UVZuRStVRklM?=
 =?utf-8?B?bTFGTnVhVkZVQ0N1MU8rcjZjL2k4SWtZZFBNRlh0VkNtaGIycVFOWTlyQW10?=
 =?utf-8?B?a3RYRlhhSFpvVEJQcTV6SzhZZG9QUmVxMFJVZUY1YldUbllNYk9udDhIcUh0?=
 =?utf-8?B?V1pWWDdjRmtraXpHSDhJUHliSFc4djYycU83UDV2c1kvWnRPM2NLbUZFd1Q1?=
 =?utf-8?B?RUNMSW9BQVdFZ2o2ekJUN1RSZ29YRjZ0NjFGbFpDREp6aUlxd0EwUHQvRkxU?=
 =?utf-8?B?TW91cTZDOS80cW1MMW0yVVhlWVEwU3dGdHFyZHZ3S2JXM3k2WFRYS1ZabVpk?=
 =?utf-8?B?RS9lOXFHZmZxcXc5cEZsbHMzeWhnVnNqQmFZZ0dHTU1EeFFxcmZseDNwWVFl?=
 =?utf-8?B?clIwYVhISGx0MGNqT25SQUhBR3QyYkpOMmJ6NHl6Z0FoWkhjbkpCSHRUdEdQ?=
 =?utf-8?B?Q0hpeWlldkVKRWFjNU1LeUhlVGIzRUwza0tIYUMyVFlucUZmUlUzUFJKTFdn?=
 =?utf-8?B?VFJKQ1p6QzNZbzJLamZGYWNIQlF6elRBOXZ1amZ4RGlLN2ErRXgxNnRqTU95?=
 =?utf-8?B?TGo3dHYzU21KZFJpSjFUZ1lJYXdPT0NTQU0yQ013SmR1NkliV2tiMElwZTF1?=
 =?utf-8?B?RW05RWVSdk83VzF2T3BCTGIxWi9TaWhmdEgxNUhNQ3hWUnprSFNPazNuUUR1?=
 =?utf-8?B?NnFVZlg3dEQzYzg1ZDJkK1ZZTTM1STZ0MEQrRHNWenRocWd0U1ZVNGdrQmtw?=
 =?utf-8?B?U1g2Q2t4V2hNTmZ0RHZsSVJYT3ZoOU9zMSt3Rm5meE9IY2pmRW5qeEZta1hz?=
 =?utf-8?B?Slp1cjU2WFRRTUlpaW9hSlBOdWtlYkg5emh6SXJYSlpuaXcwbmtKV2xJT3Ni?=
 =?utf-8?B?c1BGRnpwQ1d3dlVvVUUrdk9rcHpqMStlVmE3ZGs5OHZiRWlkSnpUQ2tQSHZK?=
 =?utf-8?B?a0NOQ3RGWmtVMEpybHlkYTZobDY1cENpRFRKdkVSanF5dVJHTDJxUjBydnha?=
 =?utf-8?B?SklyL3owZzdHa1FjUStEZWVLME5aTU1Uem5JRGdSNXdNN3U1YXZkejJvN3Mx?=
 =?utf-8?B?ZVNhcEN5T3hOUkphcXdzdDVqUTQ2U0ZQQ0FkaHdOWkRBcjVpazdHWWZ2NGda?=
 =?utf-8?B?R1BhejBkNlRsSDErb3oyaGUydmxpcTAxMHlBa1diVG5QWlBBL0lVblYzaWo5?=
 =?utf-8?B?MFV3aXdSbjEzMVZGU1ExMW5uMnhOajRCVzlvY3NkQzBVWUxkTjVPZ2lKdkFP?=
 =?utf-8?B?SW52am5hWkxDNnV2cHNBVGhPV2o0VWFSTWI3VjFMQ3NCUWdsSEtjcE1RVHRY?=
 =?utf-8?B?c0trM3J2ZW9hOER1bmd2T3pVSTYvMWxPWXVRM1M1YXBib1dManV4MGZmbXNv?=
 =?utf-8?B?dEJIV2NWbVY5M0p1N3BiNUJuU1pxWWRmYVZJN05Zek55YzJRNFlETUJOaGNJ?=
 =?utf-8?B?cVliYkNKT2RtT2p2Wm5JeFgxQm9meXo5bkVHbnZFSjdYSndzQ25kZ09TOEs4?=
 =?utf-8?B?bXcrSzg5UUxCeU9QRm81QXJ4U2ZJMHpoS2dhUmhwT1lIRkt4WktFZmsvKzIr?=
 =?utf-8?B?TVFWclpxbzhrL0E3MUJVM3gwOVlEUVM3bnlkQ2RlWXVZZWVUR2xvQklzVEpy?=
 =?utf-8?B?SzVlZTJ2dWFnb21iNlAvOXVRMGF1U21NcHpEN01sQ1pKVXpUYXdVYzVPUFdZ?=
 =?utf-8?B?QkU1OE1EOHhJVi9sYUo2dGxJMEhvalIzYVk1SXBwTlhHWmxxcEF5ak5zUnR2?=
 =?utf-8?B?Q2xMelYvN1lzY1dTeXpsSXRMUDhDdkxDYWJBVFQ2Q3hZZ1RJOWZQdDhRTEhz?=
 =?utf-8?B?TVBDMEFzOHVSaWl0NWNJNExKRlVlU2pPYmNHVjd3aXg4eUw3M0poVEVTelR6?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YscwkF925iKtTSlfT523pAtUA0YsyLPY/QynireUbm583ii23z3WpAhY19SefVHrkumiS1Jp17A91vlIN69HIBiBO2BPQAkOULWDLqMYaCJkc0I9hFF0p0gGdYYKzhFpuCrslR3nAXdGwP3CNZG/+EjCf01OB9z6IWL3te6OvSrI+KWbKBx93+J/KJCVtdBwOmMvNIl7LgHPeARIqaFF4X4CuweCYwMrCj60nDgeOlA/vUGS0/ktmy6/OELMnsl3FZxGWusowaWXJdoc4nfV37buJfzGbeNesa0mgXkK+bg3GQL00YbD8EOE5qzRm0umk8is6X1pZmJt0nbi4OoKVJnzeb8/qtKdDSRVvth3zYsxsiHCY+Yi/fuO1B+O+Gil2T+ghxMuTswzai9rrTfbJ2nD9D0BZkyTcETWBmPrgb0Mhcs/F03dbrKcmrc2wISrQP+0kZ5mCBpkhfQ/KbQ9HPWwgEn0gqnJ1roN7DevstBxzR14/m42fb7I6j5mazM2MvlWM8C/UI14sMGgqGEPQ/EDHKTfUYNY7wp1o4Rw0NxK+FxP8bqZYk1wwhwqWrBox9lxoFVqC/44pmjZ0KsA0f6NR+RkxTFTnGdNKRQ3VmI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60845d49-a70e-404f-f5d9-08dd0a68ad99
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 20:11:26.4326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOSDZbE8OeQC8Q/9Vrf8LyHRKW/v07yntwpYQHVHX3O8YBIurBX2MSp4zJ7t3h/IiB82SWycA5Y+3ossKCjdqE8rX3RjMpZhhUt69STp+y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_13,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411210152
X-Proofpoint-GUID: NIi8hfmtR7YxicKusc1bz-3AmNt4J89a
X-Proofpoint-ORIG-GUID: NIi8hfmtR7YxicKusc1bz-3AmNt4J89a

On 11/18/24 12:02 PM, Andy Lutomirski wrote:
> On Mon, Nov 18, 2024 at 11:12 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
>>
>> On Mon, 2024-11-18 at 10:43 -0800, Andy Lutomirski wrote:
>>> Linux should not use TPM2_PCR_Extend *at all*.  Instead, Linux should
>>> exclusively use TPM2_PCR_Event.  I would expect that passing, say,
>>> the entire kernel image to TPM2_PCR_Event would be a big mistake, so
>>> instead Linux should hash the relevant data with a reasonable
>>> suggestion of hashes (which includes, mandatorily, SHA-384 and *does
>>> not* include SHA-1, and may or may not be configurable at build time
>>> to include things like SM3), concatenate them, and pass that to
>>> TPM2_PCR_Event.  And Linux should make the value that it passed to
>>> TPM2_PCR_Event readily accessible to software using it, and should
>>> also include some straightforward tooling to calculate it from a
>>> given input so that software that wants to figure out what value to
>>> expect in a PCR can easily do so.
>>
>> Just for clarity, this is about how the agile log format works.  Each
>> event entry in the log contains a list of bank hashes and the extends
>> occur in log event order, so replaying a log should get you to exactly
>> the head PCR value of each bank.  If a log doesn't understand a format,
>> like SM3, then an entry for it doesn't appear in the log and a replay
>> says nothing about the PCR value.
> 
> I have no idea what the "agile log format" is or what all the formats
> in existence are.  I found section 4.2.4 here:
> 
> https://urldefense.com/v3/__https://trustedcomputinggroup.org/wp-content/uploads/TCG_IWG_CEL_v1_r0p41_pub.pdf__;!!ACWV5N9M2RV99hQ!Iw9aAHcJMT6j3t_DSb7cOk8iWy8VJYkJOlGQ_gtLUz0XwPcIZclY4I8GZJ5VP4OScLjBaz3RX1QlGGBWWZw$
> 
> It says:
> 
> This field contains the list of the digest values Extended. The Extend
> method varies with TPM command, so there is
> no uniform meaning of TPM Extend in this instance, and separate
> descriptions are unavoidable. If using the
> TPM2_PCR_Extend command, this field is the data sent to the TPM (i.e.,
> not the resulting value of the PCR after the
> TPM2_PCR_Extend command completes). If using the TPM2_PCR_Event
> command, this field contains the digest
> structure returned by the TPM2_PCR_Event command (that contains the
> digest(s) submitted to each PCR bank as
> the internal Extend operation). This field SHALL contain the
> information from the TPML_DIGEST_VALUES used in
> the Extend operation.
> 
> So we're logging the values with which we extend the PCRs.  Once upon
> a time, someone decided it was okay to skip extending a PCR bank:
> 
> https://urldefense.com/v3/__https://google.github.io/security-research/pocs/bios/tpm-carte-blanche/writeup.html__;!!ACWV5N9M2RV99hQ!Iw9aAHcJMT6j3t_DSb7cOk8iWy8VJYkJOlGQ_gtLUz0XwPcIZclY4I8GZJ5VP4OScLjBaz3RX1QlKxD4S1w$
> 
> and it was not a great idea.
> 
> There seem to be six (!) currently defined hashes: SHA1, SHA256,
> SHA384, SHA512, SM2 and SM3.  I haven't spotted anything promising not
> to add more.  It seems to be that Linux really really ought to:
> 
> (a) extend all banks.  Not all banks that the maintainers like, and
> not all banks that the maintainers knew about when having this
> discussion.  *All* banks.  That means TPM2_PCR_Event().  (Or we refuse
> to boot if there's a bank we don't like.)
> 
> (b) Make a best effort to notice if something is wrong with the TPM
> and/or someone is MITMing us and messing with us.  That means
> computing the hash algorithms we actually support and checking whether
> TPM2_PCR_Event() returns the right thing.  I'm not seeing a specific
> attack that seems likely that this prevents, but it does seem like
> decent defense in depth, and if someone chooses to provision a machine
> by reading its event log and then subsequently getting an attestation
> that a future event log matches what was read, then avoiding letting
> an attacker who temporarily controls the TPM connection from
> corrupting the results seems wise.  And I don't see anything at all
> that we gain by removing a check that (TPM's reported SHA1 == what we
> calculated) in the name of "not supporting SHA1") other than a few
> hundred bytes of object code.  (And yes, SHA1 is much more likely to
> be supported than SM3, so it's not absurd to implement SHA1 and not
> implement SM3.)
> 
>>
>> For some events, the hash is actually the hash of the event entry
>> itself and for others, the entry is just a hint and the hash is of
>> something else.
>>
>> I think part of the confusion stems from the twofold issues of PCRs: at
>> their simplest they were expected to provide the end policy values
>> (this turns out to be problematic because there are quite a few ways,
>> that will produce different end PCR values, that a system could get to
>> the same state).  If you don't trust a bank (or don't know about it),
>> you don't code it into a required policy statement and its value
>> becomes irrelevant.
> 
> I think that "you" refers to multiple entities, and this is a problem.
> 
> If the vendor of an attestation-dependent thing trusts SM3 but *Linux*
> does not like SM3, then the vendor's software should not become wildly
> insecure because Linux does not like SM3.  And, as that 2004 CVE
> shows, even two groups that are nominally associated with Microsoft
> can disagree on which banks they like, causing a vulnerability.

Thanks everyone for all the feedback and discussions on this. I 
understand it is important and perhaps the Linux TPM code should be 
modified to do the extend operations differently but this seems like it 
is outside the scope of our Secure Launch feature patch set.

As far as our patch series goes, we have done the things that were asked 
of us like documenting SHA-1 usage, fixing comments and commit message 
and breaking up the original patch into two (one for SHA-1 and one for 
SHA-256). It seems we should be able to submit our next version at this 
point.

Thanks
Ross

