Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE717DDA5B
	for <lists+linux-efi@lfdr.de>; Wed,  1 Nov 2023 01:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345059AbjKAArH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Oct 2023 20:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjKAArG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Oct 2023 20:47:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0421EA;
        Tue, 31 Oct 2023 17:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS6axv50vHlJ/3Fovv6knCIuDlKAVwET3oBELYc/OuIEnfh7rB90nFK3s1kFOQf+/hpUiTcEfcHqXh4476sHUoUjFjU8jur6SYy963d88vdhRfeoaFRERNKtiTOfR2j5Tw3m+XeS1+7kXiDQEOr5P9Y4G2fCglxdsn8V8AjvBz50qpc4/2SKuQfUHqaX0eU+bcg6QmCQ1TW6mv46SyYOfh4Y2n0Z+1311xaKlZKff6s7avczpMKGH1/yaEYsvicTTKwIyPmGC7fKhmEIQVaua8YIScifOh0433jczhAwPj50wlYtCuGK2JATZzf5+Ce5l4ubMTvNHP6tG0yCTf6AQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbELsduGrBB9gVf0rDLQHXQ2rjvEJCuT2fbCaNnXuNQ=;
 b=DlagggRxPV9/5QyojSVTjA73ggKVaCMv7AHtjM9garDTgg3b9YUErh8GntbrwfsEsAbjpB0fz3LYeRli5fSaB6ptwB2jSY9RMprg2TFUxiP2kKQ4y3p4yps5N+9DM8TXgML89nmXVYNz95CrPrgTunU0bJjFIkOQuLMXMey1EiKVvRJKXkwIkVRZzeYGMQYNbdvoIxghHFoXUExIYYXnVcGZ2ArfS4Gj2SrPh9N21mIyGsfe7pxNl0CFn89nfMWEId8B5uoUm2JFMUy7RAGphed13C6t+jj9GGZ3P9qzRKydJrlohZMQR4wbVVRlH2zJ3jlv2ebFsXXfPH8wCtN6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.cz smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbELsduGrBB9gVf0rDLQHXQ2rjvEJCuT2fbCaNnXuNQ=;
 b=1AyhhrwvpTFg+UIBNQ70fNiikYFsS4lB/KKe8SquBlqw//hfViD6vjdx7zxDoJQHXpS756fjuzBmO6Gww+WRKAFZbI7mz62H0E8++gmw6GHXNF6hmylpMRHKl7uy4qtyJuUejAor2CqzIsJ5jUXMxAD3FQhe6nt3xeztGyaTInw=
