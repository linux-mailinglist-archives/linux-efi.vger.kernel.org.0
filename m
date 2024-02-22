Return-Path: <linux-efi+bounces-650-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D86860012
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 18:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87642B24D16
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8675A157E66;
	Thu, 22 Feb 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UHmgvjZF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zSB/p+f2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D53FE2C;
	Thu, 22 Feb 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624256; cv=fail; b=qBrwMm47U1XCzWMJ6AzEA/HSgVsbi89+Bc6jEx/Q9en4lffQrToCqkh+DTALzaFm4qEsqPGnFTUTx0F1oYqUwk6YOHmvuqhBEEKwG2VPlfdHeOmMvje50rF5tsibyNUV8MNTHaFF0tRS11pmIn98KDHY9hrC7JXk59k+xOPZqSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624256; c=relaxed/simple;
	bh=HKYXrQ3KxFK3eP+MFqzqDvKARr6cSqs1uLU0NFuviQo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A24nPJvIIGTgbVTMGM8XNpRzD22TBL0YUE8xbMP7EF/TuCtOw/8G6Eqzwa0brxpGbTOvXjSpWgfZCNJtEpCSmspRntcukk/868uRECKokvdqTs0wa0iYpL573Jn+trc9QBjdQv3/2YhxAREkwstrclJKXGsVlTWwh56Khli9rqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UHmgvjZF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zSB/p+f2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MH9ZY6031359;
	Thu, 22 Feb 2024 17:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LQPE4nh3mWq5En5H4LEmNSO52JIx8v8kcETgPnCQ3E4=;
 b=UHmgvjZFOxUNkOrxfLauxK8Gv1Bg90xQYZVrkSQN1Ta/01W61M+uR0leP6bOfPP5jaZ3
 Kwtn4OU+9Bvcexa5b9VWs2SfwH//t2JWer03x13XnZDVmF3cWEc5/pwt8NsoQJYRgYoy
 pjIq8wv3Q4/d+E3q1ejRL9ik/AZRdFL8+nVCkjjrZDi00KEOn6mhiikYkvc9vY0IBRaZ
 xjGvndLoQioerhzGvMlQMF+u7kzEUlbsONrYR2JkSRDmKlkNvo9mNfYX8iYrhKY/GK/y
 Snhxc3Iid/qsealrKR+xopW/jip82IvK81LGxG/Pks3xXHwRlXKknL7bLHjJf4GsgEdT Dw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd2dhn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 17:49:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MH8tGN012827;
	Thu, 22 Feb 2024 17:49:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8bdfsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 17:49:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5eujYrvu6VS0JYTIkl0vcBckV7CtibAJv34K0l3VH9EVGJzPBPEnsdKEZlXg9VI58Y5t/yy2xpsDSYVdZMMX9jWQ0Lf78QUj+tMBlnjRvUEgEI9SChIDonW2Mxhm2pH3jf57lxSJrH3Loss+62uF5Fnyko6rYKEgXNXJtl+KJwDFwsQ6lVGIb91XRSW6ZPhFocrI8S1RQcb0jVJycxKQgR2S5hzDtl+3jiCYb6qClTlIgX9vhmD3+U8SF3qudKi0q5pALxj5x/5wX+2QF41jtAwHiT2Phj7gbUvmeub6mb5PXJutIjwT4JvUgi2lMeU7Q9OOaQFUwKJ6iScnIr0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQPE4nh3mWq5En5H4LEmNSO52JIx8v8kcETgPnCQ3E4=;
 b=KVD3x23Mggo3P2lU5lf/RMCebJbD1D+ZkItaDvVnu0WJDwcB6KGJuc7MKW+KH3wDlKFTvFkLVFtGWAgNu53trrZmc/CyaBRD/obdHZbO5dhea3zQlKvU3qX3F+qfr1kT5sYjfg4OEY5TE3WJ2NybVAKcVhz3D48rFQE16WTW0a3ug1nATOw1jKjjdxrNlcV4caukBsN/hKJhlDPy/J1jC9d0EtlSq1/qafVobXuTaXFVQwJvfXgjSFx8n7QT7MVirPiKGqftYQKwIGrpqMEFZB22pOIvWx0t1Nvh4HP3qzpWPvF54ns9Tbixb8DJroCOffBlPQxlq2phB9GIVh/s0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQPE4nh3mWq5En5H4LEmNSO52JIx8v8kcETgPnCQ3E4=;
 b=zSB/p+f221IDsgM3CWv5IrpO1lY/ZZ1Lx3LqFs4QonWpxNML7aUxS8NB3aGHZO74LKJm/12iXP+ylAi/Pc31a88WJCBYxDjncwK48u9g+gN8fe7pGW/zpyemCdZnbgxm7XJn344ddRzLxGbrfVCxvu42RvmZdZOF5OyaoPg1mBo=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DM4PR10MB7403.namprd10.prod.outlook.com (2603:10b6:8:184::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.22; Thu, 22 Feb 2024 17:49:52 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::ffd8:c820:635f:8d0c]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::ffd8:c820:635f:8d0c%5]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 17:49:52 +0000
