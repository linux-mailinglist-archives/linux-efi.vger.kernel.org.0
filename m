Return-Path: <linux-efi+bounces-5898-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13ECC94F4
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 19:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 304AB30092A4
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 18:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46A2D739D;
	Wed, 17 Dec 2025 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e044FqYT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dMxHwPvc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826926F2BD;
	Wed, 17 Dec 2025 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765996870; cv=fail; b=bh9FabuWBNbsBPY2upuOHepX1I9h+PNS79N5WoBTQoVR9aD+gDqhM7EqwtbKSGjcIKSsRKndkWRfhRbeYzYlXBMNCIoWntSJ1dymvN03FeIpkdYQXfFY+cKWJofnvXvaAKhk1oGfQ0oyiTf3CmrsYWloWFh43LcJVVRQfVSLBOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765996870; c=relaxed/simple;
	bh=pPxqsLl/xKcDyo2MWh1voE1+Fd2THVW2dR6KTfqpycU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s+pzWHJYxmle6pTn9+IeNLPV7V3YnZT9KzYlTxghmGaUSZXb6jqdHJ9kr+7cOFxg5VkM3rbjZFssRhopG8c1jOpSrsH2R8CqAtCr4fy23aeQRJ05eytfyjE39VuKzWOxHimBOfh5OckZdsBfGoxQTaR7ay8qGPmAXu2H0Q5qmpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e044FqYT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dMxHwPvc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHH1eVG3174695;
	Wed, 17 Dec 2025 18:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=y3NFVbl3WZcwMCCs7CH/KZqKOUowin3MhdSucl1ZBzc=; b=
	e044FqYTQ84kxiv0wu66m4UrRCnUwZBwdvC8wsgzPQVkEJWTWKDfaAnWseqRtnMJ
	8fVz3q2DELJQk+MHhitzkkGHdaUgKSYBrNp4GcU7xfWR3Zx3d8otk3G48TssCfaB
	FK61AJUXzyzzOD7pXJQtse50S8U57steozNgHQqmD+6hA4vFpkWQBWZ3AgeGFAQb
	Y05un0DbWAz2a0iDeSZdyWw/mYrKfVmxZvyN/SYXTyJO5j1h1+PIzmVr5nDzMSd5
	FBbogaUnE/VuY60a4NhNu0qV1OGy1EzfU7pCtYtOG9ow3Vkkabk1Q8gqMsafOrKT
	UW5VHsd4T4fKbspHOl7CZA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xx2ecj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:40:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHI5ANQ005876;
	Wed, 17 Dec 2025 18:40:18 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkewr2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:40:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJTRQEmA28q25kXX+q6yaPmONtr3jA7eN3V15pVdf23+AsShHLbQkrIP2CP5mUUi7yWI6Uc+oh/fUyezkx44TAhKfkp5X+VtbX0v9Zm51l2fkS9Ht3lpnjAOXqn9ZWhK+9i2x1S9zR5RxjvnvMlIYCXVP96grtZe6q7CqezuSv+s9O62SukDm9RIrWurmeJpFLituNhkd5J7cC9/5jILhlNO7oW60O3qWMsKmvL+zGDdYzkQTVyBy+v/AM+Rmqobli1ucJrROcA7LsVVgKcrBxGqAU7O3ZYWuPLcSmqhJSU0/706QkajnVAym+bsf5skbMTYyK8q9F8a8aV3Xmidpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3NFVbl3WZcwMCCs7CH/KZqKOUowin3MhdSucl1ZBzc=;
 b=YPSq8ztTNts0YksGdiuHhLMBjynr1hKnQLbFpYu4FAdr4KnwuolasHJ60To+3iZdrU9cNmLio05c8vCzqJayazd/Zw8Cm9YClPXzyQXTMez9kJd/P5CX57DxrQdY7VpidCOGpeEPHobrwc/AV/JYtKZH8CUoKJAGAKfC9ImQRbaxFcOpXfw+6ggAJ8mBm0PxyY03ZBEk3907CG8X2aIoWtaEm4eMn5rkLP1F2ACRoenTPb7xt7LicW9sBJ59wB0jJL+jjfaF/DtU4GGcGFsOS+7Ik3CE2T+TdmKtU8q5BDrz7+NG8o7s32Q4B1hArfhGf9onApRn6NUxirwbqXDJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3NFVbl3WZcwMCCs7CH/KZqKOUowin3MhdSucl1ZBzc=;
 b=dMxHwPvcpULcnVpDeOFkatbVnF7mw0h/NYStSPe9RCweQRAjO5pGmt4zynXZKDPfV9hmCURK0PP7FMSZyWZ3goQ1Ym7KSho1IxGshlw5elEfX+D3sMzq9bReBIQJT5DM1nMNPcbhptSS4Qu607eKx69xe3oE0nkByV80hgCaQTE=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 BN0PR10MB5016.namprd10.prod.outlook.com (2603:10b6:408:12e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 18:40:14 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:40:14 +0000
Message-ID: <c1436289-372f-4aff-b315-0bb5750d7fe6@oracle.com>
Date: Wed, 17 Dec 2025 10:40:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 19/28] x86/tpm: Early TPM PCR extending driver
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
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-20-ross.philipson@oracle.com>
 <56929e8b-a7cf-4390-b4ec-0b4c2c32b311@intel.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <56929e8b-a7cf-4390-b4ec-0b4c2c32b311@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:510:323::18) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|BN0PR10MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: c83901ee-da65-4dca-ad9b-08de3d9bb785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OERGM1dOZXFlOFcxVmxjZzNlYU9INm1YMnJwYnc1aXExQWh2RjNmbzVyNE5T?=
 =?utf-8?B?VTRiU1FlUjRKMjNmd2x3a09IWVI0NzNxN1RzMzlwTkpuSUZyTnhHWVk3SUdI?=
 =?utf-8?B?cjgycnlWTDQ5N3BZVmN6cHMrUlRiMklIK1hGY0R1VHhmSHhjMElPc1Btekdw?=
 =?utf-8?B?YW5NaEloSXQ5Uzd0KzFYYlFTVC80endRMDBMNHdSN3lWM2lsOUZYOHVJTTF3?=
 =?utf-8?B?U2tadXZoTGtaQTd1SDVmZUVqaE00Qjd1M05hU3NFTTB4eWpEbkFUM0puNW1H?=
 =?utf-8?B?a1I0b1dETmd2RTNpdSs2dmNMQzVxNHI0VUJ1Tll5dnBrSE1FTk8xdEQrY0Rt?=
 =?utf-8?B?Z2plZzhzemhYS2FmdEQ3WjhQTlJTVHFUakZ4bCtrOVVrNFc0b2NpcUl6Y0lr?=
 =?utf-8?B?N0hMRHRuZlVGb0xHT1VyVVJ4ZjF5bUZHemdzR2xwK25mWEJyMU5sNEhzUjMz?=
 =?utf-8?B?dEtNUEtvb0V3RUI2MWpxSTdDMzBNOFBXS3NCQURmZlNMWEpNbE9PYVdXc1RK?=
 =?utf-8?B?OWRMcTFteWdsSFVuMnp2L25FNjloamZaV0xqUThIRjRYaldRYzZZeGlSNWJB?=
 =?utf-8?B?SU1CVmJOVU9EclZRbnJqU0pNb1BWT3ZHWDIyVTdiK01RSUF6K2xFOXhjOVRQ?=
 =?utf-8?B?Qk91UzR3RFB0NllMUmhZZkpTM1h1aisxdHNnRURWa1puYm00UFpMemVEOWdr?=
 =?utf-8?B?SUdPc0szY2JJZE96TXJzbzRGMTlSNndqUWcrV2g2ckN5d01yRmNDZFhINCsz?=
 =?utf-8?B?T1FURFEvUENCaEZEUyt3ckNSUGxGSzhFdWN5eS91TStqZVk4SHVrVi8vQXk1?=
 =?utf-8?B?UXVaNm9LUUFMRHg4Y3JRdVZmY0E3Z3JQRHh3WTF6ZUNoMTQ0NEJsT0QrWkhW?=
 =?utf-8?B?cFRmU3lXT2x0dHBLYWl1V2M3VUY0Q0NUeDBsaStnUVFiTCtPYVFxaFBqRVBq?=
 =?utf-8?B?TDlQL091dFRpQTY3bDY3cjNwckE4ekgzMVc5OUgwd1NMVTRKMVZIWkh4VGlC?=
 =?utf-8?B?eFdKUVppaUNPYVFJWUpCM1dMalY2a1VXdTQ0blZpL2oyV3VVQ2JLQTRldTNI?=
 =?utf-8?B?VWFySUllYjhhYjNhc3FVbno3YnZFdVpidDl6NGtEVXlrRmpkcG01UDBjSkhD?=
 =?utf-8?B?V25TOE5nUnNIUDNLVmFIODd2amZRUHVWblovMTgvdnJUbytvUzNMV2RKTk5n?=
 =?utf-8?B?SUMwK3VUdmdXZG9KOVU4c1VFVHlTM1NEdTB1b1pKa09lRGdIc2dJQ3hueWsx?=
 =?utf-8?B?d3FEamROWmlLT1QvdFJtUTRIMFg4amhYUi9iRWJmRG82dU02NjFxV1ZiVUlx?=
 =?utf-8?B?QVpXeGxrcDJEY0JYeFpnbnJRNk9kSWdTUnlPcjNwczBxQjVrT2tJa01oK1Bx?=
 =?utf-8?B?UzNtWU93ZHBmL2l3U0g1LysxZm1iclN4VEdCN1JyQTJuQ3FnUlc1VTh5TEZC?=
 =?utf-8?B?WEhYTVFZWFVMYW45NHB4MUd3NkRrZ0ZSc2Uyd3NiVHNkNFhaM2p0R3M4Unc4?=
 =?utf-8?B?ekFLQzRZU0xaUjJKdm9mVE5Kdndrc0tnVW1qNGlSTVRlbitlUkN2NzdQS1J6?=
 =?utf-8?B?TlhWek82Y0dRVGxFT1NiaitsYU15SldnKzVoVjl3ellxcEVHdUc3OVBVbmhC?=
 =?utf-8?B?ZmdlZEVVR09iL2ZqQUU4eHdLcUsrVWpvdEQ4RzV5YTR4eExCM2xFc2YzRDQ3?=
 =?utf-8?B?cVVONVVaRWU0ckE1U1FpUy9WS0hlMDlOaHorRjExcWFmTUxFcHFaSEhVQ0pv?=
 =?utf-8?B?ZHd3OGljYUJsd1VucG4zRW1iQzBiWno3QmgzNjBiTjNRR3hkYTNTRng0N2xt?=
 =?utf-8?B?c2paMG9NNVU3L0RVZUNQMkUvcThRKytleXErQjVkL1hIMDFDMmIxWG9EcWhh?=
 =?utf-8?B?REVYQWFIc1p4RHZnYjhUMENVSG9hSENiSndrQUZyOGxYR2tGY3o4c0gzVTBD?=
 =?utf-8?B?dnUwYXRVVys3NnNiNFY4N3FCYVQ2M2hramZaS2RlKzQ2Y2M3YmljTG5xTWdO?=
 =?utf-8?B?OGhCdUVUWDNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHpXV2xPNGxlellzR0hNczhJRWd1MEQzbCtJdnM2MEZqMVUyMGpSZHBXaXN1?=
 =?utf-8?B?b1d5Y0wxbktOT0grdnNVMTNTN2JRZlFTN2IwR3psNjBGQUQzYks3MmNOWW0w?=
 =?utf-8?B?c2t0SUhCdHQxbFBTeEhEZVRKRU56V0hwNWdrRkdwVEVwVVdRcEE5cVhNcGl2?=
 =?utf-8?B?cDRiSytjWHdqa2d5MHlRTUJBVDZZQW9rZVVqUnN1RWNUbE81amRXSGdXSXJ3?=
 =?utf-8?B?b3lwN0luVk5tUDFMMGRjVmhxdEV6TkN6VWhKUGFTZDFreDBWSnRuRVh0R1lv?=
 =?utf-8?B?K3VNTmdlSEdIcEtSMWF3eFhHVEl5U095Yk5GTUp5TFFhU1JSN0ZScmk3VFVQ?=
 =?utf-8?B?TkVLUFdEbENlS29DT0ZuRkNVVCtSall6M054NVVYMHdEcTFjNFp6dkVucTN5?=
 =?utf-8?B?NUQ0bzVuRFkrZWd3dSsxUi9TNEwrYStNeHpBS2dINDh4MUhpVHFLcjJPeG5M?=
 =?utf-8?B?cDNuRGhRWDJwcVlqWVgxaHdDK3NLUUpwS2dDRHU0NDdtWnFxMVRLbG84U3la?=
 =?utf-8?B?U0VCQTJMdVMrRllIV1BnSFY4a2l6S1dYUEZhTzlSSXpNWktoaG9CWXUxeTVy?=
 =?utf-8?B?NEZmTUh3WWE5aDdMSVVDYXJlVEVsaVB1b1JJRHpSVXA1WjZzYzRPSi9kWXRN?=
 =?utf-8?B?dWdsajhXY3VHODNjTy9YQVNSVXZObDF4eVBwb3ZzRDdtVmZ1WnFyOEJ1aXh0?=
 =?utf-8?B?WmZMaWp3L2dDZ3R4Z3Zjbng1VWZzdEVJcUxsbStZSGZWQ3pnb0lKQU9KS0Ri?=
 =?utf-8?B?dVdhTDh2WDh5cEZaZlJHdDBVZXJsQ2N1SmdHYmhtYXVZdllLOWdvMzNMK1N0?=
 =?utf-8?B?cVBmUUgxMkdDOTJGOE9VN3NJeHdlQVM4Z2gyWStmWmN6S0xOcTJsNHpiMDAx?=
 =?utf-8?B?YlN5OGhnUzJHWGV3cCt4K3dkcXl0QllsTVI0VWVaUzcwMmo5c3EwRk9rNE55?=
 =?utf-8?B?WEVvNnZOczJOR0xMVytaU282UXZ4RzAzbUlqSUEwWXBKSmFGa0hRL0Z2cVgy?=
 =?utf-8?B?VDFqSnh2b0dMUlU3OEVUSzY0OTlXeUZZOWJlWEVhT05ublo2K3N3TVN1L2V5?=
 =?utf-8?B?UCtRTmFnY0NNWE9XemFVOW5rSmVxRDREWmRyU2tWZHNCQUFOKzhhTElHcFRv?=
 =?utf-8?B?Y3ZQY0JhOW9NdUMwNnBHQUhIR2x5YnZzR3RQb0ZvQWN4K1cyY3htRlhnT1ha?=
 =?utf-8?B?dHBXdzZNSzJxR00zTHdPTGxRb1EraGx1ODFtOHJ1Y2hrQVhLMzdvcWdxc1hv?=
 =?utf-8?B?MGQxakRoOFhpU1I4Wm92cW56Z1EzUzFBV1FRU0tCUDhoSnpjbXc2Ri8wQVJo?=
 =?utf-8?B?VDlyeVRKODBsRHlFMERGaUlHVU5HNmx0azlpQUMvOEwxUWpBdzk2VWlKdEx4?=
 =?utf-8?B?MDRtWVd0OUJ6Rit1Ym9WSTdaU3Q5OHRCZTZjVzA2cDJYalJwVFdJZjZndWpT?=
 =?utf-8?B?VWV3UG5WSFFlQW1NbzhYcWMzNUtjTU9XSktjaTlUaHloUVhKWHZVS2RUa1Bu?=
 =?utf-8?B?WExnQjIxSDMzajAvZ1VCTjlEOCtyTG9QK05VV25kT293M2I2Z3BscVlueTNM?=
 =?utf-8?B?Uy9aUjB3TVdDYklnN2NLVm4wOXl2RkpNODFkWWFrUjgrV3pheitMZW9zZmJY?=
 =?utf-8?B?S0p6cHhZMldRTVNIUWVaYVpHcmNleFdDQkZMN29uQ01CTVBhZWdyUHphc05Y?=
 =?utf-8?B?ZElFZ3hkVUhTYmZOdmpqL3hobXlESzRiTzNXUWMwVFhScTdYQm1oVGcycVor?=
 =?utf-8?B?MXcza0hIQVpaVjArVnJKd0FNdGpJYmZYRjFDSWF5Tlh0NGlXeWltb2tpYmI4?=
 =?utf-8?B?UHVkM0VwRHBKV01qdWlRWjNzVFBOSTRzdDBMcExHUzJxaFVNVEc4Y0JBT05u?=
 =?utf-8?B?L0g0V1lRV0RBdmNrWjQ3Uzk1bHZuVGEzRHE3K2VRWGxFQ0w4MER2YUNSeEkz?=
 =?utf-8?B?b29DYXAzejVyYUYycHNvak5Ca1c5dUNGZ1h1Sy9ZUjRMWXdKSU1SRkFrUWEz?=
 =?utf-8?B?Z3pZK0xralVINGJBbWpPTUthaXVKVmhOMlRYTUY5ZC9OSlBma2xqOVNIbG9I?=
 =?utf-8?B?empyaWo5aXVVVzArUUIraVdZOGtHd2NNcW5URHBBTXFFQ1loYWFRbG82Zml1?=
 =?utf-8?B?MHozeG00SHNTYUJiWFZaemRjSnZvMW5XcVRxL2lrU2hmUFhvWFpmU21nVUJm?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JpEDf57VqlhOX9DuNSymvNnUMSHPephRIdT62w9dbodNwgFGwK/s/bR+DSb1ZxCXn++U0kEyvGT8xNmOUUjn4zviV/RZLhLlT6n/fLUmgZQ7fJu3YDuJamnepvlG7MUdXx3vWgX2JKWRpQSKlT3P+RSkbpb/oQGXgPOs5bgFkW8MxWfWhUPd2BXZiSjVjM0+ObjYCP7ExVCUrsW/mYmPSDBdVjIUUyY5hr6Xt6vKEIfFCaNlcyjE/ecV1bREP2b1riZYv6Lk4y+d0kgjrGHrUsx1b9sbHEVfWlkXdKqHrAqo2gWG7vq3qOx3HNfz0MWO4J/Q/L2Jhxrq6Xe9zldP6phwD9RoDPaCSn2dEEvLwRd3TA9pfXuSDDyfwA+W309O5YUjPjcmvJlop0s6JhtQEYVOzZLvXskTYsTwIBqTcRwTGZkWhL/oF3T6GHhyiu6Eq+nvKLLg2cVg+zjsgEm7skBcVtEEKGW9gwzxZPGnW1FQUQlTj68lX6qEMAV8rMl+Le27x3yA+xxoY4ZHocEKSxHrYkyffE3RRzrlIXOgJSgvARJaGtU2HsnRB1cX9wGia5hkMTPdCJ44g8iRce2EZdByS4gyqhRMAv5pFKsbtz4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83901ee-da65-4dca-ad9b-08de3d9bb785
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:40:14.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIYca7KpQfh2XlbKAS+vMVBhRj2CMSlmQTBqOto6NiqkUzzULgumC7zN+z+TN7BUxkl6LvAiAJaEdoJ4yGEqIFIKBl6v9lr2yPZKQkPjlho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170149
X-Authority-Analysis: v=2.4 cv=B8W0EetM c=1 sm=1 tr=0 ts=6942f913 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=HKsKcPmbEJAtOU23E98A:9 a=QEXdDO2ut3YA:10 a=Ujx6Yl6ClJkA:10
 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: LMMAw_HsGGtpdG1Tkce10QvABBE75gOb
