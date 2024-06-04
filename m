Return-Path: <linux-efi+bounces-1153-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB25C8FBDDF
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 23:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A462862AB
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 21:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F34A14B97F;
	Tue,  4 Jun 2024 21:12:50 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E7140366;
	Tue,  4 Jun 2024 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535570; cv=fail; b=cVK64ZB6xez3PwC0aqNwjvgveppsqYRWWQNzNJTtS6L4jF7pVOnrXqYi6CbmSoJYEBBN+DO1sHx9AWH8tejlFfge0DQYJGm6aLWl2phLbcG/Wmzog0bdvVd24Z2ppXaED/UzNRNMJbSsAIcOKtKFmUz7uouL/4y7vU5xFREPt6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535570; c=relaxed/simple;
	bh=U+O0AjYlCBZTHJNoPQDv1CxGhcCfQBK5wKqJRbhdvIY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lq4DXfgmIYDab3+9vlzFdbqjqfh7OkPHoA8IL/TEu6+3Kj9WROwU3XOAdnmcU9VOTvC4NJ48SdN2LxhEmY9cUtYJLIcofDpqt9LhanzElURM1QIF1au08w3eH9gVRGQjAFJKAatUTCTJMB/zFI/ujJlhKQqPpcSGhT3Fpw94AIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454J4Rt9026963;
	Tue, 4 Jun 2024 21:12:14 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DwfgIzVVAyuatlqWHeM/OgipifgM+gz9OcBGrpp5TxXs=3D;_b?=
 =?UTF-8?Q?=3Dcn34noIt8V+42Srj4w4Yc6bmjCje7vAC7Vk/p2lf4iHKUXMtICxTTos8cH9g?=
 =?UTF-8?Q?+/rGCiBm_M+vYx27CqsfdALJtK5rCkDWvSLjtjmxjKWX6nqLC6EEzv9xxx18WX2?=
 =?UTF-8?Q?tv6z5ohpQA6Ysz_BsVdwSxXkjvYpka4fVLo1zYgiLeMPGYK3rJg9R/41F2100hu?=
 =?UTF-8?Q?NlRNcUzgEU66bwIw+FkD_obuV0n7Rjv84kktkDxS8saJclmfSr0jhfvDie5A3FA?=
 =?UTF-8?Q?06HIJm0lnIhhxVS3DpWHLhb7uH_HkzdflH+ib/QfsbsbCktNe2dFuhs2pdQJVUh?=
 =?UTF-8?Q?ml0c+4z+hvgkJ3dO1ETtf/9Z+mzRTBt6_pA=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv07wxvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 21:12:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454JOm0p025148;
	Tue, 4 Jun 2024 21:12:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt95xw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 21:12:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpwgf42GZIiCcBHWWgIlUbe1b7mLLGTJIym+3Oc/rZ7Neeg4B7NBT6b44SOetns0zFiWYhZ64hAxAXloqaGYfP6mGpxxZCvT5+JV56kAG1PC+D06mmjffgUDmWpFKTxuR6ndXOlRIePWPp+1qIouY31ebjtBU9VBKNsEZ2UhzCmJGToj8+spRaliahjTFz5djHrPFGcJZAzshUJXMv276FRZ3a+oRFT8qqOJZUJja9LkGi0DQtzJRjVOOdDiiLLHkBbcUMoRVMc7FlVWLG61jl9mZSSUHglUQxEvtYukCX/5Mvl7NSJjXXEUnXa5phcD06pJPknF+Ot2MO6kWg87fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfgIzVVAyuatlqWHeM/OgipifgM+gz9OcBGrpp5TxXs=;
 b=DmQOF5RFWku3hJNLrBmxkUIP7sE3AVSiC7rVl584meXfqIaK9s0ZeoGL9//jCcY7lL3OSAQrwZ5Q0GJCMP9WGgCkRY+2B9DLoHQrOYURg9n6C7XOZU9+Lk+EoRGwAAFFIwA1/1sgddFsmgGK7nGMk9bQxpCH/yoivpkAR7shfdgwTDgsBbTQQQJ63zByhrWcY1tlCDuOnpDIeDHwQAtpBCsRxxSX9FCPGqwhD9RhggDZ2znnj7j7yvOLdi+uZTmZp9yZTwuwc/RbkTEDr1R54gF70DNdxnrYv/iNtqlhIn7cSrRgdczH4pgrWkNRkbFuH248iLloabHK4T9A0BfsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfgIzVVAyuatlqWHeM/OgipifgM+gz9OcBGrpp5TxXs=;
 b=DoiEzFgbjG6V53JjIMnAwoo0IqKvdzwef2io0gc/nbdNH2/a20VTtLQoNpiYTIMHgFj1o6i4pgSX6ruIM79vcII8JKQESZyhwdPYezOUipT8VRf/c13WEZDdMPWNqxOvff+aSNEso+PLKOEeGcKzPRZ9ROZhvlRf17g67Z5eG+Q=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CH0PR10MB4988.namprd10.prod.outlook.com (2603:10b6:610:c8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Tue, 4 Jun 2024 21:12:09 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 21:12:09 +0000
Message-ID: <80580749-1a60-4754-9979-1fa29825f2f8@oracle.com>
Date: Tue, 4 Jun 2024 14:12:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/19] x86: Secure Launch kernel early boot stub
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-9-ross.philipson@oracle.com>
 <CAMj1kXHaH6atsvwr6oVPdZuhR5YEXU33-2kYEn6xb1e=gidOCw@mail.gmail.com>
 <CAMj1kXHcYOPTLTh-hEtfHk+JaORGK+fEatTT+UOqLJww+_cNTg@mail.gmail.com>
 <5bffa507-75e8-4cce-ac0c-fe13d6efd3bb@oracle.com>
 <CAMj1kXHLaqyPAw5Jjg91pqFbHoMT2jDqui4rosyerHVudRsq-w@mail.gmail.com>
 <5b32106b-bb7b-463d-8b0b-589e3d466bf3@oracle.com>
 <CAMj1kXEak-_D=B9qLsvo-M5+qJKSCrBwkoQkmC7_NoPR34+r-w@mail.gmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CAMj1kXEak-_D=B9qLsvo-M5+qJKSCrBwkoQkmC7_NoPR34+r-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::17) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CH0PR10MB4988:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf280d4-751c-4858-337d-08dc84dafe9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bzZiaGtwSEd6S3lFZEZwVWtoeE9JeE1JYTRWOWkwM1NZN2dNdWpaUGxCRjdF?=
 =?utf-8?B?UDBrVUIwVFBKVmZzREVMVDNuSVcrd3cxYlc4dlZsWnFUeW91NHhxZHBrcWhE?=
 =?utf-8?B?U1lldm4vUlRUTitIRGk0SW96a0Z4NjhUME92d2hMZjR1UkZtM1ZzaTZnQlhP?=
 =?utf-8?B?MzhWYUNhaXlYelRVeUhmQXZ1TDBqSDZ1c2lpKzRGUWMrcldLd0dXc2YwUTdt?=
 =?utf-8?B?Q1RWNThzanppaENTSmNwazZ6NjJ6dURnVW5FVWFVcGl2bG1iNUpJQjZVd1Jz?=
 =?utf-8?B?VVFRS3JEcnhVMkxOVXI3bk9PNUcrVVg0b1Bhb0xuaDJQWE5QdlN5SHJaSm5E?=
 =?utf-8?B?TndvMy8wWSsvWHE1M3g3SVZVNTZyUlFBTEExSTZ4RzIrTWgwWndjeTBQVnlR?=
 =?utf-8?B?T211ZnEyNCtYdTZ0KzI1L1pkOU42eG9sS2xYTFlrZVkwcnVRbDRLSE55Wkx0?=
 =?utf-8?B?aXRialU3OTBDQ3dBRVdjUnBKMnZPaUlXcW1vRHR6VkdydjZRczFFcS9ZajEv?=
 =?utf-8?B?WHZjNWJld1d3UFpPQ1l6bmRVQ1Z6MjQ5bkhURWI5QU5PUG9QWkJ4Sng2ZUFN?=
 =?utf-8?B?MkdDMVdreEYwKzdtdVVYbGs3SHJEalNtTGxBNkxWeXFPOVhwbExXS1BlMDE4?=
 =?utf-8?B?dTI0SGU1ZWJ2UDYzeEoyTXdGd2hYTm12OG81elJ1eGhJVWhYb3JuY1VjTE1M?=
 =?utf-8?B?SisvdHhVUkU4enJlbHJ0MWM0SXpLWTJuR0JJcEE1emRjWHcwTFlRU3NWZ0Q4?=
 =?utf-8?B?S2pwYzRiWjJVaDRLZVYwV2VuVzBJN3kvc1VtMDlRekNHVFdkVzBEUENqNGlu?=
 =?utf-8?B?dzlOa2FzV0Y0TVFpTlhCVHdaMnNFci9SQmJUOWpjZXV2Y2J3bXBid28wK0RF?=
 =?utf-8?B?MlRzZDVtOHM4REgreGJDYmpLbjlrOTgzT0FFeWFvTStLRmd0bmVSVHcxdFBH?=
 =?utf-8?B?RFlwYW0zSC9hY1ViajdTN0loSFY3NnNHUjdzRXhQZUVNZXpkM1ppeTZPMXBH?=
 =?utf-8?B?bWMxUnovUzlDZTJpK2JaQzF3WVhEUzR6UkRsZEFWK1VEU1pxV1hoOGNSTFcr?=
 =?utf-8?B?Ly9qKzFVSnVLR0RNNy9ZYU53VEpVUHp6R1dQTnhqMHBIMHB0bC92MWVabVFB?=
 =?utf-8?B?SjdXNDRCcVNoNTIwa3l0K2JMSnNBWE40dEROc2FiT2tueGZHazdFNFhhZWRm?=
 =?utf-8?B?dkVrcW1tcDF1VHhYVjRnV0dzYlpaTVZkOU04d2t0UUNsOVFicDlhTDYrVWNT?=
 =?utf-8?B?TGIyR2pTcTMxN0hlRnptNklTOHN2dmZTU2xKbkxaeG9oTmtycnNwZzBzM2Fw?=
 =?utf-8?B?bUlMa2M0YTJwU2FtOWRFMkxXWVUzdmt2UGJkaXgvc3JsTHBFQVFKZHJpN25T?=
 =?utf-8?B?UkR5R25wV1pHMkR3dnl1OFlyTmtlRTRLT3BRbzZnTTRiYWNlY2d1M0FrU0tm?=
 =?utf-8?B?ay96MHo2RDhEMWpXa01DNWg0WkYyamtyanI3T3hxUWVmSG5nUWU1VWhaa3Z3?=
 =?utf-8?B?NUdSeG5WWUFqQnBwYUZqdCtFSjVRQkNKc3Yyb1ZLWWowand3QUFCNzhPZjVK?=
 =?utf-8?B?Tm9RL25EZFRuQVo3S3cxTXdoU1BVdVZ2dUp3OWxyQThrMU80T2tvM3Vvelgw?=
 =?utf-8?B?MHVNa2lGZzRNWUNSRG1EbGNyZC9WVkt4VjJ5SjBQcjJldmZVaWpFbzZQTm5q?=
 =?utf-8?B?LzV5bEw4ckFXNFBEbUZ3WDkvU0x1Zjc4RVE2enloVG9kdG1Nb3RUODNBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmgyMTUra0NBWFUyS0RLZXpvTDFBWDNYMHpSa3V0WFkvaDdJU2V6R3QvVEpK?=
 =?utf-8?B?NGxoY0pENXI2dTdsSzh4SnozSVk4WU5BK2YwcGVZeEk3ckhYZW1FSnkyWW00?=
 =?utf-8?B?NDZSejhSVTc3VERmUXVNZHdHSEZEZHhaYVk4RmVENS8xWFpldXpITE8vWk14?=
 =?utf-8?B?MlhBYmhsZGNJRjBsVXNZRzFhQnhSam9jQ0FVeU93RW5LK1ZBNEZ3bXhBZC9z?=
 =?utf-8?B?RldYOUxlVFBFd3M0Y1dxbkdkQ0QyZjlYemovWWxKQ2lZNDh4NFNPZFUwWkpL?=
 =?utf-8?B?N0MzMC9VNDFSOGRvOUIyQ1E4eCtmUWx5dmx5b29yekNydTZwU24vdmlWMUFW?=
 =?utf-8?B?YnRiWEJnU3VhS0lxcWRSbmtaRjljRllETE0xTnlOU3ZGNERQZ1dMbno1QkFW?=
 =?utf-8?B?ZVk3QkdXWEV5VGd0TUJzelgzVzNCZ01kRC9OTUZGaHg3MWs1cXhyb0xRZ3Zi?=
 =?utf-8?B?US9za20vUjJNY2NMeWtOdUoxTHQ2VnoyRTVOUjUySURIekFvalJ3U0xOYktt?=
 =?utf-8?B?VEI1Z01QODJEK0lUc1FZOTBKYUwveVlVRGJ1bDBxeU5UNVFscVRQVFJlTG5F?=
 =?utf-8?B?V1hQd1hodXNPbFN0VkJxblF2aXJxRW9XWlQ4dytpRlFmdUc5eDJLcU1uYklD?=
 =?utf-8?B?bnQ5Z3RVdGhra2E1VkpOSDdrcnB0YXJDZDFUS3BUeHBFemNKTEdJS1hRWWtD?=
 =?utf-8?B?Q2lXaTEzcndsWGRHTEJjL3kvVXg3S3dkQkIrNGhVNFlucmJJNytlM0hJdVB4?=
 =?utf-8?B?SlJKTTNNY1N1Wm9RNG1DOEZXaGIvTHJ5dVlFU3lGdC9qbldUUUhhcXdSb3Zs?=
 =?utf-8?B?TFRQZ0hHQlVuRk9MNHZwOFhrMDIyRm44bDltdHRtd0pzMGNOVDdSQ0VXNnYw?=
 =?utf-8?B?TDdWUkJ3NFZ0T1RYZlNJbnY5ZjN4ZXd5NTNxYzlTVmZObSt6aFAzR1p6a3ds?=
 =?utf-8?B?c05RQjJBSGVUaTRFVmR3VTh6UW9YY0pCMHNvVWkrdHNPVmI4RlN0ZTVTSksy?=
 =?utf-8?B?SmsycXFRcGYvR1JENXc3VUp1dkh5SHkwbExzQ2N3Q0xacEZxb0JLQlUzUFF2?=
 =?utf-8?B?WmxBZnhRS1E1RVZlRFRZSnEwWERxNVhhQyt6Ry82UDR5VEtTTVI0ZlRXdDlW?=
 =?utf-8?B?dFpUdlRIVituWFBMU1c1VWxZTUxlZE9kamY3VURNSkFXSUxQelZkQXpXdURJ?=
 =?utf-8?B?a3VDY09STElERTcvRmtiSlhkaWU4OERDYjdnSFRFWlkwRUtqSFppNTI3QUpo?=
 =?utf-8?B?dWI2VEVtMUNRUzAvYUNid3ZNaXJpVVExVEQ0NkxUYjd0NTNjck9MWUNITng3?=
 =?utf-8?B?QzFxQVlJYjlUaW51c2phWGdvZE04Ujl1WWdkbVlJdkFScjhtbUZ3ZmppaEVN?=
 =?utf-8?B?eVF2QTAzZ3FZWll5K1krQ09XcHZxM3hOV2F3Ylc4dFRYQlpIN25USHlVQXk0?=
 =?utf-8?B?ZjUwRDNIb1UwTWNkbGpCRlhMZnR2Ynhhc29WbkhZWjZMZ3BuK3pKZEVpRTQ3?=
 =?utf-8?B?VTc0MGhXc3p5QkNVcVM1em9BOHpIL0JOakorZ1J4SEcxRmpjL1RPRXhIZXFP?=
 =?utf-8?B?SUJFTHpiRTVvV291M21LUkFGdncweWx0V0VsQmhWZkJQV3dGa1JITWN0eEk2?=
 =?utf-8?B?d2dWOGlGSmxUVS9ZSFFEejhubGJ1cnE2aFJZaXVuZG1IMmVzRk9xUmRjRm5r?=
 =?utf-8?B?bnFkYU5SZXYwaTUwQ2lBME5hY3I2QlB1Q1p2alVuamRlNnpJcGN2ME15MDdV?=
 =?utf-8?B?b2xkVGppOHJreFpiUG9uVnZRSTVSOHBWVTZ5UmFSWTBOa2tpbTdGQ3M0R0o4?=
 =?utf-8?B?MjlWQzVIY05wRmtKcGN1cTJYcHM3bnFZTTdIKzJCT3ZZVFhZQmJCMW5XRHBz?=
 =?utf-8?B?dDlCTlRPRVg3ZG0zRkJ6NlJmVXZCNEhZb1NxUTdCYUdibm5Ld2E3N3o5OWE1?=
 =?utf-8?B?NUpUSERtZTBpS1E1d0Z6YkhoQThuUmNZUGpPSkJhNFBMN296aEZrTy9DQWpn?=
 =?utf-8?B?T2dBYnNpYjRyR0NSaCt2YVhyQWZoeTVLWHFrOW8xMFN6U2kwY1ZpVlEzK2Qr?=
 =?utf-8?B?VFlyQUNnQVNRNEJwWDVLNENBcisrRGFEazN0RVltMWdxQzNjMWYxTUpVRFpK?=
 =?utf-8?B?ODIvSU5ncEVSL3J1bDh2VTZCQjlhN2xtVWE1VDdoTHNWc1dPYmw0aGNLS2F4?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DjQfkbPGtphju1vEzfGj3hr5zZyHop19HQqn2srD3xMI1iCPS1gMfyFkDlpVswDzkyYV2IMJCA+Jwq8JrwEwWlauvoeus8GU0rXjcQezxyxp7nklAJwCJCZKbw7gK0qQAGQrO38j+kMiF43ZwE1WF0JQG+IAXFaOnvxIyBl8UECpY6p7Ond2OrkhxnK4WVBSpfWaimWxjKNPbfS9iPA81SSp1ZpniJZ6cp0dLeeCmo7J/RwMToSVR/e/RopjBPpVdhWlx+iLTciX7OYqeJkfDRz2FLcPyTFk7Pvs570xZ72mjkD4kSf3EvAT0D6/95KSYMBGwYHzOg/DbxR4nkoUAw+E0QBgjfVaGX8hCKPcv3RE1pUluZawUK0DpDpwXWrCgxe1TadBaGbYOykiZbki0tHJSmM0Df36i2PKZ4O9AH2HIgMfYUwfIVEE3Qz73rc/C1ElfDd1bhOoRA3wwxwsZMYsVKH5NfAtB8abNmxSDsmQqwnsl3n7ayOWtQ4zkfR2G+zfQ0jCKr5AhAvPPuMgxT5C3yv0iV3cRxSOrgejtNVa63XHV9TdziufG8jJzVVCWPX8P4bo86oSG77Ibqs8jCEMDoGB9QSuLETZlhn3WYc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf280d4-751c-4858-337d-08dc84dafe9e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 21:12:09.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHAHgkvsbBs6f2lhVMS3UghoQ7g10AXcQbCgPJaELPGoL0Htda6fwLf4ohlOjmsRfDpTQnlT+gV/cfg+5oR9mxFMbQv08iuLa68Fnnp6FJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4988
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040171
X-Proofpoint-GUID: uO_k8lKaLNXD6430GVJMYyTNbc4jtZS8
X-Proofpoint-ORIG-GUID: uO_k8lKaLNXD6430GVJMYyTNbc4jtZS8

