Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D674D0969
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiCGVfV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245509AbiCGVfU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:35:20 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F676D959;
        Mon,  7 Mar 2022 13:34:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZA49M+HzD8xl+SwPeZOfwksjINfr6c/sK5mp1T57Mo9RD1SpFfSEj+NI4qcQWabFtGjYvdiyC2/z7wNz4Tdxb/Pk7PwAdVE2J2vkwwddBgOg+xngWq1TgiOADgoRidPpOfHJ6QxfYbuZAUUodzhVyMgBmSYUMl5UqB0BHxz9+zlhbdJMm7xBSl1jgZhVk/OQpcIfF1kwv2qwCd0Pf0haT0FZ5HEZPpJV12MTUUAsHHp4BNw7RxAX8fEloQDO+POI2kENr8buJcCQjkinxvfLEcjluMXrcumCNdbnxdYK6filSQaSk6Di/SZSV5BvWldEDDABqgXO6MqoO3rNvekWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEQBaFY0WuGexJei/21wN/smEZ6ZJ3+p5hcgP5TPb6w=;
 b=c6nil2PQ0y557rx/E1pS4jrptGs5RMQS1374yIxW2mdORLq/xVRho5RHhVYlmdtzzMv7JZ+TUX8jO+Nd8JjSTi2Mo5c2bw812YXIKV+icL5w6RQYV19XL/GZ3JvUxaTbcH+lxpPygJD1ddcug6vieC3dWTAstyQkQ6GlqDpt/Xe7ogR3bdxHQMitZTjFK4GgA2j3RIFeHTY/DIu2AbSikHOawAQEZwdV/98ZSs5EhNPPb8MeqUZY5+Pl/QolrmJLv7MI7mojT99VWrtggtsDBSWvwuucT1mERte+m2OkeVZtUdBAjjsTa++PSEYGh7+NDvE+JGLiSiCPsRrC3rWyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEQBaFY0WuGexJei/21wN/smEZ6ZJ3+p5hcgP5TPb6w=;
 b=qf4rNvbTmo8M197tL7Hv/W4+KxUftI47ijpgRCn2RgbWA9zhYTUbzNx5ltI2kT0hO9ndWZt6QdeFGe2PDODpOxpA3bgjh5op0yTgP+CnUixpOSpj+1BjLDoAICQ56NbiP9y6jC0d0wts0XAT8AXCOjzI0NKIeK/35GZMye5MWU0=
Received: from BN0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:141::26)
 by DM5PR12MB2534.namprd12.prod.outlook.com (2603:10b6:4:b4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 21:34:19 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::82) by BN0PR07CA0026.outlook.office365.com
 (2603:10b6:408:141::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:18 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:16 -0600
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v12 00/46] Add AMD Secure Nested Paging (SEV-SNP) Guest Support
Date:   Mon, 7 Mar 2022 15:33:10 -0600
Message-ID: <20220307213356.2797205-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db54a4a5-a0c5-4b2d-1825-08da00823ca9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2534:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB25346240C5CA5F42161AD550E5089@DM5PR12MB2534.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xc+60AopMymrRe0ILc9fhx3MqtbNUcElenUo3HA731loEYkRwUPOetxtJUZlwboLfGyiSrvoQnkO1qYDKn+hl0UQown303iM1XHgG6i6uu6GnGlRM9KVKC7OI3D0Mm+qnr+Bh0k4hXPO5JFIXe0LQX7j8HApFesig3Ws37kX7ApuS8IMFdnYEx0bVMnIjC50FelVX2vmbTPi8qJJhPtxVmRj+ikT18O1HlprzjNUW9Ypn8MQO7NSTE3jvRtNwRWYV0cpqokkctwD8ANtrnLip6hz3GsypzlaPXMkZHuHFaEe8IStKo4UMxYOF0ErRYflTkEj7J7vH+lk4m54ZazkbwOe+7RHEufj8boQ8yYefVsfdxl0dfAiRXC9z7uJOhRfAqTVEVnssRphoVni5C5sghAdWV9znWtZzmAYZlqU8/L3K8Jm+wgR8y8BLsI8BTgi5XXxrsAK9rtGo1j1JAqUScBkKi1y19gwkaXrrQ2rSZ2vCS4vy5A2CuhcaPicZDEDsbYAnUeWTVwOTEQuvf3Ezczv9vEjuzSTglBZ9+jyPmEQPV4PczNvfHBOE6ka7ciOw1b+mUjqv8luBORtK11wmSmVHL3cGdGqJoIqXK1nNhIg+cmj3P0Bq9MUkJ4W+0NC/b3GgaNneDECZ7BnTn18T1qnvwbK/wgumiWYE/1TsDHezpjGumXCt9yq4mALTeKU3QiGqu2I0erQ72TH92QgM++W9ojYO5yAK2Qb8mhpONKfh0a6udZR2TTzI7SaMrojWB/mReRl+5uF8trOd4/9b6cNtoZfqU9TABf05dnD/f0IVEAe2n6RmYa406trIcreNNKBZkxYXk2H5yZ3YHeX23vqnI9bEVloiyGxizYX/GY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7406005)(7416002)(30864003)(4326008)(8676002)(70586007)(70206006)(47076005)(8936002)(5660300002)(110136005)(54906003)(316002)(40460700003)(44832011)(2906002)(36756003)(7696005)(186003)(1076003)(36860700001)(16526019)(426003)(966005)(86362001)(26005)(82310400004)(6666004)(508600001)(81166007)(83380400001)(336012)(356005)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:18.9028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db54a4a5-a0c5-4b2d-1825-08da00823ca9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This part of Secure Encrypted Paging (SEV-SNP) series focuses on the changes
required in a guest OS for SEV-SNP support.