Received: from BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::17)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 00:46:56 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::ed) by BL1P221CA0021.outlook.office365.com
 (2603:10b6:208:2c5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 00:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 00:46:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 19:46:55 -0500
Date:   Tue, 31 Oct 2023 19:45:23 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        <marcelo.cerri@canonical.com>, <tim.gardner@canonical.com>,
        <philip.cox@canonical.com>, <aarcange@redhat.com>,
        <peterx@redhat.com>, <x86@kernel.org>, <linux-mm@kvack.org>,
        <linux-coco@lists.linux.dev>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@kernel.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Bandan Das <bsd@redhat.com>
Subject: Re: [PATCHv2] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
Message-ID: <20231101004523.vseyi5bezgfaht5i@amd.com>
References: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
 <20231016205419.c3sfriemyaiczxie@amd.com>
 <3ccb822e-fc46-3087-d6ad-2f754dcf218c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3ccb822e-fc46-3087-d6ad-2f754dcf218c@suse.cz>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb78561-1a7d-4728-02d9-08dbda740c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yLFiDMOStxJHjWsvevO9pRYq/PKoZzWeRKdw46A+i5hfpXMMhtQ1xME9klOCfBaegA1lWC0IrG55xCWJAgW+mptyQNStm1ke4w8SDMOrGVaoXAzWJ4fE7BzqYz4IQn5CJHH6cfbibscK5EWSROLnTexZKn3fg+jzCq/N0oGze0+1QZqoi1nEj/QE+denr0fxhU4lHKv80EalyknSfvReWtbbrlSsnNNwAO8Roaza04V2kdF31NtF/gPV5Ot7p4c1wCiGZO73YF4MTCFB/AmEP0IJrnRoWalVWiJnxfoWA44Cda0Gn2rQifVgM+f9fN2jvGS9ivF0MMXtcdZxBjOEPtzLq60WNh4zfN+y7LnuIcHiVhRemJtfotYrUexwi1t2WSiqb9GvWC4vY4FM2es1q+rKzCwcZfUFW0oyQlK7FsudT+oRHuZuzRbBcqJXqzg8AyCT5AoTnFEwBLU4ODiMWeY0Zlx1BLYbqO9jd+FM39595vG+4LDUtty6wbmJJJpc4IatLx5wyOMv35ntIG+vIcRGF2KHviT6qAh6W6jCV9odVe+1A/dLxp+NcYcRvWEH7rwomXbfSzxxmEms7AU7RWE2ykfEEwVBAOn+KO8ILFKZGzXZ2vXZt72oz1+C3/lz0IOALAOzoMa5JeQMoRf2otFHR+3622qQksr1fe/0d6XXtbJ3fOt7hCQXeHSSk6j2Cvp2yeZLhQwKbGQa9yeZ5YvF6lQq5IVVgxIFwrZCY8V40oZE+Q9g4ICbNW+zoA0SVuud25EXQNMr0QbXPbVPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(7406005)(40460700003)(40480700001)(1076003)(16526019)(26005)(2616005)(45080400002)(36860700001)(478600001)(5660300002)(47076005)(6666004)(30864003)(336012)(316002)(2906002)(7416002)(83380400001)(70206006)(44832011)(41300700001)(70586007)(8676002)(4326008)(8936002)(54906003)(6916009)(36756003)(82740400003)(53546011)(356005)(81166007)(86362001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 00:46:56.2750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb78561-1a7d-4728-02d9-08dbda740c79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 17, 2023 at 09:02:59AM +0200, Vlastimil Babka wrote:
> On 10/16/23 22:54, Michael Roth wrote:
> > On Mon, Oct 16, 2023 at 07:31:22PM +0300, Kirill A. Shutemov wrote:
> >> Michael reported soft lockups on a system that has unaccepted memory.
> >> This occurs when a user attempts to allocate and accept memory on
> >> multiple CPUs simultaneously.
> >> 
> >> The root cause of the issue is that memory acceptance is serialized with
> >> a spinlock, allowing only one CPU to accept memory at a time. The other
> >> CPUs spin and wait for their turn, leading to starvation and soft lockup
> >> reports.
> >> 
> >> To address this, the code has been modified to release the spinlock
> >> while accepting memory. This allows for parallel memory acceptance on
> >> multiple CPUs.
> >> 
> >> A newly introduced "accepting_list" keeps track of which memory is
> >> currently being accepted. This is necessary to prevent parallel
> >> acceptance of the same memory block. If a collision occurs, the lock is
> >> released and the process is retried.
> >> 
> >> Such collisions should rarely occur. The main path for memory acceptance
> >> is the page allocator, which accepts memory in MAX_ORDER chunks. As long
> >> as MAX_ORDER is equal to or larger than the unit_size, collisions will
> >> never occur because the caller fully owns the memory block being
> >> accepted.
> >> 
> >> Aside from the page allocator, only memblock and deferered_free_range()
> >> accept memory, but this only happens during boot.
> >> 
> >> The code has been tested with unit_size == 128MiB to trigger collisions
> >> and validate the retry codepath.
> >> 
> >> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >> Reported-by: Michael Roth <michael.roth@amd.com
> > 
> > Tested-by: Michael Roth <michael.roth@amd.com>
> > 
> > This seems to improve things pretty dramatically for me. Previously I
> > saw soft-lockups with 16 vCPUs and 16 processes faulting into memory,
> > and now I can do 128+ vCPUs/processes.
> > 
> > I can still trigger soft lock-ups on occassion if the number of processes
> > faulting in memory exceeds the number of vCPUs available to the guest, but
> > with a 32 vCPU guest even something like this:
> > 
> >   stress --vm 128 --vm-bytes 2G --vm-keep --cpu 255
> > 
> > still seems to avoid the soft lock-up messages. So that's probably well
> > into "potential future optimization" territory and this patch fixes the
> > more immediate issues.
> 

Sorry for the delay, the optimizations here work well enough that it's been
a bit of challenge reproducing this reliably enough to get some good data
the lingering sources of soft lock-ups I'm still seeing.

> Do you mean that the guest pretends it has more cpus than the host provides
> to it? I think such cpu starving configuration is prone to softlockups
> already, so it wouldn't be new.
> 
> If you mean the guest has as many cpus as the host provides to it, but you
> stress with many more than that number of processes, then I wonder how

Yes, this is what I meant. If there are more memory-hog worker threads in
the guest than there are vCPUs, I'm better able to reproduce soft-lockups.
That sort of makes sense since those threads will spend more time waiting on
an available vCPU to handle memory acceptance.

But it actually isn't a requirement, I've also been able to reproduce this
with equal numbers of worker threads and vCPUs if I run 4 VMs, each
running the stress/acceptance workload at the same time.

And if I force 4K pages in gmem backend (technically a supported
configuration) then I can reproduce it much more easily since the 2MB
acceptance path takes much longer and it makes it easier to expose any
potential remaining concurrency issues.

> softlockups would happen due to the extra processes. Since irqs are disabled
> through the whole operation, the extra processes can't become scheduled, and
> not being scheduled due to overloading doesn't trigger softlockups, hmm...

The soft lock-ups happen as soon as IRQs are re-enabled, either:

  a) right after a thread sees that its range intersects something
     that's in the process of being accepted

  b) right after a thread finishes accepting its whole range and is
     about to return from accept_memory()

