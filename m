Return-Path: <linux-efi+bounces-1169-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA998FC1E3
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 04:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19ACF288340
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 02:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B774EB55;
	Wed,  5 Jun 2024 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XsGc90Bu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WcgCbRN1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838D73442;
	Wed,  5 Jun 2024 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554875; cv=fail; b=Ft3aUOA3ieaXbT8RKOKavMG0YADAS03CwURu4ILatnR/lUCSJK84G1Y3O4aOgk3zspD1szIb+VKOLNetB+F/X440lLfhKhczhw7S7VWgHP8mpA8o9hMJgc4qWjMSGuNN1W6dF1zxDJAtTQq49tNyAfHe0yVPt+VQ/2NR2QrkCTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554875; c=relaxed/simple;
	bh=8jab0DheewZDnfemAKzmcpt32GVYn2+SALMK64mbBSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VCaTbpmKwrlTe03KSG/dirYfQyhQ6c/wiAK22r58WcAVxkGt3JTL7j6cad3xu6ktrOvx/p2MGkpLKdWdUhegd3BQTCDbtrV1sPxGFD1ch8KDj+zqrrGc67WFAsX/+cise+gmmPbpWqNsvBSkn8MsE0izCEaGCnMY4vIV21S371s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XsGc90Bu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WcgCbRN1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4551EW4h006303;
	Wed, 5 Jun 2024 02:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=Xsx8R9cWoJKEDYdPomE5gIYA5/rvKyem+7cHrWFFi/I=;
 b=XsGc90Bu1jmxG4WrdyYWSypa9h80Dp+yVN72YpNCOVRS3ovYW3XwgpHOBmWgYY8DnJAU
 F3rxwVqGrxMqg0vQWRUwsrO3TycZ6ZLzpwYapnaluQaCBxrLj0Y1iaokPPkM8MJsVwmQ
 Mhlu6lWucir2diSubRV1OCkYnIhBAbmrDZBV6ro54vgG1QHgn+JJpOLOsStLmGFOaRGM
 aedJAUQYZPwOZlfocdE2um6WtYej2ry1pYqajZ7Ctt11mIDL5wmqB11E9n53kcVLiY3x
 lJFDk3rfSj+BgD/ifJSCcnxZEh3o0b8JY4oLUMmp3WRHvunSHK70mxCCQP6f9utFllqg 6A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrh864y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 02:33:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454NqQCp015562;
	Wed, 5 Jun 2024 02:33:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjd4bp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 02:33:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kf1rQMIJBrQy9qcOiOQT5kiFxnaTvFNdkWyXYnaZgi2j0X/cnC3h1mZTnVdKHoLbcn9uryOg42R5Q/HeZVuxPBRzGWNeWnAhTFWXUF4rb1ihzy36j/ODXEOIoDxRJ8e9XYYsLhYd7iSts+RvfoEcOl4VvSXuyBTVDUjx97z5gVZKX/YGDOTFpdJDbcY6T585/tFaHISMOKbD1Ml/UfzXJ8VDwhoAw79OvJxLaMP9PJ8tW/zZItC98hFhuQjxhiz7JK02Tu9k84QP9xlHy1UiGKhLho+2iaK1txT0mFK7RWxd/THBnzgOjQjYWqG2s6y868EPhCRDAIxOkpWwKGRYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xsx8R9cWoJKEDYdPomE5gIYA5/rvKyem+7cHrWFFi/I=;
 b=kIB9aYQYgQi/N9T1X8ACrLCSpSPadzeSn1yXFH5JfnWKi4H/uOCW2aRZ6eYyUUSMhEJhE0RcOB+pbwjyCSI+qKBoYfXtKISiLWMXWdXN5PvsHLPqsBvz/JMLoKUPfTw1LyDQ3pSUgVWVQbzHT+4UFBknoBttjnO2M72lmZHbp4hglJhIWN/JDgPmpEaNIEJspCG5USRo0PbHvuuOvWIAIeq+mEzfBwZ3bJ9/TWKtk4LsRbRo4UPSxVhJTN1xHy//lJKhrwiL+WDwWYndhlW8aCyRDiW1TICzNWGzNWJp8x4XsKh7MarpCT9wle3Okph8PiRCCFr8eg9LILM1zg/7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xsx8R9cWoJKEDYdPomE5gIYA5/rvKyem+7cHrWFFi/I=;
 b=WcgCbRN1Hvq6IgTJOrVL21UlcnaItvGVt9O6fpcdH8DSVyCImzUDF/5u0tKHH6rgL/Tgrl5OIbd7SyoriEIK6I1xg4/8b+EnlvUkdFFaGdV6SU50c/PTeQE89g2ua00F/UYwwXMTFGSUSDnHoz63V3g9dP2YBBWDO0diiPi7+ww=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 BL3PR10MB6065.namprd10.prod.outlook.com (2603:10b6:208:3b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 02:33:24 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 02:33:24 +0000
Message-ID: <f66de08f-4905-48d6-8bcf-5b1ab847492f@oracle.com>
Date: Tue, 4 Jun 2024 19:33:16 -0700
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
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
 <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
 <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
 <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:335::28) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|BL3PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e5db28-d90c-471a-f443-08dc8507df41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bzhKUDdLM1VkS0llMEVTRUNsUkZGMHgyTm5xZjF0V3A4aWIveDBqL3lTZkw4?=
 =?utf-8?B?RFRpRVdHV1U2bEgrMVJHU1p0ZWR1OUFWYlorblM4MmdIaXdvZHhhUGN6YnBE?=
 =?utf-8?B?WVJ6ZGF0d3pac2JOWE5CUVlXUHBIOVVKTFN6OUE5UC83N0VKZURCUjVNSFk1?=
 =?utf-8?B?Q2Z2OGdMeERqLzYrem9ZeWdKYkM3MlFCYnlQUUR1UkgzNi85eHpMVDBBNEVm?=
 =?utf-8?B?M1Q2R29lakwvOGZjQXRiVHMzWWsxNnZ6RnZXRC8zNFo1WTBOODNIaXR2QzFF?=
 =?utf-8?B?OGtudnVXRHRQSlRFb0sxMzZ4a2hXdE9kVFpoVEtzLysxUHVWT21TSkw1Yk1F?=
 =?utf-8?B?aE9HV3V2WGJuQjdGWHppeUZpNnk1RzNsVmJERFlsUCtXSUV1TlJ2U0RCNThZ?=
 =?utf-8?B?UkhRWEFUUFFnUFN3YXY4R0RkUkdMbGY5bXlDTjJPYm91bkdSSHVLSE1hSmZN?=
 =?utf-8?B?UGxkYzhrRThGV2c1N3NNVGtMWndZYWdrTEM4dzM2V3FWWUIvckREcUcvUElB?=
 =?utf-8?B?emNPRnFVc3Y3V3NFRVlqSUIySm9nemRXb0FWMWxYdXpUSVF3WndkeXd5cXU3?=
 =?utf-8?B?S2thQU5hNWNZeEZpRHlpT3RkRU41Z0pDK0NqOURLaDdYNVVHZFVhd2RHdGU5?=
 =?utf-8?B?d29jQ0o4S29BV3dpYUFDbGdWZTVDdXFRNG1RWDFVQzV0d1lVdDNaQ3V6MUpO?=
 =?utf-8?B?b1BHNWNYaWdtWENVZjVtdWdLOElITmxCcFlVUStyQ0dUREZBbE95RU1DZFFP?=
 =?utf-8?B?Zkcya0FzM2NNbDZPalowUXpNUjZrd0JZNFpQT2h4OXhIdHV5ai9ycEI2aDEx?=
 =?utf-8?B?RjQ2WkNUdE9DZWFiaWpDTkRPR2tiMVpNdHFPak1mL1plVEQycC8wSmJaMzlQ?=
 =?utf-8?B?MHdMejM2OHk0U1FKZ0tlQmYwSU40WVd6dmpCZUQ5bVgxenVJaTZsK1FWeU95?=
 =?utf-8?B?Rlg2ODBZUjZuVHpQUFphK1ErQ2lVMkhXemRURGRQZGhuUjNEaDRHL0ZaUnVK?=
 =?utf-8?B?OW5JKy83ZE1WdDFub0dUYlZiYUx0L1JGRmkyazhobW1rV3UyRFZYcDlmMG5i?=
 =?utf-8?B?SDlMayt2SnRxWnhtbkVwdlVCaWd1Si9yZ3Q3KzNSZGxjNVlXb3NRTmJrQUkz?=
 =?utf-8?B?ODRYZjJyOHYySUtLaldlQ3poTkE1b3FhbTBjWDN1TnlrajJYVUljMzFQYjlU?=
 =?utf-8?B?dEJ5WldxRkVaQWlnRzBIUEFvOW85NXdPb0tubW9LWGI5STdvYlF5aWpGdFdk?=
 =?utf-8?B?WEE1WXczOVA0aXJvQUV5OTFZRzM0aVZZNkh3L1VONGJOSDVaUDNVc3JaR2ZD?=
 =?utf-8?B?QXRMTE5QOFdIN2gxWWMxcDE2SzJ3MFFINkZacmNja2xDUWNSWTZXVzJwWGg1?=
 =?utf-8?B?ZHh3SXBCVEhya0xzYS9LdXJXS3Yxd2tmQ0lQMS9OWmJSbXdVaGFUWmVYZWNR?=
 =?utf-8?B?cXFNY21XVnFwK3A2dGR4Rk9YSURvaTZwYXFuMW42TEVJKzlqRzd1b0pjVVIv?=
 =?utf-8?B?WjRMdklUMFJoZWszSldFNWtieFdpeUxIV3kyYWRxdjF4TitMckRNYVZ2UGN4?=
 =?utf-8?B?UHQrVW5xdmlYcTBWMjliWkFFeEJVQkRDN3RHa3lFSGYvVkZHSEZhcndueG82?=
 =?utf-8?B?QkNOMXJTSlZCMnJrbVFjaXgxeHNpc0ZHUk1xME9BWmQvVy82c1orRVRmUXZE?=
 =?utf-8?B?bnowQzN3TWZGdFRVV1R4NzRTQUloTWd6bURNQTlZMFEvQnF3YTVhcmJRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHVEcXhiRzZDUFZSa0xjUHJVcmpGd2FtdGJuVm1xSnFBcHg5c2JRK2dmUnY5?=
 =?utf-8?B?R3RmZDljT1FrWHovL1Bqb0pVT1k4Vkd0NDAvZ2FYTEcva2RmYmxFR0ZiRmVu?=
 =?utf-8?B?T2txUGlBczVyWXVZNzVIK0xSTEtaZ0hCeXhBOElTdkI2d1JicGZ6U21tWlBR?=
 =?utf-8?B?d0tSM2R1bnUxVWhTLzJicGI3bUtaaTdJekZWa2NLYnE0Z0c0aEtkOVhqbEtk?=
 =?utf-8?B?bmpCQm9HY0tId2F3VEFLMFczRDV6ZUVpb0lGWWtkNEF4RGlGUWd3M1VrdlM0?=
 =?utf-8?B?V2UwdVQ1REYyR2U0MUUzU1RFV1NORVJhWExLcHNTaXFua2ZNQjY0L3Z6QnZ0?=
 =?utf-8?B?WktMTEZLUllDcjVLVVVtY2paSkI1UFlsb1VnL0NVa1hHTWE2YW5LTUZaWk45?=
 =?utf-8?B?b01hWWNvdXhtOGpJazYzc1V6d2M2TFZJMHRxYmgxNHhxSXc1S0t1S1lFZGFM?=
 =?utf-8?B?MVlWNXFmVTJKa2V5WlhYd1V0K1dDOFZpcms2V3hWVHRoOWQwVXVnOFBKVmh3?=
 =?utf-8?B?cnY4WXpyanJoWlJTRU1ZbUVsUWNlQkFFMGlWSXI1RTI4NlVJYkZJcHBKbEwv?=
 =?utf-8?B?Y0R4dE5tV282dWtqYVM4YmYrdW1lY0dlR011UFA4UWhXVmxrRjEwbGs4Z0FL?=
 =?utf-8?B?czZ6bVlNVnNVU00wQXVsM0RrR0xFNWdoODhCcW9rbmpGNURrZlV0cFZTYjBU?=
 =?utf-8?B?RWpYMVFxQ090QXV4SFZUS01tWmxPNWFyR3ZmdDRGTUxmd3Blc0VXRldOcTVE?=
 =?utf-8?B?dmRWUS82cTVzbXdwWWlyZXgxUmgzUEkrZ0VyY0lhSU9PWEhhNEJlTlhld2pE?=
 =?utf-8?B?L0VSK0RlemtYTTJIcFhaellIc0RWYkQwdDlGNVdhRnZtV1FRRTEwOEg0TytK?=
 =?utf-8?B?T3lVWEVDWkZGTzAzTWc0cUpLdGhQWnZzODVMb2xmclJYSytMUTExVGdUSmc1?=
 =?utf-8?B?NWh1QjZUUStGTUVkdEZFRlFXYVpDayswZEhqMUFaRVJudmpsVFZCK0E5TG5T?=
 =?utf-8?B?bnBweGh2SzBESmVqemoxVmRMenZ5akFzZ2NjNGlXNGNLUUVGOHRuMkEyZnAy?=
 =?utf-8?B?ZUUrdCt5Z0QxWWZZMXpQd1lTc2M5VzhKOXAyaHJpVUplL2xlYUtEKytLZG5h?=
 =?utf-8?B?VWNQUENtK21hRStUS0dCdDNIVHdEY2pXc2tyVEQ4VzUrZTJnaTJrZFFBaytD?=
 =?utf-8?B?SkdSNzdOdlBQajlZaFdaOTB2Z0lCdWFqbE85ZjI0UHQ1VUxiZmFReFQxaGFU?=
 =?utf-8?B?SWdvWm5rd2YvWE5SRVJEUjdXaE41YjRvMERKNVBkTlZKTnllc3JYZ1ZPNWJk?=
 =?utf-8?B?R3ZrVk1QVGpzcW12eFR1NERpcjhhR2FoQjZYWFdMV0FXTmpXRG1FcWVZaDVw?=
 =?utf-8?B?OVRCc3EzWGpoOVhMU1RtTHg4alJJdEZVa1F0VlFxa1N1UTFVcEthM2s4ajlN?=
 =?utf-8?B?ZWh6Q1dVQ3NSVWd2Z243bEFQYVM2SncrMlZHZ0RpcVk3MDVvcUxhMVVqczIy?=
 =?utf-8?B?MHVSVzhSMHltRnJYekpRb1MwVmh4TU1hZzBpVXJ0U3k0SlVjSG5LUmhKU3Fx?=
 =?utf-8?B?TjdoTUk1V1lRaDFTay80VXZoRHlSdHR0N0dFMFE3SXVPTysvQ01pZ2dTRUcz?=
 =?utf-8?B?RGJMdlcraG9tSGVielVxNmtVS3l4bjQ1UFJ0bnFnZkRhR3MwbGdzYU84cHox?=
 =?utf-8?B?Y2lIeklkYWFSZmFsRkV0cEtaNDcvaVgzckg4aGtXakp0aXQzRHUyK2VGTm5u?=
 =?utf-8?B?WGM5VlBEQ2E1TXg1dWlJRXg1L21wc3h1RFYrQmZ0b2NJUE0wQVBLNm5sTkN5?=
 =?utf-8?B?Si9XQjVFbVRvT1NoajRvS2FHUHVwY3lZYjFVYzlURklnNnJaY0U5eWlWdjRu?=
 =?utf-8?B?eEcrL2x6dmlQWHFlWllBYVU0WFU5MDB3QXJ1Nmk1cDV6NnlSUFVLeFhQOWRS?=
 =?utf-8?B?Z3RpOXlBV2VmbVNDcDRDUkgrRy80OC9IMWRLc2xDVE53TGFrbVZobTBSZUZX?=
 =?utf-8?B?OXFiaXdVSkpaK0ZFK2tyS0UvZlVWYncwUStBekM2VFR0M2NIeU45cStQdU12?=
 =?utf-8?B?eUtZKzQ2MVAvb1hVUUtPRGZ3YjZQb2xTZk9vdzdPZExEVDFGMnNPalM3VGEw?=
 =?utf-8?B?dWJrejZzYkZqelQwQ29Mb2ZvdDdwRnZvN1FmQ25xOFZDekhreUpmd0JQVHlR?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ygdTtnmdlgQ//qdJhkyXO8JWqzgX/wdjmr/TXg0c5Da2ftQZJnSYOcjNvkMK5v4VMw1+mfe5pg109LTAzGSgyTUKLUIQiyd8ll4mtHJtQuOzF1Z/rERBB7QtzhcK37Bnl7FsEJLnmVB6HEKp9sAOUa7a0KIoyTbTo6dp4KPjTJjQ2RybVdVRhjfWXXZrhkskbRyZGr9zTjQMG7So06LuOt6L68UqtsJozpRQgda3+wvyhEDX9C5U28W8cEZkp3PjecEQ/94O+Yp1bcbuAu25/NdzOMFJdAml6DYego6FDf72pMOvVr7cgBfWziNBfvhFumDlQorKmWZ/HWXkAtjJaexdj/K2brVWI39nBdtyIA9jdzYLiqV3wuJnlqUDw4/e6+eqvkjeCqnE3QRh4AZTDIc0Br0xo8WpKY9cTc3TLu14QjcubAtnnxmd/KG6oXq6/Bniqb0h8hdvBH9w24uW3vyOjvbo4kMNXIhyHD83eEHM1Lx72ZYUV0FKZtangPfIdmsjEp6F7dGOoXqct8cPaLta0P/PnTV9rc8q5bqHWkMWaGwY1AJn5N7ybk1ahX6M0nMjBzbS+qowJGAX0z+lKCbNvFbDXqIBebpUdMA2Gfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e5db28-d90c-471a-f443-08dc8507df41
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 02:33:23.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8u0ZBOuMTO2ziYvph+L96K3IcOgmqR1DO0geZpbSNlCAp0DS8U4e2a8HUAOYRGWOY/83wS1ftNgZpoCBromtP9SoH+1wLyx3Ni3m6Ok9THg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406050019
X-Proofpoint-GUID: WanfVeA4EBRnZK9g2lLdMF4s5Jj-hMzg
X-Proofpoint-ORIG-GUID: WanfVeA4EBRnZK9g2lLdMF4s5Jj-hMzg

