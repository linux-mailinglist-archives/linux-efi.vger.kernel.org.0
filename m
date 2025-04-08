Return-Path: <linux-efi+bounces-3244-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4776A818CC
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 00:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279591B65B8B
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 22:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F73255E31;
	Tue,  8 Apr 2025 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XMvaoxrq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CyaUscBz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB517A312;
	Tue,  8 Apr 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744151730; cv=fail; b=exDonpdvZwHZ2lMAXi4fmjFXfbBrUoeqSjEgmArdHrA4H0B3VCDTCSg80ZJF115KZs7levSExUqldrsibGvd/KC77n4qJjGNRjbw88d4KaKFpZ6qITdEMNv3q+09wrVljlJjLOi1NHbJ8BLFprhCh4Ou5sW0gctFnb187fcqM/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744151730; c=relaxed/simple;
	bh=+px+lxoFk99dZU4r6C8IiLCV47Ag1ORlo0/bEwGEuYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L52BCD7tsPUxIT9a7I3qoqABJtGOI/SiBDQas1vcIByBqDtpsZjIEVaOKF9Ox3+lsoDyzhIXr4Av9VZaxYZ8fla4ssqp1JqUJfJqEJveoVBhDSelI0FPp5Co/lOJK951CXwFa/kG/Ea07CBJ+GFdLboORIQ0nqDrkUChnMeviUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XMvaoxrq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CyaUscBz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538L9rG7023927;
	Tue, 8 Apr 2025 22:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=KT6OKTdsOB7i68i86M
	yH/3uqyEDlZrSNg6Ygo4Kzmb8=; b=XMvaoxrqoc9pFUtf6LhzOWI0D+/l9Ck+7b
	Stw6r0H+1wqIvMcP70GmEWiBdEX8Eu2YPJTtOlPFnZRG9LU9MPjxEEAUaoamIjYC
	tbcyqJaa3tvOicEhdrT3RidHC1JYdjgymn5Te1gHYFnbqKfF5VyPf0fAbZgIRw/l
	7FDWH7zMuKD9Ni3/ledvhrtbyXfozDAVdL8unYvD4aVd4P7sY4XYbYbxfR6P/640
	B+x1KcyjydnNSd7Ku1SyQlYxumO4YeDjVA81gV5QjMz5M2W1APbXbJL4G+lW256W
	HRpXZpo4aUAmVDfncgDospyBCCbHWCDsToHMPHHKUj/LMpYqiFTA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tuebnypv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 22:34:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538LLc1v016095;
	Tue, 8 Apr 2025 22:34:35 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010006.outbound.protection.outlook.com [40.93.11.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty9y81g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 22:34:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2o2n2MMj7eLaxrhNaO4epo/Ox5yDs8EmqXbxZxBrPehwEqzKAvhWIaY7geo3s7jZ8ruYh5NjIr/WrHOIMtDquvJ1TzADpS70/GaquCSyUrcN4M+ZWghQUsoLPm8IApE9PTFIjmS07dQ7RRp0j2k4jQA7dtDeY4IBQDSUjbeMzGOmNyMaCcXyAT7QZKmN2uuMHvyD33D5okfXSbisGh973EIfdO9h1uZD4j6k8+QaL4Nq2XjXaTllZFT1NFHB0V3KZEViUv3WWL4JDVMpwwIelUvX1ormUb8GAeac7Sw3jCi8HK8Td3TwWf3aZRIlKLBrMQH5tsHzJJQ4m7V3QwyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KT6OKTdsOB7i68i86MyH/3uqyEDlZrSNg6Ygo4Kzmb8=;
 b=WZ5iTWU8PK+p5sa02ovQzid43U6AyMnHzHZxB72TLyej1yh5XQsVCXsRVXWRiJ2FAoJinYl6y/qKzeMtse13ZALn1yDnfV6HPQnx8//YBZ0qpFISIbJLvBlTX22RZCEJFKUtr8/eW3yaTLpcKP3vZOi+maPW3dN5ZRBMS8PSdzptptG4hYWyL8oaOMpWSMLKSs7SlBW6EbTZbDOkcpn8Ik6hVkHY+Qja68+6ZT23Bs1WBFpzE0l3lQURfzr6CyBl7D2U7NMLtDH/gmPDPMl9CFSf9rU+aE8bg/epsYYnHyQs3wKpzAU7YZd44uAAPo0BZhiJuLsU6aJh/7Ry+/vnUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT6OKTdsOB7i68i86MyH/3uqyEDlZrSNg6Ygo4Kzmb8=;
 b=CyaUscBzg2vuFrdEP7OTCzWHYadKsUNE9n0n7YHTC5TleSM0X+fgOY5Jhlj9cJBVoeN9mIqNhk+5k40yf87ArZ8rLCviQMF9YiTwUKXNChXCNd2jjPFZmMGlWqrWoS8l3tvYSlFiR/7GjgnGcTrOg4NMKo5s7O9kbIMgkH5RMIA=
Received: from IA1PR10MB8211.namprd10.prod.outlook.com (2603:10b6:208:463::7)
 by LV8PR10MB7944.namprd10.prod.outlook.com (2603:10b6:408:208::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 22:34:32 +0000
Received: from IA1PR10MB8211.namprd10.prod.outlook.com
 ([fe80::ec0a:e847:383e:1c40]) by IA1PR10MB8211.namprd10.prod.outlook.com
 ([fe80::ec0a:e847:383e:1c40%4]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 22:34:32 +0000
Date: Tue, 8 Apr 2025 18:34:16 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: ross.philipson@oracle.com, hpa@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v13 19/19] x86/efi: EFI stub DRTM launch support for
 Secure Launch
Message-ID: <Z_WkaJhel-BYxHeW@char.us.oracle.com>
References: <20250328230814.2210230-1-ross.philipson@oracle.com>
 <20250328230814.2210230-20-ross.philipson@oracle.com>
 <B41D3199-8054-4B2C-94D6-508D1DE4C8B3@zytor.com>
 <886145d3-a9f2-41f3-a754-253decdb1b4f@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <886145d3-a9f2-41f3-a754-253decdb1b4f@oracle.com>
X-ClientProxiedBy: MN2PR20CA0064.namprd20.prod.outlook.com
 (2603:10b6:208:235::33) To IA1PR10MB8211.namprd10.prod.outlook.com
 (2603:10b6:208:463::7)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB8211:EE_|LV8PR10MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b83fc6b-2315-47a1-a30a-08dd76ed87e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rVQd4D4fC2Cmx8Oxgd6R7aYR6vCmARRIybP4Zm6gKEl6hDdJ/8xaGHPlCucq?=
 =?us-ascii?Q?SHAzlpiMYAGZxY/XmygqmFnoiKNmz4CrrqyQ9OC71Rk9T+buVwkMV3HIy9Vw?=
 =?us-ascii?Q?Vciw2piIzm3Tz1ENEyfNYpV7fJTiM/cCtqI304l1Dr7ZSmpR4mKAhIr9QlzV?=
 =?us-ascii?Q?wiauDEjWd5k85Nyr9iRb+0wyTfv+OvM+aFgqCWyFdDQ6HFMEKRBFLVvbVw/k?=
 =?us-ascii?Q?PlpEi/uQkMacKxUE/INsaODggt/bkxWk3KUDOKEDm88lGD+hEb7wJbu5VR9S?=
 =?us-ascii?Q?U2se2r4XMGcWfAhUMmZh2oUhqIXQu+5L/pB2fO74LCtfR3MQXu+quI+PKt5E?=
 =?us-ascii?Q?VMsyok1Hx3MmM07SkrywWhmRoSXACGvscPQ02ik8uITbcdxpEYy1hSvB4q/Z?=
 =?us-ascii?Q?YEPqJk0+DsW6obPSwrq+8tPk4FN2XiHgBdh2dQSg6NPA3rshdgXEIIWqmp+r?=
 =?us-ascii?Q?scSUTnYtRAMnQzk94SiR3g2nFXsk7E4PAFiBUqya1944FYvtMWQ2TrJxh0pq?=
 =?us-ascii?Q?1ay2l+4RxfsodA2W/2Tj4wTV00vCvIokvI+bB1Wa22Ou5Gf91Klo/pF9dftF?=
 =?us-ascii?Q?01F7cOUomYj8SvZaSGbqj14Ljsv+tR3SKJgZO46MkmWAFbUhUWh7zX5GF5dZ?=
 =?us-ascii?Q?fU6gc7meriH/LfWb+2i+T9a81Sp4ee6BjIZN+6O8wgfIm6GAn2g/vZwd3ogk?=
 =?us-ascii?Q?QVsqd/avQoprAnJqhXIXEh15jc2YWl1fUuLTSZk4aH7a516ujPKuVkLR2Znl?=
 =?us-ascii?Q?TIJQ0SBvmoAEPAMES7WYoN99yyW+FquD2f1WoETuh7O/Vp/UOmVDRGUC25G+?=
 =?us-ascii?Q?Z54JvtC8yaMHoMzKsF9SiifHsvKPs43EWyBABNcuWh2kfFS6l9MWRLGiLZRW?=
 =?us-ascii?Q?Wy/h/RYAQj+UywNFYvpRbUb56m4ZlrExJv5sIMy13eOUg1Mr/2p1i/vYs+WN?=
 =?us-ascii?Q?u50zx44cXABNy33dOPLFiPoiY4Ki1YBP/kQM3/on7ZqTGQKHidynCWODBbNz?=
 =?us-ascii?Q?o84m4kzhUCfYyujlweTKOFVKko7bqEX6PyDnLgn4/H/GUuM2tFQEE9A76A55?=
 =?us-ascii?Q?WT82jYTkcXJKgh/V8kxbUn21K0I0enT7YVSosE8T3K7OXQtF3DxbzsH2ILSC?=
 =?us-ascii?Q?yhZJ+HFb7Oe3s+rYtMy2LtxPcha3LEm2OyknBCj9hT59X6odOrR1I3R+uy9G?=
 =?us-ascii?Q?W4cNA9zAQ5NBtn1gGM552AuB1HxziJ/n9mN/NVaqCLr7kzvTqNOvXguPwkKn?=
 =?us-ascii?Q?XZbLVTcLZ42UdPilS6+QFuZsNcrLBqL1MVRiWNIKVkX5CjoFp4krzXvb7myY?=
 =?us-ascii?Q?mxnGRP51udFLspp4k1DUXkSPjsmTYuSKHTJbY2LkHDSaqiPzI/fZZ9GXFHyv?=
 =?us-ascii?Q?b/QBR+TSXMERQYUA4bysfQGY1jCQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB8211.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZz/GgWILI17IwjVuXZn+n8hNF6nV1ga/+Jdv9CqD/scGgCT8yu303lBnfP+?=
 =?us-ascii?Q?jrLghv2NUZNaNoXzL02ueklU4NG58RwK+TlrDuCB81y4gOvycrp4/XR+x5F2?=
 =?us-ascii?Q?teMu8h5/i95ephva/1RlQbJY2rs3yC+AiWfG9iPDMm6komXF2c2XEC/U2eE0?=
 =?us-ascii?Q?E802eWt5bHRPMVse1mE6wXSdjqEmthT3bZrF92Ew8EEOT+h4NEmSOqKzZg6K?=
 =?us-ascii?Q?0Us4RzHj5Pbu9IUtLJVNL2y0zNYL6g/YWjFADvbEqv6XJrn9d85N5Sdkd9kF?=
 =?us-ascii?Q?UnyLBDQVCQe46das7F74M36KNG7yODuAncbJD7RGGIK2iulnqiFjyBOQPlZe?=
 =?us-ascii?Q?gLrJN57k00c2ydVayl2RJOQuG1fxkBIubVxUuBGscSGlM9kR7N+Lisz2hbFM?=
 =?us-ascii?Q?Opvse4E7r1kLwbrxG+b09H2xhmStfg1D6xjFxbj1wt5ewSGUVfyZxJbPIeC8?=
 =?us-ascii?Q?Pu2kL1ODVPHrDrEi1gy7pju0rTPJf60vWifJTEBJNbPmMuA81RSqcx8sInLQ?=
 =?us-ascii?Q?yhMco1PNeBRBeyh8VQuE1syHbhZd/SXM2xA4CS0Dolc4ZFIvMAhByV3Wfll3?=
 =?us-ascii?Q?rEaOMB10nbDk4w9dzvqjEtqJhMCo5bI0rnZs7sTMZpDjRBirqc/GGUOKijq7?=
 =?us-ascii?Q?lKcPnsdyQkPcpLc52XbcghvcO36RIsy4fwcdYdoazCchHxOMUPMuiaJxs2MT?=
 =?us-ascii?Q?QWYuAZas4UvvL9JdqraZjuJYh0stRo0zGLM7ExPcepcLUkJuYKnEBiwBCPbk?=
 =?us-ascii?Q?isYsxM2Cog9ODhBR5k4oIB6UXIg5H9I7c0mxhCPmzXL6+uhYQMDUL6MEPOsn?=
 =?us-ascii?Q?+dhOURog15yOI35hPFNqrCMcZFLOBAMh1f9ajOG3OSTAh+x8X/rQf/DkIFbB?=
 =?us-ascii?Q?RvK7xv63vlKm3pUAVdZWj5VAJ9ea25RZpI/FhXleDIUZmmbuJyzlWdo2rILT?=
 =?us-ascii?Q?sj9KfL9D2WwFmEL1NFvFY4ARVJ2zbzLmMaljQLp20EfzJXcxTK8/FlaGypMo?=
 =?us-ascii?Q?2sH+RLY3U94FY8JCLAXOK1P4v4k3W92g4e71uSMR5xFP6zpKOd/U4IPTYx38?=
 =?us-ascii?Q?buFtJZtmlvdtUZDmaetsrq5ZNkV7/2LZrTFEsWciwyJLhc+2pBPbyvBXTrIJ?=
 =?us-ascii?Q?kMmnQ9FxultM/yeI/QDaGs2Q7XvA1Mf/DGbSKF2bbeOsrrG9tuO2bAzf/6/D?=
 =?us-ascii?Q?qvVuy2g3YcXaiTzU8r2BozCytv/NuXkL6TbXZYNhB0Y9WTUy3NZu/I5sCkDN?=
 =?us-ascii?Q?7oVjFLT9LRrysOJBXK2x9/VjVvoD1qN0K94XSUxk0FaqQffcXj59NONgAh77?=
 =?us-ascii?Q?J5QjI79mGOxx9le0WoDYLVHrs5flJ4xdW8zfoQCy29J3OWeuFM2Ph10OUooR?=
 =?us-ascii?Q?qz658GbFVday9dg2bmqGdQVEt7zy2VvlMHsyHQ7kTBSg7C5PdWcggHHPJD/4?=
 =?us-ascii?Q?sQ1agDGpqbG+rxSKEKpUl0H2+6lWdDUE3/932vvZwoun4barm6eafskFtJ4Y?=
 =?us-ascii?Q?U+0t9gk/0YAdiLRousiLv2WMwCVqeA0f1Ct3do3tgJy4SCcgA4vBJu0h2sf6?=
 =?us-ascii?Q?tTPzGj1BIelck3wqiDSMtEQ+/ni+//WKsELXfmsB1ZgGJ7l1kBFVX2bLo/mo?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	USOEwl1bjZDobfny/wInYl+HGUQ4/CkIJc6423wliiIHEyHkWrxsi5zcHA1kl7xBF9jhBwH8kfNH8y0UFv76K8woBVGV6U1GSdClOwIwgxhhg1vtS4jfWZ3MD8X7LlwxbN2TV8V/gAg6EPK68vif5f0Lruz7bwYLe/7QDd0yeFaThVsqiMvqtpNDHVoFEVVhjGFdtcMF861wVjXOGwJLpbD9FqjCRvg2JKMWy2nW8hbC7l/BH8IBYlj7mZ405RaovNbHOsXfFqAVsYKbJFVuRfwJz9HME+RxcCvPJTmE1jfj/lxyn/qIMtRSwaMEWc9sSN0yj5qq0tQTznGqgY4qFTJdJCEEbS0nd+8f3ooB39EWUC1RKTzO5GQSesybaGisxZMZHxcY6u5v3KK7csK0p2x07jjyiwD/pHoknya1Y8Z3+dIy017IPEGfwe9hYTOBt/EtxGVn4TOxRSbJoxq4ge/g0oQZrBpDv95+vfB5YE7ejNcTZlnKU2sNL12Zcc4P3Yplxr6UIAkV8t6qbkpz+LZijIg6YI1S9d4ba9zU4MUCD5bHUgLLJ7tiUDG8NypLDSGUHG5+UxjiS7E0t86O//CGtdCwBO6W6pe6Va/bPVY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b83fc6b-2315-47a1-a30a-08dd76ed87e9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB8211.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 22:34:32.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ihxrZIG/25FfokYgyn1IvsI/2HWbksYkXVVm7uZ+1p4ik/rTsid8ba08DfKylkseRl2D757+ejMdHeo7Z3l7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7944
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_09,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080156
X-Proofpoint-GUID: iZGkAhJe1cMhdoxy3CybUWlxOaMHIdkh
X-Proofpoint-ORIG-GUID: iZGkAhJe1cMhdoxy3CybUWlxOaMHIdkh

..snip..
> > > @@ -925,6 +1014,11 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
> > > 		goto fail;
> > > 	}
> > > 
> > > +#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
> > > +	/* If a Secure Launch is in progress, this never returns */
> > > +	efi_secure_launch(boot_params);
> > > +#endif
> > > +
> > > 	/*
> > > 	 * Call the SEV init code while still running with the firmware's
> > > 	 * GDT/IDT, so #VC exceptions will be handled by EFI.
> > 
> > efi_set_u64_form()?
> > 
> > What the heck is that? If it actually involves two u32 packed into a 64 field, why not simply do two stores?
> > 
> 
> Well the story is this. The EFI maintainers asked me to use the
> efi_set_u64_split() type functions (this one splits a u64 into 2 u32). I
> went to look and there was no function that did the opposite action so I
> added it. The original function was called efi_set_u64_split() so
> efi_set_u64_form() was what I came up with. I can name it anything that is
> desired.

Hey Peter,

Is there anything in particular that needs to be done to this patch?

Thx

