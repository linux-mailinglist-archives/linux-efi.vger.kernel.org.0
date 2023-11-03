Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575B67DFD66
	for <lists+linux-efi@lfdr.de>; Fri,  3 Nov 2023 01:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjKCABj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Nov 2023 20:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjKCABi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Nov 2023 20:01:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFAF136;
        Thu,  2 Nov 2023 17:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO7XO/RKjitwIVgTrnzRaHe+jiYU7b78a2nB5cWciJ2seLGQt5Vh2oNitqZ8AGySrCnvoq5S74/RYCh/o2YIwcIl3bOpsJPIkgbLZ1pJr2tMpMTQdbSmpgflP0nV7/7Ki5oxnWUe8B9P2ubV08fnBgUepkUKfU0reboTlM7/F2iurZZsrnWMUSx4BJAKly3z+TsC77L1+4wl/ZYl3Mx8LQbcI2JjFja1a714ubR7fQy1KyNKDJnFDF69uRjK+m87958RtWCreMMDEfN3B6Gq6uActe8x/hyG17+M4ZR1n7IOOCEDYPg9fuUdoO4BIECB85L34X7NKHOUF/wfK1jZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNzhc/kB9KGXaRJZK881c+BcsoROOl+DtXNidS/uY8I=;
 b=PUPqjKa0bhoG4tdNBypomeEqBEFuB/no6N64UAvOR5PBIa3an9fEVJ4+KB5h8Tl17CkefSSlC9r7FgwCtmgBbDSkPnBYJ6MUSIfvayk4bjKO8JXV2TLZ013QbMUWdniJ6uqUoZ3nJbmb/DX7oHNBvVoFkL+p3/9QrNGwi8kUpFPBa+bVDxAzP3TmttdjD1vV4w8E0WCU7MsuzH2bN536fww1EVtaRBL46M25Ygf0GBeuQIuvtrunkX1aiZW9IcMcK5bGRdIdAEvSnlz8ma9p53k7jE/RkkRuNMUiu/uX3qq+iWFXmHtMti4EnW0uWdtJIx2rtCj0ldsppfHXynIk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNzhc/kB9KGXaRJZK881c+BcsoROOl+DtXNidS/uY8I=;
 b=CeKLEalrs9e3PenbvFL8Jx+JJ72ubjEU8vbHxTBdD4lIstNDaYf4PXUsvMh6j6OdnYF9eRx40IVA3YhBoBD7ZBvUbzQ8nV/+14I92x3wtv3xkZhtN1XSeCw5WwqqMGbmCCcNwDoUye0jFwqWHlqJDsqFf+s1n90T2AX9mitzBAA=
