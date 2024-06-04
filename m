Return-Path: <linux-efi+bounces-1155-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BEC8FBDF4
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 23:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99147B22DC2
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 21:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A900142900;
	Tue,  4 Jun 2024 21:17:44 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B225B683;
	Tue,  4 Jun 2024 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535864; cv=fail; b=Hh+JTPyTi3VCOTmq/GciCr7gYpw7eCo04GScqHvQs68cSsz+qbqVY1fqHbUizC3ItsARJCUVep8F505rZVxnfW3HCh73BCTFkTdTs3maLlLFI09bDoyl4ZPgsK518B9i3mOHn4f9NXLDMYWTY3aK5rv4oxyVsW9H7N6BVl6eySY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535864; c=relaxed/simple;
	bh=SsEDphanrFyR0TJmbKf7qkMFanPK+N9j2Ut7Q6wRXDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GmgleHiOWN9Q9gmmPDMboOextJNzDZDEQ90iI1D9u+0ON1NsHQxONt8ebH83wnDzUazlSI5sr0aAGOxzbWdonH3a7cPXxckl7ZRH9FTYimEbcnS11lYDtwTHHCg1/gDxLsoNIfiYYH3eTcFS1tH48TV4MBG4EeihR4vvvIxJlZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454J9IA7024271;
	Tue, 4 Jun 2024 21:17:10 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DMINskGGlFdtD0zG2LAPkuibNCZmrFgGKqrCSI3Jy4Bo=3D;_b?=
 =?UTF-8?Q?=3DZLgHBbIFfg1kubsM/6EyHk+pcH5z+kmkeiAlY/R5Un8AHzi4JBjrsa2UIcL9?=
 =?UTF-8?Q?fX61lVh6_4u1EOnN1FwEYozONhW6IX5cd1vKaPwKCSVqm/8StxB2XNCFkmhw99G?=
 =?UTF-8?Q?1wVGwV9A0+GGsM_ZAa9sQEcsAb2yRHc9pvST56Py8ONX7EJXwuX6QyCQ073TyUO?=
 =?UTF-8?Q?GU1ZvQJUpszmWz8BHQBa_/Kn5vCRZEmkAIY5nIv8262OaQbFG7XN92he8SyHjDK?=
 =?UTF-8?Q?Y+tM5wHn/63aGKNcHulXahmdWa_R2PzVXaAZmyhrUonnoR089zmPTKWVg8NKXWU?=
 =?UTF-8?Q?rH36WQV8Pu3bovzlOk+YnGQdZ+v+vpZp_qg=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv3nwx0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 21:17:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454KoB2L025047;
	Tue, 4 Jun 2024 21:17:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt963hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 21:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj79eBilY6FfF6f2Yig7pfMHyXwIvO5buJzZWsIfPf6RMIM35SpAsKWL7zY7qbCsAQUHy9Q44mVx0PHi1XcVtsPtbPLT+2Lo53Qx4Byz8yDdvpWdFfsdpISJcgoMuFNAnLXH0Ke0QoxABxnqudEzZP51qgoaqPHOCynH4mJiPzu0RO7+JLWT4El20eWeKWywalDbKH8xMj2AkC8p5SwuCiXu0xZJgne2SnqReXPIpVSNak2/ONe3eq8JhKWtrjnqJ05ku6rgxtbZQ5Lo6xPMxJgzmJrr42Gh5aUTLynM9yUaNLcV6SqBpAadvIHwk2Dbf/T9SmuJzyAIMgRkQyxuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MINskGGlFdtD0zG2LAPkuibNCZmrFgGKqrCSI3Jy4Bo=;
 b=iaTJBcZYvCUVVRpTf0mh3NkGbdUJJRT83mfpXaw8AFLQiuye1AUkCgYGiiQe1BgLNtM4IRIlpv7NWgHsQ/+DoEvOb9HcGABGHuZ1F6GmovmlvVKQJ1DuQVlLsaals/kdJLFcYSgButap2kVLgWXtTOPl5mJSn7aNGhxINqq+Ea1tFukBynMxdknY4PyWlkdtrZPmYGRHOY/dZm5aW+FZmUjm69Sxyn3ZyebLAU7erZlpzSJf5Dvif729pGerKw7sVrV98YTVLlMHvV2LbegEXuXVs6kWfTF+BPKbPFftqH+PLvr6PLjM6WHjjamuRYhtc0GSYhtpd2hEpm2y/Subbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MINskGGlFdtD0zG2LAPkuibNCZmrFgGKqrCSI3Jy4Bo=;
 b=HErAAxBqOyvVzhYxTKDyGfW/+Ug+VCW+K5+3IrVCtyh7qhl6Z7Ts/M/Dhm5QbHAryjB8mwjuGop/BqvFAAvG29H+UfJsQawSGs66FAVMzt3soKWge9CZZ+ecMmwdp2HuyuDDwYfZLbipQFRjjLWqnesBUAAfuAiAeMvLSsi6v8Y=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 21:17:05 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 21:17:05 +0000