X-Proofpoint-GUID: LMMAw_HsGGtpdG1Tkce10QvABBE75gOb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE0OCBTYWx0ZWRfXxd0y9Cr1YIze
 GT3PzFPz1vR4t1ALMvZacCBs0HSN2L2O6CmY9/7GQkH+N7xfodrIAO2I5ZHG38Rw5SGy747mkwu
 4chQlADmciAA1IMorNm/3m0B1RfXa33K3p9KB8GG3H9UPQsQ4aq9sw3z+/8FgQItGdKncLFh5wh
 e1/PgEXgOXPax2bCwpykpEFkjg3MSS9FMLBPX6O4hVV1HoyVMv6ZnLgbeQX0p92872y2bMWqW/5
 cse/SSSNtfLz32MqNMJgU+9GFIyr01Udw/7mfPS58O+ljNvn4Gcy4yW9qI/3limJqHR7KxlBw4S
 Dx9Xd3W1x+KgbJ4FSnxK318GN1gbbbZwRw3PW0CfU2Pe3c5nU3m1LtNhAgQi1b+xlnB7M36lzso
 DgU9TWdqTGs2D/9N86Wof421G2MOf9IKBui3mALxxGkuEA1kPT4=

On 12/16/25 1:53 PM, Dave Hansen wrote:
> I'm mostly spot-checking this to see what kind of shape it's in and how
> much work and diligence has been applied in the last 8 months since v14.
> 
> On 12/15/25 15:33, Ross Philipson wrote:
> ...
>> The driver could be extended for further operations if needed. This
>> TPM dirver implementation relies as much as possible on existing mainline
> 
> <sigh>
> 
> v15 and no spell checking. :(

Will fix.

> 
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/early_tpm_extend.c
>> @@ -0,0 +1,601 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2010-2012 United States Government, as represented by
>> + * the Secretary of Defense.  All rights reserved.
> 
> IANAL, but this looks fishy.
> 
> It's theoretically fine to go grab random code off the Internet and
> submit it to the kernel, given the correct license. But I do want to
> know what its story is and where it came from.
> 
> I also seem to remember that there are special rules around the US
> federal government's inability to hold copyrights. This seems worth at
> least a mention ... somewhere.
> 
> This is helpful, for instance:
> 
>> + * based off of the original tools/vtpm_manager code base which is:
>> + * Copyright (c) 2005, Intel Corp.
>> + * All rights reserved.
> 
> so thanks for that one.
> 
>> + * Redistribution and use in source and binary forms, with or without
>> + * modification, are permitted provided that the following conditions
>> + * are met:
>> + *
>> + *   * Redistributions of source code must retain the above copyright
>> + *     notice, this list of conditions and the following disclaimer.
>> + *   * Redistributions in binary form must reproduce the above
>> + *     copyright notice, this list of conditions and the following
>> + *     disclaimer in the documentation and/or other materials provided
>> + *     with the distribution.
>> + *   * Neither the name of Intel Corporation nor the names of its
>> + *     contributors may be used to endorse or promote products derived
>> + *     from this software without specific prior written permission.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
>> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
>> + * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
>> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
>> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
>> + * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
>> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
>> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
>> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
>> + * OF THE POSSIBILITY OF SUCH DAMAGE.
>> + */
> 
> Also, IANAL, but this looks BSD-ish.
> 
> I would have kinda expected the SPDX header to say BSD-blah-blah and not
> GPL-2.0-only.
> 
> I'd really appreciate if you could go have a huddle with your corporate
> Open Source folks and make sure this is all proper. To me, it looks
> fishy at _best_.

Yes, we will do exactly that for all the licensing and sort it out.

> 
> ...
>> +/*
>> + * We're far too early to calibrate time.  Assume a 5GHz processor (the upper
>> + * end of the Fam19h range), which causes us to be wrong in the safe direction
>> + * on slower systems.
>> + */
> 
> https://urldefense.com/v3/__https://docs.kernel.org/process/maintainer-tip.html*changelog__;Iw!!ACWV5N9M2RV99hQ!ODp_iKdXfPuA60ae9ZCFdElNvGZjrd7ffPYtSVs3cwOTY2kzGN_tgsRLYawnxEGiHE0jMDN2kgOxBBtMtmu-7ohw$
> 
> Imperative voice please.

+1

> 
> ...
>> +static int __tis_recv_data(struct tpm_chip *chip, u8 *buf, int count)
>> +{
>> +	int size = 0;
>> +	int burstcnt;
>> +
>> +	while (size < count && __tis_wait_for_stat(chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, chip->timeout_c) == 0) {
>> +		burstcnt = __tis_get_burstcount(chip);
>> +
>> +		for ( ; burstcnt > 0 && size < count; --burstcnt)
>> +			buf[size++] = tpm_read8(chip, TPM_DATA_FIFO(chip->locality));
>> +	}
>> +
>> +	return size;
>> +}
>> +
>> +/**
>> + * tpm_tis_check_locality - Check if the given locality is the active one
>> + * @chip:	The TPM chip instance
>> + * @loc:	The locality to check
>> + *
>> + * Return: true - locality active, false - not active
>> + */
>> +bool tpm_tis_check_locality(struct tpm_chip *chip, int loc)
>> +{
>> +	if ((tpm_read8(chip, TPM_ACCESS(loc)) & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) == (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) {
>> +		chip->locality = loc;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +/**
>> + * tpm_tis_release_locality - Release the active locality
>> + * @chip:	The TPM chip instance
>> + */
>> +void tpm_tis_release_locality(struct tpm_chip *chip)
>> +{
>> +	if ((tpm_read8(chip, TPM_ACCESS(chip->locality)) & (TPM_ACCESS_REQUEST_PENDING | TPM_ACCESS_VALID)) == (TPM_ACCESS_REQUEST_PENDING | TPM_ACCESS_VALID))
>> +		tpm_write8(chip, TPM_ACCESS(chip->locality), TPM_ACCESS_RELINQUISH_LOCALITY);
>> +
>> +	chip->locality = 0;
>> +}
> 
> I guess some folks aren't enforcing the 80-column limits. But this is
> not even close. It's almost 80x2.
> 
> Has there even been an attempt to make this conform to kernel coding
> style? What other checkpatch.pl warnings are being ignored?
> 

We do run checkpatch.pl and fix the issues it points out. I feel it is 
not clear how to approach the 80 character limit rule though. I have 
been told in other reviews that the 80 char rule is not really followed 
and certain things would read better w/o it. Reading the guide again, it 
does not really spell out details other than try to keep it 80 and 
under. Maybe there should be a hard limit (< 80x2) if you exceed it?

But ultimately I will format the code in whatever manner is requested.

Thank you,
Ross