Received: from MN2PR20CA0003.namprd20.prod.outlook.com (2603:10b6:208:e8::16)
 by CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 00:01:29 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::cc) by MN2PR20CA0003.outlook.office365.com
 (2603:10b6:208:e8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Fri, 3 Nov 2023 00:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 00:01:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 19:01:22 -0500
Date:   Thu, 2 Nov 2023 19:01:05 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     Vlastimil Babka <vbabka@suse.cz>, Borislav Petkov <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Message-ID: <20231103000105.m3z4eijcxlxciyzd@amd.com>
References: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
 <20231016205419.c3sfriemyaiczxie@amd.com>
 <3ccb822e-fc46-3087-d6ad-2f754dcf218c@suse.cz>
 <20231101004523.vseyi5bezgfaht5i@amd.com>
 <20231102135611.lyiu2lss2csswgch@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231102135611.lyiu2lss2csswgch@box.shutemov.name>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CH2PR12MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b0333e-be02-4394-0db0-08dbdc0007cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ozlz5HoUEpI+bbXzR58fjkKCsb3BSnLBXMkkBw6pumz8/YtHD+JRQf0RFc98EdFRK9yvEkpsmSwMidtX4YleI6ZKhGwAs5PHtA3IrQ6FmftHPpgHSSn0cU6AmXOjxs4y247vBMoQHtW9eYPEWQK6zqkiedt2xjP52g5WQkt/vcyLoJ7c62TIVp36/yJEGesZKsZxCDmGRaXyjjgadZKTuO3FAGzXvri0q4Xx7NnxH3HzK09o9bV4I4i03L3bMjLekms8uDqoGRAIfQzmGh6tNyZ1eSRQuyT7lYeK97dInopIX0heYV1P1KyJvLR+ALg8yhVlH0xmGlOwW7qxYYds/HQXCIEf+cddXKJA81lqKuwxtzx5Q08++vmn7RwekOcNI4CU2RvV7QMxYElfasQC1S5yIgg1TaNDI+d3zEAwOFqitd4kcju6UjXtxiCykxpODy7x4QVkvKne31UGQCXEQcrhaLs/TKjwkVPcgwuAsxg4E4HPqpo32j/iww7/ZNyG4drFropnE3rsAQ42Mi+q7vtoKwhS646L8UzJNeAuuS8DtsiCqXA12EnqNjGvERQB2QARAYHpRqzDfatIJvUc4xlH7lhPqjpLfw0IsZQG/diUkw4tiDtnTitiWhNs4pkt65o2pt+3/s6Hohf6b0l47ZFaFb47TdCq7ZpN1yjoZvsVcGalmXiJyGnaUZV0d56qfQlNNFx5dgF9H94vWXtwNGkLCxCqGHbLlrgzY+oi+xpsnQMF5J7kkhwAFOIB6URNxSYjTKwjpQBB/I/Gzu7zgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(81166007)(16526019)(2616005)(1076003)(40460700003)(40480700001)(356005)(426003)(26005)(336012)(44832011)(8676002)(8936002)(41300700001)(2906002)(86362001)(7416002)(7406005)(82740400003)(54906003)(478600001)(70206006)(70586007)(6916009)(316002)(4326008)(36756003)(6666004)(5660300002)(47076005)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 00:01:28.9234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b0333e-be02-4394-0db0-08dbdc0007cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4940
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 02, 2023 at 04:56:11PM +0300, Kirill A. Shutemov wrote:
> On Tue, Oct 31, 2023 at 07:45:23PM -0500, Michael Roth wrote:
> > > If you mean the guest has as many cpus as the host provides to it, but you
> > > stress with many more than that number of processes, then I wonder how
> > 
> > Yes, this is what I meant. If there are more memory-hog worker threads in
> > the guest than there are vCPUs, I'm better able to reproduce soft-lockups.
> > That sort of makes sense since those threads will spend more time waiting on
> > an available vCPU to handle memory acceptance.
> > 
> > But it actually isn't a requirement, I've also been able to reproduce this
> > with equal numbers of worker threads and vCPUs if I run 4 VMs, each
> > running the stress/acceptance workload at the same time.
> > 
> > And if I force 4K pages in gmem backend (technically a supported
> > configuration) then I can reproduce it much more easily since the 2MB
> > acceptance path takes much longer and it makes it easier to expose any
> > potential remaining concurrency issues.
> 
> This all sounds like we are solidly in "system is overloaded" territory.
> 
> Soft-lockups are still not good in this case. But I am not sure what we
> can do about it.

After spending more time on it I'm starting to reach a similar conclusion,
but I'm not yet convinced it's so much the system being overloaded as it
is the handling for KVM_SET_MEMORY_ATTRIBUTES being particularly punishing
for this sort of workload and starving vCPUs for execution time due to
it causing MMU invalidations that cause #NPFs to need restarting and
frequent NMIs due KVM_REQ_TLB_FLUSH requests. For non-CoCo guests I think
this activity would be much more infrequent.

For instance here's the journey of a particular 4MB range that ends up
triggering a soft-lockup in the guest according to host-side ftraces (in
this case I've disabled the additional 2MB region that gets taken for
the zero-padding issue, and implemented the bug fix mentioned earlier,
so there vCPUs don't ever end up waiting on each other):

== Acceptance for 4MB GPA range 0x18cbc00000:18cc000000 ==

  <...>-1946910 [226] ...1. 324797.313982: kvm_page_fault: vcpu 219 rip 0x0 address 0x00000018cbc00000 error_code 0x500000004
  <...>-1946910 [098] ...1. 324797.631256: kvm_page_fault: vcpu 219 rip 0x0 address 0x00000018cbdff000 error_code 0x500000004
  <...>-1946910 [107] ...1. 324835.184044: kvm_page_fault: vcpu 219 rip 0x0 address 0x00000018cbe00000 error_code 0x500000004
  <...>-1946910 [235] ...1. 324835.208404: kvm_page_fault: vcpu 219 rip 0x0 address 0x00000018cbfff000 error_code 0x500000004

It's a pretty wild ride that spans 38s across 4 CPUs. I seem to get these
for 2 or 3 unlucky GPA ranges for each run and the other ranges stay
well below the soft-lockup threshold.

Maybe there are ways to improve on that situation, like accepting using
larger chunk sizes (which is sort of the opposite of what I was suggesting
earlier, but maybe when done to a degree that significantly batches
invalidations and KVM_REQ_TLB_FLUSH requests it becomes less of an issue to
have vCPUs waiting on each other).

> 
> One silly idea is to prevent all vCPUs to do accept simultaneously and
> reserve one (or several) to do housekeeping. The idea is that this vCPU
> can be preempted to do job on other tasks.

Maybe if larger chunk sizes / more batching does end up helping, a
worker thread/pool of this sort makes even more sense. But maybe there
are simpler ways to experiment with that.

> 
> It would only make a difference for PREEMPT_FULL case and if the
> housekeeping CPU will hit the accept path from preemptable context. And it
> is obviously not applicable if there's only single vCPU.
> 
> > > softlockups would happen due to the extra processes. Since irqs are disabled
> > > through the whole operation, the extra processes can't become scheduled, and
> > > not being scheduled due to overloading doesn't trigger softlockups, hmm...
> > 
> > The soft lock-ups happen as soon as IRQs are re-enabled, either:
> > 
> >   a) right after a thread sees that its range intersects something
> >      that's in the process of being accepted
> > 
> >   b) right after a thread finishes accepting its whole range and is
> >      about to return from accept_memory()
> > 
> > I see a) occur more in the 4K test scenario, b) is more difficult to
> > reproduce and seems to need a larger system to reproduce more reliably.
> 
> I am not sure why you differentiate these scenarios. Kernel just hits
> place where it can be preempted and observes that it is overdue to
> scheduling.

