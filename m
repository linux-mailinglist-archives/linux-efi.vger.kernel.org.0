Return-Path: <linux-efi+bounces-3338-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC38A8A98B
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 22:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395701902A25
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B359256C99;
	Tue, 15 Apr 2025 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kAhS2ct9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FN8XCikd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A662566D3;
	Tue, 15 Apr 2025 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749944; cv=fail; b=a8iWg+FeuATM73EyF5pfAoo9wd55xTn52DllucpvthqV4sWzmXE1BXt8OfEPcXbkpiDMyiJxpKo4SnWXQlfrTLvOa78Pgh9hMdR3T9qYml5wl0AvSw+aMQmw55kK873E2CKifh3IU4VeGInIRDYcuSfP8Cioh7ifBB0Ufg4ALX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749944; c=relaxed/simple;
	bh=MdeJoTIMnVQCVgAgl/toSJaBCcApgOxHYO6iDFz80mo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rnxlkOW1llY7a05rwfA0WbOfH6MmeFUTqRmMG7B3b16trjLDQB1dmh1b5slCASLFXcQVTrvtrghk64EUF+vxDaYgv1ko5yJWllf1mg2IpeRIXr9Hg6qRurxOuosjSY/e+sA7Rd6+4jMFLuxUSgDsTBkMU5E5wK9g+zL8+o2hTkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kAhS2ct9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FN8XCikd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FKfULK006742;
	Tue, 15 Apr 2025 20:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qm1OZ599V5MULMQ1S6sPsObkD7o0O0UpLSVIF/O0IXU=; b=
	kAhS2ct9GYU3KDW49gEBpd1iA3rW81bA3eRZ7WGFaMWuzMukP+php8zX9zTosd4h
	DyQCcD6dGkwgdHh61aLWBp/r8mYjUJIS6RhpCnj6xYtju9nuSLG8knrIYXzeyUPD
	BjstMrSNFyEtLhvDhQzZtxZDdaYTk0SOopRnsvg9Amez0BnODDhx4Co7BZn5EuZz
	CEfbQeq0wT66Lc42Hqsm0Sxv+QXm8iLGDG2e8RzzdsulQvCX4HZvav9H8pfg5z60
	uaYzYla/9JYqwUGzqV2u24LDfn8v1ADH8cW1fBrLQIJPp9pHiXETXFFDX0enDiNK
	ZaGWjrKsa2ZU+og4KYLXlQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617juar3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 20:44:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FK6FpK005644;
	Tue, 15 Apr 2025 20:44:47 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010019.outbound.protection.outlook.com [40.93.12.19])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d5vvmdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 20:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkJygP9hOUtQ3JCI1Etrfs7Ujjbplr+7TY9c7tVPQUvLAs6KVszllPo5Pqpuir1Ve675nwsazKvvPegPJPh2EGErKlv14umF+TGUKusKSS1LgBwl6qHf/gKL6OMcT7nTQL0t/OwB1fznAFXtqVzo84CrFgfGq42qopYzHEtKJ5yjQ5/ncjcZNYAq/Umicgd5MVlFBDRxPlEvUm6GiS+oMW1UmLz274tt9+IlQtz6ZMmWxyc6w12APgEN7EcIYOjMri245t7GKyCuXAOVJvJFddPDuSTzZQOfAVD+Gg9rCYGk5mI0GawtlubXRobQhENZAIfyxQlvntqXsqDZtBi+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm1OZ599V5MULMQ1S6sPsObkD7o0O0UpLSVIF/O0IXU=;
 b=a+7H7wsJqHJbTWk/GWEkeYR5/0ol/D1SGTt0ar++mSBDBQk9SQdH5MV220O4PdQ3cNwyvAlgvdqNHIsOqvpZfCLSJeyMKDAg8NS6ZU3UG6wD/YT2OxeCgZv/rs7GktpTUvODGdq1FdimWeda8srhIB5CBKgAW9I9JpQVJln1bbNBMDzVgIuuR7M0ip0n3sHT60PreO/wO2UNyfESOKbZLDvNtoJMIE4aiCo6cIKfv2QwucN1AWjVy6i09m8WR3JPntT/HhFnL64nKBxeJ7Edx5zLYUjXWK8Rt5Mat8mwI56chGokfEUpXj1t6NYNcRPhYC3rQAvSDG509a5ahTqijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qm1OZ599V5MULMQ1S6sPsObkD7o0O0UpLSVIF/O0IXU=;
 b=FN8XCikdQwncayPYlCScylZk9in+hCBUIc07CAK1jNbwF+Cs1SFo+kjfJtjWU3IS1ggq+ZF1S8rIH16P+v22b2N1wJrqFujwECvn2WudPwpJvaPn3tuMZ0dDGRayNy5J5H5It+xzfzU8l3JnfO/TCY7RaIo+WihZHno+w0338aE=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DM4PR10MB6790.namprd10.prod.outlook.com (2603:10b6:8:10a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Tue, 15 Apr 2025 20:44:44 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 20:44:44 +0000
Message-ID: <b0c3aa4e-968a-4a13-a689-fcc727622f24@oracle.com>
Date: Tue, 15 Apr 2025 13:44:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/19] Documentation/x86: Secure Launch kernel
 documentation
