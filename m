Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4303BEF24
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhGGSlG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:41:06 -0400
Received: from mail-dm3nam07on2063.outbound.protection.outlook.com ([40.107.95.63]:38977
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232548AbhGGSkr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIqiQTlTJJwe7wKFbRPieO1QEd76o32L9K/o11ALrtQ0BOQ3Xujd863Ha/azJd25TnGqjiNz5bFS5R6ObPzN/k5ToLltGmV1Qw3zPhVqkzhSGtaQE5xYM2Hvd89k3hHuqIBKbqsQEQpjI53zQxbQNsMzil0OQj9+3kP9oHjmaScqUVhgeWUc2LJuACWgRqbrUEr6durYHGZauXjPON9PH+uSEDAzGIzagpXglPwG1iyhL0flC8hvoHTdHdFamu5jf5DioeU4fAyyB29xdI3nX3XzQ/32kL2RMgQcwKMjeDLOYSfHWTT2gG4MfM2GqCDoyKnoZT3CB+W5sD9l9V7eqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK6L3qN8sjRbNLqwepTV1kU2Ys8Td5On6VBQWDHu5m4=;
 b=E0jEEpeJW/i3UlupBOor2fjdM4Fb667n8ZSTcdveKWkZr3ydQRlk+vNre/GFxIyyRIjCVhsmWCvJeUNcXQ9zRNO+KcipnrcHhwkIIxNoLf7KC28ml86bA+7DTumcJNpwmfyt1kj+huGwrCcP056CaqikM0SgyPrFovISYqJ05ix2jA6Cc2AU3JIn4mAjkW6hiFNU6gVAk8ogtOk98mvtLP57+Q98gGyiWmMLSbdr4OSCdfezsZ0AGnPnAqVkop3aeW+sDzhLTIv56dd8wL10F91MH0WEP2zfVbsBxK6L5EGUF+Sgm6Hf1hGNcBTOqmOAo3SG741/jGL47z01yNSU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK6L3qN8sjRbNLqwepTV1kU2Ys8Td5On6VBQWDHu5m4=;
 b=Iwtdq3FL3fD/rlMNiUQfMaDbJtHtM088zetanJ6qOl4rtdI8EMp62dXE0WJA+Gw8KO/+I5COh5TknOYdudbpxFs9x1gfKLR7oGaqm93alptjX+mxnROcRQn90sIa86OqYCsbcml7GYd/Gyk2YkCDwH3kQvMHhyH4zQQdGqDmavc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:41 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:41 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part2 RFC v4 18/40] crypto: ccp: Add the SNP_{SET,GET}_EXT_CONFIG command
