Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B748E451CD5
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347901AbhKPAWV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18108 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349721AbhKPAUR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:20:17 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNUB3O013790;
        Tue, 16 Nov 2021 00:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=2372HCIvuNXObcgcFNIhrtpicwfVjtqo4xDCb5yI4rc=;
 b=acNuIRO6pFz+1haQgDtG/DVh13NUucvXq2tLxOa1L6KJfowGU0HUM9OeOn4QBhsxKfPF
 8I8QFc6/FphPF79d4wDFDF4M7OlAMowD4bB6ZrqJwHuwY3U0I1Qxd8IHNnhzYhyltuJ5
 2mWL7tPHEz/QJpeGcxNMJje7M4Gz+FdVqh04t5gZ+0OwR90RDACbPPL+IWNlf4E6Tx5r
 PqO8hi4GRiXizga5e20s7FAt/DNwZ+z+s2sWazV8ywNOgvzP7ihNbljzV00qbs6v1X+p
 ouwcSW+3CYJTpGauNqIRzfZ2KO3uNWnyeLX5l9l4hzDGWSKX8H7GhbkI/OM/Q6D3LXo5 ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbfjxpbfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:17:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0B0nC046183;
        Tue, 16 Nov 2021 00:17:00 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by userp3020.oracle.com with ESMTP id 3caq4ru9we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:17:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+f1zTzhyQSO0Nbv6zgN3NGI8/K0Y6ErSUZ2NNmqJo5v4OhNJX27RB9yexvMRIQtcO20PzIhbc13SaPIAcrFpm5H9MBMQJYxDRFJxioys75NA+3nnDHOuf4ImHfCDX4QTN182piLhJHufAVrITa4QQHjDlQ7ewDY03XSe/cipfuTRL58071ULYGtkof9g76Tc1hsHb//Q6PbH9dgM6KDpvZeBN+km0XO44jneNKYpXaI15RuYG2rdEsr/UXQZkFwhUxs3ECFH22TKvqQH/H9qvixKvuwdYVlJV3nIuhImsMdBEohW+ooik+wqECcU8RuThcs/jJOXzLeW7dt/Mdw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2372HCIvuNXObcgcFNIhrtpicwfVjtqo4xDCb5yI4rc=;
 b=Hs7XDA3YLsUHZ6yRdlcTx+VvCEuf6zOpuok5V7rrpodXtGGVBZdggh/YRFR5YFOkj2pmhBzMmpW4uIfk2kvBkfwhb0Tmzo1i/QODWnmXgTm9J2SYeyfjI0YX+pWlI0vxjWpHOJh8hZstBww9yvRJOFjgmp4l0Lo/A/2zo+sz0867owE/LjoDSnwiKtZQYnDSGc/0WHL38VeITUw+46qX4TfHcvksEZLywdx+muJoCNCv/LPYNfYxB5mOnznWh1j7cL6MNaWzRAQGA2fP9b/VX5GBmWEolDjEolXB+MocZ82EtsXjqUWxzVwFtw4NDTA+tVsrlRHM/y3lepoV8HGE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2372HCIvuNXObcgcFNIhrtpicwfVjtqo4xDCb5yI4rc=;
 b=ztUjJJ/MdDX1H2STkqeIuXsaiCsqyaXNhcW6Vzoh0JP9d/P9B609nMJml0ZUjahOB3KFrY0bus3qAAMyHiIw6bjluwD9dco2aGjFEIfdBrIf5N/CIgmNKaU6Kp9PSrtqJfu0D7JueVPJbUcNzikFLjQqkZfdNG+Y81dgw2MzsXI=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:57 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:57 +0000
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
Subject: [PATCH v7 17/17] integrity: Only use machine keyring when uefi_check_trust_mok_keys is true
Date:   Mon, 15 Nov 2021 19:15:45 -0500
Message-Id: <20211116001545.2639333-18-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0db1ff32-ac5f-42ae-fe3f-08d9a89666c8
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB52768C9A21A0CD0132C0FE3387999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4F3jnRSClHT4X6JCndAC3hfEHG6lsDDk3RFy8H/j90+C3KqM0J1wPVpl5Wj9pas95/lgzMA28hGOYef7Af0oL/33JepQpZWp0qhB9SRFGKarolIH+6MWTN7tFA8aG0LUdNmuumB2RT5foNfPZP0gUHU56OW4/XYBfpiS4mnHnLEE+P7hYwWvWCvYFu47w/KDI/59xDdVVSyruM7p2Y/fNXbIQfEJwdFskst158C/eDRV6Kc5zBRpN2f+5DhudD2VJpcbiWG+hoZb6UJX5qkNGieoat3zcOrMP3PbxXp1fUPOhDrbYHxHKHIWZZpNKoKbgIriDn5AmBUiOEN4ezWNA2sVPy9BKb35oH0ctzoRbEu2dLm5TnoUgQ5LXCGbd6hapfl0RDC4ZLf4Y2iOyn9J5TufRmiVbzffWhoScrc5fRqi2cpuuumjNAnZUFfTcK4fOq9GrhZfNf6NCLSNPBnC0hkTNEim2tcUH2YWBFdjfa+Um4NRKMdm+E0HXT0HLfTeBPC0zSDvQWqQiIM87KXfWTLQMRLsFhsIxlRsE7056e2wtmlEyfhboRMmTgxK9AtO0lCD32ca1lRH6WJL4N+GA4ieOcOAZTOGFHGCmSKbffjy+F3b/gZcCajWBp2eOKwx/L/sBcSM9i6KTn/pRimBU1wqh6zcdgzSQ+enH0I6gvmelf0XdDkOnFzbbdAwiAK8IuvwUEAoWyY9nMbWrpUj1801fWHNKExbDzLPZXWEmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(6666004)(4326008)(921005)(8936002)(83380400001)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oqNYZiulgj/GyelJTvnO7nsdnuLNdaZA1CSCAQXY+E4sJnUIwGe1+bBObwHA?=
 =?us-ascii?Q?W4KTI7xTtISBF6O23zSAoc5w6c3Rj1J++MdnNeyK9Dqrb4Rx2VS3AIgiyP+V?=
 =?us-ascii?Q?jGrM4N2V0bA4/74abbRvqxknLT6d5zVtZDb3ZZsViI3KBjhXltHCG6yS1JOw?=
 =?us-ascii?Q?bkDC5Ju9DS9prv7kZH8b3byW6P4tRWmeM5MUOLDOm34u4SqBj2VzphOKc6D3?=
 =?us-ascii?Q?q0gCsT680/gdIxPjzMtxrqZkSldFH3fT4+SrLayS3Z0cYumnC7pGgFkQJP1u?=
 =?us-ascii?Q?tuirZDB7eYnM8cH+3PtCtXAIGHQ4ykN16ZMFBuOtXwlgmxgwrSpJ79E+RvPS?=
 =?us-ascii?Q?GK8CjDP4pl+NXozvGhx7tzggjfzA/2boq0pJilYoDyEZTdg14x/ifJU7rKF/?=
 =?us-ascii?Q?3iC9GAq6LqYKaebJ3Uquv96fN8kDCT17rkNz5YfUJem2F9xBMHqCOLd7bQx4?=
 =?us-ascii?Q?1H6N7h6qEzTUAcvtPyDgWjNwzmQ/6NjHm+jmbKHRWBuR59b+rHt2vyNOTXBH?=
 =?us-ascii?Q?mwSzFvlaE7mBmkOjtl2PMlGRnT1eZijf9uMsVjFpd//JZRfwUUPKydH2uBSs?=
 =?us-ascii?Q?S3r0fZ7bbfANV4W5wNJwEeWe88U+1QyrvecWTNoOOlmk6Wa2UTDFwePNlyJp?=
 =?us-ascii?Q?PtqZitPQkas+3xn969BmZnrQkjnA2a+q//nisr8Q140w8W2xRaWbKhMiRKL7?=
 =?us-ascii?Q?d48HLXOEYP/T2AhsrTs9kY7mxaJcRWlTDL9c5xCtUW5Msc9DIksiy2chCJsk?=
 =?us-ascii?Q?EGdCPXcu1tDcF82kZtDOVedKdqfQWoi8KYhwzUp3qSr5SrPru460EueATaHI?=
 =?us-ascii?Q?7FRUuSL9beGxNabAplovEwOGe0dAbFOTRlvsGPQVnmm/dqj+Wqb0uXCtFpPP?=
 =?us-ascii?Q?xIFm7gMTNO4tBMAg5C7HQpswQ6DLJ5iW8s/WaWf4AY425Bpjl13BUl89eQBA?=
 =?us-ascii?Q?kEOhy6O6LbOxZuQ+/+DbTnB+hAdnAomq9y/jOVuiNExDZU9b65700h6rIR3r?=
 =?us-ascii?Q?vOMLBr0EcQORpcogKSNrP2Zse4+luAVwCpTekry1sMJ7Dv2xmU40k29TSAeD?=
 =?us-ascii?Q?a4F87uUyS5wrrClHr1jX0qJICF15z+CXS8U5uXImufj4sL6ZrayEUF87PI9F?=
 =?us-ascii?Q?lYnFIObnXoqVHFQlZLq3IQFY6XQa4r9dmpRCWIoF0XoLDCesGiHAFOrBxwxa?=
 =?us-ascii?Q?UVaBm0GzarW28ladPhjH00ZE6M/F2yIAqInUaJqJWyZcDq9dI8mYv9sJ5Irv?=
 =?us-ascii?Q?kUg49M4kLLNTTjgK9y/mXFYcNP/loOqu2VPlGx0IM0jhOVOc8uxnckhcZgNU?=
 =?us-ascii?Q?/nb6w7Yio5qOXBdiSu/ICoVKIKATMCpc+UiuFOG1+nGQ1LeSszaCo0CZv2yv?=
 =?us-ascii?Q?CYbpNsubxqB5I1t15rK/8y5XmwMB6ojAwW/mn1i2YUmeDIu8b4aqQT+LOT+x?=
 =?us-ascii?Q?F+Xv87t3lBIYly+kbGJxsbqXbEpws1g8xmUCoztaXvyNH1qaGn494b3opVHL?=
 =?us-ascii?Q?4in9rfOOWJlzIw+Qyl+cAOtcOi6KiWBvhXDpfqEmM1iBVYDLPvlTnE62VvhE?=
 =?us-ascii?Q?mT6sbZpTWcDqHtFVNAvN8IQRk9htRf6JbOqplCx7fdvuyh1TdCmAwS09bLR5?=
 =?us-ascii?Q?epgsM3iHQIlXM7GXtxs2ioupfHULMuvbYatzcixwQPlNQsuIwS2RSa3F4GSM?=
 =?us-ascii?Q?Z/cgXA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db1ff32-ac5f-42ae-fe3f-08d9a89666c8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:57.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyX9RvALxKjJnbX+COOzi/h8uv+sVRGhkUMEZlE4G0b1zL1vl9Yqe7tY6nRoNx93rcj9+WurgaQKIgyTO1V8iqblrwtDV5ZyZyOlPJ1brbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-ORIG-GUID: hmaFrdIDUiFAfj5rZniORGhqb41OM539
