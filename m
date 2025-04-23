Return-Path: <linux-efi+bounces-3442-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA3A99930
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 22:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67563BB031
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6026A1A3;
	Wed, 23 Apr 2025 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wqd5ZrZu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kBM9KORZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF462690D4;
	Wed, 23 Apr 2025 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438871; cv=fail; b=IcDHAxTGPZ0LIG2teiESV1VV8CXeUtXEMaT4tGqlmkWzlbCxIN2MMeG/pAaLNz26I/EG5ei7CDzYMxi2lGDZyN4fNHM6IcgeJFLQ+GSICbfI2pIN3feOEbMb7J/CFeeH3xaVJUk46+Nz445ijHcvulY8Rgvipn4iZPoxlUWaQoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438871; c=relaxed/simple;
	bh=zG6YtVJtn4PHcq6jGVZ62NOPQ87gXQmkZH9nMsBBLh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bgv785V3eozMOsnXkpi+JKYbTXT92PVKHWW8eULnJVbxSSeIkC5nzAmMoTCOj0cKpl1bWBsOEfJSnqK8KoSRXV1A4gQYAaI0oBpQX1WZn6gRt7mbPlypnkH2kmt7WXDDcR5DF/ct45fmVvDL6x3tfOr3dzZ3T9847bTKAPHU2O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wqd5ZrZu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kBM9KORZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJtnEc027918;
	Wed, 23 Apr 2025 20:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=F6VBoTASLjHEHJ/pyaHl1KfB48u4Ims3ixJtIsdjtRw=; b=
	Wqd5ZrZuDAQ95qGkdiziMIJeCNstjj/6geSf29GsGwahws1o/VeAxbb6y3lQktyG
	9WEbQuredL3BtZpf+ym03CRSwIRAjoXhwY7IbQldwDXVa18ATWHR2GEWwocNURoL
	MRPll806Futg8KPzzDIpHMLtNWIPU1prny0BmQmRGMw/HRtBQc1vyo1lQX69XToN
	4I368HR3sHnReuTay+NFDth6M65F8NJ+KZK8G7ngVdj2LRihoGTtXxqcYty18XaT
	+5dscOUOnsFciyOelD3OEaO/TgtarH6cvCJya0F2NHpqJpExIjdll3ZyKdkustCA
	Mk4NuAwXIC83vVvnKDw6Zg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha29rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 20:07:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJS7b6031089;
	Wed, 23 Apr 2025 20:07:11 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k06bx0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 20:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc6+bFyqQx6LD334jgcq5kQrqXg4N/uJI00oMKKJZMnz8hkMzRYac4VgBIL/26/KgbQSd+3q6iTijsOGjUAxqbnFvcdLqfMJsYfLYo6BcKK4gvHJBZHaPeOzbwfblKjhKvoPzQ0Gc3fdvmEPQ32w56K4nWOJb/4K5X8BjwatmNurt0fniWFJboggd0DlnGF0Fi2q28y8itA3lbqt4jzxET9IiQjso9x3rLG5auyKqhIZjn/JMO42gY63GigH/irrf6LjbDelaWeVqrrgsy65xGw74QHfPPJAGBsGWPMHnnsfxPjULmmCQ0vnCHFSrnMS7khNj4882WdWW+niN7sNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6VBoTASLjHEHJ/pyaHl1KfB48u4Ims3ixJtIsdjtRw=;
 b=KRxOyK/NRJflbUnUb9JOUMgNOgkJJTKJhi1z9moLP8f57K7JsrD0aI8vcifFOOv1yF8CfXdNtTJTOJPYCczTEbsQInEp4/xGSvbedydK06MEr7ALYUb58Dt8wTBkET1yKl4QH9U3b1syNyxRmoQnCjy4y9cCZztfjGHsqzMFheuTNgSgm20SkEr8aqf6ABTgh19UsVwaI+W50PSUM2Dscp0g2qNQis8uCXrxNdXnNjE6owxDLMHw/Jy7EDPzMb2vQXaaR6agH2UNy0onk3KXUBPAUdRb7AjsZis3dIhYJ4qr3zoVZ1IMuk33/peYpV7NvZxeRwGxDnOD/Rz0yQIYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6VBoTASLjHEHJ/pyaHl1KfB48u4Ims3ixJtIsdjtRw=;
 b=kBM9KORZr5manB5/FvUDWmCOWtrnURATP86WZ/79m6W68dwai8PYLvlsFRb3hyOqSgrcnhPK//fN4cZdE/HsHV/qFvRXpk4Yq9ZVHF/Yu6uV97ZX3QqRoKpHT5dhqjmbdHA95Ns5cM6E0JlhfNo0PYuTWyn4dUoq0BCII5uXblI=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CYYPR10MB7628.namprd10.prod.outlook.com (2603:10b6:930:b9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.34; Wed, 23 Apr 2025 20:07:08 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 20:07:08 +0000
