Return-Path: <linux-efi+bounces-3440-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F29FA99910
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 21:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDF9446374
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 19:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F5826A1A3;
	Wed, 23 Apr 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bHfKmDoC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f5d0iX+m"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA81257AD4;
	Wed, 23 Apr 2025 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438392; cv=fail; b=UvC0hEhXOWXYvAUUDU720vIlX15yu5RL5NuR4NzLcFCnUMPtgXa7RErU3zaYFkY1zTINQ3Tl16L0CJpCNGydzq3LwKYrpA4gN9SFSWV1aqAhlXP+t4sNmjtvqeeBs3nqd7TA0LrmRg3UZBLHDRpKOTi+O5NKFqKfjeWLP3Fvhzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438392; c=relaxed/simple;
	bh=QI91GGTqun+c+zZjly88NcPH7jMHz3vcnhmT7ZDF3gk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hdNiZvhCwX35Q2qqeqqBtYB9gXVP6ZFh6fRNLyoJFg2yInFYsGIyXq7tvAaRXZvyLTng7ozvW685Shif/83RLReEig2d9cDOvgUhxYsyGlHdNWF/AJ3SyyY5oR8PlGAhoh96muIGON/tDNB+Zft0ksgt/Z7Eluoc1d2P5OXxVIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bHfKmDoC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f5d0iX+m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJtmjj026254;
	Wed, 23 Apr 2025 19:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NnuWWIHoCIR6sguYmNk8rswsQEa7K9xTzM+cDR9l8Lg=; b=
	bHfKmDoCrEu9PGyHIjAr0EuD2IYHQOk6LA0TBly/QeKxDlKpG2vgveC8kHIy9a0B
	9l+/tvF1AynSdFI9cbYjSIY3elxQP3M4L0jloszLgRdJoXVkeMoGOW/UfRzMN30z
	mJTURDzfeTR7IVZr1REpz8wej72pjZlKyHMYx7ghMFhD6sTma7Eal+MBxJt5NsHa
	oOpX0z7poYwBjG5Zm3Mx/9S43E54Gq0+8pGRUUSuMhjV53DLFJJexM6qx25M9imu
	q7+RZ3w5VUK4cj4+IUMt5jJXG5FxNksOeU6nxNUDN6wmYFCGQF8Nb9k1yP0nUtxL
	qI7ME7Xkcf51LuuyndgKqg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhdj6sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 19:58:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJ21NL028470;
	Wed, 23 Apr 2025 19:58:55 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010003.outbound.protection.outlook.com [40.93.10.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx6kpyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 19:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeOsSgtqOW5zI3jxSvXZFsy8vNzl7TS1hjmEKdQkMpqB5Qrgis8UxQzYr/nYDdHlDx3KJ9k2CIwUsu6v/4u8LI7lsHjdXnYVsjCBeyQ/jvA7ygOW5300Go6y+qVAi+sSXx4h1rzvcECuQK3HH66F+u8vH2qiNovAIbzNaROlFYDAk+OW56Y6LCoCmEGKN5ABSTrCwRADumOEKRpb6o2XYXJFQGc5Cds5RB1lOdoqGbU0wEon4JMLdynBkcfaZRTy/vDT/+jM38douTOxbG844JmPVsCmShNUEhk1OZTTg+FDDxBlI3pUELm1f8G17Mm0DqCpnPH5JQ1LeB5cWdAPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnuWWIHoCIR6sguYmNk8rswsQEa7K9xTzM+cDR9l8Lg=;
 b=YAIwRrJRGEu+ccNcfZ+1BfeUOeLIJwfa93ZsdN1Vd31N4y3j3jVXVg8+KaZPb0VVoouC0arKv4izqqEC3TmjbDUU3g4gSDZhaclTXdaE7QNvEE67NnMHXrPTkDHKuxFO+KDX+OrmJ16Gi4BjjYLA3tPic4iYo3/Cdf1XN5KMl4tFh8bJ66iRabIfHr3dlXV6z9+61FO5dUGr2m4KOO7pasiC77F1Hum5ty/gQxf8ApNwu72P28D/sTo3JkN4LZfgJDck6tJAJAJnnfKqysQ6RYc2X48XOZwyXKDH3zA/H5aQ+F++Mw7pNrgA/28plQuiZESV2Qr//qMXvSvWU0sOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnuWWIHoCIR6sguYmNk8rswsQEa7K9xTzM+cDR9l8Lg=;
 b=f5d0iX+mGqc19FYtdc/BkyumCmi5HGxhGISvOKiz+BXNt68KuXU+BSq3W5FYlW9BdD+2XOraJJP9E3nGqp4MTotVqMZlbhrZEU0zA/XomSWR7KFpLD5yT+R8yDk1sM4vhza5k55wt/MKIJoE8k/SZXNUN0jGNw4R4AvJ790Fy9E=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SN7PR10MB6641.namprd10.prod.outlook.com (2603:10b6:806:2ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 19:58:51 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 19:58:51 +0000
Message-ID: <ad920d74-0a69-4070-a396-f17171b8678c@oracle.com>
Date: Thu, 24 Apr 2025 01:28:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 12/19] kexec: Secure Launch kexec SEXIT support
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
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
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250421162712.77452-13-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SN7PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 7023782e-640b-496d-f771-08dd82a144b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXdpVXdSZGlleFdhNklpQU5qZ1d3TFdNTFJRZlpFWFhkRFNxakpPT0xBTjk4?=
 =?utf-8?B?NENqVzhhM3FTcFBQb3lPeXhkOStVekd5Sm5MSUFLcWlRMVFTVWdpY0tnWTVr?=
 =?utf-8?B?cWFJVnRnS1d2eDZTMmNwZ3Z2Vi9SVnNwWGtqMXNjN1NlZWxOd0NIMjN1MGgr?=
 =?utf-8?B?dGllT2YxY2wvYjR3aks3Sm5wdUNFOW4vczJyd2dDOExGT2MzYlhoQno5SG1H?=
 =?utf-8?B?NjNDenJKZHFOMjhYdXpyQ08xWmVxeFRFMmQrTEUrOHZlMk9CQ2R1em9ab3Qz?=
 =?utf-8?B?cXdDWDhQV1JONW1PdHpkR0ZnNElWR0JJbU16TUM5Vjd1SDhMOUYyOHFHYnh6?=
 =?utf-8?B?WWRSdkhJdmNoYVpNWlNzallHSkdwdTBaUGNpZkFsOXdGbFcvSmZISDY3a1pR?=
 =?utf-8?B?eVRRelAwRTlUanVKSnREbVRhZ0JEanR0UUpYU0RUWmtiaEVhTCs2SVA5bHBW?=
 =?utf-8?B?cEJrd1pxb2x2aStwVklISFZuY1FFWkVabGVycDNnY1NkQjVGN0J2ZFJ6QWlY?=
 =?utf-8?B?eWV2U25oSWFzeDB2NDdQbTF6SmNyRXJzKzJDRWQ3OGFhZnErdVQ4RkRPSTN3?=
 =?utf-8?B?QzgxMlI0VUdFQXlDbE91SWVyMEp4RlhjQlZ1ZTRkS0dVb3owdlFPMllvaStG?=
 =?utf-8?B?d1FldE1rTVdXL1dWeTBFS3dmWlhDUThBNnZOVjRsNjcxa05JTnFXbkQrWUsx?=
 =?utf-8?B?dkZTMnR4TGNBejRkRDY2OXo3QnlPZzlzcUNQSlp2dGgyNGJaY0NjZU4xckNQ?=
 =?utf-8?B?ZkxTc3ZXYTAwdEtVUEZpKy9DOGw4by9CazZnWVJwM0FSZ2lyaVdLOGx0K2tp?=
 =?utf-8?B?UUM0NmV2d2VGVTVWd0tzVEZQRzZxbGFna1FMNENrRkFwUWtNeEdHMHZsVmdS?=
 =?utf-8?B?SWZQMUEyVHl2SWtnYm8xQzdwTGdkOGVoQ2hHWnZCcUdVbU5razk3QXd2TEpU?=
 =?utf-8?B?MFRRK0tBY1BXVVhlLzN6L2N3aGdiQkluU0hLdVd4QVFZT0Q3T0hPenFvRkw2?=
 =?utf-8?B?d00zajZnWmpNV2JvVXoyUkFVKzN1UVNJM3BON05lU3JycHBDU0xWRGd2WGdZ?=
 =?utf-8?B?UjFTRExtbDBVVjEvS3NKdHR2Zi9xaVNEcjkwemZpeGpoSFkrdlkweUpDdG1E?=
 =?utf-8?B?S3hXdUhHZzluZW90dG8ySytWWWdSaktROWFqb1FZOXFtdmQ2ZUc2UUZLVkFU?=
 =?utf-8?B?TDU1UFhpNk0wMURQL082eWlpY1pOaDQ2ZlRlYXFHZ3htMTc1Z25Dd2lnSEhu?=
 =?utf-8?B?M1hZQmR4d0hoOWlOOUZqSzIvSWNZL2JrU1dkNnZkYmJEMk1rMm1MZ1JWSkps?=
 =?utf-8?B?Q0NUUWl0RTZYNWFBcFBhWEk2QmZtSHNwS2x3d09nWXZLVE9kT1Mra0lOUE5j?=
 =?utf-8?B?VDNBQno0RnhteTZzNUdyVEZrREFKdTZpamVtN0MvbVdBTEs5RFp2WlNaVzNL?=
 =?utf-8?B?V0NpWitUajVka1hmRGNLSHZWUUJGSWpJYkdwRTE2aWZicXNFeXYxb1k2dnpu?=
 =?utf-8?B?Vmo5WXphZG9VajN5eWdocy93VWh2dXhKOHhmY2NDMVZscXVEUG9zRDBlRTBI?=
 =?utf-8?B?Qlp5dGlkdnBPTFUrOGg0QzFFN1pwck0xMDErL3VWVkR3WWoyQ2lzQlNTcjlV?=
 =?utf-8?B?ci94anBOV3piTDluSXo2T1hSQ21mLzhjVzQxNGpjc2lGRGEwK1dQSEJ6Ri8v?=
 =?utf-8?B?R2VUTVg5VjRtZVA3NzRPK0wyNkltUDJaVmh0UTU3NEh0aXhrYStwZnNJZnd1?=
 =?utf-8?B?YU9nbXN5aWEvY0xMNGRuV1pZcUZwZkpVbkhieCt5ZnR6aGx6WVpwajd5aGNE?=
 =?utf-8?B?MzBDMVc0ZDRoM3VZMm5oTjQ5Ritwa2FPK01WSHJ1NS82L0RZMFNsazYxVld1?=
 =?utf-8?B?RkdwNXIzc2FEazg2TnhxcG1mUWtSVzVJUEFJLzg4OHhkQWJYcEMzdE5BeHVj?=
 =?utf-8?Q?IRQmcflqGNk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE80YllFTUhOTDdyNUMxYnNjMGxKcXo3T0NBQjRqSDQ4MnVxN1dRaXk2TUQ4?=
 =?utf-8?B?ZFhZUzlWOGllek84R0VqUTAxQUM1dXZ5Z0t0cll5OUIzSEE2bDNOY2tUSEVM?=
 =?utf-8?B?T1U2VEJMbjdEOVFLMzZCRFBybnd3ZEVhNkdBZ2RUVVBGampaVHF4RUZhNGI2?=
 =?utf-8?B?eERteEh2U0cxcjJZN3RqQ2d5djdJdlRlVG83REVNSUY0OVc4RFNhM0NIQjZS?=
 =?utf-8?B?Q1JLN2lMc2FKRXoyMWx2QVBnRHJwTHBycG84Z3lkSno2NkN6WW5qbUlOSkhu?=
 =?utf-8?B?MzN3M0pGVUFheEZjei82TVlXS3VvM0EzTDU1UlU5Ky9hVEQrMk0xL0djaEtQ?=
 =?utf-8?B?SjN6MzNQV085ejY4WUdiVzZoZmFTSVBPT3Q5a2NQNXY4N1l1ZEluMXlKMDBx?=
 =?utf-8?B?ZkxoTy9zTzF0R0ZsN0dKdVArdTJnTUF6L1NHamtNZUhVWmR2SGRJZ1lMWGtP?=
 =?utf-8?B?b0hveE00L3J2NHo3bTNiTldkSVlaYzNKZ0RwVWdNK3AvZnF1bHltQktRTEFi?=
 =?utf-8?B?REdRcWlndGdrOHdFOEVRbHcySWNyNDBtWFVEWEZaeFlTc1lQQTlWeXhSMVAr?=
 =?utf-8?B?ZkozSmRLaDJENUsrUkJRdjRWc0tpcGxNMGJxS0ppV29BZDEyRDhFZk1VWS9W?=
 =?utf-8?B?SUxjUWRTVVNTTmpzK1pOZWZJUjYzMUdzL0hXdTFLdTZmN29td1VZTFVmei9t?=
 =?utf-8?B?UGJCY09RZWROZXc2SzVxTTN5WEd2V1BpdlliYkMwWFk0OHo4S0xTZDlReHF5?=
 =?utf-8?B?Y2pBRit0ZW5SOFIvOHkwVTZKNWJLaUYxczhtckZtQytadkJGMXFONVFJcFIr?=
 =?utf-8?B?UnpMb2FyajNFRlpIUXpBNmhiMU5wdEM3bHhuTXZRN3NLWWRVNWs2VWQvN2hH?=
 =?utf-8?B?RWxCalFBb0ZwRUFNeVlPalQrbG1pYmI1ZCtQUzkvTzJHcXhtdE9ieFlWbW5R?=
 =?utf-8?B?Uk1SQ0FvTCtzODgzZ0RoblFzSUJxMGFidzBFb0NYTmFsKzFEOXAzTFFoOC80?=
 =?utf-8?B?NGo5ZE5tMzlNTnpaM2FVOXZXc0QzVDdOSlNaVjVCNFFzRFppd05Xc05pMEF4?=
 =?utf-8?B?UWovWDJrMlhaMUVEdGlBV0E2eFhFWkwxL0w2czBvbDNWUnA1SDRSV1YrVGJr?=
 =?utf-8?B?TG96M3l5SHMwTUhiOHZLbTMvc2oyaXMwR05wSHJJS3pKM0xmSDdpVmw1SmM2?=
 =?utf-8?B?aFAyM2trcHlyT0FIYTN3NUVVVDVPdEVVcy94Vnpyd0FKdU9XQUduQytIZGYy?=
 =?utf-8?B?SUloZmE4MXVVMXJCN3hQcHB3RXFHOXVoOVhNRndFNzlSWGQvTldMdzNuOHJw?=
 =?utf-8?B?VENFWGUxbW1oUmRDMEdQWW5MN0ptRzMzMkpacFdFRUw4UDh0ZnpjbTI0V1NX?=
 =?utf-8?B?dnhNZE55Z05lSEI2YUZrd1Y2NGFaVHJBWWNLcjAyTzBzZjhFWUdDWGhEMERK?=
 =?utf-8?B?TlJjaTlGaUJoQkdZVklUWWdWMWFsUjc1bmZkTCtET2RobVZqUXBUQmRUaDZX?=
 =?utf-8?B?UmRoaW5EbCtrRnAxaldSczRBdkxtRmt0VHoxOXd5OHlRZUlaT2F0c0g0bUVj?=
 =?utf-8?B?WkkyVXRncUJCWkRzZFBySEVHbDJ0OXYvQnZ6TDRmTGI3SDFpZ0pGU3IrbkhI?=
 =?utf-8?B?dVNmUFFGZS9QL3kra0dTZWFYZmwwdi8zanBqTWZNQkltM2hMV2VNa3BlWW5a?=
 =?utf-8?B?TXk3STJjU0NCR0UvaHlhRkxBSGlIK1VXWWFjMVkwc000VDB0aUIvSzlESk1j?=
 =?utf-8?B?RkhUaWtJeXNkRHdNZkRLMU1aSHJPMnhQTTh0Q1NUWUE3KzVzMmF0UWxTVEY3?=
 =?utf-8?B?V2lFTnYvelBEMGtDWEkvQ1dZZEVKQ0NtSTJsalVpL0YwazRiakVCZmlMZTRx?=
 =?utf-8?B?MjdrK2FwaHZWNjNWZldnY1d0NDYxNUE2R2E4MlN6TzRFMGhVSGQrR0NHV3Q2?=
 =?utf-8?B?eXZMZzVJeituMDNWbGJFVXBUNDhkUlRzaURLTEZBSDBPK3R0bkY2MDZYeElE?=
 =?utf-8?B?cHQxQzVUL01rV3VIWVpTYmhZeFcrUnVkU3A1YUZUS2NGL0V1SXI1NWQ0bWln?=
 =?utf-8?B?Q3NpYzEvTzlhbXZBaFlJSnFVN0F5eVRyRm1zU3VKTGpodi93clFtbVhRdTZk?=
 =?utf-8?B?cG12ait0RkpjTGRGTkNDL3l3ei9yZnlSWUcvYmdFMmUvMlRxeGhEblFRczVS?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9+m/vSl15AufEnf+lsvewMIOdwq5kBEN5+M9wqxF2XbNNMfNpNwQePqfsyZn5hGDX6xXCSI/+g09wioWlUkV1D4GGHl5n5AvwXnnt9Wr/m7tC6kvMHV/5nBjHrNKoVxkoqkYOGj18m7s+4NA5KenJdwW804pjEFgnkrS0x0AGg1XkXthtdG8pDDS7KbtqqUfjAixjx5zbuDPgVBeWZ9A3ZWWMiEzGasfLyfnS8FQcRZFWNQqzUGSv1B0izvJqM8lUyaba1kDkRaiV/zlU9wfPqCttl3ERs2OXzfbB48r8iMqSZBeq5KpHiEB+hAX3hF65gmbqIxg2v0hBSu3AJT60fcBT13Kyi0PzF7/RFFU05bymZmk1ing6CQMrUqaXY30dk9lcde5ErTDxwz8B8iXTDP7tkFjNSv1hmnD8o+0QjB6GrH7Km5+Dd7Baqvw94UzwFVGvuoAasm2nF//c4/3YxTRxjNxjtA7ue2lzyVRZ1x6eXwlOytOvXXsH1XxJXy9Joe+9+kawmOm7PaotCl2zBAa3s+LACbgMHM+Z9fkx/sbaZC8o1I1sK0el77Zx1QDp+WhelM2W834kT6BTdkl3v8l7U//0ajMz8SBQ9R4Js4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7023782e-640b-496d-f771-08dd82a144b2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 19:58:51.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6W8HAemDj04DfaSQdj36v1J9gaSvub3ZS47QjqyC+hHc/tHYbJmxp7HY+EjMM02p0lhmuh6r+B4QR0J8wew7YUSgLVtAO+fWKGMfJ5jsXLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_11,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEzOCBTYWx0ZWRfXwj07KIviF77h 45VUjcTnaUG6Nj4rCipbYI5MVJryFxWVRdrMPPAfidrfRgSiHgtZ6y1XPa1xH7jDbHtQRTxyq30 hL/tlgsZt6STSoMnTldUAjY4xXDOg4vwBpNEJ1K+lH9vYysMcNGQGRIvoSCL41qOLhU/4CYJb95
 RxVzN15wjoxctJthX1pWVQD3T3Ebu3GNwjOml2lz0iJ1IWgh4LTtMGJT8L1/oy2DsRdfND4bOUU X8WG/4eK6yvkhcLioeOXbPdFzSL1vluvVHf7k0qqefEKVnpLGOYzDKN3PkiKHctyRJIEf3TULAP 2BUXcQfu23mCkHdYQqDICdQPmzVPUJ0TwqYN20YtZ/okk95dwloxcpiLLtGVn8zi2JgwfAI1noa ZXY0gzW5
X-Proofpoint-ORIG-GUID: U3aL_NMlP9gGVJRiyj2_B6kF-z9GwMCP
X-Proofpoint-GUID: U3aL_NMlP9gGVJRiyj2_B6kF-z9GwMCP



On 21-04-2025 21:57, Ross Philipson wrote:
> Prior to running the next kernel via kexec, the Secure Launch code
> closes down private SMX resources and does an SEXIT. This allows the
> next kernel to start normally without any issues starting the APs etc.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
[clip]
> +static inline void smx_getsec_sexit(void)
> +{
> +	asm volatile ("getsec\n"
> +		      : : "a" (SMX_X86_GETSEC_SEXIT));
> +}
> +
> +/*
> + * Used during kexec and on reboot paths to finalize the TXT state
> + * and do an SEXIT exiting the DRTM and disabling SMX mode.

'do an SEXIT exiting', sounds awkward. Changed to 'perform an SEXIT to 
exit' for clarity.

> + */
> +void slaunch_finalize(int do_sexit)
> +{
> +	u64 one = TXT_REGVALUE_ONE, val;
> +	void __iomem *config;
> +
> +	if (!slaunch_is_txt_launch())
> +		return;
> +
> +	config = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
> +			 PAGE_SIZE);
> +	if (!config) {
> +		pr_emerg("Error SEXIT failed to ioremap TXT private reqs\n");
> +		return;
> +	}
> +
> +	/* Clear secrets bit for SEXIT */
> +	memcpy_toio(config + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
> +	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
> +
> +	/* Unlock memory configurations */
> +	memcpy_toio(config + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(one));
> +	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
> +
> +	/* Close the TXT private register space */
> +	memcpy_toio(config + TXT_CR_CMD_CLOSE_PRIVATE, &one, sizeof(one));
> +	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
> +
> +	/*
> +	 * Calls to iounmap are not being done because of the state of the
> +	 * system this late in the kexec process. Local IRQs are disabled and
> +	 * iounmap causes a TLB flush which in turn causes a warning. Leaving
> +	 * thse mappings is not an issue since the next kernel is going to

typo thse -> these
"are not being done because of the state of the system" can be 
simplified to "are skipped due to the system state."
"Calls to iounmap are skipped due to the system state this late in the 
kexec process"

> +	 * completely re-setup memory management.
> +	 */
> +
> +	/* Map public registers and do a final read fence */
> +	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
> +			 PAGE_SIZE);
> +	if (!config) {
> +		pr_emerg("Error SEXIT failed to ioremap TXT public reqs\n");

reqs or regs ?
Assuming you meant registers (regs), not requests (reqs)

> +		return;
> +	}
> +
> +	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
> +
> +	pr_emerg("TXT clear secrets bit and unlock memory complete.\n");
> +
> +	if (!do_sexit)
> +		return;
> +
> +	if (smp_processor_id() != 0)
> +		panic("Error TXT SEXIT must be called on CPU 0\n");

Prefixing with "TXT:"
'Error' is redundant — panic() itself implies a fatal error.
we can use panic("TXT: SEXIT must be called on CPU 0\n");

> +
> +	/* In case SMX mode was disabled, enable it for SEXIT */
> +	cr4_set_bits(X86_CR4_SMXE);
> +
> +	/* Do the SEXIT SMX operation */
> +	smx_getsec_sexit();
> +

Thanks,
Alok

