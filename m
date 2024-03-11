Return-Path: <linux-efi+bounces-802-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E710787854C
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 17:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164491C208C4
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35903604AA;
	Mon, 11 Mar 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oAHzprVP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="alxH3Rob"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C255FB83;
	Mon, 11 Mar 2024 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174007; cv=fail; b=YlA6rg6BF2mLwZLZFstn/wl9wZjWtyO5C9YrFP3PdKDM04vwbb0Sm/RrN1RU9LfArkusRTa310aLld8n2gEYyQ4zzM6PnyIkYafpoXemEy/7LCtfiytxRgCkgBLWxSctkj5b4RQ3YXzO5nL16z4YWyNxVOnAu3ODlxj+ZRWR3B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174007; c=relaxed/simple;
	bh=Gdbw7drNWUl4BvbCb9zrBchuA2i9EvdrTIr/j9yX2H0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rfT4EdEw6oRCbTL9QV4oQZL3XorfxnMjWGDwBbAN4+ZQmRlm/MAsV5gUStz6Sym7QavX3C/dO3zDQg5zrGzb4gIrPV/8punHkmgY+Dk0T9Z9al0vIm5kvevRyXNJzIKM38Vks/wedA/veXN3G4cTr44n4eAlL2f+mv0/rTH51tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oAHzprVP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=alxH3Rob; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG40Fd008055;
	Mon, 11 Mar 2024 16:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=yiSsCBRB4tozPQEV+8nvvEDL6JPy5alzC2vv5xc0rLE=;
 b=oAHzprVPWrR1uxSvus1Ws/wLPCkijuX3vi/H7Wz2Sv5/CS6HR3yzN48lvAgc9enhTCJ6
 M24lk2Y7NFAcC4CsHCUxo35z+7NHjlL/nD3tnoTbN9P7VQ8H6M07cEd7eE6Zvl959DqI
 KNAE2LHuzrbeCYHljKlBJiuJAnQsPwix+FSX5yz1Su0H+S5wOqfj0Eeak9DMFEOxdSRb
 Egc9LHYj/hHAz6gF/sINlrrMLv8vqH8cxgrKGIZuKVSj3q4sgou7KMDFzaZ8x4ojMe4D
 fFrFbc01iOeItIBFlKQ95jrT30CRTbr91Z2cMsGc0+sfYG+PLGX5EEHfPKDIgsKr2y/Q /g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdbtm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BGAZPv019729;
	Mon, 11 Mar 2024 16:19:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75yw8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2GrxpI/67W74j2QxKhOEXaQ8OjNX+N8dmSISq0V12eslcl8795kcwu8NqP0CLdJE2RmQT1jGFrXNGNPR1rckQFAGkQJ2v1y17Pc19WI8RA/4VJBSIp+S4v0+ygw9rQiiITDt9vLp96zegbpzEYTuMOd4pVINcsQ/aN0CpUEpdvXfT0cxt5PCib4zU1wNHCP2XD9REsoeFQq05rxC6eSEEsJr3fnGXxcs6QoVEb9fK+KIMjVm5oaWROrS8fqNEvRHVf7LfOQm3de6z7hDn3JpomCasdLH5RqMBzypQG3266ljpQOfi2OeZzLrCKWjckXnCKiC0KaR9wEBFgUeCLUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiSsCBRB4tozPQEV+8nvvEDL6JPy5alzC2vv5xc0rLE=;
 b=CydUNS+n4s6Ad9sTWoBKthBQSdFef/29F2Dal4HawMuDVa8acj9z+Le8oQlPRuhl5+rQQMgDpi6XKmU3kQbIKd9WcONj/FM+6wwBiVHpUKTEFprhpyK5YYoPY7/R+TGK9FIH/3jjISF/jJaeAEr525PqN+b+Dq3WtWZqKeFMTIpfj92vrEDDYXH8eDCD4Bs8FfMEpZOW8Ja+WjS+Q4I5MwuZ9aE9G+Mu+LhbYdz/NCwWv9p1mF60NARk9eCHuXAz911AJDW0PkXaRxQdL/IpVy9XtELe0zNepxrOJy+qf1iaal9L5ZZJm86PUhPRC7pVeTCi27BEni4U3SAY8jOZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiSsCBRB4tozPQEV+8nvvEDL6JPy5alzC2vv5xc0rLE=;
 b=alxH3Rob4wfRs4CwdIKcMxnG/fFOO8aLiwEjDJnhOCMenxR5f2ZF4VOSa/bAnqR0aFJUkeMWQVCkTLlDyMPSCZIqkIBDOufD6M/4sxXowudHi88EFpBZIhiEtJD/jsP0ov6GfQIjgX4dswpSEZcHZm3GQkHSqmrVnN/36g+vooc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MW6PR10MB7589.namprd10.prod.outlook.com (2603:10b6:303:23b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:19:34 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:19:34 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, mic@digikod.net, casey@schaufler-ca.com,
        stefanb@linux.ibm.com, eric.snowberg@oracle.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH RFC 8/8] clavis: Introduce new LSM called clavis
