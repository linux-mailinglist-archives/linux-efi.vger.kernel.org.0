Return-Path: <linux-efi+bounces-2800-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ADEA3A7C8
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2025 20:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D02318942F2
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2025 19:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156F11E832D;
	Tue, 18 Feb 2025 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lRhm3ada";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YC8X7XBW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E681E8332;
	Tue, 18 Feb 2025 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907651; cv=fail; b=ncGjD7djSSF4+oGS6FiZHyal8gLkOAlT63+AG6yGa5fz7rZUmwhnqpm0trKsro3U6s3m6umGJwosOi/eX3qtdg1rLIZVazca9uRdwnpDFaSuiQ6JX3RI5zETnWgiU3qAO4Cpg5MH0Y61QCb0tfanJu9dyZzRMs2KClHtMWJBAYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907651; c=relaxed/simple;
	bh=xDjm0dzi8hKeHpoU1mcygyJYnxPDVFt1R4ryfpc2MUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k4DrTIPkCqYtxi/S9pXRdowtNeahXalgk9JbKukMr4kVNfkHKScwFFBlMgfD9XqQTAHmB/GsdyjVWL48C6n1NblinUCwiOz4ZyNVbeecQWGBiTuespLPT0XsQroNnRBs1QurQXc+ltPK6BsBlPb6sBviQNz5SLj5kcMcKWFtsYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lRhm3ada; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YC8X7XBW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IJ2q8w024425;
	Tue, 18 Feb 2025 19:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=utg1lsr5+4FsbNhuolDZ/5yOEfBi9bK1EKkrALjlSTE=; b=
	lRhm3ada/RTVrZ5gC/EXlbxu8oyrfpW7NlAC5g6+0UEQ4e6r2toutl57q5c5qJL2
	r8ADLkfavWcSr0Xu1m82qcceBsaBk//vyjqb+PVgeSvRqVu8e4rRWrWN7yhcVrvU
	42EpCc6MZdyehrzmRzujuMG87p2RLxHmtg07wWP/VOxuAqK2TzbxhW6ToKGJHL3Q
	oRkeQejH0pDPS7KZQpRivFpJMppFV4n7dcecOD5URsKh+nXmFqrOoJjmBr/kOp2O
	FKdafXoa7SpZjbxbLRMrolFc2be6etkKHWPwPLVxpyAJvFIpfNchuPLBL7mFSEGu
	TAyxTOl8EpNMV9SPrN3yEQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00ng35s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 19:40:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IJ8XPj039015;
	Tue, 18 Feb 2025 19:40:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thcasbh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 19:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3Wdxvdq2iKNtqcjruhxwkqQLPS+pIkAA2mV3jq1/T5yuyaCdRjABDiCGIsPkO+GSu2TDbecbCdV3TWr0baCZhQyKHgXwcewnie2ra66wCIWzINqwLKlJ+hJeXdEAyTEJs2EW95yfdxUq60Ah4i+jHG8XaRWgPYV8q5SB7umNZIKiWNoIxcWhgoVJznCPhAdOKb+AQlPNZqKJDy3e8K9l5fWY0iXljgdc4b0igQU7JI9GgwGnKW7HFjRwclx1T1LNyML62WNK5SIelJvZwBoR1Zv/zfczL/bPyXtqeJha8OPAs3VV865eiKLtDbylGWG69sOQzsqmQJ3IFhh3ZgzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utg1lsr5+4FsbNhuolDZ/5yOEfBi9bK1EKkrALjlSTE=;
 b=KOOb8N2uBbvutfhnrKaBZxSnE9Lg23jOvGLM2Qnj6qLNFerkSAc2FvrA1BS5hIvx6/juUkvt6muEsCZSr2SIaiYnBL64KhBYaa16rqOb9/Q4Y6qSrKFBOaHlQZUprt8zjpxfOHlDxc6Ypc7OwC9nvxIlcR1QRyqq8SZXF39Zg3jSW5yAlqp35xvDWO4LZEszdH1isjrLZQU2yBPVjoPJkDR+nMK/n0sxL6xU7CYMYOAz0xfOgdbTFaLxfkDkJ8SAUTFcvFLh++li+ztUwjhS2joZX/uTtNC1rZxKfppOTK44N1S1MOZv1I2un1xOIlemtsO9wBtmfIEXzQGmXe1a9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utg1lsr5+4FsbNhuolDZ/5yOEfBi9bK1EKkrALjlSTE=;
 b=YC8X7XBWsvxVDomhSOJSmEU929F4f04Ch1Q4KwUxKZNZl/t/w3yAQFfA7mNPdj6XVQCY9IqoC5NQNqm6QH1znI5bd0cdHh3A2Xe2R7lt7rj5n9bUrS8Y1HGejVgdP2Z7Vv0D8g6lSlzV893Xq9r9X24nXVo+9QULT/GNia0kVHc=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SJ2PR10MB7040.namprd10.prod.outlook.com (2603:10b6:a03:4c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 19:40:05 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 19:40:05 +0000
Message-ID: <86a65510-b17e-45ac-841a-8a2fd1fa3446@oracle.com>
Date: Tue, 18 Feb 2025 11:39:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
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
        trenchboot-devel@googlegroups.com
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <060ffc99-59e8-4b71-9e7d-daeb807332c3@oracle.com>
 <eaa0d608fb78d06caca26edc9a830cf1a02f9fb8.camel@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <eaa0d608fb78d06caca26edc9a830cf1a02f9fb8.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:408:e5::21) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SJ2PR10MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb355cb-bdaf-426d-4069-08dd50540af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHdDVjh5Vmw0aUwwV3Nzbk5pMEZiU3FhVjY5WS95OXgzN2Fnc3BCbE9UYjdC?=
 =?utf-8?B?UGF6ZitKMDJydTk5d2NqTzd5aGxqWlhkZUJXNHFWNXhTNHQ2Qm1NM2hyTElq?=
 =?utf-8?B?cDh4ZUszZFo2TWx4MmpibVdORGwweHlPM0dyN3JUYWxWbEcvMFhVOXpCRHhw?=
 =?utf-8?B?SkxUMUhLMldNZ25rRmhqaGVoNVVLcHFzMkJxUVpIbzFuVC9lanRKRmU0VElp?=
 =?utf-8?B?YTZ3WVAzU0J0SUhZV3N4SG96c0xJWmw4MEsvOG5XYWYzaWdXKzByd1IxTk9k?=
 =?utf-8?B?Y2tTS0dkMGVJbTluNmNnajRNakMxYVlpK0g0TXlFOThhTDFQY3JMVFdJbm9U?=
 =?utf-8?B?Yk1hY3JROHh6VnhkRHdzUzhTS005VWJ1SlZVQ0dzalo4ZjZ4UDIrOU1RTXlD?=
 =?utf-8?B?ZDJXLzVobUxRYXRjT1FJcmt6ODEvSnFZdUJLUXRYMkdjcFVuSTlSQlg0SlNB?=
 =?utf-8?B?UGlrNWtxUTJsRUlZMHloNm9WS2dKRmg4VTViYjMvWjBBVUM3eXZIaU1pdDdQ?=
 =?utf-8?B?eWMrRk9TendqQWR0N1ZtbVp3STk4YWNscFZ2YXNTMjdnZXhWb212YTJrQzBw?=
 =?utf-8?B?b3FRMWRJLzViM3Y4dG8xQjJYbjFMdFJvaXBWYWwxTnBlcU94a2hDc28xTTdF?=
 =?utf-8?B?SUQxMTRrYTB6cHFIZlYweXpZM2t6K05MTDdUZTZCOUNaZFhrTGJSeDhTSUFO?=
 =?utf-8?B?MXFFSVZFRnNmOWUwZ1gva2VJQ1UxVHNDaFJTTi83M0IrbDRwVUtCL2ZIWjlv?=
 =?utf-8?B?b2FFRFlXM0J6ZkRPNjY3Q2hPRlVla3BxWHlWWHZvVHlDN3FyUU9oN21ZejY4?=
 =?utf-8?B?MmcyMGdHSmtBeXVXbkVaL0hWL015amZOOVgrZlV1azk2LzAyYWJ2Qk9sRS81?=
 =?utf-8?B?bDdQcUtMRTJZSjMySzhtMTd0ZEQ4TnRqRHh5UGFSa0FjVTVPRGU3cWU3Skp4?=
 =?utf-8?B?QlBYQnh1NFB0Qms4bS80SjJwZGJpQ3lndUtLdDZkSzJpVkFhQzl2bW5TNTI4?=
 =?utf-8?B?S3Rlb2NXaEpRUTJUTXFGZk9yQnQ2Zm1MQXhaZHc4SEZoTkZ0SWlJK1dPUWps?=
 =?utf-8?B?em1ycUZ2a1ZsZ3lGbnBLSnk1Ykx0T1J3WEMzOCtwRmUxQ2g4SUJ2V0dSalpI?=
 =?utf-8?B?dGhKL0lFUzZidEt2dWswY1FzMC9jeWM0UE9RRDFsVHFwYWxSOGsrMXZZM1ly?=
 =?utf-8?B?WXBVM3l3M2tCQlVBc1A1YWJKamd5Z2wxMEljZ0lPU0NXbkZsYTVaclZpQm9D?=
 =?utf-8?B?MUx5UXplOHlYdG9GRld0aTFscWZYSVpoT09ORDRJYURKRFU5dWdnNXIraW9Y?=
 =?utf-8?B?ajNCWGFkNm1IYVBnd3JxZ0F4RENscnZTbmloZ3RkRkZTZmw2Lyt5VHN2M1J5?=
 =?utf-8?B?SEJZVllGMTV2OHIrV3V1UExBRURKdzVWNUxLNmFKQTlZQzFsN3ozdGk0RTB1?=
 =?utf-8?B?WnlDQkIwb0NqOUpUR2pseEQ2SStEOWZFV3c4cFY5bEt0Rld0b3kvNFpyZUtm?=
 =?utf-8?B?Q0JGY2lMaVdRdkNuclc1bm9qNkp2ZVFSb3dIR1ZvQTRqY1NlSXhWbHpsQjhi?=
 =?utf-8?B?OVJhVVRUanRXWXJDc2szOHpoVkp4SUZOOCtGVlZDbXRQZ1JaR1hVNzJZcE1i?=
 =?utf-8?B?Q2Q2VTV6NXY5dExFNDRQd0lwc2NzVFRtdmpQQjB1SXFLNHJtL0U3L1Z5YWdo?=
 =?utf-8?B?N1BFUWlkeUdjSld0RHRmNENFdUdsSkRFTFFHM0VQOUdYQ3A4U1lSeGxBRGFM?=
 =?utf-8?B?VDVyT2dGZVVUU2dPMFN1dHBJU3k5aDZ0OTRoeC9RNmxuWDBhNExscW9oRlRD?=
 =?utf-8?B?REtvQVU1L3pEa1BGb0hSejdVWm03NndTZFpHYmIvZUg4cHpGSzJ2YUlzSmRP?=
 =?utf-8?Q?nVnJJI7Qz6PJQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0xEbjRjUHY1WFh0bUZ5emo4SUF0V1V5ai8rZDR2WXFlbjg0di9nQ2U0WlZt?=
 =?utf-8?B?ZTUzNEpPVCtnd0FBUEozd0tEN2xSbUdRZkxsZGFXdVVQRndpaGVJbmt2SjFM?=
 =?utf-8?B?R2I1Ty9PVU80UmgvNndWS1JaMUYySXVEL1BvQ3NKdFFhTWhTZ0dXcExxSkN4?=
 =?utf-8?B?REVuNnl5VEY0bkJXcHV2MXhNdG04Y3ltNi9uaFpQMWtDRVlaQXI5d0libEVq?=
 =?utf-8?B?NXdpNG16ODRKc0phb242bzcyTGhPLzBzc215dnFCTDQ5TUJlb0szbElMNWtL?=
 =?utf-8?B?cFZDaFl0U05jWUFTQkpINW1qTVpjZnhhKzA2ZElKeGdvZ1cwb3Z5bkJwcWt4?=
 =?utf-8?B?d0RIYnRqdFU3SXNETVNndVk0WGNjUG5TRi9yVG1PY0VDNWozZkxoSjNEZVNa?=
 =?utf-8?B?cmlGWElJcU9pU3ZTMjhTMHl1TENLK2Jld1BXd29ROThmRVNpMU1BOVdWVUpk?=
 =?utf-8?B?Z2VQQTJzZDBXdmdGY09RZUNsWkY2Nkd6TVRGb21sTXppMFVWeCtkenFweE5i?=
 =?utf-8?B?OVVFNVJDUXd2dWZONXFBL0ZBYUpWN3VkTmJhT0VxTi9HRXRDOVlpRkZGTWwv?=
 =?utf-8?B?T3RMcEczNmVrNEk1R1BNaWNUWWx0OWFIYXIyZWY4N1RpRjYrUlMvamlyMUtq?=
 =?utf-8?B?TUIzVXNuWitiV1hLV0hGa3Vrc09yam9ENThJRHpTclUwcXZ5VUtIbUQ2aG1i?=
 =?utf-8?B?QzYvd3orYVp2NzZIVTc0dWMyWDBxT1EveEUxN0crbXUvUk1iNXBOdXhWOWor?=
 =?utf-8?B?VktVaDZrS2tnNVJzbUcwek9oREIvS1pEc0YrTnFqTWxjaUo5QjUycmpmeTlr?=
 =?utf-8?B?Vlh5dWtJSDB1RjUzaFVNbTFHV1pza2dYUkw1ejMrby9ZK0crdmpuWU9Td3Bm?=
 =?utf-8?B?OEFxYU5acXhCaXI2N3d0TmNTcURBOEl5WUlmQUxMc1ZrUVhsRlJIeHk1VFFl?=
 =?utf-8?B?UDJHOGtWK05sbkFFZm9mQ2pReVNwS3hwa0N0eFJKeFpNMUhXWUJ1OXpIMjVa?=
 =?utf-8?B?N3hxMFdNYjdZRmhPR2RCTDdwOGtNVTBoWTkzeG9jRk5CMk9WSzl2Y2xMUjN4?=
 =?utf-8?B?RWJvalE1dlA2SWlMd25IcXZNNTQzZlJTUkpZalpNZTBvL1VhWDBqUE13d25u?=
 =?utf-8?B?TGFoeTNqanB6QXl3dU5rekEzWWl2UHc1aTBKNmFBTDVMMzUybkltZ1NKaTlz?=
 =?utf-8?B?MCtjNUlDZW5JY2hBWXBCS1ptSG5yTVFsczN2ZnluRTB4ZXhJdFE1TjZ2Y01r?=
 =?utf-8?B?eHVSSFM2Qk5xNE1YQSthckxsVzhLbDRSVHVKckVWSFdBNGR5Y0dKdFZGT0g1?=
 =?utf-8?B?SzcvOTZYUjRRM0xhS3JHbElqNUg1ODBkd0JDWWRvSmYwNC82RXBiTFptQk9S?=
 =?utf-8?B?ZWFya1ozVXJwWTNwZllvNDNEZkk5MHlOV2JTbWpVVlJYdFFPYWNGN3plZFg1?=
 =?utf-8?B?RmNQNEZaYnRVeHdtQURZQUpkUWV0YU9YcFc5c0JBV2s0ZDhTNkRqYUF0bExC?=
 =?utf-8?B?MVdUQ3FUV3VyOEZka2FoRGp1QjdPR3NtUUwvdEZGMytucG1LcytwKzdTSVhr?=
 =?utf-8?B?NmlPamI2V2VDV0loZjdQZDlWenF0TFB4Qys2dmg2NU5hTW5vUEZhVWw5K0Vl?=
 =?utf-8?B?eXJIWjQyMmwxOHNJeFVoclFRdlREeHlHaWZOaXBwUUtrOVVsZUZVbHV2amQ2?=
 =?utf-8?B?Y3VEanVINWhncnJxV1YySml5M1AxRHNyMDJPbGN3T2owUnpNRlY2TkhwMnZz?=
 =?utf-8?B?TVZDanM1ZXEzV2VVc3B2R2IxSTdETWtaeVFmNWZiakVZYzVucDk2cmZXbzJH?=
 =?utf-8?B?RksvcHBlNHZlTE1tSjBqV0NYczlVdkUrWTVGdElFTlZqVDErM05jb1R5RlV1?=
 =?utf-8?B?T3U3dVYxaVBweEVsRzlkN3ZrN2hjSFI4ak81Lzl1Z1NVbVQyb0hrMjRMZ0Fo?=
 =?utf-8?B?aVBtWW5CZlVTekNlU0JiOENEOFp3TEN5bzNneG91QmkvWjVCdW91L3pKdjVr?=
 =?utf-8?B?OUJycXhFYkNvUG9rczYxUHBJRWh6bVczL3MwQTY3b3VxRHF5bm11WGpDWi9r?=
 =?utf-8?B?a1JVdVJNb0NPYVNjUUpIQjhNNkFWd01XMG5jZG4wbFJxamhnZTVTUG5rSnYx?=
 =?utf-8?B?eDhua3FhUmhrT2Z2VXdHREttMUdXYUdHZTRHK0JKY0dqaGoxVmxrSXhGb3lY?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uLKbVPgaC45H4xhivsz5VpGu3x7IcCckrK1W0rSxPNrnEwOD7SRSK3sJRFUdGzv9CGk4oEicmxzx0ly8g2DFLU/pVja604na6arON5kd1leOtXI5jt42ke9Kyi5vQY9nJRdc21EjLgn6CEjFPjEqx1GG5FYmVWypFWpSmSkmtiuDaA9VEQ3HP460Tl87tH6s64BujFHqDC8kuLxTt6EbeXr0m0KkdrBZlPicfZqP7m/hN/VDW0sHrAJx8je9DGBbTXj+m3xXp27h1zJsRs06bIWNMXqX9e4Ct8lYHlRJx7c9FLTj3P+439C9/2Rg7+yKMiuR38k3hYlC3DbdK3vC/5bKdlGVw2G7n6B5vXsWmk1HuhncEuopOEx+r9zYJPAHrMCsAkOKCeLGlK4AmkCsMCIZbbFsEyyoT46bGmVkUoPBDDkcPpOi4Jju755atBD77Pwi83sxxo3fzueg0/tzjlyVh0enYjOTYtklSGHU1B7O2eqPcVL8phSnvlw+M2+sUwvMqP+BvQv7SxLrRIHLQB3NxbbHk2e0VDDmB/G5YfGSEhbe4fOawoPgUZp3AglecvxJAz5cJdobi4YG1jTXBaT1M69Uh9kKbGsErnOPmGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb355cb-bdaf-426d-4069-08dd50540af2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:40:04.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbmU/hpWksUZ2MZubL79nUqIsCJcZAevcxMgYpF28+SE+59Oa2uQh60ro1d2ydATJzJx012BdPUIv+G890m4kE/Xn60+jm5HnLvmfODX29w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_09,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180135
