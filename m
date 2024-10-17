Return-Path: <linux-efi+bounces-1994-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5579A27BC
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B6C282074
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA84E1E0B8B;
	Thu, 17 Oct 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q23XjGH1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aQwiLrsD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0FA1E0B79;
	Thu, 17 Oct 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180628; cv=fail; b=dX2I59uXEjx0Z7Br8ndmwlNZMT4GLmZPcIhtT+TvhOGEnS1l9mP5lPT4ABVIOhhK0UWz/CcIihQd0N1fzK/SheXIHxy5FuIhPAJJht67xuhD95GAhVpjcXdt8EFV1m6AW3yrQaAelBQ83RiOTB6w86FaWhzLY0aF7okH0uCm1Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180628; c=relaxed/simple;
	bh=28SZ5XgUtxi+bc1YMbAuMWMIoej/4EJyKPRGvq5UErw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ug5tZri3jRO1kd0iHoDgEQrDOPoGJxYXRKWgxdax+CEp0F6xkL2xX61TOLHCCSIvcNwCpn1MolJb35Wb9AfRDUZOeFmd7KVP7FR7R64OGolZS1a/dy0nU97DGfc8hWUXoCJGAZymalagIzqu1qAQdpFgQeHxc6qzKFf1HEZtZuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q23XjGH1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aQwiLrsD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBoBV019266;
	Thu, 17 Oct 2024 15:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pXiM+Ccq+NHIgqOcJ0rb3Wky7q54msjhNytuLnm/Yq4=; b=
	Q23XjGH1y5fjUKqZf2ynS8bI053+id7Pg5ls8RplGlWscKVvl3LrOiFCvGwnfVs1
	1DCGpF8ogumgNtgsoWJ1urylikzNbVwZ1QljTVgaFk18gUvrNchWw1qCFLFogfZl
	tEF9xgE6SaEgtItjcMiiLeebYRdxUuMepTV5APrRVxIq8ux2sXu0p+DqK9It1b9X
	F6UUnm+jXG6ZvwTGOUm+SLeVvdiXozHNeI17d8lB/p87ix7mOdANeoIyKZEYn7np
	e2VZ0H63RyJlPwYj+xldaKcTN9iyoeUQ3n7VZ+JNUZF2CzybySIazKsmhS26gPuY
	Z+m9dz8SEy3UeCEZfOyfNw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cq6qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFPSY9026291;
	Thu, 17 Oct 2024 15:56:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaej31-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejO85wMIXtr6rFO0x/q6FEReNHoAUUO6oaLF602B+w8Kup+xEGmViSiRuLG151TTyCYf6WSog2m/0ZV0a2i5OpW0iJS0zFM99vkkKtJlcx5VgYBLB/wiKyRJOf96hTKrX4m//6mid43jBhMFTqZb70fNnEqFUUZaiUR0EjkxEC6nHRH4JHpQcC++Z8uEn/gZjCW7RRdMuHAWr0wpJGhqF2OxY9M4KQlR1yfGp3k0g2C+uW5Sknwsmb8ttUUgxl2WpVh5QVTHeZW7fqglrrGitoxaSdXGvhjP2lzm8r9G23wNqMp/7rJIaAMImtBOhxLmkxJONavjiVV5iJkcR5dP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXiM+Ccq+NHIgqOcJ0rb3Wky7q54msjhNytuLnm/Yq4=;
 b=IE8k9mBMShnS2hzhGN55iHPTUvHEk3usHDkj0ndrFAlObVThOSMBqtj2p5ChAdEBdy3BUBX2V9XEu8aVJ58jpgpqmMlXx0BmPu7RZpB51v1M9WHCBtIVJTFeqBvosslilvibXs6lpadkNcPF4Mp1dLt6IWkQ8NGrBNWZ4tU7wY6XI2QnQMtMOTS1iZ8S24S3tChUnA4yCaTtxVNf0K96MWCe9CSlXPiRXVQRtIvaFd8sE+wUj9cL7YUnx8EYz/E8qEuzSdy1rmVm55k/t5oBYdU5yt8zahsuNdj3yjnJPP7JmJyi9JlhyKyvPfoRuRou3ypti3Wdz1FhWxgThL5wgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXiM+Ccq+NHIgqOcJ0rb3Wky7q54msjhNytuLnm/Yq4=;
 b=aQwiLrsDu7argw5trJzW2ymKHwtWfXrzsPTCiDgbl5ty+MX/umGI/JyVbgemWis+MMzSZzWtD7UCbXya1X/8CCPJlZpitjX+0bhgrF4YIh9CJNDOBvqiag9elHZGtsOdRC2alIpQ7hEWfiAVA/FJLX8uafFLZb86R6eJftMOv50=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by LV8PR10MB7967.namprd10.prod.outlook.com (2603:10b6:408:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 17 Oct
 2024 15:56:04 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 15:56:04 +0000
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
Subject: [RFC PATCH v3 08/13] clavis: Introduce new LSM called clavis
Date: Thu, 17 Oct 2024 09:55:11 -0600
Message-ID: <20241017155516.2582369-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:408:eb::27) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|LV8PR10MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a19b1d-08d5-467d-dcbd-08dceec43395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xKfc43i9q6SaPAiSZYIOIsflpgH44fTxaDYBvlQVqOaC8cDpfqkRScF20s+K?=
 =?us-ascii?Q?4Z880Bc4D1Q40gNst5Q+H6VAAi5R4xaQZjTlBgiHhPdR3joO3s9d/+bjZH/q?=
 =?us-ascii?Q?aC1tJkIEKUeGmaBBF0oZUUVb2f6i8QvAXLtLtWMJcSbwvHRMZI7LrSbaizVX?=
 =?us-ascii?Q?ngTGeJe7yLfHSXLaRyb/ftT2bfmgfgcCHRWzZNDiXSC7rYo/mB5L1hWz528S?=
 =?us-ascii?Q?fyvtXj94KQBYSpR/VZtoOdfslrQXMV+R77JVtRioGu8VBoqeKYIisJM6CA1a?=
 =?us-ascii?Q?GwF36XP5+Ei88w0ejKeSHZb27cLiURBe8QlGEzyYSjsn2Qxh6fKRYPru3nSX?=
 =?us-ascii?Q?mxpnMVQgAE5Memvx/HgF0Rk800eaqNNwjXShS7gId+MeiditlFVNDuPq9CPD?=
 =?us-ascii?Q?6pRFKd1SRUzpCnqNdV9qfMNPemdYBwdBZwlRvE4b/Xk1o18JwWb5H0V5+5OZ?=
 =?us-ascii?Q?WB+tSLhYjMJmUqNConAaeN94ufiusLtXjdWkPfqgK7nrjolhLyQsYXTZkSwp?=
 =?us-ascii?Q?Eykd3JnOrTYcwKLCqg26p669NJjtHwhagbbPMvtCbjxLjaqL6+HEUODaIhzk?=
 =?us-ascii?Q?dVN6j9jr4e5T65p10/zMTu/rLnxdjQs3kvgppmYcS9qQiO7pm2B6rU9KJal6?=
 =?us-ascii?Q?JV0yeSLC7tKdPSGjAt2XE4T+R7He/JKgQBbUlZdu5PvwkuMBDhR37Rwj7f6b?=
 =?us-ascii?Q?JKz6dZ3YRNbPqciA54/T89VsrQ1KkLxiK62x+oJ2c1aZ4LqUuhDIps4AWKLI?=
 =?us-ascii?Q?bWYjpiQ9ritcDNov6cN7DjEK7YRVVuqEZMs0HzEdVqDP5gRmI06IhjYxc8Gx?=
 =?us-ascii?Q?BLQuGNhDYihs5TGR4vZNrV1uzUya03RGqXCbYXbXKHRUGnNpifPjHj3ELf8E?=
 =?us-ascii?Q?//o6dwgqoOQP0AJYrzG81qCQs+CXvMqIh7BTN6lMGZjPwo7g+Hp0WuW0R7p6?=
 =?us-ascii?Q?CWcvHCTi9fdrkL1zpYmZbRwl5r0tY9TCOrUKUPkzMgFyR0Lw5ssII3SR806Y?=
 =?us-ascii?Q?9NLLj0CtJdvhwO9gXYz4esd6FFV8NqvuMBfKt2oXXi50GPr0aD/1K++rehL2?=
 =?us-ascii?Q?bTynZK/RfsxJ8/yD3q5fgrK3ERQnRFzwU07hv1zEgxzfItQ2rT3y70gw0H+f?=
 =?us-ascii?Q?2pjxItD+3LSjrYa6W09D+qpvT2tgmgg1d/FYIzxqnTE3BfXu46y0qK7Jeeoi?=
 =?us-ascii?Q?u6Bd8hsZ0uQvm3JGWBqaI6+ARV9kBzKeIqoYbay92rrXBp2v1fZGhStA3VZA?=
 =?us-ascii?Q?rIz7cIzrdBGSRaspHAzuO8CheGOm5Jx/DjOaFJN+H8lNgmy/l+EftQmB9h6k?=
 =?us-ascii?Q?bpSQYxYTr0Y22tEO4DjLfDGk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iOQLWr1X1/MiybRMQRaMAg3yqIt3/G4tI+y8rSMvKy3sxshGuSopOXSowS5T?=
 =?us-ascii?Q?CaplAFy5UU8XdFiPklEFpD1RZgJxLU+PgDJchgooV3vOTB0lxcsXKcihlL6p?=
 =?us-ascii?Q?2IunVH4ei/VFb9xALSXY7TLxXfCvU9sEtkMz93rvaxDLJd7uSDq+CyKatfoZ?=
 =?us-ascii?Q?+tWSC9X9/l77Q5GUgmR2FM4OZZa0i2IebF9g5fyFelLpcJXQ0tM1xqv6/eDf?=
 =?us-ascii?Q?5JgRDq3gAISL6LyXXWg8cfldssJ22Mxtc+S+7i9VCJkUVZ0VrWV+Uo63MX2X?=
 =?us-ascii?Q?GGSfxRRJJUPe43wPJwbtX56YYg6DHKo66jjEjQAAg6lAJ5DOPztxwlLMBm11?=
 =?us-ascii?Q?LqbUpvg94g4LJ96HUBGL1eTqfJkiBjEaf4OP2ikdXuparSyWJH6rERaNgmXJ?=
 =?us-ascii?Q?dKRnnlCXBKMg/Cq9bg37z0NtkhZzeRWH1beyob+4Hhc1ObdD24SIwg/RQZsx?=
 =?us-ascii?Q?cW71oXpHWGqlQ4g94NBYseB3aC4xMVmyr1ttrvPDSJBUNZoPBeZoRL8uKxL6?=
 =?us-ascii?Q?6XBtu0QUXWKqGSmEN+Z2PvCNBaeB23K9wV/q9nNIdJBsLd9QuDGjM4NIA3hl?=
 =?us-ascii?Q?VU9oicMGoKwWj0RQeoBCKrG6DfFpbLrPf1MKCpq9bKsX5A1dfXVytyZ9NTQ6?=
 =?us-ascii?Q?ITw0Y4KXavff5c9iw5EQK6jqh1MHqnqnqFra1LClyUIBx0FO6fEkmrjIdAIN?=
 =?us-ascii?Q?URck55VUopascHlGlZoSbubbEmCfl3ZkyGtRKE4p/jcCFm5zUhAgZin/QY+q?=
 =?us-ascii?Q?qk0xjA9Z4dty0U+JHTtGJn4UpCVpP3g7N0m6z7kYAQB20iho4esJIieavpuS?=
 =?us-ascii?Q?U+Qe7HLO3eC47tekFeerLc4Fntf+hhY61DdGGVge0rKoMFSfWPm+kBdR00Bl?=
 =?us-ascii?Q?SWM5yxla3VNCw6VeySQOWD7ld8Ohr3/3XDeKtwcFA8/WHCcXqW+7A/vO+5o+?=
 =?us-ascii?Q?+pN+VMutVmBGDW/Z9Rq6CTvfHmcRK5ToH0rHrrL3Mp3Wq6CVHC58b83mwZbw?=
 =?us-ascii?Q?ywBNwtyLvS90X8sHQ75SvSoiX8Zrk1q9UjtOYshoG8njy67tpk6+4jREM/QX?=
 =?us-ascii?Q?Tv0gUfBs525+CbeOecr6gmXK/ja36GdZxVMi3Z+GUY0F4XGb7x/4Q7wzsbWJ?=
 =?us-ascii?Q?et6fEfXGG5RTVOjhNo4drtj/8FlCPjrS7lKh8XGhY7ASu9AV58b07AXuV1jy?=
 =?us-ascii?Q?QNTcrQNyQLY6rwM5igzYnFv6brjR4cFDoD2LY/829xrsTBnXK/CPuCWrm/X6?=
 =?us-ascii?Q?4o3ZcYlWUn5JfOZHQCBLhvNHKSrm7tCJ5cSuyLknpmZbBxBkdAjSplE+3hwG?=
 =?us-ascii?Q?biy1RPRdCVlcYGZfvx2NOUM4MDdNGyyk9bc7TYxny5YPJDChU0RIukJgSY46?=
 =?us-ascii?Q?N6jD61A8PG9DZHPdeaUCf4GHKSUeCq0mfZc+SO1FWik4htLlJ5rSTN3qnOf8?=
 =?us-ascii?Q?Kf70mPhg3lmQ67Ha/mvIbbCAcE6n5CAZHUk09rQLe5nsYSErTkBT5/nsREc8?=
 =?us-ascii?Q?3Z6/Wt4BQuEs55iXWGtBPT9DgnUif4rXOm6hThy05XaKkfdY2D4L8ecQXuZ0?=
 =?us-ascii?Q?jioQIEgBTfBq0Rvbsi1r25IKF5rXHmfVE8EdmjC/nI9DOkRezdyFQNn44NR0?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	atFGOedyH8ZGfKNAOfsPu+98D8aTkCnZL2ogtGAf14sXer2qqCAWyCE85FN7zc8WKTjeYsgGXvqYgRIDNyAqMlQx2qFc3ZSLtzIkQQcmFZAzOTV383mzeqMWqFx+txGwu2yMQIXZdNOM9ufk0kSeMkSI2EhE0DKLuLd8qQ0SmbY0U2wgWzAQP6/p2yp3WtdqM27Iqb8it5OZ1etD5iUqwCD6FsR1H0RIl6VOM8FslS2DDwNcO3I/cLtTW+vWH1Yl2UALuVZvB/hJC/O1z1DM6vDc4RDSPzMO1xoZCT5Gl3Sutaq89hefu3cvYYClSGkkX3e4dwd7zpQSetQkTSRfPEeC430oJybs9iD1wcwAy63RGzj5HJSi8+Rj93PsBqZCIekZevbUwvgkT1kGP3sQht5IcmPitDB1BuagNj6NsUabG1cqoZx2bvprkTtpeIrviCDfwdrizDP0adf1Exxr1tW2N6kWYdFzUZ5sZX7DuqtSEBT8zqCt2s5FDuX8WIhWVVv60WPnJyAIghkjc8crxNoVoTxq3Jck77/MAILLdv0e5n9bNPd/oNN2gOKVjcXapXwJ8Vaz/FjbvUuDmJqc+M3P1Mjb7pvUVv/WDbGMbPI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a19b1d-08d5-467d-dcbd-08dceec43395
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:56:02.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hF8Bm0PQV33ZMJIde4G85IGcdNJyli/T5GIbkEedTSwSdL24SW68ECKvTxxTGAoju2/uprsQB/Yu0DzKXqHlmA8GtlvlAcyar206fIy/zt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-ORIG-GUID: E9AZ1f-OrqX8ly01Nc-sE0ZnkudhiwaS
X-Proofpoint-GUID: E9AZ1f-OrqX8ly01Nc-sE0ZnkudhiwaS

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
Until an entry is added to the .clavis keyring, no other system key may
be used for any other purpose.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 Documentation/admin-guide/LSM/clavis.rst      | 191 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 crypto/asymmetric_keys/signature.c            |   4 +
 include/linux/lsm_count.h                     |   8 +-
 include/linux/lsm_hook_defs.h                 |   2 +
 include/linux/security.h                      |   7 +
 include/uapi/linux/lsm.h                      |   1 +
 security/Kconfig                              |  10 +-
 security/clavis/Makefile                      |   1 +
 security/clavis/clavis.c                      |  26 +++
 security/clavis/clavis.h                      |   4 +
 security/clavis/clavis_keyring.c              |  78 ++++++-
 security/security.c                           |  13 ++
 .../selftests/lsm/lsm_list_modules_test.c     |   3 +
 14 files changed, 346 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/clavis.rst
 create mode 100644 security/clavis/clavis.c

