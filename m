Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA345B352
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbhKXEqI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:46:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61732 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241042AbhKXEp7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:45:59 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO2pLtw011710;
        Wed, 24 Nov 2021 04:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=xMlCfdFVGWyitMdYY8+0D/BgfNqZdYXGLvgJQGc2sUI=;
 b=grC/9V5ubBQYgP5ssJiyhA4WrtjWGs0VmFV+NxWBsG/okqV2Ms9br5ffe7FsAuW179XS
 MpSWBAUB1oLKd0qQ+MjdgTmH89lyJqAXQbI2K1dFbfilbOD5EgizLfikPsTOt8lHiz5k
 x9em9g9Ak4NDhJUAyZfdpNu4SjafZUS5xv9YlVRvtsBQIm2L0PQSl7b1rkfkohXmqkDV
 QQGLVxCkEpNy1R5LeBcSYgIgHFpIZFzNTDQ8n+N0EfU6A0QT9eS9//pgKPcQjfe8cDFr
 ZyXUIQWNstIcwQ662UZFA6GE3oqHme5i45wsR9NZzc0jPvwhY9d1J5VNoE0Eu0z4B3Ts HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg5gje9f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4edmG036817;
        Wed, 24 Nov 2021 04:42:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 3cep50s6fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOGQRN433cH+xNzKpC1T9ItOMyLzPLDXsIOKiAibkKBTGobebolANzRCm03+VLMiT67QS8YzVG6Gq9gzaDRfd6S6Wq628SxM8zXDnk8P97fxJGh6bUKZ33U7QPVjBDCD9jNNcuYGa4cpk4aMy+LBMEN1CE01QAyn1vqeW0jRc0k7a2/SYtZg81+A0RX/3qW2CtESeleQ0wJEiaYudFW693N+fmkyVDZN3COvcTy2So9WLpoCY9ZTX1d7IMW7070NOJKq6eNmmerQoMTjNcSTuQA19s1oM1fMThq/uQJAhvJhQe7oC2vjDHcN3aohHYmcnODCinN2zYxyHdd1ZyQ/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMlCfdFVGWyitMdYY8+0D/BgfNqZdYXGLvgJQGc2sUI=;
 b=kU8phO2XltmDEZn95p92XFWt4zdbCyerdglQIPIkJ9fWuZQiF0D3uit7gnPi+vvNopZgPBnO4uZ6CKYrcRURgg+zeDlohDNybRPloSErKidrNHXUCsiuUcWauTPu75xvOEG9B78YsHvxAUlF/ZeeCIgdgY4LiH4C4CFbo2gPk0InwJHNpYatF7n+mKlw/ngibhW02CbLEMBmEWarcCvHqpEzCN0nnZji2HQzk1p83udTNnezodLnnsB9NaL2kczn5SWr3FZn+wXHEo/PqQJh26wnmw+7FNF/5eqCvcOqtaGr+uf+KLSNWEqtQRxe27TnoY2Ig3WJeaVsni5Y8Qp/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMlCfdFVGWyitMdYY8+0D/BgfNqZdYXGLvgJQGc2sUI=;
 b=eF/wlP/iFr09E3ywq3B00zrQa4QpuagEbDm6vKIVU8Uczpa3aRlGR1JoyvfYzlvXtnryupAuDhAGYlHH812JfjsBbzJ/oiiSOQpdeCEpqZPT/p1Jxn+A9cwyl3J+2q+bk2p28gzUnVS4GJ0BvnkEh2zeV8Frg4gqcwK2gXbnjTc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 04:42:25 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:25 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com, jason@zx2c4.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: [PATCH v8 11/17] KEYS: Introduce link restriction for machine keys