SEV-SNP builds upon existing SEV and SEV-ES functionality while adding
new hardware-based memory protections. SEV-SNP adds strong memory integrity
protection to help prevent malicious hypervisor-based attacks like data
replay, memory re-mapping and more in order to create an isolated memory
encryption environment.
 
This series provides the basic building blocks to support booting the SEV-SNP
VMs, it does not cover all the security enhancement introduced by the SEV-SNP
such as interrupt protection.

Many of the integrity guarantees of SEV-SNP are enforced through a new
structure called the Reverse Map Table (RMP). Adding a new page to SEV-SNP
VM requires a 2-step process. First, the hypervisor assigns a page to the
guest using the new RMPUPDATE instruction. This transitions the page to
guest-invalid. Second, the guest validates the page using the new PVALIDATE
instruction. The SEV-SNP VMs can use the new "Page State Change Request NAE"
defined in the GHCB specification to ask hypervisor to add or remove page
from the RMP table.

Each page assigned to the SEV-SNP VM can either be validated or unvalidated,
as indicated by the Validated flag in the page's RMP entry. There are two
approaches that can be taken for the page validation: Pre-validation and
Lazy Validation.

Under pre-validation, the pages are validated prior to first use. And under
lazy validation, pages are validated when first accessed. An access to a
unvalidated page results in a #VC exception, at which time the exception
handler may validate the page. Lazy validation requires careful tracking of
the validated pages to avoid validating the same GPA more than once. The
recently introduced "Unaccepted" memory type can be used to communicate the
unvalidated memory ranges to the Guest OS.

At this time we only support the pre-validation, the OVMF guest BIOS
validates the entire RAM before the control is handed over to the guest kernel.
The early_set_memory_{encrypted,decrypted} and set_memory_{encrypted,decrypted} are
enlightened to perform the page validation or invalidation while setting or
clearing the encryption attribute from the page table.

This series does not provide support for the Interrupt security yet which will
be added after the base support.

The complete branch is at https://github.com/AMDESE/linux/tree/sev-snp-v12

Patch 1-4 defines multiple VMSA save area to support SEV,SEV-ES and SEV-SNP guests.
It is a pre-requisite for the SEV-SNP guest support, and included in the
series for the completeness. These patch is queue'd here
https://git.kernel.org/pub/scm/virt/kvm/kvm.git, branch svm-for-snp.

Additional resources
---------------------
SEV-SNP whitepaper
https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf
 
APM 2: https://www.amd.com/system/files/TechDocs/24593.pdf
(section 15.36)

GHCB spec:
https://developer.amd.com/wp-content/resources/56421.pdf

SEV-SNP firmware specification:
https://developer.amd.com/sev/

