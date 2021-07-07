Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC883BEEEA
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhGGSkR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:17 -0400
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com ([40.107.223.42]:41569
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232084AbhGGSkL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVpmpSoA/KS/EeLKaVlpWVukJqEhfpH7DXHcUVuLtO18tucDF6m12A55qbxY0jb+0XinZb/nT8Y9BWxkWqiiEEukxgNrFJUxB74Uy0RCSD0Hfrs1vbAauvywKIU/+A9b54RHVxPbmSUmkIRllIKkrl4N8qV78xE1Nsr3x9f3uCbmn8R9cas1O0AvtwjK+q1jcU/3D2qtp/3A3MrrVMbWIcahQ3C9hugOGykJnhI0zGSQWUBFaTGy4ANDGMqzqcMNEgCEqoo/Ytu7qT3Fyp4e3LvDUTWQLiz2plB3zCD7AOxTPDZxqdcjUdYAcU0quQMpKytVm7MpPppgQa12jenwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T20x7H820UMIAP6tw3oUk8JA1hwxpn6tKWvJYiGndPE=;
 b=Rv/8Ui4a/FAUHxo71IoxaSRKrniDBnhSHdgCIJECoZT+VwZKDAiKerh9drdhrRGXJU3qkm0RbUHYsctKf0oY5zvTUUNx0dXMKBFG8IqUdT5Qr4psZNLHwcEVrQlucHmehdEFWli6JZKioUreSVFW79qYoRZHkWf45zixKCizvRMuYFCfcWhKHT1gJhqwVm6aPkVqw0+QdcYzGBQVEDP+vpXyi6QrlN3ojEu/JK9nrSHxzzw8E1EpdlY064OQLfpaeFzlGbDuifBQ/P7L9XVK3kLSs+P4QeIC25eDhUR8XavEfukA3S/JMB56luRWAo0eGNG3xADwO9JEY93d7mfSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T20x7H820UMIAP6tw3oUk8JA1hwxpn6tKWvJYiGndPE=;
 b=vyAnE3xvrjlw+qWKowaxjdFeoKsL975AzHNoNd6Pe0p3zcy9hlCPxutXGABPyAenyNET9fkQjpYLzSm8x10GqVmT8+5sykyfITslfEDCc9rZ95kzNNXFDsKn2l8Jg8C9WncN69LcFQxhphkZQfrqv35NE6RyycUPiBrYaKtdltM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:37:28 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:28 +0000
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
Subject: [PATCH Part2 RFC v4 13/40] crypto: ccp: Shutdown SNP firmware on kexec
Date:   Wed,  7 Jul 2021 13:35:49 -0500
Message-Id: <20210707183616.5620-14-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66bffe6f-a159-43eb-4237-08d94176459f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4082570C4179F28D1591796AE51A9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+iBR2jNeX83nFCug2aQ1kPvdsLQpu1z75kwEb+apmrKz76qeEMOI1QAFajB7Jfu5lyYy+Wj6V+8f4uB84XjcQzleKTLxSrCX6rlhCPAKBOqpwNwLP4+5t4F96QxhJuF48k/Lf9xWAOwg8zBh4oDTrNU90n1dthrfaoBeVbPPErk0/c2Q5tg4X2mup7tu+yDybo09jB9KPub9BpM32w1FUMRpohZa7/6HpmLdjvMKJ4PgABKLovhW0vxqbf9qkidIBOnZgdhOEv9k3Dxje1Go6KakF2kb3jOgmjthsFsFT1BVn0mIltyFRwpXr9ASiTaHXQQceTyQuXNHem82vCfZB55rxISJ/lSxrJP/jDIkXhx6FaCtyrdUYg/lMTS35g6p3xBGALJB39WC3rpQo5wZxq0+feglAzyAKickyqXOcL39I81ahkW/YoURMghf+ZOVjlSmbmFpNLShlnOoHUilrGCxIpT6RLWg1v5LE/5EpR/3GkHnj54Z+ZFJhozKoqab+hCfxmFyik/+zuFM2586+bmSDqe7qfSjjoMsKX/an2OJ2GJnec3Y+22mQxz0d8/sGBk6iTQeUY1/5OwOEBHppjeLeTwdZHZv141FDvN8UAtnILEbZllzvisUeomwp5UW2HCPSV9DPaXkbYGbO7lCn7Xt74a64VEp4gOtxW08E0mTdc7gWZIB9KeNUSMCRGXtybJ2SDZD/j69lR7a/vTZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(7696005)(52116002)(44832011)(8676002)(38350700002)(66946007)(38100700002)(54906003)(66476007)(8936002)(478600001)(6666004)(956004)(6486002)(7416002)(66556008)(7406005)(186003)(2616005)(2906002)(83380400001)(1076003)(4326008)(86362001)(5660300002)(36756003)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QaWOtka+UmdsUvKC6S0I3xnummQAjDSeoN0TuYLLVa3OoCRiVIYNqzWn3ALS?=
 =?us-ascii?Q?mm0+QZozRi235kCqvXKsqRsebcm3d3haLjuQJCb6F06oSZsMpyizDGzRsSFJ?=
 =?us-ascii?Q?+gAgegtwxzwsio2hGBoDVRQ+O9ncVIRAK967LUj+JRv+mkIjqw3wSe3/hZa8?=
 =?us-ascii?Q?CCunnakcpjE/iNb17rq8hrKkDeawldDVVRlhrOuNc8dsVQsdL3C/Mk+3LfJE?=
 =?us-ascii?Q?idOMVRrGLcPk2qrgfxLStlg8MJLtNusWKNJZ5/ylhrSpANCxPhZP2qwTKkjz?=
 =?us-ascii?Q?PCU9uF7Kx0EIWnnZQ8nyknM5jYJCUxXQ2h/6M2jvqKTpq+BTAgdu0OvS8p7l?=
 =?us-ascii?Q?1zJ7j5FzmienIf6bTTEprDC5UpBLzypFjMhy/YEPLXjPPlKcChDURew8yfQU?=
 =?us-ascii?Q?LxUoUkpyIIfgWuqaPumk2zxo42SUq5E9SLCAJjYZmcilYCTtjxHjErnFa4zj?=
 =?us-ascii?Q?JFTW9Eqpn0T4dMH5aQD4GSLfMazxkHau3huWPPTDdZadjhHXKUUfBjuSueCG?=
 =?us-ascii?Q?GZlCk8+yBHKheuiDe6HcdtaV4LEJu+NMiMEcRXKQ6VObqxrErlxK02lgJJ76?=
 =?us-ascii?Q?+WSDbJgKap/rH7ktjKqLWtOSTVob/wktGpntruf75xsBIjs5VTRFeLMkB+Hr?=
 =?us-ascii?Q?m72Mi23/D6a2aWxdIYAcCyiSVARM+VTu7k1MA1mBL9F+4+PJUYx50Hvz4Ql6?=
 =?us-ascii?Q?5KVajOx8PWzq6FhEP0jfYaLHlyfhUkE2aOQoX6uSlZygA4CmhnJJ+1jYM1yK?=
 =?us-ascii?Q?lp0PgeqtiaPdj9eZ3Nww/tu2uz82ipPG9WOrq4BT1EfpNTI6Clg2bjLN8Gv/?=
 =?us-ascii?Q?FkMI97tiq8UNzfsTvRvpVXE2KyGmiOQ9TFhqUNsK6g78E6rqV/ZpGeie9gNm?=
 =?us-ascii?Q?CPv19dGbU3XIpdiHlfHLo/yi/z3pz+N8W8cLjOHroD+6/H+ODrewVknetBFW?=
 =?us-ascii?Q?qVqNqffx74WSi9Fd6XrL2Wug4yWrLHd6jI36+lYj3z4cw5ZaYDD1lzuY3Ztu?=
 =?us-ascii?Q?44hajzCOy6mXCNjzOhqwoLNSCbEQ/68SnQgj9TL4Ufk4pX25kPumODbIxX3v?=
 =?us-ascii?Q?FEgC8jB3I0Rn2NsrT1e3eYFphsn0T86TKCrVxN4qqa9Pal/YdpjU2KvAiCZ+?=
 =?us-ascii?Q?7CFdwuUwQwojtQ3XCx4CEhTsnoEyFvBQKOdjOjgGNAgyjub63GsCyz+8g3r+?=
 =?us-ascii?Q?O+SFH/3/uDiaqCGR908dEOV3wIRkPOtlm5fiIaKD4yzvOMkTzcT1tLg/SGEp?=
 =?us-ascii?Q?2fleI8f/hSUEm7eWB3yDUukPwzRgL3JnzBLT+Tg3USW3NNOVK4/P0tyUxO0I?=
 =?us-ascii?Q?F+iFFu4R3EUgNvVf7SUOlWEq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bffe6f-a159-43eb-4237-08d94176459f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:28.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCRKaCdZOBelwoJ2SnslAkIX7+wxCh/FsZPK4zWWBMG6lGIqPugyjOl7/gJISNg4oEtUTdZ2TuRVMeY0ndBpJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When the kernel is getting ready to kexec, it calls the device_shutdown()
to allow drivers to cleanup before the kexec. If SEV firmware is
initialized then shutdown it before kexec'ing the new kernel.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 53 +++++++++++++++++-------------------
 drivers/crypto/ccp/sp-pci.c  | 12 ++++++++
 2 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index d3c717bb5b50..84c91bab00bd 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -310,6 +310,9 @@ static int __sev_platform_shutdown_locked(int *error)
 	struct sev_device *sev = psp_master->sev_data;
 	int ret;
 
+	if (sev->state == SEV_STATE_UNINIT)
+		return 0;
+
 	ret = __sev_do_cmd_locked(SEV_CMD_SHUTDOWN, NULL, error);
 	if (ret)
 		return ret;
@@ -1118,6 +1121,22 @@ int sev_dev_init(struct psp_device *psp)
 	return ret;
 }
 
