Return-Path: <linux-efi+bounces-1990-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0D29A27A7
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5FD8B269AC
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE531DFD8B;
	Thu, 17 Oct 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CYaj1bYG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oOAIg+vQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9721DF743;
	Thu, 17 Oct 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180613; cv=fail; b=kWQ/FVSg/9A5cFT5iPaqhW2XLOM8GGEKdHQdlgY5+Yxhy4DUxOicmHn8EJPLHshtWZhCmf1OLQX99mRxBkijVx8/T3zckzOf6Fkphv2/8G6WtetQtUq8lfMypTlK29cXtBs7KaKoiZ1n5vEKDXMevYVDh9zFa/C2JUT0z/17rXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180613; c=relaxed/simple;
	bh=PFxGllvfRbrzwkppzuEajlEZyEBBKfeGtWMMWH/TkZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B71DKE5PXX9ab1YBFQk10YWbuRsgz5xS1hTxgAKIAKenvpjyMUUFdB1T4htmeL+U5T6wf87Xi23U/JhD/4vhyfHs5HfLrTj7FAshMhvRJ8VMOtF+o0amliBi+CAbc3pI/t+f7iosuZLvf3+LxmbSUfVqH/ZS1r8MzWLZ+c00w/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CYaj1bYG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oOAIg+vQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBhYi028803;
	Thu, 17 Oct 2024 15:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Nojvl3wQnA54MTg1AJmT+MJRliJCpkx+2ocL33A0DVY=; b=
	CYaj1bYGQWTw7L7qNPExfCY0+br7xGtuZJ2SwK19CTCb806S6dPa3fGCygAjlKII
	PqFcLAUacIu17e8cTjSGlE3PGed6cTtOdpWMLY4LBUjpV/BSRqLUZN1iSqJ7gnGo
	fuaNECn8Xhg5aoiUP44v0jtXx2XH1vjpMHRVtdraRBSr6mBpvnTtjpFzILDV5nsX
	uKGkx8OBr0n2q77h6uJcsovCy6O0tYR/BAZkCNVq5uTd+38Z7Fq6vUdUsn2gc5ZJ
	jZSZH1tdKoClq59GMEGeCrYAK9aDXz5PskUTTwNZYPda0gxpGmPH8rLP4pnBZW1c
	UNutTPVUB2rFU8jKd3ArkQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt6tdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HElWMT013904;
	Thu, 17 Oct 2024 15:56:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjadu5p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqLTYDku6VhBRF5XyfNMuaa2q76HqbCcOObO5YX5qsQePtPMKCHENwSYbLmoA8VozsVC3j40wlfCRA859eqrWFAonshH03TDXOuny0kompZNFe7md/H6HaSOtXXfCCqvu77LXFpY50seG5NXiCefPqubUPpKw0xwiWVyNrVMYc+2KQznEb86wDlJKKWyW0kihVDlF0JScHC+YljkpeacKpkjAy/X2/yZBpgObDkxtyqBcX/pvtabs2bBqlr038KbWap4nRJH6oQ+wFNeeucwv4oWPBORHuRnsMhT/PBQPH9Yy9Y8g6B4mNG8bI6Jn/VLDRet2687Xz7dtKM+EhzvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nojvl3wQnA54MTg1AJmT+MJRliJCpkx+2ocL33A0DVY=;
 b=XcbsMSLjkXzObENj/h/TEvtTgZzhXYZ0n9qDekYLFQ9/h01FXS+agemKnJr2PVlIJUs2ibvH2oBlcOIW4VgErGIuaeXV+GgcYZuZ7CEgFzXHFWCib6Pc8C4Eh0/r4OnAmnkvZM85USbU7VSP/k7QQB4zJ8Vg+3g/sFDNJXrXwA1V+sfT0xsqO3yy3/FAAw2MX/iUoipzhHHzwrvJ1STryQm2nzizqvkKTPGhfrXGIu4hAdN83CYbryRWPnMC9c7dG6yLbShYtxXRnl97mVqzOEiD1K/wDUz/KFJDL8VtMpxwY2RZw8mRSRKndouRHOm6zBW3pUwsE0ePZ9FyMBWMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nojvl3wQnA54MTg1AJmT+MJRliJCpkx+2ocL33A0DVY=;
 b=oOAIg+vQznXLcdnU0wH3v3/3+tKoJrvjbm87J8IHg53wodeyFnOInARXlMvxz/Vn3TzuMUvBO3af19tr5n6vCVZ5H6n/ON65Bxp0mmAfCSvASSFDWH9E5WWIrZag8DT+GZ33B/Ybtz0J3/mq3gGZNWSaZA/b2dc63OtIT72qcss=
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
Subject: [RFC PATCH v3 02/13] certs: Introduce ability to link to a system key
Date: Thu, 17 Oct 2024 09:55:05 -0600
Message-ID: <20241017155516.2582369-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::12) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|LV8PR10MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: e3788ef2-606a-40ca-a7f9-08dceec428c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xJfRSRjq1sik9njmrhhhqcle+Jj7gpuFmovQxeTsdJB7f0BD8rHi7bTxxlhh?=
 =?us-ascii?Q?aBBafSRMHA73I3jKHUNdAOEM91nUSDryABcjbvbLwAW+oNmlTAkRS58KlNUN?=
 =?us-ascii?Q?M4dXsmx+yCVS7YZnVzL1+iDX7Ngsh7e6hy0cLvbQnzX+jaBgZoCY/LTxoAxc?=
 =?us-ascii?Q?Ym4tL53h7nij/IkOh9ENKKiTa7adv4VlpKGpvlRG5d7RQAKBjTSHLplzmGe/?=
 =?us-ascii?Q?WYMBp7gMpOUfbH9qRkGinxoZpfb+yqRLohQWScscsf+A65WJ1bVZCXLn/x5i?=
 =?us-ascii?Q?pL9A+VXpPe8B0YbA7SU0apKFDbM+DvKUorKabJmVjuc2vB3VYJ7yqrgv+xsV?=
 =?us-ascii?Q?yf28tiSCGe99oVzFFLvDolEQu/8BIZ+D6AWpMeju1q66QapjZigAc1ldG5E8?=
 =?us-ascii?Q?yqn/3F8w2Sr38/oJlIqNGAA8gyZg1QWsec7A/ctXjC5ZdmWSJWDV0l0EejHb?=
 =?us-ascii?Q?5JzDF1jISPdNeRRGQSp83vN4EBUhNgEnYt6EN3PosNZTGKboH+15yUQienV/?=
 =?us-ascii?Q?mX7Wu+/8zrZs91a0Cl44JmFE4mQ5hsqbRJz/bcY5fb6eUKlT0DPiSXNyjumH?=
 =?us-ascii?Q?L7X+9xdSKdqiK98lueSNgwqcyVCmwVUw+9Ad+Za1EJyB4q8DnpCXhE6WhyMJ?=
 =?us-ascii?Q?ePH15LAI14g7neu4B6wz+zDKw91wayDB+tsXpzLEkLEe8oKPXeFyi+7mg7YT?=
 =?us-ascii?Q?yQtciTJCVdNut8y7+vhHZ/ae2Ar+E6i6PzRBN2jcZg2Fj3DiiBAH52dPt6lG?=
 =?us-ascii?Q?Gn7340ivC+RiT8Se+eux8KnUco8fWYqPzdy/6AtmM/gKqPd48Fhlw8kGJjps?=
 =?us-ascii?Q?aVa8pDMICFZEVa9V36LNXK6QSIiUcqHDoHe+CMohmc9sy3NizF8u4s4mwd43?=
 =?us-ascii?Q?vMRGXAxTOHtgUuA6V0PBhgXjspQAkWSbzXJEued0IcRhMD461/XTeipPCGxH?=
 =?us-ascii?Q?xF7+dU5y7ngtJaYTMPlokzYpZL7ZH41Rr3Ap2kqJP2bBK1C7DIGEwmdj9Fc7?=
 =?us-ascii?Q?Ghl+2L397VxIrUnCWEsDkzjHuEiQgD1k5iD+cJNhBWTraIcBs8WK+vv7VVrm?=
 =?us-ascii?Q?t+T9AzYou3VQzDmxx/KDKuJgzfakIbpCu0El5UEp5aL14z7J9TrnStZ8PmOH?=
 =?us-ascii?Q?K+QCmDJFvD0vPheby6vMNvcL0EecBoEvu/NDQhJGWTfIhk+S89qNHgviCl01?=
 =?us-ascii?Q?ywbf1As/9qaTTeq1Hswspl34dAmSG0u0JdiMeq9wv2vaUuiC3gJ0KE8UXcl+?=
 =?us-ascii?Q?Wl89Y5STXULKoc+uvE8PQ34yOVgXd2RMYw33wRIwLlbqAg8pJAqot9UK4vXg?=
 =?us-ascii?Q?Z3kGw1TbdWEi4RR4nXUQjLxP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vs0zZmNhMfHeEQUHrRMT9+0phkeoGQYpoalwqq6xPnW6Kvea3dGG3V41Y6e8?=
 =?us-ascii?Q?ti8zRNpEf45nZjeJcSAjLxZvwnZ1X2yljOwkygzGGmu1U24jvqb6gRWEuXtJ?=
 =?us-ascii?Q?Djn2i/N+ORMeVv0C17nH+2Lf2hUO+PNMydy75RJIHM8AC/W/AFwQpkovwoZR?=
 =?us-ascii?Q?E/ccgspKTFTayk+NiuvArQDot7XW99FAFrct8pAIVZWMCNc+TrPf8fj7doVv?=
 =?us-ascii?Q?Ik8F5H3770BY2hf1zUgIilHJ70v+Tfffh6Ifmv2ETljVwgomTD4CIsxEPVSR?=
 =?us-ascii?Q?WkPUfDy3O9j5xogAymPMq8tY+9xt84madZGITakVjb81xwND+MRp7Pt2/Bdt?=
 =?us-ascii?Q?LxRpW8DAUySIlkO5pV6kMbeE0Um6P3KpRbtMIzN1zQg+V0QOkopGiEO8tfvi?=
 =?us-ascii?Q?/mKs+pGfCoC+Qi+XK9NSuRWTfwcGtd4MJhS3hOioIko+bwGs9HRFgoutVrST?=
 =?us-ascii?Q?PwzopeVsjnPK0H7VDyTqA+ZdUDD8QwqxFhtP27Zri6JStqY0oYI9aEsMwxQP?=
 =?us-ascii?Q?pNlOuPz8ZvabWev7f3mj9TLZ28vBurdYf6eEJMFYToiSokL1D5F1j+ncN/my?=
 =?us-ascii?Q?OoTCUUBV2ClHyaKRGq8jCzgbFAN3gCCEOtReE0gj1JKFq+WCwvAtb/KlIrEq?=
 =?us-ascii?Q?ICKovlk77LfpvZDeK7pa0i9tcZ/nU+d7vInNu9Q0+cepUIXbZtXoRSpaJWoo?=
 =?us-ascii?Q?dvVDbmXLZ1x+hHUG/4ZbR6ROYAFXEwMrO3AaMyIk7+pgnMqNxfImxzizcorQ?=
 =?us-ascii?Q?6n0PRiQFDMFueNcMVPu5O3vADj7Xy3pyQ3KlaIOklrITsVPJnWXUDyCwWTHg?=
 =?us-ascii?Q?ADGtE9gZkrJZcEc9rhKVpep8xMejmiNWgdkY699nTDqo7OPkv/7Kn3UDHEpl?=
 =?us-ascii?Q?c5at76AenmX67IFnBdqXhvQaE/BAC05WekJDNZn7WYl8/CaxZnXpuqCFnStq?=
 =?us-ascii?Q?/KgYU2aFGalqdZlnPo5XIdSnMrNASBjm8GfruP/jwlg/Q2P3ySLrMLzo1fHo?=
 =?us-ascii?Q?SNnZhT02+s/NIc2qhPEPRsqutiDFYelC7uysRup5H0dyLXY5oA8JEfbq5LTG?=
 =?us-ascii?Q?0wdDEeFQpJfF54be22smzI9XyYcVkaul1PST/MWp9U/sFr0De4OixsswV7ju?=
 =?us-ascii?Q?bFVGDQ21ypPAmYMf90yA80RrbuomoJLldp8EVLMKGu5q6gQM0uLfcklvewc8?=
 =?us-ascii?Q?f4V6RGHZA1mP2Pr7X7XEsBiubh36x0TxGKUpQj/1T4Wg1n4ssH52KZV1SZER?=
 =?us-ascii?Q?WP/A2aIsoVRKTA/VW7ZOAW7NzbtsmakChctTdIQvv29PrvsOTPXO9mbyVw9s?=
 =?us-ascii?Q?AiD7W1ET4nAQZSmsq16Lw7/BNiyKkbZpPzqnYMsXwlH2vy1zuXfOoLQqYvxy?=
 =?us-ascii?Q?QOpdACSBrT41bfGCxUOHXi5X0zFHkz+jg3FkjuNLlE5KQ48dbQvEBoRUnifa?=
 =?us-ascii?Q?Ic4/3lmPrmCPokWHnRh0z+GqW1vR1/KU7ujYOKaT7r2PCtNb+4lec4UoeLsD?=
 =?us-ascii?Q?uGk94ow0mcJhYX6DGni6jHqH7LuIX7QmM3ITR7BrcCIWGU5BIBTwBu1Iixru?=
 =?us-ascii?Q?n+amx3bwXvLCP4Ax5CotJ0d5Xn3OjwB1XYOq6VrGuM917COcjDjSNHOyX8gE?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q1tcoYZ9jpA5e7jgUmQ7/mk8CqMQU+WGf8yDB8m1CI85KhcNsti6COLUFc219aQdNUlqVNvg7TbZYZ/AytQ7t+hnaW/VpSfbkKhLRmVONl41Owdw/jnQJcNVJg9YfoSA37Uf8nhaw9sEt5BOgV3lhAJiMtbsBKpGbXNVVcWl4TwZoYRzVHAx2e/hHad+wYjnlM04CmCrzBpvDXi0NCY94naVWXZdZrfceqxSV/Au3wrkgOo9Im8P5k1EJ0IIm0jMJZFgEm/wYzSZwa92QrRpi1QnwbAqH5AzO8pCvfsCe03e+K6NXBogjG7otXvgXsMhVR7PocQMtSkWEebuXV5dtvp3Tjy9hNZjWu0R2rbLkLfNpmfkbvx36oMePMzTwq3+OXQmX/h4tx+UV8Q4iQSOZdQ19MV7JiecaHylmd51VlkK3Y3UjPbxUcEvSfzxTrQY6P3tHkD3j7o7RSzrBCCyMibJoe+2T//h+C9Qbv1GogqDqsqn0nEQGYptMMsqrhkPyjVqukFlBb/a1FQnFY4H8TXwbXMQo38j8UWjg70v+QPvuNejTPlYVf2LOI3I1Eu4/W9E3WZrCs9DBHm1jqxDQI8nLQmvLkx/ccR0rAY2h5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3788ef2-606a-40ca-a7f9-08dceec428c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:55:44.9061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qS835+jSXvu4DJ8XPkd2blu2KUA09xOG1yCd7ZPktHwjRqCF7gXhI0YOF+aNNf4h6s0NgSLglDMMpTW777p64GNGtETdNxMSyKCFxsVdGVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-GUID: oKoo18sjZQNsdQOpjdDTZCfdYK3iIv4U