Date:   Wed,  7 Jul 2021 13:35:54 -0500
Message-Id: <20210707183616.5620-19-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e0267e0-870e-45a8-44d0-08d941764d97
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB280896DF302F5A17D79C49F6E51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SC0GvutFbN9Kim//ZJ44yo+UIYgCyW2vRAdf1quumcQN1PzXGQ16W6VZikf4K4if9p7HpaxGWKv6+xDEfh+BfknWv8njIvJo0ityopBNSijiTn6DUZT/zAboW1p5wSsVKFHMS+E9sAissukf4jM/y6VD479jrDOneRlG2FI4ELqP+XdZ930ps+VYgKeSsQOJT6inq64+BBe7xRGZValIa+bs5GM+xh0oWVfBo8SA0EWH2rUveuc1DgIUPDPjx3yroO6+gzUFPSa4aCWY/nZVn2qXxCJVsVy68Xj05nNdxpCEAzVyNjAnPOFc3KhDzsrJuzNRhDiAW65NZ7hP+m/UIL3FGKy+aaLueVn/fmioWrRhOMlhYVmkp0wP3bDyjEN+LjHMsPjHgPp8yESXDgBsmUqugLIRVE+6mTAqrGbWMEYpCsuSCDVIFA+r7njjYGjjhta/b9/0OKVE0xELfT/8L2A3cfLZWLrsLSl5LivjFLQ9MI+AxDsL/wKGh3CjcO7ZrKddikDb8pjQfOUklOTLWJeYTBpuTE42V0+9yw9nQfVJ3Cp4YX2l2sXLlsOn+DwbH/S+RYGeBXFGXSkKMlO2Hc1ynBaDR1k8OhiqdloBB8FClQn2c/N8s26ZBvL/xtgG21beUfAvI1OybcnkDEPJlaHv8Xvbzz5Ooi92kwJNsxEzVaq1KCkbdKO67XP7fWNibemDcHv4c/jcI3v60Q1V4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B1at8POG4+BhjHPDC9V6inz9r6+A7EiD/LD9tDgEwJrA1WNypyONwqKJJzoz?=
 =?us-ascii?Q?EkCIQGvSybimKIX0E7c+oZKsJRSjqZl0TUSmVhTFG4rF6I4za4I7h30ipc4+?=
 =?us-ascii?Q?Or3m1G6/IF7pa1z2FHj7w12QwEBKmvUjxKNd80CYV01UPz00fqapo2Z6yyJa?=
 =?us-ascii?Q?TwyhBah+HgTzBkbQZneu8QNXGuLyhLpVMyM7Uh2z28+ODqFsQmxKPdYojWqC?=
 =?us-ascii?Q?5pDiUPwbrXUhwclgHaZmBqXOoJpOavVf44OZYEPCfYiKDLPjanfp4f6yFAaq?=
 =?us-ascii?Q?nycAQ4cQHk6kBeiH8yB0CrnTqs2M/GCRiGf8J6HvfDqVpBnwN4yFZk6ZjZNK?=
 =?us-ascii?Q?Qqc+gP+CvnvqWCj2ci758TM4qY3gpN5nE2WDxNMaMmu2JWKGa5W+N3wKoZmU?=
 =?us-ascii?Q?G2qYhV8w2yU13QNVcUpu5kBWdhaO8vgTHCBCk74L141dEQTeuamknrLv1Zxb?=
 =?us-ascii?Q?J70nW5ShXfcVFsredRuHNZ6tSh9Zx1KcREYR/mDGrrUwyTq8hLsViBCuQ/tA?=
 =?us-ascii?Q?ygYDwDw59iUjXTpvKLYG5rbGJ9zxr/d5h4FnXsePyGiMJb0GlH+jWAz0Mw0n?=
 =?us-ascii?Q?auCcBe8n36QP03cRn/oPItDohMadvQfbnQXhixhDBWhebqzXPH3YZLU0LZak?=
 =?us-ascii?Q?53GGTwT+kDm+TgOJijNic4njp9xI0egTU5QJY7jGNHjGNRb1NJBskyylROV/?=
 =?us-ascii?Q?stJER5w8c7fWnQnpXN8rPXQv1ghkp22fB39p7bk99ei8c3W1oCJtAhZrKnTr?=
 =?us-ascii?Q?2P82uzdW3rWiz1lrOII1vaxyPZ+ttX7kY5U+XztyOqCwH0Q7NkqoU3TxMdvw?=
 =?us-ascii?Q?V1y9Xi2fTO1ocV7X1pcLgFya6YjE/LhDJp1e4CSeJAz1INCUIuvmMaRgeJda?=
 =?us-ascii?Q?vr5yy07czhd3549ek38PUeGQV9VJkEmSFhHDamGIrWfyh6+Gg/2jtROdlA8S?=
 =?us-ascii?Q?neTV6YGIxp/hMHRTyfmxdGUoA2EHIelrDxyS1IWUGrS4MxHXxULTqcvmXkvu?=
 =?us-ascii?Q?4pjSW2+ClcQnX3bGqKDmRVq+kNV0KS+3v+HEUFWCGfMJUPYcnKwcOSZI2Qgk?=
 =?us-ascii?Q?YYbwM/OTK9xKojmJ60lZiZhNPdXPE7V490CFNzkuCsde70JVgmMOzHFtzcQr?=
 =?us-ascii?Q?0vahUnrCR6jS9cn31YmP+Y1DzrCjFWuJbcQR9WkZqcoF0qqra7k+O8/1KGNq?=
 =?us-ascii?Q?6Wp3h14fhZ9FCXIF8Qdavz2qqms+5FKgVkyRITONtBIAEA1T87JT1MMiVA/b?=
 =?us-ascii?Q?SXzC1/Da71n2nD2tbRwE4OI6uYWRd84aoQLfkXxAzXB026mBcB8X9WhABJ7U?=
 =?us-ascii?Q?+1eCh1KCjCNI3Pn/VqPGpp/h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0267e0-870e-45a8-44d0-08d941764d97
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:41.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCk4eZ0iMODwCDEA2E7aHcagEEVtT4fW2yCzLejTp2FqhDdoZJ3HlHNgY3VYk1HKD23DYwUG0k9GlSgoJejHnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-SNP firmware provides the SNP_CONFIG command used to set the
system-wide configuration value for SNP guests. The information includes
the TCB version string to be reported in guest attestation reports.

