Return-Path: <linux-efi+bounces-1086-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB828D5710
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 02:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78DE1C21BB5
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 00:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97B34C84;
	Fri, 31 May 2024 00:41:41 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3A51C01;
	Fri, 31 May 2024 00:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116101; cv=fail; b=PSrjsVWWbhTUTvO/soeEMAdKOYg9ZvnHoa+v29uwuH5DQ+VaFOoT5zUUKbbFwrL9tkqet96SbKnyn3GajVVb9mc4DnX3KAWITeOxm9ZjaGAQO+Gtiuzfd9MpfUcXdeibBMf2btjhVRdRh05kRhnULm7U9sAuhNiCxvLIgn48P7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116101; c=relaxed/simple;
	bh=Sd0cwxyJY6h6wY/6nyui2VL2EdFETwmMpOyo5EuAF+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GPLfVPX7y9c+IDQ8lne8rYT/a8Nc9jL4XISAeaXidnPvz4Tf+vqilaMx2RLzIsW44P59lW6Xm2gQY09B9e50xtunGBKVSEECpjcYAvbqlI9VU+8Xq2oeMcNDcCVkp5SVs0mnsnib18fQkdFUoNeHhW/6LUHIs3Fv7J61aGyqSd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFTf6h001883;
	Fri, 31 May 2024 00:40:08 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DQSLMKUNClh/CEDQrZ+3i0A/uuUmEr6AYabeAfEGWS14=3D;_b?=
 =?UTF-8?Q?=3DH4eQ9QGQSQjSIrEkHbdDFbPCjI+FMdlsuX6fhpZ5z2c1KGsWUcaWrAQw8KNl?=
 =?UTF-8?Q?3bYsrrAn_263+OkbCOZJ8q//NbiIyjoFKN0fW7lKrXutindR6AE5rIGBr4DlWQR?=
 =?UTF-8?Q?4/AkJNwPLUPDxo_+0AKqxfzNZczfpPl/fl4IVBisYgdnU69Z/ZeXuGXPfhDijfH?=
 =?UTF-8?Q?ChXv+cFDMr50UVSoETrI_7EhZd8fJDOHZsYbGqPM5z43/AJCpCxbF+l+INUQJlc?=
 =?UTF-8?Q?8SlaB4a9WSteY46EeIqHld6tq2_YzJYT7uUunYOzYsOkHMfwusK3dnMlhwBOJwn?=
 =?UTF-8?Q?sRTmakDLwFs5usDCzcOH0X3TW1Pbm5KX_KA=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kba716-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UMfwEv026627;
	Fri, 31 May 2024 00:40:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5098hkr-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niGLYvfjv54daH7q5c5MyhXF2K25KlIjqO/z3IOpXNJmoeOYpRKn0Is7/mmN/3ZIjpf4Q9tja0srWOZG5J0qHPSiqyHPoozY8Cgc45o0oVR7G1Z8DFpQ7pHPdZFI8U0nWdn4CPfivTrfc1AMY5Yfz0aFsS0e/3CJm3wwFWdN+HRE65mj9QJJaV3yi/nZ851fuzER/KNs4hPDVeP6bbxFOLKtiC/CwgWuULl/2z0Yy4cxFQj4MoxEO3+tvcIo47mfdE3qqQFT9KzdLvIQQ1hqoERGjthgSmdh5NvuIGHO1OTpYHSsVdrlL2tGVOAL0hK3G9/zOVp4StDWjYUAjVwo6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSLMKUNClh/CEDQrZ+3i0A/uuUmEr6AYabeAfEGWS14=;
 b=aNUwiQ04dQb0dl+bDuHJXuFIZ2f7fu3ETqpx8VkJKu/4i1M7C/B96r7WCp4uKLs0ps1Csbzy4VDw6+8NmzuXW46IVyf+miw0FvT+ceqjUgGGPFL0nTImurTNCkFaYPcNP8D1lnIq8bTuL/Zbpym7BrTcg3WkOUXAr3OyRn832LOg1qUTM51LmYMTwrk3KTNLo66VGnq3rdV5x6jApeaKQL0BlTfvQgYZMDDqQUr8E8v72kIi8Am0YC4NipIDxbB8u/OgLJTX1KmApJnVgGmQyD7OIPWfbES8+Xv9kuRjF4aFvDx1S8Dhm9cudC/O8383g7hMLTyREHuNU5Sk2Rg4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSLMKUNClh/CEDQrZ+3i0A/uuUmEr6AYabeAfEGWS14=;
 b=WAjxfKHt4344MfeRmTIBIX7ncLXAtYknOKtsIcpUV+TJNxJjxAwPr2OziNrMlBs/puLJfQH+mZ9k253C6v6NQA/vspPyX08vxU6l9MZDoatxY3e34juZhnTWwX1adzeWn5uPjBqEWqPpAyF53HD6OvF32yTixkm9ee61sFTqXfw=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 00:40:00 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 00:40:00 +0000
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
Subject: [RFC PATCH v2 4/8] clavis: Prevent clavis boot param from changing during kexec
Date: Thu, 30 May 2024 18:39:41 -0600
Message-ID: <20240531003945.44594-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531003945.44594-1-eric.snowberg@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::16) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 203683a2-130b-433f-7ef8-08dc810a342e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lMsCURNOhz+ZJJ22B3a5zimfet9XPNdtJG/pQeoJz7au9Sz7w7jls2WJkCkb?=
 =?us-ascii?Q?8M9ThvySVfbB8gxHAdbP+q4z35DG75mvAKrk1pHt4uAoW34DveyKOzrelTm3?=
 =?us-ascii?Q?3S06VSvUmhnde1NkBRUdJzTi7hccyhbJYq5/KUlD4uTfz/Cf7zUEA0PruVRk?=
 =?us-ascii?Q?3h8frSDV1X/tYjRwArhNDWM9lwugKLrJTYscMU0AFpii4OsfCe1vPyDGm6hm?=
 =?us-ascii?Q?A+W+dbf9OnTxe26kUBCNMSiMHkxjCli8qYSjGg656YuzS4CCGNUqE3Mb99xS?=
 =?us-ascii?Q?uF28MmlQpTEdG2Yqtq6B3eIOGrQVAP65jDJvYEx/NewoiCbVoUzDO8lvCmJS?=
 =?us-ascii?Q?di4SB7qTTV/PZier7vAIKyc0aARcDaStTCzdF335lcY0fbM96GV6v10FWveS?=
 =?us-ascii?Q?fsOq3HEOz+GcI0iAb3pfDbsUpVJyQa0IM96SS/hQ5q11QFVP3OBBvj6Cd3uX?=
 =?us-ascii?Q?Tk96G2Xgc+2W/nagm+rlPlmzwZk7nK4VrHKuLRdEvb5CzHDjwXcIrAm3+yOJ?=
 =?us-ascii?Q?0W/vEK0I1O5j4CkU7RcE92R8LHJuHPySSspTFwY4pDMWw6vSVxeOkJGEpCG6?=
 =?us-ascii?Q?zMivo3S9QMj2jJZrr76R3GDnhpCxQDW2zATcsKOh+TLOhwniPIdH4VsKILCa?=
 =?us-ascii?Q?+IF92gVhANM0zdPU00jFFALLzED1rGh0+xVS+ukDV3h6Ij5LHzq/Y49cqvAP?=
 =?us-ascii?Q?dFo8k4VUx9chQ/gcy2MxeRbRvl+04fMzbKyEvHQqmvBxrFA1nkvkWXzDxaWa?=
 =?us-ascii?Q?BrZTKPZDeicyv4eV4wcp2Yx/N+5gJpFp/Zg1EJgWteLIhHcYWEL5Y7O1NUTe?=
 =?us-ascii?Q?jYiyvNrvHA63/nDS3qQRDThXsTw1fLU/T4ctA4PEtF8mf2xK5fdAMtkhXFn6?=
 =?us-ascii?Q?QLUZZmhsRUl2meV8olgpZRivsMlpvDg6d6oJmruM/s/KXqkyoQdCvA0Fb/iC?=
 =?us-ascii?Q?fRpA4z0179g7L7K1F5apS/h3RRS28P8i0c2W7XnlPrvKEzKSfKX8xQLXvpNJ?=
 =?us-ascii?Q?bjMYf7TnMycJUDd2Lt8Htnk4ED8p/8J2nZFGQSWKHcFcRNnvVk2uP9Uu/4Fp?=
 =?us-ascii?Q?g/N8Bel53Q0z+wQ5sV7SB5gfjB51I1aFQEGkKBUG6ZV51XeTlM+fXkIVbqkz?=
 =?us-ascii?Q?XTl6cS1iEWlJNEncsUJmXDEtmIlccxgtMGo984DStJPe99+SNorB4DNYJQnA?=
 =?us-ascii?Q?ikLiBYVdtbM39ggepegECA1y+gzMdlXCJ4e4qnjZOn2B7r9JYDLLH475DSAV?=
 =?us-ascii?Q?7aUi1SyBzRX4OoN5n0vO2PPhilgCLikAUBin4y3tLQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Z5K/UmZHj0KYEQ8slim0x3lgPHb7fFLpCdAMzWhOU3vOgJ32nnkuI24HqM1N?=
 =?us-ascii?Q?dM5G0KLEhyZ0dN8mgi50duvnLW/TlBXYh2/pl1XQ2TPc9ZNmiz2Ky3HjbsPC?=
 =?us-ascii?Q?a4OoDH0IVvLMtXSHLJDnY/n7WKeII6P4OusfyXg9y7y7xlL+ylD09lrsSUxC?=
 =?us-ascii?Q?P86xG3q5+r+EWt2vSPEdhXWtxCMeJWqAg0uo8/IKfBxMEbtaoTI5GsPO97X1?=
 =?us-ascii?Q?d7Y39ILqFB+hSRh/hi471Av306WUgW+20NCkh5mVUn1eeafmNpue/7Si3p7U?=
 =?us-ascii?Q?GlXUO9MDWMcXrVxaaE4BHnrew9r55foTtRyLXRz1AJFkXyvp6reK/sMH2bon?=
 =?us-ascii?Q?dh+uMryblDv9hffk13mP8VT/YMpfRSFarBm8ktuB7sgv4HsGjnT6RVbke0qx?=
 =?us-ascii?Q?xP3vh5dkDP2LKNRpEM2Re9auLDU/ZABUTzeBsHN9AhJn013sMgA7DSnS0SMo?=
 =?us-ascii?Q?G0df9eIIY0/YWkpvPfF2mbSQ8mMiENlP0VvmqF6CnPyzqqz7iY7oDNS2nFKA?=
 =?us-ascii?Q?avyfoc/XJuRXa6S070PRielOYDxb8QSqM7i/CHnBpUoYwGRPCiDt0T2W+E5a?=
 =?us-ascii?Q?+SUYDPTJfPoGocSuzS336bZCFddj8+HIfrN99kyGKYHG6UP8sFENZmRwVhzk?=
 =?us-ascii?Q?nWd+3j0OtllfcxIWKxVtr3BPbqCA33TqPnz5HYbSklh1Z8235wfZH4DU+vCu?=
 =?us-ascii?Q?CsevaiAEsxGf/mfGkF7W64HSedXje58Vey+N70++SDsB3RzrHnTBHEcBvTlB?=
 =?us-ascii?Q?jvVRVVuXjROg0X4pJMaJJUy+5PTnpPUrJDYkyK9sJJfCK0YqjLurv0Mx3g3P?=
 =?us-ascii?Q?wlW9/1GR48WEAd6N4CisGUiR4+RuXwJPZ45DL7jI/NGqregXITtegsEhEYrS?=
 =?us-ascii?Q?2SWuYPfWHIVdRPZlTGK4ETz7756KEz0/DDNUtp5dne4YE6hfFpQlFd8UqnPw?=
 =?us-ascii?Q?tdK+OVFc/tNDLpArJMHKcff9KmOJRivvX3R2a9uqlTLPNYaMtjzsHBYuHrUB?=
 =?us-ascii?Q?vpUTJf0wSnKKq3Bk6q7RyNQWQFbPNHMWZgQwgEuWEzsUTSivW6bnhDG3A271?=
 =?us-ascii?Q?BwH3Jng46uYZ4GCTynK8zwz7LuxlROECpqhkYhXBThVs0u/XTUNJ/w+/MT1e?=
 =?us-ascii?Q?qEKgo8PSTE3g4GQKwBKUruleTZxdTD2DPdKI//gKGubVF711coOE4WPDwRvH?=
 =?us-ascii?Q?4byxzJBfs9UH1Wwp2ef+nRR5EjH8nwyZF+PJ5cv+L/LY0cx4EJAG5M1NMKLV?=
 =?us-ascii?Q?7HL2qE3O6D6B5hmuo1X9fuxIwYOysvUdplsXBlBJwMOuGM2Cof8VJ9JzeZ5f?=
 =?us-ascii?Q?WzTdSU3e4GxtbZPerL7IbKYTwBZ8ckSksPS/YOh/aOMJzWOyNG6oSMJxJLut?=
 =?us-ascii?Q?tZIbZYO5fGUztGPUAuDoVxo8ciI3KkBTbM332fH1wnx0YYJerKwaK3J5YYE1?=
 =?us-ascii?Q?vXdRHvfAMnplGBKRkBLA6mAUq1lfuvXINONBQjx1q+h9DenwUDuVvGBsJnqE?=
 =?us-ascii?Q?NxZNfPUqXrUu3FwPSKL0FXlod8mYk9x7mcjjCavIk2/naDztuDW/3fE+8XQj?=
 =?us-ascii?Q?Uo81hwqDpwT06vZ8Mz+GorVaoWrWiR1mESQsJDTpZeh3u3M7V5bVAgB9OUB/?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fAm1ExtXINbdEf3RcnYo1wSxEaHDyhL8nR5/YmTj4xKClTTvRWPBVouFpPnL/BDCEMCFPsmXkX+ewQvMjgGfSipD5iXX1Kfy2yWKb77bcPS6X2Z9wertO/w9EFqymEjrQLHCfsMNCMxweT+fvjRUNj8Q6Xs7v/bFI2qHuIIDJQnlP421xCGD4cTDhpzP4ecHiMFEAFn/7k742PBi16iv/U1U2gNMm3+Sm83mX6lM5TKD15cC04mKvshU13Ko7nE4BUfZqHjX2tfiX/5odKUt3jZPUtmoTs2iPVYLTU4GsyxRbjeTPv1kze4xGwM/xHXS2xwUy9GqEBsZj6Qf7zh8uVYw0ZQh36/mkjhy5tNe9QQcOJq6wScDn4vFp31gJqhy4N82HD+HDCW1n7YDshCT102oGuDOIJBszK2C4PMP7VkXv4S14dcPO58IH14TtABlkitzdWIbIk72AN1Uj4r42xpsY2qcTreUYV2qD62384d6v8QN8NUP1hSY0V/ZgAPKUlm5l2Ib4/h7BTLANBOqeCWX093jhAFfbAZ4UVQpu9E77lrObAldMfQSeEz6QOjXUr3SDv6LazkoDSAQMxnNKvD9KcK42EjtYDQP4xAU1VQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203683a2-130b-433f-7ef8-08dc810a342e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 00:40:00.6416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFYhyUYLtQp6VCJHEowhAgtR0gzoCAfHVIlXLPRbBllnPO0O0WP+HgK7eteSxHja03IzKP8bI2FZOTfR+sLGUCYYw6uroJwBcBfbZeFUy6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310002
