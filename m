Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C280451CAC
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347662AbhKPAWK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54660 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349366AbhKPAUB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:20:01 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNMBN9009038;
        Tue, 16 Nov 2021 00:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=oYyarWa6/nH/R8iLXn2oxuDsNUALil26yTxNiVmVmeE=;
 b=Tp0S6KY9k1Ac+1No2tByc6VyJpDLm45QtNzjfMfZvy0Kb2ibN5eh6qrAw70+WEPas9Px
 8rltZuSJol0azOXVHE/4Ctd3BuWx/gQbNgpdX+XTe4eDXRsDXrrDpOPA+ZJAd6Hp1MGb
 5RBGxGRfA/FefnOzigvjxsLEEIIM4+uJ3EsSzkoR65BkD5kknjk9HPnKYIo+n67OmidO
 eSAydbJHYbQzGIwtqmjS/0SBNn28WEeDg+OZi2q1T/CrBa2gCl4xTpynQRBsKw7oRmk8
 vx1xnuZ/BjXfbujYKo+rUb86ZJ05b3ghJIgqlERao/3skIz1LcIkGMnCzjXD6i2h11Ud lQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv7xb32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0B1JM046349;
        Tue, 16 Nov 2021 00:16:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3020.oracle.com with ESMTP id 3caq4ru948-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Za7od5oms9dsRPH/6cb+0caOYaHNeB6ZoLyq7SRF1FNbIVU9mxdqXBnX6ju0fWwK607gJRd5T11dR+oEbQWzM9qCeA4kEGaRWC1rjQX97r2/tteV1XxH89CUMcYXzuVt6clVB284B+ylyBLvDNSVrsI+tH0PYJ6wjGbDu0tkv31LUOIRrr79KM3yh46V3tE+QIc/mrw3ZvmWfs+4+TdYrgsNLRAGxI7UATFHP6MG75056095XP+t5HepVOXAaJCCp4rlBMNoLsQVQCCBj5Ds582vSuCnCcodxntX9T7pkD2F5yqKZN39QStgaU7vA/qQThRwppGyvi29idhzHOeoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYyarWa6/nH/R8iLXn2oxuDsNUALil26yTxNiVmVmeE=;
 b=GiBRHUN4DvIiSMJJznubfd/d6RxVzhAFfDviRTa3G2MAzXSCm4MbEFBxPS+wkZ7sYrXM03zpZ9wk05qQ8eQgmYk4kjQh61suvOZP0wYT1JUwIgm9tfkSkCy2rBtkKHcSJWQ9x6wGbN/EIRKMDZb4J/ZsNOoilf3hKa+MQ2pkg8CDMcZYyhDDFzyWEFpEZ6ooiZ7Ygn2alSd3xPVJBI7YTVhiTRPmtV8KRRDyQS48iV4SmKl3lz+DHZHNz1DpmO/bCCD/D9zlsvA33tz8YDSxSXszc5rG7IMY9mfIwqY/AL5etrqbfylQNLgvZjRmTxaRrOGwYYn2jsLlorA9jTQaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYyarWa6/nH/R8iLXn2oxuDsNUALil26yTxNiVmVmeE=;
 b=u07rReEbwC74xoLy4DgzeYuLOnNGIOz7IvDlGFxTOf+XaK69KFB3sPZBbCGNssM23YnOz9no6TLTdV1sGNHnG+BH136TPz3xXWTahvltITy11L/qgoSAgqRqZ1E/Ad8uO3ty+tQeNwHwFEsZg3m6aESEEdtbHdTE7WAk3+dtk6I=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4358.namprd10.prod.outlook.com (2603:10b6:610:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 16 Nov
 2021 00:16:13 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:13 +0000
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
Subject: [PATCH v7 01/17] integrity: Introduce a Linux keyring called machine
Date:   Mon, 15 Nov 2021 19:15:29 -0500
Message-Id: <20211116001545.2639333-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c4b7502-818c-427e-dfe8-08d9a8964c77
X-MS-TrafficTypeDiagnostic: CH2PR10MB4358:
X-Microsoft-Antispam-PRVS: <CH2PR10MB435820309C9F29FAF2047DCF87999@CH2PR10MB4358.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFZk/Ym/KZ4GNfXViXjnDQUJuDH/L3pXoc4Mlq+7uIPAtAwjzPs9R5umnNIEwMVUIN6Ll+Mqkgx8xD7rwtKJ0YP5TOVI81crtpF1a6EL/GzeSZEO0CmQvTe1gyyuljgf8cgg5069gK0+AAMLdmiKpD9ibEuQyFSfhvzI87EkJZuvXFWfUuPL/B/C6JCBA3nmlMteE0Z1cIRVboLBsZG1nHCUVGkzNyCjkNHFcXjFJn/vV1JRf0acQj8F4TOg0ydEnAK9gDxLMtIhwmkwFR7/IdTUMnQMUMypngiiu5O8FhA9hmaWhxYrHWgqY3QXjRZLdRVmnkE5q8TMeuIVBYxyXPeJholGPdIq0mLCaeUtukLZp7hEEgVcVmtnBjIK82voTSQWmdWrSEAK1mUHHMG3VAcO/N+/s2zGMS/X2vgVIjdSUHZdgq0mrd3VY3Hm2EMbmff1LiqgB11Nk8ZbN1qf3n9iDBeGzVbHxV7QPyNjMn1cBDVGIjYpUAzqP6jGDf+e5+hpItrW8YoyyW4+4TMsW62Sb1gr/b3tvG9WvudDrAWA+FqP/ICOnkIioCYpR4DL1g4yuCioNovzdcRbO8V1PgL0vm5WB1cHHKNtlMapaf0eXmlrVzphsSYjfOqHdbnUA+PTPKpm5qkCX3hqwGfpkG9gfaZYvj4gi4XZ7+MHowz0SEjvNzT9axaMdDa2UFu4cgNrMACsKVl7hEgDylwtVjQQE6HQ3g1Vbp2107dNkh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(38350700002)(186003)(86362001)(66556008)(38100700002)(8676002)(26005)(316002)(4326008)(8936002)(83380400001)(52116002)(508600001)(6486002)(7696005)(5660300002)(921005)(107886003)(1076003)(44832011)(6666004)(956004)(2616005)(36756003)(2906002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4A8xS9EO0Smk/dhjrI+VF/ocLpClpTv19I7nHQdfBove+gU64vDTeIncDGxa?=
 =?us-ascii?Q?YRZDKCf3BoYhNZgZWOQGMp4yeSuIPClfLiA8k/K1xJlGjtt65FP6WuQ7SFUG?=
 =?us-ascii?Q?lu50vqhS0xgB18WjRv59ExiNh9WViLjxHIeNsIQt0cYYXJDe8u9WPRhQdrvs?=
 =?us-ascii?Q?L1tIGQ95oIeYWshWD4dV55cQMi0jlLSjD1yXqoz5Eo/3/WR/vJj6IxOhJHUh?=
 =?us-ascii?Q?GJhFK3eJMXw7DFa/QXtXvrFCDT2+LHqjDchTQdlvafMO8+/6rO8TtFVEXUhj?=
 =?us-ascii?Q?muIvLsfJ/euNoTf6jVpXooGEJyw8KaX/7uNXKRuY5zkJJUuYl8pJPDQSdohR?=
 =?us-ascii?Q?Mqw/QnaFvUrxrT9zGTaLezq2T2xzU6F6RFeeq+2EKHJZKNAleQ+kF4TB5hgN?=
 =?us-ascii?Q?2UOsQwULpy6CeLhmblj5umvl1cAv8ZYDOFsygJOqttdkqNjZK1QR/oebHF02?=
 =?us-ascii?Q?iNUarAi/JmbkaonGl61y7xD6mAbIgzdZJvRGkSqhPPl1TeL6oJk0euhV0bd1?=
 =?us-ascii?Q?FqaILiqJyhh/7bs/fi69sAbmLlVikvOHGUqOi9CECwOtL0WZTPZOcswKvJBM?=
 =?us-ascii?Q?IdvBYEtpFAD4xeiOj1mQWtZ+h2zTCrfPL8fW2eeTwSk0vBDtlULziF+G2eb7?=
 =?us-ascii?Q?OlGkZ3q6MNmGuhh8UaKR7EPub9AuOPn/25P1v8v0BVJjpCETXNUctJocuHv2?=
 =?us-ascii?Q?AhOqp/IDw34GSpaeiKV8t8V/78QuhNkPGqgcQkQCPT7dKP5khq1ozCB77T2p?=
 =?us-ascii?Q?1oynq7XHkH401osXCPMkO1JFvESarEvQSoQd5EGc+1LK5vS1Wmlxcaimm2fA?=
 =?us-ascii?Q?7HUvj3imJDkTEBpto0O2d6iJNa19l2TqqMObsEiy3cgCVKq2LU5trIz9QzPl?=
 =?us-ascii?Q?z+FKVqyhbYFnr6t4r4oRDwQ5hXLnSGT7GO+Et5V5+cdykcOy+HFuNct7PV2m?=
 =?us-ascii?Q?yz7CAcGUaBdU8/L/E1OqMgYiidayHErQ8KEmmJbhwBab9otK8s7srF4DGnDU?=
 =?us-ascii?Q?MOkhxzM7cwg4EbOsFo1aZtEtPsZr+CFGsfkGG0+M7aApQg8/p59+GLHsSKWq?=
 =?us-ascii?Q?WpuUx8HRxo06W6W9bny36bZM51gYlBAJSKUTTlikwX62FaElNf0BBwVm/h8y?=
 =?us-ascii?Q?GtZ2QBtcalPdGFACDjiys26q/5tAn+Bse+mwGFtUnk94LyxLHpX/mnDXt7x5?=
 =?us-ascii?Q?IbWbibBvdvadGSVRq1ZcvSi1oNQx0jlRgco8R/P9zzZtS0tQNpdASP7rBowy?=
 =?us-ascii?Q?npc5D5scJcbj3MZACLNYqz+zVWeW7Zn7vMVDSktjO/wb5nvmPOjxEAXvr2Tv?=
 =?us-ascii?Q?3nbvAY/JqyZm8HBslIo7k8aE0o/1qydhaG0SvfROtnqJgJqMXlUO4DuS+k0P?=
 =?us-ascii?Q?bwknUw+Lwe8lBoz2MvdI792gLogDM8etoQK96d3H3xvvdzFl58I/Pw4Yvir+?=
 =?us-ascii?Q?cEe4XbMV8RsY/+WtCIOBYXcUJat1C3vz5Xmz2LiMfwcrAh/g5ZPJWpT8WFgq?=
 =?us-ascii?Q?OWRcBntZQYD+lHWQ3mbYDgQEWPJF7DETSYmNWCMJLEqt0/sO71qDRlq6smDr?=
 =?us-ascii?Q?c6H5vXtu08oi519sbSKFhV/toRdEO2W/f0jnFW1y3abt6+9tFitYjOjSK+OD?=
 =?us-ascii?Q?j1H8Eh3gcIJwQkUVmmP/HgCHng6D/Y4aRoa7gnhJV2sI7mjz3SDjl5ubAeiW?=
 =?us-ascii?Q?ChSz9g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4b7502-818c-427e-dfe8-08d9a8964c77
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:13.3669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4vc0aLihjtEE+GFHx4LA0zc+dZDJNh176DtA/5EOfMKFA0GPZbO0MhF5pMRsr30XEv3wxt32MaHSYqz4qpnhPYbxy+f68hxBHH9haBM5ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4358
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-GUID: JEmXPLiRzZLPt5eAtusF_EZTotdZH7Fk
X-Proofpoint-ORIG-GUID: JEmXPLiRzZLPt5eAtusF_EZTotdZH7Fk
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Many UEFI Linux distributions boot using shim.  The UEFI shim provides
what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
Boot DB and MOK keys to validate the next step in the boot chain.  The
MOK facility can be used to import user generated keys.  These keys can
be used to sign an end-users development kernel build.  When Linux
boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
.platform keyring.

Define a new Linux keyring called machine.  This keyring shall contain just
MOK CA keys and not the remaining keys in the platform keyring. This new
machine keyring will be used in follow on patches.  Unlike keys in the
platform keyring, keys contained in the machine keyring will be trusted
within the kernel if the end-user has chosen to do so.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Removed destory keyring code
v3: Unmodified from v2
v4: Add Kconfig, merged in "integrity: add add_to_mok_keyring" 
v5: Rename to machine keyring
v6: Depend on EFI in kconfig  (suggested by Mimi)
    Test to see if ".platform" keyring is configured in
      add_to_machine_keyring (suggested by Mimi)
v7: Depend on LOAD_UEFI_KEYS instead EFI for mokvar code
---
 security/integrity/Kconfig                    | 12 ++++++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   |  1 +
 security/integrity/integrity.h                | 12 +++++-
 .../platform_certs/machine_keyring.c          | 42 +++++++++++++++++++
 5 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/platform_certs/machine_keyring.c

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 71f0177e8716..12879dec251d 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -62,6 +62,18 @@ config INTEGRITY_PLATFORM_KEYRING
          provided by the platform for verifying the kexec'ed kerned image
          and, possibly, the initramfs signature.
 
+config INTEGRITY_MACHINE_KEYRING
+	bool "Provide a keyring to which CA Machine Owner Keys may be added"
+	depends on SECONDARY_TRUSTED_KEYRING
+	depends on INTEGRITY_ASYMMETRIC_KEYS
+	depends on SYSTEM_BLACKLIST_KEYRING
+	depends on LOAD_UEFI_KEYS
+	help
+	 If set, provide a keyring to which CA Machine Owner Keys (MOK) may
+	 be added. This keyring shall contain just CA MOK keys.  Unlike keys
+	 in the platform keyring, keys contained in the .machine keyring will
+	 be trusted within the kernel.
+
 config LOAD_UEFI_KEYS
        depends on INTEGRITY_PLATFORM_KEYRING
        depends on EFI
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 7ee39d66cf16..d0ffe37dc1d6 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -10,6 +10,7 @@ integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
 integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
+integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING) += platform_certs/machine_keyring.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 3b06a01bd0fd..8c315be8ad99 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -30,6 +30,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 	".ima",
 #endif
 	".platform",
+	".machine",
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..730771eececd 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -151,7 +151,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
 #define INTEGRITY_KEYRING_PLATFORM	2
-#define INTEGRITY_KEYRING_MAX		3
+#define INTEGRITY_KEYRING_MACHINE	3
+#define INTEGRITY_KEYRING_MAX		4
 
 extern struct dentry *integrity_dir;
 
@@ -283,3 +284,12 @@ static inline void __init add_to_platform_keyring(const char *source,
 {
 }
 #endif
+
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
+#else
+static inline void __init add_to_machine_keyring(const char *source,
+						  const void *data, size_t len)
+{
+}
+#endif
diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
new file mode 100644
index 000000000000..ea2ac2f9f2b5
--- /dev/null
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Machine keyring routines.
+ *
+ * Copyright (c) 2021, Oracle and/or its affiliates.
+ */
+
+#include "../integrity.h"
+
+static __init int machine_keyring_init(void)
+{
+	int rc;
+
+	rc = integrity_init_keyring(INTEGRITY_KEYRING_MACHINE);
+	if (rc)
+		return rc;
+
+	pr_notice("Machine keyring initialized\n");
+	return 0;
+}
+device_initcall(machine_keyring_init);
+
+void __init add_to_machine_keyring(const char *source, const void *data, size_t len)
+{
+	key_perm_t perm;
+	int rc;
+
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
+	rc = integrity_load_cert(INTEGRITY_KEYRING_MACHINE, source, data, len, perm);
+
+	/*
+	 * Some MOKList keys may not pass the machine keyring restrictions.
+	 * If the restriction check does not pass and the platform keyring
+	 * is configured, try to add it into that keyring instead.
+	 */
+	if (rc && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
+					 data, len, perm);
+
+	if (rc)
+		pr_info("Error adding keys to machine keyring %s\n", source);
+}
-- 
2.18.4

