Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED63C39FEAD
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 20:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhFHSJM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 14:09:12 -0400
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:14369
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234291AbhFHSJJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Jun 2021 14:09:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPokZuvCEMTM7FAr8X6v57oKIgBhkYZxUBz7l3LeB5ccGGnpVniLQ76kTJfw6k6xlkeBbBwiJ+2ZtnrUdI0KNJUuJLv9h+tybUSSnol+hPttB0FN2+Hy80wMSRD2xcmUGbcWXR0m5HIUsQGjzQlBPljoKJs3EdYHQRdPWUsPB5sVZdqePa5g/M7q8cFIfNI6vjcFPFjE1X2PPfR41aKMi2a0jgi72Z36OFdNGkLiXnag61EQ9Wrw0zPdI5hKeUhhDxg3YYw+9YZm5Hb2C28uchqAjWRJGaahoiUn9q/jYAmQ5biDpQmxTaWHJsj7J+5+ixdwrivVa6WAJIjRqD9X2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byPxPBVAaVcaJmF4W2HW9APZqi6drLzD62O/iiYnsEs=;
 b=ciF2qjaIVENbX9mDtfmThmmGor+7Em/gYCI+G3jwb+lmP5bUit/pWRnjZ+vjbXUoMDCLQbsZYqnGMXYi9yCUw/sMD5sedLNfC/NTsSOHqs27WWnt1HBmKibaiSJ6c6IIBw/Smuqa9ioDCFnPCHaNinkag4BgaQfwNr+mx4iVagtmxkYAKuEl+YdxbEcdREOWcbeA1xVIBRtVPWh/x261H1XrA4ib/l0rTAFGW0Z/vtAeSU3e7y2o78wAzR2VyNtsDHLlIQC4SuUivrqD97XSGEWQUd+Cneu8LMOy+0z+c308cE3YDk7XHbeU7CGh2hnlL3bFrEECdMDysa90XqsWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byPxPBVAaVcaJmF4W2HW9APZqi6drLzD62O/iiYnsEs=;
 b=u1wOV8wUJlgB2W+TLw8d0wgQdvWdQELkMpPBcrC8hh/bDduBmr8Re4+QXZRIppT0DmlzqT7eedO3efCyEbjsPxZiFnN0ymvcBMHqXp4pwbcly1D7evCvZs3Rha8yo8+PzF71qQL6KxM6b8+jZP4+NbQi74my7t113L1KhIO34AQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2759.namprd12.prod.outlook.com (2603:10b6:a03:61::32)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 18:07:14 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::ed9c:d6cf:531c:731a]) by BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::ed9c:d6cf:531c:731a%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 18:07:14 +0000
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     pbonzini@redhat.com
Cc:     seanjc@google.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, linux-efi@vger.kernel.org
Subject: [PATCH v3 5/5] x86/kvm: Add guest support for detecting and enabling SEV Live Migration feature.
Date:   Tue,  8 Jun 2021 18:07:04 +0000
Message-Id: <951a07f3b9e25cb7dd8fbc8d1797f216008c139a.1623174621.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1623174621.git.ashish.kalra@amd.com>
References: <cover.1623174621.git.ashish.kalra@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:806:6f::35) To BYAPR12MB2759.namprd12.prod.outlook.com
 (2603:10b6:a03:61::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by SA0PR12CA0030.namprd12.prod.outlook.com (2603:10b6:806:6f::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 18:07:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b72e0e05-0ac2-49e3-eb27-08d92aa83e94
X-MS-TrafficTypeDiagnostic: BY5PR12MB4065:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40658EDE966C22218D31D60C8E379@BY5PR12MB4065.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbryhYLM7C9ksedU/Tq3RUbqyYprVpPph2fy3gm+W8joDNQg97uly2exti5X8rNVJow3yqsm+zr2KDX7F3iPEFns1YMYW6N0zawA1QA3uhheyfruqg909K3nQV/5kbZfE9Bz9TYHALM/MR03au0EVK0j8OUiDtTp+V98EztA2gquw9INYU8QcKf5yhhzN+j0qZm0jTp7a8gdSumdzHp29IEonGNN9u0gExytsis+0c2TlEGxc/aq1VqYBOhp5i5McWfhTR4ZrPdBO9cj6AD5urYAxwedqos/YVl7rEgbabI+8tljFHAkXtDR3qAjZ26/mJGKmiJQSyJ8ZQ4jF3WeZCh2wS5I9/kUSj2K1BAGB8zs1n3BKachY/HxgU/1jxt+qXNJHwDhZXwTpVqLWNISwP4K0z0jcCl39rGwqnRK6oUc0vRvJSOSWQbfW+2Yxr5UwvbH9GcDAxvzjuPuaDj/Jtdx+s2b6wuQhg8lEmpFG5V8Y0li9EXFpn9TZDZZAs73W4YE+GLVCDfws090plGE3CvbyCFgV8R96PP5xP6RWZJo+pSlmETKkzVNUW+poIKUOh/+0OaXnF17IHvExHjgexdpYycOZckVlSw7aiYob5Icb2+Ltq8MthCbhhzsABvDDWWTBQE1C4oxmG7300AL3fHOGy8GghfYafeJdZUphpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2759.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(6916009)(4326008)(38350700002)(38100700002)(83380400001)(6486002)(5660300002)(86362001)(8936002)(7416002)(66556008)(8676002)(66476007)(186003)(26005)(956004)(16526019)(2616005)(478600001)(52116002)(6666004)(7696005)(316002)(66946007)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8UGd5xPr9V1O646fsiQUVthZCbAKOCkPTzpAmQtvN/dSyU0vaeeeHujQeXvc?=
 =?us-ascii?Q?F3XELbcHUI4AKzKduDTfkFCNDzO/ZS5R9vaWCMymP9opeYucLEobU7PuGro+?=
 =?us-ascii?Q?51K3+dMDy4HMPJoUdJ20cj4jpxjgR8B5nPGCmSvDsycD+D2Qev/1p8/OiyY1?=
 =?us-ascii?Q?QJkOAtTMFgC+2bTKGUzmhciUbzyKPcAzsAlnw9LZaCNnIs6TllFnQ+yM1rfv?=
 =?us-ascii?Q?tS9NXhoPuXiPnLVAGEJEpZA3P79Hs4Q1ryoV4VGN2OlPHVJwT2GF50v0Rn2f?=
 =?us-ascii?Q?vxf9QB76JtK2sbqBVimCuq4eODbhkCZuZ/INpmpRZacQ29bJiHyUDpqKfmCV?=
 =?us-ascii?Q?mqJjjSayJf9aWOfWkzgr2HODNgYQx4+XCn93PJbFjKZe477IcWt1wwc/IHDy?=
 =?us-ascii?Q?n5lFEzUkPHK+8xEpum+vJPV9hr9b3dcA4J6ALaOUTD5CqVRfeD9BJ1kM4wtG?=
 =?us-ascii?Q?tlKG4sw3uMl2JvWkLLiZFYBlaopcYAmusZ42ZZjJjt7HWhL7PRidggljz8Gj?=
 =?us-ascii?Q?yPO7xBzCJf7Iwxp5YpaEKIOVytIi+NgJB0CaojZgE1GXZ5UNCMfeVPRUPEBb?=
 =?us-ascii?Q?/5Exwo0ag7Qc8ETzLkY9EQAwUBr1kOBjo3eAzTPkaeZmRafPv2zjdZGDKKfS?=
 =?us-ascii?Q?jniOF4puaNDY7lDQNTRXLrcw4Tn/baOVA5bE6MdnXzzyKtidkS3bLyA7abuN?=
 =?us-ascii?Q?MQp0rwaCCYRvAb6K6Pkr1GWwCG7973oaKQDymqRWDnIZ35OPlpdL7e2WJYcS?=
 =?us-ascii?Q?RQH1+SyfCsp2PJMc8fb4GcKokzIm2gtv9FQ3z0etKmzD3ERDPVsxzgjvaTEz?=
 =?us-ascii?Q?+1fjGEGgE3V+zGy4zGAhw55PT7jPG2PdRv4Sg0QdlKRg+RMt/Ctt+lfuvSOA?=
 =?us-ascii?Q?wA055RDMAy1WFVqENd9zanV1rMPhAK7Y9lNvoG30kJIgW+EKNws4kZMqIfPF?=
 =?us-ascii?Q?yGPIyXhe1Oes3iCo/62a6ei0abaQKn2u0P0e7tOe3P19PrX4mWZ/T6zgwPSW?=
 =?us-ascii?Q?Z0VL8Ba1YlmnmquAYok4z4e4xMs3xDadqzMm3mxj05baEziOKWq/zYjVhlG1?=
 =?us-ascii?Q?uyg4sJa4fdY8TUzdxfC6mi6LBYqYd0Xl4dR758osFHjUo//E8ZL1iqwHiaJg?=
 =?us-ascii?Q?b0s+sAcdXjwu8ZhVQNZD1Z0kYk0dk1v0duC/LkcHtWWlbOrczpW8pMQKackU?=
 =?us-ascii?Q?ulIyR6ciaQ19gwBfLgRvhoptaGoxgjimJQZoPL9GN2dFBzKKyCQ6DhYBsAzk?=
 =?us-ascii?Q?xc3MJT3uk7Wzv3hwkjEspAhhyvW/9fkNU1Rf0mgssVhm8/bKW76NtXqawCtW?=
 =?us-ascii?Q?flPg4y6HYbISp4r54X9Nj2Zp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72e0e05-0ac2-49e3-eb27-08d92aa83e94
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 18:07:14.3784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /plWAtxytF6pWuSwwATDdXkNcPkURPtnnh5obINmJ/O8vqK65B+mI5v2hbcbNfYRPTLsrKjjNMhMJ+WsvMbEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

The guest support for detecting and enabling SEV Live migration
feature uses the following logic :

 - kvm_init_plaform() checks if its booted under the EFI

   - If not EFI,

     i) if kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL), issue a wrmsrl()
         to enable the SEV live migration support

   - If EFI,

     i) If kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL), read
        the UEFI variable which indicates OVMF support for live migration

     ii) the variable indicates live migration is supported, issue a wrmsrl() to
          enable the SEV live migration support