diff --git a/Documentation/admin-guide/LSM/clavis.rst b/Documentation/admin-guide/LSM/clavis.rst
new file mode 100644
index 000000000000..0e924f638a86
--- /dev/null
+++ b/Documentation/admin-guide/LSM/clavis.rst
@@ -0,0 +1,191 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======
+Clavis
+======
+
+Clavis is a Linux Security Module that provides mandatory access control to
+system kernel keys (i.e. builtin, secondary, machine and platform). These
+restrictions will prohibit keys from being used for validation. Upon boot, the
+Clavis LSM is provided a key id as a boot parameter.  This single key is then
+used as the root of trust for any access control modifications made going
+forward. Access control updates must be signed and validated by this key.
+
+Clavis has its own keyring.  All ACL updates are applied through this keyring.
+The update must be signed by the single root of trust key.
+
+When enabled, all system keys are prohibited from being used until an ACL is
+added for them.
+
+On UEFI platforms, the root of trust key shall survive a kexec. Trying to
+defeat or change it from the command line is not allowed.  The original boot
+parameter is stored in UEFI and will always be referenced following a kexec.
+
+The Clavis LSM contains a system keyring call .clavis.  It contains a single
+asymmetric key that is used to validate anything added to it.  This key can
+be added during boot and must be a preexisting system kernel key.  If the
+``clavis=`` boot parameter is not used, any asymmetric key the user owns
+can be added to enable the LSM.
+
+The only user space components are OpenSSL and the keyctl utility. A new
+key type call ``clavis_key_acl`` is used for ACL updates. Any number of signed
+``clavis_key_acl`` entries may be added to the .clavis keyring. The
+``clavis_key_acl`` contains the subject key identifier along with the allowed
+usage type for the key.
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
+indicates the key was added by the system owner. For kernels booted through
+shim, a first-stage UEFI boot loader, a key may be added to the machine keyring
+by doing:
+
+.. code-block:: bash
+
+  mokutil --import ./clavis-lsm.x509
+
+and then rebooting and enrolling the key through MokManager.
+
+How to enable the Clavis LSM
+----------------------------
+
+Add the key id to the ``clavis=`` boot parameter.  With the example above the
+key id is the subject key identifier: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
+
+Add the following boot parameter:
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
+The original ``clavis=`` boot parameter will persist across any kexec. Changing it or
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
+To update the .clavis kerying ACL list, first create a file containing the
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
index 7ad507f49324..748ba3f1143e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5567,6 +5567,13 @@ F:	scripts/Makefile.clang
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
diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
index 16eb49761b25..146aba3993d9 100644
--- a/include/linux/lsm_count.h
+++ b/include/linux/lsm_count.h
@@ -102,6 +102,11 @@
 #define IPE_ENABLED
 #endif
 
