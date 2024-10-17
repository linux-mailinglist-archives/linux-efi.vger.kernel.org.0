Return-Path: <linux-efi+bounces-1995-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0CE9A27D7
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 18:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DED5288E5D
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5F1DDC2B;
	Thu, 17 Oct 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gTxzyZhy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XKUHTFlc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2F13B797;
	Thu, 17 Oct 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180917; cv=fail; b=q/ZpKaMG9XUIzpZXEKZH2WuY9XsIWYJ2D804jHsV0/OoWbwITD6jhdgRENU7sfnuxFbFmmQ6kiZxbs9NJqKepVgqa11dYFSV5hK6a02hIrBLr9JoJdHfrT7IPWg/r5PLbogIrbqP+hFJHpCU51jpr7v4BISUv6PPrWMQUryW+KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180917; c=relaxed/simple;
	bh=hhMfAo4Yfk6ej/qZiLTK5i9QUg2QeO3hIXotPH2sb58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k9Kohl7DW53Z35gZDFKz+ISMOAcRrdtvT4RGj3jgnwuMULOhER5d6brPArBU7gWGeaUwkSPgHV24qcB99U5OqXPbCKAWoHvLTwTOQZPEvUzKbe06PUoytvlk8SnP97osTkyfagkH9z80cbp2zjuCUW3fUbqthZ2WOomzJCRfr/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gTxzyZhy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XKUHTFlc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBvE5024561;
	Thu, 17 Oct 2024 15:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=krx6eeu1tfKXYz0vs3Htju+m2dqTtfKGzr3PhiQ0sD4=; b=
	gTxzyZhyLBCubftXl96hMXOfsfXKpFEzgbOqFt/GFXMCVAtJGq4CLzPbpDCC0ukc
	s1+GfIajLe2HZfSKz8s8rETNiW+oHf+T0XHMqQahjWm5JmVdq7JeRdSozPBTxeHc
	VU3TitVAl9OrPUkrMNLfLm90TLF+e8AXtu7P4S6IFXXeO1+r5h8cUDQpW3YqCquX
	+AfRf6uQkaMazReI92LRuJxUq3tDkFZipO0yMAFEyg5FJZJCalEwA9zdRIemnyhD
	ylaUTe5ZOVpwQM/rOyf0A2jB64a5HO4u4qvVbUb0hZdYSdSF+Q1aSk8z2NlDkR0y
	GfEocXxpNUFXF7FPbd+zDQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcpd2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HElWMR013904;
	Thu, 17 Oct 2024 15:56:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjadu5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UT1X1id52a5mT99NMA97txDcST41luZApz2keMYcx9qbD4XvXVRQmprqaLUNCf2Lkg8hDx7qQiaSApRuPN1VbnHy4JDxE2C6N1YplSwzt/L6EKhTu1pNRzhYSOSJqwCWXBTneTcpqV9yL+IjpPIUe5MdC1zJAgdLy3dYSNSpI9A2tYea3HYhgC1qE0YCCuaIagCxe/pWtR2k5wVfXJ/nDD1mt47ZJPflAN0CdYNJXshXnN+Y6ZPZR+T7r0k3yD/vuCl8wkzQtkmPvxDkwZMtlExQRHUDL8n0mmfqHLO8xjKwGiiGRxN9bwNk2j8dL8WLiCWHvpT8o0DbYoYDJEX5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krx6eeu1tfKXYz0vs3Htju+m2dqTtfKGzr3PhiQ0sD4=;
 b=hHGhJUTkSpK4RtxzrxjEymMZYM5fw/y2CreDoiqPmocYMJ+KxTEBkqYGgxVrUw2jS1xOe1NS4obLAFEhrugfZEDjXjVUXSCMStnzOKjmwZ34emFaQhEWMzW2//iQhJFbyPwqZeWcwv7TI0JerYu+f3j/aIOnHpSRYfD9W0+YVJvzHeRIHv/yrRB7JnykOZ2eEoi9KjPcWiBlXB9ADVTNrxvzSWgu0YW98UIQIZCwhxs1kpVJP5BTckXsYyUVMG3CBbXKXiPPibGbhBjgNgWp9YIrf+jKI/LHHCi008BLRQ5Ql5BS2NvxHVV+x6umnTKxBI84NyI3pfJSV//eM+v9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krx6eeu1tfKXYz0vs3Htju+m2dqTtfKGzr3PhiQ0sD4=;
 b=XKUHTFlcx6smN4Tv1jIBzvzGKTViaI/38Y8nF2uC2ZEPbVzPGNX6stLG0Sw3N5fAfeDnsbrmHyZ1HUsnxCVuKSpv4pCuUsn3o3b5TDCUox/R0KUdE9AUSsQhj/lRBzVu1L88AU6JGdXSDzOUllXg1eMcRLzLzhIQRVzCD2dmXBE=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by LV8PR10MB7967.namprd10.prod.outlook.com (2603:10b6:408:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 17 Oct
 2024 15:56:01 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 15:56:01 +0000
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
Subject: [RFC PATCH v3 01/13] certs: Remove CONFIG_INTEGRITY_PLATFORM_KEYRING check
Date: Thu, 17 Oct 2024 09:55:04 -0600
Message-ID: <20241017155516.2582369-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|LV8PR10MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: df916ab9-f351-47aa-88fa-08dceec427ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r2PnS+cALiHNWzd4T+SVnQJski3ZLJhP1/hf/QMrCXQgwVD4+8N+VyLisis9?=
 =?us-ascii?Q?7tUaWScMP6u2u5gzi1/ZNifMuYchtRvZx1W6TH5mjwlUibh3Uab2jP+3UqNt?=
 =?us-ascii?Q?nelRFM8E7YlMc+YPufaQn5XbKK7rVRZGgH+diz/eJwSUw/7j2ScNG31qdT7g?=
 =?us-ascii?Q?sZmALozCAI7IcZrKiZ8oCsW9h3qVxDYtqF/yECb6Mmu+KSU2z0RH/qdg+L9a?=
 =?us-ascii?Q?rHfPPcO70q13OrLlLYQyi62JWGdkGgUSPF4nSjFt6OOdehKb/NB42XcIrqWt?=
 =?us-ascii?Q?K/t1kgiN77uOIBQlJke29U3/cSsbuHgq2WtphWQKG9vlzvKylv5xEEVw4FpG?=
 =?us-ascii?Q?0DfpX+VSOmM+og4VT4INtTFglXXVdUf/919WA/Y/1byQV+cn9/JM+U8rVqmr?=
 =?us-ascii?Q?f2rcZuqlX21KFkoLwQoQs+3QXrGQ6snha2vDJuruUuTls8lHw7Je4sj4PpCB?=
 =?us-ascii?Q?CsmSzvdH9BIXjB+xu3odgBTKf6g8zRLe1Q/uKO9iL6sxp6CmObxIcT9ZnooT?=
 =?us-ascii?Q?C+cM6J9cbuIjdaTTqb/kk9UY+YnU/rCJ1QPfK8bYnUI+0uc6gohtARmBcp22?=
 =?us-ascii?Q?a2EqZY4RV8nBhF2kF+7PRcnnqq1v1KXCZ22eRsmNQEK6n8GZMlWQ9cE07ZqN?=
 =?us-ascii?Q?BBLBXg/mT1dAulISkTNe/dUouFKMon9qGykfhlBWEcIactQWlWCA2Qz2dWBK?=
 =?us-ascii?Q?HGUg6zt8Gh1ezJrTKtHmZkSFLXCpkfjBlu1dwo4wmxvKcK9aoOSUG9KWQ5UY?=
 =?us-ascii?Q?QLrCV4SHi5T8O0qyaqukO2bKQ/HYZKEhIcxwwDrC4fqiL2QT7KBRGS0dPEhh?=
 =?us-ascii?Q?5VE0iaAyi6frAzTX8g5y6tBvvojf0hauNL05y9IG03V7WmrRx3eae1fS15Dv?=
 =?us-ascii?Q?H411CXu2E6270gkj3SvtaV/CKK2PBtG0VAAcOEAhUpfKgcC30q5nI7bUePLR?=
 =?us-ascii?Q?q5W3cXKvbuXpUVI4R09OLrUDJ7h4TKz0BjJ+h2btYVS0pleF+1uzm0Y+n50n?=
 =?us-ascii?Q?6HYIyC15tUy7r6TxwvkgdkQowhP6Ti3om+67nJoVe5oJUKjUsUJIys5p0cOp?=
 =?us-ascii?Q?eBJXFAbgrn3oyYcqrZnQZgatqmW52RxueGn1lwNwifQRAb7SYDEGEsqXNJXv?=
 =?us-ascii?Q?Mx/AY6afIBbBIgo0axWz4D418+8F8QFT23Vd3JAhCZAEAFBICNZSycbCd3fB?=
 =?us-ascii?Q?vp2MRRUUQa7g3GBBLk4rz/9gC5X4M4z7VC33T3YtctIiXAIBSe0/4OjBe0Xo?=
 =?us-ascii?Q?MyGzpJdjlb7wUwJIdMCCxnT7luqznbqWfcAQ2mV1vBoEqRukC4kOO5haaHh4?=
 =?us-ascii?Q?aeTJkapLlml9ox6aG1tWxnvQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0laBAxjNZzCxW/OWe87MYpNYoy3JmzNswVGrNaPtE/poGWBlmuMoNz6ij51?=
 =?us-ascii?Q?K9GUhwaDWehlSeYPDPbvjMaSqWgN6aNvH9elysFqDWd9trBOdOp7hJXoq37i?=
 =?us-ascii?Q?JTiO8VnRKZfXURj7DPeFRNN57sWvJDFYnvGxFUrREwnZ6Ynv7CCcx3zgHCLT?=
 =?us-ascii?Q?PK19AAmTV08b+HKNKtFJbd/iUT7Bip+cTUCme1FNROBLjLGf92LZMljU14hu?=
 =?us-ascii?Q?jfdnBywVg4ftpCG8OU5xqIJmqNFGtBS7UaOCIXTBNeHn0bvw661Y7SVaUChj?=
 =?us-ascii?Q?Swtdg9Rc8/RQwQhJlgtUQZQf91fAkVKN3TRY+vpw26pgiuCXIX9fQq5H/c2/?=
 =?us-ascii?Q?5xYpayASJiruiihj5G0SPPtHlI38yQmr4vTu3oqsq0YSZK84RYEM2IfKYOwN?=
 =?us-ascii?Q?6QLWyZpIl1WLWYAUHSZiP+LOmIKHfq+WH4UVsiQ4sV6bhsWQXb+5LrH2hmif?=
 =?us-ascii?Q?eIGZCVX5ADgDKuCxzi+8ZMLwno0dmJOHZqzvUOCAyLuY6fL8LJOJGTSfI0eq?=
 =?us-ascii?Q?yOw+83wD6gEpxXyCtydjfvVIPcmQA38IXNHml6965+wfR8G6bCuq8H3sPTY5?=
 =?us-ascii?Q?6P3QjNJGjbKZ1EvE+Ld6D/RC8P1DqcY9CPCBKnnWECNfWpWjAATum3YMRBHW?=
 =?us-ascii?Q?u3ebDEtSJrylNInejs+1/OWiJArER12VBojVyaDmpxzhChAk34B57XuWPI8n?=
 =?us-ascii?Q?xS367OnaiuCFiLMf3XIRCyRVZSRieQkDK31b8nV1zx6+fIOjsv/cT+FyYQsR?=
 =?us-ascii?Q?8kNZB5sjVl06NTBrvETVyHmTs8/xedJc25TNd+hmPLDvsfStHmduUYN+UdL/?=
 =?us-ascii?Q?LJqX6Ygj5UEVBqfGpfeLEP1eD/CkAZs1O7hs/wuCwphMMVFMbDbHrRdlMtzQ?=
 =?us-ascii?Q?iNR7x2IObtGEqdkhQO4982SZR6+el9wIcX2ex8OP79Ko8doK3uD0D7RXUUgt?=
 =?us-ascii?Q?rj7vvkALZFXkZWOaeiyQMsvjxuUmCnSvb77iQN35dsnv+rad+OGLXVDz3lbi?=
 =?us-ascii?Q?DqR2SEA0nxfVbU/J0wsHGRnrKECpYeIJksOwlCkii5lYlTFi2OhSUUGKWymN?=
 =?us-ascii?Q?BDyY3L75MexmpaendV8pbZczPxFgVmlvR4YTNdPy2W9qbt+tBTRpudlQj46s?=
 =?us-ascii?Q?MRB6gQZW3RQJmdDLQJvSRVz0KOu1IrwkNS+juunmsQ7MPlZs4/lajv2yH2E9?=
 =?us-ascii?Q?uwBB82hjkgknfGfg1ubGwHWsrH+yede4WxHte4VxmKNb1bPSTQqtQc641OVh?=
 =?us-ascii?Q?n7aP3dRvdG+ellid1wa6kCH+QF1ZovK6QyK4+Q9mWR5rR1w2mGONJB39CvQY?=
 =?us-ascii?Q?l5nA/ZAvKTCdDnSgOivHr0XgfFWBtBpL7/mNV1WodKN3Mq9MtKDQ9JGqsdIC?=
 =?us-ascii?Q?ulU2CBWa/oHi9nypuAG1G6iLMycTvPgXVyAZAVaQevaLqQ5qrQ3F7fIjiJjC?=
 =?us-ascii?Q?KyimXttXdBBZIOm+FquS9AmKSsFckfsfd0rs8CTS2FjBS738r6BWmY185Ip5?=
 =?us-ascii?Q?MCPckvLrnqkyfn/LmWMroEn1ejR+ofbz6WXmO9GqUq3VDlJo66ciC+LIJMsW?=
 =?us-ascii?Q?OVtP2oPG5+xuhHj4rbZIhlq9aNTgWMkt7oVZ5WxvJls48mSJWKS+ue2JXIYh?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rFUssuHGScInf82FIYq/20EMAgxqqQD0xO/u1NdBDyIlmJGjLnbgm95SSlcP9LCq8bgpRl7bSkCJa5E3c76mZSZ9ElBkuh1oB6M4SWLv4dFkuznZQ6o2A8dO7amOf1b5s86g/JP1hCEsQR4+k0GT159tldsxcD0DwO2XTpi68e3PXlk53YBYEbniY5dlQA8LCBMws7kgZ67LYTFNbuCrr93QjS6wDEKxDlRBS/rW+02xFHue8hDB6Qiay8Syhq4HhBEbT8yCDFazvLu1ac6Epw87441ysL3TNkB2IdhZbPYZOJy/X8tJvf1LfLxgIEg3aWcZEpgtCxI1XjiwxnHrWXcC5gWVV8gu2twbtBlpWOlk5qRG42mBRn30IaFKKvFV4Y9bWt1UiJdK7VeIrB3i6oyvJNLovpZMvcePi+jeE90sFqlKOY5m+pNKggVavr/5qHvkvS9hI2mFjDqoeHv4XFoDCIewtcCZhGa6bh3k86tvQxJxm887sc2vdrtPobjeyEakrBqLZvhPuehnLV+MgJ+a0eL15XljJTx0DmNRQLmbvzlNNZabSkzfiDr0yM4D1Iz6cewEy6R1Wm+YjVE2hZ2IISZ51zS+EzJFGp+j35k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df916ab9-f351-47aa-88fa-08dceec427ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:55:42.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GO5atfWPOyTbE+FC7CHhrB17Bsq4gKDrQsupQjrQvUht0xqU6XTKd1sSZ3dqTTeh1+4HTa7ekokv3MDClnVFo4eF9T161T7v1ZvukfZjbbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-GUID: 5f2lWyWcbvEbY5KQrxp6tRVDaWrBCAn6
X-Proofpoint-ORIG-GUID: 5f2lWyWcbvEbY5KQrxp6tRVDaWrBCAn6

Remove the CONFIG_INTEGRITY_PLATFORM_KEYRING ifdef check so this
pattern does not need to be repeated with new code.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 9de610bf1f4b..e344cee10d28 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -24,9 +24,7 @@ static struct key *secondary_trusted_keys;
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
 static struct key *machine_trusted_keys;
 #endif
-#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 static struct key *platform_trusted_keys;
-#endif
 
 extern __initconst const u8 system_certificate_list[];
 extern __initconst const unsigned long system_certificate_list_size;
@@ -345,11 +343,7 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 		trusted_keys = builtin_trusted_keys;
 #endif
 	} else if (trusted_keys == VERIFY_USE_PLATFORM_KEYRING) {
-#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 		trusted_keys = platform_trusted_keys;
-#else
-		trusted_keys = NULL;
-#endif
 		if (!trusted_keys) {
 			ret = -ENOKEY;
 			pr_devel("PKCS#7 platform keyring is not available\n");
-- 
2.45.0


