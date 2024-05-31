Return-Path: <linux-efi+bounces-1094-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6748D5742
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 02:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A235B2872BC
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342D06FC2;
	Fri, 31 May 2024 00:41:56 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1D6AB6;
	Fri, 31 May 2024 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116116; cv=fail; b=GRooIyGzj4qNqx94OSU1VMNvg0uxQ5THf0Lbv/es7ReASo1Y/ZcaIM1VjpTOJuZdeEjgOOLbUcczYBMlMfbg4gOjy4ZVPHBRSmgHkakaEAdoGj+Stb52u+QXoyVWQ+86vC+Ydy/d0igw7l8MyyigfpEAywdnke88thWjMe9o9fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116116; c=relaxed/simple;
	bh=13OTUR1JrftSdz5wTB2uNsIEZyqLRxhWrLppd0Mkd80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClTibDulNljUueFfIGCmiCPKYadSU/kPNReRrzIk3HfubkC0kPN8c9n7Hcr7SDe/Bnct/enTpIiLc4+a7lvUzqx7ZgduXXyrBFWMLSmLDgionqmKFkxHsrcVAauNFdahQZ5VL2gaAKjtuFBCAgKgZoTfS/ea0eX+bgs/6BQ/x3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFdpQj018500;
	Fri, 31 May 2024 00:40:27 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D6tVqAtBqVCFaMj0ujhY0KcsI0reA3mIzS4BhuUtBP1E=3D;_b?=
 =?UTF-8?Q?=3DbF381lwTJuR7N54QZNwN5rw5hZJjq1pGOkBrY9Q05S3gxSxRbHRhSthrMueg?=
 =?UTF-8?Q?Y7V8TZds_9haEgEBuQt7jgxPMVa92ZPu7lWW69yF7megzkCpSPuJncBeLnGLX+C?=
 =?UTF-8?Q?hUqGkSEGAaxKbG_vHVFoN82RFSkT4ZhzxZyWIF/96eWoZGX+zETuFT+2bWMvePc?=
 =?UTF-8?Q?rYuhVFvSP2M/pVbgcPeB_U43ZSuPLKH86o0PNwiBkiXOYPDzqZDfW8LgfdxX0bt?=
 =?UTF-8?Q?oULUhBUrBxOU8XVFyhgo5HNIUP_zGJi5N7WG4R3eQMmmAxizAuspseu1dt6V41j?=
 =?UTF-8?Q?BjGuBmI9EvBJWYZGFYOVDnZ+66Exo9te_Wg=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j8a214-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UMCOER026633;
	Fri, 31 May 2024 00:40:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5098j24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA79pFu2OgpYmo2m6jFUBTUMixEhLbDRu08YV1fcWqfvT/VD8Bs6Hovt/5C8yR0bi7sO0FXNw3TYscdA5cFpA19dtRCdKoVtV4KYCT4la7pFkseBU6+mQNQqqVarwqGZaA3kmEkz71Adg+anTJ9XE3e2ZqTw4trFZNtnru14LTZRlZC9Fu4nYkug0hxr4aWI5znjh+om0ZHElxv3T/hdnEI35WJi07tOeN9aiXWuEtqRb8HPrtLi0Voam8ulVPWFAVxQpgO5Cah629fruLZ4t+T4CfdwdknrVgLy3gG9I7wOFsqHv1M9MLI7qdbtJkyQ+zA8gAWj+0ncfHm/75vH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tVqAtBqVCFaMj0ujhY0KcsI0reA3mIzS4BhuUtBP1E=;
 b=VepUCVUt/808xSH4ToX9e4aU5044IgTmDeBX5dT/rLhafVKEaFvMvdywl8SOmCZ9OE1MdlYX0N/MkhiYDY6VoXIgJLLmFqtFqXRAFP4rruq/cPaK/PgEm8LIJxcU9UteFL5te0YmQEWywOOvEQ2zeqBhaRYdpUmoGDBp8Yxo79gDAkqOXI+2/HMl+FXY8Bma90t1ZtDzu7tDcNtSbxG7axBCR6mHMNptaIcoiKpcp2SGj13pLIsiLIdlII++miV0Sru1tO5ORTilCroKF3WYFn++jmXavqKpI6k0L0ITTuE56K+DIuMfprWfKn8DJAkoeFJkpWtkiemNsMfj0vBOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tVqAtBqVCFaMj0ujhY0KcsI0reA3mIzS4BhuUtBP1E=;
 b=rwMotToZZFvmKP1o5ZSIujKHxaaNqwF+R1Q/hO/n75vfbD+3IptiUfcR3j/mOKqZhXIPt5ZTZfeTgXDeIOsRwUWPS19E2/wPoUMZjvFhsQKgFtKt9o+w3vAMr2Pz8p2Kt5iCB67PkpJA8+ftrHybEICoYSNjDbwoRToYOsZlMYc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 00:40:23 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 00:40:23 +0000
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
Subject: [RFC PATCH v2 8/8] clavis: Introduce new LSM called clavis
Date: Thu, 30 May 2024 18:39:45 -0600
Message-ID: <20240531003945.44594-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531003945.44594-1-eric.snowberg@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0109.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::6) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: cc87c4e1-a954-4257-50e9-08dc810a4175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0eKBoPX4qEBAiVq6TT+4LAMa/IFpxEfEQcVTJzpR9sTTghecQ3AErzwkh3TI?=
 =?us-ascii?Q?8MdqggQSB47RjfYYEvjmNIKWz7v0637VTWOU0mI62dPIdy5JIGET8GyriYTQ?=
 =?us-ascii?Q?rjzF0fJo5/+0SJK+nFysefEWIecvrRYthZsbC8ZrS5JgyLp9USOuY3tx1Wpk?=
 =?us-ascii?Q?mxolMLevKu7ffisYVpneXRlkdOL9KngcU/kcTYJZBBvvjTSAJ6B9eQebYNUz?=
 =?us-ascii?Q?HJ+tAqrttKJfdwzBA33YbyczRgtF7efwawpFLk9xyMQi2SvYK+AJhbisjhyk?=
 =?us-ascii?Q?mv4RleMJPduCId4ORgBt/e2+cDhFr7gbaIOnTHFnMAB6GRcaPp9D6tvKy6d3?=
 =?us-ascii?Q?dFiBD1MnMf2Apm6Wtpxkx/9bg7jkzxQj+ieAZhIqiqO7JfnMSQEfeghzaP/F?=
 =?us-ascii?Q?ER2INEbpXcAdJ2JViuW+78WdP5QN7wCulMEsUP+Sz5uu1HtLRqTKtUAIZ/1h?=
 =?us-ascii?Q?sBViErjzjFhynKXbFEuBeI4JXZEbJtWK3WtcqqO0krnlsLdj2ZVOW0tjRFBM?=
 =?us-ascii?Q?1EsX2awcy5hTEOgLHAUEP7WmXhxJSZpAv57l84CEF2EAPcz0FJ89pME0EClY?=
 =?us-ascii?Q?8DLTxF3qXHz/XJp2OynjmUO3SXpaOjVIY4e63SDztKdeHGe5hEhB7Z239mW3?=
 =?us-ascii?Q?cIutMSYJ4V0BsXS2uBHkvmIZmwjfMBA6exRjeQt6xR9FNHjkZoij6VRXm2sO?=
 =?us-ascii?Q?8PE2AiwzFKBg4MBrqm9pNGyM02CR/c8ybvs3fDnnFtWGgNnJJIqR13ZPHWS4?=
 =?us-ascii?Q?BK+xBqAxt1Afpk2CoIq5Oyby++T1mNRHm7nYs15+GGv/Nfsughm0nzr4oBBs?=
 =?us-ascii?Q?+Ew8zPJg2PJf+ZPPz4mZdQk+/vmCVsJDbauS5xiK1o5VMeNDpZgsMIH7ZNzG?=
 =?us-ascii?Q?pxF+rMipOYL627WMVhB0Ymof/wdeWf7QhRLMXe02mBRn7ZNTovjIH5/0a5EP?=
 =?us-ascii?Q?hSmH1JLZfAJRdtGY3SZVlfkvOtK5t4y2U/LiDYbnNpeKUTGGIF5bsk1XCY5I?=
 =?us-ascii?Q?YOIgL2l/rJC0l095aflflRuQD2c2ueZOtE7Yl+pVW9wenzDN75dkjHvqu6SP?=
 =?us-ascii?Q?S/bSrCsh6PmUyPP9+V45C6UWEm+W9Hh0uy0CmcFhqMsKOL0vzJ5JzusUamJG?=
 =?us-ascii?Q?ZD45vj2SxMGS9yk4jPzKBluSkwVi4XAf71xDWsfdC69sXi0G7PocT60NG4XX?=
 =?us-ascii?Q?Fbb8xx3Gc5KTvcr6/9ImvWMDJzAsn7+/SipTM0N56b1zvdult06QSusbedQw?=
 =?us-ascii?Q?MHqKK+V4sQKmDuGX8temTzMy9QJ18z6rhJbS6p8J3w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Lyu5279BsBR7QJNq5dyZhkgcLeQfMP4/GwdHk25jBcR9ynBYSB5YoZ5X4sPs?=
 =?us-ascii?Q?YQN5Jzb32Q+W3RbLcJc7Z5qUYsL1kxJPcyAZXeBmEQjC36fyYqCzY8D2B6K2?=
 =?us-ascii?Q?goT8KyXXfhlGZLxAYpIzxkwCDzOj0rj7GD2zWswRiEvhVsNW8dAjqdDCtzya?=
 =?us-ascii?Q?L1Da+JMrC14HPvz1D0Xl4XD9KoQOa4ipFF4XeusDjg+3prho4+KJBWC4mb8L?=
 =?us-ascii?Q?QtufNhISjNtyMhDrRIF2CbIIsNR7G8De6ZoSHuGLINT+abhYXld8ZscY1lfW?=
 =?us-ascii?Q?KzKqtXhgZ2x+4c/9kiyWPZgf2LPSqC0a8dnHVPtN4WkaXVfvP6qm095kVjzp?=
 =?us-ascii?Q?hyDdfo4+GcoYQ2SPVaNBix3GvFxOQWxDJl1SSLUT7qRKQFju0ri3shfbr2cK?=
 =?us-ascii?Q?5ob/Af8ggNSK43B4ICk8MLTjAwIdujaCNh4uvm9InLnGevvVrbOcnf3vW/op?=
 =?us-ascii?Q?4BSyyQ0A06nNVNTA3bQcv8zgbaiFD4pnM1vPW8SSmGjgATNmt6MBGAcWd+gy?=
 =?us-ascii?Q?qL/MSktYb7u4MX27qyrwxkPKKT15+r6FgwgPYWDGy4ygJQZi5+KSDIwZP2+u?=
 =?us-ascii?Q?W5JdUPfoqRKqt87icOG8Czwg7MdFIkAidQE7fdK9VGJTUKP9PaB8G6OeZrs3?=
 =?us-ascii?Q?T5vTnB4BS66G2Zet5Moa6dUiytR0BMNUKns2jwLunmIZct1CvVbh9Yj7KF2W?=
 =?us-ascii?Q?LxYZJGHFZ70g12sb+/1UvihCmMbxrVNWBmxeLXhEX/YfmCbTjyZe0JaTzPIa?=
 =?us-ascii?Q?HijDP4XpL8x6g3lSYtMijYUpJI2mW8oIdgHepdTFxAZWx+jsomwPPqNh6z0q?=
 =?us-ascii?Q?2WyO8XFWUJ34Zf2CaYRQdV6joo0n3jhbKKS2v2PwT3ZUolbi6L1emOb/tJt2?=
 =?us-ascii?Q?fE0N+gP6u8mGRCzfo3ZOo2WTflXlrGdjER/5tfFWTOQAb5bkhpk05tiIBm3W?=
 =?us-ascii?Q?b49fjTQnTbdIO1m5DAj5N3wrvLCxfzsl48Xglm13oPoda1A5j0tylnSzObKT?=
 =?us-ascii?Q?XQNczE9Qz80HteHiAOsZLdn4V+c1Gi2dXQw46pcTsZDOoZf5yeaVThGI1B42?=
 =?us-ascii?Q?wb2nJV8AKY4YVFZGwxXwaN7nrhWdTgmgl3LmDgsrwX33mAYty57UD0+V0MAx?=
 =?us-ascii?Q?UM7QKnFn2AC6w+82HeprE009lvrKISRxl3AN9R2tz6xTsiYe8N+Eg/xIYbRn?=
 =?us-ascii?Q?tGvFxMyWAaZZaQN55VHKBW1e/6KCt7HNqTfJ9LwKqng877mMVyy6Va6AySpJ?=
 =?us-ascii?Q?G6sQDgMrcz+N/JmXuylo1BDM9uFbNuv9RREvb/AjPFeYatWXReYAVtUjmT49?=
 =?us-ascii?Q?jIQdZPA2VoubLkffRICJpFi0KkE19kPhT44LP6M0tGJZCwrqswewd4eOvIqt?=
 =?us-ascii?Q?2x7fYJR0OZ/NjSa8C+7k/DPxCEjx1+F4AIcaXctD89wvuDhldAw0fqyQbUM2?=
 =?us-ascii?Q?eoFdY5FlPdEvLoVCIjtlipCx+1MlvekXydCvxuY8xvK6CJykZc5vuJXL/6oP?=
 =?us-ascii?Q?3bIfjjiyCtboF/z0sF2eMP68ib4bg4oUrbDs98W+t25DP4S48ptN5yP/DWh4?=
 =?us-ascii?Q?EuF2ebqG3Ql5MBIaH/JWzRcYZnAOqGKr7kYfjsET6spvCMETlN8VwZhgb1xb?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pEscxjtV8TimaJamTzAViwalNTjiS1z4VWu4R2Ra42oAxE+LolW/UNQfBlVV/yLWEUwH0zLtr1Hs7vytzBcc+qXbFHGve6WrkK1mIcntLHpacszErmSSXMJAnKkYRflEtf+jyaKolS56xvUXrZdITtCL9gqxNH7pWn3xYXeARCnjJhMVm+NJV/97bOTdJvYK3PkNg5xOXnadBr5bh3WizH1oZNyUR2OTIFvCnZ8FW63v933MIblFH6O/lVufd3Dtq9T/lltRD/oYrABDotUWSDwbkS9IbzUq5htzknkNmu1BpZtEhmoStFq4BjlZtNhdfJFN7xZWOHz3y2EX3zhBwYA+zjXA7nkT7NIdbDKfzluUn4It47VsnuYIAaAJy7kXZ9GabVRAcLc+WUsbyiapLAbNmSwM0D7AHtsSV2/VnwJSgs8NhhPEOSfvkrb1HiivMdAaqXopvOkTFYygT19NWnTkGgRws2kjvhrH/60aos/NIMmmE8H3dCICfnB00J3tUaa2vDIQyhXva/dpG+LYW40f6y2RHlFon+iKFcCm5zpAlnr/zvLeLUlsk9btDFNLyu/mlElVveOx9S575jByzM7gwQ3vDCBHc4q2OIYqyWM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc87c4e1-a954-4257-50e9-08dc810a4175
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 00:40:23.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHhwoRvvpERLFS+JKySIyuqGAGidERpWcHljWO6Fr7f2MislN2ONv1hdQZGkZuBE8HCDEzo85WH+svP6h3kJECttKHTkYY5GG9QrsUvStgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310002
X-Proofpoint-ORIG-GUID: 1Qx6XI1MA_-Q0I-Nfp1LAHeCOVytpgqf
X-Proofpoint-GUID: 1Qx6XI1MA_-Q0I-Nfp1LAHeCOVytpgqf

