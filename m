Return-Path: <linux-efi+bounces-3398-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFBCA956A9
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 21:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6175B3A6FB1
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 19:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920841EF0B0;
	Mon, 21 Apr 2025 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="McuPXqL4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fsYxFu3p"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB891EF08F;
	Mon, 21 Apr 2025 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745263170; cv=fail; b=Qg9Ix2wKYKJem5PjFikL+HVP3oJn6tCSBIISjvhnSQgmULWHzL+jRBegmUZKGezTWVYozVYEWDeI2AEQ0IP5RDBeVpSNBxY4rPYjUQjgphWSeegg4Njgmr7BPjPndP7+i6ni5RHmiK3VtRWse1VWEe+Xo4v0muxJSntYSlyXGhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745263170; c=relaxed/simple;
	bh=ste+xLEQ/0NEX0QlnPKdFkeOFemKUkweEUZ/zVy/dBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=isJL71lUxblKhJ0nF0Txr9bbpzr4Q8BdFnmcWGDHjgz3jHaz6u60o8CNwfWJwgMNUTgfC02Jy9YTuV1GfVNWqrCn4GW/l4WwWr8V1rGbojhJtho+aFl28tnvROgVoC++f9ull4+bMwhHpQF8ubFs6QpyzEnhE+c14wStzbYCMVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=McuPXqL4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fsYxFu3p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LFIeqE015029;
	Mon, 21 Apr 2025 19:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ut8NI/KiCFHbzwiBKG6Buzt0cyXD+lj4CiISxjJwv/8=; b=
	McuPXqL4bQ1ajULv1yO3k+/I4DATtKqw7avIIXaceyeafxxwCrvPAnxPuAdEUI+9
	hPWnYNERmNil5Q8hOtb1eS+zP3gPitTtEn+uBijSxK7hAJsbkMFBlZ9LqTK+eoNl
	L4byWqEI0SMNhbRjfVURZXQ7btzLF5XinZ2oZtrHnHYnRHqusjdmggnIveFnvRtZ
	ab6CCvFq42PC+tTuRDVJCDJWRCjNE1UcL6Ly42d0DUUcByjmOM37HxXAbY8HelAR
	qx3wwPSERJwCG2nfw+sAepCOGB5TDKbm9+YYONA6CznrAsdpSu1i2z7laAEkE7sI
	P7E6Vtwzq6eKQd0p4lnxUw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643vc352y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 19:18:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53LIIcsK010943;
	Mon, 21 Apr 2025 19:18:35 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013058.outbound.protection.outlook.com [40.93.20.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464298wy4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 19:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaFoqqWawOvdaG+uJ2M8DCgMo0QYtruudVO6cyDYtbu2epiTiSd+DsFWcBPBZ8V1hBOyqhoVTr8n1uO3KJRULoPhLOf/AtEAnOREMWvy+l2m8CvZDgd9tC89v0CTZYJiswIH++r5tQgq4KW0+DJfiq+QycSwo8GgkZnzRyBnVeRBCPmmGeVzEKyYFBi6tHbK/ro/BzaZjLy/2OLfePvTyWaCrV1Xds3zrSZJ51igbjBtdCa/Lh8/SwG3cGECM6HvxW+NLlbid9LjvlWgM3IjcpGNnsXwB8PuV2Kuhoo/CqPwe4V7JLB9PmgbRUs9o8+ydZgSbF6/k/ijbtMPJBKgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut8NI/KiCFHbzwiBKG6Buzt0cyXD+lj4CiISxjJwv/8=;
 b=L0rI7haeIeUQj3yGZ51AvBQ+WIlNX3cNS5bDdbQVUNUxcnFaJFxwUdj0DgXhalhxepN5yTK2CqUx1+CoIE/J1Ny5iHe0bYA8XBMwBTzdwiNc/LHc2u9wBLxrSKWLQ6w1GnqGelT8s+XJed3Cwmol3qJHUuv9PyppmbS30TZxpYlZHng9a4g5/pEyiOB9vDNy6JAv0IizF0F9qUkmvfKW+EPvauak/Eqo28XCxBWXduvdT3F7mZuf6m7kn9NGlwNARvUBa2UrPnVE0qC+nbJZNt6tEXOAlZKJeaOBrglXHf3ZVYkHvFd48yv+C86c3cQjU4RaCCsGYK3eadjIn/pDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut8NI/KiCFHbzwiBKG6Buzt0cyXD+lj4CiISxjJwv/8=;
 b=fsYxFu3pNHTnz05j1eQO27KTbixmujhyL3t+pSEp+p1XRlFESOe+3N4sU18famr9c5XNfzdmnBNSyICPyPrphHDaSYZ2eeHOWGblWnQkBYgsoYdSIQ7OgL0ntdYzI0nAf+5W1k8ziDZlR9zAqgKwVIJaCpVRcw++2RPCxhvGfvY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH0PR10MB5562.namprd10.prod.outlook.com (2603:10b6:510:f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 21 Apr
 2025 19:18:32 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 19:18:32 +0000
Message-ID: <66cd5c81-9797-4610-93d2-de111b36ce87@oracle.com>
Date: Tue, 22 Apr 2025 00:48:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/19] x86: Secure Launch Resource Table header file
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
 <20250421162712.77452-4-ross.philipson@oracle.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250421162712.77452-4-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::6) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH0PR10MB5562:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efedf4d-0f81-4e2d-924d-08dd81094e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0lSWU9RMXdFTkhwMm1JMFFzZHQ1U2xuNkQ5WjJEQ25LN3ZKMDFraEI0MnpO?=
 =?utf-8?B?TGRRaVlha0hRamhpeHFVNWVicWkySldnTUp1cnQxWGx5L3dSSHhPMFRTTTly?=
 =?utf-8?B?NlZLMW9GbWRzaWkvWkx3VnBxR2E5K0JWcU5pa3YwamJ2dHUrS3VYdFJ0NzR6?=
 =?utf-8?B?VEJMSk1uVTlNR1ZWQUwvL2ZGVmlMVG0yOW90d3h2R1o5dE5GVDZTNlcyTVJu?=
 =?utf-8?B?YVJaMDBIR3Y4Y0ZxQnZ4MFlVaU54NENpRDNieWpjM3dIMjZiejdGTmp1Z3Bj?=
 =?utf-8?B?SlBiVzJoMDl4Tkc4SVFHUWk5Wk8xVlAzQVc1Rm1zNUQ3dUlkcFVIREdVOWxU?=
 =?utf-8?B?SGIrQ0ZicEc4eUFkNUlwUWg2SjdINXZEWnFGbW41MzZQZUlYcGVNbC9meFlk?=
 =?utf-8?B?K01EaXZsNkxGTDVNaXdQVXE5REdCOVMrNWR6K2QxWkI3SVl3N0txYnhnTngx?=
 =?utf-8?B?N2JWM0lvYnF1UXNFcUwrVE5XZGc5Y0NlVDZNMS9mNDhvQnBxNS9mQ1A0Skpt?=
 =?utf-8?B?RzNlVUVUMng4VHhGV0RLK0ZkWjhnVFEzSTMvMlFLNFRlTWJQbHZjQVFCN2k2?=
 =?utf-8?B?dzN3TEdpL3hNRXZwb0ZuZjhVTTJYQXhLaXltTnNJNy9GRHBHU3VOQzNibk1h?=
 =?utf-8?B?QUxRMmFxTjROM1A2T2NiNWxNUEhnQ0RRbHhHWlZtTFZFTVpDQlNndy9zcG5y?=
 =?utf-8?B?WVdGTHdmdEZJS05TRU5BeFZlbDlRT0xaSGM5c1pGQnlZYjN2ZExVVVQ1dDI1?=
 =?utf-8?B?SnRZWHkxWmhDZ3FOek1QaEhjMGlBZkM1Skl3T1RDdVFWaFpEYXJGYlh2ZWRi?=
 =?utf-8?B?QlJJNFZvWCsxNkVTZVZ3UEJFVHVBUEUrTDVldWFjbUtQVmEwUlljR09LUjZU?=
 =?utf-8?B?RktFVzd2bWF4TWlYSHN6cUxjZTMrYkJLVTJYU3laUGhoVUVITWF2dEh2bnRF?=
 =?utf-8?B?dDExZW42SEFpZTJ2aHkyZXFhZFkzZW5seGU2NGtKY0V0Mnp6WGdYUWQwZWor?=
 =?utf-8?B?NC85VVFUamMzdTVlOHYwYXc1TnRURGZJU2tPU1pJMlZaQzB1NmZJYTRpalhE?=
 =?utf-8?B?M2FlY0JSaVg0bTUzNlIyS0hzMGR3REhpRVNEc245OUlXNU1rUGo2NnhrS0gx?=
 =?utf-8?B?RWNnelAxRDc4R3pmeFl0RlliM05FUWlURVpEY3pYVVFYV3dpbnREN3gzYkVl?=
 =?utf-8?B?ZVlWREZQWnJkS252SXBDZk9ENklQemU1K3dnUDNwSzAzaG8rN3lBbmJDV05Q?=
 =?utf-8?B?Vkhra25hc1NHNVBkT0R4aExBK2RwK0FOc0dUbnVHSXNlK1Q3Um43Sk1GOWZn?=
 =?utf-8?B?V200RERZU0Y5Q0tlaktVQmYyWW13Y1hvQ0RPRGdxOXNTSnE3UmdsSktUSTR4?=
 =?utf-8?B?QldLVG9mTytzeVVldlRHYjJ2TU5UQnFJQW1WSEJEdDNORlk4VkJQbjJCWi9P?=
 =?utf-8?B?WnErSE1CNG8reGRCMzhVLzJ1blkrUElSN1VOS0dFZUtlY3QwemFhUDBrQnFt?=
 =?utf-8?B?YUZQRU9UNlhpckM5TXloekJ6d2krYTRWQWFEcEFlNUlNK1JoNm5TTGtiaXFF?=
 =?utf-8?B?b1J6Zk94SEJlWjhJSktjbmlTMW1MSnliUjhlZFJTVVM4ODlYQ3VQVEtnckhX?=
 =?utf-8?B?LzByUUNIWUdITlk1c3hvSnN5dUluQU1OSUx0WkpwY1A0alErM25XZVl0djcy?=
 =?utf-8?B?bVJkSWN0alVzdmF0Mm1mR1JpeTBZUkFHRDVuMkhmSGhCR2lqd21nRm05SHpo?=
 =?utf-8?B?cHlRRnhtNHYyWmhjTEFqdVlDbWpKaWcwMk5UeWdGZDgwdDlDUU80bytlVS9y?=
 =?utf-8?B?UG00RXF5NEEyUHNkVEJ3b0IyWFlmbkpoV2hvVytvbmpnckxENDUzWHRHYWdV?=
 =?utf-8?B?Ly9Gd0JnNUpBZWI1d2Z4YlIzQW81NnV1ak5aTmIwMFVCcy85d3J3RStFb0tW?=
 =?utf-8?Q?kb/jEGRjG8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1JRQzQrZnJEb1B3dnFNU3I2endRNEo3VWNlK3dtdWt3S05acUhScG1BZ05P?=
 =?utf-8?B?c295N0h5bTlTbkZOYVNTcUdFU0ZxQXdTYU04QmVRVFJhaFUxQm5RWXpPU0U5?=
 =?utf-8?B?U1JQT3V3eFNiREYxUUpKbnp0eHVFbFJnY2FSNUtBV1o1SzZkbDRKNlkzM3hL?=
 =?utf-8?B?ZENVU01DUENsQmpoUUQzbC9JNXNIQlZpLzA0K3dBZ3RRdmQ2TVd5TUIwUElX?=
 =?utf-8?B?elJLK0JIV3NxakZ2RndTckhVSXpZZ0tmcmdiWkQ2RnZ4bzFGdzRpakxaVTVp?=
 =?utf-8?B?eWVJY0VQblFxeDJoNDE1RlNzRC85UTJsVWdDSUlWWGR5RGwwRTNNTlU0cmx0?=
 =?utf-8?B?TVdyaE40elVvaWhHTkdpdmt2N0psRXAyejBTQ0VzTzBubjluaU9QQVVJa3R6?=
 =?utf-8?B?aVFFblJ5ZDBvVkxBbkRha0o0eDA0TnAvS2FhaUN3VENnSEY1QVdRaE5VVXY4?=
 =?utf-8?B?SXAvV21mNDhyS1RQL05xdytuT0ZoS3F4UmdMOHpvUkFoeXA1VEMyUUYwMkFG?=
 =?utf-8?B?OExKaUhMQWZYdCt0U0xGcitkQy9mWGdHNVpJd2lrQmgwRTl5Q0cyRCtBMy9Q?=
 =?utf-8?B?aWphZjQ3b0Y2L3gwbnBqM2RhMzBLNTg1RkNUcWY1NjV0TWU3K0c5U2NzU0R5?=
 =?utf-8?B?R3VodzZZT1F5ck1xSWM4dzlkaFQ0UjB0V1h1UTBPV2llYTMwYzNEVDhDNVA2?=
 =?utf-8?B?Ymczdzg0V2U5ZDl3c013MVJCNnhmWVZvUUI4Uk1idkNrT1ZvcFJKNjVFNGZO?=
 =?utf-8?B?NllJdFEreUpNTDYxRmZINUh5RldXTmk0eHJNRWYzeEpFM1dOZHAyRDFXcEIx?=
 =?utf-8?B?S1NkTFB4MXdFMkhGdWlaU0pvZnU4OUVaUzNQSjYxcDhhd2xIclJLV0pMcnRI?=
 =?utf-8?B?dVRkaWxoK3JPNkVjdGZZQ0lOTXA3ckZwejRwRlFrTjF1Ynd2ZkkzOGptMThm?=
 =?utf-8?B?cHBHSUpjMTRZNEJLV0JQTW51SWFWaTJ5SlBaWEdQalQ4S3d6NVNYTFdJelVN?=
 =?utf-8?B?SFRWcXJKWGdCYlc0bEd2ZzdzQ2FOVmlZbFF3cU1QY2RTOVQyOXc2UVpudUYw?=
 =?utf-8?B?MnpqcTdqMTM3TllpTEtRa0RLbnNoMXo2ZzNncWs5WmxPR0JMS2JNekZlRUFm?=
 =?utf-8?B?YWpSK1BFQTZ2WHM0TGxvSmNhTi9pU2k0NmN1VFNTL2xxcUt2T3FnQnVSc3N1?=
 =?utf-8?B?VnF2VGpodk9KQUU0R3ViU1padHNHQ1JRZnlDakZXUzZrN2VnR0t1SXdITmpF?=
 =?utf-8?B?K0xhRGxTeWRHUU9nZVJkWWhwMGQyMDF6dmlGLzVrRDc2bVNGMmV3V3A2ZUVZ?=
 =?utf-8?B?SFRTcmd6NTZ1MVV4R0pCTHNqV3p1Tm5mRExYQ2NvWG40aUdUQTQ1VjBobUpL?=
 =?utf-8?B?ODdSb0RxVitRYmNKMHYwMEx4Q3BRbW5TQ09xUk9wdGE0cUhFTnNvMTV1d05h?=
 =?utf-8?B?SkF5ZVlQTGgza25HUUI0RzlPblVaa1Q0TGthYkdkZmFwM2dHSHdVL1IvQTNL?=
 =?utf-8?B?eDNXaFAzaDB1WnpwNXZlbXZ6NlErM2J0ODJNR3YzdjZLZHptVVhyaVJWalFG?=
 =?utf-8?B?M242emVVYTM3QWFaWnREWnlvbFdzenY5TENsZy9kS2ViTDY0N0IydTAwMmFE?=
 =?utf-8?B?WU9yeXBGS2FscUdCdU9oSTJ4MW9WSXd5MEswN0RXaS9DOTI4dUo3K29BcFNW?=
 =?utf-8?B?MlNHZWZMQ1cxdW1EbEt5MHI2RGYvNVBEMjU0VW5QMWJ6NElUb0MxNGlNYlVL?=
 =?utf-8?B?dEIwZklJN2xkY3JNT0Nja3daV3N5SUZYYkZBTnBRZUhyU0FsOHdNZ1MzSXBU?=
 =?utf-8?B?S1VkbGhPL0hMeFlQTm53cFpLbjIzaXR1RGdZNWY1V0g1TXExSXRSRUE0MVFv?=
 =?utf-8?B?TUtoNTgzcVJMNXBrdmlNU3lWbHE3WWw0Rnd0TlNyd1lmUE0vd081aExKaWNH?=
 =?utf-8?B?VHVobFd3UEpKeFdtaDlVZTlQSXo0QjgzVXQ1d3BVS2d6dmxoU3BORVdHMjJS?=
 =?utf-8?B?NGdSeWt3cGwrY3JTM2RKeGNxRjMzcGxJcm1PSVgrbkgzcmU3Q2xCNDNkZ0w1?=
 =?utf-8?B?KzIvVEpTNGJCTjMzOHRhRVdJT1JGVjZpQmFNeFJzVWl4djRaTllwUUI2akRa?=
 =?utf-8?B?bUNLaFlac0lxWHkzT3hrS2NZeXJ4YlRoTjNoUE5pT3RjekxTWDJrOEpFZUhP?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ub8jgZ75FNTnPUQFhGzrZjJ5aTHQqEMmHDpi3O3UyXmbSUpxEIpBSdin+eNJWHCbmC9n6YJ669PAjnhzFEqe2UE75YE8t6ut9zvhlYllhFh3FUevoa6r3594eu0s0QK0cJPyumRxxXRyT3d11oojbngHqoP9A9VWqGYmSupYOcTIAv0Vpg+4aOvLUWdS5Sn/Nac8aM18gKb0YSgkhws3YyFp82P9HHIvknlqwX/bSCVx13gP6JpL6vAhDwf6ZgPcQGKJBzAnOdXmzZVhpPQwbR8iag4S8xNQdhR1TlDKhp9+2Zp43tiKHfmFbKDIgPKY6k7ipWlYTrg8xfpUxqi8wioVQqUpx2gl97Q9aldYTgOgqCjY9Zd9pthL0xQ6+l3GmPyWmeGp46H5Z+Tl4ESyvitFZ7aPhMzZGANr6OV3gvsPRlsQGS+QSg/97YuPjPcWuRhUCW4DwPAOmT0fN6XERvjkVUd68gN6hT3qqSUIrQxqjfUr8+rjZqFCCKM0B+Q0W38mxczl2UCgKM09ffzGMZRQNKw/24g03XullaUxZN8j5QO4B8RsWiI9qtHblzn8cWx6bssA/cqdSDbn2tlx5KgTNb68naPZxSJY3/lqhPI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efedf4d-0f81-4e2d-924d-08dd81094e20
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 19:18:32.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsWqdfbnPoLde1kIX4Ajgu1LS+REmSpIvzideHAnTW5RxRQejvyHmfOSyopcWw93dOVUpAJXc4nJwD6TlKhavcT4w2uVXqs00W/RL693U68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_09,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210151
X-Proofpoint-GUID: JHYvLasJeOYg1NjXLtuAYY2V0Eag7Jkx
X-Proofpoint-ORIG-GUID: JHYvLasJeOYg1NjXLtuAYY2V0Eag7Jkx



On 21-04-2025 21:56, Ross Philipson wrote:
> The Secure Launch Specification is an architectural agnostic, software neutral
> API/ABI maintainted by the TrenchBoot project. It's function is to allow any

typo maintainted

> compliant boot loader to communicate the pre-launch configuration to any
> compliant post-launch kernel. This API/ABI is referred to as the Secure Launch
> Resource Table by the specification.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---

> +/*
> + * Return the next entry with the given tag in the SLRT starting at the
> + * currenty entry. If entry is NULL, the search begins at the beginning of

typo currenty

> + * table.
> + */
> +static inline void *
> +slr_next_entry_by_tag(struct slr_table *table,
> +		      struct slr_entry_hdr *entry,
> +		      u16 tag)


Thanks
Alok