Message-ID: <a94faec1-693e-4fe4-84e2-aa7db576c4b8@oracle.com>
Date: Thu, 22 Feb 2024 09:49:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/15] x86: Secure Launch Resource Table header file
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-5-ross.philipson@oracle.com>
 <CAMj1kXGaMfUAR85jpeS2JxcmWBbpkzroCVZOtwa3WDQwStDjMw@mail.gmail.com>
From: ross.philipson@oracle.com
In-Reply-To: <CAMj1kXGaMfUAR85jpeS2JxcmWBbpkzroCVZOtwa3WDQwStDjMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0035.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::48) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DM4PR10MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 24002f6c-447a-4fa0-e328-08dc33ceabf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8s/PWuPdPbZdNgHhbzi+leQTi8/QDNzOGLYUSvzR30QAuCd0t4IZ+XYW8rzGMQgECazjF5ERXAqWKFDHU1AHku6mi2cpYD5BIa868AggeT9hAWlbol8XPOHKbVx4AYvPs5IX77SAixk3MG2tGwaQpPK6VT4BedBkZUqKu9WRFvfqo659lKktBm6XycNyKssYM7z05p0j6hbcKmFazY+aBZvW/LMvUkMUeGUs5mA3lfEHjiQgfF1bMvEpFDf/YODbOKNlJych7Pr9w3k0t99Y/cVNRPgwJv8n2IeTmZ+WfGZri83a6iMlzcT9VyIErpCmUhA/dY3OxF6bx9icIzyPb36hnudwiSXLA/ULqYc1RBWniWAHY7cXQyanEjR28RU3kIeTGtpEI3zWN/A/YEZIfEQbutemzLBS+7JymmquWb/NGjCjRETMkLVvJ7izPgWwvD7oh0yBEe3U1GJxd5ZEn07d6l5beFgsQ3XLN/X3ZmPQ6zgayEArbGvmJfAFphgpLwomScHiAP2bt/VmAaURu+f/89uXEM1p6xEl2seD84w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dXBPL3ltL1BBRXNHM29LNlErWkwwVDBQT1FZbS9WazgyQ0hxUjFlVDYwWTBH?=
 =?utf-8?B?ZjBWNGEvTDRtVzRaWUlsdHRVWW5ERk9NODFneW0vdVlvU1hEaVVHL2luNlhH?=
 =?utf-8?B?alQ0b2MydWRla1hkUXA1QWh4Tk5kMEhwQXpxZjdUQlUrTEJ1c1FhRlkwNFRs?=
 =?utf-8?B?ZFVKVnFuQk52L3NEUTgvK2xpWWhuNkxPSXVGV0owR2NHK2xtN2RkVno2SEpz?=
 =?utf-8?B?dXJXb25VbFJMdGpuOS9xL29Ja0J4MWUwbTdKOE1YR1FrWHRHK3Jkc3MxK0k0?=
 =?utf-8?B?RVZ2RjVjNDAxVU1iaUtrL0pvUDZkbjc0cVBjMU9PcnBBYWRNcXFXVHRibCsw?=
 =?utf-8?B?cjd3bUJrS1Z3U0lORVN1Ry9lbnpabTRnSE5jcC9yZ3NxYW9keU5DOEoxV1kv?=
 =?utf-8?B?L1hOd281WkJWaFRZRS91Ly8yblVEaWZ0Wmh3OU9ScUE0My9jVjhhTHRMN1pU?=
 =?utf-8?B?ODBJajRKV0tLbUhCdG44R08vemN1ajFtd0lleG9BRk9EdEJua0NxWEV0V3Qz?=
 =?utf-8?B?YkZRSVgrTk9ieC95SWoxZjloSDV2M240RWdKdnM0U0VTOThSazNkSUErL3hX?=
 =?utf-8?B?V1dVaEZqaUMzRk5IUmVESzZZQjRsbWMzMXlEKzhyTjRHcktuNTA2WWJTSDJV?=
 =?utf-8?B?Q2YzeVdUNVl2Vzg5T2kzck1CWFRDVnJTTVZ1ekVVL2dFeGNPb3REekpHbis4?=
 =?utf-8?B?RHQ1SFBIWUNlUGRMVDZ5dHB3aHQvOWpUalcveVBhMGlLVDdrU1lYcUJtS29Q?=
 =?utf-8?B?eElpSkw3cGo2a01XMk9DUmFPVkhtdUVtVjhjYkcvekVucWRLMVJZTEEzTnBE?=
 =?utf-8?B?U21XeE0zRlVkWUlUQlA5Qk5oQVhGNnE1aXlnYThpRTE4a25Ea2lEd1pWODZJ?=
 =?utf-8?B?bUF4d1IxSUxieVR3M3l4WkZVZHZsSDF6SERxTjljeWh0TXJ2UkJSSUcvSnRT?=
 =?utf-8?B?TWg5MXdlYjFuZUxNeUNOU3RGc3hteGFzQ0txMnM5YVk0aFJ2MHRCNFE3ZmFz?=
 =?utf-8?B?cm9KZzh6WDN2bVRMaGFHRE1lS0JlUE1UeFF2R1BXMm4yU0RLa1lCMnlZR1dY?=
 =?utf-8?B?ZFBqays3bW1Rb3g5VXdCZHhlMktjRjNWNHBFREVCdVEyK0N6UWdFSUhrbStl?=
 =?utf-8?B?cVBjZnlTWGFwS3k5VlZaZXUxNFVISEUvWXpyRWFrRG85SmF2eHl0ZVQ2d3ZW?=
 =?utf-8?B?eUI2cTNrZE1raC9OczdkUXJJc0tvancvQWtyRkx1YUVKRW9Ld05DVk5sSnlF?=
 =?utf-8?B?UHBnVFBpeUYyN3B5R1Y0Sk9Lc3ZUM0RiN2EzSlVNcnBaUlIzWGM1SUdmbnFQ?=
 =?utf-8?B?ZXVvNWtFN2crYXlMQ25pQldBSGFteVMxNU1JOUIwK0s0MmlUNVViTU8vem50?=
 =?utf-8?B?ZkR1QzhqMU0rYnhqMkxZdTVpN0tNS3JjdVNsaWJSS1ZrTU9icGorN1Y3VXFX?=
 =?utf-8?B?TjQ3Tlp0L0NodDQrR2FnOU1IT2pHeGl1Z2k3eEV4M2dsK2NscU82dEJtZW5X?=
 =?utf-8?B?ZTlPd1dUOTNvbGZNejREUHJ0M0dlZzM0MDUzVVIyVUVNRWFzRTI2M0V6VWhX?=
 =?utf-8?B?ZWd0Y2dGLzgwSno4Q0xKNjdmNlVjMm14VUIwdkJPUXp3VUpLRG5xcjBIcHJi?=
 =?utf-8?B?MTVlR3pMRUZOV0lZR0ZiRWZ1czZBM2lEaWQzRmZiZmdjQmVMR3gveVYzOStq?=
 =?utf-8?B?eTlBTnNScUwydkVaaE5jUzF6YkpCaXNQK2szeFhGWHdqSmVYdTNHWnc5eWVK?=
 =?utf-8?B?OUlzeFUvQ0JvNGN5R2JGMnVsWVcxbUNSL2J6VStFOUZXNDNkRGlzL3NQdDYr?=
 =?utf-8?B?WmdJMDhRY3lOUTRoNVQ5OFBlR3lDYnM0RVArS0N1Mm5iWU5QV0ZwaCtBZXVo?=
 =?utf-8?B?UDJ5VTljY1VxSzRQN0NVZDJLdTVxT2trd283RkFCZHBMbnA0bW5KNlZaYk9R?=
 =?utf-8?B?NlJJUWxGYTFzWXR1OUJsWWx6Qmc2MW05QUhValRaTmw1RFUxQWprc3dYa2pG?=
 =?utf-8?B?Y3ovN3UzeWhXRzhkS1JSNUtFUE5UYzhpZUVlai80V1pKd09JZUNWM2R5U3lP?=
 =?utf-8?B?aW5iL0NuSzl1ZWdkUU1jVFBEMjk0S3dOSDV5ZWJ6V0ZJTUVGZ2NrTlRoNkxp?=
 =?utf-8?B?VmFOV015R2xmZHRESWN5Q0U5amF6TU03b3RTN1NBZGY1aUdBTE1pUC9XL1dF?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kRTSJ7+vQUP1dDGfwKl7Qh+giE+d7bOxo7WzRRwnCCxnUNzhngHN1aovvjFT2vrHJwhQhHCfr03WLKOj2VNMghLyA5LFeiGzGaZyDr8Ynao5hjzr5CF905bwzM9e5YFsOLsWryO9ynTLnQrFBW/waf0CmVIB8TStc2j56oBWLQrM9yAvtKz56cDPcq22zfseauwkeRwGRr+9UZQs5Rufc2d6piHFr83rvBhcQ1CmOgC+f8Fgq4ZNp4Rg7ZWPUhffn74bAV66IW+d/gbjMeNUP91VHFGZir9/f8LHGGrXB/CXINOnYxSGP/sg2gwgror4duOKqrMl6MXCx7onp+1hFMfdPITmqailEivb8L4gUbIiqwPKcBPCfXYRWHj4s8CuRasgijEPT3KJzxI93waZNvvFAAO4MZTNSU/tmi2XRoqgcTIiM6LrBq4DjHF8Yn7S2nop1NZiK0MjCmLHkxIwmO4x8ZXWhlkZdXXA+29LEVeCNLWfQwkevQ5r5gX/cUOsGGFYdc8vVlF/x/OmYNVWeV3qmh/tNP9hL4khBQZTM+KLYwLAogQDDtI1vMqLEAtFsLPhbhiV+qp/bVyD5AhtT4k891/l0EoFCY4f1g4+W44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24002f6c-447a-4fa0-e328-08dc33ceabf4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 17:49:52.3454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lH8vIbXrAULUbZ3J1U0QevMBAjsGrShzF1uGijMKur9tUlVIg3TJPMXhR9AShTfx9BI77aVobNMFLidvnU6bGcgaXZt+/Il4T3NpCAb7mMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402220140
