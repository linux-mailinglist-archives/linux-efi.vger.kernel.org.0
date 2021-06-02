Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8836398B63
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFBOG0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:06:26 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:8225
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229654AbhFBOGZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:06:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNnlMZ2aWZDuIokg3Z2V4AX2J0pZmXbDCYX/COsTpYD1k1dpvkp/Ol4txWwlIwbCMS3k5kTwC+MnuNKOXwgEKx//3hZwSqBn8EOgB6IkubzBH56rnLzayWkDw9FTtK3gmulQ3oQhQ4mTzmV9GBR6RJOjv9vWNLNRUodeoUwSdcCaQzm9rqt3T7jdLH6ND72iAxIBMfsq22vXrBQaFbmZHCxFsP+QnOlpbuUd/3ElVRbKF6haOOBAbTavVBsAzStbu+EPMb25t/2S1vTPzqsv9OYdLfuc8Yb8PCMID/2mPSJUmq3JZqWzy6hzhVAHweg6ztAyjKSJWmisSjuVg1pXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlgrGuxx3H7C9RMUztu9tfA51vMKe9EnoBRN/d4QaVY=;
 b=j56GGKBcTLgR3LlY4qMQS16YgzrcOkmxNfYUPIhZLxazcmJ/bcsGQ6cf5xxDXPnmQ/vhLv65VKw5m2GffWQGYTp86v072WaQIHxK3XYG3Z2g4mwEskJEr0LNcUZvz5WzfdQEk4t7X2sTPPPxKXwbcpDscsUsfeu68wssAMK6oPV81j1KqJ4Za5BVP/Ow1xPcww5OXuxhLWc/hB6/hE32lovarVOwYZpYCbtakQTR1sQyBoiwzRhz9kTfGacBYF6jiX3huNJw2KXTT5ryyDo8YZQsOYGNc5sXOOG4N5L9wK1hdpvc5AZCynWQ0MeV5kJf5mqXDCAf2ULP6le2LTp0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlgrGuxx3H7C9RMUztu9tfA51vMKe9EnoBRN/d4QaVY=;
 b=VZsN9jWGQAVf/DY2t8whLnKUHWJpv4HEwoGdo6qsE/DIwS+Ux8faPCbPLhyT6m+iB2lHuPCHFtHOdu5qchY2sneXdr35ZY0hfhNrHD8aobXZz0Jtk9jNBCgd8VpIB7yAhcwthNtjMlB+DbmRsweC0B+AN0OXIlCNfcb98npeEHc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 14:04:40 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:40 +0000
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v3 00/22] Add AMD Secure Nested Paging (SEV-SNP) Guest Support
Date:   Wed,  2 Jun 2021 09:03:54 -0500
Message-Id: <20210602140416.23573-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0959eafd-3a46-4f80-3c32-08d925cf5d07
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4512E7A4AD55226315AE900CE53D9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mc/t8I6w2sQcOnKEq94zlPzVKzYX8CB/7V7hm9Fx251fUDfRBdNrFTTwxeiP/p+CuqkWNmEcNP3ShD896pk26hF1HOKyyn0ndVHCJNEKOBQSUtcpeJQNfjzgTvNmBuYtNUnhQ46FYA5lB5Eq8YO8se5H4a59N3yJuOmY9yiHUA6eZ6fDf4AWO/ZrgJgG/lSICdEevQqa73cj5a1fECVvp1rMmkisbQpJwdahfyVwEWIP4XNGEnDNwQ3ZCO0ZbtXAuw62AsdcO6jkNzsCVz5/eitOx9XvmbUc2E1MSOvjZpG3y798DUcBTKGx/kHwjCpXpevj9mXBFvHgRtX7pO2wx3pcJj6uv0xCQxnqqkG+vferVjwCWhYy8/D3N4N0tydxxVK5PZ1hJENq6KOdMuKjDnOaQ7fuskAiTYGjBhn/SkgUwvj3U242kn8zvzIeXS1zYPZXki7aLAt/UJ3+D+vfq34i4bKpMmOCqQvXDs3AAAnskAK1MotCto6D6onCpLj++flk2zTJ+zbhEwtZ/toC/Y4oG5l6GbL/ex/DpismcdwnMisrXR7aND1F6vxiU9OlTZZ/NbA0rbs2p2Q21oncy8nRK70TOnuBS/SwV3g3ymIhlgky0D+GVXX3x+h4t2xhmn/44AhNqyeXy3Thj88SXx5A8FL2ebxxWjYnk4qmzls8PzbGq94eXDZOAV4cLgo+aL0bHk/IFAbVs/RjQrMZTNi0qOxm4tMnlRcol5jrzfx1TnDf4WjdX0XvsmPAJNSBUWLTmuVbFvOnGDnVmUaYBUHjlCqLZ2G1le/zxZNAEFPdEsvmEg71rxH9MT/EOaLB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(966005)(6666004)(44832011)(7416002)(26005)(2906002)(8676002)(6486002)(7696005)(52116002)(38100700002)(478600001)(956004)(66556008)(186003)(1076003)(36756003)(8936002)(16526019)(66946007)(83380400001)(38350700002)(5660300002)(2616005)(54906003)(4326008)(86362001)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TkJUQWcvcXZpdHhIN09VU1lqVDZsR1BaQ1ZCaEdRV0dZZFZzVlV0OXBibmtC?=
 =?utf-8?B?Y3hhU1poQUE1RElpdUVoeE9zNzRxcEdQdi9JRWhsaEQvZEJzdjYxSjkzNnNH?=
 =?utf-8?B?bGx4WGJHcTBKTFFnY0Q0aEVUZVpPK1UzRmczbG92eUJqZittbHc4dUtwdEdT?=
 =?utf-8?B?cXpGcFIzMWZoL3ZBUXNrY0pDWXZHcWZTcXFmeEdDTXVQckxtUVFJRVZ4eHV3?=
 =?utf-8?B?UVMxUWNJWmJxUzlqTXc0MkZFblBoRW5kQXpEQTlBUTg2SDdRZy9vQ0FpbEVk?=
 =?utf-8?B?ay9lYy9NcFBvbHZmZnVVL3dlS0ExOVdjZHF5TzZ0UTI2R1BIUE44U29Ya1d6?=
 =?utf-8?B?aVEwZVF2VUlTNTU5Z2JJaTd3RUZhalkrSTgxVFY2T29aUXhPQmdOcFBHbm96?=
 =?utf-8?B?UFdpcGM2MWt6WHVvMERlNlVXaU0wMW15WkpTVDlBMTUxMWxzbWV4TXlFYWp1?=
 =?utf-8?B?UGVNeGp6VDBYZkZpSjkrR0dYSzZ0U3dXR1RiRFcxNVhnNWw3Y25ncjQxSmVt?=
 =?utf-8?B?NFZ3LzMxV3NRVndLalpJb1l5RFZoajBoQ3ZleU5YT0NXSTVMTGNJZmdIOGVR?=
 =?utf-8?B?K245Z3pjVFh0WUtkaTNXY1NRQ1BFQzkyclg4QnFER3gvZVhkWTk5YXBITkRF?=
 =?utf-8?B?Q3kyNiswaU1kR3VPRTFWRTVNTXRwaDhKZXg1WHBkODQxYVdwVm9rd1dEVDZJ?=
 =?utf-8?B?VjM5a1ZQcGZwL1JUdDRuMi9WMXppblpPY0NESlRhVnVaNUowV0Y2UmR3bWZn?=
 =?utf-8?B?MjZYNXpaRzJyQVVoTEE5VDJRejRYWlR3VlA3MUVuNGFoOU4vU05IZENVSjBH?=
 =?utf-8?B?eWwvTUVLNXp6OU5YOVdXcUprSW5oeEFWWFoySHNrSlhhTnM0Vk1JcmNmNkJo?=
 =?utf-8?B?KzRQczBZZ2lwVWdKVnBpT2paTjVEZEkwM2lJWkJ1QldjbHNCWSsrZXIwVkdQ?=
 =?utf-8?B?MXYvWkVDRXppU3dISmR4SW5LT0tRMHBXK0xoSTZHSit2b2ZnSGZ0Y3p2RStD?=
 =?utf-8?B?bDR2dlB5L2ZnR1VzSnh3K3JtSnpYRExudUZDUzZKQ1NXZ1laeUhRR2VBUnBz?=
 =?utf-8?B?akJjL1czV3R5azNVQVV2Y2x5cUphQWUwemdjVmVqVHhsNDN2TTdqNjRuZHpT?=
 =?utf-8?B?MVB3THhUVTRzOFJXTlc4aXQyV0RYOE9vWHJNeWpKMFQyL1NEUkFWZUxnWEJm?=
 =?utf-8?B?cmViN3lFMG5Rejl0akEzZzlmVG5TOFhld2lPZ3pHSnF3K3RvV0l6NXZ3SkxQ?=
 =?utf-8?B?VDFTamdjVzQzTENFb2hOMUs5NlpXZTlpUmdjcjJvTXpjNG1LVkpMS1dVR29p?=
 =?utf-8?B?ci9DamxpdDc5c0ZhVmc0dlhPN1dPell2amZ6TzFLSGpmNUVwaTZ3SjZMWWdT?=
 =?utf-8?B?V1VGcGFEd1FWZHhMSWVqTDB0MCtyaUFzelVPUDlrNXBWeHpxeHcya3Y4ZWtZ?=
 =?utf-8?B?eUphbTVQdzEzc2hRdVVUU214a2lyVlNGTjdNbTFTeWJzUXF3dkQxQ0lkbi9S?=
 =?utf-8?B?SGlRVWtIeHdwQUFTRUdNL0RQd3p4QlRRaHUyTzZwNGVzNE1vWmFvN0gzTmhJ?=
 =?utf-8?B?NFJmSGQ5c3Nnb09mWEdVMUNNYmxzZEFWblNLYThwRkhRN1F1R1hNSzJieGJW?=
 =?utf-8?B?UlNLaE5yMm03TmU4WVN5blNVYlRaWWJKMmJ3aDVpVXBFMGZiaEpYdllOSGxT?=
 =?utf-8?B?UVh5UUFXUmlnd0V2SzVFeGpnajdqWGJqVmRTZXl3YjFnbGx5NlJ2TDhaZ2Rt?=
 =?utf-8?Q?uIlUyvB59JABXYDwMEb5EqP/+ckpoW1QaPUR/0l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0959eafd-3a46-4f80-3c32-08d925cf5d07
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:40.1137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfx0YwSM5TKmtbo1u07bWn3VHmytVagnMQrJRlEBw9PO3GygUOjGnMtbTfK+yFkB9/v/UQfJqdS3DFAsXdjI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
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