To: Sean Christopherson <seanjc@google.com>
Cc: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-2-ross.philipson@oracle.com>
 <f816c36c-cb7e-4143-b58c-f96a40699f7a@oracle.com>
 <b06b187a-54e2-460e-8fc5-b440184b6f7a@oracle.com>
 <Z_mKgfZznBZgS-Pb@google.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z_mKgfZznBZgS-Pb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::35) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DM4PR10MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 81aaa156-32b4-4755-25d9-08dd7c5e5a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWg2c2p4MytxTElZdGNkZWJqOSs4RG9RdU9TTCtqMHVtQWwxQUtXUFNnRVV4?=
 =?utf-8?B?Z3FCSkpRNHMyQno3SU4yZnhuVzZ2ZzEvd2FUZTFPcE5SdHBWZkdFamZvVW8y?=
 =?utf-8?B?bWFYT3ZudXdjbno1clFwMVB2WitibWJDa2pqWURpOXZiZzM0VGtUU09NZ2Vp?=
 =?utf-8?B?aVhGNVd6T0xHMDNPNktHSVlBSXFqb1BYc3JsWGNoMzRSL0xENDlSZkJPQW5L?=
 =?utf-8?B?aEl6cFBRVkdIN253VTg2c3Z0M3BVM3JGeXVYMmtCQm1naVYyamgvZzdhN2xM?=
 =?utf-8?B?cCtHZVU1SWU2cW03dWhPZ1FWWkRRbmlqcUVUMzZ1RFlKSWo2aTIwZHJFYTh6?=
 =?utf-8?B?WE9VVzJFbCtKRDFzYW5SeWRqUnNxQWU4a0oyUS9nOEN1ZTJRQ2YyNENaZHEz?=
 =?utf-8?B?cGg4SHc0N0hGUzdTTEFmTWNXTkhCSWJFc2xBUHlsZkc0N1RlemlHNngxK2du?=
 =?utf-8?B?UGZYS1ExMHQ4SGVHQ0d1UEUzOFQwUll1c1RwQnVBa2pVY2taR2ZNQWQwQVBL?=
 =?utf-8?B?NDVWZUFuZUhqT0xUcDNuTGdoSlZZVHZaaE5TOFE3MXkvRHhKSUhJcjYyQ3hM?=
 =?utf-8?B?NjcvRTRmWjZkN2xhdUZOeHhTU0g5cmQvSklnQ1NvK2JFQ3FMalZYWVVwMHVi?=
 =?utf-8?B?SE5iR2JrdHJFcWJjeWRPbVhLZlIxRkJSdE1XczhUYUQxMTlOZU9qb0Jpb2dE?=
 =?utf-8?B?bllqMmdVaXBqL0JwZHo1YjduV2pvT3NkN0tXRi9BbzV2Nmt5S3EwV2QxaW1l?=
 =?utf-8?B?YWNSWnRKL3p1U0cxNHE1VjNFR2pmdWxiaWpQWEk2cy9uZVFpSDV5VWtFMGMv?=
 =?utf-8?B?T1hTVitVdjRtcUd3T2Y0ck1nWTZ0aFNGREc4Q1lZbTdSclZaM3Nvd0RaRkxI?=
 =?utf-8?B?SlpkcC9zNi9oQWJQejRJclBNeFM2ek13aXBwR1RoNjNjQ29VYUZXWDZGdUpn?=
 =?utf-8?B?Q0tYeXR1RUFTM0FDeEl0OVRBYkJtOFlOL2NsZTQ1aXdUTTdjclNpZ25wVVBx?=
 =?utf-8?B?SWt6cWcwbUJSdzdTY1plQWt4RGFOT3Z2KzByVTNBLzJyUExaNTdnSW1tZTlB?=
 =?utf-8?B?UjFIWUFjNDVXU3FTYjJlalBhbXFKdUIxT3pxU2drc25nZDNNYzRDeU82T1BY?=
 =?utf-8?B?NnN4cGRxWGVUeDhZNUtVdHhzbVlkbUovcVZUWFNJZExVbGxjS3c3YVI1K0No?=
 =?utf-8?B?UVFoR1BCbFJEaGo0ZGl0Q3BjbDVIek1yT3hnd0ZIYllQZFZTaXRwd041Wm5Z?=
 =?utf-8?B?eXBCZzZzNThONTN1RWJ1TVhxTG1oNmp6MUhlRVJjWUswSU0rWmQyc3dmVktN?=
 =?utf-8?B?L3FVK052SnNFRnJRaWZmUHhoVkpwaXBqY3R3R3V5OWpSU2VURDNkU0hXTUFS?=
 =?utf-8?B?VjIvSnJGcjZCVHVzWUNNYm1wbUNpUlJUeitZcmlUc1BORFp5MzFHVlNuV2JR?=
 =?utf-8?B?RW5ZSDVBZTJqV3FGTFpoSWx0bWRYakdPSG1pckUrY0ZIbVZoSTd4RjdIY1Vm?=
 =?utf-8?B?OW1NYmhBUmJ2UUFEaUc4YkwwMzJNYURNY3lFa0xhV3RFL1pzQjM3eHZrWUlN?=
 =?utf-8?B?V2FneTVaNmdMeHBTWkFsVmswNVlkWnIraTh1NzdwSTZ1eElHdWFRWklUeU5l?=
 =?utf-8?B?MUFRZFliOUFBWStMMVNkc2VjR0lCemRLL1JFV1hDL3FkcmtpOFN2S2NJMkZP?=
 =?utf-8?B?bll3QjRnQVhRTXg5UmR1aEFlOStSWm1PazRCbzgrMVRDemU4ek1yQ1BIMUp6?=
 =?utf-8?B?WTUzVUZXVU81OU80a3BDTUxPSFc3UmFNRjhQWndXOWNqU0t4a2JQUG1NR1VJ?=
 =?utf-8?B?ODZPbFdnMk44ODRKZnVaRHVJb1B4Mmlmc1hmZGJleVgyWnk4bThjcWx6S3lE?=
 =?utf-8?B?WHZzZWxjRVA1Qlk4bFJzU0t0ZHBLVFh2OHE0TVdVUVVXYm5RM2VJZ01qODlw?=
 =?utf-8?Q?9XoWowBSO5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUhiS3JSblI4LzlGT1BtRk84VVg4aE5DMlNYMElocEVuNUgrUlRUSDdUSFhC?=
 =?utf-8?B?dFBZaXZ2c2Q0bldKWEJWNWRhVThONUFvSEd6TjhwSmRMSHBNT2Z5Ym1yZ3Bp?=
 =?utf-8?B?a0V1Y1JzWG9jNkRLMWFTaS9odlhmSkxhdEtGVVVhYXpSQkVNVmpuRytrV1dj?=
 =?utf-8?B?RkVGcysvU3RBV0lTRWh1UC9LSjdkNmZkMVB5NW1XWjFiY0VGY21iLzYrNldQ?=
 =?utf-8?B?RHh5MDR5VEN2ZU1BMGZGdHJTZE1EYzNZajgyczlOemx2bWFlTlJ1bjdTSitE?=
 =?utf-8?B?dVFwMmdyVnJUN2xGNjh3Sm9sS1VkdjArN0dXdk80SUpoUDZMTVgzSU9kaWVZ?=
 =?utf-8?B?RGh6bHlNVzdzdU95djBXbURMVk5aWlhLMTFrWmQya2hvWm9pZENmMGhjd2RU?=
 =?utf-8?B?bitDMzZ3NXBLSDY3OXRXby94eHkzQjVmb1pvSHNwSEl6UkJkNGt0N1ZMVjVJ?=
 =?utf-8?B?eEpYZExlVFllUzNmWGx6Z3RiK2NablBYNzdxTDFqSFJtNWNLTkFqR1pQVFRr?=
 =?utf-8?B?Mms4ODluYURUd3FYM3NZQWs5clJ3MFlHQ1R3elFCM2x0dGxiL0YwQS9wZStB?=
 =?utf-8?B?UnVIYkIzUS9hbzEwenRkT2NjckJLV3JHcFJ4YTVwQTlQeGdycnBhZEhGM2RF?=
 =?utf-8?B?aTdVWFpUUkNVbVVWcGpLVUszeFJiZDhabGFoYVRpN3p5cUloZG16SmhBMU92?=
 =?utf-8?B?bVA0eWdwR05KWld2QlRBalpCaVdFSnJQakxqS0ttSkJPMjdyckEzVFRhUm1Q?=
 =?utf-8?B?MDVYT3E5bHZWQmF2dkQzZ0YzL1g5Z0Y5c1ZTQ2xueExSajdBc0FrckdrM2RF?=
 =?utf-8?B?d2ZiMGJSaG1zTHV4YzN1QnoxRWFGQ1QwTzZ6eEJ0a0JsbjcvUTRBcWRHWlQ0?=
 =?utf-8?B?VlpBWVNveGVwZkd2YVBobmgxVUo2VExnWE1ra0QyVmhpVkl1YjB2SXdRenk4?=
 =?utf-8?B?VjhtbEgzNVVJNmdMSWw1TTZFSVg1bjhsNjBtMldpd294dHNhR2hiaUxjcVBj?=
 =?utf-8?B?ZmhCeE5MNzlSZ1dld3ZMbDZYVlRLZ0xyeVNaSEQ3NXVZQVV4SFNvY2hIaWZ5?=
 =?utf-8?B?ay95T2luQ0g0aGRWNExQcjRmOG4raVQ4dlplNU1zOFBKb3l3cVJFOWFtRTdC?=
 =?utf-8?B?RThtYVhyaUpBSTgzVHN3bVNaakJTVzhycGdWZitHU3JjblZUYnJ4UHg0aEky?=
 =?utf-8?B?Z3BseDR0czVUaHJUNjh3UlNpaXdDQ3dVNnExaFhOa25jV2xodnZhRVVaclh4?=
 =?utf-8?B?WmlCNVByeW5FeWZVODJtMUFuWVVKWFlVRlVaTHh4clE3T0t2M1drSHphWlJ3?=
 =?utf-8?B?T3NoNUIvVGhJVVhrWTQ4ZnQvcVRLemN1TmxCUWl0bTZNVytYUU5IUlZxejV0?=
 =?utf-8?B?VUdmRDZxSDQzWlppeEFJWVpJUjJONzhoWWtLZEFVWUpaV0J1aHBkTEZ3UGlV?=
 =?utf-8?B?cXB4NmJoYVM4emZQNUVKaVJGZGk3NWJnTHVuVnBJWlVFZjQxK3pkNDhpQUMx?=
 =?utf-8?B?cHJkTkIzTjZKWlYvV1BnQ0VpV1Z3bEk5T2pSN0YwZlBuZm9MNFVIUHYvOS94?=
 =?utf-8?B?QVdFT0lURGFJb0NFeDUveVR3TkJIdEM2cFcxcWFwYkZwc2FOZnZ5bDJjSGJn?=
 =?utf-8?B?L0U2bzA5L1hUd0tOdHBySkg4Z1JUZ1lRQS9aNnBjOFlka01EK3EwWmpQZ1Ru?=
 =?utf-8?B?am0vN09JdTMwUGN0djZtaHgrRUwyOUlzUUNnakZQVVBUcU1wSzRsSmp6QlVr?=
 =?utf-8?B?MytkN3hOYW5FUmpmME44UDdSOGRsNnhVeEJIV25xcnBmZDA4QXA3RUU5VTZP?=
 =?utf-8?B?RzNjZ2psbVEyUVBCNGlvMFFybWw2dzRhdExEbDFSWERhQkhEWWFCa2FRMTRz?=
 =?utf-8?B?YmExL1lDd3Y1SmpsTFNkV3ZjNk1CNVFzUkczZndUYnIwNDd5WHk4MUJ3KytK?=
 =?utf-8?B?NDVLR3duNC9lMTRTNXZBVzNXcXhBa1FMZHEvUTI4NnJzQm0xK05uTFB6QnAy?=
 =?utf-8?B?MUl0QmJCUWpqU0ZHSFNVRUUyaUVkNnFERkx2cWJva2Z3dEdjL01HZzgxY3Ey?=
 =?utf-8?B?OEpSL0R2VnVNSkdvZ3lGeWRIbGM1SXR1U1BsQkd6QVkvMnNieVhEWUFEVURG?=
 =?utf-8?B?ck8xeXlLUXV0M05FNFJ5RHFmN3hQMDhIcGxZR0lMbkJBOHpqWlBiSzNXZHZ5?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3SWnQDlWKY9DkkmGebdDtMtrlBBggjJQ0fXVVxY7snEzkHSdKY8/pgGulIcJmyG/JeFLh6IgxMheR6OJtllCnJOYNWPfxJYzcq96XCoNghX6VrBf3YqfvEUFRwDyqBvwiXKCIwZkS+GdSs3SOSTQWXESvVIGtjpj3tcw/aNGjNlOwD/JOjjeVvkz0BsSo5+M+AVLUw7E5FnDTM/9Bb2gSo+Tqkgecv6nGmagXA2kaIWK32OyoozRaTq6nzsnle/xPm/Pdbhv0hZNhEOtAaTSuPHaXvZM7PxtR0EwT/D2pw9CHDcVQH+dA1IA6Va1tMdPkVZ/EBcfkwyLLgOsNrvomaem+ZqZpL0WK+yWV1uUArpnhPHC26LICVosC+wDfk+oar53Ctz9qAZ18BWQ/k05DRG0hePlN1TDPJSM7KO49+5fT3mh6x/+pC2o66KSB8yqHamFyT0VawabopRIIndQtOwD0oPhqAr8+g2yB5alsSHEbxhKQKlJsJKvYBLsLWR41YkLj7QWqneVWi7Bu1O/bocjx+w9E1kwadiU1NMaIfj9ARehoUywYc1ufoQtaEqpa4ToBaZAR/sjt/e5WwXJ52I0ElgBrLvNmMt0oy/G/x8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81aaa156-32b4-4755-25d9-08dd7c5e5a32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 20:44:44.1980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKp9ojqb+y33aWQ0azqDFWhujo3Fxd/RHwwig/LzWBuG/7z/2bAPs2frifhokM6kpmF2ILg7vwVdNv2BJ6/ll89wv8BZPmvutaGk2xP/hlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150146
