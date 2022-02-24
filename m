Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9C84C3263
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 17:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiBXQ6b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 11:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiBXQ6a (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:58:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BA843EE5;
        Thu, 24 Feb 2022 08:57:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1SJ7/JL4tg/ta44fw/Yos6cBJ3az/9lgH7J7d6qYO9impHG4SX65MVMzuIm5RoAOq7/Q2iC99iUwsdLbj3H1J2l8NgBbGTpO9hbGlLwAVZd4BtOurg6zUGmPIr77N9tpL7lmHRwkKHY/VQ0X7lSJHM6Xx9bVOwIU40QcQdjlU9I2xvYg/KggwvfEY8mNp0SoncBylO/xTR2r2JzbxrZl7og3wdrnFtm0xGLK/WW6Uy8JSJbSoooxnl8cERhK+2LVs7dyA4YFURiu19zI0xFoQ9miAHZWYFAxC4OcK0ZvOx/iOoFBQmLlGz7GhJCGEUfbxUbURhoQf5fgWjcFKgWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyG9GmAVsFkBFMQ0j2Dh+rJAb/2bTg30fs399Nnjrbg=;
 b=KHN7GW58Hi3Gv94V/CjwVEg2ybCJ1VTElAVEfQMzJXnlBkZaPPMdwVp6q8ap7mji0MlEVEQh4i0vqXQSsByvn57nIe2169WiBu5/EwALfQU07uY0iLpdD1FtTwBNtOX7pdqqKwZQO3ek8bnmKjzgoOrJHv0c8BqbkGjqwSCODRwqjgn1k9isY6PszCAGj/nhGQqqYNc+IESsy099DmhuJY6P2zGr+Ssv2Otrjdqt/q+/iOhMET8b058KM7pi1pwP0c6g3Y6ZuTnXHLpUwJr4PouhBLvZwWBRfkUjaJOFMJeGIg09MVdux1DE2JMPh+QmWaWU8D2x5hFHfFXJkiQlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyG9GmAVsFkBFMQ0j2Dh+rJAb/2bTg30fs399Nnjrbg=;
 b=XKtwHaI5k7f75SccchkI3mISEMNwwRxTF7soPxfPstri/1ejEiiXx8JWxB3kAN38wyeAiYpl0U8ZBcmhtoCpawLyZtPk/MtBCftL3npIwyQ1ib4XHT1Lcu0mpF7McfI4fhrOoPFxOIncO8MSh+upUNEiRLFy+Oefwl8bcTbRhtY=
Received: from DM3PR11CA0010.namprd11.prod.outlook.com (2603:10b6:0:54::20) by
 CY4PR1201MB0229.namprd12.prod.outlook.com (2603:10b6:910:1d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 16:57:55 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::a4) by DM3PR11CA0010.outlook.office365.com
 (2603:10b6:0:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 16:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:57:54 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:57:51 -0600
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
Subject: [PATCH v11 00/45] Add AMD Secure Nested Paging (SEV-SNP) Guest Support
Date:   Thu, 24 Feb 2022 10:55:40 -0600
Message-ID: <20220224165625.2175020-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a17b847-7830-49e3-df37-08d9f7b6cd32
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0229:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02298A26EF0008D02181619EE53D9@CY4PR1201MB0229.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVFJJMURoUG85I8RgFXoa46KvGwcSbYWSCBpgaANkc3ZpB28IubNFaKjV3rlaUukQgC4u15If+ufrGcUWtRVgsiY4fwnDObXTFExpNTayz0Cs6rzAzfPUi9gdaA8qU8axDE065+4JT3sBHjlQjMxdgxFzjzX7vlIGJ8tEzY0F/ZH2TemaCnq/VrOEDm2X5XflBJ4YMxFboBn54t1ywbvOfd32MOu1Bh52cJ7NuyuQY8h6fVPDDokLgiDOZ/q2Dt0NJwIEoZw+H1D0clftyxfQa9jwga+TgwQsfh0oNTKwferl0aFPYshFOzmYdtlV0aXomF6igd+DvBruY4LFGthWLaTf2AS/utKF+e0nBmKP+pCmGBx360/a7UXhYonCv/33WAvz9l+B62rcoaZSNTkmbYoO7oRPK5LdubH3EQIGbFxbyGoY5LA/g7JJhUdRiJBo+ZlGz5mc9RAMnD8IKJFBq7T9hTalU4ZUH5b/HQ58PdD8RpzEzC2zAwA4uOtNkPW0ISTUQISNecfjUjkaQU0802+DPG9BkyAnFzGH/CDdGUCDNzuzE1eS8i8w1KuMeKbq5Hrg09D8Z368iVYhET9U6xSYINibwC/H0dOfh1uAiuPow7VEAO6Ks1MIwtAuFPF23GiqcAPq8MKQ42Adq3qnwHbncLfZ1WM+nvAWgVHXG8EiL8pUdiXcb6ruoH+E8S523Yquw7bbV/6LaQ5S+YxECdz8rpW3zF000v23i7CZnu+IF3pXJoahNbMk8yPT9IH89jTNSdF2UyPDN13Tpko92FtGQWT0L0J8OGuIFmpAe5YByYN+OmEGdY20YvOA2T4OPjOg9k1vkGb0gIZCReYVzJZdi5y0WL4VR/XDBikXug=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(44832011)(30864003)(2906002)(70586007)(16526019)(426003)(1076003)(336012)(6666004)(81166007)(26005)(36756003)(47076005)(36860700001)(356005)(7406005)(7416002)(70206006)(5660300002)(82310400004)(7696005)(8936002)(40460700003)(2616005)(316002)(8676002)(4326008)(86362001)(83380400001)(508600001)(966005)(110136005)(54906003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:57:54.7313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a17b847-7830-49e3-df37-08d9f7b6cd32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0229
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

The complete branch is at https://github.com/AMDESE/linux/tree/sev-snp-v11

Patch 1-4 defines multiple VMSA save area to support SEV,SEV-ES and SEV-SNP guests.
It is a pre-requisite for the SEV-SNP guest support, and included in the
series for the completeness. These patch apply cleanly to kvm/next.
It is also posted on KVM mailing list:
https://lore.kernel.org/lkml/20211213173356.138726-3-brijesh.singh@amd.com/T/#m7d6868f3e81624323ea933d3a63a68949b286103

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

v10: https://lore.kernel.org/linux-mm/20220209181039.1262882-32-brijesh.singh@amd.com/T/
v9: https://lore.kernel.org/linux-mm/20220208052542.3g6nskck7uhjnfji@amd.com
v8: https://lore.kernel.org/lkml/20211210154332.11526-1-brijesh.singh@amd.com/
v7: https://lore.kernel.org/linux-mm/20211110220731.2396491-40-brijesh.singh@amd.com/
v6: https://lore.kernel.org/linux-mm/20211008180453.462291-1-brijesh.singh@amd.com/
v5: https://lore.kernel.org/lkml/20210820151933.22401-1-brijesh.singh@amd.com/

Changes since v10:
 * Rebase patches to x86/cc.
 * Integerate the SNP page state change functions in x86_platform.guest_{prepare,finish} hook.

Changes since v9:
 * Removed unecessary checks on CPUID table contents, added kernel param to dump CPUID table during boot
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

Michael Roth (21):
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
  virt: sevguest: Add documentation for SEV-SNP CPUID Enforcement

Tom Lendacky (4):
  KVM: SVM: Create a separate mapping for the SEV-ES save area
  KVM: SVM: Create a separate mapping for the GHCB save area
  KVM: SVM: Update the SEV-ES save area mapping
  x86/sev: Use SEV-SNP AP creation to start secondary CPUs

 .../admin-guide/kernel-parameters.txt         |   4 +
 Documentation/virt/coco/sevguest.rst          | 155 ++++
 Documentation/virt/index.rst                  |   1 +
 Documentation/x86/zero-page.rst               |   2 +
 arch/x86/boot/compressed/Makefile             |   1 +
 arch/x86/boot/compressed/acpi.c               | 173 +---
 arch/x86/boot/compressed/efi.c                | 238 ++++++
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
 arch/x86/kernel/sev-shared.c                  | 529 +++++++++++-
 arch/x86/kernel/sev.c                         | 802 +++++++++++++++++-
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
 drivers/virt/coco/sevguest/Kconfig            |  12 +
 drivers/virt/coco/sevguest/Makefile           |   2 +
 drivers/virt/coco/sevguest/sevguest.c         | 736 ++++++++++++++++
 drivers/virt/coco/sevguest/sevguest.h         |  98 +++
 include/linux/cc_platform.h                   |   8 +
 include/linux/efi.h                           |   1 +
 include/uapi/linux/sev-guest.h                |  80 ++
 51 files changed, 3638 insertions(+), 373 deletions(-)
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

