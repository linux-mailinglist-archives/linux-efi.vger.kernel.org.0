Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EE67CB4EE
	for <lists+linux-efi@lfdr.de>; Mon, 16 Oct 2023 22:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjJPUyr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Oct 2023 16:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPUyr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Oct 2023 16:54:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FC995;
        Mon, 16 Oct 2023 13:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvMiQfTgyz97QScKpfSZgRp47Y4jYD8r1vEQeP+ann/om8X76MfBTSVUAdXOdMsLkz13bvqTbxImjy0ltAv1IXHYk5hBsaMAsdFHEPLwNfROpOm+RIUc6KM0KB1GYB6cjldDKaGuIkghn3mC97oTTEyJzBulHML91bCV8uNwwSRgtljDkUMQFxMav4nxAoqrcnU3eTL50CZ0PdjqyvDHyT5YNLO9r7HFRu2U2wKBQdME5igTvplN0nHt2Vr12EeKZ/bXMl3/477NUeHIHuhNxY7s60Cqv+4+ZvLhWGoFPGDPiKPPo/Qb/eOpmwj5WZfdOgX+lUCiJBXdtM2mbyjdfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja4e8MdI+Loh2KZNBmOcfTFOAa+FgCMmf6+c1xwguNQ=;
 b=U38VAtm4G0cA1EbNKVhvAtgYztaAcaQMLxsXJonF5yuOBE6r8wDmtVaa9uH8qmoh2nHkYhzFSEHX10A2xpB4Pf4HfaArpeXI4paGl8u98FEbRPCT8VuV3tQxyzIPczb9W7V2/WlgeRsixXYetYDkXvlJhnTJfJ6mk9Nw/gcN/htT35Ky7t1YIdyD2ahzfdVb6KAcUqHnFIebLJJTP/SbRa522Hw8lBJ1kSM/kNem4QVp4a9u9CIzMbOx4kCXfx2l7z+Xd8BPdSZQlSs5LShhfiG+yB4xEl473r7NFFzYslqI51Xb4l1XOaGyBF22yzHkQyx8hypVpyqDnKoOH0l+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja4e8MdI+Loh2KZNBmOcfTFOAa+FgCMmf6+c1xwguNQ=;
 b=FNFmTBzQEsEC34B7jPWBgLqq09FUNfPhRhF7dZBwnCRuG/huTlT5fMPiTOa4waiQuT4BzT3IEtjOHzXfYlIPjhKZsNMCrv9oyA0i2Csg3GMcoKDzkqNzFMXmNFoEZNrE813uXXhiXMjNlQ6XNGTdgj/X8/AdRiyCLhTUVNw37xs=
Received: from SN1PR12CA0111.namprd12.prod.outlook.com (2603:10b6:802:21::46)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Mon, 16 Oct
 2023 20:54:41 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::93) by SN1PR12CA0111.outlook.office365.com
 (2603:10b6:802:21::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 20:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 20:54:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 15:54:34 -0500
Date:   Mon, 16 Oct 2023 15:54:19 -0500
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
        <philip.cox@canonical.com>, <aarcange@redhat.com>,
        <peterx@redhat.com>, <x86@kernel.org>, <linux-mm@kvack.org>,
        <linux-coco@lists.linux.dev>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@kernel.org>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCHv2] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