X-Proofpoint-GUID: hmaFrdIDUiFAfj5rZniORGhqb41OM539
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

With the introduction of uefi_check_trust_mok_keys, it signifies the end-
user wants to trust the machine keyring as trusted keys.  If they have
chosen to trust the machine keyring, load the qualifying keys into it
during boot, then link it to the secondary keyring .  If the user has not
chosen to trust the machine keyring, it will be empty and not linked to
the secondary keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v4: Initial version
v5: Rename to machine keyring
v6: Unmodified from v5
v7: Made trust_mok static
---
 security/integrity/digsig.c                      |  2 +-
 security/integrity/integrity.h                   |  5 +++++
 .../integrity/platform_certs/keyring_handler.c   |  2 +-
 .../integrity/platform_certs/machine_keyring.c   | 16 ++++++++++++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 109b58840d45..1de09c7b5f93 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -116,7 +116,7 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
-		if (id == INTEGRITY_KEYRING_MACHINE)
+		if (id == INTEGRITY_KEYRING_MACHINE && trust_moklist())
 			set_machine_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 730771eececd..2e214c761158 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -287,9 +287,14 @@ static inline void __init add_to_platform_keyring(const char *source,
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
 void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
+bool __init trust_moklist(void);
 #else
 static inline void __init add_to_machine_keyring(const char *source,
 						  const void *data, size_t len)
 {
 }
+static inline bool __init trust_moklist(void)
+{
+	return false;
+}
 #endif
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 4872850d081f..1db4d3b4356d 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -83,7 +83,7 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
 {
 	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
-		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
+		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && trust_moklist())
 			return add_to_machine_keyring;
 		else
 			return add_to_platform_keyring;
diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
index 09fd8f20c756..7aaed7950b6e 100644
--- a/security/integrity/platform_certs/machine_keyring.c
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -8,6 +8,8 @@
 #include <linux/efi.h>
 #include "../integrity.h"
 
+static bool trust_mok;
+
 static __init int machine_keyring_init(void)
 {
 	int rc;
@@ -59,3 +61,17 @@ static __init bool uefi_check_trust_mok_keys(void)
 
 	return false;
 }
+
+bool __init trust_moklist(void)
+{
+	static bool initialized;
+
+	if (!initialized) {
+		initialized = true;
+
+		if (uefi_check_trust_mok_keys())
+			trust_mok = true;
+	}
+
+	return trust_mok;
+}
-- 
2.18.4