+static void sev_firmware_shutdown(struct sev_device *sev)
+{
+	sev_platform_shutdown(NULL);
+
+	if (sev_es_tmr) {
+		/* The TMR area was encrypted, flush it from the cache */
+		wbinvd_on_all_cpus();
+
+		free_pages((unsigned long)sev_es_tmr,
+			   get_order(SEV_ES_TMR_SIZE));
+		sev_es_tmr = NULL;
+	}
+
+	sev_snp_shutdown(NULL);
+}
+
 void sev_dev_destroy(struct psp_device *psp)
 {
 	struct sev_device *sev = psp->sev_data;
@@ -1125,6 +1144,8 @@ void sev_dev_destroy(struct psp_device *psp)
 	if (!sev)
 		return;
 
+	sev_firmware_shutdown(sev);
+
 	if (sev->misc)
 		kref_put(&misc_dev->refcount, sev_exit);
 
@@ -1155,21 +1176,6 @@ void sev_pci_init(void)
 	if (sev_get_api_version())
 		goto err;
 
-	/*
-	 * If platform is not in UNINIT state then firmware upgrade and/or
-	 * platform INIT command will fail. These command require UNINIT state.
-	 *
-	 * In a normal boot we should never run into case where the firmware
-	 * is not in UNINIT state on boot. But in case of kexec boot, a reboot
-	 * may not go through a typical shutdown sequence and may leave the
-	 * firmware in INIT or WORKING state.
-	 */
-
-	if (sev->state != SEV_STATE_UNINIT) {
-		sev_platform_shutdown(NULL);
-		sev->state = SEV_STATE_UNINIT;
-	}
-
 	if (sev_version_greater_or_equal(0, 15) &&
 	    sev_update_firmware(sev->dev) == 0)
 		sev_get_api_version();
@@ -1227,19 +1233,10 @@ void sev_pci_init(void)
 
 void sev_pci_exit(void)
 {
-	if (!psp_master->sev_data)
-		return;
-
-	sev_platform_shutdown(NULL);
-
-	if (sev_es_tmr) {
-		/* The TMR area was encrypted, flush it from the cache */
-		wbinvd_on_all_cpus();
+	struct sev_device *sev = psp_master->sev_data;
 
-		free_pages((unsigned long)sev_es_tmr,
-			   get_order(SEV_ES_TMR_SIZE));
-		sev_es_tmr = NULL;
-	}
+	if (!sev)
+		return;
 
-	sev_snp_shutdown(NULL);
+	sev_firmware_shutdown(sev);
 }
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index f468594ef8af..fb1b499bf04d 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -239,6 +239,17 @@ static int sp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ret;
 }
 
+static void sp_pci_shutdown(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sp_device *sp = dev_get_drvdata(dev);
+
+	if (!sp)
+		return;
+
+	sp_destroy(sp);
+}
+
 static void sp_pci_remove(struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -369,6 +380,7 @@ static struct pci_driver sp_pci_driver = {
 	.id_table = sp_pci_table,
 	.probe = sp_pci_probe,
 	.remove = sp_pci_remove,
+	.shutdown = sp_pci_shutdown,
 	.driver.pm = &sp_pci_pm_ops,
 };
 
-- 
2.17.1

