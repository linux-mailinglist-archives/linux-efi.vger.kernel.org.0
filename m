Return-Path: <linux-efi+bounces-1993-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B71F29A27E4
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 18:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E065B282F7
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 16:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903401DF245;
	Thu, 17 Oct 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I2vN3Qs0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i4EvjnLw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E81E0B64;
	Thu, 17 Oct 2024 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180627; cv=fail; b=MQUBPqmEjeSfDWtfsRRDDxoW+XuWR0S/fGRrunSpDjQkWBBGBH77DSZvyODiIkP0eI6pl+zMHN++qW5ShJRSEcNfQy0K2Wlc6BgHx7T3AAnXesjBE390ghZAE3To0XXyJWu2rC0pJeL+/jEADSMQFIM4fymwS8Z9gB//W5RCcsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180627; c=relaxed/simple;
	bh=xXwAwtCsevXxVT63QDniH9yydolJGv2jCITLAb3CTF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SajG9oq4y++T8xGSlJdasqJql9XDZJZ/r55VSxVV1lZOMDSLdS3+pjcACWcyLJLH2RkxMEzrt83ql0eryCyFqOUWaXy300t8ku2LMqmep//HnsY/EpV5s2SHJ6XgnBQjznrPsausFPHQ+9Zf8NS/DlwzVtyn41lGMDTTdkBMrD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I2vN3Qs0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i4EvjnLw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBvEA024561;
	Thu, 17 Oct 2024 15:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DCAUm+ORlFm5e7acijGQlERtZB1nOJhzoA4wRHy2NeE=; b=
	I2vN3Qs0LbxEdsrLMPo0RC5GlOHvHuJ1yl4AxcYQzrRf/RgVCszX87q9bbrrRnSZ
	uHLuU6alW1D7V+AHocGGThcPJw4wmMbfDHL7o+qkEnQ0uUM4BOw+M+2ZG8pyhk7S
	htI523PnO7yffGLEVhgN7Ok8f9HuL22Pkw0zvMMFT0eBjPSSZawcMbdvFlZ+Gb1b
	rvpRrDSLyV27+7RVUnxx7jN0m17eAY4TVZ3vtLUeOlfgQ05cnmbEFrZQkCJXE+gz
	xXJESw/AFGI86cgN+02mcMMhiPJ7rGeGi6Y3db4FeEi0w05JPXP4WwenV/9IcXDX
	KykB2/YsPFLZutXGe2xjHw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcpd3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFEJ0X026193;
	Thu, 17 Oct 2024 15:56:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaej7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eks2iENzhRhBExuP6ThyadYxUIOs2+cbAvr6WyZC6dluoaLjzq/vIUp/Re+wdAsFo/c29DRUwYXDmfRi03Pqh4U5DurXiImOsRCBSfxKBVtB1CoGgnZGrR30m7pUBw41f/MYvWyKvmZDx7asD+mFIKQykNhJ1es5kOG1Ma/Wlr/rkbyobhUNirtGA369CZFLMnB2sLNizsD+iZHmbqLUW/BXaIyY6NeUNh/3PdRWGNudclMegmSVtCvFF7eD2gs2xiXbb2jnZ09WKCPWjvfofkYj/MhKv/5U/w7CdCbaCrZfTtfPTK0QhN06DYxilN+232SB1YBOHVt8/rbqKj7kHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCAUm+ORlFm5e7acijGQlERtZB1nOJhzoA4wRHy2NeE=;
 b=hT0yBusWKjGoJycH3QTLcsvGc5AAznburVoWBQFeFI1uZxsk6WxkzkUAPzoTnzaMIoSn5OyAK1T20MU8qC9aXR9kkOO/piZRcP1teTqfqerKKi/8FznYsI//ZuLu8jhTuHn+muw8u+20VneeJgUgKl+U1+Iifk9TnifK1w07H+W0/nNh12uzg90xeMWVXVlTHaoLc8VPJxUE6IdlhHDvrdDMqsyN6Ifnv+vXrTousId9uTt8+OB4PBuJZx4rUqLjp0+3CKbt1sIQkME6u58ub4R5L4wYEx5ipxoGJ07aBYkUfQCAV8ERD5GsBPuYnsAyI8Gw++YuWbOFmAM3qy07/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCAUm+ORlFm5e7acijGQlERtZB1nOJhzoA4wRHy2NeE=;
 b=i4EvjnLwj7DYQ92PPpog8D7CMQonjo5cIfMI4WiG3voCdg9hwbxDB++ieAx9YxpC2LHVKPhv+GWBtooAyKlEiJmo1TiRE+Rrv38spA7OjPGtPHrUAyR+6moZGEgs8nUBt4NU0fRwi7zB48nz4BRBaqDTtIb3zWWj7Tzjw1MBpfE=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 15:56:13 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 15:56:13 +0000
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
Subject: [RFC PATCH v3 13/13] clavis: Kunit support
Date: Thu, 17 Oct 2024 09:55:16 -0600
Message-ID: <20241017155516.2582369-14-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::20) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cd1588-5df2-465d-9ba0-08dceec43a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Npg0V/T4Z6x/0xQTIZghVuKwFiszVRWl/w8Cy8mh2eRkBUck2+Qz+BW6fKru?=
 =?us-ascii?Q?ps7A+qQm/V7nuxWI8Tcj+ei4E4N7Hv76aJDIlsu7by31Ts0TWZvGQnmUzOJH?=
 =?us-ascii?Q?oZ2KnLImeDFrInXL1ax/WJ0hD0A3NrQNDHlszXYIIEDn/mInmZTnsWRPgXyp?=
 =?us-ascii?Q?Hrnaf9pC7vNFgqf2BC1A2zNgHb53xAcee7aBZF7F3oomnDeUKKA8yWl8OPE5?=
 =?us-ascii?Q?/0QL2t4Xib2vKgfYvsi4qr9Ux+AvK+RyT3+CM4gvYhpS2pnA+LSUvuNrIMsV?=
 =?us-ascii?Q?lXZHW8+5XMtxV2rUp0KSl3Yq1xUTT1Oz76rURCCdbqNsnXatEOi2n/EzNl4M?=
 =?us-ascii?Q?2dNKLpYBzmDr+7asYL4SsJD0qajJ+vwTVgniCdqWNP3pViNRkkF35MIA4CMI?=
 =?us-ascii?Q?1iEFMtV+868cJhZUBjRohYn4DbBIRKusTRKG1NLQwSi+yQktMs8PyVE5Sb88?=
 =?us-ascii?Q?cIcpSSX+B+qFEfDEOi6umX2xV+FKlbgbSLdtroBpIO873grJChAhNyIgyXG0?=
 =?us-ascii?Q?mowY7ZNC8vCJKQAY8s/uWuLjq32GAz2aFzhEWY9eXjf2aAEGzSHDt2Uh8lKo?=
 =?us-ascii?Q?h6qUgKrTmymJKO9+KbF5GFem95G6X33KDGzdjyV6BNwYhvlZZc9k6htxmkmo?=
 =?us-ascii?Q?v1F2nCTYfdiDq2wUFDs1yyLF5SVE7KyPIimG7gyor8qEDpGWAWXmKKi00gQ2?=
 =?us-ascii?Q?P/go+L1+CumMFljfb54lPg0nRoHkOW1lnF7LNs+iVTwWkN+ZKaPvyhGHAZuZ?=
 =?us-ascii?Q?Zc03BjnGdLskjAYbpz5CapCo3YazzpZfFBIf2YRZ85xgD25Q/yZLtRpFFpRm?=
 =?us-ascii?Q?VcN0NGwK7nOTcU/xXb/S6uW69Ni1saK0g6Nm3aoRxAda/sSyKqGTFyqhiKpn?=
 =?us-ascii?Q?4IrK3DutKLaBXAqeiWlAQemBiNiXcGHeT7LECkkf5K/o96x2sbHl/0GegtXb?=
 =?us-ascii?Q?Cl4m/0trf5wxjigDN0dF0mCiSOT+rcF2QDERhS+Ugpx37xrOuy5MfrINg304?=
 =?us-ascii?Q?EL71bsO2UETDk+RvcmRXHQ1TfkLz6KzvpO0/FCvmcW59qSzE/VnCKp0/60bo?=
 =?us-ascii?Q?0IIstv6gIBfDCc0uDwbIrJCP9xZfhq6XD/k1Cv7SVlaCFEOq4KiieiObPzrn?=
 =?us-ascii?Q?tNCv7KwZiEetOCY9DIqe6dpeuH71v9FTo4Bq0SjTdNxtJv8MVNhRQyQlExwf?=
 =?us-ascii?Q?PuPw4K3gSVr6bfexqeLR1nF/8OHlNzgbeaD89K2uizcwG9huuVDttbLkrlv+?=
 =?us-ascii?Q?2wbhJ4zFAnKev0ahMeP2cl7HWQSv/OL9qVeh8MBV/UEhkeEYmAmZepL9YmTj?=
 =?us-ascii?Q?bIyvK+Vto7WcxqjglBi+fUR7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOBySBKSSC3fKkjFwvFe34wYBc80pDRxGYgYXsQ/ktDi3WkeSFEOGRYw5Bg0?=
 =?us-ascii?Q?zOhoTDsEgCBZVRAJbtzfLQx0O+Qhk48lRag01JcKsxMrYOkgKvamLxw/b+gg?=
 =?us-ascii?Q?mfU9DnJouS2s0+DghwxL5fuQ3hDPDNQGZBLkCd6+X9ayQDHbT15zvBjBJYGP?=
 =?us-ascii?Q?EP90nipWuZuDHRsZFOpWexcfe1aeqs1bROG3j1at8FskQ5w9eb81798tfDqf?=
 =?us-ascii?Q?4G5DD6BBl9i1S3OB8hYxSIvQ0Jld0eyQ1PsztsRThU6zjguQKQjLlr/Way88?=
 =?us-ascii?Q?vVeiBZfBNoLX9e+lJ+qDju25CIOpnIEkv9P3PU5Ok89hYCXR8hiuSAPQxEtC?=
 =?us-ascii?Q?rf5EPvLZjZO8NKhaZ0XOa0Muj/6girvrjfYRrX3z4bCO/F9jspaNryNVyZTY?=
 =?us-ascii?Q?uo9qM17XLjlMBaZNmxlfHNIOiAOyGHtdIwqTzjDrf6TIRdMdRdNgHh5xjmX0?=
 =?us-ascii?Q?9zhEvID1+LO8+MMqPhsMQH81wDdq4NkPatWkRX8t3BC+AFVVXop2icJTmrgU?=
 =?us-ascii?Q?aNx1lwg0uXG2jS8jmlHwIplRTlUrb2/VaFCP++TJkWnUANBGZ+FpeQGGWszT?=
 =?us-ascii?Q?5ARW2fJ0BRV/28VdmkGwUIN3syjM9eJrN1UTuE1ZNbXi1BLpP9A4lhOyfbUc?=
 =?us-ascii?Q?JFR6bdR7TakXJUP2DhqlRispE1ksORcZbajqnITBc1Un0PSTgxDvLT8BnEul?=
 =?us-ascii?Q?X58DAA38CFX/M1fy7x2iMrXd7k7eXGfKpPcnXvunBkimvdkLy0uXUV691Ujd?=
 =?us-ascii?Q?vaZYcKTbGTT6O36GnZGiAh4v4q6rtORqcWZ70eEL0iUByD+7Jq2HRoMX/WPH?=
 =?us-ascii?Q?1U2A4+aTxGFWbOZDo2187+9HjQmFV+vlI6RQETONP4Jjs9eE42g3RK5oLfJP?=
 =?us-ascii?Q?wkO4e9JJUmy9KLWeYnUoqrQn2E+scSCbqQQMjBUFc/ugo9yJLt/OwVnQwqAS?=
 =?us-ascii?Q?pYZ7htCtSPrNES3Nz/TRen88S6t71EAnqFBXtMkdHTnOG1hDBev0L1SsM0G4?=
 =?us-ascii?Q?6wGO4Qi6cqDywY2nx26BdYGPWCCzlYPVrBabzv7JFNEJ5t+rn3CWeicp/fHo?=
 =?us-ascii?Q?y2PVZTxTvryIBk/UqTOY25k6dr2IRs7oxGDQrPlTRIY0NmqRFLSsJgxZpk6R?=
 =?us-ascii?Q?GnBLKUbd/OqaEGTJyMwZzjMzrGHb530caEVOhdO9CEhhfT1LLfsFgnEGd/J/?=
 =?us-ascii?Q?Nd5k0XI3h6328Vw46Xp3P2LCEHKLieTIle1EWBOwwk1vJUoY3Z/L50bD+hGz?=
 =?us-ascii?Q?dufgqVDnjDCDlnuCuf7N1eQrOBCiaBt5PXV8svZiGEu7LTdMy1Lfqd9/RDwV?=
 =?us-ascii?Q?wBrmKODFHOqE5LhjkJwgAkhSQuZ3UIoJp70MiXSEqU1D9Xg9tBt1FxnPBm4J?=
 =?us-ascii?Q?cMPS7jVWnHHwqK4H0XQiRw/JfNyaSJT7ghq1/9fOyZkV8PirXyNeFwk3WSyd?=
 =?us-ascii?Q?pgI5v8T/r+CqYA1fPgnJGz+rHULBHlj65UntqulXEc/iDPxeXLMkHM+UNgrc?=
 =?us-ascii?Q?Pd502QL5Y0k0GBh/WEwBicbUVOTYOQd+lnkqCv24Q0JaUc+8SycLkUGhggJJ?=
 =?us-ascii?Q?/U/R07drNvb6AppoqOxWiF9mLhQIj6WkSkRiT1FlWkX67fpPncPF8GmR5AR/?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JIKL34BmaKLpD/+KJrZ2GWJQz1rDCCehbJs3JTCAZ0wSPW5BM/PyFSPNXR5Iz2qMrC/Fid2Tpnry/jPwtXzAuolgZ+MFQK7+K8vBUI1FTZ9vNFRzZbBuTPHOPg3v6GCuSuKQRTgaG7EaQvJbB8aI1NLWl8T7KcW2Uut+/6152MUDxrNfvMCgJT1IuZa/mtzgqfXZO0UAsjYBQbXisCTaq7rbRVxY+7pu8X4YXHJvu0uA7QIK4d7q41OyvPjaAu7lpGYq3WArKYuX5vqh/gZtIXFmVpXyHuNOY5MnO41gx2s6jXCdxCo5saYIkkTeFu1+SdgxuUmwpsG1YMgWFg41sy9SVXxMxlqDopelhwPAvQvbvdoD/xTtarF23CWO+53rdUJHX9nF2azrhKwdg/9AuJpoDzHBbMuNO/6DkznyMCj9t1FjfXKVVUYvnvW6YbRSsNka5GuETlZwHJIxklmbqF2Qu9L/AiprKh4Lq0KVs9gVOWgK4F/gggFf3lPEDfPdqFDndPZi0XJoyQlmrLxgUvA01kNr16RqcAympjv2XZRZfKkEFXHNPO75vhxduczviBdorJ3TtYtM6IAzyq/aJwdfYF4GfX3JOdYKHmap/UI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cd1588-5df2-465d-9ba0-08dceec43a1f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:56:13.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4hdDyZUySwjKbJlQeGDj5QHJbWTDquwi7X9xSo53+gEaU1Z5D6lYXaXf7GzfDmYBtXqDq9xzmJSvJUcgkaQ3JhlWIqS4cgLRxRxbRwJTfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-GUID: VnjlpIfLZpJ5KLV7CumRXusG-DtqhMHH
