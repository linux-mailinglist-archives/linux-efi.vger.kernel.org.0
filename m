Return-Path: <linux-efi+bounces-3459-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE245A9B6DE
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 20:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF009208F5
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADDF290BB4;
	Thu, 24 Apr 2025 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m+tUsVe7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cxMyG1WL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799E27F75B;
	Thu, 24 Apr 2025 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521029; cv=fail; b=cOSdYAnUvsn66vi3Sf27LAFxIpaeL5fmtXLvZJ9AJspRq1hkFQJ06HwBBQLSy+fsip7aItdDUHPuW4c8B+t1QJQGbcj+nrgRzpZ/rjC9VkjncwajgM4dzsNK3IbjZVTv2RgEEq+CooGguK1CF2pFdDZVDYittfXg/Yifl+4m/j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521029; c=relaxed/simple;
	bh=+2M2zDw9NVwv1K4H8dwrzOihanvTEYRPYRZpun5XikY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XFmu8E+OpxjCQzlXbb3ykqP/QiVL2agW+66dcHhYa3lUPNOOhQFizrkxzsHu0YPfESYsjJHyMBmD6YE7N58jqOlMXPhi1+2iZE2GmvnbCQl590nPTXo/uCJ10+8QtrmCoixQvvvQcEyLSQsFFoZYXt1IHG0F5h2372GN7u2YRic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m+tUsVe7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cxMyG1WL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OGqNbo012852;
	Thu, 24 Apr 2025 18:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KTvWYXDmYG8VOKoFpgf8/uUxy+cES0MJ2cKnYnGBrQ0=; b=
	m+tUsVe7VjLncRNcc+HYlQRIHrJ3MQXyPN00J/FGXaBBA2OrKsXpiNoFOmz5YcmW
	buivnc/HNeh2UJDRd1cwDROyj20Nwb2Jqu2ULMQbJOVhz3ECoUwkcinD2Jjtx/LB
	PksmedzL7pMAjZN0JubCiGRg3oVplaYehmhzxlIDfFVDLNhk1Mc9x/dqAroIZR3w
	LsVPPg4F1pHZbglrmHpwnzo5jzYZhj0wc8wklU8x2hR/VEdW8WKFcjwAjEHzKIjl
	ftcf1xoHZ3HErhjlPTynD2vhPdNJJeTcY9UKFHAHIgK7Ryan1vknSfZzfjuDwqI1
	LA/Q5f4Kc+SHbO7mcg6mjw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467s6q8guu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 18:56:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OILb2q013820;
	Thu, 24 Apr 2025 18:56:21 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013079.outbound.protection.outlook.com [40.93.6.79])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxqpu65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 18:56:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er60nw9GdssHb9k0k9Vq4SCcQMIYVKUmtw4AlEIO0SHKl+M++vkO/uizD2tjHop7QS7cM2iSAblnThp6tytNJAqo/5QSvx53B/byPYAp6CrPJqBERRo6FQ0kPAaQMakj73LF0YNdUO1ntNJrtu/85UFqb8xYHNkDw5FuJU8oO1xENdI2bvpJ/0YU4cPn65SbNE5UIO3UpqvXF3tcfx4EeMUnZTecME4Rb0SIKeGaGEAbFBg0wbxr3hrnME6wVGVPm6Z6T0x9+P34kjbo3dgsNFcmHevMaDqTt+ir+HhLG7eRI8kqgrS9tCAHcR05tPFV7asIh908fsVkjBiR+RWYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTvWYXDmYG8VOKoFpgf8/uUxy+cES0MJ2cKnYnGBrQ0=;
 b=ykBB8IsOzf869qwCdPwOiBWBZPA/CUVg4gttChyx8d3Wo6kdQxPeTtceCkug0JQmaOIopEK4p3GBoUIuZeTuXzRIX4SLVr1cDBf5vwUUNjJIjUKe4oCnVLDsD7rFJ3mIxDWiakYRaq/3bcbqQ2s+bNN+A/H229udTHn3dsZ+jREeRg5EktrMQZM9Terg3lTKVE/MiIouurvn70ZpKzT06mAiVav/cTQaff7/W50jWtdfDTlDey2C6lv70pUOBYqEjL0NcUkkhrvyTn7iTjwqZrMUDTlaPoQ7wV7Wp4igTF2UwnDjEqrr35SmtbP221KTNIkCn/MszcX9p3ptrjSJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTvWYXDmYG8VOKoFpgf8/uUxy+cES0MJ2cKnYnGBrQ0=;
 b=cxMyG1WLVFCM2oc1iF71PcONbeAalY+BvIdPiAaZ6RIatc+8gYc9KE6vEimxnclub1p1Vf/3gyOqIgR0VYDWrz1YI3OYhSdU8348lLi27bG4wJ5vY6d/0HuYw9HBN5rH5uulYP/rz9pVtzx2bhwFpSxHqDp3IgiUDlnwwuy400Q=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 PH7PR10MB7838.namprd10.prod.outlook.com (2603:10b6:510:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Thu, 24 Apr
 2025 18:56:15 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 18:56:15 +0000
Message-ID: <e68edaab-e7cf-4a13-acb1-87ddbb73765a@oracle.com>
Date: Thu, 24 Apr 2025 11:56:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/19] x86: Secure Launch main header file
To: "Huang, Kai" <kai.huang@intel.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "James.Bottomley@hansenpartnership.com"
 <James.Bottomley@hansenpartnership.com>,
        "trenchboot-devel@googlegroups.com" <trenchboot-devel@googlegroups.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Ghatraju, Kanth" <kanth.ghatraju@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "dpsmith@apertussolutions.com" <dpsmith@apertussolutions.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-5-ross.philipson@oracle.com>
 <e2d00d7cc4cfc33a3b328fe8386f6d164bc46184.camel@intel.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <e2d00d7cc4cfc33a3b328fe8386f6d164bc46184.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::21) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|PH7PR10MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d77bc59-442b-4baf-0a87-08dd8361b0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUphWGVFNnlWMmxSQlR4TkFPaFdhM2d0UmVjMmFpd25lczVkeFhtZzBFamFU?=
 =?utf-8?B?czROMUJlYWdzOVpnbmdtYWZNRkNDcGI2R1JUL3padUpMWG9mY0E5ZktjV2Ur?=
 =?utf-8?B?aUNZMG9wYXRWZnNxSzFNaHFaMDFvbWczSTVjajJsczl4NFFHQ09FRHBnbjJz?=
 =?utf-8?B?Um9UNkRaT3JoZlJ5ME9vUUdSRHZ2cFQ2QWs3TThTQldVcU5VMTFHdE9WTWh0?=
 =?utf-8?B?MEc3bklKRHRvNi9CNXJDdFV6Zm0rTGF2Rk5uVVZOS2dXaWpXRnFjc1R5Yzd3?=
 =?utf-8?B?Y1ZrMDRDaGdjSmgzRm9Da2ZJVGdiOUxsNyt0SzhXVUdYeS9QdGhxc0pxMzJI?=
 =?utf-8?B?V0pOcWxVL1pkbkg3L0E2QlRQM0ZMMEVNL1E5cXhKNlZIOFpoeTVDNk1oQ1Vx?=
 =?utf-8?B?YUxrMGpjSkltdFU5dy93NzVwT25WYndYOFF0VkVPS0Q1Ylp4U1dCdFdxdGdx?=
 =?utf-8?B?ak9VWjd6bWxiWFcrRXYzUHpqdUppSTBid0YvTW9aWWFzWk9qeWpWaE8zdmtv?=
 =?utf-8?B?eTlxd214bWpwbmluY3BJWHRqN3g2T09WczlZT3FFOUVKMllvMFlNckNqY1dZ?=
 =?utf-8?B?YnJRbmFQLytLQ3YxMDI5SHhSVWE0UnBRcWtLbVdXTTk5VEl2NXE5U2xiRzRR?=
 =?utf-8?B?U2tlaXNwcHZsazJrNFFZZmMxbnEzWkZKUitjMTFSYzlJbktkN1pwSW9HMEVX?=
 =?utf-8?B?a0ZXTzJxdTJablFNbW5LK29aZ0lWcEIvalAyK2d3aHhDKzdJNTZIQWV5MGZ2?=
 =?utf-8?B?L3lyWGN4bVdzbU5FNzg3S2xac0hJVUZhZlplN1ZnUXU4NUxHV1JJOFE1dzFo?=
 =?utf-8?B?bGgvNytSckpMZXBhRlJBU0VMQWxTNysxWGVhVTE2bys0UkViLy9XTFk1NXE4?=
 =?utf-8?B?bWVXaVZFK2tGenNoamRhYkhkMFFmekJWZlJRaFY4TUp1OEcvbFdqQVBpRHlM?=
 =?utf-8?B?K0pUby9TWkhJQVpiREloKys3TFA0L3NoVmExL09PcmRsc1VmcEdsK1NlVG5L?=
 =?utf-8?B?dmh0eStYdzY3b2hOSW9pVGJacUlZeGUrTEh0T0pzL0t0NDRyR1BDTTVweTVY?=
 =?utf-8?B?NnlPRVU4NTE5TWRuZ0tJaTdaTXFuSm5LaXgyODRtNGZWL2FNYWppNkZxUFln?=
 =?utf-8?B?RFBGNmVwUWtGcnMyM255WVhoK2ptRWJEcytFSmJhWFBKSGRNalZSN1UyK1JY?=
 =?utf-8?B?SVk4N2lsNHh3Z0pyM2ZCWXh4Yk5yNVNMbmcwSzZVTXhNOG5OUVRhZmlaQVNF?=
 =?utf-8?B?dXA3K2Z2Z212YU5vRUtKRWpzNzJNU1hnU3ZVQTYyMGZzdmVXYkpsMzRKUEVK?=
 =?utf-8?B?bytCTjc5Sll2d04yYkpxbDQrb2dYbzJBN0tUWFBCYzJJVElYTzQxSWFwN1lW?=
 =?utf-8?B?Yk5KR2EwRUVOTTY1cEVOdHNwQ0JOOE8xR2hQVzhiR01JV2FPNXUxd1JEcmZY?=
 =?utf-8?B?L21zTTFqb3dwcUZ1ZUZwOXBCb1p5Q1hhRHVjcGFXcmxCVnBvOHY1MFBaU0JD?=
 =?utf-8?B?cjBqZGN1MCt2V3czNXpxNlQ2R2pQSS9nOFhyYm02a0tteW8zR2tBZHpLT0pW?=
 =?utf-8?B?aDhTc3gxTWlJMXY5dWhscm1MNSs1RVNiSXhibWNCS2gyRnYwd3RoYXVhdE5F?=
 =?utf-8?B?OEdUN3pOZWZWWVF3eU5xTXM2M2s0N08zWldxZExRelJJVTNpanBXWGZvTFZv?=
 =?utf-8?B?eTBWVUhsb28rRHNKdndEeHhWZjZFQjRYR2hIMWpPM3BtZ0tzcGYzYnpuRmJJ?=
 =?utf-8?B?Y285S3czUWkwUEhOSDFCMCttNm1pT0xIRWZQNEE4dUFZQUpLRnhBTkp3RXA0?=
 =?utf-8?B?QTFoZ21aaTJnTDUzZ2cvOWRBVWYzYU9LN0hqWkV0alNzTUZZOXRpaVRRREN3?=
 =?utf-8?B?NHNsd3BuNFVpcVVSSDZvblVQcXg0MHIwSXl0ZTVxcmRUb0pNQTNocy83OGVC?=
 =?utf-8?B?dkRjL3pTRDRNT3dXbTY5Tjh5ak9NMEFuT3hrOUR3MVd6azFWcXBjU3hFRkhL?=
 =?utf-8?B?c0JSWlJqTUdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a01LUUc5SmlhK1RiOWpTenpHbkxRMms3dkFza2ZWSlhjQzJnajhjVE13M0d0?=
 =?utf-8?B?dTE1YUtybng0RmJTWmFvMGN6S2lrS2ZoM1JPZTU1RXpSMWxUNmVYTjVtbGJt?=
 =?utf-8?B?L0czRGZ6UmVUSGhqU1VDekIrWjZac044ZFhONzQwZUdtZThmWVhnZzZXMjd3?=
 =?utf-8?B?MHFGWGRtNVVobHp6bjQwWHpkb0pJRG1acDlGWFN1V1YyV2FXUlF3S2RWcnI3?=
 =?utf-8?B?NFRSbnM4eWNURTF1Q29NVWRSc2Y5N1JvWEZRNzNmR1UrRndvVm44ZTJoekwv?=
 =?utf-8?B?eUoxalRVeEVBemlQK3JOOUkvcmlvd2xLNzRUL0UydkNDeHduSVVtZCs3UElH?=
 =?utf-8?B?OWFsQ091UFBTaWNOVjBvaXBMYk1iR1k2SDFjN0FWOXhaUWNBNHF0ZzVTTmlV?=
 =?utf-8?B?c0tlWVlFMzFuWlNvQWJ2cS9pbmptR3B5Yzlnc1k3S0dlQ3RKc0dEK1EzMXZk?=
 =?utf-8?B?OVJrajMvaWdwSlB5SjRZVjd2ZnIwM2ZxNEp4TGcraGlKRkxRRWNOZCtKQ3J3?=
 =?utf-8?B?Wk8zaUNROURrZ1BOUTF6YjgwaXVTUWtuR203RklmbUJLZXpCSTZjK0R0dXJ4?=
 =?utf-8?B?ODZKRC9zZE43aHR6anVtaXNPZFJGdG0reUdvV2JJUTA5bXJPUWdkcnNxTTBO?=
 =?utf-8?B?NytBdlRnc1RHb0NiakQ1bkwwS2VNRzNRd3ZvbTIwYWZISnRyeUgyQTZpbEFi?=
 =?utf-8?B?N1FGd1JST05oUjAxR3c5UVZ2cDZkeWlLNW9LSXh1cnlVY3pidFRFbDB3MVR1?=
 =?utf-8?B?NGtqS2gxRlZxOVZJK3lCMEZwZlFkck5IRXlqVENQQWx3cGREZDMwUG51VVVt?=
 =?utf-8?B?azNKVUFXS1BOZzBFcThRVkNNM3QrK3pLQzBrMkpNaXdJSmZVZmtMZDBleGlZ?=
 =?utf-8?B?UHR0T09JdExEcnU5WVJtcnRXM1Q4TlY4aUR0ckwzOXk3MjBEeWdXQTZ2blhx?=
 =?utf-8?B?QUxjVmJTQytBTEs2U0QxUWVMdXVVdndrV2JEUi83SFlBb2cxc3ViZjdPUVl0?=
 =?utf-8?B?c3FwMktHdGxZcXk2SThlZE9KdzIweFc1ZWdWbEtLY1NwVnpjeUdvZFlEbURM?=
 =?utf-8?B?SDBmRUV4TEFzeXpCY0FCZkFDZWRYTXVlL0R1QU5NY3lqS0FFT1ZPYWJjNVF6?=
 =?utf-8?B?U0p2ZmNiVDhBeFRrREJUUE1yTHc4YU9yVWV2WENsdlhUZk9aaFAydE4yOFdj?=
 =?utf-8?B?K2lyanhQZTB2ZXBCcXdaUWRaRVB6K1hQYmxCQVNRZ1lFMThoZGpZTXlxRmpx?=
 =?utf-8?B?K1d2cUpEd3hPMUpOR1F2VTZ3alNtMFFsVXJoWitDYjRYRlBJcWE4M1lhN01Q?=
 =?utf-8?B?NkJFUHMzTjFIWTl4Zm5ZdTRkVlUybWMwVkJFMzN1WDRNM3FTeXM2Qkhod0tL?=
 =?utf-8?B?OU9IYkVNWDhsYWZGN08yTFhkdXJ3eCtsc1FRRFVtbWFTUXVUVzB3N08wNEd0?=
 =?utf-8?B?Y2xCMjR3MlNISnd2TGdqV3ErVnBWVkdXOWczV01MMnhFc2lSVUpma2JSRDVw?=
 =?utf-8?B?cTlyZXoyYnBMUm1vclR0R0Mra2JTd09CMmp0aE9pRmRvYXFPOXVmMXZkVk1I?=
 =?utf-8?B?UVhOWHBvTk12Y0N6UFN0Q0lCcENYeXZDdEZuLzRCaWVWRThSM3FObk12RW0z?=
 =?utf-8?B?cldUZ09rdkttSEdkVUxIaVp2enZnNGRWcjU3NU5Id3gwZ09ha3J4YXdmK2cw?=
 =?utf-8?B?V2llZ21iYmMxLzRKZW5DKzhZcFZuSzBqUDFTKzFoa2FtZXpDanRteTB5eVM1?=
 =?utf-8?B?QkxxZWJkQVJkK3AzYmdSUGZBMUdzRnRVb29Mdjl4Z0hJYzFialU3ajhsbDZF?=
 =?utf-8?B?K0p6RklQbDlDN3YxMEhZdTNlL0ljUCsyNThNTTRYQ3cyVm9kajZ4TEJGdHN4?=
 =?utf-8?B?eEQ0aU5CWlhQUGloR3hlRHB2U0ZDRlpMcDdDUlp4UlhpUEtld3RlK003MURr?=
 =?utf-8?B?TzNPdEFQUExSemZPZkxjTFBBZnVuamNUMlNkcG0rZWxzL0M4VjRSNnkwL1hv?=
 =?utf-8?B?bVYvVE1UZ2RVeWlYYmtxSE9yOVREMURlQmdhRXVMWDFvZS9vQzNlK3o5Q25B?=
 =?utf-8?B?aE1VRDFqREErNmF6SjhPN2ovRGZVU1dQVFF1R2U0NEFrMFVqUmdENVM0cS9D?=
 =?utf-8?B?ZWovaFFBNXo1RWMvOHgvQ0ZlQTJFYk1hM2JEdUxLMHhTdFZ0Z2VoaTRrcHV4?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mfjdSI+W99fH+X6o0cXodv1Mje9h1+zPSOW4V5V2MEoJ1guJlhCw0/+pFIeqY8ohMd4fxO5q8ZC2/2Gvf6Lry7FbXMc8HbUVq5Qvmhb4xjqIZI55Za2Uev0HFkBnVK5c1olOJFiCXYPCyeTIgqT7kELoy7daFlQCcVY7+BcE9xysM5ADSe14w/RpuQv+q6ZvZLq9yhsBMvyykb4rOKh4pczzJyglW6l8XfsmjezchuEx83gQy1d6QSe3lzbKQbXKYZVNpd3hxmID/OsC5NqXchRA6LVy+9ZaR/HcVbVJeJOGy+UXjRXMWIVwZsRfLh7JL3LRPyWYg0S53Ay0AMHXdsBix3Ij133lxMNVEx6AISFx2fl1k7rr1NrcX0bEVMSQKJgJpnWQaTCLM6Lrh+UI84zo4He8fpfX8guUEXK8nOqD2r0/xwWoJbTy+oT+1NwuExF3pN+e3ciCOksVGK4ymNjUlSbwRQGrlxKvtRFQB/UXnWKUpld4+cyzltsw+CyEo9kfl7QBfrKd+JEVEWeYRasFbYvhlDGZyvSxLHYrjxaP64XPtwfNkKwbbiyxBRs8iDD3u783xHNc4JEvb6J8VgAaSz0wH7g6x4P/wAGDx3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d77bc59-442b-4baf-0a87-08dd8361b0a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 18:56:15.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUWKbWGgC7dfiNdwI0rxJYMM/dOIG7x6BGtDPEwEkEuxuNqlNJoH9u8EPbpEUuzk2oIUodNrcY5osp4GFDGAEJ0C3dtCLbGmqH1KWdkG7Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDEzMSBTYWx0ZWRfX7tKHi4Ydi+Dg 68R1qBqPiSDlobc5FeTp6DuD6EunJu2pCA0QGLJ0PmpdmMwASbTlU4Fn5V0V9l4XI2WtD3f/GSJ L0T2Ks8CFQQsc5Y0kJfFxzMgwSdp0lK8e+d51Oh+k0h/UGvO01N5UeNY5X+rOiJWgMpIn65FEP/
 I2RBaaOa4H9U3+KJeWzvVNST21GFi+qupXd2BmkcCXfTy7sCrHW1T8YWpN/T1A40cKGaF8U7Coy eTVHd6c5dClJAeA5gYA6wiWIOy42U+rgeVl6X4/N/EyA/zxseOa6R9hVEq2+Gp02ZOAzFJGqgnZ R+O6QFD1gMCRx2H8BTS8I7NMBkpV6xoMw8cT1KDKUSx4CLMc9qcBPguMcffo5Fv5vvjDzssBon5 2/3yY/BI