+#if IS_ENABLED(CONFIG_SECURITY_CLAVIS)
+#define CLAVIS_ENABLED 1,
+#else
+#define CLAVIS_ENABLED
+#endif
 /*
  *  There is a trailing comma that we need to be accounted for. This is done by
  *  using a skipped argument in __COUNT_LSMS
@@ -124,7 +129,8 @@
 		LANDLOCK_ENABLED	\
 		IMA_ENABLED		\
 		EVM_ENABLED		\
-		IPE_ENABLED)
+		IPE_ENABLED		\
+		CLAVIS_ENABLED)
 
 #else
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9eca013aa5e1..a405122a4657 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -410,6 +410,8 @@ LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
 LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
 	 struct key *key, const void *payload, size_t payload_len,
 	 unsigned long flags, bool create)
+LSM_HOOK(int, 0, key_verify_signature, const struct key *key,
+	 const struct public_key_signature *sig)
 #endif /* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
diff --git a/include/linux/security.h b/include/linux/security.h
index 2ec8f3014757..4439be172a51 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -63,6 +63,7 @@ enum fs_value_type;
 struct watch;
 struct watch_notification;
 struct lsm_ctx;
+struct public_key_signature;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -2053,6 +2054,7 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
 					const void *payload, size_t payload_len,
 					unsigned long flags, bool create);
 
+int security_key_verify_signature(const struct key *key, const struct public_key_signature *sig);
 #else
 
 static inline int security_key_alloc(struct key *key,
@@ -2087,6 +2089,11 @@ static inline void security_key_post_create_or_update(struct key *keyring,
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
index 938593dfd5da..a2ef13c71143 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -65,6 +65,7 @@ struct lsm_ctx {
 #define LSM_ID_IMA		111
 #define LSM_ID_EVM		112
 #define LSM_ID_IPE		113
+#define LSM_ID_CLAVIS		114
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/Kconfig b/security/Kconfig
index 714ec08dda96..90355ddec5c0 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -265,11 +265,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,ipe,bpf" if DEFAULT_SECURITY_SMACK
-	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,ipe,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,ipe,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "landlock,lockdown,yama,loadpin,safesetid,ipe,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,ipe,bpf"
+	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,ipe,bpf,clavis" if DEFAULT_SECURITY_SMACK
+	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,ipe,bpf,clavis" if DEFAULT_SECURITY_APPARMOR
+	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,ipe,bpf,clavis" if DEFAULT_SECURITY_TOMOYO
+	default "landlock,lockdown,yama,loadpin,safesetid,ipe,bpf,clavis" if DEFAULT_SECURITY_DAC
+	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,ipe,bpf,clavis"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list, except for those with order
diff --git a/security/clavis/Makefile b/security/clavis/Makefile
index 16c451f45f37..a3430dd6bdf9 100644
--- a/security/clavis/Makefile
+++ b/security/clavis/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SECURITY_CLAVIS) += clavis_keyring.o
+obj-$(CONFIG_SECURITY_CLAVIS) += clavis.o
diff --git a/security/clavis/clavis.c b/security/clavis/clavis.c
new file mode 100644
index 000000000000..21ade9e625dc
--- /dev/null
+++ b/security/clavis/clavis.c
@@ -0,0 +1,26 @@
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
+	clavis_keyring_init();
+	security_add_hooks(clavis_hooks, ARRAY_SIZE(clavis_hooks), &clavis_lsmid);
+	return 0;
+};
+
+DEFINE_LSM(clavis) = {
+	.name = "clavis",
+	.init = clavis_lsm_init,
+};
diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
index 92f77a1939ad..b77e4ec8edbe 100644
--- a/security/clavis/clavis.h
+++ b/security/clavis/clavis.h
@@ -3,6 +3,8 @@
 #define _SECURITY_CLAVIS_H_
 #include <keys/asymmetric-type.h>
 
+struct public_key_signature;
+
 /* Max length for the asymmetric key id contained on the boot param */
 #define CLAVIS_BIN_KID_MAX   32
 #define CLAVIS_ASCII_KID_MAX 64
