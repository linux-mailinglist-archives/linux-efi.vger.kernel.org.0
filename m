Return-Path: <linux-efi+bounces-794-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C6B87850B
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 17:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB542844AA
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A4D4AED5;
	Mon, 11 Mar 2024 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B6L2vYRW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RnFe+kFp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFF482CD;
	Mon, 11 Mar 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173983; cv=fail; b=V8ZuLdZHGraQP0E6w13e8d32Rng1ZzrVWpmmTRE2GAUWKjuTdWjIY13uerx4hYvjiib/hx9p1Nfp5ZitZiSbMHMsVW0npFhp0w6ERxI7K0Kjx3dsUpvgnOG2NEmHFo4ELN47QYgj8KGNwZGba8YL0n8Foiw16RsfHUsUvOC+6nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173983; c=relaxed/simple;
	bh=GSitH76pU34XvEuLyOIIVUd8hHEzgzppgDzxu7zCHss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1L681KrkIwFOJVp+gJehlXfilyx4nVQI4FVQjK+hQ2ZAUjKe+3xVrrGdg2a5GJosT4FGTSeRHvbbX290CuzFhvvzvRDmOOxKuMwcze04z2NpF3hL6C8V86NsV/QqBb4C68SAE0YTfDj/azwdtq6zRAqNMKHyNEKMfyQNbkf8qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B6L2vYRW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RnFe+kFp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG40Rw008069;
	Mon, 11 Mar 2024 16:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=BJr9RcGwSc4JLDRvLoY0l7FQdOkxq7x4rvjsHVHwkLY=;
 b=B6L2vYRWV3qPhn2jJsLRLZP/j0K3DMKmmcdNiI6FFNDwgY5L7m3RZIDtKdARDNt6ToJo
 rgASRmGlxtR4qGMWHOSpx4+5CoGrZJjofhiDCiioB0KlTXtNcAaIy0H3U7mHhvXNBCl0
 IfnUaTy5hL3aqPFa9AiRnSIcZFp1r71UVPZDhfLqWhX0fT3dc/NdvZPfH7du4YH6tMyY
 HC1djK2kI64ppqc/NymC8LvlrNtf2VTvzZG828sBeEOptvbSE8btZvLYBbtjcO64ZbdF
 cACB9lpF3lkd9a8IfsG5P7wOWqi3BdFR9ecCKJwHCur/ee+dK+OmG0ooX9LB7OwsukJF mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdbtka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BGBYTs033753;
	Mon, 11 Mar 2024 16:19:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75qxaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNil7QSNVtLPj6L1WSXsh64ySCesvvs5JRKlC1pkPujVh2NFfjOdawKGFEm2wWwBvug9rXhXad00/cJrc49TZfYQPuIrNuvTW+tCtGxthJK/Yj4Ri9Q5na2DH6+6ZIkQviAPIVWv3NZMSHvQv1vt0OKKQZWQvUNWGra3W2OOi+fUzusiOuGylesNWs1oNXxMMiI8FAZNN3NpAmohwSxJC8gwoS1qqBgz9Zm7K4/Cwp9LCMtVlHE1vJJ7JvkExj8KPhoq1pU2qVuV5FnicYt60NrUxPuYeRbxzXkgNSZTlh/9z1q8eW8LeJ8J6KDD9WYe6Bggp8jXRzugmsNrC+3clA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJr9RcGwSc4JLDRvLoY0l7FQdOkxq7x4rvjsHVHwkLY=;
 b=XC8hSaPj+AahLRMQKHScud+/spJqfODS050QQtM0/dfUvf2GXNqK2DvpZskqr/u3rDyDQ3mYLyhNf97ASTj57bYEMR+t/ACQRQdfr/dT8dyunPoxPSF+U/KjZYG4qEkM9SSXVKRhb94alX56hgpP4MRjt5LMo6x3SB24MPGbpHIGugB4gJKhWx5dPIlywFrlue6cnQoyJUzF8Pzhq5497I0ZMKIDUNXGYxhN6/yIwsMEUwwvjWRGy04xMpxrMojTgo8bhi/re9RcmJtkN8rUpWWJZ7pPBDVGZ5xr4Y0WcqBG8Is8xLVAeQOYmgs/OhyXevg2DmidZxDbNwAEMrxOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJr9RcGwSc4JLDRvLoY0l7FQdOkxq7x4rvjsHVHwkLY=;
 b=RnFe+kFpk9x4cpy+rN4FUMJeJLilEazdZl2uNvicd7/KEx6nwSaBLqMvPRrzaDdNJ3wfqzSnvbrVWms+LM6SqsoZpnWslzh5lGoqeQj+GeeLRA79dp1xCURO8LdIs/E2x2wElWjFTY6Ci4cQbK7zWOqsgUTKDwx0B4ar3xCmKuM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5119.namprd10.prod.outlook.com (2603:10b6:5:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:19:13 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:19:13 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, mic@digikod.net, casey@schaufler-ca.com,
        stefanb@linux.ibm.com, eric.snowberg@oracle.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH RFC 3/8] efi: Make clavis boot param persist across kexec
