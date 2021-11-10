Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60A844CB98
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhKJWKx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:10:53 -0500
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com ([40.107.93.48]:56289
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233573AbhKJWKu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:10:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N90dFsT2pDVGT6C9IagZuf6B1QCDbUc/zZ3HOFxtWiZMjaRNbwKfRSKmr+6v0W7kmQKx7DOtoSi5MXyO+epP4PABctEp9QEnlaZbK6BJQ0o06m3ZJl7lH4k6xa9hUi82UxUoDsdhBkgyZV6dl+38HUa1xrXNJPcgGA75yqF0gp1lGlE7LC+z1KextzjhwfYCeBXXoTX3EyAp8ZTzLW0erolKsWLnOhDK2+pbXAgk45zfzEjEE1ib3aBLMPhDT82n6K5fasPPcdQJSrMgVaDGiOV1L4q6eo5+BPdi7ZGqo+ZGGveeHinOmOK78y/A0RDgv21uI57bMUuNmIc4IsrGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VMkFem80S0Plwtz5FkgBEiM02ix/8WyyT9NFo0fAxc=;
 b=HEHUS821NI4hyWEJ0TGBpGgBAyVq4a1OxUsfHSynzN/lAsU/zf13XGG7sE2YZ3dcLCPRWZc1asK5LDPdm5y4CfMfAeVchzrJ3br+kuq+X5LaIS5uY1apv+A9uLGR71UEg/1KDWMdJkQX5FZng8sM++7Gl6ji3KO9OUUduCi4eFj1RFuk8LX/0ry6nzYDjbsJFDh7pU74bl/c9qX6OLNGjyT4z6Kj4s5TgN3sURQqnwEsUwZgVmY3rWdGIlxIKqhflbB3liGnnIsMjj6N+ykUhLubr1/SShnT58rT2+kdSA4DoWWgl3fiNiRCMjSK+AH38Y+9NFRB9d31C+901/g9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VMkFem80S0Plwtz5FkgBEiM02ix/8WyyT9NFo0fAxc=;
 b=AJrG4zYNl9VO6DXBltKz0lDe1xcfFrE7E9BLGRU4QIpyZC/4DMucqBexVnhtTqd3vq5/TbS06kwSC/UYafMWGdAb6xDeT5X77jbqliVWxhEcd1K1w+n4OVbyV/uolVbbPSqUiNGqSVZV1Rt9l4nsDkdaz3AXyT0gF6AUWPf6vJE=
Received: from DM3PR12CA0048.namprd12.prod.outlook.com (2603:10b6:0:56::16) by
 DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Wed, 10 Nov 2021 22:07:53 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::1a) by DM3PR12CA0048.outlook.office365.com
 (2603:10b6:0:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Wed, 10 Nov 2021 22:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:07:53 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:07:51 -0600
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
Subject: [PATCH v7 00/45] Add AMD Secure Nested Paging (SEV-SNP) Guest Support
Date:   Wed, 10 Nov 2021 16:06:46 -0600
Message-ID: <20211110220731.2396491-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 226494c5-4154-43c4-7a9a-08d9a4968b2b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01069550FE49EC6111D62761E5939@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWpbtmkxr6J/Tb9rerydTAI1lhn92yfFX6+0b65l9L27FNnGY5SqWfDC+80YZZzeJ+gjVrQ0PkWKbEfJUp6Ls9m+4yFex868oZ9mm6XZSNVBp2QaTEM1RFeCnt6mwUXtA1JgT3kvFc8/2eysdxGY2kV51kWVkqOhNDcGUdRl2dnFEk8NjnXRyf/874C/bY8gb0RS3NFvmxkT7zb21ACuHaz6j2wItmcNi4HI7FHkzjj0lh5aemx4J0tYU3NsFzIH0EJXheQ96Wy1LI4lXOONOW3YTCY7tp5KzGnCRl21ONEU9l2rkNGHERXl8hHNL//Vnjhtr4rVFWszNHeOXe5sCFDk1xFuTuc6VqY1YKIqbQnbkBtLhmDTRgZ36ytACthqqliiI51m8BvTHY0mXfM4TuoP9kUZkItBya32wosCbb6ZqAaX5RUxhaOfpSKVwlR4vzSHJ6jTnU3T1guepUoGV91hlviS4cjVqkW7rIzss15+ueoWxyDUJHaUyk22AKLyr1AyKLbLe/qK/ySx3CIQREUnSFRR03wc/Q+zmMFm8gI0gkjlqwgAXTloPr4RIfYuwqLBtcMkEu6lIm/UXj8VQM9uIKO9LuXziikEwJcW70h7acbNQZ0fovkr++tqJnratSSAyO1VOTywUXAaQn0373ViYvPV4XMBavI1JzpN3cE8HqXAXgs8Vw9Qk/dxQxxJAHSWAhtx7ze4UmmbwD63/Nyqm/+993rCQPILs3HwsQ7AJtlJVJbARyGqTBCRrvpFKJMYLKXZaIOCwBXHB4hHrOtIAZUI1mM+BdWl9mPogS+u7UkfuEbRWrz/wn8J4Rf65CRxr1R4CVlf7NodVE1obj0mT5my17+MpAYYjKuXS6mRsWPCOvUrbja4b6n9YZ7W
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(54906003)(30864003)(82310400003)(186003)(110136005)(8676002)(336012)(70586007)(4326008)(2906002)(70206006)(1076003)(36756003)(5660300002)(6666004)(508600001)(81166007)(26005)(2616005)(356005)(7416002)(7406005)(426003)(36860700001)(47076005)(7696005)(44832011)(83380400001)(966005)(16526019)(316002)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:07:53.5748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 226494c5-4154-43c4-7a9a-08d9a4968b2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
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
  ea79c24a30aa (origin/master, origin/HEAD, master) Merge branch 'timers/urgent'

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

v6: https://lore.kernel.org/linux-mm/20211008180453.462291-1-brijesh.singh@amd.com/
v5: https://lore.kernel.org/lkml/20210820151933.22401-1-brijesh.singh@amd.com/

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

Borislav Petkov (3):
  x86/sev: Get rid of excessive use of defines
  x86/head64: Carve out the guest encryption postprocessing into a
    helper
  x86/sev: Remove do_early_exception() forward declarations

Brijesh Singh (22):
  x86/mm: Extend cc_attr to include AMD SEV-SNP
  x86/sev: Shorten GHCB terminate macro names
  x86/sev: Define the Linux specific guest termination reasons
  x86/sev: Save the negotiated GHCB version
  x86/sev: Add support for hypervisor feature VMGEXIT
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

Tom Lendacky (4):
  KVM: SVM: Create a separate mapping for the SEV-ES save area
  KVM: SVM: Create a separate mapping for the GHCB save area
  KVM: SVM: Update the SEV-ES save area mapping
  x86/sev: Use SEV-SNP AP creation to start secondary CPUs

 Documentation/virt/coco/sevguest.rst          | 117 +++
 .../virt/kvm/amd-memory-encryption.rst        |  28 +
 arch/x86/boot/compressed/Makefile             |   1 +
 arch/x86/boot/compressed/acpi.c               | 129 +--
 arch/x86/boot/compressed/efi.c                | 178 ++++
 arch/x86/boot/compressed/head_64.S            |   8 +-
 arch/x86/boot/compressed/ident_map_64.c       |  44 +-
 arch/x86/boot/compressed/mem_encrypt.S        |  36 -
 arch/x86/boot/compressed/misc.h               |  44 +-
 arch/x86/boot/compressed/sev.c                | 243 ++++-
 arch/x86/include/asm/bootparam_utils.h        |   1 +
 arch/x86/include/asm/cpuid.h                  |  26 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/setup.h                  |   2 +-
 arch/x86/include/asm/sev-common.h             | 137 ++-
 arch/x86/include/asm/sev.h                    |  96 +-
 arch/x86/include/asm/svm.h                    | 171 +++-
 arch/x86/include/uapi/asm/bootparam.h         |   4 +-
 arch/x86/include/uapi/asm/svm.h               |  13 +
 arch/x86/kernel/Makefile                      |   1 -
 arch/x86/kernel/cc_platform.c                 |   2 +
 arch/x86/kernel/cpu/common.c                  |   5 +
 arch/x86/kernel/head64.c                      |  78 +-
 arch/x86/kernel/head_64.S                     |  24 +
 arch/x86/kernel/probe_roms.c                  |  13 +-
 arch/x86/kernel/sev-shared.c                  | 554 +++++++++++-
 arch/x86/kernel/sev.c                         | 838 ++++++++++++++++--
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
 drivers/virt/coco/sevguest/sevguest.c         | 743 ++++++++++++++++
 drivers/virt/coco/sevguest/sevguest.h         |  98 ++
 include/linux/cc_platform.h                   |   8 +
 include/linux/efi.h                           |   1 +
 include/uapi/linux/sev-guest.h                |  81 ++
 44 files changed, 3524 insertions(+), 345 deletions(-)
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

