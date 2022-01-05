Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52D4485C82
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 00:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245644AbiAEXvo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 18:51:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40994 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245573AbiAEXvG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 18:51:06 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205N50uP026084;
        Wed, 5 Jan 2022 23:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FNOc3EZPudjSqWJajjAI5Xe/ScJLWHq6HO14BAVi8g8=;
 b=cLS4ImK+CtTq7h9R3TJQhKlfBmxB+Dmp61JeSY0dgWFN1+r+KgRajFa5J8E/yO2Ly2Wd
 BQksJDbzvf/TRYp6JyPb/A04eiPTNDI/R3LFt6PyGz1fXRwFmbp8C+cw05UMpjjG3BmU
 aoJj6zhAn+o2i7uTVpD7FJYXYDNqGB+5S2uuhn9e+4foCC+a9R2kg361jpXoGOddFIsd
 78nJLWTUQrlLnLorUwTM75zO1QaBOxhmW5U2pXb3uPT4di4xVfGkmTkL/rkIYOiIeNfb
 KqAqHDFclXNt+7LCAQiRaVOgFyYG2xZvV7alzGuGWI5+QKynYJzPhPqEZHEwHQm0crO+ eQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpmg202-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205No7Kc191080;
        Wed, 5 Jan 2022 23:50:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3ddmqgsh94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqGhNtg0T4PWVErVBX0ICR2VODCqyrYJ9yuAB4f1+RlQSvOEMjAFWz3PeP+UkSpLc6FYZvNmzNw6vqxabiJkWeAHU87z3iMYeWyn7hL4BZJegQ3kgtyGJFBKbeivTGMtaEFu8I/VzT480C3PRTAq/NTUSeX4jfy+VdBYlZ9Cf1sDIOiqnjH8GkRAHLi7QILeF5MlKIJIOOjQUAmuGK8Jd8/RWP9QXsnTdzDDkAWU3Wt5Vbfd1Zao+CCpKgHVlSSXd1w1EnwndkB7ci3E5EJvkmW0AHJvuak/2VtVmbM/UC4MAwMErtdTO3aYTneX5rxotgCQAHDCmrMHzg+cWQFVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNOc3EZPudjSqWJajjAI5Xe/ScJLWHq6HO14BAVi8g8=;
 b=JZrD/XWMS1HTrbowqidlJmzL4wCovt5/zrcjJE22RQHdL71GrezhVAUdQFGo4+MVeM28m2R6lxiFlPZLWLJieHKKFyL9VC+n3hwgigxuR6qkjkQNGPNN8929k3JaBpXRD2uerHWYzX4YC1ZzkElNueigmpafH6wmlVNKsksv3jh9Xap0ashncnJADsKazOLjiPvFUCLe6h5055D0vGcDE17U7D1FwlEBYgaQJTzUlQl0ZY7tXNrb8YdOtPiyoMoCk4u99NC2EoYQo1tAdUQj9myMMr+VdePl01Sfrq/dnQpQ94bGwG2FbL/OIsTMSkXJZVEerTCcVBTyEwyTHxlGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNOc3EZPudjSqWJajjAI5Xe/ScJLWHq6HO14BAVi8g8=;
 b=U4cxlmlmOy90QQohzozYaNnvJXYPgDBIWzK1LKEl5tSosCnHJk/hxRqyYPT/5U+mIiHMH03Lw272YLs5aOnV0C+FVgBpc736vRNIdthiVywuZHQ/KREdsn1rN/czQo0hEH3elg922mr6SYJ91V99WkQxfGb5NPEBwKCB5wjRmDY=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 23:50:38 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 23:50:38 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, ardb@kernel.org,
        jarkko@kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        nayna@linux.ibm.com, zohar@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: [PATCH v9 4/8] KEYS: store reference to machine keyring
Date:   Wed,  5 Jan 2022 18:50:08 -0500
Message-Id: <20220105235012.2497118-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220105235012.2497118-1-eric.snowberg@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0095.namprd05.prod.outlook.com
 (2603:10b6:803:22::33) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d409cbba-bbcb-4225-8e00-08d9d0a62cb3