Introduce a new LSM called clavis.  The motivation behind this LSM is to
provide access control for system keys.  The access control list is
contained within a keyring call .clavis.  During boot if the clavis= boot
arg is supplied with a key id contained within any of the current system
keyrings (builtin, secondary, machine, or platform) it shall be used as
the root of trust for validating anything that is added to the ACL list.

The first restriction introduced with this LSM is the ability to enforce
key usage.  The kernel already has a notion of tracking key usage.  This
LSM adds the ability to enforce this usage based on the system owners
configuration.

Each system key may have one or more uses defined within the ACL list.
When this LSM is enabled, only the builtin keys are available for loading
kernel modules and doing a kexec.  Until an entry is added to the .clavis
keyring, no other system key may be used for any other purpose.

In the future it is envisioned this LSM could be enhanced to provide
access control for UEFI Secure Boot Advanced Targeting (SBAT).  Using
the same clavis= boot param and storing the additional contents within
the new Runtime Services UEFI var, SBAT restrictions could be maintained
across kexec.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 Documentation/admin-guide/LSM/clavis.rst | 198 +++++++++++++++++++++++
 MAINTAINERS                              |   7 +
 crypto/asymmetric_keys/signature.c       |   4 +
 include/linux/lsm_hook_defs.h            |   2 +
 include/linux/security.h                 |   7 +
 include/uapi/linux/lsm.h                 |   1 +
 security/Kconfig                         |  10 +-
 security/clavis/Makefile                 |   1 +
 security/clavis/clavis.c                 |  25 +++
 security/clavis/clavis.h                 |   4 +
 security/clavis/clavis_keyring.c         |  83 ++++++++++
 security/security.c                      |  16 +-
 12 files changed, 352 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/clavis.rst
 create mode 100644 security/clavis/clavis.c

