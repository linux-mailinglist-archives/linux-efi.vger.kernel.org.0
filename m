Return-Path: <linux-efi+bounces-1982-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05799A2776
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 17:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763CB283EA2
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8932A1DED6A;
	Thu, 17 Oct 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KWNh8eR8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cR6DJ4Qx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88317ADF0;
	Thu, 17 Oct 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180602; cv=fail; b=TqK01jpMUilWL1O6hIZPrnSCjWPkAJEy3V76imBWgH4eMpUcgXjv0dxZixsjTTLtF8S0PPdTQ41ksROgkjAuG7u7yVslk27y/KS2K6JRXQYPcp6ZNNhNPzHHhaMLpabFvFmIxDCYwKTRMJ0Dhf8OmsI6iDex1HBGlovufDkLlPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180602; c=relaxed/simple;
	bh=nsy8i+d12+HzPq9fW1OWHX/2Wr+GQGYwF9K0hnhAOTs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RH2r5JwCRqk5FIy+v30aaWULZQ2UT1C5P5jICq5aznVCqpOob0q2AnZ19W3Lr28m/xL561f4Y420dsMbC207l+YpaHIoYKD+0+Xijtx+EWwx6VFCUpQBz8hX0DcZgYYLRyDGjKqo9lkaSaXrVZJJ8lAnifHkdMoGig29uAluUIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KWNh8eR8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cR6DJ4Qx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBn1V002171;
	Thu, 17 Oct 2024 15:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=KskcF1rxZWCaDFoF
	QewCcVsEkpkoG0RYRkJMtJqmOr8=; b=KWNh8eR89jjI6BTmc5+ccAwBNUfM1vyg
	Yy5eSldeO7WzlGlSvk31rx5OfPkAI2eLsV0FY7tS5BhbbrwE78hc3+wpbEhZ1IqC
	NO6/hKwmPp/qnyIRQY9xdzT0dSb8b0gBGooKgwAEohR63YMe8KIXQ85OXQ7ObwUO
	z3gjEbgsBml4U1sh4UFoKWoXd//KjJ+/ObFIh2slcaKQ0Ux4chIdUiGUHTuXDPsN
	bq7ZpqefTb8w6Pgd0rF957j1ZpaWTZiempYPcxMT750g0+5rRt67FB1OiJY/g762
	+4gtX7c04AjyknyWSU0e2NpxqCy97X7geuL8jcR2UYCrfcijYs6Rpw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2pxen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HEg5sr014010;
	Thu, 17 Oct 2024 15:56:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjadu75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nlv3Y0dYYA6YqN1wQ4vdkLU6IxtrgB41U7M9satbroA6+oYZ4ytqRHz/5MTO7ivoCr7UfqxlDwVrbYdHV+cxPDKYeiEpGkc6/myNZC8nymhHZwG6Y5OLmNoZBJzc2cu2CiJiCgfr+UrPnUVyDfmbRkRcm7nn+3PJ34nZhbKpUewW86lAqMzZLsuH2zXMbCQEs3Z/WKGJdAeeWznlHh71HUwcNlfvpbQPYBO93lbF9wjOLzdjWulDgALaXSoWo68LNMN5pPLBpPv55WrTxN2l7CMaWia2AuaOEmvCyZtWW5f0SiRbnUHfILJXb8c5jLESfGx1E54uXzQgBP6aqH1hPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KskcF1rxZWCaDFoFQewCcVsEkpkoG0RYRkJMtJqmOr8=;
 b=tJ0RnA8TI/KWoecAOteSfKEj48P8h1iMVYJRlis5AOzidL6N2k+hy3H3nD6P4mif4hRl2peO9jqVY1yK8Tp2JDilDhBuNZNzWleNY/utqMHik9x8mNIMc/a+/lkmv5MEcvNYFVNWLFMgZrWPQu1vPJBULKeFOrzlxVMHlFhJzoC1pcnppm0mqjHGQLxLGbMpqOxDBhR388YVYIJ1+LEJj+JpF++6hDWhwlMvxMrlgUm65F5lxsYgOLQpC0V4cyIue5yuVAPysBJ85G/9Ni18GmV9CW7V9HGjcg9xoOB6iXilFW1lDsrvIfNIJmG4/U4d4WbCX5Ie3yyon8xnlVSN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KskcF1rxZWCaDFoFQewCcVsEkpkoG0RYRkJMtJqmOr8=;
 b=cR6DJ4QxhTR5nnnLjscQ71Z06nKKv4O+zleAzhaHvT8hRch7XArURDG58rQQ1xBGRdeKQ7VqY6FU/6JbvkcvudWWQpqB2C41dhaCLNCUDjrtryGjf8x8DYlLHMNKgLzKnYcA1QUdEmuBV9OhhJMqFZ7LI1CQ+gj7rZ43+ypVoN4=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 15:56:00 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 15:56:00 +0000
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
Subject: [RFC PATCH v3 00/13] Clavis LSM
Date: Thu, 17 Oct 2024 09:55:03 -0600
Message-ID: <20241017155516.2582369-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0412.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::16) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d08220-7ebc-4305-5669-08dceec41b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QfWczvl+/qaPDNllAkLDimrj6s868uz7m0ZSAtFUvn00hSJC07YtFQ1uUiG6?=
 =?us-ascii?Q?2P/Gd2LYjypMx3gdKbZaCDzuDpwdkgFkjPglo+JwLqHBhfMFH00vUiQ8ObH6?=
 =?us-ascii?Q?8mg5n+zI+3CBQ36SpsECxnk1cg/kDXpnKcB2XnV+o03Tlb/t4Fqjf87ZAExS?=
 =?us-ascii?Q?qXVxQPByRiFXZ16PLATFsWDuga87Xnb0sv3HPzvpuWcedrlpUfdmYvgkY6yF?=
 =?us-ascii?Q?troNqKr+AUBMtmX9n7oqoiUfVIrND3Jiwv0OK6UWy6hAbqTfxyuNSHByDmvM?=
 =?us-ascii?Q?A7pxU1jLWJLtrU8Yd1alkikKYZ40ngeyZY2jD+m0Pebh1LQT47q5RrYoiXIB?=
 =?us-ascii?Q?oPApKxUdSl9ryIP6FJ/lfdlK6cPXA7RUrpcBHrmsXlvfXA9P+2N55SsfrjHd?=
 =?us-ascii?Q?tAOErJ9Axqh6f/cf7LezF0b5XyLakXlbAMncsSuFgjRc0GBeedUBf2+Z9KN0?=
 =?us-ascii?Q?4mvyzcQTwVTlo4EEsxDzDvmYeCzZSG3JqTqr2T+vIJ8ZY2xV2I3VN+VRVeDJ?=
 =?us-ascii?Q?kSZ/MfxK1z6qdYRLnRdllVTFr/P115ZE5N3M+qnF/OuaqqRaP0gODOToGC9S?=
 =?us-ascii?Q?lLf+Ycu9ziO486NnEyyR8xfCL5hx5Lzy/Wg1uLOF0rZF24HJ1D0EIiq/aQpD?=
 =?us-ascii?Q?Dk3FYKJxG4dYe9OqqRzNIn3hOGhsUEy8mvvjX/vrD4rvQwL/BTgWDNL7hA1b?=
 =?us-ascii?Q?SqNRLV+NE2YqW50qgRFhML4WBye8YQWFcRZTkzdELFU/pyFa3HJIRZqxQy8e?=
 =?us-ascii?Q?sLnj9CzOi1fuhpulh3PVk0YjztWTCJuj//shWpY7c1KHsdtTsvj1AC1Ap4sm?=
 =?us-ascii?Q?bEI43tl4h9SVdniQKGBt563Wpckoonsa3Nv26o5Q5o85H2QLYzTPpPyTl5kk?=
 =?us-ascii?Q?sJo0bqDNV29JhTLk98n5zHrfb6SFAN7vZ8BxFXRl3joh6ANjmr5LAj6MI+uG?=
 =?us-ascii?Q?b/AzrfevIr/iWsp4Ffr/exp4ykKI45F9P8zA2iCRspwPZ1bRGDiHocd8r8EE?=
 =?us-ascii?Q?fkCOr8qfIRwe0j449g+WBQSztp1CLuJv75OlLIB4dm22OoWg+CC/wNPjjve6?=
 =?us-ascii?Q?Uz315KyPG72HUAwTBrTqVJvfHD/dASDqGkvBE65cnfyJnY/y1qG/YSxdezBx?=
 =?us-ascii?Q?DKG4wcTzEtwewYugyr6UOK8jHr42UTlhpEB3lV6noQDU4bxfrZOs6dRfCvR1?=
 =?us-ascii?Q?cNRiOLrJc0keLxLR7bA0f7ppa6m74LRnte7Tn6jE4d7zGRFTImp70FZmGlT4?=
 =?us-ascii?Q?jtR7ptsn3XdJ9xuYEmLvm8QXRj75Umd0dXltbp8xF1GT4B5jgWfQrYOpYD6n?=
 =?us-ascii?Q?uBo74gXlCU9nPxLLKb7nUVM5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4pgsi5vyXOpaotYtU5Ipo558nolgzkuwWOEXuBZkRUh+JrDdGLivs/TQljg?=
 =?us-ascii?Q?D/URbA5jq6bceg8mxbswjPBpx5xo6E/sP5nEy19mNDeviJhCWY+uRRl0kyLZ?=
 =?us-ascii?Q?Sh8JRLrfc+8FlgJMqg5RDS/pb/7Y4fuGK2trlrUBYxQUGSD31ieT0pdOFn99?=
 =?us-ascii?Q?4gh35y3yzX5EjL4qIRaVaLrGbS7AM5qpdGPbyAFcA4hg43KsTZoNGdjFGaIi?=
 =?us-ascii?Q?CgOfKNpKfzxd2ZLYIs+VIZ/khFMa6r3lrRFF8u0fhEix7dLw0t6ybE9OaZSk?=
 =?us-ascii?Q?kbBHTBI62W3rByexh5jgtZ0jRKm0vxhuJhhuv0wiBwC6x5kRokwgSDag7sAm?=
 =?us-ascii?Q?Y9Z22CcyKLh5W59LSmsWnlyQ5xhdfKHJ1Lgxn8sY0nAHha5dkMEaA5CRrEXZ?=
 =?us-ascii?Q?+DMrkdv+ljLuOz4q3uK3F/lFvhJDveuL6I/S26lbczRJ++5ebBs6waJclkCs?=
 =?us-ascii?Q?C8HTpIzqL1hdmZbfkInx7Tkkrp20Pl4vCs8YGZ6INTqxIKoKltyeWVugGzUp?=
 =?us-ascii?Q?yw4yaxmVH7Sj5PuAUJM1v6Of8M90zRH9OHQt12ieUXzSnXOWaPiIvKd1pRsd?=
 =?us-ascii?Q?cy6KXJRvrkBuvB30GqkdeCWmXrSerbyvyysh28e7pQg0Ghczws6p1/n1hCP9?=
 =?us-ascii?Q?4eQh0E4v2jj37AYgQfBBtFmIkIwj2uP7IwxcnSPbDsysZiE/LQ7n3QARMdms?=
 =?us-ascii?Q?dCHZa6vFeXzSPjrMRDE19hhNfeia7BBsYh6wp8I73+YlFWpX239Cla/EQNv/?=
 =?us-ascii?Q?7yfK1ABOD5zI22Mn1SkYGe65amTPN6LNpkYKPWSv3RiKWrqIS3oNOo8g7tx5?=
 =?us-ascii?Q?BW9GITYmhwJF3TebfpilKXuG2u+qvVbexQtR0UuL68GYerG+xPglc79Mdw1x?=
 =?us-ascii?Q?VMiN50jDbQOkI/kPGIqyN13yQo2VqVFDFOE/ZXSv9TbgZuJuQY+BL6ZwQDHn?=
 =?us-ascii?Q?7uqSlPGyMDwCpUA0I6R+hVGX7y6KTPIA/kBX9b8OZFnU/JA5esrVJLdhungl?=
 =?us-ascii?Q?228ubgJTZ3mUNLQz5Y22ASr//pNxIOgm+0TxF9PjnxbpsULmkFGP9IGBq9jY?=
 =?us-ascii?Q?biUUVkui5Z5AyI37aK3D1fo3EkokEe+Ku51OLDFJp3Ue05NeNXXHZ/i3iDuy?=
 =?us-ascii?Q?J2M9f0rXeETz22T4FV5VGlWjuVvz5I+zUN0CIGq5vTvjjOP/7GEmSVaDJOPh?=
 =?us-ascii?Q?X0PPfzlJQ3q1/d66e1s5FK1K9kiGB7cqjmd4kVDFYSIdXGi5CEvbJmkkT0tn?=
 =?us-ascii?Q?iRYPzXzrsFwRf6op55YibrJ2pB8vwM0nL1ECMLLnuKYSaPj5LUeLAqI1jCiF?=
 =?us-ascii?Q?ae8lnJmoSiBtMiw/a8zRQLdpAcRFAJvCYMtyfqzF7Z677MuJw45ryUzDmwZE?=
 =?us-ascii?Q?XyB5yfNM3bjGQplBTm0cf8bzuIeJdhWKp0it1Y+76TRhUiq9mijM74pX72Qo?=
 =?us-ascii?Q?xVKlxyBoA+/IJ53PEMmO0NLA7uyGC6IFZJ5NrUW6pDe7Xwbj8AM5FcA4bW3S?=
 =?us-ascii?Q?95kpxWgv93yP57wo0/7prZGEpuWRK/uJN5ogfVfY7YI5Cc+WDLhZnnPv1seH?=
 =?us-ascii?Q?iw8ldiU86nvgKjuX6Fq155UVaBYyEWdkviFeybKXw2G5wFi8RReMWn8v2F1N?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TwqL0CHCtIE3PXsusjy72Ftnc/7k6OIMX9GIPgw1PnCmol3CgmhcqGbML40zZCe7KZZdQCuaKPUhRgbrLehHjkS1SoS8t/v9WgimEsz0MeeXp3CUTymJfMNibyWh3FUcdgTUBD11gbauKkKngGusvW8a3j7ybhB72S4GlnYLR+zM31cCAH5JODmnMlsWBf1v4pPXW7ErsCtjsQxyr7CQ8pHch0snLbc5w9qRdeDvmJ/1aKoQPeRyB4IRD3n4WBFUXsvBvQsrPxRIZp9p7q7zznnhSXrK9uoVk2f23IlaSxBDY3LnWmhkXy88XknXbz2gkxiUYgEeZTC1s9/uOz4oYeC72qG8ZvK/1+FznS0yv18jBy0yuC0hBxtTvo6O6w21Y1Oma5ly0NTEP0aHTZZZqXXNO2I5aP5nIA8KijQJN8evlAWoL/F3o+Aw+yEKloFkhJRIEKBih3Szrp5TQiUfKSn5a6/Te6MWinFKaPfX3uUFAf/64N7sTsgxKz+Kx4/kOHap9UVY/AYJnbuI4IbyFl1qKcD2vaU239JjdA13mlN/+zTgqU21Ibv6rHdA18qfJ9thnw9dDb7BKyTNzwwBr3/j6xElNfnkZRYiaGKTZCk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d08220-7ebc-4305-5669-08dceec41b01
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:55:40.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1HJTpIJPIRUIP/AqRFM4G/RU0FkPMy4d84v2zWcUKRwMeRwiqBhQ7k24xXKKR9fr03zmI5UcDEqWucnkV4c7v8N6fi+YDif0KOZlFGPlJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-GUID: w9HxsukxnE_rZNe9wmBZNFSOFe-S_gfZ
X-Proofpoint-ORIG-GUID: w9HxsukxnE_rZNe9wmBZNFSOFe-S_gfZ