On 6/4/24 1:54 PM, Ard Biesheuvel wrote:
> On Tue, 4 Jun 2024 at 19:34, <ross.philipson@oracle.com> wrote:
>>
>> On 6/4/24 10:27 AM, Ard Biesheuvel wrote:
>>> On Tue, 4 Jun 2024 at 19:24, <ross.philipson@oracle.com> wrote:
>>>>
>>>> On 5/31/24 6:33 AM, Ard Biesheuvel wrote:
>>>>> On Fri, 31 May 2024 at 13:00, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>>
>>>>>> Hello Ross,
>>>>>>
>>>>>> On Fri, 31 May 2024 at 03:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>>>>>>>
>>>>>>> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
>>>>>>> later AMD SKINIT) to vector to during the late launch. The symbol
>>>>>>> sl_stub_entry is that entry point and its offset into the kernel is
>>>>>>> conveyed to the launching code using the MLE (Measured Launch
>>>>>>> Environment) header in the structure named mle_header. The offset of the
>>>>>>> MLE header is set in the kernel_info. The routine sl_stub contains the
>>>>>>> very early late launch setup code responsible for setting up the basic
>>>>>>> environment to allow the normal kernel startup_32 code to proceed. It is
>>>>>>> also responsible for properly waking and handling the APs on Intel
>>>>>>> platforms. The routine sl_main which runs after entering 64b mode is
>>>>>>> responsible for measuring configuration and module information before
>>>>>>> it is used like the boot params, the kernel command line, the TXT heap,
>>>>>>> an external initramfs, etc.
>>>>>>>
>>>>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>>>>>> ---
>>>>>>>     Documentation/arch/x86/boot.rst        |  21 +
>>>>>>>     arch/x86/boot/compressed/Makefile      |   3 +-
>>>>>>>     arch/x86/boot/compressed/head_64.S     |  30 +
>>>>>>>     arch/x86/boot/compressed/kernel_info.S |  34 ++
>>>>>>>     arch/x86/boot/compressed/sl_main.c     | 577 ++++++++++++++++++++
>>>>>>>     arch/x86/boot/compressed/sl_stub.S     | 725 +++++++++++++++++++++++++
>>>>>>>     arch/x86/include/asm/msr-index.h       |   5 +
>>>>>>>     arch/x86/include/uapi/asm/bootparam.h  |   1 +
>>>>>>>     arch/x86/kernel/asm-offsets.c          |  20 +
>>>>>>>     9 files changed, 1415 insertions(+), 1 deletion(-)
>>>>>>>     create mode 100644 arch/x86/boot/compressed/sl_main.c
>>>>>>>     create mode 100644 arch/x86/boot/compressed/sl_stub.S
>>>>>>>
>>>>>>> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
>>>>>>> index 4fd492cb4970..295cdf9bcbdb 100644
>>>>>>> --- a/Documentation/arch/x86/boot.rst
>>>>>>> +++ b/Documentation/arch/x86/boot.rst
>>>>>>> @@ -482,6 +482,14 @@ Protocol:  2.00+
>>>>>>>                - If 1, KASLR enabled.
>>>>>>>                - If 0, KASLR disabled.
>>>>>>>
>>>>>>> +  Bit 2 (kernel internal): SLAUNCH_FLAG
>>>>>>> +
>>>>>>> +       - Used internally by the setup kernel to communicate
>>>>>>> +         Secure Launch status to kernel proper.
>>>>>>> +
>>>>>>> +           - If 1, Secure Launch enabled.
>>>>>>> +           - If 0, Secure Launch disabled.
>>>>>>> +
>>>>>>>       Bit 5 (write): QUIET_FLAG
>>>>>>>
>>>>>>>            - If 0, print early messages.
>>>>>>> @@ -1028,6 +1036,19 @@ Offset/size:     0x000c/4
>>>>>>>
>>>>>>>       This field contains maximal allowed type for setup_data and setup_indirect structs.
>>>>>>>
>>>>>>> +============   =================
>>>>>>> +Field name:    mle_header_offset
>>>>>>> +Offset/size:   0x0010/4
>>>>>>> +============   =================
>>>>>>> +
>>>>>>> +  This field contains the offset to the Secure Launch Measured Launch Environment
>>>>>>> +  (MLE) header. This offset is used to locate information needed during a secure
>>>>>>> +  late launch using Intel TXT. If the offset is zero, the kernel does not have
>>>>>>> +  Secure Launch capabilities. The MLE entry point is called from TXT on the BSP
>>>>>>> +  following a success measured launch. The specific state of the processors is
>>>>>>> +  outlined in the TXT Software Development Guide, the latest can be found here:
>>>>>>> +  https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf__;!!ACWV5N9M2RV99hQ!Mng0gnPhOYZ8D02t1rYwQfY6U3uWaypJyd1T2rsWz3QNHr9GhIZ9ANB_-cgPExxX0e0KmCpda-3VX8Fj$
>>>>>>> +
>>>>>>>
>>>>>>
>>>>>> Could we just repaint this field as the offset relative to the start
>>>>>> of kernel_info rather than relative to the start of the image? That
>>>>>> way, there is no need for patch #1, and given that the consumer of
>>>>>> this field accesses it via kernel_info, I wouldn't expect any issues
>>>>>> in applying this offset to obtain the actual address.
>>>>>>
>>>>>>
>>>>>>>     The Image Checksum
>>>>>>>     ==================
>>>>>>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>>>>>>> index 9189a0e28686..9076a248d4b4 100644
>>>>>>> --- a/arch/x86/boot/compressed/Makefile
>>>>>>> +++ b/arch/x86/boot/compressed/Makefile
>>>>>>> @@ -118,7 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>>>>>>>     vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>>>>>>>     vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>>>>>>>
>>>>>>> -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
>>>>>>> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o \
>>>>>>> +       $(obj)/sl_main.o $(obj)/sl_stub.o
>>>>>>>
>>>>>>>     $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>>>>>>>            $(call if_changed,ld)
>>>>>>> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
>>>>>>> index 1dcb794c5479..803c9e2e6d85 100644
>>>>>>> --- a/arch/x86/boot/compressed/head_64.S
>>>>>>> +++ b/arch/x86/boot/compressed/head_64.S
>>>>>>> @@ -420,6 +420,13 @@ SYM_CODE_START(startup_64)
>>>>>>>            pushq   $0
>>>>>>>            popfq
>>>>>>>
>>>>>>> +#ifdef CONFIG_SECURE_LAUNCH
>>>>>>> +       /* Ensure the relocation region is coverd by a PMR */
>>>>>>
>>>>>> covered
>>>>>>
>>>>>>> +       movq    %rbx, %rdi
>>>>>>> +       movl    $(_bss - startup_32), %esi
>>>>>>> +       callq   sl_check_region
>>>>>>> +#endif
>>>>>>> +
>>>>>>>     /*
>>>>>>>      * Copy the compressed kernel to the end of our buffer
>>>>>>>      * where decompression in place becomes safe.
>>>>>>> @@ -462,6 +469,29 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>>>>>>>            shrq    $3, %rcx
>>>>>>>            rep     stosq
>>>>>>>
>>>>>>> +#ifdef CONFIG_SECURE_LAUNCH
>>>>>>> +       /*
>>>>>>> +        * Have to do the final early sl stub work in 64b area.
>>>>>>> +        *
>>>>>>> +        * *********** NOTE ***********
>>>>>>> +        *
>>>>>>> +        * Several boot params get used before we get a chance to measure
>>>>>>> +        * them in this call. This is a known issue and we currently don't
>>>>>>> +        * have a solution. The scratch field doesn't matter. There is no
>>>>>>> +        * obvious way to do anything about the use of kernel_alignment or
>>>>>>> +        * init_size though these seem low risk with all the PMR and overlap
>>>>>>> +        * checks in place.
>>>>>>> +        */
>>>>>>> +       movq    %r15, %rdi
>>>>>>> +       callq   sl_main
>>>>>>> +
>>>>>>> +       /* Ensure the decompression location is covered by a PMR */
>>>>>>> +       movq    %rbp, %rdi
>>>>>>> +       movq    output_len(%rip), %rsi
>>>>>>> +       callq   sl_check_region
>>>>>>> +#endif
>>>>>>> +
>>>>>>> +       pushq   %rsi
>>>>>>
>>>>>> This looks like a rebase error.
>>>>>>
>>>>>>>            call    load_stage2_idt
>>>>>>>
>>>>>>>            /* Pass boot_params to initialize_identity_maps() */
>>>>>>> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
>>>>>>> index c18f07181dd5..e199b87764e9 100644
>>>>>>> --- a/arch/x86/boot/compressed/kernel_info.S
>>>>>>> +++ b/arch/x86/boot/compressed/kernel_info.S
>>>>>>> @@ -28,6 +28,40 @@ SYM_DATA_START(kernel_info)
>>>>>>>            /* Maximal allowed type for setup_data and setup_indirect structs. */
>>>>>>>            .long   SETUP_TYPE_MAX
>>>>>>>
>>>>>>> +       /* Offset to the MLE header structure */
>>>>>>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>>>>>>> +       .long   rva(mle_header)
>>>>>>
>>>>>> ... so this could just be mle_header - kernel_info, and the consumer
>>>>>> can do the math instead.
>>>>>>
>>>>>>> +#else
>>>>>>> +       .long   0
>>>>>>> +#endif
>>>>>>> +
>>>>>>>     kernel_info_var_len_data:
>>>>>>>            /* Empty for time being... */
>>>>>>>     SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
>>>>>>> +
>>>>>>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>>>>>>> +       /*
>>>>>>> +        * The MLE Header per the TXT Specification, section 2.1
>>>>>>> +        * MLE capabilities, see table 4. Capabilities set:
>>>>>>> +        * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
>>>>>>> +        * bit 1: Support for RLP wakeup using MONITOR address
>>>>>>> +        * bit 2: The ECX register will contain the pointer to the MLE page table
>>>>>>> +        * bit 5: TPM 1.2 family: Details/authorities PCR usage support
>>>>>>> +        * bit 9: Supported format of TPM 2.0 event log - TCG compliant
>>>>>>> +        */
>>>>>>> +SYM_DATA_START(mle_header)
>>>>>>> +       .long   0x9082ac5a  /* UUID0 */
>>>>>>> +       .long   0x74a7476f  /* UUID1 */
>>>>>>> +       .long   0xa2555c0f  /* UUID2 */
>>>>>>> +       .long   0x42b651cb  /* UUID3 */
>>>>>>> +       .long   0x00000034  /* MLE header size */
>>>>>>> +       .long   0x00020002  /* MLE version 2.2 */
>>>>>>> +       .long   rva(sl_stub_entry) /* Linear entry point of MLE (virt. address) */
>>>>>>
>>>>>> and these should perhaps be relative to mle_header?
>>>>>>
>>>>>>> +       .long   0x00000000  /* First valid page of MLE */
>>>>>>> +       .long   0x00000000  /* Offset within binary of first byte of MLE */
>>>>>>> +       .long   rva(_edata) /* Offset within binary of last byte + 1 of MLE */
>>>>>>
>>>>>> and here
>>>>>>
>>>>>
>>>>> Ugh never mind - these are specified externally.
>>>>
>>>> Can you clarify your follow on comment here?
>>>>
>>>
>>> I noticed that -as you pointed out in your previous reply- these
>>> fields cannot be repainted at will, as they are defined by an external
>>> specification.
>>>
>>> I'll play a bit more with this code tomorrow - I would *really* like
>>> to avoid the need for patch #1, as it adds another constraint on how
>>> we construct the boot image, and this is already riddled with legacy
>>> and other complications.
>>
>> Yea I should have read forward through all your replies before
>> responding to the first one but I think it clarified things as you point
>> out here. We appreciate you help and suggestions.
>>
> 
> OK, so I have a solution that does not require kernel_info at a fixed offset:
> 
> - put this at the end of arch/x86/boot/compressed/vmlinux.lds.S
> 
> #ifdef CONFIG_SECURE_LAUNCH
> PROVIDE(kernel_info_offset      = ABSOLUTE(kernel_info - startup_32));
> PROVIDE(mle_header_offset       = kernel_info_offset +
> ABSOLUTE(mle_header - startup_32));
> PROVIDE(sl_stub_entry_offset    = kernel_info_offset +
> ABSOLUTE(sl_stub_entry - startup_32));
> PROVIDE(_edata_offset           = kernel_info_offset + ABSOLUTE(_edata
> - startup_32));
> #endif
> 
> 
> and use this for the header fields:
> 
>          /* Offset to the MLE header structure */
> #if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>          .long   mle_header_offset - kernel_info
> #else
>          .long   0
> #endif
> 

Awesome thank you! We will work on incorporating this unless someone 
else sees a problem with it (or we run into problems and need to revisit).

Ross

> 
> 
> SYM_DATA_START(mle_header)
>          .long   0x9082ac5a  /* UUID0 */
>          .long   0x74a7476f  /* UUID1 */
>          .long   0xa2555c0f  /* UUID2 */
>          .long   0x42b651cb  /* UUID3 */
>          .long   0x00000034  /* MLE header size */
>          .long   0x00020002  /* MLE version 2.2 */
>          .long   sl_stub_entry_offset - kernel_info /* Linear entry
> point of MLE (virt. address) */
>          .long   0x00000000  /* First valid page of MLE */
>          .long   0x00000000  /* Offset within binary of first byte of MLE */
>          .long   _edata_offset - kernel_info /* Offset within binary of
> last byte + 1 of MLE */
>          .long   0x00000227  /* Bit vector of MLE-supported capabilities */
>          .long   0x00000000  /* Starting linear address of command line
> (unused) */
>          .long   0x00000000  /* Ending linear address of command line (unused) */
> 


