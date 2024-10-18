Return-Path: <linux-efi+bounces-2008-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F9C9A42D5
	for <lists+linux-efi@lfdr.de>; Fri, 18 Oct 2024 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEE51C24B56
	for <lists+linux-efi@lfdr.de>; Fri, 18 Oct 2024 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C13A168488;
	Fri, 18 Oct 2024 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F2xOmklw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tdJK+nRB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C61D1D0DF7;
	Fri, 18 Oct 2024 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266478; cv=fail; b=lInf64Z20NPG3aeC/Ib6+MurQ53SGl3aCYwuXJ6J6CrRXVXiDuz2HcUFwJtmDrejX12YbROqLezO+IovE7kD3X82fH24c2+wg0xtQDHYDI6lJHk0QWRnFMiYPdOTfopJvG4Cr4zW2Gp6Hro+JmD+SRy7bS9zX0dtcIWEROk8oLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266478; c=relaxed/simple;
	bh=aTMha72AdapmD4YckVgYFES+kKQZsjZCjtIXAIYm39I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=si1mllOz6/7APzb8APgda9R7zDVw/zU8KvkXrowuf5DSVr2Ql6+ybilQr2GzG3r+ozBb8ak8n0H+f0DkD05/CWjyWsLD0kuZ8WW3b+GAX6YART/HzJX9txPo1cNWArXmifJ1j9cMeoYA0SWvim6IHZrY0Eyv4x6GjTrEEAHYDG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F2xOmklw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tdJK+nRB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBhS8017277;
	Fri, 18 Oct 2024 15:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aTMha72AdapmD4YckVgYFES+kKQZsjZCjtIXAIYm39I=; b=
	F2xOmklwAScpPGFcWdNPw4WnQ+Lnsj6M4E3aoBcB1s+9gAUvu3MLXx6RpbRb/Cmf
	A8o1lnWXq8VE6fqT4uqh774MqHL9FeIpdD5Sb/npoX+gCOIwkOxBeAxMMgKoFBrc
	/s0ZxibuB4xS9pWFexZoxsM33uRuuudqcp5I8ifHhJx3Tutu/sJ6Jij77N111CCc
	Rpv4lgSuxC1lfiK2rf/kDDMq/FBlXOrs5pQOGOUeS5nTHFlrpyJri+3PVd0FHpMK
	L+DRytxLivuclkhgXm5ipaOALcHqN3W6hyIxTjJzzkZHY0F+75tAA4VQXk6YDycO
	kcTOLXdhE/jyIFD2Piqlyg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnth4bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 15:42:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IE89K4026220;
	Fri, 18 Oct 2024 15:42:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbrerd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 15:42:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gze1CZN3C3kn/tYWgAH9N0WeBMgJCeZVR06XhkkNLLR6fXDUrjwyQPFYD9B8WJKxoy3EXxPmN2f/CQQ2MRGKzZUT+qJVReLQWRYeKj7CeCRtdOLmKkngEdQoKIMK1HmrnvuhhoDTL0HqEERdK5JmX4nWXM/hDwzauq2ztWXgNtqIMxLxQM7tRO7F2q3iPc8kTr1q5dfaZI5IeC9URcnMQ+QUYcLO4965Qp8khG5Xk+5LF7VUk7ZRz5NHDdt4kzx+DCVXVLa9nQYGcSEfd81W5J6z1ND9YC5U9W6TV6akXgKncZrEjKakbRkmctDCg5sqLAaeLcXISuLgiAAuhgMwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTMha72AdapmD4YckVgYFES+kKQZsjZCjtIXAIYm39I=;
 b=FRyKloBM6X0BBbILY9KTPbE2NaA1QGJ4PT70wGWohsEZ0ygAxAtgflNlUz65DylGuDd3t8tJ0A4rFSmR+KjIZM1SWroUd6laR4Imkrgu9gynfk9+lubakm+84GGpHXU7UzyuOHkApjJ9j2slKnu9woZT098x1MSOjUJ5jkr6YFuFaMahmcu0z+958PcgmDHbZOy5vTmzYHiZkXisyBwoTXb6uUqKgVKeOxc09Nm24jSYLiWGDPosdB/L6EFj0FQTtp+MYzPwWz0DhTROUd9Y/F/0Zcmakok4lN0tCLlmBEbd5beMY2MIoACcogxphJ7ppnQE5oXYOerT+rZlImnVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTMha72AdapmD4YckVgYFES+kKQZsjZCjtIXAIYm39I=;
 b=tdJK+nRBJRJ7J7a+4OQbb6zoCpPkQ3lHiZqSh8MlB9dWVmmB+E9L5vNBstPjd38h6r+oqMJ9PjXq6De3zCEOPd5KrYFHNIJz+s7g5+RLT8NVPSIoDc/BtShiaXzobVRPz/I6abxHWoEKw5qUjsvbqrIAj8yCJCKpuUSxBtkpsdM=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by IA1PR10MB7417.namprd10.prod.outlook.com (2603:10b6:208:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 15:42:15 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Fri, 18 Oct 2024
 15:42:15 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Ben Boeckel <me@benboeckel.net>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel
	<ardb@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
	<serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu
	<roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        Stefan Berger
	<stefanb@linux.ibm.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Randy
 Dunlap <rdunlap@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH v3 05/13] clavis: Introduce a new key type called
 clavis_key_acl
Thread-Topic: [RFC PATCH v3 05/13] clavis: Introduce a new key type called
 clavis_key_acl
Thread-Index: AQHbIK0LtFdZeAa2vEyhuI80sKG05rKL+eMAgACtU4A=
Date: Fri, 18 Oct 2024 15:42:15 +0000
Message-ID: <2F718293-72DA-4E7F-99FF-690276B94F34@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-6-eric.snowberg@oracle.com>
 <ZxHwaGeDCBSp3Dzx@farprobe>