Motivation:

Each end-user has their own security threat model. What is important to one
end-user may not be important to another. There is not a right or wrong threat
model.

A common request made when adding new kernel changes that could impact the
threat model around system kernel keys is to add additional Kconfig options.
As kernel developers, it is challenging to both add and keep track of all the
Kconfig options around security features that may limit or restrict
system key usage.  It is also difficult for a general purpose distro to take
advantage of some of these features, since it may prevent some users from
executing their workload.

It is the author's belief that it is better left up to the end-user on how
kernel keys should be used within their system.

Throughout the Linux kernel, key usage is tracked when doing signature
verification with keys contained within one of the system keyrings;  however,
there isn't a way for the end-user to enforce this usage.  This series gives the
end-user the ability to configure key usage based on their threat model.
Having the ability to enforce key usage also improves security by reducing the
attack surface should a system key be compromised. It allows new features to be
added without the need for additional Kconfig options for fear of changing the
end-user's threat model. It also allows a distro to build a kernel that suits
various end-user's needs without resorting to selecting Kconfig options with
the least restrictive security options.

Solution:

This series introduces a new LSM called Clavis (Latin word meaning key).
This LSM leaves it up to the end-user to determine what system keys they want
to use and for what purpose.

The Clavis LSM adds the ability to do access control for all system keys.  When
enabled, until an ACL entry is added for a specific key, none of the system keys
may be used for any type of verification purpose.  When the kernel is built,
typically kernel modules are signed with an ephemeral key, an ACL entry for the
ephemeral key is pre-loaded, allowing the kernel modules to load during boot. At
build time other ACL entries may also be included.