X-Proofpoint-ORIG-GUID: VnjlpIfLZpJ5KLV7CumRXusG-DtqhMHH

Add Kunit coverage to Clavis.

The Makefile will generate multiple test vectors.  All test vectors will
end up in the x509.h, acl.h or signed_data.h file.

The clavis test vectors (ctv) include:

	6 different x509 certs. One for each of the different key usage types.
	This will be loaded into the machine_kunit keyring.
		ctv_0[x]_x509

	1 x509 cert that will be used for revocations:
		ctv_rev_x509

	6 different Clavis ACL's.  One for each usage type:
		ctv_0[x]_x509_acl

	2 different Clavis keys ctv_ca0_x509 and ctv_ca1_x509.

	12 different PCKS7 signed Clavis ACLs.
	   6 signed by ctv_ca0:
	     ctv_ca0_0[x]_pkcs7

	   6 signed by ctv_ca1
	     ctv_ca1_0[x]_pkcs7

	1 signed module (with random data) signed by a key in the module ACL:
		ctv_module_ca0_signed

	1 signed module (with random data) signed by a revoked key:
		ctv_module_rev_signed

	1 Unspecified data that is PKCS7 signed the key unspecified data ACL:
		ctv_data_05_signed

The tests can be enabled through a new Kconfig: SECURITY_CLAVIS_KUNIT_TEST.

