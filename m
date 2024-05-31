Return-Path: <linux-efi+bounces-1093-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3918D5737
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 02:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334AD1F26716
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 00:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EDF225CE;
	Fri, 31 May 2024 00:41:47 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B681DDE9;
	Fri, 31 May 2024 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116107; cv=fail; b=VT/5gtvMwelraFYBoeGmL6pnRA6E+XhEXL52YSQZeIxVZEGzEwBPa9f/2rk+SiLMOEy4LIs6fzdbaOB7IZ5UjbV9tH4YaGAhZA6x+mNp6zHyBuMIwBnCtkOzIrOSwlipqDaKG5mwn8gC7s36PHrOaJB63dh5dwtWy67t9Monb+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116107; c=relaxed/simple;
	bh=ITVAvLqAawJyqRwV/PAHLlzw2Br9h4m2ejQMvYG0IBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8jFgzQtMqU2oQRhcP+C36oU6aGpHkD43xJ+RSyyhPaGw9RM2YciwuW/xCsxuAcC/CVyTmn3X2RcUSzpwiqD3ttKigABhn4tYLsYRxXbt/UBrSNlsBUoeorL0UYWp/7DJe7X3oTIKqkUVKCg10lz3AyneezPjKmBFaWe4WDd/gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UExT4m018494;
	Fri, 31 May 2024 00:40:21 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DM9PQWKZVZvsLr0XtuZEtlU+LpS7GGtvxjKV5HmNd3MA=3D;_b?=
 =?UTF-8?Q?=3DZJQN7v0k8i2P8xeM74SSWxmtgFO6jP/EyNyhh0MkjoEBy3Uxy5RDVb2OYHZC?=
 =?UTF-8?Q?5u1C75lE_yyRJIzKCcDslw//XH9M/E6MC13ay31Frqo/h5wCs2Mq7Xm3jrYibpp?=
 =?UTF-8?Q?WG4KgZvsdjT8V9_k/Oupd7Nc+MWonVX1d/5qIbfezLfqOiBFzbwBfkMOL/t3G2y?=
 =?UTF-8?Q?XQ/k5sHE83dwxtfGsDWr_whfTG6quzSZHNQDvtJa4kYDUogTya7dPY7acJGN5hK?=
 =?UTF-8?Q?MqGYtTo3I8EfNC3NXHyLUpD9z2_y3vK730YITLUKmKUWAbD5sztcQsGT88EdK1p?=
 =?UTF-8?Q?k3kK+Di5zfQvEhixLYLRn/Su39JaP2l2_1g=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j8a213-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44V0RU1M010708;
	Fri, 31 May 2024 00:40:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc511ah6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBPK0xmmgN7Z2nJr212LbKESCxkGg7T5q/7FJlMbNDn07QliAB8qGiQ/dXTVpsiisQlAjgfWJ9iDA+IUcfTRyvTeqSlxGrstTsEFuszJzVQURaPVTObRI6j0GOLb48cnDNviofbUp2o2MoEqz6oa0cjJ96fGAlo6tvRS1Hnza1KrUOrVNJ/RHprSzSbTWGQqOmLSCNPOJsczandYcl9HaUIpmFBduP0h0aE5H5VCsiRWfHN97Xjmsbni/XBVJDVI5illoLDJELmcjxKFYoAuMFPhrve232dw07NczNH8R0Re/AwF0TH/EjwfNSrEjSm5Q04ITm50mP8iaPj39Bz6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9PQWKZVZvsLr0XtuZEtlU+LpS7GGtvxjKV5HmNd3MA=;
 b=PrWwliWImRxnWv7RT5iFVJ7Cak4Ukw1yJ7YKO60Xj8/aJsvyq/lHmq+0Z27wsPxIdlRVyh4q+TNCiqzjpb9aZDLsccW3C9td1BQbiBM8a7bkLCgss/5uapY6OdT/AbZGV0Xti4JycaLxr3VY1Ttjw0ia7uAZKa9sgBsRaZScGOGqDVV7OIFXvLOO7P16F/a7K8n6+RmPPhH4KrmiXTUGVeUqF84cWfKjyjRW1CxuHs6LPyAVeZzYwmUvj5hXjgrojNh8lY8ZaRvKgEeyNVLDIiTNiMC3omlc2GdfeTzdlrA+dHrjhyoZnEzHPDZpMCx95o0l5HzspalYOTs98FOpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9PQWKZVZvsLr0XtuZEtlU+LpS7GGtvxjKV5HmNd3MA=;
 b=OqoD9/68TVSdkmq1j6ZzxNUTqSyOb5eYiFrKTIJz/ytSTNM/4VgtbJWw9zGVBVe0nsE5xHzQHiFA+kYKDj6nE4Nz0xUmf7izYCT9yHStnRLcoqVVRKepo8SNZwhAOn9Z5RolPfHziv7+tQLAaI/Od3qG00p1Gwk4wK16g58QxiE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 00:40:18 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 00:40:18 +0000
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
Subject: [RFC PATCH v2 7/8] clavis: Introduce a new key type called clavis_key_acl
Date: Thu, 30 May 2024 18:39:44 -0600
Message-ID: <20240531003945.44594-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531003945.44594-1-eric.snowberg@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dcf537a-989f-460a-6ac1-08dc810a3e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7lM3HLFGq5v1uRLtmWD+ePL9oxZEfrj8e+T1a1C6zL5QPZqsLmXPORdyCJ0V?=
 =?us-ascii?Q?57HoFZiWdZKrhgDSn3JoOP49OvUYh5NUdw6jGBIZgFvq6gxn5JRaCuFaFVsQ?=
 =?us-ascii?Q?jxI7LS4IhqDhVZXfoA3EC5JaqRMYS9Q0yOJim1oanF8ImlrYPErIKfwo7dgD?=
 =?us-ascii?Q?wFMIchiOyQZRRIj8IFd8XouCrlsjlon0ZVEhSab3/1vHEyeDWKmHt6q0xLzC?=
 =?us-ascii?Q?EMYCdbo2Yi05bEi5/KzBeaUmQ4MMsw60nTO3UonN2HKV0/qTW4DhtEkumMYX?=
 =?us-ascii?Q?Do0OW+4z92pS+7F/bkZ+bI0PiCX3D01TTPY4HYPHjCDPSkp+jnAFUhjWmqTR?=
 =?us-ascii?Q?jYFYGTyvfJ9Yqh+92df/ZFC+90twxGKdDXxN6UEAdIVPCNrrZYg/IRjMtS5k?=
 =?us-ascii?Q?Q7QQ2dedb8ykSRmNj5ogEMiW5Bqw0O8xKxO3bWPjvpy0SGh6+z0vMgb/J7ST?=
 =?us-ascii?Q?WJU7Wv8ZnKOw4MVYHKoxvRVWS0opMMJq+Z0vSzzEViJcV20mt5OGsYCDvVEK?=
 =?us-ascii?Q?e1TbkcfO3Ho/1N6Vkq4tFEfIi6cgfdhK3mgPiZXnZ0kCdP5KA7jnDe6ENW2Q?=
 =?us-ascii?Q?6rbiuebLTTynq5N7pezADz22i2PxTk26ECl2uHiTf+BW2ir0mIlXbk7uQwOK?=
 =?us-ascii?Q?Xv1tI+6Muq5X7itnzLzec1OcOgkdR9LRpIiKT6v4MM+sVcnmauHBwjDNqkjB?=
 =?us-ascii?Q?YbopRHJ7aUM/05F74zBc32NuTSICMxnP8t2M5OuHUx+CdhM/if63+U83Osnb?=
 =?us-ascii?Q?Lcx/0FJjeayhgmyqZ/3TqwzGSrD8lZK0cAfWSdaC15SyxrXR8Mnu3fr8bLAv?=
 =?us-ascii?Q?gPCmkoOIMCSLOkDDwdwZwPp2jrIEotm6DM/2yu5xFVJ3gw4RxBQMbNbheY4K?=
 =?us-ascii?Q?LpySqgoARXJ+8iM1Xi473Pv90SNK2TXaadgPW0cMCNr6xS+JBc8OEzTbc/FO?=
 =?us-ascii?Q?YqihlmFsEOSf2c+zGSunVtNSuZoEAh1uqdgaD/CeuvwqdCfUPMgCePv6rUwB?=
 =?us-ascii?Q?Tw6IzlENBw8HzY4bO+2IPv+53vhNYiqM1TkpboPfSqGxtKnwpEs3PDeysLZP?=
 =?us-ascii?Q?kMEe5PMV2k5u1DsUOqTdUi9MK8J145FQjBFEvCp6A4du9Q56EzZDbVwlQfC4?=
 =?us-ascii?Q?WeQ7yCgIfPyBGZItkN9m0gSubyeNa5Tqdtr2nSq7DhUAAJVp+DAEGdHExySB?=
 =?us-ascii?Q?//y9/c8i0VuwN60z15L2SKVfIT+AMPL+zNdyQ6tYP60lELGoP6j5UKPbCQaV?=
 =?us-ascii?Q?uRdDaFrq9RFsFMCl6jB2I3PV6H/p2Q0AEKQ+GX5/rQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jO9LuL7T+wSszHuiK///wi609R96mTAEScOz8NHW91lhjJROWixfulzNCs6J?=
 =?us-ascii?Q?PW4D68l1xk5VqRhJvRp0Fc5+jMh5It3kld8ZpezANWq0FQ6zUM3Ont3fhcCb?=
 =?us-ascii?Q?xYC3LJhOUmObdU55J9wflVBkrs/Xxr2zDu/owE7MyDTUv0eV/n6C37pyDbiw?=
 =?us-ascii?Q?7emJ/v/fYDQlRRDoMpks2fX2OzeeOOk+iVyHKoKH+tgQXJ5TDB9frTCyvR+B?=
 =?us-ascii?Q?lG0Fs02YcDgwNCpcnXecqfNyXNW0sqyrzryXJL0kMYK19zifOOohEK5Fr/iN?=
 =?us-ascii?Q?ur/euElL/7ZIXvzs6/jXz6bmA/9X2K8USDGPijv3BiYzE7RHDCrlIeMkUoo6?=
 =?us-ascii?Q?RrYbCCYekDFtWfSHANdJrSZmTt3+5cfXf4VwNV0NLST9tszpVP31Dbfbw5uV?=
 =?us-ascii?Q?6oMlqTEsLYLYS6caf+XVUP7ppTFFcO0qn4l4yNuolZ2RO+OcvxExe90bd5cx?=
 =?us-ascii?Q?srsCE/2XbYSYbQL/p/l6jpphbGO2RP1Tp45ofM6Z3+APdelsLHqBB9wBg0Yx?=
 =?us-ascii?Q?gOXL1sBnxPmG0Fz+uys7CXC8YWyYpOzAA2uWU5Wt+l++SYJiCFJulmxnjsXr?=
 =?us-ascii?Q?ejRys9dwmxTITEccK+K7bPuto6r9+fqXeqCQisWEQj18fgAU8CbaZM09o0iR?=
 =?us-ascii?Q?PTdQ7hWmW9oszu8wtDaa94EAQFyznNx3RY4XLf/G+XWVo5QRF7W6uPwYCH+2?=
 =?us-ascii?Q?vSOFR8bPCUttv7hhvAiOsRyYg2Cbrh/4mZesb3iqYeeKKxGsDjcHsukWYcLR?=
 =?us-ascii?Q?jDUUbNRS08fhjTgV/J0tZFFHMXjGGl2YwBn17zXLLvZUb5k7cjmidjiVbBTi?=
 =?us-ascii?Q?CoXG8xZWBfv0hn3eNOTwPXgOha0CvAC7qdIgDEdgIeJR7w9Tx9H4fR26gRbK?=
 =?us-ascii?Q?cCe+W8VuOemaOyuEclbWGJqIY6l/cGOC3BYKa4sSVXHyS3WJD98SDlk5Ksd4?=
 =?us-ascii?Q?yG37DgLZ0Y0S0XtH2Ry+9SPkf8FpUGYCkGIF9zqKn0Z/UBMyHFGLDhTRxzaF?=
 =?us-ascii?Q?2jXeoVScCtBSX0w7gk0Fea9ImIb3QQRQfUYU76FBWLht4JEWuyacHikDaLYC?=
 =?us-ascii?Q?uV+JV3rWSFBn4N3PWfXwUMXfuHEQgognKpEOhkOor81HRdyS+/9O8sko5YVp?=
 =?us-ascii?Q?eBn2sYxuXM9Fdx85BGV548UPdtdBsEgI6CvxQxNGFNCKvMFEdBFM9AvbX0XW?=
 =?us-ascii?Q?/BKOGhik1gvYEyICsLSvQ4VZpdECptL/0LcWXux8RkT9g5jALrIIxf4aFHPs?=
 =?us-ascii?Q?CEvxCHi+wcTnrF9m4XEh/ZcDkbmuBhAmLkRvJMqk5/Ep8Ug2dMjXmAnFcpHU?=
 =?us-ascii?Q?Z7UginJehslf0KHOeqxngoFtFddlGmTxJI613qMYA9PU1h6a+43Z40M1Iw+J?=
 =?us-ascii?Q?LgvJavyznqwcf5IsfGh0RWB/37V3Covo2Hgde3GGI3VeFfvCyBOhci24UI9F?=
 =?us-ascii?Q?nSbv4cM2Zc07iX2YyfiT280klbq+UAEiWL/ZlGawWxpMJz0h/M//2T2kWeck?=
 =?us-ascii?Q?9HCJZS4uIz0iLBdYlB41YH42oBCXEVXJway2oMWJGfC6jZHXyR9oDWI6vqbr?=
 =?us-ascii?Q?RuMi9wXR8E9ONz/Gzo+LEss6Tg5Pc1hkub/UnvPIDi/0odALbQq50cA2941k?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	50iEhERYYMk/Lioe1Rf+0nvbCZ7zvddg+GKtA0RWd3xgYkNAuFHHaiJXgVQ6oCvWbFQcjghUmJDMvCIPZZz25JsSBtP6BU+D8x+hunGs3ypGavkyh8LHsMO+4SpXxcIFmfF0bQaNwRw5tZGBP5CkVnokHEp2qSfCHytepM/92q++OozTqoRX0tlm7A9XFbE0wCPap7SHKUFMrA5y1oyZDFlujSIk39+Dgplrq3iLjVhIKbKy9AF1qRGYLpQAaMY6IvE7D2Ilc7Kf6ldLFYWI3MuUxlsZifUHMj8BYmxZmWCLrAz5zT7hrNpZWzarGt0IfK3Rm5lKUanEZwYN+jOroW8HymHIZ1UtqgKzM5V04Ev3oeiG/B6GYglgCQ4mpqkSbMWrF+dg0coHXmzugWF5BdcTb5JO6tjTfPe1C2t7WIj9Q48hSOkwDv0Z4iHbwCORFqkcS4vW51QfEga2m+kKnBgn1yU5kr4UZxVkVwF7hRCvfqkB+cXlFTLskasgaWNQZN04Qld2xmzS0PRe2xHtqscEM6/31493SyQlvaY+RCvjFiuQtIlsT8IJw3Gd32KHFauCf7v5xS5oVNaahV35co+gbhNbbEKnafQVIZULAtI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcf537a-989f-460a-6ac1-08dc810a3e8a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 00:40:18.1017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJWJwAJzlAizUugLDEfYIimmho5o89tM7Bo3PvGYMYSBIsGvm3kqbGNjQrwSnR0R+7b5505kuqmqoCwMa+0JV6Kh4+bfgrNqm+yCXtIaK9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405310002