diff --git a/Documentation/admin-guide/LSM/clavis.rst b/Documentation/admin-guide/LSM/clavis.rst
new file mode 100644
index 000000000000..d1641e3ef38b
--- /dev/null
+++ b/Documentation/admin-guide/LSM/clavis.rst
@@ -0,0 +1,198 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======
+Clavis
+======
+
+Clavis is a Linux Security Module that provides mandatory access control to
+system kernel keys (i.e. builtin, secondary, machine and platform). These
+restrictions will prohibit keys from being used for validation. Upon boot, the
+Clavis LSM is provided a key id as a boot param.  This single key is then
+used as the root of trust for any access control modifications made going
+forward. Access control updates must be signed and validated by this key.
+
+Clavis has its own keyring.  All ACL updates are applied through this keyring.
+The update must be signed by the single root of trust key.
+
+When enabled, all system keys are prohibited from being used until an ACL is
+added for them. There is two exceptions to this rule, builtin keys may be used
+to validate both signed kernels and modules.
+
+Adding system kernel keys can only be performed by the machine owner; this
+could be through the Machine Owner Key (MOK) or the UEFI Secure Boot DB. It
+is possible the machine owner and system administrator may be different
+people. The system administrator will not be able to make ACL updates without
+them being signed by the machine owner.
+
+On UEFI platforms, the root of trust key shall survive a kexec. Trying to
+defeat or change it from the command line is not allowed.  The original boot
+param is stored in UEFI and will always be referenced following a kexec.
+
+The Clavis LSM contains a system keyring call .clavis.  It contains a single
+asymmetric key that is use to validate anything added to it.  This key can only
+be added during boot and must be a preexisting system kernel key.  If the
+``clavis=`` boot param is not used, the keyring does not exist and the feature
+can not be used until the next reboot.
+
+The only user space components are OpenSSL and the keyctl utility. A new
+key type call ``clavis_key_acl`` is used for ACL updates. Any number of signed
+``clavis_key_acl`` entries may be added to the .clavis keyring. The
+``clavis_key_acl`` contains the subject key identifier along with the allowed
+usage type for
+the key.
+
+The format is as follows:
+
+.. code-block:: console
+
+  XX:YYYYYYYYYYY
+
+  XX - Single byte of the key type
+	VERIFYING_MODULE_SIGNATURE            00
+	VERIFYING_FIRMWARE_SIGNATURE          01
+	VERIFYING_KEXEC_PE_SIGNATURE          02
+	VERIFYING_KEY_SIGNATURE               03
+	VERIFYING_KEY_SELF_SIGNATURE          04
+	VERIFYING_UNSPECIFIED_SIGNATURE       05
+  :  - ASCII colon
+  YY - Even number of hexadecimal characters representing the key id
+
+The ``clavis_key_acl`` must be S/MIME signed by the sole asymmetric key contained
+within the .clavis keyring.
+
+In the future if new features are added, new key types could be created.
+
+Usage Examples
+==============
+
+How to create a signing key:
+----------------------------
+
+.. code-block:: bash
+
+  cat <<EOF > clavis-lsm.genkey
+  [ req ]
+  default_bits = 4096
+  distinguished_name = req_distinguished_name
+  prompt = no
+  string_mask = utf8only
+  x509_extensions = v3_ca
+  [ req_distinguished_name ]
+  O = TEST
+  CN = Clavis LSM key
+  emailAddress = user@example.com
+  [ v3_ca ]
+  basicConstraints=CA:TRUE
+  subjectKeyIdentifier=hash
+  authorityKeyIdentifier=keyid:always,issuer
+  keyUsage=digitalSignature
+  EOF
+
+  openssl req -new -x509 -utf8 -sha256 -days 3650 -batch \
+        -config clavis-lsm.genkey -outform DER \
+        -out clavis-lsm.x509 -keyout clavis-lsm.priv
+
+How to get the Subject Key Identifier
+-------------------------------------
+
+.. code-block:: bash
+
+  openssl x509 -in ./clavis-lsm.x509 -inform der \
+        -ext subjectKeyIdentifier  -nocert \
+        | tail -n +2 | cut -f2 -d '='| tr -d ':'
+  4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
+
+How to enroll the signing key into the MOK
+------------------------------------------
+
+The key must now be added to the machine or platform keyrings.  This
+indicates the key was added by the system owner. To add to the machine
+keyring on x86 do:
+
+.. code-block:: bash
+
+  mokutil --import ./clavis-lsm.x509
+
+and then reboot and enroll the key through the MokManager.
+
+How to enable the Clavis LSM
+----------------------------
+
+Add the key id to the ``clavis=`` boot param.  With the example above the
+key id is the subject key identifier: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
+
+Add the following boot param:
+
+.. code-block:: console
+
+  clavis=4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
+
+After booting there will be a single key contained in the .clavis keyring:
+
+.. code-block:: bash
+
+  keyctl show %:.clavis
+  Keyring
+    254954913 ----swrv      0     0  keyring: .clavis
+    301905375 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
+
+The original ``clavis=`` boot param will persist across any kexec. Changing it or
+removing it has no effect.
+
+
+How to sign an entry to be added to the .clavis keyring:
+--------------------------------------------------------
+
+In this example we have 3 keys in the machine keyring.  Our Clavis LSM key, a
+key we want to use for kernel verification and a key we want to use for module
+verification.
+
+.. code-block:: bash
+
+  keyctl show %:.machine
+  Keyring
+    999488265 ---lswrv      0     0  keyring: .machine
+    912608009 ---lswrv      0     0   \_ asymmetric: TEST: Module Key: 17eb8c5bf766364be094c577625213700add9471
+    646229664 ---lswrv      0     0   \_ asymmetric: TEST: Kernel Key: b360d113c848ace3f1e6a80060b43d1206f0487d
+   1073737099 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
+
+To update the .clavis kerying ACL list.  First create a file containing the
+key usage type followed by a colon and the key id that we want to allow to
+validate that usage.  In the first example we are saying key
+17eb8c5bf766364be094c577625213700add9471 is allowed to validate kernel modules.
+In the second example we are saying key b360d113c848ace3f1e6a80060b43d1206f0487d
+is allowed to validate signed kernels.
+
+.. code-block:: bash
+
+  echo "00:17eb8c5bf766364be094c577625213700add9471" > module-acl.txt
+  echo "02:b360d113c848ace3f1e6a80060b43d1206f0487d" > kernel-acl.txt
+
+Now both these files must be signed by the key contained in the .clavis keyring:
+
+.. code-block:: bash
+
+  openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in module-acl.txt \
+        -out module-acl.pkcs7 -binary -outform DER -nodetach -noattr
+
+  openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in kernel-acl.txt \
+        -out kernel-acl.pkcs7 -binary -outform DER -nodetach -noattr
+
+Afterwards the ACL list in the clavis keyring can be updated:
+
+.. code-block:: bash
+
+  keyctl padd clavis_key_acl "" %:.clavis < module-acl.pkcs7
+  keyctl padd clavis_key_acl "" %:.clavis < kernel-acl.pkcs7
+
+  keyctl show %:.clavis
+
+  Keyring
+    254954913 ----swrv      0     0  keyring: .clavis
+    301905375 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
+   1013065475 --alswrv      0     0   \_ clavis_key_acl: 02:b360d113c848ace3f1e6a80060b43d1206f0487d
+    445581284 --alswrv      0     0   \_ clavis_key_acl: 00:17eb8c5bf766364be094c577625213700add9471
+
+Now the 17eb8c5bf766364be094c577625213700add9471 key can be used for
+validating kernel modules and the b360d113c848ace3f1e6a80060b43d1206f0487d
+key can be used to validate signed kernels.
diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..edf28dee71f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5326,6 +5326,13 @@ F:	scripts/Makefile.clang
 F:	scripts/clang-tools/
 K:	\b(?i:clang|llvm)\b
 