The Clavis LSM requires the end-user to have their own public key infrastructure
(PKI).  In order for a Clavis ACL entry to be added, the ACL must be signed by
what is being called the Clavis key.  The Clavis key is owned by the end-user.
The Clavis public key can be contained within the machine keyring, or it can be
added after the machine boots.

Not only is there a new Clavis key being introduced, but there is also a new
.clavis keyring.  The .clavis keyring contains a single Clavis key. It also
contains any number of ACL entries that are signed by the Clavis key.

It is believed that the most common setup would be to have the Clavis key
contained within the machine keyring. Enabling the Clavis LSM during boot is
accomplished by passing in the asymmetric key id for the Clavis key within a
new "clavis=" boot param.  The asymmetric key id must match one already
contained within any of the system keyrings.  If a match is found, a link is
created into the new .clavis keyring.  This Clavis key shall be used as the
root of trust for any keyring ACL updates afterwards.

On UEFI systems the "clavis" boot param is mirrored into a new UEFI variable
within the EFI stub code. This variable will persist until the next reboot.
This same type of functionality is done within shim. Since this variable is
created before ExitBootServices (EBS) it will not have the NVRAM bit set,
signifying it was created during the Boot Services phase. This is being used
so the "clavis" boot param can not be changed via kexec, thereby preventing a
pivot of the root of trust.