v11: https://lore.kernel.org/all/20220224165625.2175020-1-brijesh.singh@amd.com/
v10: https://lore.kernel.org/linux-mm/20220209181039.1262882-32-brijesh.singh@amd.com/T/
v9: https://lore.kernel.org/linux-mm/20220208052542.3g6nskck7uhjnfji@amd.com
v8: https://lore.kernel.org/lkml/20211210154332.11526-1-brijesh.singh@amd.com/
v7: https://lore.kernel.org/linux-mm/20211110220731.2396491-40-brijesh.singh@amd.com/
v6: https://lore.kernel.org/linux-mm/20211008180453.462291-1-brijesh.singh@amd.com/
v5: https://lore.kernel.org/lkml/20210820151933.22401-1-brijesh.singh@amd.com/

Change since v11:
 * Simplify the memory allocation for VMSA to address Dave Hansen feedback.
 * Drop the unneeded memset for request and response buffer in the sevguest command handling.
 * Make fw_err required for the SNP guest request API.
 * Simplify the error code checking for SNP_GET_EXT_REPORT command handing to address Boris feedback.
 * Rename the command line from "sev_debug" => "sev=debug" to dump the CPUID value.

Changes since v10:
 * Rebase patches to x86/cc.
 * Integerate the SNP page state change functions in x86_platform.guest_{prepare,finish} hook.

Changes since v9:
 * Removed unnecessary checks on CPUID table contents, added kernel param to dump CPUID table during boot
 * Added boot_{rd,wr}msr() helpers
 * Renamed/refactored SNP CPUID code/definitions for clarity/consistency
 * Re-worked comments for clarity and avoid redundancies
 * Moved SNP CPUID table documentation to Documentation/virt/coco/sevguest.rst
 * Documented cc_blob_address/acpi_rsdp_addr in zero-page.rst

Changes since v8:
 * Setup the GHCB before taking the first #VC.
 * Make the CC blob structure size invariant.
 * Define the AP INIT macro and update the AP creation to use those macro
   instead of the hardcoded values.
 * Expand the comments to cover some of previous feedbacks.
 * Fix the commit messages based on the feedbacks.
 * Multiple fixes/cleanup on cpuid patches (based on Boris and Dave feedback)
   * drop is_efi64 return arguments in favor of a separate efi_get_type() helper.
   * drop is_efi64 input arguments in favor of calling efi_get_type() as-needed.
   * move acpi.c's kexec-specific handling into library code.
   * fix stack protection for 32/64-bit builds.
   * Export add_identity_map() to avoid SEV-specific code in ident_map_64.c.
   * use snp_abort() when terminating via initial ccblob scan.
   * fix the copyright header after the code refactor.
   * remove code duplication whereever possible.

Changes since v7:
 * sevguest: extend the get report structure to accept the vmpl from userspace.
 * In the compressed path, move the GHCB protocol negotiation from VC handler
   to sev_enable().
 * sev_enable(): don't expect SEV bit in status MSR when cpuid bit is present, update comments.
 * sme_enable(): call directly from head_64.S rather than as part of startup_64_setup_env, add comments
 * snp_find_cc_blob(), sev_prep_identity_maps(): add missing 'static' keywords to function prototypes

Changes since v6:
 * Add rmpadjust() helper to be used by AP creation and vmpl0 detect function.
 * Clear the VM communication key if guest detects that hypervisor is modifying
   the SNP_GUEST_REQ response header.
 * Move the per-cpu GHCB registration from first #VC to idt setup.
 * Consolidate initial SEV/SME setup into a common entry point that gets called
   early enough to also be used for SEV-SNP CPUID table setup.
 * SNP CPUID: separate initial SEV-SNP feature detection out into standalone
   snp_init() routines, then add CPUID table setup to it as a separate patch.
 * SNP CPUID: fix boot issue with Seabios due to ACPI relying on certain EFI
   config table lookup failures as fallthrough cases rather than error cases.
 * SNP CPUID: drop the use of a separate init routines to handle pointer fixups
   after switching to kernel virtual addresses, instead use a helper that uses
   RIP-relative addressing to access CPUID table when either on identity mapping
   or kernel virtual addresses.

Changes since v5:
 * move the seqno allocation in the sevguest driver.
 * extend snp_issue_guest_request() to accept the exit_info to simplify the logic.
 * use smaller structure names based on feedback.
 * explicitly clear the memory after the SNP guest request is completed.
 * cpuid validation: use a local copy of cpuid table instead of keeping
   firmware table mapped throughout boot.
 * cpuid validation: coding style fix-ups and refactor cpuid-related helpers
   as suggested.
 * cpuid validation: drop a number of BOOT_COMPRESSED-guarded defs/declarations
   by moving things like snp_cpuid_init*() out of sev-shared.c and keeping only
   the common bits there.
 * Break up EFI config table helpers and related acpi.c changes into separate
   patches.
 * re-enable stack protection for 32-bit kernels as well, not just 64-bit

