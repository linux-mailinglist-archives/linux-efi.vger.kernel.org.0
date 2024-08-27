Return-Path: <linux-efi+bounces-1609-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B70961551
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 19:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47DB1F245CA
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9BD1CE703;
	Tue, 27 Aug 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fN6k1dKH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O+y38tS1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6DC1925AC;
	Tue, 27 Aug 2024 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779236; cv=fail; b=odmNJfePaiOyNZDHdQ4nXtbeFHztW4vTZIIXoOUHAGy8F+gnuop29jIOuBW8hdbWnkK8j90Wz4OLT6Atb87zGSz/9am/0YsB+fyvIa4CZj+92SD95M3FGJrRgM57M7aJOpD4wtDI2sIB9x6sYrH+LQwXWPNS53SU3Ow8+id8RJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779236; c=relaxed/simple;
	bh=6aALHgYm6vTNMfUgaQsH3sTMuf7YpnKKEGVAPHRcP50=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jo87JoMQ4fYakL3cCO5fLcMbuKfCXx/4kFjcD/7JSTIIgHIZ83PtxqccjpRi5PczObh+bbYwqGFjkpmLI3+gSlR/qRK/rGERToXRKpUNQlmmXpJoAxuJcVJX8o33rKGXF80rKAnpBb0KQWwU3U6N3UFHY5ka5w6KgYCAsyYvWpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fN6k1dKH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O+y38tS1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RHGVVt003776;
	Tue, 27 Aug 2024 17:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=eLGvsaFT0IFzxN7Lgn3r3+zb9amuqjw4w0o+i9wwgGo=; b=
	fN6k1dKHCgGkAKm5QpWTsnqht18BwCrjShSyi3EzokW1+A7+0XqES0NktkWzrk+3
	xSyvi0pfdo3nC0Htzk44nrb/zkoWYu25d7l+L1gBaLTOIIHm7+dKCAO3MQenwFdQ
	KncJ7hATyO6m793xkYlRtvFOJats80Y1KMb9nBk3Y65i74Hl+SDPVdcvkAXVeHD2
	W7K6EZGJwokuMr0LabfD9erVSzmW/zSgS/idUR2bfUiZJPRcQn4+fbwZVmmvTy9y
	TFqwmCj/IMx7igvRh4ZeuOLe2SC4LOVp1kjNP98WpOmnTOkJJf8cIk2HVvVEq1/s
	Di3z13qTmdFKAKp3j0ePpg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177nae6k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 17:19:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47RG8brp020326;
	Tue, 27 Aug 2024 17:19:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8my32v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 17:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUuSW9twc3eWbCY8eQp8f4pd8xnYHyRKQU2giI32sSDXcldLVLrgJrgJF1nZp4AYtQO5UuLUgpv1nkhbrd/oWBlUPJL5weUq695PcA/F6yqM+0QpuBC6vHyZEtZvE0xR0cmMLkVBx4VJWw6ZYtF5hrxUYFyWYmks2vz0RMN266Oi2qYf35glr5N9bfTTWKUWso+JeiD3jM66KkGXQFo4MvgD+GC0S+JB6OIHErrVs9NgmJgfq7AArBDB+l/+KGxMSZGD/7n8Luee+9xoQr2BwBgXWGeAQvMZB4CjboFB54IzfwxxoBPXEztzIrJSaqCuD3aF6Z7atI2VSxNggOEHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLGvsaFT0IFzxN7Lgn3r3+zb9amuqjw4w0o+i9wwgGo=;
 b=bykL7pHtMl1DCqNlaf5+qICe2iEv58yFnSSLY6uRBmMq2/fceZ6o1lbJJ8/nl8T317iP+meOfo8KwB2qYfAGayUwMgxE0uR13HKl43TjVdm7+AC5C4/CaBfC/ZlAOFYHAFXZw39fjmU7V8wlquyetEVJjubFGYRKJwUKuyYa/XtoVrcPgcqc3NJbZzu9PGVIuBXD20dAY//98wdcYdnU0StovkzvxwyGnQpdA5uiQ1edFzXVbA4lBX8v5LtEZ02zqg5x+SYnK6MlFem8CRLuxxzrgpCnZsO0m8MXmKbGfO8Vl+7jFc6BYA44Qv9b5w0IQ+Echr/qvyAjSAXALXxpMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLGvsaFT0IFzxN7Lgn3r3+zb9amuqjw4w0o+i9wwgGo=;
 b=O+y38tS1PB3LRGKKQhSJafh3MxIFV6/fekm8/e89/0TXaREiuVv4cCSR5RLzVVZ8h4odMihaunN9yDrWVXOJK5TLI0o/9N2aO5VdPygd+aRtQ90b1nFU7vuCNJJx1mv/NVF00+wXltjEYvnK84U1NvcWCGUMfTbRxoPrEI0qnqs=