As mentioned earlier, this LSM introduces a new .clavis keyring.  Following
boot, no new keys can be added to this keyring and only the key designated via
the initial boot param may be used. If the clavis boot param was not used, the
LSM can be enabled afterwards using the keyctl command.  The end-user may add
their Clavis key into the .clavis keyring and the Clavis LSM shall be enabled.

The .clavis keyring also holds the access control list for system keys. A new
key type called clavis_key_acl is being introduced. This contains the usage
followed by the asymmetric key id. To be added to the clavis keyring, the
clavis_key_acl must be S/MIME signed by the Clavis key. New ACL additions to
the .clavis keyring may be added at any time.

Currently this LSM does not require new changes or modifications to any user
space tools.  It also does not have a securityfs interface.  Everything is
done using the existing keyctl tool through the new .clavis keyring. The
S/MIME signing can be done with a simple OpenSSL command. If additions or
updates need to be added in the future, new ACL key types could be created.
With this approach, maintainability should not be an issue in the future
if missing items are identified.

Clavis must be configured at build time with CONFIG_SECURITY_CLAVIS=y. The list
of security modules enabled by default is set with CONFIG_LSM.  The kernel
configuration must contain CONFIG_LSM=[...],clavis with [...] as the list of
other security modules for the running system.

For setup and usage instructions, a clavis admin-guide has been included
in Documentation/admin-guide/LSM/clavis.rst.