X-Proofpoint-GUID: uu5oTWAKubcqvPBfuB6EWL1eXVJWZJ9N
X-Proofpoint-ORIG-GUID: uu5oTWAKubcqvPBfuB6EWL1eXVJWZJ9N

Use the new Clavis EFI RT variable to validate the clavis boot param didn't
change during a reboot. If the boot param is different or missing, use the
one stored in EFI instead. This will prevent a pivot in the root of trust
for the upcoming Clavis LSM.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/clavis/Makefile         |  3 ++
 security/clavis/clavis.h         | 16 ++++++++++
 security/clavis/clavis_efi.c     | 50 ++++++++++++++++++++++++++++++++
 security/clavis/clavis_keyring.c | 17 +++++++++--
 4 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 security/clavis/clavis.h
 create mode 100644 security/clavis/clavis_efi.c

diff --git a/security/clavis/Makefile b/security/clavis/Makefile
index 16c451f45f37..2b2b3bc8eef4 100644
--- a/security/clavis/Makefile
+++ b/security/clavis/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SECURITY_CLAVIS) += clavis_keyring.o
+ifeq ($(CONFIG_EFI),y)
+obj-$(CONFIG_SECURITY_CLAVIS) += clavis_efi.o
+endif
diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
new file mode 100644
index 000000000000..708dd0b1cc76
--- /dev/null
+++ b/security/clavis/clavis.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SECURITY_CLAVIS_H_
+#define _SECURITY_CLAVIS_H_
+
+struct asymmetric_key_id;
+
+#ifdef CONFIG_EFI
+int clavis_efi_param(struct asymmetric_key_id *kid, int len);
+#else
+static inline int __init clavis_efi_param(struct asymmetric_key_id *kid, int len)
+{
+	return -EINVAL;
+}
+#endif
+
+#endif /* _SECURITY_CLAVIS_H_ */
diff --git a/security/clavis/clavis_efi.c b/security/clavis/clavis_efi.c
new file mode 100644
index 000000000000..7bc8ef03794a
--- /dev/null
+++ b/security/clavis/clavis_efi.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <keys/asymmetric-type.h>
+#include <linux/efi.h>
+#include "clavis.h"
+
+static efi_char16_t clavis_param_name[] = L"Clavis";
+static efi_guid_t clavis_guid = LINUX_EFI_CLAVIS_GUID;
+
+int __init clavis_efi_param(struct asymmetric_key_id *kid, int len)
+{
+	unsigned char buf[64];
+	unsigned long ascii_len = sizeof(buf);
+	efi_status_t error;
+	int hex_len;
+	u32 attr;
+
+	if (!efi_enabled(EFI_BOOT)) {
+		pr_info("efi_enabled(EFI_BOOT) not set");
+		return -EPERM;
+	}
+
+	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
+		pr_info("%s : EFI runtime services are not enabled\n", __func__);
+		return -EPERM;
+	}
+
+	error = efi.get_variable(clavis_param_name, &clavis_guid, &attr, &ascii_len, &buf);
+
+	if (error) {
+		pr_err("Error reading clavis parm\n");
+		return -EINVAL;
+	}
+
+	if (attr & EFI_VARIABLE_NON_VOLATILE)  {
+		pr_info("Error: NV access set\n");
+		return -EINVAL;
+	} else if (ascii_len > 0) {
+		hex_len = ascii_len / 2;
+
+		if (hex_len > len) {
+			pr_info("invalid length\n");
+			return -EINVAL;
+		}
+		kid->len = hex_len;
+		return hex2bin(kid->data, buf, kid->len);
+	}
+
+	pr_info("Error: invalid size\n");
+	return -EINVAL;
+}
diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
index e92b8bd4ad5b..1225a8ee1e5a 100644
--- a/security/clavis/clavis_keyring.c
+++ b/security/clavis/clavis_keyring.c
@@ -4,6 +4,7 @@
 #include <linux/integrity.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
+#include "clavis.h"
 
 static struct key *clavis_keyring;
 static struct asymmetric_key_id *setup_keyid;
@@ -82,9 +83,21 @@ static int __init clavis_keyring_init(void)
 
 void __init late_init_clavis_setup(void)
 {
-	if (!setup_keyid)
+	int error;
+	struct {
+		struct asymmetric_key_id id;
+		unsigned char data[MAX_BIN_KID];
+	} efi_keyid;
+	struct asymmetric_key_id *keyid = &efi_keyid.id;
+
+	error = clavis_efi_param(keyid, sizeof(efi_keyid.data));
+
+	if (error && !setup_keyid)
 		return;
 
+	if (error)
+		keyid = setup_keyid;
+
 	clavis_keyring_init();
-	system_key_link(clavis_keyring, setup_keyid);
+	system_key_link(clavis_keyring, keyid);
 }
-- 
2.43.0