I see a) occur more in the 4K test scenario, b) is more difficult to
reproduce and seems to need a larger system to reproduce more reliably.

The fact that b) seems to depend on larger systems sort of makes sense.
When we need to covert a page to private as part of accepting it, there
is a guest->host request that eventually goes off to host userspace which
will call the KVM ioctl KVM_SET_MEMORY_ATTRIBUTES to mark the memory as
private so that it will get faulted in from the guest_memfd backend. When
this happens, any guest page faults that are currently in flight will get
invalidated and require a retry, and there's also a guest TLB flush
that results in an NMI to all the cores the guest was scheduled on so that
it can exit and acknowledge new updates. So the higher the rate of
KVM_SET_MEMORY_ATTRIBUTES the system is able to process, the higher the
frequency of this sort of activity on the host side that can impact each
vCPUs ability to make progress on accepting a particular range.

Also I was running 4 guests, each with as many vCPUs as the host, so
contention for physical resources would probably be a factor as well.

I'm not sure what can be done about b), but they seem to be host-side
optimizations that aren't too relevant to this patch, and they seem to
occur less frequently than a), which seems to be more guest side.

Still not sure what is causing type a) lock-ups exactly, but through
various traces and debug statements I think I've at least gotten some idea
that there are certain conditions where the vCPUs become more and more
dependent on each other completing certain ranges, and they spend longer
and longer amounts of time looping through the accepting_list.

