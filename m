Return-Path: <linux-efi+bounces-1129-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 015A18FBA78
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 19:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9608286D4C
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B943E1494CB;
	Tue,  4 Jun 2024 17:32:08 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74BC12CD98;
	Tue,  4 Jun 2024 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522328; cv=fail; b=MkKtFl2s7FGlz0eyQsi6AalLzvaGPIhlXnWlFa+ob/KZGRkDa++85DPKrlTF4rJnRFf9Mvu4OQB/ERu+QZsn+KR2RVAC/qUJKic4bVOCbL6CI0ji49v/mlqFo5AsN+3cXZUlwwHdIldqtVrJzQA6LFwBDbEdKHSJJZPvr/JuYJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522328; c=relaxed/simple;
	bh=Zm6MEuI2WmZ8CCk33uH4J/QVM9jT+Vb/YWxQC8o+wu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GnJYi7wlulPgEQiO7YJkY9xdtav134AKVHELRLS1wd4XHD815x6zzz0lB3473M4joPRrM2s8nIYD3MAcHWGhCuS+A4fe/pQIgHoLb/GXfTe2zB6uvDhwmUta2g3PbGp51jPeTynNRDLHuFzqAEPgzaVeeGkX6NuNJRuR6Ga7VKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BmovZ013710;
	Tue, 4 Jun 2024 17:31:26 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DOwm59vriAZOEbtERrGE+kBGkoI3bY+8ouViqIOPREqI=3D;_b?=
 =?UTF-8?Q?=3DUc+GeHf/5KJAWpRVmGFYOcFa5xeTXzhYjVBcmEDHBYcaieqKVsO/hO2o6DQ9?=
 =?UTF-8?Q?bTx7fmxR_qcsT22UkSHDz9+lgOpbUMNB+8EUzmjj42a/5+eKDPwg7Vceg3SG7Wx?=
 =?UTF-8?Q?YzqJdV1Mabwjux_tqqdjuTmdy9ZDk1yu5iayvrc6MQgpzBzwUxqN20AbufUrKSI?=
 =?UTF-8?Q?kFK/6pvIQ46RFQuXXIJT_0r0O8FcpWGx0MF90W9CWHsRSm0LwdfF/PHvZ2Qqj4R?=
 =?UTF-8?Q?j2w9rxr1HEdw03G0m7c9fUh5Tp_HG63wzwu9EzGpuf9zIf71pM2X60jG4kZnI3u?=
 =?UTF-8?Q?2RFpcELSK+BBaxf5LM/eipMwVrN3mrba_5Q=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuwm5j63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:31:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454G7iDZ025177;
	Tue, 4 Jun 2024 17:31:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt8xhsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpXcJn+veMxUrs+B61LqMLQufYFHjU7kCgVf1pc8r5DJHF9uvV+CKVQaLcXBxL3wqeNDeLY47OitVli7yGcxAvZAnM4EisX4a0Hu1WmDXPOsEG38/tZsAxmPD3OSI63goXKhDmjKMEPbOilxxHSHyOcj52vh1yZFd9chk6wYWSdvcCiK5FhOfkmDcGMhsPJBEnqx7UVE7VzOtJQ4jWCk5iPdzk+7cgUDVhD+9gh/M0ROOxiwQ79RV4sALNB7BK4A21VafsJbr8RzQLP6QITB5Itz1PsIMwJ4v2cc+o7W5Sk/ZaPZ3Ol/kw7pCQuTLlNzhPV693HqYHRAOS/HUd90lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Owm59vriAZOEbtERrGE+kBGkoI3bY+8ouViqIOPREqI=;
 b=N1VY6Vr4z8i3x2Io657b1Yy1rKpIPYAgNpqCNufvYmfldu3WQv7OH3jsCXiJHiP/WtN5ojtIMVbV+d9dFUJqX1BAOlsDS2FJR2EKHqNN6AVWbp0uMv5EzBeGKslVMUTndR86/dtX0JzAXBAHijdhkuq/s3T5dtxqD9HBZr2J902Ouyk5gEHPSvJzaOpKTlBYEZgtplb2mw68KoRayC8fuIjGepLlEt4PIcb2CaE1Sl34DzHer3sRx5/98lVgu1X9X9V1fbqu4Ouh4wZ92jejeelQvVokCITsTTdL3sW4wBIA5dApt4J+Gbn+8nK9XEtiJWSp3JfoBr2mHWLIJ+o5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Owm59vriAZOEbtERrGE+kBGkoI3bY+8ouViqIOPREqI=;
 b=pkGxecoQpQeu6MJS9fPJC35ZhPRqE0NHOVLzolV9w3cb78MbDWrKQH8j5IjfuP18UGgMekr5QvLIiH+DVvpskXhcd5vx9GaTerA72fxcNaxgCG1PqnEHb02MSRIL34zVednpFaEZeWz2LZFFlBRcopBP+fQ4d0M37RWRCj2Vbio=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 17:31:17 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:31:17 +0000