X-Proofpoint-ORIG-GUID: 4uqA9cqxhN2NlmJllfgsgV4PW4aME5Qn
X-Proofpoint-GUID: 4uqA9cqxhN2NlmJllfgsgV4PW4aME5Qn

Introduce a new key type for keyring access control.  The new key type
is called clavis_key_acl.  The clavis_key_acl contains the subject key
identifier along with the allowed usage type for the key.

The format is as follows:

XX:YYYYYYYYYYY

XX - Single byte of the key type
	VERIFYING_MODULE_SIGNATURE            00
	VERIFYING_FIRMWARE_SIGNATURE          01
	VERIFYING_KEXEC_PE_SIGNATURE          02
	VERIFYING_KEY_SIGNATURE               03
	VERIFYING_KEY_SELF_SIGNATURE          04
	VERIFYING_UNSPECIFIED_SIGNATURE       05
:  - ASCII colon
YY - Even number of hexadecimal characters representing the key id

This key type will be used in the clavis keyring for access control. To
be added to the clavis keyring, the clavis_key_acl must be S/MIME signed
by the sole asymmetric key contained within it.

Below is an example of how this could be used. Within the example, the
key (b360d113c848ace3f1e6a80060b43d1206f0487d) is already in the machine
keyring. The intended usage for this key is to validate a signed kernel
for kexec:

