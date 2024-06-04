Return-Path: <linux-efi+bounces-1147-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCDA8FBD5A
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C238283D38
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E96C149009;
	Tue,  4 Jun 2024 20:32:48 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAFB29401;
	Tue,  4 Jun 2024 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533168; cv=fail; b=j3re3LcADMUXFAOnEqImkQz9CQvtKGEw3JT84IPnTUARGL/zMsVuZ6cxJRDwmbvwoeiGg2HY/ftXSkhqObvkzwlOQyVi0yVgPpihwsgqGwfLodF0/4L27Iq76sci199BDVk9rQOB96Yj2yzYPdChZGDOy/jCuoi6m8Sw4gngxuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533168; c=relaxed/simple;
	bh=Blos8yUpE7ut3ANSYjz4G45UZ39SZga/3ack9QB5SrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ffsAyAVz2fI6GQmZStc/K7d+iUtaYhha+2kEdNDcbPwRWlhI7FpwrBdsXEWEa3TvTDwbiJYALGrqksg4NJGgHWrWOftaDmufy0N9jTz2wf2rGjhsYn0/U/c4uF1yoUllG5zuXin6xXWBvOTnfal/4HNps6amgCXDw8liyMozdzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454JCq19032521;
	Tue, 4 Jun 2024 20:32:02 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D6GdCI4yLWoyLvGTN/2Xka3HnrJReA15gkFufTvwsaq4=3D;_b?=
 =?UTF-8?Q?=3DL+evJym/mT2azMngPNL0AXhKOWAJuSqgmuLakaw5oeBjpe/HqQCDJv2dg+fr?=
 =?UTF-8?Q?PeJBAmpO_sxGeEuQrcaBAYyRZcXuciCTncvHWNW9aIRkNUippPTxEhYcg0WYImb?=
 =?UTF-8?Q?fYCaNH7V/IlAeP_RryvV0O+5EUckDGJYveUW4NG+960LDB8n717/bV9FUMOgEdq?=
 =?UTF-8?Q?XySrJ1js85miEjFSaBR1_2VL0nu4URuW2N/niBgHI9C1XXTwE1orxJrk+md1qrJ?=
 =?UTF-8?Q?Q4gMwFjmcaJpIb6fVHDic1NxuW_gbTzTPu+0ua8FjO657o9r3Z1T7KjkkdApuUE?=
 =?UTF-8?Q?SV1yDFR/0rty4jSKNlI0mNdFKWJwMQKF_uA=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv6u5vr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 20:32:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454JNd57005458;
	Tue, 4 Jun 2024 20:32:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrme3d9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 20:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvPDhZlbTP4YKigC7Fw1iXlMrvw+cLWcdSk0PCqVaVoJ4ahUiIkwKkGYWe75NzN2sg4JLmavG5e0HjfycIkEDBwyriSijvlsJI5Vnh6Zp0w52RMxgvE4PvTjRTZM2TkdcYyYdoKo1Xql864VVFTB9haChkmMQPvRvYSMwU+xRKNgIuu5Mi0STLbGeLRj53Suj1VAF56NfRHDG7OSrDA7Le/zmMRfxnO9np1RzQj4BGfCZ/fv4rRxgkhH39SacPy/TBBWXhiwsUGOMB4Q20Z34jnS5pMv08jUfpFDPCttc0Pn8sXb6sGWMMzxW1TqhYK5YWmWvUCrfpjBce+GJwCD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GdCI4yLWoyLvGTN/2Xka3HnrJReA15gkFufTvwsaq4=;
 b=Ctoa8dBurKNtbiChkAOt42g2A90MU3pmNsm9LatEOFbCsZZyyrx5g9sPETXZyLxE87sriXl/akfcofrCGT9/igH4T3nPQW8L/V5k7Gj1ZgGcR1Ao+pAqAdW5+OxGRlTZiS1AJneVWTQKDdYYv4RZeKExFJmXUwEK4ncRW3aEzohgugJmyBKasNguCTc9n08e/kObAXYH9kPWTtjndo04mcE2UbAd21iQeFpD+Qlr3oWjaF/Pa7VP2MuWHEE7up7JTdlUnD+y4CtPH21AAp8o1FQDojZLLswlnv0pe23UiFLFsHwSuBKoZ9dErWu4S5tQfRWTdjH02zQBa9nLXB6ezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GdCI4yLWoyLvGTN/2Xka3HnrJReA15gkFufTvwsaq4=;
 b=wUscOoqaZltTJW2MnYWuRKZIGTVxEa53u/0Xfrn1t7obTyhTQlPGs1qmoO0zhwcbt2prGpahbQwNDjcn+S74Z5hM0tqMCDKvJNVFYbfZUSxoILsDAyenQIKIlkrvfH0oNWfyQclO+QaBkNPTCNhxZrI9hIpRhX53nshpWGbh24U=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CH3PR10MB7259.namprd10.prod.outlook.com (2603:10b6:610:12a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 20:31:58 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 20:31:57 +0000
Message-ID: <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
Date: Tue, 4 Jun 2024 13:31:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/19] x86: Secure Launch Resource Table header file
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::12) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CH3PR10MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: a68af263-084d-47e3-ee57-08dc84d5616f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aGtNb1RLU3QreTF1Y1RDaElEUnNMTU5DeDhuTmtnRXFOTzVJRVFlRUlXUzdK?=
 =?utf-8?B?eXAxSlJ2TlFKWmh3YWgyK0VlVjJUNzNWZ2hWTldnek9vRUFLV0poTGVEd05W?=
 =?utf-8?B?MmFZbFJyS08vVUZQWWc1Q0svb2x4VEJUQWJPRWcvbG01NG9UeTgyYnZjM3RI?=
 =?utf-8?B?UE9GOTRLeWhPSUpuaFhPaXptV0dFZXYreVFhRUZOK1RYQ1VjbXMwQ3g3NVdp?=
 =?utf-8?B?cGZGaURhSjJxV1JOVjExWE5LeE1GdkFuazNzSEl6ZW1PbVBVcE5aMFZPbXQ3?=
 =?utf-8?B?NWJLWnh6bnJrS2xZbmFaTGsxVHVRb05FTHVndE1FZFBRNDM5amx3bE01c3py?=
 =?utf-8?B?dkdVSWZPNXFyZEVoVVNIcmtucFl6dXFzRXBOeGE0QTlybURabVNic1IzUUV5?=
 =?utf-8?B?VGpKUGVSMGRtWUg4RmtjUGFtdTg3SUlBaUZSYk9NbHRNRkIwZEVIQWhnNDBR?=
 =?utf-8?B?RHZaNGNsKzBqM3V2eUloNVZPOTl1ZVdvSzUzL1YyZHB2Sk9neGJiWG5iVy95?=
 =?utf-8?B?QTA4WUthYVhiYVp1YUkzU0JldWZaS2VRUHVZaGdXMUlkcnFKczlrWEtyTFZ0?=
 =?utf-8?B?QlJLRjBNVWt0Q28zS1VxNENjSmw2Q0VDQ2RaekpNc2J2cHI1V1g2emttTy9I?=
 =?utf-8?B?Q1JmLzlORU0vVS9vSUdVbENTTHVPQjVqOWs1RHBrRWF6bjdTL0t4bmZ1OTZP?=
 =?utf-8?B?RURsSTRqdmo1MFRDSVlGQ2VFUlZFWFluSjJTRlRjUkdJMXNTR3lOSFVOenZJ?=
 =?utf-8?B?Q2JPVDRINWNBblZxMWNKMmx2OUZ4TWpIWTRXTEFML2JCRU5XZTRLNWdVMmxv?=
 =?utf-8?B?ZFhIRjlYTC9NS3pKYzB4VTNjL2QxVHZJaW9jRlF2ZXloNFhpWC9TdE03RzQ0?=
 =?utf-8?B?TTZnSUFwQTFLY3A0YUMyUmpBWnhIRDhqR3BSczd0UlN5clBPRmdUUGxJM0Va?=
 =?utf-8?B?ZUJPYkNKUnBJOFlSVHozSmRBNjNnbmgwUGNnVGEwR0ZmUUcxRm42ZnhlYkZH?=
 =?utf-8?B?aitYcDJ2ZzRMMWt5K2FEMTVyNGFKdW81UmVtY1NUNEhpdnFhUEY2NTExRGMr?=
 =?utf-8?B?Rmcva24xTzhUNVNOTmhYVjlFV2t4SnNZa25DaHRvV2g1OHJIekhHVjF4UFdu?=
 =?utf-8?B?NnhJeGZhaThkd3dnY2NRc1RtUTkvUDlIdXVvc1VzNkNLSDRaWlFRMkF3UU42?=
 =?utf-8?B?TjVWNWNCd3hlZ29RMGlTMDFyU0lCbGpMczFQUUFiOW5Ndmx6V21Qa3NWbmsv?=
 =?utf-8?B?QzVuVXJGdDJ3T2tBMG1zQlBWL1FQWjhURk5RY3Zwdmp0bVdKTVlNekJsUlZv?=
 =?utf-8?B?eUY4N0dZcXhkekIxUE8wNDdoeFVOT3ZESldTL3NuWjVwK2hxaFV6MXNwMHZS?=
 =?utf-8?B?SjAyWG9UVkZkSnZLOGkrQXkxOG9vUlhzbFFYT3htd2dBTElFZU1KbFp1aHRk?=
 =?utf-8?B?T0pnVDgrWnFraFRLK2xvYzFnN3Y4U3FianJmeWJaOXRRbjZoeGxKdVJyYmV4?=
 =?utf-8?B?Z2Z3RXE5Vm01bG9taEgySzc0M2Naa0RWcVYxTDcyUWhkNk1OcDNza3daTW5y?=
 =?utf-8?B?a0xVV2czdU92aTExSjd3VjlaVnlvcVBPZTQxSkhtM1R3SEpObUtMSFZVQkJT?=
 =?utf-8?B?UFM1ZFo3eG1VTEtWSDNLRTd4dHBRbFYyaVdON25CME4raDBSa3ZNS3kvSXZ0?=
 =?utf-8?B?aTJmSytWSG1zQzFuTnRUUDkzSlAwZ2tRZnh3NnBGVnNmR0NONzNCcC9mQjl5?=
 =?utf-8?Q?fCG5rvg5bIU5RSoWDsO1hmbwZ7Ed792kIU5ufNG?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NE5aYnlpamRaRmYvVWk2QW9TUHJyMmVkVmRxUEQrcDBZZEY3MU80ODJEZTFW?=
 =?utf-8?B?cmJGRW5nWCtmOENmWlg1ZlI3aUJlT0NjRUVCdWt5Y3k1Ni9UcUxGM0JUaVp1?=
 =?utf-8?B?RUllNVYxai9kd1R5dFkyMTd0NGVTZzV3Rk1PRXdLL0VpazhJYkUwZ2p5THIv?=
 =?utf-8?B?QzZmVDgxaEZZRHdXN054RzFRM29pZVRJbHhwdU5wMVFtempzc0w4YzhTQXFX?=
 =?utf-8?B?KzlyNTZ3ZkxpWTZvRnRhdERyVDhTZStDMjgrQ3VoK0VINE15TGQzazRiRWhl?=
 =?utf-8?B?V1c3VDVJTjBpMUJ2b3hwSUwrYWlRUHhVdEtCZGcyaXdac0trbUVkS05XV2dv?=
 =?utf-8?B?akQrTWtoUCtraWNvQjdXZFZhK1NHVEVoaE5zOHB3emhwUGl6dGo3T3FmV2Zy?=
 =?utf-8?B?UTRuRmk5bTNPb3owdVRjN0s0RWhaY1owaTd4Sjg5NDNEenRFTTV1TmtkcGlJ?=
 =?utf-8?B?THZySTBQOGpvQWs0bE94UnZVSmF4UkdVbUpPelJtQzFYMDNkbitwUkQ1N1g4?=
 =?utf-8?B?Y1NlT2ZBSzdEejhHSENocmlZemZGanN0RHc0NkF6aFlQT0lpL2I2T1lFTTJ0?=
 =?utf-8?B?NEk2WmhxK3lRQjJveWtDOGVqTlZXRSsweEFmaDl2R3FkWGpUTEhuN2E2S3p2?=
 =?utf-8?B?RzNqQWpOYnY4OUFkMG9uYUdLdlZoMXVSdktWWGxLTFNaTGNtbDRaOEFUV0cr?=
 =?utf-8?B?VXJIdFZhQlRWR2ZCczZFZjA3eXpyakF1Nlp6SmszSE5iRktESFZxUEVoL0tv?=
 =?utf-8?B?bGVyUlpZUU5ITzVWZjl5K0xXUmROQVVCb3o3ZHg0M2hFdTJBNVFnbTVIdXg2?=
 =?utf-8?B?cmNCK25PVXZRN3IwU0o2eDJKU1RIMm8zNDhaZ09vcDlLTG1lM1l4ZkhmRmxF?=
 =?utf-8?B?N2NiSlU5ZnFQMmM3TlI5TnZjWWU2a3hzRFBWQVlqV081ay9qQ0hXMHl6RnYv?=
 =?utf-8?B?OEtqUHY4d1NhN0s1VzkwUjJLaXhLcUZWUUZMaU1PYy8wVkJuRW5CcXJEMDNO?=
 =?utf-8?B?dE1ibWg1d04zUHhKUDdFMWZaMkFDZllrWVQ0ZnRJVzhIeEpNRjZmaldtYXVI?=
 =?utf-8?B?ejhWaHNKbVh6TklJUVJvTnk1UWJQbzNYZ2VpV1VUSmovcnJzU1RQd1liTzMz?=
 =?utf-8?B?U0hsa1VOUzROMDM1MWNHanZZSnFaaS9PQmJDc3BVdityNS9PMVBxSHduRmtY?=
 =?utf-8?B?eVE4RUJVM1lidUVsUXc3SVZNT0R6c3d6MERrVVZ0ZXRweFg0dVI4cWZyVGYw?=
 =?utf-8?B?ejdqWm9FMFdCc3J3NkMySnBhbWUyVVAvbGRJZlBrTlRIdmxGUWxFdlFIbjZ0?=
 =?utf-8?B?S1JBZlhaUmZacHJCZ3RYZVZGeEZjY3FUNmVjWkhTV09QNS9FZWYrejRjcm5I?=
 =?utf-8?B?V0FKTEl4TFR2VUdVWTJjbmpTQnhIWGJ1dGpRYTFjYnhJRGhHcDFlT3RJcXgz?=
 =?utf-8?B?VStjSENjK3dmZnhuTlBlWEs2d1lLV2YrOHY3SklZWUZ0U05CemdQZUZmVXlT?=
 =?utf-8?B?bUZVaVFXRkN6RzY4NStNZXFZbkVscEdaU2NQemR1WEFlRytaY29lSVFMeG14?=
 =?utf-8?B?ckFMUUZXTkI5aTFwL0swdEhwNXNpYWhqdFJSclJXRmtmYm5RSHM2QVZYNjV6?=
 =?utf-8?B?alZHMk5tRUtKZWdTSS9qSExzTkdEQmNaOGZ0YnhVUnhTY0RnbjV5aHdPZk81?=
 =?utf-8?B?S3greENOSVU5S2hSSkYvWXV6T0pzbWc4bnpJSlI4dDdTcjA4eXlzQTNsRHEx?=
 =?utf-8?B?RUpka0RzK2ZlUUt3QnczaUk0cDVQbWJIaGEzN01nME5kV0dQQnJobXJuTnR6?=
 =?utf-8?B?aDFoLzRLNDJWZmUyYkRHb00zN25TY21jYnJFcUtqcnhKQitBa2lLTHFlc3U5?=
 =?utf-8?B?ZlpKbzVHYS9CTERLL2U5R1lLRDFiR0tyalI5TkwyVTRMZU8rRVp3STBMQ1B5?=
 =?utf-8?B?TFE1cTRFSVcycnp5SWJKMjJaTGUzbHlSWXNhTFFMVTFQN0lIcHdnZXZkS1pG?=
 =?utf-8?B?NmszOTQvRGtwSWpoOGpDSnAxRnNqQzk2cG1KcUlidlZBaURHd3p3YjYya05B?=
 =?utf-8?B?OG5LRDhOMEkwSnZJYTRVQ0lvbkJUK1JRSnlmMEhvNExsN2VlbUFENmFkWDhD?=
 =?utf-8?B?dXozYVdJUUlVcnltME9WSGc5bU9XakRVdGl4N09oS0ljOFh1cTJuR1V3NDZu?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nGPwP2FJt/tiPSksSkPjMnBUqm4tNuVo1ppAJvppSaXLXaPF9rao6otqDH46Gl8/rl50sEkbNUcF32WOs3GhjnuJ4V4rPhO6u3yW/FtM7fbElCXbv/5lG/dzrotZNKsUANs2AQesmC/qtshDXB++/6GdjgZCCoKN7pQ31Bnlae4TGZx4NbiQKofQ5VvayQ1ivy68ucWaRnwrX1GmdkTADtCur1Bbc6D1AFFAwqvBT84Ncy42qO/SFl1ucg/vKEFV0FjRM6Og61zdnmIQTBjPFzYkU/43rrpK5k8Yfa5iWpIgprryxL2PO/1Bu5j/mzPKtqNUo7RU+80X3FqVHzFPRqAzzcuPgnToOXNIBQXfeeqZzg74ycMVLouA80uRxUk32ouzwkl563Os9JGBRL+1ADYszopGpIzYHhc94YWpNurzjzrM98hg48gQvd4q0XQGB5ZQmXbjUEaTJNZZVSjKvU7YcSg0NKqeOnHRuO4Sq+++NKPCXVetIS4umJgtHbLCEZb5fLlgmqF3YalA7EYdRT9ANUtnX0w1JxkoW4XpOjUULFSn+mEwyX5SHv8KvP3/dGd7iZPTACk+xegufZ0ghNEPMSTH1EZHwP/bMNY0FII=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68af263-084d-47e3-ee57-08dc84d5616f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 20:31:57.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0FyRM2jnD1yUC8vx1BKUzEMzDA0egcZWCnpxIDamQgDTCfSuVIPpCHGmoZ5s/2wzaRO5Y53T5vRQo/tOHELMQB/kTICAPRV4mSrgfG3G8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040165
X-Proofpoint-ORIG-GUID: E8aWxefCU9_B3S8Yn-Dcl0eugmiDA0cl
X-Proofpoint-GUID: E8aWxefCU9_B3S8Yn-Dcl0eugmiDA0cl

On 6/4/24 11:21 AM, Jarkko Sakkinen wrote:
> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>> Introduce the Secure Launch Resource Table which forms the formal
>> interface between the pre and post launch code.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> If a uarch specific, I'd appreciate Intel SDM reference here so that I
> can look it up and compare. Like in section granularity.

This table is meant to not be architecture specific though it can 
contain architecture specific sub-entities. E.g. there is a TXT specific 
table and in the future there will be an AMD and ARM one (and hopefully 
some others). I hope that addresses what you are pointing out or maybe I 
don't fully understand what you mean here...

Thanks
Ross

> 
> BR, Jarkko


