Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663FE426FE1
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbhJHSHP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:07:15 -0400
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:9281
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231245AbhJHSHO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEmL8lQl+GjuR1s88w3HPBeOhOMdATxntvUGmKUZGSygwpavFwRHqvggghrRbsUBYnpYeuB6Pa/pZxrOkrcRXpmpJchRTau2q8/pJsQScxx9hlHA83qjYz6fZu2AhWxWoX2TSLkL0xCqc3n93MrniEgDgakus98jSAil7O7jgMCHnEs42pI1++SB7KI520cX3RO8tRM/l5jhXD4Yp+wayHjHdBEasUFgtPpZ8jNzwplhAm/r9vRRvgeGTPucsgE7lJtBoCy6W5cfr8QxCPsFU5Kne16XhheTyLmIwBAVhp9XruanBaIk+4oarSIxgvyG0cRYXYto/RtS7xoFUKCXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d1nw+Iyq8+S9Rcc+3AQlATRUWi5W+sr0T5f+6LfjGI=;
 b=ENZ6TGWQdNJhXh2OqXLeWdTOE+DDxGMNsP8Yp0c9PudREcTY9iwfNdxXuGpaI3gQ9ojy229Q/hG+UTBYH/DunnC+83Y8wFbLUDyDzQMuJ8nq12vaFp/F7jFOwqFzPq7g450PLcCN/MPS1BuKInHbddfSK0DCtlJExy1saazsr0DwsJOtBDGq9DThGGN6PsaIIAMH2ottdFBRyIE0mNMBU9aTo4VHx+cmQtzFamxHArY0E6Jd5wG5hV3EMWup5e10G8zGh8uLrgTZ4FkEtNNaTUqpsLOn4/2jeMMcMqkKxbPYfHSMN5GWWVdmU5Ir0wM8+PZK7a4XUwiQIgjpgHCcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d1nw+Iyq8+S9Rcc+3AQlATRUWi5W+sr0T5f+6LfjGI=;
 b=139DJKdnPd7DkHxFmH/zSMvK/anh6NV9IBEkCxMQ4Z4Yay+BZvKnSbxWeQK+lEXxrTvPnYPY5jXvCtY4eYMihilu6QmU+yt9RDbjr8jjTcg5jp1dAaUqgZeAhZ+aicJyfyFDrFlJeWf5revi5I4GTMjFociqDhD42LAOFblfOCo=