This series does not provide support for the following SEV-SNP features yet:

* Extended Guest request
* CPUID filtering
* Lazy validation
* Interrupt security

The series is based on tip/master commit
  493a0d4559fd (origin/master, origin/HEAD) Merge branch 'perf/core'

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

Changes since v2:
 * Add support for AP startup.
 * Add snp_prep_memory() and sev_snp_active() helper.
 * Drop sev_snp_active() helper.
 * Add sev_feature_enabled() helper to check which SEV feature is active.
 * Shorten the GHCB NAE macro names.
 * Add snp_msg_seqno() to get the message counter used while building the request for the attestation report.
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

Brijesh Singh (18):
  x86/sev: shorten GHCB terminate macro names
  x86/sev: Define the Linux specific guest termination reasons
  x86/sev: Save the negotiated GHCB version
  x86/mm: Add sev_feature_enabled() helper
  x86/sev: Add support for hypervisor feature VMGEXIT
  x86/sev: check SEV-SNP features support
  x86/sev: Add a helper for the PVALIDATE instruction
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
  KVM: SVM: define new SEV_FEATURES field in the VMCB Save State Area
  x86/boot: Add Confidential Computing address to setup_header
  x86/sev: Register SNP guest request platform device
  virt: Add SEV-SNP guest driver

