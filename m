Return-Path: <linux-efi+bounces-1983-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9B79A2796
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 17:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96250B26189
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974C71DF244;
	Thu, 17 Oct 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lhS2Renj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L5DIfskU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08131DEFF1;
	Thu, 17 Oct 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180608; cv=fail; b=L7+DxHrxl7BlcCVOOfS9M7rXjhTtgY4Ls0x9rFDto7oakLU3MFRFFHQj/h4RWkT7x+SssbdL8Azj0LLVRzol7rE7JY1zkkmg67ljJdr6ouhTIW+qqSYtq+NE/q7G8IFz6GRvymz1f0zSCENYqNEwI0KnE/J8BoZwA/PyUo7+KWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180608; c=relaxed/simple;
	bh=0Dz26JoFR0dl5goU/ElcSAy5OjWHbxoVggSKkA4UHmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XSGcfLSeUygJfJJZmMiiHpAj9tN2gcJzTW5Wy0gkr7shVKK7XHRrHzzxwmlrKJGJXYNv9e1f/ot0Ft6kvSnrkInMv8AynfLMJOT7k0NMV5wY9o0JSAYIVAdykks6Ti5pSAfh+cQdPMlPYxrdvYJpthaEUaocTMUz4Z1Gk14HncU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lhS2Renj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L5DIfskU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBouJ002189;
	Thu, 17 Oct 2024 15:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zSH92tUIFXowUHbAfcAcQHD0O5mpkSl5kOmEt/qWF1c=; b=
	lhS2RenjFFZ/AoS2stwhzcihsqJ8z6S++38cBeGAKsQu49IYsJVHYs3W3S95DlWt
	IbP3bTlgV1Z2f84Np/WtV9D68nRNyhYaBl0S+i0ra5SAcF44jinGSqw6CtLPLyuN
	L2VmLAEBJCMPPlx1FV2hwNUqegNkS8blyPkJjljQYPIt99uqQeYywbMwYE8Wg/om
	umON/1h0Pr9fIzaTtdIsaZcKAtpz+0MVgIX4TqX0C64g4OArCKb9SXivFH2yEpdb
	7twuMrWLfkPM+3wUd0e3O4Piv60cHCZPDhkh7/Yf9kvNOSuQ0jFkfN7uO0q0rXNd
	9Apws3W7eaVMjUkUdzF+nQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2pxem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HElWMU013904;
	Thu, 17 Oct 2024 15:56:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjadu5p-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lorF2X3NFZjnyvErPSl/dGaVAK5c4fYnUZ+NUSkDg4YO3Khqms349FIsTWzR8bsxBFnbmD/H4CbynoZq2b249L6RuvopZscHYBx62R8uJPA3I77P1CHfS5/k+6vpYBcXW7g1fHRDXxv5PKepRifcPqV/XpwmhQIpjoFBukpYkc1SXod+WOFcSrMQ3SvFBbzH26CYd2YgzWUTkzBNchYxPcd2UE60pN4ivL86elcMtN1AOXf4GlmZ89s8O5CTFix8Ib4TMuJ6dFD1AfUohoRJEtUJZmKphtFAMLYqgW5m2Q9UETOxI4IYOCheVZ2usZm5e+G3aYwmK3PBx6wWym5kZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSH92tUIFXowUHbAfcAcQHD0O5mpkSl5kOmEt/qWF1c=;
 b=cE8haHHhnxPQWA6SqgS3S36ZdxNTA0VX9uAD0sWO/bXON/NVBgOpmIBN8aohB4demiDjnVuXXBKOpEytp/vFWVJ0iN3LWvHdntQoMWu2ohyPdDbFURVpjhoyK8STsEzzGfCPsRQ+L8JXMaXZ6wp7urpNrejz1SeZBLqTKXyJDuBjvQOBJo2FmWdwekwNSVmlLymGa5cthY32rfkkT62ZUKfYX03L3ziaJsRNRZNSFQQJYhQaReYQES2s+Z7nZwOUhDaMITc6VwuTXEkhM6vqJxYrToJ+I2/wHpJJDAhOX6y5ig5A0ksOxBICTzrI36vTEkIDQ58YRyK0pvS9fI6vGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSH92tUIFXowUHbAfcAcQHD0O5mpkSl5kOmEt/qWF1c=;
 b=L5DIfskUPO7VXvizjCu2/PoCSCVjTXxlkuNTKWWYrvQtnWW6H58K1vGHvR2fofZTAac2uObtCVK13ByyBGLawBQFYKPAI6zNlZAPw+M4nUIXU8TmfuPl2T0kp36ElI1DM/72C8LBrPp4RZs+SWL1wpqHhcAldpVROxCroRXdXiQ=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by LV8PR10MB7967.namprd10.prod.outlook.com (2603:10b6:408:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 17 Oct
 2024 15:56:02 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 15:56:02 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, mic@digikod.net, casey@schaufler-ca.com,
        stefanb@linux.ibm.com, eric.snowberg@oracle.com, ebiggers@kernel.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [RFC PATCH v3 03/13] clavis: Introduce a new system keyring called clavis
Date: Thu, 17 Oct 2024 09:55:06 -0600
Message-ID: <20241017155516.2582369-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|LV8PR10MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c02e0e-cf1d-4982-e7ae-08dceec429ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F+tgaVi276NyRd4pUOSOXMFCVlyRWNrBnGFx5fmdaWuPJ0eODBIYlc8Qgkha?=
 =?us-ascii?Q?VTtxOmlWxtj+eNPbn50hpmGB2sWA0qFpgXXMCK/wNhaCOiDk11TPNKABlf7k?=
 =?us-ascii?Q?NuxhMSxVe/jiULAzhq4nSeqEa8a/ZANXTDeq8HjsuDKtKdD4bGLYyz9XRkJS?=
 =?us-ascii?Q?G1ZJz7KeIhVj1ng5mXDZtGellEqjR5M7bug3HW7SazCvwOUwBH7+9a3Xgj04?=
 =?us-ascii?Q?CnsTbOfYrdNIWhP+mwlM+PtglT10HcWSc/UIj+iYFL5UCrtZCm3ZpDhhrBC+?=
 =?us-ascii?Q?FmW34rAorGspTfU0/6mjiWQnhHm3tdtT8DOcQ8ABcWglenTSBq6xDH7FzNnp?=
 =?us-ascii?Q?lHsWtjpRJmjg5dqGPQ4x6yY3fS5MXa4DwcdaETKxdBLgDuTs8HFyp5lwXnNA?=
 =?us-ascii?Q?ZFPCwgW6ag4pErviyeRuM9Jvye9CyN/UQViEQgq2I62l1bfXQqtOFNOvlTU9?=
 =?us-ascii?Q?Xwo+32WJ6xOMXlxm9uSa1P+VF1jH2npKrt9LwP3ytADkt2hT/eFt3eYcty74?=
 =?us-ascii?Q?v2BcdLCmBc0HuiAmtrV5aZJ8RJ80pMNKvSZsDATQS3pcAXRHWG2xOEr2Mv1v?=
 =?us-ascii?Q?Z2cs4NGSOV1uyVYxvUha2uOlXW24ZcaJumyg5d/vPwv/ztvqbWvF7/5wcBVe?=
 =?us-ascii?Q?A62DpXM3KRIriLTmg72/0YDpSkrQbld/RX6cydSgyHy8YdpxncqmyhbrI5vB?=
 =?us-ascii?Q?ux2pNNoC97RQX26TxQCphN7iBVzV1MucTHsInigZTDtYTKVkGDFMD0Ujphix?=
 =?us-ascii?Q?TliXAC0BvaRiEPaMNB+SP+sWBTivg7rJtbyzYZWsg1aluo381BZx0pdoJo9R?=
 =?us-ascii?Q?HxZf/hlKU537jeq4c2uG7hWYF5hUA/OIaT2hI7dxbRs2P4PjDkyzBGv6HE8v?=
 =?us-ascii?Q?AeGkSbUoD6XhXs4Ik6y+1pm10ehPkDb0ZH6v+XUpO3+dfx+ItLPnlRPqbHT0?=
 =?us-ascii?Q?ul9o/ncniWpbhJeOABlqJUMe/MXDcYCKkVD8NAi5RxB9bGQtslFaO39nOziP?=
 =?us-ascii?Q?yXDjb/D2DIjat6HhprPUfmL2hjdcXq09TShiZN8Ls5LvrEbSWSBhsHQEPcTu?=
 =?us-ascii?Q?UVPmtkFPObNingSw0I1mBPiXy3uwYkpdtJrP4BgLDRAsiIemXtzH6FPEWLsD?=
 =?us-ascii?Q?IoJDh0jjOQHQsiUJFXf48pcl+/BjVrdMMiZcqTv4EmpWhn24uQuBA/OScTef?=
 =?us-ascii?Q?7yzEQJAHSwzJPVgHGGu0KBse0fOL4lHDTmyz+qtmnQngrR6yPKLUa1XnnuHF?=
 =?us-ascii?Q?oUlFleiTRWZ33GSh8lcJ7vE4sKwCZGgBWcoy3XVu0Pqe2aBUwOpLOkpNAu19?=
 =?us-ascii?Q?+7aoqWWrx+jf4tKKFGDnmUBz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5hg2xunVkLmJ7r2cl4WNMwUy1y7tg2fXBSgxrsL9tncQqSkp7cLPSj7SdzAv?=
 =?us-ascii?Q?9GTfmEzFn9144z9MxBcStit/t7pZrgVHf1yoAdm1A6kRIIu3dN56Y7qPhPal?=
 =?us-ascii?Q?PXC1HPCqRQ4yBAHAm1SWeeg4D9MAZgfk6Mvn+xWVaxWTVO6sNxEOZ1VB7Rma?=
 =?us-ascii?Q?UzVwSBhlNGY+10UrQ6tRYy18QkmKDocHe4lpZb7svd0w/72NfcwWqu2q+lUh?=
 =?us-ascii?Q?hF/lfqKlZvRVNAclZ5M0NYMeCWtx154BpIzV6+E8mggsJ+6+0TYDaUr2tLlY?=
 =?us-ascii?Q?iB7AKUXDMaMo5cEAKQx2EuAvKyAzv1N9ISKs/aoEOLVS2G0YZWLt0IW5ZXGC?=
 =?us-ascii?Q?2Xn5XvEsnsg/YsObeRiyVrDvhq0yAhd6NLhR0QuGiHMdZT+aN0FsSeaYI+m6?=
 =?us-ascii?Q?09iCgRhaZiTW9J2oYYErTZ/rBS/Zkb2aQeHOgy/ITN4SKdMSXiijX3KHjgbf?=
 =?us-ascii?Q?xXdhHbRmQGrpiVyZeWHcoyjXM/ssS3opxMRjJ8uhfnwMODx7w+01uHjVY1LJ?=
 =?us-ascii?Q?06g1/4Hr/gImozaFtRfEgZyBv3Ilzq0Pr80K8/ZYMclqpkBqw0hoCh/stta0?=
 =?us-ascii?Q?4KQ3wPnUdWmWavsL7PKR1hHxA/+xA4KwoPJnlP7VxEMayzvQ05pdy7zhYl0A?=
 =?us-ascii?Q?q/vzrZ/UVPLfV25eWElTPSQU6cRM6Js9f87G0YE709VWDwc55O81DEfopXTB?=
 =?us-ascii?Q?uRmIVYu51wEXvIov4Pa1IhcHcuq9Kahp5Br61T2HwloWOfDVSheao/Dn/Jqw?=
 =?us-ascii?Q?CRyDn5PNIAZ/23hGfJ7oy6UOAxgws3+ygQm0nVyYsBGbbAQ/mTXa8yXGuX+2?=
 =?us-ascii?Q?ENSA/t7kEdLN8T7mSY29xiIERc8LRJSAl1RoRgimH2HGvvG91dLIYEva1HDm?=
 =?us-ascii?Q?/V/vT3/e69NgOYa7sA5I4Ub69ZJVHFtd7TRIzOnXiAvYSwQfyW4JBZXYe/1V?=
 =?us-ascii?Q?jG+TwzSQ8+QUx5r3lD1Cke2fzTLz6bguXT8HaG0uoEsMz2RW2LQ8JYUrhBWk?=
 =?us-ascii?Q?iCW4POgCEopcFasVy8h9cov8axyN8Ib692EWQlyCiayO72eI7nb+ZYPEMnR2?=
 =?us-ascii?Q?iDaicf12ZPpjS4raRKG3DBgaeeb+vXzNaOftuSdG+MBbmhIIQ5wiM52R47PX?=
 =?us-ascii?Q?CYPG2q0LTW/DUZqYzYyaWu2jJlzJQrvKi2t6M9LMZ5yxpdSQVVAaWSVqfR6y?=
 =?us-ascii?Q?rG+Ox8u0dIsLSaKyvKwShCepxAPLRHl7vUQAKY02qrJJmod65jAnNS3s5+63?=
 =?us-ascii?Q?qWRaytpbjWFz00MI3Oz3imda688pL3RwLcXEf+W6gT5AhWe4VhvsY5zHE5xw?=
 =?us-ascii?Q?vcO0jzfL3h9GISWihzwUQ1K2A5giex40PPvjlRA0iP+h37EzSYCImNXqLz7H?=
 =?us-ascii?Q?ZvKL+KUCBYBhSy7PSxNGn0p4T9PNK15seYDIVgisyyAlyz8k60PvXcloBnXg?=
 =?us-ascii?Q?I2hkASWbZ16+ZRHNAiClLKM0cSYlxPHvG3QbuGCXla3Dj+ZZnINYaP2p9jH2?=
 =?us-ascii?Q?lufQywf6KuclW+ApZyIWaz1vC8JJ+TnHIYboFC1ljmruQSZ1IHPDGFg91SSY?=
 =?us-ascii?Q?zdcHk+b85n9Zr7L1WALq7Hl/cb4PEtXprq6S1f9TQ1hsUAAcOW8Mu8vqS/tv?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9zKGN+Ecg/bZFelpyyRj+xTb6G4fFxY7YGK0bIrmbLcVNpREoftPoMvzaF+xu1AacV0/pm80Gvrcu73pNL02k83doXBVPhD9Y72zOecd0MCuP4ZiIjRWz5zN47E0+HBS9K9Vki9OK4PQ3Zmdl0vPShCl8OL95yUNjcEHtNgp2k6gL/732Muvnh9mDp/UoNOlCtBpXeaOKPniyw9tcsJ69tNRZByGWCW1zHm1Y3gMpWRD23cOdqB1EELB13Ouk4Tu3CKMQakgFJtVhnsgfVyz9tI7Q8AkkEYmFArJffjVHyCNYiIy5dkGg3q/mAFZAHYy0oGiMqYj9dugrV8HuNYsqyc1kZnjTNTesoPY7am/AYyqf3GZ4v4lgl1DA8POz6cPsl86JY+aOBDmQxS2xaTeKmn/pFut8iGEN15hvBiFsHOdMcGyF4RyLvlJm9hW9ngd4kh/0poyEMNLFA9rQgdpVJweemgzy4IYq9S8DNCoQ1NRV96qRcSTn1PuC2+QuTTJ08bVX5k/I1edat+OIVBXTZH43sk5MlV54TNBNCmetKxZp0OJuxiiBWoEZFS7+9I2/bsuGvS6KyRz5YWo6wd46M1rfsY5J3Or8RN1KEUnrs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c02e0e-cf1d-4982-e7ae-08dceec429ff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:55:46.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRmW7NtkQlO7NkuEHtzPplAYZ5l+p+zluVkNavzymjOukMceJ4mRRHTikVKx/8Fuaxxw5p/ii6fhNZFqjkJdcaX5vDvlOKxbwIszPGrIWZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-GUID: gKDe7UYFlZH6zE5nZUad1jGfcBOgpoXD
X-Proofpoint-ORIG-GUID: gKDe7UYFlZH6zE5nZUad1jGfcBOgpoXD

Introduce a new system keyring called clavis.  This keyring shall contain
a single asymmetric key. This key may be a linked to a key already
contained in one of the system keyrings (builtin, secondary, or platform).
One way to add this key into this keyring is during boot by passing in the
asymmetric key id within the new "clavis=" boot param.  If a matching key
is found in one of the system keyrings, a link shall be created. This
keyring will be used in the future by the new Clavis LSM.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 .../admin-guide/kernel-parameters.txt         |   6 +
 include/linux/integrity.h                     |   8 ++
 security/Kconfig                              |   1 +
 security/Makefile                             |   1 +
 security/clavis/Kconfig                       |  11 ++
 security/clavis/Makefile                      |   3 +
 security/clavis/clavis.h                      |  13 ++
 security/clavis/clavis_keyring.c              | 115 ++++++++++++++++++
 security/integrity/iint.c                     |   2 +
 9 files changed, 160 insertions(+)
 create mode 100644 security/clavis/Kconfig
 create mode 100644 security/clavis/Makefile
 create mode 100644 security/clavis/clavis.h
 create mode 100644 security/clavis/clavis_keyring.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..d71397e7d254 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -645,6 +645,12 @@
 	cio_ignore=	[S390]
 			See Documentation/arch/s390/common_io.rst for details.
 
+	clavis=		[SECURITY,EARLY]
+			Identifies a specific key contained in one of the system
+			keyrings (builtin, secondary, or platform) to be used as
+			the Clavis root of trust.
+			Format: { <keyid> }
+
 	clearcpuid=X[,X...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index f5842372359b..837c52e1d83b 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -23,6 +23,14 @@ enum integrity_status {
 #ifdef CONFIG_INTEGRITY
 extern void __init integrity_load_keys(void);
 
+#ifdef CONFIG_SECURITY_CLAVIS
+void __init late_init_clavis_setup(void);
+#else
+static inline void late_init_clavis_setup(void)
+{
+}
+#endif
+
 #else
 static inline void integrity_load_keys(void)
 {
diff --git a/security/Kconfig b/security/Kconfig
index 28e685f53bd1..714ec08dda96 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -225,6 +225,7 @@ source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
 source "security/ipe/Kconfig"
+source "security/clavis/Kconfig"
 
 source "security/integrity/Kconfig"
 
diff --git a/security/Makefile b/security/Makefile
index cc0982214b84..69576551007a 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 obj-$(CONFIG_SECURITY_IPE)		+= ipe/
+obj-$(CONFIG_SECURITY_CLAVIS)		+= clavis/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/clavis/Kconfig b/security/clavis/Kconfig
new file mode 100644
index 000000000000..04f7565f2e2b
--- /dev/null
+++ b/security/clavis/Kconfig
@@ -0,0 +1,11 @@
+config SECURITY_CLAVIS
+	bool "Clavis keyring"
+	depends on SECURITY
+	select SYSTEM_DATA_VERIFICATION
+	select CRYPTO_SHA256
+	help
+	  Enable the clavis keyring. This keyring shall contain a single asymmetric key.
+	  This key shall be linked to a key already contained in one of the system
+	  keyrings (builtin, secondary, or platform).  One way to add this key
+	  is during boot by passing in the asymmetric key id within the "clavis=" boot
+	  param.  This keyring is required by the Clavis LSM.
diff --git a/security/clavis/Makefile b/security/clavis/Makefile
new file mode 100644
index 000000000000..16c451f45f37
--- /dev/null
+++ b/security/clavis/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SECURITY_CLAVIS) += clavis_keyring.o
diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
new file mode 100644
index 000000000000..5e397b55a60a
--- /dev/null
+++ b/security/clavis/clavis.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SECURITY_CLAVIS_H_
+#define _SECURITY_CLAVIS_H_
+#include <keys/asymmetric-type.h>
+
+/* Max length for the asymmetric key id contained on the boot param */
+#define CLAVIS_BIN_KID_MAX   32
+
+struct asymmetric_setup_kid {
+	struct asymmetric_key_id id;
+	unsigned char data[CLAVIS_BIN_KID_MAX];
+};
+#endif /* _SECURITY_CLAVIS_H_ */
diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
new file mode 100644
index 000000000000..400ed455a3a2
--- /dev/null
+++ b/security/clavis/clavis_keyring.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/security.h>
+#include <linux/integrity.h>
+#include <keys/asymmetric-type.h>
+#include <keys/system_keyring.h>
+#include "clavis.h"
+
+static struct key *clavis_keyring;
+static struct asymmetric_key_id *clavis_boot_akid;
+static struct asymmetric_setup_kid clavis_setup_akid;
+static bool clavis_enforced;
+
+static bool clavis_acl_enforced(void)
+{
+	return clavis_enforced;
+}
+static int restrict_link_for_clavis(struct key *dest_keyring, const struct key_type *type,
+				    const union key_payload *payload, struct key *restrict_key)
+{
+	/*
+	 * Allow a single asymmetric key into this keyring. This key is used as the
+	 * root of trust for anything added afterwards.
+	 */
+	if (type == &key_type_asymmetric && dest_keyring == clavis_keyring &&
+	    !clavis_acl_enforced()) {
+		clavis_enforced = true;
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static struct asymmetric_key_id *clavis_parse_boot_param(char *kid, struct asymmetric_key_id *akid,
+							 int akid_max_len)
+{
+	int error, hex_len;
+
+	if (!kid)
+		return 0;
+
+	hex_len = strlen(kid) / 2;
+
+	if (hex_len > akid_max_len)
+		return 0;
+
+	akid->len = hex_len;
+	error = hex2bin(akid->data, kid, akid->len);
+
+	if (error < 0) {
+		pr_err("Unparsable clavis key id\n");
+		return 0;
+	}
+
+	return akid;
+}
+
+static int __init clavis_param(char *kid)
+{
+	clavis_boot_akid = clavis_parse_boot_param(kid, &clavis_setup_akid.id,
+						   ARRAY_SIZE(clavis_setup_akid.data));
+
+	return 1;
+}
+
+__setup("clavis=", clavis_param);
+
+static struct key *clavis_keyring_alloc(const char *desc, struct key_restriction *restriction)
+{
+	struct key *keyring;
+
+	keyring = keyring_alloc(desc, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
+				KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH | KEY_POS_WRITE |
+				KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH | KEY_USR_WRITE,
+				KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
+				restriction, NULL);
+	return keyring;
+}
+
+static struct key_restriction *clavis_restriction_alloc(key_restrict_link_func_t check_func)
+{
+	struct key_restriction *restriction;
+
+	restriction = kzalloc(sizeof(*restriction), GFP_KERNEL);
+
+	if (restriction)
+		restriction->check = check_func;
+
+	return restriction;
+}
+
+static int __init clavis_keyring_init(void)
+{
+	struct key_restriction *restriction;
+
+	restriction = clavis_restriction_alloc(restrict_link_for_clavis);
+	if (!restriction)
+		panic("Can't allocate clavis keyring restriction\n");
+
+	clavis_keyring = clavis_keyring_alloc(".clavis", restriction);
+	if (IS_ERR(clavis_keyring))
+		panic("Can't allocate clavis keyring\n");
+
+	return 0;
+}
+
+void __init late_init_clavis_setup(void)
+{
+	clavis_keyring_init();
+
+	if (!clavis_boot_akid)
+		return;
+
+	system_key_link(clavis_keyring, clavis_boot_akid);
+}
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 068ac6c2ae1e..87a8bfc0662f 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -36,6 +36,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
  */
 void __init integrity_load_keys(void)
 {
+	late_init_clavis_setup();
+
 	ima_load_x509();
 
 	if (!IS_ENABLED(CONFIG_IMA_LOAD_X509))
-- 
2.45.0


