Return-Path: <linux-efi+bounces-1091-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE25E8D572C
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 02:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903FE2866C7
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 00:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3608318EB1;
	Fri, 31 May 2024 00:41:44 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361825695;
	Fri, 31 May 2024 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116104; cv=fail; b=N7hPuodD0hlsmRnXp9HvBqRX0/azV+QgzL1SoWhxm8tY6Wk7ucdw7ygkG25lanLtS0Y6eZ7ZCNzHAowPTSAi7yp3PzB8FSxmHJIu/4yy+OnFc7HN3UgbELrCQ7OqwLHQr2DreXXqGm1sRCWCZ4YPQKvLM0USld5QTfQ9Wzm8PSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116104; c=relaxed/simple;
	bh=5nglmItgmUESiaBm1j6gAbGqJ7G2YoBCtNqrOtHGk0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MbWMI9nhzS9EQ/z/vyPxzSFpa++b41VBftVdRYivi7tBh/Oyj56ylvTK9T7xQXVJiIcEJkdwYOhQUTIs9QXK7W4SmPc/2F8wxmmbW5HLZLAxEMYx6B7DrLTVNDDzNDdM1VRExDpeXP2jKM329HayCyA1E+Nr7TON2ObxpduIKrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFUsZT002189;
	Fri, 31 May 2024 00:40:16 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DNkzwK8FbIMfPgygTDHv+e0TNJCjRAcHgZ+DBJYVuLqQ=3D;_b?=
 =?UTF-8?Q?=3DJhyCDtFXVyQDqfQ0tcAFw1H66xXEO2fdfMDIfnulCnJBPN2Pfl+iANc2JDoQ?=
 =?UTF-8?Q?PlTRd4CE_E6SfmS/CwrnGAxI3cbBFs8hnQSGeeqK6If0xb6xeqjNKCjO++PZzox?=
 =?UTF-8?Q?ZAxN/oY5ABvVyy_kuh/DlA73zu++ToyuFDJaT3PgzCqfFPeasqU8UXdkP6RH43F?=
 =?UTF-8?Q?lZpx7arpS7w5tTIoB/UY_e1m5njKj2HD9IISfuqDAn5MrescAUtOVBcxwcKcski?=
 =?UTF-8?Q?gn8ETWTB1/Icag6ZwmZMjGkMye_Ge0z7tkeSHf70wp888HmSTnujBLS4RDUU6LT?=
 =?UTF-8?Q?bwfvQjOf2iwxRutw5AMiVRo+9jvsibCT_OA=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kba71d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UNVWIe024113;
	Fri, 31 May 2024 00:40:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52ejv6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQaCjSFB9QHnSMYQR5o/IBBu1K7jMbzLkUXHfrTashpBDrNS1GvcxPROzG2/Jpg083RcpMMkXFi5pKRAsZjexWcAz+Dwqo1Qtca2q39sakoa8omn6vLhOANFp8+zgUhp18NH22MyYfEv6ejrnNoZb9hI5LaXbZUfOX8IVxxxhBV2hBa9uC8koq7vaiFfFw4LUzVOtB95XdvD3/u0L7thflKJYl4Mfv+2O8+J5TTLficE0Lv3nK6Q15vDzujNPJaYnVYNQjJlBBxHzo+Cy9lOj/xxwGSoG863KRIzUF7NhJN1628mVn3mqSe+Ey0rXzI3fJgDxXzZDQ7AMA2+4K5NIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkzwK8FbIMfPgygTDHv+e0TNJCjRAcHgZ+DBJYVuLqQ=;
 b=iizwWBFjSUHXcuUBIbl1jTklXW/Mqg3HM4f+wMrir6ECKHSdHQjdPkrzvWI28YKPG+kC87QOQaQAToOlBT6D801jBIKNTHXP6NG62JyHitHXPPykBmI/tIQuWER/OiJYNe5pwyC6Li6dfEyYznj3MvyEooT8sov3x0tUWehPq3QrPlGd87sW/+YKW+/5hVUS1z2y/q36dfvj+bKnEmnrExYsRtV3awtcRqz3HFGHsWBFryqnQILLBFrdnUqBoHBXz9ffBj2u80gXYywG4EWwv//GyENxWTaXeRxeHF6NoPJ61Gf2kjXL96EDk4e1vKLVKjnwYmQ5GT6GyyWEACy81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkzwK8FbIMfPgygTDHv+e0TNJCjRAcHgZ+DBJYVuLqQ=;
 b=tHMtQ5ndTrO9Tx2r48gAIwnzYuyJMMMQUVWX0T0yCCfLIWH/N+oBLMsBONd8Zjhm/n6dmXCpmQDMDHEpE3SRv0aP95+Ai1SoI06HTXyhJrkNMdKtL7zGoi5YGZkfw/BE4En0K1pJidwC0GSLFEcJ8RZRr1T6awebu/2hBQz8N5A=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 00:40:11 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 00:40:11 +0000
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
Subject: [RFC PATCH v2 6/8] keys: Add ability to track intended usage of the public key
Date: Thu, 30 May 2024 18:39:43 -0600
Message-ID: <20240531003945.44594-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531003945.44594-1-eric.snowberg@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: d81ab9f7-3539-4321-a79c-08dc810a3a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+oJRAaie+W44H4awCDJ5TH7uGwwiV4kInA5K23Ovh7pzWTXBBZMEKFONbnaG?=
 =?us-ascii?Q?Tf7pAn4nzA1wiC5bwA4AyMdIWDstUm0Tdrl+p3hXk1vdtoFEoYLuRh8KIfeV?=
 =?us-ascii?Q?oSnwUDZEJ4I104AMjHFYRoHK1ZfALomL2N2RdadLnbn9c249G5f5LGSBhxvo?=
 =?us-ascii?Q?el6NMeG52gW5cYohE5WlshzeAaPZPyqcPMXbXtx3ezv9C9t/Xqxhixd3RCkp?=
 =?us-ascii?Q?Ncyx+50EctigFcfa0ojRMZD/2HtZG5KaWqBnnD5hEoCFRfBuy6FY5xFDcCqf?=
 =?us-ascii?Q?cjwqQaWCYhhveIvLGU2WGEpWlgptrZFHZB+6dNNDVQnBFDBweXSTyL79eL/a?=
 =?us-ascii?Q?IRZ0LlR5goecvo8CQLbmRkJsOXFnlWAiwtKeslaN0udvSKsLWM33C7JE//5Q?=
 =?us-ascii?Q?X7q+uDOJ4wmOV+Z6FDdCIkes8Kf9CAJbfPlkEeUkMoq0EJMR6THrQOcsBGlK?=
 =?us-ascii?Q?OPf+zRbkmxQgnjMc6oqmDGOYHSrXJ00mTLhZa+6w3FZQTQ83sSmO5+FtEjaK?=
 =?us-ascii?Q?ERUTj6uspqWsSDbI7SbjCSNXbpxrysQmxQXbV/nYMGX3vpKQIn7cBb6WJomk?=
 =?us-ascii?Q?kJYNHDMDlYfHIAkLKZ06+dEJPNHlFxwMqbhxB6uj03qEelGFLypF1V8RY6U3?=
 =?us-ascii?Q?knDyVMPSEhd8OwwcVA58P24i6UMPPCvbbZRQ0VymQ+DwRPy1Se6AD9wXuOqE?=
 =?us-ascii?Q?ThlOgZuKdtyqcxfdwQLgqs7wvetj9XRB7UVl+7696ZSR2OIoMlSCorTZ/R5c?=
 =?us-ascii?Q?lLdjKGKJVOqAYLUJHhqaVVZS4O/8rbBdkiEF81UX8CxBpm0kf5argd3ryhGF?=
 =?us-ascii?Q?hQA79sO0vDbk4xo5NzPctt/rcUc/TYpe+0sGv1eiFqVbih0QnubW3S2ksvSy?=
 =?us-ascii?Q?UwWSFHWVPO4Pg6u3wi/lYu3VbZCfrK7vWgjxADQ4IQtuAIzW6hVPRR7geI8c?=
 =?us-ascii?Q?FO/D4in7pLO6C46GWODvat4S+L0vxrWPOcujKhIAGWHpyz03NO+vysIEVi0L?=
 =?us-ascii?Q?cOJZNdUCVCEWNbdpDV+U/Jg4n15qaSlmyANg0XOB1orq5oikquGI3t/wFSbZ?=
 =?us-ascii?Q?BRkX4Zd0nuChQCoCAANGu/eWE859VDmD5fleXjIOjCeBYQcklpowhzhsUeIU?=
 =?us-ascii?Q?IIOgXt8I4+7Br9nJoy+ks3cxFwYxMcOyzNmLgSyncnjGVGUadPLdNQIyvuwm?=
 =?us-ascii?Q?ip+HuvSQODmzjsQFfiTRVMYj1CP5gGBZO+/XdRJGqTCD7sWS5AfFWwAX7lWZ?=
 =?us-ascii?Q?1+xE7CfaUmG04pQNsrCnOPiEFwOHFC94/msMA9VTbg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lysr31unsBdGWhjnnWACkbCiZqu9bqOGSdNNspRHUxxUVKAi0QcM5oPRNz5O?=
 =?us-ascii?Q?O95cfc5R6uA2j20Vj9klha5dbVD+KRbzu/joauPTXqIEaWRBn+j3qdJgFS1a?=
 =?us-ascii?Q?hIUJPJ/RzRvST0U13TrpLhHAVI0RBhEbhE3a432br+V9Gkk3dz1EtCTFoe6/?=
 =?us-ascii?Q?0XUBk9uAK5jqiQDfLNPK59uJUrUVEvWaDTiAklp+UUv5LYkAUdO8vEXluBDS?=
 =?us-ascii?Q?WOy3fyk2M+FzJ4Lnjwj2KyixthubqiIqRzLvOaW3wYMVnAoZec/Q6lVN+/0V?=
 =?us-ascii?Q?LfDr1Y0tkuXWF8BKxu5UU0awlJgyglzCsju4zr3RZF4sTB98rIRS5cq/6/B2?=
 =?us-ascii?Q?xi6z45NkUrzxEpIm0a18ua9y1lS3TtMjF1R9cID4Ov2KQVhCKm4Lh1Jylde3?=
 =?us-ascii?Q?39KwrIrgPmFILAC4a3jF/MWRlKe3gMZGcIiF0kgDWtZdO59nZtSbNaU+oAPp?=
 =?us-ascii?Q?BW//YuoRj95ZSYN7wQlGVqVjt9p2/9gfUHwPG661WppvgQ0dOsDGAs/6XB2l?=
 =?us-ascii?Q?XtVIM76yfGVpBJRwXICHq2BJziSphSJPKSaSLMXTmRkppj25aSrB+I2pl/Xz?=
 =?us-ascii?Q?x2txYbFtG93OR97clgGhGlP/nPW+g9dqCjHdkO/Te74anuXyP2M8cAW+INKy?=
 =?us-ascii?Q?WacHmXqQ9DJEuA77HDILfreOjjrnKyp6XBes4GqSq0xM38q/E0nQmhoJWhfp?=
 =?us-ascii?Q?6j6jwMEJipF8WKJWBv+cNDRnzCf7j5Y8b/2Cuhhh/oMefd6LbdY8V2/WUAsj?=
 =?us-ascii?Q?jEhKyov8HBn+g1h9AwajiWO5iC3TsIsnp2tAen30IxTyciiworl4gkgd1wfE?=
 =?us-ascii?Q?3ZJRR28owF63OUf9wI886k/C/6R7ChelecjgfrCZnBvZy2DPHC0N8dNB9JQt?=
 =?us-ascii?Q?CqCFdgs7IpHQ1wnNr8dYpG9XxLxBil0IxaLbN5SGhTDjDLHcyGsQAvpMdRs/?=
 =?us-ascii?Q?wlfGAPAk9PpPyh8ENFqx3w+Cipg8Vj5KW5ZTs5vunS/nGMHqTfpZ8OkRhNMf?=
 =?us-ascii?Q?GLpxzFuaTINS9mGd4Z38aARxhQhOB9NDkXm8vUNiAcrsFHiAenp7+1v99sVU?=
 =?us-ascii?Q?ps6DRruGv0KFnluu50gsIK79VPYxAOo5zocmU9wUqCGWgDbUkXSPGO8m9YxG?=
 =?us-ascii?Q?/2AhOHSe8wH8PNT9+NkaiS93NRhMKbTSCYmqQV1U+8PWkk3S8VLBktrDkpev?=
 =?us-ascii?Q?nqtNyakvCjZyGzFM5a1DyeT0zZBqjrPAib5zDHDVvE1m2942cZEYI26QAz2I?=
 =?us-ascii?Q?dS97ohUGTiYhqhLoZwGECbD/AE02cOeIOnHzE8Rc8GMtte6x1m5/94xA5kTq?=
 =?us-ascii?Q?ynNZlcsCWHZemJ2R8NykSqnuDadRM564dTP0PCHJpyqnajYevmTx+V+eyiH4?=
 =?us-ascii?Q?8E7xiBVLm2U/ZtGUSSeNf3sWhBsP85ss2kkdjY8mmNcSfomr5NaHQmCuP8Al?=
 =?us-ascii?Q?S17Tkv6E+odIbV803LgIkidqdAlM9qEGiNFRWOdPzKY3gvvldY12ZIHyHdqH?=
 =?us-ascii?Q?AfoGT/RQId/ufkOqY5Kn/5YSrvAcftidBddlao9KQM8Fa7zqf8Z/yh1xgHtu?=
 =?us-ascii?Q?cAyTnVWUNuk68Y7DPgSg0OTsK3qxr/98JpVkB3dXngDyC6eJnw9sGufFv5Lc?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	e5qVIUucKLb51GMsnplnwkek5pj9/MEIVGqgQ11rnrkB39iMxpKA+UjWhmjLfsY4FqpbUHkSOk5aMjz6JkjrLBgLs2vE48OlXgv0/ZVwoMeM/lZGrQu9+48l1oMI0lU64K0TJCOhA5dfdGuThnvbK9rmjG9Va+D2kJ5oKGMt+uUE0Oy9r7818TZkB8Aco2GguG/vdLOSP3rNl5vvzMoUrL2a9IwyPduBjc9eddjK6+QQ2J3HODZr7XWcMequ0S0f7G+Ippf0Rro3eAflTrosog7XUJu+RaaPa12uIrhiDAwEnCQKKew7usDwC5K6qD6f9yvBh+xbT6eOl9RovEfWdh4OQpcj1JPEm8MeUtCkvE01Yt3BHcNyP1sdxv3EDDq/+tZaRhPi23ufBxh2GNZjs5DSGA5vWnvpg/jsiJIX57n60i8KAO2pnICC3s4TITIHtKXUsfD7eZ7+SPChHDbcdPgVLIaaYUF4YAe1rDNhGvtBaLFwSBhOhgZh5EK+Vm1qsTSQvNKjeQAh8hiTWDPCwM24/RDX/8tF6/F7tGTsrQXSW0Vkg9sHULgpKm4pqpPjDQxN1jv+NJs7ve/9vQXUvqSma7W1ABC3DZGx0DZU8o0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81ab9f7-3539-4321-a79c-08dc810a3a5c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 00:40:11.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmwWY2WouRCRMAGnhZpSKwAArjC1tIbNqF7GywmMRfdg6jGA3uZmXRXIjvIiNCuMGzbOYAVqOSnuVmpuByQbl4qHS39U3sYIDxUY6F2c6DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310002