Message-ID: <0487e0c6-6269-4b23-8bea-3729a04129ba@oracle.com>
Date: Wed, 23 Apr 2025 13:07:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 12/19] kexec: Secure Launch kexec SEXIT support
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
 <20250421162712.77452-13-ross.philipson@oracle.com>
 <ad920d74-0a69-4070-a396-f17171b8678c@oracle.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <ad920d74-0a69-4070-a396-f17171b8678c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0067.namprd17.prod.outlook.com
 (2603:10b6:510:325::13) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CYYPR10MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b52224-17d3-4eeb-7fd2-08dd82a26ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1RVMkNWSWRGN01wS1A5MUZRWEJBdDEvdC9uRnNkOWNlbEJLUDdxZkZrckVM?=
 =?utf-8?B?RDVXOWtMTWVldzhBT0dxa2xrakQrc1c4a3kzb2lXd09OeU9aZjl0bkUxOExZ?=
 =?utf-8?B?RWVCK2F1Skd6emo5WHNnbjJzTWt3YVVvSWI4bWVhbGZZNHphc1grcjkrVXhj?=
 =?utf-8?B?WDJFZm5nYWpVMjJvN3VZUDYreEE2djZNTGl0K0M4RTN5SElSaFNZSVhidXVF?=
 =?utf-8?B?N3BlekYzb3V3WkJvZVFkdHpKRFZKU0J2R2JleitrQTNMUnYvRUZxYU1DZFRM?=
 =?utf-8?B?RTJOaVVyTUl3Mi9GWm5seEt4dW4xRndqcmxFZjN5UHBPZWdnYVdFMzQzTW8v?=
 =?utf-8?B?RXhOdlVpemxTTXU1Vnllc2ZCVXRwci9PbEYyS3ozUEhGYTFpVVFWT1BtZS9M?=
 =?utf-8?B?S041MEszWXRnZmZBZVM2WlBsK0ppcTY1RUdIUHBxNCtqTXFnOGRzUlZUT3Q1?=
 =?utf-8?B?WlI3Mi81ZDBBYkJ6UEFpSTZzdUkvZG9zSUZybXlrN1hFZHVvUnhERHRneERC?=
 =?utf-8?B?Wk9LN3ZnNkE1Wi9ZRUlVeEhWNENXOEZ2WlBFZHFKU3J3MGxhN1NFRWlHdzBk?=
 =?utf-8?B?b0o5dFNIcUIxQXkxM3BmNEhZK1JyWnZkWHNpcHVuN1V1ejJTMW5Fc0R0d3lp?=
 =?utf-8?B?TXhIV1FIdi9EaGExU2IvZGhRUGlhUmJaelQ3Q2V1VmlvSFpaSG5ReUN6M3cy?=
 =?utf-8?B?L3JDWXdZcmpDNk9GcGtKeDRsRnNLc2pTTnA3bVlBRkgxK1JLSE85YlhrVklt?=
 =?utf-8?B?K3gzbGRtdHJLOXFHRGdKVDhwMWNVQnU3TkdxVC9HUVRQcEVvZmJqY2VQS3pU?=
 =?utf-8?B?Q2pKWC9WUmFmMUpDOU02czNDSmlGUUZPQU8rSmpLN2pqYUpGNVJtc1dQWmRK?=
 =?utf-8?B?WkltQTlVRTUzdXJFUFA0aFJ3QVp4aHR6djFuek9xS1FWMjIzcXJoZlJMS1Np?=
 =?utf-8?B?QXFDZEJwdWlRYUEwL3JGYmZEcEJKcFl6VkdvdWJ3MXNlWlhTZEtzM2N1VDhJ?=
 =?utf-8?B?cnpSM1JxbmlhU1pHM1htOExEM3FHeTcrbDhGSHhtS3JNSFJxL0ZTa0RQZDVu?=
 =?utf-8?B?MTZHa0xvODgzSEtlMFF5ajZsZysyTERhand2ZURTbGdycFU5dzlISjB6OHI1?=
 =?utf-8?B?OCt5eHpRRjRRdWN6emp3c1ljaFk1Ym9EZmcwa3VlN0ZiN2tJbVpiUXp1cnZB?=
 =?utf-8?B?NFJCWDNWTk00QmVDOFVlOHd3RkowaEpuRFI1cWVXQWFZWkcwaXpuYlJ1bk9p?=
 =?utf-8?B?MW5FUmxtZTgyZVNWZnZHQWZsVVBzYkdtTFdrU2lVdnBBQWR5OGdBNjFTblhk?=
 =?utf-8?B?RWc4ZkJnMUhWRjR4bFRla1l1OWNCQnlFdnVON3JVR0l0Zmw1bkdNcEVMWnM4?=
 =?utf-8?B?dTlYM0FZbEJpT09mMHY2OU5PRXFQNnhSODJnb2paOWZvSHBvNVpBZE8xQm5L?=
 =?utf-8?B?bEZTVlZOM2JCT1dwZVVIVFNIY2Zhd2NZWmE0bVRjb0Rud0MxU2FkMWRxaTls?=
 =?utf-8?B?ODMxa0NXdlJMYWJBNTc5YU1tbmdKS2NQaE1LdVV5K2pXRm44dTFsSy9CYkNV?=
 =?utf-8?B?ZVIxMVdldTJPdk9vSjZzT1J3MW5wdnFHbUZkY1d0N0lwZHg1WXpIZWlPa1d0?=
 =?utf-8?B?S0h4Wm16RnZISWljMmJweGVORWxsVFk5NzRyR2tGSEJTdXpVQVEvTVZtbWwy?=
 =?utf-8?B?Und5QWRUSW9YUWdscFY4QjQ0THQrZkJaWlJ1d0lnZnBmUndqcXpYUnFSbGdj?=
 =?utf-8?B?WWtwWE5RVEQ0UjBSMGdEMWpCbjBpYThlTWdyc1dnYXhJZVFvaUpESUxXdjNJ?=
 =?utf-8?B?QjhwSnE0c0hKY3FQQzNFVXJJMjFYeTFYSHZFanUvVUEvTlR4Ny9zNHE0STJj?=
 =?utf-8?B?WFVPOEJ2ZFZvVDJDTXBWVUFESmJRbWNSbkNzVlV4QkhUcjM1d1ZNUzRZSDht?=
 =?utf-8?Q?hJhRej5IwiY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0IwSzFpeVBwWVk5VHhVSlB5alNqcnowOE82NUxJQnVWdGk5dVY4QmU0c05x?=
 =?utf-8?B?WEZMVW54eDJ4YWJJRmU2ZjRpVDZ2ZFBOdUN4d1kxYTFSNktQaDBMUUVyT3JR?=
 =?utf-8?B?bFR3dTBDd2liTkpVOUVaMWVCbXR5bW9pdmZQeHcraHY5VS9PbFhRTTd1a1c0?=
 =?utf-8?B?RVFoZWhFODNEYzB0Zm5Yb1hXS0IxblRYOGxOUGZsb2R1WDYvQWRDYk51elJw?=
 =?utf-8?B?aFBodDJIdTRVaTFnaGhhVk9ZeTZXYlVYUHZGU2VyT05ZNmpVeVpsSXE1SzlK?=
 =?utf-8?B?aFJremhoL25PbytkblRNOWFkaUZFZnh3clUrK28wOStDQmZId3VWZjBNSUVa?=
 =?utf-8?B?R2c5QVZ2cFY0L3N3OG9kRUpWYVZJdnljdGJlM0tUT0JsUGFRTGZiRkErb2JJ?=
 =?utf-8?B?d3ZQN3Jwb0J0STRhZVoweFVrKzlUSklJYlNSamJVOGNldEt5TVNvV1E0UGh6?=
 =?utf-8?B?ZVhpSUpkS1ZjMDBhNWlJMHFUa1NsVUpxKzdTS2NEaW5XL2pENkNOaS9GN2Qx?=
 =?utf-8?B?d3ovWEtVMi9jbGFTaXNEUDFwZXdJTVpuNU5NOFJETnBkRXV3ck1hTVNqUXFU?=
 =?utf-8?B?UXNxWTNhOThTbmNTWDJOUXlJaFlaVVUrZlVnM3ZPUmcrUTVsbnFNaGZSK1B4?=
 =?utf-8?B?WGdjU1dQVjAySjJLVWpsNXlxelU3d1g0NW93TmdnODh2TkdvaExLWktYem5J?=
 =?utf-8?B?dkN2S0czdklEbHlrY0R1NlB0WktiN1loQnVmYVpZemNzTnpYYlBlRGNSbmVw?=
 =?utf-8?B?ZlVZQzc4aW5MNmZxZDNqa1VDcTFpdTltYWR4Qk1lV2xPSjVDQ2EyanhsZUZ0?=
 =?utf-8?B?ZHdhcDNzNG1kUTlrYmtWck9ueEFiVlBNR3BhNGc2ZlA5YXJ4dmpVOXh3RG93?=
 =?utf-8?B?Q0ZVcHArRnNZbURoTE5oVi9rSGdNL3c3L05ucGpIMitHZnpYZzM1NFdacUxE?=
 =?utf-8?B?c2ZvR1RQMCtiMVIvUXkzVWc4NUxCL0VNNGF2WDRScy8zQnptcTRWdFpLWS9J?=
 =?utf-8?B?WnplS3ZKQ3NicExKQ0pKUTJnMmtZZkRmdCtLdEVpZS95WE5QbGI1MlpxN0Y4?=
 =?utf-8?B?YTZnRkZreWdzRmNnNGowU2tzbkJuelBkRDQxc1pUczNlWWNxYURPSkhjSElL?=
 =?utf-8?B?bXNWak5BK0JEWTJ1SFIwUWN6RzhMOTV2RGJjMUNDM3hWRno5ajVyNStqeklX?=
 =?utf-8?B?MDliNFVzREJaRmxiWWdLQWVvZkYwMmRUeEJpUEtWa2I0amVRSFBHVThteUJK?=
 =?utf-8?B?bjFyYjJZV0wxbEdFNGowTEQxcm9zb2d2eFIxbE5BaUF1TlhpQjA1dEdtZ0VR?=
 =?utf-8?B?MzZheHlraGZ4YXI1cTQvKzh6dk5QQkxZbmZhV2tGdHZxOHBOSnczU1J3L0tw?=
 =?utf-8?B?d3UzVWxKOGlrSXp0SjJvN3lUZ1NsVzIrY1JoNk9HYnJ0Y2VpWG4vM2c5Qlox?=
 =?utf-8?B?SlZQS1lUSll6c29VR0NHdm9qTHEwWU9MZmpvazQ0TjJMV1A2Ry9PUE1RaW9i?=
 =?utf-8?B?SlRZbXU2YTlPOWtKdTRRd0phVlB5emkvTW4yLzFwaDMxekhTNDJUVi9ia2ZR?=
 =?utf-8?B?SXJmb1N6aWhFdUZ4TTA2QXVteW1mR3dCODF1ZG1mK0V2MFFBaGhETGZ2azVP?=
 =?utf-8?B?Ty9teENTT01rNDhvaFlQNjAwdU9nRzhxRlJxNSttdWdZZEkySzNkSGZQM0Jl?=
 =?utf-8?B?ak93OXJMQ1gwenpQR2dObFhabVJQcjlzUWZpa3hYSjFZekVMeE9QZFVGdVVy?=
 =?utf-8?B?TnFBbVZxd2hkNnFYWHNxdndzOFI1TytJNWlxZC83VURKK0NzYzlFMXZtZ1hJ?=
 =?utf-8?B?ZlpxS3dmUzZDbS94VENXdENLR25oa1BLYXVKSzhEZDhOUkY1TEUrWEZ1VFN0?=
 =?utf-8?B?b0V2SG45bW4rS1VSNU9DRUdEdURTYi9Td09aYlJ4Mm5wQWt2cEMreDNtR241?=
 =?utf-8?B?RHRUR1F3WWFkbWo4K1BvV0Jhd3FUVk9Vck1LbWtNb1gxV25EaXBaT05yMTRa?=
 =?utf-8?B?ejlRRnprWEVpTEJRVE1UcnhFb0tOTC9Rd2svV3dGNDdpWi9SbVhRR21NOVBL?=
 =?utf-8?B?TEtZNjNiNU83ckNudUc4L0E3MVVJc1FIWWZ1aHpwWnErblRMTXp1MXNjbnly?=
 =?utf-8?B?a0Y2TnE1cGZYaTE5WEZYYkYvMVhiaGwrVE1vRHpER3NmdExpdXZqMmlqR1hS?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9EGD+hDNGzHP3Aj2H6b/CyXm5jPxju/apjnNivm4MxPoNIdCXSZBHGp4q7dnWyec4vTvm3HXwYbogkAvqEXNXdBxqrmHt2GFmsnqiYMAsCZrRoyQd7OqS0WtV1QpefNzTo9Lrt0MTMAxxrm7reFs7O8j+iGDuowHk4bcJ2iNeZIzeGoBZSkKXtj5V5P3T9tQgoScW2jRIQJ1OwcprWcIwnZTpPC9S08aqwcB0fkrlPZsKm45JDc/Br8+NbBNEYhuTFSyTCTx6aW+lO/KcsGPwySB/VdOj1I8vSqQjATSHE9eeAx0m56Yr9IMDTlN0X/tHfrrXGdgtxcMQt14HG0IdF7k6sB3lXWbxDRvYUQw1jm8rvOzK523XDRcRl4Qzwo324DnypwS2YRREhkznklwvOsjscll14sASFLlFiRaMgLO2T8vMH78qC0w84h4BSsHOQwD0Y/yECA0Owxm4DAc6WdD2GzmzdjGrJRIwMHg0yB0ahG/fXPY8mk8iJfUMyRN2L+tIyKH3ZwvYMdHa6ag1+vh1hrqqOe/NGDfPRXY4monUK97bZg/vGeIcDSgf30w5WJ98ZRMXynvJJPuz/nJ6ypLkiBGEg0Fz+/qUmgbNNk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b52224-17d3-4eeb-7fd2-08dd82a26ce3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 20:07:08.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BiOBpusCagU46Y0/yAv7E7mmI+K7rBS+/+scj+eBetxAdFHI3L4wLdz30AwMofokYCi1A8eHfWfHgG74wvhBkJnqvuhl8hgVJ4xYDtn6EQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_11,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230139
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEzOSBTYWx0ZWRfXxPTQ3KPb4ksN DTilOGUvN5bCIz8+8oIgFZvyUhK6zVwutlbU49IMUEiDuTsGipHI9Rz5CgBwYirT24VrDIbjo/S gjWB2apZ5nZMeb1Y6VQLStkTZkasZMz0ZH/kup7zrSuNVYYmZORss2Yt3v8wEhHVZC/WeM++Xaa
 c+kUhzdgVxPkchmntmTCgD1TfIS+46O4kA/Ahkf+f8SaZGkwUw4pSrHjJYvXiCCdTj1Icg0zVlj MWOUdeM6IcXbBdTsTFC5wtVF0BI5Nyw56rhf+GRi4/VmvWQJG5NddPr5jn0McgtUJ42HVjrVc/U /qfICjS9hdLY8JGWb6LebuG6h/LFx+c68CXdiFHkGfOtUSLPw7YN52154zeSRxL3s5vuihPwTb1 dsGR0hrm
