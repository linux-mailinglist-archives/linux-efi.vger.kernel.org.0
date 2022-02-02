Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9464A6963
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 01:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiBBAwi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 19:52:38 -0500
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:64033
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231736AbiBBAwh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 1 Feb 2022 19:52:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A54TAhIvRJyVdp8VyTAVi/XLfAABDNhufpEnX246IqRUpdC9n2FmZTiSK6vrZM2WbWZUbqKIH3EhiDq+t24QeTZN0i9bI6Ndzoba9xJzrezc/GY80DnBd4F0AmnfU9khzNf2nL1CD6y1q5ONxSdLNwflF8MtsMgMOjLqkwJS4r0QfbUh35CIlvFZhup1ekgQpqP/lrQmdKHx2VbFt9in8u65SDRki331bx0Y5J7x5C1D4+TnsKqc4Lp3PpM/jao1i3jY2rEwSKnxmilzkmpwsI/8RnO298d6RmQmVhWKljCGh2i4Z2XzGYpKT3tVZvX+GlTw1BSnAbYQik9Je5XyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jLLNyF931Xkh2GTQRfzaJi21GVrsL7gT24oSMgOqwk=;
 b=TM51Ww8FHKljILj5xSjB4ut7j12I64+l6pZCUBduRL1iJixBpA5LzzaCvGsfmJkoeydiJMB0ytkCMpWWAZsxXRgZuIKSeNqCsipEmdQPRgjmnnUMAvZ26K7XBjXBNDI4EIp2jQV9NVlwtua4VeXTkEVnl/tVSlxkVGTj0ZIYc3RopX9c4ETykiXs09NG44EAEmzlbOTsDfk9SQtrWbWWtDQ7+g4nt6WnU8OG+zj+KqIB7pvehoWb06kKDcVQJimtORG819iuA7S9r5qpVgjM2tm7l+wxRa5hwaFfoKixWdCl9HGP2qgJ/4wL0FjgibDEIBkdDVd3vCcdQJO6U/kgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jLLNyF931Xkh2GTQRfzaJi21GVrsL7gT24oSMgOqwk=;
 b=jVR/khLQRutGUnLZDp6R3qOzdnUzkpM65dM1tU0XKvz4YT7LFEXvrUQeLFlKwnryGvZqP/kj2j/sf3j7Eqdm0Kt1wwyQEcYJ7vth5Y7KrwcaOCVVG55J1AiKWG+yDao0IE+G0ees4oh+pwsG1Gh53425I2PSHdAX4d0/gWdP76c=
Received: from MWHPR18CA0062.namprd18.prod.outlook.com (2603:10b6:300:39::24)
 by DM5PR12MB1356.namprd12.prod.outlook.com (2603:10b6:3:74::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 00:52:32 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::69) by MWHPR18CA0062.outlook.office365.com
 (2603:10b6:300:39::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Wed, 2 Feb 2022 00:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 2 Feb 2022 00:52:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Feb
 2022 18:52:30 -0600
Date:   Tue, 1 Feb 2022 18:52:12 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v9 05/43] x86/compressed/64: Detect/setup SEV/SME
 features earlier in boot
Message-ID: <20220202005212.a3fnn6i76ko6u6t5@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-6-brijesh.singh@amd.com>
 <Yfl3FaTGPxE7qMCq@zn.tnic>
 <20220201203507.goibbaln6dxyoogv@amd.com>
 <YfmmBykN2s0HsiAJ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YfmmBykN2s0HsiAJ@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 972d436e-7a77-4b8b-deff-08d9e5e64b36
