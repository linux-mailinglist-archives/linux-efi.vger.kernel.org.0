Return-Path: <linux-efi+bounces-1092-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040068D5733
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 02:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0264286C9F
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 00:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF911CAAE;
	Fri, 31 May 2024 00:41:44 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0308468;
	Fri, 31 May 2024 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116104; cv=fail; b=iu11aJEGjo5c3R5uz6xHhgHkMsN4WNZbfsyxzJzQU0itGyhxIIzgxCbBXo8XYI+lqpaENwjaFxwh+VFVdxiDQc0TszpuSKC62wZZZvkWZy2kfziQEFEZ+oky5LNkUQZOgn1fRKG5yOr0n1QLMVLz3HYP3FDx7MxpxNaVyLGzF3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116104; c=relaxed/simple;
	bh=WV/vaBMP6WGJi5yAUUMEVdjuFC/EzXfDZv/UGO4jHmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jCXYnHrujg+8ItkbCcQtDcpYOZw9pl4PzCCz8euaIWnXC5MxS20w7Q/n1FXiKsUETVrSFEcOSlq2llyDCwzyhgQ52Mj+0jVwJy1jSAkFyOsPsxy6EgQhMEY9edTF92eC+sTpTEj22DoilPyxM/IC25wIiZvXxVWFczrxol8fR4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFUsZS002189;
	Fri, 31 May 2024 00:39:59 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:message-?=
 =?UTF-8?Q?id:mime-version:subject:to;_s=3Dcorp-2023-11-20;_bh=3DNv5/+1dZE?=
 =?UTF-8?Q?eLuiLfwOa34ZKF/wikTpCKPHBsTv/tvAeo=3D;_b=3DZRnw1B5o2uswtzq7O656?=
 =?UTF-8?Q?rXo7CXB8yA5CITtF+iwIj15dKBEFTiLN9ffY182Da7bbXG6u_VZDnTILEsEjgis?=
 =?UTF-8?Q?tu45AI8iGeHyRqbeRXsSvgmTA7KBB19z9uSp42dt5XEvWs5HpOdfPT_J2pDvj/g?=
 =?UTF-8?Q?KZrVzG2IbL36ojV1v9wrZSglkNV8ye3Jh0PCD2aCIcWmHhneKSwB7BYIanck_in?=
 =?UTF-8?Q?t0bu72XxkhSSUTl5eclI6VTrcxwGoKN1TpooNEQbO/3WBid4y4dyDDp2TWletVk?=
 =?UTF-8?Q?zbe_FIjgTTSTlKDxz6NBfdU5k3m/KAV1rbtEGp+e16Pwpki0BZ5K1/df3nIaZq6?=
 =?UTF-8?Q?QP6v3aNiD_Qg=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kba710-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:39:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44V0Fq5n006199;
	Fri, 31 May 2024 00:39:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c7pksw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:39:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBzOMut2qN/OqgwitdABt7vfKuE0li5pBxPj5FR7lonewCt50JdnGG1PSVTkOjRiblVv2dOZ1JoVuAPwYYQYGX8kiKJqRJURrCLl/tOj2mDEoIv83H5/U/b6kFWbQ6PRGM4UaFgV+mZfwuS/yszLTaKF0QgzMnhL3ACfUcvPI9HXHX6Kyqd8ed6npZvIdR+T1K9vGQQVJldIzNakQrzNHl9NsQdBdRS2JqPawe4I1DismD1HaYfL3rGX5xfILuvUneQknrXMDmjm+YjV+bZcYp6rFFaAGdHhlVbPrecjT/pK6EhLwaAn11t+ET+ZnvRjTK3JGfsrUMjMMIUiU94LWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nv5/+1dZEeLuiLfwOa34ZKF/wikTpCKPHBsTv/tvAeo=;
 b=TB3wdePojECCpYc+VzSqoYO2+IYnLr1QLRlk2s7v1HGxUEy6Ji7QbxNF9tGWFruImfPIwI9Q9++8gbJiwGsxvOr3kkR9gheT+l0f+Q0S2de4fQvEWj19x7dtbSt+slSvNJb2ndg8KujUvMhy0NgGQw8o5wzaKFziy4yIEvwFYcEZjWAEjUPks4wvnLWXv8KNY7hCeF3MA61WAn1E5cK2jRIuj3WzZiFU1t6kTiM08I+xh91Mkh3K8XtBleG2sWE06WTtTEGenMnaeFDk6A3nOsfUOHhbV2V+5asVauiFf1PJgDOQIPausjoLpbBnCba+7G3xIPp0UlTRVBn9Lv7jQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv5/+1dZEeLuiLfwOa34ZKF/wikTpCKPHBsTv/tvAeo=;
 b=sdPVJxl/uq/+pifDggpXSCi451ZZvOHQtLJQLDQY33JtMXh1GnvEGlT+d5ux9Qdg8EtnBcUVqyMuJgy/ylg2f1GTyNQqjA0m9BeUoHHt3FCd82p3z+8yuLJrPe+g5x/BdhQVvMJtwFC3eiwWqZ8Nc74Z90V57JQ0L9QqyAHWj6o=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 00:39:53 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 00:39:52 +0000
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
Subject: [RFC PATCH v2 0/8] Clavis LSM
Date: Thu, 30 May 2024 18:39:37 -0600
Message-ID: <20240531003945.44594-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0051.namprd15.prod.outlook.com
 (2603:10b6:208:237::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0d9d13-e2d2-4658-7f37-08dc810a2f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0DSSR6VVg2j1Pnf25UyeW8Nr6IZWUl3Azi99YgT1vz+jwuJnGzpciwZ6LbsW?=
 =?us-ascii?Q?mRRAczuR38sPFTZBknodk4eQAAF4q2lX/SlBn9aE9kDNqpNy5R2gfpMxes64?=
 =?us-ascii?Q?+sPopnk4nCLiPD7Mia3qEg5OgnLaN1sn0oZR0bGa083HpWx4rNNn01iE4rbb?=
 =?us-ascii?Q?qYEd6jLgb/bXj34IpXLk1wFhH/3dgGLhqeV1LNHgkfN824YOkLc8/GtxuB0D?=
 =?us-ascii?Q?kN9acwDf1i9d+ecyJLqHHC4ST42wwOA6pUHpQHr/DHcFKmRTaHyIJ63eP+C7?=
 =?us-ascii?Q?u3e7ZiQ84ipr4ODoYwX9/dr17PQ1jcDNSrUA9pphk0CJHKzcNfjha0+7QpHF?=
 =?us-ascii?Q?4apQeAd68QTvrrmG72Z4Y3Pd1KYtRvvfDF62pSK+gmpIC15UQa1cXKD00XoD?=
 =?us-ascii?Q?YKPAJZjad98AjX5cjRbOZtYcgqN5qKclywICNROo2iKIMKZDwUT4BpnQYLva?=
 =?us-ascii?Q?2p1TRD0UKW6lUbHMsK6CM5A69HcduOU7cIvVJXOu/LisiSHeWsdbcCdpDIdK?=
 =?us-ascii?Q?q3MWbk1mQ8dFcp6Drye1+kp9bpa2L9PnYn8MOkgF20ABc1DEiU18L1axKFJv?=
 =?us-ascii?Q?VynGMnsRb1tXPoDuL0ElWoXNquOP98MG+Zx63rxmbrOEH83om/wQC7f7vCWv?=
 =?us-ascii?Q?yYJYhY+XBda5MobWp4C4twYpNuGoar1e22t/cy7Hmei7rPWL3kV+T6Xh18EH?=
 =?us-ascii?Q?TlXMlqHbGt+qfw622bM+wGo9VAes2VyaDdn3+neouQ9FfjCoNU9FGq+0nqAd?=
 =?us-ascii?Q?Qr6T57Ea02JYUdeAipXPEZ5wcx2WxFXqgtsYdY6mpBIsDUUSK4PQQF64iZd7?=
 =?us-ascii?Q?xzebcwrMM4AiMGv+4karo4qa0gck/Hf7vIZAqwvlIMBq2u+Q4WbM31qiXBKo?=
 =?us-ascii?Q?JGLhHkGBsfc972ByAcEJuFvQaXWt2G9Lu/JEwvYXwfBhpnaOPHxvezdy1ue2?=
 =?us-ascii?Q?VQijQFZ4QsFQG7+KOs/daZ8iqVE5Os4Zg9IXzNentlw2vxQhX4/XJ2261J8n?=
 =?us-ascii?Q?qYhv71817TG89qW9yZrFSkEJzx2AnGfSdpXA5OM9ymjm8tJofQxv2tCQklcP?=
 =?us-ascii?Q?37KI8sgsHMSottxr6eLGxpXB96uSu0LHIRUbeQBoK8iNIi5Qpvgg2d+kp+hA?=
 =?us-ascii?Q?KO4wHgYUSdpMAoBirTMwWl7/qc44HusYv50hSALfqfLQPGcIvdYB0RIeQkAG?=
 =?us-ascii?Q?D8CqYBcYK4gYcQ6AQ5MuxiYP+UAYwDuS0XQQJItq/xpp9Gh0TfvFBPypczkC?=
 =?us-ascii?Q?mVHlUw5HW4cFm9dy7pnpc4B8/pFg/PzdtAwSAisjbw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eifnUsw1hulDYJpZVblPdr8LN4Is3UHCD0pPA7TB0n0U7eL1IS6766hBQya1?=
 =?us-ascii?Q?8r2wsGanE5ilPXUIlrrtB6iBODC3H7rF73R52Io3j8kAQWBW1UMp4XlYHmRx?=
 =?us-ascii?Q?wk9mSp/iejJL54KU43EqspXVnjw0VDYfX0UWc4RVc26ULGcbLEpDqAG11flX?=
 =?us-ascii?Q?cM5ePHIqfUb9jQZEVN+aX2OtVYvslzBi3pttx/DlEKTt8d1jzQUBL0A48fgh?=
 =?us-ascii?Q?lrx0jOAV0bTphtdkUe3xfAtXUzzigKX+0ulg+mb4XmVvTbGUdLlY4ILbRXd1?=
 =?us-ascii?Q?lu6BLV7fb5+HoQyolBkHMw+a5+DzX6Sve6m76GBvOC9/I6vKRK2QnYGSl7//?=
 =?us-ascii?Q?2Oj/SU3mNI4QDACzhlVJSou08Tc5o2gN5N7I9I+hglgPmTDAN8gCylm6lNFe?=
 =?us-ascii?Q?w8+QYuxfLwza+QtRAES2HLEd90Cw1RuhC6w5ENQV0YsMIDd8ZoK7IT840GhO?=
 =?us-ascii?Q?i3CInh6mGkWxZb8k4eS9k8EVe/2xpMzydoNlxPUQvLR2H1EM6QEHrtJv8WKP?=
 =?us-ascii?Q?mu8qi4il/ouJ96ZkyeLSifaCePs2JD8S/iHf1spwabvwPs/Iw+kP0iN2u5AU?=
 =?us-ascii?Q?hL/UHqvU0JOeakw7JZl0U6iWYaB8j89uzOL6/Ass8kRpNArdtYjkeh2H+h+Q?=
 =?us-ascii?Q?k4uVGpFMOG+iiPdGjMtfqm+dq54UxiRuY3Txz+EhqQhA/uIabQSKnJaYuj9r?=
 =?us-ascii?Q?sgElSM1LHTpy28Qk0WD9VVSadUphsngf03BvIDfVPXHXEHZiSGjzjjhtEwIo?=
 =?us-ascii?Q?oUCVVsDtB1h1E7lMwEDSKlsCgWXCdGvJlWyPbjRssYxeFcWa1D0obU51amxF?=
 =?us-ascii?Q?KFgf4iKYzjNmsZ0zcSs224GGfGArcYs+4kkSiElA6DkYce215+gtckQ1H7gP?=
 =?us-ascii?Q?YfLfntIEjNGScNvvJxLBf99hPEKcf8Ys/OVyPCOBq05vvs6hvnDvGYxY5YKO?=
 =?us-ascii?Q?mrSOZLJpZESmCtpNmIxq8xZapscTNzJU2Uylg/RdSLA+RtpMBhC8eSLVryUU?=
 =?us-ascii?Q?u2KCHWbF29ECZEd7auL+XMqwPNzC/lnFyVe/tmUlATi6YCOO3rGXFtXQrIbT?=
 =?us-ascii?Q?gif/3bj+3dijrR1pPvoHRPFNuyHISwtqNE2tzq4JIRHJLiG9REyMgIhb5ile?=
 =?us-ascii?Q?1Cl9xGpDs1HDDC7iU/9RB3snYemV1/MRK5VZkW7JyIlJpld7cV9uBvikOgel?=
 =?us-ascii?Q?s0tlZh9O7YSUrvZGFgdYIum0+ZZnYylZb5N7xnc/uQzB1Qxw6U6luCro0ApQ?=
 =?us-ascii?Q?eRiZAMO+x6ShA6l4lMyVKxjNL+wJ7oH6yf5STXxpRsKmV+XiLP4eoxBMxtge?=
 =?us-ascii?Q?AXdv5evLI5FgnlVF+tgWr7nXuXqvJpz9uX/Hc+TbCqfSomvQDuGjQeXWcoNy?=
 =?us-ascii?Q?wGL7SklBRLG3l7pJY5bI5weA6GASSQnaJ9TRSEGbYRj1wSQABRi54D+4Sj4Q?=
 =?us-ascii?Q?qQTSKPwzlaXnNu4AlN7XpLo1z+5U0jvnNWJmAn0TVz5LCDZsEhN45Dzbx2KW?=
 =?us-ascii?Q?UQB+77WZdhByIxSZd9ox4+j2ioUnT2mQqKaqTT4WDe9sSqIaJlwy3WNT9uBj?=
 =?us-ascii?Q?piiX182IX9GIbHHSFyMMTIEYMqqtVktkYMV0of3blannEd081Z/07qIH+3XY?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7wY6hGEWVl8gXWhw0ZTRS6LjUw/bmX27cAL+d7t72sMsDrBpvDga3RWxajoRdAOqmw3JycAg76Ra+owrbvlKuoyWavJe+CCg99oueiS8JS7zd/TlBVwic8fQm0QsyuvhLAVaV3arSkVOOs43AMJmejzhlDEQ3NvrsSOr9BwZsw4/OOIMUrDmpLiBJ6BbC+NXvXN+zvdhG+zce6HCw2xIoXpS6pZ7naqT75msMM7uQ1h08M6CR97y0FJGkYHkhzD7sWf07RnNhQ0ZR088dCespxMf6zR9yfN9vO8E2cW6ZdNITCWLjgoiswU37ccCYm2M5e9W9ByNxRVFx4fuFWd24OTQ7JMmdP68QnUygZnC7RLuCFph8ERS1fgiMgwHgHfu0I8K7I7LeJhpW8Ehz4fq4zuFGBb5Cj73scWBbu3TZQ2DeV8RXxmqkPt1gwcVUe80WrPfn6xWhgUGGI0dgoeAOpH1CzvB+X6NNlAVXK6dNFQ3UeBLx/7nSluean10o2rT/F3u1MiDUyJrzPkDshEkCDUde6+5uve+q4kaYiS0WKNh9/5+iU4IR0qqtCVmOirzSDYamI1LWp/1klubJBGjLgLEKMTJmrcsx8yXkoEfl2o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0d9d13-e2d2-4658-7f37-08dc810a2f91
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 00:39:52.9376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xM/09o2TWb6B8dXquBNhvamTzrZ1c6/NGGSEsyCXQkxZhVfityytno+/OMXN+r7PG8YsSUWzhqdyh5WjJ/A4+HexKYV+UPRq8iDHQ5VDYkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310002
X-Proofpoint-GUID: nE63IZupd9uw7VtbVJidpQnPffqx7Xr5
X-Proofpoint-ORIG-GUID: nE63IZupd9uw7VtbVJidpQnPffqx7Xr5

Introduce a new LSM called Clavis (Latin word meaning key).  The motivation
behind this LSM is to provide access control for system keys.  Before spending
more time on this LSM, I am sending this as an RFC to start a discussion to see
if the current direction taken has a possibility of being accepted in the
future.

Today the kernel has the following system keyrings: .builtin_trusted_keyring,
.secondary_trusted_keyring, and the .machine.  It also has the .platform
keyring which has limited capabilities; it can only be used to verify a kernel
for kexec.

Today the kernel also tracks key usage for verification done with any of these
keys. Current verification usage includes: VERIFYING_MODULE_SIGNATURE,
VERIFYING_FIRMWARE_SIGNATURE, VERIFYING_KEXEC_PE_SIGNATURE,
VERIFYING_KEY_SIGNATURE, VERIFYING_KEY_SELF_SIGNATURE, and
VERIFYING_UNSPECIFIED_SIGNATURE. After these usage types were originally
introduced, most additions have typically used the
VERIFYING_UNSPECIFIED_SIGNATURE.

At the moment, besides the usage enforcement for .platform keys, any key
contained within the system keyrings can be used for any verification
purpose.  For example, a key that was originally created to sign kernel
modules could be used for BPF verification.

This new LSM adds the ability to do access control for all system keys. When
enabled, only the .builtin_trusted_keys are available for loading kernel
modules and doing a kexec.  Until an ACL entry is added for a specific key, no
other system key may be used for any other purpose.

Enabling the LSM is done during initial boot by passing in a single asymmetric
key id within a new "clavis=" boot param. The asymmetric key id must match one
already contained within any of the system keyrings.  If a match is found, a
link is created into the new .clavis keyring.  This key shall be used as the
root of trust for any keyring ACL updates afterwards.

On UEFI systems the "clavis" boot param is mirrored into a new UEFI variable
within the EFI stub code. This variable will persist until the next power on
reset.  This same type of functionality is done within shim. Since this
variable is created before ExitBootServices (EBS) it will not have the NVRAM
bit set, signifying it was created during the Boot Services phase. This is
being used so the "clavis" boot param can not be changed via kexec, thereby
preventing a pivot of the root of trust.

As mentioned earlier, this LSM introduces a new .clavis keyring.  Following
boot, no new asymmetric keys can be added to this keyring and only the key
designated via the initial boot param may be used. This LSM can not be started
at any other point in time.  The .clavis keyring also holds the access control
list for system keys. A new key type called clavis_key_acl is being introduced.
This contains the usage followed by the asymmetric key id. To be added to the
clavis keyring, the clavis_key_acl must be S/MIME signed by the sole asymmetric
key contained within it. New ACL additions to the .clavis keyring may be added
at any time.

Currently this LSM does not require new changes or modifications to any user
space tools.  It also does not have a securityfs interface.  Everything is
done using the existing keyctl tool through the new .clavis keyring. The
S/MIME signing can be done with a simple OpenSSL command. If additions or
updates need to be added in the future, new ACL key types could be created.
With this approach, maintainability should not be an issue in the future
if missing items are identified.

Clavis must be configured at build time with CONFIG_SECURITY_CLAVIS=y. The list
of security modules enabled by default is set with CONFIG_LSM.  The kernel
configuration must contain CONFIG_LSM=clavis,[...] with [...] as the list of
other security modules for the running system.

For setup and usage instructions, the final patch includes an admin-guide.

Future enhancements to this LSM could include:

1. Subsystems that currently use system keys with
   VERIFYING_UNSPECIFIED_SIGNATURE could be updated with their specific
   usage type.  For example, a usage type for IMA, BPF, etc could be
   added.

2. Currently, each clavis_key_acl must be individually signed.  Add the ability
   to sign multiple clavis_key_acl entries within the same file.

3. Currently, this LSM does not place key usage restrictions on the builtin
   keys for kexec and kernel module verification. This was done to prevent a
   regression that could  prevent the kernel from booting.  This could be
   changed if there was a way at compile time to pre-populate the .clavis
   keyring. This would allow the ephemeral key used to sign the kernel
   modules to be included within the .clavis keyring, allowing the kernel
   to boot.

4. UEFI Secure Boot Advanced Targeting (SBAT) support. Since
   the boot param is mirrored into UEFI before EBS is called,
   this LSM could be enhanced to not only enforce key usage,
   but also SBAT levels across kexec.

5. Having the ability to allow platform keys to be on par with
   all other system keys when using this LSM. This would be useful
   for a user that controls their entire UEFI SB DB key chain and
   doesn't want to use MOK keys.

I would appreciate any feedback on this approach. Thanks.

Changes in v2:
  Rebased to 6.10-rc1
  Various cleanup in the first patch recommended by Jarkko
  Documentation improvements recommended by Randy
  Fixed lint warnings
  Other cleanup

Eric Snowberg (8):
  certs: Introduce ability to link to a system key
  clavis: Introduce a new system keyring called clavis
  efi: Make clavis boot param persist across kexec
  clavis: Prevent clavis boot param from changing during kexec
  keys: Add new verification type (VERIFYING_CLAVIS_SIGNATURE)
  keys: Add ability to track intended usage of the public key
  clavis: Introduce a new key type called clavis_key_acl
  clavis: Introduce new LSM called clavis

 Documentation/admin-guide/LSM/clavis.rst      | 198 +++++++++++
 .../admin-guide/kernel-parameters.txt         |   8 +
 MAINTAINERS                                   |   7 +
 certs/blacklist.c                             |   3 +
 certs/system_keyring.c                        |  31 ++
 crypto/asymmetric_keys/asymmetric_type.c      |   1 +
 crypto/asymmetric_keys/pkcs7_trust.c          |  20 ++
 crypto/asymmetric_keys/pkcs7_verify.c         |   5 +
 crypto/asymmetric_keys/signature.c            |   4 +
 drivers/firmware/efi/Kconfig                  |  12 +
 drivers/firmware/efi/libstub/Makefile         |   1 +
 drivers/firmware/efi/libstub/clavis.c         |  33 ++
 .../firmware/efi/libstub/efi-stub-helper.c    |   2 +
 drivers/firmware/efi/libstub/efi-stub.c       |   2 +
 drivers/firmware/efi/libstub/efistub.h        |   8 +
 drivers/firmware/efi/libstub/x86-stub.c       |   2 +
 include/crypto/pkcs7.h                        |   3 +
 include/crypto/public_key.h                   |   4 +
 include/keys/system_keyring.h                 |   7 +-
 include/linux/efi.h                           |   1 +
 include/linux/integrity.h                     |   8 +
 include/linux/lsm_hook_defs.h                 |   2 +
 include/linux/security.h                      |   7 +
 include/linux/verification.h                  |   1 +
 include/uapi/linux/lsm.h                      |   1 +
 security/Kconfig                              |  11 +-
 security/Makefile                             |   1 +
 security/clavis/Kconfig                       |   9 +
 security/clavis/Makefile                      |   7 +
 security/clavis/clavis.c                      |  25 ++
 security/clavis/clavis.h                      |  20 ++
 security/clavis/clavis_efi.c                  |  50 +++
 security/clavis/clavis_keyring.c              | 314 ++++++++++++++++++
 security/integrity/iint.c                     |   2 +
 security/security.c                           |  16 +-
 35 files changed, 819 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/clavis.rst
 create mode 100644 drivers/firmware/efi/libstub/clavis.c
 create mode 100644 security/clavis/Kconfig
 create mode 100644 security/clavis/Makefile
 create mode 100644 security/clavis/clavis.c
 create mode 100644 security/clavis/clavis.h
 create mode 100644 security/clavis/clavis_efi.c
 create mode 100644 security/clavis/clavis_keyring.c


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.43.0