+CLAVIS LINUX SECURITY MODULE
+M:	Eric Snowberg <eric.snowberg@oracle.com>
+L:	linux-security-module@vger.kernel.org
+S:	Maintained
+F:	Documentation/admin-guide/LSM/clavis.rst
+F:	security/clavis
+
 CLK API
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-clk@vger.kernel.org
diff --git a/crypto/asymmetric_keys/signature.c b/crypto/asymmetric_keys/signature.c
index 2deff81f8af5..7e3a78650a93 100644
--- a/crypto/asymmetric_keys/signature.c
+++ b/crypto/asymmetric_keys/signature.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/keyctl.h>
+#include <linux/security.h>
 #include <crypto/public_key.h>
 #include <keys/user-type.h>
 #include "asymmetric_keys.h"
@@ -153,6 +154,9 @@ int verify_signature(const struct key *key,
 
 	ret = subtype->verify_signature(key, sig);
 
+	if (!ret)
+		ret = security_key_verify_signature(key, sig);
+
 	pr_devel("<==%s() = %d\n", __func__, ret);
 	return ret;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index f804b76cde44..6534af90d8db 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -409,6 +409,8 @@ LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
 LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
 	 struct key *key, const void *payload, size_t payload_len,
 	 unsigned long flags, bool create)