In-Reply-To: <ZxHwaGeDCBSp3Dzx@farprobe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|IA1PR10MB7417:EE_
x-ms-office365-filtering-correlation-id: d945e518-2085-4d70-d9aa-08dcef8b711e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2lqUTRuNlZGSDJqSTBVc0F2dWg1b1BGbWQ1NHlPOE9mRHpUaE1DK0o1LzlR?=
 =?utf-8?B?L2ZJeE8vd0Y2dktBN3Zqd1ZISTc3eTI1N3hOdVpheFNObUNpYkRPTUhlS3ky?=
 =?utf-8?B?MUxaR216QXNxZmR4R1hMQVhlRVFkYktkYXZ6L0hFKzIxRGFnOTdXSFl6SDNB?=
 =?utf-8?B?SjFkWGJ6YW0velRxNTBMVTd2dCtRbFN4cXNpdFRXT292T0JrZEdVc2U2eFN6?=
 =?utf-8?B?dzF0TWJFcENxc29NeGR0RWFmSlR6a1Z5RzBpQWplUFUycWdac1k2L2U1Nita?=
 =?utf-8?B?cDJPOTh2eDJDT1ZWNFFTVE15NElLZVVPWVdmVDlYMVJLTWxOOWxtcGJLaStn?=
 =?utf-8?B?OW1FSlE0OGVyaWptTWVMcHdXRG82bkZCSG1KZkFTMERpUzRZaHoyVUZoWVB1?=
 =?utf-8?B?TGVsTTMvS2ZhN3hBUTFhdHNTakg1bFc4M016S2V5bDcvaGNKancwWWZQNUlB?=
 =?utf-8?B?Mi9aUFVvS1d0YVk3YjdDZnhKeTk0VzRCMXhNeDV2b0o5cmduUCt5QXVFTTlh?=
 =?utf-8?B?Z1Z6WnVSKytsZ25KU1VrU0hqdy9VaHJGSnl2Z0JZaTEwNFFQc0hmNjVSMmtn?=
 =?utf-8?B?ekMwYUtwVlFjZmRGbzdvdk1QRTF4QVBwSGh0aENPTm1adHE2akttUEtuc0RV?=
 =?utf-8?B?anpmTlFqNUlFeE1ZWDVtV1NuUkx5b2ZjSURVUzdrbEtUaCtqazZlcVRBOVhY?=
 =?utf-8?B?Vkp2WVdwVmdIWUloc0lMcHRXVllqVkpNMkpXWE0vM01xazJiUlQ3eU1OWmZu?=
 =?utf-8?B?OVpYdDdRekx3Q0RtZkJWUDhheEhhZ210RzQwZmY0bEFpQjFxRHlQTFdpR0h0?=
 =?utf-8?B?SklIZ1ZONDVpeFV1enRjVFh0UTFWcWxHODYwNCsyYUIyWUZ4K3haZTJFTUR3?=
 =?utf-8?B?RjkrMnFtNVRSaysvR2NhZWdlLzd3Y0VmaHJZVTlRR3dtSEs1L3NncnpvVlNV?=
 =?utf-8?B?a0JzMVJoQVNrR0ZnRjlOSVp1UGplWS9LWGhyWnB6T3BWc0tVM28xT3VLRDFJ?=
 =?utf-8?B?THE5aFBIWm1EYWNibkNhMFRvS25IeUlpa2R5eG1PSFJOREVJVFFIV05kelM3?=
 =?utf-8?B?NmRVUzIrdDRFVGxCaUtLMWl1WWQwN1hFRjFMZ1kyVXIwL2dUL0wvbWgwWDkr?=
 =?utf-8?B?SkxoWGorZmlacHdpd1grOVAvK3RGMkFIcmduQzNyeXRKMXVtK1oxdTRaYVlE?=
 =?utf-8?B?SklEbTJCblAyTHdzVGJ6K3BKbEZGSm1zMzNrcUdSaXZGa0JocXBSQ0t6Y3RD?=
 =?utf-8?B?L3dsbUhEejRicDY1N1hGempUWG9RWTk2MHgvMCs5OTFFUFk5ZkdNVVFwcU1y?=
 =?utf-8?B?d0pMb1NNbG1iOWoyM0wzY2gwWjI3QTRmblFUTUZ2TkNibG5VVlRTL0FaME1Y?=
 =?utf-8?B?TGZvdjFKbHJaYW11V1ZQdmVnRTVUdkE5NjhnMmVXU3kwRVdQYzBsaU1nRGI0?=
 =?utf-8?B?RUJWQVdCZ0JKdUd4cEFsU1p6b2h6Y3F4MnpsdzdFajRVZm5YWE5McUQ1eU1Z?=
 =?utf-8?B?QUVkcVNnS3Naa0NqeDl4U09TOW9WNmgyUSt3SHIycnp0WktVd2dlaWY3K2p2?=
 =?utf-8?B?VGRtcGtTR3hSQ0VGdjRaQWF4bmpIMGUxSHZFdDI1RGZEVy9kQUpxQ0NlbDk5?=
 =?utf-8?B?L2JCKzFhb2xZQ0dBRlZGWGEwdWEvZDBTY2tVTi9lTGNuaXVBd053bnQ5ZXdK?=
 =?utf-8?B?cDNEdDcxdnkycXZNcjF3cHVQK3dNQys4N3FoNm82NEM5VzFtKy8remtwV3cy?=
 =?utf-8?B?Ynk0N3RnWWJGaTYxbVFwK3JWYi9rVFk5Qll6Z0w3RW5rMEVySnpuaDFrUTdi?=
 =?utf-8?Q?0XiH8JHuMt9gaTjZVG6uPO7IPaFIjtv5ny164=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDl0cVNKZy9PckFNVmR6ZldFZEc2SFhvdFhDYko1bE50cW9aNG16ak5GM2dt?=
 =?utf-8?B?eS9kZm5RbmkwT2NweXcrMjBvMGxhMHFqUUtOaENhRjlOQlJpa2E1OE95NUx6?=
 =?utf-8?B?UHJneEMzUWsrQ01ubmpaZXJYUGVnRVN4cGVTb25iQXMzMlZ0MDh1UnR0aHNH?=
 =?utf-8?B?TlZtb3d3NVRZT2lZL0RjdzVGZ1hoVXpuZk9rNHl4aVpFWWhVOTFhVHJrb2or?=
 =?utf-8?B?bUVIVlBDUzJoUEVaWDNSaHdZQmRYNkdaVi9BU2tONng4M3RrRStEN0o1Yk1q?=
 =?utf-8?B?MDRCMHkrR0NqVWFyNFV1VHhUOHJPc0xCbkc1UGxSb1U3TGZHOUYyZ1B6S3E5?=
 =?utf-8?B?enY4UTBCUU52bkZHM3B2WjVaMmR0YmJ4QnJKd21Mb2lPd0syMTM2di9sTmNp?=
 =?utf-8?B?WGJ4SHdXenJmb3dHWEJuYkFxTUlQUUd0SVZydlRWTmVGS0F4Q1JxcFBIMVBK?=
 =?utf-8?B?Q0Ryc0ZrMXNBcVFkQWFiMHkvTlUxSTNTMEVxS2hPV0FHejhDYjR5Q3IyMzBk?=
 =?utf-8?B?OFJmMEg1Y0p6Q3NJYjNmMUZBVC9ZWllxcmZxNHZFb3k0V1BjNEhnMzVIaW1Z?=
 =?utf-8?B?Vm5QTVZkT3ZIMnNSZjJRUWQrQjRCaWs2aWYzbVEyb3lITDVoYVNMRjZrWWZ1?=
 =?utf-8?B?cDFLYU5rV2JWdG5GZ1V2UC9BYkFKTms2d2tVTFJ5Z2hrRUo2ODdhUWVwc2JV?=
 =?utf-8?B?QSs4dE1wVHFPU0JSZklZS0FuSUFDVWZxU3FNTXRRRFhNQ1A5OU4xT1FjZkRP?=
 =?utf-8?B?Zk9uQzlrRDlldzFhcFBKand5MU1qZGNrUGNYaG16UTFHSTlCVkNFdVpNRzdm?=
 =?utf-8?B?Q3JTVTR5OWhFZVhMVmZCanQ1MTBybm51MFE5bElINENOZFNteFMzMGEvVzR1?=
 =?utf-8?B?dVhXaWpvMXNvYXQzVHJuRUJ5T2g2VG9SZFJxLzFRZnhsVU5mT01tb0xteFZB?=
 =?utf-8?B?cmQ0Wm5wajM1NVdTRnJIWkdzMmsycmFGYThzMFMzRElzRWJJczI4UnBFOEkx?=
 =?utf-8?B?QzQveDhUM3VwS29YbTh4UjRvZTAyVGJwNTJ5TTlNY1MzMXU1NkpBUjVzWFBQ?=
 =?utf-8?B?M1VDcVFaVGsrZ2IzendJaEpqVjdYNE1PU2I3VlVPR0E5Yi92M1RoelU5Tm5Z?=
 =?utf-8?B?VXlKRmFuVjBxWHJQU0tkZHRFZzl1UVFzT2NqcTNDZUFDZTBpZVhtZ3N0UlBq?=
 =?utf-8?B?eTV4S1o3Wk5vUnhPSXhnc1lVQzEvQkhZajlQWlNmYjFXQmk2S1EwbUxQZVFz?=
 =?utf-8?B?K2xqNzN6eHN0Y3k2Um9aWjNpQjNLbmRSZXVPeGtka05iOUE3R3pkeC94ZWNO?=
 =?utf-8?B?MkNBNzl1Y1ViY0dKNWgvR1FqWXAzMXQwUCs5UVY5N0h3N0lxRUxrRWZzQnBW?=
 =?utf-8?B?RW1kT1FJS3dza2t4bXR3dzM1MFhENFNJRTZ4TjAxM3RmTnpjM2YyOVBNNE43?=
 =?utf-8?B?b2paQ2Y0VUVBMXZmb3pFVFk4QSt6UStteWVwVFZISWNZdlNlN1lSbDB2Q05Z?=
 =?utf-8?B?VEswTm4wOXRGekJKdHZqczM3NmZuN2JtSVlXQW1HWkMrcmJ4SkJxTzlmWFVo?=
 =?utf-8?B?T3BoYzJuRTBaVS9hak50eWszc3lVSFFWaTFPcklFNmRITlZkZ09NRFZySyts?=
 =?utf-8?B?U0tIQjJ0bm55K1dtREVadVdEUWw3dWtXdHZWQ3hSZTFYVnBWTVJhMjJ4amFY?=
 =?utf-8?B?UldzRUZkNlRnSjIxQXVWc21MUUV6bkV1d2VqYTZodVVXTnNZTHBHR3RUbkF3?=
 =?utf-8?B?V1hlWWFyZHJYOWhqQXVEVFFnYXFRMFUxNHZZd3gyZGNiV0wzdUdjSWNYZFc5?=
 =?utf-8?B?Y3ZCYmJyQVh4ZXkzUnVqVnZoZzh4R2ZibFNDUHpvWU5tUUZlcERVam9RV2dr?=
 =?utf-8?B?eWlaSWFhdkE3Yzl4NVNIeEp6ZGc0bGIxYWM4UytVYUV0bDdLMzlNNDEwVkNO?=
 =?utf-8?B?d3RCc1k1cisyN2kxbkJSVUVJekwvMnJtZkFIbmxkbVY1QWcrNGpXRXBOOVR2?=
 =?utf-8?B?K0plODVFRU1OcHFoWXZpckF4VGF1UmlQMG01TC83cTJRZ1ArYWNKY0xXS0Zi?=
 =?utf-8?B?N0YwdXZRczNkbkhvZkhQRkViOWMrNFRURmttZDU5WWFSOTJJMzhtR0VPdXhy?=
 =?utf-8?B?YVZJWmlacVdvb3BHcjhTUllxZkgzWGRVWm8yRmpZWDVsRzdVRmVZT0lHaUhn?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00AC2BB00D5FF542A74124BF17A11192@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	23X18EPoAgvAkfh2nRDZDui6A8D/0lwLwsoMMBpM/BdzEnWxU8P40ny1rjFBbxMMs9uFtNsFqlA7Rq/6sCbfItgQt4xSbDx5OmAzzqUO2p2AHU7GdYi4DHW5jJGbR0cGBV4rrljHXzjpBbpBFMt0WxoP9TRlifIHGjNsSsUOGX9fGgIATObghyUgZPRa2d/23Hzw6/8zz61R90zLIUsOwDfcG07ZKrzWpSObyrDQrtn8AEDHlyvpV3JOjT9rLImZBTq6GYsDR4BA/g6UdkKf1AuzE8lFitoXqfv6QUJ73ggyX0X8YtFgsB62Fbwwb7YPP8ViITWgyiS0v9+tStSkJnuNcnAYuP+OxZEyKXVaFjXTKJRYPiqw+yVFpu3vv5SekBal2d0ENGG1mBvl7usNuY7Ah8ouVOBlDB6oTVLiSP9rv/UD8rSzM/SzBvwM7Po5iu1jo2TT1feQe+ttNja/iLXgLLC0OKvzWHZNpdtfDi403m8bf7TrGVgQca1TI5wyzb7OFC9JhhofRbpo1FY/39sFX96sNzEj3Q548QfjE91TPg2FAdxosQs+W97lQB2RpuS3QMX+NkBuPXyKhFhcj5xvUkIr4mD9wSXPrcdbvxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d945e518-2085-4d70-d9aa-08dcef8b711e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 15:42:15.6991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFxETOKf27k1TcRcROn/Fk9EPwtOkGXNV9q3lv4EFpLoAuelw66P/Ij4xgNA7EnifmrlTw2ohwBlteYr0qUDVwU5LUPM2peYor6aIx60kPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_11,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180100
