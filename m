Return-Path: <linux-efi+bounces-2932-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED37A57239
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 20:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119353B9A55
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 19:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC4B25487F;
	Fri,  7 Mar 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="InFal5Q8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s2vEnSqR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00773254874;
	Fri,  7 Mar 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376413; cv=fail; b=QDdp/82Ushju1FsxVFpjX97ZM9B0SXXAuf2La0dLqU5xZwbaCMnsdbdCBJdn7g64AVgyYLVECI2ALsvMOeKSGzsSHqRtCajoipTvt+Dlv7IzwTOBfA63BJArl5jpt74tEFHRVEjIsjvUxOEdRyL/hbKlZJkkKou3XuEsoEkEvt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376413; c=relaxed/simple;
	bh=4u+X3/OdMco5bcmSiuMWYWVWf08oSHuI32jwHNZ73Ys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c38qostjO0xNVzG7LTkqHdmYFp2ZQIeBaulUKwi0NKK2SF70BWfJPH8uouhtqS+QdVsG+X6t+4BWyLaqb/Qr64LaCpN0qDayAGDkycWP5DpV6q3HIGHOImBF4Ko5Y/98qgW+pobrrcwDIA1gW7yMbl23N0V1Ak/YQXLaU7bQQxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=InFal5Q8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s2vEnSqR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527ItgV5020946;
	Fri, 7 Mar 2025 19:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SlFBABEAC8ZDaFX8YpxNiEHJ7M5Uw+KaCmb3F9vEmbg=; b=
	InFal5Q8GstW4AuC1C7aclDeNEdOk6VSU5k5lv3rexvTexK5iHkX9a6h10P6ecWL
	KZxpmJjb3LMry+Iidq0mH9bL7XCXp9qXN5gIrrnTFG39qluf9m2mHbSIgB8Hgptf
	XBVWpUb7EYR5a8TM5gfgIa/M5qLfKMuz8+qZkAvnH/B0Kp8e/5w3iu77TbWlftH3
	ZojlrDwpor29cBJIUBv9WMo1yxTOe9/JnNHxLU+qYS8f2eYnQH5tIJcMhU4tJWpM
	rnXzvBp20QELvdMWhoTo7nOl7BD6B3894G//nZVzPjaVdiErh6TApALiHYlTR8tW
	ZbIkG7NHzaNX9Hn6lULL8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hmxrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:39:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527Hq8wf010885;
	Fri, 7 Mar 2025 19:39:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpfje50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:39:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zC/ogewZGxrhUQ1LYlCXCzkPCipmOEEEWxKCq2roUzUU9Ftvw7jvUJuY0sDJrQiXFH2ArC+bOqWDK7xWbnyY+WtpGRBxbiFySZLnJYRbDywpUbHTC62JwTLyDGLkXyUoU0hEpvqwC+SXDmO9mK7k+EJN4APltSOBGBvjNPFjhYqRtLqH4ERyZso0hU4k70ZD9q6IIT8aKHefM9QdJE8vUgOecxDs92STTpku6nnBhw+gn1LxsG/IOWVhwdAUhN55Y19vISiSl6uRr+FXKZr1mvKjTiqdhlobVSmopkCuKapHHghIyG6jglAaiudUE6xrsu7FJC/jMZmMgm5JAHQHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlFBABEAC8ZDaFX8YpxNiEHJ7M5Uw+KaCmb3F9vEmbg=;
 b=C1XFDyp82IZckJE3lEIP7oWlzbSJyLZJg0LBkYMruQMGX8yPWPowyszAsltYPby0Dw1LQttcA8MIVCh/Y8sqC+qMTWkpivxDmHUvdZ0Bh3gZNhRdRCWcWatngT2BSVUppQ1QYtilEQStYTmeZ6sbwocYdxu2ffC1LwldBE8pwGEyqV0CTL5eRkPeYH8PnWNyuO0IADl2450vsqAokRoE6M3lnok55r92aYTZPHX6egouI0+QM1MILMcYp+owVI+OYAyDu1P3k359ppBvMG8KfZGMrvZNvqL0iCHXdFIz/e94jrAaQa6/pDgdJmvrwg/fcjFOVRlLquxtmYga0W3ZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlFBABEAC8ZDaFX8YpxNiEHJ7M5Uw+KaCmb3F9vEmbg=;
 b=s2vEnSqRSC+8uHrE2olkjX7BwCXgeUblMOZ8p+OPXByC10CChd1DVl8dTsmMRT39cuJgihCkI7j6EE2DZK/G1LazJ88u9Am2PSwCEe6gN+l7esn5BeFPSYwWrxNZyASgWvyRcUy1jEzx8FrNf9kZVGZ33BsEQcqa56DHQqO5+a8=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DM4PR10MB5944.namprd10.prod.outlook.com (2603:10b6:8:aa::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Fri, 7 Mar 2025 19:39:25 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 19:39:25 +0000
Message-ID: <202d0759-579d-417a-b532-27ffe69316cf@oracle.com>
Date: Fri, 7 Mar 2025 11:39:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 17/19] tpm, sysfs: Show locality used by kernel
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
 <20241219194216.152839-18-ross.philipson@oracle.com>
 <Z8qbsdX2hTathvbs@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z8qbsdX2hTathvbs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DM4PR10MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff4f940-c736-457e-6a12-08dd5dafc476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHRRMjdzQ2o2aTlQdHhTV1lXazZwREVFajZ3NWhtMkRDSlg4Ynl3OHZiak11?=
 =?utf-8?B?OTdnUU1SOXBZcTNFbzZUWWlyYlJKN1RDNmd3RWQ1QVhDSmRselFCMzNHNllx?=
 =?utf-8?B?ZjMzL3pNNUpGK29hNnpWV1dBeVpDYmhDUjRGcU02UXJvY0hEdlpwSE5nZDBa?=
 =?utf-8?B?TE9MZ05oa2dmZjRWWW5UaEJaWEYyWCtiRHdmbXhiM21PTVVmd0VxeXRLV1Bh?=
 =?utf-8?B?S09XMWpmQnFTYXR3RVVmblcwQ1RRRnQzZkFiRjVVZW9mMi9HMGJmcGZFbFdw?=
 =?utf-8?B?dUJGUy9oUE5ob3p3RnlHZ1JTRnlZb3ozRnp0eno4OUxvNzNBRU1QZ1RpRHN4?=
 =?utf-8?B?UXhzbktCK3hBWlgzTU9Va3prZjBEU3BVY0M3M0ZNZGxxWlZCNUpjVlBteCtF?=
 =?utf-8?B?bGYvSkY3QW5SelQxUmFlODR0U2lXOWRTVEpaRHZlZm1Cay9ZWXJ4ZHBQTXRa?=
 =?utf-8?B?WUp5bXZUVmI3V1B1Mmk1dnJJZGdIQjZ4alJOY21YNXNNNFc3N21kQ3hiRlp1?=
 =?utf-8?B?WEJIaW9GMXJFYXVPK1IyUm9aQWZaUUliUnV1dEVhdC91VjFaZUd5cmJ3K0cv?=
 =?utf-8?B?K1RPRTRJRFlNanZIOVEzSVRia0ZpWEgyZElYMGdxME5XUWkyUnRJK1VmYmNa?=
 =?utf-8?B?a3QxdlVtWGxQN1ducVZjeVptWmhYY1EyUDcxMFRoSlQ0bjZjdzhsUmRzSWlp?=
 =?utf-8?B?R2Y3ZkJBeG5mUVYrNWpYVFY1WDRqcmt1QU5ZZEVnQ3dzTjlkNFpWSmFiTGFv?=
 =?utf-8?B?K1BlMTdZczJ6SG5qdkdHQ24rRFpTT1VzVlBIY1dabWZTM0tkWlEwazZqaFRw?=
 =?utf-8?B?ZW5XK0llVnFNSFk5TnZxdDdlVWtDQytsZVcxazJqeERQUDJjYXc4OWExR2Ux?=
 =?utf-8?B?NWhsRGk2dmhIUGtsR3k1L2pMN09IU25VRUhIMVdJdGpVdlJmUG9MNE02Q0M2?=
 =?utf-8?B?OWxiVm1ZUDEveDFoZXZ4UFVDbmxpZFJYdy9MQkhRV1NnakV6S2tHdTRielF1?=
 =?utf-8?B?aWlROTByVC9wc3hHZ043RzNqOSs1dm00Y09PREdPR1puZEdEYmhIeExsRWdr?=
 =?utf-8?B?dFo2d0puT3ZEL05JSUVaUnE5ejRISnMvbVVsU2RETlhMblhaTWQrYVYvaGhC?=
 =?utf-8?B?dGFBMVpFWHpORkw3d3g2YlZUT0Y3SGF3N3plb1l4QjNhNlBZelFlVmh6OW5k?=
 =?utf-8?B?aEVrUWxhUEJoT0REaUttendmQlo4QTF2QTJnN3NBUFdlSmlMeUN6UE94Y1Rq?=
 =?utf-8?B?aXJYaSt6My9qOGg0NWUxeHFvUjI5T3Q2ZVR0eWdXSnI5c2VzenBPS09Va1Ra?=
 =?utf-8?B?NzlzbVJ1RHhGbGNTbmtOem9GaUhjT3lpY0M3d1RtK3Evay9aV3BhQnphUis5?=
 =?utf-8?B?M0cwYkJmUFhRZklKQ0NGUyt0aVRzQlQ3WkxCeEZwSCtKSkR6SDBjVkxJVzkx?=
 =?utf-8?B?OG1vMGVGNUFWd3RlbUZ3NW84Rnc1K0FSSWxyaUNYYUNQUVR0eHB0Nm5yTGI2?=
 =?utf-8?B?TWd4bDF3aGxHb2ZwRGlWckpxbXdoSi90U1VIalU0aDFhN3JkcjcwaFgzOERx?=
 =?utf-8?B?REVYRkhObGhYRmhtVW5ET0cyOThMWHc3UEIwWlZ4L3R5a0lyd0hCUUVzUkxP?=
 =?utf-8?B?Skt2NWVmMVFNYVQ0OUc2R2FvbWptNSs1Um9DSjlGRXJEWlFlMkhvckZ3eW5X?=
 =?utf-8?B?VkJrOWNPVklMTWNxeUlIRk94NERDL1UyVU1LS3U3dStmVHlQNDg4THlZTU5w?=
 =?utf-8?B?ZmYwa3RROWdKOG5XSkFSb252Z08yWm9ETnZrRkEySWdKaVpvaHUrMHE0ZktH?=
 =?utf-8?B?cUY1YzdOWmtTY2Ivc3F1UllJSW1xbnhuWWpYNjQ3c21kMy9aVS9lanRxYm1p?=
 =?utf-8?Q?6e+3FyjK47Tnm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWw4RjlzRGRGd1ZSWXRvRWxGQ3dhR3FIOHBlT1Bwak5OWTdVYTJpaHh2M2FN?=
 =?utf-8?B?SS91L0RKTS95K1ZudXhuV3JOS3hSWWo5K1RaMGRLYmFsSk8zTkFET05wWE5j?=
 =?utf-8?B?RmFLK256MldtTVhRTzlubW9oOFJDMWVJTklFRldNT2lmdEQ2YS82djAwTDBi?=
 =?utf-8?B?NUtKWDVKVWFlYlg5bmY1N2FrVGxuWEpKM1ROc2Evdkt2R09PdFl3QktCZXlW?=
 =?utf-8?B?cHBVbzA5UDY5ZzN0dW15SHZ2OGIzYzRjQUlZVVNvZVZGaTdvd3dwaVdGZFA4?=
 =?utf-8?B?Sm1LR1R3RjRMUlJWbXFiSk0vL0RZTEdUU1BOTmNDekNWemFuYTY2WW1VQWF6?=
 =?utf-8?B?YklQZTZLVkhaOTVTYi9ldFNTYXdFQk11NjFjalJJblF1ampQVE0zT29EaGxt?=
 =?utf-8?B?VVNmQUYyOFRUUjNDc0hUdmRzQzhIY1VuM05XcFBQNlliMUJ1NDE4Yld1Qy9L?=
 =?utf-8?B?Ukp3ODVZa244RlhFQWJ6Z2F4UjdkMlBjQ2xNOVZtUW53eDB3YzJZeVZ5UlN6?=
 =?utf-8?B?d044bXlhdW1rWEJ5RzFOSU5lMG5ma2NlbUJQU29EM0x6WmtGdlhXbUJmK1Bk?=
 =?utf-8?B?bTN5RzNuQ0NiT282eXVKMDdNbmcvamdDNWFPVkQ1WjVCWE5hbFhMUkFMMDgv?=
 =?utf-8?B?TWpQTUJ6U3hjTWc2bjg4bEEwOUUzNHo5SzhCZHhsWFNOejlXRjllUTgyNmF1?=
 =?utf-8?B?WEJJRFZIakZmZVZUVzJUUzlVZ0hyalpGNGpzWjR2L0dDK0VnbkVRdVJkMGtH?=
 =?utf-8?B?U3E1K2hQVkRCYWoxMG9neEpiRjN1bzhZZ080aWZsTGZyQ09QMlhPaFFYcG8v?=
 =?utf-8?B?RU9sTVN5anByTExrL0hYd2huL3BMcG1RcmViMlAxdWVPNTNIZnRKUENvbm5B?=
 =?utf-8?B?R1B3YjZYVHVsM1BIeEdsWjc0V3ZTSWNNL0R0bGhtTjg0REJrOGpWTGhqa0tj?=
 =?utf-8?B?V1YxWUFEUW5YUHRQM1VqN0tkTkk0aUxzY3MyNUUrK1pJTzdERGpnNWlpa3lR?=
 =?utf-8?B?TU9HTXZ1aHR0cEVLWkY0eTZ3TTZFKzUrSWRCZXI1SFhXZURsTVZQVXExS0dC?=
 =?utf-8?B?a1F6T2h3UjE0WDZiNlh0aG5Nc3hnYkRTWWxmSDdROFNTZjdhVThTemJBdDhh?=
 =?utf-8?B?TnZCZldlZkNTYnBhYzdHdi9LYjlob0hTZTNHOFMvNkVwZnNkM2sxZFFSMHky?=
 =?utf-8?B?S21ZbEFNcVp6U3NYUWJmdEVmeGd1UDZqVzJzTUdUYWxONzE5QTdub3FzS2xN?=
 =?utf-8?B?Y2YwSU5vNTVRRmoxNEVvUEJJeERZSmhrckdzRE9jRGZTcEZyenNvRFhxalQ5?=
 =?utf-8?B?bUh2K2lMeDdHZDZ4THFCeFVYbEU0eXFXVllaRTQxM0RDNjYrUWFkRHNPNk5y?=
 =?utf-8?B?cXdxMnNZQTZLM1ZvdFJVb0tjRmY2anhkSXhITm03c1R3SlBPclhKcUpGSjdt?=
 =?utf-8?B?MFVIdnF6SnFZSmN4NzdSRStlNzJtbWlqYW53RlFPUXRwRlNXbWxOR015WW5l?=
 =?utf-8?B?MVpjQ2NCc2REU0ZvS24xR0xKditOMnIxS21WVkJNaVRwZkttNU5QN0tyOGdx?=
 =?utf-8?B?YlRLaGpCdW1XSnYxRFlKaXhQMjlTVHo2ZmJucFRqY2hkYUMvRDdsdmkrTzVl?=
 =?utf-8?B?bzJGcTFUWE5Nb1JmOHNoVHM2U3F4VGN0VC8rK1dwTXppa250REJaMkNqZk10?=
 =?utf-8?B?VVBQem5PZTZWRTRpcmtDT0pJajNlNnd6ZStLTHlFWUNrZHNFRGFZbFpGclM3?=
 =?utf-8?B?ZkhFYVRyTmRjZU5uR3NjMjczY0phN2dEVzlsUGVUSWV0RDVqVDlzeUc5OEFx?=
 =?utf-8?B?UzB3NXc2YnFoYUJzeGR6SERjTE9qZk1KS010NmY0cWZUQ1NBRUJOampRL1A3?=
 =?utf-8?B?NE1SOTA0NDl6VUFvUWxVdG4vSElIQWhGVEl5V1drY2ZPbWR3U1laL3hGdXNT?=
 =?utf-8?B?TlRpUmJ3RWlZcjlnVzUzdzRTT05BL1VFL0pZU2lWUTlLWHJtRHM5RDlwSjgr?=
 =?utf-8?B?TG5WZDh0REVRcTBLU0NyVkdaS1lMKzNnU2RTWEdVbHhORnUvbmxzRU52SWJ4?=
 =?utf-8?B?bGx2WHU3aXl1MnZkQ1ZhNVhHRUhCZGFmNWRwM2hVcVVDWHZUR0NWUVh4cngv?=
 =?utf-8?B?NEoyZEppdWhsTFRZdG9pbDJWOW5RcWZRMHFXRFZOV2twQUtQUXpCalJSdHM4?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jKx8y3N6HnNFRecssdTl6Bg0OSdF5jyhrY2Crai0NbJqUehoEWuGHuzuBW+xoMjXJW5YxJ1BLh5emhRgQYab6yKHuQX/P9mguaKm39Vc2S5LyocL7lXGJ1Ns28vIgkSrkLsAJlGcIletqGgEZ0PEVT9HqlxbQcmdNEOoV/x7USL6w0V821Y5f+DneGmPh45CD+I5ZsWS0WXTls+gMn9Jdf+XfWJmoK8/bkcWQpI6HE94f3nSA+X9qkm5IcJVGNbUw/A6iHlZeFWDzaR8X7cYeg4JIZcDCqWm9j93Y4Q7sTcOXLAutcUEhXPc7+Oa5EkFCuHv7xj4f8mZxBiXh4kWW6XGUovPfXLn7TibwPtfl2MSeDglXzdc+I+CRX8F5pc/ptQ7aO+FOspRns3PIAGSqmAOshVzULxReCnovlsmnpbzgZLgeOhCRMbem2IPom8iZ8V/t1SHU4yTGDoaMvD18b1mc97+gWK8/pXWGJ25suQQ6rwNcvDBz14Ms4ZPcdKEmO0Mx0b5s1yHe1SVMc/WKo2F2mBlAT0Yx495Uw6VLDsHGmwgWXvW6aYlcdTk3IcRBTm+Pf8ejQLtyEhbjjCSN2t1dC2ayJiZx4GJsHFrzjw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff4f940-c736-457e-6a12-08dd5dafc476
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 19:39:25.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: of8veZaauVndKiBds8i0oJnpOVDGPJZ3JqxWwQAH5pbecEnXgvSU/E3VK3dtrLyAjdeWtA8khYIOFGvftCGU5RK0NzVtyKidlwx0Y5XSgUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5944
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070148
X-Proofpoint-GUID: 7BCwnVLomcSjpOX_U5wU3PtpgkdKSe6A
X-Proofpoint-ORIG-GUID: 7BCwnVLomcSjpOX_U5wU3PtpgkdKSe6A

