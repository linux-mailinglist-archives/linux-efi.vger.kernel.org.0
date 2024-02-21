Return-Path: <linux-efi+bounces-621-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B3E85E8E0
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 21:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDD4285C26
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B28663A;
	Wed, 21 Feb 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gqeByvBj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cz1gQMgd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9A86634;
	Wed, 21 Feb 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708546698; cv=fail; b=luvxTn0D4qqlsiDlfw6Hgo8+3+kN5Nly2/plcT2b4IbVvLaXQskUO1FCs/c5YwygdqEeh6K8rU4DWA5hbH3HQfJv2u3pXs/L2AzQ+X0MdIVCnIvYazGTzYlXg2goGvhgllM4WP7J91RUDotg7UXfZyk36uxyj8Y2trA4um1gCJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708546698; c=relaxed/simple;
	bh=ZM4Pw7TGq6Ob6Iu4YTOdKx46nQ84CXhAXMB1XlmA6iU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sO2wayVECOBTN6UUIvmWgMFzIt2G+LFesWIvZJeHcGv2y992CB3quY3YgdvnM+w7F8gy1mX4/9gFlAnRHg8i3W5VNDU7VdXPLT9I5T/HHXRa56QMPZHzOySy7xEd4P1bMCyjt+LDU1P+2Zk8MzP383UyIs0jMVQHPluuqjvSa3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gqeByvBj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cz1gQMgd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJZaBU012087;
	Wed, 21 Feb 2024 20:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=KN1gkwMVS5WGyOz5dbf8kYwOYxozUosmOkfYI0IL7D8=;
 b=gqeByvBjbdzm2XqTeB8nnsTqWr0VCCGilzcCn78CSb6bmqczynijwFxwaiuI9x24tUKs
 XUt10USH5rii2UDoiRNWCVTqnuMaP+wSle1AInls1cMyF+SdKitFp3uNL1ZwpVgLAmBR
 MKI/hb+u1DB3NPHrn66gyG4xdj91PqdYs7wqapc6IOio3mYx7x6WJLpXFP3k8tz3muLw
 gKXr146+/jwZ+LAKr8LGvNOJGdvBciLV1cQw9z+1jcWKMT6AoilaG6nIDbttZhRLkkGe
 hAqza5+tPPOuEN558zd6L6KOa4ImtwK3/NNax4VnldGIsjV4ZJwOJoS4zRoTYVPnz+Ps 3g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu2s94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 20:17:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJUKvs037883;
	Wed, 21 Feb 2024 20:17:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89hna9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 20:17:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1m2+350Gd93cEd+8W8+C3xbRlTOfFla+XpN+HWzp3LCPNypNogkxvud0zyK2bXiLH6DEWZnrpYopyNCaul6qsQXHSEM3m7p8Du1dxy7HiefmTH5vG27/Yfu8sFWeF9pVKiUlxJ+Zetpn5weWCsKlJi9JEF7BTK3gSR/87kmr0StVHRsT9nRPsWVvNCzX2EuPFSboCqnvDIdr0pWUmPG9KK+SyBuOyU89nW3q6WZ7sV/mFHWUtCxEKBb/QTJ+uUzst5BsDDYV680HaUrsEP5+Vvg8Mkhw4AyVoJium2Bsr7ukoZYqW8oEzgMOmjoNjcQSx3W+6aDB4HMVrSNJhcbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KN1gkwMVS5WGyOz5dbf8kYwOYxozUosmOkfYI0IL7D8=;
 b=bihS7FR4AeB8DPFnIIXRGUFotNoHd53LvIgUE1XWOfDJ3kE5J/ZqSUNNkHdctfVM1vQ5yo3RLlxVE/FdDmY+2P9P2f0uEW8tBNjzEfnVqU6MO9ask9wGwjIh4smKfc2Ck8hJvmskxhP2TJFaMn48gYduQouCaMOw4N3utssRGgcZmB0xxDVwHmtSfuAuXi6TmOooQqpl5cDxUr937zDzQ0Zrib8OjF+f5VrIqldNm0NffH8Y/Df9M9iZS3u2gY2TpNdTPJokCf6H1MRiqB4HVsskUgFErZbrbE1ATWWF50EncOxTEuuMuMRQJ+o1i3/axYUY7CEr1AK3YK2ogUHLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN1gkwMVS5WGyOz5dbf8kYwOYxozUosmOkfYI0IL7D8=;
 b=cz1gQMgdjl2QY29iPduLibC/IWW+mjkZRc1JxuCTyuvxgBqbIZujfmCILxNZEneZ7xuIgripmfu69dFL4Rrzqsnw2VbxnYUwDUb8qXINezY7jWJywAwtBkHaN801H/8N8gt1JlQpCk3mOceKjKZ3KGwoVISqP+HLw6tRTVHf8Yw=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CY5PR10MB6142.namprd10.prod.outlook.com (2603:10b6:930:36::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.32; Wed, 21 Feb 2024 20:17:34 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::ffd8:c820:635f:8d0c]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::ffd8:c820:635f:8d0c%5]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 20:17:34 +0000
