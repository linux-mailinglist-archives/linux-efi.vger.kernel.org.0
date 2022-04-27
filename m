Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BEC510D18
	for <lists+linux-efi@lfdr.de>; Wed, 27 Apr 2022 02:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354557AbiD0AWX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 20:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343562AbiD0AWX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 20:22:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33044B36A9;
        Tue, 26 Apr 2022 17:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWqmu87NaRiGS0tXiTnRLJPHulP4BkqNaj8HcWiPlZfHnXLTBCVeWP1Gc5MHErq5zZ2FKoJ0LobIz8Yiv4SZL58iG4u+47a7u4gth6azs2lXMlJOqEh/+H+MbHgGbJN9Mnl2JfiisSxtqBW755kBpsN7F4Gudx0+3XwiWz4S6to4UkaUy2eWf5tAAtN8TDTIYAHPxyTcHHLLcr/IxQkpZgea105NYB4ZhV/eMo12d/f6iceEJ4JHu4FXY54drWVsKasKfKUYhnFdiLxc0ymgxv58j5Dd1rOaAiye+hZrncjJ34xLJ0WG0l1aV+Zc5HHpyktiytA3qPhbcfIkzPALLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGvJkGEElOO+I7QSdBBYxqWBU7tSa2Gogm11ZKVVK8g=;
 b=LBVcuXLi0IeuFCCxBxpw/fp2k8ZYyVBW9YGnYjhYoPNejkkNgI51J6QGgLTyPwW8IHR+ngZJTymSHVeKCU9gqTXi8aCoJiNvb9ryY8Er/zzapm2pkUuwXIALTb4LeAw/RrxqIqjW97vzyNC1Bt5fFG/jvPUm1tQdbqiqzIssCXWaEXDcPGxIJ5ScWhCB5DP2h+STKGkORx59T4UrCIdE1EnOEB3lTzeFt2z0iFOi+9/vOSQazp76Ffbz56Ud8eY2gm1ziqbEXWccxvu7rLBQSY9SAGzZ4MGAzZsvX7TTjbGI4wLj423k3N4YLV8KR3gzwwA/egbxq5z4NiFmEfIDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGvJkGEElOO+I7QSdBBYxqWBU7tSa2Gogm11ZKVVK8g=;
 b=rGzGkMVraDPJaJlKDl6S/6VHjDKodcfuQ3wAFc3qfdXLYpm4MjwLrFAkUxx39/ecGH4FQKfBnrwphhki0Dy0BixI7aCyfPzSihbphrfid3dj/8zuFMHexlOlhryEDJeVP/zNRf9Jc7HXdiktOlnXOHsQmDYYO40OQm3yXtfloxE=