The EFI live migration check is done using a late_initcall() callback.

Also, ensure that _bss_decrypted section is marked as decrypted in the
shared pages list.

Also adds kexec support for SEV Live Migration.

Reset the host's shared pages list related to kernel
specific page encryption status settings before we load a
new kernel by kexec. We cannot reset the complete
shared pages list here as we need to retain the
UEFI/OVMF firmware specific settings.

The host's shared pages list is maintained for the
guest to keep track of all unencrypted guest memory regions,
therefore we need to explicitly mark all shared pages as
encrypted again before rebooting into the new guest kernel.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h |   4 ++
 arch/x86/kernel/kvm.c              | 107 +++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt.c          |   6 ++
 3 files changed, 117 insertions(+)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 9c80c68d75b5..8dd373cc8b66 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -43,6 +43,8 @@ void __init sme_enable(struct boot_params *bp);
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
+void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
+					    bool enc);
 
 void __init mem_encrypt_free_decrypted_mem(void);
 
@@ -83,6 +85,8 @@ static inline int __init
 early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
+static inline void __init
+early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc) {}
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index a26643dc6bd6..80a81de4c470 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -27,6 +27,7 @@
 #include <linux/nmi.h>
 #include <linux/swait.h>
 #include <linux/syscore_ops.h>