@@ -20,4 +22,6 @@ const char __initconst *const clavis_module_acl[] = {
 extern const char __initconst *const clavis_module_acl[];
 #endif
 
+int __init clavis_keyring_init(void);
+int clavis_sig_verify(const struct key *key, const struct public_key_signature *sig);
 #endif /* _SECURITY_CLAVIS_H_ */
diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
index 2a18d0e77189..1e1fbb54f6be 100644
--- a/security/clavis/clavis_keyring.c
+++ b/security/clavis/clavis_keyring.c
@@ -284,7 +284,7 @@ static void clavis_add_acl(const char *const *skid_list, struct key *keyring)
 	}
 }
 
-static int __init clavis_keyring_init(void)
+int __init clavis_keyring_init(void)
 {
 	struct key_restriction *restriction;
 
@@ -306,10 +306,82 @@ static int __init clavis_keyring_init(void)
 
 void __init late_init_clavis_setup(void)
 {
-	clavis_keyring_init();
-
 	if (!clavis_boot_akid)
 		return;
 
 	system_key_link(clavis_keyring, clavis_boot_akid);
 }
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
+	if (!clavis_acl_enforced())
+		return 0;
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
+			ref = keyring_search(make_key_ref(clavis_keyring_get(), true),
+					     &clavis_key_acl, buf_ptr, false);
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
+}
diff --git a/security/security.c b/security/security.c
index c5981e558bc2..097f8cedcd36 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5522,6 +5522,19 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
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
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
index 1cc8a977c711..cf292f976ac4 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -131,6 +131,9 @@ TEST(correct_lsm_list_modules)
 		case LSM_ID_IPE:
 			name = "ipe";
 			break;
+		case LSM_ID_CLAVIS:
+			name = "clavis";
+			break;
 		default:
 			name = "INVALID";
 			break;
-- 
2.45.0


