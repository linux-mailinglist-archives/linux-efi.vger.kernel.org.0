Return-Path: <linux-efi+bounces-1158-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453628FBEAF
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 00:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90167B21B9A
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3142014B09F;
	Tue,  4 Jun 2024 22:15:32 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EED140366;
	Tue,  4 Jun 2024 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539332; cv=fail; b=fvfklEqrp3QJdU7KABWaLdNCheFvxCT3dQCFggGFOezfW+kB9s3PTfb6fkb+vRn3m1FxK439nQUbG5IUm14CD1cLP4a3ASIM2AhzUGjjkH57iF2+BMC4AsRtz546ZeB2q8/kK3OyciUOEBZVFR3SFH+4dtuacLdyoSwN3/NOoQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539332; c=relaxed/simple;
	bh=Y7Oi3MPJEiafVBbESudm93E4ZKixLrPBal8jAkQivoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ojMACNw78skzb01gs1bjz9S1VvAJuBrAF8qsvRnu+XGToCvZLirZodKRsCQSIhrUTgFz/lkRGN5IuXfnxS/O/2tdDfo/PcC3pi4moreC0tW49A80OmdlzZ0yjtoiopdBcwGKZ1gkebRfoEP0abT5J2Si/R/TJleDhe4oL+nNj9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454MEZD9016114;
	Tue, 4 Jun 2024 22:14:49 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DE79z09MC2zOvzm6+xBwHJgwtkrvRw0HEsFgJ4m7BEaU=3D;_b?=
 =?UTF-8?Q?=3DgHaEPlnAOqWL1HryHKt8XD42rkigGk1eda4HJ/D2AmdaMS47MYz/CAjjt1ud?=
 =?UTF-8?Q?O67s92fo_5w3BNYTsT3aZBWmxHHVcviV5UDSKqoToAoNBAV0q7nZcpDtx0efIaM?=
 =?UTF-8?Q?/vh7cCOKVjWouK_3JPfE3ftGtXsOFdqFVAN4m4YvNhmBGIkK6ODy9TUst8w/QlL?=
 =?UTF-8?Q?aP08g8sLII8Jd06dGf7v_xkhCwqgqXtNGOollGA6ZT5POonbfss/fDhA5SmSBKr?=
 =?UTF-8?Q?/t+t42fYloqgepv98VDmB+1r0O_yr7IjOpXGFdCJek5a3fJNS6JMA9QY8JEuIu5?=
 =?UTF-8?Q?+QohbMcWN33TicV0HuV3ybRmD0NkrPuC_xA=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv07x1ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 22:14:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454L0vgw023933;
	Tue, 4 Jun 2024 22:14:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrqxf2y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 22:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CivPoEt2SE5UVUiduq03VjMvRgLIG09/AR+r++/jHqBBJnYbmEPor+/pg/IDYzlbOwGEqCg8xOK8f98V4n4C1dKeAn3KAUACDr2ipsQUhMubRtovxiY+/pLdLwtxmCeicMi8SVA3VRUpYCg4wv3LdIkJSiCsTrCMScvaJVg8MSVXx80wS9oAmj+zaACnnAdKbrlQh1oJ2YLjfisqm+1yTo/d/vzTBxIBM973Td7FlZR8pZsGTEvtomeFXn1pdCQPUqeM3OX3dEA3VGM8e5Uk0YKbclTRTfp0YvA0iYPhEryFqqkNuyo90scklt8dk/vvqbut5Ajhyl1NlqQi71u9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E79z09MC2zOvzm6+xBwHJgwtkrvRw0HEsFgJ4m7BEaU=;
 b=HSX0F7vtGLmgA/7LWs3lRMoVP9aX4taSdutP3YhcexOo5vsQ//Vwq0mYYSz73qYGnylWdTZSzo9ZFDqY3r5mftk5Qfzh18RhbjUIKuTa7RRdXIuWLYlL1gm2OFiopxdOdx0YRk4VFQKV06TUip8Z8gOmWT6MwiLi+188sZRzPJFpc1YDR91I9YPbzMqdVqbgyYmcF1UhRjFce7mUdEbc9iaQ3y94wE9goi9sNOTHO5W0r+vMXEOucRoG/vWPhPJCsB0Tb11/uZdMhar0haV2ZBmkWu9SyLOeI0d5EznGTV+8+FnO2y1MsTBiOsZMa9rt2IUVUaiJ22XB/pPrwmozaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E79z09MC2zOvzm6+xBwHJgwtkrvRw0HEsFgJ4m7BEaU=;
 b=0N22ISbVc+alfa3tZMYBklz88pyQs4sjVOVE7xsmc6FU3NuVpcjhbwpy5mXLKKRqoo1WQasimrv6pJ1VG7dovjnFZiGKIR75ZM8g4ZMhIpvTCT416ymdpFIMKpy6gJrglFRC4taYcYFUYA/ddfGEyQlViDEEig9jDaDzmwqL+t4=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CH4PR10MB8025.namprd10.prod.outlook.com (2603:10b6:610:247::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Tue, 4 Jun 2024 22:14:45 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 22:14:45 +0000
Message-ID: <282fddde-d156-4bd3-906b-0318d0a3746d@oracle.com>
Date: Tue, 4 Jun 2024 15:14:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/19] tpm: Add ability to set the preferred locality
 the TPM chip uses
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
 <20240531010331.134441-17-ross.philipson@oracle.com>
 <D1RIKP548WG9.Q5MM7K3FRH4P@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RIKP548WG9.Q5MM7K3FRH4P@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0022.prod.exchangelabs.com
 (2603:10b6:207:18::35) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CH4PR10MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 6580f0ca-a55c-40a4-388b-08dc84e3bd80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U3ZPRzI2U2VHMWpwN0MxU2ZBRXdOaWlzV0llVTRQdHA1RjhTb0ZNdFlZakU2?=
 =?utf-8?B?SlZWa1hoeGpEMlhHZGo5VzIvb2tXY2Y4YkVtZENjU3hYMTJSbi9SUW4wT1Rm?=
 =?utf-8?B?bGozK3BFUE0wd1d4RC9MSU1NQUhIa1U5RUd2WFVXZDNDRmJrQVZPbUhxR09t?=
 =?utf-8?B?ZkxEQmkyNERLOFcwS2RxWWI0NmFOOWxCYjNQR0libVNweUMzdHdlL1F1Q1Ux?=
 =?utf-8?B?MWlQRHhDcGxIdE1OU0V0NTkvN0pjNmc1YlhrdG8zWTM3bWljL3FXWUNPblJT?=
 =?utf-8?B?aXZzeTBobElEck9jY3dsazJwNENtUTY5N0pPOWQwRGcwMUhLTUVsRlBTTGZp?=
 =?utf-8?B?a1RWOS8rbzkvVEZ1SmYzSDl2ZThkNytVMHFmdy9tZzdRdTd3aTBYMFcwcU5S?=
 =?utf-8?B?NVNnZ1pyMWM3MFhheHAzbWxHd3M4MS9ybi9uSTNPemFiTVRSdmN3SEZNc3Ar?=
 =?utf-8?B?NUhEcHdFQ2dpeHEwVjI1V2d5WFY5aUI0MUNXcFNhWXdKb0w0YTFIU2VNUU9W?=
 =?utf-8?B?THpBSlcyNWxReHhqYzdKaXdMNW84NXdCRDV4a3djUmc4Qlc4OUhub3lEdjF6?=
 =?utf-8?B?dXM4eVdWZlNhWTZTZDFlbjRyazRBVnpOY2hzRmt6ZGJGeHcvYkV0R0M4SG53?=
 =?utf-8?B?bzdtdUJURUZmUWx3cktuaGF4ZEIwZ2R6WGNUQ3BmakF4UU81TjVaY2x2eHJD?=
 =?utf-8?B?V29QRzBMVml4M2graitiaFJETG1JYnN1YTR1WnBYbkJNZXBpWUppT2JtQWpF?=
 =?utf-8?B?MmNoeXd2V2pxaXFDcVNFRnpqMHN4SEkxQi83OVVPd2w3VHJ2YTlmVXZ1REJ2?=
 =?utf-8?B?WTh3TGVvaEx6VXF2Um45cmxmYllrTWFicXJ4NitBbG1LS2h0WkdKemVQVVc3?=
 =?utf-8?B?djFNc3R2ZXV5NmFHS0J2K1A4aU5pL2kraCtLaGVIaW9nOUloRldJSWk4RTlY?=
 =?utf-8?B?aW9nTXlMUGlUcVBxUlhKSHVrK2l0UGM0aGZFSkpibis4eG5BRno4STRaUnNa?=
 =?utf-8?B?ZFo0K3ltWnY5RnAzMThzK1BPYlNJQ1JUMnZDVUlieDIvbUZCNi9TYmNKNFFH?=
 =?utf-8?B?ZEFrSEwvYXlhYkNpUlpmWUx0LzRlbXF2MWJyRnpGZmdVSVlzckhpQWN5c2hs?=
 =?utf-8?B?cks0bHZ0UUhRNVJuTnYzNzQvbEhuYUR3NlZlWDRCbUJBdUVBRmx6MVBVRmhw?=
 =?utf-8?B?OXlselVxSzMxZ05udXlrUkcycFNQZHdUK0tQaHhrckpzY29sTjA5eVdQa3VM?=
 =?utf-8?B?YzlPMUltMTNnUEttWFZQdVF2UGVtVlZReDNkQ3RRM1Y1UXVPd3BRY25vaHd4?=
 =?utf-8?B?aDgvQVRIRXNzUCtVbGJ4enpxNHh6cDQ0cjhzb1hRYUY0UTJKaTdWWjlCTkJh?=
 =?utf-8?B?VmcrNVNtQ1VxTmV0VVBaQWlWUU15cEg4THNzT0cyRndMSGZkVFFwMzhWUVly?=
 =?utf-8?B?K1JkZFJnRlpuNjZ0UzBaTkhYcnF5Z3YvQTBJZmx3UFBwSkJCdnN6U25DV2RL?=
 =?utf-8?B?WW1YSy83MGNlcXZIZ3lNY21OdFk1OUwybUlPRjMxZFo3V2ZtOWJCY29DbjdB?=
 =?utf-8?B?T1FrOElFMFkvODEwdVhQWmhZSEFWbU9SUFNrbFlxb3RwUnFFTW45SDJKVURS?=
 =?utf-8?B?NWh2azdsblhLWnk0MDNRMGpCLzNPUnNCQ2VjdXJiek9CMDI5UjVLUWdKWmd0?=
 =?utf-8?B?OEkwdWpqME5rSUIvQ2JjeGNwRnpFWERkRGVjVzVLM2x2OHhkSlZIaU9RPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dkVzc2dHMzlFR2Qra0pDbE56MEdIcUs2R1paMHV6b0gzSCtJVHN6U050N3Vv?=
 =?utf-8?B?NklNbjRxcDh0UllBNW1sZzNVZWJHTmpRL2oxOEI2WEpqREk0ZUFDODlDSysz?=
 =?utf-8?B?aVpOMHVneTJMTHVlTHlPY2lrY2gyQWk1QkU2dWkwTkN0cUFiV2NoYVdUTjZN?=
 =?utf-8?B?cG52OW5ma0NYY2h6eW16VW1Xdi8wZXJQcGZsRzRwMDVkaVlmRUhhcXIwTDNv?=
 =?utf-8?B?WGNOZzVYeVhTWmh6M3g4VTNPWU1BMFFidS9ld3p3UUtKVWZnUXZJaDFNaFVV?=
 =?utf-8?B?bmY3Q0VoL2xHWmpsMHZoS0tQdTd2Wi9XZFc3cHhtcTFScUp0NTRaWGY4Z29S?=
 =?utf-8?B?eUZ5S0s0WXp2VzNINkc0bUFFRkJFNW03STRwSC9lQkp4TDdmcXFka0NpNXMx?=
 =?utf-8?B?L1I4U0hTYmhrTHlXeDg0TnJoaURNYXovcEhqVTQxUmU4Tmo5elVRbVJGQVd5?=
 =?utf-8?B?ZVFTL1Y2SXNZMW1HMmZ2Rk9ZU0FuWTIxZEd3SEZyaWpxeUNnSzlLNnFFR2ky?=
 =?utf-8?B?RC9EL3A4aTlPeiswQ1JiRFpDRE5WcEJUd0RwN1Qzc0N3bXZDbGhuK0tGZ2FD?=
 =?utf-8?B?U0MvWE5haUo5ME8xRWI4VGJ2amZlYTNNR1lzZXM3NFJTeEtraVVudUNHQ0pI?=
 =?utf-8?B?U0QwNFZDWml5LzRLakpmRXFYbWs3WWIxaHIwV2pLbXBaY3NwdXlKWGpZK2FV?=
 =?utf-8?B?UkkzSG4vTnhYZnNidFNFOVI1ZmJtTzcvakhQSU0zYzQybHU1bGJqZlQwR1Fo?=
 =?utf-8?B?YVhRa2ZGdWpOUjJMNUhXekh4MmNqMHpoUEp6c0lkTncrbXFGK0FBdk9TUFlO?=
 =?utf-8?B?SldxcUpEdGdPeStJbWdKTEpSUmh3MGNla0ZTbVhLU2krK0NFVTd4blJ2bUJU?=
 =?utf-8?B?QXV6WjkwaXhaYTlObHp6ZGFMeVp0djFNN0pXVTltTzMrMDU3eHlzbzcxOThC?=
 =?utf-8?B?ak50RjhLc0pQa09OZjAwZlVDbUQ5QUV2c2ZoeWcyUm5YK25sRjk2YWtSb1U3?=
 =?utf-8?B?RzFMckdVZm04eGkycWhNT2wwNVprOWMvNUFSU1VaUmpsV3BMTjZYS0NWTWdH?=
 =?utf-8?B?V2hjVk8wMk81bmpjOVcwQkNQNlcrdkJsNTNkZUZyRW5wdnorNmRXeVFiZGg1?=
 =?utf-8?B?TFF1UU1vM01GazlCOXc4L0RYeityR3lITDBscTc5dnBhajQzeVFHRlVlZjYv?=
 =?utf-8?B?SzlHKzk4ZW9PdVpSRVZMQ1NlM3NTT1Z2cFgwNlpURjlJZU1nQzVHa0I1dDNy?=
 =?utf-8?B?eUdrNjVtWkpWQ3ZqNnVYclUrYk42U28xQVM1K1k5aUxVYktPTmZtNUp3UDls?=
 =?utf-8?B?OXBvQk1VOVd2dXA4TmpJRE5kWWNIUDZ5bTMvcXdUY2Z3MXd5dlY5a3hLc2s3?=
 =?utf-8?B?R3JHUjl2UXk4TlBSRVdnWWVpZS9uc0orMzZQNktCVDJTQ29sS0plUGpnK1BW?=
 =?utf-8?B?U3B1c3lpYlJJNGhpb0xDTXBaMlJZeVR4T2hDSkV5UFdmSEpDMkJEZy9GWWE5?=
 =?utf-8?B?aEx5UjFkTk5pOU5xY0ZIVmFsMDhGYU1PN3FGWDdjcWFkdFR3VjhheEJta2V0?=
 =?utf-8?B?UnlrbHEraUZMSk9JLytCZE1ocmtBeDVGdVpXeGtoUi9yQi9iODJRWWEwcnZ6?=
 =?utf-8?B?eENDS2t2WUx5VEJ3WWVWUnhTSitFL1hHUm9HQW84aXNZQnlrNmlpUkF3U29X?=
 =?utf-8?B?aGZQek85OVRIMEZLeXdkR3ljYjQzaXJCRHRCdFVaL0U3NjN6KzlIc3ZVa3BN?=
 =?utf-8?B?SGpxb2IzWm0rQ1k2d0JrN1N0TEtGamtTREFYd25mc2pZMFRNRm5Yd1U3eVc3?=
 =?utf-8?B?RTVaOXpYMHpnVjhoZFhoY2lkZ0NHU2RIQkljVVM3TFR3NDRrY0ZkVm94WXcr?=
 =?utf-8?B?QzZRTWJobGZ1WFZhYmVrdmp2TGJIc1ltSVBHVm9qQk5JWUlyOXpWcDFHdS9M?=
 =?utf-8?B?R0hVZWdUMWIrTTMySEF4cFdMY3owazJzTVh0Y1QwbXBPcTZjQTFPRXVkcDFl?=
 =?utf-8?B?WVpSSkU0djNkQkQ5UEdkUWdVZUltc1E0K2F0THBCd0hDYnNObW9ON1BkN2dW?=
 =?utf-8?B?ZFVvYjhSc0ZmK0JzSVNNWklmSjVNL2FpNmZGKzFQd2grMkRBUzNvN3l3OVc2?=
 =?utf-8?B?U3pRV042QkI3TDFzVnFMWkFHd3JsZWZFeGRubHBTT0NFQ1Mxa3ZjTkp3TjNr?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TYYIfo/FAjGNzDV3sbHQhj0cZljk0HTP9+9VC1r0+fA2C8VZGuDNOX6rJnZe0HwiGLjM3zlBkp/Pooa3FLhY7bLWK6dIgrz0pJAuRQG9d3tEJAwcPbl8a3aRDU5ohbbDbJ08Yc3GLQ3M6HTJqO08yguFrpAIluanXhByXI++kSucUXx2dwYQPofvDtkQKQt3xcUA6V+YhZsnlfntLUVM4Qq4NId9UckaRJleGEhXvCmNNmlwP7sIVoPlesvSN2ZMj9ZrIRCv3Rbp5j5K9AM9Cq+tsz4Yrq3fmZkiKyPixM5LOX31Bdcww86XWIvLI/WS2LDMusSOXXHsg54bf91WgOajrY7r8DnyXiSSDhwoi94EBZPoiF4YLmPE80ANRGRjZ+3mAzYZnOVLjQp+ZB6TDzVfOt6F4ogjmwpf3KN0fd3LgKpFa6T6AjcfZzu1ZVywJJEQ33tdgUva9+OZG2ds3hA5CKtWFdvcyt63sYA1gRBO31ok79ezSDME90UOI2VITy6OKdPFX+CqO8n5YwkIODd1lqYHC6koAKbzMIsU1TCffV/PIAX4kMg2XfehrdEoDIzH0iJr/hhYtcUvG/4nHyboRSUUk3NxAj4A/Ei2m9Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6580f0ca-a55c-40a4-388b-08dc84e3bd80
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 22:14:45.3637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FA/NDxelLLkXOIggWIh+XbNLL0ecJHZJBFLtEgWk3Qo0qdijgepH+1odRip2zPRMwcmjYcT/wA4pEGACvkk/0Sd0lB0M1vrtUu+7/JFg7Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040180
X-Proofpoint-GUID: zBIft3hJof5EGLdWBMrp0r7bRBujpLAE
X-Proofpoint-ORIG-GUID: zBIft3hJof5EGLdWBMrp0r7bRBujpLAE

