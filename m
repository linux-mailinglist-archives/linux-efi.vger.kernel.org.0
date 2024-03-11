Return-Path: <linux-efi+bounces-801-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C2C878543
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 17:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8ADB224F3
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 16:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6485EE8B;
	Mon, 11 Mar 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SzzriLYK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gky1epG/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5785EE8F;
	Mon, 11 Mar 2024 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173999; cv=fail; b=jGZTRn7lxQjBG7LM/8tLMZKpsNvW3bWQ4u0eb6U0owHGQTIQZLv/xO0MKBmr/jnR+gIuMLgMn5bMriD/q805BAzfJtODfYrepDtJIyFA+coUn9nby+kTJes5nXHAREf4ehg232r6N0pBufS9SgtKhY4UgMmst3p7sj7lZPU+jbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173999; c=relaxed/simple;
	bh=wm8Dj8dSJjDG8brSc5THtJSt5alYIS+iFN9VploHjrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=afVRN9cDDe/8mPkaDPOG02LuHpRQdqK0fiN/pJxyZk2N+TJvNE/h4/bwiwuBRDzBGaTaZcGCjluqG2MhxKp4Fkn/gv8MHoz7Vi7w906wGfmBzhiwyl1mjkFbhDq0KPUSB5nAqdvM2EWl9+X9tZvnXiVbwavba5j63Bz44aWxe8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SzzriLYK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gky1epG/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG46pc011913;
	Mon, 11 Mar 2024 16:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=NwhN4z/bJE5kk6l+0B7GBx7x2kvY02UB36GOgIBztC8=;
 b=SzzriLYKDeqiyvM2kq2VZv1jMiMufWCBavJ8qppmAXNWJVtwFYJ2T0fASoL94TViZGhw
 5aTGBlp3QXchXO0LKIK7AxDp98CMpaQxyxyjHS9iO37t5954JdIrrkVam0xUF0CDlhRj
 REH+mL1OTxGsfW9hO8CHrTEVDrie4n5rDslp+yOduWh9/01CVcfxUtIbGw1Lo5uvYpYX
 6+0OyplxjoFVWFm3QfMXXMIUss/Lg+Sm/ni9u/xK4gwn+38H7pL0ryFQSFw7bbFLYIiX
 jYsXuaSzyoh4ZGi1FiG6WXOXRJNmS8E1jAPnjARGuzNOKRXp4a3ktoxonwXegxjS4UUT lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ebsks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BFvUUD028739;
	Mon, 11 Mar 2024 16:19:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75yf79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsCff1boM2wE3e2xhlS+YqJ7qxZrA69KbEwpKorhG6KveD2p1KG/ryKfUH63ogqB4kxxATEm9Z/ls6HVBf90uUnI3ca/O2Ipi2Kk8H3m612x7LbAYQPJuNrkPrZ/OUHtk2fAGGQqVv2PiwPIVoeGmWfpJBw9gOdZ4E6ZiG44jsycYTaKQys4Acd/DYFabefQYSe/vL0GB2pFNr8olpJc9CDcmrH3MgEZBHu0Wu0FjexcS+9feP9ZUsitBE9O5dTdOKB/zSk66ofiC6OiWsc1LclnKx3m6rEpCfhG6RCpnW1WsEjwUxpsDNQ2e7wkXJo9qtb8k+9GulTgY5AtHYkyUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwhN4z/bJE5kk6l+0B7GBx7x2kvY02UB36GOgIBztC8=;
 b=lYpZ8szgE7Af/gp8ImMPT4RYgg0N5pFRlDgtwyYUj3PAw5M0ZVsY2flolGLZGkM+ogqbS9O/PhaYmmzKQz//Xjdc2hTyNp6w7Wzsf2/oRQzUf34AoBHTCS7ZReIA4PaIKmXLm6n0H59zyLVLutje3249O2AXoocm8cGmYbcWhBJ1YtmQ6bsx63L4U0oWxBZllT1hyf2+s9geVsFW49bsFk4N/eb7SCt1XfUwI09hFQZ8qrXNZnKZQ5PSmGz/hb/oSKKo7W92l6Rmy2ANnTps0PcR+HUwUhB8oiCsxda1aohxKMJCO6mzB7y6BJJVqECA30UXfcS1mo+0Q6Q4Hr4b8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwhN4z/bJE5kk6l+0B7GBx7x2kvY02UB36GOgIBztC8=;
 b=gky1epG/4v1Y+ai0HIio+AaymDrxCebgdizKOpxV91h7Z1mPnxfkXjEo4bDWN1MKogyLv/rAdUquPWxSf0YafYTGIvW3OzksrpUJeV86c8J4c/hVIWP4EPPzwA3tiEWv6iwIK/x4jHkRUPzGALJKgRv6PTF+ePhXr5aPIwvBPuM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MW6PR10MB7589.namprd10.prod.outlook.com (2603:10b6:303:23b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:19:29 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:19:29 +0000
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
Subject: [PATCH RFC 7/8] clavis: Introduce a new key type called clavis_key_acl
Date: Mon, 11 Mar 2024 12:11:10 -0400
Message-Id: <20240311161111.3268190-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240311161111.3268190-1-eric.snowberg@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:208:32d::9) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|MW6PR10MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 23afda7b-2f1f-4edf-b1fa-08dc41e706dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aV797qFYRqzOLoGyjpgfyZ1wXBNhdjFB67RTbYhFRd1kYODxYQt6hUrR3qxpaTulDq+3g+i3FvLcubXXc2lfGuTTzOhX1VDAFEm1P9fw2a22I1mkmTBW0MQWqp8BWsVzdpFawvkxf3+Ay6gtcyU8TamgxTKSBbmcfPmijYAZTnnaw3wm8R0FgsidF5RvMnVaQ0xiF+wOxDLN731bFLwDAQQ9gLJJ9ytaK4y+YKw/Vj49TEzD9YKlUON/vwsdxTDLq9751vpfa+wg7niRIh9QnfOwoitz9TkEy1wnpJS+T67C4WLP1ON6YdNvxUZ1qmSYB6m6ryINilm7S52fBHubw60CXiX+uhb+kTWu6yjaViKkOR4lvlM4CkuuLqZGJ+AF/w/QvRUEg2ix//Ygj4XPQpusIY5TUD8DjT4iFpID0AWr7CKaM2gv9WLbppBuhNhIMKLJaw+EHMUz2srE775gDAlMAhD9rvISJhg58ZPl05416ImbstN6QOpcktHiZxjHs7lwiuRMkb3xemSc61wWUrhWv7IaZifNQnHYRFeWJ0PYnd6E+ZWnrwEFoQSfi8H1UCSPvw1UqjQlwsMThMBEFMKCWpr4ptgrpWUWeHgzXjBHXrrdFX3XQkBSvzOFoNLNHqGueE1QYqfL1JMn3TEw8rI8maC0Ge48HPjg1FZ3mpM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Zsy5914wzKOsrF7V8jdxP6ThZKvy9jgDKV56u5HmD2F5PcJ3Ci9cZTimcZiK?=
 =?us-ascii?Q?jAArQNAytRNSJ4Bu2nFy1D3IhS+ak64DTj+CqhGWdZRxVHRaF7+Hfny15/3h?=
 =?us-ascii?Q?nBugwtXH0FQAGCPGvj4Eh/mrITqcdES5Pg3T+aF9+yiMUGS88ypgaoyK1W94?=
 =?us-ascii?Q?FT/855wpXBj5Ead+A5F21dt74YivnMafvzuo0MpztYgPEgQrz8C81wykIrZf?=
 =?us-ascii?Q?1Uq5EMQ457qD96XaSDAmVzZ8wxpbyBEtULtimimeQb5gcoLRRlJ8tAKK25Nk?=
 =?us-ascii?Q?PQ3KI3DJJUU4GcUYTId8f+H+NkoNf7JSCSdDlWqWIVaKr8WtKP7rA7Nm2Dym?=
 =?us-ascii?Q?a2o+WcY6llgXOS6xafof4s9+YoxybKhTMpeflja7FHpRyFz7Cnnl5MqX5VSq?=
 =?us-ascii?Q?S5SHKgBwoDpO350J3gRRxTON3rECAm3dabgS2e5+yV2m0hafix6QFtGfCwbs?=
 =?us-ascii?Q?ML2N5GzCxNNImpK/P0+pRC4zFJNcfyRGR9CTUbuZhnh6+IYJX0p25PfN+JgV?=
 =?us-ascii?Q?KopBYckWuFXLZH5sQkX5xz/aE8ulRCr5nrAdTj6TNpteZv2b7ZdnMROU5/eY?=
 =?us-ascii?Q?VtYCYJr1XRjKau2L99HEHTrxHfvb8/3nY1i0hO6MaadV2SzQhl/pn8nBcvEo?=
 =?us-ascii?Q?nvgUA6Oipv1hEJPp3KiUJLiEj/rqJQgePfAz0aGa6fJmi97BolEo3NsEJF2x?=
 =?us-ascii?Q?LOeJKJBQZiqhhFKdeokvf2a+8gC01AlMez15khp39u0SFp2GhuLjWS4nAqxk?=
 =?us-ascii?Q?KhyjrW8MGhpdolzOhbhCoreRgeIO/++Mg0r6f03LJwB4daqea16BG11PWFGW?=
 =?us-ascii?Q?NvsH5YrWmm7jyhDB7jBmURGN2q1w5epp+VbESGR6lxrRtwbeWL3L5MAjFtpQ?=
 =?us-ascii?Q?X22n8BBsBUXtwxreTo6j62PiGs9q17cGeRfDWaA+xSJXImMsz2oNVgyFqTIC?=
 =?us-ascii?Q?c44KMztF9iUghC81485XL3X8weRnwgmRedLFSFXYdR5pWsfJJkKIznuUtyvc?=
 =?us-ascii?Q?FxQAFEkd0wwP1pDlhcqIPtjK1CyMV+b1qajXPj09gbQb8GXBh213HyIkysx5?=
 =?us-ascii?Q?+aMKMQlFYPoGiGRsH1DvrOK0aECPHzG+C0/UWhXGDrS7SNMatKdc4SkG7P3K?=
 =?us-ascii?Q?wiVjWQFDocw6y9izRkAX0pL4+1iYlXz5z/YkqLzXeTOdkfOVtu6qAToarxpg?=
 =?us-ascii?Q?bUo5ZxoLjHy1DvXsIWtaJyF+YfmZ7NFfk3quP5PXat7g4DlrkbU+h57W5392?=
 =?us-ascii?Q?uRqIfCanIrIzl3c9QA17FZmoIwl3F/P3b9wsAcSQUUW8CkOIOWgb8yFHrPGo?=
 =?us-ascii?Q?w138lDSzx54Nio383pARrsAQpJMIBN+iI0k8he7VGKHynAPDRFHzowMt3Ta4?=
 =?us-ascii?Q?StRns0o9DhG25D/OxMqpGhYogMf1MDjmjUp8lGaWDYcGoDeSzPMpYewCOMbU?=
 =?us-ascii?Q?fE8ZtSxSdRo1uGRKX79CIhA2p0jB8qpEXCaQQ47ZK0ohmb5M0ck/exRYCqJK?=
 =?us-ascii?Q?tFP3GSQ8EaRUFwK6okURjgLGvNoflpg1/VF1n4WfvSUOLPWdwo1S6DZNK05e?=
 =?us-ascii?Q?yM1NqDqnoiiNMAhCyrUhL51CwiaVZkglVV6ppe3PywnN/kAPmh1UTQ9BPXId?=
 =?us-ascii?Q?pnOwBeBIGhKI0rUOXoqsUIY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	d0Xe0k7heDXZq8cwcBsODmtnHPBOKxTV7nApRcz8ySTfGZoSnz44TXYqiFx4PvialERqxMrFj9HAE0MM+NoZpjp9J4vZUVZU72AOfCuctj7a8dTh8DWlJm2JzdaLhQRfzyhh98YEPIYeGnoy25OqdPR4ihRhANaPGQg3anZU9TxspjWkiFEIYc3wif4atJoGHJVt8hprUlpF/WpIYlLC2XrIrIscjNJWlNYXJmJWkcyCsN5qZ2BmciAv6oR1pcQfiCc5g9uMkYsaV1eWy1HjdIWkTnNwqNfKep+bPtG5Xg68ffrk0pkhwioekFsFkANQrm2j534Q6G2D9EcX9rSYoN2UGJrLsS1DcgGokK0CLENvOjgfj8BBXe9Z4lks6MyyDD76eZTen0BzKIwWNcbTXT3wwFzCbS+0Gu/gC39cmEDYOJydqES1kz7YfuHrGz4u5DL/b1gLmXdn/Pj/bltiG8LlWUSof+UvAkmVx6IxtGbm+l+t5rHXy7G77IqqxUrFMxkzNiUMdhuP5/ZuqGmr4S330fdH12mdzuKTMbsrA7wEdbQku8FHG2/6R06rhTzh+ja1Wjwg8lGUgNXXvaQF8/6VnW21ONOwrjgKCzHY1VM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23afda7b-2f1f-4edf-b1fa-08dc41e706dd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:19:29.1449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETvNDQK1WzKK7uUihWGHTKLoJu4yvWhqMFte/eWH1H/cLQIO4HpRXQdlBEFTjPB9zAtJnWSA581laBKtth3+jtNaCa63G/3X3c78CIqxMFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110124
