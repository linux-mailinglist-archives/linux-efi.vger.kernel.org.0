Return-Path: <linux-efi+bounces-1127-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2188FBA40
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 19:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48A32865BD
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED7114900F;
	Tue,  4 Jun 2024 17:25:17 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF613E03D;
	Tue,  4 Jun 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521917; cv=fail; b=Cg9bvirXjYrR7S9y1jaWLfKpVdXOqkMyDk0aoF3iST5weHH48ymX3rOJ+6uIDa+Z8tVHyCcYJ7tZmWCwgU1Ylbj9fog45zkpGtbKlGsSLFs2Ivql0pl0jGhwGW1DfZjsCGu1YUXFbSL3WcA/dZ7VnwOBQNXzJnSYN1ww6s5TP2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521917; c=relaxed/simple;
	bh=uKPpYuj0YPFY67XAIpX4nyRUaKU7DuiwUU1tQuTmfPk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oiYYaAM8WfUKk1nr+2s7w0u2jDq2CIouZfDMoTc4iu+gkASqHmcHL6P1w3HZLLfFfiCUkycpoxeWRssky7arZtiqE6xpK1BNQ5SHoXbgrZ6hikPvMU/dTxsl9nIj4WwiSnbc45LylpdyLj9JRguwuROxIDNeb9AUgvcO0KnKouE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Bnwxf024630;
	Tue, 4 Jun 2024 17:24:15 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Dgp5uZXPUAQZjzOcnsfdxvO+lBGYGchQRwtQ4EuoJHuY=3D;_b?=
 =?UTF-8?Q?=3DhVRtKuHgOvGA7zu94F1/Mdxu8KMK5C0kkIYbGtNuvWE1xuVRh4EEapnyTeqN?=
 =?UTF-8?Q?KWsK0xVx_hjjUO+lTzyfoWOWm4BgmrnA3x9JxQSAekWXO2wW5pjg0LEAWvcpu0z?=
 =?UTF-8?Q?46OunLjwoWtYlj_bSj0+77SMSBwhMsfWP6nsj0DqGZ/ta/+xZU/neU5inE3bcST?=
 =?UTF-8?Q?+pODY9ZEbeyfQhigrD8Y_MctWVl4MOJaffDXzKooK2pV0xlkuunWXDBGid3Tdyt?=
 =?UTF-8?Q?uMp0t0WP+SFoxOGClgW2QG9euX_Sztk2MfasLlInvzVCfKY+bEhETNUQ/vubO7D?=
 =?UTF-8?Q?HGELbHrCeVUrsrV8BQY7DZrIOdWi4jtP_aA=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv3nwgq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:24:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454G802e016141;
	Tue, 4 Jun 2024 17:24:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsaed54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLjyeZFP6C90CZsIvDCgsCwseaFjz8UhW3/NqRMPUdY5+BN5nqI8rTGc785SetWgB+LAV1IRizKKUJme91Grh+6WgVezrGFAvQPrFxRgLNhymnPek3dvZAFe38E/EbeRrP/KOiZlotpU2S5parnNlycN81lH1HweyxlOOE/f56Oq7ZHp6Ho7reWAGHWNisjgc31utMdKwTGHIXGHfVO8xFNJGK0m9IiCSwsPmVvj8qeoMby8URh6TrKC9dwp8P0EvagGra78ROso8rMfTOjN0liy/2azoALl9iRhnigUHm4rRnGu9knBWJI5rwG/PoGduHOl+VEP7fCfHrU9hdq2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp5uZXPUAQZjzOcnsfdxvO+lBGYGchQRwtQ4EuoJHuY=;
 b=YmN2CQic/7T1qvEfcSHce44uojYJeywKxz+vkKa4a7uakQXL/LwaeHJfYMRPSIHKlKUpOmXHX9TTVtnQERzp0JpIjYbg2wp0x2DBc6sDpQyA9HOODDxkc/2usZ1OeciFMQa6Tt3vKnbx0jzKmymDO6z6iVG6YDlIiutnMdkF7cqkEQ6KzDCUDwTiofLXL96+nxiM4bwGtCbIQmLblVR8yVs6FeeNy8CsX68i6HoYdZtI7OpX1Mam2M/B5N3EgPe3oDQM1Mdu968ygBKmIHorFFqDfULuftQZ42KMSA5a4M+eDK6zPR22Fk+MSD1T+c4RBY64+0LhQpcPi29JGjIUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp5uZXPUAQZjzOcnsfdxvO+lBGYGchQRwtQ4EuoJHuY=;
 b=tiA2aeYhbycitTKUr8gDOYL3fWF4Rlz6WvSvdf7TrD5145yzbSO2Nrr6nXXGCBf9+nPEH6tp9L3xrRMAtnmZW1ez/0xJ+6tSZkyo254YoLc9uRm5Feukm+9zw3Ojec5k1N1tq/ux0OO2Mdd0GmcX3FXhropmxU/Fp1O7ffhfMuc=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DS0PR10MB7363.namprd10.prod.outlook.com (2603:10b6:8:fd::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.26; Tue, 4 Jun 2024 17:24:10 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:24:10 +0000
Message-ID: <5bffa507-75e8-4cce-ac0c-fe13d6efd3bb@oracle.com>
Date: Tue, 4 Jun 2024 10:24:06 -0700
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
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CAMj1kXHcYOPTLTh-hEtfHk+JaORGK+fEatTT+UOqLJww+_cNTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DS0PR10MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 628e4475-78fe-40e0-6fb3-08dc84bb2591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VDdxTStVaTliOTFZNWpabFRGZU1EaXhXa0U0elVqZ00wT1RxWHpGOFhYL040?=
 =?utf-8?B?QnB5ckxTYkRXZkhmNW9JY1J4elgxS3k2MGhoVGs0Y1REY29YcXk2VTlkbnpm?=
 =?utf-8?B?YU5zc2x0d3I5aHFRREt3M3VCbExTNmZoQURBSXI2Q0g4eUoycjRhNjJ0OXRu?=
 =?utf-8?B?QkNKYjdBWi90S2JOaTRBdHFyOWc2OEQ5aDhBR3dOL1lFaW50N2huY1o5L1E1?=
 =?utf-8?B?TlVYRW9EcXVHODlxYlJwTFZXckpQODJaaG5hMG1LOTYyVFdRUy9RakJNNjZu?=
 =?utf-8?B?cmdZS0ZhWi82OXV5djlIZ1MyZk4xSUNETWw5RHhQbngyZEg0MkJmNVg3QUVv?=
 =?utf-8?B?c08xcmlnS20vYVM2cU9PYWpmQUxRaUNHN3NRSis4YmhKYTJxNzdqWmlDcWtz?=
 =?utf-8?B?cUhzMzhQbnB3aERUQ2JkMksrbU0zdnBDTm5nSjVmSEtQZjlHR0VQaDZSMVB2?=
 =?utf-8?B?LzRHRXFBa1lCdmlEeDZBeFgvU1Y2RVJpYVBnbFFveDI1RGVPMzU4SFpJemxw?=
 =?utf-8?B?dGRKQ1pvcXNsODQ2TFU3M2NVZGN5M0ptOTlDTEUvdzNBd2psQjg4dEtSd3Fr?=
 =?utf-8?B?WG1sNmdvUUw2L04vMmpUT2tmWmhHNzVLckV5SUZKR0RJQzFabUh2YnZaTmF5?=
 =?utf-8?B?czh2THd6WjNUSmRzSXkwVVFMTHV4NVJFU2w5R2pkYmV0Tlc3YmtNU1ovTnhp?=
 =?utf-8?B?dXE1YWtjSy8xczNGSFltSkdxeG5raGtnRXlwYWdZQWhobUR2dTV4VFlxVXo5?=
 =?utf-8?B?b0Q4V3d0NjhLNkR0QlFtV1VDcG03L1ViZW5hTkgrS0tkS3ZNSUdiVVVXV0FE?=
 =?utf-8?B?RFVRVXU3Z3V3UWhuVkRuT2pxN0lQd3ZjSGQrVTF2WTREZkxZOThpclVKYUhp?=
 =?utf-8?B?ZCtNSUNPbEV6d1hLdFZqRG9IWjBTYlVoRkcvbzMwSGN5WjlYa2h2aWNwSXU1?=
 =?utf-8?B?Z3FQaWw3Z1pPa0NLaWRPZXpCRzZIak5iaGorcFdUOEs1MDEydzh3c3RQMlds?=
 =?utf-8?B?VUI5ZVRUUEMwcndtemdmZVF3QkJDODljMnRPMWVkZWRUSHlRajZqL1U2S2k2?=
 =?utf-8?B?M2h0NlpGWS9saEFlUEI3ZHVodzZ2ZjRaeFZtbFNaRlh1N3QxK04xQ2tMbEJl?=
 =?utf-8?B?TXdjODVoUE5icnVidUxOMGZPM00zRU1YY2tITkhCWWhuYUlrYlh5OUlQWUda?=
 =?utf-8?B?cUFrNVRYNkxIV0hKWjR5bFNOUW1zYk8zNjVtVXBocmt5VHZ1RzBUOVdtdjR0?=
 =?utf-8?B?UHUyTG9wb1hnWWRFVmRxbzZQbGdpcXQ3Q0pNQUowV2VLRGtreGNCTmw0ZWl1?=
 =?utf-8?B?KzJIRXpVd0szTGtSczZ5Qi9wcnpya1FNNXd0eHJ1OWI5RE8xMm5DYWVvMEQx?=
 =?utf-8?B?ZnZjSVNKSk95UUh1em5HNkhUZkk0NzNodVFUSjlGcmFVMm1XNlhPMUMwL1hN?=
 =?utf-8?B?SVpoNCtGNXpSckNhZitmSTk2OTAvRVlTcWJ3SG8xVkhZMUtPTW9TcUVBN3dl?=
 =?utf-8?B?NHVpTzlLc0JTSkphSXpzRXRSalk0ak5XRzgrTGczQitQcnFQZGVYT1dST0ZL?=
 =?utf-8?B?aFlZV2JNS2JDQXFZMy9nVElSeS80TWZ3MlJVTzdCaGRwRXZJQjNLUW5GR013?=
 =?utf-8?B?VGlQZnZVQ1Y0bWhKZDJvNTh0dzN4NjJkUzJadlNiWCtFdnFmMzRiamREK2Rs?=
 =?utf-8?B?eWp4Nzg2dEthSGYwd0VXWUJ4YU55VVpoUFdyZ3hTc1hTZFRZM0Q0K29nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SS8vNDA0WEc1NnpDbTZjQ1F5QUlWVVJueXpDQWhmd3RheCtGZS9aWUxjWW81?=
 =?utf-8?B?MHo2M0liSGM3bDBFL1l3N3dVdDgxaDlNb21HMkZWdWthT2lQWXVkVkxYaXJh?=
 =?utf-8?B?TFZmTkZrM0dkUVpUYWF6cG9VcnhNNFpGSmhHeStRZm4yRWNJOXRHYzEvL0Nm?=
 =?utf-8?B?dWNBZlpOWEZzWGd4eUhwWEFvWWQ2WUhtTG9iRTV0M0FneXZlbitGdXRaWjM2?=
 =?utf-8?B?eW9LaklBK0drMnY0bDVXemV2dHduZ3lzNFBvck9nQjkwVXlJNjErY3cwUHRL?=
 =?utf-8?B?S3lPL0JRT0Q1UHZscEZqcFFEYnlTeVdzRlVNZTJ0TnRVL3cwNDY4R2NYeUkw?=
 =?utf-8?B?YVU5NUYvdkg3TFdYNTVEL0I5NHlxaXhMUmVoSWNaai9QbDhPbWUvZGgzbzlv?=
 =?utf-8?B?RnYyNE5BNVVzRjdwZ1hZenRydGxoUmMvamJzVWorbURzNXpFU2RVcGwwU1Nv?=
 =?utf-8?B?amxWN3liNGRYM0F2bW5DUU5HYVV6dlNFUTZNU25oRU5pSnNNRXN0RDNZMTZn?=
 =?utf-8?B?TXB2VUN0dmVBTGxIOG12UHlDRkhPSjYzUXdkSDdjZjlnclFxeWtIMFl6QVNx?=
 =?utf-8?B?NVNRMWVnSzdiUDluR2VESXRyWUJOOHNpdFBuSThVTmZCWjlOU2ZPbU1oTlpL?=
 =?utf-8?B?VFRvVjM5dFRyWXIreFRVRHRPQ001citrMlA1ckZYdlVxbnhsZmNwL01weTBE?=
 =?utf-8?B?WEt6WEFQd3VNYVBTaXFzYytsMkxoLzE4dkd1WkdSZDloV3hLMTVuTHk3R2Iw?=
 =?utf-8?B?Z29mVjVZajNnODg1WmtIU3d4anNHOGljbmsyUzJQWW1GRnJWazZ3VnQ3UUNW?=
 =?utf-8?B?dC9sZjVHWk5MRnpVOEVkQ2luTG94SG4yWFY3VXlQNzdhT0JTUmpuNGlKTWpF?=
 =?utf-8?B?RnRsaytMKzQ0TnpRVGFsMllkUnh3eVI3d0NGNUJVMlZ0Q0RkeFJTNVRtK2Fv?=
 =?utf-8?B?ZHh3ZnA5M1BJUFQ4ZmEyQzhjZ3RwNndVV3ZGaDUzdms2VExuYVR2L0Jzd0FY?=
 =?utf-8?B?QVFaOGpsb0FxSFgvZ3BFdS9Yc2V6QmxEeTZhVWdSMjhqd3kzbGdjczRmZFBZ?=
 =?utf-8?B?bmRuVEhxQVRHL3VuKzk0RFhUNHhPZC83TGx1SFdNQ0lYVUI5Rk1Fdk45aS9w?=
 =?utf-8?B?d1Q4WldUckdNVHh2VmhOMmp4RVNSK2FwcExYelpHcFVEV2xPS1VnV2E0MzRr?=
 =?utf-8?B?Zm01amNWelI2WjQxTW9xOXkwSytjYUthNFJBU1FoaThhOTRwUzBpK3E2QVVK?=
 =?utf-8?B?ODhlS0xoOWhFZ3ZZQ0tGV0NVdnVWOS9GbkJralNSYXZhdEpTZ3pIaE9ZekRv?=
 =?utf-8?B?WE1pM2pWUVdLNFVsT1VZNkt4L2pBU1M0S2txWCtZb280cEVWTnFtYjB2d3gv?=
 =?utf-8?B?N2JjY3pHYWdXR0EyWjJSSEgvU1IvRUZ3VkxTanE5QWN2TDNrS25nOUZFU0ky?=
 =?utf-8?B?WmVEd2t6YVpaZzJMVzRTMEN2MW02ZXdMTVVHOGQ0UmdrSEhUcG85T25yd3k5?=
 =?utf-8?B?ZkxQTW44ZFc0aEVnM3Z3YXBXVWw0dytZT1c4bWpWSjVZZm1nTCtXTUVZRjVF?=
 =?utf-8?B?WVl2UlMxeGNiRW5kelBxZFJUNEZjRnFqUmhtQUUxbFV1V0J6aFB6dTNDcW1X?=
 =?utf-8?B?T0tJVTROT2UvdittZEJGV01ycUgyOEY5Z1dDdXJOZUtJeXM0QmZzMDdjSEpu?=
 =?utf-8?B?Y2UxREFXTnVmNUdTN3BIYTFIbC9URDhnbVNkaVBOMTZHR01rejBtZWgydmkr?=
 =?utf-8?B?SndzYW9RL1c5UUpxdmxnd1E4OWk4NEhEZjlWVWVraDc3YW5Zc1hIcG5Qa2NC?=
 =?utf-8?B?eTdnWEdLTVpxOXN4RUxJa3o2ZjBJM3Fla2dFeDl1cmxNR1RlbzRYeER6S2JD?=
 =?utf-8?B?OHFiSXRsZ05qeDFnUUhTK2dnTWhkd2dZaDk2QXJ4VGNXQndmWGh3Mjgwd0NF?=
 =?utf-8?B?ajRJRWJ4V0pFMm41TW5MaEZMaDR0TGM3VUtBOGxlYXdjallhYU1CRFZ3Mk5o?=
 =?utf-8?B?b05iRWEwdGZSYXRERS91Q1pvekFOTEtNQmlkbUhmYzhxYWVyeWVVekl5ZWVF?=
 =?utf-8?B?ZGpDRHRvNEVJdlRMWDBENkpwT1hBdWZqc280dVowY2YzQ2lvblpRdmIybFZ1?=
 =?utf-8?B?QXlyTnluKzdrdnZKaFZuMHIvS25yU0xmTit5NW1CU1ltOXJuSll5RFlFTXF6?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XNhF29g3HWsG8wLAZOI2owQ46Y7UdQeq1e2xiHksV+3KcIQV6YFh9bKJpv8e/dbG4qyPXQECiXSlhoGaPCRHpreNuMIJQu2aWrLkkoT0gYRC52KQSuCRo3yl2lxeR1LFHmnuE2xxkjRM1RFOFFZq45C0re458kNg/US0b/T2XA0KJTBWBhZWGvHiWETAjuqxCeCyNyy9L94YIRLAJD6wAMtnJ3hIS8wbWR6M9OwBW/GxzuNeRdkrOy6LMq0fquY7mYQCiuIMXcOQDenozulUG94/V/lZWbTE8MXfRmXIJgNgOedpKNvsq9DXlU9awBj461BNC0UPHl2h31RLdMDtLGF6Ubn9l4z2gl0LLOm18xY3iREiqg4Ruqs57jNRjhnYqnNPXLnUmtLIAToIS1KlKxNIWnHwoZVq3QKIq35Kz0HsdZ607/lzug2m+m1yvF7IavtY+cQ4ydrMDgThgFKC/JkuoUetDazmTtBxxjgDy6a+mi0AGc6iLzPS7QBEN7KLsZP6nO4ZiuvUOYTs+xgNhuIqVo7zdJZcpUuyRUVmanwgo6/BuPwE+hGRUNFCo0/tQBjDcLtzEo/Wc+D1xTcZk5qGUCuYUv3K/Uq0Nqzt5Uc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628e4475-78fe-40e0-6fb3-08dc84bb2591
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:24:10.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frTrel5q8js5WS1qIVR191iUj13haKGvIGM1p50FRK78ytOphOkVektfGItUuKI55Q4j3GJeI1UrzYaNCMCFltQfSMFdKtvyUjmYRSl60sE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040139
X-Proofpoint-ORIG-GUID: WlogrfIohrhNb_VKaH4qAMvfRJdqTfqe
X-Proofpoint-GUID: WlogrfIohrhNb_VKaH4qAMvfRJdqTfqe

On 5/31/24 6:33 AM, Ard Biesheuvel wrote:
> On Fri, 31 May 2024 at 13:00, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> Hello Ross,
>>
>> On Fri, 31 May 2024 at 03:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>>>
>>> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
>>> later AMD SKINIT) to vector to during the late launch. The symbol
>>> sl_stub_entry is that entry point and its offset into the kernel is
>>> conveyed to the launching code using the MLE (Measured Launch
>>> Environment) header in the structure named mle_header. The offset of the
>>> MLE header is set in the kernel_info. The routine sl_stub contains the
>>> very early late launch setup code responsible for setting up the basic
>>> environment to allow the normal kernel startup_32 code to proceed. It is
>>> also responsible for properly waking and handling the APs on Intel
>>> platforms. The routine sl_main which runs after entering 64b mode is
>>> responsible for measuring configuration and module information before
>>> it is used like the boot params, the kernel command line, the TXT heap,
>>> an external initramfs, etc.
>>>
>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>> ---
>>>   Documentation/arch/x86/boot.rst        |  21 +
>>>   arch/x86/boot/compressed/Makefile      |   3 +-
>>>   arch/x86/boot/compressed/head_64.S     |  30 +
>>>   arch/x86/boot/compressed/kernel_info.S |  34 ++
>>>   arch/x86/boot/compressed/sl_main.c     | 577 ++++++++++++++++++++
>>>   arch/x86/boot/compressed/sl_stub.S     | 725 +++++++++++++++++++++++++
>>>   arch/x86/include/asm/msr-index.h       |   5 +
>>>   arch/x86/include/uapi/asm/bootparam.h  |   1 +
>>>   arch/x86/kernel/asm-offsets.c          |  20 +
>>>   9 files changed, 1415 insertions(+), 1 deletion(-)
>>>   create mode 100644 arch/x86/boot/compressed/sl_main.c
>>>   create mode 100644 arch/x86/boot/compressed/sl_stub.S
>>>
>>> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
>>> index 4fd492cb4970..295cdf9bcbdb 100644
>>> --- a/Documentation/arch/x86/boot.rst
>>> +++ b/Documentation/arch/x86/boot.rst
>>> @@ -482,6 +482,14 @@ Protocol:  2.00+
>>>              - If 1, KASLR enabled.
>>>              - If 0, KASLR disabled.
>>>
>>> +  Bit 2 (kernel internal): SLAUNCH_FLAG
>>> +
>>> +       - Used internally by the setup kernel to communicate
>>> +         Secure Launch status to kernel proper.
>>> +
>>> +           - If 1, Secure Launch enabled.
>>> +           - If 0, Secure Launch disabled.
>>> +
>>>     Bit 5 (write): QUIET_FLAG
>>>
>>>          - If 0, print early messages.
>>> @@ -1028,6 +1036,19 @@ Offset/size:     0x000c/4
>>>
>>>     This field contains maximal allowed type for setup_data and setup_indirect structs.
>>>
>>> +============   =================
>>> +Field name:    mle_header_offset
>>> +Offset/size:   0x0010/4
>>> +============   =================
>>> +
>>> +  This field contains the offset to the Secure Launch Measured Launch Environment
>>> +  (MLE) header. This offset is used to locate information needed during a secure
>>> +  late launch using Intel TXT. If the offset is zero, the kernel does not have
>>> +  Secure Launch capabilities. The MLE entry point is called from TXT on the BSP
>>> +  following a success measured launch. The specific state of the processors is
>>> +  outlined in the TXT Software Development Guide, the latest can be found here:
>>> +  https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf__;!!ACWV5N9M2RV99hQ!Mng0gnPhOYZ8D02t1rYwQfY6U3uWaypJyd1T2rsWz3QNHr9GhIZ9ANB_-cgPExxX0e0KmCpda-3VX8Fj$
>>> +
>>>
>>
>> Could we just repaint this field as the offset relative to the start
>> of kernel_info rather than relative to the start of the image? That
>> way, there is no need for patch #1, and given that the consumer of
>> this field accesses it via kernel_info, I wouldn't expect any issues
>> in applying this offset to obtain the actual address.
>>
>>
>>>   The Image Checksum
>>>   ==================
>>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>>> index 9189a0e28686..9076a248d4b4 100644
>>> --- a/arch/x86/boot/compressed/Makefile
>>> +++ b/arch/x86/boot/compressed/Makefile
>>> @@ -118,7 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>>>   vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>>>   vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>>>
>>> -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
>>> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o \
>>> +       $(obj)/sl_main.o $(obj)/sl_stub.o
>>>
>>>   $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>>>          $(call if_changed,ld)
>>> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
>>> index 1dcb794c5479..803c9e2e6d85 100644
>>> --- a/arch/x86/boot/compressed/head_64.S
>>> +++ b/arch/x86/boot/compressed/head_64.S
>>> @@ -420,6 +420,13 @@ SYM_CODE_START(startup_64)
>>>          pushq   $0
>>>          popfq
>>>
>>> +#ifdef CONFIG_SECURE_LAUNCH
>>> +       /* Ensure the relocation region is coverd by a PMR */
>>
>> covered
>>
>>> +       movq    %rbx, %rdi
>>> +       movl    $(_bss - startup_32), %esi
>>> +       callq   sl_check_region
>>> +#endif
>>> +
>>>   /*
>>>    * Copy the compressed kernel to the end of our buffer
>>>    * where decompression in place becomes safe.
>>> @@ -462,6 +469,29 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>>>          shrq    $3, %rcx
>>>          rep     stosq
>>>
>>> +#ifdef CONFIG_SECURE_LAUNCH
>>> +       /*
>>> +        * Have to do the final early sl stub work in 64b area.
>>> +        *
>>> +        * *********** NOTE ***********
>>> +        *
>>> +        * Several boot params get used before we get a chance to measure
>>> +        * them in this call. This is a known issue and we currently don't
>>> +        * have a solution. The scratch field doesn't matter. There is no
>>> +        * obvious way to do anything about the use of kernel_alignment or
>>> +        * init_size though these seem low risk with all the PMR and overlap
>>> +        * checks in place.
>>> +        */
>>> +       movq    %r15, %rdi
>>> +       callq   sl_main
>>> +
>>> +       /* Ensure the decompression location is covered by a PMR */
>>> +       movq    %rbp, %rdi
>>> +       movq    output_len(%rip), %rsi
>>> +       callq   sl_check_region
>>> +#endif
>>> +
>>> +       pushq   %rsi
>>
>> This looks like a rebase error.
>>
>>>          call    load_stage2_idt
>>>
>>>          /* Pass boot_params to initialize_identity_maps() */
>>> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
>>> index c18f07181dd5..e199b87764e9 100644
>>> --- a/arch/x86/boot/compressed/kernel_info.S
>>> +++ b/arch/x86/boot/compressed/kernel_info.S
>>> @@ -28,6 +28,40 @@ SYM_DATA_START(kernel_info)
>>>          /* Maximal allowed type for setup_data and setup_indirect structs. */
>>>          .long   SETUP_TYPE_MAX
>>>
>>> +       /* Offset to the MLE header structure */
>>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>>> +       .long   rva(mle_header)
>>
>> ... so this could just be mle_header - kernel_info, and the consumer
>> can do the math instead.
>>
>>> +#else
>>> +       .long   0
>>> +#endif
>>> +
>>>   kernel_info_var_len_data:
>>>          /* Empty for time being... */
>>>   SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
>>> +
>>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>>> +       /*
>>> +        * The MLE Header per the TXT Specification, section 2.1
>>> +        * MLE capabilities, see table 4. Capabilities set:
>>> +        * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
>>> +        * bit 1: Support for RLP wakeup using MONITOR address
>>> +        * bit 2: The ECX register will contain the pointer to the MLE page table
>>> +        * bit 5: TPM 1.2 family: Details/authorities PCR usage support
>>> +        * bit 9: Supported format of TPM 2.0 event log - TCG compliant
>>> +        */
>>> +SYM_DATA_START(mle_header)
>>> +       .long   0x9082ac5a  /* UUID0 */
>>> +       .long   0x74a7476f  /* UUID1 */
>>> +       .long   0xa2555c0f  /* UUID2 */
>>> +       .long   0x42b651cb  /* UUID3 */
>>> +       .long   0x00000034  /* MLE header size */
>>> +       .long   0x00020002  /* MLE version 2.2 */
>>> +       .long   rva(sl_stub_entry) /* Linear entry point of MLE (virt. address) */
>>
>> and these should perhaps be relative to mle_header?
>>
>>> +       .long   0x00000000  /* First valid page of MLE */
>>> +       .long   0x00000000  /* Offset within binary of first byte of MLE */
>>> +       .long   rva(_edata) /* Offset within binary of last byte + 1 of MLE */
>>
>> and here
>>
> 
> Ugh never mind - these are specified externally.

Can you clarify your follow on comment here?

Thank you,
Ross


