Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D114704C9
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbhLJPrl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:47:41 -0500
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com ([40.107.94.42]:33376
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239714AbhLJPre (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJpygWjTVvhCfcOsEGj6ncKW6JjuLSGi2mWKpGnpq+JTMLbJkcAWNYqmldL20jq1JPahwVm9SBp3oNGEmbNZI+X4+FECQFbsJ7nz9hWyLDqlkmsTdfGnt5D5EKp83H5dYsEw2+dErbD8LDppZOstzJbNpP8R8RYEMN6v0mqjvuKYOW8G9cfs1VtrTMLFAOOmNHAcvSlKVTo/rmOSy/puDtJS7Tx4Ih226LzUrC9WWbwhEZ6MR0q6n3rhhj0dRiL/8A2QQvufpOSowN2GnYpYYa3LOU4wnPLNVKNuweRMu5f9wJ+/uFv3Ohb3m264X4pv/fV6shzvQi1/SZR0KLGxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDo+cgW5VB/YOE5QantxK/pRIpFfMKnNseBzlYyFqDM=;
 b=QvFR5SsiJ9yYW0x/GUtb3q5ohVhx+N9QIhag/S+9U7pJIylk3eSa5bsXXV3twGxLyg7Bmg+H3takK1iv7aX1giCck8P5opjOT1K8JMyfw148NunaRtYRsScJlTuB4ttnL0IWmQvDM7tAJ7EH2gmsQ8Lid7kLmxFP8ozUpSNPFZqj7W5y8nkxXwXTDYtU5DlmyS6dJ2AUzDLfdh1Ay6Si/b/9/+NBV0cwL88pvXhTyKtPgsZKevaq7WXvGMx5f+YEG3AFHqGaBez6C8moBY4+VD7XRTHAOkKODLqvE6FKIjqJClmz1bJi89VGFbDDbIGrzGzJJJXoPmsKvAqO5qF4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDo+cgW5VB/YOE5QantxK/pRIpFfMKnNseBzlYyFqDM=;
 b=WV5cqIJJzJeuGBY5YFQn5m6Sin2pVBnDfd1LElQP+yWvLvlb4scE+UJkuGFcItNDEHOFllEb9TAEF1PHb/NWa/S+bRGuinROG6rRM2PjcI3wlwIvcC4wVJ/+aRLpUw98Eg1+cFUA3oMpAQ8N4t0AUTENOZjFFVPG4ED3UDhxBlU=
Received: from BN9PR03CA0075.namprd03.prod.outlook.com (2603:10b6:408:fc::20)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 15:43:50 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::56) by BN9PR03CA0075.outlook.office365.com
 (2603:10b6:408:fc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Fri, 10 Dec 2021 15:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:43:50 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:43:46 -0600
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v8 00/40] Add AMD Secure Nested Paging (SEV-SNP) Guest Support
Date:   Fri, 10 Dec 2021 09:42:52 -0600
Message-ID: <20211210154332.11526-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e223e0e-6867-49bf-c6b2-08d9bbf3dcc5
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24873F214EE8289BD246BB46E5719@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFCz9NPuSmi17j0m75Q83x7e8s8XmV/xucxGLQv7tmKcChIvRETlnpe4iALw7TUrURJYvqxvscmqcanSSLiNTT0J7TUvfs3AvGTZGB3l3KgUEccHipmBut9vRFfe3usN8jQlfvIDZuQU+Shom/yqUIBYeRLWfA31qxDB7QEUzgc2ktKBqLfatQ8sjVtN30tPMfblkSI+t/5Dr+hRt19qMuv592YglKHPAnJfcGAPhgLrd0NTgW37swOTOVNdD6akZwIV8U6pRvzkzoPezbEfhtO1/crYSD57Q/xS57f9KV3pXqa8VaL/sAhmndw0R+6XxrF8glD4HyxE0bZwC4zRED7wxWpYShehlbQqjuXQVHz9no0cjYcbF1iu/KtGOAlyuJVPAHdM//dLpl934sTvKobm71KOZj1pO1ZIyQhHxDzoaobPz7J+lpgfD6NSIDTUAlvZV2m6KwWDMDqBWD5jdHNoM4RC8EVRvz0eY2O3xjMlXCTA3I9NFm1D/SX4MKqfB0898P84+N6GMHJiUPHR0shpGII+NZYBBNfHflOBSIjZNipzX6Ol2rZBxxkGxhtZQd/LdfvsibqZLL9SOMH+A2c8qosVa1ciRgE5uJHQ56MZ2yzI+JXIVp6NpoN69bYNlcYiMrLD4d10qy/Qa9IUat4/uEQ8a1Vam/TBGpBWgBGmG/TSYRNg0fNSafhJkuzeHL3BuY7uvF/Cc37R32U3RCJPnehMMPFIgu6gICRQQ4YrJJu6I+RdFDXQD+I1efMbuba/eM1RYMK6ljMPOaBrvKmw2V2Yq1aHX3W300a2vcxEF4HQvWRYNfzee80tkMXYJfjVJxOFGslQeHf4zx0hsLU4qoXRog7LnW0w/yiDpWuEf4wfC6TPJ9Ym8cd3y6NEcgVhaYJxedqAOendTl3dA2TPxXXc+8rCGhorAV5xSgJUXXHcHWdifoocrTHsJ02J
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(6666004)(36756003)(54906003)(44832011)(110136005)(2906002)(83380400001)(8936002)(5660300002)(70586007)(426003)(8676002)(508600001)(2616005)(70206006)(336012)(30864003)(7416002)(7406005)(36860700001)(47076005)(26005)(4326008)(7696005)(186003)(16526019)(40460700001)(86362001)(82310400004)(1076003)(316002)(966005)(81166007)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:43:50.4123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e223e0e-6867-49bf-c6b2-08d9bbf3dcc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
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

At this time we only sypport the pre-validation, the OVMF guest BIOS
validates the entire RAM before the control is handed over to the guest kernel.
The early_set_memory_{encrypt,decrypt} and set_memory_{encrypt,decrypt} are
enlightened to perform the page validation or invalidation while setting or
clearing the encryption attribute from the page table.

This series does not provide support for the Interrupt security yet which will
be added after the base support.

The series is based on tip/master
  7f32a31b0a34 (origin/master, origin/HEAD) Merge branch into tip/master: 'core/entry'

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

v7: https://lore.kernel.org/linux-mm/20211110220731.2396491-40-brijesh.singh@amd.com/
v6: https://lore.kernel.org/linux-mm/20211008180453.462291-1-brijesh.singh@amd.com/
v5: https://lore.kernel.org/lkml/20210820151933.22401-1-brijesh.singh@amd.com/

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

Brijesh Singh (21):
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
  x86/kernel: Make the bss.decrypted section shared in RMP table
  x86/kernel: Validate rom memory before accessing when SEV-SNP is
    active
  x86/mm: Add support to validate memory when changing C-bit
  KVM: SVM: Define sev_features and vmpl field in the VMSA
  KVM: SVM: Create a separate mapping for the SEV-ES save area
  x86/boot: Add Confidential Computing type to setup_data
  x86/sev: Provide support for SNP guest request NAEs
  x86/sev: Register SNP guest request platform device
  virt: Add SEV-SNP guest driver
  virt: sevguest: Add support to derive key
  virt: sevguest: Add support to get extended report

Michael Roth (16):
  x86/compressed/64: detect/setup SEV/SME features earlier in boot
  x86/sev: detect/setup SEV/SME features earlier in boot
  x86/head: re-enable stack protection for 32/64-bit builds
  x86/sev: move MSR-based VMGEXITs for CPUID to helper
  KVM: x86: move lookup of indexed CPUID leafs to helper
  x86/compressed/acpi: move EFI system table lookup to helper
  x86/compressed/acpi: move EFI config table lookup to helper
  x86/compressed/acpi: move EFI vendor table lookup to helper
  KVM: SEV: Add documentation for SEV-SNP CPUID Enforcement
  x86/compressed/64: add support for SEV-SNP CPUID table in #VC handlers
  x86/boot: add a pointer to Confidential Computing blob in bootparams
  x86/compressed: add SEV-SNP feature detection/setup
  x86/compressed: use firmware-validated CPUID for SEV-SNP guests
  x86/compressed/64: add identity mapping for Confidential Computing
    blob
  x86/sev: add SEV-SNP feature detection/setup
  x86/sev: use firmware-validated CPUID for SEV-SNP guests

Tom Lendacky (3):
  KVM: SVM: Create a separate mapping for the GHCB save area
  KVM: SVM: Update the SEV-ES save area mapping
  x86/sev: Use SEV-SNP AP creation to start secondary CPUs

 Documentation/virt/coco/sevguest.rst          | 121 +++
 .../virt/kvm/amd-memory-encryption.rst        |  28 +
 arch/x86/boot/compressed/Makefile             |   1 +
 arch/x86/boot/compressed/acpi.c               | 129 +--
 arch/x86/boot/compressed/efi.c                | 179 ++++
 arch/x86/boot/compressed/head_64.S            |  32 +-
 arch/x86/boot/compressed/ident_map_64.c       |  44 +-
 arch/x86/boot/compressed/mem_encrypt.S        |  36 -
 arch/x86/boot/compressed/misc.h               |  44 +-
 arch/x86/boot/compressed/sev.c                | 249 +++++-
 arch/x86/include/asm/bootparam_utils.h        |   1 +
 arch/x86/include/asm/cpuid.h                  |  26 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/sev-common.h             |  82 ++
 arch/x86/include/asm/sev.h                    |  96 +-
 arch/x86/include/asm/svm.h                    | 171 +++-
 arch/x86/include/uapi/asm/bootparam.h         |   4 +-
 arch/x86/include/uapi/asm/svm.h               |  13 +
 arch/x86/kernel/Makefile                      |   1 -
 arch/x86/kernel/cc_platform.c                 |   2 +
 arch/x86/kernel/cpu/common.c                  |   4 +
 arch/x86/kernel/head64.c                      |  11 +-
 arch/x86/kernel/head_64.S                     |  37 +
 arch/x86/kernel/probe_roms.c                  |  13 +-
 arch/x86/kernel/sev-shared.c                  | 539 ++++++++++-
 arch/x86/kernel/sev.c                         | 841 ++++++++++++++++--
 arch/x86/kernel/smpboot.c                     |   3 +
 arch/x86/kvm/cpuid.c                          |  17 +-
 arch/x86/kvm/svm/sev.c                        |  24 +-
 arch/x86/kvm/svm/svm.c                        |   4 +-
 arch/x86/kvm/svm/svm.h                        |   2 +-
 arch/x86/mm/mem_encrypt.c                     |  55 +-
 arch/x86/mm/mem_encrypt_identity.c            |   8 +
 arch/x86/mm/pat/set_memory.c                  |  15 +
 drivers/virt/Kconfig                          |   3 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/coco/sevguest/Kconfig            |   9 +
 drivers/virt/coco/sevguest/Makefile           |   2 +
 drivers/virt/coco/sevguest/sevguest.c         | 738 +++++++++++++++
 drivers/virt/coco/sevguest/sevguest.h         |  98 ++
 include/linux/cc_platform.h                   |   8 +
 include/linux/efi.h                           |   1 +
 include/uapi/linux/sev-guest.h                |  77 ++
 43 files changed, 3474 insertions(+), 297 deletions(-)
 create mode 100644 Documentation/virt/coco/sevguest.rst
 create mode 100644 arch/x86/boot/compressed/efi.c
 create mode 100644 arch/x86/include/asm/cpuid.h
 create mode 100644 drivers/virt/coco/sevguest/Kconfig
 create mode 100644 drivers/virt/coco/sevguest/Makefile
 create mode 100644 drivers/virt/coco/sevguest/sevguest.c
 create mode 100644 drivers/virt/coco/sevguest/sevguest.h
 create mode 100644 include/uapi/linux/sev-guest.h

-- 
2.25.1