+#include <linux/efi.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -40,6 +41,7 @@
 #include <asm/ptrace.h>
 #include <asm/reboot.h>
 #include <asm/svm.h>
+#include <asm/e820/api.h>
 
 DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
 
@@ -433,6 +435,8 @@ static void kvm_guest_cpu_offline(bool shutdown)
 	kvm_disable_steal_time();
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
 		wrmsrl(MSR_KVM_PV_EOI_EN, 0);
+	if (kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL))
+		wrmsrl(MSR_KVM_MIGRATION_CONTROL, 0);
 	kvm_pv_disable_apf();
 	if (!shutdown)
 		apf_task_wake_all();
@@ -547,6 +551,55 @@ static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
 	__send_ipi_mask(local_mask, vector);
 }
 
+static int __init setup_efi_kvm_sev_migration(void)
+{
+	efi_char16_t efi_sev_live_migration_enabled[] = L"SevLiveMigrationEnabled";
+	efi_guid_t efi_variable_guid = AMD_SEV_MEM_ENCRYPT_GUID;
+	efi_status_t status;
+	unsigned long size;
+	bool enabled;
+
+	if (!sev_active() ||
+	    !kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL))
+		return 0;
+
+	if (!efi_enabled(EFI_BOOT))
+		return 0;
+
+	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
+		pr_info("%s : EFI runtime services are not enabled\n", __func__);
+		return 0;
+	}
+
+	size = sizeof(enabled);
+
+	/* Get variable contents into buffer */
+	status = efi.get_variable(efi_sev_live_migration_enabled,
+				  &efi_variable_guid, NULL, &size, &enabled);
+
+	if (status == EFI_NOT_FOUND) {
+		pr_info("%s : EFI live migration variable not found\n", __func__);
+		return 0;
+	}
+
+	if (status != EFI_SUCCESS) {
+		pr_info("%s : EFI variable retrieval failed\n", __func__);
+		return 0;
+	}
+
+	if (enabled == 0) {
+		pr_info("%s: live migration disabled in EFI\n", __func__);
+		return 0;
+	}
+
+	pr_info("%s : live migration enabled in EFI\n", __func__);
+	wrmsrl(MSR_KVM_MIGRATION_CONTROL, KVM_MIGRATION_READY);
+
+	return true;
+}
+
+late_initcall(setup_efi_kvm_sev_migration);
+
 /*
  * Set the IPI entry points
  */