Received: from CY8PR10MB7218.namprd10.prod.outlook.com (2603:10b6:930:76::22)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Tue, 27 Aug
 2024 17:19:17 +0000
Received: from CY8PR10MB7218.namprd10.prod.outlook.com
 ([fe80::3bfd:d89c:954f:747f]) by CY8PR10MB7218.namprd10.prod.outlook.com
 ([fe80::3bfd:d89c:954f:747f%4]) with mapi id 15.20.7897.010; Tue, 27 Aug 2024
 17:19:17 +0000
Message-ID: <833c9b45-b11d-4253-afab-6c4e92d650d2@oracle.com>
Date: Tue, 27 Aug 2024 10:19:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for
 Secure Launch
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20240826223835.3928819-1-ross.philipson@oracle.com>
 <20240826223835.3928819-21-ross.philipson@oracle.com>
 <CAMj1kXEyStoqmvvQirxt_GXTnO2qQjOxtQGzHzQeCdRCYzT7uA@mail.gmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CAMj1kXEyStoqmvvQirxt_GXTnO2qQjOxtQGzHzQeCdRCYzT7uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To CY8PR10MB7218.namprd10.prod.outlook.com
 (2603:10b6:930:76::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7218:EE_|SJ0PR10MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7ae786-205f-46b3-a5e6-08dcc6bc6169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmlzTWZCTHRzL0FiQ3VOdWoycnR0NzN3QllVOXNCa1lDeDlySHFLMFI1VXRw?=
 =?utf-8?B?SzF2QTdLakVxdXlLWDR0UHNiUWd5ZXgwQzZzQWVONHNKZmFHR1BaeTlkS0xm?=
 =?utf-8?B?SDF1K1BJODdMOXVFOXBmWVViYU1HOGtidDVjbDhlZG91bUJvL0xuQzczV1dz?=
 =?utf-8?B?Q3JMRmNYcWVqdDRvUEw4cFdPRFFIbVZxY1VjbFVmUmdiWC9QYkJWZEZ6NEZW?=
 =?utf-8?B?RUpXZkJqelpSa1puT243bktMai9rQngzQzU4NnU5Tm5wWXF5c2xESGJsS0tG?=
 =?utf-8?B?MjdnVzZtUFVlVFhLZzY2eGp2OWFpZGlCNFpmRWJVVm81akY0b0tMSVpWcGEw?=
 =?utf-8?B?Sk4wcEhPaDRwbk9wOWU1UVlQSzBiZFk0eXRYS1FKN1gyK3FSbHlpUkloUFNw?=
 =?utf-8?B?RVVkdHM1RXFNdHBUR2FWNW96c0QvOGZRTitYMi81anJKekhBMC9YYTY3eUEz?=
 =?utf-8?B?ZTdiYmQ5S3IvOWlHMWRMeUtKZ3VFYy9pV3VncFZ3QW9lSzBieUhqcml6N3p6?=
 =?utf-8?B?dlcvTjl4eFRxRDg2eGhnWVV5U3JyaVpYSHhYRWhMRG94TFNPQ2VVVFVZM3Ns?=
 =?utf-8?B?TXJlN2dVSnhhQk1xaHVBaHdJYm9vQlFpVm9FK21rMForVDhyc1dUZ0hSbE44?=
 =?utf-8?B?NDN6T05DRUR0UDM1ay9KM3Z4c3pOdjhrQlRRWHFxOTZIa09zSmYraUliZFFo?=
 =?utf-8?B?bUo2VzRxT0MzWDl0SmN0SDJtMWlMa1ZvU054ZUZzWWRySjNhQ0Jmc2h1cWtY?=
 =?utf-8?B?d1BCeGxhd2hnNnJDOWFWMVJ1OGVTVnc5SGE5S3BYcXVIWUtpZHliQlVoWFl4?=
 =?utf-8?B?OVJHREtMWS9TMDlranRFdk82YWJSL3BYUWZxUi9STVhnOXV4QktKZit6cUQ3?=
 =?utf-8?B?U1hSaUtXM1kzZVZUK2xCb2xHeXluMVZQY2hvRCtDWEZFSkVyc2NPUW81S0Zh?=
 =?utf-8?B?eEp2UTR2VWNDZFpCenIxMCs3SVpWd3ptY2o1aVNUL28zaUFnQmtkTHdHaFBN?=
 =?utf-8?B?K2dPMmxFbEJja3JaditJZnM1MGFtNnRjTmozVUxibysxU0Z6Sk5raWhSbHpT?=
 =?utf-8?B?U3RBaXFCUXJmSmtJMnBqcEl3TjR1K29pVlJTSWlsK2hRTFdNNi9hL0NDQWk5?=
 =?utf-8?B?ejBlOGxycXJubkhJWTNHSzdtWnNKVUJmNWY5Q0cyLzFLbS9Ja3BlZ2s4djNT?=
 =?utf-8?B?NEQzaDlxR3VFNU81YXFoWmsyeUFpQ1ZJOTcwbXVkWXJ5a3VhMGVmZ2RWLzZW?=
 =?utf-8?B?UnlHbXltbXVvTnJ0MTQxcW04S3liZjZ5SUV0bTFPZ0JLZCtwRHJNemV3NzhC?=
 =?utf-8?B?MktVMndiVUhja3FKWXVhN29FWCttamJxMTZJY3orejNLTXN2eDhTWCtnSkVy?=
 =?utf-8?B?cFc0TW1SZjRvOUljZ1hKZTZtc29yUldxa1E0WkZnUU5kazIxRVYxV215ZDNZ?=
 =?utf-8?B?ZW55ODVnQ05RMGs2Ymw4K0EybkZqMXE1VlJ2UGExd2daZ3dKSHFTYVZCV2Vu?=
 =?utf-8?B?UUZCOWVUbE9oQ0JjKzJVV0ZUQ0VEbHEza2o1RG1jcmZvUVFxa0I2bURyOUpV?=
 =?utf-8?B?cTdYTUtsTHZ0UTlFQ3BSM25XZ3JwaSsvT054L0lUcHgyQzllZUNvdXdORFYw?=
 =?utf-8?B?L1hTRGNjRjFMemhrQ3VPY1g5eGtXUGFiSFdZY2VOMnNic01vMkwvNTZJVHA4?=
 =?utf-8?B?TVRBbjdicGpGSThZc253SjlvSmJvQzdnaHJwOXpJMmZLQ2FuZTlKcUVKVkVs?=
 =?utf-8?B?RWZRRjNEUnY0a0NvTnlXdVJGaVY4SUpBL2lObU5IQ0NwU1BhSzVORzlzTDJ4?=
 =?utf-8?B?OHFZQmRlTk1UdFdoSy96UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2ozTm9VMEZVaE1yOXVTM0dyVnJUbWptS25Pd216OVBKZW9YU04rZmdvWTlH?=
 =?utf-8?B?MWNNOGgwNWt3ZW9JYTVRVkNFdUxRNkJ3L25OMW9veU4zdURpZWNTblRMb0tu?=
 =?utf-8?B?ZzdkZ04wSkVUSWZlSElJL3pOWDRNNGxCNE5PV1l1bTVjYnh3MURyOW9yMVpz?=
 =?utf-8?B?QkpMWHlqNlIxbnVLaTBGaGtRMWJGWDJzZFpyVk9vUGhwNU14QnA4NTdCUit3?=
 =?utf-8?B?blAvYWY5L1RVMTMybDNHMHZFZ0lIUUpXMm1HaW9uaUtUbEpNcmdTd2Z6VS81?=
 =?utf-8?B?TVg1aXI4K2NCSjkzeHpnWmx0eEFxQ0pOY2l1TUUwOEtXUDlwQWdBUjZPOEIy?=
 =?utf-8?B?OFlqT3BkeDRvM0FjcFVWVWU0MzJZbm5rNTBvTUdmR2R3MkNIRTJtYjZiZXdF?=
 =?utf-8?B?bVlnbjdlekpqbHZiTVRZQ1NYNTBVY2g3R1Q4azVHdFlsaWNzVit3SUJYWkRC?=
 =?utf-8?B?d3JGa0xhQnhqN1dNTDY5M0tuVVRiN2FMdUJJRDUzZ0ZtcnB4MXc3QXprK1Fv?=
 =?utf-8?B?ZGFzTEZuME9kRWZKUW5HMWx0eDFUSDMraXVuQUFmdC9DQjEzS3hnaFluQzlp?=
 =?utf-8?B?Qms3eVY4MWtHY0E3b0RvNDlWRVVPY2MwRGdGaFNTRGszMWRybGFROFQzRHhL?=
 =?utf-8?B?cUoza1psZHpta1NvbGZPeHpUd1Y3NnE4QnB4TDgreHd4L3ZYcnBwMTdxc1ov?=
 =?utf-8?B?OExsSEsySXJLbVliUHdET29vekpKTUdJTlNBZk5XQ0plUWJob2t0cU9iRklE?=
 =?utf-8?B?cWtibEUrdkdjM3BLSE41VUM3bStqUzFxY2RSNmJVZTFoaG5FdkplcDlSQTFt?=
 =?utf-8?B?SStDOExhZ1N5WkFCaHI1Qi9KN2VUNE5iTDMrWEJMWmFEclUvajZkSy9yS0wr?=
 =?utf-8?B?VzFDMzY5Mm9CbUZ1NGtKSW1CT25GcTl2d3ZIUC9YT0RCZ1YyWkZvVkxWVXJt?=
 =?utf-8?B?SXhhWEQxelB0MVU3d2ZKZFcrY2RDRGpTeUpYYVRkbzFKdTZ5SE1pU2Y4cjRa?=
 =?utf-8?B?YVhtNm4wVWwxWThVeGNsKzdNYWNZSFhubDRoWFZFam96dmk4Z1VFU29hbXhr?=
 =?utf-8?B?RGhBUWxZYUpvWngzVFdMQjV4MzlSTyt1Mjg0QXUvKzQ3Q0hjcmx0OERBV28y?=
 =?utf-8?B?L05JWmdES0JKbWRYUUpWQkhnWnpETkpoanJ0RXR1RHd6TDVpMkQ3YkNkdXpu?=
 =?utf-8?B?STdWdUJMZGZSdi9UMkdPei85MzRZZlNHNmZ1ZnlCZzY0Y3FoaG9RcHJCQkdv?=
 =?utf-8?B?TVBoK3hFWnh3bVIwVmZCejVaaHJmeGNDRklxTnVsLzRRemp5dUhuandkVWJk?=
 =?utf-8?B?VkowMCtWQWIyZmcxNWd2akZTRytrK1FYQnpRd1p0Y0JvNnpqU0JjWVVaa2Z5?=
 =?utf-8?B?Y3Ywa3M5SE81SkJKZVNIcWM0V01oMzNqOFBnN1luWm9MZHNvcmd6U3ZlaEZB?=
 =?utf-8?B?aFJ4Ym1ML2VLQW5yMmxDUjBiQW9PN1IvOWRRdC9zMHA3czBDeXpVNmx5dVZK?=
 =?utf-8?B?Mno1S0JRcEFmRUtYSVpQWW9VWkJIc1FBZnRlVnNqZ1cyT0ZEUkxMWEJ3MEpo?=
 =?utf-8?B?Zm4yZkJmeDdic1hBQzJrMDFUL2szeHRPay9uajZONG9mQkxWSkQyRzBCaklI?=
 =?utf-8?B?Ukw5SkZ0d0p1Y0FZQlR6c3cyUzZidDFYangvUGt6dmJNWTRqc29Fb1JNaVlw?=
 =?utf-8?B?TUlpdWJ6ZUcwZ1dpdXlmNjhMMC9FcDBBT3JXc29UU1QrL0ZFSjNhbUhpT24r?=
 =?utf-8?B?Wnp6ZVRqWHNCZWU0NDNpa0FYdFdsZ0lUcko5eit0YktXRWtyV0UyTC9ONHQr?=
 =?utf-8?B?UDZLVjNreE5kQ1A3czcrRjFReHRuaG5aTXQram1rclczSzZTMUVxNTRCWUt1?=
 =?utf-8?B?TGJrM2VXT3pLZEhKZm9MWkt4VTFzYUVGdFUyUjF0eitnSlV5TWxKTUNSZXRP?=
 =?utf-8?B?Q3p2ajlCcTAwc2srQnN3bjJYNThJVzdMZW5nNDFFSW8xN29Qd09jZzJUZ1pV?=
 =?utf-8?B?elB2bjlkVGxtN1ZINUxxbmdqMVdDSXlpNDZmZTdDY3dPbS94SFNVeXFLdStK?=
 =?utf-8?B?cFozbi9wTk9HdDJXUTUxVjdYWS9wdEl5WmZiSUZodGxJczhrL3VRMHVrV2sw?=
 =?utf-8?B?eUZYTS9yTUh2OFd6ZUlKOS9Kcks3R1VycXNvWGlabjA5WnVjZVJTeXpxcmVS?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aaKcQlH3R8nweOuhmIH5Ua59eZTSiMiZKT9QPEqNntGyk/kw2mRNgBpxvFTaUMtgaBLBtES806ibwHUaBgQNH19XvmVDLZB4MWloqR51lMwwqZUdnxJJWI8ecYO5qlHYeYK3RyWH9gOoPC/GYsa5TxqjgxXJKHRlWzcW3m0TmA2QRX0x39TB5XapurZLc3zQel/cC5fuLXPvGksc1QuOwmDm1/euJ8Xt0/+A1qkkp+tg0gm/I8h5GSVzfxCZnTgmo1haoT7Ct7uaRWTlSchfsc6F5lSlzMgPHkWIwhNnR+iSsCTmdPQsdebIvUhnx8yuAG5asSwHJFgTIj/964ItR/8Nk5P+MIdkJ/uL4hQ3KziAOvR0/wlhQiXNYQ93QL68Vf2k0uy+dATA3TfrstO15A2d5G8ExQupKCAwZBNEO9PtDLBPb8XrJXigWx9Exmb/ZHcivgGpW/Nj3qQefuKSRIC7e9KWpBwkGnZbEoTLSqSbS6n7BFP/Uyg299TLz7maX5uAQAaVJ9lCy4CCpHPUqCx+70AF6N3F/to9FmVOYF4T4jeS5wYB+qXskYI1jRglob+ma0BaLuBwIqPa87E7zzAPK1xpjTrleBqfmKGffJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7ae786-205f-46b3-a5e6-08dcc6bc6169
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:19:17.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjRLCnjfPajCDHEb9l3qS9MM4+OITe4xdPuQxE1I078WrC/72lg6IW1nGZh+98cxfJFtwNAZQZUYPxHqmxG9gLa4wrR4YBG6RT7uHL969iY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408270131
X-Proofpoint-GUID: W3lJu7yKOdIsLRQ4ci_sthbQBBLSuKqP
X-Proofpoint-ORIG-GUID: W3lJu7yKOdIsLRQ4ci_sthbQBBLSuKqP

On 8/27/24 3:28 AM, Ard Biesheuvel wrote:
> On Tue, 27 Aug 2024 at 00:44, Ross Philipson <ross.philipson@oracle.com> wrote:
>>
>> This support allows the DRTM launch to be initiated after an EFI stub
>> launch of the Linux kernel is done. This is accomplished by providing
>> a handler to jump to when a Secure Launch is in progress. This has to be
>> called after the EFI stub does Exit Boot Services.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Thank you for the two reviews
Ross

> 
>> ---
>>   drivers/firmware/efi/libstub/efistub.h  |  8 ++
>>   drivers/firmware/efi/libstub/x86-stub.c | 98 +++++++++++++++++++++++++
>>   2 files changed, 106 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
>> index d33ccbc4a2c6..baf42d6d0796 100644
>> --- a/drivers/firmware/efi/libstub/efistub.h
>> +++ b/drivers/firmware/efi/libstub/efistub.h
>> @@ -135,6 +135,14 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
>>          *hi = upper_32_bits(data);
>>   }
>>
>> +static inline
>> +void efi_set_u64_form(u32 lo, u32 hi, u64 *data)
>> +{
>> +       u64 upper = hi;
>> +
>> +       *data = lo | upper << 32;
>> +}
>> +
>>   /*
>>    * Allocation types for calls to boottime->allocate_pages.
>>    */
>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>> index f8e465da344d..04786c1b3b5d 100644
>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>> @@ -9,6 +9,8 @@
>>   #include <linux/efi.h>
>>   #include <linux/pci.h>
>>   #include <linux/stddef.h>
>> +#include <linux/slr_table.h>
>> +#include <linux/slaunch.h>
>>
>>   #include <asm/efi.h>
>>   #include <asm/e820/types.h>
>> @@ -923,6 +925,99 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>>          return efi_adjust_memory_range_protection(addr, kernel_text_size);
>>   }
>>
>> +static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
>> +                                                struct boot_params *boot_params)
>> +{
>> +       struct slr_entry_intel_info *txt_info;
>> +       struct slr_entry_policy *policy;
>> +       struct txt_os_mle_data *os_mle;
>> +       bool updated = false;
>> +       int i;
>> +
>> +       txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
>> +       if (!txt_info)
>> +               return false;
>> +
>> +       os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
>> +       if (!os_mle)
>> +               return false;
>> +
>> +       os_mle->boot_params_addr = (u64)boot_params;
>> +
>> +       policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
>> +       if (!policy)
>> +               return false;
>> +
>> +       for (i = 0; i < policy->nr_entries; i++) {
>> +               if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
>> +                       policy->policy_entries[i].entity = (u64)boot_params;
>> +                       updated = true;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       /*
>> +        * If this is a PE entry into EFI stub the mocked up boot params will
>> +        * be missing some of the setup header data needed for the second stage
>> +        * of the Secure Launch boot.
>> +        */
>> +       if (image) {
>> +               struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base +
>> +                                           offsetof(struct boot_params, hdr));
>> +               u64 cmdline_ptr;
>> +
>> +               boot_params->hdr.setup_sects = hdr->setup_sects;
>> +               boot_params->hdr.syssize = hdr->syssize;
>> +               boot_params->hdr.version = hdr->version;
>> +               boot_params->hdr.loadflags = hdr->loadflags;
>> +               boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
>> +               boot_params->hdr.min_alignment = hdr->min_alignment;
>> +               boot_params->hdr.xloadflags = hdr->xloadflags;
>> +               boot_params->hdr.init_size = hdr->init_size;
>> +               boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
>> +               efi_set_u64_form(boot_params->hdr.cmd_line_ptr, boot_params->ext_cmd_line_ptr,
>> +                                &cmdline_ptr);
>> +               boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
>> +       }
>> +
>> +       return updated;
>> +}
>> +
>> +static void efi_secure_launch(struct boot_params *boot_params)
>> +{
>> +       struct slr_entry_dl_info *dlinfo;
>> +       efi_guid_t guid = SLR_TABLE_GUID;
>> +       dl_handler_func handler_callback;
>> +       struct slr_table *slrt;
>> +
>> +       if (!IS_ENABLED(CONFIG_SECURE_LAUNCH))
>> +               return;
>> +
>> +       /*
>> +        * The presence of this table indicated a Secure Launch
>> +        * is being requested.
>> +        */
>> +       slrt = (struct slr_table *)get_efi_config_table(guid);
>> +       if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
>> +               return;
>> +
>> +       /*
>> +        * Since the EFI stub library creates its own boot_params on entry, the
>> +        * SLRT and TXT heap have to be updated with this version.
>> +        */
>> +       if (!efi_secure_launch_update_boot_params(slrt, boot_params))
>> +               return;
>> +
>> +       /* Jump through DL stub to initiate Secure Launch */
>> +       dlinfo = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
>> +
>> +       handler_callback = (dl_handler_func)dlinfo->dl_handler;
>> +
>> +       handler_callback(&dlinfo->bl_context);
>> +
>> +       unreachable();
>> +}
>> +
>>   static void __noreturn enter_kernel(unsigned long kernel_addr,
>>                                      struct boot_params *boot_params)
>>   {
>> @@ -1050,6 +1145,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>>                  goto fail;
>>          }
>>
>> +       /* If a Secure Launch is in progress, this never returns */
>> +       efi_secure_launch(boot_params);
>> +
>>          /*
>>           * Call the SEV init code while still running with the firmware's
>>           * GDT/IDT, so #VC exceptions will be handled by EFI.
>> --
>> 2.39.3
>>