Received: from MW4PR03CA0082.namprd03.prod.outlook.com (2603:10b6:303:b6::27)
 by MN2PR12MB4607.namprd12.prod.outlook.com (2603:10b6:208:a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 18:05:13 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::37) by MW4PR03CA0082.outlook.office365.com
 (2603:10b6:303:b6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:12 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:10 -0500
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
Subject: [PATCH v6 00/42] Add AMD Secure Nested Paging (SEV-SNP) Guest Support
Date:   Fri, 8 Oct 2021 13:04:11 -0500
Message-ID: <20211008180453.462291-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db1f7ff0-23c8-4a8c-a879-08d98a862cc3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4607:
X-Microsoft-Antispam-PRVS: <MN2PR12MB46075845E00C88472E953A14E5B29@MN2PR12MB4607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BoKtWPLsUYvge4o1mRu30+Gw9+VuIZeGQY6FfZ0Uy1JpbKLnFNarBQHR+Qn6sb5pQxc/VzeSM5mB5OFFXjrIB2Cc5+9d3vThdXmYPPSba+2bw5YkyhbBZbBDx35ltm5N349SxFkJpYrsTmvJrn5MUSgoa8FswPXwY/rwDAdpQc2olOdhYvR1O7fyB7QVubKUnOPTmSkmwdY1NgKaCvKvBBwOKkYXD1ycje+jLCZ/+F6hSqP402BQuubBPEc8/aZfyV984QEfPt0KY4xphhPag9Zlz+7At/CPIicP8mbKtNYLDJMC9J3wMGqhvWyAL3xMtSe4HT40XGW0C46uVclCmjJpghLUftFYhAWMEJXxRit0sTbANqNafJNtVd4QS+Six/ixxq2xU0EqdWJ8OeD87vDStgglcZJAkyFV1TowyDTtLNR9ZjLw8KpXp5TdpuZF4J2J++R5jbk+a4vkrrqMrd/UQ782LZQlJRwTiQcZj3bqDo8v2f5A1ZuPTefo+9Bl44k4lrlplSQho6ZxjB/YVXNk3ODNRmIkqVthmNyBxFl09pN/zNUuE4FHzKkB5tEKIdcGH5Oo7ujX4xuq3hy4VCTO0la/GaOKCNQB/wDr5ckbFuM3ZZNDk9gjq0jfcmB7P4zoFI591fpAtgCjSElo5v1+uXg/ZLFeS6fZk9KWkATndAvRn+m8WJpjZFPw6gDcI0eIQpr2KSQ4Y8lxR+QHunXQjaZQJ/2R1mM+fnSVhpTfrDEQrd2/nYTIc5b9V9w5KzgsQ7hXilEBYNF+mMqNRT3ikocKvF+WQQ/35DK5TnsxxGkndgNpw2NbJxuDiKq9lir9iE61L4rG9Is8M1azQLyrfE0VAmm5bp2xL6uOU/qSGEtq7GD5VyQTfvgIjt0Y
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(83380400001)(70586007)(110136005)(7696005)(2616005)(47076005)(70206006)(82310400003)(4326008)(1076003)(26005)(16526019)(54906003)(8676002)(7416002)(966005)(36860700001)(36756003)(8936002)(186003)(44832011)(336012)(2906002)(508600001)(5660300002)(316002)(81166007)(7406005)(356005)(86362001)(426003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:12.9487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db1f7ff0-23c8-4a8c-a879-08d98a862cc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4607
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
  a6d06ef25c4e (origin/master, origin/HEAD, master) Merge branch 'irq/core

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

v5: https://lore.kernel.org/lkml/20210820151933.22401-1-brijesh.singh@amd.com/

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

Michael Roth (13):
  x86/sev-es: initialize sev_status/features within #VC handler
  x86/head: re-enable stack protection for 32/64-bit builds
  x86/sev: move MSR-based VMGEXITs for CPUID to helper
  KVM: x86: move lookup of indexed CPUID leafs to helper
  x86/compressed/acpi: move EFI system table lookup to helper
  x86/compressed/acpi: move EFI config table lookup to helper
  x86/compressed/acpi: move EFI vendor table lookup to helper
  x86/compressed/64: add support for SEV-SNP CPUID table in #VC handlers
  boot/compressed/64: use firmware-validated CPUID for SEV-SNP guests
  x86/boot: add a pointer to Confidential Computing blob in bootparams
  x86/compressed/64: store Confidential Computing blob address in
    bootparams
  x86/compressed/64: add identity mapping for Confidential Computing
    blob
  x86/sev: use firmware-validated CPUID for SEV-SNP guests

Tom Lendacky (4):
  KVM: SVM: Create a separate mapping for the SEV-ES save area
  KVM: SVM: Create a separate mapping for the GHCB save area
  KVM: SVM: Update the SEV-ES save area mapping
  x86/sev: Use SEV-SNP AP creation to start secondary CPUs

 Documentation/virt/coco/sevguest.rst    | 117 ++++
 arch/x86/boot/compressed/Makefile       |   1 +
 arch/x86/boot/compressed/acpi.c         | 120 +---
 arch/x86/boot/compressed/efi.c          | 171 +++++
 arch/x86/boot/compressed/head_64.S      |   1 +
 arch/x86/boot/compressed/ident_map_64.c |  44 +-
 arch/x86/boot/compressed/idt_64.c       |   5 +-
 arch/x86/boot/compressed/misc.h         |  42 ++
 arch/x86/boot/compressed/sev.c          | 189 +++++-
 arch/x86/include/asm/bootparam_utils.h  |   1 +
 arch/x86/include/asm/cpuid.h            |  26 +
 arch/x86/include/asm/msr-index.h        |   2 +
 arch/x86/include/asm/setup.h            |   2 +-
 arch/x86/include/asm/sev-common.h       | 137 +++-
 arch/x86/include/asm/sev.h              |  80 ++-
 arch/x86/include/asm/svm.h              | 167 ++++-
 arch/x86/include/uapi/asm/bootparam.h   |   4 +-
 arch/x86/include/uapi/asm/svm.h         |  13 +
 arch/x86/kernel/Makefile                |   1 -
 arch/x86/kernel/cc_platform.c           |   2 +
 arch/x86/kernel/head64.c                |  79 ++-
 arch/x86/kernel/head_64.S               |  24 +
 arch/x86/kernel/probe_roms.c            |  13 +-
 arch/x86/kernel/sev-shared.c            | 569 +++++++++++++++-
 arch/x86/kernel/sev.c                   | 860 ++++++++++++++++++++++--
 arch/x86/kernel/smpboot.c               |   3 +
 arch/x86/kvm/cpuid.c                    |  17 +-
 arch/x86/kvm/svm/sev.c                  |  24 +-
 arch/x86/kvm/svm/svm.c                  |   4 +-
 arch/x86/kvm/svm/svm.h                  |   2 +-
 arch/x86/mm/mem_encrypt.c               |  55 +-
 arch/x86/mm/pat/set_memory.c            |  15 +
 drivers/virt/Kconfig                    |   3 +
 drivers/virt/Makefile                   |   1 +
 drivers/virt/coco/sevguest/Kconfig      |   9 +
 drivers/virt/coco/sevguest/Makefile     |   2 +
 drivers/virt/coco/sevguest/sevguest.c   | 703 +++++++++++++++++++
 drivers/virt/coco/sevguest/sevguest.h   |  98 +++
 include/linux/cc_platform.h             |   8 +
 include/linux/efi.h                     |   1 +
 include/uapi/linux/sev-guest.h          |  81 +++
 41 files changed, 3389 insertions(+), 307 deletions(-)
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

