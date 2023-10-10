Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA87C4202
	for <lists+linux-efi@lfdr.de>; Tue, 10 Oct 2023 23:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjJJVFr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Oct 2023 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJJVFp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Oct 2023 17:05:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE86D91;
        Tue, 10 Oct 2023 14:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWV7Dv6JscvaY0rXKp5l/U460yBOEpIGhmA8KVoy3qN5D6SQJJGbUQ6hDS/6l8/RudKwnHzs1cXXseBsVwFNT7Hv9U5dhZOqx5pC7isqUzbNO7A9kl6r+1I4xXO88L+01jfMPBVtaPs0eTFZjc7TtK4LfKxZnV1XIn3uHoJqRRfnQHcQ8Odv+E1FECL/pXDDlvtrXd31kgi8Y7cvhSIghD+efT7pFVR8bntF7MGl2v3hmfcF+lCSau2naFzLvmDWsO6+BFXyjGSZRBMFGMl97bBOwrshziNBdTbveq9z+dkoeymYjaGeWzgcIAhTtQwAZgbjKM5xQxNWME+DouPaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/GjfNg9E1yGNS8HniV9cnu4bjczyuheXhKEHCEpA9o=;
 b=YIs/QeyylHJLJZN75Xfx7ye7HGlkSNrlvhWUXdd/58Aj/1FFOvfkzzvH84Ut/wr0YmUy8OoF/4kFm6OqJi99dNXFWw6hKKYN53Oyr2bsG23YSg6dEeNotoO6No+4aKniQyF9pOOSFpDrU5SpPH5MCeuFlPaPoyi/vjPJm8bN7XMZvuoTs1EOHI8N+2G9mZHAimBJB0+DPL5g/Sx2TJBDkrwg4vRUNbLOLCio3Po1Zc/V+eas0SHy6E3W93MHvq6Y6LWRuKogPBZe5dMJgBNurfGuIs+iEilaqUHyzcL38OVkdawzIq358YibdvrOAN3oiey7hWvOI/Dpjx1PaeAZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/GjfNg9E1yGNS8HniV9cnu4bjczyuheXhKEHCEpA9o=;
 b=q/LlCunZb7G3r5WVzKZxY+aXM6NWmDaOWEzwg88BgeXq6pf9hzscQJ1BhBru1lP2DqB1EKFSfbqKHpQF/AMe/bQkF/WYJCftCiuM9b1lsyRZC9g1XroN0rt89obFci/lUbAjj0OHexCQzvkoCNYYxZMXnXvhghZw4xBSRJ3JnEM=
Received: from SJ0PR13CA0051.namprd13.prod.outlook.com (2603:10b6:a03:2c2::26)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 21:05:40 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::7b) by SJ0PR13CA0051.outlook.office365.com
 (2603:10b6:a03:2c2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Tue, 10 Oct 2023 21:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 21:05:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 16:05:39 -0500
Date:   Tue, 10 Oct 2023 16:05:18 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        <marcelo.cerri@canonical.com>, <tim.gardner@canonical.com>,
        <khalid.elmously@canonical.com>, <philip.cox@canonical.com>,
        <aarcange@redhat.com>, <peterx@redhat.com>, <x86@kernel.org>,
        <linux-mm@kvack.org>, <linux-coco@lists.linux.dev>,
        <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv14 5/9] efi: Add unaccepted memory support
