Return-Path: <linux-efi+bounces-5899-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F7CCC950F
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 19:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7482B3013701
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866F92D8376;
	Wed, 17 Dec 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Le/jmoC8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xFfJx5pu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600C267AF6;
	Wed, 17 Dec 2025 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997091; cv=fail; b=Z3vXhgp9Pmv0BjSUIY5l/qF5V46x05pGK2EepiPKzF2s/0N2AekfdthatxJelHbBWnHI4kz0Rh7kC2M0izh0FiRJg1XMnFeqitGttSOvtnph9FXfEgpw/z6eyz0CQd0/RmByI7lMg8ZNe9GqU1d8rUmUSTIn/m57dr3Iig8mGw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997091; c=relaxed/simple;
	bh=FZ+pV/O9Af/drkxo1311d0ZJmNvxDVklK/83dCzqCbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KUwsEp86jWsIlHtTXpD3h6KcNpSLSzqXLRyGoO6sl/vjBvvVqeFtAt9tWCHEAhaHnxs24CWEBZ/T4Ze4s//GvElvUvYi1wasyrfBo02uCbXxgYfALMOhwiSUOW9ozpZ8az3P3hxIY7zysmaIMCXf1ewIw/Yoeurw1LRCA3RvWf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Le/jmoC8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xFfJx5pu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHH1Yjo3071747;
	Wed, 17 Dec 2025 18:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/KL0yp8H4Y/kHAizC55YcngaQjhbepCAjqMfMjGwSPM=; b=
	Le/jmoC8a5LyIgoCSxsoKvc1CjG0Qnav48wTcD2EgWM9CuJTh4BnwtZgmfENGwp5
	e8D4MktUw705vicjGHxtvANqRBZ5avuZB3YEAH+qWfiHr6Dgt+7OfUlIc+W4+T8b
	Q8icXb7z8vQRi7SDQHzyPus4Je08O7UOlW3X5sYzDbsuli5WpUazfQQjaW3E8ma7
	jFEZZ/V1w01q9Q38Dy9Vp+2e5Ou+5JlMwJydPwRjPl0AABGEExkvK+RixnIOqO+1
	gC9Py1pqLvbb2Lbn2oy9lNAkYGI6g43Q2S5qOqC2q4jb99aPUeMVBIgtYmzUPzHG
	wvRj32sV1O+KkVrLqhByOw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b3xa2rfrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:44:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHGxNm5024610;
	Wed, 17 Dec 2025 18:44:13 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkc4quk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:44:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsiUWL+IJomRfcQHNY3AyJ3hR3GoCjtN3yp4OnNXxeRkCp78rfQMdZxzRcakVsT5vP4iMGF1iKVNsfSkupaG+lAT5Mzb2V31c5kZotw2Q6kS4Zy7uUdZrkkpjUAIFcIkbavwjX/x2JiaMrU/cp9pL6mgB2H2RdDSB/XNRO1mZ1mPFZOG5GTvbxMU7yk00+KyrQ1AIFUozLu3iCs1j0oxPQ/gvT+rSHy8h4tn+/avYEqNotGHXeKvtlGMvTqPiGFQVfa7krjAYiBCorrmpobCPFyWnCnEvYwJaA+GKDP43XVVsHwvutdzzCcYndaLMxQQzAEKe7l+2vaXlo+A4mmQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KL0yp8H4Y/kHAizC55YcngaQjhbepCAjqMfMjGwSPM=;
 b=I2+4raILtM/M4L0XoV222DIbUzbiuc0bygXkZwnE+rVL6g5qYGDkbt94dLr59OB9w2ZC8DXj+78KB7jPBJ/rPKcG9uh0wB5zfSlyV1gjqsCVdVI3eIZ4028oz1ST1sb0Dq4GZPWNVjWs2H4AT4G7epi26KCaoSNQBGlCY69d3HCNmx497KWMh/eU1R0AdsNKobcw/FlUdkMyGAkEhtiLnG/rghmfMAPgsbQi5uyhGDGfDFF5eJ5aUssjIzuO09zCBvRPgny6lI/wqFrgjxkMakNOycSIbRAZcDc0QlIXJsoYeKgks8EoX28gsMwi5BdGZaGWLJBjLK4RMqtrOSn+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KL0yp8H4Y/kHAizC55YcngaQjhbepCAjqMfMjGwSPM=;
 b=xFfJx5puLIcN+f/VtC9x+30O9GRd6rN42wcgEB8qCxmQccISOpGBzzINXoMiNPafRvJzjzO07oNpA7HDKNkVKnppatddAOUxyGiWiVMHNv7BXNYnXgk5mhXRr/SC7mJGmf0oILQJMVZfKlA55SFCx2LThboo4xZtPbRgrgGYub8=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 IA4PR10MB8256.namprd10.prod.outlook.com (2603:10b6:208:56c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 18:44:08 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:44:07 +0000
Message-ID: <2d77b55e-b042-4c2d-92bf-8ad76b23558f@oracle.com>
Date: Wed, 17 Dec 2025 10:44:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 16/28] x86/txt: Intel Trusted eXecution Technology
 (TXT) definitions
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
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
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-17-ross.philipson@oracle.com>
 <9febdd36-9c23-458a-8d7e-2bc39849e188@intel.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <9febdd36-9c23-458a-8d7e-2bc39849e188@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0071.namprd07.prod.outlook.com
 (2603:10b6:510:f::16) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|IA4PR10MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 0779b85e-7b3a-4b60-082d-08de3d9c42b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzdIaTlxa3h6SUR2L3BTWmdKWDBzRFY4Tmc5Wm5qRmdtREFacHBXbGs3THN4?=
 =?utf-8?B?Z2lxLzdXdTUzbmQrOVAxNUx0eFNnaXhqOWFtT29RMFg3cHJuY2xyNHdPNkpJ?=
 =?utf-8?B?M2V2V3R0aW5XUFFOeWUxTzNGWnJOa3VQQmNMVlVTaEpHVks0UUhjWEFpZ1Vu?=
 =?utf-8?B?Q3I3VTAyZkh1ZUxrYlY1RW8vTGZBcG5BdHRpdG1IWFNwYWhZNmRjNEw2M3VH?=
 =?utf-8?B?RFo1aURReXFtN0hxV1FTalU5WDlacGZjQWh6bDBjVHNxOWlqdnlVOHZja0Jo?=
 =?utf-8?B?RXlZTzlFV1BqbThBMlZiTTVTTXpDNDF4cFMvZTYrRW0xY1I0YXNZRUh3UUts?=
 =?utf-8?B?TUxpbDVzNGNCQUdkQmtwTzdWMlJhMWpCTEh4aUIvSDhuN1BGR0hOcmU2YUMr?=
 =?utf-8?B?d09CQzYzOExBdzhlVWk2cE9pTGFaYzZDMmpMcWhxekhCZFFkVWxuTS9FYUVN?=
 =?utf-8?B?R3lQMlJaNmdvT3ZhZ0tiRWJ2NmdGSTFhbXNJZ0lzMldtYWhkWjRRV2xoc01B?=
 =?utf-8?B?K0U5UkVzMlQrL3dScnRJMzEvd3hMWTNyMU9XV3liMDNLZ3lpMW5wYnZ2T2c2?=
 =?utf-8?B?Wi9ZRXhOR0xjSlF4UTg5TDRRb2sranZPZnpFWkZac3RHZWx4WWZBVDlGYlFn?=
 =?utf-8?B?SkNvZzdZd0k1RS9uTGlVUDdqeWRCRVQ0WjNpNyt6QUdZVldDOUNtZnpBRk84?=
 =?utf-8?B?ZG56YlZ3cys3NHE3M1U2Nm5JY3NTZFNMb2RjWFhJellXejd3YUg4ZGxjd3px?=
 =?utf-8?B?TXBtSmxWSnByM2FuK2pGcHRWNi9kZEhrWEhTQWw3bmM1TjZxQ2pQRlZlcTVp?=
 =?utf-8?B?eDZMU0lSRHJhYVo2V3l1cFAzSGtsdXRMMXZPc0gyWGlkZGFDWDIvTXBNeUh1?=
 =?utf-8?B?ZXc1YU5WUXJla0hUOUpUYnZqQnpmS0VIdmJZWVBhckQzMFZjRllZTmo1d0xU?=
 =?utf-8?B?eU1vVVRYQm5uUTNsVkZZYklrZ0dVdnpBNXVEUDF4ekFVMGgzMUlwSXRHQTNh?=
 =?utf-8?B?R1JLTTBKNkhNWHptQWtMNU1iNktQeE1FcjdoVzNFUis3VlVsUXFpeHAycWZB?=
 =?utf-8?B?ZGkxcWh2WDFFc0lvcEkya2crWkNFczd5ZDlKbWkwWFI4N3FSVWxTWlc5aWV6?=
 =?utf-8?B?aXVxVERnbFQyOGZrRklwVGxxYVdQazNjcEJRQTFNejIrdFVHbGRPT0dMNWNO?=
 =?utf-8?B?aE5kZXhkUUYyRlQyUm1XU2VaWXpxVDgrTysvbkJlWXFxSzFhZ3g0SUlpUkVR?=
 =?utf-8?B?WVhuMmNwaUVUOUNvYzNQa01GQm1WZmhmTWRPVmVTWDhwa05nUTlWbENYeFJP?=
 =?utf-8?B?dEhmNXM2NC9MTTJtUDVHbUtuUzNzaWFOdzFHUlViVlpaUlkyRVlpMXBFSEsw?=
 =?utf-8?B?WTlkeVNIdVB3OUF3bnhwTGFiZUpsY1ZpM200WExOcnNydnNIaENoaEdrSjBN?=
 =?utf-8?B?WGlhOFpLODRWbFE4Z21zY2FadDRVSGNYZmQ4UG1PLzk4YkhxaENaeXpsYVNz?=
 =?utf-8?B?emhjYUdDR3ZZckphcU5aS084bEpnajNYUGZJdnhHa1VIVUMwZ1pVdUpwTXcx?=
 =?utf-8?B?eGpsT1J5MmZBNXdKQ0FXK2ZDYjF0WVVBNlhoZHBEQWNoWnNYVzc3c3ErSjN5?=
 =?utf-8?B?VklOK3c0TmZqd25QMDFDd2ZBYVVUUW54ZUZMUFY0OW9YS0dtdTQ4Q1BnU0Jh?=
 =?utf-8?B?di9lUkdjM0FrZTFFc2xCT1E5S0loQlFVaFRpK2U1SXQvL01oOGo4ZnNsVGlM?=
 =?utf-8?B?eklVbEpMSFk2MzNJMjAvdE8xSE5uN3VPc1Y2TStTM3ZiVW00aFo0Zy9SVTBi?=
 =?utf-8?B?NjV6bDJ3SDZHNjh4VFhTdFZkSTZINDhMbUZ6NjJocjQ3VERJL0FJWU9zL0Zq?=
 =?utf-8?B?L1V1NzBQL0JVbm1PRWxMUjJITVh5eFZiZ3BSb1MySndjQzJQSFViT05ZQW5r?=
 =?utf-8?Q?NWiT73vTXsYS2UQIm8Nn/CKAsDH0X0Kv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGE4UlNtQ1FxWXptTmRDOFduNjRoWVFmcHVqU0xyd09nK1NhcjZ4TkVPQXYv?=
 =?utf-8?B?aXcwc0ZLRWNvQ0tQVjQ0N0g4emhsRFlTRDMrMlA0Sy8vNThSN0UxWWZjTFdk?=
 =?utf-8?B?ZDRQS0xBUEViMTlCdWdIRW1WN21nQk9kZTdRZW9LK1VTS1N2RnVwSy9ZSGVV?=
 =?utf-8?B?ZFJoSXJlR3lzTDg5VzljcHAzYjZGL2pXMDBmSzd3ZGpFRWpNWXZxZDVtYkpQ?=
 =?utf-8?B?akIrYUt3SVVWbWxmMlRuVWhrakt1OU1xRkFmYjYwT1M5KzBZdTVnUmM1Tk5m?=
 =?utf-8?B?Tk1TQ21Fek1TK3NxOWs0RTVRdjVaNVJlTXl1RzM4YytLcllJNEpFOEptYk5P?=
 =?utf-8?B?OTYxTEdEVjl2WEFZNE1jWGhvTEZpMnJuZkdDQ2dGTUVWYVJ3bUMwTkRMSDU5?=
 =?utf-8?B?b1Q2ZU5GaTc0Y1ZPVXA2Y2toL0NBT1VKcVVPM2dKb2dMaE5tRGFSZUdKWkpL?=
 =?utf-8?B?a0NBcEZJM0poWmp5ekh2VG16NUpXQTV5SWd5OGtUcTQ4enJlVUpaeTIzemo3?=
 =?utf-8?B?QzV1UXlFWHBvclZJZ2xOZDczNDhua1FqWGxZUE9wTEtaRUxwclBUTXVGcHBG?=
 =?utf-8?B?WE9yRXRlV3JlQXE0Yzk1dlpOaitidVM2ZXpYdEJvVGdvbEZHZm0xMCtIc2Q1?=
 =?utf-8?B?WWthaTFoRzZqMmV6bW5MbWMzeE5vbFNoZjZSWGZXQmdCcG1Ob2dab1N5bGY4?=
 =?utf-8?B?OTliT1kramZuMnZqU3ZEbTMzNHlyU01SU0NucVJ0TzZFZkFGV3ROTHZ1UVlz?=
 =?utf-8?B?ZHoxaXJQRVhDWDYvcDlpS21TRXFOc2djLzV3Mm9qUjBrTVVIY1VzbWw0SXp2?=
 =?utf-8?B?YXJtRXVDV0ZqajJGTnVUV1owRlhmb1JrVVViM21PTEtackVtYUU1VzhZQ0ZH?=
 =?utf-8?B?cmx6NDRHZVlJSTZXS3BFS081TzQ4QkhYbGhMazR1Q2Ryc3ZFMW9QaUV2WTBK?=
 =?utf-8?B?a1hTaDcxOTd0TmZvREptTkNQTzAzb3Fjdkl5VTNaa2ZTSjRUUXRqZ0M3emp2?=
 =?utf-8?B?VFZ5MkFCbGN1VEhwZFNyYUNtTDUrQ0hJUGY5c015aG1kb0oyYVIxU1NYODZI?=
 =?utf-8?B?NGlKNlRhNHJROGdmNURKQkpWQjJJdndGUWVtVnQ3eEZiczVWeTkvV1BkbDdm?=
 =?utf-8?B?dHhpcWYvVVBFV0JLbDVqSlVhM0xCSmRwYnpaSmJ3aEdjdTR6VGNWN29uUmdU?=
 =?utf-8?B?Um5SNy8xbFNjVDhtVFlRTDVKZE9aSnFiUWZ0MW9rTFpqdEx6dU9ZeExpTXQw?=
 =?utf-8?B?S2c5cHBqVmhLN25rSC9HeWhYTEpLUkh2NGpiQ2orMVFSd2hOMnVyVjNoQUhv?=
 =?utf-8?B?Z2JHNkJZeDlCREZlUHluUVQ1bDBFT0N4d2NRYlNnVTlXWXU1bTZ4QTQ0dStw?=
 =?utf-8?B?bjl4cm52S0oyNy9ZTzhSaE5uYitrTXBYVWF0VVpEa1hJOVdCb3QrWjl5VDlG?=
 =?utf-8?B?ekkyWVRIZXlSVzRpMHNiRDhBendqaStLMyt0NHpGdkplZVFhNlFTakJBcUE5?=
 =?utf-8?B?NE5manFTNUwxQ0w2dS85OE5lc2M3bVJ4U2Z3eElUa2hmTGV0SEF3b0Q3YkN5?=
 =?utf-8?B?cVpjNWQvZkhDZWxoT043cm5EbkF2Q2RVQXZYb0hWRklVSFNFSVdpUHdwUGV2?=
 =?utf-8?B?LzFNZUx3ZjFsM2VGUng0VXV5anZqK2tjemdNMnJQanNiRnVMbEFEYktacEZ0?=
 =?utf-8?B?Y3VPeVNRL3pxV0VJbmYrVko3Sk43UUNaMTZELzhJYVFxaHN6aUd0djZ4ZkJh?=
 =?utf-8?B?UnpNTllUZjEzUXFldGRCWVMyRWtNT3RvU1cydlBRbDVwem9VZDhmd0I1REEx?=
 =?utf-8?B?R3dkNFgrOXpMa2pVWEVzR3NJdnRrNFo1eDMwb1o1cURUbEJocDY5NjdBKzh0?=
 =?utf-8?B?NnBDYktnbTdqZ2hqai90Tm81UkduZzg0d3JUUWh2T3VaZ3Jsc0l4aThCVmcw?=
 =?utf-8?B?OWZWQlRxek95NXRFcHlSRzE0K05FaHl4cW05V0xDcGVYbERBSXltK3Z5bjk3?=
 =?utf-8?B?ODRpRzFnVjR0ZEU2ZnJzWjNnSUU1MmdYTWY0cUJWaXE5Zm90bHRPSVVkUUJ6?=
 =?utf-8?B?c3U3STJGZUlJeE4zaXZPVklYZWFvdUQwOGZ2NW1VTkh5OWJ0Z0tVVXVIVUUw?=
 =?utf-8?B?SndYNGdxVVRjaExNL0o2Y2Z6RFJaU0c3UjZTQXgyKzhVSlRYeXJsV2pOd3RX?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4M2CUwT12+w0idps2gVPdvs2z1QHd6nsRxaCBFGm0MCHPkByBxi3jf9Skuck1HP4tIQAfUC4QkPwe1nbSZXp9Gp8wAxM2s0s2F1XjE9dNqZeqgmqO42XKNcpacuw2jezWR6Pslrz5IvdpoWGStZTE7pajW/5ny9yMwZCdKLEH8LTw+UGN1utxTE7a+uKsCPPYuNEYa4pfRU2kgwtyiyWtdC60HcDx6joQCcPJNf6fm2UqUPSR21MjbuBtuq/kBbbWEen3BR9O9IU2FiLBZC5RQtrQJMvyUqVgnqwQw/2r450IRKVvy8qSxrxuixEvK6ydgl130LCaSK5xANn02GnBuETB4LJRiysocprgZw42LV70yN2HyZFMVqXgqEX02UhL3WL8x52hdoD43usjcdIDnsjVi7FRvf9O00Tf0713OttClM+zqA/ogvseXPdZqUYOdq07BYPJW5Sb4jeyrG0L+2V+WWsDt90OniLl8va5VWzGka8OpTpBW6IHz4rGSX9iLMWH7y+JcxSdINowBjStM1T4g+Y6NBJEQqxlkQL8GbVLyR4Z2e4281jzdqc3ATkQKcVFPK+9M99fAYaP4d9ck5WeNtMtZ+LG/Gi+LY/sC4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0779b85e-7b3a-4b60-082d-08de3d9c42b1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:44:07.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT2EOJNbufiBAUOJBKm9pkvBMbNheaC5pbe3BAY6ddeXtUMjwV0qkS2DGXzPRCP1DenYHkKh8PrZF3QjbbP3nT/HTxydYjcXqH/XMgZwSMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170149
