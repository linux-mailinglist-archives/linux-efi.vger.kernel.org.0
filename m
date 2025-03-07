Return-Path: <linux-efi+bounces-2936-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40A4A57270
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 20:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9875A3AFF0F
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 19:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D476E1A2632;
	Fri,  7 Mar 2025 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OIKqrTxB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZHkxnP6Y"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C02DDA9;
	Fri,  7 Mar 2025 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376865; cv=fail; b=XoYZhQKGS5ZjdeuPrmnyFCCTFXhmn5I+pfCvHaRKwB7PXkx6JcLczNqsHYZ3o6SqS5igEY/K1MwNLryqJJ6zrS4fIApwB4lwdWhL36OPb3hhmOwqsm/3HckAQGOXNr2zHVu5zlqH493MBKEY/ENjwOzMYZT+PyKvTS2MDPv1Swk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376865; c=relaxed/simple;
	bh=ROppPETE+HLKHA4NR2Gf3BUkeLrxyyHxbOFL1SBENPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iZAL5en7mezqMYt8f89pgTqNHuoPLm9hoqG3KLuLISnGKczZu44lwEi1pUe+SDMlVVAptv9N/tJF1Vwf5jAnv368NpWItc3RaTXT9x1eZCP/Anlqz0orZoADJjFQRB0BCu8OOgAdaeEEEiZx4bQXC/t/lKX7IXmtYD2MeVMyB38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OIKqrTxB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZHkxnP6Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527ItgHu020983;
	Fri, 7 Mar 2025 19:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=z709IjRC4cTelH+qzKH0SefrPi0HyEyTp2vLr+dWJz8=; b=
	OIKqrTxBsRcF1S1zvhV8SZerN6YvyGLnXN2Z75CADh1cRf0GXO2tFL9Z6hbk+UzB
	jtVIqd11zYeed7ty4EDBN/bR6XD3RGpRIulgTkM9F+klVvap6hBdkzlANvjGBCVR
	kq5TMvQ+nXpOVoPSJgbDOHlbQZyxOrZygZkZQb/x9MXX6oR8VvqktOTM8njDM+cu
	fa7dWspvSnp8vyuCZnVFRZqeFq3gFREPkgbrbzmcteLgzXVunEz4cLzjSxv43dKA
	/giunEOKdDNpMHjCRCu8xm1X8jHHpATfAoXtx04sAUrvd6tqNHOqXvlFrZRCNB+c
	7qsuSGnKQqRhVXcrwdnTlA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hmy4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:47:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527IfqvM038909;
	Fri, 7 Mar 2025 19:47:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpm7pr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:47:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n07EEuqJ2oz0/W66bIv1czwVvwczRF9yiXwrFLTEmiD1dksiYL9eqHXKtOXp6JJws+/AQGyJZ8EJx4KqWlH6DGDpVCCm7PPpA8mcxsEGlJibXryVVSBzalHa8FUv9qowyrel/XEBdmg73Mh0YSYvmPVm10mk9VJghytSI8vydMIb5TukpxKZRlwRTuM3qpwbwkL2P0TqwG35VFiaHeLB4mIgQtIqGxjAlSl13fTeLpWO3wdov1Egp3rHH5KKS6HS/mrxCzhGGqoXSLPu50srzYJ2P3OAwVDbDDtY/WUcO8Yr3JOcbnuzrmBGAHVvggwWx98w1QSR8+D63MdX+346DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z709IjRC4cTelH+qzKH0SefrPi0HyEyTp2vLr+dWJz8=;
 b=t+QOEaqjL3GUEBTF9gofLYT6vHHTzFZx6QUkRaYC+wRAxl249qFe7wXd6SpJRMJpIJuyTLseZTvdEXwMMCro6ITuIxmTWFcKH2NqRom1Cvyb6fBStHd+4xOfb6YpwANAowzvNsLCLHmn7IFr1JfbdTMdw/FIrB7w0vQ3AzrVyI6G0u0Imi+D1K+STqHTVltQpN23wpdNkeg8mJbZkPRQadel0VwjILnlaPT45BmYRyTl39NjzX4Vf90Pf/cq02p+IQTFD8FncJSLKO1Rt5pLUzqaRgcncQAS19dtA8g0DOGfoZEG8zE8rn0cRovcrL8RJd8OKoh1XaKPKzZExt+DOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z709IjRC4cTelH+qzKH0SefrPi0HyEyTp2vLr+dWJz8=;
 b=ZHkxnP6YpVvZ8r9v6m4QJVeoIYpyyJ2OzP2T4Z03soCo82Ic7ibkRm9PHKH87pGNDqlQOrd0I006Usm3L93gVYxLAogi1IBZEs/6oN5HkDZT58hVEbSoKEQFxqKpxc3MDsV5jlyRn0Ck1EvNCptNYxN49N65G+Y3CZImDXQTDHI=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 19:47:03 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 19:47:03 +0000