Tom Lendacky (4):
  KVM: SVM: Create a separate mapping for the SEV-ES save area
  KVM: SVM: Create a separate mapping for the GHCB save area
  KVM: SVM: Update the SEV-ES save area mapping
  x86/sev-snp: SEV-SNP AP creation support

 Documentation/x86/boot.rst              |  27 +
 arch/x86/boot/compressed/ident_map_64.c |  17 +-
 arch/x86/boot/compressed/misc.h         |   6 +
 arch/x86/boot/compressed/sev.c          |  78 ++-
 arch/x86/boot/header.S                  |   7 +-
 arch/x86/include/asm/mem_encrypt.h      |   9 +
 arch/x86/include/asm/msr-index.h        |   2 +
 arch/x86/include/asm/sev-common.h       |  76 ++-
 arch/x86/include/asm/sev.h              |  76 ++-
 arch/x86/include/asm/svm.h              | 167 ++++++-
 arch/x86/include/uapi/asm/bootparam.h   |   1 +
 arch/x86/include/uapi/asm/svm.h         |   9 +
 arch/x86/kernel/head64.c                |   7 +
 arch/x86/kernel/probe_roms.c            |  13 +-
 arch/x86/kernel/sev-internal.h          |  12 +
 arch/x86/kernel/sev-shared.c            |  74 ++-
 arch/x86/kernel/sev.c                   | 630 +++++++++++++++++++++++-
 arch/x86/kernel/smpboot.c               |   3 +
 arch/x86/kvm/svm/sev.c                  |  24 +-
 arch/x86/kvm/svm/svm.c                  |   4 +-
 arch/x86/kvm/svm/svm.h                  |   2 +-
 arch/x86/mm/mem_encrypt.c               |  61 ++-
 arch/x86/mm/pat/set_memory.c            |  14 +
 arch/x86/platform/efi/efi.c             |   2 +
 drivers/virt/Kconfig                    |   3 +
 drivers/virt/Makefile                   |   1 +
 drivers/virt/sevguest/Kconfig           |  10 +
 drivers/virt/sevguest/Makefile          |   4 +
 drivers/virt/sevguest/snp.c             | 448 +++++++++++++++++
 drivers/virt/sevguest/snp.h             |  63 +++
 include/linux/efi.h                     |   1 +
 include/linux/sev-guest.h               |  76 +++
 include/uapi/linux/sev-guest.h          |  56 +++
 33 files changed, 1926 insertions(+), 57 deletions(-)
 create mode 100644 arch/x86/kernel/sev-internal.h
 create mode 100644 drivers/virt/sevguest/Kconfig
 create mode 100644 drivers/virt/sevguest/Makefile
 create mode 100644 drivers/virt/sevguest/snp.c
 create mode 100644 drivers/virt/sevguest/snp.h
 create mode 100644 include/linux/sev-guest.h
 create mode 100644 include/uapi/linux/sev-guest.h

-- 
2.17.1

