Return-Path: <linux-efi+bounces-1984-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B59A2781
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 17:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43811C25541
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7F51DF257;
	Thu, 17 Oct 2024 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CltL2m6i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xZrqgWLV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB951DED69;
	Thu, 17 Oct 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180609; cv=fail; b=cyZmINmNDGqJlmQFO4X/kw3nWu7J/EYDXZoqe8Q3pWFaqDVVoBHnw30mrHnVOXxAGY3G4VCzVEQ42d/PemD0FNRJ09K5Z0wSWm7YLTq/gqO1z48Ck4sz9mfaPAMySKaVehNHPrqJmtJBVGL5iPhvJXgROCmIDPgcoZ44uRbAVXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180609; c=relaxed/simple;
	bh=mnqIockSMDoXhMbpzrwug+dmIAa0y/oimbOWgfHWlFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AQAB2fMQZdz/6CiGZ5GCthp3WUQGPVHaT2HEXBAxpTMxk6sQav09t5aAVbs24YsGxCIi2BpXUuWu7PA0ZUGPJGxfjSKX/LMhsMeTpcSmUcrpdwdygaYgBFimBz+9IK74tpis6JmT/YaKbhc6MlWMKKjqvUEE8KIA0x88FaXLNg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CltL2m6i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xZrqgWLV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBnU9002180;
	Thu, 17 Oct 2024 15:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AMxfp9IG1I1xk1Rm/78tvPu4e2bT8HCS8BLAhK0tzkA=; b=
	CltL2m6isN23zi82cKqdq3dN1Toh1/dKBX0GdJQf7TJgrWxbCOMm5/NiFPyW076w
	Rs65WoIsVCY6aVl1sTiu5IDsVp5p+5fIqnH/UUW+0/ChAGiMScE0ShIyUASojN/X
	N0S07T4OjghH7g+6HWxbglTok/8dYnJT2kbr2BnVkAN2MADfBjK/3zCCMA0x+eAV
	X5eymDh+K2QlvPuolt16m/Tduwv1QOTVpYbzCdLLOHkz8m76qiwrLOiPZ7lUkWqc
	KuluwxKMTyYSGVN1dRG9zBiKo+X0N1jVqkagq5Ds0jsKxAAQw7gCkGPUmBRfhiqS
	Y/tf8CVyXHCSj+XSEjoZrA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2pxey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFfHAv026407;
	Thu, 17 Oct 2024 15:56:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaej4g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3WyClCO9PlJ3u78FwzhTHLJgwafgWktYxSWR3A63I/CBQ6/CkEesr0X4GFlvNyA+luEteaisohuf4+EQIMGyLmEfjIwESJrJDoyAyvDZbAABbIdN+n2+Iy/N1eYC2I8gYJExmr2bm1QaJQGyaeEHdipGyTC20lfLbdiz/esYxgR3BPmGH/v1jmkxT/8J/axZyPHYxOxm7lnEv1nJu3KolA9iWar+sAYPzqlazWwmvMMrUX1rUiX6LZMsMQCEEOo+Ty7/nbEU6A5vW4GVvQPzUPx04s5wHHinEz+Mj3DB2zEfIFdtqxvLRPLyKwd1r235x0RuW1ksJnrba78ZTWbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMxfp9IG1I1xk1Rm/78tvPu4e2bT8HCS8BLAhK0tzkA=;
 b=LkjQcL25A/E3JJbuLc8BzLB1HQq1WV6FhIcrLVbJiVaau7UC8V0DFPEPZgQdIyf0pQcKtbl9VpgcpCD8dU6oYZbcpNLuqp1rrvl3AX/lZlD9gHnmxjVqDNwiWrSsE9WA8Ok1afiBn5OgM3G1YyMvfxDz90c+bTWZzJkxEj5pBrbw4A1ETwT7wPaRoZv1jeMduoRY1U8e4Ym1vWaj1cbX8slGLsg2s551nOMN1Pk//P1JRAqKyVTP6OPWDoMFAZRPheczg+kaL2aj9VaXvnY6xBS1hU/3kewDrtQVprqoh7QTuO9LptM271MPAbNquH6ncE6h6rAXbAcC7zLAkNeedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMxfp9IG1I1xk1Rm/78tvPu4e2bT8HCS8BLAhK0tzkA=;
 b=xZrqgWLVospiJyTYmehwYJGxyw8tTy4eajLeCYq5lajt4RQ3zyYTyIO8cW4Wf5xYuwPZ1Z5IKnp6iE5DH7OFzmqKmTLNClSUgQNAdIwkmjiPsUalSITTTUZq97mTG590QJlQlbGf/D4k8ci8Bp5+L/LVVGx/8E0Prvtc+GkFgDg=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 15:56:08 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 15:56:08 +0000
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
Subject: [RFC PATCH v3 10/13] efi: Make clavis boot param persist across kexec
Date: Thu, 17 Oct 2024 09:55:13 -0600
Message-ID: <20241017155516.2582369-11-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::22) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: bbaaf9b8-61e8-4be8-4e53-08dceec43702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mFIJ6Z8WiiPL3934Xasz3rFafI04PlI3jfc9mrlBhIusSujer/tkudcQ+FnO?=
 =?us-ascii?Q?5sYKBXeIkLntnJ3RMyg9leuRc5kQggfN1V6xnuN4juQCqepGaDsx5059ocVe?=
 =?us-ascii?Q?jXdCCdTtxVrwFoAaLz3vAo185VV/e+8SKTX0/2tqDqoxpbFxLyUASOxDvjGy?=
 =?us-ascii?Q?Krijcy9GC1kYS+3G+CL9cytYiY8OyV6X783pVUmQyHQYBlfuKUCFJZxG+Yjc?=
 =?us-ascii?Q?qgy/yyvUkVoKPKkkKjI7xSL3DCLUeuvAbfaEJfJFnyGmgWTDNeRIZzwcwkDT?=
 =?us-ascii?Q?iYLHKUvPnW26oZnrwPI2F/8VmHBX0fhX+bS1bO/unl1wVYH+qYHXvyRKMgQw?=
 =?us-ascii?Q?XuIhNQZwxL9zGzHSwEj50LqNw2XEJcFZV+55e1uIG2mplhGia1Z4UK3cUKj8?=
 =?us-ascii?Q?Ta1vwDzM7bkkx6Gz/cUXtHIkbExNsOpfpQeyqTXKeRYmmUMy3wSrCzfg3TAo?=
 =?us-ascii?Q?+56bYdAjqtGkDgLB03+ZIUV15L0GiEesh/Gq892OREzDe1YDw4RZTco5y82t?=
 =?us-ascii?Q?mo1QmZB064vjXJEzg4M1D1N7MCuwi1YcBwnIOLYn0gD2lklyvj0//1RlGxOV?=
 =?us-ascii?Q?P21Xe8FG5msnFM9qQemj3SKPkfISRDKsiY7ypt81xOh2GTS/XByUZGhk7S56?=
 =?us-ascii?Q?/FoTIdDZkp/HamnCtrcKpA8ninX53P6IDwArpX4D2wYSjLYn51VK9FQ864xD?=
 =?us-ascii?Q?FWUXWyLtWmMhU9BNCtBrK0j550bp/hEIyNDHHY21VwZxITlLX+1aeIG4+sb+?=
 =?us-ascii?Q?qFeKP7MglqmdPpvC6i+FnXQlchwBvSf7YJ99eA3QNZqnJHYvWQCcAZJI5ILE?=
 =?us-ascii?Q?DvTc1HBS5j3F+t2ejUVQdibGGaG7uTL0MFomHCEYgU8SoQL42O4PHIz9dDCW?=
 =?us-ascii?Q?PG6A+UbJsvjbsacfi6EVwWV7UWM1VJRvmfji/dg7Mh57sUdxKPxbWwAo7QSC?=
 =?us-ascii?Q?aatdXJ22E9yhoUGWQMj80lE45gGUTTu13eWzNNln8cF4r1O0aIqf7o770h1y?=
 =?us-ascii?Q?Go7bsKX1YLO1hctHhANj9GoRHqsJlNB0CnyZsE0mwYJjv+A5Y5zYucVgj09m?=
 =?us-ascii?Q?zXhSfEBtfr2bS386NvYRNhc8GU1hT/KEpTCMchJiyZhaR+HoYDwrVzlI/7f6?=
 =?us-ascii?Q?8LGVAV8MF0vfmoLe/PyqPw4Fa5OVfSWmMVm9KaS4iY2Z1+btq6GRKj4lnhDs?=
 =?us-ascii?Q?5L5VfzGa1d5IQR7siYtUCf18N00nJg0HRJOU6cmOsrDZ2YvGt9XLJambKhrO?=
 =?us-ascii?Q?O2NEnXtVtnRSWinTktPPmj2hS/NxCqAjLopz6bAjdHKT2zpTsMv5ZPJdIE5c?=
 =?us-ascii?Q?VVaHFkOsJx3w5A10n0yCY/lm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mic/G0WeqAv6Bw6Dh5iutDSYsdGI2O+6ijbi07XjjGStOoRzVsWHBhkNRfQP?=
 =?us-ascii?Q?Z7EwG1Dus9C3EgAcXo+AMQ5LFLvSoPWNHFJXvAGqC/KZ32fvtSIzAJAJRTZK?=
 =?us-ascii?Q?3IdGYFb6xajQ4lFG1HUH9iscF4bgDtZSRKan8usi4Ji6UhOTOh6VAlCA9tr2?=
 =?us-ascii?Q?cUBqx3KQjsQu4Gl2owXFttb2poVVpV/AGWfMzD4W/gn+Wr//rpCiCUZbWj0P?=
 =?us-ascii?Q?FSMWO2A13I2FHkALSbPFSyaTm9Zid6aOyBafZ/ZIW0lflOBNmdO6fcp4Pfrk?=
 =?us-ascii?Q?v7EmLnojk0ADJYhtc8Vk9yrROXJl3znqfqkIA/qsLUBLvpa77jMB+8+2Pd5H?=
 =?us-ascii?Q?XO9P5YHADUCCVdfEeRSx72VEpuwXwX847WuXpbnjCFf9iTGVE+RwABvuMkLu?=
 =?us-ascii?Q?mZfRpPmvFpzKnCgydwdtyKsC7Ef/GCWjWu3FHRo9LnLsldMHCWfbFoPK2Hw7?=
 =?us-ascii?Q?jhmNDKS7wYx41Bpthp/PX0EURNPSYzP1t9I+50ZCl67B3KuG5nP27YyqfxB/?=
 =?us-ascii?Q?LIH3sz4B4sTXsgxrgAZGDLqWcn/oerOChGCXuu57ZJ2br7pWRsILQUgsZD4C?=
 =?us-ascii?Q?8QCd/ApUorKcPOL6ktKn3cP/z6EQoGg4jdL+vImZms1bsWwvgkVKjzL8NwSS?=
 =?us-ascii?Q?GA2pbvy8a2I15fOpy6UTnOy2NUFKmOGkBhN5TJFaPNeHEGqok662KNVFRMJT?=
 =?us-ascii?Q?47iSnqiet0Wy87zabLx7lLqikjth26aHmP9S+uYKoohibAS0PdNrdqcG39hN?=
 =?us-ascii?Q?cFI6aM7+G7ydkqa4xCGqBNMZI0avIVyHwaRNYkG1PrAqZm8hX7EWuLMm4XO+?=
 =?us-ascii?Q?ACbslOp5WCORWebGKUvNytvuBk716Jl9BWB4lE6PKuwZ22b5TNJuYktRo8x+?=
 =?us-ascii?Q?eTQsbEPorxPhIHdN7tlPbWTPgDCimW/xsGM3Hpqg2ifJ0MiXhszC0hqMTUGG?=
 =?us-ascii?Q?J6+Xfd21q2NGyPfAyCuQASmI5Wqe4DaGGbpqt5keF3MpWlLMBeTuliNOqq45?=
 =?us-ascii?Q?qrfIW/NZbYzHxK9K2sAm4sI8DHWPE2yVPjdiMD2MiqY13TSQb6Kl8LuOv1cw?=
 =?us-ascii?Q?kREvO6pOvIHxRV+O3m5sFeA6lxJeyc/FblvynL9GC9miOMxbDZGWvMTlty/+?=
 =?us-ascii?Q?tWgilvDXn/xMje54Fa2rvfTgv1rS4xWb28cwdESffwBqvZ1bZEdwqp+eKDSa?=
 =?us-ascii?Q?lwd1DvL9Co56usAO6JEsyRgrdyOjDSIljfPE5I0IOVEYnhRUN32/PKMnFEM3?=
 =?us-ascii?Q?vj5XJUnqpsgwixLPXSnKQnAi0d0OYL1jM3aljG+6CybZ8gFvAEseEzAx+W+Z?=
 =?us-ascii?Q?RrqRqesJmeQDA7vQvQAv/oaOUfzCaG9N5ERNfYy+LMHjYSjY+5q/FheXids5?=
 =?us-ascii?Q?qCUGyEa7zBlGsmJpzC5nz9HtHeIYvUwRr+xBGkApCugFDkZDE9lkzAnho8Sq?=
 =?us-ascii?Q?LmJL39jd+19qwcONO1CW/cJtE0o7KlB9/dagYQ4Ba/ZjkobFM95vsCogdZK6?=
 =?us-ascii?Q?mCRhZ3sufIqZtbRrQ+Q3XtcJnTiN1zEYglagxWMem7tNRF1EEFtz8dVCpMeM?=
 =?us-ascii?Q?3aQBfFzFm0LzMHWIDTS4G8YwLa4AXFwkHfJh98bfNAHrPIJ57G5Fpu/hiOEI?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LLckYKQC7ERRet/JH/K0LiccnxybR7c7eIU03sqUMlZRcG5rF5cJMSV53Grtp91NfZQDF49nw1B5CCz5thr+qmXNJXCTUKt6vIfI6myLwdl7o5+nv62rk+0p1L8lW1zQy/KkyZwaA6TZoA+Fy94a2d//u+lSB00Cdy0ZGQYx1fdQ8doqM0mflINgSzHlF/mROQ0BESWJLqeKpsSYZ/hSoZDmsLl2ddyDbcgoUslqiPMH0GrH06MwqS6LClJHSGod/5sS+Kdg2EA6vXTihnQlWErxT75TsCxwQtBJ20ZgCB7Kx+IW5xnV292G6FoFQjQkQ75eAV+w+ievFVlSKkj8ND9jeV+Ibl45QB9IBLkkRt3XcXptHePLLro72Iv2weKozivd+MjVhofMZVUG5vuFTZYTalhKlqoXRmDyYBLnRgiNwtb22/+oZBofIrvfL2k6AX8MxsTlbKFXD+HyTJznN966GhESADhZtcafmuZGiEeEtb2wyk/TqJjGuF0FGscufOHF+vhSth7P1/PgnPoqDoTvTgEzcuaAcw42AcvTsAba3JbJb1RNg0e8yAGsSAWjRGB+mjmgj35RvMbWqV3V7fCo4RwV1JHECC3jBNrdOM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaaf9b8-61e8-4be8-4e53-08dceec43702
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:56:08.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QjTKbpGXY/el6NZkMDj+lSy0duF1yG9CGqSOUbCqLj1bDmjGGiyJm5PSrZvCiGWqkLAiki5dbg+ghDa7fNswBQ+7ArxV6cMJKEmTdRFVCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-GUID: dft_VKIB8sPRI9Ng7Q83w5RfjJ2yswtH
X-Proofpoint-ORIG-GUID: dft_VKIB8sPRI9Ng7Q83w5RfjJ2yswtH