Message-ID: <8e3898d1-9d8d-45e1-a23e-74094a7e01a5@oracle.com>
Date: Fri, 7 Mar 2025 11:46:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/19] x86: Secure Launch main header file
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
 <20241219194216.152839-5-ross.philipson@oracle.com>
 <Z8qFdeM8YEck2j1C@kernel.org>
 <d2adb4c4-b03f-4fbd-81c2-1cd017ed2822@oracle.com>
 <Z8tK704hkyoZZc7_@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z8tK704hkyoZZc7_@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::19) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|BLAPR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fdbc02-a504-42e3-79d6-08dd5db0d52f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3o3dExOVy9nemx5UU5aVDVOSXJTV21nWVhGUkdNejRON1MzVWJ6K3QrRjZv?=
 =?utf-8?B?Q0I4MjNmbkg0MFdwUURScWRoakpOZlEvU1JOa1pVSTA3a0NTc3dkajUwUlVN?=
 =?utf-8?B?dENTSXYxbHpabGRzMEhTWkFIOW1GR0pDV2JJQ1RDK3doWWdEZkFhdGNCS2ow?=
 =?utf-8?B?eFIyR3Zmais1QklEMkdUT0dFR1U1dVBNWXZ0TURGUDBJV2NuZy9NU1E0elpB?=
 =?utf-8?B?T3JuaUxmTGxOZ1ZhN2g3VFg1bWRRSTNjUlltRUtGd2hGem42eENHeU0vQjh3?=
 =?utf-8?B?SlhNY2tMb1NrUU95SjVIUE80TUhlS3pGNHh6eEdzcHJjS2U2NWI4OHhMREpp?=
 =?utf-8?B?TlpGMTBpc3pmUitqZTRIZU1UblhSN1V5SmN5ejdKcTcvNEh5cWZvRVRZS0ZS?=
 =?utf-8?B?RXYwSytzc1BKNzBhL211aW81VE11TTd3S3hoaHowU3hBeXVqSVUzck42N3V5?=
 =?utf-8?B?ME9lamIxNk52VlBLdHNaZnJZc1NxQTJLNFdFOGNrMVNrajJXQ0FucVBweDJk?=
 =?utf-8?B?aVVOZWRNQSt0OWdDUnRrWHorWWlRblRpTmM3endaZnRsSDR6VWN0WVM4NDRL?=
 =?utf-8?B?ZXExUi83TytJWXhBWWdiMkcvUTZPSFFrbTBHb2Q4cHdGaVNNSEp0aDRBWXZB?=
 =?utf-8?B?ZGpXdExTSkh0SHo1K09OMkRUOFZxOVhHanY1V2pVTERYVjZnVFEvNVIyd3ln?=
 =?utf-8?B?NnV4VkVZbkk2bjczUThPV2dmcUhUMHNqTUpYUHptRDhhN2xoeDlwR2g5dG5V?=
 =?utf-8?B?aXBXWVJ3UDhWaVdOc0xVQzBwRDBsVndxZGtMbTJQbGJEK01Yb0MwTVpCaG5Q?=
 =?utf-8?B?TGRtM2QxSkliT1hEV1ZYemNiZ3hUZGRMa2lqWVNXdytoMUhVbXVzNlVub1hS?=
 =?utf-8?B?ZWM2K0JNcGtjNTh3WCsxeTdQbUY2ZUE5WkxWSDk0ckd6L01Wc2xRQXNjZUty?=
 =?utf-8?B?TysvZjNrVUs5cUV0dmcxVEc1RFVxalR4bjJxRURYWjFRY2g0ZXhpM3Q2L0JP?=
 =?utf-8?B?RHNobUg1STZaZ2VucXh2REJiQ1hTZUNaY3Bzc3JxMU82T1ZHTFI5K1F5cHUz?=
 =?utf-8?B?T09ROWIxNkk5NTFQYks0SFRvbEp1aW5YOWdNekFhUzdWQ0lrOWhGR1F4czVJ?=
 =?utf-8?B?dC9CTnpLcDRPbTBSbU5YTXJkY1hBRi9iZkdrZE5vblFZWWxKT2QvWExyS2JL?=
 =?utf-8?B?cUlycm84Z0JES0VDdnUxTGRydWtUOFlGMHZZWFFpYWxhRTQ1Z3dHWVlPaGht?=
 =?utf-8?B?WGxKVFV6eDVYbFFWVWhvZmRQSVU4eUV2dkZMZ3gyOFdqeHJkTnBYT1FrcVU4?=
 =?utf-8?B?R3dGaEc5ZWpCWFJEUm9WTitsTHJydHQ0ZGFuR2RwcWVKTHZrOTBEdXk3L1hT?=
 =?utf-8?B?dXJ3VFRDYUl5SXhrUWVRaHlnbEhFU0VEV01uYWNxM21UenlyQi81a0EyVmdS?=
 =?utf-8?B?Q3BkYW5OMVZNMXBVTjk0ZkdOWFd6elpocEdRT2k2VzF5eU9mVWZrOS93V3p5?=
 =?utf-8?B?dlhGMCtReTJvSjNhQ1o5ZDhobU9vSndxK1FQWnR4SzhjeVI3TkJvMmlObnZJ?=
 =?utf-8?B?K01OMk4xN2Fpb1NpM0kySlhDV25vckZDS05QVjdLejR6WEF5L0pSSlk2TnA0?=
 =?utf-8?B?Z2NvZk5LMTRLYS9xVzlhd3lmeHBNb3FaMHhKdVM3b2dxanA4UU5mYk9LNmMv?=
 =?utf-8?B?ZFV4WnZ5NHVsbllqQ0Nqd1dTdzRTZm1UWXBKNmV0R01adTB2cGdaOU1OWWhU?=
 =?utf-8?B?a0tkV2hJWGxQTkhxdHlKODdLUjNZYUhQaFl0aGJkTWhFMUVodnh3VHVURmlQ?=
 =?utf-8?B?OU9qYXJOdWtlWWFhZlk0amtFWUNBSk1qK09zUWZkUjRSWVQ4MExkSUdlUmhN?=
 =?utf-8?Q?GHjCXRAEgCKxW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjhzRzNyVWVZY3ZOMzNsTnZ0TnlNai8zYmtZRGNGalRDK0Q1S2pSbDdMV29R?=
 =?utf-8?B?cjZZeTBTSlc3NmlQZHd5dC83RGVzZS9ZZWNPVTZSMFlucERHMHAyRUpOR0tt?=
 =?utf-8?B?S0k5MWtKQ1o0ZklxeHRHR2dVaTdIV05FY1pPTit0T2RtcVFlK1pEYXcyNHlP?=
 =?utf-8?B?OHRMbHE3Nzc4OG92ajBId05FYnF5VFFhVUdpS0lNajFKdFpFdW0zK2NRMW1Y?=
 =?utf-8?B?RmdtdkVNQWp3V3RsOThmTC9NaS81NTVPblMzemZqOVVOa3N1TlE3Z25CY0s4?=
 =?utf-8?B?bTlRaXEwK1EyWnFGRWxpWGk2VjcxNlduOHJ0ZFVXcVBLZ0llQVN5UEJsckRl?=
 =?utf-8?B?blhKQko1M0Q5Y041WXZpTnUzZlJIalgxaHkzNFFna2N1MXpZM0VkLy82R0hY?=
 =?utf-8?B?Um0yS3B0b2VEY2loZ213ZXA1NnVvSS9SVERHdlNnaUhiTUNYaytyMmozMGE2?=
 =?utf-8?B?M2JLQ0VoMWFjcmJMUzJsQXVOcTVoTWorMFZDdzdheGwweE10aTAwNVhmU0hz?=
 =?utf-8?B?MGJDMkh3cWZSRko5cGZPUkRDL2pqQnRRellQSzBKQk1PV2NJMWJZb0dTUytH?=
 =?utf-8?B?bEozdXVpK0NMTjZxSm1DTm5tYkRBa3U0RjB6MmVwWlpzSFlMYkEyTmhCREto?=
 =?utf-8?B?RUhIRUFteHdOM2hxeVB3QXNicWM4YVZEdFRCS3k0aGNIZGlSQUxNVmVqMEIw?=
 =?utf-8?B?MW5YRlo0S0FUajJDNWhsdmVESms3bjZ2VnlVdW9ua21YWjhqTmcxMHJwcnEy?=
 =?utf-8?B?ZVZZU25nankxY1ZDRkQ3TnhZNllXRy9kdHBOb0l1WHlZZ3lHS2k5U3FUU0JZ?=
 =?utf-8?B?YVZPL3ZoK3JxcEp3ZXRLTHdwVkt1aTNQemJmTmtKTklmWGthZ2E3Tk1EYXQ0?=
 =?utf-8?B?L0w2T3FtTlVDN3BhSVc0dklGUGYwRFRaUHN6TnpjYWFaNVkrYUN5VFI4TmRG?=
 =?utf-8?B?V2VYdDROcEY4YklHUzM1S2h6UlFFOG15VnAybFN0MEJBZTNuZVNDTzF6bnNh?=
 =?utf-8?B?UE1JbU9HMkE2azk1M3hCWWs5cEp3ZUJqZEl6NTZBb1lmdmRVUXZGeFJKOE1I?=
 =?utf-8?B?aVFhT0E0OVZWKzdQbEZ1eHNHMEJnNG1qT3I4QjUxWHphZzh1c2tKMlpyZ3ZW?=
 =?utf-8?B?RFc2T0pNakhRa3d3YjJRaXZsTzYvK2RKQnJNU1ltMkM3R1hlWHFYc0czSko0?=
 =?utf-8?B?UnhBZnIzOWVGYXEyZjJCQkszQk9LYkdwU2VrTVMyTU9RTDVXR1Q1c0ZxUjJH?=
 =?utf-8?B?Um5OWGdGanE0bTQxQjEvRHJNQnUybE1rNXBNVmk0V1lvKzFaVDFqSm5UNVVu?=
 =?utf-8?B?dUR2c1p4S1VvQzlycmQ2L0lWeTBXWVo2azVwbUhGNWNJeFZIeVhWUGJrVlFu?=
 =?utf-8?B?Tnd6SCt2Z2RlWlRhZWVDZlVYMWhUSVdsRkMxNVJmVVdlRlJBcVNUZnJLeEh2?=
 =?utf-8?B?OFpQaUZEa0xxK1pEZmtJQjJma2thZVVrMTNTVGRxTW9NUTlsT05ucVZoRTJP?=
 =?utf-8?B?RFhhVktuMmIrY3pXZkEvTDVDOWJTRnZveC9GSStLbG5XTG9peTMvd2l6MlZ1?=
 =?utf-8?B?alFqOTlFcllqa2lweGpGUHRlV3JjeTloQVFKOUEvdm82TTFUN1BGVU8wQ1Nn?=
 =?utf-8?B?cU1LbG03L0JPV29lKzl2TFIxenBWaE1RUnYxc3RIRVpjVy82R1RlaGp6WnlJ?=
 =?utf-8?B?OUdVdjNCa2dES2puMVU5dnhrNGE1WVpXZktlaXd5UXc5Wkc4dWZMRGM3Wmxt?=
 =?utf-8?B?WTYwSStPa3N0dTRtME1jVndOZStpTFY4SXppNVo4VHhsTjVHVVZkUm5VWk9B?=
 =?utf-8?B?ZkJQOXQ0MEtXRGJjNHdKSTVwVnhOdFVRUStiUkZJZUt5eThZUzlDY1FnMm0v?=
 =?utf-8?B?bjVxMS9qL2RMR2VlamVzWVB3TElwUGdzSzRET3pLeW4rSkYxODNHbitqVVFV?=
 =?utf-8?B?S2s5TlpUR3c5RWhDMnBkNDA2Zi9ycCtrTkVzWGRuQkhKNGNzY2R4SVJUbnFB?=
 =?utf-8?B?YlJxNE5GcmxEaUZ1Y29RZS9DYk80RTh1c3Vzd1UxNWhLL2dxWVZUSkpTLzFV?=
 =?utf-8?B?TjB0MjNLZUd2dWtXdGsrYjdTTWJBZ3VUUGROWWljWFpVV3U2U2lLaDh5b2lF?=
 =?utf-8?B?eXQvb2FGQzV3clhuK1NZYWk5S0hMNG56cGlDYnRmM3pLNWpzNDdDT09HVzdI?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qfGgKpr0cwtNdKJZ0tdpGHNuwq4Z4KGqn+by4+uS9EMwOsMN5zxbWMU/SCADm1h9tLA4uGKuA42I3MkevDIJhIOokhmKycdwuStmU3+FxPlnApOtYQ4AnZLs/rcFBmnzuPPGVoB6ihefJ58zEDK+R8534dlvJlQBHlDxyuBfXzpgMcG93d7zmrJjuxZQoUT9JcdC5jAy0nC8lK8RA6Fj+s7pgL6b7LBygT+1sv9Vju0mXZ2au+HBwHRX0L6pQ2Irhm290xiotW7OxUIxNU4iCnzrMwnBWJXH+u4LXNUo9Joe5Goveg2hIA/Oh3TIogw0k7Y2TpHH5mlaXjA/gtlsGmOHSnurocajxdaD3Crjxjf096P/XuNWfRZ0Wwc2X2GB7JTPNyL28SYRScHb8/Jltm7PVRDSPhMK/WxotP9++tvOls5DJzRuyYrpLz8gzlVw64uZ+ZZQj5TlPTs2RO50Q5NkBYmIIAOaL3yFL5SkiXDaODcDNmMHnBZMNw09EH87gCKIJgTIwg7zcY1z7ON+T+NJjeSSC8aGvkx25LacGljhRLHGcwGwoEYpmevUf2rR6SgvRGF8rV3EmyvXtwowEb58tJlnfHl8ln2Ugc+TwQw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fdbc02-a504-42e3-79d6-08dd5db0d52f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 19:47:03.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oXHJimufswAD6sY01oAh0MhGNBT11yzw0Iq6LeTLHgFdj1W7USIowj8RZpN2atyljK+N3gGCgddEvyTh7ByKYqzn3SNbuKtbWkqHXnvRPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070149