Changes since v4:
 * Address the cpuid specific review comment
 * Simplified the macro based on the review feedback
 * Move macro definition to the patch that needs it
 * Fix the issues reported by the checkpath
 * Address the AP creation specific review comment

Changes since v3:
 * Add support to use the PSP filtered CPUID.
 * Add support for the extended guest request.
 * Move sevguest driver in driver/virt/coco.
 * Add documentation for sevguest ioctl.
 * Add support to check the vmpl0.
 * Pass the VM encryption key and id to be used for encrypting guest messages
   through the platform drv data.
 * Multiple cleanup and fixes to address the review feedbacks.

Changes since v2:
 * Add support for AP startup using SNP specific vmgexit.
 * Add snp_prep_memory() helper.
 * Drop sev_snp_active() helper.
 * Add sev_feature_enabled() helper to check which SEV feature is active.
 * Sync the SNP guest message request header with latest SNP FW spec.
 * Multiple cleanup and fixes to address the review feedbacks.

Changes since v1:
 * Integerate the SNP support in sev.{ch}.
 * Add support to query the hypervisor feature and detect whether SNP is supported.
 * Define Linux specific reason code for the SNP guest termination.
 * Extend the setup_header provide a way for hypervisor to pass secret and cpuid page.
 * Add support to create a platform device and driver to query the attestation report
   and the derive a key.
 * Multiple cleanup and fixes to address Boris's review fedback.

Brijesh Singh (20):
  KVM: SVM: Define sev_features and vmpl field in the VMSA
  x86/mm: Extend cc_attr to include AMD SEV-SNP
  x86/sev: Define the Linux specific guest termination reasons
  x86/sev: Save the negotiated GHCB version
  x86/sev: Check SEV-SNP features support
  x86/sev: Add a helper for the PVALIDATE instruction
  x86/sev: Check the vmpl level
  x86/compressed: Add helper for validating pages in the decompression
    stage
  x86/compressed: Register GHCB memory when SEV-SNP is active
  x86/sev: Register GHCB memory when SEV-SNP is active
  x86/sev: Add helper for validating pages in early enc attribute
    changes
  x86/kernel: Make the .bss..decrypted section shared in RMP table
  x86/kernel: Validate ROM memory before accessing when SEV-SNP is
    active
  x86/mm: Validate memory when changing the C-bit
  x86/boot: Add Confidential Computing type to setup_data
  x86/sev: Provide support for SNP guest request NAEs
  x86/sev: Register SEV-SNP guest request platform device
  virt: Add SEV-SNP guest driver
  virt: sevguest: Add support to derive key
  virt: sevguest: Add support to get extended report

Michael Roth (22):
  x86/boot: Introduce helpers for MSR reads/writes
  x86/boot: Use MSR read/write helpers instead of inline assembly
  x86/compressed/64: Detect/setup SEV/SME features earlier in boot
  x86/sev: Detect/setup SEV/SME features earlier in boot
  x86/head/64: Re-enable stack protection
  x86/compressed/acpi: Move EFI detection to helper
  x86/compressed/acpi: Move EFI system table lookup to helper
  x86/compressed/acpi: Move EFI config table lookup to helper
  x86/compressed/acpi: Move EFI vendor table lookup to helper
  x86/compressed/acpi: Move EFI kexec handling into common code
  KVM: x86: Move lookup of indexed CPUID leafs to helper
  x86/sev: Move MSR-based VMGEXITs for CPUID to helper
  x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers
  x86/boot: Add a pointer to Confidential Computing blob in bootparams
  x86/compressed: Add SEV-SNP feature detection/setup
  x86/compressed: Use firmware-validated CPUID leaves for SEV-SNP guests
  x86/compressed: Export and rename add_identity_map()
  x86/compressed/64: Add identity mapping for Confidential Computing
    blob
  x86/sev: Add SEV-SNP feature detection/setup
  x86/sev: Use firmware-validated CPUID for SEV-SNP guests
  x86/sev: add sev=debug cmdline option to dump SNP CPUID table
  virt: sevguest: Add documentation for SEV-SNP CPUID Enforcement

