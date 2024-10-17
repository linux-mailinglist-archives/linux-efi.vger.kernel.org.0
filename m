Return-Path: <linux-efi+bounces-1991-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2459A27A5
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 17:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826251F2300D
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BF81E008A;
	Thu, 17 Oct 2024 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GBqCpiyb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qiXK/IO5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F451DFE16;
	Thu, 17 Oct 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180617; cv=fail; b=QFllSi593x7IuH/QU1nYQsXQfhH6ktq50WdQ7RFhwmISGN/IMENv4n5jI6zMyIpy9BdLL6he9p0Kq5SMP3YWpgmiH01P7Walq/jXf/FAuRkrqL1+8Ga0CMlQnTYO9GfDr4e55pGih7iRUGH8tUEcOi0yaQWT0NDgt/0PGomSqQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180617; c=relaxed/simple;
	bh=PoO0Ac/eDyqjnv12t43kphD28yEuzzr8t58hT5IqhFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kM2v4lYbP2eFVoH7OzR5CZt6ggO+kwRNbd3oJ7oUGxOW7Xr8NevfQ1TAKa84FvBQusXWlrnZ5rrFryF/J+6Nt1ongWB5DoL4cjnfq3SkqhqML5N58R3iKU3YDkEIhtg8VzSXX3WpQLTACFF1mTWteU2gof4x+d8RTvMR3CbN9cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GBqCpiyb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qiXK/IO5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBrMD028923;
	Thu, 17 Oct 2024 15:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RNu0atCC/CaTHi28ICJ2AfLFW/9yMfSjcd4hKj6n5BE=; b=
	GBqCpiyblgoZF6L4n1m6KLNvw65x0KKRrLTmvfnpwduaMRjCLdaR/9eIxtbkLGNC
	Vsu+Um3y+lk+4vIfa+tCOnbIyTpF057ktBF+eXlmxcujzKAmqtHhFyYTtzKmfZRp
	M1kJjhHYJ7UMjJjrYhxC5gn4sv3jVPRtFVHPT0eJv6nRuS83G/fAN8OJt5mRZX7/
	dvlgZcsVEpwRLiMJK4uXH2YYrbC3SPegGyJGFzMh9vNptlFBURv281TA50xz78h2
	nVQSeJsWttOvZBYetsLfcZvpZRG08w1UzLuvLKKvNl9eiCfSVKqxxxm4jIEV4pxd
	laKJFolY/nkTb+wSOcmWPQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt6te0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFfHAu026407;
	Thu, 17 Oct 2024 15:56:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaej4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/BtaRgh/1tWZSiWX0p5CYv0RvwTc7y6/DqkHqXfYVQUFwzMnD631Ktb++HJVVDJ1Aqz26L3AyP0bb8m+WIIM1WXqcLTMoAka4wa9N/mmOSmU7xLTxpSyRNunMDecGb0fU8PNWtRu0uyKuU9cmdbG4yCCpxuAWHOjDTM6ZTtxlyrnLouyQzOOnjX4mo7ZSP5jzCD5ksOnGIP7xitBGs9sPO5bm25hS78M01fbzNrGsylQFVU/rAS3hbwUhvFhxrvz84Ts4Bo07cyllTPmjVJWbmudjFdzBlc6ljb/OJkMeVnj27HEov4F4TGBa/ikr2LfQzJ9rs4nDKjWGVBnnZ7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNu0atCC/CaTHi28ICJ2AfLFW/9yMfSjcd4hKj6n5BE=;
 b=A0zpcWbUWio//TBayWVu5ra6slEDlFU0q1hniySt3RlCulZU29Od1I3gNFSI8vF+4BfHwodwZRRpa9C9wLzSX76xAkhoMwWCOwxmyuXI5qIClvcsOM2lqWJbXioAHKJ5McrvefYPjoVnZwvbjew6LTnmOBEB4mvDPrkaVVL/IFmVd5sXuNaYXqeG2ey79UEuPgvdFyc9lPUt+0h9rwwMu3AboSyHSyv/o39FnlJwMGXTv2MEnw97+IPXwIMZZs/24gLax8DqdMPB1KBMNOkiL2gxqZpA4DQ3fwOcfn1ruemEJDMnYA+rHfr6GRzucGs3RkHzlhzoKfVORtdVLuI3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNu0atCC/CaTHi28ICJ2AfLFW/9yMfSjcd4hKj6n5BE=;
 b=qiXK/IO5oD+K/xtqUmFF3g+tSCe/YOXNlelKAJ1jL32jdguoMBBowyPKyMJwrzb/2qhWFH8DhgE1XpMyWNeZHgZd8A1sBpJlM5raEYN3moBPjMEJW/q8x2TSZJBPHNuVjn2COidL1H869QQWDluj1X2AzKL3cifTHq+s2Dra8oY=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 15:56:07 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 15:56:07 +0000
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
Subject: [RFC PATCH v3 09/13] clavis: Allow user to define acl at build time
Date: Thu, 17 Oct 2024 09:55:12 -0600
Message-ID: <20241017155516.2582369-10-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:208:23c::12) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 9638a801-6a60-4ee8-466e-08dceec4358e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pHdf70g/EyBtzrFj0E+3CVJ4WsAFK9qahu9ZCsXePOE0SLks9yFI24eZQB8Q?=
 =?us-ascii?Q?+6YFayCw7Y6wu0fdE70atQ7ONFesVLnHY5Slh/UncZIyXmSitZAkTjeMW6qO?=
 =?us-ascii?Q?BqhSNfvMd1oW7bwI2sv/C6htqpC1nbhSxlhfKI1JzJVlagQnoeCTvzzpbA2r?=
 =?us-ascii?Q?bFMFDL4q0ShZShv315p7UskssO3QL4t386+BTv5NxJZP4pc5kUL6mjdki+Hs?=
 =?us-ascii?Q?EZO9rUoiT4BGS7yjEq8hDGJvpF6RP7B1yINetfZHlGatBXVJYqFyD5y6s4Yc?=
 =?us-ascii?Q?eru9DFVD1PCPvPioDBBfuhEAZPb+tatHO3dUgfK+wT5/MJxtDIA9U0as5bQo?=
 =?us-ascii?Q?7RH0e6ytd99aKqjvjmr1eL/Raa7Z5W4S0Z4ImY6OjtuTjNSLAKLnDoiAZP1y?=
 =?us-ascii?Q?yHG6Wl6b/u1s+yBjovyaPt6E/wD/sJ7dbwt5YM7tUjsXjAgMroFYb/iw3WZa?=
 =?us-ascii?Q?1RC4DZdnntAOcJGfbomotknzIzwNvVwutmQidx6LjazTQdAWZbjvnkfrJ6qa?=
 =?us-ascii?Q?tIQ+Xba51SZ8L/E9jIH8B/ayQQUCC04+bvfeohxixcPMI0pZwOskzNA5w4bc?=
 =?us-ascii?Q?7h1tY7+0XsLQ495sHZ5xLsnCe4YkQdqRRko6zPhYJ5qqHKDROdSP4XcUWsGA?=
 =?us-ascii?Q?l/eRQqtosvyaBDvjDAj51qShfiaP93WemRTrpoBD6LTG0urElOSpHpldLuFW?=
 =?us-ascii?Q?sfzluwO+9mNvsiGNpTYe18CzH63KvdHEIu/cKCJUqn3N+AF1aGdrtVt75rMU?=
 =?us-ascii?Q?V4HJce3dJ74jU6zYhGfaQgbHLpihX4T6NulA/LXyTa+06ya2G3Y5dkT7ZMY7?=
 =?us-ascii?Q?KuAVp1TAn3luuUWjzMd1Y+ynVH6BgxOepAqNAfE12Yyl0NESicsMJLBhbbN0?=
 =?us-ascii?Q?zru1raJc0LZhG2faEUEd1NG/JJKF/oEyspRBCYA2M8fDsBHiR6JOctd6WTL0?=
 =?us-ascii?Q?jqiCtSS0+l7joPai1f/wvme0E/S/6G7pNfduHWKFjZ2v5M6lICdIZLhqVDHY?=
 =?us-ascii?Q?DHf/JrG7LXHOGc+oD7LPEjmW9YbcqlhVEAIaM9ilyvPVA/1sOD08qkFPrO0q?=
 =?us-ascii?Q?uuFVyV1RGi/A/7TDFj7x08XCI3OJm3Yfct3uuWpPxtV7wwMhASD3NiCux5XV?=
 =?us-ascii?Q?Yqs+IMykRBucjKp1VSU/k+wruWARTPXzYoW/KCfa8j9ojh1BfDQWKwdr1c/Q?=
 =?us-ascii?Q?91F/u+/wyElvKuG0+LN85e2sIAPc9HqJT0KAv/53or279qsc+BPLIYrtoBgD?=
 =?us-ascii?Q?cwxGICYGAKI+mEyG4QYAgInVmHIySk/lsRns2IY7OzDe5TnNMg9C7UG0UNwf?=
 =?us-ascii?Q?LJM8Q8P6VFs3QqkQuD8qxCwq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TiJi+Htb1ErwwUlkZ4UhxArm/dddf00qqRk0OB2sno+n2DEG4uepfUWkvwHm?=
 =?us-ascii?Q?9vIxuIlM4fl9j7JvEYQBBDNF0vbkS7IM5buEry3l+POYAeTeMJtAZfQ3gAN8?=
 =?us-ascii?Q?TQdDWLmKo/hU3Cc80GGWlfN6hQe4jOD3U88zfx/fEm7SdZOP1uqjfbBAHUNR?=
 =?us-ascii?Q?i8fk/pblXOoWU9UcHXP2rCcvoGcEe+WCKe1x9UbiqEX/pO+byIU13z9bC/6i?=
 =?us-ascii?Q?5PGPwf8PgLEzvEWvaN3Zl1Op06hIGI/g6kHGgKGwc7Io9kBNFAa9/DUYVY7t?=
 =?us-ascii?Q?9x+JEgU2aF5ZeplO+wwgzL+93YxynnebJBnE7VXpK5AV2G02wmk4nSeLJmvK?=
 =?us-ascii?Q?yrN39RUm3r5IrZGIN1q0SyPaZ5A6zkbsD91CIHtoLTvbH0o9SogLjG6BvK7W?=
 =?us-ascii?Q?Qw5XmutkIBsqP+n+CJl+dJHWv219AuJOFyw63ek2lxiVJoQGKslULoQopFM1?=
 =?us-ascii?Q?TZsbLtiiSRHsYTUcDAlh6l6aRw2a754lp3mnCo2ShUjbOtBr3wGek2aC89bB?=
 =?us-ascii?Q?+I5Xk6Evoj+c4tSe7Ck8mW5IlFTi2rqbQT1FgaQ0crWSNi0B+ADZ+IeTmBmu?=
 =?us-ascii?Q?+20pRrvMK53cCK1mPSbCp/tRcstorTbKgFJwJOh0cOzp8vm2Ay439IGX8sAh?=
 =?us-ascii?Q?qfFIbE9R+1SPJpVVaa8t5xavxNA3QcK3pQF4ZIyR9BwDVMFismEAD5X3H7b0?=
 =?us-ascii?Q?ucZfW2NG5r6eQz9p1uGo6/jdKE4Qnu5+u1t5K955flBKdL3U9bryHqRxsW6G?=
 =?us-ascii?Q?0Tj3SDLjMcBxsVNRH8lpB5U90BBGwcL0zPBIqyS125tlCeQVmDk/Tl2TRvbp?=
 =?us-ascii?Q?/SqYizdZtc/jIVxKAFZuQHP4mDQUQr/2tMPy9WFsOCsYi2yexUy+Nt2zQECM?=
 =?us-ascii?Q?dV/dStIQsb57767vMDx1CMkPOQdZFchLAk8qUVIpfyCIsxuCKO9SewvPrf0A?=
 =?us-ascii?Q?/23IVbYXL9PCUq29B1xli/yEEs3iqcxgl4DP9V9pcVoc5CIjmVYugQKXUG+J?=
 =?us-ascii?Q?KiazwvUdZCKxcgcrzlPiI+pus+sbcOh57QkdsfUtPxxZPZqICplbxhS2Vxxn?=
 =?us-ascii?Q?inKvozEzoJ7/x8OyDPx+k0lK09bw2fU3MXhW6K3PwzY6we+Wus0Vfh1DbvOm?=
 =?us-ascii?Q?L6dmEe5WBcZ1XcKFs7nv2salZQAlueRobdUpmGixwtlg/2wDu85JAK7pyClz?=
 =?us-ascii?Q?3UohCCpRB8vjydV+iQHulfcRs24BwEO8XfdV1C/AJKpVV7O0mTgXVUyAbiYW?=
 =?us-ascii?Q?LQYicuXSMxwF2YC4XxQYwEGlZ9TxufCwYCc+J1cRXe/IY0kK8x/Jw6I4P5N6?=
 =?us-ascii?Q?OA30mN4YvnSbI69nNlitLYD4hbomcQoDmM6ble6E8A7aCRLb4EiCfLKLJLFd?=
 =?us-ascii?Q?nPA+d2azEOJCObSuJZCSnEMfcXlUFOtVxnbPRxGxnJHev7TEeMrG3liUujgC?=
 =?us-ascii?Q?qhNe30niku+4qxbSExC4/QrtVtybmAOK7Yad7u4og4WjDcYJ7XBB07MkLhJB?=
 =?us-ascii?Q?Y/g49BX3DoNmk2xMSvRAr/ZZtE15ByycH2GWk+VBwDlLaPxvrJbJ1pckSBKL?=
 =?us-ascii?Q?OPlezbtVo9hxvpYiXFehXXaNQ0T0YYLpw9kEzEXh4H2UXuDkJR2GQZWqEGJK?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SbUCcmK738lIOSYXwuefMa1KyEQUhJdoGMRV6/lVRHQNtQLeaOZGeqasPM/ts6dCuOUsrf7YBUxrnDsgST/vyWkHp4EOXJ544dlzhTEaqxhCPW4Y88DiFFLhrtgbZlBhHRguJQYhPlWftIU2WhY+x6eVtWz6ZkAxqNxh+XJqUNf9IJa9XW3x4dsMFmCu79VxKVGb9JRn+Eys8mMJ3ssP0ZzV6x9CXwAiEZwyl+iWe8SkyXTTDvTkMgD+Fg7Rih9+0zb5LWl/GcaevKefVaDsr4xPjrXv41Bq3h/E3wdaaK1edsthZ+jzNU4kRjKiFni9c/61aXzTHezXRxIpaHzVaB0BcfOw8s66vmKOVoNVjVg3o29ln4Ohjfkhd7o/beUBPphiXIJ3qA3mm8g3FYT63tWh422OWP+EU1xfBLXL1D+URJ2eRjGoPChhB9cCFYHdpsnk8mi4+rSZGJBU6Itdb88uyF5q+qVsB1fzWHg2pYhG5isygJCoeB6vCUeoi1sLJh6PtI5obiTEiX1BoiBhk3CtsH5YEqda6WX8IXrVscl+5sK9tBFue2Lu7Mgkl9d1mJhK460qwfmaHgA3COHvd86ON6lBA7EEDtFwa06Wf28=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9638a801-6a60-4ee8-466e-08dceec4358e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:56:06.0781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HR5jKUR7Q1U/8QxPeq7xVqmIKIF6HNdGtUMX3WGchuZKIWO9yFjm0mWCf3X4oNW4+3zUnFS2nE5p5KreJEOnX94s3AdX8boe9svspdx4P6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-GUID: U5p-hYNPRFGLqGcPBixGVQXJMCsoWuuV