X-Proofpoint-GUID: h2C2hr7_kZQGdQAl36-hYOtIM9z6A_1j
X-Proofpoint-ORIG-GUID: h2C2hr7_kZQGdQAl36-hYOtIM9z6A_1j

On 3/7/25 11:37 AM, 'Jarkko Sakkinen' via trenchboot-devel wrote:
> On Fri, Mar 07, 2025 at 11:25:20AM -0800, ross.philipson@oracle.com wrote:
>> On 3/6/25 9:34 PM, 'Jarkko Sakkinen' via trenchboot-devel wrote:
>>> On Thu, Dec 19, 2024 at 11:42:01AM -0800, Ross Philipson wrote:
>>>> Introduce the main Secure Launch header file used in the early SL stub
>>>> and the early setup code.
>>>
>>> Just would need a *short* description of what slaunch.h holds. I guess
>>> it holds Intel TXT micro-arhitectural data structures? Anything else?
>>
>> Later it will contain data strutures etc. to support other architectures
>> like AMD and Arm64.
>>
>>>
>>> This helps e.g. reviewers to skip some but still keep on track what a
>>> patch contains (and return back to it when necessary).
>>
>> Yes we can make it clearer what is in this header file.
> 
> As per code changes I did spend two hours reading them just to make sure
> that I can understand the TPM specific code changes, and also that they
> make total sense to me.
> 
> Therefore I've put a lot the nagging is around documentation and
> definitions. I really could not find anything in the source code that I
> could pinpoint being absolutely wrong.

Yes agreed.

> 
> This really needs just now the stamp from tip maintainers. As per TPM
> changes they do have my blessing (no need for reviewed-by's as they
> have SOB already). I hereby also give permission to pull TPM changes
> through tip tree...

Thank you for that, we appreciate it.

Ross

> 
>> Thanks
>> Ross
> 
> BR, Jarkko
> 