Date:   Tue, 23 Nov 2021 23:41:18 -0500
Message-Id: <20211124044124.998170-12-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e5b7768-42cb-4969-2068-08d9af04cf6a
X-MS-TrafficTypeDiagnostic: CH2PR10MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR10MB395747BF9131AFAF9F7ABDD787619@CH2PR10MB3957.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6o3HrS0wjU7OgazH1YQ3Mi3xO5gLIRcNqTY8d4XMNMHJR5tSI7ceT8IH/50rGRQb05OCqrIdPxrNdF/iEiedv6oBM1xNSuf5GsW9VzgoFnpKNEVqDn02Ekken2HtKUFXDoqXZMesuMHjzXOzs4R5/10jx4LPNFCIUyGgfnMfXh9lVmCZNSAv9QcLWl0GzugcZZv0/zrjIe8jsWvXiHQf+sCTKNSmpFW7eMYf8gGN5iqBr34RDz90jvKqZx2RKpM6h9Ghow3TXeYjPwpmr2DXVa2cNYE8NAa38uaiGq3c7oVL7rlRfbnSU59+u6D1wJVIzCbrLZPNdeMYPTedm0yEW5l3slrnPJgECmjjIRRvRQkLgc+3/3nIcaskE53MFFrq6qn7da6FIKRME5hmJ+FCBwmd0umRB6xp4JL0TRlESy2yQCib/fdSt5U3c9z/3+BjnNxtbIW6TIkLRVAK0w5UNQATFZhlxNnnpz/DlkzDlIYVt+WyXcijZfUJM3Us9T1XCLcq/gkxjn6CVkKHfNPT8gSaX+mwabz8qFr59N0XaL/RL9fXjxC00yjgMMGNx1gC6/vTY7weOUw/GiJ9i9e0RibNVJMwF27DWueh9kmUTuXTyWmWV1oWZ+JzP3X/tkPX48l/nereoQUrKvoH4HpKHYeNdpslyt4dLJMecjr5FKXCncbXQfEGYTUUyduRmFVcM19wQnvfqunx8WmZdneeTFeQ2w9sp1XdqPmKbgKjkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(36756003)(66476007)(921005)(66556008)(186003)(7416002)(8936002)(52116002)(4326008)(956004)(44832011)(316002)(107886003)(38100700002)(38350700002)(66946007)(8676002)(86362001)(2906002)(7696005)(1076003)(508600001)(6666004)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fgkczo32cuXBaaeBO4oGMDwA7/3roEzzO4OGTdISBLFnqZ2XkRmmrMFASZc9?=
 =?us-ascii?Q?rzbUeHC2YJ4eXbpXcL2X3ITqYsImMAqD2NLmGzBShChqptB3IjA4tEj2vjv7?=
 =?us-ascii?Q?sthz6OQHqheXGrfirGykb6qclhy7VjIHdW8bBKC41MC+w81d6OUIGGaWxDir?=
 =?us-ascii?Q?NSxCY3pKd8S7Kx/L+3clJ4JNHCCchp4Aml5kuQ+yA8JOdCovT/BsAHamdzbr?=
 =?us-ascii?Q?OMY4VuIDGxnRjwAiq4QTF3/br36E7rleCDL1/Oddu6z0yis06sSixBhQAVnh?=
 =?us-ascii?Q?uIfCa+H1Lna6DHrEGNnb1fgA2s9mEMIWWwzza5jq01rMYbf3G27yFrdbiy1i?=
 =?us-ascii?Q?8TeYsr+te8pJKYFnOLNEX6RhGHEwgyx3u+WrK3B2iZvM9sj+yZhaHDkR9ILl?=
 =?us-ascii?Q?b961uz8NsK0vnqHuS1/Qhj9ldYI8aWMC7rgZUmoDfS57IADj1/L1e6h37qD3?=
 =?us-ascii?Q?RTtgPxNIbt6ko4VDU19x1aKi4+/9FJ0fxa0aPfBY5xo60Rw83NuLm5dCaxdA?=
 =?us-ascii?Q?rMLIsGw8YflQMKOyoQ8g9vKcFTC+e/rcha66OUr4WNdc6XzWjtq6g+m8Ee1U?=
 =?us-ascii?Q?V1rkAeSeLD1J+4TsPKuZ0JvxVd2ZqIkY2NtbPw0yzYGBAc2mw38tzezv2XCX?=
 =?us-ascii?Q?opI4Jt8dhTRAC9BkyfxbiCYEUAMdhnqOCfEN3owEmiwlU3hlSom1PIHzx6Ht?=
 =?us-ascii?Q?E7Eyo0gowmnegNeIZgBlp++AqmEPWd7LleiVEjfkCdDj6IRK3/Dc98BJyrN9?=
 =?us-ascii?Q?piEY1JvR+lqQXz+eGm3776nb5Mb5cqcp2Otw+jdeDscpmcftV1dn3X9+3k2F?=
 =?us-ascii?Q?BMPRs6tgf3C6gWHF+rbZjNfMPOIjwqzr/9/MR/6Zbq3sI1IRK0j4GB4rYr6A?=
 =?us-ascii?Q?pXAw9zfL+Rp+Q80kduQDgL7CAx8ZDK4QV12Tgi2B1ebs6uz6oOmsW0HZDDRw?=
 =?us-ascii?Q?B5Dq1F4d//oVE9eqSTr2SF1/b2Rf2ph9Prw11pSbqXbVqOf8B1CIckzrceny?=
 =?us-ascii?Q?+7TTREhnoZTNCwJqyp9zBwVaOMufx3pSHOB2fQhwMR4FsfPeD9wKQY2twBu1?=
 =?us-ascii?Q?ao8IzVBFDp6HrQsywNE29X54/HVLmafpEp6Xz+cvqkgmn7h1dNU/2tiesd3P?=
 =?us-ascii?Q?1ZSQw8WJ5ab9ppd9VRcLfXevhcSaGwR3ewyNs6z4Honhy+GcZFyS4OBJJvmE?=
 =?us-ascii?Q?4BKCBlCl1NVWqPreReg6VxrBqV7leLJKtLLfpg39nT0T08tM0WsrrhdCKXh4?=
 =?us-ascii?Q?0wONCkhZGsiLRTS9djpGF7bXhl1lwPGSu9z9YSmDhPykjHod2l8J+svq1j2x?=
 =?us-ascii?Q?7G6PfjK3lxzawCOqi2qLEYYkn8defdJXThi+Heup4As+c+iCLoLwwKwr4Ml0?=
 =?us-ascii?Q?lHSPMSe14g3PnaZKeHFtXIBsJ1PBEsFsCpHdrlH7oCxurGVsbw/CDikh7/Ih?=
 =?us-ascii?Q?X9tUqnLJlxgGFKetFTL1VzScd8kbBaILeXHV6Sr0yrBCtMv7MfObG0mjqg1W?=
 =?us-ascii?Q?mrXZguuzYQi6ObHSaPbbmP321AWFSN9f8krJVqV4i3oQdzyAoXuyoydMnOcm?=
 =?us-ascii?Q?ixKMDkakiyPLmIOrN/y2L77Fg9/eUxDXp4UvrxuM+dcvT4rVoSbID+VZqmwI?=
 =?us-ascii?Q?W+Eb7wlExN1oewh0Su+sQqv8E14Z/DQQA1kXgSrgj38lWhTS5WtwsxWbeEIC?=
 =?us-ascii?Q?Y4VwaQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5b7768-42cb-4969-2068-08d9af04cf6a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:24.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlJ3L6VR9TYg2bOPKQIE6J7ex6Tb/esfrycpGJ74d6lzyCug6dxGmgvrCPEUmaqZ9rNtoa9kbOLVtcd77ILMbmXUPFGTCDUsyy4rMzx2uoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: 3hYKo_I-qoN2PKe5jxPUZzn2VFarWQbU