On 6/4/24 1:27 PM, Jarkko Sakkinen wrote:
> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>> Curently the locality is hard coded to 0 but for DRTM support, access
>> is needed to localities 1 through 4.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   drivers/char/tpm/tpm-chip.c      | 24 +++++++++++++++++++++++-
>>   drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
>>   drivers/char/tpm/tpm.h           |  1 +
>>   include/linux/tpm.h              |  4 ++++
>>   4 files changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 854546000c92..73eac54d61fb 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>>   	if (!chip->ops->request_locality)
>>   		return 0;
>>   
>> -	rc = chip->ops->request_locality(chip, 0);
>> +	rc = chip->ops->request_locality(chip, chip->pref_locality);
>>   	if (rc < 0)
>>   		return rc;
>>   
>> @@ -143,6 +143,27 @@ void tpm_chip_stop(struct tpm_chip *chip)
>>   }
>>   EXPORT_SYMBOL_GPL(tpm_chip_stop);
>>   
>> +/**
>> + * tpm_chip_preferred_locality() - set the TPM chip preferred locality to open
>> + * @chip:	a TPM chip to use
>> + * @locality:   the preferred locality
>> + *
>> + * Return:
>> + * * true      - Preferred locality set
>> + * * false     - Invalid locality specified
>> + */
>> +bool tpm_chip_preferred_locality(struct tpm_chip *chip, int locality)
>> +{
>> +	if (locality < 0 || locality >=TPM_MAX_LOCALITY)
>> +		return false;
>> +
>> +	mutex_lock(&chip->tpm_mutex);
>> +	chip->pref_locality = locality;
>> +	mutex_unlock(&chip->tpm_mutex);
>> +	return true;
>> +}
>> +EXPORT_SYMBOL_GPL(tpm_chip_preferred_locality);
>> +
>>   /**
>>    * tpm_try_get_ops() - Get a ref to the tpm_chip
>>    * @chip: Chip to ref
>> @@ -374,6 +395,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>>   	}
>>   
>>   	chip->locality = -1;
>> +	chip->pref_locality = 0;
>>   	return chip;
>>   
>>   out:
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> index 5da134f12c9a..35f14ccecf0e 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -274,6 +274,21 @@ int tpm_is_tpm2(struct tpm_chip *chip)
>>   }
>>   EXPORT_SYMBOL_GPL(tpm_is_tpm2);
>>   
>> +/**
>> + * tpm_preferred_locality() - set the TPM chip preferred locality to open
>> + * @chip:	a TPM chip to use
>> + * @locality:   the preferred locality
>> + *
>> + * Return:
>> + * * true      - Preferred locality set
>> + * * false     - Invalid locality specified
>> + */
>> +bool tpm_preferred_locality(struct tpm_chip *chip, int locality)
>> +{
>> +	return tpm_chip_preferred_locality(chip, locality);
>> +}
>> +EXPORT_SYMBOL_GPL(tpm_preferred_locality);
> 
>   What good does this extra wrapping do?
> 
>   tpm_set_default_locality() and default_locality would make so much more
>   sense in any case.

Are you mainly just talking about my naming choices here and in the 
follow-on response? Can you clarify what you are requesting?

Thanks
Ross

> 
>   BR, Jarkko


