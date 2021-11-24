Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FE745B390
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbhKXErW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:47:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23110 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241297AbhKXEq2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:46:28 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4aFFU029981;
        Wed, 24 Nov 2021 04:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=98HWcp3RjTT+twGfMcSXQUhAoK9z8Bg5Y8ejQ1oirUc=;
 b=A0SDipaYrFTImMy37NUF3NlJyOao4AnFhDcAkZGfNyMlm8qB1F4EdqH40MmLaYGl5JW7
 vxnh/YpC9uD3RgFTPdVaVtIN5cAHPl7IAHvzsSVqmmI0ANoM7IlF/uoFzcVUcld6s3KR
 8nrabY7+sHHKljUnB+THROa3XvoQI2C20BzfRDTTxmlAPcX1zREHzqxa5h9r6agYVucq
 gEbZkQJ0OD3IVKcHou5iOnRkgNhhUgKBJlqHrii80saZoO+2pXGYaDDmp5dCVzV4/oiI
 mUnu3jvmF3NdOUekQp/pJcd2C/XZMJevReOliqTaWaoZzsCsJJFH257aQiyG8FqsGgn4 qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg55g76qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4f47R025282;
        Wed, 24 Nov 2021 04:42:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3020.oracle.com with ESMTP id 3ceru6amfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCrVhaXzJqmqSY3olhQjGv2dIlihpSmKIXzS9fmzAbd9qPWi/kkEK94hZelL66v/Z/CYR35igJO1LOVVxn8ViL0uXLIF121IPKGvoqqj+dIYvuWUI6guuZeJUDh9XsVODFKtUZXepHZ2X5MN3K902YoLpqU+6IB8+d8Kvy/1x1oFziQSHn5LC82UIPVz0iBApmucMfaRtEn1/KkpVlGAlmfK1R4THjOHf6s15Fn66JCnCpFC4+tIC8JlkBWGdcSJ+iPp0lHBbHvuI+CGWyk2A7bt/Xy7MRPLgyCZ269qFQ5Dd1apc6USRjf1gKAPmGUrpff/87lx+K/cqUUd6kT7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98HWcp3RjTT+twGfMcSXQUhAoK9z8Bg5Y8ejQ1oirUc=;
 b=WyKf1eNwgnXFx6cCv9vb8687XJT1TPvtIwzt+tig/U4uGyy25SDzHOmkql4pM59kMjOt3cDeQS24wz8veuuZfWwcLC/OKOlM1qv/aHpD8bYCGLpiUUmMim2zo6tA8b498xNMoQ1rK++RTcsVBiwXAnE1r66KAtOMrnuy80x7JHhJhcTmJToyrkiqcDvXtQczIniyiSGkV6mV80CbAfl3BMmBL31pM/LmvZoQQyzHJTaWIsL8ZCPX/9/EW2ObZJ/37eQSO8yGhu0SClFPY3q/xaZDR0hnYY9AtBk8f91fSBI0Nw/qGO2pMwhuaMMSjH2tNWehEI3yEOiY8RrG5OdXkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98HWcp3RjTT+twGfMcSXQUhAoK9z8Bg5Y8ejQ1oirUc=;
 b=D/YNJKVr5jJ+zHxy6shzMjrBCXVZzrhfzJsP9BFKTJZHJUnLFEt0OEQ/qbn8vZevffvk+7qi186+w8se0QD8xmJfqtqpX16Typw8OvfCL6DxRCa78hV94qiv+udCQcmjpy+Vu1XoLDl+noWU4ecVIRx06WBu0U0sekCtQ/1NX8M=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 04:42:16 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:16 +0000
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
Subject: [PATCH v8 08/17] integrity: add new keyring handler for mok keys
Date:   Tue, 23 Nov 2021 23:41:15 -0500
Message-Id: <20211124044124.998170-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b8d0dcb-3131-4320-c122-08d9af04ca5b
X-MS-TrafficTypeDiagnostic: CH2PR10MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR10MB3957177759B6C691451BBB9987619@CH2PR10MB3957.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6WqQxUvOye4wbudDmrKlz8KKSkudH/KZua8x1/qAhB6TIPcNhxM1WeS9aoVtr5a06MKdkG8Bix6V4ruIwWhV9Q6YVJrQbMmrS6i/fJt2xHK4RXHfo0+rIRDNWau+Go1L92gP83uSbtD1kG0Hw7inRlJ5i2xT2luqhxVeBZOFpdPOBLX5JMqHQYJgWrjnyoe/5Iv2U54yjkllUCAOH+Kd1Brp5AT8XUCgaq2KEHmqwbqCNf/Xnqkv7zkbyg079Z1EjS2OtT4mFKzkeBM3NmqjD82uUjD5hVPIuiM5TbYBtSZL/XU0LF+v+AVoL3lpqOm2FLnq5eqMsAQ21s8GB20CQey73mpRN8iHV83AzGH+Fjxcf9byl1nXVoIHUW5Q5iRQP8i7cJ1S4yyYJ08isL1xTSpTFbtsmnN/6fnaCGn5szl52hOW2JQxJQzHM5v+dKtoVdZdixk3fVxncuUwYArZskx+LLXJsOds66dthM1LnXXJAgRJVAI5zj7CKANW9mnTkQBRmdtXb2XGO9sZnrE8ikbyBnbm0h5BY3Wc/0vl/owNCT8QcQAB3nuRvEAOAAe1/dt0WjhtAhheVElBfzE5vajKI12qZwTKNLYUc7ISqauh8PYDJnuO3j8o25smfoI/kwkoKvYf7SUO5UCLe8Y2eimCOQu3bm7EHx0cP1jyoxNQKam3PVLZqKXRiP/8y2hzAQldXUIPlVtL+e2Vx3HESlrBX6SVZih4XrtOrjUEt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(36756003)(66476007)(83380400001)(921005)(66556008)(186003)(7416002)(8936002)(52116002)(4326008)(956004)(44832011)(316002)(107886003)(38100700002)(38350700002)(66946007)(8676002)(86362001)(2906002)(7696005)(1076003)(508600001)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4tgPo7PF/9skYI3L35K6rWIZpLG0Le733FKwm77jDlU+32SJgdDPT9D7DAc9?=
 =?us-ascii?Q?H5yxPQRYh4/Z7fIWpmcgoRPnNUWj3E7FJ+Re0NC/dJj7jzh6q3sIFdtHCsaQ?=
 =?us-ascii?Q?lBa/z8TzNjww+mtj5FBfooLRhoOo9O+q779kD/NxTXMMQYkyRrMjw8qiDbfk?=
 =?us-ascii?Q?boWPNWm7L9nsIaAOkKyZELFoSG1dybAhXXTb+lkszMTXxC7XZ1reobX9C83F?=
 =?us-ascii?Q?W/MQ4hsCvxywitAonOgs9wM6dQRnT7QNYAt7RCLjCq3yypZmpdasGTSmAKjm?=
 =?us-ascii?Q?uBGgJwmAXCLuciY31NMQyPHUqj5Va4EPcrZ7P8HUR3y6zDGW29Pny1yLTGN5?=
 =?us-ascii?Q?Ni4cV1AGTLnaKq2cAs+LIt9V9WaaVqAPsGmDTOQH6/o6pzoI7bPBuWJpYfzL?=
 =?us-ascii?Q?szQnXbl3ZJSCi+yXQB78jXCJFw2m56G1V9P2F6wRaeWo8YDow4xlRWjSMNLl?=
 =?us-ascii?Q?MElrHudk2lVGNnItdsbsuqD8R1Zxd0iQwTM0KhZWUAkNV1GJrIKmlL1w2NW3?=
 =?us-ascii?Q?8rCDu73AOtuMGm9H98wvyStvH2gSADnQDryWhy+VSxIU5wLxG1ubiAF6cISZ?=
 =?us-ascii?Q?id9vLn4YoBPSHdZyFCrDn+X+ulHLaSubtMmbjlMzcxvRgiAhSXlZ9QRSMN1e?=
 =?us-ascii?Q?0llPdJ939eE9AqP9Jv6V3bxp5hAONUd4z0JiYl0qyzeKUNJ7iyRZaqCaokmb?=
 =?us-ascii?Q?PLx1RkbOVxQJezXPJc5apgOrazA8yaZpJA2EyBIQzonbGYCWU+kPlBL2rHFz?=
 =?us-ascii?Q?6I+melVgT67t8Zc+96ghIgFF1a/xaUZ6Y/pSKrK3wTl9iU4CUbIvzXChCKqY?=
 =?us-ascii?Q?RzIp1hJDC7ZklF9r7OlUBPt9O5xZmL33e3WkDE/EFY8y6uWmAxJR2yPwZFbD?=
 =?us-ascii?Q?mxlliddHWr6sX7D+Th3nZoqaL0RKjeGwmyAAOppw0RdsWvNXxIAsGh7CrFU+?=
 =?us-ascii?Q?OAVatwn79WdtBBHuruRYLCMoYGI55QOnuvpUxkTfdXyYFmblH+wc3FwuvaMt?=
 =?us-ascii?Q?PRpzsHyFqdXVExYztP0q0X3O028i6mzh7/PqYDp77nkG32ZDx2fNf3H+SJjj?=
 =?us-ascii?Q?7+kr5HSo9G56cgg3UB9SrdPjNrCsRdHfX7xiwluWto4stkAaJC38RWQHt9Xq?=
 =?us-ascii?Q?7zW8IYxrMtPKx0Y/d6zHpo9O4pwpS2R2VbIt+3yHXQDF0AQv64sv0psrMUHs?=
 =?us-ascii?Q?8Fubyd2CZZwvbNbAzTxWez36QihKWlGpKveAcbsJSF8C8NiUFbC1Db7/HkJz?=
 =?us-ascii?Q?TFmKlKvglmHu4vgd5CHvmBkFnZJO0GITRO7GfdgyOobALYqsk7ofB/dAU1T6?=
 =?us-ascii?Q?tVhN4T5hbBgeRnhAmYZKK7up9hYl/eps3hFLLxvoZarLdYMhG/IiDjMUfD77?=
 =?us-ascii?Q?k03212hHlwr0uuqbhX4FSoLocmD3ZQvbRhNnSxtKmbbQcXAPKKmZyMCzSg+x?=
 =?us-ascii?Q?jG31w7bUT5YW4zkSvVAAkA36zIXaKqgyJXYHARKxRLQ0Jt36oeEBecWXxQk+?=
 =?us-ascii?Q?tLIRLm0NIAANZS9VxU9Q54n8kEDihbtxtNYtoXGlk9gCLiMhkBqaT0eA1h3X?=
 =?us-ascii?Q?Aeue+bFYez9s7CQ5HgunScE0+I0K6fPuiityQJ3IoyBuzWK2NCzyU5vCS5Rw?=
 =?us-ascii?Q?oQrCpia/sO/ryECs3+2NlpIowwcfEq35NBy8pYojtVMPbNkElrGkYCdKkmnE?=
 =?us-ascii?Q?6QKX9w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8d0dcb-3131-4320-c122-08d9af04ca5b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:16.1527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9F/Ncv8WpZNNz7lXEX2R4GffzyUkBxQX4DextCzMPLPl2V8ZnXQxd+fAzuKK504FvBGUnf+CIwPOC08rWW38KlO1Ix4Kqf+KJ9vuqs2BE1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-ORIG-GUID: AO6MVFETP-sO3BZwrT7nOcldRMUDSPMR