Date: Mon, 11 Mar 2024 12:11:11 -0400
Message-Id: <20240311161111.3268190-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240311161111.3268190-1-eric.snowberg@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:2d::35) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|MW6PR10MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: cd958dd8-bec1-40de-e047-08dc41e709be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ui6Ef8s5YWdXQZi2sqpX8FOMU8cngw4xz9E1AeGcu+WIzJPOWylTsE197/zUyvFDPXM+BNDI0+L7M7d7M8Aj/76elOYFaHAvbrI7sz3Xm2+AgLm0OFvK9dNA25BZinZE5NWDDV36PUeomFt7UlVqIgmgfzlPb/JhwB8A018MhBZ30hvllhQxVlNkOgv1Yr5oQqkKg+/xMFm554IQY7KvKAlaWNe+PaG4vu8ax/KrHI89gboKmst2SY59x9M/8ct2VL0kAWfYgbiOK341viw8UOJUOphU+8We3RE6qidhV4QcT3bKuKYvDrxgC9LZ1Gm32rk3eIpClo23q9M2kC6agTcHE8MkmTVUUITbmBK9CvmzrLkuqOfyxztrmfvoMLOH1yQPZI5eIm2JqeI9LviL60YG7tAy1wwf0DmrIl23OyozctUc/7xwUGQHnM+OHbpgj6Jr9GAT2JdMBpT6vdW5VkvcR2SP7dbGW1g7PxnNNyKg47cK1vE0l196h/n24L6bH9wUIG62UHcmMtAHyUvcRbb4C2EjANcycF5W4oaDUV7YX1M+0ghmXy36QMETo9l9eyXF0w8u+xZhX+sZSQkk+4xvixlEXki4FV2fvpBCUBT1jirhjbYXv+pN4qrudOsX/zH/ViohV5/8241DYRjnzvTMCmLPyv566r4VZv5F+FM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uWYaHs+Xk8wAAKIgxcmqq0U1edl5y0mizPj/aft5hr6FLfJKZdTU05L8mv1E?=
 =?us-ascii?Q?733IfUj8gPE3grkGU8nELvti+BVazAS2gxGz9YPUV9KpGcEDtJETFnamBFi5?=
 =?us-ascii?Q?JoElKIA23vnXeJpzEqVzyCurN++VMj0ioqJ5UDij+hyiPijcJmxhN4KrqyG0?=
 =?us-ascii?Q?U87UBHqoNFbyqPTGkaAwDTa2T0gx6a5yjRTXovgMzDMbU+v0BUqGDZtzq6Sx?=
 =?us-ascii?Q?fnE820YAW/zGc5UP9TlsrRcRMGrp3FgcxJHqbZgGozzcL99KzRYEIjZcjdE2?=
 =?us-ascii?Q?KV23ZYxAjOyRF0hvOpLBze7N0y2vv/6srC8llypxANZpqcm7bGxmBfr28qyR?=
 =?us-ascii?Q?cb61O+8mgN6+8SomSFYcesv+22KJaY3aAEbAH9b3BXoM/BH9DKOSgOEyWGRo?=
 =?us-ascii?Q?PHZL+U8t0GZC1/XctBZGBgxUQaj08QsJjlsb+jPbvWoSgeYgqLFdXzlY8SHE?=
 =?us-ascii?Q?rPjS35gUK3OP2ZpW/yTcPD2QXnZPkZ90XHiMfiTy1VijSkXQkyCiKe6zhUiu?=
 =?us-ascii?Q?vUnOw2tq7CPDt8QQg0/orqRi3vVsZ4u5xylRzL02lWz/Myz8jJKIMox9f4r8?=
 =?us-ascii?Q?7qMlUKn4MZONnN88kTNYVWErQdCH84vJilBj3ZrPPUkdXoqYgETZoKt4NJOV?=
 =?us-ascii?Q?rBKy9jc34eXtwF1xuDidBaUyUYOaiYh3j0nsn+GWK5MdTwQISsS0N/IWZzpB?=
 =?us-ascii?Q?TonUwVxiIZqsar35ub030wFaiTVW9+VK+u5gZpxZK6whv6JjqyJOf8RYEwR/?=
 =?us-ascii?Q?6kZOUoJoVZTC2fI3XJEBXi8QP8qhnBqn2ETFybAEGUtH25Jb1jwWVURtkUGG?=
 =?us-ascii?Q?ExnYbNGGZFGUphg8cLA8WtlFmjkMwZaX/YEuJpvTk0y5rChF/ARqj9mPBNE9?=
 =?us-ascii?Q?81+zR7PYhnXnR5im9qNjZd1D26OB8AerimU73wQAD05eSGZ630bFsS0HskJ7?=
 =?us-ascii?Q?6VvB8ew8KGr5IXSjioqZWbcvxMiedq+AlbAO3znz4+g6tZHBPuBNmO4iT7Wt?=
 =?us-ascii?Q?WvrqpBlsadPB8t5CaLyEq6+M+gGjFX0m3DKPYf3KHapjMHrKd4T9E9pf76rv?=
 =?us-ascii?Q?bS9sx3oAbx/6UxGftnrgF9ofCjhDBRRZoHcfkaJ9JypkEwORI+Nwk2AwFl4B?=
 =?us-ascii?Q?BPgVbJE6LQBcIEO2OvrMejz02szAwo86sSDY91LLHhPrtTKYAwjE4STKLFl7?=
 =?us-ascii?Q?dt55hN+Fsa8fBWa2HUuD+LN7EPCEWQbKV4FaTTWUFgAvP+/WPV157oc2zwOV?=
 =?us-ascii?Q?PIfUlJAbyyZCNBoWkzFig7gkT8hmdgm1vwSUilcBhiDCW5kM524MUgbeN5m5?=
 =?us-ascii?Q?7m4X4p9SvrCsacWtEssHTXxKOcJjGalWoLRIQcuLIrGG3Cd94SI5QmOFZnME?=
 =?us-ascii?Q?lesCS+GDFM/x4DUnJnpZxLPz5M2iUvzsF1yIjmAStIBprqC0/eXVwNm9lSxP?=
 =?us-ascii?Q?MmPRHwhwv9Y7d0Mtk3QfpDBQFEJe99gUDfs13crEouolgJ0+FAHAWKvy+2gU?=
 =?us-ascii?Q?UHML/MqoNy4YfsuMoG19hOvCe5+el6FMNARYdRNXj3odlGNgiDHgiVntptRR?=
 =?us-ascii?Q?/LWkaS9NZEhaM6qaOt3Aqsg/0lxeUcojzVgp+wVvEk3czTO/bKI1/wDAJHp4?=
 =?us-ascii?Q?U1ZDSDgKigq0eAMrhlPJ8io=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2y6jpZNgDcL3M5fGTm3stNAV1/BvV+HAx/xt9iCI8+ov9Pn8K/zywDyWRN7SV3iT6yMmMERciPRkI2IwnVLUEJca+BEmNrYeYXrDzDb1IL65n+8DnXl05yADn2duJU2CZdjaPTZskRgKCsF6qSVMa7hbKHkVNPN3QLzMXaN3RWmeGD9+7X/3Bl7psY8S7U7DwgAtH3KiOpnWvs/z0XJhXROtvyelrLIisopnvFoFpBxdromGw8XkOumkJTxoUzSW7bdnOsLGMWomwU/5hk5ef53jcv3/p+VqjGGUjgYXoZkWEhkro/swB3HSY7TYB430vKzoCscGgVjFkf8WMI9p8XIbDID1Y4wAVjt4typGhMRy+dx0Kc9y0JzUCWWMdHeGmYVZSZFv2OuEkCDdtQaQlFuzEynRvEu+PQYg11t1Xxwj8e9ODRnKOzFgJjeAVDbdiIKiguAUUVBGDYmpervbV3AL5PnF94xkqUXOOWLXnuDThqQMfTFFbQ+nTOTGE4IncNGIAmEpe3YLxDxxAlWW5pHqh5b+MAv6suNgrMYytnaRWrmYSNlgXRSbNNzKioJ2K+G4ZM5h+6kQPh8a56NgL6wUSFr3xuvZIDXrxDrLsZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd958dd8-bec1-40de-e047-08dc41e709be
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:19:34.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyekq031puD2fcNai342ejk4ljJ/7vma1wwGwCFM+XqaZbwFlg/66cc8cw51sGyBsXCxsB8952gDC9huNnaak+iqrqF/zHPpy2GY2NrR9II=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110124
X-Proofpoint-ORIG-GUID: yp_kGNpu5uEgkzokwEIWNP_r3M4OQNE1
X-Proofpoint-GUID: yp_kGNpu5uEgkzokwEIWNP_r3M4OQNE1

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
the new RT UEFI var, SBAT restrictions could be maintained across kexec.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 Documentation/admin-guide/LSM/clavis.rst | 190 +++++++++++++++++++++++
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
 12 files changed, 344 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/clavis.rst
 create mode 100644 security/clavis/clavis.c