Tom Lendacky (4):
  KVM: SVM: Create a separate mapping for the SEV-ES save area
  KVM: SVM: Create a separate mapping for the GHCB save area
  KVM: SVM: Update the SEV-ES save area mapping
  x86/sev: Use SEV-SNP AP creation to start secondary CPUs

 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/virt/coco/sevguest.rst          | 155 ++++
 Documentation/virt/index.rst                  |   1 +
 Documentation/x86/x86_64/boot-options.rst     |  14 +
 Documentation/x86/zero-page.rst               |   2 +
 arch/x86/boot/compressed/Makefile             |   1 +
 arch/x86/boot/compressed/acpi.c               | 173 +---
 arch/x86/boot/compressed/efi.c                | 238 +++++
 arch/x86/boot/compressed/head_64.S            |  37 +-
 arch/x86/boot/compressed/ident_map_64.c       |  39 +-
 arch/x86/boot/compressed/idt_64.c             |  18 +-
 arch/x86/boot/compressed/mem_encrypt.S        |  36 -
 arch/x86/boot/compressed/misc.h               |  55 +-
 arch/x86/boot/compressed/sev.c                | 263 +++++-
 arch/x86/boot/cpucheck.c                      |  30 +-
 arch/x86/boot/msr.h                           |  28 +
 arch/x86/coco/core.c                          |   3 +
 arch/x86/include/asm/bootparam_utils.h        |   1 +
 arch/x86/include/asm/cpuid.h                  |  34 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/msr.h                    |  11 +-
 arch/x86/include/asm/setup.h                  |   1 -
 arch/x86/include/asm/sev-common.h             |  82 ++
 arch/x86/include/asm/sev.h                    | 102 ++-
 arch/x86/include/asm/shared/msr.h             |  15 +
 arch/x86/include/asm/svm.h                    | 171 +++-
 arch/x86/include/uapi/asm/bootparam.h         |   4 +-
 arch/x86/include/uapi/asm/svm.h               |  13 +
 arch/x86/kernel/Makefile                      |   2 -
 arch/x86/kernel/cpu/common.c                  |   4 +
 arch/x86/kernel/head64.c                      |  29 +-
 arch/x86/kernel/head_64.S                     |  37 +-
 arch/x86/kernel/probe_roms.c                  |  13 +-
 arch/x86/kernel/sev-shared.c                  | 529 ++++++++++-
 arch/x86/kernel/sev.c                         | 834 +++++++++++++++++-
 arch/x86/kernel/smpboot.c                     |   3 +
 arch/x86/kvm/cpuid.c                          |  19 +-
 arch/x86/kvm/svm/sev.c                        |  24 +-
 arch/x86/kvm/svm/svm.c                        |   4 +-
 arch/x86/kvm/svm/svm.h                        |   2 +-
 arch/x86/mm/mem_encrypt.c                     |   4 +
 arch/x86/mm/mem_encrypt_amd.c                 |  71 +-
 arch/x86/mm/mem_encrypt_identity.c            |   8 +
 drivers/virt/Kconfig                          |   3 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/coco/sevguest/Kconfig            |  14 +
 drivers/virt/coco/sevguest/Makefile           |   2 +
 drivers/virt/coco/sevguest/sevguest.c         | 740 ++++++++++++++++
 drivers/virt/coco/sevguest/sevguest.h         |  98 ++
 include/linux/cc_platform.h                   |   8 +
 include/linux/efi.h                           |   1 +
 include/uapi/linux/sev-guest.h                |  80 ++
 52 files changed, 3688 insertions(+), 373 deletions(-)
 create mode 100644 Documentation/virt/coco/sevguest.rst
 create mode 100644 arch/x86/boot/compressed/efi.c
 create mode 100644 arch/x86/boot/msr.h
 create mode 100644 arch/x86/include/asm/cpuid.h
 create mode 100644 arch/x86/include/asm/shared/msr.h
 create mode 100644 drivers/virt/coco/sevguest/Kconfig
 create mode 100644 drivers/virt/coco/sevguest/Makefile
 create mode 100644 drivers/virt/coco/sevguest/sevguest.c
 create mode 100644 drivers/virt/coco/sevguest/sevguest.h
 create mode 100644 include/uapi/linux/sev-guest.h

-- 
2.25.1

