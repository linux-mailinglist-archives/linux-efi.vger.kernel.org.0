Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD05349FECC
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbiA1RSW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:18:22 -0500
Received: from mail-dm6nam08on2047.outbound.protection.outlook.com ([40.107.102.47]:20704
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245524AbiA1RSV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dycXhI/wBC3H3xGs9xQaFYgfVJl2VnF9KiufSPV/W1Bty/eVsxP6xf861SfTd9q6QoaY+GQDmaVHA8S2P4vNYSLZesVMv/AOoFovZ4BX8uZwNh3sOuRq3yGmN2BsB6wWIOK1/U9p6lOZ5qVZF/iz6Vm9sDD7jZMcD6vk7OHXrqsTH9zfQ3aLnVhYUjgSZnUM6mflDgqyZT97DPFADVGRbfOylda8pWavusxu6/cnJj54boVloo1HiBNO+60kQPu3GZu7wFP3x/de5mXLrynk04iA2IwMwMO9ZRGVUd8EFNVMbTq6aR/khFsX0uc95tEr//JLNcVBVLmEkmAaN4ARFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLM103IAvJCI1zQ5cehueKa9Zd2aOosEehqPH9aCgg0=;
 b=cLeVJApnfXHYAmxTVHc2q/mkKejHEWyD6sxwroNGyNw+i1JW7+KwhpXP81C1btsNUIPurCdLcRZ9DLo9bbHu4E4Duuuj70puKEE4Cl5SWlIfR8ts80rTR4B/aEJ5g5jN4b7TrldukIYNafadCsDZRAIbdAbBbfAJU/DIeOpDOigVvYjiiwQCnDyKjJJXqScR9eyPOSZ65UjozDsUvTuiz7O0Mhueh6IsDlzm9QpCzTy6l4Sif2OfLW0DcsrvNnie+26z7KazbCTcc+fPlHV4B2PXOEoJDObW8rOArDoR7gtJKTUYog9kGFR++d1SosS7Do8nEQ5jW28uz4hyP2fPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLM103IAvJCI1zQ5cehueKa9Zd2aOosEehqPH9aCgg0=;
 b=vSoYmCrlWrzkdtAnrywcYClAfKZsGpWmmdXnElDVQL+LOSw+zioWvGqlgw7+i0255kvC14jVu3GEkyTfKOked45c9VGKIiUKb+Gh1GnhDkV9cJ1u9Ha/D5Ub7umToKT8x+6E+G6u5VXhHM43+zcIXf6h7ynv2XLG9ugvnFDNmVo=
Received: from DM5PR19CA0065.namprd19.prod.outlook.com (2603:10b6:3:116::27)
 by CH2PR12MB4889.namprd12.prod.outlook.com (2603:10b6:610:68::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 17:18:19 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::d4) by DM5PR19CA0065.outlook.office365.com
 (2603:10b6:3:116::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:19 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:16 -0600
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
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v9 00/43] Add AMD Secure Nested Paging (SEV-SNP) Guest Support
Date:   Fri, 28 Jan 2022 11:17:21 -0600
Message-ID: <20220128171804.569796-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8940258b-08c2-42dd-b5c0-08d9e2822de0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4889:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4889AC2469CD3E7DFF8B268AE5229@CH2PR12MB4889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjvnGbjvPT2keB482aPBeghY0R2Fr62IQ+st1WBo0mOQueSiMaFHUKkV/3v2CXNLev+y7fWxwCkaus+MCctz4t5MRlyeT9xRHXpgaSeUh7tTkGuTSdYE6B7wu2u0bOJMhSbU7RD3bDpy5XplozmAML/NjWPVxadWKTbxqf3IZruh/dYuH7wqTtPRb6MM2n/3JM6rzuS/w4P4uhlNQDZsvrqhFacObcf0WuxtXwv4EGFOdhGSUcXIhi3i2+6Z7BfrMGqCC7FcpABwff9DPIKiBMguGq1bJxlbA1FAkAD+bdQuAtq9v4VpDRa3Hl2C8bP5zk6k9ujh4EOtHCCka1SXSncohEJ/J7NbpA35KTDbF9Ir+KpKHq7JLWJ41xHUuStwCbhbS5SAzJJIZd0jIy3j4a6Vw4yQ57/2cv7vxNc46b8SoI5xmWsMwVA8o8zGTlZ6UE0pIzEBuxUjzlUkgtP4vHVPQ5WmePjpkthpmpafr24fDrvgK/4IYHTpxOqVKs9/HJbrkIFieqzFlXNUb6G+8JAtxpT4LXzYfWPsOn0CDyV3RuftG0rQEqAv9MbXyz4mtbB036gaH1eu89ymM0K5MceYjo8W3zaKxVB+tuKVlmccoa/UDo7Xzy0pu25mbuVsC/q5FQt8GST+n7z8XeefKqlTJizHL8BmZDmZX6LfmQa9sV2VlWviRKKLnke/WJh4phGy+JNkHxJbppaqLUDGnhcEDUWGvI49k0gWTsNA99tDQWN3ieVXRxw0P7Ze5G0uXiHC46DFbxXDQmF156kfIvHOasZDJkHCC8wGSw3oze2+Bcg4zvdI2dq+PBIie/Xw8DmSOvciGIZ96b7SsFiF4OYTnatFuwUndyhwt5sGkds=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(70586007)(8676002)(4326008)(54906003)(110136005)(426003)(508600001)(70206006)(966005)(47076005)(83380400001)(86362001)(316002)(336012)(82310400004)(5660300002)(186003)(7696005)(36756003)(81166007)(26005)(1076003)(2616005)(36860700001)(16526019)(2906002)(40460700003)(44832011)(30864003)(6666004)(356005)(7416002)(7406005)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:19.1713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8940258b-08c2-42dd-b5c0-08d9e2822de0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4889
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
The early_set_memory_{encrypted,decrypted} and set_memory_{encrypted,decrypted} are
enlightened to perform the page validation or invalidation while setting or
clearing the encryption attribute from the page table.

This series does not provide support for the Interrupt security yet which will
be added after the base support.

The series is based on tip/master
  94985da003a4 (origin/master, origin/HEAD) Merge branch into tip/master: 'irq/urgent'

The complete branch is at https://github.com/AMDESE/linux/tree/sev-snp-v9

Patch 1-4 defines multiple VMSA save area to support SEV,SEV-ES and SEV-SNP guests.
It is a pre-requisite for the SEV-SNP guest support, and included in the
series for the completeness. Not sure if it will go through the tip or KVM.
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

v8: https://lore.kernel.org/lkml/20211210154332.11526-1-brijesh.singh@amd.com/
v7: https://lore.kernel.org/linux-mm/20211110220731.2396491-40-brijesh.singh@amd.com/
v6: https://lore.kernel.org/linux-mm/20211008180453.462291-1-brijesh.singh@amd.com/
v5: https://lore.kernel.org/lkml/20210820151933.22401-1-brijesh.singh@amd.com/

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
  x86/mm: Add support to validate memory when changing C-bit
  x86/boot: Add Confidential Computing type to setup_data
  x86/sev: Provide support for SNP guest request NAEs
  x86/sev: Register SEV-SNP guest request platform device
  virt: Add SEV-SNP guest driver
  virt: sevguest: Add support to derive key
  virt: sevguest: Add support to get extended report

Michael Roth (19):
  x86/compressed/64: Detect/setup SEV/SME features earlier in boot
  x86/sev: Detect/setup SEV/SME features earlier in boot
  x86/head/64: Re-enable stack protection
  x86/sev: Move MSR-based VMGEXITs for CPUID to helper
  KVM: x86: Move lookup of indexed CPUID leafs to helper
  x86/compressed/acpi: Move EFI detection to helper
  x86/compressed/acpi: Move EFI system table lookup to helper
  x86/compressed/acpi: Move EFI config table lookup to helper
  x86/compressed/acpi: Move EFI vendor table lookup to helper
  x86/compressed/acpi: Move EFI kexec handling into common code
  KVM: SEV: Add documentation for SEV-SNP CPUID Enforcement
  x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers
  x86/boot: Add a pointer to Confidential Computing blob in bootparams
  x86/compressed: Add SEV-SNP feature detection/setup
  x86/compressed: Use firmware-validated CPUID leaves for SEV-SNP guests
  x86/compressed: Export and rename add_identity_map()
  x86/compressed/64: Add identity mapping for Confidential Computing
    blob
  x86/sev: Add SEV-SNP feature detection/setup
  x86/sev: Use firmware-validated CPUID for SEV-SNP guests

Tom Lendacky (4):
  KVM: SVM: Create a separate mapping for the SEV-ES save area
  KVM: SVM: Create a separate mapping for the GHCB save area
  KVM: SVM: Update the SEV-ES save area mapping
  x86/sev: Use SEV-SNP AP creation to start secondary CPUs

 Documentation/virt/coco/sevguest.rst          | 121 +++
 .../virt/kvm/amd-memory-encryption.rst        |  28 +
 arch/x86/boot/compressed/Makefile             |   1 +
 arch/x86/boot/compressed/acpi.c               | 172 +---
 arch/x86/boot/compressed/efi.c                | 243 +++++
 arch/x86/boot/compressed/head_64.S            |  32 +-
 arch/x86/boot/compressed/ident_map_64.c       |  39 +-
 arch/x86/boot/compressed/idt_64.c             |  10 +-
 arch/x86/boot/compressed/mem_encrypt.S        |  36 -
 arch/x86/boot/compressed/misc.h               |  55 +-
 arch/x86/boot/compressed/sev.c                | 256 ++++-
 arch/x86/include/asm/bootparam_utils.h        |   1 +
 arch/x86/include/asm/cpuid.h                  |  38 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/setup.h                  |   1 -
 arch/x86/include/asm/sev-common.h             |  82 ++
 arch/x86/include/asm/sev.h                    | 102 +-
 arch/x86/include/asm/svm.h                    | 171 +++-
 arch/x86/include/uapi/asm/bootparam.h         |   4 +-
 arch/x86/include/uapi/asm/svm.h               |  13 +
 arch/x86/kernel/Makefile                      |   1 -
 arch/x86/kernel/cc_platform.c                 |   2 +
 arch/x86/kernel/cpu/common.c                  |   4 +
 arch/x86/kernel/head64.c                      |  30 +-
 arch/x86/kernel/head_64.S                     |  37 +-
 arch/x86/kernel/probe_roms.c                  |  13 +-
 arch/x86/kernel/sev-shared.c                  | 526 +++++++++-
 arch/x86/kernel/sev.c                         | 934 ++++++++++++++++--
 arch/x86/kernel/smpboot.c                     |   3 +
 arch/x86/kvm/cpuid.c                          |  19 +-
 arch/x86/kvm/svm/sev.c                        |  24 +-
 arch/x86/kvm/svm/svm.c                        |   4 +-
 arch/x86/kvm/svm/svm.h                        |   2 +-
 arch/x86/mm/mem_encrypt.c                     |   4 +
 arch/x86/mm/mem_encrypt_amd.c                 |  58 +-
 arch/x86/mm/mem_encrypt_identity.c            |   8 +
 arch/x86/mm/pat/set_memory.c                  |  15 +
 drivers/virt/Kconfig                          |   3 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/coco/sevguest/Kconfig            |  12 +
 drivers/virt/coco/sevguest/Makefile           |   2 +
 drivers/virt/coco/sevguest/sevguest.c         | 739 ++++++++++++++
 drivers/virt/coco/sevguest/sevguest.h         |  98 ++
 include/linux/cc_platform.h                   |   8 +
 include/linux/efi.h                           |   1 +
 include/uapi/linux/sev-guest.h                |  80 ++
 46 files changed, 3652 insertions(+), 383 deletions(-)
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

