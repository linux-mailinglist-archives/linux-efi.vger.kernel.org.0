Return-Path: <linux-efi+bounces-797-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45B878525
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 17:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3780B1F26B05
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3B4537FB;
	Mon, 11 Mar 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NrNhSx4k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k1RYLIS3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C019C4E1CE;
	Mon, 11 Mar 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173987; cv=fail; b=lenjbwdBuYewixGr0OSGmiOcDF/s2kibhpr1pOV94USo/+iTvcFE+hxEVjA8wZNa5F03hfyY5ZeHY61CaKoNPs+0s++rY0Oo2kMNU1Emw0fW9sjpaspVvlWq5Fbd+Pv299LXYHHW89uQb1Rp8tQ5VFGiBK0aKa/O1NwPSgJg44w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173987; c=relaxed/simple;
	bh=aOaEFWq48kYowRvINXrbrcN7pk0Q/LJ+r0sLhqGGFpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xh5BRVphJMfYN4kDzcr3cCxBm/03SKL5j9VH0u197U9eJnlCREtudW0lMyn63j9sKucQlwCVn7UOEpyCCf5JYUbTbW75a1vL/m2IdxRz8ZzYVQ7dPvmorLEOaZnkPEkNoOAVLf2dmh9nrt+qtRv2dewdkQovavwhEIFNGuLcmLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NrNhSx4k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k1RYLIS3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG4skU011481;
	Mon, 11 Mar 2024 16:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=QJ2mWccsllAndPvjMKTHXgjM/qF2M65Rf0FCdAXn+YU=;
 b=NrNhSx4k2IwQJaTSBN5AniDze/nIBK689JghuPSEAJ3wrabsIR7M4ZTSOoGYLhaetxqA
 6buDuw8v1oYz6MXTbGN8JbES6ZvdFRseHAwt+eTUFogVqG/01RoNw71FEiJrinl1YMfC
 vf5Aex8xtfitRu1H+WnBmpZs2LJfw9D+9O9YujCCKiSWy79tmVcQEQvqgttLfe30sHlP
 TZIBldvo6jt+EAqbmpkJhW+jIybzkWkjMfmbS7BcKmGEF1oAHIkqEqd0qHEecvTHStDe
 r4puJQs4FQzOij2OkDlcbjqz7a3tOVIShEwL7iCk6ijtdNnSI4HvIMW5vgG7xAgouaWC lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrgaukqep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BGA08Q033763;
	Mon, 11 Mar 2024 16:19:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75qxd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0CXbVPcVrrJco0Nw9K9Pw8P8Asw0Lc1dUCxZBl0bl7Irwc4G5aOqzHOrcQVYnyw26wnDZv3zcJ+LiyJOQ6PUhIe/EYmpTqFohrmbIk5dCv9x4uQfooztcJ8xyw718PZ26HRkf0QPEJDJJbAcxteHUqAjDkPD5i7C4d3YpwW2GgzTbKRPqiAVbeen0c1LjhqEOTtHqnwRYTcoKU6gHT85DPb9aOLqAXPWj+/hLUlDiQyaWkQXwA1ndaCizZzsL/SFjzqDbqu8kMVcBqU9NeUYL6+ov2VpcnYq1J0J6xpgwEJWDwq4Xwc/fgiwZ7e2zsT/uTD4VUNWtx4p7hkw0WxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJ2mWccsllAndPvjMKTHXgjM/qF2M65Rf0FCdAXn+YU=;
 b=kQhlCwuNX34bPWYXK6NRLcTRB8TD6dsVfUeuJm8OC0ZZzbhwkQsy66atdGR8tZekfh4mICwZfjtWbEarsWlj/Vgq/bKzr+s3NS/GWVszVfFjK/5R8loyYifivbgJXHnOaNHOuyYI+W+eUpXSZ5D3K83qdrJlpIrpjl39wSGphyuWiSt0xhsJUICm5rc0wJ7sObcCeoiJ6uh0CT9dvgwqOCb2ps30+qiKvi4i80KtaQhCNFKcCzD+45rV6NyUiEIC29NBQ5RRsYEkDxrcj4tm9Q1lvBno6uDBpUMJJKL2z5ybV7HJ+qxleZ1qR9bCdG904f9QnSywcHNU3bkWhWZL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ2mWccsllAndPvjMKTHXgjM/qF2M65Rf0FCdAXn+YU=;
 b=k1RYLIS3NM8nkWHauxdLVJeo8uTAKV6/TnqmGjC0x4UCxJBfWGOpljNf0tZe9U/5nvTaT3WTZPRMuLsEQxx3e/870SWGDiouVSou7P8YkuOGn6GNVpT4HxVPUTEtAZ3RjFNXUbicdAzulN6XL2oYyKszV2YTVfiFevCh8LAxM2A=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MW6PR10MB7589.namprd10.prod.outlook.com (2603:10b6:303:23b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:19:18 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:19:17 +0000
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
Subject: [PATCH RFC 4/8] clavis: Prevent clavis boot param from changing during kexec
Date: Mon, 11 Mar 2024 12:11:07 -0400
Message-Id: <20240311161111.3268190-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240311161111.3268190-1-eric.snowberg@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|MW6PR10MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c6ed25-889b-4253-69fd-08dc41e70006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c2PG2CcMZjIyt94GL0ajhRcJ1aqtStZsUGGfv1CbiVOL9zYWfDB4olfB3QPzFmKiYMyHx0qF4yGNXPJ9qwprrk4fSdu19VfzjBu9KmM4QTnWbUZiGrlSZ0KCDfm38cfvA1LXiHD7zOUTfD3HPY5CqsyYztRO4scewzOqmpL+YtSGzJVtxfkq/aET6KPOSTI5R+J2YNFJEOsJM7g2+FW0qlPwW8gIpwAnxnE9Z7arJcYmwglOAJAn8bu7am5Hrzvzmorp6UNhe7yvipKP8BrgJVqc4ZSj5A+sENdMHeSxXqSYCXXOyWCYOOGau+Z4RwJJpg0or2+GlPkJfb+JnSc960gu4EBsm46Xf7sM9wi3m4CxMkKrAkBFho/LDbKdG9WnjvuA/wsJQh0Kkb3N3K/heQcJvNBlENZEsIc+kBD2jVoAtCkC4n9wYAZKbzJfabqGEszBgeJ60mKLoXDV6Kfz5TGwlKpA41iJdh3g5JBa2bFzrISKzT6RkitZC1Y6Zkk3E7g5hGHWYYH36ktYznbv4d1HpbNnHLr8/FSFEC/LVuuD7mXZuwQYYaCWIx4t9BDazW0my2fM/BRPPlvXtLXpIMgB39v1q0TTfzpShHspb5qF4FXVlKmGNpf0Op+asz01Je7wti8PHU09w1WyNObrc5COh0vskXqsIhgwG6Pc/9M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AnRaw8+p4qLF5w/1yJ8XLr8i3WFzb1mhC3b2FbcIq5FO/jZYJ5qE+UHE97tb?=
 =?us-ascii?Q?qY5GE3L2Uj1+LCJGOY5BNLLf0cbV/MowyPTMv4cY1XPNfuWQ2Nq44MpwLmMo?=
 =?us-ascii?Q?FT7J5QLUQSKJsOv13M5ftWaURMG0IK1Af7tgr2EH2wN1qaqcAN3dPJgEJhdp?=
 =?us-ascii?Q?AsVGAGGgoSQKD9AinexsEfVXX9NU1KOVQ89BGKW/hqO0rPrBmXzOI2SdmvV4?=
 =?us-ascii?Q?oOCsMDDKbFE5WlTeYR/GH6B4aB7X5Rrzop42odquq4Io4Qr7rWYgeqQHLy07?=
 =?us-ascii?Q?aPqoOgyvajmUMJwOTbdtt20pxNcw3J/bEYCGJKV7xF10qaf65cw7XBJdq/na?=
 =?us-ascii?Q?yxC218KmTUTGhp0RGWb6aggzdFI/dAnF754AiWR29FYuUAzlcWtHDxCreBuw?=
 =?us-ascii?Q?Rk24tDC6xyBjgt6q/rFem77C0ZhSLucikhfSPvQqGDUFfCozDJU0XvwX+rBc?=
 =?us-ascii?Q?h88Jor+P/gAKzWp577Gsb49dqoVtvovhOoLdojHcPocm6Rg5OIdNBrOKMRyI?=
 =?us-ascii?Q?01Co8qCwpbtyGV4kyTFeXk29iCo9498U+q6UvqKc5ex90v/ws1I/fq4eCyns?=
 =?us-ascii?Q?bHrkUwPhaxTX3DUF8AzJYzkgNUa2thKLdqUFlTNtXLXVWzLNJkATHFDpwOUH?=
 =?us-ascii?Q?z649Rb0QVYPDYxTD9X0+T4RgmMrgU/XfvlNsRogR0vj1bgW1otSS/6w6gMf7?=
 =?us-ascii?Q?0kqs1NlJPjebVsiuNfOov7tgMLDkw7t/6MSaV2zscMsAyJx0FCjnYTzfglO1?=
 =?us-ascii?Q?BOd3Vsh2WthdPFjdDH3ChwCmRk6w23sfk31aSeY+FOe8QGCETuJe9FKOPflo?=
 =?us-ascii?Q?6f0tQG/WwWsFN23MUZu1ag+z+WtWayuCTXk0LEHSSo62uJwL4TZlT6FzdXW8?=
 =?us-ascii?Q?acMzC5G6HbJvEoZhXYZUp/fJ5Y1IEHOpHqRjZzF8UO6+9n38OpbsRSRvpPUh?=
 =?us-ascii?Q?5M3pRtT3Pwahc8kZXGyH58rLu2aJk47Dvh/9haAT2h7oVhJ4hcv5SiZ1DroY?=
 =?us-ascii?Q?9kNMuehzCnXyhbiZs/9t36J6eaj/Hc9SPs/fkP6zgxEWaWb8OStFHUx0GwA6?=
 =?us-ascii?Q?NM1D6PmMKVKDD/UEk9Z9Q2ynbeG7RmN5v4gpURJ50RzSajw4qOoZ4z1Eg2s1?=
 =?us-ascii?Q?C42BBJjdVFn43Exkcw7zpw67p1WpV7ut6z+zTb6l7P0nA3pWDwUsjPjn2sLO?=
 =?us-ascii?Q?FYJoyE8z1VHkBJRgw6OXWuEKJQpdlKNCdCFveZdlAQ7R90d7/toSmjWE/4iW?=
 =?us-ascii?Q?LAHBlW2b33Dcevnbsel+luP9CI/jzg2JdP5bWqTHTtNS5RyCkLpyjRobGxWg?=
 =?us-ascii?Q?diqVGU1a65QRmLPP1pV9jQ/aB3WZqQ1kaXTvQ33ibbFUZfWEJzGhqkxtnZLD?=
 =?us-ascii?Q?Z9ncSODUUfWVt9sztHNm9J0m2sXg0+jd3KHUCw1JFRWj1PtSkc88Z72nRdZn?=
 =?us-ascii?Q?06oFR2lr2sdllhWQaIvMEAeBIe92cupPXmd2N+4hExCEmMDj6CQ91rkxDrbS?=
 =?us-ascii?Q?QZC8zhUkSW6S0htpTXxxnv+RNWi4VeMYxR/348l+95Ft+OpFVALbNPO5bQIn?=
 =?us-ascii?Q?SIKbY4rP80CvT4cBsy2VerMJJbQr8l1m9hi4stRjl2VWBuX7/RHXHxoJROVI?=
 =?us-ascii?Q?Y69e7gGxBxnXXZMwagHM1SU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XBoyMWBbVFaHrevPRNx3pOycGr0GRl4ka5DzQBiGAD2F7Cm7B/GfuNPekVnoh2eNYA0u6+iuLGJBkP33M5jJqy4wEM81qaY0QbGtARIgs6/wCTqsBoYT7Q5MWBE2ouxjgPujLr4IrIUmvv5rgW7i9KYOfWt7Hpivr6/008qJpT1q2XVvCrsvc3rtWrkj/LjiyL3tl49coYa8PnxR97xrCcH/MT0dWxCmLsRL3Esi4tOeJuGn3RlNFm8Jw4cDDipdDIfz+PbnzON0BWmBFsGxIqLWo2yP+M8iTRzokwpx5qcXh2ZEzuI6iPVt6AIVVsb8jfv4kKPlkrS5VEez5nCqnWpuaE19gSK9Bzk028SuN09A8Oku1gIEVOm3TcsatlMz/R3CDCsPlipCVRsBYRMfQ+69LFyrcHyyyrCc4CVVFJATzpqc0vCZHk8XBiIpnJ4nMi008f3Uj1HhEwY+w+Cw1DA3MotaYz8gP0nQ89/dK+YhPDsU0KEwJ3Kiw7HfzEvZ5008CVqR2EH4ISOMkb6XZkf5TnA32M+S3X1WvkcBWLix64oJP5Cb7k/Kga2Vvj56h6K6JuT7xUEWealJ94jMv22vnLiUVgUVQgSM/hEbDyk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c6ed25-889b-4253-69fd-08dc41e70006
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:19:17.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H+MsUn86e/fpvlsW7AlKjxSBXkhZZio5rurHRI8mPOOaERisAHdZPa2byuhv7XTgfT6hWoP/mrrnalDiJTDxYG+BOLBnvk5RH1icnE54A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110124
X-Proofpoint-GUID: 7YjW01kYDsusCbQ1C5RMacIYkrWnxePY
X-Proofpoint-ORIG-GUID: 7YjW01kYDsusCbQ1C5RMacIYkrWnxePY

Use the new Clavis EFI RT variable to validate the clavis boot param didn't
change during a reboot. If the boot param is different or missing, use the
one stored in EFI instead. This will prevent a pivot in the root of trust
for the upcoming Clavis LSM.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/clavis/Makefile         |  3 ++
 security/clavis/clavis.h         | 12 ++++++++
 security/clavis/clavis_efi.c     | 50 ++++++++++++++++++++++++++++++++
 security/clavis/clavis_keyring.c | 17 +++++++++--
 4 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100644 security/clavis/clavis.h
 create mode 100644 security/clavis/clavis_efi.c

diff --git a/security/clavis/Makefile b/security/clavis/Makefile
index ff19c1e240fd..c008cb74c762 100644
--- a/security/clavis/Makefile
+++ b/security/clavis/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SECURITY_CLAVIS_KEYRING) += clavis_keyring.o
+ifeq ($(CONFIG_EFI),y)
+obj-$(CONFIG_SECURITY_CLAVIS_KEYRING) += clavis_efi.o
+endif
diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
new file mode 100644
index 000000000000..3883c390b9e4
--- /dev/null
+++ b/security/clavis/clavis.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+struct asymmetric_key_id;
+
+#ifdef CONFIG_EFI
+int __init clavis_efi_param(struct asymmetric_key_id *kid, int len);
+#else
+static inline int __init clavis_efi_param(struct asymmetric_key_id *kid, int len)
+{
+	return -EINVAL;
+}
+#endif
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
index 9f1aede81992..c5606ed101f6 100644
--- a/security/clavis/clavis_keyring.c
+++ b/security/clavis/clavis_keyring.c
@@ -3,6 +3,7 @@
 #include <linux/security.h>
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
2.39.3


