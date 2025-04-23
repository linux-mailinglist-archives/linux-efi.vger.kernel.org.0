Return-Path: <linux-efi+bounces-3444-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A502FA999C7
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 22:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BC74641C3
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 20:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A08275851;
	Wed, 23 Apr 2025 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xx3cn6sy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UX8Wyydx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91D1C8639;
	Wed, 23 Apr 2025 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441763; cv=fail; b=c3jzp7uQ7ZUu2K1Dmj+GsdVZjZruMLse1MvMpKlaNaiC0HW65KrJpkEOZEk0gY6i9v+9miYby0XdsI6GRBeS/hMkOdChuxA3xskfe5E898ccRm/hWcd1GlH+SI+OICYBOFOeQnHeGagrG5xBe7Ij1a6adK5GXR5HEQDF/SpF0iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441763; c=relaxed/simple;
	bh=dNqdymhAbdSPG3KCBb/fDlQj9MAVCLPoDD+qCyl1r3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gPmR36gZidaLX5q30dlOItk3ZA965M+Dh3FLNU+V4vBy7J0q+o0W4E1KNPq6oDoXGeO7JawRP8DR5v1/vPE5H2RMAKkgsCjd2XOrS+XEjUChKiOJysVzhOOQfYMUjQrvP8iWc12IG/Z9j+eaWq8ekdGckglW928+DjKxmKW0kw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xx3cn6sy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UX8Wyydx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NKBt67004738;
	Wed, 23 Apr 2025 20:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PGN20et/hxsKACyqFLExzaRT5AzlioeU/mNo+ODj9os=; b=
	Xx3cn6syGbRLuKtQ+pMUwmjjFwHIF2lAHxQryxNcwiMNDFag9bnvSi4bFrOPiB98
	+oN15C+uz6YoJvxtmG2OOiYheFaAaBIGYepUBBQvx2AVEfduFoeuvhqSoVIdSSb4
	wN5XcyMW/4CNzNosu2lxp0Sw+Gir2xb82bSHduEvLbbLN5mbXYdo7tR7UtDHBr4T
	WfyZwURIQd8gIE9nT9BK1BgVZF0yiAUJWKLLmzkLkj/l2LxIEk53sIzR4g98M5jn
	EGPYzFu7jNuHneAuhCLaptcG9FUDcRXN+eCWBIZAVZxQZmYLo4KjNuIThHB+7FEi
	fz6Uc3YV9/T25W7GJV38nQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha2aw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 20:55:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJgeQH025033;
	Wed, 23 Apr 2025 20:55:21 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012037.outbound.protection.outlook.com [40.93.1.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbr6r08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 20:55:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pui778Fgl1+lfRmUo26PPNwBtQnBxmf8YlFodndCTBRHRMg3FBgjy6fdX+ReGzPvw4h5HE1Qt+0qeNzAg28qn/cyRR8HQyx9qgVqLx+mvbWdnhcE1kgnaY0+OVYhq7DB+D2duRIza0piKlxcWV9abSxd2LkpHAiDjW62Rv8sbp+/ybK3kbr4tz4gaoQ/kxrGF6qz13LUSBzGoNcC9yH7U68/il20SR+lbscJO9MXj+78N6Dfg7OhKVK9thCJBW38RXXEjtj0L638+g7dMR9ZCiGdEkHg5kg+GN6zynD8q2CRl5c3i7XOXX67Xczf+vCXNw0QYIAwaGw/YxRsq8A2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGN20et/hxsKACyqFLExzaRT5AzlioeU/mNo+ODj9os=;
 b=VUTFqPUeFlVrkZB4FdtfAwM2msm/m+aGslCBO7G/+DD+l/SAfrQD5/AvCRxp/ARYcD133OqnC6LRVP+UDsBbIvvTgDz+B3bOhTk4kM4gf22OTvBR0tdSrhYS3BTf/UQGWk3Ri6rmZMHGUr26iGwHguAuffinf098SqWtisponzObOiJrRPa16BCPTf7P3kAo8rOqHuZTV7WbePJKAZwwQHl4MbBrzSFxNLozD306zUf42GuZYuTvhiJTMzpzHeWycXJqEeAWtdoZlp4YGTZiq3sUVHIT0dw41b12bJHoDPgHMlyTQrQ+TJCihF3kqNBjcZxs4Taf8Omi0/gAUAZfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGN20et/hxsKACyqFLExzaRT5AzlioeU/mNo+ODj9os=;
 b=UX8Wyydx0zzi/LyoS9XRMHr7Nh8H1AAWLPmJepfIGmn37kdDksLGqHxzVrXeMSCjwEFQEmJN+dXRkpww3yEy3MMfQNrLOQak3iR0xvlDSMYhAogEO+e8QkY+EmvxuQ7qsb1p6piAagyeJ8eF0TlfNiT+HSoqLLiFxEkoOUHafug=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA1PR10MB6073.namprd10.prod.outlook.com (2603:10b6:208:3af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.37; Wed, 23 Apr
 2025 20:55:17 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 20:54:58 +0000
Message-ID: <1e5a828a-c3d5-4337-bc3b-ef423e16020a@oracle.com>
Date: Thu, 24 Apr 2025 02:24:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/19] x86/boot: Place TXT MLE header in the
 kernel_info section
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-9-ross.philipson@oracle.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250421162712.77452-9-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA1PR10MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f67fcf8-f193-4b30-28cd-08dd82a91b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckgvSHg5M0YvaW5mZitTeTNiVEN4MitacUxpM093Wjh0U2RwZ0NSNEhXemtK?=
 =?utf-8?B?T1dOMk5VYkgzV0tVVHM0Wnh4TFlJVjJFTUxTcnJEd1lDb0FHVkJOYW5Cdzlt?=
 =?utf-8?B?eXB3UUtlNGlESFVBMWVLWVN0bWVxbitYNC81L3ZHMEgzZVZkdWFwQ2lReWNC?=
 =?utf-8?B?am9keWI0a05XNmRZV1pMUVRPQkZVS1BYRlhzN0I2M0RsMEIzb2gzY2VDbmdS?=
 =?utf-8?B?bVJHR2xrOWk5R0d6bStBWmdvL0lZSGpMb0xtZFNueDZzWmRRMjBVV1NLbjVp?=
 =?utf-8?B?bWNJMEk0Qmo4aTJzTEhiVXZCUXc5WUpYcG1SUWtSSklsOVZzeWh6aUdMZVcv?=
 =?utf-8?B?dk9QYXBjQXNRTytGK3I2YVNsUWZjYVNuY0VQTVhuK1VCL3hJaDhTV01sMWZx?=
 =?utf-8?B?RnhDYllwZnViczU4NUpPNDNhMGdlN0U2VVVvVTlZamtxS1FseVNSanllam9u?=
 =?utf-8?B?bFFVZTFzNlhFQXRBODFtNWNNVklJTEpuZDY4NGxTRnB1R3c5a2RCS1ZGKzdP?=
 =?utf-8?B?RUpKV210U01wVnZMWXlJSlltTHRlQWt6bHZiblc2ZWJVbUdVaE0zWTZNcGpR?=
 =?utf-8?B?OVBVNVYxYk1wOVE3eUZCTWgxNWQ3WSszSW1vWUM1OG5abGZKSllodzREWTFP?=
 =?utf-8?B?RWdWNWFPS05lcnBFKzF2YTh2a1BGaER1OXZ4QkhGTk9HTlVrcjhSWmJ6SUhx?=
 =?utf-8?B?bXFKTWJlcGp4c1l6dTBhV1ZyS3hQTTI5VDM0OE1COXB1amd1Qm1RKzRXcUM3?=
 =?utf-8?B?RnpuN1dyWUY0UW41UXhPejQ5R1pBdmR6M0h2L2lWWjJlcllXdHlyMk5oc2FU?=
 =?utf-8?B?WjhsTFEwZ05raHZpYmlXSjMvRnJLZ2hBMm5QckI5WFg5MmdlS1h4WUxDS3Fu?=
 =?utf-8?B?cytpSEUvcEp0dDJOa3ppeHUwd1NyOHpZL3dhKzNlSnVjSVd0d1dGcEFRbzVH?=
 =?utf-8?B?MFBYZWxJZlpFM0JxWlJsdGI1M2txREdWVThZTXJxUmFDbnNxV2huUkd0QSts?=
 =?utf-8?B?ZTVZRE05aU5vT1dsOFJLZi9mL1F6Vy8vNy9KVVVoL2s1dWVCUlBORjRjTkVu?=
 =?utf-8?B?OEhPWUY1ejh6V3U1RS9ZMzFGKzJQK0RvMHp2L2NHQzcwZFoxTDdZSkFMRjUw?=
 =?utf-8?B?eFBsVFZ1UGUzNVdGOU96TjhoWER3SXA5MzNjNjRCRXlhU1NoRGphbzNSd05v?=
 =?utf-8?B?VWorWmNBTnF4YUF0K1hxWkY4cjF3UXI3YUdZaEQwUS8vZzBabGl1NEE5MXg0?=
 =?utf-8?B?MkRyNDlJcjc4RHpnYWtEWmRzVVYrQVR0dEFUZGtNbFJUekF3RWFxeG9sVGcw?=
 =?utf-8?B?enBLbHAwbGJPVlNGdU1mRjBabDFlcFBTVTdjZG80bWRYZHFiTVFRcHU0WDBj?=
 =?utf-8?B?YnRmLzZRNFliVmJXaTJFV3kwRVlGeTdkSFd2ZEt0cEYwRmd5bFVGeGpObU1x?=
 =?utf-8?B?VUNGNUNnbmhkck1xaGUvN28xeVNxQW9SRHU1OEZkMzg2eDhYWVREOWd1V1Y5?=
 =?utf-8?B?eDk4NlN6RURSbjdQaE4vd3JJRC9kdHJXREdMSmViaUdHaGVUUkx5QnkzNWtU?=
 =?utf-8?B?c2NqT0VTNTc0K1ZNVm5icGphWitucmVPVjhHRzMxWTBTdUJ1V2dlZ1FZUmww?=
 =?utf-8?B?WDJtOTBOMUtiSWJ3YVpvN0ZYMjFqUktVdzBUZVp0UzNZSXhJdFA0VGJqaHR2?=
 =?utf-8?B?UTBxTy9JYlFqbThSTUZKbFBuNk9odC9YUlZFTHhmU216aFVPWjhRRDBuS2dL?=
 =?utf-8?B?Y3I2cEFPeHVZSVI2MzR6djU4Q0JmVnQ0eldURm9LQU8rcXFnRVF0VWVGclFD?=
 =?utf-8?B?Nk9IR0tCaHphYU9GYjRwbXd2TUVkTWRXcW1HUzlzeTQ3WnhrOFNXVWxzWEE2?=
 =?utf-8?B?TThSYnVvUG9mK0QzeE5oWU5nUXQ1eXIwQnJXWXAxQU1GRjczL0plb29tMlVl?=
 =?utf-8?Q?JuwhhU5CdL4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejRqS2MwM2pxNkNMbDhNODlMeDBVV29sbWwzenZjcmsrWkJnTVA1RitmTE5R?=
 =?utf-8?B?NXFEQ21PYVdBZkR1MU1hczRJRzREZHBqaDRMTnJrK1dpcmZiOWNrK3llNVYz?=
 =?utf-8?B?WTdqTU1odzZBOCtlaEFtYVU3WUI1SlpmZlM0Z3VQbjd4N0RjSVFSa2FqR09E?=
 =?utf-8?B?SEZYd0puRmh1V24xdHduaEtFSW51QnUrczR2VmkzNmUreTdFclFvTmppNlV2?=
 =?utf-8?B?UlNFbnJuK3VHWDI2b2hNazNiUWxDMXVPWVYwdjhnN25CSDdtbGtWOTFKWTVB?=
 =?utf-8?B?SHFUNlNCLyszU09ZVDFvRlBYNGMzdFFla1ZYYk5vYjNJWFNjYzJOa0Y1YVRv?=
 =?utf-8?B?Z3hjSjNkOVNucWVodklsTlF2Y2JtY29CRXBlS01rOFNvVlljRk9MTWdGUEYv?=
 =?utf-8?B?ODdYUUNEWG4rZnU0Z2dOOWRTWHVmOHQvTUx1eGZGWWk0d05Ta2wyNjFwLzhE?=
 =?utf-8?B?VWo0WVpocWRybUI3dUZ6Nml1QjVBRjM2OXV2T1p5RSs1WWlOaXo1b21iaURQ?=
 =?utf-8?B?K3Z1UDREbjlENldBZnlTeVV1SWxXdDFZU3AxVnN6Y2tqRUxjQ05NQWYrYU40?=
 =?utf-8?B?WEVSMnBjNzdBQ3ljWFZ0Nm5hQXl0bGF0bDNnaFAxVTdFL2FSYWVQZ0syYkZj?=
 =?utf-8?B?ejR1dmtSMXRmTnZPRnRpeFZJZi83Qmw5OHFKWmhLZGJmSjhsSDczd21GcjRz?=
 =?utf-8?B?WnFNR2xZcFR5eGtrOTkvQUt0bGpzU0YxK1hnWTB6dGMvbk9DcmNMUFpFMkdl?=
 =?utf-8?B?bVA5SFRLdG9SbXluSnlRWG1TMVB6Q21rRG80dWZ3T2dJOW8zS0ZsVzFNMzhP?=
 =?utf-8?B?dzVKclVscWdrb2ZtQ3R1RUlHY216VWhHbjNOdDh0aWt5WjJlTTJxT21UL1gr?=
 =?utf-8?B?MjZrTjEyUTFIQ3Vaazh5d0R5c2FpRmNiczRNemFZYUhxNVlXWmxDbHk5dGxO?=
 =?utf-8?B?U3ZEM1NFTTVxazAzU1pTWXlBdnBRRkY2R083emtrM0wzZGsvYTVqUzFhSnFa?=
 =?utf-8?B?alBGZVFJS2xVT0M3di84SVVHcWZjUm1Eak10cWQrNFRHS2puc1FhTUJqNUhy?=
 =?utf-8?B?Zzd6eUtPZytkS3RBWGtuZXY1eXE2b0l3NlFpaklFNTBtNUZLYVU1YmZjVTlV?=
 =?utf-8?B?N3ZHQkNlb2F1d2o1TGdlVjU2dW9vbS95bkxDQUFBdmJDU1d0SFdwbHhHNHZM?=
 =?utf-8?B?K050RXNDZVU5ZFVoZnNhdmFvMEdBby9vWkUvMDZNazFhRWozZkR1cGFkTXhm?=
 =?utf-8?B?aVZUYTI4YVJsV0Jaa0d6RTJwSmVPMjhrc05IRnJONWc2WjBZcUQ4TTZ5TWo2?=
 =?utf-8?B?bW44UGdyWDY5WjZPWFF2UWhOK1JNTDhvQmtZd0pCSjhqeEIzR1lhSGRtRXRr?=
 =?utf-8?B?M001NitNRDRvMXgycXkzYWFKWnZDU216OW1QNmR5aU5UWHhIVENsQm1XSGlk?=
 =?utf-8?B?dFVZTWNxZmF5cHVlcEZCRXE0dXRLZHFrWVo4RTM4Q1dCNVp3a3FBSlRQczlE?=
 =?utf-8?B?M3crUW1iU08vSnE1TUVmOTduMjlsTlc2bHlramxHbHRiTTV4UnMxcjdudHRj?=
 =?utf-8?B?VkdwYW5TVENSN3pNQ09rdkZzWkIzTFIvL1RtUWk1OXFJcWhRMHJwaVRYRUgr?=
 =?utf-8?B?Zm8zOWZpRVA1WGtDK3g0MmlHQ0tOaWUzTmI5QzRYNmE1ZU9iODZwdG1FcWM3?=
 =?utf-8?B?aTk5bVlFN2V0MDIzMHY4SGE2ZHN0bjBxdGplYldiVG5PcjlQOHE2Zjl1cnl1?=
 =?utf-8?B?TGg0dm9JaHVaSVZQelpLa3JKN1MrQWRDSU5hUy8xdEVkOHpxNXdWUkJ4VFhu?=
 =?utf-8?B?UjFSSk11aHNCY2F3MmMyM0Z6L1BHNHk3Zjljc1ZRQTQrb1FlNC8rN3k0WnJQ?=
 =?utf-8?B?WHA3RjRCSVdvMGhSaE5KcitTOFk3dWJ6K2FuV1FlYmxldlFrZVE4R3RZZjFE?=
 =?utf-8?B?a1FKMjZON1h5ZHExOHpWSlpsVUIrQ2EzdmRXYjJJdW44ZjRPOUxabkh0SVl1?=
 =?utf-8?B?TTA4WFFYNUhBbEZQcGY4R2p5R2ZxaGw1YVo3NEpFd2sycmZEMDZJQzF6b3FJ?=
 =?utf-8?B?a25lNUloNnpSQ2FiMWZrTHc5S0dyQVBaNWUyMFhiQ1NQNDBLTzUvV1NiK1ll?=
 =?utf-8?B?VzIyUG03RSt1UW5LSkNNRUlUbWVlaDJyajIzc1JZVmFpbVBwcHVReWlaWXJt?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/YqR+07u0+jRF1jLhLi7Z6sFsF64Ees/r2UyCVZbjX4baK5Fced5YW9wy/daQ8ID3mchU45f2nodyZSYbcOE83UnQ8TwNQ8lgLCDCPc/8kjCmNrog9MRAunRnHo8QvrIbx1zPzdrg+QnDW1obvykZLtYxtL4FBE8QBn8cZLg962HO0H0o/mEorvukfIgwpHMuh0yr1JptaRYuJdbZrnH8TnXtwH2pnDGDexJP2AW9KiY7NFQhKIU0fSx/vug+dsnguZdAzUi0UD0M4FXhKXxZK7K4UgxxhdhKnkKZHlibAW2UjBlgkIrEV8fHRrFnXjHq5ZIzRjPv+ZF2P+T6Ix84MVIq+PlC9wOkRbr2f/57MdJlJOTAvuT6rouWotbSsgcR/G0HZ6oB/GOdPuBBoFj6a/WFlPQmDBSOl1LOIEkrJp7HpDSHjBe8yZF5wfTAvIOZyptWxArPMFTJMEivMxGQm20XFSW8ecHS8Mp0LfhBaLMc0Jr4EPDSNCnpZQWGdMi5qwpjr7/Po22GAi/x+7fqTBEKl4XiHqw6BsvvWCPHtZlO6CaXW8YEwrVqb/C90X3ZPUB1DNOERrHssUoxwX2R3PXGxYltHTgwERdEkqfr9M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f67fcf8-f193-4b30-28cd-08dd82a91b99
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 20:54:58.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtjluEA4iuqeO9q2+J+MugpFNoZ0t0pRgzTiHuMWWYdpTjj6ma0rkhZayvS/HCfYJ0Z49+2jK4KneyQ6u1ulmdNeptlCo0OC5yH97dHX4o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_11,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504230143
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE0MiBTYWx0ZWRfX3wGhcDGHWA7F BzNzX4FNwIbh7O4YkS5F0Y43ZE6+jAJrikGAJcojz38of14FDC3KIERNLk/8X16Il7PpsLip/Zn C9PgQA47GeZOuUzXo1E/5R+qBFQ8gIUJ9vXzwNZXOlSRh5swvOn6HLyd/X8D2ffOGwpVlHIeEGc
 VuBSD2eaix3ddILRNGsOSUvP51q+DZOpbSgDhcFeUm3nUaaMMztL/FuZOwuhFftIWcl7Fc7aK5I k7nqsVy8ZlUZMndel621AnuF0oi9ptmRIu9xUQoVsDKLXVwqfK2roCIs+S+MKCBPcPi9GZ6EC8y o3JV6H3DfcTL9t7Bl/EJL+4gs6Qwju99K++CjJgqsdsvmG5l2BynHrzbgKboQWoWF62v2rcq/Hd 08SuIy6G
X-Proofpoint-GUID: WLNxolDSB5nW82gqWVUFFR8iCsSWnFPv
X-Proofpoint-ORIG-GUID: WLNxolDSB5nW82gqWVUFFR8iCsSWnFPv



On 21-04-2025 21:57, Ross Philipson wrote:
> +/*
> + * The kernel_info structure is not placed at a fixed offest in the

typo offest  -> offset

> + * kernel image. So this macro and the support in the linker file
> + * allow the relative offsets for the MLE header within the kernel
> + * image to be configured at build time.
> + */
> +#define roffset(X) ((X) - kernel_info)
>   

Thanks,
Alok

