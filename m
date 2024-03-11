Return-Path: <linux-efi+bounces-800-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CB6878539
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 17:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3886281D12
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8851E5E09C;
	Mon, 11 Mar 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eXmnghvy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sUZ0cbqa"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B85E07E;
	Mon, 11 Mar 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173995; cv=fail; b=ZDHjcWXHuzStZi3L2VasAA5mSl4VciMGCbc9xFyROjnfyzozt0HkB766WFw4MgPEGY+fR2PrcPDr8Zoy4AKQIDCWsPktPnONwyncnDeCnJrc0wN9wSSnYgM2oRRLNHGjB9iW1ZgEL3iNX1sfapCFZQBBSQs20NpdLqJ6Lz50JEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173995; c=relaxed/simple;
	bh=xcrhHqLX1QxvBXLNbERqRhW3R9fU/hZftTHRlhmOTjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H39slwnLoivsbtkOkOJpIRGre0ZuxlnMBDTkR/ydvbN82f3wsUvJAxrdWHynTfO9UYq0WG1typHp2uDZ4mPaJCO/h6xylMoSTWaTe8n+mgGpIH5Vlj1tbf1ji3kM2cqHd94xW9QuXvQy0O2Ef2TP+msw83X8GzaeQuBQMY8dVlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eXmnghvy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sUZ0cbqa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG46Rs011922;
	Mon, 11 Mar 2024 16:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=lE3zGi4lx+LX4xh6HplVkjuqDf23NSoKJ1pIIqNEmH8=;
 b=eXmnghvyqxY56qagtRq9Zw64OicbEd2qbCYvXMX62HPZENT4SzWB29Xz8rJHFP0emfMr
 nXh/9SduNUBxSHEao+nMGwBVAWvZw7S3fp6ZhXn5xHsOMDTNV+qGJdkIGY1Czp9h0PAE
 yG2CtuphLAuO+SbhdSJEvWo7V5NTY7wKvkS56gkDPcJw2SPDo/izKWaLAFioqUXHSiEK
 iCX7vr7uwlcOm8kKChejoBhdlN7ICpO1x5kvk39J5ZxuJKPx/UysJwUOOXCvvlvaKhSO
 gnqBPC1bsSrj8TR2HXZ82iXpxI4RLShDcB8S3K/s4a6aCtAfq8A1diLv1ulGryO4FeGu /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ebskn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG7DMk037978;
	Mon, 11 Mar 2024 16:19:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75yaua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iz4AYFPH8sdo3u90Z/CTmWRCh5o2Vd8YJWwITcionmFEkEC18H8C4n6yEVQUfMoWff0J+/7vx0JoWLk2eMbIO5p/e/B83r6G/SAX5lRq5tJ09TlNjG2UpnOTjDfpl9nuUCNKbvs25zxPmYf7a89xyEHRb8qiiOHW0/V8uxkJFsmxkQvKle32WT9IIgN9f2ssB73jjzrtHSHSK3NCscU2XCreilQ/R7yQ4rYhZqdcrFCTZ+WR18M+qZQlcCeK8aQMjV0dawO7Zi9uuqzrnqOWw0Yd2cVFvTxa46EOs4NNtikkIQQBcNzvSdefl4y+cYEoEECxDoupcdpOEtkOiAe74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lE3zGi4lx+LX4xh6HplVkjuqDf23NSoKJ1pIIqNEmH8=;
 b=bC0jbtv2JdOzB+nNpfOG3r1IS7cSwnohuToPYA4CCz92EX3nie0kt+fB1SPiMxq4Mhi170266srdkN7rFPzwQH/PrEK3ckruHd5PKaEf85+OD3l6C7EbPjP4lTeys4tnDuvTbfxIS+0RZtU2Sg8Hv/ds8bAD2oYIvRBkFw9AkvQOEvmLvDoLRzIE6G44fyrZWCexXyI8Y/fpZCG+Skd4UW5qbu6UYxBQEw/9AM55CCfdXVEw3ymyPSZGjKJCkf7KV07bwKfaOHJGAnSxB71UHGYWM8VfgDks05kBkvOuAXTI0rd8DeEDtZTD3YVzyRYbJ4UjZE4FUmKpxLLquOPv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE3zGi4lx+LX4xh6HplVkjuqDf23NSoKJ1pIIqNEmH8=;
 b=sUZ0cbqaYo+aTfO8v67aVeBPd8w6ZhM1JQelDA3towc5Wd0LSNMyNfsfzrYeY4+gRzP72/qCLPjuEF98EjX5xm9Ebr+Z65T+s1+4ZXPDLRX8uF6XfGGgjsNWzHgkfRqQfgxsG4rXfJ8kA8/WuoBPQ2XsGA+axZi8OKr4Ckh4AqU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MW6PR10MB7589.namprd10.prod.outlook.com (2603:10b6:303:23b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:19:25 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:19:25 +0000
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
Subject: [PATCH RFC 6/8] keys: Add ability to track intended usage of the public key
Date: Mon, 11 Mar 2024 12:11:09 -0400
Message-Id: <20240311161111.3268190-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240311161111.3268190-1-eric.snowberg@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:36e::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|MW6PR10MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 184d2b49-4e09-4190-b7b2-08dc41e7048b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RzyadAldFzjpXeIb1ufuyUeGYRkTl0rS4gY9b6VKC1zvuSlwMw8dm2iEr+BZ4DMyKB0pR+Z+KkM1f177JT3v+BvUfHXXPEoDzyoZC1fkV26W8U0jzS+GhI5PekmQOymwOXRoGOn1Lmqy9iog38EWfS7Doyz/0pf1Tb2SFuZ47s6PFQ1bAQW2YtFyzFXao2tv+j8pcCxvEujY6WYuCELv9OLVYZLKCz56mD7gBHT6I0AMBPusfFtHthBHyzSjQfPTYuZjE/JuSN5aKKeXCCVctMmBeMFAnw0iUkZDu3LH+piy7wyV1iHCMT/80c7+uYCtCDDkIbPBkVW34eSiJZsuUApn2EDFlm0JbzIRBUGQ8evaOWbuFbMhLz28jfA/qRJVstFCa5GJZK5/HE+UMukGBZoq4ruGeu8fb1YBXWUcySHjLpjt1bDC61n1/BF6zPgB/hdlY8FHBeq1phn+hEr2yTK5h8x4WxKSh5/CFKzSGP8BSHjcddAcVn004NA0c33ELnxvOl/nv87fmfQR0TmF30yFcyQFWQki77IEEV+y/OshJZPe2jwxPddO07mnn40MUXLMTHE0r2ED5fMXS+93nqXgjsXaJ8pUwKppnD+PG4LrtwLjUM7JbRYN6tGHuuNbJJEOZM0YjLHQ31sNZwqjSlf9EoRadA4M/pnLpH+ngeM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ph3P5hCXQ2liPkTTaqGm3dwW9+2/XcnKHx0X4lzKmvPh56/eksJJAmEhFdjd?=
 =?us-ascii?Q?7pGG5dreavXZDG04xAYDcmiknGUk205H8qNUp9iPav3AT7wiIEc60o5VB/1v?=
 =?us-ascii?Q?metTPo7pPx5qHN4F9CCFtP1VEwX7JlXfev69/sL6Hst8f6Y+TWMjAtjyPutl?=
 =?us-ascii?Q?B9QI/3HTA9H3bXXOVYCzUAMcggYKDvSk85kbqPGFXTnhdWOeAf+2RBxk3Rj7?=
 =?us-ascii?Q?fhSVpQpNPjl36OADJuBVZTdPrL14wbkKsgkClNP0r1GIP1vyoVt/+N0fNXr0?=
 =?us-ascii?Q?O/6iBlz3dcWwZLjPDmGwJMmeolcTiTCPuJ8GV8mTYYYPfAp3TPn90GDCayV+?=
 =?us-ascii?Q?nA1wD3WuwHKorjhZAXpisgTqLBeHTePjEQtHA2vA95UgJvPUf4XhovvSiecV?=
 =?us-ascii?Q?k+YWjIYDoNASybths5Qq/2TtPhC2H+SxBLbRCCnguDvm3+l/HxzEQKCPH1Lj?=
 =?us-ascii?Q?508wX9VkGcz4yq4+UKroqp55v6YL9CyWW1lxSL2QLvIHWJpbmSbXdGjCrN7o?=
 =?us-ascii?Q?nnKvDaJXiHw7/1Kix9EbGL1ESQpeMkmmfUl9Ncyd/I3VscIGIH332ZBxFGS/?=
 =?us-ascii?Q?BCAhFLOPG/KHw2mC8tkAYKwrC4RQTuLKSkRJNlmYdKeT2fiDOgfN4jvNSGGW?=
 =?us-ascii?Q?szxkhNd7y38Cff14wPGdlwhjX9DK0jH+r07/EhOppyluOewGusWpSWOpoZqE?=
 =?us-ascii?Q?s7P+UNSBOnRxgS5+HVnqc98YeqoMKrTQQVd3/RKWH9+NFY+AC9z4AuCzKcMs?=
 =?us-ascii?Q?j8b4L5kTQkaWO66HzQ2pLvU9+EXZAMrgrfwZM0FrXvJ9QEQOLgs8VSrbfVSr?=
 =?us-ascii?Q?4Vpryux0M8cLTh8pcH18caS0ZX029EoJTWJ7l2q5nPfxJ1cYdzadVU2mHQnk?=
 =?us-ascii?Q?YycoaJKC2B8A3TPPxb3HiXmCr1tRhSRQ33ngLOWcM/TDcxeqDCElI2WFgYgp?=
 =?us-ascii?Q?fFhpEm38vKhG6qVunzqP7ot7t7O0LQH521pGSJNOh2QIp4ZOzSh+DVwwgLVa?=
 =?us-ascii?Q?TMJkjNx4uukUZ97Md9eV5tUYREcIQ8Lqyka90oblMzyeHlR07wfYLJw0AdCY?=
 =?us-ascii?Q?MyjUmvDO7KrxuplEqgAcYZeouNdSh4JywrS/RNFUcxI3pp3pcFsXnzhdvQO8?=
 =?us-ascii?Q?LIyK3Tb5WKwFCdtj8/sxbmBAhLbZSk3O25hyImHFDV35jwA+OurqloS0wqhS?=
 =?us-ascii?Q?mnOwCbxUallb6cDBPZN8Ea5TdPqIwer8AQIOL7adnCluICrs2kNNQQFJMmhr?=
 =?us-ascii?Q?1kwHTElRN+bpIf6cNaIHldYdFrERm9qLEFiVchJZ7dPPJ8VZQo1ouC4lj/de?=
 =?us-ascii?Q?ys2TbfUmHUHOSBnE940uXS+e77SN7vyj6i687HvdP/fnfl1wDDcn1+CBaSJ2?=
 =?us-ascii?Q?Tf22Aib2Rz3pqzm7SXPYEG1N6h8EFjCuH0nk3FAi1K20L8hgCxc8AQtqiQIY?=
 =?us-ascii?Q?KkA6begpzHqkRTwdsLmC5/4rAy05vQ7P9FuNe212vN8SEMZlFIWuiYskdBWw?=
 =?us-ascii?Q?AtFKjTL6rgOqb2cjn5Y/AXLZWrtyev+pIVzPSeXiCg56GyogUPHos49iPbZh?=
 =?us-ascii?Q?HxGbgyyUphvntiomHTQaZm6JSfk9yQiZAchefILT//Cyruwt4nS81CLvdSeJ?=
 =?us-ascii?Q?6tPehWtpOsT6zBYYhoxnEC8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	C1ongw3z/d5O8w3EF5ul18Wg39gaOoBNkhFwl3VlVohchSRz3iCNovH/x2VBV1WOutGTl2TF24f4hFuMFtx7XtGCym8RXrKjB4R0vvtuwIzi404/xd9vKZB+lIogLGDe8OEcZ7QKWSMeoKkGUZd5RKfXysB8t72vsihiFRMzQCcuIRp9yEvMUVE5vwMCRNRdDO0GkJQGCSj2P5XFTusut93qU+nOv69jRTdYpLjGQDq4HBP2ue50yDWZsC3uYgfzJ5OcA9sOuf5xqhnvMSOXrNypZ5WWQils5Qg3Sdcu5pYqU043sAzUqm/1iLC2hdYkdw2krhAXrrlDF+ND5k0BVW6qIu/LY6m6Hb0yDamFc1hMAPcZCs3BnwEyI0YtkANAIgeIw8Yiu2cMSKkZAlGV9WUOzNpo5bNtkFTubCZAbVi6tE78bT1Ef4OXPqrNA7mxjYtS3e5TuyfmNeUqUGUFXtb5XieKwRHi3+acl8pRpiY5LwvdJ1MNPvQTTn+T28fZtwe/6qurSR0G3L7fK2VB7Dpo0d7ReRcwnhoSvHxrLmGsPBjtcylodx8GgPVqLxRXbnNJIN/tXdc1k+XAXbji9sO/WinFwChPMwEx1plpB4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184d2b49-4e09-4190-b7b2-08dc41e7048b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:19:25.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0K1DBHSsYzkzpChCxjHtI0LMmLn9E5LLLXB8FPY/fe5MBeq3HbKCHJALViPDB8ZN/rcpcOsYIBH/BgA83HowVVvADzmTX9tLqoX5Cfluto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110124
X-Proofpoint-GUID: v3HYcdjVo_CUrjQAjCGV1A_0Af7hpTLR
X-Proofpoint-ORIG-GUID: v3HYcdjVo_CUrjQAjCGV1A_0Af7hpTLR

Add two new fields in public_key_signature to track the intended usage of
the signature.  Also add a flag for the revocation pass.  During signiture
validation, two verifications can take place for the same signature.  One
to see if it verifies against something on the .blacklist keyring and
the other to see if it verifies against the supplied keyring. The flag
is used to determine which stage the verification is in.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/blacklist.c                     |  3 +++
 crypto/asymmetric_keys/pkcs7_trust.c  | 20 ++++++++++++++++++++
 crypto/asymmetric_keys/pkcs7_verify.c |  4 ++++
 include/crypto/pkcs7.h                |  3 +++
 include/crypto/public_key.h           |  4 ++++
 5 files changed, 34 insertions(+)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 675dd7a8f07a..dd34e56a6362 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -17,6 +17,7 @@
 #include <linux/uidgid.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
+#include <crypto/public_key.h>
 #include "blacklist.h"
 
 /*
@@ -289,7 +290,9 @@ int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
 {
 	int ret;
 
+	pkcs7_set_usage_flag(pkcs7, PKS_REVOCATION_PASS);
 	ret = pkcs7_validate_trust(pkcs7, blacklist_keyring);
+	pkcs7_clear_usage_flag(pkcs7, PKS_REVOCATION_PASS);
 
 	if (ret == 0)
 		return -EKEYREJECTED;
diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
index 9a87c34ed173..64d70eb68864 100644
--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -131,6 +131,26 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 	return 0;
 }
 
+void pkcs7_clear_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage)
+{
+	struct pkcs7_signed_info *sinfo;
+
+	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
+		if (sinfo->sig)
+			clear_bit(usage, &sinfo->sig->usage_flags);
+	}
+}
+
+void pkcs7_set_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage)
+{
+	struct pkcs7_signed_info *sinfo;
+
+	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
+		if (sinfo->sig)
+			set_bit(usage, &sinfo->sig->usage_flags);
+	}
+}
+
 /**
  * pkcs7_validate_trust - Validate PKCS#7 trust chain
  * @pkcs7: The PKCS#7 certificate to validate
diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 1dc80e68ce96..44b8bd0ad4d8 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -455,6 +455,10 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
 			return ret;
 		}
 		actual_ret = 0;
+		if (sinfo->sig) {
+			sinfo->sig->usage = usage;
+			set_bit(PKS_USAGE_SET, &sinfo->sig->usage_flags);
+		}
 	}
 
 	kleave(" = %d", actual_ret);
diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
index 38ec7f5f9041..6c3c9061b118 100644
--- a/include/crypto/pkcs7.h
+++ b/include/crypto/pkcs7.h
@@ -32,6 +32,9 @@ extern int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
 extern int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
 				struct key *trust_keyring);
 
+extern void pkcs7_set_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage);
+extern void pkcs7_clear_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage);
+
 /*
  * pkcs7_verify.c
  */
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 462f8a34cdf8..3ddfbc20a55f 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -48,6 +48,10 @@ struct public_key_signature {
 	const char *pkey_algo;
 	const char *hash_algo;
 	const char *encoding;
+	u32 usage;		/* Intended usage */
+	unsigned long usage_flags;
+#define PKS_USAGE_SET		0
+#define PKS_REVOCATION_PASS	1
 };
 
 extern void public_key_signature_free(struct public_key_signature *sig);
-- 
2.39.3


