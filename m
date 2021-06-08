Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDBB39FE92
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 20:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhFHSH4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 14:07:56 -0400
Received: from mail-bn8nam12on2043.outbound.protection.outlook.com ([40.107.237.43]:12544
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232461AbhFHSHt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Jun 2021 14:07:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNXHzXY6+29IBP4MwAet8tzQfAaMIN+x8OgE5ND5zcgBOXSzAwD3IKFPTiEARcowLNtgVyIF1HPeJZJHYvJkB+8fPFY/hUVeuMq3HNQLRwybm+6d2KbofDpk5fy114ADcRqFSQ/lckoAPlwzzHfBE7DrDMFswZxrX2LwfbXIzJbZ/lxEB2l9liaUqDMbXmrMsE0rWGUdyd38JmvMklJ5R4mA2RIr72P4M5UyUgy5A8gXfGyWz+m3F4QEi6uvCh+08lBxIRFtTmIXunqzEZalkqlefmLrtQw5btshrFqR64XcR/9JUZOlSR+nR4STgtUlE3y97cZ910C7/ZSb6hyv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9DMx7yo7+oDg4SeCgH+wtAlhFopEjAswcNpItO+Njk=;
 b=XllHWPvUkMP2Y9OQ/G76WGzoGFmX6c/zf8ZrPk/rv6oKnefNRadvWVyBngs1QrUTLc5HH5fg1U7pGKnmkXMI2eQshOYLruW8xi1hRT+4FJdFGVjvlyPe7W68NSXiZSpEZPNISGKdgmni1B8wMAvfKA6cfULuAV9Xv5FdRF4flRDkcq13y8Y0a4oxlQfO5qJ40Jw2SXeyYb1lZUXsTPnq07vSk+qI4BjBFO1WJchVseSnXZp4kgaEeJS9weTzHjU2YXR3YU0OWQIV2bGt6Qj1NoQEODyprSCt/bVQw9H//DM4QI+bJLxo/T/rv7eYMtI9mfYysrWmb93tUhAx8gqhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9DMx7yo7+oDg4SeCgH+wtAlhFopEjAswcNpItO+Njk=;
 b=E4STk0QT0WjEEnLveWyaqxRLMnxsjn7mOb2fgCfLpmVHkHpo41fBTQK3e7cK3pWyrBIUGc7OIoWy+QN0AHDDYnkSdzkCj8/3yT7yPXnHgjw7wl/7zHNcBePdNEhh3iYKqSay9QgvhR2JNzkYG+nEL0UY6mBMP8WK53D4zjohBjY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2759.namprd12.prod.outlook.com (2603:10b6:a03:61::32)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 18:05:54 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::ed9c:d6cf:531c:731a]) by BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::ed9c:d6cf:531c:731a%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 18:05:54 +0000
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     pbonzini@redhat.com
Cc:     seanjc@google.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, linux-efi@vger.kernel.org
Subject: [PATCH v3 1/5] KVM: X86: Introduce KVM_HC_MAP_GPA_RANGE hypercall
Date:   Tue,  8 Jun 2021 18:05:43 +0000
Message-Id: <90778988e1ee01926ff9cac447aacb745f954c8c.1623174621.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1623174621.git.ashish.kalra@amd.com>
References: <cover.1623174621.git.ashish.kalra@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:806:d2::22) To BYAPR12MB2759.namprd12.prod.outlook.com
 (2603:10b6:a03:61::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by SA0PR11CA0077.namprd11.prod.outlook.com (2603:10b6:806:d2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Tue, 8 Jun 2021 18:05:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7becc568-c572-4c50-92e5-08d92aa80e97
X-MS-TrafficTypeDiagnostic: BY5PR12MB4321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB43214956CC30980DA62E13588E379@BY5PR12MB4321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8kPJxRbunAzfFGuEY2G8hhyDGRQZC6PD3R2Kvr58pLUwIHmdOz4AO7FjWH2jelZLzEsAydJTjN8JEawiZlCIJqXH/yR6mvKFFwSEAtSTpc5anjOl9FjWE5Kem8LqjlRNZ2okREH/XfFWz/J7z8kO9TQThin1Q9D2PvJ6qUvPzK8VnsB8Djl0MH+U38DWOQe+snC4ykJU2YzRQIVU1mRryXf/9L5kjjShUAoi88BjxbjAgFAdXVrEcDMqwBkY2eRPEtPmE6D29zOU2qb5ojw3zeb8NOenUujmEB+8w65nTKYJUz8qCnFcEH3gKyGDw+OyWWgTGtLPwZjr5jcE8tuxPQrJIKAkMrQHx78Of3bSBIZE1Zh755224SR3dKy0lDTLwBIncNxi/W2Ji/GwCzHWRuF1uamo+ZVJ9Kko5ZekZCcoKoLMtR5HHbSjJscQUdmby+aPg9TQMTCMWyclB7HDbxKxb1RBJyLayo7BOmAi6+4g85ArXbt8H9i+4/7pd8dZ6inslreDsPgKCYDIng1SRwBzRnX94zj5ghB+788u7hoDivEPnpSAwOE20199eghQkBSykUc6PomwVm+p2mvjAUjF7pwpW1phBMCiS0iIioUhnLc5Lv6bSie5NOtdYSUSx03oSpDG5f6HT2hfU833A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2759.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(66476007)(5660300002)(66556008)(38350700002)(956004)(38100700002)(2906002)(2616005)(66946007)(8936002)(36756003)(7696005)(7416002)(186003)(16526019)(6916009)(30864003)(86362001)(6666004)(316002)(6486002)(478600001)(26005)(83380400001)(4326008)(52116002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6M0jXS2bS8oEXI7dSBSG22Uugt6NME98TSxThNUDLaLjv8IX6Vw3wlvmzNQx?=
 =?us-ascii?Q?EggijGEVSDMfzPJQpxhfevdmf1T0NzMb4KHiPf1smVELEOOyGk9EcTudwwd5?=
 =?us-ascii?Q?RtG65rtRhSga8wPts+iFr5KeDLVw8gB4e1yd4wTpm21HMW6MLtnUTB5MNiiS?=
 =?us-ascii?Q?H9f0m+ffjRcMDxzB9jENsT+JqonpbKq8nnY+lRdsyXQ7S7/qOJcW1qr3NA+u?=
 =?us-ascii?Q?gakxXfPnKhPHzc35OImP0aaYBu+vSdZZtHS/GXjKvE+PTvAk1V0mNrQOFrh+?=
 =?us-ascii?Q?Jc0YSj491BKfDsUUfT5u4F+djMhSkval+T0+yhiXpkL7zzJGu9isU/jise94?=
 =?us-ascii?Q?Su050f0HoKUUgnToiQxpD8ChYzVfg5DHCOPqALYt7ewES1yV1fw8e9fRGraR?=
 =?us-ascii?Q?+EpBrWPrOEt76NDwkN6XObZJhSyY2/vMB/E0HKbiFr7mUDz/R1A2hmBBviGZ?=
 =?us-ascii?Q?qYjnJ/M5w166PLOFtEoVZZJxYExqe1avzClIzWTQfEbrFfnthA0H7eCaMQJS?=
 =?us-ascii?Q?O5HBebKuoSzW/VVqvzZfYUuakQ8Yzz2tKaPH8FKPgmYsOZulkPAqS8Op5kNC?=
 =?us-ascii?Q?pGtac47KseeurXvzY08UbrL0I8yKz12doaWpNxQtSBTtpWGgu/b7ETkSFlKL?=
 =?us-ascii?Q?Jf5CWSHIWCrHWRVxF6PTrDbpkUtI9Hfa8uXLSSL//5ZY6Km8J0zDMCgVKTjJ?=
 =?us-ascii?Q?xZQAcFkXhx/u+U1RkSFtOe6r9HVUEHcT68jcybvypDW+Gj5VFeI6qBaXzxFe?=
 =?us-ascii?Q?2RIxYXYK4+7CyrLKW7tl9AQxaLASS2i7hyMG9d1empdddtD6yB0Lt1xH5MxH?=
 =?us-ascii?Q?zRzX4M5YSmncey9EeuYiekR2MJH5UdHPgvpGBJoM+9NRZtnpcKiFcdFpnLbG?=
 =?us-ascii?Q?+M3yHbf0qUgDDwFYQtEVENA/Mc7UspG9P8yL/w30S7FN3pn7dmmF7hEIXn5d?=
 =?us-ascii?Q?ewLtWCIdsQneTALWwpiyQgACNrBdFJMXscw8IhVPdLCMX9P6E2QaZ8f7NEvv?=
 =?us-ascii?Q?P/FARgF1+N5Yn+Edcy4EAPj7j0ImFm+4A96xwH6oMELYPIHz5n4rOK+FWjzY?=
 =?us-ascii?Q?9thyml92uDuYppHQkzLvjRrX/yfnOSPSy2U5jr8wkYXO0ae3/rIVsGU8QRv+?=
 =?us-ascii?Q?YIx1AbJE2JCOKTW+/vCxtyhD7V9TB2iy5+ns6gPCYQ0TV+lOiA9ZfaPiZOTu?=
 =?us-ascii?Q?Cj8xNc9KgoL1eRGJYtBbgSPxd4lsq8lCf+d4JQqcFfsYdoMFpZhzNDXMjW65?=
 =?us-ascii?Q?ekbMQ91oLQ1KYhx/b8Sx1k0QgTsLr/iLHYqT5QpllHUAwsapfQ6vA+S75lXa?=
 =?us-ascii?Q?cQ04TELMkqH0qLdYncxCwIJc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7becc568-c572-4c50-92e5-08d92aa80e97
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 18:05:53.9711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHH4saVn+IWpqTJuAzzDxovWFcGmEIkSSxJrHHrj2lvLqg4VS0gqyNKLtvJvsbmXw2gAYS7c15/z+aDW9Opgiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

This hypercall is used by the SEV guest to notify a change in the page
encryption status to the hypervisor. The hypercall should be invoked
only when the encryption attribute is changed from encrypted -> decrypted
and vice versa. By default all guest pages are considered encrypted.

The hypercall exits to userspace to manage the guest shared regions and
integrate with the userspace VMM's migration code.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Steve Rutherford <srutherford@google.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst        | 19 +++++++++++
 Documentation/virt/kvm/cpuid.rst      |  7 ++++
 Documentation/virt/kvm/hypercalls.rst | 21 ++++++++++++
 Documentation/virt/kvm/msr.rst        | 13 ++++++++
 arch/x86/include/asm/kvm_host.h       |  2 ++
 arch/x86/include/uapi/asm/kvm_para.h  | 13 ++++++++
 arch/x86/kvm/x86.c                    | 46 +++++++++++++++++++++++++++
 include/uapi/linux/kvm.h              |  1 +
 include/uapi/linux/kvm_para.h         |  1 +
 9 files changed, 123 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 7fcb2fd38f42..6396ce8bfa44 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6891,3 +6891,22 @@ This capability is always enabled.
 This capability indicates that the KVM virtual PTP service is
 supported in the host. A VMM can check whether the service is
 available to the guest on migration.
+
+8.33 KVM_CAP_EXIT_HYPERCALL
+---------------------------
+
+:Capability: KVM_CAP_EXIT_HYPERCALL
+:Architectures: x86
+:Type: vm
+
+This capability, if enabled, will cause KVM to exit to userspace
+with KVM_EXIT_HYPERCALL exit reason to process some hypercalls.
+
+Calling KVM_CHECK_EXTENSION for this capability will return a bitmask
+of hypercalls that can be configured to exit to userspace.
+Right now, the only such hypercall is KVM_HC_MAP_GPA_RANGE.
+
+The argument to KVM_ENABLE_CAP is also a bitmask, and must be a subset
+of the result of KVM_CHECK_EXTENSION.  KVM will forward to userspace
+the hypercalls whose corresponding bit is in the argument, and return
+ENOSYS for the others.
diff --git a/Documentation/virt/kvm/cpuid.rst b/Documentation/virt/kvm/cpuid.rst
index cf62162d4be2..bda3e3e737d7 100644
--- a/Documentation/virt/kvm/cpuid.rst
+++ b/Documentation/virt/kvm/cpuid.rst
@@ -96,6 +96,13 @@ KVM_FEATURE_MSI_EXT_DEST_ID        15          guest checks this feature bit
                                                before using extended destination
                                                ID bits in MSI address bits 11-5.
 
+KVM_FEATURE_HC_MAP_GPA_RANGE       16          guest checks this feature bit before
+                                               using the map gpa range hypercall
+                                               to notify the page state change
+
+KVM_FEATURE_MIGRATION_CONTROL      17          guest checks this feature bit before
+                                               using MSR_KVM_MIGRATION_CONTROL
+
 KVM_FEATURE_CLOCKSOURCE_STABLE_BIT 24          host will warn if no guest-side
                                                per-cpu warps are expected in
                                                kvmclock
diff --git a/Documentation/virt/kvm/hypercalls.rst b/Documentation/virt/kvm/hypercalls.rst
index ed4fddd364ea..e56fa8b9cfca 100644
--- a/Documentation/virt/kvm/hypercalls.rst
+++ b/Documentation/virt/kvm/hypercalls.rst
@@ -169,3 +169,24 @@ a0: destination APIC ID
 
 :Usage example: When sending a call-function IPI-many to vCPUs, yield if
 	        any of the IPI target vCPUs was preempted.
+
+8. KVM_HC_MAP_GPA_RANGE
+-------------------------
+:Architecture: x86
+:Status: active
+:Purpose: Request KVM to map a GPA range with the specified attributes.
+
+a0: the guest physical address of the start page
+a1: the number of (4kb) pages (must be contiguous in GPA space)
+a2: attributes
+
+    Where 'attributes' :
+        * bits  3:0 - preferred page size encoding 0 = 4kb, 1 = 2mb, 2 = 1gb, etc...
+        * bit     4 - plaintext = 0, encrypted = 1
+        * bits 63:5 - reserved (must be zero)
+
+**Implementation note**: this hypercall is implemented in userspace via
+the KVM_CAP_EXIT_HYPERCALL capability. Userspace must enable that capability
+before advertising KVM_FEATURE_HC_MAP_GPA_RANGE in the guest CPUID.  In
+addition, if the guest supports KVM_FEATURE_MIGRATION_CONTROL, userspace
+must also set up an MSR filter to process writes to MSR_KVM_MIGRATION_CONTROL.
diff --git a/Documentation/virt/kvm/msr.rst b/Documentation/virt/kvm/msr.rst
index e37a14c323d2..9315fc385fb0 100644
--- a/Documentation/virt/kvm/msr.rst
+++ b/Documentation/virt/kvm/msr.rst
@@ -376,3 +376,16 @@ data:
 	write '1' to bit 0 of the MSR, this causes the host to re-scan its queue
 	and check if there are more notifications pending. The MSR is available
 	if KVM_FEATURE_ASYNC_PF_INT is present in CPUID.
+
+MSR_KVM_MIGRATION_CONTROL:
+        0x4b564d08
+
+data:
+        This MSR is available if KVM_FEATURE_MIGRATION_CONTROL is present in
+        CPUID.  Bit 0 represents whether live migration of the guest is allowed.
+
+        When a guest is started, bit 0 will be 0 if the guest has encrypted
+        memory and 1 if the guest does not have encrypted memory.  If the
+        guest is communicating page encryption status to the host using the
+        ``KVM_HC_MAP_GPA_RANGE`` hypercall, it can set bit 0 in this MSR to
+        allow live migration of the guest.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55efbacfc244..5b9bc8b3db20 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1067,6 +1067,8 @@ struct kvm_arch {
 	u32 user_space_msr_mask;
 	struct kvm_x86_msr_filter __rcu *msr_filter;
 
+	u32 hypercall_exit_enabled;
+
 	/* Guest can access the SGX PROVISIONKEY. */
 	bool sgx_provisioning_allowed;
 
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 950afebfba88..5146bbab84d4 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -33,6 +33,8 @@
 #define KVM_FEATURE_PV_SCHED_YIELD	13
 #define KVM_FEATURE_ASYNC_PF_INT	14
 #define KVM_FEATURE_MSI_EXT_DEST_ID	15
+#define KVM_FEATURE_HC_MAP_GPA_RANGE	16
+#define KVM_FEATURE_MIGRATION_CONTROL	17
 
 #define KVM_HINTS_REALTIME      0
 
@@ -54,6 +56,7 @@
 #define MSR_KVM_POLL_CONTROL	0x4b564d05
 #define MSR_KVM_ASYNC_PF_INT	0x4b564d06
 #define MSR_KVM_ASYNC_PF_ACK	0x4b564d07
+#define MSR_KVM_MIGRATION_CONTROL	0x4b564d08
 
 struct kvm_steal_time {
 	__u64 steal;
@@ -90,6 +93,16 @@ struct kvm_clock_pairing {
 /* MSR_KVM_ASYNC_PF_INT */
 #define KVM_ASYNC_PF_VEC_MASK			GENMASK(7, 0)
 
+/* MSR_KVM_MIGRATION_CONTROL */
+#define KVM_MIGRATION_READY		(1 << 0)
+
+/* KVM_HC_MAP_GPA_RANGE */
+#define KVM_MAP_GPA_RANGE_PAGE_SZ_4K	0
+#define KVM_MAP_GPA_RANGE_PAGE_SZ_2M	(1 << 0)
+#define KVM_MAP_GPA_RANGE_PAGE_SZ_1G	(1 << 1)
+#define KVM_MAP_GPA_RANGE_ENC_STAT(n)	(n << 4)
+#define KVM_MAP_GPA_RANGE_ENCRYPTED	KVM_MAP_GPA_RANGE_ENC_STAT(1)
+#define KVM_MAP_GPA_RANGE_DECRYPTED	KVM_MAP_GPA_RANGE_ENC_STAT(0)
 
 /* Operations for KVM_HC_MMU_OP */
 #define KVM_MMU_OP_WRITE_PTE            1
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9b6bca616929..6686d99b1d7b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -102,6 +102,8 @@ static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
 
 static u64 __read_mostly cr4_reserved_bits = CR4_RESERVED_BITS;
 
+#define KVM_EXIT_HYPERCALL_VALID_MASK (1 << KVM_HC_MAP_GPA_RANGE)
+
 #define KVM_X2APIC_API_VALID_FLAGS (KVM_X2APIC_API_USE_32BIT_IDS | \
                                     KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK)
 
@@ -3894,6 +3896,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_VM_COPY_ENC_CONTEXT_FROM:
 		r = 1;
 		break;
+	case KVM_CAP_EXIT_HYPERCALL:
+		r = KVM_EXIT_HYPERCALL_VALID_MASK;
+		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
 		return KVM_GUESTDBG_VALID_MASK;
 #ifdef CONFIG_KVM_XEN
@@ -5499,6 +5504,14 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if (kvm_x86_ops.vm_copy_enc_context_from)
 			r = kvm_x86_ops.vm_copy_enc_context_from(kvm, cap->args[0]);
 		return r;
+	case KVM_CAP_EXIT_HYPERCALL:
+		if (cap->args[0] & ~KVM_EXIT_HYPERCALL_VALID_MASK) {
+			r = -EINVAL;
+			break;
+		}
+		kvm->arch.hypercall_exit_enabled = cap->args[0];
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -8384,6 +8397,17 @@ static void kvm_sched_yield(struct kvm_vcpu *vcpu, unsigned long dest_id)
 	return;
 }
 
+static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
+{
+	u64 ret = vcpu->run->hypercall.ret;
+
+	if (!is_64_bit_mode(vcpu))
+		ret = (u32)ret;
+	kvm_rax_write(vcpu, ret);
+	++vcpu->stat.hypercalls;
+	return kvm_skip_emulated_instruction(vcpu);
+}
+
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 {
 	unsigned long nr, a0, a1, a2, a3, ret;
@@ -8449,6 +8473,28 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 		kvm_sched_yield(vcpu, a0);
 		ret = 0;
 		break;
+	case KVM_HC_MAP_GPA_RANGE: {
+		u64 gpa = a0, npages = a1, attrs = a2;
+
+		ret = -KVM_ENOSYS;
+		if (!(vcpu->kvm->arch.hypercall_exit_enabled & (1 << KVM_HC_MAP_GPA_RANGE)))
+			break;
+
+		if (!PAGE_ALIGNED(gpa) || !npages ||
+		    gpa_to_gfn(gpa) + npages <= gpa_to_gfn(gpa)) {
+			ret = -KVM_EINVAL;
+			break;
+		}
+
+		vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
+		vcpu->run->hypercall.nr       = KVM_HC_MAP_GPA_RANGE;
+		vcpu->run->hypercall.args[0]  = gpa;
+		vcpu->run->hypercall.args[1]  = npages;
+		vcpu->run->hypercall.args[2]  = attrs;
+		vcpu->run->hypercall.longmode = op_64_bit;
+		vcpu->arch.complete_userspace_io = complete_hypercall_exit;
+		return 0;
+	}
 	default:
 		ret = -KVM_ENOSYS;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 3fd9a7e9d90c..1fb4fd863324 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1082,6 +1082,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_SGX_ATTRIBUTE 196
 #define KVM_CAP_VM_COPY_ENC_CONTEXT_FROM 197
 #define KVM_CAP_PTP_KVM 198
+#define KVM_CAP_EXIT_HYPERCALL 199
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index 8b86609849b9..960c7e93d1a9 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -29,6 +29,7 @@
 #define KVM_HC_CLOCK_PAIRING		9
 #define KVM_HC_SEND_IPI		10
 #define KVM_HC_SCHED_YIELD		11
+#define KVM_HC_MAP_GPA_RANGE		12
 
 /*
  * hypercalls use architecture specific
-- 
2.17.1