Date: Mon, 11 Mar 2024 12:11:06 -0400
Message-Id: <20240311161111.3268190-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240311161111.3268190-1-eric.snowberg@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::29) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c14497d-9387-4bab-2e24-08dc41e6fdd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	D1tv+08ocwCb9HrcmFGJkV4tN5rNfrXts3dbfsv5O4sYiJrCHhiGOKQxxqOqvZ1pyjsabW9U4q/+nffX0G1okz931v9FQVqfxFZEah8wleZ+F+LfxY83nHbiAdMLFSIXzGcL1E1kXxUxrH+md/xntve1RbQ/64v2P7KgfRRDZIUq28Kh6/2wLouhUR8Jc1DIMisZKfgbmMeUbl/rSR2usS/PlV5ZN4QdAburQCZTGomcCDx5fPldNcSYunNQdM0u7HhGwwJaSM9objGGIBbOD6VUpvFH9D/BpgCmv2kJVp1eGX2arK89Ursr0ObeXnvVpJ87ntEY4VZKrjQ8e+UAWqzan3u0spiVZ8YjldhSOeFxR7t0sTdHQfmFcgQE/MVtKtnfs3liXpDnIFxpezbcA6ADwlYQn+L7kBKgeTiUnXeGpFzHvHbMdj3XlDaZ4oHmiH19SJ+sg6XLf34fXzvV8uNb5IrGfy+xGTO6srZkZk2cZCHOwKxOPFS50nfJsrM80Xn3n6ifB/CX7Nas9vUuCPzhLOHMxTKIIE8+T5oKhr0krFt1Ih/pJOtJ95Yc0HtyM2gtUQzz0PpVUH74LQn/7PG63rMS1WerHPHv1dlXhXrcDdpesPSDzTX+jxlXWg0S0VcNL8XDjfrH2kEey32M+IPdOThAYEMX07ia/q80mvE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dBXcXqsO8gWc3koJmA5cyNVK0rog/nPWIxN6Cksd2uqcPzj4KFQtM6+V9PC/?=
 =?us-ascii?Q?1+nurztPH8IiKpxDfAer8iCafFHEfyDwqNXTnFarVEAzE79jLa9yxNGH+GH1?=
 =?us-ascii?Q?BhpMgywQv9a6TiUOzWDgWt537lW/TXvg0XPQAsVs7KWRhKDFrmFBDuJW1vhJ?=
 =?us-ascii?Q?Hld3uB0xh7quWLDd/nhhzLZKW85fE01eb/bNhQKX5d1Z+/68xa7PUMBeeGro?=
 =?us-ascii?Q?BbSpvu4z+8+liXcxjdg4JuNBXYYEAgvqO+b/LxFgrWZLN0MJhrIRVttmLir6?=
 =?us-ascii?Q?0RstBYg0xMpNkB7ve3STPMrPAgOWSEU2Vl08As1ytfnhHNIoFHVjGt5M0jz/?=
 =?us-ascii?Q?tDVb8JrbtJui9erksxmT5joTnXut9gh5G/R6WSoqPowcO+fOTk8qtbcnpY20?=
 =?us-ascii?Q?9/nhMVcYjLXeyqgoGyVsm9nJd2Um7xtO/WPXG/4n3RayUFcGMoDl4E0H376m?=
 =?us-ascii?Q?AQihOe6yW4Nxs2y2fpvEUjkw+vgRXkCXSJtSrWs/aYIE17pIsa7yrn3UIBLE?=
 =?us-ascii?Q?RzakMF4qzzUDTOnveIxW3J8lWyGSc7v7bz6+XtwEq2NXZ7d0Qa32WhBkV/ML?=
 =?us-ascii?Q?oxiKszW/P6OOshUi6VAFuRmcEudnHjFM7eGy2tHX3st7H/9qFrSQVfoStkL3?=
 =?us-ascii?Q?AFASoomx7rTlJtRWHSSibTgFOJHesHKRv1ulgAH1z0SDzp3ITjf2E1ytpgoX?=
 =?us-ascii?Q?9Po5GduAxpi1CJ5T7yYWOySfTyiSVxq2rZCV5NqgLBl4VbMQm2vDDs0BjPPy?=
 =?us-ascii?Q?K8XwA0IaYhyRO4aTDcHqHaXlLqmvgbJ6ybVfOK7X4gbDzkjlACKd4PCOKmBq?=
 =?us-ascii?Q?b694eruYZVwCZ0TGbF63XjhTWOKnOv8Fezl7D01XCL8MFNIqFmfcuwwoQIbV?=
 =?us-ascii?Q?aZHLqwVszyeGJuKkkyuGAgdt7m/pxt/jEn5SNLmKyMUmJ7fmKAwuE/slnTwZ?=
 =?us-ascii?Q?7yiPc8A6Fj0AAh+nw3fIC0XROCOsTDc0dmi1L9Rxgcp1poNCnwMsCH/kSDSH?=
 =?us-ascii?Q?N0W28LY/QV54XWKUSvXQQ/Pu0dnExOv78MiRvsyIVkwFDa35q36TVuPqPa9h?=
 =?us-ascii?Q?FAJDqoqL+Tf4ovk/38wY9lf8hlZ7mdaM0JkvazLf/0cyqah8oKMT4NWp6HyH?=
 =?us-ascii?Q?Qw2neaNJ0HMOY+R24ZYooMjJYm//lGeOVVsv3ZBC91+aDCh2UbLkpC9BHZYa?=
 =?us-ascii?Q?FtwsAKe9aGltPxX0xk11b4VgY+yhJATbzslPaD1Hw37IzBxR1VLc2JV5n7an?=
 =?us-ascii?Q?6NFAKjsbSWeyLB8qQzCz7viO0B45kxGwQj8hLqg703uJ46jUSX3dFkh60MFH?=
 =?us-ascii?Q?+FbW4Ku2szJALDnG4UsUIZZ5AsJqwiKugKjrxrzYvJmjz5+hPPFfHN4CJCVL?=
 =?us-ascii?Q?/THY8ZcyC+Iow/MgyhFHaWeYU07Wlss2yKSlGf2br4EAy2p+nOzlrpHtrzH/?=
 =?us-ascii?Q?2BIY2B/e4PjcTLa2fsdhiX8epMRroZqDtNw9NHw0gqhqv7PsZe1m4p+cmL0b?=
 =?us-ascii?Q?F6PMRXvZKZAaB3tbXmqLLtAsRWvQ0U8+EmMb8eoBfKH2STE20ZSCDfs5+cYO?=
 =?us-ascii?Q?ZM5JOreDWpxzv1S/35QwDOgIFbwpSFlQ6GVfOmyf4lSUMfH7ZilDrMzZLU6e?=
 =?us-ascii?Q?tFpES/hvCiTm/IASwZWYjDk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n2+MLyi8q/7YpbaaJ1e3AEAhC0YZi7liIP0KBPF140f15F2aw9pBfkUsH7lGaWymvKF75oMrT24e4XVYfVaPXdVoe5LhBGfP0MojRfF3Wpwl2cyVNgZ8GZ5NwKwDrNccruSA0iAESKAvfLcQ5SKukStrCD7Au6uhuXa9hr/VPUADmEkhJ2p1aqs9fQZiz5VYA1K+xq0JPnQ84VFB0ceqUGHqXvEAMBqJ3tiV3gf3g9oRMaFPUfVc7acj/43DIUbDK0cc+97/zkoIFVF2vbesBPV+A4nhUyErA1tRiMAMt5yEWt4SSKE5mNdLNSA9YkH2/p4fdAbBGPK0FuJeJTkeYFxh0x9Y9Y4nydS/D+JqnJp+p+ZzPWjL4ohjS6rTngfpIjtvA/c4B1QIj9Q9r7rVm3OTwfSOGlzwdQG7nXZtzv20kpql6cm5paP0VaV5go9Bm2S+uT2dAWvMhSNa9w28RaoF9Jm0/BWI7BWI8MX/38SsmEbRCn4IpnWlbga6GUiQ7RYwyANQ++h3o2WQMXhLlnMTZBd9ZAcKHwFniv85Ebt07p/jeFlCBYBzLrrGXgBfSDnqWDSMoCTpJ7rKchdYGrLYkSQZaDWP4rpmQ0TFg/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c14497d-9387-4bab-2e24-08dc41e6fdd2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:19:13.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGerSaY2/YGRHSlQAyyAFESyxGcoO0bwGRNuTILy0383Qkl0DP2075bSW+8Pt9QyWBJCrHydVoQg+hr99+6rug/VSH2e94Ck6GbOnYpUQ0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110124
