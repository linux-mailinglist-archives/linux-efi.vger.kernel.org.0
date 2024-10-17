Return-Path: <linux-efi+bounces-1986-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372359A27B5
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 18:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7C4B26FE1
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5CB1DF25E;
	Thu, 17 Oct 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fybM0SQk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kMZ3/oNU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64EF1DF24C;
	Thu, 17 Oct 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180610; cv=fail; b=tu5eqHj/UO8NJnZqVqGSbdgyFPyqUSU44gublPUt/oMMk5WOJM7RmheE1KO0JSbuNQLvUT0To7pVNGZLKM+TWZN+djvv0cfRsdbNqvuTYR+3vUKhRLYpL94qR/Xjbrd09ZfP5zyLxoCvCryZ8JVpvZ8TOD+JLhlKxdarHAhyYwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180610; c=relaxed/simple;
	bh=jf2VTlHUcrrD++SlXTfEnLEsdou5s/LUahpZnmfs7pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OoSx9BOU74LWSgOfDzBsseLOx+CpzHErQ3SFqcANcWDdxwwk2pcDJyrwCkyghoQcPySaDuUripFGceP3l/P1kqYlhIXfzenLbZoD3QYBR8gUPv39yZbL4ZFHQW6rAqek3pGVYUPt0HakhUMRtK4QIyLJ/gqBg3qsD8Psx2TtjaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fybM0SQk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kMZ3/oNU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBr3S028917;
	Thu, 17 Oct 2024 15:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jOiKJn835/HEb8EO5CbkLpGBeWv1xaVUAOT2NYtg31Y=; b=
	fybM0SQkCbFON2SROtD3/JNWs4NCNu4/NmKm4uaLDALMxV9N7I1va4nDOUccdbSP
	SMjeWGXrmb0nA3ZU9vLbFRQYFeCyVH9KFlEsdiCDjQukGJwo6wpis5xPb7tpWDxv
	Jg7fCI6uTNY85X1U3DS9zabO8TlC6knzcsaiYm4XlczlbiKTMYkQN7TdRZgRikHk
	gOg+pO7QW6n8++vggEOHdPZr+rAjmIBw7jMi/iPkwoCKXr5FC0+aQmuvWKFKCgyI
	uo7vps3JFt7CptBAsfei43/nK7E8TJBl571yObqQ91XrnkM/HZKKGlendt6PMhtT
	UyBhx+KQTXdP2qrc56MDTg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt6teb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFqmgi026553;
	Thu, 17 Oct 2024 15:56:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjh180d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WULQ9THPiCZhtxPmfvQXfU6yTzqH6GMDtq3mohQTCRzzrCVAQPZLoRbOePfPKjtWLOfioIQIxxt1XkdgPXizT05uXwd4bY5+55UGX8THMFf8NSQSbTmiTkO9T/6dpe9L5g/kwd5chTMzluwPWzHj72IzmJpvdnOidLSfzyh8FNKQH19XXP0w3BWIT9oqaPxIyh0c1PETWgsg+RsuiUtOX3DigjiWsrNJA5BnOiXOylFQDqYVhyqJERTYalDgr0n4ewwZXyxcagx1z4jpxiMdRMRi2Ey/oiP8kdGqDmDr01JZ7K/1AiQq1Ny+CNmWwWDjCWUZnSst0Qw2J9AT+akiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOiKJn835/HEb8EO5CbkLpGBeWv1xaVUAOT2NYtg31Y=;
 b=cobPJ5IrX4/Ekoon81LTCpAm9x+oVWFFfC3KM6pOJUJVZNbLmnFgrkcIWWnarSNDyYQ7ekyAU2WPmX4NjnzTKanO0q86HnqACUP8k1Qpukl64AH8/IkVZRnmhhJa4OZGFKXxZbRkvrQw2C6z6Mu/pJonlc02HwMm990cQH053K4sm5/WawOABaZVBzE1AqQDCWLkLkhQMZoYZr5HP0oqg9eGm9QjkYbFros+o7kreCq6MTomSuJ+iMi8BVyJVgHREagtqSsCV623hEuwVr2tKQIIDUHPwYfmiqqoZJBwOeu78JJ6Sai9yWNdirzuibr7UNgnQ++BI21IGTwda5vd+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOiKJn835/HEb8EO5CbkLpGBeWv1xaVUAOT2NYtg31Y=;
 b=kMZ3/oNUA/LQyE/DR2UrjeHuj/vMej4iqU34NJJKrsb5vxT9zjvDcAvZK/H0+NtXCNQN0kNmvLlx8kyxGpxG2/KXmMyVl5XMEPrrmmbAg0mj+4KCfy9ef7Hg+51TpjIoLnCG0XWXn+F4ETrlNEeXzDJYCDEzykfRnYzKIlLXNts=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 15:56:12 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 15:56:12 +0000
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
Subject: [RFC PATCH v3 12/13] clavis: Add function redirection for Kunit support
Date: Thu, 17 Oct 2024 09:55:15 -0600
Message-ID: <20241017155516.2582369-13-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:a03:100::33) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 12262d9c-58ee-4d5c-847e-08dceec43922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xb5VbgQn+de4KiK85EaVBPfoK9hMIHbt7MnVx5BU2dxshPJs+mBmwSZZYGRE?=
 =?us-ascii?Q?GLuAPMz1OjTuXAoghRlaf/RPk9HxDct3rTYoJMtSNd8Ya3sLed96U5OmfRG/?=
 =?us-ascii?Q?VAI5pU5JHREci84by+tLKgA9vpH59Wx7DMgMBmUsLFBjmdT1ep3jmIW1v5Np?=
 =?us-ascii?Q?FDeStC+Df3KWdfqOaygiLDnkEdC8aZ//yELvKDu6wqfc39QAtQoSdDLHQvRA?=
 =?us-ascii?Q?+2lLk9y3FPMOb81+wEnEFuKxXupnwSibpYWb+Yj8qluaC0IxzCcJwsO+stao?=
 =?us-ascii?Q?wKOgIrkydXHav+QlVU+Ieznhb+ZYoCUkuJERPWM09ARqepeXRuqQuY5WlZU0?=
 =?us-ascii?Q?nsD/kdhAtTpIL1W6NYqpNNKHTwCnWJAEIYLodGCRWxvqWLehhg7KLQaJjPAP?=
 =?us-ascii?Q?W98vPBB2KfQ9jPfqv0r/1LCPkfF4D0u4xL4g50ALG0MYASwWDYthRnEKJX5N?=
 =?us-ascii?Q?bfEZZCjqLYfwh+5vaNSrLLn9SHEhzKQu2hIU68BSav2RcI7AuTb2ynUAbjO3?=
 =?us-ascii?Q?0Xo8gi4/tAcZwESXmMyNl0c788YyEbidVvNIcbWxy+psTuStSNEZtPbHcEJf?=
 =?us-ascii?Q?N/5kiTgsYqGJFp8jQMKLi/hqheqXSJqj8NmwxmRuoOiDQ+Jlr4pckzch58Zx?=
 =?us-ascii?Q?RDfcsBXJVPZmL9MZ3Px2lJ5WPPaBAef3XNC8mHIKewap29tRW8exQiaDdugg?=
 =?us-ascii?Q?BytLaoKlfp17pskpQ5zlrHYB5dlnqPDlDkzbDN+T725ZfwrfPvlNqYUt7Fsn?=
 =?us-ascii?Q?Oek3j386UkIjQ2w9N9req0MGPOnfJ2AsozX5aXtgk7i3NBk9F0KEctpj+Q5D?=
 =?us-ascii?Q?kJFGW3y+dAm+rWOy5HESrLZEXTp6hwo2tYwkpVlkd49VxGzCSkPaZAd6mfYf?=
 =?us-ascii?Q?dSND7GDggWPdYITZG7sLd5Q4MUojjMPvqYVMWvm3mg2hWspCwivz7X1rfE7R?=
 =?us-ascii?Q?SMGKnFz8TK8y9xM32Z3eG8o+vBVD6ROq1jYncxqnL4IfN8d4HM8trobCWuUp?=
 =?us-ascii?Q?pdeHhJ29xqTFZWt5lKNrxTOuDZl8sndIDbcIo8ezJzRhDYKVxiT5YDjGtG7R?=
 =?us-ascii?Q?HgxY8VzdvxCsTtp226QUUOHYYyhAA3EjTHgmUr3UwGliOD3qb4iX4LFBFx1G?=
 =?us-ascii?Q?AzJJZySYGo8iDHwJURy7ZYFD5cGEgzmXWQ7S7oLCpBcS/WIqfGAMH4PCxvMa?=
 =?us-ascii?Q?genBDQmfHcpZNwkor9JCsl/Jr3NUyTss2T7OcclQtqaWwj0WLSUB8+TOo6b/?=
 =?us-ascii?Q?7TnIShNsnjAITl0P1Rgr2GDvaSzGKBp5IBR5cCJaN0gdqChy1yjA3qJ6JW9R?=
 =?us-ascii?Q?uKf6DnZpeyY+kggjQh1SEYcZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uk/PcEtJHbJ1a+O2G2zefQVAQBH6PxaN7bC3gT82X1IP2PUoBQ4n9FiK3UgD?=
 =?us-ascii?Q?uC0h4ctmO4XJu1hHYPUM1ArfMGTRDgX+tRBeFBbMEZTTjtwEsTNEofT6naMq?=
 =?us-ascii?Q?hjXWoqr3AQ6wK3oriscU4vWQRxFJ5r/DRwnM6mAHiCnHQ0NlBLYagDu0QRIg?=
 =?us-ascii?Q?H4Sa3CvZtEjcg2Z1kueIJI1pSmGUkISQ5kjSrkM79Bm2IOsMuqY+QKPBWBFA?=
 =?us-ascii?Q?Ets6u8VvvMy4FWKWjymW36gi2/yimACe3Vpl/Ih7HCcT8JlwzJEasoRrCRzj?=
 =?us-ascii?Q?kw6lpi3gx8fu8ur4CQv/gFhEis3fd7W8VMCwnZ6n7JPKS6n3YhglvJnEet/a?=
 =?us-ascii?Q?+zlskgQ/JOD8ym2BdchlDrqHH4TkPkWHD5cxTgPJSMsRsG6DRQqbXtpYXefj?=
 =?us-ascii?Q?cLWAXYxtBaLryyj9DlB1x4aFbl+p3mM99v64MY/7vUufvdzyrpIBz8cV3fE+?=
 =?us-ascii?Q?mCUDfTCoWwOehbJc7l2StZcnUvnSebgLIMVbVNnEzpTt8/PeR/yG0qatf6cE?=
 =?us-ascii?Q?8uOgM9OaYTLPGjjCDFswzdC9E5WT2SXKd5zwBtsYXL1apjBP5MgVpYju+Uyw?=
 =?us-ascii?Q?suxawgdi7xygRsD4vObH+cOpnme+Z6Njx0jP2tQ5B2aM/uQLd0RrY1YEOTkj?=
 =?us-ascii?Q?utjVNkIZ+TP0d8X1Nn8v68z531U4tHY36WvzCjA7BwDGqSDA7jg1Gt2Bqu8A?=
 =?us-ascii?Q?Kz+SHtPqSIUaElUHlQIG/UmOXuBot2NBbUBQM/jaE+k0n9t5epjbxfgCAWeZ?=
 =?us-ascii?Q?4F/PqbnrJrefaSPqC52c7EIt/o5QsV1t40GnLmmP9nhVNnVlWOvJ+XxCzWJh?=
 =?us-ascii?Q?bRKAhx8hJMs7OCskxBdYnWm6WwtUS3s7U+tG3gIKUZzGWvNM3HM0C1e6ejqO?=
 =?us-ascii?Q?8RvsQGqRmJ8ISN+Sk6hbU2aFUjUq5X6fMXD22ZH17H6RHbAuPmp5dVKdRo7Y?=
 =?us-ascii?Q?qtgT6mlIMZiw6D1lcM6L2JGuh+y2IZTgUEdMtg9FQoDGtcpyJgyVTt573vjA?=
 =?us-ascii?Q?N9sGxGzob9uv5K7oN5MplrCxLEfuLusGmMKlPCMZqAh0oV/ZYDyp8H7I7zD7?=
 =?us-ascii?Q?GgW5rQeNQC7vQezT3e4RPUw5GRbpZQ0de8UejfrBnKr/Thw98asQhWI6q+Ba?=
 =?us-ascii?Q?cp4tjXNxtGM+cfLw1TjY/wAM+sRfvXtC5KcfhzcgvnmR4vGT6VrDDDJn6iQf?=
 =?us-ascii?Q?QTe9WW+EokWCELFI3qXxOm6KNYiRDj+U3BmfFzfK6K0RcB+KER8DbL6HCBNS?=
 =?us-ascii?Q?BrovfNJv6hx+8la6YKVOeZGyXrcAYWVzU9cddun1mHuC0lZvJ6E5DMA+LpNi?=
 =?us-ascii?Q?g/PUsDxernPi5Yvf7RvfAxRZYYkMJzp+N1wqUEp/d2bJaZhhfT0aMcAtksTA?=
 =?us-ascii?Q?HId9cpmvGW60nfBlmLVzbEn5+bR2ak8N3IlIzBZwxCN5Z5cC2ehbk54qj0VF?=
 =?us-ascii?Q?lwgUL+MFs3gcbTa4iyhETNaC1al4GMP6v1+gSYqsY3b4PC5eZN9JBF4CD2Y6?=
 =?us-ascii?Q?Bem1MlVCUccDETcMxs89Cvl73uJNQh2OvAdNacjwXOU9pGTA6a8emW2eQPS6?=
 =?us-ascii?Q?jZ365qvuw+QHPsHxwoXFQNOQm9bdZc5twxQ+sbi99u98EjAueVuWPwTxZNyT?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sstEE93gqPmL2o88UtPIEQVCPcoRfEVtmq0l51QAayEPDKHqrfvla1o4S8nmYG+3M/Q2xUWzq77/cMN+YuAKSei/V7GBW+gJjtaQjNPObaS+gQFJzVAP3Fr68vvYlIl4DqF85TtrWZBQ5fmAe+pFQ38Z/rgB5agvfuR6nQsKA4oMj3RJEaPRacoMLL4dmkwxJ1LipFKXBHbh2m188LziGBp0AS3y9M6V2H5kmYU/7mc97Rj16qqEzJ451jJLok/blMHY9bhoKDdb2MJKS0c9SDqHKKcg8M8vOpkn1kDS8p7eYlXs+5wfHL3HisRLLdKc6zobr6EzbEX2iFKUrjHMHgu4xq4oLYLaajJHjhq2i6DuE4SdicONxfUJtY8aLZh6JKseSVV2ZHT8gAm6I5v4Ugb7pYecqkUVglGuAY1++GtDsUYDy/3f6CJ0tvmHtDkY6odxANXdffGOvaHr/uAZcbsDgMxYs1q9gF5AySb4wPe/F1Qk+UgJkNgBeL9Qge1MQG30oFsg5pYM+vGOuwp0nkZ9shClG5Q0eZ0/EXG9TSjm9h4SgNE//IcXiJwrGlpUtnz9hyc27bcyZZnPysdV4moXl/EpxRrlny9hdfdMQVg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12262d9c-58ee-4d5c-847e-08dceec43922
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:56:12.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHCy6GKhs0GeF2Opzb/ZzJg4zhYFXjEJi+6uS17/hiHWqQXwSfUsM5hbACFWF3c67XQsdWDvhlJZqpfDFRPqMn+dPPayg85uBOPdqYjwJiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170110
X-Proofpoint-GUID: CKrPMP9Je5zV-3ys8x0MdtOHlyGk9RzC
X-Proofpoint-ORIG-GUID: CKrPMP9Je5zV-3ys8x0MdtOHlyGk9RzC