X-Proofpoint-ORIG-GUID: U5p-hYNPRFGLqGcPBixGVQXJMCsoWuuV

Add a new Kconfig called Security_CLAVIS_ACL_LIST. If set, this option
should be the file name of a list of clavis ACL entries. This will be
included into a C wrapper to incorporate the acl list into the kernel.
The file contents must be in the following format: <two digit key usage
number>:<subject key id>. If more than one entry is added, add a carriage
return after each entry.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/clavis/.gitignore           |  1 +
 security/clavis/Kconfig              | 10 ++++++++++
 security/clavis/Makefile             | 16 ++++++++++++++++
 security/clavis/clavis.h             |  2 ++
 security/clavis/clavis_builtin_acl.c |  7 +++++++
 security/clavis/clavis_keyring.c     |  1 +
 6 files changed, 37 insertions(+)
 create mode 100644 security/clavis/.gitignore
 create mode 100644 security/clavis/clavis_builtin_acl.c

diff --git a/security/clavis/.gitignore b/security/clavis/.gitignore
new file mode 100644
index 000000000000..c1b60bee049e
--- /dev/null
+++ b/security/clavis/.gitignore
@@ -0,0 +1 @@
+/builtin_acl
diff --git a/security/clavis/Kconfig b/security/clavis/Kconfig
index 04f7565f2e2b..b702311ec905 100644
--- a/security/clavis/Kconfig
+++ b/security/clavis/Kconfig
@@ -9,3 +9,13 @@ config SECURITY_CLAVIS
 	  keyrings (builtin, secondary, or platform).  One way to add this key
 	  is during boot by passing in the asymmetric key id within the "clavis=" boot
 	  param.  This keyring is required by the Clavis LSM.
