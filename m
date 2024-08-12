Return-Path: <linux-efi+bounces-1538-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F75E94F72A
	for <lists+linux-efi@lfdr.de>; Mon, 12 Aug 2024 21:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD94282BD1
	for <lists+linux-efi@lfdr.de>; Mon, 12 Aug 2024 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF6618E02B;
	Mon, 12 Aug 2024 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DpttxGDS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U6QB9VjY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F6C156;
	Mon, 12 Aug 2024 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489532; cv=fail; b=ZBgVd2EBdU2DQnYvoWQjySF4Rugs/3k9xb2xK/ewM4/kgEA0arl7MoTwfW4Ncis5O7oQf/3Deb41TEJnpxfNUpIFdclQnn+VcQy3rpm+tZprOBzCBMcb1yEW9ftxIXUEG+ZpWZxZvG1QMjI2e4iLS0+EpRTicCiGCuuqiduekBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489532; c=relaxed/simple;
	bh=1681xn6qaaHeglZM4YLqHYUUSzh/Bve4YFK6ohhZlGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g3rWv0ahVqKK4aHSY/i+Ge9QQOUCdS8tvoT9h0GrqIV/Iu8Ajc9Osmfb7SYpKu0fDDPoi7f7GayiUIdY/OoMO0h2kv7cP/2fcWmlMrVue5gyZBKOXAqRVg33RWx5bLcC6CO3oPBKAXu+F4ET37YbxjLkxK2/VyzFBt6iL5Fcv7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DpttxGDS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U6QB9VjY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CHXwF3008583;
	Mon, 12 Aug 2024 19:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=HvxCMm4/h5M39PlpOWlwtrunqnj1+qps7Nsz/Mphz90=; b=
	DpttxGDSRQQI+t3W+euRlewfNf1SKKCL8Gg5fPlynnbdpv+8LuOaVhROMw6QBKAh
	zSw0ueS2HaDkOwj1CKzHo4t3rvvJdyL/ev1zthUzmvHI0LmBZNo/aQfrlkN/sibb
	oCotPQP8nUYGxMSmIgTLsXDEnuggCnI1OwmAx98pi3S/JcCuFgwr7LRnNR+uPYBg
	LmWogzckM0H1PSSFzkpukV6glbI5tenG6SNa/0ZPrGfcw/blEF0Qag/JRSj0UBg8
	O048potyEgnChPe3bhGF0JRxGK7OIkTdUBn0NtPx1ucrAHSLZ2CA4f2KW/D1FR1G
	mmpezG9WSuCghhPipv15NQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtkcnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 19:02:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CHGHg2003818;
	Mon, 12 Aug 2024 19:02:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8j13e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 19:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljBBkDeiydAx3QsN1WHT2BcwuLdt6bNneis7aq+gdbl0tIn74MirSrsiUa+2evlcQhvMiVgsS9UihWBzybsXV90SPl2S8hqxAjF3hzniykdZ3kmuELsL9FdHuA1fqP1fKFh5K+WfG3Y5ZVGmpQZX63/zydBwPM515qAYVFSVzaywJ2+4OW6R+ttpj4mSx1aFF4s5Uv+BUvkDxWt/5go5herz0aWyzuGpxzfVlC8irsXqgGS+qqfG2eHEFEC9Opp+S6kPeuW5OUVRItVzHb3PQPdHzvCxYe7h7DFi7K45XiM0LfFxO0p2ifGEkbtJ0+REx8y1GnIEmcZMtPFs73EWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvxCMm4/h5M39PlpOWlwtrunqnj1+qps7Nsz/Mphz90=;
 b=kOdhOf79fWyjQYl7iiZyo+12SpZzIdUgN7wrvuCouW6CHxRbH6Xc1YfZB1lRAQVNKKOElxcLuqeMy3fr1j7JZDAGqWkixeon4rFcz9JDQA1NYnJQAKwjNxB109ysuO7hFto7r0NbE7n0v3d929G86f2oXIocym3+ADv/nE65gJxFjDVlJ++BuzqoRjT5PZ9BKshaLEfJT8GZVWwn/n354f2uD14Ss8SIYJ3sBy6m4t3AWng9PEBetxZwlE+hHcfJSodfqHTNncgUavDMrS5BLzvHqJBCffSLhzNq0Px+7hoLvxxjUnys+lzn+1IoMlhKV9tfw0t/5Rqo2UXZcaCJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvxCMm4/h5M39PlpOWlwtrunqnj1+qps7Nsz/Mphz90=;
 b=U6QB9VjY5fjYMHLY2Tav6FWiB7mlOeEK7QAmTuKgqcbsQGUVC+Ho5ct7YfQZkp+vwrxs7KI83PRvPcPe8Tik75oPxAqN3xb1raYSAQQIAnZOFZD16IYC0G0poC6sKnglgOtXYMl3Wa0CiOxeXHJFuSK35HeKTS+IFY0sXZ1u1Jo=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CH0PR10MB4923.namprd10.prod.outlook.com (2603:10b6:610:da::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.15; Mon, 12 Aug 2024 19:02:26 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 19:02:25 +0000
Message-ID: <ad84cdaf-bea6-483e-82f3-c83a6b7006c3@oracle.com>
Date: Mon, 12 Aug 2024 12:02:18 -0700
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
        trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-10-ross.philipson@oracle.com>
 <D1RHZDG3HJNK.ZWTFLXDBEXD1@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RHZDG3HJNK.ZWTFLXDBEXD1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:408:143::8) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CH0PR10MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bea787-5d32-43e1-07ea-08dcbb014db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTF5NGVPaVN3MHp0RzdmNVVheGw4OVNYUzUrbVJyZ2xoVnk5R29NQndIby9R?=
 =?utf-8?B?ZktjR3dlN2MvcnlqOXlNMFVSS2hrZnNyRzdHeUZMcktTVWpjMVZnNG9IdkZP?=
 =?utf-8?B?VzBKbFZ4UGw2R3Y4Ym9CakFBZDV0ajZ3WTV5ckVjNlR5cks2eldmREM0TDVE?=
 =?utf-8?B?NFYwaDFxVGdYdVBxdERZeFpYNC84Z0NmdlVQalpUbGpHMndtaGRsN3NSNVZB?=
 =?utf-8?B?MHQ3dmNZeHBmWjREdnhPMDdEbll0VjZvRDU1QjFFNEcxTUxNcUZ5UGpndkFj?=
 =?utf-8?B?elR4Y2gxd3doNENtRC9ZcEppMTlYbUpqQkIyVkxFMUxaTnFMZGt0bnh5N01r?=
 =?utf-8?B?RVJLbmtHYWdVd3IyWGN3UStCdkFGN3d0QU1NVXBQaTJvbEpaZkxnU2Z4cloz?=
 =?utf-8?B?MTZUZmgwVlN2aitJRGZqVE5xbHFzYWl6STFCVldwbFRGWVlmU0Z6YWNySDUx?=
 =?utf-8?B?eDhhaEo2K1B6VU1oQ0VWWFNVdmVSMnpLOTE1c1hIdllrQXFKS0dseCtObTV4?=
 =?utf-8?B?VDZhem9FZUNrRDB0ck80emEvQnMxSFJxRERRcnEvM0lRdnFRQlp4VHVwZklE?=
 =?utf-8?B?Lyt2dmllVkt1TkRoRm5GemRybDFhWENGUGRXcW5BY3ZLT2Y4bXBleW43VklF?=
 =?utf-8?B?SnhRM2hGKytTSlFBUytjaEV4eHRWTTBlVm9FWC9JZVNvZFRrZlhodmRmN08x?=
 =?utf-8?B?NmtBOGVHNllSa0Y0REVkV0twN09VV3l0T2RVdDJTY0VuQ1JwZXFFOE5YSW5m?=
 =?utf-8?B?M21LTHVncEtJZ0h6MVZNNVhFWnNhUHJLdzBrWGhkV2NhcFFYM2VtTzcwSzM0?=
 =?utf-8?B?OVc5NnVDWXkyTFpQNi9ERlBkNzNVTVBrOEpSL256M2p1SWVXVjhISHMxNjVv?=
 =?utf-8?B?S1BwZnpuYlZ0Z1Rnam9CVVNqUytMcUx4WlFLNS9ObUN3eWNRM21idHQyTXp1?=
 =?utf-8?B?akJWRXJEOFZ2emptZjdhdFNyZzdtcTB1ZEN3OThwU3FjeDJWOFp2bWFFa2FF?=
 =?utf-8?B?ZFdQT3BPOGxTMzJrbVJXVkF3Zml6TXQ0ajllQ3IwWWxTbW0vWDBtWmJyOE8z?=
 =?utf-8?B?WG43cENjVXFiSEQxaXBrSVUvZFRyZTA1ZXNTcHBsandxcnBKVXhURG5VVnZI?=
 =?utf-8?B?TlgwTCtHdGVwdFdKWi80c0lJYVN5Mms4YUlzajdmUGpXSEh2Zk5NckRZRm5x?=
 =?utf-8?B?NnU4anduaStIZVViMlU1Z2JQcWIrdjBZemtMeCthVnFtUzRoOHBoR2ZZa0Qw?=
 =?utf-8?B?YlhiU3ZHMGZHL21DWjdWdjFHWUk3VU5rMkdicG05K3VSeUpxUFNRZkJUY2hp?=
 =?utf-8?B?STZtUXdXR0pKTmw3cFM3YzFOWXR3U3gvRllBbCtVanNWUlIvcE0vZ0t5Y254?=
 =?utf-8?B?Y2VSYnJmMlQ1WTRCcklza0NhLy84eWVuVWFuOUtQcXRnNDdFcExlUjd2RFVh?=
 =?utf-8?B?ZmprcUkvYWZVOGZrV2Z5N2FuVE5iYyt3RTgyRnpGTmkrKzVhekR2MUNzNDlG?=
 =?utf-8?B?cGtsNS9CRkV6RTJqa2p2QlV4eEM1L1BBekFCMmhhQnVqdE9sdVdIakl3SUVy?=
 =?utf-8?B?N2ZWdDJjT3M3cEE0TmNqcHBkdU1HM0pKZmh3UXhtSFc2b09KbE5wTk5oOGw1?=
 =?utf-8?B?NGFueXZqUzNVRUZXdk81cjM0ZUVpdmp3Ty91RitWa3VjdWd4MUwveVJYb2Rw?=
 =?utf-8?B?bmViT3EvT3RVN0NSeTNkdExNWHpHU3pNZTlnbHlibkNDanFyUmdEME01N0s0?=
 =?utf-8?B?dHczdUFRMUJ6Qkd3UXcyRzJiRmNYOU1zUHdOZnd1ZG1McG1BSzFCSEMwejFX?=
 =?utf-8?B?V1VkZ0hSQTF6YURhVEpiQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWhaSFhyeVprSGFGc0lqU1ptaGl6eXJxbmtxMno0TzI5c2JMVXl1ZUViZFpk?=
 =?utf-8?B?dHVrd2YrcnErMFJjdmNFbXlMcXc2RWMvc3NqUldhdlhuN1dpcllZZ1ZVSC92?=
 =?utf-8?B?aHFIZWhWTDVIUjFXZXFBWEVDU1d2MnVkdU9RSGkwWHlYNlhmZlFjVjV3cGxp?=
 =?utf-8?B?U1FFYTUwOERhcEdVM2gwMXJqdVhnL09xeklBTzU0T1pnMkN2cHlyVnNNQ25m?=
 =?utf-8?B?U2NraGdyRWV1M0RWTkhmZ1lSYUFidUw1RU04WGtIa2dOMTVsY1ZQUDVDQkov?=
 =?utf-8?B?QnM2dzNzVlE1cGFNNmR3MnJXQkgzd2NGQ3Z6elVCV1QxZlBmRFhxcnkyY0Ur?=
 =?utf-8?B?NW9WY3ZOK1JpYlIreElDbnIxR2hFQjFTYllVdjlCaFk2c29PdEJvU3N0Vk1m?=
 =?utf-8?B?YUM3WnRsd2xJem9qbDZ6dC8rRmVrTGxYcG9yNGYrZitoVWtWekdQS0tkUDUw?=
 =?utf-8?B?U29zM1UzUVpkalhXNnFIeFNqSU1EYTg1RnNicHFaVU81bEQ4Z0dVU3BzSDl3?=
 =?utf-8?B?K0hKVDFXZEVUeW1wNUdrT2pCeEIveURvRG0yOWJzcG9YTFVUTjl1ZVV2aHJN?=
 =?utf-8?B?Qk9STm9ZTXFZRUhLQ09OQ3NKYzNNQ3Bicm9MMEVlNEx1TVE2czRhei8zZ3hN?=
 =?utf-8?B?YTJ6ZmlUMS82Tit4SHNyUjBXRDlLYXE3RDNMaVJoSDloZFFadlBWSDRoWHRT?=
 =?utf-8?B?Z3cxRzVCSVJkV1RxODVON1hZOWNSaGNrQmFoWmVXckZVUmphMTBteENMM200?=
 =?utf-8?B?RFdJRHlySVZDMXZvMm5jSTk2NTlydVNOaGVoV1VNbXhWNk9rYnVMTnptN3pJ?=
 =?utf-8?B?blhMbWZoZkRteGR1MGZVdXpEbmEyaU11QlVleC81dGNGcVJxU0d4NmJnMzZp?=
 =?utf-8?B?azZDTVpqV1hGamxHQ0JZcmdwYXVncFlUb0VRSDEyWXlYTFM0eFRrVnkyeHNV?=
 =?utf-8?B?YTcxcVh6TC8xWnJZU0JJQ0IzcHlLa2hPbk9yV0JMM1ZaYTVZUUZFaU03WlVI?=
 =?utf-8?B?eWNNM1cwa1ZIQXJtVnFwb1k4R0drcE1uSTVyenV0RzA5MmE4aWo1bFVOak8v?=
 =?utf-8?B?QTBkRHdQS0c0N1hEUGVubzFuMTJIbWN3M2drNmFYRFBiY3pGd3BIbXZsYkFx?=
 =?utf-8?B?OFFHTGdsQ1hEbFNYdm5SQU8raFJHM21aaEZRZ0VOTFpiY1BGeW1ObUlpRXdw?=
 =?utf-8?B?QnN0NGNOdWU5ZTEzT3Aydy9lOWZrdElQdjBOaGM1cDl5UFA0T3Y1bWVEOWUz?=
 =?utf-8?B?d3J5NkhqcW5QSDg0NTF3WEttVnY2MVFLVm9BeC91clR4Sm1ZWlJiVnFKT1Vl?=
 =?utf-8?B?OFl2Q0dlY2MzRGRYd1VZTjA1ZlhKYXVWMld2RjRieTVFbzBPOTF0c3dMUnJH?=
 =?utf-8?B?enN4NXVaQW5BNDA0ZVFaaytlUXFDNUxuUGt4b0xTRkJZZ1FwSFBmdzhnTStq?=
 =?utf-8?B?c0QwT3JrMXBtamx2dm1MK2tMZzlZWi9TTkYwaTVaSTlENDN5d2lqSjBybzBB?=
 =?utf-8?B?a1ZJTkhJMkgreTk5RzVFa2EvTTBFYW5WSWJXL0tQenNLbzJOaGtuenU4ZVJE?=
 =?utf-8?B?cFJiZkR6TnpHRnFTRHppN3FwaGgxaWRMdkwzUHNmSTRVeFVpUmhqUUEvckJa?=
 =?utf-8?B?N1NLb0p4Y0gzOWl3Wk16NzZpb1hqN0duSjVUc1dlZzgyNEVjQWJhMGZLQ2o2?=
 =?utf-8?B?Yzl6UnFFVkkxNUJDT0RvNjJZZFNOZ3Q5c05NN3kxMDFMbDJLM0pUQS9NcG5j?=
 =?utf-8?B?cDlTU3pkQkVoUmZxTFdMT3luSXBRY25OSCtFZjEvSWpVNmFCVE5Md2FOYlov?=
 =?utf-8?B?bkg0ckVDMTdkUmJJTjluQ1lhUXkrUUJkZWJ3TmRRQWJJSzlhRCsvdFA1cGEv?=
 =?utf-8?B?TnZOcWdPaVlSYkdVRFpHeDN1SjRvSWc5WXBRS3RpYU1aWUN3ellDaVRNY29w?=
 =?utf-8?B?N0NwckxlYTFEN3JsV0NjTG92WGlKWHVUQnRFMzF1aWJBNHh4amlieFFNdzdk?=
 =?utf-8?B?M2xidWQ5NWFiQVNWK3hLWGtXMjYwMjlLRnd6RHRnMGg4eVJsejJlTURaYVBp?=
 =?utf-8?B?SXI1T3g2aTEvbHZkajVDS0dycUFTQzJkWE0rWXN6SERwMytVV3ArZXhGcWpI?=
 =?utf-8?B?RWcydHllQTZkVlAzMTYxR0dQTTV5d1pqRlJ1Uy9XTDVqcXVsMkVBemVaVzNt?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iHI3sD2Te4RLyx4xKgiSj/UM8g1/EDgZSaeeNrU8RSzd0aqT/8Ma2FbSKOHTmR0Xjgsj3zUYTQ7nz157aNCsFhumuPFMI0VUf4z0bV8K61PRuEDX3gaF+6BIyP15NPbsOywQtviGW9Jr2xGXwXSgsIzwQcAJUYLcnt9VaHBOXV4KdRZzMHv3EmXpNDSKmkQsxc/Nil5xRgn3YfvY6OjG/Kpi/BsJl9pfkgykdkNINhRSBWnOkW7qiRJp3ZGJR50m2htdvFmGWWpa0HkHTy1YQyRSnL4OR+wqS+hC57S5dqdZdlAr8SIZmO1zcBv8XEY/IIK2/W53F3MZdUh1NlBLMl53Ef3AXgiwOUPB820/SOUzL+YtkEJ1WVtSxo4gTTmMU28fp/aXm4RBUi+9mTDUoQlJ1yX3IA4/LB9KLYwtpT/+3C8T49Nv6bfT2A5odLJ3hptfYTr31XDVLihCoIgVI1ucHfDRjfa5IFWvar50Pn7IB+rJvKOLGaYp/iQa9W3DCkN9i0shqF1AWrwHYvjueMJIJRlFR60P9U9JIFTJNdcqBVE4Fq4Wj8ypZSCLMsWkJyF4jGtiSIIhXMD/F6HATjoZXMWWBWW5+94ltnj2//U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bea787-5d32-43e1-07ea-08dcbb014db0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 19:02:25.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4gi+snz2Ybh05dHmM7srr2t65THpEVdzDm76/tul9V79Dp53T/jB+jbVwIkrywDaANLiIyxc1lqJLVBT0oWxTSlh/tN6fdDAOla3bi3uhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408120141
X-Proofpoint-ORIG-GUID: u9Zuc1F_Z8ib5UD87akHqsjeEPBDmdi_
X-Proofpoint-GUID: u9Zuc1F_Z8ib5UD87akHqsjeEPBDmdi_

On 6/4/24 3:59 PM, Jarkko Sakkinen wrote:
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

Further thoughts on this after discussions...

The Secure Launch feature will cover other architectures beyond x86 in 
the future. We may have to rework/move the config settings at that point 
but for now I don't think we want to change it.

Thanks
Ross

> 
> Just asking...
> 
> BR, Jarkko
> 