There are 3 things I've noticed that might lead to vCPUs getting hung up
on each other:

 1) try_to_accept_memory_one() calls accept_page(page, MAX_ORDER), which
    is a 4MB range

 2) There's an extra 2MB region taken after each unit to account for
    load_unaligned_zeropad() 

 3) There is what appears to be a bug here:

        list_for_each_entry(entry, &accepting_list, list) {
                if (entry->end < range.start)
                        continue;
                if (entry->start >= range.end)
                        continue;

    where if entry->end == range.start, the thread will wait on the owner
    of that range even though it doesn't actually intersect.

I don't quite know how all this lines up to a dependency chain that would
potentially explain the lock-ups, but to mitigate that scenario, I tried only
adding the specific 2MB range that is being accepted to accepting_list, rather
than the whole range, and then just iterate through 2MB at a time in
accept_memory() instead of passing the larger range on to arch_accept_memory().

That seems to have resolved the soft lock-ups for the forced-4K scenario, but
I haven't had much time to test larger configurations yet.

-Mike


== Soft lock-ups of type A (kernel is vanilla 6.6.0-rc5 + this patch) ==

[  266.312940] watchdog: BUG: soft lockup - CPU#161 stuck for 21s! [stress:7844]^M
[  266.321432] Modules linked in:^M
[  266.336478] Modules linked in: btrfs^M
[  266.350571]  btrfs^M
[  266.363954]  blake2b_generic^M
[  266.377754]  blake2b_generic^M
[  266.393502]  raid10^M
[  266.406422]  raid10^M
[  266.418275]  raid456^M
[  266.430487]  raid456^M
[  266.442159]  async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear virtio_net i2c_i801 net_failover psmouse virtio_scsi i2c_smbus failover crc32_pclmul lpc_ich^M
[  266.442226] irq event stamp: 1100892^M
[  266.442228] hardirqs last enabled at (1100891): irqentry_exit (kernel/entry/common.c:445)
[  266.442253] hardirqs last disabled at (1100892): _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:108 kernel/locking/spinlock.c:162)
[  266.442261] softirqs last enabled at (1094506): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582)
[  266.442268] softirqs last disabled at (1094499): irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644)
[  266.442291] CPU: 161 PID: 7844 Comm: stress Not tainted 6.6.0-rc5-snp-guest1-no-extend+ #1^M
[  266.442298] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022^M
[  266.442305] RIP: 0010:_raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:85 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
[  266.442309] Code: b1 b1 18 ff 4c 89 e7 e8 79 e7 18 ff 81 e3 00 02 00 00 75 26 9c 58 0f 1f 40 00 f6 c4 02 75 22 48 85 db 74 06 fb 0f 1f 44 00 00 <65> ff 0d fc 5d 06 73 5b 41 5c 5d c3 cc cc cc cc e8 c6 9f 28 ff eb^M
[  266.442311] RSP: 0000:ffffc9000da17a80 EFLAGS: 00000206^M
[  266.442313] RAX: 0000000000000046 RBX: 0000000000000200 RCX: ffffc9000da1fac0^M
[  266.442314] RDX: ffffffff8ccc7915 RSI: ffffffff8cfddf9a RDI: ffffffff8cfddf9a^M
[  266.442316] RBP: ffffc9000da17a90 R08: 0000000000000000 R09: 0000000000000000^M
[  266.442317] R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8dd1a1e0^M
[  266.442318] R13: 00000014b8c00000 R14: 0000000000200000 R15: ffff88807baa7018^M
[  266.442321] FS:  00007f6a297c5740(0000) GS:ffff889b8ee80000(0000) knlGS:0000000000000000^M
[  266.442322] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
[  266.442323] CR2: 00007f6a20cb1010 CR3: 0008000125992001 CR4: 0000000000770ef0^M
[  266.442325] PKRU: 55555554^M
[  266.442325] Call Trace:^M
[  266.442329]  <IRQ>^M
[  266.442343] ? show_regs (arch/x86/kernel/dumpstack.c:479)
[  266.442358] ? watchdog_timer_fn (kernel/watchdog.c:520)
[  266.442366] ? __pfx_watchdog_timer_fn (kernel/watchdog.c:439)
[  266.442367] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1688 kernel/time/hrtimer.c:1752)
[  266.442377] ? hrtimer_interrupt (kernel/time/hrtimer.c:1817)
[  266.442381] ? __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1081)
[  266.442388] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14))
[  266.442394]  </IRQ>^M
[  266.442395]  <TASK>^M
[  266.442396] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645)
[  266.442407] ? accept_memory (arch/x86/include/asm/vdso/processor.h:13 arch/x86/include/asm/vdso/processor.h:18 drivers/firmware/efi/unaccepted_memory.c:122)
[  266.442420] ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
[  266.442422] ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
[  266.442428] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:85 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
[  266.442430] accept_memory (arch/x86/include/asm/vdso/processor.h:13 arch/x86/include/asm/vdso/processor.h:18 drivers/firmware/efi/unaccepted_memory.c:122)
[  266.442433] ? mark_held_locks (kernel/locking/lockdep.c:4273)
[  266.442450] try_to_accept_memory (mm/page_alloc.c:6629 mm/page_alloc.c:6649)
[  266.442467] get_page_from_freelist (mm/page_alloc.c:3125)
[  266.442474] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755 kernel/locking/lockdep.c:5718)
[  266.442478] __alloc_pages (mm/page_alloc.c:4426)
[  266.442485] __folio_alloc (mm/page_alloc.c:4462)
[  266.442487] ? policy_node (include/linux/nodemask.h:266 mm/mempolicy.c:1887)
[  266.442499] vma_alloc_folio (include/linux/mempolicy.h:75 include/linux/mempolicy.h:80 mm/mempolicy.c:2263)
[  266.442503] do_pte_missing (mm/memory.c:4110 mm/memory.c:3667)
[  266.442508] __handle_mm_fault (mm/memory.c:4978 mm/memory.c:5119)
[  266.442515] handle_mm_fault (mm/memory.c:5284)
[  266.442517] do_user_addr_fault (arch/x86/mm/fault.c:1365)
[  266.442523] ? exit_to_user_mode_prepare (kernel/entry/common.c:212 (discriminator 31))
[  266.453915]  async_raid6_recov^M
[  266.465236] exc_page_fault (arch/x86/include/asm/paravirt.h:689 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561)
[  266.465292] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570)
[  266.465307] RIP: 0033:0x564b7e602cf0


== Soft lock-ups of type B ==