Message-ID: <20231010210518.jguawj7bscwgvszv@amd.com>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a966caa-610e-4c34-9dae-08dbc9d4a8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZA85uPiaQlRmEpG3NduTiPcMpWcE49V5A5EISeOWZfZDQcgzUt74SS0SmPLE8afl1Wi3syM+oj66Yz99nETTvKP50YNshZmxBZcamJdqK6Zsm5otVCqSIpsFOjhXGrXbw0Ta4aMmgwujOuv5MPmrvJb5sp58k0Wmo3Fm2KLMFjVnemAclnB8+OfS5Vahj3bKoEF4CyndtPjyc5GsIzPG2gV0JcjDsQSr4qwxP8gWETrjhIFWvf4rS4ZPc97eqt85uQSgHt3k+3leceLTTCIc0aekLuuohB8WLBBQzxmY7qgQnbklQVw8ohy88yhv4iBkwHClEoRMFMpJa9xp4Qp2IjHGgnlokbKp3/Z0WKvSwrIfC88Kt2PNH+2lZlDBsYLELQJmlZiTPUvSRXiH10YOcNJijMw8VrjWRIqjgbcY8telYdySyXLi0av5buU1vveqfuys+PNtPlhVsca3gnXuD9AR8z2gj/SM1mfa4dnTL2Day92KaA9B4VNcxU8YLppRGjEk9uSBk6v2IDx/C0QOTq4BXgUWkplcLdtx77Vv8PVYWTz2JvMbrFlJuOHXyFLcFqYRFzDLel5dsdix6vMUDu+keX+4QlUyE5b2fD4GWYIY7EHhRBy1t+LQtXjwc4CIYN6AroSUjaNohqOU5V66G4zTYUlrmykdy9LiC9PdkkRVmhoT6+TRsMVCtmFt+vwDJsjrZG9MyHjz9A5hDpMTDzAkfni4hQAr31W3lfp74CCMFC00mgHMoL9yd92WwLGvknvaI+2VsA7pisnczxLNjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(6666004)(36756003)(40480700001)(40460700003)(45080400002)(83380400001)(336012)(426003)(26005)(16526019)(1076003)(2616005)(44832011)(41300700001)(8936002)(4326008)(8676002)(5660300002)(47076005)(7406005)(7416002)(2906002)(6916009)(54906003)(316002)(70586007)(70206006)(478600001)(82740400003)(81166007)(356005)(86362001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:05:40.3489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a966caa-610e-4c34-9dae-08dbc9d4a8c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 06, 2023 at 05:26:33PM +0300, Kirill A. Shutemov wrote:
> efi_config_parse_tables() reserves memory that holds unaccepted memory
> configuration table so it won't be reused by page allocator.
> 
> Core-mm requires few helpers to support unaccepted memory:
> 
>  - accept_memory() checks the range of addresses against the bitmap and
>    accept memory if needed.
> 
>  - range_contains_unaccepted_memory() checks if anything within the
>    range requires acceptance.
> 
> Architectural code has to provide efi_get_unaccepted_table() that
> returns pointer to the unaccepted memory configuration table.
> 
> arch_accept_memory() handles arch-specific part of memory acceptance.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/platform/efi/efi.c              |   3 +
>  drivers/firmware/efi/Makefile            |   1 +
>  drivers/firmware/efi/efi.c               |  25 +++++
>  drivers/firmware/efi/unaccepted_memory.c | 112 +++++++++++++++++++++++
>  include/linux/efi.h                      |   1 +
>  5 files changed, 142 insertions(+)
>  create mode 100644 drivers/firmware/efi/unaccepted_memory.c
> 
> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> new file mode 100644
> index 000000000000..08a9a843550a
> --- /dev/null
> +++ b/drivers/firmware/efi/unaccepted_memory.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/efi.h>
> +#include <linux/memblock.h>
> +#include <linux/spinlock.h>
> +#include <asm/unaccepted_memory.h>
> +
> +/* Protects unaccepted memory bitmap */
> +static DEFINE_SPINLOCK(unaccepted_memory_lock);
> +
> +/*
> + * accept_memory() -- Consult bitmap and accept the memory if needed.
> + *
> + * Only memory that is explicitly marked as unaccepted in the bitmap requires
> + * an action. All the remaining memory is implicitly accepted and doesn't need
> + * acceptance.
> + *
> + * No need to accept:
> + *  - anything if the system has no unaccepted table;
> + *  - memory that is below phys_base;
> + *  - memory that is above the memory that addressable by the bitmap;
> + */
> +void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	struct efi_unaccepted_memory *unaccepted;
> +	unsigned long range_start, range_end;
> +	unsigned long flags;
> +	u64 unit_size;
> +
> +	unaccepted = efi_get_unaccepted_table();
> +	if (!unaccepted)
> +		return;
> +
> +	unit_size = unaccepted->unit_size;
> +
> +	/*
> +	 * Only care for the part of the range that is represented
> +	 * in the bitmap.
> +	 */
> +	if (start < unaccepted->phys_base)
> +		start = unaccepted->phys_base;
> +	if (end < unaccepted->phys_base)
> +		return;
> +
> +	/* Translate to offsets from the beginning of the bitmap */
> +	start -= unaccepted->phys_base;
> +	end -= unaccepted->phys_base;
> +
> +	/* Make sure not to overrun the bitmap */
> +	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
> +		end = unaccepted->size * unit_size * BITS_PER_BYTE;
> +
> +	range_start = start / unit_size;
> +
> +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
> +				   DIV_ROUND_UP(end, unit_size)) {
> +		unsigned long phys_start, phys_end;
> +		unsigned long len = range_end - range_start;
> +
> +		phys_start = range_start * unit_size + unaccepted->phys_base;
> +		phys_end = range_end * unit_size + unaccepted->phys_base;
> +
> +		arch_accept_memory(phys_start, phys_end);
> +		bitmap_clear(unaccepted->bitmap, range_start, len);
> +	}
> +	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +}