Version 2 of the GHCB specification adds an NAE (SNP extended guest
request) that a guest can use to query the reports that include additional
certificates.

In both cases, userspace provided additional data is included in the
attestation reports. The userspace will use the SNP_SET_EXT_CONFIG
command to give the certificate blob and the reported TCB version string
at once. Note that the specification defines certificate blob with a
specific GUID format; the userspace is responsible for building the
proper certificate blob. The ioctl treats it an opaque blob.

While it is not defined in the spec, but let's add SNP_GET_EXT_CONFIG
command that can be used to obtain the data programmed through the
SNP_SET_EXT_CONFIG.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 Documentation/virt/coco/sevguest.rst |  28 +++++++
 drivers/crypto/ccp/sev-dev.c         | 117 +++++++++++++++++++++++++++
 drivers/crypto/ccp/sev-dev.h         |   3 +
 include/uapi/linux/psp-sev.h         |  16 ++++
 4 files changed, 164 insertions(+)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 7c51da010039..64a1b5167b33 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -134,3 +134,31 @@ See GHCB specification for further detail on how to parse the certificate blob.
 The SNP_PLATFORM_STATUS command is used to query the SNP platform status. The
 status includes API major, minor version and more. See the SEV-SNP
 specification for further details.
+
+2.4 SNP_SET_EXT_CONFIG
+----------------------
+:Technology: sev-snp
+:Type: hypervisor ioctl cmd
+:Parameters (in): struct sev_data_snp_ext_config
+:Returns (out): 0 on success, -negative on error
+
+The SNP_SET_EXT_CONFIG is used to set the system-wide configuration such as
+reported TCB version in the attestation report. The command is similar to
+SNP_CONFIG command defined in the SEV-SNP spec. The main difference is the
+command also accepts an additional certificate blob defined in the GHCB
+specification.
+
+If the certs_address is zero, then previous certificate blob will deleted.
+For more information on the certificate blob layout, see the GHCB spec
+(extended guest request message).
+
+
+2.4 SNP_GET_EXT_CONFIG
+----------------------
+:Technology: sev-snp
+:Type: hypervisor ioctl cmd
+:Parameters (in): struct sev_data_snp_ext_config
+:Returns (out): 0 on success, -negative on error
+
+The SNP_SET_EXT_CONFIG is used to query the system-wide configuration set
+through the SNP_SET_EXT_CONFIG.
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 65003aba807a..1984a7b2c4e1 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1087,6 +1087,10 @@ static int __sev_snp_shutdown_locked(int *error)
 	/* Free the status page */
 	__snp_free_firmware_pages(sev->snp_plat_status_page, 0, true);
 
+	/* Free the memory used for caching the certificate data */
+	kfree(sev->snp_certs_data);
+	sev->snp_certs_data = NULL;
+
 	/* SHUTDOWN requires the DF_FLUSH */
 	wbinvd_on_all_cpus();
 	__sev_do_cmd_locked(SEV_CMD_SNP_DF_FLUSH, NULL, NULL);
@@ -1373,6 +1377,113 @@ static int sev_ioctl_snp_platform_status(struct sev_issue_cmd *argp)
 	return 0;
 }
 