X-Proofpoint-GUID: eDrudLGFqBroQ8M_brsuRDTIHAM1KgzZ
X-Proofpoint-ORIG-GUID: eDrudLGFqBroQ8M_brsuRDTIHAM1KgzZ

On 4/11/25 2:32 PM, 'Sean Christopherson' via trenchboot-devel wrote:
> On Fri, Apr 11, 2025, ross.philipson@oracle.com wrote:
>> On 4/10/25 10:50 PM, ALOK TIWARI wrote:
>>>
>>>
>>> On 11-04-2025 02:11, Ross Philipson wrote:
>>>> +
>>>> + - Entry from the dynamic launch jumps to the SL stub.
>>>> + - SL stub fixes up the world on the BSP.
>>>> + - For TXT, SL stub wakes the APs, fixes up their worlds.
>>>> + - For TXT, APs are left halted using MONITOR/MWAIT intructions.
>>>
>>> typo intructions -> instruction
>>
>> Thanks for the review. They are two separate instructions so is this really
>> incorrect?
> 
>  From the peanut gallery, I'd just drop the "instruction(s)" qualifier, i.e.
> 
> 	- For TXT, APs are left halted using MONITOR/MWAIT.
> 
> Pedantically, it's the combination of MONTIOR+MWAIT that puts the CPU into a
> sleep state, not the individual instructions.
> 
> And while I'm picking nits, the documentation is also a bit misleading as the CPU
> isn't halted per se.  I'd go with something like:
> 
> 	- For TXT, APs are left in an optimized (MONITOR/MWAIT) wait state.
> 
Good suggestion, thanks

Ross