Message-ID: <38863264-e57d-4ef3-a663-cc172713dbf9@oracle.com>
Date: Tue, 4 Jun 2024 10:31:13 -0700
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
 <CAMj1kXH3AwSiq8K6VZEp83uF-W6mtODqrCKROQZ6VqAsFGVBbg@mail.gmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CAMj1kXH3AwSiq8K6VZEp83uF-W6mtODqrCKROQZ6VqAsFGVBbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0040.namprd17.prod.outlook.com
 (2603:10b6:a03:167::17) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|MW4PR10MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcdf3ea-469e-44de-19a3-08dc84bc23bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VVpUZU40eXNvSlRFMEY0YkVjdTJJTUdvQ3pERDk2cHFNTjhVQnMzV2x2bkJF?=
 =?utf-8?B?U0V5MkV0Zkx3Qzcza1RKRnVPL3ZDNkVqL0RRdWZGWlJMcklvYW5NcVRyUHlE?=
 =?utf-8?B?Y2V3TXpWVlN1VWFaVkpIMjNZaitzay84WXo1NzlKQlNVeVorNy9DbDIrT1d0?=
 =?utf-8?B?Rk1jS1p2VVdTM1c3SnJ1Skdjdy9hcFJRcUV0V0UxY25GdU1lZUtDUFdCc0la?=
 =?utf-8?B?MXFyak9FdEdpNEQ4OGxQdjFZeTIrYjdKdzFkbVFPcnhpWG9EQlU0YmZCMHRn?=
 =?utf-8?B?MU82NXVCMS9ocWJrZHhac0NvR0VQTDlVQy9BeXIxTGJRNGlJTDNWYWpOdXIz?=
 =?utf-8?B?SUk0SDZ5MUJzWFlJVHNsVDN2UnZDd3ZUb25Oeklxamt1eUlSMmwyZnZLZ0Z6?=
 =?utf-8?B?ZW1WQWFYMERuaVpDcWd2WXlVZTBnT25IYXU4empuR1N3Z3hTVjhZbDBncEh0?=
 =?utf-8?B?ajJJQk5CTEVvQXJXNm03VDJ0cW5TSXBrUy9xbE1CK0diOURHUUhmUFlVK0I3?=
 =?utf-8?B?aTNjMHdDckIwTkVtWnE5RFRSZS9DK1Q0c0FTREVGRmFSajJaYWtiOTI3QnJL?=
 =?utf-8?B?R3NaRDFJekVyYS8vaDMxU3hweWZXK1VPekpWRENCVkFMYzFUSDFlY28yT1FI?=
 =?utf-8?B?aHIyMkRtTGFPMHlwRWNxRFdRTUl4bFVMTnM5a1htdncycW5ma0JBdlhjc1cv?=
 =?utf-8?B?OWlYbmRoVVNGZWZEbHB0SXVNRzh4ZHBIRUNqUlA0Si94VUxRSzlSeXI3ZUt4?=
 =?utf-8?B?eTVIdlVDYllEREozNEY4dTlwZlMzUkJPeEVFUlR0VVg4dUtyU0lMRFYzV21o?=
 =?utf-8?B?MmMzc0JvcDE0YnBZNFprVVNhM1J0WU42QWJuVmtrY2ZlM0g2ZTNSVm5COUxF?=
 =?utf-8?B?NGovSGVTWjZvQUkzaGNtTFk4dkNpbHNkTHY1ekdCMTlhNDJxbHZjeG5uREVr?=
 =?utf-8?B?ZVpQLzZqSWxkNnFpMHlSaStYSVpBWDV1RWdLcHpxYW9XUVdmQS8rWnZPcTRH?=
 =?utf-8?B?dWh1VFF1U2ZXL1J6ZFdoeHI2Tys0d3lGYzBFWVQ1UnhzT0l5TzloaERCNlBn?=
 =?utf-8?B?Q1ZlUm5EYVQzekxOd2RrVld1ZmRWVzhhQkt0cTBLU3JnQmRKWTBJYlpEbUhs?=
 =?utf-8?B?Ry9ST0c0U014UkdRSENNaXFGYm13akVaQk1Gd0N0S2hJNHlXR09VYndYMnU1?=
 =?utf-8?B?WmxURGhrdklXMmQrSEdGWXBaUTBqNTZsNlNwNjVCaUtJZnJtRDVzQi91YWNP?=
 =?utf-8?B?eER0TXpzZVhiSkkvbTUrZzU1Ny84V1kxMEJxeVRCQ2xMRjF4Yzh2Rnd2Nk5J?=
 =?utf-8?B?R3VTRUI5NXh1djFEWFF5Tk05TTg3azNnZDFCYlRtTnpVcWlKZWUwVVlXSFpZ?=
 =?utf-8?B?bTdwUkpCWWgvK1hrVFlIUTJabitOVW9oVkJZK2ZVUWg5ajFCSG03b2I5TnpY?=
 =?utf-8?B?OExQTVpiZUVwRHhCZUxmOFMraTRnQmg5ajBTWE5jT2VlczY1Q3NqR1lFNE9N?=
 =?utf-8?B?ZXJ4bGJnVGozc3g2dEc5K2NJSXhMVzhVa2JEZ0VmTzBxbTBGcDIvVTZoUi96?=
 =?utf-8?B?allzNERtQ002Q2ZZRlRIZVJreFVobVBXOFhqZ05ZdTlySzRZMDJQTHNranIr?=
 =?utf-8?B?dllzNy9FVitRT2hMeHNFNTRUa05xNW1VMWJXMGg3Wi9oNzNOT2c0T3dZS2pa?=
 =?utf-8?B?WTZvZXcrV1M3eWltS3Rwc2xvTDFvY0phRXR3YjRUbnlHZ1RkemJrNC94ZDBl?=
 =?utf-8?Q?aURzSHanVpZKfmMAflidSCHv8gg4CLBDTishdFE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmRZbjNxZ1pDTUFuazlxeXJ0YWNRVm9VTmJ5SHl1alhRZm1QWXh4bDFHcGN5?=
 =?utf-8?B?dlQ0aUZMaG1Zai9IOG9CTEJJeUxRMXdUaVNkam5DTUdRUjJtd2NDeDFxLzV6?=
 =?utf-8?B?NUw3aGd5d2didU9US2w4TldYdjFIUFh0TUJtdWlEdmc0OXZld3pyMzJKTmJk?=
 =?utf-8?B?TjlEVnlYaGtUUUZhd1lSejk2NGxyMThBdXBNbXhKMmpjK0l0bmc5NEJ3aDN6?=
 =?utf-8?B?c2dPNFJlNWZYUG56VXltLzZPUWNzaFo4Vk1FbUFLWExFMjJhUXVabnVwc25K?=
 =?utf-8?B?OTZCaXQ2Mkx4Y3RjVnpOUlBrdnl1ZjVwaEtSQkFFM0hkZEFsSFVWdTIyQll5?=
 =?utf-8?B?YksrOGtmSDV1c0lJT3VuNE5PdXZ4ZmpuN2k1VVpRbXJ2aURLV3lDSE41eEpH?=
 =?utf-8?B?a3JyWEQyNDF4S1M1U3Q5WG0zQUdRT2NCaFByaXRaSHJFU1Y0cCtIcTg0eE02?=
 =?utf-8?B?R2o1SXBnOFhlaWg0TEh6YlJnZGExalRoTEptdlJaRGZ6N1hJemk5NVl6L0JT?=
 =?utf-8?B?V3dJZUpaZXFVZ01rRXV6czdpNy96dkU3YmpxTzFoRmZIbHpjUzJocEVMVUxK?=
 =?utf-8?B?V056S3FSVkwvVG9MK3NhYmJ6QjFRNzJsbWEyd09WWWd1VXlJb2tXMGN1WXly?=
 =?utf-8?B?c1dFYkpDdDh2dmh0RWhoK0k2NVhTZjB5SUZZcllEbzNZVmc2UkYyRkR5MHN5?=
 =?utf-8?B?dWoyK2dicXRrNUJsN1dzWGQvMlN0c1NWSS9IZ3dWVEVRR1U5V2lhYWdSYzBx?=
 =?utf-8?B?Q1VBeWtRRThuMGxUUU1NVXpvT1BUTFNuSXg4THhWMHVVRUN1ZFkvOVBrTCtB?=
 =?utf-8?B?QWxRZ0daWXJFOVJOb1poRkNkZEh6cldhVGtXWnRZZytvK0tjcVBOb2QxaGxK?=
 =?utf-8?B?bGcyK2ZtUjZZTmRoQ09zajl4aTB2UjFHMlMwMHBtc2EzZkhkN1pQVk9WNytr?=
 =?utf-8?B?ZlJYUXdjbFgyRmUyV3dMbWJ3MTNIVzBSL09Wenh2OVdvc1NqRUQyb1dVM1RD?=
 =?utf-8?B?eGFwOWdBUUNxS3ZkTXFyOTlOdVR5alRhOWsvTnNHdEwzM1ptS0FwRGpTL0Rv?=
 =?utf-8?B?MDY3dVlvV21RbkI5RUpzc3Z6N3RGZmFCQTErVjZ1azVxR015TG5XUzlGMmxH?=
 =?utf-8?B?QytNOXdTUUhia0VJOGU0ajFPaGlUdU5RRiswMDJzR0JtRHplbTNEY2J0UUNO?=
 =?utf-8?B?WERoSzNWY2JSejJoN0sxUFowajQ2MmNhaHVKNXZxbGRlbzA2cDFYdDRMUEwy?=
 =?utf-8?B?d2d0OTFId2xRY3pvZkxIc0RFSFdOUlJxVStyN3RGc1VFb21nN2VsRHd5NURi?=
 =?utf-8?B?Sy9vUzlVVmRHaUR3T0xpWjE1ZVJuekJYN3AwcHdvU0ZTYVlXNmt4RE5qM2cx?=
 =?utf-8?B?VG8yTTdkTUlKR1lGV0ZTaFlZWTRuVm9Kd0t5aHRTb3VZVUZDbEswT1lxcVls?=
 =?utf-8?B?QW92cHNkMTVyK0xyOUZJZVA4SllGNndTcFpNTkdOblJZOUg0RUoycnQwb0Uy?=
 =?utf-8?B?ekNZM2JESFdJMFRObzhHR3VmYnA4NTRpTFBCdXJlbk50MG1mRXFPaUIyRnFu?=
 =?utf-8?B?VUZnTVNaVG5GS2s1S2tHeFVBOWtNa0JydVJJeTBzZVFCLzBHQ2lwdUVFWFBB?=
 =?utf-8?B?V09EMVBqbE9QeDl0Y1ErcFFleVl6NExhRTArbmE2ZGFHSlBIVDYxUnFvcWMw?=
 =?utf-8?B?dXR2aE9XUVNuYmtUeHg4bG56Ymx0R1pZYTdCcjcxaW0vRFBkSVkwekpJMUVI?=
 =?utf-8?B?QXV2dXozMFU3eTVMWExiL243MVhZcHpuOEI5N1hUOVl3RlJUOHZFUTBsb3Yy?=
 =?utf-8?B?OFBZeEpFV0xOaVFQR2tkdWM3ZFE3UVd0eVFZajVuNm1HMnpBcmNmYjRiWUJQ?=
 =?utf-8?B?V0x2MlYyY2cyTXUzdHc1OWdjTFYwRUtoVnJyQVVCbkg2cGtRWVhlZ3RNTkI5?=
 =?utf-8?B?THhiZW5PUUo1MzhuMEliY05ERml1TC9oWjhsRHpDMFhBOXF6NnduNitTbFh5?=
 =?utf-8?B?ZUxVOFBsdlZtKzR2T1NMcmp4cklQVGw1cFJmUmN1d1FqTitWOVBhc3dVWjkr?=
 =?utf-8?B?czJpalFYbEhMdXpvUFgzR2x1c2ZjWW9qejY4SDIzVXVuN0tJbXZBQlBCS3g3?=
 =?utf-8?B?ajRFWDhQcTdPWm1tVjhNWXZoWmdTU1pMVVVUcGZ1eFl1MG1BQ25qd2ZpaW1C?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7MNOhoSShnBCvV4v0Uz45HqFWNTHmP3kiRs5dc3Dj59RWn7prG6JA7xZ/Yn4Z62yQ5JRhsdTnblJCopA+5Cf9JLCT3qZujt9gBaXYp/pvIvuYj1i3NF9konD7s+VBJwE5rvV1t2gq8NIqCD/XSCe9Y0yExNlojsph0DNXuLPXDRfnWl1LTjUePkl6PQcWyvCSKo/mN/1nrjYr8RJijM9x8LkshouHjFw5ZHtG4h7UhyRe+SCclEDMzqsdZHUPXE9Ho7HV6b1NYHVJ3LxXOhTjmXbIOsyYf3N/pzXbUIz1RezbCcnvZAZh4dUJjVtnPnhBjhgwIb1vRzQLadyTeIs/sObUBgpxGHV70DfNfP7K2dibSHe45RR4dlRriYfo/kDZOlN/GoP5wjMbOkIXZNL6ULdJxuWFf8sBOs+qIOrYvTM9zbMEKEi3tRzpXHbxVHlvYTLE8so9YJM4Uzuf1he3J3yggstaodFrmaFXLwzX3n47BjV78E2cWaNnew3vEdszXZoHU6kBBthIS+FWYrFpNzzzL81cEbKUp9E7faSjWGppIFWaWIy1MZUx/hVfbUro/pqdm1ER46/7wDNEHsNHyr/Nvb7PaMmDNz0VqK29+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcdf3ea-469e-44de-19a3-08dc84bc23bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:31:16.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLJ8S0M3P4Nm09OGcoarS0vs+VKhkctQClNK1ikPUMcvO10kQg6fl6B799pfZXQ8nuUHtMc4J35GNtNl5DpLsy5pfT0PqR/FBvDXOnkGHV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040140