echo "02:b360d113c848ace3f1e6a80060b43d1206f0487d" > kernel-acl.txt

The next step is to sign it:

openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in \
	kernel-acl.txt  -out kernel-acl.pkcs7 -binary -outform DER \
	-nodetach -noattr

The final step is how to add the acl to the .clavis keyring:

keyctl padd clavis_key_acl "" %:.clavis < kernel-acl.pkcs7

Afterwards the new clavis_key_acl can be seen in the .clavis keyring:

keyctl show %:.clavis
Keyring
  keyring: .clavis
   \_ asymmetric: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
   \_ clavis_key_acl: 02:b360d113c848ace3f1e6a80060b43d1206f0487d

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 .../admin-guide/kernel-parameters.txt         |   2 +
 security/clavis/clavis_keyring.c              | 128 ++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d505535ea3b..c2d498eb2466 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -629,6 +629,8 @@
 			keyrings (builtin, secondary, or platform) to be used as
 			the Clavis root of trust.
 			Format: { <keyid> }
+			See Documentation/admin-guide/LSM/clavis.rst for
+			details.
 
 	clearcpuid=X[,X...] [X86]
 			Disable CPUID feature X for the kernel. See
diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
index 1225a8ee1e5a..9b3db299acef 100644
--- a/security/clavis/clavis_keyring.c
+++ b/security/clavis/clavis_keyring.c
@@ -2,13 +2,18 @@
 
 #include <linux/security.h>
 #include <linux/integrity.h>