Message-ID: <20231016205419.c3sfriemyaiczxie@amd.com>
References: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ef0697-b8bc-4fe1-d229-08dbce8a1dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKy+BRmaszNcuSvIR/JjSCpEloVHF4CkQ7XIn/wbge18oDv2fEmU/a4eOGTQ58704CxHAwjQSZ954k8PwTmh1oU1xTxBv5n5K6m5qG9lnKDgjFdP6DJkR0+MikZ0BiPRhd/tj8VC/AzwIY2pRF+AUbPpVGLXF7h06qeIrgVfzvBntoU5UdWJmVlSpvGu+g83OLXFl4NcENnnxq2i/s2v+WeBHBRcHLsMhMSVbc7DmcA3u8MYqrjGLxpQJSFN4KiBfg1/YRHUa9yG3xQL/Rqs3LC2yqVOzCz2oE557Sx4irlA5D4A2nWUlRbyTXWr+/3LyNf086ZWa7BGiBVmKUpUo5HMwwtZlCiK45DcfxYOpQOvhwpOvbPXusURQqKjP4lc00Xj3yMNek8ZI/v74Pd9gywMd6Ckf4ML0IkAoBo1TDrdDmkk6kXml9TXEwbI1TUs3QqTR9a0CvRrsgMnbrdjNIr36rjNeYESByDMFF4lXEkuyM6/7NG3M5NVcUNecT2A13CbCoXi4FAHqwq+JCYuAeyejmpUH3hXqSOOxEd7KHX0P/Ut3U2vDnDBXblkpJrBaWFUIJFlywI4lI2ZoWZO6Ek3CVIyl9QPLGKGXnV3p6LNbC/JgkXPnHpYgxwGdud7ecWkD9uux56rAkU6UXGCBzS9PPRh6gwUJMbqMxV/h6CeGzzp1ncnPYeiig9Q1Y2iEpVGTCg81s/EJeXIJgLGmoHX54fJ4CKTrlEX4ZVsYlniYpy6dPYIsnTAAdwx5r/j3ds+oSQfIgRoW3dQu6UH6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(2616005)(356005)(26005)(16526019)(6916009)(70586007)(82740400003)(40480700001)(54906003)(1076003)(70206006)(36860700001)(4326008)(8936002)(8676002)(316002)(36756003)(426003)(336012)(478600001)(2906002)(7406005)(7416002)(6666004)(83380400001)(86362001)(5660300002)(81166007)(47076005)(44832011)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 20:54:40.1066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ef0697-b8bc-4fe1-d229-08dbce8a1dc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 16, 2023 at 07:31:22PM +0300, Kirill A. Shutemov wrote:
> Michael reported soft lockups on a system that has unaccepted memory.
> This occurs when a user attempts to allocate and accept memory on
> multiple CPUs simultaneously.
> 
> The root cause of the issue is that memory acceptance is serialized with
> a spinlock, allowing only one CPU to accept memory at a time. The other
> CPUs spin and wait for their turn, leading to starvation and soft lockup
> reports.
> 
> To address this, the code has been modified to release the spinlock
> while accepting memory. This allows for parallel memory acceptance on
> multiple CPUs.
> 
> A newly introduced "accepting_list" keeps track of which memory is
> currently being accepted. This is necessary to prevent parallel
> acceptance of the same memory block. If a collision occurs, the lock is
> released and the process is retried.
> 
> Such collisions should rarely occur. The main path for memory acceptance
> is the page allocator, which accepts memory in MAX_ORDER chunks. As long
> as MAX_ORDER is equal to or larger than the unit_size, collisions will
> never occur because the caller fully owns the memory block being
> accepted.
> 
> Aside from the page allocator, only memblock and deferered_free_range()
> accept memory, but this only happens during boot.
> 
> The code has been tested with unit_size == 128MiB to trigger collisions
> and validate the retry codepath.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Michael Roth <michael.roth@amd.com

Tested-by: Michael Roth <michael.roth@amd.com>

This seems to improve things pretty dramatically for me. Previously I
saw soft-lockups with 16 vCPUs and 16 processes faulting into memory,
and now I can do 128+ vCPUs/processes.

I can still trigger soft lock-ups on occassion if the number of processes
faulting in memory exceeds the number of vCPUs available to the guest, but
with a 32 vCPU guest even something like this:

  stress --vm 128 --vm-bytes 2G --vm-keep --cpu 255

still seems to avoid the soft lock-up messages. So that's probably well
into "potential future optimization" territory and this patch fixes the
more immediate issues.

Thanks!

-Mike

> Fixes: 2053bc57f367 ("efi: Add unaccepted memory support")
> Cc: <stable@kernel.org>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
> 
>   v2:
>    - Fix deadlock (Vlastimil);
>    - Fix comments (Vlastimil);
>    - s/cond_resched()/cpu_relax()/ -- cond_resched() cannot be called
>      from atomic context;
> 