[  266.675357] watchdog: BUG: soft lockup - CPU#134 stuck for 23s! [stress:7817]^M
[  266.675394] Modules linked in: btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear virtio_net i2c_i801 net_failover psmouse virtio_scsi i2c_smbus failover crc32_pclmul lpc_ich^M
[  266.675675] irq event stamp: 2579636^M
[  266.675680] hardirqs last enabled at (2579635): _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
[  266.675751] hardirqs last disabled at (2579636): _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:108 kernel/locking/spinlock.c:162)
[  266.675754] softirqs last enabled at (1734708): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582)
[  266.675757] softirqs last disabled at (1734701): irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644)
[  266.675813] CPU: 134 PID: 7817 Comm: stress Tainted: G             L     6.6.0-rc5-snp-guest1-no-extend+ #1^M
[  266.675831] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022^M
[  266.675838] RIP: 0010:_raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:85 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
[  266.675848] Code: b1 b1 18 ff 4c 89 e7 e8 79 e7 18 ff 81 e3 00 02 00 00 75 26 9c 58 0f 1f 40 00 f6 c4 02 75 22 48 85 db 74 06 fb 0f 1f 44 00 00 <65> ff 0d fc 5d 06 73 5b 41 5c 5d c3 cc cc cc cc e8 c6 9f 28 ff eb^M
[  266.675850] RSP: 0000:ffffc9000d93fa80 EFLAGS: 00000206^M
[  266.675852] RAX: 0000000000000046 RBX: 0000000000000200 RCX: 000000000000a53b^M
[  266.675853] RDX: ffffffff8ccc78e2 RSI: ffffffff8cfddf9a RDI: ffffffff8cfddf9a^M
[  266.675854] RBP: ffffc9000d93fa90 R08: 0000000000000000 R09: 0000000000000000^M
[  266.675855] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8dd1a1e0^M
[  266.675856] R13: ffff88807baa7030 R14: 0000000000200000 R15: ffff88807baa7018^M
[  266.675861] FS:  00007f6a297c5740(0000) GS:ffff889b8e100000(0000) knlGS:0000000000000000^M
[  266.675862] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
[  266.675863] CR2: 00007f6a1ca4e010 CR3: 0008000124e04003 CR4: 0000000000770ef0^M
[  266.675865] PKRU: 55555554^M
[  266.675865] Call Trace:^M
[  266.675879]  <IRQ>^M
[  266.675947] ? show_regs (arch/x86/kernel/dumpstack.c:479)
[  266.675965] ? watchdog_timer_fn (kernel/watchdog.c:520)
[  266.675979] ? __pfx_watchdog_timer_fn (kernel/watchdog.c:439)
[  266.675981] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1688 kernel/time/hrtimer.c:1752)
[  266.675995] ? hrtimer_interrupt (kernel/time/hrtimer.c:1817)
[  266.675998] ? __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1081)
[  266.676006] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14))
[  266.676014]  </IRQ>^M
[  266.676014]  <TASK>^M
[  266.676016] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645)
[  266.676032] ? accept_memory (drivers/firmware/efi/unaccepted_memory.c:162)
[  266.676052] ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
[  266.676054] ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
[  266.676067] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:85 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
[  266.676069] accept_memory (drivers/firmware/efi/unaccepted_memory.c:162)
[  266.676074] try_to_accept_memory (mm/page_alloc.c:6629 mm/page_alloc.c:6649)
[  266.676107] get_page_from_freelist (mm/page_alloc.c:3125)
[  266.676110] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755 kernel/locking/lockdep.c:5718)
[  266.676123] __alloc_pages (mm/page_alloc.c:4426)
[  266.676127] __folio_alloc (mm/page_alloc.c:4462)
[  266.676129] ? policy_node (include/linux/nodemask.h:266 mm/mempolicy.c:1887)
[  266.676138] vma_alloc_folio (include/linux/mempolicy.h:75 include/linux/mempolicy.h:80 mm/mempolicy.c:2263)
[  266.676141] do_pte_missing (mm/memory.c:4110 mm/memory.c:3667)
[  266.676149] __handle_mm_fault (mm/memory.c:4978 mm/memory.c:5119)
[  266.676156] handle_mm_fault (mm/memory.c:5284)
[  266.676159] do_user_addr_fault (arch/x86/mm/fault.c:1365)
[  266.676165] ? exit_to_user_mode_prepare (kernel/entry/common.c:212 (discriminator 31))
[  266.676174] exc_page_fault (arch/x86/include/asm/paravirt.h:689 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561)
[  266.676177] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570)
[  266.676178] RIP: 0033:0x564b7e602cf0^

> 
> > Thanks!
> > 
> > -Mike
> > 
> >> Fixes: 2053bc57f367 ("efi: Add unaccepted memory support")
> >> Cc: <stable@kernel.org>
> >> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> >> ---
> >> 
> >>   v2:
> >>    - Fix deadlock (Vlastimil);
> >>    - Fix comments (Vlastimil);
> >>    - s/cond_resched()/cpu_relax()/ -- cond_resched() cannot be called
> >>      from atomic context;
> >> 
> 