In preparation for Kunit support within Clavis, add function redirection
for some of the static functions.  Also Add KUNIT_STATIC_STUB_REDIRECT
to a few functions that will be redirected in the future.  This should
have no functional change.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/clavis/clavis_keyring.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
index 81bfc3ed02a3..339af707b612 100644
--- a/security/clavis/clavis_keyring.c
+++ b/security/clavis/clavis_keyring.c
@@ -8,6 +8,7 @@
 #include <keys/system_keyring.h>
 #include <keys/user-type.h>
 #include <crypto/pkcs7.h>
+#include <kunit/static_stub.h>
 #include "clavis.h"
 
 static struct key *clavis_keyring;
@@ -46,6 +47,9 @@ static int pkcs7_preparse_content(void *ctx, const void *data, size_t len, size_
 	return ret;
 }
 
+int (* const pkcs7_preparse_content_fn_ptr)(void *ctx, const void *data, size_t len,
+					    size_t asn1hdrlen) = pkcs7_preparse_content;
+
 static void key_acl_free_preparse(struct key_preparsed_payload *prep)
 {
 	kfree(prep->description);
@@ -54,16 +58,24 @@ static void key_acl_free_preparse(struct key_preparsed_payload *prep)
 
 static struct key *clavis_keyring_get(void)
 {
+	KUNIT_STATIC_STUB_REDIRECT(clavis_keyring_get);
 	return clavis_keyring;
 }
 
+struct key * (* const clavis_keyring_get_fn_ptr)(void) = clavis_keyring_get;
+
 static bool clavis_acl_enforced(void)
 {
+	KUNIT_STATIC_STUB_REDIRECT(clavis_acl_enforced);
 	return clavis_enforced;
 }
 
+bool (* const clavis_acl_enforced_fn_ptr)(void) = clavis_acl_enforced;
+
 static int key_acl_preparse(struct key_preparsed_payload *prep)
 {
+	KUNIT_STATIC_STUB_REDIRECT(key_acl_preparse, prep);
+
 	/*
 	 * Only allow the description to be set via the pkcs7 data contents.
 	 * The exception to this rule is if the entry was builtin, it will have
@@ -79,6 +91,8 @@ static int key_acl_preparse(struct key_preparsed_payload *prep)
 				      prep);
 }
 
+int (* const key_acl_preparse_fn_ptr)(struct key_preparsed_payload *prep) = key_acl_preparse;
+
 static int key_acl_instantiate(struct key *key, struct key_preparsed_payload *prep)
 {
 	/*
@@ -225,6 +239,10 @@ static struct asymmetric_key_id *clavis_parse_boot_param(char *kid, struct asymm
 	return akid;
 }
 
+struct asymmetric_key_id *
+	(* const parse_boot_param_fn_ptr)(char *kid, struct asymmetric_key_id *akid,
+					  int akid_max_len) = clavis_parse_boot_param;
+
 static int __init clavis_param(char *kid)
 {
 	clavis_boot_akid = clavis_parse_boot_param(kid, &clavis_setup_akid.id,
@@ -247,6 +265,10 @@ static struct key *clavis_keyring_alloc(const char *desc, struct key_restriction
 	return keyring;
 }
 
+struct key *
+	(* const keyring_alloc_fn_ptr)(const char *desc, struct key_restriction *restriction) =
+				       clavis_keyring_alloc;
+
 static struct key_restriction *clavis_restriction_alloc(key_restrict_link_func_t check_func)
 {
 	struct key_restriction *restriction;
@@ -259,6 +281,10 @@ static struct key_restriction *clavis_restriction_alloc(key_restrict_link_func_t
 	return restriction;
 }
 
+struct key_restriction *
+	(* const restriction_alloc_fn_ptr)(key_restrict_link_func_t
+					   check_func) = clavis_restriction_alloc;
+
 static void clavis_add_acl(const char *const *skid_list, struct key *keyring)
 {
 	const char *const *acl;
@@ -284,6 +310,9 @@ static void clavis_add_acl(const char *const *skid_list, struct key *keyring)
 	}
 }
 
+void (* const clavis_add_acl_fn_ptr)(const char *const *skid_list,
+				     struct key *keyring) = clavis_add_acl;
+
 int __init clavis_keyring_init(void)
 {
 	struct key_restriction *restriction;
-- 
2.45.0