diff --git a/Documentation/admin-guide/LSM/clavis.rst b/Documentation/admin-guide/LSM/clavis.rst
new file mode 100644
index 000000000000..b0a73defb4fc
--- /dev/null
+++ b/Documentation/admin-guide/LSM/clavis.rst
@@ -0,0 +1,190 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====
+Clavis
+=====
+
+Clavis is a Linux Security Module that provides mandatory access control to
+system kernel keys (i.e. builtin, secondary, machine and platform). These
+restrictions will prohit keys from being used for validation. Upon boot, the
+Clavis LSM is provided a key id as a boot param.  This single key is then
+used as the root of trust for any access control modifications made going
+forward. Access control updates must be signed and validated by this key.
+
+Clavis has its own keyring.  All ACL updates are applied through this keyring.
+The update must be signed by the single root of trust key.
+
+When enabled, all system keys are prohibited from being used until an ACL is
+added for it. There is two exceptions to this rule, builtin keys may be used
+to validate both signed kernels and modules.
+
+Adding system kernel keys can only be performed by the machine owner, this
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
+clavis= boot param is not used, the keyring does not exist and the feature
+can not be used until the next power on reset.
+
+The only user space components are OpenSSL and the keyctl utility. A new
+key type call clavis_key_acl is used for ACL updates. Any number of signed
+clavis_key_acl entries may be added to the .clavis keyring. The clavis_key_acl
+contains the subject key identifer along with the allowed usage type for
+the key.
+
+The format is as follows:
+::
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
+The clavis_key_acl must be S/MIME signed by the sole asymmetric key contained
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
+::
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
+  emailAddress = john.doe@foo.com
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
+::
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
+::
+
+  mokutil --import ./clavis-lsm.x509
+
+and then reboot and enroll the key through the MokManager.
+
+How to enable the Clavis LSM
+----------------------------
+
+Add the key id to the clavis= boot param.  With the example above the
+key id is the subject key identifer: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
+
+Add the following boot param:
+::
+
+  clavis=4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
+
+After booting there will be a single key contained in the .clavis keyring:
+::
+
+  $ keyctl show %:.clavis
+  Keyring
+    254954913 ----swrv      0     0  keyring: .clavis
+    301905375 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
+
+The original clavis= boot param will persist across any kexec. Changing it or
+removing it has no effect.
+
+
+How to sign an entry to be added to the .clavis keyring:
+-------------------------------------------------------
+
+In this example we have 3 keys in the machine keyring.  Our Clavis LSM key, a
+key we want to use for kernel verification and a key we want to use for module
+verification.
+::
+
+  $ keyctl show %:.machine
+   Keyring
+    999488265 ---lswrv      0     0  keyring: .machine
+    912608009 ---lswrv      0     0   \_ asymmetric: TEST: Module Key: 17eb8c5bf766364be094c577625213700add9471
+    646229664 ---lswrv      0     0   \_ asymmetric: TEST: Kernel Key: b360d113c848ace3f1e6a80060b43d1206f0487d
+   1073737099 ---lswrv      0     0   \_ asymmetric: TEST: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
+
+To update the .clavis kerying acl list.  First create a file containing the
+key usage type followed by a colon and the key id that we want to allow to
+validate that usage.  In the first example we are saying key
+17eb8c5bf766364be094c577625213700add9471 is allowed to validate kernel modules.
+In the second example we are saying key b360d113c848ace3f1e6a80060b43d1206f0487d
+is allowed to validate signed kernels.
+
+::
+
+  echo "00:17eb8c5bf766364be094c577625213700add9471" > module-acl.txt
+  echo "02:b360d113c848ace3f1e6a80060b43d1206f0487d" > kernel-acl.txt
+
+Now both these files must be signed by the key contained in the .clavis keyring:
+
+::
+
+  openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in module-acl.txt \
+        -out module-acl.pkcs7 -binary -outform DER -nodetach -noattr
+
+  openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in kernel-acl.txt \
+        -out kernel-acl.pkcs7 -binary -outform DER -nodetach -noattr
+
+Afterwards the ACL list in the clavis keyring can be updated:
+::
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
index 960512bec428..64725ea4f881 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5137,6 +5137,13 @@ F:	scripts/Makefile.clang
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
index 398983be77e8..19892e1aa18b 100644
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
index 7e4683035d34..d18bf16feb2c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -408,6 +408,8 @@ LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
 LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
 	 struct key *key, const void *payload, size_t payload_len,
 	 unsigned long flags, bool create)