Add the ability for the clavis boot param to persist across kexec.  This is
done by creating a RT variable before ExitBootServices is called. The new
variable is called Clavis with a new GUID
193ccef6-348b-4f1f-a81b-0ea4b899dbf2.  This variable does not have NVRAM
set, signifying it was created during the Boot Services phase.  This
variable will persist across a kexec, however it will not persist across
a power on reset.  This same type of functionality is currently used
within EFI shim to mirror MOK variables into the kernel.  It is being used
here so the clavis boot param can not be changed via kexec.  If a different
clavis boot param is used, the one stored in the RT variable will be used
instead. Enforcement of which boot param to use will be done in a follow
on patch.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 drivers/firmware/efi/Kconfig                  | 12 +++++++
 drivers/firmware/efi/libstub/Makefile         |  1 +
 drivers/firmware/efi/libstub/clavis.c         | 33 +++++++++++++++++++
 .../firmware/efi/libstub/efi-stub-helper.c    |  2 ++
 drivers/firmware/efi/libstub/efi-stub.c       |  2 ++
 drivers/firmware/efi/libstub/efistub.h        |  8 +++++
 drivers/firmware/efi/libstub/x86-stub.c       |  2 ++
 include/linux/efi.h                           |  1 +
 8 files changed, 61 insertions(+)
 create mode 100644 drivers/firmware/efi/libstub/clavis.c

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 72f2537d90ca..8dcb5326d05d 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -186,6 +186,18 @@ config RESET_ATTACK_MITIGATION
 	  have been evicted, since otherwise it will trigger even on clean
 	  reboots.
 