X-Authority-Analysis: v=2.4 cv=Ot5CCi/t c=1 sm=1 tr=0 ts=6942f9fd cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=IbfMZYMr7PA3qzHKcgUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UU4o4v91FjVmdpgfBldFI8eQ1B8qJSIL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE0OSBTYWx0ZWRfXwgcX6lH7R9Rf
 wEZKPPnItaaZzu4/uHpP0IAwBwzuf2Wc3EWJQa929MehtRYvlyuxyrgVHASUsELDsQDICXxf+Fn
 LqrbHO6S0Pq7Um/VmBfYcnbo8cMzqIs8tbjT7xfhMWEgnxZwGwU9goLbgEbFp8gWaDyfkLCsOy5
 YvDoEoAKI3w7IaLi/akVivFAtFpXRfJvOKqliFBU+AcThjh16igj5G9MmfKCE4JyHN3DdA1z/mu
 A2Wkuvk/61ilXRovc32gGjuss5FB7e9AlDVZ6QWLB2+FqXmviv2/lyg0ukRe6mxIwHf27NMiobp
 /55Rv7iB5MnPAmb7Ie40GuV7TqQbA1lNGe/4VN32TcEGKo53EyfX9xFxWJhy5YxM4N4pd5N1gW8
 C+HvbB323UBdyB9Eqi70pZZtclxv9Q==