X-Proofpoint-ORIG-GUID: oKoo18sjZQNsdQOpjdDTZCfdYK3iIv4U

Introduce system_key_link(), a new function to allow a keyring to link
to a key contained within one of the system keyrings (builtin, secondary,
or platform). Depending on how the kernel is built, if the machine
keyring is available, it will be checked as well, since it is linked to
the secondary keyring. If the asymmetric key id matches a key within one
of these system keyrings, the matching key is linked into the passed in
keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c        | 30 ++++++++++++++++++++++++++++++
 include/keys/system_keyring.h |  7 ++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index e344cee10d28..4abee7514442 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -20,6 +20,9 @@
 static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
+#define system_trusted_keys secondary_trusted_keys
+#else
+#define system_trusted_keys builtin_trusted_keys
 #endif
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
 static struct key *machine_trusted_keys;
@@ -420,3 +423,30 @@ void __init set_platform_trusted_keys(struct key *keyring)
 	platform_trusted_keys = keyring;
 }
 #endif
+
+/**
+ * system_key_link - Link to a system key
+ * @keyring: The keyring to link into
+ * @id: The asymmetric key id to look for in the system keyring
+ *
+ * Search the system keyrings to see if one of them contains a matching "id".
+ * If there is a match, link the key into "keyring".  System keyrings always
+ * includes the builtin. If any of the following keyrings are enabled:
+ * secondary, machine, and platform they are searched as well.
+ */
+int system_key_link(struct key *keyring, struct asymmetric_key_id *id)
+{
+	struct key *key;
+
+	key = find_asymmetric_key(system_trusted_keys, id, NULL, NULL, false);
+	if (!IS_ERR(key))
+		return key_link(keyring, key);
+
+	if (platform_trusted_keys) {
+		key = find_asymmetric_key(platform_trusted_keys, id, NULL, NULL, false);
+		if (!IS_ERR(key))
+			return key_link(keyring, key);
+	}
+
+	return -ENOKEY;
+}
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 8365adf842ef..b47ac8e2001a 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -9,6 +9,7 @@
 #define _KEYS_SYSTEM_KEYRING_H
 
 #include <linux/key.h>
+struct asymmetric_key_id;
 
 enum blacklist_hash_type {
 	/* TBSCertificate hash */
@@ -28,7 +29,7 @@ int restrict_link_by_digsig_builtin(struct key *dest_keyring,
 				    const union key_payload *payload,
 				    struct key *restriction_key);
 extern __init int load_module_cert(struct key *keyring);
-
+extern int system_key_link(struct key *keyring, struct asymmetric_key_id *id);
 #else
 #define restrict_link_by_builtin_trusted restrict_link_reject
 #define restrict_link_by_digsig_builtin restrict_link_reject
@@ -38,6 +39,10 @@ static inline __init int load_module_cert(struct key *keyring)
 	return 0;
 }
 
+static inline int system_key_link(struct key *keyring, struct asymmetric_key_id *id)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
-- 
2.45.0