X-Proofpoint-ORIG-GUID: R2b2nbVzclaVKTsPfJ1mirEdEp7IBwFF
X-Proofpoint-GUID: R2b2nbVzclaVKTsPfJ1mirEdEp7IBwFF

Add the ability for the clavis boot param to persist across kexec.  This is
done by creating a RT variable before ExitBootServices is called. The new
variable is called Clavis with a new GUID
193ccef6-348b-4f1f-a81b-0ea4b899dbf2.  This variable does not have NVRAM
set, signifying it was created during the Boot Services phase.  This
variable will persist across a kexec, however it will not persist across
a power on reset.  This same type of functionality is currently used
within EFI shim to mirror MOK variables into the kernel.  It is being used
here so the clavis boot param can not be changed via kexec.  If a different
clavis boot param is used, the one stored in the RT variable will be used
instead. Enforcement of which boot param to use will be done in a follow
on patch.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 drivers/firmware/efi/Kconfig                  | 12 +++++++
 drivers/firmware/efi/libstub/Makefile         |  1 +
 drivers/firmware/efi/libstub/clavis.c         | 33 +++++++++++++++++++
 .../firmware/efi/libstub/efi-stub-helper.c    |  2 ++
 drivers/firmware/efi/libstub/efi-stub.c       |  2 ++
 drivers/firmware/efi/libstub/efistub.h        |  8 +++++
 drivers/firmware/efi/libstub/x86-stub.c       |  2 ++
 include/linux/efi.h                           |  1 +
 8 files changed, 61 insertions(+)
 create mode 100644 drivers/firmware/efi/libstub/clavis.c

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 72f2537d90ca..8dcb5326d05d 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -186,6 +186,18 @@ config RESET_ATTACK_MITIGATION
 	  have been evicted, since otherwise it will trigger even on clean
 	  reboots.
 