+LSM_HOOK(int, 0, key_verify_signature, const struct key *key,
+	 const struct public_key_signature *sig)
 #endif /* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
diff --git a/include/linux/security.h b/include/linux/security.h
index 21cf70346b33..c5474e9260e0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -63,6 +63,7 @@ enum fs_value_type;
 struct watch;
 struct watch_notification;
 struct lsm_ctx;
+struct public_key_signature;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -2009,6 +2010,7 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
 					const void *payload, size_t payload_len,
 					unsigned long flags, bool create);
 
+int security_key_verify_signature(const struct key *key, const struct public_key_signature *sig);
 #else
 
 static inline int security_key_alloc(struct key *key,
@@ -2043,6 +2045,11 @@ static inline void security_key_post_create_or_update(struct key *keyring,
 						      bool create)
 { }
 
+static inline int security_key_verify_signature(const struct key *key,
+						const struct public_key_signature *sig)
+{
+	return 0;
+}
 #endif
 #endif /* CONFIG_KEYS */
 
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 33d8c9f4aa6b..3a60c4ff5186 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -64,6 +64,7 @@ struct lsm_ctx {
 #define LSM_ID_LANDLOCK		110
 #define LSM_ID_IMA		111
 #define LSM_ID_EVM		112
+#define LSM_ID_CLAVIS		113
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/Kconfig b/security/Kconfig
index b9ad8e580b96..7df8b2a4941f 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -232,11 +232,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
+	default "clavis,landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "clavis,landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "clavis,landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
+	default "clavis,landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
+	default "clavis,landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list, except for those with order
diff --git a/security/clavis/Makefile b/security/clavis/Makefile
index 2b2b3bc8eef4..441c70c6b78a 100644
--- a/security/clavis/Makefile
+++ b/security/clavis/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SECURITY_CLAVIS) += clavis_keyring.o
+obj-$(CONFIG_SECURITY_CLAVIS) += clavis.o
 ifeq ($(CONFIG_EFI),y)
 obj-$(CONFIG_SECURITY_CLAVIS) += clavis_efi.o
 endif
diff --git a/security/clavis/clavis.c b/security/clavis/clavis.c
new file mode 100644
index 000000000000..040337dbd8d9
--- /dev/null
+++ b/security/clavis/clavis.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
+#include "clavis.h"
+
+static struct security_hook_list clavis_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(key_verify_signature, clavis_sig_verify),
+};
+
+const struct lsm_id clavis_lsmid = {
+	.name = "clavis",
+	.id = LSM_ID_CLAVIS,
+};
+
+static int __init clavis_lsm_init(void)
+{
+	security_add_hooks(clavis_hooks, ARRAY_SIZE(clavis_hooks), &clavis_lsmid);
+	return 0;
+};
+
+DEFINE_LSM(clavis) = {
+	.name = "clavis",
+	.init = clavis_lsm_init,
+};
diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
index 708dd0b1cc76..2a2fe2525c7c 100644
--- a/security/clavis/clavis.h
+++ b/security/clavis/clavis.h
@@ -2,6 +2,8 @@
 #ifndef _SECURITY_CLAVIS_H_
 #define _SECURITY_CLAVIS_H_
 
