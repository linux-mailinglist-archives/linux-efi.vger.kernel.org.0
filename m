Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14F33BEDC9
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhGGSSP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:18:15 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:62945
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231196AbhGGSSL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sne/WWUHjSR3z0lPqJoDMyUGtC2MjggsStlJ2SgvoAy9PQjSC8fgMwY7tb3y7Q6SMZ9xAgEX42/T1rnqstDDjiVqhfSSr97YfrLZnKvu4gEeEVJgG1gAxiNI8o0JcOO03Jbi9HC3nunD7vd85tWzpuiUAol4gQbT1fk05qZUFAQRJMQxiT/Jf+UsOykBpsdmqaK1fy22zWOEvGx1TynGYJwHWpnSSz5HgR4BKcTTuI4EyDveNooIEIYmPHwEr137v9Fo5BbelWvzax/P6fp+iCb3hb+ioUwwypmzTlvPG1+BLatRKAya6aYRfm1hLfgYyp9i3KCI2rUOwIaNWpLqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFrg4Pfqgj5kMYuGr3NuwoyePIZkPmZCc+GPXuVdkdU=;
 b=oJYBvy4JixDAMYfvnE0xyN6bE1MjHDZYAXIW1tat5duMlN7kFf/Houhyhki+1xQqu8Xra8DbjCylX/spmPhA9XFCUX1DvYaIs5OprGCIdckqx3HAF9gu/lpFRtn5Wbty3nOKbV7dysvAQagO/DcWjHC8xX3Se5Nj+IemO64OmySjXDIhFuFzZjJu6H4AwqG89qC4yVwq2EvMJWBzp+al3QhlOchu8d+Fmz0Tqt3SxeYroNxgwco6l8lHicEJ8zO+LIszz81nU1Qb1emX/+oZJrYwpTb+ykETExkWuJLtmjLrkr3I0pFr73pPUBPl1s6QvPOdhwrewzT/aNokhwLK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFrg4Pfqgj5kMYuGr3NuwoyePIZkPmZCc+GPXuVdkdU=;
 b=1TdKoGZAH5Sy2glo1s3Jk8mK70Su00gAsDKPKa5/d6vz8IvWX2hA8qneJcJW+9fLQad7+vgyrLFkrkp3iRo6mOxrBYrsHEiyGbjssE01pKe0V8PvJebs1NBbWaD/XwK+eKZn7gosA0rnwBXdStxdQrLSJuYcnCicLY6SRc6rrVI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3939.namprd12.prod.outlook.com (2603:10b6:a03:1a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:15:26 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:26 +0000
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
Subject: [PATCH Part1 RFC v4 00/36] Add AMD Secure Nested Paging (SEV-SNP) Guest Support
Date:   Wed,  7 Jul 2021 13:14:30 -0500
Message-Id: <20210707181506.30489-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 874eec20-c674-4e93-d7c3-08d941733170
X-MS-TrafficTypeDiagnostic: BY5PR12MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3939907124D2B9311A1EBB43E51A9@BY5PR12MB3939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6hdruh8twro+N/56EBGijvkAUaKt/EEAWIBAtt4+5gpoK9HIBIFnn0eZjm0RwPIZKZm1O2HWPepyIUAQUROT8UHnkQi+MnSsXMC5FNEwRKA9uW0JwP9c/XIZWNnt72z3E8UfMltbgnaxthxQrg1k6q6dL7ngl8Xt55H8n/rNMebYYXffZpO/Ad/nqvTbY10ITOfgBE9e/ViqVOUgcJisqvcsHePSO00x/z/L8W3C4qTvrArtBORwCziKZL7uIqC1YNK8FAxrwuMGy/Oac3e0Ub44J7gR+VyFig1Cb7fOzzY25o8U4oWqHrKfJe2Y9ZUFgZ8p8Wnfa95U0CFPk22b0/Kf2MOze3MTP2swJiSao9cTgXid53bgyZLiysdWvDPxDfWp3B0P691KIqSHn0jGTpfmEo5g2YNNcWgm/usBXlWT6GbUH6KHLpZ39Wn1osa0QuRk8Pm+tk8fTT9FhKrsXzoaQ4xQDxem+oU3Li8dT+VLwCbyjItrLhaqp3VK2+hFxLdEMPSePcpp2OZptGiTDo+HltRDySxLSrTseOVObh65XelKZmceUoK84og7l73tJVGsk9S1pHZ0TpAc52941DZbPZmzeB7vXjTHMg7ZKX2zi2LAEZV+BimxG0/JdxjASNo79XxxE36MkfsuxwJKkRAumvjpw5XZm5q/DfzDCwk9kyP16GS6lSpdwk9MLVaDwVf4tLlbCamMkP/wzRlTlI6GhgeJzqd8+pRqer3NyJnofzwWYBtk9JZ06Mvv7ZcDMWOZrxWYt/YgRqkg5oiM+EWIzQU5GrHpfHDU33Qpbg5AquYb5SqhpDmLuuYo7N13wHOPBRb83HT4YVaT3Yj/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(44832011)(966005)(66556008)(38100700002)(38350700002)(66946007)(186003)(66476007)(2906002)(1076003)(26005)(52116002)(8936002)(2616005)(6486002)(7696005)(6666004)(5660300002)(8676002)(956004)(7406005)(7416002)(478600001)(83380400001)(316002)(54906003)(86362001)(36756003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejA4Nlg5UjdMa0VtM09qZkJ2T01SZDhTb2hsV25WbElEMHNvOWpuT0toejRC?=
 =?utf-8?B?cEQ3ZUREbVJGT29FdDNUNkFFMHRURXFnSGhwQ0duOXovNnVabjdHVzA4SUlh?=
 =?utf-8?B?a0VIR2hiVmRWaS9JZ2RrTEx1V0NKUFZ1d3lRbFNSK2UzWkkyS2I1a3J1cVZK?=
 =?utf-8?B?NndsdjFtNkRudWJaYzV0K3ZpVjBuVmpyYmtxcnlkeVl3VEV6a1ZyWmRlVmJw?=
 =?utf-8?B?VmtISGdUTkdTRW1pOHk0dEJ6Y1BScGVCRVBXK0plc3BQUnpVenM2Q25FbTQr?=
 =?utf-8?B?a0VyZjVEcWVRMWh5WDllZGE4U1A3cmtXR1V3bXk1Qkt0NWhvTEhKei9yWDRQ?=
 =?utf-8?B?WSs3Y1pGZ1U2bVB6STY4c2E0OW9HOWNZVi9zb0l6TUNMM0FFYUZJNTNmbW5I?=
 =?utf-8?B?cHRFblgxL2xCZ0R1OVlub3VvT1RMVW9wQXhIaGdnbitybDcyTEFUSXFMRWtj?=
 =?utf-8?B?cGlzVE5HWXZiZUFhRGlIcUtIbnFMN3hNVGtOdHUrY0FKbWVmU1NNMVoxNlFP?=
 =?utf-8?B?cHVKbjJvaElWeVY3NlgxNHFJVnZMZXBVWVkrSXJBM1RqOXE5cHhETHZENWZY?=
 =?utf-8?B?TnRpUG9YQUQvM2E4YXgzV0VjZlRWWkM3d1crSjZIYXhNN0JyeVJsOVB3QjZa?=
 =?utf-8?B?Zkc0TUNjZ0NwQTFwUGFIS0lFSVU4MmhmNUtGR0J6VTJZNEcwTzcyYXVsRG9y?=
 =?utf-8?B?SjZ4WldTMXdRZTFCOStmaUJNcVZqVVJuVEdoNjZWRWNzOThDMWhIOG1QS1A0?=
 =?utf-8?B?a1VGVzQ0Q2UzdVcwU3RyZUc0cUZidVlEdHQvbE9NcW1aU1JjdmFTV3hvVDNY?=
 =?utf-8?B?Qk54anNRZFJ0aTF1OE5WczRoUjAva3VjWEU2S2VOalRCbE13eC81cEdoWDd5?=
 =?utf-8?B?TUlINnJMNEdFUzhjSlBxc3dJWE9SVExQdXFBRG9ZUGZKVTYvNGVVbnZuVVdD?=
 =?utf-8?B?MTc1RzBueFJlOHBLTERFSWNRaFpVVTJuUHVWQWJBRXFXRUt2Q2cybXJnSkJx?=
 =?utf-8?B?dzQzem1TUitnL1BOQ0FkSWxrS3ZlVTNpdWQ3bTd2VGdPbTlSakNiakU2b1R2?=
 =?utf-8?B?VWY3NFVhaWwwalNrL2xZM3pTbFkxL3hmdlF6OGUzY2Q2cVRqZnhVeXZ4MTFK?=
 =?utf-8?B?dTltSHNQZ2QyNVRjUDZpdmhoVDhvYmxnMk8xVmN3ZjNkY0JlMktEaVNyS3F6?=
 =?utf-8?B?K1h1ZWRTZ2pQc2ZURkxKNWJvMlo3ZVB2WXBEOEJRYjJJdlo1S3d3N1phaFM1?=
 =?utf-8?B?ZHZ5dmVyMktHS25UdXBDTjlSUnlqaDBiQ0Z3Y0RSMU9ZdjJRdkJLYWU1MnBR?=
 =?utf-8?B?MmlMbmpYK1dFV2o3YjlWaEE2cHZYanRqQU1CRjBGMGdUckNvVzdTNGNqRXBt?=
 =?utf-8?B?Um1PTDlodExqL3pheVk4ZnpNM3EycWxwU05TcGo3dUxhbzhtdFJjcVlOcnZG?=
 =?utf-8?B?OEx4anU1K2hWbVZ4d2RBQUN1ZWdQd2EvVklQRDhWUFo5a0lvTEZLdllOTE5a?=
 =?utf-8?B?TTQ3bGZndnBiNlQ2WXJQUkZwQnlLVWdBNnpkd1lsYkpJb2szcUYvSXdvTEkx?=
 =?utf-8?B?K05RSWwzeDNEQzdZWExhT0g2MkppdE1zcVVVa2c0V29nSHBpSHFOQVNvWUda?=
 =?utf-8?B?R0RqVkx1T2R6MitEcGhhZlo3VzNJZlNjVnhXb0VHSGNhcGpoTFAvNlMvQ1Nx?=
 =?utf-8?B?YS93WDBjWnhZQVk4SkdnSHlwN1FHZUNEQmFYT2tKcTNjTHNYN09WOWdNRFM3?=
 =?utf-8?Q?rMwPQ5soXpf7fUrf5iqatCmKzmiMoP1hSl1th9a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874eec20-c674-4e93-d7c3-08d941733170
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:25.9517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uOQov26PZsz26t+SJ5dodJEVWEQA4epiWOLno/kW418yuprmbQOOjRqPBFvU+4E4C6LNiZHXid7kOAqzzirlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3939
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

* Lazy validation
* Interrupt security

The series is based on tip/master
  e53fbd0a2509 (origin/master) Merge branch 'core/urgent'

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

Brijesh Singh (23):
  x86/sev: shorten GHCB terminate macro names
  x86/sev: Save the negotiated GHCB version
  x86/sev: Add support for hypervisor feature VMGEXIT
  x86/mm: Add sev_feature_enabled() helper
  x86/sev: Define the Linux specific guest termination reasons
  x86/sev: check SEV-SNP features support
  x86/sev: Add a helper for the PVALIDATE instruction
  x86/sev: check the vmpl level
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

 Documentation/virt/coco/sevguest.rst        | 109 +++
 arch/x86/boot/compressed/Makefile           |   1 +
 arch/x86/boot/compressed/acpi.c             | 124 ++--
 arch/x86/boot/compressed/efi-config-table.c | 224 ++++++
 arch/x86/boot/compressed/head_64.S          |   1 +
 arch/x86/boot/compressed/ident_map_64.c     |  35 +-
 arch/x86/boot/compressed/idt_64.c           |   7 +-
 arch/x86/boot/compressed/misc.h             |  66 ++
 arch/x86/boot/compressed/sev.c              | 115 +++-
 arch/x86/include/asm/bootparam_utils.h      |   1 +
 arch/x86/include/asm/cpuid-indexed.h        |  26 +
 arch/x86/include/asm/mem_encrypt.h          |  10 +
 arch/x86/include/asm/msr-index.h            |   2 +
 arch/x86/include/asm/realmode.h             |   1 +
 arch/x86/include/asm/setup.h                |   5 +-
 arch/x86/include/asm/sev-common.h           |  80 ++-
 arch/x86/include/asm/sev.h                  |  79 ++-
 arch/x86/include/asm/svm.h                  | 176 ++++-
 arch/x86/include/uapi/asm/bootparam.h       |   4 +-
 arch/x86/include/uapi/asm/svm.h             |  13 +
 arch/x86/kernel/head64.c                    |  46 +-
 arch/x86/kernel/head_64.S                   |   6 +-
 arch/x86/kernel/probe_roms.c                |  13 +-
 arch/x86/kernel/setup.c                     |   3 +
 arch/x86/kernel/sev-internal.h              |  12 +
 arch/x86/kernel/sev-shared.c                | 572 +++++++++++++++-
 arch/x86/kernel/sev.c                       | 716 +++++++++++++++++++-
 arch/x86/kernel/smpboot.c                   |   5 +
 arch/x86/kvm/cpuid.c                        |  17 +-
 arch/x86/kvm/svm/sev.c                      |  24 +-
 arch/x86/kvm/svm/svm.c                      |   4 +-
 arch/x86/kvm/svm/svm.h                      |   2 +-
 arch/x86/mm/mem_encrypt.c                   |  65 +-
 arch/x86/mm/pat/set_memory.c                |  15 +
 drivers/virt/Kconfig                        |   3 +
 drivers/virt/Makefile                       |   1 +
 drivers/virt/coco/sevguest/Kconfig          |   9 +
 drivers/virt/coco/sevguest/Makefile         |   2 +
 drivers/virt/coco/sevguest/sevguest.c       | 623 +++++++++++++++++
 drivers/virt/coco/sevguest/sevguest.h       |  63 ++
 include/linux/efi.h                         |   1 +
 include/linux/sev-guest.h                   |  90 +++
 include/uapi/linux/sev-guest.h              |  81 +++
 43 files changed, 3253 insertions(+), 199 deletions(-)
 create mode 100644 Documentation/virt/coco/sevguest.rst
 create mode 100644 arch/x86/boot/compressed/efi-config-table.c
 create mode 100644 arch/x86/include/asm/cpuid-indexed.h
 create mode 100644 arch/x86/kernel/sev-internal.h
 create mode 100644 drivers/virt/coco/sevguest/Kconfig
 create mode 100644 drivers/virt/coco/sevguest/Makefile
 create mode 100644 drivers/virt/coco/sevguest/sevguest.c
 create mode 100644 drivers/virt/coco/sevguest/sevguest.h
 create mode 100644 include/linux/sev-guest.h
 create mode 100644 include/uapi/linux/sev-guest.h

-- 
2.17.1