+config EARLY_CLAVIS
+	bool "Early clavis"
+	depends on EFI_STUB
+	help
+	  Allow the clavis boot param to persist across kexec. This will create a
+	  variable called Clavis with a 193ccef6-348b-4f1f-a81b-0ea4b899dbf2 GUID.
+	  This variable does not have NVRAM set, signifying it was created during
+	  the Boot Services phase.  This variable will persist across a kexec,
+	  however it will not persist across a power on reset. During kexec, if
+	  a different clavis boot param is used, the one stored in the RT variable
+	  will be used instead.
+
 config EFI_RCI2_TABLE
 	bool "EFI Runtime Configuration Interface Table Version 2 Support"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 06964a3c130f..c4aef94d877a 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -85,6 +85,7 @@ $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 				   screen_info.o efi-stub-entry.o
 
+lib-$(CONFIG_EARLY_CLAVIS)	+= clavis.o
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= kaslr.o arm64.o arm64-stub.o smbios.o
 lib-$(CONFIG_X86)		+= x86-stub.o
diff --git a/drivers/firmware/efi/libstub/clavis.c b/drivers/firmware/efi/libstub/clavis.c
new file mode 100644
index 000000000000..3a715e87a13a
--- /dev/null
+++ b/drivers/firmware/efi/libstub/clavis.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include "efistub.h"
+
+#define MAX_PARAM_LENGTH 64
+static const efi_char16_t clavis_param_name[] = L"Clavis";
+static const efi_guid_t clavis_guid = LINUX_EFI_CLAVIS_GUID;
+static unsigned char param_data[MAX_PARAM_LENGTH];
+static size_t param_len;
+
+void efi_parse_clavis(char *option)
+{
+	if (!option)
+		return;
+
+	param_len = strnlen(option, MAX_PARAM_LENGTH);
+	memcpy(param_data, option, param_len);
+}
+
+void efi_setup_clavis(void)
+{
+	efi_status_t error;
+
+	if (param_len) {
+		error = set_efi_var(clavis_param_name, &clavis_guid,
+				    EFI_VARIABLE_BOOTSERVICE_ACCESS | EFI_VARIABLE_RUNTIME_ACCESS,
+				    param_len, &param_data);
+	}
+
+	if (error)
+		efi_err("Failed to set Clavis\n");
+}
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index bfa30625f5d0..0d9c6ac0a652 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -91,6 +91,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 		} else if (!strcmp(param, "video") &&
 			   val && strstarts(val, "efifb:")) {
 			efi_parse_option_graphics(val + strlen("efifb:"));
+		} else if (!strcmp(param, "clavis") && val) {
+			efi_parse_clavis(val);
 		}
 	}
 	efi_bs_call(free_pool, buf);
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index f9c1e8a2bd1d..16e50a124ce1 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -183,6 +183,8 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 
 	install_memreserve_table();
 
+	efi_setup_clavis();
+
 	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
 
 	free_screen_info(si);
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 212687c30d79..81a1f013f483 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1060,6 +1060,14 @@ static inline void
 efi_enable_reset_attack_mitigation(void) { }
 #endif
 
+#ifdef CONFIG_EARLY_CLAVIS
+void efi_parse_clavis(char *option);
+void efi_setup_clavis(void);
+#else
+static inline void efi_parse_clavis(char *option) { }
+static inline void efi_setup_clavis(void) { }
+#endif
+
 void efi_retrieve_tpm2_eventlog(void);
 
 struct screen_info *alloc_screen_info(void);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0d510c9a06a4..08bd6224d17a 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -928,6 +928,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	setup_unaccepted_memory();
 
+	efi_setup_clavis();
+
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("exit_boot() failed!\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index c74f47711f0b..d0fe291d433e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -420,6 +420,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
 
 #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
+#define LINUX_EFI_CLAVIS_GUID			EFI_GUID(0x193ccef6, 0x348b, 0x4f1f,  0xa8, 0x1b, 0x0e, 0xa4, 0xb8, 0x99, 0xdb, 0xf2)
 
 /*
  * This GUID may be installed onto the kernel image's handle as a NULL protocol
-- 
2.39.3


