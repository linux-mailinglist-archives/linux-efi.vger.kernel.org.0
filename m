Return-Path: <linux-efi+bounces-798-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B125887852D
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 17:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BEC1C213F8
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A62154BD8;
	Mon, 11 Mar 2024 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EuOC0uuW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d8zBedfq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0FD5B697;
	Mon, 11 Mar 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173991; cv=fail; b=K7iEPa9tknULNHFLx30e7gGRhr6Ct2LHWpFJfiegK+gvvM/SHGq1GkybU7dwjgXXcqoYyF64Jws1ZRCWKucmn4z1pw1ZrwW5k4aj+nOmRpu+fWYHma8/lLJU1fEhuLwNtQovLulsamY7w7BJa4O6GvGJhurNErPIy4XhXr2NzY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173991; c=relaxed/simple;
	bh=jqfk8OOxs4/Bz/cC5CmbiOlqcono6Pb6OaERcc5bQKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q3bSZ95Rk6ZGa+tGTJjR1B068V6Ms3QaHwPiCkhS8LZqPYOpIdGhx8JeyuNJ4uptuweqw7jn2t0peize6w8QOeulxPNmhH956jAkxnIJqP4Iab+C7f6HsgIBJoCNIOYs7uX93x9aGMbClX6hg1HAw3J17Q/mHXQDy4vB8RhvjFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EuOC0uuW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d8zBedfq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG4018008047;
	Mon, 11 Mar 2024 16:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=LexnYcogTGCZEOS7+4Nj7Rx1wuA+oQqYo/tXnUCa9Rk=;
 b=EuOC0uuWm+UjfUIoLjPQhXQpJ5o+m9uHqfifhf2btCNvNV6WyTMI4n4hjRHgYAVsRGS2
 Mb9yeFlJmO07GSfoFQilX0wkiNkhYFveR5wxZq50ITaHgfUTRdgrBtncZv9yBWB9pX+/
 XLNXtiDEI9xRuW9Ru9y8aHKg1oKlB390vvv8VnR39h5TY8v8Rw0WNxuS6BYDt0CnEvMw
 yMxGxqZiXDIptQ+vBHFYN1LOYnRCZL7yxjo7eDkpnMYhvndT6Sf3TpdxLMTNYTx3/qrL
 kBFpKV+q9RL6RzRzZNRsBD+m5of1sBSkq0BliUUJu6JQrsK/43Sgzgy5wUuHjPqbPYal eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdbtkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BFpu1D028554;
	Mon, 11 Mar 2024 16:19:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75yf24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4FyB3daBE2CXosLqsewxeju1hv0BN+nweZ5wtJ6thZanHFf4YJSpb8Msq5U1rBaymJXmcgOiPwCLmQkzfHYcd7lFMwoD/NMs4oyNIH+oJVUR9zPb8wmSkNMMyyXB1usQ1QLCzeBCb2BHu4lLuCxGdLyGu304KvHDy5wm4aSpqafuFC79oIL+gSOh5x/bDkP0lDfiAcurgy0Z/8H7vmXwTeOCOXwte2/ADImjMnM4fFR989x1WUbLBcvA5xA6Y9YJ6Y0ondXiqNXPdL+ZArmQmhVDs479PXGq8eq1CVyd6ZyShzaivYJ0E5JquHa70rs+ycCbUCEnJtXj9G4pqP98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LexnYcogTGCZEOS7+4Nj7Rx1wuA+oQqYo/tXnUCa9Rk=;
 b=QP9GeK2Ja8Jo/nYQhWK+I8nRjQiES5KIR/OQURuJQC4WWtsFGaLNnW/xwALrLtRgtrCKFE2Ao2tQwZNJrNWqD68z0g8X9h1uXc0GON0WyRVcZGWfVhIubCbEKfrzTK/S+cwk9me4E2ViN+W6F9kjsrgDjXJzBg3RyPuVZcLR5upCKj12uO8orAw01iy58PhMZT3vW/fCSOFpNBVlHFDdI1U9q7yihE5zyuBxAkBjvFzwuaFjB3cnlFeNGWt8xtIpni6EvE+ubyECvAlNhSfUAyHBg3C7LEKBsje33PlRI6bLCSliPpA4YY8fPtlatBTkEqK3MtBttsarH+KzNgdKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LexnYcogTGCZEOS7+4Nj7Rx1wuA+oQqYo/tXnUCa9Rk=;
 b=d8zBedfqbXHtImYRfQpfJf4jRVhp2N9gH7Qdeulylq+BS5I32Iyrb+580oGq4fa4klwJ1+jeqx8yc58bDr8B/DAoc6T/mKUnYWirsIO9D2CA44RJdhoj4i7lYXFAKgpS8UotTtapNp1rQ84inIUdBIfKilxh61Hw3LFNMQ+CH/U=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MW6PR10MB7589.namprd10.prod.outlook.com (2603:10b6:303:23b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:19:23 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:19:21 +0000
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
Subject: [PATCH RFC 5/8] keys: Add new verification type (VERIFYING_CLAVIS_SIGNATURE)
Date: Mon, 11 Mar 2024 12:11:08 -0400
Message-Id: <20240311161111.3268190-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240311161111.3268190-1-eric.snowberg@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|MW6PR10MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 17afa830-f135-4fb1-ec38-08dc41e7023f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lDzveHQTxMNtEwsAQUf7OfdcRDEKhZJ7KmKzOf4cqYup/HDT9e44zeEPF4++pZ1MFdOPB8Cir8y5i0+GYmsLjnFnHcw5hg+5B7W6MHpYGE7q4VO0DyYdAby/t2n/IpmyN3rZBbPCamqpT8N5CAkW32hxPeswZX5fNJAPr6nJq/sPWA6ddnS9X1pp7bmP95eLQsA/8sB8VdsPiPgrF9vzo0n6WpBywVnd0+a2LYy4Gmji6jfnAcagnER5A5g6YFLviIXRLBiIhhMLhzMz3WBfMDrWvag/5dnLj9hOu9t/MGezulTGta25nPttuzltAxf0sjbMpUX4/OFYFGh/ecZkuUn2l8lcrGLBYQ7uRR3Phb6BzMUWBCTCq8svHPfgvMuhnIfMZXrUCxmGQBCCPW8QAWncIOg6PBQTFlmdKut2DRa/Ifb/Wn2KnM1vRgVVSPFGaSNrkVEba6vySR2bJq3WhHX43uvNLnpfLGjtXmmJyyAJpuVz11dG3dEEMuJsowfX8P9HXeOg23uEuRJgwyTdxfoapSscwsp8dQ7GopDV0ChVdiSLDHQmj66ndRvkXm+6U7NR2Gp7lFFHQinrnGgTNZBD8vWEdsvD6olghZ/ES6WtjGIaYSEWQS2MBgFewY2W+FKpgf2NT19wvUw57MBC4hCli2qkfcl4JR4EhrfL2wA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Uq0Mg8gQxLmDzp+/sRwtqqTcxMr9oStDKK5j8bK7NtZwkf6+IXzXmLZTTu0n?=
 =?us-ascii?Q?xN4iFtGyZ2XfmT7sIwPO3g180bv8omst58fHTFluolk1+lzVa/CD5r+6zHsu?=
 =?us-ascii?Q?AWZVx1/uZo2jTDRnGzpgABQ+r6ZCw2gx7VMGGpIupDN+5fqzHRhIVO7/5yOq?=
 =?us-ascii?Q?ln286Ffj2+L8xofJPCH3TiFqyR8Ez8bh0bOkVMtcXDDCJk3Y/OwD8Wv4E2Pa?=
 =?us-ascii?Q?W33RASZcvkLHE89bYVTSmm1CiPsVnxO/k8UJGf5WjXHLMgcGf6UT/Xe2evN+?=
 =?us-ascii?Q?TpdDcYZ6TidF0IBdN2+bSjtedyJ0dv6X98nQlVOGHhXXcpb+TscEae8fYZ3k?=
 =?us-ascii?Q?5a0r5f4mviZIY4BVtr/IYd2lDUQQ4t9WvwaewdaK6Jd4N2nLZ6sPt7NoqwfL?=
 =?us-ascii?Q?26r/Ho467aLdVcXS/ShNHYl6WRdesulFZfrhDo7xi3hp6Nbtk1DKVWiuJVz7?=
 =?us-ascii?Q?q2D84rLjA2DK36TEWJMGUOQ76VbbTY/8KrDqMlgNq3UTUOUbyhL+hs5MsZRU?=
 =?us-ascii?Q?LjhXyOMiosLJl6RgoqqxYVMU7uqJbiXYIriTjpVo19iAiH+Nmew7RAYOMNsL?=
 =?us-ascii?Q?LgbhHknYOMBj6lQCvjwonFqrweFd+HAoHrDbQsgg7KgtZfmYoVVccY8VGQg0?=
 =?us-ascii?Q?ei06WeIG4oamKI2yBQTE8+uGVfhEZ+2vY1bSBrUs70yVvVv39MDeixkOXd87?=
 =?us-ascii?Q?OoO23c0G12FmRzJ1WvSfkU/zNdVe2YV76mcCRNc/xnHxqMpgotjg/9IT9ucT?=
 =?us-ascii?Q?TwZpLxVrB/R84IJuu5qUL8N+NHK81/yhgQ8yWO2cx3ou5apJ2oPyK7O2bddj?=
 =?us-ascii?Q?7vAHxRnQk+SqJbscy/SybZLf+n5zMBYLsT+DD3L9FOF3BpAgxX+Vze/jbSi6?=
 =?us-ascii?Q?qlygcJlEoSH4fqWM69IinwdxFeCXqJzDAopGRHAOKDfp2OsDQIIkA7YxY+Ny?=
 =?us-ascii?Q?BLbqflO7Rv/JR0nLscdUnq1G8ar5cPoRYXqSo/5zy3kBfGXDTisbvrkgFXJU?=
 =?us-ascii?Q?oBkxPhQlO6/cikeMoD4EFKfVWhKKPQdmnWZVzWvDy5jxWfrFU3wQqXlJMlPB?=
 =?us-ascii?Q?RWJRhCJ5jZu3keify5GzWjzMO37QhV7jQvsI7Prdxha7ePTAYVWdAUUsPwM/?=
 =?us-ascii?Q?5ZxYAstyjQmjSpI4I0wmmxlAJiEElCKXsRY9GMiJoiJGR83hQs7pKa+Q4nvl?=
 =?us-ascii?Q?Is62esdxdfQ/VQo65TQUj3vFs/42cDniRdlEqqugNHBM4QQQNaM92h4cMmp7?=
 =?us-ascii?Q?YKeNdsQXmnn8YD9rqcQ5Kh380MVF56jFr25ec4WPQj5RGRZjrFJDWi4GBcyp?=
 =?us-ascii?Q?duWNvh+YIMfakqe9J+S9SoEwmBI3+o/4f7Q+XzUticnVlg7+Xuvcg+86D6h1?=
 =?us-ascii?Q?bwHE8JIJC09KAfH2Gstk4SUU9M1LENfb6PHW9K6eXwUMfasEh1Htl1vZgrS2?=
 =?us-ascii?Q?1SCcUHGfZdPpnMwVYN8nptbR/k30PsLH4e2h4XxMVKX0tMhcHIdHUGUJ2pmV?=
 =?us-ascii?Q?qZln7foLbRba2VH43CugTRwbEPNwQiz8XfYp2Wg9Z7QjjVLNEaGL1qYnlqSA?=
 =?us-ascii?Q?XCQ3bXH0tVMD1qnRYFhTVmK+ZBqBxbMRin5Xt7REvMbloiD67A7+heimJP30?=
 =?us-ascii?Q?NoaH8VofxB2EabWhJC8zr0E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hm+ubv5aMdDmvFUPPh/oFnthJKl9M9xKPPYzTHi8HmTiAu2pjyIp3Yxg9QwlZUbs+wIbkxjFfiZZ87gP5dHpze446C1DUVpjWw+pwEJSm7KTSy9NbsY2n+pB2/b29aLZ8qNJzcXU6kutb0WdulrmSfFF2rid6uwHj3ffv4sEiVIEUBRkSf4iPbICyLnU14/3Oao+nV39bBOUWx/Etb+bS3pnVYmlcu6o9KswD17xS00SHZcPXOLCbW+fUIaiq9C+tKKfsAuC/adf/Hk6gROpYR64/UVhDC/ND44aQooP/NF1SjmjE0GByZ24DFUj0S4giCURg3knxmOzKPCc2R0DAOgSVs8fAmAssFZhlhDnaCHgIKFuZJDePX6tVk576fzil+ub8i7osTo3ZxlVTnpQ8KqWGSn+kVGjFVmEvYIN9qQK7gO06Rpljn48sSAWywM4yOiGDImefmVjemh7iMPriIdNm1zUzrDPqQDww/ljP21uuVs05bGEwQE9iSI6kORGdys1DNSYwND9tBdgpRR4/4m87CKEaVFfRc6SzSiudWF2/Unl+mzWaIC2BfwSp9LjljVzPu0LKKwl1DnnOlFhYUNDPxXN0YYkJpAfeYy4Bc8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17afa830-f135-4fb1-ec38-08dc41e7023f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:19:21.3903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyGq7RwxX9u4wrig3Vf5FGmqJXmTJvkaFicTv06cyzatVkxOmoKKWk9BWdn63y+/NZDe1V40/BZi5cy7MMwmEjAd9ENDsbQrk4smj3IaWgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110124
X-Proofpoint-ORIG-GUID: hF3u4WBFwUOXt5CDHYvShcPIuFuAleQ-
X-Proofpoint-GUID: hF3u4WBFwUOXt5CDHYvShcPIuFuAleQ-

Add a new verification type called VERIFYING_CLAVIS_SIGNATURE.  This new
usage will be used for validating keys added to the new clavis lsm keyring.
This will be introduced in a follow-on patch.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/asymmetric_type.c | 1 +
 crypto/asymmetric_keys/pkcs7_verify.c    | 1 +
 include/linux/verification.h             | 1 +
 3 files changed, 3 insertions(+)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index a5da8ccd353e..7fdc006f18d6 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -25,6 +25,7 @@ const char *const key_being_used_for[NR__KEY_BEING_USED_FOR] = {
 	[VERIFYING_KEY_SIGNATURE]		= "key sig",
 	[VERIFYING_KEY_SELF_SIGNATURE]		= "key self sig",
 	[VERIFYING_UNSPECIFIED_SIGNATURE]	= "unspec sig",
+	[VERIFYING_CLAVIS_SIGNATURE]		= "clavis sig",
 };
 EXPORT_SYMBOL_GPL(key_being_used_for);
 
diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index f0d4ff3c20a8..1dc80e68ce96 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -428,6 +428,7 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
 		}
 		/* Authattr presence checked in parser */
 		break;
+	case VERIFYING_CLAVIS_SIGNATURE:
 	case VERIFYING_UNSPECIFIED_SIGNATURE:
 		if (pkcs7->data_type != OID_data) {
 			pr_warn("Invalid unspecified sig (not pkcs7-data)\n");
diff --git a/include/linux/verification.h b/include/linux/verification.h
index cb2d47f28091..970f748b5cc9 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -36,6 +36,7 @@ enum key_being_used_for {
 	VERIFYING_KEY_SIGNATURE,
 	VERIFYING_KEY_SELF_SIGNATURE,
 	VERIFYING_UNSPECIFIED_SIGNATURE,
+	VERIFYING_CLAVIS_SIGNATURE,
 	NR__KEY_BEING_USED_FOR
 };
 extern const char *const key_being_used_for[NR__KEY_BEING_USED_FOR];
-- 
2.39.3