Run all KUnit tests for Clavis with:
	  ./tools/testing/kunit/kunit.py run --kunitconfig security/clavis

The only areas missing are stubbing out EFI and system_key_link.
Everything else should be covered with this patch.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/clavis/.gitignore    |   1 +
 security/clavis/.kunitconfig  |   4 +
 security/clavis/Kconfig       |  16 +
 security/clavis/Makefile      | 132 ++++++++
 security/clavis/clavis.h      |  24 ++
 security/clavis/clavis_test.c | 566 ++++++++++++++++++++++++++++++++++
 6 files changed, 743 insertions(+)
 create mode 100644 security/clavis/.kunitconfig
 create mode 100644 security/clavis/clavis_test.c

diff --git a/security/clavis/.gitignore b/security/clavis/.gitignore
index c1b60bee049e..2c160c45fc53 100644
--- a/security/clavis/.gitignore
+++ b/security/clavis/.gitignore
@@ -1 +1,2 @@
 /builtin_acl
+/sign-file*
diff --git a/security/clavis/.kunitconfig b/security/clavis/.kunitconfig
new file mode 100644
index 000000000000..c3d2e0eccb06
--- /dev/null
+++ b/security/clavis/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_SECURITY=y
+CONFIG_SECURITY_CLAVIS=y
+CONFIG_SECURITY_CLAVIS_KUNIT_TEST=y
diff --git a/security/clavis/Kconfig b/security/clavis/Kconfig
index b702311ec905..32cd9799cac9 100644
--- a/security/clavis/Kconfig
+++ b/security/clavis/Kconfig
@@ -19,3 +19,19 @@ config SECURITY_CLAVIS_ACL_LIST
 	  acl list into the kernel. The file contents must be in the following
 	  format: <two digit key usage number>:<subject key id>.  If more than
 	  one entry is added, add a carriage return after each entry.
+
+config SECURITY_CLAVIS_KUNIT_TEST
+	bool "KUnit tests for Clavis" if !KUNIT_ALL_TESTS
+	depends on SECURITY_CLAVIS && KUNIT
+	default KUNIT_ALL_TESTS
+	select SYSTEM_BLACKLIST_KEYRING
+	select SYSTEM_REVOCATION_LIST
+	help
+	  Build KUnit tests for Clavis.
+
+	  See the KUnit documentation in Documentation/dev-tools/kunit
+
+	  Run all KUnit tests for Clavis with:
+	  ./tools/testing/kunit/kunit.py run --kunitconfig security/clavis
+
+	  If you are unsure how to answer this question, answer N.
diff --git a/security/clavis/Makefile b/security/clavis/Makefile
index af68a44a0cb4..c0915af4f180 100644
--- a/security/clavis/Makefile
+++ b/security/clavis/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_SECURITY_CLAVIS) += clavis_keyring.o
 obj-$(CONFIG_SECURITY_CLAVIS) += clavis.o
 obj-$(CONFIG_SECURITY_CLAVIS) += clavis_builtin_acl.o
+obj-$(CONFIG_SECURITY_CLAVIS_KUNIT_TEST) += clavis_test.o
 
 ifeq ($(CONFIG_SECURITY_CLAVIS_ACL_LIST),)
 quiet_cmd_make_builtin_acl = GEN     $@
@@ -22,3 +23,134 @@ $(obj)/clavis_builtin_acl.o: $(obj)/builtin_acl
 ifeq ($(CONFIG_EFI),y)
 obj-$(CONFIG_SECURITY_CLAVIS) += clavis_efi.o
 endif