X-Proofpoint-GUID: nBb1pahi6t4dN6iPkZRM5h1vHgoX0W-z
X-Proofpoint-ORIG-GUID: nBb1pahi6t4dN6iPkZRM5h1vHgoX0W-z

On 2/18/25 10:31 AM, Jarkko Sakkinen wrote:
> On Tue, 2025-02-18 at 10:21 -0800, ross.philipson@oracle.com wrote:
>> Hello folks,
>>
>> We posted the v12 version of our patch set in December of 2024 and we
>> have not heard anything on it from the community. We believe we have
>> reasonably addressed the issues as has been discussed on list. I
>> realize
>> there has been a lot going on with releases etc but I just wanted to
>> send a bump that these patches are out there if anyone has time.
> 
> I don't know what happened but to be totally honest with you I missed
> that version. Maybe it was holiday rush but yeah still I did not skip
> it for that reason per se, just that it could very well explain the
> silence (people tend to fast-forward more at the time, and then
> mistakes easily happen).
> 
> I'm right now on holiday up until end of this month, and this will
> require enough time that I unfortunately have to postpone the review
> up until the first full week of the next Month, in order to do this
> properly.
> 
> Still, apologies for ignoring this!

No worries at all! I sent it right before the holidays and people were 
busy with that and on other things. I appreciate your response and plan 
to have a look when you can.

Thanks
Ross

> 
>> Thank you,
>> Ross Philipson
> 
> BR, Jarkko