+LSM_HOOK(int, 0, key_verify_signature, const struct key *key,
+	 const struct public_key_signature *sig)
 #endif /* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
diff --git a/include/linux/security.h b/include/linux/security.h
index 94661398708a..e672a180714d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -62,6 +62,7 @@ enum fs_value_type;
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
index 7f5a52b7cefd..f158c0e6b8dc 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -234,11 +234,11 @@ endchoice
 
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
index c008cb74c762..60f72cf96886 100644
--- a/security/clavis/Makefile
+++ b/security/clavis/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SECURITY_CLAVIS_KEYRING) += clavis_keyring.o
+obj-$(CONFIG_SECURITY_CLAVIS_KEYRING) += clavis.o
 ifeq ($(CONFIG_EFI),y)
 obj-$(CONFIG_SECURITY_CLAVIS_KEYRING) += clavis_efi.o
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
index 3883c390b9e4..886a85d82518 100644
--- a/security/clavis/clavis.h
+++ b/security/clavis/clavis.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+struct key;
+struct public_key_signature;
 struct asymmetric_key_id;
 
 #ifdef CONFIG_EFI
@@ -10,3 +12,5 @@ static inline int __init clavis_efi_param(struct asymmetric_key_id *kid, int len
 	return -EINVAL;
 }
 #endif