X-Proofpoint-GUID: fz_bASZRugUTIrmOrJzZ1wDEkx4OSh-p
X-Proofpoint-ORIG-GUID: fz_bASZRugUTIrmOrJzZ1wDEkx4OSh-p

On 4/23/25 12:58 PM, ALOK TIWARI wrote:
> 
> 
> On 21-04-2025 21:57, Ross Philipson wrote:
>> Prior to running the next kernel via kexec, the Secure Launch code
>> closes down private SMX resources and does an SEXIT. This allows the
>> next kernel to start normally without any issues starting the APs etc.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
> [clip]
>> +static inline void smx_getsec_sexit(void)
>> +{
>> +    asm volatile ("getsec\n"
>> +              : : "a" (SMX_X86_GETSEC_SEXIT));
>> +}
>> +
>> +/*
>> + * Used during kexec and on reboot paths to finalize the TXT state
>> + * and do an SEXIT exiting the DRTM and disabling SMX mode.
> 
> 'do an SEXIT exiting', sounds awkward. Changed to 'perform an SEXIT to 
> exit' for clarity.
> 
>> + */
>> +void slaunch_finalize(int do_sexit)
>> +{
>> +    u64 one = TXT_REGVALUE_ONE, val;
>> +    void __iomem *config;
>> +
>> +    if (!slaunch_is_txt_launch())
>> +        return;
>> +
>> +    config = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
>> +             PAGE_SIZE);
>> +    if (!config) {
>> +        pr_emerg("Error SEXIT failed to ioremap TXT private reqs\n");
>> +        return;
>> +    }
>> +
>> +    /* Clear secrets bit for SEXIT */
>> +    memcpy_toio(config + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
>> +    memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
>> +
>> +    /* Unlock memory configurations */
>> +    memcpy_toio(config + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, 
>> sizeof(one));
>> +    memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
>> +
>> +    /* Close the TXT private register space */
>> +    memcpy_toio(config + TXT_CR_CMD_CLOSE_PRIVATE, &one, sizeof(one));
>> +    memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
>> +
>> +    /*
>> +     * Calls to iounmap are not being done because of the state of the
>> +     * system this late in the kexec process. Local IRQs are disabled 
>> and
>> +     * iounmap causes a TLB flush which in turn causes a warning. 
>> Leaving
>> +     * thse mappings is not an issue since the next kernel is going to
> 
> typo thse -> these
> "are not being done because of the state of the system" can be 
> simplified to "are skipped due to the system state."
> "Calls to iounmap are skipped due to the system state this late in the 
> kexec process"
> 
>> +     * completely re-setup memory management.
>> +     */
>> +
>> +    /* Map public registers and do a final read fence */
>> +    config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
>> +             PAGE_SIZE);
>> +    if (!config) {
>> +        pr_emerg("Error SEXIT failed to ioremap TXT public reqs\n");
> 
> reqs or regs ?
> Assuming you meant registers (regs), not requests (reqs)
> 
>> +        return;
>> +    }
>> +
>> +    memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
>> +
>> +    pr_emerg("TXT clear secrets bit and unlock memory complete.\n");
>> +
>> +    if (!do_sexit)
>> +        return;
>> +
>> +    if (smp_processor_id() != 0)
>> +        panic("Error TXT SEXIT must be called on CPU 0\n");
> 
> Prefixing with "TXT:"
> 'Error' is redundant — panic() itself implies a fatal error.
> we can use panic("TXT: SEXIT must be called on CPU 0\n");

All good points, we will address these.

Thanks
Ross

> 
>> +
>> +    /* In case SMX mode was disabled, enable it for SEXIT */
>> +    cr4_set_bits(X86_CR4_SMXE);
>> +
>> +    /* Do the SEXIT SMX operation */
>> +    smx_getsec_sexit();
>> +
> 
> Thanks,
> Alok