Message-ID: <dc53f100-062b-47ae-abc8-5414ce8d041c@oracle.com>
Date: Wed, 21 Feb 2024 12:17:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/15] x86: EFI stub DRTM launch support for Secure
 Launch
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-16-ross.philipson@oracle.com>
 <CAMj1kXF3k_c4Wn9GU+NC_+_aYfDpAzAUnfR=A4L_T+re1H3G=w@mail.gmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CAMj1kXF3k_c4Wn9GU+NC_+_aYfDpAzAUnfR=A4L_T+re1H3G=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::37) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CY5PR10MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efbb1d9-c6af-4e3b-73f5-08dc331a23e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kSw28QJQlXwLA8A40QBrucjpbC9KvoWhD1VKLWSDUjDdtYlo7v9EmhhiVbR2sOfoddM1T1HreNINbjI1Ls4Kes4FcLBIrei16dhAtiZzgyfZBwGimBdmMBA1+1is+0evSQfDDrt2BFJ6Cn//GBVBUzWfKWug6mr6jIeLVQyKeE4CX4T+qgPH2gVNfQzxdbdunahgkfjyMAQLK/gZV9fnJWXojUxI9NY0VuWiviRLEU3czfsE3uqXieSP4I5+ty76VpwC8x01uxRHAZk1v4cikDWIvueUPu1TEWTEFbZsDv2ShbNgrFYuvTJAoYLvhsO7RaoLummiLw8o5FVsBH+iPylFs9kYdTVUHLoD/HM6x/IAQfU00Dn+c1ZNY9ah3SXTj8vH9sgPFhq5Ln51WbNk59lWb1TK3RsQ0txo3cmdNRRNcDOhiCkh8FJtSMw5D1IyagUmZBdI5lTSzkHtussJrVcsTM5fBgWsP50MK2oxQPNN0UrQY2Yiui6CjFqA5q/fQuS5WujIJlSIs1WJVYD0OeRVheq/ITQk0TSziSYw8i4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T25lc3dPR3gvdTYzM084SS80ZENiTDVtR1RYY1ZGN3BPKzF3MUswYjZPclFm?=
 =?utf-8?B?eW5kZUV3MEo3SEJoNWNVT3ByVXhqVWFCWUoyQjlNTk11UWZneVhBTnFWdk5o?=
 =?utf-8?B?dnlmeTFGLzNYajZPMHR3S0pieXNRR29jL2xodUR5TEFNaWlWbm9iNG9NKzJq?=
 =?utf-8?B?SzRBYnNZOFN5WW0vdDVXajM0SzM5bWlaQmswWVVpenM3SHo3MmVnSC94V1NL?=
 =?utf-8?B?NDVCY2VOME40akJhQjFBNjlkNHd1M3JxWWcrQjRRTGMzMDhCREhSVklobGlr?=
 =?utf-8?B?YS80ZmJ6SFdNZGpYRGFsMXhOajN1MXhKaW4rWWNUcy9KQXNnNFBPcTh3NnZ0?=
 =?utf-8?B?RHhNcnVqYy96R21oazVXK1BUZFd0d2EyendtRTlsbWMycy9hSkRZMnFoSE1D?=
 =?utf-8?B?UkRuTkRoTkczYzgvQ0NRbzc1blNnN2NFVHpwbWptOG9NZEF3Rkk5V1ZLdjdY?=
 =?utf-8?B?ZkxvV2YyOXV0dmtINkdJaGZ3L2xheXdaTlVHa0w1Tms0RUE3b0JwaStQKzJy?=
 =?utf-8?B?elRuWkJzWWxZcVIwZFcwUm5mV05BTy85a2g3STJDdTF4eEJ3UHZoTEZLUkJC?=
 =?utf-8?B?TGdFYXd0T28zRHppdDJqdkdQaktMMFZjVEF3VUxLOWxYa0xxeW1iRTN3b2ZT?=
 =?utf-8?B?VXMyZ3luSnVLRnZIbUt1YjhUM08zaVBBU1FWQmN4YkxSYjdBNjIxVnc3bHkw?=
 =?utf-8?B?SHZ5R3MrWGlISmF2QnFVZUp6amlieDMvMHRHcnN3TVg3b3dsQy9aSWRFSzJX?=
 =?utf-8?B?Uk5nUERWRTFRc3A4ZVV3UFRXM0x4Z1BLSTZkS3UxcU16TTQyemlMeU43QWY1?=
 =?utf-8?B?SHVhRkZybVYzNzRPcGNMY3hlN3VZMmQ2eFFRK2JMc2xNVTdGQWFtM256OTUr?=
 =?utf-8?B?VTgrUklONzIxRUVINTlhN3BacmNYVXBENjlTNHBzVkYyNzZ4d3FGd2t3NVor?=
 =?utf-8?B?cVgvYjRhbE96Q2txWFRDU2FrMnc2bHlFVW5SUDhmdkNrVEdBbkp0Tlh2YlR6?=
 =?utf-8?B?L3ZJMmVTUlVZQWRlYjJqZnlSdGdGcml2VGNrbmtySU55bjVWMWZmR2JTN1Ri?=
 =?utf-8?B?UjhabmpmVFRPbkt3YTFjbzFjWk1UL1V0YUFaWXBZeDBYd0VseC9kcVBnWjZ5?=
 =?utf-8?B?ckZ2YW1JeGRFZ1lFWWhEajMzbzRJVW40VlFrLy9SMUx0aDFjcS91VGZpRTNF?=
 =?utf-8?B?cThheklUR3NBT3piN3Exc1hLMUg1NEtqUlJvZzJDS2M4a1dSMjJTTklRZkds?=
 =?utf-8?B?eUNyMmMzQVUxQ1gxVkJrdkU4ak5yZXdJdnJqZWdja3QwQlZXZ01CZUtFT2N2?=
 =?utf-8?B?UnhWQnNQMUYxNkVvMFBKOVBrK2g2YjM1Nnd5YWlmbytUOGJ2ZW1TRngzSWkw?=
 =?utf-8?B?Nko4RWdlWHZpeHFNRlNva1BJeFJlT0tkdlpoRytxMUdJZ2lET3VSTlpaYk9z?=
 =?utf-8?B?M3FvbnU2UkhuYTByRm1NUHVMZUx5RVhQUDV3aC9Xc1lYNC9leXJqcWFIdm1n?=
 =?utf-8?B?dUlsM214ZnRvQ2VEaWU5MUJJVGNKVUJhL2VkSDZrNTg5dzBYQ1FhcEw5Y3RL?=
 =?utf-8?B?SktOUXNTQld6bXBvVUE0N09iVVBqNjNXU2F4Y2VTVzZUb1RhR2lXSVBCemFp?=
 =?utf-8?B?ZFdoVFZsbjJQUUZpaVlOcmNOTER1bVZNa2xZblExSUUrbk9FOUFuLzZzS0VH?=
 =?utf-8?B?aitPeFFzWk5hQTFLaU1URlNpaUZSUjhBSm4yN1Y0YmtCdWlXUzY1Ym1mWjhY?=
 =?utf-8?B?SkRLc1N3NEg4QjJNTDJtWTczTnFwZnVGclZTalNnY3ozRE5iOC92NldBR1NS?=
 =?utf-8?B?ZVZzNERIMVAvdVNscmlpYUFZVTRoaEpadjhWelNPTndqMWlzNEVack1EYXpk?=
 =?utf-8?B?WVU5d0lyYzdWRUQ5cEdLYnFTWENXU0FGS0hCbWZTVitzbHFrSDNoN1JacStl?=
 =?utf-8?B?c1hnSDByQitPcUZCbERQZG1zanAyMXFSTE9XWXBCcGRiSEhDMkM2N3ZuSGo4?=
 =?utf-8?B?Sk9sMVgyRm56eHNGVjB1L3ZzYTRDb3VjZFQybHhQbUlIM0dpZlFOdXpMMjM0?=
 =?utf-8?B?bUZqOFM1ejVJMTJoTXpxYWpSVUhhRnhOUEQ4cjhXZVZVOU94VmJlQXdkSEVp?=
 =?utf-8?B?UU04UUs3MWFqSGFzUzlySjBnOGVkU3hJd1ROZnhMM1cveXFKWjZDUHNQZVUr?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	w6hBZzRxR1l4c/lIa3eK4r2+FNNaqlx5AouU/fzAbUOY7wPHQe0mtPd09+rCLqR5cMCDYSJGNIRtV/xeJnAtSDtWturTinpAB9EutsP1IWCx/vd8DpRcv75UKVnP20F4KQyozeWOLyd3SA2uoJTLxqlnzVKBLE4wLKF3nHQNHK6qg4cGFRVSVCnPGp08wi7DWdEEDuH5NvtOooGGulGXfcqysXz7EBCS9uAbjw7xpSYLeLc2toD2UV0DlEhSRdJY0OVyo0FwCP9LRAf1oLONDNDyOMFnjhSoPz1Trmsw/mgjMqr5Vj/31DNw9GHBG9ZxP5sRlkdmyaS9s9ud6LPiRnBfvz1B6idkS68YsZBkg8n+hVPC7od6WAGt90XDx9tPXHJn5KDuCIsI4xosTZaKRv5gkzMnTrtKMnw+lvAe2XVzRk4I6B9zlkjYPX1kn22blWemaQeR+OEjOgFP3Nsj3VKzwTOsnR8YJ+eT3FF1F3mCwBnclsUirIqiExF+wLifFSyb5b64s+mo3a0BHqsFQO9hUGy2OojyAzKJBo9rdkZSa5R/N5bCqoskWchO/JT40OFLBa/t2/4KVXbX3Y3Ei1FmokLMJDkIFZcX2pTYiqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efbb1d9-c6af-4e3b-73f5-08dc331a23e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 20:17:34.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbmQsw7E+6y3O8+2GRRC61+ubuhhXqabNKvgGSwyv3oS7XNg7DQpF/FselCZ1OFgRO6Y9bXNE0Rf/cKJoXpelbYRYDNp85M5ZsdY8Uo5sNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_07,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210157