X-Proofpoint-GUID: VXvmW-kGFJ80TQnhvUTjwwqEhrenOVr_
X-Proofpoint-ORIG-GUID: VXvmW-kGFJ80TQnhvUTjwwqEhrenOVr_

On 2/15/24 12:08 AM, Ard Biesheuvel wrote:
> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>>
>> Introduce the Secure Launch Resource Table which forms the formal
>> interface between the pre and post launch code.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   include/linux/slr_table.h | 270 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 270 insertions(+)
>>   create mode 100644 include/linux/slr_table.h
>>
>> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
>> new file mode 100644
>> index 000000000000..42020988233a
>> --- /dev/null
>> +++ b/include/linux/slr_table.h
>> @@ -0,0 +1,270 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Secure Launch Resource Table
>> + *
>> + * Copyright (c) 2023, Oracle and/or its affiliates.
>> + */
>> +
>> +#ifndef _LINUX_SLR_TABLE_H
>> +#define _LINUX_SLR_TABLE_H
>> +
>> +/* Put this in efi.h if it becomes a standard */
>> +#define SLR_TABLE_GUID                         EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
>> +
>> +/* SLR table header values */
>> +#define SLR_TABLE_MAGIC                0x4452544d
>> +#define SLR_TABLE_REVISION     1
>> +
>> +/* Current revisions for the policy and UEFI config */
>> +#define SLR_POLICY_REVISION            1
>> +#define SLR_UEFI_CONFIG_REVISION       1
>> +
>> +/* SLR defined architectures */
>> +#define SLR_INTEL_TXT          1
>> +#define SLR_AMD_SKINIT         2
>> +
>> +/* SLR defined bootloaders */
>> +#define SLR_BOOTLOADER_INVALID 0
>> +#define SLR_BOOTLOADER_GRUB    1
>> +
>> +/* Log formats */
>> +#define SLR_DRTM_TPM12_LOG     1
>> +#define SLR_DRTM_TPM20_LOG     2
>> +
>> +/* DRTM Policy Entry Flags */
>> +#define SLR_POLICY_FLAG_MEASURED       0x1
>> +#define SLR_POLICY_IMPLICIT_SIZE       0x2
>> +
>> +/* Array Lengths */
>> +#define TPM_EVENT_INFO_LENGTH          32
>> +#define TXT_VARIABLE_MTRRS_LENGTH      32
>> +
>> +/* Tags */
>> +#define SLR_ENTRY_INVALID      0x0000
>> +#define SLR_ENTRY_DL_INFO      0x0001
>> +#define SLR_ENTRY_LOG_INFO     0x0002
>> +#define SLR_ENTRY_ENTRY_POLICY 0x0003
>> +#define SLR_ENTRY_INTEL_INFO   0x0004
>> +#define SLR_ENTRY_AMD_INFO     0x0005
>> +#define SLR_ENTRY_ARM_INFO     0x0006
>> +#define SLR_ENTRY_UEFI_INFO    0x0007
>> +#define SLR_ENTRY_UEFI_CONFIG  0x0008
>> +#define SLR_ENTRY_END          0xffff
>> +
>> +/* Entity Types */
>> +#define SLR_ET_UNSPECIFIED     0x0000
>> +#define SLR_ET_SLRT            0x0001
>> +#define SLR_ET_BOOT_PARAMS     0x0002
>> +#define SLR_ET_SETUP_DATA      0x0003
>> +#define SLR_ET_CMDLINE         0x0004
>> +#define SLR_ET_UEFI_MEMMAP     0x0005
>> +#define SLR_ET_RAMDISK         0x0006
>> +#define SLR_ET_TXT_OS2MLE      0x0010
>> +#define SLR_ET_UNUSED          0xffff
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +/*
>> + * Primary SLR Table Header
>> + */
>> +struct slr_table {
>> +       u32 magic;
>> +       u16 revision;
>> +       u16 architecture;
>> +       u32 size;
>> +       u32 max_size;
>> +       /* entries[] */
>> +} __packed;
> 
> Packing this struct has no effect on the layout so better drop the
> __packed here. If this table is part of a structure that can appear
> misaligned in memory, better to pack the outer struct or deal with it
> there in another way.
> 
>> +
>> +/*
>> + * Common SLRT Table Header
>> + */
>> +struct slr_entry_hdr {
>> +       u16 tag;
>> +       u16 size;
>> +} __packed;
> 
> Same here
> 
>> +
>> +/*
>> + * Boot loader context
>> + */
>> +struct slr_bl_context {
>> +       u16 bootloader;
>> +       u16 reserved;
>> +       u64 context;
>> +} __packed;
>> +
>> +/*
>> + * DRTM Dynamic Launch Configuration
>> + */
>> +struct slr_entry_dl_info {
>> +       struct slr_entry_hdr hdr;
>> +       struct slr_bl_context bl_context;
>> +       u64 dl_handler;
> 
> I noticed in the EFI patch that this is actually
> 
> void (*dl_handler)(struct slr_bl_context *bl_context);
> 
> so better declare it as such.
> 
>> +       u64 dce_base;
>> +       u32 dce_size;
>> +       u64 dlme_entry;
>> +} __packed;
>> +
>> +/*
>> + * TPM Log Information
>> + */
>> +struct slr_entry_log_info {
>> +       struct slr_entry_hdr hdr;
>> +       u16 format;
>> +       u16 reserved;
>> +       u64 addr;
>> +       u32 size;
>> +} __packed;
>> +
>> +/*
>> + * DRTM Measurement Policy
>> + */
>> +struct slr_entry_policy {
>> +       struct slr_entry_hdr hdr;
>> +       u16 revision;
>> +       u16 nr_entries;
>> +       /* policy_entries[] */
> 
> Please use a flex array here:
> 
>    struct slr_policy_entry policy_entries[];

Yes we will use flex arrays everywhere it is relevant in here going forward.

Thanks
Ross

> 
>> +} __packed;
>> +
>> +/*
>> + * DRTM Measurement Entry
>> + */
>> +struct slr_policy_entry {
>> +       u16 pcr;
>> +       u16 entity_type;
>> +       u16 flags;
>> +       u16 reserved;
>> +       u64 entity;
>> +       u64 size;
>> +       char evt_info[TPM_EVENT_INFO_LENGTH];
>> +} __packed;
>> +
>> +/*
>> + * Secure Launch defined MTRR saving structures
>> + */
>> +struct slr_txt_mtrr_pair {
>> +       u64 mtrr_physbase;
>> +       u64 mtrr_physmask;
>> +} __packed;
>> +
>> +struct slr_txt_mtrr_state {
>> +       u64 default_mem_type;
>> +       u64 mtrr_vcnt;
>> +       struct slr_txt_mtrr_pair mtrr_pair[TXT_VARIABLE_MTRRS_LENGTH];
>> +} __packed;
>> +
>> +/*
>> + * Intel TXT Info table
>> + */
>> +struct slr_entry_intel_info {
>> +       struct slr_entry_hdr hdr;
>> +       u64 saved_misc_enable_msr;
>> +       struct slr_txt_mtrr_state saved_bsp_mtrrs;
>> +} __packed;
>> +
>> +/*
>> + * AMD SKINIT Info table
>> + */
>> +struct slr_entry_amd_info {
>> +       struct slr_entry_hdr hdr;
>> +} __packed;
>> +
>> +/*
>> + * ARM DRTM Info table
>> + */
>> +struct slr_entry_arm_info {
>> +       struct slr_entry_hdr hdr;
>> +} __packed;
>> +
> 
> These two look preliminary, so better to drop them now and introduce
> only once you know what they will look like.
> 
>> +struct slr_entry_uefi_config {
>> +       struct slr_entry_hdr hdr;
>> +       u16 revision;
>> +       u16 nr_entries;
>> +       /* uefi_cfg_entries[] */
> 
> Use a flex array
> 
>> +} __packed;
>> +
>> +struct slr_uefi_cfg_entry {
>> +       u16 pcr;
>> +       u16 reserved;
>> +       u64 cfg; /* address or value */
>> +       u32 size;
>> +       char evt_info[TPM_EVENT_INFO_LENGTH];
>> +} __packed;
>> +
>> +static inline void *slr_end_of_entrys(struct slr_table *table)
> 
> typo 'entrys' ?
> 
>> +{
>> +       return (((void *)table) + table->size);
> 
> You can drop two sets of parens here
> 
>> +}
>> +
>> +static inline struct slr_entry_hdr *
>> +slr_next_entry(struct slr_table *table,
>> +              struct slr_entry_hdr *curr)
>> +{
>> +       struct slr_entry_hdr *next = (struct slr_entry_hdr *)
>> +                               ((u8 *)curr + curr->size);
>> +
>> +       if ((void *)next >= slr_end_of_entrys(table))
>> +               return NULL;
>> +       if (next->tag == SLR_ENTRY_END)
>> +               return NULL;
>> +
>> +       return next;
>> +}
>> +
>> +static inline struct slr_entry_hdr *
>> +slr_next_entry_by_tag(struct slr_table *table,
>> +                     struct slr_entry_hdr *entry,
>> +                     u16 tag)
>> +{
>> +       if (!entry) /* Start from the beginning */
>> +               entry = (struct slr_entry_hdr *)(((u8 *)table) + sizeof(*table));
>> +
>> +       for ( ; ; ) {
>> +               if (entry->tag == tag)
>> +                       return entry;
>> +
>> +               entry = slr_next_entry(table, entry);
>> +               if (!entry)
>> +                       return NULL;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static inline int
>> +slr_add_entry(struct slr_table *table,
>> +             struct slr_entry_hdr *entry)
>> +{
>> +       struct slr_entry_hdr *end;
>> +
>> +       if ((table->size + entry->size) > table->max_size)
>> +               return -1;
>> +
>> +       memcpy((u8 *)table + table->size - sizeof(*end), entry, entry->size);
>> +       table->size += entry->size;
>> +
>> +       end  = (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*end));
>> +       end->tag = SLR_ENTRY_END;
>> +       end->size = sizeof(*end);
>> +
>> +       return 0;
>> +}
>> +
>> +static inline void
>> +slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)
>> +{
>> +       struct slr_entry_hdr *end;
>> +
>> +       slrt->magic = SLR_TABLE_MAGIC;
>> +       slrt->revision = SLR_TABLE_REVISION;
>> +       slrt->architecture = architecture;
>> +       slrt->size = sizeof(*slrt) + sizeof(*end);
>> +       slrt->max_size = max_size;
>> +       end = (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
>> +       end->tag = SLR_ENTRY_END;
>> +       end->size = sizeof(*end);
>> +}
>> +
>> +#endif /* !__ASSEMBLY */
>> +
>> +#endif /* _LINUX_SLR_TABLE_H */
>> --
>> 2.39.3
>>