+
+ifeq ($(CONFIG_SECURITY_CLAVIS_KUNIT_TEST),y)
+ctv := include/generated/clavis
+$(shell mkdir -p $(ctv))
+
+quiet_cmd_make_test_key = GEN     $@
+	cmd_make_test_key = \
+		openssl req -x509 -out $@ -outform der -keyout \
+		$@.priv -new \
+		-nodes -sha512 -days 3650   -subj '/CN=Clavis Kunit' -extensions EXT -config <( \
+		printf "[cert]\nCN=Clavis Kunit\n[req]\ndistinguished_name =  cert\ndefault_bits \
+		= 4096\n[EXT]\nkeyUsage=keyCertSign,digitalSignature\n\
+		extendedKeyUsage=codeSigning\nsubjectKeyIdentifier=hash\n\
+		basicConstraints=critical,CA:TRUE\nauthorityKeyIdentifier=keyid:always,issuer") \
+		> /dev/null 2>&1
+
+# These are in the same order as enum key_being_used_for
+KEY_USAGE = 0 1 2 3 4 5
+CLAVIS_KEYS = 0 1
+
+$(ctv)/ctv_%.x509: FORCE
+	$(call if_changed,make_test_key)
+
+quiet_cmd_make_include_bin_array = GEN	$@
+	cmd_make_include_bin_array = \
+	echo "/* Autogenerated file, do not modify. */" > $@;	\
+	for cfile in $(filter-out FORCE $(ctv)/x509.h $(ctv)/acl.h,$^); do		\
+		filename=$$(basename $$cfile);	\
+		varname=$$(echo "$$filename" | sed 's/\./_/g'); \
+		{ echo -n "const u32 $$varname"_len" = "; \
+		cat $$cfile | wc -c | tr -d '\n'; echo ";"; \
+		echo "const u8 $$varname[] = {"; \
+		od -t x1 -An -v $$cfile | sed 's/\([0-9a-fA-F]\{2\}\)/0x\1,/g'; \
+		echo "};"; } >> $@;	\
+	done
+
+quiet_cmd_make_include_char_array = GEN	 $@
+	cmd_make_include_char_array = \
+	echo "/* Autogenerated file, do not modify. */" > $@; \
+	for cfile in $(filter-out FORCE $(ctv)/x509.h,$^); do \
+		filename=$$(basename $$cfile);	\
+		varname=$$(echo "$$filename" | sed 's/\./_/g'); \
+		{ echo -n "const char $$varname[] = "\"; \
+		  cat $$cfile; echo "\";"; } >> $@; \
+	done
+
+quiet_cmd_gen_acl = GEN     $@
+	cmd_gen_acl = \
+		{ echo -n $*:; \
+		openssl x509 -in $< -inform der -ext subjectKeyIdentifier -nocert | \
+		tail -n +2 | cut -f4 -d '=' | tr -d ':' | tr '[:upper:]' '[:lower:]' | \
+		tr -d '[:space:]'; } > $@
+
+$(ctv)/ctv_%.x509.acl: $(ctv)/ctv_%.x509 FORCE
+	$(call if_changed,gen_acl)
+
+quiet_cmd_ca0_sign_pkcs7 = GEN    $@
+	cmd_ca0_sign_pkcs7 = \
+		openssl smime -sign -signer $(ctv)/ctv_ca0.x509 -inkey \
+		$(ctv)/ctv_ca0.x509.priv -in $< -out $@ -binary -outform DER \
+		-nodetach -noattr > /dev/null 2>&1
+
+$(ctv)/ctv_ca0_%.pkcs7: $(ctv)/ctv_%.x509.acl $(ctv)/ctv_ca0.x509 FORCE
+	$(call if_changed,ca0_sign_pkcs7)
+
+quiet_cmd_ca1_sign_pkcs7 = GEN     $@
+	cmd_ca1_sign_pkcs7 = \
+		openssl smime -sign -signer $(ctv)/ctv_ca1.x509 -inkey \
+		$(ctv)/ctv_ca1.x509.priv -in $< -out $@ -binary -outform DER \
+		-nodetach -noattr > /dev/null 2>&1
+
+$(ctv)/ctv_ca1_%.pkcs7: $(ctv)/ctv_%.x509.acl $(ctv)/ctv_ca1.x509 FORCE
+	$(call if_changed,ca1_sign_pkcs7)
+
+quiet_cmd_sign_data_pkcs7 = GEN    $@
+	cmd_sign_data_pkcs7 = \
+		openssl smime -sign -signer $(ctv)/ctv_$*.x509 -inkey \
+		$(ctv)/ctv_$*.x509.priv -in $< -out $@ -binary -outform DER \
+		-nodetach -noattr > /dev/null 2>&1
+
+quiet_cmd_gen_file = GEN     $@
+	cmd_gen_file = head -c 4096 /dev/urandom > $@
+
+$(ctv)/ctv_data_%_signed: $(ctv)/ctv_%.x509 FORCE
+	$(call cmd,gen_file)
+	$(call cmd,sign_data_pkcs7)
+
+quiet_cmd_copy_sign-file = COPY    $@
+	cmd_copy_sign-file = cat $(src)/../../scripts/sign-file.c >$@
+
+quiet_cmd_sign = KSIGN   $@
+	cmd_sign = $(obj)/sign-file sha256 $<.priv $< $@
+
+$(src)/sign-file.c: FORCE
+	$(call cmd,copy_sign-file)
+
+hostprogs := sign-file
+HOSTCFLAGS_sign-file.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 3> /dev/null) -I$(srctree)/scripts
+HOSTLDLIBS_sign-file = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
+
+$(ctv)/ctv_module_%_signed: $(ctv)/ctv_%.x509 $(obj)/sign-file FORCE
+	$(call cmd,gen_file)
+	$(call cmd,sign)
+
+$(ctv)/x509.h: $(foreach n, $(KEY_USAGE), $(ctv)/ctv_0$n.x509)  $(ctv)/ctv_rev.x509 \
+		   $(foreach n, $(CLAVIS_KEYS), $(ctv)/ctv_ca$n.x509) FORCE
+	$(call if_changed,make_include_bin_array)
+
+$(ctv)/acl.h: $(ctv)/x509.h $(foreach n, $(KEY_USAGE), $(ctv)/ctv_0$n.x509.acl) FORCE
+	$(call if_changed,make_include_char_array)
+
+$(ctv)/signed_data.h: $(ctv)/x509.h $(ctv)/acl.h \
+			  $(foreach n, $(KEY_USAGE), $(ctv)/ctv_ca0_0$n.pkcs7) \
+			  $(foreach n, $(KEY_USAGE), $(ctv)/ctv_ca1_0$n.pkcs7) \
+			  $(ctv)/ctv_module_00_signed $(ctv)/ctv_module_ca0_signed \
+			  $(ctv)/ctv_module_rev_signed $(ctv)/ctv_data_05_signed FORCE
+	$(call if_changed,make_include_bin_array)
+
+targets += $(foreach n, $(CLAVIS_KEYS), $(ctv)/ctv_ca$n.x509)
+targets += $(foreach n, $(KEY_USAGE), $(ctv)/ctv_0$n.x509)
+targets += $(foreach n, $(KEY_USAGE), $(ctv)/ctv_0$n.x509.acl)
+targets += $(foreach n, $(KEY_USAGE), $(ctv)/ctv_ca0_0$n.pkcs7)
+targets += $(foreach n, $(KEY_USAGE), $(ctv)/ctv_ca1_0$n.pkcs7)
+targets += $(ctv)/x509.h $(ctv)/acl.h $(ctv)/signed_data.h
+targets += $(ctv)/ctv_module_00_signed $(ctv)/ctv_module_ca0_signed
+targets += $(ctv)/ctv_module_rev_signed $(ctv)/ctv_data_05_signed
+targets += $(ctv)/ctv_rev.x509
+targets += $(src)/sign-file.c $(obj)/sign-file
+
+$(obj)/clavis_test.o: $(ctv)/x509.h $(ctv)/acl.h $(ctv)/signed_data.h
+endif
diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
index 6f68b560311e..2f08c8af1d66 100644
--- a/security/clavis/clavis.h
+++ b/security/clavis/clavis.h
@@ -35,4 +35,28 @@ static inline int __init clavis_efi_param(struct asymmetric_key_id *kid, int len
 
 int __init clavis_keyring_init(void);
 int clavis_sig_verify(const struct key *key, const struct public_key_signature *sig);
+#ifdef CONFIG_SECURITY_CLAVIS_KUNIT_TEST
+extern void key_type_put(struct key_type *ktype);
+extern struct key_type *key_type_lookup(const char *type);
+extern long keyctl_update_key(key_serial_t id, const void __user *_payload, size_t plen);
+extern struct key * (* const clavis_keyring_get_fn_ptr)(void);
+extern int (* const key_acl_preparse_fn_ptr)(struct key_preparsed_payload *prep);
+extern void (* const clavis_add_acl_fn_ptr)(const char *const *skid_list, struct key *keyring);
+
+extern struct key *
+	(*const keyring_alloc_fn_ptr)(const char *desc, struct key_restriction *restriction);
+
+extern struct key_restriction *
+	(* const restriction_alloc_fn_ptr)(key_restrict_link_func_t check_func);
+
+extern struct asymmetric_key_id  *
+	(* const parse_boot_param_fn_ptr)(char *kid, struct asymmetric_key_id *akid,
+					  int akid_max_len);
+
+extern int
+	(* const pkcs7_preparse_content_fn_ptr)(void *ctx, const void *data, size_t len,
+						size_t asn1hdrlen);
+
+extern bool (* const clavis_acl_enforced_fn_ptr)(void);
+#endif
 #endif /* _SECURITY_CLAVIS_H_ */
diff --git a/security/clavis/clavis_test.c b/security/clavis/clavis_test.c
new file mode 100644
index 000000000000..67fe5d6c6037
--- /dev/null
+++ b/security/clavis/clavis_test.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <kunit/static_stub.h>
+#include <linux/init.h>
+#include <linux/key-type.h>
+#include <keys/asymmetric-type.h>
+#include <linux/vmalloc.h>
+#include <linux/uaccess.h>
+#include <linux/module_signature.h>
+#include <keys/system_keyring.h>
+#include <linux/cred.h>
+#include "clavis.h"
+#include <generated/clavis/x509.h>
+#include <generated/clavis/acl.h>
+#include <generated/clavis/signed_data.h>
+
+static struct key *machine_keyring;
+static struct key *clavis_keyring;
+static bool clavis_enforced;
+
+const char *const clavis_builtin_test_acl_list[] = {
+	"01:02b4e19c7efc4512ae4911d9e7e6c3c9",
+	"05:b6c202e7710544a885e425387cd344f6",
+	"04:ca5b4645541c4e828ef460806f9a61bc",
+	NULL
+};
+
+static int clavis_suite_init(struct kunit_suite *suite)
+{
+	kunit_info(suite, "Initializing Clavis Suite\n");
+
+	machine_keyring = keyring_alloc(".machine_kunit",
+					GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
+					(KEY_POS_ALL & ~KEY_POS_SETATTR) |
+					KEY_USR_VIEW | KEY_USR_READ |
+					KEY_USR_SEARCH,
+					KEY_ALLOC_NOT_IN_QUOTA,
+					NULL, NULL);
+
+	x509_load_certificate_list(ctv_00_x509, ctv_00_x509_len, machine_keyring);
+	x509_load_certificate_list(ctv_01_x509, ctv_01_x509_len, machine_keyring);
+	x509_load_certificate_list(ctv_02_x509, ctv_02_x509_len, machine_keyring);
+	x509_load_certificate_list(ctv_03_x509, ctv_03_x509_len, machine_keyring);
+	x509_load_certificate_list(ctv_04_x509, ctv_04_x509_len, machine_keyring);
+	x509_load_certificate_list(ctv_05_x509, ctv_05_x509_len, machine_keyring);
+	x509_load_certificate_list(ctv_ca0_x509, ctv_ca0_x509_len, machine_keyring);
+	x509_load_certificate_list(ctv_ca1_x509, ctv_ca1_x509_len, machine_keyring);
+	x509_load_certificate_list(ctv_rev_x509, ctv_rev_x509_len, machine_keyring);
+
+	/*
+	 * Note, this will leave the machine with one additional revocation in the
+	 * blacklist keyring when done.
+	 */
+	add_key_to_revocation_list(ctv_rev_x509, ctv_rev_x509_len);
+
+	return 0;
+}
+
+static void clavis_suite_exit(struct kunit_suite *suite)
+{
+	key_put(machine_keyring);
+}
+
+static int restrict_link_for_clavis_test(struct key *dest_keyring, const struct key_type *type,
+					 const union key_payload *payload, struct key *restrict_key)
+{
+	struct key_type *clavis;
+	int rval = 0;
+
+	if (type == &key_type_asymmetric && dest_keyring == clavis_keyring && !clavis_enforced) {
+		clavis_enforced = true;
+		return 0;
+	}
+
+	clavis = key_type_lookup("clavis_key_acl");
+	if (type != clavis)
+		rval = -EOPNOTSUPP;
+
+	if (clavis != ERR_PTR(-ENOKEY))
+		key_type_put(clavis);
+
+	return rval;
+}
+
+static int clavis_test_keyring_init(struct kunit *test)
+{
+	struct key_restriction *restriction;
+
+	restriction = restriction_alloc_fn_ptr(restrict_link_for_clavis_test);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, restriction);
+	clavis_keyring = keyring_alloc_fn_ptr(".clavis_test", restriction);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, clavis_keyring);
+	KUNIT_EXPECT_EQ(test, clavis_keyring->perm, KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH |
+			KEY_POS_WRITE | KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH |
+			KEY_USR_WRITE);
+	clavis_enforced = false;
+	return 0;
+}
+
+static void clavis_test_keyring_exit(struct kunit *test)
+{
+	key_put(clavis_keyring);
+	clavis_keyring = NULL;
+	clavis_enforced = false;
+}
+
+static void builtin_acl_tests(struct kunit *test)
+{
+	key_ref_t key;
+	const char *const *desc;
+
+	clavis_add_acl_fn_ptr(clavis_builtin_test_acl_list, clavis_keyring);
+
+	for (desc = clavis_builtin_test_acl_list; *desc; desc++) {
+		key = keyring_search(make_key_ref(clavis_keyring, true),
+				     key_type_lookup("clavis_key_acl"),
+				     *desc,
+				     true);
+		KUNIT_EXPECT_FALSE(test, (IS_ERR(key)));
+		KUNIT_EXPECT_EQ(test, strcmp(key_ref_to_ptr(key)->description, *desc), 0);
+		KUNIT_EXPECT_EQ(test,
+				keyctl_update_key(key_ref_to_ptr(key)->serial, NULL, 0),
+				-EACCES);
+		KUNIT_EXPECT_EQ(test, key_ref_to_ptr(key)->perm, KEY_POS_SEARCH | KEY_POS_VIEW |
+				KEY_USR_SEARCH | KEY_USR_VIEW);
+		key_ref_put(key);
+	}
+}
+
+static void register_key_type_tests(struct kunit *test)
+{
+	struct key_type *clavis;
+
+	clavis = key_type_lookup("clavis_key_acl");
+	KUNIT_EXPECT_PTR_NE(test, clavis, ERR_PTR(-ENOKEY));
+	if (clavis != ERR_PTR(-ENOKEY))
+		key_type_put(clavis);
+
+	clavis = key_type_lookup("bogus");
+	KUNIT_EXPECT_PTR_EQ(test, clavis, ERR_PTR(-ENOKEY));
+	if (clavis != ERR_PTR(-ENOKEY))
+		key_type_put(clavis);
+}
+
+static void clavis_parse_boot_param_tests(struct kunit *test)
+{
+	char *huge = "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef01";
+	struct asymmetric_setup_kid ask;
+	struct asymmetric_key_id *kid;
+
+	KUNIT_EXPECT_PTR_EQ(test, parse_boot_param_fn_ptr(NULL, &ask.id, ARRAY_SIZE(ask.data)),
+			    NULL);
+	KUNIT_EXPECT_PTR_EQ(test, parse_boot_param_fn_ptr(huge, &ask.id, ARRAY_SIZE(ask.data)),
+			    NULL);
+	KUNIT_EXPECT_PTR_EQ(test, parse_boot_param_fn_ptr("0x1000", &ask.id, ARRAY_SIZE(ask.data)),
+			    NULL);
+	KUNIT_EXPECT_PTR_EQ(test, parse_boot_param_fn_ptr("nothex", &ask.id, ARRAY_SIZE(ask.data)),
+			    NULL);
+	kid = parse_boot_param_fn_ptr("01234567", &ask.id, ARRAY_SIZE(ask.data));
+
+	KUNIT_EXPECT_EQ(test, kid->len, 4);
+	KUNIT_EXPECT_EQ(test, kid->data[0], 0x01);
+	KUNIT_EXPECT_EQ(test, kid->data[1], 0x23);
+	KUNIT_EXPECT_EQ(test, kid->data[2], 0x45);
+	KUNIT_EXPECT_EQ(test, kid->data[3], 0x67);
+}
+
+static inline bool vet_description_test(struct key *keyring, const char *desc)
+{
+	key_ref_t key;
+
+	key = key_create(make_key_ref(keyring, true),
+			 "clavis_key_acl",
+			  desc,
+			  NULL,
+			  0,
+			  KEY_POS_SEARCH | KEY_POS_VIEW | KEY_USR_SEARCH | KEY_USR_VIEW,
+			  KEY_ALLOC_BUILT_IN);
+
+	if (IS_ERR(key))
+		return false;
+
+	return true;
+}
+
+static void key_acl_vet_description_tests(struct kunit *test)
+{
+	char *huge = "01:0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef01";
+	char *large = "01:0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef";
+	char buf[64];
+	int i;
+
+	KUNIT_EXPECT_FALSE(test, vet_description_test(clavis_keyring, "00:nothex"));
+	KUNIT_EXPECT_FALSE(test, vet_description_test(clavis_keyring, "0:1234"));
+	KUNIT_EXPECT_FALSE(test, vet_description_test(clavis_keyring, "01:123"));
+	KUNIT_EXPECT_FALSE(test, vet_description_test(clavis_keyring, "X0:123"));
+	KUNIT_EXPECT_FALSE(test, vet_description_test(clavis_keyring, huge));
+	KUNIT_EXPECT_TRUE(test, vet_description_test(clavis_keyring, large));
+
+	for (i = 0; i < 255; i++) {
+		snprintf(buf, sizeof(buf), "%2hx:01234567", i);
+		if (i < VERIFYING_CLAVIS_SIGNATURE)
+			KUNIT_EXPECT_TRUE(test, vet_description_test(clavis_keyring, buf));
+		else
+			KUNIT_EXPECT_FALSE(test, vet_description_test(clavis_keyring, buf));
+	}
+}
+
+static void key_usage_tests(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, VERIFYING_CLAVIS_SIGNATURE + 1, NR__KEY_BEING_USED_FOR);
+}
+
+static int key_acl_preparse_kunit(struct key_preparsed_payload *prep)
+{
+	if (prep->orig_description)
+		return 0;
+
+	return verify_pkcs7_signature(NULL, 0, prep->data, prep->datalen, clavis_keyring,
+				      VERIFYING_CLAVIS_SIGNATURE, pkcs7_preparse_content_fn_ptr,
+				      prep);
+}
+
+static void signed_acl_tests(struct kunit *test)
+{
+	int i;
+	const unsigned char *ca0_acl_pkcs7[] = { ctv_ca0_00_pkcs7, ctv_ca0_01_pkcs7,
+						 ctv_ca0_02_pkcs7, ctv_ca0_03_pkcs7,
+						 ctv_ca0_04_pkcs7, ctv_ca0_05_pkcs7
+					       };
+
+	const u32 ca0_acl_pkcs7_buf_size[] = { ctv_ca0_00_pkcs7_len, ctv_ca0_01_pkcs7_len,
+					       ctv_ca0_02_pkcs7_len, ctv_ca0_03_pkcs7_len,
+					       ctv_ca0_04_pkcs7_len, ctv_ca0_05_pkcs7_len
+					     };
+
+	const unsigned char *ca1_acl_pkcs7[] = { ctv_ca1_00_pkcs7, ctv_ca1_01_pkcs7,
+						 ctv_ca1_02_pkcs7, ctv_ca1_03_pkcs7,
+						 ctv_ca1_04_pkcs7, ctv_ca1_05_pkcs7
+					       };
+
+	const u32 ca1_acl_pkcs7_buf_size[] = { ctv_ca1_00_pkcs7_len, ctv_ca1_01_pkcs7_len,
+					       ctv_ca1_02_pkcs7_len, ctv_ca1_03_pkcs7_len,
+					       ctv_ca1_04_pkcs7_len, ctv_ca1_05_pkcs7_len
+					     };
+
+	char const *acl_list[] = { ctv_00_x509_acl, ctv_01_x509_acl, ctv_02_x509_acl,
+				   ctv_03_x509_acl, ctv_04_x509_acl, ctv_05_x509_acl };
+
+	key_ref_t key;
+
+	KUNIT_EXPECT_EQ(test,
+			x509_load_certificate_list(ctv_ca0_x509, ctv_ca0_x509_len, clavis_keyring),
+			0);
+
+	clavis_enforced = true;
+
+	for (i = 0; i < 6; i++) {
+		key = key_create(make_key_ref(clavis_keyring, true),
+				 "clavis_key_acl",
+				 NULL,
+				 ca0_acl_pkcs7[i],
+				 ca0_acl_pkcs7_buf_size[i],
+				 KEY_POS_SEARCH | KEY_POS_VIEW | KEY_USR_SEARCH | KEY_USR_VIEW,
+				 KEY_ALLOC_BUILT_IN);
+
+		KUNIT_EXPECT_TRUE(test, IS_ERR(key));
+
+		key = keyring_search(make_key_ref(clavis_keyring, true),
+				     key_type_lookup("clavis_key_acl"),
+				     acl_list[i],
+				     true);
+
+		KUNIT_EXPECT_TRUE(test, IS_ERR(key));
+	}
+
+	kunit_activate_static_stub(test, key_acl_preparse_fn_ptr, key_acl_preparse_kunit);
+
+	for (i = 0; i < 6; i++) {
+		key = key_create(make_key_ref(clavis_keyring, true),
+				 "clavis_key_acl",
+				 NULL,
+				 ca0_acl_pkcs7[i],
+				 ca0_acl_pkcs7_buf_size[i],
+				 KEY_POS_SEARCH | KEY_POS_VIEW | KEY_USR_SEARCH | KEY_USR_VIEW,
+				 KEY_ALLOC_BUILT_IN);
+
+		KUNIT_EXPECT_NOT_ERR_OR_NULL(test, key);
+
+		key = keyring_search(make_key_ref(clavis_keyring, true),
+				     key_type_lookup("clavis_key_acl"),
+				     acl_list[i],
+				     true);
+
+		KUNIT_EXPECT_NOT_ERR_OR_NULL(test, key);
+	}
+
+	for (i = 0; i < 6; i++) {
+		key = key_create(make_key_ref(clavis_keyring, true),
+				 "clavis_key_acl",
+				 NULL,
+				 ca1_acl_pkcs7[i],
+				 ca1_acl_pkcs7_buf_size[i],
+				 KEY_POS_SEARCH | KEY_POS_VIEW | KEY_USR_SEARCH | KEY_USR_VIEW,
+				 KEY_ALLOC_BUILT_IN);
+
+		KUNIT_EXPECT_TRUE(test, IS_ERR(key));
+	}
+
+	kunit_deactivate_static_stub(test, key_acl_preparse_fn_ptr);
+}
+
+static struct key *clavis_key_get(void)
+{
+	return clavis_keyring;
+}
+
+static bool clavis_acl_enforced(void)
+{
+	return clavis_enforced;
+}
+
+static void module_invalid_signed_tests(struct kunit *test)
+{
+	const void *mod = ctv_module_ca0_signed;
+	struct module_signature ms;
+	key_ref_t key;
+	size_t sig_len, mod_len;
+
+	kunit_activate_static_stub(test, clavis_keyring_get_fn_ptr, clavis_key_get);
+	kunit_activate_static_stub(test, clavis_acl_enforced_fn_ptr, clavis_acl_enforced);
+
+	/* Remove the module signature appended information at the end. */
+	mod_len = ctv_module_ca0_signed_len - 28;
+	KUNIT_EXPECT_GT(test, mod_len, sizeof(ms));
+	memcpy(&ms, mod + (mod_len - sizeof(ms)), sizeof(ms));
+	sig_len = be32_to_cpu(ms.sig_len);
+	mod_len -= sig_len + sizeof(ms);
+
+	/*
+	 * Enforcement has not been set yet, therefore the verification passes
+	 * without an ACL. The module signing key is in the machine_kunit
+	 * keyring.
+	 */
+	KUNIT_EXPECT_EQ(test, verify_pkcs7_signature(mod, mod_len,
+						     mod + mod_len, sig_len,
+						     machine_keyring,
+						     VERIFYING_MODULE_SIGNATURE,
+						     NULL, NULL), 0);
+
+	/* Load the clavis CA0 in the clavis keyring. */
+	KUNIT_EXPECT_EQ(test,
+			x509_load_certificate_list(ctv_ca0_x509, ctv_ca0_x509_len, clavis_keyring),
+			0);
+
+	clavis_enforced = true;
+
+	/* Enforcement has been enabled without an ACL set. */
+	KUNIT_EXPECT_EQ(test, verify_pkcs7_signature(mod, mod_len,
+						     mod + mod_len, sig_len,
+						     machine_keyring,
+						     VERIFYING_MODULE_SIGNATURE,
+						     NULL, NULL), -EKEYREJECTED);
+
+	/* Add the module ACL. */
+	key = key_create(make_key_ref(clavis_keyring, true),
+			 "clavis_key_acl",
+			 NULL,
+			 ctv_ca0_00_pkcs7,
+			 ctv_ca0_00_pkcs7_len,
+			 KEY_POS_SEARCH | KEY_POS_VIEW | KEY_USR_SEARCH |
+			 KEY_USR_VIEW, KEY_ALLOC_BUILT_IN);
+
+	KUNIT_EXPECT_FALSE(test, IS_ERR(key));
+
+	/* This module was not signed by the module ACL in the clavis keyring. */
+	KUNIT_EXPECT_EQ(test, verify_pkcs7_signature(mod, mod_len,
+						     mod + mod_len, sig_len,
+						     machine_keyring,
+						     VERIFYING_MODULE_SIGNATURE,
+						     NULL, NULL), -EKEYREJECTED);
+
+	kunit_deactivate_static_stub(test, clavis_keyring_get_fn_ptr);
+	kunit_deactivate_static_stub(test, clavis_acl_enforced_fn_ptr);
+}
+
+static void module_signed_tests(struct kunit *test)
+{
+	const void *mod = ctv_module_00_signed;
+	struct module_signature ms;
+	key_ref_t key;
+	size_t sig_len, mod_len;
+
+	kunit_activate_static_stub(test, clavis_keyring_get_fn_ptr, clavis_key_get);
+	kunit_activate_static_stub(test, clavis_acl_enforced_fn_ptr, clavis_acl_enforced);
+
+	/* Remove the module signature appended information at the end. */
+	mod_len = ctv_module_00_signed_len - 28;
+	KUNIT_EXPECT_GT(test, mod_len, sizeof(ms));
+	memcpy(&ms, mod + (mod_len - sizeof(ms)), sizeof(ms));
+	sig_len = be32_to_cpu(ms.sig_len);
+	mod_len -= sig_len + sizeof(ms);
+
+	/*
+	 * Enforcement has not been set yet, therefore the verification passes
+	 * without an ACL.
+	 */
+	KUNIT_EXPECT_EQ(test, verify_pkcs7_signature(mod, mod_len,
+						     mod + mod_len, sig_len,
+						     machine_keyring,
+						     VERIFYING_MODULE_SIGNATURE,
+						     NULL, NULL), 0);
+
+	/* Load the clavis CA0 in the clavis keyring. */
+	KUNIT_EXPECT_EQ(test,
+			x509_load_certificate_list(ctv_ca0_x509, ctv_ca0_x509_len, clavis_keyring),
+			0);
+
+	clavis_enforced = true;
+
+	/* Enforcement has been enabled without an ACL set. */
+	KUNIT_EXPECT_EQ(test, verify_pkcs7_signature(mod, mod_len,
+						     mod + mod_len, sig_len,
+						     machine_keyring,
+						     VERIFYING_MODULE_SIGNATURE,
+						     NULL, NULL), -EKEYREJECTED);
+
+	/* Add the module ACL. */
+	key = key_create(make_key_ref(clavis_keyring, true),
+			 "clavis_key_acl",
+			 NULL,
+			 ctv_ca0_00_pkcs7,
+			 ctv_ca0_00_pkcs7_len,
+			 KEY_POS_SEARCH | KEY_POS_VIEW | KEY_USR_SEARCH |
+			 KEY_USR_VIEW, KEY_ALLOC_BUILT_IN);
+
+	KUNIT_EXPECT_FALSE(test, IS_ERR(key));
+
+	KUNIT_EXPECT_EQ(test, verify_pkcs7_signature(mod, mod_len,
+						     mod + mod_len, sig_len,
+						     machine_keyring,
+						     VERIFYING_MODULE_SIGNATURE,
+						     NULL, NULL), 0);
+
+	kunit_deactivate_static_stub(test, clavis_keyring_get_fn_ptr);
+	kunit_deactivate_static_stub(test, clavis_acl_enforced_fn_ptr);
+}
+
+static void module_revocation_tests(struct kunit *test)
+{
+	/*
+	 * When this test starts, the cert used to sign the module is both in
+	 * the machine_kunit keyring and the blacklist keyring.  Also the
+	 * clavis_kunit is not in enforcement mode. This will test the
+	 * PKS_REVOCATION_PASS.
+	 */
+
+	const void *mod = ctv_module_rev_signed;
+	struct module_signature ms;
+	size_t sig_len, mod_len;
+
+	kunit_activate_static_stub(test, clavis_keyring_get_fn_ptr, clavis_key_get);
+	kunit_activate_static_stub(test, clavis_acl_enforced_fn_ptr, clavis_acl_enforced);
+
+	/* Remove the module signature appended information at the end. */
+	mod_len = ctv_module_rev_signed_len - 28;
+	KUNIT_EXPECT_GT(test, mod_len, sizeof(ms));
+	memcpy(&ms, mod + (mod_len - sizeof(ms)), sizeof(ms));
+	sig_len = be32_to_cpu(ms.sig_len);
+	mod_len -= sig_len + sizeof(ms);
+
+	KUNIT_EXPECT_EQ(test, verify_pkcs7_signature(mod, mod_len,
+						     mod + mod_len, sig_len,
+						     machine_keyring,
+						     VERIFYING_MODULE_SIGNATURE,
+						     NULL, NULL), -EKEYREJECTED);
+
+	clavis_enforced = true;
+
+	KUNIT_EXPECT_EQ(test, verify_pkcs7_signature(mod, mod_len,
+						     mod + mod_len, sig_len,
+						     machine_keyring,
+						     VERIFYING_MODULE_SIGNATURE,
+						     NULL, NULL), -EKEYREJECTED);
+
+	kunit_deactivate_static_stub(test, clavis_keyring_get_fn_ptr);
+	kunit_deactivate_static_stub(test, clavis_acl_enforced_fn_ptr);
+}
+
+static void unspecified_signed_tests(struct kunit *test)
+{
+	key_ref_t key;
+
+	kunit_activate_static_stub(test, clavis_keyring_get_fn_ptr, clavis_key_get);
+	kunit_activate_static_stub(test, clavis_acl_enforced_fn_ptr, clavis_acl_enforced);
+
+	KUNIT_EXPECT_EQ(test,
+			verify_pkcs7_signature(NULL, 0, ctv_data_05_signed, ctv_data_05_signed_len,
+					       machine_keyring,
+					       VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL),
+			0);
+
+	/* Load the clavis CA0 in the clavis keyring. */
+	KUNIT_EXPECT_EQ(test,
+			x509_load_certificate_list(ctv_ca0_x509, ctv_ca0_x509_len, clavis_keyring),
+			0);
+
+	clavis_enforced = true;
+
+	KUNIT_EXPECT_EQ(test,
+			verify_pkcs7_signature(NULL, 0, ctv_data_05_signed, ctv_data_05_signed_len,
+					       machine_keyring,
+					       VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL),
+			-EKEYREJECTED);
+
+	/* Add the unspecified ACL. */
+	key = key_create(make_key_ref(clavis_keyring, true),
+			 "clavis_key_acl",
+			 NULL,
+			 ctv_ca0_05_pkcs7,
+			 ctv_ca0_05_pkcs7_len,
+			 KEY_POS_SEARCH | KEY_POS_VIEW | KEY_USR_SEARCH |
+			 KEY_USR_VIEW, KEY_ALLOC_BUILT_IN);
+
+	KUNIT_EXPECT_FALSE(test, IS_ERR(key));
+
+	KUNIT_EXPECT_EQ(test,
+			verify_pkcs7_signature(NULL, 0, ctv_data_05_signed, ctv_data_05_signed_len,
+					       machine_keyring,
+					       VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL),
+			0);
+
+	KUNIT_EXPECT_EQ(test,
+			verify_pkcs7_signature(NULL, 0, ctv_data_05_signed, ctv_data_05_signed_len,
+					       machine_keyring,
+					       VERIFYING_MODULE_SIGNATURE, NULL, NULL),
+			-EKEYREJECTED);
+
+	kunit_deactivate_static_stub(test, clavis_keyring_get_fn_ptr);
+	kunit_deactivate_static_stub(test, clavis_acl_enforced_fn_ptr);
+}
+
+static struct kunit_case clavis_test_cases[] = {
+	KUNIT_CASE(builtin_acl_tests),
+	KUNIT_CASE(register_key_type_tests),
+	KUNIT_CASE(clavis_parse_boot_param_tests),
+	KUNIT_CASE(key_acl_vet_description_tests),
+	KUNIT_CASE(key_usage_tests),
+	KUNIT_CASE(signed_acl_tests),
+	KUNIT_CASE(module_signed_tests),
+	KUNIT_CASE(module_invalid_signed_tests),
+	KUNIT_CASE(module_revocation_tests),
+	KUNIT_CASE(unspecified_signed_tests),
+	{}
+};
+
+static struct kunit_suite clavis_test_suite = {
+	.name = "clavis",
+	.suite_init = clavis_suite_init,
+	.suite_exit = clavis_suite_exit,
+	.init = clavis_test_keyring_init,
+	.exit = clavis_test_keyring_exit,
+	.test_cases = clavis_test_cases,
+};
+
+kunit_test_suites(&clavis_test_suite);
-- 
2.45.0