+
+config SECURITY_CLAVIS_ACL_LIST
+	string "Clavis ACL list to preload into the clavis keyring"
+	depends on SECURITY_CLAVIS
+	help
+	  If set, this option should be the file name of a list of clavis ACL
+	  entries. This will be included into a C wrapper to incorporate the
+	  acl list into the kernel. The file contents must be in the following
+	  format: <two digit key usage number>:<subject key id>.  If more than
+	  one entry is added, add a carriage return after each entry.
diff --git a/security/clavis/Makefile b/security/clavis/Makefile
index a3430dd6bdf9..082e6d3c0934 100644
--- a/security/clavis/Makefile
+++ b/security/clavis/Makefile
@@ -2,3 +2,19 @@
 
 obj-$(CONFIG_SECURITY_CLAVIS) += clavis_keyring.o
 obj-$(CONFIG_SECURITY_CLAVIS) += clavis.o
+obj-$(CONFIG_SECURITY_CLAVIS) += clavis_builtin_acl.o
+
+ifeq ($(CONFIG_SECURITY_CLAVIS_ACL_LIST),)
+quiet_cmd_make_builtin_acl = GEN     $@
+      cmd_make_builtin_acl = \
+	echo > $@
+else
+quiet_cmd_make_builtin_acl = GEN     $@
+      cmd_make_builtin_acl = \
+	sed 's/^[ \t]*//; s/.*/"&",/' $< | tr '[:upper:]' '[:lower:]' > $@
+endif
+
+$(obj)/builtin_acl: $(CONFIG_SECURITY_CLAVIS_ACL_LIST) FORCE
+	$(call if_changed,make_builtin_acl)
+
+$(obj)/clavis_builtin_acl.o: $(obj)/builtin_acl
diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
index b77e4ec8edbe..7099a517b111 100644
--- a/security/clavis/clavis.h
+++ b/security/clavis/clavis.h
@@ -14,6 +14,8 @@ struct asymmetric_setup_kid {
 	unsigned char data[CLAVIS_BIN_KID_MAX];
 };
 
+extern const char __initconst *const clavis_builtin_acl_list[];
+
 #ifndef CONFIG_SYSTEM_TRUSTED_KEYRING
 const char __initconst *const clavis_module_acl[] = {
 	 NULL
diff --git a/security/clavis/clavis_builtin_acl.c b/security/clavis/clavis_builtin_acl.c
new file mode 100644
index 000000000000..c98b6df05413
--- /dev/null
+++ b/security/clavis/clavis_builtin_acl.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "clavis.h"
+
+const char __initconst *const clavis_builtin_acl_list[] = {
+#include "builtin_acl"
+	NULL
+};
diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
index 1e1fbb54f6be..a4a95a931b50 100644
--- a/security/clavis/clavis_keyring.c
+++ b/security/clavis/clavis_keyring.c
@@ -300,6 +300,7 @@ int __init clavis_keyring_init(void)
 		panic("Can't allocate clavis keyring\n");
 
 	clavis_add_acl(clavis_module_acl, clavis_keyring);
+	clavis_add_acl(clavis_builtin_acl_list, clavis_keyring);
 
 	return 0;
 }
-- 
2.45.0


