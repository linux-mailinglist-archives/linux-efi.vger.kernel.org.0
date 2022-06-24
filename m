Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E26255A05B
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiFXRla (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 13:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiFXRlS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 13:41:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E562C28;
        Fri, 24 Jun 2022 10:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj/GJCds4qn57xzx0iohRB+ipfpKc1qdroqYVvPeSh00rGsfMCXcajQ9coOWWJj0HmV6TU5Lwv9OYqrVS9v8LBM8tFCrZz+KIEcQ/dgHihUB4GJ/fTO6MIpf9DqO5yBRA/tbLkEbzxzUhPYUZIQQupYMs9JGCgrLc7wZGvLJ5JsucXRD7zrZ0l719JiXcdhhOCNkAv+hMNIxviLXANQCdgpYL8zAs9163BwiPNCPIJ4Ox9ObisXNmkgyHm+1TrhpqVklW+OeYrZAaoWr4m8eNrOoIT6skRuwZDGNaVaRKEeGKwu8xbfBZIgPdYU5QmL4OfHppz0phoN0x2AfKR5Vzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drMceoozm68gaq8isNTUBlf+jgkiqfKvWFZ21IfZoU0=;
 b=lZZllByTJIVsR+1S0dM1ZcdVvzOZnReo7sUgyDlJZfSfCpI3Rt2RBwQA77ynHzLI4e1fOTMrFsTvKOWFE2cb0CKhdzpzQXL/k52ZE3e1o9c2TJwrGfN4eUAi48+cfdktSMQukTufQVpcTV2S2pY5PPMQabSJ0QkK8rX34YS6MMGKN6pNa5qtccybQPSi3z01Zd9PGQC0lTqgP1ZFusbB8I/fRiYmSlxEPmoF7zo1rg5h5gTfDP6w6oyM+MNsmyVj/OA+SHQC6xcFy5yX5msuXnbpKiIdHrl4zJh1wJWCKEj4Vc3rZlkS8xrJo4m0/Oy+4i12pyafGWYXxlJLo7ZDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drMceoozm68gaq8isNTUBlf+jgkiqfKvWFZ21IfZoU0=;
 b=m2juGD9g04kO18yBxRzNerxWpL3FKkBq2Wr/OIZYgTe/sIDKrSqr9R+Vh3NwViHTR95/LBmE2P4oGZlQ1/3lhLcwpbzFn3yeG9BmWFPnN8+3J7xRdjXqDHHvM2ad0ohqJZfPNP2H1b43k0e+gE39TPrvbmUKaWaPgI6rIjfVxCE=
Received: from BN6PR13CA0062.namprd13.prod.outlook.com (2603:10b6:404:11::24)
 by MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 17:41:13 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::75) by BN6PR13CA0062.outlook.office365.com
 (2603:10b6:404:11::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.7 via Frontend
 Transport; Fri, 24 Jun 2022 17:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 17:41:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 24 Jun
 2022 12:41:12 -0500
Date:   Fri, 24 Jun 2022 12:40:57 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Peter Gonda <pgonda@google.com>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
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
        "Mike Rapoport" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        <marcelo.cerri@canonical.com>, <tim.gardner@canonical.com>,
        <khalid.elmously@canonical.com>, <philip.cox@canonical.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, <linux-mm@kvack.org>,
        <linux-coco@lists.linux.dev>, <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Message-ID: <20220624174057.72dwo7v36lokmoub@amd.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 395ad975-a880-4d2d-abf9-08da5608bb65
X-MS-TrafficTypeDiagnostic: MN2PR12MB3455:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfv2WeDE7duPbCY4Ou7Jb8d5uwbIa+nv+yboFnjwuaNxm/m2gO/IYGL236Ks6UkbzbYxhiApHMEmqsuyki7nnNFBuvH6uyv4WMLS928Km7/4EV2qYG/yPDo9EG/x8mVzPIE2dzzWfaSQPOfARN3JSLKmIg4eSEqD9N4cXf6Dm4vxrjotoCnqbL1SiDnaefaQfVQCrth7yRp0Er4UKJz4dutoygAc2W9cjl2gJnLuSZgt8K+eXQ8qvnk3903dT/MD6RnbqRK5c6847lO6QIT50MadsTMC8VJ593Ly/ngPYz+jZ6N/XBMwBD3AJMh2BoEoqnx4U6iOFq0cEZPXk+7yhg4jGwNwZZ5AxyNWqcsXE7E30t6575CroYrsjzjOol/2mKrd89JiJDtzC4YFvluTiIfIiOekdMCaHnPfYWY6+h4rmrnHSrmNWqSETlqM3V6USLS9wz6BSa2sHyE/X+bl8h2yiobFpH5nJS1osZV0YedCFnX8IEk3b4gv2Ax6kpyuuBk1nAYaPEND5qX2o4arpXSByRdEe+mNu4WQPpO0ZaXIMc6g893aUfdLvawb8Ex8P/kpReXCJJw0YSkVMxNa5rzqV8NQnnad0qwJw9t63HPKrhYicU3G+fN8JWMNbClmZtAigUDBdM161IJaB4tRfgLfr39rEiVoezbm16JEJwAV/68cXrVK1+wfNqVJjs8YmXO84HDroXNa9laFJQck3U71m16PCi/r2ggEanxGdGaCMvZG105hVz4UlotvEu+5qJ9XtRpxM715seWHbceggxsvneYIi69fNevhW9RImTPCRlIGgCNbCLY4p4Kw5lIw41wAsrvZEbLYYHc2x2zdWw/9T/2ckJKslifrrkWnZPY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(40470700004)(36840700001)(478600001)(1076003)(53546011)(86362001)(54906003)(8936002)(40480700001)(36860700001)(7416002)(26005)(5660300002)(2616005)(336012)(966005)(186003)(7406005)(44832011)(426003)(82310400005)(47076005)(70206006)(16526019)(40460700003)(316002)(81166007)(70586007)(2906002)(356005)(41300700001)(45080400002)(82740400003)(6666004)(36756003)(4326008)(83380400001)(6916009)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 17:41:12.9294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 395ad975-a880-4d2d-abf9-08da5608bb65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3455
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 24, 2022 at 10:37:10AM -0600, Peter Gonda wrote:
> On Tue, Jun 14, 2022 at 6:03 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > UEFI Specification version 2.9 introduces the concept of memory
> > acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
> > SEV-SNP, requiring memory to be accepted before it can be used by the
> > guest. Accepting happens via a protocol specific for the Virtual
> > Machine platform.
> >
> > Accepting memory is costly and it makes VMM allocate memory for the
> > accepted guest physical address range. It's better to postpone memory
> > acceptance until memory is needed. It lowers boot time and reduces
> > memory overhead.
> >
> > The kernel needs to know what memory has been accepted. Firmware
> > communicates this information via memory map: a new memory type --
> > EFI_UNACCEPTED_MEMORY -- indicates such memory.
> >
> > Range-based tracking works fine for firmware, but it gets bulky for
> > the kernel: e820 has to be modified on every page acceptance. It leads
> > to table fragmentation, but there's a limited number of entries in the
> > e820 table
> >
> > Another option is to mark such memory as usable in e820 and track if the
> > range has been accepted in a bitmap. One bit in the bitmap represents
> > 2MiB in the address space: one 4k page is enough to track 64GiB or
> > physical address space.
> >
> > In the worst-case scenario -- a huge hole in the middle of the
> > address space -- It needs 256MiB to handle 4PiB of the address
> > space.
> >
> > Any unaccepted memory that is not aligned to 2M gets accepted upfront.
> >
> > The approach lowers boot time substantially. Boot to shell is ~2.5x
> > faster for 4G TDX VM and ~4x faster for 64G.
> >
> > TDX-specific code isolated from the core of unaccepted memory support. It
> > supposed to help to plug-in different implementation of unaccepted memory
> > such as SEV-SNP.
> >
> > The tree can be found here:
> >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel%2Ftdx.git&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C73bacba017c84291482a08da55ffd481%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637916854542432349%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=P%2FUJOL305xo85NLXGxGouQVGHgzLJpmBdNyZ7Re5%2FB0%3D&amp;reserved=0 guest-unaccepted-memory
> 
> Hi Kirill,
> 
> I have a couple questions about this feature mainly about how cloud
> customers can use this, I assume since this is a confidential compute
> feature a large number of the users of these patches will be cloud
> customers using TDX and SNP. One issue I see with these patches is how
> do we as a cloud provider know whether a customer's linux image
> supports this feature, if the image doesn't have these patches UEFI
> needs to fully validate the memory, if the image does we can use this
> new protocol. In GCE we supply our VMs with a version of the EDK2 FW
> and the customer doesn't input into which UEFI we run, as far as I can
> tell from the Azure SNP VM documentation it seems very similar. We
> need to somehow tell our UEFI in the VM what to do based on the image.
> The current way I can see to solve this issue would be to have our
> customers give us metadata about their VM's image but this seems kinda
> burdensome on our customers (I assume we'll have more features which
> both UEFI and kernel need to both support inorder to be turned on like
> this one) and error-prone, if a customer incorrectly labels their

> image it may fail to boot.. Has there been any discussion about how to
> solve this? My naive thoughts were what if UEFI and Kernel had some
> sort of feature negotiation. Maybe that could happen via an extension
> to exit boot services or a UEFI runtime driver, I'm not sure what's
> best here just some ideas.

Not sure if you've seen this thread or not, but there's also been some
discussion around this in the context of the UEFI support:

  https://patchew.org/EDK2/cover.1654420875.git.min.m.xu@intel.com/cce5ea2aaaeddd9ce9df6fa7ac1ef52976c5c7e6.1654420876.git.min.m.xu@intel.com/#20220608061805.vvsjiqt55rqnl3fw@sirius.home.kraxel.org

2 things being discussed there really, which I think roughly boil down
to:

 1) how to configure OVMF to enable/disable lazy acceptance
    - compile time option most likely: accept-all/accept-minimum/accept-1GB

 2) how to introduce an automatic mode in the future where OVMF does the
    right thing based on what the guest supports. Gerd floated the idea of
    tying it to ExitBootServices as well, but not sure there's a solid
    plan on what to do here yet.

If that's accurate, it seems like the only 'safe' option is to disable it via
#1 (accept-all), and then when #2 comes along, compile OVMF to just Do The
Right Thing.

Users who know their VMs implement lazy acceptance can force it on via
accept-all OVMF compile option.

-Mike