X-Proofpoint-ORIG-GUID: UU4o4v91FjVmdpgfBldFI8eQ1B8qJSIL

On 12/16/25 2:14 PM, Dave Hansen wrote:
> On 12/15/25 15:33, Ross Philipson wrote:
>> +static inline struct txt_heap_event_log_pointer2_1_element*
>> +txt_find_log2_1_element(struct txt_os_sinit_data *os_sinit_data)
>> +{
>> +	struct txt_heap_ext_data_element *ext_elem;
>> +
>> +	/* The extended element array is at the end of this table */
>> +	ext_elem = (struct txt_heap_ext_data_element *)
>> +		((u8 *)os_sinit_data + sizeof(struct txt_os_sinit_data));
> 
> I'd really honestly see a helper for this kind of thing:
> 
> #define ptr_after(foo)	((void *)foo + sizeof(foo))
> 
> resulting in:
> 
> 	ext_elem = ptr_after(os_sinit_data);
 >

We can do that.
  > would be a billion times easier to read than what's there. I honestly
> don't even see why this bothers with the u8 and cast to 'struct
> txt_heap_ext_data_element *' versus just using void* and being done with it.
> 
> There's no type safety here in the first place so why bother?

Earlier, this was done to a number of other functions for the same 
reason. We will change it here too.

Ross

> 
>> +	while (ext_elem->type != TXT_HEAP_EXTDATA_TYPE_END) {
>> +		if (ext_elem->type == TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1) {
>> +			return (struct txt_heap_event_log_pointer2_1_element *)
>> +				((u8 *)ext_elem + sizeof(struct txt_heap_ext_data_element));
>> +		}
>> +		ext_elem = (struct txt_heap_ext_data_element *)
>> +			    ((u8 *)ext_elem + ext_elem->size);
>> +	}