X-Proofpoint-ORIG-GUID: 3hYKo_I-qoN2PKe5jxPUZzn2VFarWQbU
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Introduce a new link restriction that includes the trusted builtin,
secondary and machine keys. The restriction is based on the key to be
added being vouched for by a key in any of these three keyrings.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3: Initial version
v4: moved code under CONFIG_INTEGRITY_MOK_KEYRING
v5: Rename to machine keyring
v6: Change subject name (suggested by Mimi)
    Rename restrict_link_by_builtin_secondary_and_ca_trusted
      to restrict_link_by_builtin_secondary_and_machine (suggested by
      Mimi)
v7: Unmodified from v6
v8: Add missing parameter definitions (suggested by Mimi)
---
 certs/system_keyring.c        | 27 +++++++++++++++++++++++++++
 include/keys/system_keyring.h |  6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index bc7e44fc82c2..8a2fd1dc15db 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -99,6 +99,33 @@ void __init set_machine_trusted_keys(struct key *keyring)
 {
 	machine_trusted_keys = keyring;
 }
+
+/**
+ * restrict_link_by_builtin_secondary_and_machine - Restrict keyring addition.
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @restrict_key: A ring of keys that can be used to vouch for the new cert.
+ *
+ * Restrict the addition of keys into a keyring based on the key-to-be-added
+ * being vouched for by a key in either the built-in, the secondary, or
+ * the machine keyrings.
+ */
+int restrict_link_by_builtin_secondary_and_machine(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key)
+{
+	if (machine_trusted_keys && type == &key_type_keyring &&
+	    dest_keyring == secondary_trusted_keys &&
+	    payload == &machine_trusted_keys->payload)
+		/* Allow the machine keyring to be added to the secondary */
+		return 0;
+
+	return restrict_link_by_builtin_and_secondary_trusted(dest_keyring, type,
+							      payload, restrict_key);
+}
 #endif
 
 /*
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 98c9b10cdc17..2419a735420f 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -39,8 +39,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #endif
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+extern int restrict_link_by_builtin_secondary_and_machine(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key);
 extern void __init set_machine_trusted_keys(struct key *keyring);
 #else
+#define restrict_link_by_builtin_secondary_and_machine restrict_link_by_builtin_trusted
 static inline void __init set_machine_trusted_keys(struct key *keyring)
 {
 }
-- 
2.18.4

