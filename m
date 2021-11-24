Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E9845B36E
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbhKXEqL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:46:11 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63620 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241052AbhKXEqB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:46:01 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4RqBn029976;
        Wed, 24 Nov 2021 04:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=77+ZIdPcr4ZosBsLOc5sX3qoDHqT8aH8dtBTB6lugMY=;
 b=aW1CugKyvSml1qD7QBmdF34yE+mTxaIAqnrIGCT27ya+q9dkp5GDUsAIHBKxrnK+7Gnr
 yDgtt+eo9CxQ40O0OeDi+GAnULNjr4DDugnnqz2V4h4dV0u+Z0boE4KY2Ls/RM++fEye
 T18H6/fVrF/Aoa/FrxlCoy4XnI0lLditTPvmGEEUipcsgo7bV8WWF4T+Pbs73CLgpdvu
 GQObhyHIWku8Q5shAahMBaUJgkmh287+QvUtGzqrRY0XuhcMbw4vdCNAPrMwqEIaPJY+
 0uLh2C2LPBNweFPBDs1fvDye0EaQBXw9K/t9O4nHqEPE7aeypFykWefMyKwoqoU7Yb+U SA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg55g76qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4f46u025272;
        Wed, 24 Nov 2021 04:42:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3ceru6amhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be7fUUku8tSzUxF56VDpyfaUPkQ/4kfWIx6rUI4vBY8mpyd0U174LVr1geOrYemZOSU0DAAFblMwrdhRsOndt2JYtr0W3/CgPPstUBFAc1VLlpEIsKa7O50HDEQ0ML5aXFjJ33k9YM26XGqwA4gkOMfkKhVS0H9xLGirO8B/JDSc7L1+zbXH0OmJ46SQ2Y0IatFhhq1ofrhJOB92hIjHAc/dY5u/yWmKkFYwGJ/09tlQ0UXrWCbaJhn7950wBzz7wST60HLAEKpMI+yV2BlBUkOBWw0+umUrTBy8A6Kh8hF+Xe3LjX0CPY9vzbuqeYOK8VBmXzCFGNpmex5dAEPDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77+ZIdPcr4ZosBsLOc5sX3qoDHqT8aH8dtBTB6lugMY=;
 b=gVsAD48QV0Wbx9/S7b6/CVudRDMIqwgFDkXE8mokc5KoUTF9xBEPDLrrXWrHNi0eWdbxv2kPhyX9XMZwVh4paHGG/v+9k+um8uxqbb4U1k60rOcap1ntgUD1A82ej3xydawttUJIJQKoTam6tYwtgCnEYPMASycgfA2agSjnYt8UiQSCKjvnRKSswukeuUAEZ6DlGzRbv6jm4fq72ffJdQJ+dmBKXhceVRbn/iQ+q69WwZ9ctWl4ldZDlQl4eW15xZ0K4GUoSaE0Yfb6uRb4Iw/KpGL6toFWmXswAL9UbOJ9z5HLVFOAFABpLs+iF6urKikW7DOTmh93iW6eMLFZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77+ZIdPcr4ZosBsLOc5sX3qoDHqT8aH8dtBTB6lugMY=;
 b=McFLHcqxICMGDdmlp9kTh6Y8Rb/XTtMoiWiAAjZb2LoXDVg6D78J1UrHPutK4u1F5dBoP1ku+VRpnZTCMmtrSw4noPC1iPsCEcfWtr/tlO5nzDCHjlYsYug4LH/XcYqOIh2TInIS5kdHepeMmMWD8sVxdmGr5/I9SZGgULv9cI0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 04:42:22 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:22 +0000
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
Subject: [PATCH v8 10/17] KEYS: add a reference to machine keyring
Date:   Tue, 23 Nov 2021 23:41:17 -0500
Message-Id: <20211124044124.998170-11-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aa295e1-450a-481a-1a02-08d9af04cdc9
X-MS-TrafficTypeDiagnostic: CH2PR10MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR10MB3957C26350D13CB39E9FEDEF87619@CH2PR10MB3957.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBkXHBctGOez2paatYWn1VdqUKU75Ce2JTZIzz5UIm4L4C1CqtDEkiUcWAlpKGB6iurXvs9B+b6Kwg3gV0R4x+VAe0qScw7DY1ToW9GEvQI64Po2qTwrHC0cHQXherBbu0yXycjhMSAUglYj6sVsjSIK68M8vNEEnj5+bC2fPZyv2LaAyu4ZDsnLy4oL7v7OMnYIAEZkgr9lpiuW48sir15dPPwnwEA0jMlCvJkqcW7/kztuUT40FSWyRvAerjv5O4ILUU3KXXd9ulJeUJwlC2J3UJyM4yJhRTyu6jjhkYjLJF12V8f8u1X/8jQLJR2Ix1oGGhjG3+MExP/gLWopSNHQg8nHJAzKUJWJ10WCG5JGv4ayxVsZXlewzl4UYMipLLcMlp0m8mE/IYsDrg6U29xcoKKggs6/O56JRRJ9NHH80/VAQGTWyr9uMBFapWD8sgZcIkjVFRaTofe/2cIokwX+NgyDDLBIgCKVy5B2tNOYq/6aDqpnYlGxGvROugXJcJ+JhiyLlvoKCwjsb+jN9Dd904KEpBIpEYfjpi2G6LsDmzlRZcCWbjZgMoYzWl33FwHjJW0KUi+z/e59nL/4CGLgPO2j9Bt6gBq50oih0vwFUmFjIDhdw7nvYLQlkhcTsH//1TDPslumMwYW0dcMs8+XtMoBgsX4PFXqJ3bJ2ekwFpKzG8qDA9YkokQ/VvbFhckaX2SWrv1ytrERrKBuYb1KfRa/Hep40MOFJ8FIzic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(36756003)(66476007)(83380400001)(921005)(66556008)(186003)(7416002)(8936002)(52116002)(4326008)(956004)(44832011)(316002)(107886003)(38100700002)(38350700002)(66946007)(8676002)(86362001)(2906002)(7696005)(1076003)(508600001)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PVtHUw5Un1RBCQYNqnJOPEwZ8iuMP0SXpXlL2VJAHnvQ8cl9rCXGIOfGCfTq?=
 =?us-ascii?Q?UAYzfmDdOJZDjgqD/rZH2mMt+JIA540FDF6EF9K+pECbambFSVmWBT1Kerfo?=
 =?us-ascii?Q?pZ62JN45Hf5DqOCFyxsGB5goTgXUSi1aN9VKP4tsct833zRfHxHPdiO1fYjS?=
 =?us-ascii?Q?f+rhx+LGe67iVELecaulbJ34oeA+g+Ud6XphDShrermBPl3r5VLXXmeT6hMB?=
 =?us-ascii?Q?/mCh2kBuPt21Gm1tZaWWu/HV5V4yQoL014iOArm/4A0M4dHVHrwtrkfYNvD6?=
 =?us-ascii?Q?cTwN3HE5ephHZxgtgw7uhRNxRBukL1bqsPTvUgZG2rNw185wHdPy6g3EBAA5?=
 =?us-ascii?Q?pUPPUA7pejZEl7oURkRGVSPV9Y8qch5UdwSH42t0CvYuFZQQUP/EUFYESNhm?=
 =?us-ascii?Q?OQkcksnT+7/jknsykn59AFjibxLdiaxAOmSt8DqmJTDwHDdhqJifjw8e6g7w?=
 =?us-ascii?Q?+6bDeZ5u3+C7bmpYsCAyLDa3r6H/XICnKvUxmngEeTTO/bAXVvuA8RSCbp0n?=
 =?us-ascii?Q?Ce3pFCBCODdVRz4lgmnFGUItfHbZeFUWORaAXeWJfX41drIkA+PYWiX+TIeh?=
 =?us-ascii?Q?Kow8Rvxbyum7DmkGy+1pEcT21tdmPmGOjl/cGCJ8ftaISkrizRtyZNotJbrw?=
 =?us-ascii?Q?TgV+k6PxTTq7sxkHUDDCBE883k4JkIyctcWcZr27YAr2zb0+MgH5mVmjg0JL?=
 =?us-ascii?Q?FAuN+8ydg9Z29WS+1MWUr6+2ACvq1eEraqW4LFzfF8fgHrleP9rJRUmdB7Dx?=
 =?us-ascii?Q?nxHkb0Yz2JMf6I6WGaqKiCBQaJwAzz6Zv5Gzax83lnKEFOR7qogcHomvu3XD?=
 =?us-ascii?Q?UM4Q/n0A+ql8pcDCjrGFI94KnoE0hat8lBfTJOqKj+KUwyqddRaibP3p24Lm?=
 =?us-ascii?Q?Nk0QKMhn5mb+3LfmR9WNmaz/BgxcqeSz0y6xyvKQP5ulsMvPZ+m1/FuhcLN8?=
 =?us-ascii?Q?lEtWTCZVwS6o9aLs6El5z212MvxSwda15vYSVZlDAQ99E0TjDvhZ/YoRVw8h?=
 =?us-ascii?Q?sfNTj24i/Ad4v5AMnizUaG2IMK0CoiHTexfjNFcLurmXjYn0o8U7aKuujuhO?=
 =?us-ascii?Q?VhyV8+DE0BcQLjM0QfZe+Jw97vwJS6G72m7D/gsKFpWix8Vczt4hG+BSVfya?=
 =?us-ascii?Q?gS0Pft0fjE7yRLi4fZeqVA2ohQbksnuIdr0amarzkXZxCBokJSHQjgFFyb/a?=
 =?us-ascii?Q?vYCJCWETIyrNuqUyHCDiskPQ/3wtnrrSa3UrFii553mLzThilPoygShGWbMX?=
 =?us-ascii?Q?NIM4DNsw5moTOAoL135X2bpx2wnResYEzwUe6PWfI0Cmj5XmZdhrVClsGQe8?=
 =?us-ascii?Q?8XM9GPH8Qsbkd/xqnbbqQOvbM//1UFz6+wQaKg/b+PUNde4bcwOuK3lOo+5i?=
 =?us-ascii?Q?gnbshkrj7Iu6k7ulup5VDdOkcMsTyyUhzCpIKLaM+bw+sXaOKIbTOsBT5CGb?=
 =?us-ascii?Q?qr6vpQnDc46Zkp5u1nAf3rePp95P/+b53OGfHhj4tBZyP9ZW0KVcCoKQ+Vv0?=
 =?us-ascii?Q?+UtuF/sMIJSAfu7aGQZTKZIEAuC5EMi5QVPrULG6AovgOZ/5uMI1m59S+Glp?=
 =?us-ascii?Q?fz/sReQzcsazDKbqj6EwDM7el1NTvCFOEy5ljIhG/5Re7Bvqn0k+Gjg3fjVE?=
 =?us-ascii?Q?7VwBAmR7N4C2x3qhx0GR+Rr34h7H3Ycg/ZyOrD09D58+i1n9+CLnriUSXm3m?=
 =?us-ascii?Q?EZE5JQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa295e1-450a-481a-1a02-08d9af04cdc9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:21.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hYUpqsGdGyM5VEIowaRxVL6HWfCtUxGfPgzpFzbUTLswnDoYKsYnoooG7PUNb6kA2fh714w4tIzLHxExNeggZJOJsTkOhq2lQ9kljgyHEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-ORIG-GUID: h659-a8sXTh92LbCVKQOpcaqE-iF68h7
X-Proofpoint-GUID: h659-a8sXTh92LbCVKQOpcaqE-iF68h7
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Expose the .machine keyring created in integrity code by adding
a reference.  This makes the machine keyring accessible for keyring
restrictions in the future.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: set_mok_trusted_keys only available when secondary is enabled
v4: Moved code under CONFIG_INTEGRITY_MOK_KEYRING
v5: Rename to machine keyring
v8: Unmodified from v5
---
 certs/system_keyring.c        | 9 +++++++++
 include/keys/system_keyring.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 8f1f87579819..bc7e44fc82c2 100644
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
@@ -91,6 +94,12 @@ static __init struct key_restriction *get_secondary_restriction(void)
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
-- 
2.18.4