X-MS-TrafficTypeDiagnostic: DM5PR12MB1356:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB135639A859213EDB920F8AAA95279@DM5PR12MB1356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ucESxqInr/srzXT+VE92kbVNP11PA3iebVMusUAkBKNgByiz7utT7rZGygG87lkW9CLJHpzFDV0YpURW+SbD7mfGBn7Ud8+FkXzHic66l+pEKqa2Q9K1zUXcGCyXb/e7dQkfpO6siiIeqXl+mWFgAANDhtidOSDvz4JU/GmtetpPST+W3USzAHxM/iPU5TqyNZ649gOrZJ9TIy8U09WIspKF+mDm+zLtPE+GEVvoAGs0QzK9YzEWRVWgfRWGN7vURpKvj4NCMEy/VM3E4N7yDbnTKBjszQONoiyT5Cu9ZCuKjIiglJLDIxsG5CVG7JjSQPqXitVSiO7tbncAID/XRxFtm6JUsZMPYu+NfPxrbL0o9s2qNLrYhRQpqnkFewWJLpA5yC7LjLP7C4dIus2x1Y8mRncTlZMr/xTj8WhCalIuVdd1myMDZ64pYpTUkvzF3nFSg8rlYWClqP1o17dz/bmGxboLtfR5ufYcdN6TZA4iTCV049UeXSoqkOx99oPmEn/u+mMYPGu8Oxg8bqhXHwA9P+4lUlKkmvOOFgCt4feMSFwIKhuzTUFmEKysrYOYqN4IiaX3I7TVk/ikN/VMFExl+tlahvbA1ix7hHFwxehRgwLq2JvHR8gQX6pjE0YmbYUzzitxrsiPQxJjZXgIW/Y8YjYh/3cjAz5UFXMOsc21dVUpU+M9I7ZUNhTdfGpw2c1jRyhHTih+OgLY9G6yJevNwDOxllNB5PjPtohjyI0pGGyFeiZdIRfi+OYTNOVor1C78z5S5A+t9cMW6X1LF/CXSnbBZGEyktT8xE6GopGuZckUx9BNrBopPUMjqT/q/Wt6HIa9i9+JFLcENfwFWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(8676002)(2906002)(70206006)(70586007)(4326008)(5660300002)(7406005)(44832011)(86362001)(36860700001)(82310400004)(8936002)(47076005)(40460700003)(6666004)(336012)(426003)(508600001)(45080400002)(356005)(7416002)(966005)(81166007)(6916009)(316002)(36756003)(1076003)(26005)(16526019)(186003)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 00:52:31.5043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 972d436e-7a77-4b8b-deff-08d9e5e64b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1356
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 01, 2022 at 10:28:39PM +0100, Borislav Petkov wrote:
> On Tue, Feb 01, 2022 at 02:35:07PM -0600, Michael Roth wrote:
> > Unfortunately rdmsr()/wrmsr()/__rdmsr()/__wrmsr() etc. definitions are all
> > already getting pulled in via:
> > 
> >   misc.h:
> >     #include linux/elf.h
> >       #include linux/thread_info.h
> >         #include linux/cpufeature.h
> >           #include linux/processor.h
> >             #include linux/msr.h
> > 
> > Those definitions aren't usable in boot/compressed because of __ex_table
> > and possibly some other dependency hellishness.
> 
> And they should not be. Mixing kernel proper and decompressor code needs
> to stop and untangling that is a multi-year effort, unfortunately. ;-\
> 
> > Would read_msr()/write_msr() be reasonable alternative names for these new
> > helpers, or something else that better distinguishes them from the
> > kernel proper definitions?
> 
> Nah, just call them rdmsr/wrmsr(). There is already {read,write}_msr()
> tracepoint symbols in kernel proper and there's no point in keeping them
> apart using different names - that ship has long sailed.

Since the kernel proper rdmsr()/wrmsr() definitions are getting pulled in via
misc.h, I have to use a different name to avoid compiler errors. For now I've
gone with rd_msr()/wr_msr(), but no problem changing those if needed.

> > Should we introduce something like this as well for cpucheck.c? Or
> > re-write cpucheck.c to make use of the u64 versions? Or just set the
> > cpucheck.c rework aside for now? (but still introduce the above helpers
> > as boot/msr.h in preparation)?
> 
> How about you model it after
> 
> static int msr_read(u32 msr, struct msr *m)
> 
> from arch/x86/lib/msr.c which takes struct msr from which you can return
> either u32s or a u64?
> 
> The stuff you share between the decompressor and kernel proper you put
> in a arch/x86/include/asm/shared/ folder, for an example, see what we do
> there in the TDX patchset:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20220124150215.36893-11-kirill.shutemov%40linux.intel.com&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C1662b963f1c54f3663df08d9e5c9d6bd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637793477399827883%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=rtdo9ci3XjOHn2HphvNE7ciFR6tKh1pVclFuNhXkNGs%3D&amp;reserved=0
> 
> I.e., you move struct msr in such a shared header and then you include
> it everywhere needed.
> 
> The arch/x86/boot/ msr helpers are then plain and simple, without
> tracepoints and exception fixups and you define them in ...boot/msr.c or
> so.
> 
> If the patch gets too big, make sure to split it in a couple so that it
> is clear what happens at each step.
> 
> How does that sound?

Thanks for the suggestions, this works out nicely, but as far as defining
them in boot/msr.c, it looks like the Makefile in boot/compressed doesn't
currently have any instances of linking to objects in boot/, and the status
quo seems to be #include'ing the whole C file in cases where boot/ code is
needed in boot/compressed.

Since the rd_msr/wr_msr are oneliners, it seemed like it might be a
little cleaner to just define them in boot/msr.h as static inline and
include them directly as part of the header.

Here's what it looks like on top of this tree, and roughly how I plan to
split the patches for v10:

- define the rd_msr/wr_msr helpers
  https://github.com/mdroth/linux/commit/982c6c5741478c8f634db8ac0ba36575b5eff946

- use the helpers in boot/compressed/sev.c and boot/cpucheck.c
  https://github.com/mdroth/linux/commit/a16e11f727c01fc478d3b741e1bdd2fd44975d7c

For v10 though I'll likely just drop rd_sev_status_msr() completely and use
rd_msr() directly.

Let me know if I should make any changes and I'll make sure to get those in for
the next spin.

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C1662b963f1c54f3663df08d9e5c9d6bd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637793477399827883%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=njDai06MS2mcyMLZ5YvLMcgXSXwfoO01U2c0D%2BE3HG4%3D&amp;reserved=0