On 6/4/24 5:22 PM, Jarkko Sakkinen wrote:
> On Wed Jun 5, 2024 at 2:00 AM EEST,  wrote:
>> On 6/4/24 3:36 PM, Jarkko Sakkinen wrote:
>>> On Tue Jun 4, 2024 at 11:31 PM EEST,  wrote:
>>>> On 6/4/24 11:21 AM, Jarkko Sakkinen wrote:
>>>>> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>>>>>> Introduce the Secure Launch Resource Table which forms the formal
>>>>>> interface between the pre and post launch code.
>>>>>>
>>>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>>>>
>>>>> If a uarch specific, I'd appreciate Intel SDM reference here so that I
>>>>> can look it up and compare. Like in section granularity.
>>>>
>>>> This table is meant to not be architecture specific though it can
>>>> contain architecture specific sub-entities. E.g. there is a TXT specific
>>>> table and in the future there will be an AMD and ARM one (and hopefully
>>>> some others). I hope that addresses what you are pointing out or maybe I
>>>> don't fully understand what you mean here...
>>>
>>> At least Intel SDM has a definition of any possible architecture
>>> specific data structure. It is handy to also have this available
>>> in inline comment for any possible such structure pointing out the
>>> section where it is defined.
>>
>> The TXT specific structure is not defined in the SDM or the TXT dev
>> guide. Part of it is driven by requirements in the TXT dev guide but
>> that guide does not contain implementation details.
>>
>> That said, if you would like links to relevant documents in the comments
>> before arch specific structures, I can add them.
> 
> Vol. 2D 7-40, in the description of GETSEC[WAKEUP] there is in fact a
> description of MLE JOINT structure at least:
> 
> 1. GDT limit (offset 0)
> 2. GDT base (offset 4)
> 3. Segment selector initializer (offset 8)
> 4. EIP (offset 12)
> 
> So is this only exercised in protect mode, and not in long mode? Just
> wondering whether I should make a bug report on this for SDM or not.

I believe you can issue the SENTER instruction in long mode, compat mode 
or protected mode. On the other side thought, you will pop out of the 
TXT initialization in protected mode. The SDM outlines what registers 
will hold what values and what is valid and not valid. The APs will also 
vector through the join structure mentioned above to the location 
specified in protected mode using the GDT information you provide.

> 
> Especially this puzzles me, given that x86s won't have protected
> mode in the first place...

My guess is the simplified x86 architecture will not support TXT. It is 
not supported on a number of CPUs/chipsets as it stands today. Just a 
guess but we know only vPro systems support TXT today.

Thanks
Ross

> 
> BR, Jarkko
> 


