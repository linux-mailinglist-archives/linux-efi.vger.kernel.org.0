Return-Path: <linux-efi+bounces-2930-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5FFA571FC
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 20:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE27A3559
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382F2505B6;
	Fri,  7 Mar 2025 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tc89LzJd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Po7Mu+lg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1F6241691;
	Fri,  7 Mar 2025 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376202; cv=fail; b=Yqu/vcZbUE27M75mHoYH4dd52m8BeIkiym5XSaBiX6o89SJv2CcC2eRFgdigTOBfa/pDzWrNnoaO73VbTZQcxcrlwCReiKJ66DFHf86Kdil1OBBeu85Q2RkR03/35pAsZh88QEOpiut6tb2/evQWhOWEWxkX2bEeTxAXUmTqQSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376202; c=relaxed/simple;
	bh=I+S6K+lBJWglmHV3YI2iJ6wXPosQGTruTszDR+j1eVs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eQxNXZIDMduy7KhOMMnvDah20rOQMP1ftYCOZwfs3ok1fB73qj5TGPyV3a8G8ddjkAJWw4pOgiqLBTt2CtNFW8A13fu2oIliem/sy8wj4RgjG/nqwl67c0Zhklq0rmNIIo8lvGjltlBaHKq1Y/gqQAC1LaTeaVzYrtqTm+scOc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tc89LzJd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Po7Mu+lg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527ItgUg020946;
	Fri, 7 Mar 2025 19:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BSOhQlT8mepkfIkubnIMKmc6LOgCru2lkjl79QKnR30=; b=
	Tc89LzJdKl61aBvk4KYUVj575ix81Gkqf8ihb9QsnxWaal5KtwUardbYnhP8ASV8
	s08prUJZVJ+d1GHv4/pBdes83w5/pilSFF/mt6mNUuUCkNId3bIbv9IlkCeIq7Py
	0Hn1sh2mIemz1CSWrz0M473xj3OSkKY0nY2Yq/Zvgeu4n8F6OrqF0EK5SEslx2kf
	K8Ju8cNTlc7oTUNdKx8cO9D+tfNRfZsie0nVTbEktbBjRNYpZZo4jsJnqPj9kkMm
	1jgrL10oKl/Lvl0VoKZS/xGTrbGMMMQEex0i4kVo2GtCpXtvdbiKry2mixGUC6hH
	Bl36EhmENd8ALD3JxD3QXw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hmxjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:35:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527HdQRo038291;
	Fri, 7 Mar 2025 19:35:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpm7ast-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:35:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feaWwEqGK1QuHoLGJcuwW8jeV5xMcQWqZkMbdRU+1eC82avOY2zM55fAPg3t7Zvqk1kkQf7JaZNFCbOqCPgzTg2nc5z0VjC0FNpo3U4sH9efKnWhY+uWulQEMXAzcUfanVl3JL5XEydY0hBY72yJIVCBBsGSJL3twfRtSY7Oxa4pRhxswrtLohOblryfaODtZmty4COAVUNy8URFPYwI+XPg4ktt2iDYvSwgtcSkXKro/R/v1ARWe/BiN1HhjOtY9ByANziVqrOyMrnUnx7x0Rnf1akuFQHqSdYgzQFqJVcDXIKobQZFB9bHNSrcF+/tNDjNuhkO6fFNv8dHLUVwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSOhQlT8mepkfIkubnIMKmc6LOgCru2lkjl79QKnR30=;
 b=PkYcxEZCbGNo0WzfWLll1wYTICz9q5IBrG58mxN8nrVwRKjixu/8SYaNh6v57Nq82QzsxzHakWbwjw43Oq4Y3xHSaU+5EI6xJTkUt/DFN84qlY7kgq5U9vMlyzeLJXwk08z8SbCkaB8IoRUEIAjdfdtuv3oYQeWD/vm92OyZQVCPVjHuKv1L0fvp2K+Bp4z833cRT39HZi0ueR+77IukJ9kKVWNDWp0Njov3YJAxY+iDdSkaW6UdhSc1IHTv5Gwk/v7neIxMgx8NLvcPcpNMl8TezreVxsfxN37aFKIDP4QTGWyt0D5r9qj3mM6dCdS0LoqkCTDJjz8bzAPFrQgF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSOhQlT8mepkfIkubnIMKmc6LOgCru2lkjl79QKnR30=;
 b=Po7Mu+lgbXk6RpstlTatVGspoDVWTlU4DYB9CJKzU+AYKuLwil7LsaplCLoHTs19kQwXG4AzZIfd28Q10jsIp4z4Zthsy1txIBNQpx1nWg7V08chfqJ4s1/RlHzH35BS/zSbUTkmPHADy9Qe9+TyP9mZGBeZDktlHUcIGfWFIpk=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DM4PR10MB6160.namprd10.prod.outlook.com (2603:10b6:8:bc::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Fri, 7 Mar 2025 19:35:56 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 19:35:56 +0000
Message-ID: <ebb40034-2b82-40a0-a3f3-1ddca24780f4@oracle.com>
Date: Fri, 7 Mar 2025 11:35:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/19] tpm, tpm_tis: Address positive localities in
 tpm_tis_request_locality()
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-16-ross.philipson@oracle.com>
 <Z8qbGZwi0yFyus0J@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z8qbGZwi0yFyus0J@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::32) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DM4PR10MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: c08c491c-2a03-4427-f349-08dd5daf47e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUZlMTVNMTYzMzZkd29TM0J3eVdGOXlDMzBSV2sxWVAzOUZKMllrWmw3OStO?=
 =?utf-8?B?b3Rqa09mRm9PMUhzamRsWXdQZ1FIaEJsK08rckQ4QkRoN2JCbkd1YjVsNEFa?=
 =?utf-8?B?djV0TWhWZ05JQlptalJEUGhobndtb3FSRGtCNlQ3OEM5Qk9vV2w2em9xRzFP?=
 =?utf-8?B?TGg4ZFk1SDRHMkE4MFlIcDJEK0lWanZYK1FxUnpWWjEwTWZUUVhBMlQzdmt3?=
 =?utf-8?B?ZEV2ZWp5RjFQY3p6a3FzbS9iUlMrVjY1QmQ2MWMzOVFFdUVDeVNtWUVOWHdS?=
 =?utf-8?B?T0M1K1A4aGw5ajg2dXozeFZiUDZoeFlBQndQZkFTWFFORzdZOWRFT3ZMNERp?=
 =?utf-8?B?eG4rNzhGS2JYcVZnUkdaU09uVVhncC81QStyMGlVeWQ4RGMxc2dWQ3UyUVVk?=
 =?utf-8?B?N0RjZXlkdDgrUWV3M085SU94WU4rdlpQYVUyT0IvekovREZXeWRNVDZsWCti?=
 =?utf-8?B?RFpHNjlPT0NpaDM5Z2RRV2ZFMjRrMGxqNmhLcWxwL2Q0L3paZEhWd0V2Lzlm?=
 =?utf-8?B?OXZFdHUyMFNGWDM3REF2T0JoZ0hQdEZmMjIveC9iWWtQVnNpd1RpTTRaU2cv?=
 =?utf-8?B?VkxrM3l5aE5zQkNxMVRiL3paL3NXSlMwS1Z1ei9mY2t6L3oyRTRxNE5DYUFB?=
 =?utf-8?B?Y2l5ZjZZTW9GQUNONGd3QldNMzlzSTJjYVlNb2F5WGZVUWNYRmFyRkR6V1FB?=
 =?utf-8?B?dHFDc1VVdks2Yk5ZaDBlSVUzcFJBRlZnUGtJTUdvZHIzVFM2SEwxSU1Uc3Uv?=
 =?utf-8?B?RTJKTDhCalJOeFNxUi96SEpqaW52eHZhMTFnaTRaS0QwcjNKcC92TlFNdUJR?=
 =?utf-8?B?Ny84Ly9pOGp4OFJzQXdEdFpXVC9MVjdGZ1dnQUw5dWJGOU9DQnJYUEtlMlc3?=
 =?utf-8?B?bk1QaU0vSDUvblg1OU9oMFZHWFlSVDdMSVMxUkhsakQ4ckR1SnNoZm9hWHly?=
 =?utf-8?B?TXJ3elVQVmZqdmFoRWc4TUlzZkJENmRKY3Fza0tpbmhYZGl0U29qNnIvKzkv?=
 =?utf-8?B?eGQ5WlRPSXFCTFA4dUt1d0hQRXlScXBtS3lBVitFVTczN1FuVXlHRk1sdmJC?=
 =?utf-8?B?Q2ZFVE1FSnF0Y2F3LzExRURyN3NzRXZYRVNFajJkbDBNSFROR3BvQXFBVWNo?=
 =?utf-8?B?bVNxaTRVOFh2ZzBYU2hHK3VTdFdjRjJLNjNFUTFMR2JGb0VNUlByZlEvb2dl?=
 =?utf-8?B?cFZNeHgvL2lpSW5LUTlOL0MyRy9vYlhxZzJyYVljdWUvN2lqZFZBemladlU1?=
 =?utf-8?B?c1E2aEJRSTZ6RHJyM0xzZ3JGSUVRb2ZzQldNRUNTaHRoYWUyMnFYeXpYSmpn?=
 =?utf-8?B?dEtXSysxTWJlZ1lublRmMjZCS1NYUG9uVkpUd1ZQcVJYTVIweStLOEhZUFA3?=
 =?utf-8?B?WmF2WFg5U1pKc2MxVE5ybW5uL3g0OS9HQTFMREp0T3RCeUNhRnV4MTJJU245?=
 =?utf-8?B?azV1U09zK29aQ0hvaU05RlZYcDFjYjRmR3B4Nm51WWlCTUxkNVFEanlVbXJR?=
 =?utf-8?B?UGx0ejRTcnI5M04zOFB2WFd3UksvN25hL0ZyblVGY01hVkM4aFFHbFpoMDd5?=
 =?utf-8?B?N3ZGeWplcG5OcXNLejdzN2pCM3loUUpQZGNPN3liRFZWZmlGQm5NR2dPY1ll?=
 =?utf-8?B?UHRDSGNOb2NjalRRYVhUTU5vbzZEVlNjT1NRbk5pSzRobVovU0VGRURINS9n?=
 =?utf-8?B?SC9PUElVQ2wwRWwrUm9ueUwxMTRFTTJoQ2xlVWxmcXpFL1F1OUNQRjEvTXVy?=
 =?utf-8?B?cThKbStUUStVVmZnL3g1dnV4TG9HSDc4R0hMOXFQdTgxcENGUlRNaWEwQWRI?=
 =?utf-8?B?ak9ZZEVLeXpTcmxDcEVXYUVGYmpFNXV0bnI4VWMwUmRlMy8xVGZQKzZnaldV?=
 =?utf-8?Q?J3hfZCHVwcPgO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFdMa3NZK052bHlsbnpCUWxvbGhEM3I4b21WZDNnc3RtU1pGRG8xTGhVU0Fa?=
 =?utf-8?B?Q3N4bDdUUzN0T3FUZ3gyTFlTcUl3TVJLTTRyNEFWMlJtcEhsWVJyY3dMT0Nn?=
 =?utf-8?B?R1VZbE5QM25GTzM0dk1UalQ4c3FZN2RSM01EWG1hODc3YnM1K2xQZ2hUMGFD?=
 =?utf-8?B?WndqMHk2ZTRNNnJBUWQxcTIveXRZbGFFR3lzTUFwVjZ5bitRRUY1SGdHcDN0?=
 =?utf-8?B?VGR4Wk9pQ2RZa2FFaHh0YVZBSU9YTnh1U1pQSVJDa2tXbnBvb0g1dFc0Nlhi?=
 =?utf-8?B?SGhidFM5QmtjRzJ2ZlRrT2UveGM0bnZMcEVUZGhlYlhLa0t2TXFJSXpIL3Vh?=
 =?utf-8?B?Y3BMZ3hsS2R5M0hyQ2lYbTM0SHNiZHEzOVErUkh3SjdvYjkvTlpDaFZNS0FO?=
 =?utf-8?B?RlhsdXJrbzc1dnFqOFNNV25HR3JDZEIxdTlMenRnbGQ1QUQvYjVIMkp1bkUr?=
 =?utf-8?B?aHhjWm5PU2tkejZFTDM1QWVIMU5mb05qV3MxZTYrTkloUk1XaitGdFVwUUhO?=
 =?utf-8?B?aDM5RXZnWmtuWEU1OXU4U1lrelNZdDhidDVlR3cvR2dtSUZaMEJROEVMYWx2?=
 =?utf-8?B?bndmeEQ0MkFsZkYzMU1HNEVIZGpML0poam1DVXVYbDI1V09ad0NkbjhaSVNY?=
 =?utf-8?B?NTBzN3RScmI5Qm1qVXhnUmkrangxWnRnNEZINFpUS3ZXRTUyMzVtSG5mbUhw?=
 =?utf-8?B?NjJBNTFWbm5JbFdlNHk2K3pZUm0rMlFVNEU5a3JCeFJIL1BqMllhc0dCeTZF?=
 =?utf-8?B?VjhzRVJiQitsM0IrWTZmekM3cjFuc1M4WXF0blY0a3QzbHF5a21FYk52MXd6?=
 =?utf-8?B?N0lPbVQ3a0F6R2IxV3BTcjc2aW05cGhJU3UvY1lxMmQ3WkpTb2UyWkZ4WXkw?=
 =?utf-8?B?MnpmZTF5bTk2ZEM3S3NVSlBmQXpGeHlXQ3RhZ2xtUzRNY1duVmE5VDU2UHU4?=
 =?utf-8?B?TkhDdnRvVzYwbXpwckErNEFod1duWWhnbit6TmlyUHd6ZXdaV0JiSkRzQUJr?=
 =?utf-8?B?Z2V3VjVGQ1I4SVliNmJhOUZYVyt0czluTjNkdFFkaUEwVHJjM1JTUG5FUGh0?=
 =?utf-8?B?S3V1M1Q4RW5BRDJuMHcveFM3Wnk2Qkc2RE9DMmZKUjJUSDVtY2V0SkVYNitm?=
 =?utf-8?B?QnhCT0thMnl0WXVKcTZ3bG5WUG9oRTFycmxBUk4wMXZzUE1KZytxcWxOU3Ir?=
 =?utf-8?B?TUE2c2N3MTRBOTdwanNCdnB6ZzlMZk1RY2ZINmt1bHUrOUMrRUk1bzJCaGZP?=
 =?utf-8?B?QXRzTkVacWtnbjR0Y3VYV09rTkhrY0tYS09RKzRPd3ptQ2o3VVN2L1hoMWhZ?=
 =?utf-8?B?MTI4RUV5VjA2aWJ2MzJpelVQUVFnSndOTTkwRGhvcWRWZ2t2aFVteFdNWnZz?=
 =?utf-8?B?L0s1dDlTYmpwMGhtS0dDSmkxU3hJbFZOa0lMVFUvbUVrcTFnVHROMEFRNmlo?=
 =?utf-8?B?YndTcE1TcXBOcHlzQlJJVW1XTUV1UFZYNkFYb2owckFieFowU2NScS9peE5h?=
 =?utf-8?B?VEN5aGtKM3I3WkFMeGJ2eHVQM3MybThjb0ZBOTl0TzM0THN4dDZSOWM4NlR5?=
 =?utf-8?B?cXZ1V0ZKMFd3SUJTMFZtUDE5eGdiN09QZmY0NHVoL3UwSFJxWUhRTm5BM010?=
 =?utf-8?B?UXF3bHdRQTkwVGh4SUxseW9lSWgrWlhHVWpSSjVyQmdSVFZrV20rakpDdk44?=
 =?utf-8?B?RVJZUE1zRWpvdnRrYkFSbGNpbUpERllya3AxL1pNb1JMUU9tYUtpWFFLZmZ4?=
 =?utf-8?B?eG1KWDd2WlNjTENURENwVHBpbmNuMUJrWEpzM0tiSFc3VHQ1RkU4andNajdR?=
 =?utf-8?B?bkw4SlM0bVJxczlOSkJra1FrbHpaTEFybzhxTzhSSXN1T1ZxWS9oMnBTMUtM?=
 =?utf-8?B?Z2FlOXd3MG05RWt2cnYrYWgrdWRleldQUWF5bXp5YXhVZTNwTTM3dnU3MWhw?=
 =?utf-8?B?TGhuTG1hY0l4MDlvV0NmOFIyTDR4cmNRZmxHNDhVL3NIOFVjMld1bGtHczQr?=
 =?utf-8?B?ckV5bmhaTERGOTJXQnR4dGVySlUzTWFlSE92MG53QzNVSDkwN0EwUnA3N1o3?=
 =?utf-8?B?RFArbjhyNWRvZnlsZmxFcXZuZ2dzeTFsM2VGdDNaL1FhcC9pMzRXRm1WQi9L?=
 =?utf-8?B?NWFQYjl0LzZ2SENxRHpqZmhPMlp1RXV0WUpQQS85SC9zUkVZN2tGY0VZSk1B?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EnU3WbDn+I5ZsiwRZmd25G2pbL5mk918ZTnXYUokUTnCxQwsV5xe9W+H88qTjnXg7f0E5CkG0F3eeI9Rf48o+/FWfNUwx9FOAEfwjLlV94jMlSQ63GQX5ZukWdu+D+4WZPOVBKvQAyMNM7pnpu/dGE8fAbqpKGU4UsSMaMEKXEf3xPGuy/Bgqo3vq4nwVZ9vIh7DbtTbTshJRBFrJRqxbyv3MnsjBbNgApAdwqqyNBAeza1EGIaEQfl0xjPvGFx1kDlNQpDxDULA9W8TFL/LhcuGpFaoGWbk/91D37yDoIS+CV+5ChsBPbKz13k8Feq8AkJk8YAOs/ctQI5LQ5R0P6SFrn9QILeo1Bbc8ctcoZTkwmfyidb0+m6i82euhjdypbR+FMM41YH4ToM9CLKiVjo3Hu1beon66iR3L69fqVmZixDl867Ga3YHvlnQBRq6VjBT2CH66PeCQKhz2JxPnOam3WD/mnoWKeHIrdADaUAWBTSxJ/cegjvl1+l4ydsNMXX7HJQ19h/pF9DKlrZBR6sKttx0Q9V4iDRSgiAdM9n1sbS23KLbpeFiMtJ40FujklwzHoOc+Rybm5jmSHkAS3KTz2gNunczutXk2u2xZI4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08c491c-2a03-4427-f349-08dd5daf47e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 19:35:56.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bj7MihRyD2dyE07WLiYuZCRWlRDEnPDeRR8V+JzW9Oh7Skim1BKhIjVnAXOJ3QAKFRKMTY+1NpWs7GoRuXxTA+zd1jrmxIkcf3EI2XynAIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070147