X-Proofpoint-GUID: kESAnOLVYH5JpD43DR3OkTjnGIR9v5Vx
X-Proofpoint-ORIG-GUID: kESAnOLVYH5JpD43DR3OkTjnGIR9v5Vx

On 2/15/24 1:01 AM, Ard Biesheuvel wrote:
> On Wed, 14 Feb 2024 at 23:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>>
>> This support allows the DRTM launch to be initiated after an EFI stub
>> launch of the Linux kernel is done. This is accomplished by providing
>> a handler to jump to when a Secure Launch is in progress. This has to be
>> called after the EFI stub does Exit Boot Services.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   drivers/firmware/efi/libstub/x86-stub.c | 55 +++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>> index 0d510c9a06a4..4df2cf539194 100644
>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/efi.h>
>>   #include <linux/pci.h>
>>   #include <linux/stddef.h>
>> +#include <linux/slr_table.h>
>>
>>   #include <asm/efi.h>
>>   #include <asm/e820/types.h>
>> @@ -810,6 +811,57 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>>          return EFI_SUCCESS;
>>   }
>>
>> +static void efi_secure_launch(struct boot_params *boot_params)
>> +{
>> +       struct slr_entry_uefi_config *uefi_config;
>> +       struct slr_uefi_cfg_entry *uefi_entry;
>> +       struct slr_entry_dl_info *dlinfo;
>> +       efi_guid_t guid = SLR_TABLE_GUID;
>> +       struct slr_table *slrt;
>> +       u64 memmap_hi;
>> +       void *table;
>> +       u8 buf[64] = {0};
>> +
> 
> If you add a flex array to slr_entry_uefi_config as I suggested in
> response to the other patch, we could simplify this substantially

I feel like there is some reason why we did not use flex arrays. We were 
talking and we seem to remember we used to use them and someone asked us 
to remove them. We are still looking into it. But if we can go back to 
them, I will take all the changes you recommended here.

Thanks
Ross

> 
> static struct slr_entry_uefi_config cfg = {
>          .hdr.tag        = SLR_ENTRY_UEFI_CONFIG,
>          .hdr.size       = sizeof(cfg),
>          .revision       = SLR_UEFI_CONFIG_REVISION,
>          .nr_entries     = 1,
>          .entries[0]     = {
>                  .pcr    = 18,
>                  .evt_info = "Measured UEFI memory map",
>          },
> };
> 
> cfg.entries[0].cfg  = boot_params->efi_info.efi_memmap |
>                        (u64)boot_params->efi_info.efi_memmap_hi << 32;
> cfg.entries[0].size = boot_params->efi_info.efi_memmap_size;
> 
> 
> 
>> +       table = get_efi_config_table(guid);
>> +
>> +       /*
>> +        * The presence of this table indicated a Secure Launch
>> +        * is being requested.
>> +        */
>> +       if (!table)
>> +               return;
>> +
>> +       slrt = (struct slr_table *)table;
>> +
>> +       if (slrt->magic != SLR_TABLE_MAGIC)
>> +               return;
>> +
> 
> slrt = (struct slr_table *)get_efi_config_table(guid);
> if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
>          return;
> 
>> +       /* Add config information to measure the UEFI memory map */
>> +       uefi_config = (struct slr_entry_uefi_config *)buf;
>> +       uefi_config->hdr.tag = SLR_ENTRY_UEFI_CONFIG;
>> +       uefi_config->hdr.size = sizeof(*uefi_config) + sizeof(*uefi_entry);
>> +       uefi_config->revision = SLR_UEFI_CONFIG_REVISION;
>> +       uefi_config->nr_entries = 1;
>> +       uefi_entry = (struct slr_uefi_cfg_entry *)(buf + sizeof(*uefi_config));
>> +       uefi_entry->pcr = 18;
>> +       uefi_entry->cfg = boot_params->efi_info.efi_memmap;
>> +       memmap_hi = boot_params->efi_info.efi_memmap_hi;
>> +       uefi_entry->cfg |= memmap_hi << 32;
>> +       uefi_entry->size = boot_params->efi_info.efi_memmap_size;
>> +       memcpy(&uefi_entry->evt_info[0], "Measured UEFI memory map",
>> +               strlen("Measured UEFI memory map"));
>> +
> 
> Drop all of this
> 
>> +       if (slr_add_entry(slrt, (struct slr_entry_hdr *)uefi_config))
> 
> if (slr_add_entry(slrt, &uefi_config.hdr))
> 
> 
>> +               return;
>> +
>> +       /* Jump through DL stub to initiate Secure Launch */
>> +       dlinfo = (struct slr_entry_dl_info *)
>> +               slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
>> +
>> +       asm volatile ("jmp *%%rax"
>> +                     : : "a" (dlinfo->dl_handler), "D" (&dlinfo->bl_context));
> 
> Fix the prototype and just do
> 
> dlinfo->dl_handler(&dlinfo->bl_context);
> unreachable();
> 
> 
> So in summary, this becomes
> 
> static void efi_secure_launch(struct boot_params *boot_params)
> {
>          static struct slr_entry_uefi_config cfg = {
>                  .hdr.tag        = SLR_ENTRY_UEFI_CONFIG,
>                  .hdr.size       = sizeof(cfg),
>                  .revision       = SLR_UEFI_CONFIG_REVISION,
>                  .nr_entries     = 1,
>                  .entries[0]     = {
>                          .pcr    = 18,
>                          .evt_info = "Measured UEFI memory map",
>                  },
>          };
>          struct slr_entry_dl_info *dlinfo;
>          efi_guid_t guid = SLR_TABLE_GUID;
>          struct slr_table *slrt;
> 
>          /*
>           * The presence of this table indicated a Secure Launch
>           * is being requested.
>           */
>          slrt = (struct slr_table *)get_efi_config_table(guid);
>          if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
>                  return;
> 
>          cfg.entries[0].cfg  = boot_params->efi_info.efi_memmap |
>                                (u64)boot_params->efi_info.efi_memmap_hi << 32;
>          cfg.entries[0].size = boot_params->efi_info.efi_memmap_size;
> 
>          if (slr_add_entry(slrt, &cfg.hdr))
>                  return;
> 
>          /* Jump through DL stub to initiate Secure Launch */
>          dlinfo = (struct slr_entry_dl_info *)
>                   slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
> 
>          dlinfo->dl_handler(&dlinfo->bl_context);
> 
>          unreachable();
> }
> 
> 
>> +}
>> +
>>   static void __noreturn enter_kernel(unsigned long kernel_addr,
>>                                      struct boot_params *boot_params)
>>   {
>> @@ -934,6 +986,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>>                  goto fail;
>>          }
>>
>> +       /* If a Secure Launch is in progress, this never returns */
> 
> if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
> 
>> +       efi_secure_launch(boot_params);
>> +
>>          /*
>>           * Call the SEV init code while still running with the firmware's
>>           * GDT/IDT, so #VC exceptions will be handled by EFI.
>> --
>> 2.39.3
>>
> 