On 3/6/25 11:09 PM, Jarkko Sakkinen wrote:
> On Thu, Dec 19, 2024 at 11:42:14AM -0800, Ross Philipson wrote:
>> Expose the locality used by the kernel to sysfs.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>>   drivers/char/tpm/tpm-sysfs.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
>> index 94231f052ea7..2da5857e223b 100644
>> --- a/drivers/char/tpm/tpm-sysfs.c
>> +++ b/drivers/char/tpm/tpm-sysfs.c
>> @@ -309,6 +309,14 @@ static ssize_t tpm_version_major_show(struct device *dev,
>>   }
>>   static DEVICE_ATTR_RO(tpm_version_major);
>>   
>> +static ssize_t locality_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct tpm_chip *chip = to_tpm_chip(dev);
>> +
>> +	return sprintf(buf, "%u\n", chip->kernel_locality);
>> +}
>> +static DEVICE_ATTR_RO(locality);
>> +
>>   #ifdef CONFIG_TCG_TPM2_HMAC
>>   static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
>>   			      char *buf)
>> @@ -336,6 +344,7 @@ static struct attribute *tpm1_dev_attrs[] = {
>>   	&dev_attr_durations.attr,
>>   	&dev_attr_timeouts.attr,
>>   	&dev_attr_tpm_version_major.attr,
>> +	&dev_attr_locality.attr,
>>   	NULL,
>>   };
>>   
>> @@ -344,6 +353,7 @@ static struct attribute *tpm2_dev_attrs[] = {
>>   #ifdef CONFIG_TCG_TPM2_HMAC
>>   	&dev_attr_null_name.attr,
>>   #endif
>> +	&dev_attr_locality.attr,
>>   	NULL
>>   };
>>   
>> -- 
>> 2.39.3
>>
> 
> I think we are now in good standing point with TPM changes.
> 
> I'd really put focus now on unimportant seeming but actually important
> documentation full refinement. It has all the infos but it is torture
> to read still :-) I did put detail how I would like it to be edited
> (personally, perhaps others could comment that part too). If it was
> a bit more punctual it would be easier to follow rest of the patch
> set.

Yes this is very fair. We can do a scrub of all documentation including 
commit messages and comments. We will incorporate your and other folk's 
input in the process.

Thank you for taking the time to look through these patches. I know 
people are busy, we really appreciate it.

Ross

> 
> BR, Jarkko