X-Proofpoint-GUID: OzZpwbd37zXTIdJhfnli1itrb1nsOwNn
X-Proofpoint-ORIG-GUID: OzZpwbd37zXTIdJhfnli1itrb1nsOwNn

On 3/6/25 11:07 PM, Jarkko Sakkinen wrote:
> On Thu, Dec 19, 2024 at 11:42:12AM -0800, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> Validate that the input locality is within the correct range, as specified
>> by TCG standards, and increase the locality count also for the positive
>> localities.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>>   drivers/char/tpm/tpm_tis_core.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index c58f360fb4a4..c86100ad743a 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -234,10 +234,13 @@ static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
>>   	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>   	int ret = 0;
>>   
>> +	if (l < 0 || l > TPM_MAX_LOCALITY)
>> +		return -EINVAL;
> 
> I would mind if we put do dev_warn() here because it is unexpected
> condition or even perhaps dev_err(). Or am I missing something?

No I think you are right. We will look at it but will likely take your 
suggestion here.

Thanks
Ross

> 
>> +
>>   	mutex_lock(&priv->locality_count_mutex);
>>   	if (priv->locality_count == 0)
>>   		ret = __tpm_tis_request_locality(chip, l);
>> -	if (!ret)
>> +	if (ret >= 0)
>>   		priv->locality_count++;
>>   	mutex_unlock(&priv->locality_count_mutex);
>>   	return ret;
>> -- 
>> 2.39.3
>>
> 
> I agree with this now.
> 
> BR, Jarkko