Message-ID: <74328ab7-c054-49ad-a40d-214fe6792adf@oracle.com>
Date: Tue, 4 Jun 2024 14:17:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/19] x86: Secure Launch kernel late boot stub
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
 <20240531010331.134441-10-ross.philipson@oracle.com>
 <D1RHZDG3HJNK.ZWTFLXDBEXD1@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RHZDG3HJNK.ZWTFLXDBEXD1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::24) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|BN0PR10MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 2400ddde-07e4-4b6d-47a5-08dc84dbaf09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TFRKenVUbG0rUFAxb3JVcm9VMFdEeVRreHZFNjJpblcvblpWSzMrdFUzQVd5?=
 =?utf-8?B?ZVZNY3lrTmlPMTFuVUV0R1VpZktsK0szdXd1U3A1MGJ3UnFldXptamdWT003?=
 =?utf-8?B?MnVnZ3FGWGZrMHN3bkYreDQ1R2sybTlqNUNPYlJSa3FneWtBVWxkbDJRSk1j?=
 =?utf-8?B?MGpwaDNrZGRaSndKQVhzSUMwYTdZaDVuN0Vtd01rbFFzUWRBOWhyRk9ma2N4?=
 =?utf-8?B?aUFjaHdwcFV1L3NXSkRJQlRVVzN6VnlYQS91UzVJQjltRDJQR3lsbk5wcVFN?=
 =?utf-8?B?Lyt2a0VCK01sZ0tiMHBkZjl1QkZXUGw2UHBZQWR2YlVmL01URk9JK3RTczlW?=
 =?utf-8?B?QkJnN1A2TzdmSm9GT3NYQ3hHbHZhVWhKMyt5S3g0S0lKYWU3S2dmWjIvWml2?=
 =?utf-8?B?ckhNdkJYY1QyZElUNzVHRmRWRkU2TytPWUZVZGpZdkNKL0ltYno3aU1Jdml1?=
 =?utf-8?B?UWtpaTlZYUhSUVRCR2Fqak5xa3hrazh6ekk0eFZ4WGlXN0Npd081VEVNeS83?=
 =?utf-8?B?S3RISTZ3cUNYVkM0aFQxa0gzenNWQ3hqK3RkY00yRTA2QWJBdG0vTUVYaXor?=
 =?utf-8?B?OEdCVWZlTmN0emw3bHlHQXBTUmkrelErWHVnMnJ0dFMxdVF4cHJUekE4aWc3?=
 =?utf-8?B?ZU9QUEpKd1V6VC92UVJrSjFnbHJtZFRCaTcwWHlsc01tS05wMVpibjk1VkNP?=
 =?utf-8?B?cTZDZnl3Rk4xb0pnV2FrTk5acThzbHZub1dGVVFGQVZyYnZYNnVoeXd2OFJF?=
 =?utf-8?B?TDJDZUd5SkRnNksvbGNRWDZ0TWFraWJZSUpKTEwrVDZSY2pFQ1ZaYWJIbFhY?=
 =?utf-8?B?Nk1sMFJTTjc2VHkzaFE2V1NOQWtxenk0bDI5UE1TRnlObjAyUDZNYnFFd1Bn?=
 =?utf-8?B?UkUwbXo4dzZQMzNkSDBvWFY0Ym9oMGVUR2hNa1dCOWl1cDQwWHNzMHVhaE1k?=
 =?utf-8?B?UFp5WnNTdldralhia2Zyb3FFVUd6M094dDVTZmhNYWNwM0FINXhXOVFwQ2pi?=
 =?utf-8?B?b0drZzdPNEZXbTcwUTdFMUQ5VzRRY2xIM3pha1Q3Sk1BYXlSTVZrUG9kVWZX?=
 =?utf-8?B?cnRoWkRVVFBzNUxjUDl4YW10dzRmcFJWcjQzd2ljOWVmT0ZXZW1obytTd2NE?=
 =?utf-8?B?YVV4akUxZXE3c1p6RnhmZStDZFByNnhoMlBSTTJHVlBhM0k2M0JLOUs0YXVW?=
 =?utf-8?B?WGx6R3BzR2ZDNGFMNTJNZnVmYUx3cjFjMWV2ZHgxbXNuZzRWSWw3VzFTNURR?=
 =?utf-8?B?TTBLY0xYdmlpQkZnbHJQYzgwU2w1WXZ3bXBPREhON29LeXNJdGdPYktJQmM2?=
 =?utf-8?B?bWhkZ3puREUrTGM1Sm1EMGVpeC9lRlVxY2dpaWhPOUppU1pOaHdMK0I5ZitI?=
 =?utf-8?B?QVFNeWx4SEV1RGxDNjBOVWRxVnVENWdCOVhxR3FvWVo1L2N0Ym01NE4ycDBp?=
 =?utf-8?B?RmpsV2UwZ3pqZjlGSmVuaVBKQlVYKzdNKzhkMEJDS2lybk5EYjB4R0pIemVP?=
 =?utf-8?B?NUtpYmZPRzlLekNSVHBhTUE2Tm5aZjhsZjlOdmhLRFV4SEczU2x3QWNSRHN0?=
 =?utf-8?B?WFdBM0l0eGRqVlFKZk1UZVhmeE90a0VJR1c5UnBIOGtUWUkvcEpPTzl6Slp0?=
 =?utf-8?B?clNucWFYTkgwaTZnZmNaVTV5THN4NXdpNlhFaHdFcFB1Ti9tMDBrQ0x3aExn?=
 =?utf-8?B?WFFLU052RTg3VDRFTStsNGx6b2p2MlFaZ1YrcGJWdjhMWmc2UlJ6WnZ3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z1hPTS9XZ2RmSWlHWFV5bUYxVzFYcFVaSEVsZndWSzh6YzJGNTZRZCtwYkhJ?=
 =?utf-8?B?Ky9Td1Vrd2ZyZmN6Ukg2dXVCVDFFNkl5UHZYZCtlbGliU1FlaEF2ckUydkU5?=
 =?utf-8?B?TkdGb1EvNDQxL3RGMG5IeG5lZFVMOGszYVVwM1QrWVF1RmV0aldLL2QydXdW?=
 =?utf-8?B?VkFta3BCR1g5RUs2Sjc4WGRNbFFVU1pNTmU3Lzg2YTc5N0tXK0FXcjBJODJQ?=
 =?utf-8?B?MHZhbjNIUVRxeUtaTFdnOUh0b2F4T0VuRFRLbDQ0S2hHaUhTQUhCcjZsYzlo?=
 =?utf-8?B?TTU4MFA0M0N1aUZWSFBrQkJTUUY2U1B1MC9UWW8wTURxbmtxZTRhUlAxUkp2?=
 =?utf-8?B?WlBieEhvUFc0Vmhud1JpV0lKcWQrRXMycDcxSGRyY0pRbkt0TXBoYkI0cElk?=
 =?utf-8?B?OUJFR0hrNWF0c2xvYzB4NlptaEpud2R6eTF6SmU2WHN3S2w4UmptKy9SRmQ2?=
 =?utf-8?B?SzV2WHlXeWdCQWJYamlmRFRGVWdHODVPMDVrREppTmNmUzQxZVE2cEpmUEdt?=
 =?utf-8?B?VE81YkFTSlFRcmRISVY0MHdmMTEzMHNEdmx6VmFHY3hQblFocUpOMWNLWkxJ?=
 =?utf-8?B?VFlwajFpYWY3Y0gzVmo4Yy9ReEwvRG1GSzM3azBnZzNUTEZDdjgrVUVVUi80?=
 =?utf-8?B?YkVaNGhMWWxhTjM5ZzFFM2FhcFFodlZ4UU5wb1l3bTJIZWphYjg2YmZKZmhZ?=
 =?utf-8?B?SmFwV2tjeHkvVmN1dkZyTFdZRk1LemdQS3I3QXAvM2dYS1cwYjZ4S0JOUkRF?=
 =?utf-8?B?U1NYbHVUVTR0NWdFaW5OOXNxOWVtWG1EV2I4Qzk0SnVsNDl1bzA5cEVZcVRE?=
 =?utf-8?B?QWYrN0xuNVhwdWx5UmtuTHRHL3lGanlTMWNsUk5IWU04MkZ6OHpCbmZOZTVY?=
 =?utf-8?B?OS9zT05zR2ZKUnpMK2xnTkdONktlZm5kY1E3aVhnL29qUTR2czBuWC93eWtY?=
 =?utf-8?B?cjRFdVp3cGlVVUtvZWFMS2NQVUpPWXpXMGtWUTNiTS9yYTluVUJBUVREaEZW?=
 =?utf-8?B?c3pDanF3VWtQcTI2SGtvSVNWWWlpaU9LMUZsbmpwYUNEcVFsVUJxVW1MOTdW?=
 =?utf-8?B?UU5PZDdxN1A0MWY5Q3Q3emRFM0ZMdm0vNldJdlNZUldtOUQ3YlhqZ1pCc04r?=
 =?utf-8?B?ZVFZeUdsSTk4N0pucGE4bWViY3c4NVIwZVR3RnI5T0FkdnZyNTgyQmVjTzlE?=
 =?utf-8?B?VGN3YUoyRUlMUmxpQWdWditqUi84NkNjQWxmVm9yZmVRdU9YZGJTcC8rT25F?=
 =?utf-8?B?M1FwMUdZQmsvRHMrbUpwNWo5UURpaElRYmhPS1JYMXNrd2l6VlBKWUt5Y25q?=
 =?utf-8?B?dHZja2d0OHdJMFN6dlFyOXloUVAvWnY4bUN3WFRmM2xzRlhBb2FBakxkeWEv?=
 =?utf-8?B?TXJTWFdNM3kzcjMveVVsL3BlWXA2REhsNWNCVUF5azVGaFZ3NC9aZ0NtVlJN?=
 =?utf-8?B?clZuSE82RzRCaG5DSzNUdDZOM0oySTRjZ01ualoybFMyWnA5U1BKbklJSy9w?=
 =?utf-8?B?Z0J6RSt1WTFiTVFXcXdLOVVpM1o1Y0VsWGdWUHBoSWtuL2dYd2ViM0FKK09s?=
 =?utf-8?B?cVZidmFXckFlcStRRDlqQy9maDI3alhQaFFwQ0R4Ulp5RmtqdEppVENYRmky?=
 =?utf-8?B?YjB3OXpNNzNIYnl2aDVHL2RmTVJDZTdNQW03OFBoaFVodnEzMFFoMHJaS2RY?=
 =?utf-8?B?ekdER0dkNnpQL2hvWXNMNmg0d1ZzVWpYai9rcWRDN1NGeTJ6QVdidk1ocGU2?=
 =?utf-8?B?TWg3T3hvUGkrUTdHRm5qTXQxa1kxdzRJbVQ2WEkvSVNkN29TOGEycWZUNkFT?=
 =?utf-8?B?UW1TYzlEYkdQK1pPWUdPSVVUdHEyU2ppNG03ZFdxbHA5Y0tDdHpCQnRMVEJs?=
 =?utf-8?B?b1RWMGdtVytTR3lZQUJodXBrZjY0WjRNOWJYU1drYlBrSGdINnN5akc2YXNF?=
 =?utf-8?B?WFN1ZmRYc1lvOWdyWU5maFRqdzJSZTlMRjZ5YTZ6bnZEVnFxZjhYeFZYNENl?=
 =?utf-8?B?L1lsS3B6ejZwSkpvWG5vZjFuWHlWU0VCcldQTS9DcGQvTUwvZk80V3dtWE51?=
 =?utf-8?B?dHJ3b0U5UjIyT0lOWTBjU1ViOTdWOHBjRXNtNm5xM3hFOUthNGRTbzRFWGVT?=
 =?utf-8?B?RFVBeXk5ZE1xSjJOQlFvSG1aM1JibG5Ub0ZuQ3JSbmdacHQxeDdhVUhOU3BV?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HWbeJoCTPC9mia00vvLIJKIGMgK8YMfK4LbV/vWxIg3j64w5xWtljFmB1kLmL/ozHtmiiYxqpZFy/1tLcG6Ah8/t0krouTs3UsPuE4HABe1aRIcZ1xBZw3c9ikkAy7Wrdm4vlr6D5CduxfPEPTgq7j6zCMYr71gMQFmw0Y+RMnwriAIUZ6C9Y+E8dvd0dtbKhacbEX7/olgQkBHnO++ZtoASc1T/y8pMU+IIN1m6+Dql8lb7veTlt/YTNtlO4KGrbVWYFBf7sPNXV8NOlcDagUnGkpQWaEmCvUP4jD+iCTLS9JKIFnQWFMAG/eg8L/3/6afewX2twsAx0j7LexLaFi/S+zV5WUrHSRROxcE5ISi3fz3d3IgkXoVTVKEnDlRm34P35tfBYjzp0L75UMuaZcUyKeZyNd3qAxQsWnbMX8wKrnwQvJxmhdpB33jwB2I2lyswmhU62ly/6bdOCP9ncC/01Qcx82vi05ESXzLty8bwMM2A/Y4aTPgwC30hGwAe7N6s6cTpN5+akQTajDvkLlD5cUmfSPmNMdfNpA6ybkGYWLvmfQYpCErdtsA0OoXEw47si5xCtjFDawfv/u1TXtfqtKuWGfgbUT7t07gbArs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2400ddde-07e4-4b6d-47a5-08dc84dbaf09
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 21:17:05.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmqvrJE254+d8DMnVbunKzZ7vQlMg3LjlS6xz4JQgxttZX8x6M9s5q1VJN5G+RPKER70K6bIKnmKtJu5Z/DiIDMgB+iuCxyKiw9ikeeps3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040171
X-Proofpoint-ORIG-GUID: J8s9dANaYHo0xk1A6BICnQpVQoEqIfH4
X-Proofpoint-GUID: J8s9dANaYHo0xk1A6BICnQpVQoEqIfH4