X-Proofpoint-ORIG-GUID: MUZRo93_-HPJaa3UxRazDSmEGYyw_Pq8
X-Proofpoint-GUID: MUZRo93_-HPJaa3UxRazDSmEGYyw_Pq8

DQoNCj4gT24gT2N0IDE3LCAyMDI0LCBhdCAxMToyMeKAr1BNLCBCZW4gQm9lY2tlbCA8bWVAYmVu
Ym9lY2tlbC5uZXQ+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBPY3QgMTcsIDIwMjQgYXQgMDk6NTU6
MDggLTA2MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBJbnRyb2R1Y2UgYSBuZXcga2V5IHR5
cGUgZm9yIGtleXJpbmcgYWNjZXNzIGNvbnRyb2wuICBUaGUgbmV3IGtleSB0eXBlDQo+PiBpcyBj
YWxsZWQgY2xhdmlzX2tleV9hY2wuICBUaGUgY2xhdmlzX2tleV9hY2wgY29udGFpbnMgdGhlIHN1
YmplY3Qga2V5DQo+PiBpZGVudGlmaWVyIGFsb25nIHdpdGggdGhlIGFsbG93ZWQgdXNhZ2UgdHlw
ZSBmb3IgdGhlIGtleS4NCj4+IA0KPj4gVGhlIGZvcm1hdCBpcyBhcyBmb2xsb3dzOg0KPj4gDQo+
PiBYWDpZWVlZWVlZWVlZWQ0KPj4gDQo+PiBYWCAtIFNpbmdsZSBieXRlIG9mIHRoZSBrZXkgdHlw
ZQ0KPj4gVkVSSUZZSU5HX01PRFVMRV9TSUdOQVRVUkUgICAgICAgICAgICAwMA0KPj4gVkVSSUZZ
SU5HX0ZJUk1XQVJFX1NJR05BVFVSRSAgICAgICAgICAwMQ0KPj4gVkVSSUZZSU5HX0tFWEVDX1BF
X1NJR05BVFVSRSAgICAgICAgICAwMg0KPj4gVkVSSUZZSU5HX0tFWV9TSUdOQVRVUkUgICAgICAg
ICAgICAgICAwMw0KPj4gVkVSSUZZSU5HX0tFWV9TRUxGX1NJR05BVFVSRSAgICAgICAgICAwNA0K
Pj4gVkVSSUZZSU5HX1VOU1BFQ0lGSUVEX1NJR05BVFVSRSAgICAgICAwNQ0KPj4gOiAgLSBBU0NJ
SSBjb2xvbg0KPj4gWVkgLSBFdmVuIG51bWJlciBvZiBoZXhhZGVjaW1hbCBjaGFyYWN0ZXJzIHJl
cHJlc2VudGluZyB0aGUga2V5IGlkDQo+IA0KPiBUaGlzIGlzIGV4cGVjdGVkIHRvIGJlICpsb3dl
cmNhc2UqIGhleGFkZWNpbWFsIGNoYXJhY3RlcnMgaW4gdGhlIGNvZGU7DQo+IGNhbiB0aGF0IHJl
c3RyaWN0aW9uIHBsZWFzZSBiZSBkb2N1bWVudGVkPyAoQ29taW5nIGJhY2sgaGVyZSwgdGhlcmUg
aXMgYQ0KPiBgdG9sb3dlcmAgcGFzcyBwZXJmb3JtZWQgd2hlbiBjb3B5aW5nIGZyb20gdXNlcnNw
YWNlLCBzbyB0aGlzIHNlZW1zIHRvDQo+IGJlIGFuIGludGVybmFsIHJlcXVpcmVtZW50LCBub3Qg
dXNlcnNwYWNlLg0KDQpDb3JyZWN0DQoNCj4gTWlnaHQgYmUgd29ydGggZG9jdW1lbnRpbmcNCj4g
c29tZXdoZXJlIGluIGNhc2UgdGhlIGtlcm5lbCB3YW50cyB0byBtYWtlIHN1Y2ggYSBrZXkgaW50
ZXJuYWxseS4pDQo+IA0KPiBJIGFsc28gc2VlIGEgMzItYnl0ZSAoNjQgaGV4IGNoYXJhY3RlcnMp
IGxpbWl0IGluIHRoZSBjb2RlOyB0aGF0IHNob3VsZA0KPiBhbHNvIGJlIGRvY3VtZW50ZWQgc29t
ZXdoZXJlLg0KDQpJIGRpZG4ndCB3YW50IHRvIGJ1cmRlbiB0aGUgZW5kLXVzZXIgd2l0aCBnZXR0
aW5nIGV2ZXJ5dGhpbmcgaW4NCmxvd2VyY2FzZSwgc2luY2UgT3BlblNTTCB0eXBpY2FsbHkgcmV0
dXJucyB0aGUgcmVzdWx0IGluIHVwcGVyY2FzZS4gDQpJIHdpbGwgYWRkIHNvbWUgY29tbWVudHMg
YXMgeW91IHN1Z2dlc3RlZCBpbmNhc2UgdGhlIGtlcm5lbCANCndhbnRzIHRvIG1ha2Ugc3VjaCBh
IGtleSBpbnRlcm5hbGx5Lg0KDQo+PiBUaGlzIGtleSB0eXBlIHdpbGwgYmUgdXNlZCBpbiB0aGUg
Y2xhdmlzIGtleXJpbmcgZm9yIGFjY2VzcyBjb250cm9sLiBUbw0KPj4gYmUgYWRkZWQgdG8gdGhl
IGNsYXZpcyBrZXlyaW5nLCB0aGUgY2xhdmlzX2tleV9hY2wgbXVzdCBiZSBTL01JTUUgc2lnbmVk
DQo+PiBieSB0aGUgc29sZSBhc3ltbWV0cmljIGtleSBjb250YWluZWQgd2l0aGluIGl0Lg0KPj4g
DQo+PiBCZWxvdyBpcyBhbiBleGFtcGxlIG9mIGhvdyB0aGlzIGNvdWxkIGJlIHVzZWQuIFdpdGhp
biB0aGUgZXhhbXBsZSwgdGhlDQo+PiBrZXkgKGIzNjBkMTEzYzg0OGFjZTNmMWU2YTgwMDYwYjQz
ZDEyMDZmMDQ4N2QpIGlzIGFscmVhZHkgaW4gdGhlIG1hY2hpbmUNCj4+IGtleXJpbmcuIFRoZSBp
bnRlbmRlZCB1c2FnZSBmb3IgdGhpcyBrZXkgaXMgdG8gdmFsaWRhdGUgYSBzaWduZWQga2VybmVs
DQo+PiBmb3Iga2V4ZWM6DQo+PiANCj4+IGVjaG8gIjAyOmIzNjBkMTEzYzg0OGFjZTNmMWU2YTgw
MDYwYjQzZDEyMDZmMDQ4N2QiID4ga2VybmVsLWFjbC50eHQNCj4+IA0KPj4gVGhlIG5leHQgc3Rl
cCBpcyB0byBzaWduIGl0Og0KPj4gDQo+PiBvcGVuc3NsIHNtaW1lIC1zaWduIC1zaWduZXIgY2xh
dmlzLWxzbS54NTA5IC1pbmtleSBjbGF2aXMtbHNtLnByaXYgLWluIFwNCj4+IGtlcm5lbC1hY2wu
dHh0ICAtb3V0IGtlcm5lbC1hY2wucGtjczcgLWJpbmFyeSAtb3V0Zm9ybSBERVIgXA0KPj4gLW5v
ZGV0YWNoIC1ub2F0dHINCj4+IA0KPj4gVGhlIGZpbmFsIHN0ZXAgaXMgaG93IHRvIGFkZCB0aGUg
YWNsIHRvIHRoZSAuY2xhdmlzIGtleXJpbmc6DQo+PiANCj4+IGtleWN0bCBwYWRkIGNsYXZpc19r
ZXlfYWNsICIiICU6LmNsYXZpcyA8IGtlcm5lbC1hY2wucGtjczcNCj4+IA0KPj4gQWZ0ZXJ3YXJk
cyB0aGUgbmV3IGNsYXZpc19rZXlfYWNsIGNhbiBiZSBzZWVuIGluIHRoZSAuY2xhdmlzIGtleXJp
bmc6DQo+PiANCj4+IGtleWN0bCBzaG93ICU6LmNsYXZpcw0KPj4gS2V5cmluZw0KPj4gIGtleXJp
bmc6IC5jbGF2aXMNCj4+ICAgXF8gYXN5bW1ldHJpYzogQ2xhdmlzIExTTSBrZXk6IDRhMDBhYjlm
MzVjOWRjM2FlZDdjMjI1ZDIyYmFmY2JkOTI4NWUxZTgNCj4+ICAgXF8gY2xhdmlzX2tleV9hY2w6
IDAyOmIzNjBkMTEzYzg0OGFjZTNmMWU2YTgwMDYwYjQzZDEyMDZmMDQ4N2QNCj4gDQo+IENhbiB0
aGlzIGJlIGNvbW1pdHRlZCB0byBgRG9jdW1lbnRhdGlvbi9gIGFuZCBub3QganVzdCB0aGUgR2l0
IGhpc3RvcnkNCj4gcGxlYXNlPw0KDQpUaGlzIGlzIGRvY3VtZW50ZWQsIGJ1dCBpdCBkb2Vzbid0
IGNvbWUgaW4gdW50aWwgdGhlIDh0aCBwYXRjaCBpbiB0aGUgc2VyaWVzLiANCkhvcGVmdWxseSB0
aGF0IGlzIG5vdCBhbiBpc3N1ZS4NCg0KPiBDb2RlIGNvbW1lbnRzIGlubGluZSBiZWxvdy4NCj4g
DQo+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIFNub3diZXJnIDxlcmljLnNub3diZXJnQG9yYWNsZS5j
b20+DQo+PiAtLS0NCj4+IHNlY3VyaXR5L2NsYXZpcy9jbGF2aXMuaCAgICAgICAgIHwgICAxICsN
Cj4+IHNlY3VyaXR5L2NsYXZpcy9jbGF2aXNfa2V5cmluZy5jIHwgMTczICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4+IDIgZmlsZXMgY2hhbmdlZCwgMTc0IGluc2VydGlvbnMoKykN
Cj4+IA0KPj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2NsYXZpcy9jbGF2aXMuaCBiL3NlY3VyaXR5
L2NsYXZpcy9jbGF2aXMuaA0KPj4gaW5kZXggNWUzOTdiNTVhNjBhLi43YjU1YTYwNTA0NDAgMTAw
NjQ0DQo+PiAtLS0gYS9zZWN1cml0eS9jbGF2aXMvY2xhdmlzLmgNCj4+ICsrKyBiL3NlY3VyaXR5
L2NsYXZpcy9jbGF2aXMuaA0KPj4gQEAgLTUsNiArNSw3IEBADQo+PiANCj4+IC8qIE1heCBsZW5n
dGggZm9yIHRoZSBhc3ltbWV0cmljIGtleSBpZCBjb250YWluZWQgb24gdGhlIGJvb3QgcGFyYW0g
Ki8NCj4+ICNkZWZpbmUgQ0xBVklTX0JJTl9LSURfTUFYICAgMzINCj4+ICsjZGVmaW5lIENMQVZJ
U19BU0NJSV9LSURfTUFYIDY0DQo+PiANCj4+IHN0cnVjdCBhc3ltbWV0cmljX3NldHVwX2tpZCB7
DQo+PiBzdHJ1Y3QgYXN5bW1ldHJpY19rZXlfaWQgaWQ7DQo+PiBkaWZmIC0tZ2l0IGEvc2VjdXJp
dHkvY2xhdmlzL2NsYXZpc19rZXlyaW5nLmMgYi9zZWN1cml0eS9jbGF2aXMvY2xhdmlzX2tleXJp
bmcuYw0KPj4gaW5kZXggNDAwZWQ0NTVhM2EyLi4wMDE2M2U3ZjBmZTkgMTAwNjQ0DQo+PiAtLS0g
YS9zZWN1cml0eS9jbGF2aXMvY2xhdmlzX2tleXJpbmcuYw0KPj4gKysrIGIvc2VjdXJpdHkvY2xh
dmlzL2NsYXZpc19rZXlyaW5nLmMNCj4+IEBAIC0yLDggKzIsMTIgQEANCj4+IA0KPj4gI2luY2x1
ZGUgPGxpbnV4L3NlY3VyaXR5Lmg+DQo+PiAjaW5jbHVkZSA8bGludXgvaW50ZWdyaXR5Lmg+DQo+
PiArI2luY2x1ZGUgPGxpbnV4L2N0eXBlLmg+DQo+PiAjaW5jbHVkZSA8a2V5cy9hc3ltbWV0cmlj
LXR5cGUuaD4NCj4+ICsjaW5jbHVkZSA8a2V5cy9hc3ltbWV0cmljLXN1YnR5cGUuaD4NCj4+ICNp
bmNsdWRlIDxrZXlzL3N5c3RlbV9rZXlyaW5nLmg+DQo+PiArI2luY2x1ZGUgPGtleXMvdXNlci10
eXBlLmg+DQo+PiArI2luY2x1ZGUgPGNyeXB0by9wa2NzNy5oPg0KPj4gI2luY2x1ZGUgImNsYXZp
cy5oIg0KPj4gDQo+PiBzdGF0aWMgc3RydWN0IGtleSAqY2xhdmlzX2tleXJpbmc7DQo+PiBAQCAt
MTEsMTAgKzE1LDE3MyBAQCBzdGF0aWMgc3RydWN0IGFzeW1tZXRyaWNfa2V5X2lkICpjbGF2aXNf
Ym9vdF9ha2lkOw0KPj4gc3RhdGljIHN0cnVjdCBhc3ltbWV0cmljX3NldHVwX2tpZCBjbGF2aXNf
c2V0dXBfYWtpZDsNCj4+IHN0YXRpYyBib29sIGNsYXZpc19lbmZvcmNlZDsNCj4+IA0KPj4gK3N0
YXRpYyBpbnQgcGtjczdfcHJlcGFyc2VfY29udGVudCh2b2lkICpjdHgsIGNvbnN0IHZvaWQgKmRh
dGEsIHNpemVfdCBsZW4sIHNpemVfdCBhc24xaGRybGVuKQ0KPj4gK3sNCj4+ICsgc3RydWN0IGtl
eV9wcmVwYXJzZWRfcGF5bG9hZCAqcHJlcCA9IGN0eDsNCj4+ICsgY29uc3Qgdm9pZCAqc2F2ZWRf
cHJlcF9kYXRhOw0KPj4gKyBzaXplX3Qgc2F2ZWRfcHJlcF9kYXRhbGVuOw0KPj4gKyBjaGFyICpk
ZXNjOw0KPj4gKyBpbnQgcmV0LCBpOw0KPj4gKw0KPj4gKyAvKiBrZXlfYWNsX2ZyZWVfcHJlcGFy
c2Ugd2lsbCBmcmVlIHRoaXMgKi8NCj4+ICsgZGVzYyA9IGttZW1kdXAoZGF0YSwgbGVuLCBHRlBf
S0VSTkVMKTsNCj4+ICsgaWYgKCFkZXNjKQ0KPj4gKyByZXR1cm4gLUVOT01FTTsNCj4+ICsNCj4+
ICsgLyogQ29weSB0aGUgdXNlciBzdXBwbGllZCBjb250ZW50cyBhbmQgcmVtb3ZlIGFueSB3aGl0
ZSBzcGFjZS4gKi8NCj4+ICsgZm9yIChpID0gMDsgaSA8IGxlbjsgaSsrKSB7DQo+PiArIGRlc2Nb
aV0gPSB0b2xvd2VyKGRlc2NbaV0pOw0KPiANCj4gQWgsIGxvb2tpbmcgaGVyZSBpdCBzZWVtcyB0
aGF0IHVzZXJzcGFjZSBjYW4gcHJvdmlkZSB1cHBlciBvciBsb3dlcmNhc2UuDQo+IFRIYXQgdGhp
cyBpcyBiZWluZyBwZXJmb3JtZWQgc2hvdWxkIGJlIGFkZGVkIHRvIHRoZSBjb21tZW50IGhlcmUu
DQoNCkknbGwgdXBkYXRlIHRoZSBjb21tZW50Lg0KDQo+IA0KPj4gKyBpZiAoaXNzcGFjZShkZXNj
W2ldKSkNCj4+ICsgZGVzY1tpXSA9IDA7DQo+IA0KPiBIb3cgaXMgc2V0dGluZyBhIHNwYWNlIHRv
IGAwYCAqcmVtb3ZpbmcqIGl0PyBTdXJlbHkgdGhlIGBpc3hkaWdpdGAgY2hlY2sNCj4gaW50ZXJu
YWxseSBpcyBnb2luZyB0byByZWplY3QgdGhpcy4gUGVyaGFwcyB5b3UgbWVhbnQgdG8gaGF2ZSB0
d28NCj4gaW5kaWNlcyBpbnRvIGBkZXNjYCwgb25lIHJlYWQgYW5kIG9uZSB3cml0ZSBhbmQgdG8g
c3RhbGwgdGhlIHdyaXRlIGluZGV4DQo+IGFzIGxvbmcgYXMgd2UncmUgcmVhZGluZyB3aGl0ZXNw
YWNlPw0KPiANCj4gQWxzbywgdGhhdCB3aGl0ZXNwYWNlIGlzIHN0cmlwcGVkIGlzIGEgdXNlcnNw
YWNlLXJlbGV2YW50IGRldGFpbCB0aGF0DQo+IHNob3VsZCBiZSBkb2N1bWVudGVkLg0KDQpUaGlz
IHdhcyBkb25lIGluY2FzZSB0aGUgZW5kLXVzZXIgaGFzIGEgdHJhaWxpbmcgY2FycmlhZ2UgcmV0
dXJuIGF0IHRoZQ0KZW5kIG9mIHRoZWlyIEFDTC4gSSBoYXZlIHVwZGF0ZWQgdGhlIGNvbW1lbnQg
YXMgZm9sbG93czoNCg0KKyAgICAgICAvKg0KKyAgICAgICAgKiBDb3B5IHRoZSB1c2VyIHN1cHBs
aWVkIGNvbnRlbnRzLCBpZiB1cHBlcmNhc2UgaXMgdXNlZCwgY29udmVydCBpdCB0bw0KKyAgICAg
ICAgKiBsb3dlcmNhc2UuICBBbHNvIGlmIHRoZSBlbmQgb2YgdGhlIEFDTCBjb250YWlucyBhbnkg
d2hpdGVzcGFjZSwgc3RyaXANCisgICAgICAgICogaXQgb3V0Lg0KKyAgICAgICAgKi8NCg0KPiAN
Cj4+ICtzdGF0aWMgdm9pZCBrZXlfYWNsX2Rlc3Ryb3koc3RydWN0IGtleSAqa2V5KQ0KPj4gK3sN
Cj4+ICsgLyogSXQgc2hvdWxkIG5vdCBiZSBwb3NzaWJsZSB0byBnZXQgaGVyZSAqLw0KPj4gKyBw
cl9pbmZvKCJkZXN0cm95IGNsYXZpc19rZXlfYWNsIGRlbmllZFxuIik7DQo+PiArfQ0KPj4gKw0K
Pj4gK3N0YXRpYyB2b2lkIGtleV9hY2xfcmV2b2tlKHN0cnVjdCBrZXkgKmtleSkNCj4+ICt7DQo+
PiArIC8qIEl0IHNob3VsZCBub3QgYmUgcG9zc2libGUgdG8gZ2V0IGhlcmUgKi8NCj4+ICsgcHJf
aW5mbygicmV2b2tlIGNsYXZpc19rZXlfYWNsIGRlbmllZFxuIik7DQo+PiArfQ0KPiANCj4gVGhl
c2Uga2V5cyBjYW5ub3QgYmUgZGVzdHJveWVkIG9yIHJldm9rZWQ/IFRoaXMgc2VlbXPigKZub3Zl
bCB0byBtZS4gV2hhdA0KPiBpZiB0aGVyZSdzIGEgdGltZW91dCBvbiB0aGUga2V5PyBJZiBzdWNo
IGtleXMgYXJlIGltbW9ydGFsLCB0aW1lb3V0cw0KPiBzaG91bGQgYWxzbyBiZSByZWZ1c2VkPw0K
DQpBbGwgdGhlIHN5c3RlbSBrZXJuZWwga2V5cmluZ3Mgd29yayB0aGlzIHdheS4gQnV0IG5vdyB0
aGF0IHlvdSBicmluZyB0aGlzIHVwLCBuZWl0aGVyIG9mDQp0aGVzZSBmdW5jdGlvbnMgYXJlIHJl
YWxseSBuZWNlc3NhcnksIHNvIEkgd2lsbCByZW1vdmUgdGhlbSBpbiB0aGUgbmV4dCByb3VuZC4N
Cg0KPj4gK3N0YXRpYyBpbnQga2V5X2FjbF92ZXRfZGVzY3JpcHRpb24oY29uc3QgY2hhciAqZGVz
YykNCj4+ICt7DQo+PiArIGludCBpLCBkZXNjX2xlbjsNCj4+ICsgczE2IGt0eXBlOw0KPj4gKw0K
Pj4gKyBpZiAoIWRlc2MpDQo+PiArIGdvdG8gaW52YWxpZDsNCj4+ICsNCj4+ICsgZGVzY19sZW4g
PSBzaXplb2YoZGVzYyk7DQo+IA0KPiBUaGlzIHNob3VsZCBiZSBgc3RybGVuYCwgbm8/DQoNCkkg
d2lsbCBjaGFuZ2UgdGhpcyB0byBzdHJsZW4NCg0KPj4gKyAvKg0KPj4gKyAqIGNsYXZpc19hY2wg
Zm9ybWF0Og0KPj4gKyAqICAgIHh4Onl5eXkuLi4NCj4+ICsgKg0KPj4gKyAqICAgIHh4ICAgICAt
IFNpbmdsZSBieXRlIG9mIHRoZSBrZXkgdHlwZQ0KPj4gKyAqICAgIDogICAgICAtIEFzY2lpIGNv
bG9uDQo+PiArICogICAgeXl5eS4uIC0gRXZlbiBudW1iZXIgb2YgaGV4YWRlY2ltYWwgY2hhcmFj
dGVycyByZXByZXNlbnRpbmcgdGhlIGtleWlkDQo+PiArICovDQo+PiArDQo+PiArIC8qIFRoZSBt
aW4gY2xhdmlzIGFjbCBpcyA3IGNoYXJhY3RlcnMuICovDQo+PiArIGlmIChkZXNjX2xlbiA8IDcp
DQo+PiArIGdvdG8gaW52YWxpZDsNCj4+ICsNCj4+ICsgLyogQ2hlY2sgdGhlIGZpcnN0IGJ5dGUg
aXMgYSB2YWxpZCBrZXkgdHlwZS4gKi8NCj4+ICsgaWYgKHNzY2FuZihkZXNjLCAiJTJoeCIsICZr
dHlwZSkgIT0gMSkNCj4+ICsgZ290byBpbnZhbGlkOw0KPj4gKw0KPj4gKyBpZiAoa3R5cGUgPj0g
VkVSSUZZSU5HX0NMQVZJU19TSUdOQVRVUkUpDQo+PiArIGdvdG8gaW52YWxpZDsNCj4+ICsNCj4+
ICsgLyogQ2hlY2sgdGhhdCB0aGVyZSBpcyBhIGNvbG9uIGZvbGxvd2luZyB0aGUga2V5IHR5cGUg
Ki8NCj4+ICsgaWYgKGRlc2NbMl0gIT0gJzonKQ0KPj4gKyBnb3RvIGludmFsaWQ7DQo+PiArDQo+
PiArIC8qIE1vdmUgcGFzdCB0aGUgY29sb24uICovDQo+PiArIGRlc2MgKz0gMzsNCj4+ICsNCj4+
ICsgZm9yIChpID0gMDsgKmRlc2MgJiYgaSA8IENMQVZJU19BU0NJSV9LSURfTUFYOyBkZXNjKyss
IGkrKykgew0KPj4gKyAvKiBDaGVjayBpZiBsb3dlcmNhc2UgaGV4IG51bWJlciAqLw0KPj4gKyBp
ZiAoIWlzeGRpZ2l0KCpkZXNjKSB8fCBpc3VwcGVyKCpkZXNjKSkNCj4+ICsgZ290byBpbnZhbGlk
Ow0KPj4gKyB9DQo+PiArDQo+PiArIC8qIENoZWNrIGlmIHRoZSBoYXMgaXMgZ3JlYXRlciB0aGFu
IENMQVZJU19BU0NJSV9LSURfTUFYLiAqLw0KPj4gKyBpZiAoKmRlc2MpDQo+PiArIGdvdG8gaW52
YWxpZDsNCj4+ICsNCj4+ICsgLyogQ2hlY2sgZm9yIGV2ZW4gbnVtYmVyIG9mIGhleCBjaGFyYWN0
ZXJzLiAqLw0KPj4gKyBpZiAoaSA9PSAwIHx8IGkgJiAxKQ0KPiANCj4gRldJVzwgdGhlIGBpID09
IDBgIGlzIGltcG9zc2libGUgZHVlIHRvIHRoZSBgZGVzY19sZW4gPCA3YCBjaGVjayBhYm92ZQ0K
PiAod2VsbCwgb25jZSBgc3RybGVuYCBpcyB1c2Vk4oCmKS4NCg0KYW5kIHJlbW92ZSB0aGUgdW5u
ZWNlc3NhcnkgY2hlY2suICBUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQo=