X-Proofpoint-ORIG-GUID: DBAWJP9T3kerArkVQfB9IeswKS3oBAR8
X-Proofpoint-GUID: DBAWJP9T3kerArkVQfB9IeswKS3oBAR8

On 4/24/25 5:29 AM, Huang, Kai wrote:
> On Mon, 2025-04-21 at 09:26 -0700, Ross Philipson wrote:
>> Introduce the main Secure Launch header file used in the early SL stub
>> and the early setup code.
>>
>> This header file contains the following categories:
>>   - Secure Launch implementation specific structures and definitions.
>>   - Intel TXT architecture specific DRTM structures, definitions and functions
>> used by Secure Launch.
>>   - DRTM TPM event logging definitions and helper functions.
> 
> Looking at the actual code in this patch, seems >90% code in the
> <linux/slaunch.h> is Intel specific, e.g., TXT specific macro/structure
> definitions.  It doesn't seem to be the right way to organize the code.
> 
> E.g., following the current pattern, when we need to add support for another TXT
> similar vendor-specific technology, we will need to add yet-another set of
> macro/structure definitions for that technology to <linux/slaunch.h> as well.
> 
> That would be a giant mess IMHO.
> 
> Could we make <linux/slaunch.h> only contain the common things, and move Intel
> specific things to some x86 header(s), e.g., <asm/intel-txt.h> or <asm/txt.h>?