+
+int clavis_sig_verify(const struct key *key, const struct public_key_signature *sig);
diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
index 0ab2341d47b8..cc4527b417e1 100644
--- a/security/clavis/clavis_keyring.c
+++ b/security/clavis/clavis_keyring.c
@@ -12,6 +12,7 @@
 static struct key *clavis_keyring;
 static struct asymmetric_key_id *setup_keyid;
 
+static int clavis_init;
 #define MAX_ASCII_KID 64
 #define MAX_BIN_KID   32
 
@@ -227,4 +228,86 @@ void __init late_init_clavis_setup(void)
 
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
index 4cb832b00c40..d1da60a1b7a4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -50,7 +50,8 @@
 	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_EVM) ? 1 : 0))
+	(IS_ENABLED(CONFIG_EVM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_CLAVIS_KEYRING) ? 1 : 0))
 
 /*
  * These are descriptions of the reasons that can be passed to the
@@ -5313,6 +5314,19 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
 	call_void_hook(key_post_create_or_update, keyring, key, payload,
 		       payload_len, flags, create);
 }
+
+/**
+ * security_key_verify_signature - verify signature
+ * @key: key
+ * @public_key_signature: signature
+ *
+ * See wheather signature verification is allowed based on the ACL for
+ * key usage.
+ */
+int security_key_verify_signature(const struct key *key, const struct public_key_signature *sig)
+{
+	return call_int_hook(key_verify_signature, key, sig);
+}
 #endif	/* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
-- 
2.39.3