It just seemed like a) was more similar to the original issue of threads
becoming serialized on a few CPUs, but with the changes noted above to
completely decouple vCPUs from each other I was still able to trigger soft
lock-ups, but instead of a storm of lock-ups from vCPU threads suffering
secondary effects, these were purely lock-ups of type b), which
point to there ultimately being something on the host-side which was
causing all the threads to trip over themselves.

> 
> > The fact that b) seems to depend on larger systems sort of makes sense.
> > When we need to covert a page to private as part of accepting it, there
> > is a guest->host request that eventually goes off to host userspace which
> > will call the KVM ioctl KVM_SET_MEMORY_ATTRIBUTES to mark the memory as
> > private so that it will get faulted in from the guest_memfd backend. When
> > this happens, any guest page faults that are currently in flight will get
> > invalidated and require a retry, and there's also a guest TLB flush
> > that results in an NMI to all the cores the guest was scheduled on so that
> > it can exit and acknowledge new updates. So the higher the rate of
> > KVM_SET_MEMORY_ATTRIBUTES the system is able to process, the higher the
> > frequency of this sort of activity on the host side that can impact each
> > vCPUs ability to make progress on accepting a particular range.
> > 
> > Also I was running 4 guests, each with as many vCPUs as the host, so
> > contention for physical resources would probably be a factor as well.
> 
> Yeah, at some point you will just saturate memory bandwidth.
> 
> > I'm not sure what can be done about b), but they seem to be host-side
> > optimizations that aren't too relevant to this patch, and they seem to
> > occur less frequently than a), which seems to be more guest side.
> > 
> > Still not sure what is causing type a) lock-ups exactly, but through
> > various traces and debug statements I think I've at least gotten some idea
> > that there are certain conditions where the vCPUs become more and more
> > dependent on each other completing certain ranges, and they spend longer
> > and longer amounts of time looping through the accepting_list.
> > 
> > There are 3 things I've noticed that might lead to vCPUs getting hung up
> > on each other:
> > 
> >  1) try_to_accept_memory_one() calls accept_page(page, MAX_ORDER), which
> >     is a 4MB range
> 
> This should not make one vCPU to setup on work on another. Page allocator
> owns full 4MB. It is not shared with anyone.

Indeed, with 2) and 3) addressed there no longer seem to be any
dependencies between threads.

> 
> >  2) There's an extra 2MB region taken after each unit to account for
> >     load_unaligned_zeropad() 
> 
> Okay, yes, this is true.
> 
> >  3) There is what appears to be a bug here:
> > 
> >         list_for_each_entry(entry, &accepting_list, list) {
> >                 if (entry->end < range.start)
> >                         continue;
> >                 if (entry->start >= range.end)
> >                         continue;
> > 
> >     where if entry->end == range.start, the thread will wait on the owner
> >     of that range even though it doesn't actually intersect.
> 
> Good catch. Care to send a patch?

Sure, I will get that posted by tomorrow after a bit more testing.

> 
> > I don't quite know how all this lines up to a dependency chain that would
> > potentially explain the lock-ups, but to mitigate that scenario, I tried only
> > adding the specific 2MB range that is being accepted to accepting_list, rather
> > than the whole range, and then just iterate through 2MB at a time in
> > accept_memory() instead of passing the larger range on to arch_accept_memory().
> 
> This might improve situation with soft lockups a bit, but would hurt
> accept bandwidth.

Yah, I think it was helpful for getting rid of some noise and getting a
better idea of the main source of the bottleneck, but the underlying issue
still remains even with these changes in place. 

I'll continue to experiment with it, but it makes me feel better at least
that there isn't something strange going on with the current guest-side
implementation.

Thanks,

Mike

> 
> > That seems to have resolved the soft lock-ups for the forced-4K scenario, but
> > I haven't had much time to test larger configurations yet.
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