+config EARLY_CLAVIS
+	bool "Early clavis"
+	depends on EFI_STUB
+	help
+	  Allow the clavis boot param to persist across kexec. This will create a
+	  variable called Clavis with a 193ccef6-348b-4f1f-a81b-0ea4b899dbf2 GUID.
+	  This variable does not have NVRAM set, signifying it was created during
+	  the Boot Services phase.  This variable will persist across a kexec,
+	  however it will not persist across a power on reset. During kexec, if
+	  a different clavis boot param is used, the one stored in the RT variable
+	  will be used instead.
+
 config EFI_RCI2_TABLE
 	bool "EFI Runtime Configuration Interface Table Version 2 Support"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ed4e8ddbe76a..b5243543ccc9 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -86,6 +86,7 @@ lib-$(CONFIG_X86)		+= x86-stub.o smbios.o
 lib-$(CONFIG_X86_64)		+= x86-5lvl.o
 lib-$(CONFIG_RISCV)		+= kaslr.o riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
+lib-$(CONFIG_EARLY_CLAVIS)	+= clavis.o
 
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
diff --git a/drivers/firmware/efi/libstub/clavis.c b/drivers/firmware/efi/libstub/clavis.c
new file mode 100644
index 000000000000..3a715e87a13a
--- /dev/null
+++ b/drivers/firmware/efi/libstub/clavis.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include "efistub.h"
+
+#define MAX_PARAM_LENGTH 64
+static const efi_char16_t clavis_param_name[] = L"Clavis";
+static const efi_guid_t clavis_guid = LINUX_EFI_CLAVIS_GUID;
+static unsigned char param_data[MAX_PARAM_LENGTH];
+static size_t param_len;
+
+void efi_parse_clavis(char *option)
+{
+	if (!option)
+		return;
+
+	param_len = strnlen(option, MAX_PARAM_LENGTH);
+	memcpy(param_data, option, param_len);
+}
+
+void efi_setup_clavis(void)
+{
+	efi_status_t error;
+
+	if (param_len) {
+		error = set_efi_var(clavis_param_name, &clavis_guid,
+				    EFI_VARIABLE_BOOTSERVICE_ACCESS | EFI_VARIABLE_RUNTIME_ACCESS,
+				    param_len, &param_data);
+	}
+
+	if (error)
+		efi_err("Failed to set Clavis\n");
+}
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index de659f6a815f..3c45eaec325d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -100,6 +100,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 		} else if (!strcmp(param, "video") &&
 			   val && strstarts(val, "efifb:")) {
 			efi_parse_option_graphics(val + strlen("efifb:"));
+		} else if (!strcmp(param, "clavis") && val) {
+			efi_parse_clavis(val);
 		}
 	}
 	efi_bs_call(free_pool, buf);
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 958a680e0660..c15cd0d9e71f 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -183,6 +183,8 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 
 	install_memreserve_table();
 
+	efi_setup_clavis();
+
 	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
 
 	free_screen_info(si);
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 685098f9626f..ddd51d7f19c3 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1142,6 +1142,14 @@ static inline void
 efi_enable_reset_attack_mitigation(void) { }
 #endif
 
+#ifdef CONFIG_EARLY_CLAVIS
+void efi_parse_clavis(char *option);
+void efi_setup_clavis(void);
+#else
+static inline void efi_parse_clavis(char *option) { }
+static inline void efi_setup_clavis(void) { }
+#endif
+
 void efi_retrieve_eventlog(void);
 
 struct screen_info *alloc_screen_info(void);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f8e465da344d..facec319d978 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -1044,6 +1044,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	setup_unaccepted_memory();
 
+	efi_setup_clavis();
+
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("exit_boot() failed!\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e28d88066033..a6ab5d30d25c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -423,6 +423,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
 
 #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
+#define LINUX_EFI_CLAVIS_GUID			EFI_GUID(0x193ccef6, 0x348b, 0x4f1f,  0xa8, 0x1b, 0x0e, 0xa4, 0xb8, 0x99, 0xdb, 0xf2)
 
 /*
  * This GUID may be installed onto the kernel image's handle as a NULL protocol
-- 
2.45.0