@@ -805,8 +858,62 @@ static bool __init kvm_msi_ext_dest_id(void)
 	return kvm_para_has_feature(KVM_FEATURE_MSI_EXT_DEST_ID);
 }
 
+static void kvm_sev_hc_page_enc_status(unsigned long pfn, int npages, bool enc)
+{
+	kvm_hypercall3(KVM_HC_MAP_GPA_RANGE, pfn << PAGE_SHIFT, npages,
+		       KVM_MAP_GPA_RANGE_ENC_STAT(enc) | KVM_MAP_GPA_RANGE_PAGE_SZ_4K);
+}
+
 static void __init kvm_init_platform(void)
 {
+	if (sev_active() &&
+	    kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL)) {
+		unsigned long nr_pages;
+		int i;
+
+		pv_ops.mmu.notify_page_enc_status_changed =
+			kvm_sev_hc_page_enc_status;
+
+		/*
+		 * Reset the host's shared pages list related to kernel
+		 * specific page encryption status settings before we load a
+		 * new kernel by kexec. Reset the page encryption status
+		 * during early boot intead of just before kexec to avoid SMP
+		 * races during kvm_pv_guest_cpu_reboot().
+		 * NOTE: We cannot reset the complete shared pages list
+		 * here as we need to retain the UEFI/OVMF firmware
+		 * specific settings.
+		 */
+
+		for (i = 0; i < e820_table->nr_entries; i++) {
+			struct e820_entry *entry = &e820_table->entries[i];
+
+			if (entry->type != E820_TYPE_RAM)
+				continue;
+
+			nr_pages = DIV_ROUND_UP(entry->size, PAGE_SIZE);
+
+			kvm_hypercall3(KVM_HC_MAP_GPA_RANGE, entry->addr,
+				       nr_pages,
+				       KVM_MAP_GPA_RANGE_ENCRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K);
+		}
+
+		/*
+		 * Ensure that _bss_decrypted section is marked as decrypted in the
+		 * shared pages list.
+		 */
+		nr_pages = DIV_ROUND_UP(__end_bss_decrypted - __start_bss_decrypted,
+					PAGE_SIZE);
+		early_set_mem_enc_dec_hypercall((unsigned long)__start_bss_decrypted,
+						nr_pages, 0);
+
+		/*
+		 * If not booted using EFI, enable Live migration support.
+		 */
+		if (!efi_enabled(EFI_BOOT))
+			wrmsrl(MSR_KVM_MIGRATION_CONTROL,
+			       KVM_MIGRATION_READY);
+	}
 	kvmclock_init();
 	x86_platform.apic_post_init = kvm_apic_init;
 }
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 6b12620376a4..3d6a906d125c 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -411,6 +411,12 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 	return early_set_memory_enc_dec(vaddr, size, true);
 }
 
+void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
+					bool enc)
+{
+	notify_range_enc_status_changed(vaddr, npages, enc);
+}
+
 /*
  * SME and SEV are very similar but they are not the same, so there are
  * times that the kernel will need to distinguish between SME and SEV. The
-- 
2.17.1

