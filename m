Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F82A3F2EC0
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbhHTPV1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:21:27 -0400
Received: from mail-bn8nam08on2046.outbound.protection.outlook.com ([40.107.100.46]:11233
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241024AbhHTPV0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ0e6ZgnOYZJIbT0AJK/kXEnX2L9ux6yY6l6tQ15fdHNL/EIzr2iA9NxyLso4H2ENM+38dofa9W0r5/U+U3rvtKLqmnMOoBGAgCdrpnNoFgER30T72zANGJTBNat4LP9J8h75HwJh81GmWQoao/GLD+pyO9lSEgz/HosHrla1OpAlKs9iYK3hyzHfRnnkV04V3zDlNcnpHSIh9tkYJ9dKL6LpxGWWDwNIqsLXyQF8iAv3KROgyaLFT2H6mqfhG7MKDYieJY07lO8NlOYP2wBms1Kg+Nf6CeqQI/M/d2bO5JLNx7DDODj/jtCVqVKUjOYokEwzc5P6ggSBUHgG99r7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g18QstA/LjJhHaayeGCyDN7h2D6qbNgdLCNIoFSZ34Y=;
 b=bchLsLZnPot2o0fgBgC3LaLjS//RrgeJySYA31WcOICIbql2JyUTD+ll2RewdwyiM/10cYkAABWlpf1cVNqYTGg5V00a3RM8l1DUp1Ujh4l/8w/x3wzM3/ai7KRYNh5iXafWjnxuXaivTka0fCNpcJm2jmT5T1YGvN2pV2Va62jk5tSIACsuTOvQMRN0S6qNW1w0bx46cMB73UBTYvNue/gYf2X4LvmmeSa2mGNuRupDeAo286jylKjFOKctuWZtPUxbFVX/y2lQvE4fDHYzXTVV0WgfbN34Gs2NkJDMI2J7OzbroFmSzT9sspAq7Sxzl/4rZy4OCCa8HFx8k/w4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g18QstA/LjJhHaayeGCyDN7h2D6qbNgdLCNIoFSZ34Y=;
 b=Mbj19l00a8oJrIcP2TEjg+C11x6J5SZwNMoX11Zka1SelpoT43+hZmnhL7LAHexN+NBU0vR3txO0zRhzICMZVhmh+E1BZMkYaHHGrsN08TmNng5QsDiRAixmwHr8yIppk487dgs6quuGsV7w18YdRUha+sY5iO8XGUUXWaaU5Jg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:20:46 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:20:46 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 00/38] Add AMD Secure Nested Paging (SEV-SNP) Guest Support
