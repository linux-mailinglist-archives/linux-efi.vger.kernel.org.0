Return-Path: <linux-efi+bounces-2933-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D19A57257
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 20:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3580D172563
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 19:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEBD2561A9;
	Fri,  7 Mar 2025 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eyeQ8NmI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bdUR827q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E1255E44;
	Fri,  7 Mar 2025 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376582; cv=fail; b=J+LabmadOALxM85aUP7FGDlJv8k0TbQboZrppY9LYAQCXnBHyHRZP6BdCKbArQZeg3Z+cRbsbLpipz9udTpWTK/aN3XCmorZDVjdElYMFbcb1jRtb2a4MSrcy1BgEcahQdJyBqzGWuq54Fd+t+hOY9swLdbcceYSjbGV043nY50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376582; c=relaxed/simple;
	bh=Kd6vm+jGFbWa3l0aT6EyYzCtINsiV+Byyk586QYKyF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s0SA4VY8rzBRTNWrcV6DDGQ8k3hA+alQ8TMZrehSpTaRNpSH8GUu9mxYWujw4NkdYtPMyKz2PMkd6EjyQYwNweFc7/3sFYI6+Hl9z6xD98G/BEmSujmTtIcsO6kaggN5j0tX/4Oh6mmzIzJGhwve3Sl/4W+k8IdcR4CNoQP+uLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eyeQ8NmI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bdUR827q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527Ithij018072;
	Fri, 7 Mar 2025 19:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1FL3UyKhHA+rUF5xJ+K7uD9ws8DCnimY2dmR9TUVF5w=; b=
	eyeQ8NmIgOOMOAnNshDS76wY5FkMjE6ZOr0ruql3b1vNc4VKU9pVBlnsXhVtQ2Oc
	CO9oDD8gS1tWNLXj8wbH8In9PlVP7ha/F5FGHYwjMhRV+spYEZfeq77Q/Yw417fG
	H6M+1gz1r9bY5qi74tAGB5GPh0jrh/gaWGYYBQjGooFkf4ANA0N44NYCal/xUVem
	HXkHNEhikfgx2y7EP4E/AG1z5UfFXnaFoiDWTW6D+EsKFAhNrYGeJLQZnTxEC/Rq
	xsTJaF06yCtRP+vKaseArejg8gJ/Hm9dBO7TxWBZo7g3l8McUnzCmlf6s3NR0LXW
	T0O5PpxgSfiFTnzol6UrWg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u825298-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:42:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527IMWMB039103;
	Fri, 7 Mar 2025 19:42:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpemgt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:42:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLfD+rGNv+PSRo7qjiqiA/9+zjKBHpsBbJlJCbzd2Awe0/fCuPMsh82EWig924ZjFAirZAJXsRGyCVdN5s/skIJfU6Oov/zf4NxK40SeiblR7OY6CXvT99iZtEDwsVkHJuJc+RKSLpCQ4vKOlr6JnWNuvaO0ICLvPmrJnP9o1XwEZmASO6WmUc87jT6qiaJXNFkAVT1aXYMUtzZA+0R786ncnGD/DQkjV/NH4nG9Xh0TD21BlsJw4yf1eft3V3ysWHbb6SBAJVkDlftpYgRIX5nvRVBSJuouJuTBby7iBN3zHxw3Unqi/2IwK4JjgVhAq+6+yVn/no0EzRJmbdfLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FL3UyKhHA+rUF5xJ+K7uD9ws8DCnimY2dmR9TUVF5w=;
 b=T1d7bm3glqMv7q8eQIAJXY9KYescmijiM8792TbC5bLfyzlYCYeLBilqlVgpLFC5rYfVJa54eKpeO6t0yIAnf+QV1UzgOZTapbjG2ADo100ldImGUNP8TkApbh+c+UxwSPjb0Z5oIsdGuYCxKaGmklYNiEoxbtBq9sQKICG2aNdSGBMVqRUo5rUKS489cGhkJBfk80eH8HU3tC+H1+9b0zuDFjFxeTNAuvPCHo0U7eY1MQUK3J4Pa1/oJU6BiTWEUJuk8Q+M5d29INfBP/UYZ9iVIkJ6xsXdSHcY7Yew8BFuj9ouJT7z8LLgXysvjnRkNysQSE2LZzIl5wqKR2l2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FL3UyKhHA+rUF5xJ+K7uD9ws8DCnimY2dmR9TUVF5w=;
 b=bdUR827qP07Sn36QVjpQHy8AN4kx7c9lZFp/YPdQ9F35YWAoUi/yg5ZDDkehIAhLo2A+DFuFF9i0hctTLAQKYo25ly8k26Mrk3LXt+Uc/qj6VbnV9BAiWzvHJJHc7tWXqL7uGLEWg4kl1TtXL3Om8BZ0vllYIb6e2Af9fwJg2Xs=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 PH0PR10MB4632.namprd10.prod.outlook.com (2603:10b6:510:34::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Fri, 7 Mar 2025 19:42:10 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 19:42:10 +0000
Message-ID: <9f22632f-6c53-4021-986e-bb4fdd566646@oracle.com>
Date: Fri, 7 Mar 2025 11:42:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/19] x86: Secure Launch kernel early boot stub
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
 <20241219194216.152839-10-ross.philipson@oracle.com>
 <Z8qZmWhSdxCCU_Fm@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z8qZmWhSdxCCU_Fm@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::31) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|PH0PR10MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff8eb69-a982-4e61-7533-08dd5db02704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEdsM1hXeTR5SHczajNscDlKbGZDdVRyYmhESjU2cDh1QkxVR1VPQngvWDBw?=
 =?utf-8?B?L01FWnlsaHRleHNlVzdOVzFlbXp5RFc0T3ZadTBxUWswRFgvTmhIU0hoYmph?=
 =?utf-8?B?NFU1THNYVEUzOTdEU0R6T284aTRvMGhyQlhRQ3dKcjE2M3FETG13VThQWVFn?=
 =?utf-8?B?ZDVmQzF5TDUrMmZMR2wvRzB6ZEprL0lqWUVNWWdPdjQ5OXJKczVlcFppWE5J?=
 =?utf-8?B?YWpQZFhodXU0Mi9Bdk9mVERvdFR1Q3JLd1ArVkJmNW5JeEQwYTJFTXV0Uith?=
 =?utf-8?B?K3R1akszNzBxS3F3Wkh5VnhXL3VmWVJ2WkNJTWx0YlhHMkc2MVR4SUNidytT?=
 =?utf-8?B?TFMxRDJScmQzckFteTJOUmdodk80amd5bFoxQmxpRWZMTnBkb2JEWVU0N1c3?=
 =?utf-8?B?MXp1OTBpdTh0MUlJOVpWU25SRko1V0FZdHF4WDJVMW5Wa1ZWdmoyejJRUFBy?=
 =?utf-8?B?SHpoN1I1QkgrRjI0TmRHL0FEYmgrVlBxR1QrSXNiM0xPTVh3SzFCSEgzZHpw?=
 =?utf-8?B?WkZURUN3WC85ekJVa2pjc2dUTC9Nc3MvcUpON29PZDhOdzRudGZCSThkcGlu?=
 =?utf-8?B?M083RklCZUtxb1pRbnQ2ck0zUUU3S1F2ODFyOEFEU2pBYTI4bkhnRzkwVlZD?=
 =?utf-8?B?MXRpdThzMmxqZ2hZdVV4UWZnSWVnL0pMcTI2WXhOT05lVmI4UEJ0Y0F2MUtR?=
 =?utf-8?B?U21nWUdGbE9wS3YyUzF0WUxlL21yc28yQjJ0Sy9idlArQ1l2bERJSndLTUVh?=
 =?utf-8?B?cS9HWFRsOWk4VWVabSt1cHdERzY0bFRLVEVEOUlLcGZCb2JQbHVGV0k3WjZO?=
 =?utf-8?B?OUNzNjFFYmlLdWdRVmF1Nml4SElSQWtMZ2REWWplSEsyNGo5NjhqK1g5VVF6?=
 =?utf-8?B?Y0crU1hHZkNEcjBiSnRRSFl4aFJXM2Erb3EwZ1BnK1pNS0hqbndQeVh2WCt4?=
 =?utf-8?B?WXVnY28wQ2FZa3FIMUg0MWRZY3lQc3J0M3U3ZW1lUmNKeVAyQ0E5b3Q4WnE4?=
 =?utf-8?B?NzBhSXBrc0lVdFhjZ0o1OWExMHhtYlVGT1NBODVKVEpkbERKYzB2NU51OTRO?=
 =?utf-8?B?MUdCS0VPWVN0NnVhS2ZKMkJxTlNKQzhhdktRaldFSnE3RDFKRG5YN1RGSGNl?=
 =?utf-8?B?ZVY2VElSSlhHUUxqNTdidTByMGZXRTMzcDExellLNHFFQ0tHbnFPMTRkRWIz?=
 =?utf-8?B?c1BWTEViYTRFZVZiVE9UR2g2RFRrVDlXMWF3aGJXNUpobkV3a1JEUWNub2VU?=
 =?utf-8?B?eG5KK04yWWYvcnlOai95YjNidmVxNEx0RFB3TTlQMUR4KzB0K3EwME5acFFj?=
 =?utf-8?B?RFlTSUlnb1NqYXZGYlo3NUxVSmd5akhSTWhobEhRN1E5aUtxUVdrTlMvc2gr?=
 =?utf-8?B?cDdoQjJyaG9MS29hb2JSTVVPM2NXQU8vUEg3Y1pIMEU1ZHB2cFh1ZEt4Snlu?=
 =?utf-8?B?TDZSa3VoNkw4ckJPWkNuWTRGY2N6TkpjYVNvS2pUWHVWMllIWlYxWGhOYTJZ?=
 =?utf-8?B?NVZuNlNKc01ad0htSzRtbisvWElLRVpOdnp1OWQ1YVd3TnJoREdoR08za3BX?=
 =?utf-8?B?MG1Kc2xsY21lZlppazJMNjYzb0JwQWpxbWpCMjNmZi9Jd2d6RnBGaFVvM0tl?=
 =?utf-8?B?WXp6bzJ1NXNLZzZzZDBJQVR5NmJ1K0NlZ0JvaDdZOVRjdlI1eURCaTlJM2RL?=
 =?utf-8?B?Ylp2MEFxWlJhODZRQ3JTOVZmY2RWWWVMWGNrRmVNeE1ob1huNHpGNUdaNExv?=
 =?utf-8?B?WStoSk9HdTZZS2dkbHdBK0FUaVM2b0t1VDJVbmtKTkI2Q0RnOWt0cXFOS2Vu?=
 =?utf-8?B?eFdkcUQ0UWE1cDV4QklVVXh2Q0k5STd2bTNZcmRnbStNNkQvZmxrVzMrVFdx?=
 =?utf-8?Q?AIKIHMj1PnEuK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzFGNnM2WDhsQW95Y0dJYjRkV1BkemNRS1dMZkdEdGg3eENKcUJmb01FTzJm?=
 =?utf-8?B?dUQwL1k3T0d1WWw5Z3lnY2hlTmZwcithR1B1ZnNrQ3ZoTm95V2hKYk94N3Ji?=
 =?utf-8?B?YWk0ZDRXWHRMMC9OTm9zRWtwVkJ2ZUFueTd4UWlhUXcyMzBVbStPRmRBRkZP?=
 =?utf-8?B?c2s3cXVEclY2N0pES05kNnNDWDUvekVTRitsNWNnVVJ6YStVT0pnSzMvbkZp?=
 =?utf-8?B?REhsNTlKak5HWk5QS1JmVmlmdGNaZi9qUUdpRGdOc2R3UDRXak1ZTXg3VzNP?=
 =?utf-8?B?b0wrVzNiNE5yaXBXVFNYM29RaGVGNUN1SVl3cXlKT0FjNFl3ZDNBVUU3RjhZ?=
 =?utf-8?B?SXVjbHZTL29jZDg5cFIydGVKZXV5dnJwMVpFMGpUNHhjL2JOYXBxejFSNDVU?=
 =?utf-8?B?Z2d6NnNTMDUvYlZxVkJqWTYwVHZKN0YrNHBxcFg5TlZlVUg5NkhZZmhBREFX?=
 =?utf-8?B?Y3hxWHZSQ3JsR21aNjNpL0QvVUVPQVFyMzhaNjgwcitqeWdNdUt2VjVsZk9r?=
 =?utf-8?B?RTl4cHVyU2FUalpDek5CcFB3RDlqVnFVcnoxYktMcUxXQ3pxeGtXNTlzTEcx?=
 =?utf-8?B?TWRkWjRkNWtUdHBuQ0pUK0dtRDhjN3QxRmNLd0p6TmF0VXliMnQ0WWVtdWpP?=
 =?utf-8?B?SzJsVnV3Z2Z1am9OMldoSGZCbm9idTNjRFBMZ3BOTGxpelhrL1VCWHVwTGww?=
 =?utf-8?B?RkwwTjBJY1lpTGhhUW5xQkVHQS82VGFXTzNPMzlzRlRKaEVQTWNNTzAvNmRu?=
 =?utf-8?B?Y3F0MUhCRlVLa2J0NVo2cU9jWUNZeHFTa0Urbm9SOUsxMG1vYjc3YUdDV0Rq?=
 =?utf-8?B?dSsxVEZPRTlFUDEvV3dQbS9PdUYyb3NvK0pzVmd5bVFuNFN4MWNVNGJqblBY?=
 =?utf-8?B?M1I3WGRNWC8vWmdHMzF2R1BUVHFwOTE1N0h5ZlJyOGFCaDFOOFBGSy9PMll2?=
 =?utf-8?B?Mnk0TyswZEdqbGxod3cwNmJDb0hFOHdCTlMzMUp1eDFZMW9ualhlcXRmMTZZ?=
 =?utf-8?B?dmU4TFZUVjZlQ2FhZHJDbldGOHRjL0tKU1V5ODRLWFVvbWlhVXMzQzJOemV5?=
 =?utf-8?B?R1Nwandyb1BTUDl6a1JvZlY5VjB2d08vQ2gvM01sVXlCMld4cnNUem9BZU5l?=
 =?utf-8?B?QWlDenRUZHRXTGVGRnQ4cDM4MDh3NDdoVlhkQ25WRzhncGU0Z3h0RjVlczFU?=
 =?utf-8?B?UmlVQzh1SzRreDNVNTI5Sld5ZTFRdXozQWo1TkNDRW13aFRMNDJNaFRCY3NR?=
 =?utf-8?B?cGgveFBPUnVnMDgvYVBXR3dCRTRvRFpUdGtwdVhMbEpacGd3eUxsaHNXemVX?=
 =?utf-8?B?U3NrZ25obmtJTVZneWtwWFFBSFkxdXd5WUR5ME42aHJtdVRNV1JUdzBsd2VR?=
 =?utf-8?B?ais2WGxTeHJFcGhHeHltTGRxb0ZDdFRoWUwxT21WTGNBU0lRbGVDa3U2MjMw?=
 =?utf-8?B?NEVhQ2ZqUGx5bjJidlY0K1k2ckpNUFg1SlRhUWRJc2d4TjREK0lEbGwydGpx?=
 =?utf-8?B?djFHN1NzQWt3S0RXY2NBVTJlVjNtdmNvK2pBaWdmYU9qWGtacWhONTBDdmgv?=
 =?utf-8?B?UTdiVHB1cGladkcwSVdUUHl2NFpSRHdXZmxLM2xwaHRJQVNBZCs3VnBSQ2JL?=
 =?utf-8?B?aStVY3pPdjhsVEloT0hacnk2aUt3cHRDRzh0ZXF4WUtzR1I5SFVwNlYrVThq?=
 =?utf-8?B?QTd3T1UvQU5PWThnTkZQQW51Y0tGak1QUzFMa0FCSGZnRnBFZzZhd0tqc1Er?=
 =?utf-8?B?bTc1QjRMRGxOTkxLZzdOVXhrRi9QbUt0M25sbVY0d05DY29uU1ptbWI5d3RX?=
 =?utf-8?B?OWxLRHNzckxoYTR1b0hRSUhBcGlmekpFUDJCVmJGcmZFQ3JwMzk4VktvQmdE?=
 =?utf-8?B?b1BobTN6SWoxSVcwdCt4aW84Wlc0S2xEdDJGeGE4cTY5dFJidHloWmgwM21J?=
 =?utf-8?B?RTFwbWxkYlZ5TFBQMzVKWFdhZ1prQmFvV2FQWWt0MTdoazAxQkhOc1BVOTRk?=
 =?utf-8?B?YWJKVEJ3MnJDcTQ2dWYzYjlUdHRhcnM1aVRaV1Y0Vzk5VjljYzJtZTFheldN?=
 =?utf-8?B?V3RIOE9kY2lVN2xiay95OExxYmVNUWJIVVdYbzlDaGdSWkw5R2NUUngzNGp5?=
 =?utf-8?B?NDVTdXFmeTdUR2YxUWhIZk9iVGdKZmt3VjI4ekg1eEliZVJJTjlhQ2xyNUY4?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ePcozkmlsqc2I+As3gaNZqA+T8b10e5uUvZpEjYkjsAruOEzA+11dsYqdxfkcRbH0x+QIdFllHKLpWvj84dxByZ5L3M2/lOdWLlYUktF8m3kjC5Bs8UNC0hEUTM15lafn2pKAL6XkhkiZIFs9hdPeJcgPm2LqpepN4lP3z1J4EBul+V7xRTkV9DbLFFjGMrmlxDu+cV+DDxadKmlE8voSgSk1/W6Dqe0nKR7aUCCdZNS05C243Mt/e5tqIL0/tgl4tnkBQXDOd6cWIv0LnBSfodRHPX2QrlHRFMKxwPtsSSZq9y9s8pabiwnyrHG/8Sgylf/27v9dUPIP9REqkaHAN9QkkylnTXaPWFEJ6PErvyCv7w2wl8+ZJGZ9f0FHNh9hKwXBiBhbvfeQcuaT8ubDYMon284TUo/s996Afa5egNDxkWAy9qo9DPehJfv1qTKCbxJFTzfzwj4tSV0Hx+1jMXAInpcbft2kN84G9bctBxNVgZ1pxrHEGTymdZ6WdmnE2VlCr+VSqxh4CKDRBi+Z7n7lbBYAtlJgEVZ6uGlw8WPwvVoK2IWYDs6wpnpyHHHfUl7HvchB2hINPxjpliAx/vuF7FkapIFluVFy48a9dY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff8eb69-a982-4e61-7533-08dd5db02704
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 19:42:10.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QoPVU9s36jrsr++yflY3a2OUsMiwdIFmKxG4uxqABuRLusuXRToIHXY41xAqj5Kr7STZ9HDEk2sLJYWX3nGu34QogapaWsQNRKiv7Ki4zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070148
X-Proofpoint-GUID: DQvQfbnfM6f7xvpccEqA4bqUA2TPuiF0
X-Proofpoint-ORIG-GUID: DQvQfbnfM6f7xvpccEqA4bqUA2TPuiF0

On 3/6/25 11:00 PM, 'Jarkko Sakkinen' via trenchboot-devel wrote:
> On Thu, Dec 19, 2024 at 11:42:06AM -0800, Ross Philipson wrote:
>> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
>> later AMD SKINIT) to vector to during the late launch. The symbol
> 
> Does "to vector to" translate into to jump into during late launch? :-)
> 
> Given the complicated topic in the first place I'd use as down to
> earth language as I possibly could where it can be used.

Yes it does mean that so I can to just "jump".

Ross

> 
> 
> 
>> sl_stub_entry is that entry point and its offset into the kernel is
>> conveyed to the launching code using the MLE (Measured Launch
>> Environment) header in the structure named mle_header. The offset of the
>> MLE header is set in the kernel_info. The routine sl_stub contains the
>> very early late launch setup code responsible for setting up the basic
>> environment to allow the normal kernel startup_32 code to proceed. It is
>> also responsible for properly waking and handling the APs on Intel
>> platforms. The routine sl_main which runs after entering 64b mode is
>> responsible for measuring configuration and module information before
>> it is used like the boot params, the kernel command line, the TXT heap,
>> an external initramfs, etc.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Otherwise this is looking somewhat decent!
> 
> BR, Jarkko
> 