X-Proofpoint-GUID: DXOgKpgjURvX71QuG5MST8PsO87BgvwD
X-Proofpoint-ORIG-GUID: DXOgKpgjURvX71QuG5MST8PsO87BgvwD

On 5/31/24 7:04 AM, Ard Biesheuvel wrote:
> On Fri, 31 May 2024 at 15:33, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Fri, 31 May 2024 at 13:00, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>
>>> Hello Ross,
>>>
>>> On Fri, 31 May 2024 at 03:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>>>>
>>>> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
>>>> later AMD SKINIT) to vector to during the late launch. The symbol
>>>> sl_stub_entry is that entry point and its offset into the kernel is
>>>> conveyed to the launching code using the MLE (Measured Launch
>>>> Environment) header in the structure named mle_header. The offset of the
>>>> MLE header is set in the kernel_info. The routine sl_stub contains the
>>>> very early late launch setup code responsible for setting up the basic
>>>> environment to allow the normal kernel startup_32 code to proceed. It is
>>>> also responsible for properly waking and handling the APs on Intel
>>>> platforms. The routine sl_main which runs after entering 64b mode is
>>>> responsible for measuring configuration and module information before
>>>> it is used like the boot params, the kernel command line, the TXT heap,
>>>> an external initramfs, etc.
>>>>
>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>>> ---
>>>>   Documentation/arch/x86/boot.rst        |  21 +
>>>>   arch/x86/boot/compressed/Makefile      |   3 +-
>>>>   arch/x86/boot/compressed/head_64.S     |  30 +
>>>>   arch/x86/boot/compressed/kernel_info.S |  34 ++
>>>>   arch/x86/boot/compressed/sl_main.c     | 577 ++++++++++++++++++++
>>>>   arch/x86/boot/compressed/sl_stub.S     | 725 +++++++++++++++++++++++++
>>>>   arch/x86/include/asm/msr-index.h       |   5 +
>>>>   arch/x86/include/uapi/asm/bootparam.h  |   1 +
>>>>   arch/x86/kernel/asm-offsets.c          |  20 +
>>>>   9 files changed, 1415 insertions(+), 1 deletion(-)
>>>>   create mode 100644 arch/x86/boot/compressed/sl_main.c
>>>>   create mode 100644 arch/x86/boot/compressed/sl_stub.S
>>>>
>>>> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
>>>> index 4fd492cb4970..295cdf9bcbdb 100644
>>>> --- a/Documentation/arch/x86/boot.rst
>>>> +++ b/Documentation/arch/x86/boot.rst
>>>> @@ -482,6 +482,14 @@ Protocol:  2.00+
>>>>              - If 1, KASLR enabled.
>>>>              - If 0, KASLR disabled.
>>>>
>>>> +  Bit 2 (kernel internal): SLAUNCH_FLAG
>>>> +
>>>> +       - Used internally by the setup kernel to communicate
>>>> +         Secure Launch status to kernel proper.
>>>> +
>>>> +           - If 1, Secure Launch enabled.
>>>> +           - If 0, Secure Launch disabled.
>>>> +
>>>>     Bit 5 (write): QUIET_FLAG
>>>>
>>>>          - If 0, print early messages.
>>>> @@ -1028,6 +1036,19 @@ Offset/size:     0x000c/4
>>>>
>>>>     This field contains maximal allowed type for setup_data and setup_indirect structs.
>>>>
>>>> +============   =================
>>>> +Field name:    mle_header_offset
>>>> +Offset/size:   0x0010/4
>>>> +============   =================
>>>> +
>>>> +  This field contains the offset to the Secure Launch Measured Launch Environment
>>>> +  (MLE) header. This offset is used to locate information needed during a secure
>>>> +  late launch using Intel TXT. If the offset is zero, the kernel does not have
>>>> +  Secure Launch capabilities. The MLE entry point is called from TXT on the BSP
>>>> +  following a success measured launch. The specific state of the processors is
>>>> +  outlined in the TXT Software Development Guide, the latest can be found here:
>>>> +  https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf__;!!ACWV5N9M2RV99hQ!ItP96GzpIqxa7wGXth63mmzkWPbBgoixpG3-Gj1tlstBVkReH_hagE-Sa_E6DwcvYtu5xLOwbVWeeXGa$
>>>> +
>>>>
>>>
>>> Could we just repaint this field as the offset relative to the start
>>> of kernel_info rather than relative to the start of the image? That
>>> way, there is no need for patch #1, and given that the consumer of
>>> this field accesses it via kernel_info, I wouldn't expect any issues
>>> in applying this offset to obtain the actual address.
>>>
>>>
>>>>   The Image Checksum
>>>>   ==================
>>>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>>>> index 9189a0e28686..9076a248d4b4 100644
>>>> --- a/arch/x86/boot/compressed/Makefile
>>>> +++ b/arch/x86/boot/compressed/Makefile
>>>> @@ -118,7 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>>>>   vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>>>>   vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>>>>
>>>> -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
>>>> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o \
>>>> +       $(obj)/sl_main.o $(obj)/sl_stub.o
>>>>
>>>>   $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>>>>          $(call if_changed,ld)
>>>> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
>>>> index 1dcb794c5479..803c9e2e6d85 100644
>>>> --- a/arch/x86/boot/compressed/head_64.S
>>>> +++ b/arch/x86/boot/compressed/head_64.S
>>>> @@ -420,6 +420,13 @@ SYM_CODE_START(startup_64)
>>>>          pushq   $0
>>>>          popfq
>>>>
>>>> +#ifdef CONFIG_SECURE_LAUNCH
>>>> +       /* Ensure the relocation region is coverd by a PMR */
>>>
>>> covered
>>>
>>>> +       movq    %rbx, %rdi
>>>> +       movl    $(_bss - startup_32), %esi
>>>> +       callq   sl_check_region
>>>> +#endif
>>>> +
>>>>   /*
>>>>    * Copy the compressed kernel to the end of our buffer
>>>>    * where decompression in place becomes safe.
>>>> @@ -462,6 +469,29 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>>>>          shrq    $3, %rcx
>>>>          rep     stosq
>>>>
>>>> +#ifdef CONFIG_SECURE_LAUNCH
>>>> +       /*
>>>> +        * Have to do the final early sl stub work in 64b area.
>>>> +        *
>>>> +        * *********** NOTE ***********
>>>> +        *
>>>> +        * Several boot params get used before we get a chance to measure
>>>> +        * them in this call. This is a known issue and we currently don't
>>>> +        * have a solution. The scratch field doesn't matter. There is no
>>>> +        * obvious way to do anything about the use of kernel_alignment or
>>>> +        * init_size though these seem low risk with all the PMR and overlap
>>>> +        * checks in place.
>>>> +        */
>>>> +       movq    %r15, %rdi
>>>> +       callq   sl_main
>>>> +
>>>> +       /* Ensure the decompression location is covered by a PMR */
>>>> +       movq    %rbp, %rdi
>>>> +       movq    output_len(%rip), %rsi
>>>> +       callq   sl_check_region
>>>> +#endif
>>>> +
>>>> +       pushq   %rsi
>>>
>>> This looks like a rebase error.
>>>
>>>>          call    load_stage2_idt
>>>>
>>>>          /* Pass boot_params to initialize_identity_maps() */
>>>> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
>>>> index c18f07181dd5..e199b87764e9 100644
>>>> --- a/arch/x86/boot/compressed/kernel_info.S
>>>> +++ b/arch/x86/boot/compressed/kernel_info.S
>>>> @@ -28,6 +28,40 @@ SYM_DATA_START(kernel_info)
>>>>          /* Maximal allowed type for setup_data and setup_indirect structs. */
>>>>          .long   SETUP_TYPE_MAX
>>>>
>>>> +       /* Offset to the MLE header structure */
>>>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>>>> +       .long   rva(mle_header)
>>>
>>> ... so this could just be mle_header - kernel_info, and the consumer
>>> can do the math instead.
>>>
>>>> +#else
>>>> +       .long   0
>>>> +#endif
>>>> +
>>>>   kernel_info_var_len_data:
>>>>          /* Empty for time being... */
>>>>   SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
>>>> +
>>>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>>>> +       /*
>>>> +        * The MLE Header per the TXT Specification, section 2.1
>>>> +        * MLE capabilities, see table 4. Capabilities set:
>>>> +        * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
>>>> +        * bit 1: Support for RLP wakeup using MONITOR address
>>>> +        * bit 2: The ECX register will contain the pointer to the MLE page table
>>>> +        * bit 5: TPM 1.2 family: Details/authorities PCR usage support
>>>> +        * bit 9: Supported format of TPM 2.0 event log - TCG compliant
>>>> +        */
>>>> +SYM_DATA_START(mle_header)
>>>> +       .long   0x9082ac5a  /* UUID0 */
>>>> +       .long   0x74a7476f  /* UUID1 */
>>>> +       .long   0xa2555c0f  /* UUID2 */
>>>> +       .long   0x42b651cb  /* UUID3 */
>>>> +       .long   0x00000034  /* MLE header size */
>>>> +       .long   0x00020002  /* MLE version 2.2 */
>>>> +       .long   rva(sl_stub_entry) /* Linear entry point of MLE (virt. address) */
>>>
>>> and these should perhaps be relative to mle_header?
>>>
>>>> +       .long   0x00000000  /* First valid page of MLE */
>>>> +       .long   0x00000000  /* Offset within binary of first byte of MLE */
>>>> +       .long   rva(_edata) /* Offset within binary of last byte + 1 of MLE */
>>>
>>> and here
>>>
>>
>> Ugh never mind - these are specified externally.
> 
> OK, so instead of patch #1, please use the linker script to generate
> these constants.
> 
> I.e., add this to arch/x86/boot/compressed/vmlinux.lds.S
> 
> #ifdef CONFIG_SECURE_LAUNCH
> PROVIDE(mle_header_offset       = mle_header - startup_32);
> PROVIDE(sl_stub_entry_offset    = sl_stub_entry - startup_32);
> PROVIDE(_edata_offset           = _edata - startup_32);
> #endif
> 
> and use the symbols on the left hand side in the code.

Hmmm that is an interesting approach we had not considered but we surely 
will now. We are not wedded to keeping patch #1 by any means. Thank you 
for your suggestions.

Ross