+#include <linux/ctype.h>
 #include <keys/asymmetric-type.h>
+#include <keys/asymmetric-subtype.h>
 #include <keys/system_keyring.h>
+#include <keys/user-type.h>
+#include <crypto/pkcs7.h>
 #include "clavis.h"
 
 static struct key *clavis_keyring;
 static struct asymmetric_key_id *setup_keyid;
 
+#define MAX_ASCII_KID 64
 #define MAX_BIN_KID   32
 
 static struct {
@@ -16,6 +21,123 @@ static struct {
 	unsigned char data[MAX_BIN_KID];
 } setup_key;
 
+static int pkcs7_preparse_content(void *ctx, const void *data, size_t len,
+				  size_t asn1hdrlen)
+{
+	struct key_preparsed_payload *prep = ctx;
+	const void *saved_prep_data;
+	size_t saved_prep_datalen;
+	const char *p;
+	char *desc;
+	int ret, i;
+
+	/* key_acl_free_preparse will free this */
+	desc = kmalloc(len, GFP_KERNEL);
+
+	if (!desc)
+		return -ENOMEM;
+	memcpy(desc, data, len);
+
+	/* remove any white space */
+	for (i = 0, p = desc; i < len; i++, p++) {
+		if (isspace(*p))
+			desc[i] = 0;
+	}
+
+	prep->description = desc;
+	saved_prep_data = prep->data;
+	saved_prep_datalen = prep->datalen;
+	prep->data = desc;
+	prep->datalen = len;
+	ret = user_preparse(prep);
+	prep->data = saved_prep_data;
+	prep->datalen = saved_prep_datalen;
+	return ret;
+}
+
+static void key_acl_free_preparse(struct key_preparsed_payload *prep)
+{
+	kfree(prep->description);
+	user_free_preparse(prep);
+}
+
+static int key_acl_preparse(struct key_preparsed_payload *prep)
+{
+	/* Only allow the description to be set via the pkcs7 data contents */
+	if (prep->orig_description)
+		return -EINVAL;
+
+	return verify_pkcs7_signature(NULL, 0, prep->data, prep->datalen, clavis_keyring,
+				      VERIFYING_CLAVIS_SIGNATURE, pkcs7_preparse_content,
+				      prep);
+}
+
+static int key_acl_instantiate(struct key *key, struct key_preparsed_payload *prep)
+{
+	key->perm |= KEY_USR_READ;
+	key->perm |= KEY_USR_SEARCH;
+	set_bit(KEY_FLAG_KEEP, &key->flags);
+	return generic_key_instantiate(key, prep);
+}
+
+static void key_acl_destroy(struct key *key)
+{
+	/* It should not be possible to get here */
+	pr_info("destroy clavis_key_acl denied\n");
+}
+
+static void key_acl_revoke(struct key *key)
+{
+	/* It should not be possible to get here */
+	pr_info("revoke clavis_key_acl denied\n");
+}
+
+static int key_acl_update(struct key *key, struct key_preparsed_payload *prep)
+{
+	return -EPERM;
+}
+
+static int key_acl_vet_description(const char *desc)
+{
+	unsigned char data[MAX_BIN_KID];
+	int ascii_len, hex_len, error;
+
+	ascii_len = strlen(desc);
+
+	/*
+	 * clavis_acl format:
+	 *    xx:yyyyyyyyy...
+	 *
+	 *    xx   - Single byte of the key type
+	 *    :    - Ascii colon
+	 *    yyyy - Even number of hexadecimal characters representing the keyid
+	 */
+	if (ascii_len < 5 || ascii_len > (MAX_ASCII_KID + 3) || desc[2] != ':')
+		return -EINVAL;
+
+	/* move past the colon */
+	ascii_len -= 3;
+	hex_len = ascii_len / 2;
+	error = hex2bin(data, desc + 3, hex_len);
+
+	if (error < 0)
+		pr_err("Unparsable clavis key id\n");
+
+	return error;
+}
+
+static struct key_type clavis_key_acl = {
+	.name			= "clavis_key_acl",
+	.preparse		= key_acl_preparse,
+	.free_preparse		= key_acl_free_preparse,
+	.instantiate		= key_acl_instantiate,
+	.update			= key_acl_update,
+	.revoke			= key_acl_revoke,
+	.destroy		= key_acl_destroy,
+	.vet_description	= key_acl_vet_description,
+	.read			= user_read,
+};
+
 static int restrict_link_for_clavis(struct key *dest_keyring, const struct key_type *type,
 				    const union key_payload *payload, struct key *restrict_key)
 {
@@ -30,6 +152,9 @@ static int restrict_link_for_clavis(struct key *dest_keyring, const struct key_t
 		return 0;
 	}
 
+	if (type == &clavis_key_acl)
+		return 0;
+
 	return -EOPNOTSUPP;
 }
 
@@ -64,6 +189,9 @@ static int __init clavis_keyring_init(void)
 {
 	struct key_restriction *restriction;
 
+	if (register_key_type(&clavis_key_acl) < 0)
+		panic("Can't allocate clavis key type\n");
+
 	restriction = kzalloc(sizeof(*restriction), GFP_KERNEL);
 	if (!restriction)
 		panic("Can't allocate clavis keyring restriction\n");
-- 
2.43.0