+static int sev_ioctl_snp_get_config(struct sev_issue_cmd *argp)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	struct sev_user_data_ext_snp_config input;
+	int ret;
+
+	if (!sev->snp_inited || !argp->data)
+		return -EINVAL;
+
+	if (copy_from_user(&input, (void __user *)argp->data, sizeof(input)))
+		return -EFAULT;
+
+	/* Copy the TCB version programmed through the SET_CONFIG to userspace */
+	if (input.config_address) {
+		if (copy_to_user((void * __user)input.config_address,
+				&sev->snp_config, sizeof (struct sev_user_data_snp_config)))
+			return -EFAULT;
+	}
+
+	/* Copy the extended certs programmed through the SNP_SET_CONFIG */
+	if (input.certs_address && sev->snp_certs_data) {
+		if (input.certs_len < sev->snp_certs_len) {
+			/* Return the certs length to userspace */
+			input.certs_len = sev->snp_certs_len;
+
+			ret = -ENOSR;
+			goto e_done;
+		}
+
+		if (copy_to_user((void * __user)input.certs_address,
+				sev->snp_certs_data, sev->snp_certs_len))
+			return -EFAULT;
+	}
+
+	ret = 0;
+
+e_done:
+	if (copy_to_user((void __user *)argp->data, &input, sizeof(input)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+static int sev_ioctl_snp_set_config(struct sev_issue_cmd *argp, bool writable)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	struct sev_user_data_ext_snp_config input;
+	struct sev_user_data_snp_config config;
+	void *certs = NULL;
+	int ret = 0;
+
+	if (!sev->snp_inited || !argp->data)
+		return -EINVAL;
+
+	if (!writable)
+		return -EPERM;
+
+	if (copy_from_user(&input, (void __user *)argp->data, sizeof(input)))
+		return -EFAULT;
+
+	/* Copy the certs from userspace */
+	if (input.certs_address) {
+		if (!input.certs_len || !IS_ALIGNED(input.certs_len, PAGE_SIZE))
+			return -EINVAL;
+
+		certs = psp_copy_user_blob(input.certs_address, input.certs_len);
+		if (IS_ERR(certs))
+			return PTR_ERR(certs);
+
+	}
+
+	/* Issue the PSP command to update the TCB version using the SNP_CONFIG. */
+	if (input.config_address) {
+		if (copy_from_user(&config,
+				   (void __user *)input.config_address, sizeof(config))) {
+			ret = -EFAULT;
+			goto e_free;
+		}
+
+		ret = __sev_do_cmd_locked(SEV_CMD_SNP_CONFIG, &config, &argp->error);
+		if (ret)
+			goto e_free;
+
+		memcpy(&sev->snp_config, &config, sizeof(config));
+	}
+
+	/*
+	 * If the new certs are passed then cache it else free the old certs.
+	 */
+	if (certs) {
+		kfree(sev->snp_certs_data);
+		sev->snp_certs_data = certs;
+		sev->snp_certs_len = input.certs_len;
+	} else {
+		kfree(sev->snp_certs_data);
+		sev->snp_certs_data = NULL;
+		sev->snp_certs_len = 0;
+	}
+
+	return 0;
+
+e_free:
+	kfree(certs);
+	return ret;
+}
+
+
 static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -1427,6 +1538,12 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 	case SNP_PLATFORM_STATUS:
 		ret = sev_ioctl_snp_platform_status(&input);
 		break;
+	case SNP_SET_EXT_CONFIG:
+		ret = sev_ioctl_snp_set_config(&input, writable);
+		break;
+	case SNP_GET_EXT_CONFIG:
+		ret = sev_ioctl_snp_get_config(&input);
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index 5efe162ad82d..37dc58c09cb6 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -67,6 +67,9 @@ struct sev_device {
 	bool snp_inited;
 	struct snp_host_map snp_host_map[MAX_SNP_HOST_MAP_BUFS];
 	struct page *snp_plat_status_page;
+	void *snp_certs_data;
+	u32 snp_certs_len;
+	struct sev_user_data_snp_config snp_config;
 };
 
 int sev_dev_init(struct psp_device *psp);
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 0c383d322097..12c758b616c2 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -29,6 +29,8 @@ enum {
 	SEV_GET_ID,	/* This command is deprecated, use SEV_GET_ID2 */
 	SEV_GET_ID2,
 	SNP_PLATFORM_STATUS = 256,
+	SNP_SET_EXT_CONFIG,
+	SNP_GET_EXT_CONFIG,
 
 	SEV_MAX,
 };
@@ -190,6 +192,20 @@ struct sev_user_data_snp_config {
 	__u8 rsvd[52];
 } __packed;
 
+/**
+ * struct sev_data_snp_ext_config - system wide configuration value for SNP.
+ *
+ * @config_address: address of the struct sev_user_data_snp_config or 0 when
+ *      	reported_tcb does not need to be updated.
+ * @certs_address: address of extended guest request certificate chain or
+ *              0 when previous certificate should be removed on SNP_SET_EXT_CONFIG.
+ * @certs_len: length of the certs
+ */
+struct sev_user_data_ext_snp_config {
+	__u64 config_address;		/* In */
+	__u64 certs_address;		/* In */
+	__u32 certs_len;		/* In */
+};
 
 /**
  * struct sev_issue_cmd - SEV ioctl parameters
-- 
2.17.1