On 6/4/24 12:59 PM, Jarkko Sakkinen wrote:
> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>> The routine slaunch_setup is called out of the x86 specific setup_arch()
>> routine during early kernel boot. After determining what platform is
>> present, various operations specific to that platform occur. This
>> includes finalizing setting for the platform late launch and verifying
>> that memory protections are in place.
>>
>> For TXT, this code also reserves the original compressed kernel setup
>> area where the APs were left looping so that this memory cannot be used.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   arch/x86/kernel/Makefile   |   1 +
>>   arch/x86/kernel/setup.c    |   3 +
>>   arch/x86/kernel/slaunch.c  | 525 +++++++++++++++++++++++++++++++++++++
>>   drivers/iommu/intel/dmar.c |   4 +
>>   4 files changed, 533 insertions(+)
>>   create mode 100644 arch/x86/kernel/slaunch.c
>>
>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>> index 5d128167e2e2..b35ca99ab0a0 100644
>> --- a/arch/x86/kernel/Makefile
>> +++ b/arch/x86/kernel/Makefile
>> @@ -76,6 +76,7 @@ obj-$(CONFIG_X86_32)		+= tls.o
>>   obj-$(CONFIG_IA32_EMULATION)	+= tls.o
>>   obj-y				+= step.o
>>   obj-$(CONFIG_INTEL_TXT)		+= tboot.o
>> +obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
> 
> Hmm... should that be CONFIG_X86_SECURE_LAUNCH?
> 
> Just asking...

It could be if you would like. I guess we just thought it was implied 
given its location.

Ross

> 
> BR, Jarkko
> 