Future enhancements to this LSM could include:

1. Subsystems that currently use system keys with
   VERIFYING_UNSPECIFIED_SIGNATURE could be updated with their specific usage
   type.  For example, a usage type for IMA, BPF, etc could be added.

2. Having the ability to allow platform keys to be on par with all other
   system keys when using this LSM. This would be useful for a user that
   controls their entire UEFI SB DB key chain and doesn't want to use MOK keys.
   This could also potentially remove the need for the machine keyring all
   together.

3. Some of the Kconfig options around key usage and types could be deprecated.

I would appreciate any feedback on this approach. Thanks.

Changes in v3:
  Rebased to 6.12-rc3
  Added Kunit test code
  Preload an ACL in the clavis keyring with the ephemeral module signing key
  Preload user defined ACL data into the clavis keyring with build time data
  Changes to the second patch recommended by Jarkko
  Reordered patches recommended by Mimi
  Documentation improvements recommended by Randy

Changes in v2:
  Rebased to 6.10-rc1
  Various cleanup in the first patch recommended by Jarkko
  Documentation improvements recommended by Randy
  Fixed lint warnings
  Other cleanup

Eric Snowberg (13):
  certs: Remove CONFIG_INTEGRITY_PLATFORM_KEYRING check
  certs: Introduce ability to link to a system key
  clavis: Introduce a new system keyring called clavis
  keys: Add new verification type (VERIFYING_CLAVIS_SIGNATURE)
  clavis: Introduce a new key type called clavis_key_acl
  clavis: Populate clavis keyring acl with kernel module signature
  keys: Add ability to track intended usage of the public key
  clavis: Introduce new LSM called clavis
  clavis: Allow user to define acl at build time
  efi: Make clavis boot param persist across kexec
  clavis: Prevent boot param change during kexec
  clavis: Add function redirection for Kunit support
  clavis: Kunit support

 Documentation/admin-guide/LSM/clavis.rst      | 191 ++++++
 .../admin-guide/kernel-parameters.txt         |   6 +
 MAINTAINERS                                   |   7 +
 certs/.gitignore                              |   1 +
 certs/Makefile                                |  20 +
 certs/blacklist.c                             |   3 +
 certs/clavis_module_acl.c                     |   7 +
 certs/system_keyring.c                        |  36 +-
 crypto/asymmetric_keys/asymmetric_type.c      |   1 +
 crypto/asymmetric_keys/pkcs7_trust.c          |  20 +
 crypto/asymmetric_keys/pkcs7_verify.c         |   5 +
 crypto/asymmetric_keys/signature.c            |   4 +
 drivers/firmware/efi/Kconfig                  |  12 +
 drivers/firmware/efi/libstub/Makefile         |   1 +
 drivers/firmware/efi/libstub/clavis.c         |  33 +
 .../firmware/efi/libstub/efi-stub-helper.c    |   2 +
 drivers/firmware/efi/libstub/efi-stub.c       |   2 +
 drivers/firmware/efi/libstub/efistub.h        |   8 +
 drivers/firmware/efi/libstub/x86-stub.c       |   2 +
 include/crypto/pkcs7.h                        |   3 +
 include/crypto/public_key.h                   |   4 +
 include/keys/system_keyring.h                 |   7 +-
 include/linux/efi.h                           |   1 +
 include/linux/integrity.h                     |   8 +
 include/linux/lsm_count.h                     |   8 +-
 include/linux/lsm_hook_defs.h                 |   2 +
 include/linux/security.h                      |   7 +
 include/linux/verification.h                  |   2 +
 include/uapi/linux/lsm.h                      |   1 +
 security/Kconfig                              |  11 +-
 security/Makefile                             |   1 +
 security/clavis/.gitignore                    |   2 +
 security/clavis/.kunitconfig                  |   4 +
 security/clavis/Kconfig                       |  37 ++
 security/clavis/Makefile                      | 156 +++++
 security/clavis/clavis.c                      |  26 +
 security/clavis/clavis.h                      |  62 ++
 security/clavis/clavis_builtin_acl.c          |   7 +
 security/clavis/clavis_efi.c                  |  50 ++
 security/clavis/clavis_keyring.c              | 426 +++++++++++++
 security/clavis/clavis_test.c                 | 566 ++++++++++++++++++
 security/integrity/iint.c                     |   2 +
 security/security.c                           |  13 +
 .../selftests/lsm/lsm_list_modules_test.c     |   3 +
 44 files changed, 1757 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/clavis.rst
 create mode 100644 certs/clavis_module_acl.c
 create mode 100644 drivers/firmware/efi/libstub/clavis.c
 create mode 100644 security/clavis/.gitignore
 create mode 100644 security/clavis/.kunitconfig
 create mode 100644 security/clavis/Kconfig
 create mode 100644 security/clavis/Makefile
 create mode 100644 security/clavis/clavis.c
 create mode 100644 security/clavis/clavis.h
 create mode 100644 security/clavis/clavis_builtin_acl.c
 create mode 100644 security/clavis/clavis_efi.c
 create mode 100644 security/clavis/clavis_keyring.c
 create mode 100644 security/clavis/clavis_test.c


base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
-- 
2.45.0