X-MS-TrafficTypeDiagnostic: CH0PR10MB5034:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5034C912636FC597806FE39A874B9@CH0PR10MB5034.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEyc214tP8BeRcYmLeUUHQ8ntXTDs62Xu0tRdsaX16CE1MFLktaBDBwCqPr5eY7NUeEuLzNTfDBAJewYnhMZ7nRxXu/qcgzJk2Ixqo48bAFVmUNoRG0ooVmC5Prraz/6cPO43EdYHqx3Qx+al8BiXuE5sKXesYExJ0mPl4U7VHFlhDDqd01939SmWngFjv1mJGj6Cnj2xVC+SodmdgZzPPcRx5tjtZtmYFeg2NhNco3IhXzn9mtpUABcMrv9Xj6VpN9xjjU5okhNHD/E/LsSvNrCAHpJASrdC+9juFnPg+fIJdxywYyMxDkPNkOVnnYTrQmoCCfZlyooDW9Yjx376MXHpM7Pvlc5cbGK90s4KNpJFgRW8Yy2y6ytA7LdE8Yj3PYz1v0mBQeyPINsh9/S2QDHkV15heAK2zkUFXeSd7IIOXsjGrZxOBThkhGZMBqI3L/8xz1AdOI/II49ml15b2YdNhsCr78lG5EftHndVZahQdug8BhkD0qLTSIrCE+J0yoK0wU9D0AAOYIsU+lEgBNB9nNOSWWqFc8lucaS+dorGL6tFWEtcG1ZXMCmPTWO4NmtwsS/EbtR4yP55oKqQ8t5jonDL9OAexm0LnNJvwew4DtsfBPcqCL9uprm8ZRGYa7k4VF3LT3M4RPDN35VgzufAhANHqYA3RgBiUNwn8iUJ3SGO6sICEhs3G/4S1qxFqy0lpdF0G5J7preZOVMLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6512007)(8676002)(316002)(2906002)(66556008)(6506007)(508600001)(8936002)(66476007)(52116002)(2616005)(86362001)(66946007)(4326008)(7416002)(36756003)(38100700002)(107886003)(6666004)(44832011)(26005)(6486002)(5660300002)(83380400001)(1076003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Bcz0dvZxqiprp9H4iFxI95LRx8Uv7UOYjdJXt+Ppg8GFGFpwcFg6kpKhFPV?=
 =?us-ascii?Q?XgMC6ca6pKvI6Cfm4L2MNHFRJPCNa41123J1pfL20EUIE3ybIX3qv/6i2VmS?=
 =?us-ascii?Q?CoQgZ/R957KaCdhHtnSCbQB0EQSfGGmIyJa7Oqcimips4XuslseCKkyEnccG?=
 =?us-ascii?Q?it26NLt3aZpnAHTaTvNnqYmWXVl+kUdY2xOyHp8iucl8MtOcbKUHI6ELxEOn?=
 =?us-ascii?Q?VE909NK7dCKzxfqPe7HiSlke+El/v8MYdoA8zHhammi2+Frg6dqjpEQc+gYJ?=
 =?us-ascii?Q?5PlfWOJQZxWnyrYEiyD7NWeEoXyNjXtCpSigB7g5PVW2+V6O1A9ztP8PvatB?=
 =?us-ascii?Q?ipfwRV6G3ebeTGc7rc5Yjp/nwz5z7ywKb/ez3mduRH/SMWpGPOa+PMUzuxme?=
 =?us-ascii?Q?WVCeSHQUIGrhlOgSDwha34QxjUIClWXBQLuAzugKK+jm5sN0ygy1AUU6lFej?=
 =?us-ascii?Q?aZ7Nn3Hah/k/nLp2cWpUhjeTiS/Lh4r0eMA8XbsSFVYuDHeSbDRBKzLrXqRa?=
 =?us-ascii?Q?nf8yRk2TxuU717NLpF8JbxZ8lRa5uxm09sNdF+v7tbORJmwvw2PT7xOO1ISB?=
 =?us-ascii?Q?LTInJOlXPUpCqB+bNG2OvBpdSGRN9Jh7TJxws/NNSzt6AY4hi9LC/T4wBV6j?=
 =?us-ascii?Q?x/0bY4jP0hUPwyWYc8NSf8108YmI7qvZapw0iTacfufKFUw7WS0Wjar6ppcN?=
 =?us-ascii?Q?QdwtR7omPdA1mYfloEsjq15m5NWwrZgINEWPzQa7I2W+5EKVx3/INVu9VLUt?=
 =?us-ascii?Q?Mh0vNb0oDeE+/bGA627YzPFLe0Jngb6twGV0V+Jxf8ctIcV1lEA0tAI2S52a?=
 =?us-ascii?Q?Dxqu6Qb9Q2FB+jvH/Pv3AfDxZizj0am2ouS4LjRhEyFB+6ykZ4pywulXw1fv?=
 =?us-ascii?Q?RguQtt6lVbfc29H1qxOjp9vgwaKY64qG0BGw7NW3AVN5u7FN+3o14FK5mYNC?=
 =?us-ascii?Q?Ldg/ZeyZpqQ9iiXBHKlVZhFF18s4mFif4nZ1zAq+2mzOuZVIBI598lzS3x3n?=
 =?us-ascii?Q?kxWguUtHeSVOHkdFRyRpV3mWXpPX9gsSRqp8HPHCu1ykWLw3Q6gtQJ+CR3Tw?=
 =?us-ascii?Q?NrpsxRqTPXGk1KZw8GiVWme2afnfgbuP0suQYhOMpUVOYWMnjYVbAMhPnqdY?=
 =?us-ascii?Q?bBvh7SF85EwGQRoFLlXXmH159Hgh9XYh9pQus2NQHR5iaJiW85k25dSBVQKV?=
 =?us-ascii?Q?dTRk4zOVR6wse44Y33i/hhHkxhk2hrcQi77DhqBUIlXRR3v28y6lhYiayRl+?=
 =?us-ascii?Q?3ao8H2kSZB825/85hVq6LLQqrDaAsbXpLK27iRsAYkmIHhfMCN5pBDpBkDmr?=
 =?us-ascii?Q?3vl3yWob6mbyFZW4JMGwhRoLyn+qGyQhdtdU6u5GH0/ahdj7ttbiN7Yp2k7s?=
 =?us-ascii?Q?zfiYV1meCNjN30LdcNILLgZJl3kbcRQJFHas4601kn44UO+CbPnpx8p+0FbC?=
 =?us-ascii?Q?ER4x0wzHyzAqSfRFkLZUBIIpo2Ej+eXH0Bp/tKVXK3GugF1NoOydRax+ts6d?=
 =?us-ascii?Q?am4p6XpDlG4BzvJHA/QHj+22FFCYZXAbU5K4TC4OYnSDY1kMbs0kCe8PO6yM?=
 =?us-ascii?Q?I7dkwNmtjEpJ962O6jp2ObDqaeDp/MiVxsqGDMZOiHzovCc0EBon6NI2iWnM?=
 =?us-ascii?Q?WhK1QJFYga281kv8VWzI1NACPczmKlqzyZrzPl3SfxjA4hh87g2NXEtyxweO?=
 =?us-ascii?Q?giB+Zw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d409cbba-bbcb-4225-8e00-08d9d0a62cb3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 23:50:38.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgqlVLpohiMtgzQ8qb2eSJ/JUsGK0fkFRWy3tAspjTjOWp8YvBwrujSB9qAW01zntLIbSljCCAay1rByLDqQhgp9ItH4grjNlG/I3wpLyCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=712 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201050151
X-Proofpoint-GUID: 2XHDKSBV2hcy2p6roZyCXLaXc9fZVVP-
X-Proofpoint-ORIG-GUID: 2XHDKSBV2hcy2p6roZyCXLaXc9fZVVP-
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Expose the .machine keyring created in integrity code by adding
a reference.  Store a reference to the machine keyring in
system keyring code. The system keyring code needs this to complete
the keyring link to the machine keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: Unmodified from v2
v4: Removed trust_moklist check
v5: Rename to machine keyring
v8: Unmodified from v5
v9: Combine with "add reference to machine keyring" patch
---
 certs/system_keyring.c        | 9 +++++++++
 include/keys/system_keyring.h | 8 ++++++++
 security/integrity/digsig.c   | 2 ++
 3 files changed, 19 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 692365dee2bd..08ea542c8096 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -22,6 +22,9 @@ static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
 #endif
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+static struct key *machine_trusted_keys;
+#endif
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 static struct key *platform_trusted_keys;
 #endif
@@ -91,6 +94,12 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 	return restriction;
 }
 #endif
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+void __init set_machine_trusted_keys(struct key *keyring)
+{
+	machine_trusted_keys = keyring;
+}
+#endif
 
 /*
  * Create the trusted keyrings
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 6acd3cf13a18..98c9b10cdc17 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -38,6 +38,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #endif
 
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+extern void __init set_machine_trusted_keys(struct key *keyring);
+#else
+static inline void __init set_machine_trusted_keys(struct key *keyring)
+{
+}
+#endif
+
 extern struct pkcs7_message *pkcs7;
 #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
 extern int mark_hash_blacklisted(const char *hash);
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 2b7fa85613c0..7b719aa76188 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -112,6 +112,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
+		if (id == INTEGRITY_KEYRING_MACHINE)
+			set_machine_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
 	}
-- 
2.18.4