Yes this looks to be a good idea. I think it has been something we have 
thought of before. We will look into it.


> 
> 
> [...]
> 
>> +/*
>> + * External functions available in mainline kernel.
>> + */
>> +void slaunch_setup_txt(void);
>> +void slaunch_fixup_jump_vector(void);
>> +u32 slaunch_get_flags(void);
>> +struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
>> +struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar);
>> +void __noreturn slaunch_txt_reset(void __iomem *txt,
>> +					 const char *msg, u64 error);
>> +void slaunch_finalize(int do_sexit);
>> +
>> +static inline bool slaunch_is_txt_launch(void)
>> +{
>> +	u32 mask = SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
>> +
>> +	return (slaunch_get_flags() & mask) == mask;
>> +}
>> +
>> +#else
>> +
>> +static inline void slaunch_setup_txt(void)
>> +{
>> +}
>> +
>> +static inline void slaunch_fixup_jump_vector(void)
>> +{
>> +}
>> +
>> +static inline u32 slaunch_get_flags(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)
>> +{
>> +	return dmar;
>> +}
>> +
>> +static inline void slaunch_finalize(int do_sexit)
>> +{
>> +}
>> +
>> +static inline bool slaunch_is_txt_launch(void)
>> +{
>> +	return false;
>> +}
>>
> 
> .. btw it's not clear which part of the code is common code.
> 
> Looking at the abvoe code, it seems those functions are common functions called
> from common code.  E.g., slaunch_finalize() is called from kernel/kexec_core.c,
> which means it is a concept in the kernel common code and must be available for
> all ARCHs (I haven't read how other functions are called, though).
> 
> But the name slaunch_setup_txt(), slaunch_get_dmar_table() and
> slaunch_is_txt_launch() are quite Intel specific.  So it seems to me this patch
> _tries_ to support Secure Launch at the arch agnostic level but it doesn't do a
> good job at the abstraction?

If we do what you suggest, I think these ambiguities will go away.

Thank you,
Ross


