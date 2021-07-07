Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80A63BEEC6
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhGGSjl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:39:41 -0400
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:31808
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230288AbhGGSjk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW+fWhehwmV3APOhJC9uEdDAqtimYRPhdSVsRrkN9IbVyh5C/Ja1NwM4rb5ys139iC3+Z8VF+g8gX/ZCstSoXMTkZDUmRK/Pr7TL9uXGRw2R+w5bhR+wigTH3xfWU5wdFXx6TMk+RtACTmw7fXxGxqOFaItysDz6CxjHdNxp6C5U01WXVwerx7lnJF+4sMheQxmaGXq99mqUO5W0DGpl8deVUWVhVdCIOW9r3lgb9VODIWdEP44K4Jn/dzSbMHjhu5acmbC2msn5faLKnoeyE82e5Ke/5SMWM2G0jd6Q6+dbwKDo4wmtXgiyWisMoiR1dTNn/f7S2EzUJtd7trsarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qukaQGS2KMzsKPBZwOwskLEj7UEvC3sJHo27yiGOaQ4=;
 b=gigbx/yl2YZdkqYkFXzlJ1ZD7Btiuysgc3i99mJjFnMa4x4kqSzkaCbx2y/H+sw5mgOtSNMg2BejykVvBCMiukp2c9QSjQ8gSNyrPgj7nASyjTsRTSVS8PuNwCngClo9vkj7X9cahw3NoTrUkYpTFuVp0m080VLHFmGqifdM9DaDJVogbA4wNOU8BYnGWVg7iGuQHey+JXU066BTlo7IVf29S1mdlcnJGDDyC5vhE8BHa+r/ipK/EngNSZbJK5yBBBu/XeY/5yFdM2uZJamf9HTMOW3AQMoTjj3na66YAPGFznSsGJdrpGlNHqPbe7a2RgozjjF+d4yTzCMorLgX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qukaQGS2KMzsKPBZwOwskLEj7UEvC3sJHo27yiGOaQ4=;
 b=ZEHHEu1rqZoTwvO6gmPcjjyCVouUxg0nsarLvTzwo0Lwf6V20OqQSxOGM8b9WHjcaZ3ElhxUesPOsaW4Uv8ofiyCNyJWXdZs917YqVjP6G3SXWaPX0MwAOOeuL8Zt68N+HNWMAdKzZjIhV6n0CrZttR9vArbzf/8OmQGFmTzJJs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB3525.namprd12.prod.outlook.com (2603:10b6:a03:13b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:36:54 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:36:54 +0000
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
Subject: [PATCH Part2 RFC v4 00/40] Add AMD Secure Nested Paging (SEV-SNP) Hypervisor Support
Date:   Wed,  7 Jul 2021 13:35:36 -0500
Message-Id: <20210707183616.5620-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:36:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6267774-f094-41ec-723d-08d94176316f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3525E8FF01545F98938A06ABE51A9@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcP5Me0KQ+vR/qRutreVtAh5rzBoOlqan0CTJ7L6MPjqjNN6SG6BhT6hjrArBJyrWQeH82BySHpCW858hMk4if2UH52fGAw0O7FeeCmQ9iAED6YH8tBkO2tZXq6KiNFJDyjkXvyjxXDSzSDIHtR9ZE09PYWrV6gznyY1vg9Irq8W3IeDxe3tCTTARpol1i5EdKHzJPaz9yVQqBRc0tzeDEzklSLc7EMm/Pjdl0K6TUhplnJ8kF0HDqvqdPaTvC3DE5w6RhVO1lIRWYgN3T8rG5OfOfQiMZTT76pOTDRHne4jH2SDViNpz4bGacvCUqA+f1spXitPr/PIu1Z9q6a+y0x+g8tHpAaLWbEyvnpaISBFr9ef/fVSEzc2oUf6EWlxVZc/Np6+D7W1r0Pqh1GrmfSJHRrU3WrRCtRIOBb3Hn/TTLsFTQHrPl4odOFQfUULwNrTmn7NZ7Py45OzoLv67yMKWjS6uSM6ypBRT2eNoBFkZEIYlLZfpxuPHO/M4l5wWIXHXyBv3mQWB8036Qoq+U9v0nCLcDq6zmWlujVwKoJbLrVgbRjrEMafmxnK1Krmd6245jTImg+riUreh39Ih6n9XFKFX6hABcegMSudWzmVAu54drnggkWjCgnRU+ICEQn2Mj2zXGJzOrZ4/Bm/MJ7XcZTFayySR/YqjRr8vTXD1uZux2NksTW/Ma6jjke1Uk5FvMjCuXnYkhK/GeAFCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(83380400001)(1076003)(478600001)(4326008)(44832011)(26005)(6666004)(7696005)(54906003)(2906002)(6486002)(52116002)(36756003)(8676002)(186003)(38350700002)(956004)(7416002)(5660300002)(86362001)(38100700002)(66476007)(7406005)(2616005)(66556008)(66946007)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7SF3lWBIicveVp+wGxk47ZRwcuHAUzQplmoITZL8Er3XJYjrQEtVSUsB7tC?=
 =?us-ascii?Q?YK8lDXxQKJqdKt+B0tgA31rjYkkT/f4k2Rf9nVDEcU2QLLN21pr4cnfO6CcA?=
 =?us-ascii?Q?/lgAXnkv/SJIUfpd5gOhZCL9zgpr/NGp+Xzjo0bwuvBISJPFHljHqRHZ5jca?=
 =?us-ascii?Q?xXgnQynqe/9tO8YQ0wLz9eCaiHcwgTHUgQEz9eKf1Y3+NN+n9SsEVhUQ1z03?=
 =?us-ascii?Q?2jdWQAS8fv98gx3xqxc1yPAXqb8USxu8cyv0qrML5VuKTNs1ZTej1uH35sgW?=
 =?us-ascii?Q?gqk3zk4NY6Ge8V9B64ip8B7boudkTvOyZJCmP9Wg1yCONenf0pzdNs4itwVV?=
 =?us-ascii?Q?Fi3QHk+H1sEhzWpX6+wAbVnrYJE1cEsOzztWo2RLipKPeC18ThWgE33EMKvk?=
 =?us-ascii?Q?MDlxEuUOicBoMNVGtFsp9/OQQfsts5O3IbmN0jmoZRQm0qxoGqQ2CgNeMK6y?=
 =?us-ascii?Q?ds4m2tYuHMYwQaXGG9K2qw5xRfjDA6Mrd8UuQ/OqddFZP5O+4AWJpvrPnV1Q?=
 =?us-ascii?Q?0C2euh9mNMsXfdNqV7G63tY39bQ34Cb/QEwqGnDzHQIO5GS6mosJLhcstxGQ?=
 =?us-ascii?Q?CUlRqGkK/3RX8UsK1F4TZhKp7CIafEfd0NINHhHxcmTZ12JCW0o+4h8i2OA3?=
 =?us-ascii?Q?lF8xOlCCQzXyhSV5DAi5P/JQozZiUJpaz3CHr3DFL3LUkgfYNE1wCzNj/kuU?=
 =?us-ascii?Q?Qw2lnlRm4zbPVmC0dGSIiZNt5NBOnNMO5PMnk9mwuICSrhCxHVav2VwnyXfw?=
 =?us-ascii?Q?D6C2CuUMAuYH8Zkx+RXP2tFTwQAi+B0p2gByxW2GGZXeJrXiYZ/a57cYO/Sf?=
 =?us-ascii?Q?FxXSFd81WG0X2UnQp0X8RN0ypImBvfvkt0g9bIEjbHGEUDhbG7+wf5F9rFCc?=
 =?us-ascii?Q?OloCkDfGFsGQikdOFPlY2GxBLpOIZH3+E58Qzu1rgriARaSZ5Z9NiVsjRYzO?=
 =?us-ascii?Q?nxCHoEdvrpv7+vEH37row0qIcK00Ezqgk9vqQqjArRt5sCo+24migAx4E+/6?=
 =?us-ascii?Q?04dSvBf828mKJJxGyvSEeys8BRnFKmgLi3Lg0NL6aHcZ44hEoz3XQmXztieP?=
 =?us-ascii?Q?L4ydi3R0rXZwcTtvbJYJIKLa3BS4eaP3MysVpIwNU/bazoyOv0EA5hZluL5U?=
 =?us-ascii?Q?Xfr9lH3ltWK78zGcdxaYUquWHRIsYKOuW9kQtryAjcLb67dbtluuVwr5ElnN?=
 =?us-ascii?Q?YNeMB6uOYZA04jhoQkRLVxaS9CAIe/75mgiA3pBTTo3ebQgD4bHLTuaqAYme?=
 =?us-ascii?Q?a2OlV7iy1qTHzduiZUVywbes98qbT7TbS5edu105j8hM/932b0/b9j5Pt8Qr?=
 =?us-ascii?Q?BblULdqoXBb+fAlmLSrKTz0G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6267774-f094-41ec-723d-08d94176316f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:36:54.2868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXq00rUrk/4SAA5NUFslxau8ndcJ+Rs17iJf3cFaovvv+etUvYJ3GYO/JPjCqNVi0w8OocZxP9CBoETtQhH5zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This part of the Secure Encrypted Paging (SEV-SNP) series focuses on the
changes required in a host OS for SEV-SNP support. The series builds upon
SEV-SNP Part-1.

This series provides the basic building blocks to support booting the SEV-SNP
VMs, it does not cover all the security enhancement introduced by the SEV-SNP
such as interrupt protection.

The CCP driver is enhanced to provide new APIs that use the SEV-SNP
specific commands defined in the SEV-SNP firmware specification. The KVM
driver uses those APIs to create and managed the SEV-SNP guests.

The GHCB specification version 2 introduces new set of NAE's that is
used by the SEV-SNP guest to communicate with the hypervisor. The series
provides support to handle the following new NAE events:
- Register GHCB GPA
- Page State Change Request
- Hypevisor feature
- Guest message request

The RMP check is enforced as soon as SEV-SNP is enabled. Not every memory
access requires an RMP check. In particular, the read accesses from the
hypervisor do not require RMP checks because the data confidentiality is
already protected via memory encryption. When hardware encounters an RMP
checks failure, it raises a page-fault exception. If RMP check failure
is due to the page-size mismatch, then split the large page to resolve
the fault.

The series does not provide support for the following SEV-SNP specific
NAE's yet:

* Interrupt security

The series is based on the commit:
 a4345a7cecfb (origin/next, next) Merge tag 'kvmarm-fixes-5.13-1' 

Changes since v3:
 * Add support for extended guest message request.
 * Add ioctl to query the SNP Platform status.
 * Add ioctl to get and set the SNP config.
 * Add check to verify that memory reserved for the RMP covers the full system RAM.
 * Start the SNP specific commands from 256 instead of 255.
 * Multiple cleanup and fixes based on the review feedback.

Changes since v2:
 * Add AP creation support.
 * Drop the patch to handle the RMP fault for the kernel address.
 * Add functions to track the write access from the hypervisor.
 * Do not enable the SNP feature when IOMMU is disabled or is in passthrough mode.
 * Dump the RMP entry on RMP violation for the debug.
 * Shorten the GHCB macro names.
 * Start the SNP_INIT command id from 255 to give some gap for the legacy SEV.
 * Sync the header with the latest 0.9 SNP spec.
 
Changes since v1:
 * Add AP reset MSR protocol VMGEXIT NAE.
 * Add Hypervisor features VMGEXIT NAE.
 * Move the RMP table initialization and RMPUPDATE/PSMASH helper in
   arch/x86/kernel/sev.c.
 * Add support to map/unmap SEV legacy command buffer to firmware state when
   SNP is active.
 * Enhance PSP driver to provide helper to allocate/free memory used for the
   firmware context page.
 * Add support to handle RMP fault for the kernel address.
 * Add support to handle GUEST_REQUEST NAE event for attestation.
 * Rename RMP table lookup helper.
 * Drop typedef from rmpentry struct definition.
 * Drop SNP static key and use cpu_feature_enabled() to check whether SEV-SNP
   is active.
 * Multiple cleanup/fixes to address Boris review feedback.

Brijesh Singh (37):
  KVM: SVM: Provide the Hypervisor Feature support VMGEXIT
  x86/cpufeatures: Add SEV-SNP CPU feature
  x86/sev: Add the host SEV-SNP initialization support
  x86/sev: Add RMP entry lookup helpers
  x86/sev: Add helper functions for RMPUPDATE and PSMASH instruction
  x86/sev: Split the physmap when adding the page in RMP table
  x86/traps: Define RMP violation #PF error code
  x86/fault: Add support to dump RMP entry on fault
  x86/fault: Add support to handle the RMP fault for user address
  crypto:ccp: Define the SEV-SNP commands
  crypto: ccp: Add support to initialize the AMD-SP for SEV-SNP
  crypto: ccp: Shutdown SNP firmware on kexec
  crypto:ccp: Provide APIs to issue SEV-SNP commands
  crypto: ccp: Handle the legacy TMR allocation when SNP is enabled
  crypto: ccp: Handle the legacy SEV command when SNP is enabled
  crypto: ccp: Add the SNP_PLATFORM_STATUS command
  crypto: ccp: Add the SNP_{SET,GET}_EXT_CONFIG command
  crypto: ccp: provide APIs to query extended attestation report
  KVM: SVM: Make AVIC backing, VMSA and VMCB memory allocation SNP safe
  KVM: SVM: Add initial SEV-SNP support
  KVM: SVM: Add KVM_SNP_INIT command
  KVM: SVM: Add KVM_SEV_SNP_LAUNCH_START command
  KVM: SVM: Add KVM_SEV_SNP_LAUNCH_UPDATE command
  KVM: SVM: Reclaim the guest pages when SEV-SNP VM terminates
  KVM: SVM: Add KVM_SEV_SNP_LAUNCH_FINISH command
  KVM: X86: Add kvm_x86_ops to get the max page level for the TDP
  KVM: X86: Introduce kvm_mmu_map_tdp_page() for use by SEV
  KVM: X86: Introduce kvm_mmu_get_tdp_walk() for SEV-SNP use
  KVM: X86: Define new RMP check related #NPF error bits
  KVM: X86: update page-fault trace to log the 64-bit error code
  KVM: SVM: Add support to handle GHCB GPA register VMGEXIT
  KVM: SVM: Add support to handle MSR based Page State Change VMGEXIT
  KVM: SVM: Add support to handle Page State Change VMGEXIT
  KVM: Add arch hooks to track the host write to guest memory
  KVM: X86: Export the kvm_zap_gfn_range() for the SNP use
  KVM: SVM: Add support to handle the RMP nested page fault
  KVM: SVM: Provide support for SNP_GUEST_REQUEST NAE event

Tom Lendacky (3):
  KVM: SVM: Add support to handle AP reset MSR protocol
  KVM: SVM: Use a VMSA physical address variable for populating VMCB
  KVM: SVM: Support SEV-SNP AP Creation NAE event

 Documentation/virt/coco/sevguest.rst          |   55 +
 .../virt/kvm/amd-memory-encryption.rst        |   91 ++
 arch/x86/include/asm/cpufeatures.h            |    1 +
 arch/x86/include/asm/disabled-features.h      |    8 +-
 arch/x86/include/asm/kvm_host.h               |   24 +
 arch/x86/include/asm/msr-index.h              |    6 +
 arch/x86/include/asm/sev-common.h             |   18 +
 arch/x86/include/asm/sev.h                    |    4 +-
 arch/x86/include/asm/svm.h                    |    3 +
 arch/x86/include/asm/trap_pf.h                |   18 +-
 arch/x86/include/uapi/asm/svm.h               |    4 +-
 arch/x86/kernel/cpu/amd.c                     |    3 +-
 arch/x86/kernel/sev.c                         |  217 +++
 arch/x86/kvm/lapic.c                          |    5 +-
 arch/x86/kvm/mmu.h                            |    5 +-
 arch/x86/kvm/mmu/mmu.c                        |   76 +-
 arch/x86/kvm/svm/sev.c                        | 1321 ++++++++++++++++-
 arch/x86/kvm/svm/svm.c                        |   37 +-
 arch/x86/kvm/svm/svm.h                        |   48 +-
 arch/x86/kvm/trace.h                          |    6 +-
 arch/x86/kvm/vmx/vmx.c                        |    8 +
 arch/x86/kvm/x86.c                            |   89 +-
 arch/x86/mm/fault.c                           |  149 ++
 drivers/crypto/ccp/sev-dev.c                  |  863 ++++++++++-
 drivers/crypto/ccp/sev-dev.h                  |   18 +
 drivers/crypto/ccp/sp-pci.c                   |   12 +
 include/linux/kvm_host.h                      |    3 +
 include/linux/mm.h                            |    6 +-
 include/linux/psp-sev.h                       |  347 +++++
 include/linux/sev.h                           |   76 +
 include/uapi/linux/kvm.h                      |   47 +
 include/uapi/linux/psp-sev.h                  |   60 +
 mm/memory.c                                   |   13 +
 tools/arch/x86/include/asm/cpufeatures.h      |    1 +
 virt/kvm/kvm_main.c                           |   21 +-
 35 files changed, 3571 insertions(+), 92 deletions(-)
 create mode 100644 include/linux/sev.h

-- 
2.17.1

