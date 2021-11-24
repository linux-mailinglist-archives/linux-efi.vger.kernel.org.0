Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60945B3A4
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhKXEuc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:50:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3400 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229623AbhKXEub (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:50:31 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4UG7B006066;
        Wed, 24 Nov 2021 04:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=IsuOpev9dtIowVHmPnU6Z92IKthwrgBPSZ16xs0tP2M=;
 b=i+hUvXcL4g7jcQ0peRze3lxbuT6hxA0aUQiDD6wgbZAF8PdX7Al7sYpsWh5k1CzkSJjD
 JtZcaWjoWdlQN+N8RaSB4tJENHnF6wxhnDbDCQQRJzUwyE3vXKlTUU7578UyZjaDFXk9
 ZDCuOAkIzXNjkaomXszKMoKvpS7ombQMmtWuvgCdtpWZI97NKq42ikpHga60oxRrcwlv
 jLxIOzPLw4viyILR0MVaK6UZQvnjRBocAF927aYvKzgWDcjldkhbuGKyQnDHAKA9TkNS
 ZreX72BNabNIg7QyEEgRcCdOpxNllRUE1/UZjaKGlmDeoOKsjeGZ9JdwPyopQN4lBOVf 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg46fewj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:41:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4fXBs181923;
        Wed, 24 Nov 2021 04:41:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3020.oracle.com with ESMTP id 3ch5tgp37y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:41:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8hz31mQAht35chJErJFaZrnyglJZwHKtFiD0eazFRUm297anVWipBSSgUqBTfkwVKQraTFquVIxLrfpXW74YydHBKuHx6R/VsPe/cSXovI8k02AmvkAelBeCxVtCe4i5OpPdJyzEXctWdek2IfthXY/6MCC510zn/RNmzh7SwmPmw8QhwKepMX4KCK3rP6CTO4weI5lhTpvP+kUFDuHBhzGWYfaRz7OuQgIfKwcCXlwKiKYFsn/S374dan2LDwLmwj0bc8zTw21X2b482/6G3iSNIYgzxIZn6+dvAf6cGa3jTMqn+HBahilyzZaJzz+tHwVmw88/CwrZj37YwAulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsuOpev9dtIowVHmPnU6Z92IKthwrgBPSZ16xs0tP2M=;
 b=FSK9NNflxL3VV9Jw3Jy2hKWaKVedLdUC320dD9zA1gvAYtrWjTxdk8qgl0oGcImk85AH8E3A7CLoRymSLZvvrMpuwX51rsCpdbvYTuAPTI1C9+F6gEsGVYpcCqbG6bE63oG2aMrejM6vTfIAU/3at00lrUg1hCUfR3zVfO5K9KGEqi5yzkMvx0eCMocHhGsbnTDc1eRU5udrtIpWEjADaZ/qUf/aNs0ziU3J3E0gRBNeuxv196H61trYy8qlFGiunjawDypcB3fpi53zhoDgfgdjvzD+sgxeGHS4MQhaqTpy+AY7v/aAvu4fGvgLMrqQjH23TUjAIRsFvTycVdu3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsuOpev9dtIowVHmPnU6Z92IKthwrgBPSZ16xs0tP2M=;
 b=T0F1OwDa0roHjv68QMHb1FHJfAYlC76rYqz/B9nyH69iZyILt5uxYfPvgdnKM2eTKYIo1pNzHhPw9j7URV24nw917xb7t2bOe78iVbi2bbYhRZlIuEOrWssOjJElljF82XhIkNt1jBfKXoXJ2TPZlzsjYnDRjqbGWsmgL93FwP8=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 04:41:55 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:41:55 +0000
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
Subject: [PATCH v8 01/17] KEYS: Create static version of public_key_verify_signature
Date:   Tue, 23 Nov 2021 23:41:08 -0500
Message-Id: <20211124044124.998170-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:41:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2f9b308-7bfe-43f5-f5ec-08d9af04bda6
X-MS-TrafficTypeDiagnostic: CH2PR10MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR10MB39573A3110CE1D969950EAD087619@CH2PR10MB3957.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LcfnNR7SUZRwnMwfykqLixioibzi+ZSLn9Cn4oSaX0kRPqXXFNIGTOzJP2DqH+5h7ERJyxh2wpqGHvvUljWkWQ7QuO0gfn+laVef1RLlbdEwPio8tPYVPI4HHixuwQn0jmneGqwivehLGH/aQJMujY4LxmwcX3RBwWiRUNrO39kZr5vq18HPD8fBQOQPnmVcft8s8xLabERhbCVL8lGZLji1O5dtBap4RYAPtIkBmohTn4cs2hiU2VxHnTovC4/HNk8+R6DtUibOvr0LQcipKut+2neBK63W4EPY3WU9S0XpA3Zj2MotuowGi5DhhbVTIWAM7owQ9WC4T/DOf4W1UBfXqdEgz+r2t1+LX8NWKNcxkII/PuqXcGef726BLxII1vdldB4H3jTPT0NAi61RRFjyVVvoLavtwz39jt86kMHDpe8lh6iBDKATSGcvXKHp0oZ/4gTZT+NVKyHqTXiAsa3qjuB4h5mSbmvpiJSzsOvb44COgofGAyu+KhiQ2YxYaDsxds0cJP4YDfL5WnmI8TldVJYWZ0W6TQMId17U70FyMPC7OgRZmyKUqOSl5s5CfdC7U5kHuICSRI2MFQxsRp4tMXgID2OtKf1WHs1LT3TO+6AniPML0dEiBhHFAOcTYOskk67bPVbsBWtNo+nD9Dn4uKUaAlds6wH/JbWQUkSIb0QHzjnOFKJW59+M1EgSkEGxe+lR3EOuECy8uc3VLHiCx+lBrVzG0gCI+/GVlmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(36756003)(66476007)(83380400001)(921005)(66556008)(186003)(7416002)(8936002)(52116002)(4326008)(956004)(44832011)(316002)(107886003)(38100700002)(38350700002)(66946007)(8676002)(86362001)(2906002)(7696005)(1076003)(508600001)(6666004)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aRKE8tHWIA8LgPQbF2dZf9I9F0zx7g92uEIykewolc9QpnOGSbvzHgYE/iP4?=
 =?us-ascii?Q?7b8h3xaXqmRM+p3pgU3/S9BZZu9LCHodf/NOBHnLQnpXwEBiab/M4fQ0jhPr?=
 =?us-ascii?Q?vZaitIVqVBn6jNwilvp3pRhSTe3ZluQjwXaATizjy3EelyasNJS5OPTN1DcB?=
 =?us-ascii?Q?8RnfN7vMGKChYXlTtAl6tmv5C9qGaZZ00rJbvBprDUmrEqOJRBng+AC2tvdg?=
 =?us-ascii?Q?csK7Ayt5yf/Z/LXBCy9l8ojW0k0c4b2p8OIJ37uOvLu56eAVtt0/C6eExbE5?=
 =?us-ascii?Q?kRoG/P9/+XdZ/9GPoqiaTE1vDR39C3tVSh1XASGMj9WJnzwhE1UGSn1NQndu?=
 =?us-ascii?Q?K3g2+IhIt8pJnevXzqGMs+yJY1YfuYBuGIfppiuQlu7VfhNm0iRqoPhTl61V?=
 =?us-ascii?Q?KCg9v9KG9wC+RSAk/ms/AOXsrlbMeasFOR/lKAAecdvCtZZdelIcFUceE9Iz?=
 =?us-ascii?Q?9T9dbHmwcZd8vlykySiiShXSKdhw+y7+FrGgOvX1N0cDr2obzaDB2dWuv5Vj?=
 =?us-ascii?Q?yNnVp8FDyV9vkIU5ZxhsYG8UalleJW10Fo347ubgMKw7FOXUvdFkvkxGsliB?=
 =?us-ascii?Q?ykUeeBIy821BtikQVml7pT94zKkdnBwbqOPm0+6Wd2Ou7ViOiJn3VesmHipY?=
 =?us-ascii?Q?gtzFt9OcsoIGrrozXtRURyqyga8iTfRsTLJFzR+qmTcuu5+qc4GK5Bsfvh8V?=
 =?us-ascii?Q?cYbYh69L95HKTRKu70x82xjhVYU6XTq7MN+dWQnP1/3R05UAscbY0SexJRcR?=
 =?us-ascii?Q?63QC6cMdJnB1xN5WT8CJAARtaveslBvd0mVbthDEjDO/JKxNxV6r7PPntUOV?=
 =?us-ascii?Q?4EmX5tIqfWNuNLJZvDMETU2dUWACGaoEW6HgzELudQz6z7zo2Q/xTPFxmlMJ?=
 =?us-ascii?Q?Ra1bz4AUTuPoh2TityTzUlf55UlForogqUkSJZf0ENPTdne8H47IkhM/iJo0?=
 =?us-ascii?Q?5LV5m4cVnd8yzJMg4jABf++zFY61HD+ZybMM33kujoBUbCo2h6OzJLNV4Y+G?=
 =?us-ascii?Q?XZOE3+GmQKs8UWLO5uxk0rKpffQKFAKyqP61cvzJp0ppI9LymTqsQWGUOmMS?=
 =?us-ascii?Q?j2uXrt/A2I1ED56iGdJzuOux3yifRdaMk21ZoJ/NDpyHBKsbpVPOisytGhN4?=
 =?us-ascii?Q?YBYs+5GhhxtUZWgO8/PzxYRJ/s6jfiUsTjMzmj8ySFqsXyX/qYsylIsoTRQI?=
 =?us-ascii?Q?wFQ11avHnN+6l7pyki8B/43u+OEy9n4jnzZMPti5lxHR3dwCz8uQX+FC7wKg?=
 =?us-ascii?Q?GRdwEj2A+LZPF8mhxvt7RUZ1oUDVd/gQTaSk8y07Z++I5uLgB1mzggHM/pj/?=
 =?us-ascii?Q?9Bpn9L5fbcj2ktTKUMMddXm0OBI4H3fP5/2LHng66S0MLsETHYbY0Fni5m19?=
 =?us-ascii?Q?FH09ZpgMqgJfsZhehvM+/sfijardpGZRWDe24Gi7iZ5bhKQ8TB1c8u4CbgJ4?=
 =?us-ascii?Q?PM2eH9WMDHgNqMssv9hnFsOf2twkoCCm6AyHMJYHjEojLPIDE/Atg/EKjn0t?=
 =?us-ascii?Q?lJZC3r9HfTVGRIQUBP9Exn14B4sl6+0oup+RkLUOgHWFPF+OUus7q554pE2s?=
 =?us-ascii?Q?/gkpYOvSUsXxVvAo4uwhtl1NaGeXbuOdoUuJLgaEvqL20zXOjfGSXEiYRLFn?=
 =?us-ascii?Q?ELCoKZ8SNp9fMOjcpDLYJq7GjpUTPdtPSvOmCg3tNDC0bd0gDHGXwG1GUVns?=
 =?us-ascii?Q?xP3ElQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f9b308-7bfe-43f5-f5ec-08d9af04bda6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:41:54.9088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIMwkYNfVI4eRnP1uotzAoiW7x7OXQy1dQ7syntN7g+QLzEN1k3n6Oki6MPUBBqXb5X2cW8VyKaiWnwOjYyfX/1jyvl0w9J74di5Cm4w5ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: -cjUQdVIa9FLkRf3ArQiZ6Bip9dSvPkm
X-Proofpoint-ORIG-GUID: -cjUQdVIa9FLkRf3ArQiZ6Bip9dSvPkm
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The kernel test robot reports undefined reference to
public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
not defined. Create a static version in this case and return -EINVAL.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
v7: Initial version
v8: Code unmodified from v7 added Mimi's Reviewed-by
---
 include/crypto/public_key.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index f603325c0c30..a9b2e600b7cc 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -80,7 +80,16 @@ extern int create_signature(struct kernel_pkey_params *, const void *, void *);
 extern int verify_signature(const struct key *,
 			    const struct public_key_signature *);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
 int public_key_verify_signature(const struct public_key *pkey,
 				const struct public_key_signature *sig);
+#else
+static inline
+int public_key_verify_signature(const struct public_key *pkey,
+				const struct public_key_signature *sig)
+{
+	return -EINVAL;
+}
+#endif
 
 #endif /* _LINUX_PUBLIC_KEY_H */
-- 
2.18.4