Date:   Fri, 20 Aug 2021 10:18:55 -0500
Message-Id: <20210820151933.22401-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:20:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf518cf4-bba2-4692-656e-08d963ee153a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4557CF91E2C053F7E9C31900E5C19@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+Gn9jKM0ZfaMVxXFtSYds/amctRwRZMRJlb8rmfqug1ybec4GiHqe5GWLYR/vEYOdTiOax0Ko+DPLR6Q/mRIRs2eTRhYq03wrM7IHo31O5KlCd2NdYdp877gepi2JCWgdX2q1KVPOq2hRjevEa6K+BWs++XoJxASB+XsMV8Rc1uTxO0v3OUmZqfcES41xIYBUt8J+8jqJeOQrjA896pbT5Uy27SqOZDvwwjnyv8sbwdloTFobTU2RYUnIrlpHZFPjDDjFYBZ2inFSb/IuruWyWxNaOGxWJ6+4eIhbqmJGexyao9zvtUSvTOzF1q1ODcZ/wJ858788/PBJyHfMOQbOYQrZoKFUhGmz6wyk+1qu7aqKNkL27/FRTHy2VbEC2ABXAbri+wo6KisdhtfYAYDrM+37Wu1tYQxyZHstQpI+UV7WuXO7OffyBSgzCALaSHHDL5QqvHqDZj+MQTh5tK5+++1P0AbXW7W8QJgKoLRn7+IIya/7mPvmOEm72lN3XgpyrOACp+Q2P1cAuACTzyldniKqZOqJfGmX52QTGzu6Po7CK3Y/1BaxTnqxrtiRRR3ls3dGihrphVkZVQr4U4dlO3FRCJtlokiBR0RWKX3S7aCFbcN2bHrtohRNPGakQP5IoMmpGTZNpBlT9PD6GO0XJxW3EEUlfD8U1ctWplcF1gjJKygQO184hAWvE6cDzWprUhjkvqSrbKvx2k/imScmSwtFTeGFnwMSww6KtAG0ajELROlFjv9Z9ngw0g1iDqkqVBbMkhzmWyOeX1YEzLhOWWmwaBkaVdh1Jzu8kZKr14JRXuaZeUOVISinTW4XcwjUCNXrae+7oOaWWF1NcBIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(66476007)(66946007)(4326008)(478600001)(44832011)(956004)(2616005)(7696005)(7406005)(38350700002)(52116002)(966005)(66556008)(7416002)(38100700002)(6666004)(36756003)(186003)(316002)(8936002)(2906002)(83380400001)(86362001)(26005)(54906003)(1076003)(6486002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjQyM3NtZXRQSDJ4UVlkRVNQMktQUmc4ZWFISFBwYWd4RyttUnlldmpjYi92?=
 =?utf-8?B?WmFCbXlNdWNCa0dMbU9qVkdPUzV3Tit2NFgzWmJydlFoQkFoK1dBbG1ITkto?=
 =?utf-8?B?WHdsb1ZHUEFwUE16VXlrTTRxOUN6MEZ2anNsSGtpMGFFY2VNam1kN3lEeWFM?=
 =?utf-8?B?YkJ1d0x6TDV3Vi9BL0tnTnpsbmMxUG9MWUNERGhqZVV5dWtacVFmN3ViL3I3?=
 =?utf-8?B?T1FsdFpqWk04TEFkSklUR1dHUUpXNUx3d1dYSE1sMFdFcFFVYlBSWFZkZkxz?=
 =?utf-8?B?RUI2eGNsQjZMK2tWMzVzV1dVUzFqeDVzalN5UTVwRGkxVHNxOU5qSnBIdnlt?=
 =?utf-8?B?ZUpBanpxZHIvNzgvVmlPQ3FMMFpWTmpNY1BkZ2g4TExYMnI4V0NzNEo5NEtU?=
 =?utf-8?B?ZEdWbDhrUi94czZsK3ZlS1h1ZzRHa2VITTY4cVpVRUk2bWVyTHYxNDNuQ1Rk?=
 =?utf-8?B?eG1YSFFzWmJXK1laYlVOOWRsbVc5TWl1b0tRcTBDNUJHL3V6c1IycUFPMUFz?=
 =?utf-8?B?cjBjaTU3SkFPK3ZLVVF0VXpmUzYzWk1pazdDUFMxTkxxcWVJb1ZqZVlRQVdZ?=
 =?utf-8?B?Yk1kZlpxQURtOE04SzQyc3E0NXgzOS9wMzhiKzhDdEMvemd2MnMvMWJZVnVi?=
 =?utf-8?B?REg3bEFBMk1ab1B2UStkUkd3ZUs3eXdpNnRaK1pIWW90YkhTSW9ubEZOUG1S?=
 =?utf-8?B?UEpJV3VkcDNpY2N0enJmN0VMTVV6RlhHOWY5NXRzczMzNjltby9RNGZvSC9I?=
 =?utf-8?B?SUYyUDdkTFdheVhyeU54Y0ZHOWV2RFNvcVNHcHRNekJadnFmQUNSSDkwVUhZ?=
 =?utf-8?B?SEg3NytXU2lqN0prSTVqbGQ3RlpKN2ZsQkF5U3paWWg0TndtNVVnMnVaNnBG?=
 =?utf-8?B?cVFJOGZnUkpYTWhCWlFBWWU3Wm9sU1hkZG9wTC9VTC84SVFGQXB1M01MNlBI?=
 =?utf-8?B?VlpwM2dzWFYwYUZxOWVkZHVzVEcxRWhWMmhoQkw1Q0NMMzNNdFU1VGVhQ3Jy?=
 =?utf-8?B?bFIwL1oyMmdjU1U1eXF3eUtPUit6NTFWY01YUG0vMUwvZTdOSVBLT2xBbCtT?=
 =?utf-8?B?WFUxaGY1Qnc1RUVzeDFLVkVsR1BJR2NYRXg5bVN4ektWa0RyNWIxM0ZvUG9J?=
 =?utf-8?B?RmNablUxUDQyMVhpWWhMczZmblZBNFk5T1hCcWptMlJwaGxYaG9kSzBoWDVk?=
 =?utf-8?B?OGYxelNxK3pVZ0tzQmxSM3dNSkdDcVpBR1gzcU1JZS9rYUEzNU9aRGpabXhs?=
 =?utf-8?B?Y245VEo4SUl6YWZwem9lRVZoMGt2N1JadTliOWFIK3p5dVEzUEVEWVplYmhV?=
 =?utf-8?B?dzdYcWN3Z1dYcHp5UjdlZjFsTjdGeWlzRTBGZ1k4UDY2ZkNzSXpyaW9wcmQ2?=
 =?utf-8?B?TGhZY2NKSElNQTBJdTkxRjFrZnJ0NjdlREYwS2JTT3BSZFJHZ0djeEFzUm9S?=
 =?utf-8?B?a3JIZkVUR2VkeWlhZlN2UmY2QjZMUVlXQWxxcW10eStOR2Y3TDhuenIwdzlK?=
 =?utf-8?B?bDJibU40Y1VYMnZMZktEaitjSjVuRUF3aVI5M3dMS1hkOG9vMlFCS3BDTnE1?=
 =?utf-8?B?Y1pFSW9hQ0ZjZlZFZlg1WCs5S1gwaU9NUnNNZ2YralMvZDRmZldudFFEd2tC?=
 =?utf-8?B?MGhSVUFlVUJBcjJIUTg1dWRIcDVHdmhOcngyRTBjUFVxN3JDMkE1cUNHcG42?=
 =?utf-8?B?YVhUbWpsY3BMT1ZiaDJOUmt2bzF0NklBY01ucHRuN3ZpN0lHMk9CT1JqVXFs?=
 =?utf-8?Q?RUlSGalMVmZ54NBRQCKyhvV58kLhwNlldGpx/hS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf518cf4-bba2-4692-656e-08d963ee153a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:20:46.1539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CbR2GNVd1WKqlRpJPUzr5F8K2MdgOU8EvcrKpteHO6EBSpl5xsxN4AKmP262h/GJXUE4ebu8rQNgPZTGfCO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
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
  f6a71a5ebe23 (origin/master, origin/HEAD) Merge branch 'locking/core'

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

Borislav Petkov (2):
  x86/sev: Get rid of excessive use of defines
  x86/head64: Carve out the guest encryption postprocessing into a
    helper

Brijesh Singh (23):
  x86/mm: Add sev_feature_enabled() helper
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
  x86/sev: Add snp_msg_seqno() helper
  x86/sev: Register SNP guest request platform device
  virt: Add SEV-SNP guest driver
  virt: sevguest: Add support to derive key
  virt: sevguest: Add support to get extended report

Michael Roth (9):
  x86/head/64: set up a startup %gs for stack protector
  x86/sev: move MSR-based VMGEXITs for CPUID to helper
  KVM: x86: move lookup of indexed CPUID leafs to helper
  x86/compressed/acpi: move EFI config table access to common code
  x86/compressed/64: enable SEV-SNP-validated CPUID in #VC handler
  x86/boot: add a pointer to Confidential Computing blob in bootparams
  x86/compressed/64: store Confidential Computing blob address in
    bootparams
  x86/compressed/64: add identity mapping for Confidential Computing
    blob
  x86/sev: enable SEV-SNP-validated CPUID in #VC handlers

Tom Lendacky (4):
  KVM: SVM: Create a separate mapping for the SEV-ES save area
  KVM: SVM: Create a separate mapping for the GHCB save area
  KVM: SVM: Update the SEV-ES save area mapping
  x86/sev: Use SEV-SNP AP creation to start secondary CPUs

 Documentation/virt/coco/sevguest.rst    | 109 ++++
 arch/x86/boot/compressed/Makefile       |   1 +
 arch/x86/boot/compressed/acpi.c         | 113 +---
 arch/x86/boot/compressed/efi.c          | 179 ++++++
 arch/x86/boot/compressed/head_64.S      |   1 +
 arch/x86/boot/compressed/ident_map_64.c |  36 +-
 arch/x86/boot/compressed/idt_64.c       |   7 +-
 arch/x86/boot/compressed/misc.h         |  50 ++
 arch/x86/boot/compressed/sev.c          | 115 +++-
 arch/x86/include/asm/bootparam_utils.h  |   1 +
 arch/x86/include/asm/cpuid.h            |  26 +
 arch/x86/include/asm/mem_encrypt.h      |  10 +
 arch/x86/include/asm/msr-index.h        |   2 +
 arch/x86/include/asm/realmode.h         |   1 +
 arch/x86/include/asm/setup.h            |   5 +-
 arch/x86/include/asm/sev-common.h       | 130 ++++-
 arch/x86/include/asm/sev.h              |  73 ++-
 arch/x86/include/asm/svm.h              | 167 +++++-
 arch/x86/include/uapi/asm/bootparam.h   |   4 +-
 arch/x86/include/uapi/asm/svm.h         |  13 +
 arch/x86/kernel/Makefile                |   2 +-
 arch/x86/kernel/head64.c                | 103 +++-
 arch/x86/kernel/head_64.S               |   6 +-
 arch/x86/kernel/probe_roms.c            |  13 +-
 arch/x86/kernel/setup.c                 |   3 +
 arch/x86/kernel/sev-internal.h          |  12 +
 arch/x86/kernel/sev-shared.c            | 628 +++++++++++++++++++--
 arch/x86/kernel/sev.c                   | 720 +++++++++++++++++++++++-
 arch/x86/kernel/smpboot.c               |   5 +
 arch/x86/kvm/cpuid.c                    |  17 +-
 arch/x86/kvm/svm/sev.c                  |  24 +-
 arch/x86/kvm/svm/svm.c                  |   4 +-
 arch/x86/kvm/svm/svm.h                  |   2 +-
 arch/x86/mm/mem_encrypt.c               |  65 ++-
 arch/x86/mm/pat/set_memory.c            |  15 +
 drivers/virt/Kconfig                    |   3 +
 drivers/virt/Makefile                   |   1 +
 drivers/virt/coco/sevguest/Kconfig      |   9 +
 drivers/virt/coco/sevguest/Makefile     |   2 +
 drivers/virt/coco/sevguest/sevguest.c   | 622 ++++++++++++++++++++
 drivers/virt/coco/sevguest/sevguest.h   |  63 +++
 include/linux/efi.h                     |   1 +
 include/linux/sev-guest.h               |  90 +++
 include/uapi/linux/sev-guest.h          |  81 +++
 44 files changed, 3287 insertions(+), 247 deletions(-)
 create mode 100644 Documentation/virt/coco/sevguest.rst
 create mode 100644 arch/x86/boot/compressed/efi.c
 create mode 100644 arch/x86/include/asm/cpuid.h
 create mode 100644 arch/x86/kernel/sev-internal.h
 create mode 100644 drivers/virt/coco/sevguest/Kconfig
 create mode 100644 drivers/virt/coco/sevguest/Makefile
 create mode 100644 drivers/virt/coco/sevguest/sevguest.c
 create mode 100644 drivers/virt/coco/sevguest/sevguest.h
 create mode 100644 include/linux/sev-guest.h
 create mode 100644 include/uapi/linux/sev-guest.h

-- 
2.17.1