Received: from BN9PR03CA0803.namprd03.prod.outlook.com (2603:10b6:408:13f::28)
 by CY4PR12MB1286.namprd12.prod.outlook.com (2603:10b6:903:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 00:19:10 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::fd) by BN9PR03CA0803.outlook.office365.com
 (2603:10b6:408:13f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Wed, 27 Apr 2022 00:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 00:19:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 19:18:57 -0500
Date:   Tue, 26 Apr 2022 19:17:56 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        "Sean Christopherson" <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        "Dario Faggioli" <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        "David Hildenbrand" <david@redhat.com>, <x86@kernel.org>,
        <linux-mm@kvack.org>, <linux-coco@lists.linux.dev>,
        <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Message-ID: <20220427001756.xefhkwwc7uhxuusk@amd.com>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0154363a-a992-4b07-6188-08da27e38ceb
X-MS-TrafficTypeDiagnostic: CY4PR12MB1286:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB12867069932ACEAD37B6C0C395FA9@CY4PR12MB1286.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJvZ0FLm04FTBpyFMOmpVBaxE1pdekoK5sfZ+rGSEmKRL9VkkREO/WHsBkcvyGmsHP7bbsEy5kcJ8F6AsAusYQkuaU2NwUDmylwICl4EH9rxPPx81D77s534TrNxwx83ui0wgmZhUt4AjB9W9EKPDFbdRUOi4T2JC0EJg9OOlRG1Mllsfs6dImdUeu1BMuWvdV7WG20vxi4O7oUIQdp2BXtRMc0G+qQ6KYFkb7QSIk5DbyTazRyii77TP+RoKv2AAlP6U486NFb698OTN+3PEogtKtse65llZnutH6W2nG3H5+kiDIF+JTHAvLY0IuJg2VGFwTtoOl1n/oYIzm1tMyTWtslF7SiGQB8mZy0uC2WNkIIq5vsmyeKVaVoxnn79QMl7lYJmZMyjWMbRSJT1PIfEm3m8805Er5QhHYil3XczcWqsTYh0i5rhfHcDz2ONOXUl3IeSXJXzy8JUbtEMdE+lJLsI3Bvu0uuYHXXCHW50Gh/m32Ot1jVUodtyEBn3E/Z9ZyHUNAM8Z8W2Rh3oUFI3RhhDqUM+BU1t+i5fuS1PlmtkuynjnclMY42VWo9nyDOm5i2pD3G2XbfjlLji2p/JGL5XoPj117M3J6NovgcAW8dEwLzb3ZoaDVF7zoseN2naUjoyRTXyTwZTD7CH1kS0VkrZY+fdAOSX8KFR2IYqc2CTCW3bGBrsL5UnCZKzdyGnkKqS6EcSFeX3vT7HWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(1076003)(16526019)(44832011)(8936002)(7416002)(186003)(82310400005)(70206006)(70586007)(356005)(8676002)(4326008)(36860700001)(36756003)(47076005)(5660300002)(426003)(336012)(2616005)(316002)(81166007)(54906003)(26005)(6916009)(40460700003)(508600001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 00:19:10.0860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0154363a-a992-4b07-6188-08da27e38ceb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1286
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 25, 2022 at 06:39:28AM +0300, Kirill A. Shutemov wrote:
> The firmware will pre-accept the memory used to run the stub. But, the
> stub is responsible for accepting the memory into which it decompresses
> the main kernel. Accept memory just before decompression starts.
> 
> The stub is also responsible for choosing a physical address in which to
> place the decompressed kernel image. The KASLR mechanism will randomize
> this physical address. Since the unaccepted memory region is relatively
> small, KASLR would be quite ineffective if it only used the pre-accepted
> area (EFI_CONVENTIONAL_MEMORY). Ensure that KASLR randomizes among the
> entire physical address space by also including EFI_UNACCEPTED_MEMOR
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/boot/compressed/Makefile        |  2 +-
>  arch/x86/boot/compressed/kaslr.c         | 14 ++++++++++++--
>  arch/x86/boot/compressed/mem.c           | 21 +++++++++++++++++++++
>  arch/x86/boot/compressed/misc.c          |  9 +++++++++
>  arch/x86/include/asm/unaccepted_memory.h |  2 ++
>  5 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 7f672f7e2fea..b59007e57cbf 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -102,7 +102,7 @@ endif
>  
>  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>  vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
> -vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/mem.o
> +vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/find.o $(obj)/mem.o

Since it's possible to have CONFIG_UNACCEPTED_MEMORY=y while
CONFIG_INTEL_TDX_GUEST=n (e.g. for SNP-only guest kernels), this can
result in mem.o reporting linker errors due to tdx_accept_memory() not
being defined. I think it needs a stub for !CONFIG_INTEL_TDX_GUEST, or
something along that line.

>  
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
>  efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 411b268bc0a2..59db90626042 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -725,10 +725,20 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>  		 * but in practice there's firmware where using that memory leads
>  		 * to crashes.
>  		 *
> -		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
> +		 * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if
> +		 * supported) are guaranteed to be free.
>  		 */
> -		if (md->type != EFI_CONVENTIONAL_MEMORY)
> +
> +		switch (md->type) {
> +		case EFI_CONVENTIONAL_MEMORY:
> +			break;
> +		case EFI_UNACCEPTED_MEMORY:

Just FYI, but with latest tip boot/compressed now relies on a separate header
in arch/x86/boot/compressed/efi.h where this need to be defined again.