X-Proofpoint-GUID: S5r15CYYLK2A0Vrt1f7wUis8c-3gORHC
X-Proofpoint-ORIG-GUID: S5r15CYYLK2A0Vrt1f7wUis8c-3gORHC

Introduce a new key type for keyring access control.  The new key type
is called clavis_key_acl.  The clavis_key_acl contains the subject key
identifer along with the allowed usage type for the key.

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
 security/clavis/clavis_keyring.c | 127 +++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
index c5606ed101f6..0ab2341d47b8 100644
--- a/security/clavis/clavis_keyring.c
+++ b/security/clavis/clavis_keyring.c
@@ -1,13 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/security.h>
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
@@ -15,6 +20,123 @@ static struct {
 	unsigned char data[MAX_BIN_KID];
 } setup_key;
 
+static int pkcs7_preparse_content(void *ctx, const void *data, size_t len,
+			      size_t asn1hdrlen)
+{
+	struct key_preparsed_payload *prep = ctx;
+	const void *saved_prep_data;
+	size_t saved_prep_datalen;
+	const char *p;
+	char *desc;
+	int ret, i;
+
+	/* clavis_free_prepase will free this */
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
+	error = hex2bin(data, desc+3, hex_len);
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
 static int restrict_link_for_clavis(struct key *dest_keyring,
 		const struct key_type *type, const union key_payload *payload,
 		struct key *restrict_key)
@@ -30,6 +152,8 @@ static int restrict_link_for_clavis(struct key *dest_keyring,
 		return 0;
 	}
 
+	if (type == &clavis_key_acl)
+		return 0;
 	return -EOPNOTSUPP;
 }
 
@@ -64,6 +188,9 @@ static int __init clavis_keyring_init(void)
 {
 	struct key_restriction *restriction;
 
+	if (register_key_type(&clavis_key_acl) < 0)
+		panic("Can't allocate clavis key type\n");
+
 	restriction = kzalloc(sizeof(*restriction), GFP_KERNEL);
 	if (!restriction)
 		panic("Can't allocate clavis keyring restriction\n");
-- 
2.39.3