X-Proofpoint-GUID: AO6MVFETP-sO3BZwrT7nOcldRMUDSPMR
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently both Secure Boot DB and Machine Owner Keys (MOK) go through
the same keyring handler (get_handler_for_db). With the addition of the
new machine keyring, the end-user may choose to trust MOK keys.

Introduce a new keyring handler specific for MOK keys.  If MOK keys are
trusted by the end-user, use the new keyring handler instead.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
v1: Initial version
v3: Only change the keyring handler if the secondary is enabled
v4: Removed trust_moklist check
v5: Rename to machine keyring
v7: Unmodified from v5
v8: Code unmodified from v7 added Mimi's Reviewed-by
---
 .../integrity/platform_certs/keyring_handler.c  | 17 ++++++++++++++++-
 .../integrity/platform_certs/keyring_handler.h  |  5 +++++
 security/integrity/platform_certs/load_uefi.c   |  4 ++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index e9791be98fd9..4872850d081f 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -67,7 +67,7 @@ static __init void uefi_revocation_list_x509(const char *source,
 
 /*
  * Return the appropriate handler for particular signature list types found in
- * the UEFI db and MokListRT tables.
+ * the UEFI db tables.
  */
 __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 {
@@ -76,6 +76,21 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 	return 0;
 }
 
+/*
+ * Return the appropriate handler for particular signature list types found in
+ * the MokListRT tables.
+ */
+__init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
+{
+	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
+		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
+			return add_to_machine_keyring;
+		else
+			return add_to_platform_keyring;
+	}
+	return 0;
+}
+
 /*
  * Return the appropriate handler for particular signature list types found in
  * the UEFI dbx and MokListXRT tables.
diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
index 2462bfa08fe3..284558f30411 100644
--- a/security/integrity/platform_certs/keyring_handler.h
+++ b/security/integrity/platform_certs/keyring_handler.h
@@ -24,6 +24,11 @@ void blacklist_binary(const char *source, const void *data, size_t len);
  */
 efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type);
 
+/*
+ * Return the handler for particular signature list types found in the mok.
+ */
+efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type);
+
 /*
  * Return the handler for particular signature list types found in the dbx.
  */
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index f290f78c3f30..c1bfd1cd7cc3 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -94,7 +94,7 @@ static int __init load_moklist_certs(void)
 		rc = parse_efi_signature_list("UEFI:MokListRT (MOKvar table)",
 					      mokvar_entry->data,
 					      mokvar_entry->data_size,
-					      get_handler_for_db);
+					      get_handler_for_mok);
 		/* All done if that worked. */
 		if (!rc)
 			return rc;
@@ -109,7 +109,7 @@ static int __init load_moklist_certs(void)
 	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
 	if (mok) {
 		rc = parse_efi_signature_list("UEFI:MokListRT",
-					      mok, moksize, get_handler_for_db);
+					      mok, moksize, get_handler_for_mok);
 		kfree(mok);
 		if (rc)
 			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
-- 
2.18.4