+struct key;
+struct public_key_signature;
 struct asymmetric_key_id;
 
 #ifdef CONFIG_EFI
@@ -13,4 +15,6 @@ static inline int __init clavis_efi_param(struct asymmetric_key_id *kid, int len
 }
 #endif
 
+int clavis_sig_verify(const struct key *key, const struct public_key_signature *sig);
+
 #endif /* _SECURITY_CLAVIS_H_ */
diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
index 9b3db299acef..736bdadd9000 100644
--- a/security/clavis/clavis_keyring.c
+++ b/security/clavis/clavis_keyring.c
@@ -13,6 +13,7 @@
 static struct key *clavis_keyring;
 static struct asymmetric_key_id *setup_keyid;
 
+static int clavis_init;
 #define MAX_ASCII_KID 64
 #define MAX_BIN_KID   32
 
@@ -228,4 +229,86 @@ void __init late_init_clavis_setup(void)
 
 	clavis_keyring_init();
 	system_key_link(clavis_keyring, keyid);
+	clavis_init = true;
+}
+
+int clavis_sig_verify(const struct key *key, const struct public_key_signature *sig)
+{
+	const struct asymmetric_key_ids *kids = asymmetric_key_ids(key);
+	const struct asymmetric_key_subtype *subtype;
+	const struct asymmetric_key_id *newkid;
+	char *buf_ptr, *ptr;
+	key_ref_t ref;
+	int i, buf_len;
+
+	if (!clavis_init)
+		return 0;
+
+	if (key->type != &key_type_asymmetric)
+		return -EKEYREJECTED;
+	subtype = asymmetric_key_subtype(key);
+	if (!subtype || !key->payload.data[0])
+		return -EKEYREJECTED;
+	if (!subtype->verify_signature)
+		return -EKEYREJECTED;
+
+	/* Allow sig validation when not using a system keyring */
+	if (!test_bit(PKS_USAGE_SET, &sig->usage_flags))
+		return 0;
+
+	if (test_bit(KEY_FLAG_BUILTIN, &key->flags) && sig->usage == VERIFYING_MODULE_SIGNATURE)
+		return 0;
+
+	if (test_bit(KEY_FLAG_BUILTIN, &key->flags) && sig->usage == VERIFYING_KEXEC_PE_SIGNATURE)
+		return 0;
+
+	/* The previous sig validation is enough to get on the clavis keyring */
+	if (sig->usage == VERIFYING_CLAVIS_SIGNATURE)
+		return 0;
+
+	if (test_bit(PKS_REVOCATION_PASS, &sig->usage_flags))
+		return 0;
+
+	for (i = 0, buf_len = 0; i < 3; i++) {
+		if (kids->id[i]) {
+			newkid = (struct asymmetric_key_id *)kids->id[i];
+			if (newkid->len > buf_len)
+				buf_len = newkid->len;
+		}
+	}
+
+	if (!buf_len)
+		return -EKEYREJECTED;
+
+	/* Allocate enough space for the conversion to ascii plus the header. */
+	buf_ptr = kmalloc(buf_len * 2 + 4, GFP_KERNEL | __GFP_ZERO);
+
+	if (!buf_ptr)
+		return -ENOMEM;
+
+	for (i = 0; i < 3; i++) {
+		if (kids->id[i]) {
+			newkid = (struct asymmetric_key_id *)kids->id[i];
+			if (!newkid->len)
+				continue;
+
+			ptr = buf_ptr;
+			ptr = bin2hex(ptr, &sig->usage, 1);
+			*ptr++ = ':';
+			ptr = bin2hex(ptr, newkid->data, newkid->len);
+			*ptr = 0;
+			ref = keyring_search(make_key_ref(clavis_keyring, true), &clavis_key_acl,
+					     buf_ptr, false);
+
+			if (!IS_ERR(ref))
+				break;
+		}
+	}
+
+	kfree(buf_ptr);
+
+	if (IS_ERR(ref))
+		return -EKEYREJECTED;
+
+	return 0;
 }
diff --git a/security/security.c b/security/security.c
index e5da848c50b9..bd2e13a8f01b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -51,7 +51,8 @@
 	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_EVM) ? 1 : 0))
+	(IS_ENABLED(CONFIG_EVM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_CLAVIS) ? 1 : 0))
 
 /*
  * These are descriptions of the reasons that can be passed to the
@@ -5323,6 +5324,19 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
 	call_void_hook(key_post_create_or_update, keyring, key, payload,
 		       payload_len, flags, create);
 }
+
+/**
+ * security_key_verify_signature - verify signature
+ * @key: key
+ * @sig: signature
+ *
+ * See whether signature verification is allowed based on the ACL for
+ * key usage.
+ */
+int security_key_verify_signature(const struct key *key, const struct public_key_signature *sig)
+{
+	return call_int_hook(key_verify_signature, key, sig);
+}
 #endif	/* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
-- 
2.43.0