X-Proofpoint-GUID: rSOmBbXC_8TYqdxUwHOW3egne2EOEyWu
X-Proofpoint-ORIG-GUID: rSOmBbXC_8TYqdxUwHOW3egne2EOEyWu

Add two new fields in public_key_signature to track the intended usage of
the signature.  Also add a flag for the revocation pass.  During signature
validation, two verifications can take place for the same signature.  One
to see if it verifies against something on the .blacklist keyring and
the other to see if it verifies against the supplied keyring. The flag
is used to determine which stage the verification is in.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/blacklist.c                     |  3 +++
 crypto/asymmetric_keys/pkcs7_trust.c  | 20 ++++++++++++++++++++
 crypto/asymmetric_keys/pkcs7_verify.c |  4 ++++
 include/crypto/pkcs7.h                |  3 +++
 include/crypto/public_key.h           |  4 ++++
 5 files changed, 34 insertions(+)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 675dd7a8f07a..dd34e56a6362 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -17,6 +17,7 @@
 #include <linux/uidgid.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
+#include <crypto/public_key.h>
 #include "blacklist.h"
 
 /*
@@ -289,7 +290,9 @@ int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
 {
 	int ret;
 
+	pkcs7_set_usage_flag(pkcs7, PKS_REVOCATION_PASS);
 	ret = pkcs7_validate_trust(pkcs7, blacklist_keyring);
+	pkcs7_clear_usage_flag(pkcs7, PKS_REVOCATION_PASS);
 
 	if (ret == 0)
 		return -EKEYREJECTED;
diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
index 9a87c34ed173..64d70eb68864 100644
--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -131,6 +131,26 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 	return 0;
 }
 
+void pkcs7_clear_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage)
+{
+	struct pkcs7_signed_info *sinfo;
+
+	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
+		if (sinfo->sig)
+			clear_bit(usage, &sinfo->sig->usage_flags);
+	}
+}
+
+void pkcs7_set_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage)
+{
+	struct pkcs7_signed_info *sinfo;
+
+	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
+		if (sinfo->sig)
+			set_bit(usage, &sinfo->sig->usage_flags);
+	}
+}
+
 /**
  * pkcs7_validate_trust - Validate PKCS#7 trust chain
  * @pkcs7: The PKCS#7 certificate to validate
diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 1dc80e68ce96..44b8bd0ad4d8 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -455,6 +455,10 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
 			return ret;
 		}
 		actual_ret = 0;
+		if (sinfo->sig) {
+			sinfo->sig->usage = usage;
+			set_bit(PKS_USAGE_SET, &sinfo->sig->usage_flags);
+		}
 	}
 
 	kleave(" = %d", actual_ret);
diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
index 38ec7f5f9041..6c3c9061b118 100644
--- a/include/crypto/pkcs7.h
+++ b/include/crypto/pkcs7.h
@@ -32,6 +32,9 @@ extern int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
 extern int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
 				struct key *trust_keyring);
 
+extern void pkcs7_set_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage);
+extern void pkcs7_clear_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage);
+
 /*
  * pkcs7_verify.c
  */
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index b7f308977c84..394022b5d856 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -49,6 +49,10 @@ struct public_key_signature {
 	const char *pkey_algo;
 	const char *hash_algo;
 	const char *encoding;
+	u32 usage;		/* Intended usage */
+	unsigned long usage_flags;
+#define PKS_USAGE_SET		0
+#define PKS_REVOCATION_PASS	1
 };
 
 extern void public_key_signature_free(struct public_key_signature *sig);
-- 
2.43.0