While testing SNP guests running today's tip/master (ef19bc9dddc3) I ran
into what seems to be fairly significant lock contention due to the
unaccepted_memory_lock spinlock above, which results in a constant stream
of soft-lockups until the workload gets all its memory accepted/faulted
in if the guest has around 16+ vCPUs.

I've included the guest dmesg traces I was seeing below.

In this case I was running a 32 vCPU guest with 200GB of memory running on
a 256 thread EPYC (Milan) system, and can trigger the above situation fairly
reliably by running the following workload in a freshly-booted guests:

  stress --vm 32 --vm-bytes 5G --vm-keep

Scaling up the number of stress threads and vCPUs should make it easier
to reproduce.

Other than unresponsiveness/lockup messages until the memory is accepted,
the guest seems to continue running fine, but for large guests where
unaccepted memory is more likely to be useful, it seems like it could be
an issue, especially when consider 100+ vCPU guests.

-Mike

[  105.753073] watchdog: BUG: soft lockup - CPU#3 stuck for 27s! [stress:1590]
[  105.756109] Modules linked in: btrfs(E) blake2b_generic(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) async_tx(E) xor(E) raid6_pq(E) libcrc32c(E) raid1(E) raid0(E) multipath(E) linear(E) crc32_pclmul(E) virtio_net(E) i2c_i801(E) net_failover(E) i2c_smbus(E) psmouse(E) failover(E) virtio_scsi(E) lpc_ich(E)
[  105.771644] irq event stamp: 392274
[  105.773852] hardirqs last  enabled at (392273): [<ffffffff9fbddf9a>] _raw_spin_unlock_irqrestore+0x5a/0x70
[  105.780058] hardirqs last disabled at (392274): [<ffffffff9fbddca9>] _raw_spin_lock_irqsave+0x69/0x70
[  105.785486] softirqs last  enabled at (392158): [<ffffffff9fbdf663>] __do_softirq+0x2a3/0x357
[  105.790627] softirqs last disabled at (392149): [<ffffffff9ecd0f5c>] irq_exit_rcu+0x8c/0xb0
[  105.795972] CPU: 3 PID: 1590 Comm: stress Tainted: G            EL     6.6.0-rc5-snp-guest-v10n+ #1
[  105.802416] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
[  105.807040] RIP: 0010:_raw_spin_unlock_irqrestore+0x45/0x70
[  105.810327] Code: b1 b1 18 ff 4c 89 e7 e8 79 e7 18 ff 81 e3 00 02 00 00 75 26 9c 58 0f 1f 40 00 f6 c4 02 75 22 48 85 db 74 06 fb 0f 1f 44 00 00 <65> ff 0d fc 5d 46 60 5b 41 5c 5d c3 cc cc cc cc e8 c6 9f 28 ff eb
[  105.818749] RSP: 0000:ffffc9000585faa8 EFLAGS: 00000206
[  105.821155] RAX: 0000000000000046 RBX: 0000000000000200 RCX: 00000000000028ce
[  105.825258] RDX: ffffffff9f8c7830 RSI: ffffffff9fbddf9a RDI: ffffffff9fbddf9a
[  105.828287] RBP: ffffc9000585fab8 R08: 0000000000000000 R09: 0000000000000000
[  105.831322] R10: 000000ffffffffff R11: 0000000000000000 R12: ffffffffa091a160
[  105.834713] R13: 00000000000028cd R14: ffff88807c459030 R15: ffff88807c459018
[  105.838230] FS:  00007fa4a8ee8740(0000) GS:ffff88b1aff80000(0000) knlGS:0000000000000000
[  105.841677] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  105.844115] CR2: 00007fa3719ec010 CR3: 000800010f7c2003 CR4: 0000000000770ef0
[  105.847160] PKRU: 55555554
[  105.848490] Call Trace:
[  105.849634]  <IRQ>
[  105.850517]  ? show_regs+0x68/0x70
[  105.851986]  ? watchdog_timer_fn+0x1dc/0x240
[  105.853868]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  105.855827]  ? __hrtimer_run_queues+0x1c3/0x340
[  105.857821]  ? hrtimer_interrupt+0x109/0x240
[  105.859673]  ? __sysvec_apic_timer_interrupt+0x67/0x170
[  105.861941]  ? sysvec_apic_timer_interrupt+0x7b/0x90
[  105.864048]  </IRQ>
[  105.864981]  <TASK>
[  105.865901]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  105.868110]  ? accept_memory+0x150/0x170
[  105.869795]  ? _raw_spin_unlock_irqrestore+0x5a/0x70
[  105.871885]  ? _raw_spin_unlock_irqrestore+0x5a/0x70
[  105.873966]  ? _raw_spin_unlock_irqrestore+0x45/0x70
[  105.876047]  accept_memory+0x150/0x170
[  105.877665]  try_to_accept_memory+0x134/0x1b0
[  105.879532]  get_page_from_freelist+0xa3e/0x1370
[  105.881479]  ? lock_acquire+0xd8/0x2b0
[  105.883045]  __alloc_pages+0x1b7/0x390
[  105.884619]  __folio_alloc+0x1b/0x50
[  105.886151]  ? policy_node+0x57/0x70
[  105.887673]  vma_alloc_folio+0xa6/0x360
[  105.889325]  do_pte_missing+0x1a5/0x8b0
[  105.890948]  __handle_mm_fault+0x75e/0xda0
[  105.892693]  handle_mm_fault+0xe1/0x2d0
[  105.894304]  do_user_addr_fault+0x1ce/0xa40
[  105.896050]  ? exit_to_user_mode_prepare+0xa4/0x230
[  105.898113]  exc_page_fault+0x84/0x200
[  105.899693]  asm_exc_page_fault+0x27/0x30
[  105.901405] RIP: 0033:0x55ebd4602cf0
[  105.902926] Code: 8b 54 24 0c 31 c0 85 d2 0f 94 c0 89 04 24 41 83 fd 02 0f 8f 3e 02 00 00 48 85 ed 48 89 d8 7e 1b 66 2e 0f 1f 84 00 00 00 00 00 <c6> 00 5a 4c 01 f8 48 89 c2 48 29 da 48 39 d5 7f ef 49 83 fc 00 0f
[  105.910671] RSP: 002b:00007ffebfede470 EFLAGS: 00010206
[  105.912897] RAX: 00007fa3719ec010 RBX: 00007fa3683ff010 RCX: 00007fa3683ff010
[  105.915859] RDX: 00000000095ed000 RSI: 0000000140001000 RDI: 0000000000000000
[  105.918853] RBP: 0000000140000000 R08: 00000000ffffffff R09: 0000000000000000
[  105.921836] R10: 0000000000000022 R11: 0000000000000246 R12: ffffffffffffffff
[  105.924810] R13: 0000000000000002 R14: fffffffffffff000 R15: 0000000000001000
[  105.927771]  </TASK>
[  110.367774] watchdog: BUG: soft lockup - CPU#15 stuck for 32s! [stress:1594]
[  110.369415] watchdog: BUG: soft lockup - CPU#13 stuck for 36s! [stress:1602]
