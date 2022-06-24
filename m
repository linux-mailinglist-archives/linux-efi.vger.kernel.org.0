Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2F1559EA2
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiFXQha (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 12:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiFXQh3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 12:37:29 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EDA4E38E
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 09:37:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s10so3346771ljh.12
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RkDI0H3V8ffCzpx/7oBooTk7SI+tThMooS0/flQ46ts=;
        b=Wr83A7dczmTD19uiTfoSAwDd1VOxB9w/zd7eUUBaGU4oLKHJsWFWQzgu29QD1WDW9a
         CYCRIOSpwM/n8B8RHU1RDoKuQDPC39kNU2yu28+7AqBZLu5iGSFCQaBpNxkjRaC2+EAY
         r9dKe0mcb1dqgtXx6ikkcy7z+3rtDy81bUeGKWXQC+ScidmX7pGWyPQ6XHDob4RAKz8t
         uG69IrK44JpGz3zqi1jdMgNTdiU0Q5ifIxUWPAjOvy6fmhgKuHokVm9fd5cRII+5XYKs
         DfNoPK6DoJm7qn4DuZbToUszNVkxAgcJX10mahR+ovylbHc70v9s1xmEK5S6RFQf3Dbl
         /Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RkDI0H3V8ffCzpx/7oBooTk7SI+tThMooS0/flQ46ts=;
        b=tQHyelnzlpjjYbkf/J7xHhUKauG+JE0vlXfvBHTrrfbExMIY8F7tUC4BkEcYnubDCe
         SFU6L1KhT0Gj5ZzY/myuOC24T0fVLwmdfWRjEH/ysH+8bnYD6FTz2pThyiiMofYT98Mf
         mrrzX2jPOslWpRzBcwgQZUW8AOWq7gwgRr+XiZzWoHA9Ma0KiqQNtexJNnE+NO1G5bin
         Rj3UWcLm5HX0ESPuuvLbrWWk0iX9KRHjsrepTWLyhEsWIA4HHu43yocqVoVtXRu+HlVv
         M8XHjXy/cRvgR+zV00CFYdsX+kA06hbP2GecDZRqFMh1wZ2IG/Dp6NVPJkOnPu1BO9l+
         l/MQ==
X-Gm-Message-State: AJIora9o0BzUYFM6l6oq7r5nwrwx0zPzRfpi6H1zyu8J1hBgoFK7mzvW
        fef+HIOSf3FasOqtkWUZ8gZDK5hqYh9yU7qnTrezKw==
X-Google-Smtp-Source: AGRyM1tn7wjiEPlC9NdGXIzamRcuXNDaXZdehYf2ijcYp1FvPXzVktvfUFGAtBVLzqbWDRxTOiFYc5PcvhD9KSLXHeQ=
X-Received: by 2002:a2e:1f01:0:b0:25a:5960:3c39 with SMTP id
 f1-20020a2e1f01000000b0025a59603c39mr7638432ljf.282.1656088644853; Fri, 24
 Jun 2022 09:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 24 Jun 2022 10:37:10 -0600
Message-ID: <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 14, 2022 at 6:03 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> UEFI Specification version 2.9 introduces the concept of memory
> acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, requiring memory to be accepted before it can be used by the
> guest. Accepting happens via a protocol specific for the Virtual
> Machine platform.
>
> Accepting memory is costly and it makes VMM allocate memory for the
> accepted guest physical address range. It's better to postpone memory
> acceptance until memory is needed. It lowers boot time and reduces
> memory overhead.
>
> The kernel needs to know what memory has been accepted. Firmware
> communicates this information via memory map: a new memory type --
> EFI_UNACCEPTED_MEMORY -- indicates such memory.
>
> Range-based tracking works fine for firmware, but it gets bulky for
> the kernel: e820 has to be modified on every page acceptance. It leads
> to table fragmentation, but there's a limited number of entries in the
> e820 table
>
> Another option is to mark such memory as usable in e820 and track if the
> range has been accepted in a bitmap. One bit in the bitmap represents
> 2MiB in the address space: one 4k page is enough to track 64GiB or
> physical address space.
>
> In the worst-case scenario -- a huge hole in the middle of the
> address space -- It needs 256MiB to handle 4PiB of the address
> space.
>
> Any unaccepted memory that is not aligned to 2M gets accepted upfront.
>
> The approach lowers boot time substantially. Boot to shell is ~2.5x
> faster for 4G TDX VM and ~4x faster for 64G.
>
> TDX-specific code isolated from the core of unaccepted memory support. It
> supposed to help to plug-in different implementation of unaccepted memory
> such as SEV-SNP.
>
> The tree can be found here:
>
> https://github.com/intel/tdx.git guest-unaccepted-memory

Hi Kirill,

I have a couple questions about this feature mainly about how cloud
customers can use this, I assume since this is a confidential compute
feature a large number of the users of these patches will be cloud
customers using TDX and SNP. One issue I see with these patches is how
do we as a cloud provider know whether a customer's linux image
supports this feature, if the image doesn't have these patches UEFI
needs to fully validate the memory, if the image does we can use this
new protocol. In GCE we supply our VMs with a version of the EDK2 FW
and the customer doesn't input into which UEFI we run, as far as I can
tell from the Azure SNP VM documentation it seems very similar. We
need to somehow tell our UEFI in the VM what to do based on the image.
The current way I can see to solve this issue would be to have our
customers give us metadata about their VM's image but this seems kinda
burdensome on our customers (I assume we'll have more features which
both UEFI and kernel need to both support inorder to be turned on like
this one) and error-prone, if a customer incorrectly labels their
image it may fail to boot.. Has there been any discussion about how to
solve this? My naive thoughts were what if UEFI and Kernel had some
sort of feature negotiation. Maybe that could happen via an extension
to exit boot services or a UEFI runtime driver, I'm not sure what's
best here just some ideas.



>
> v7:
>  - Rework meminfo counter to use PageUnaccepted() and move to generic code;
>  - Fix range_contains_unaccepted_memory() on machines without unaccepted memory;
>  - Add Reviewed-by from David;
> v6:
>  - Fix load_unaligned_zeropad() on machine with unaccepted memory;
>  - Clear PageUnaccepted() on merged pages, leaving it only on head;
>  - Clarify error handling in allocate_e820();
>  - Fix build with CONFIG_UNACCEPTED_MEMORY=y, but without TDX;
>  - Disable kexec at boottime instead of build conflict;
>  - Rebased to tip/master;
>  - Spelling fixes;
>  - Add Reviewed-by from Mike and David;
> v5:
>  - Updates comments and commit messages;
>    + Explain options for unaccepted memory handling;
>  - Expose amount of unaccepted memory in /proc/meminfo
>  - Adjust check in page_expected_state();
>  - Fix error code handling in allocate_e820();
>  - Centralize __pa()/__va() definitions in the boot stub;
>  - Avoid includes from the main kernel in the boot stub;
>  - Use an existing hole in boot_param for unaccepted_memory, instead of adding
>    to the end of the structure;
>  - Extract allocate_unaccepted_memory() form allocate_e820();
>  - Complain if there's unaccepted memory, but kernel does not support it;
>  - Fix vmstat counter;
>  - Split up few preparatory patches;
>  - Random readability adjustments;
> v4:
>  - PageBuddyUnaccepted() -> PageUnaccepted;
>  - Use separate page_type, not shared with offline;
>  - Rework interface between core-mm and arch code;
>  - Adjust commit messages;
>  - Ack from Mike;
>
> Kirill A. Shutemov (14):
>   x86/boot: Centralize __pa()/__va() definitions
>   mm: Add support for unaccepted memory
>   mm: Report unaccepted memory in meminfo
>   efi/x86: Get full memory map in allocate_e820()
>   x86/boot: Add infrastructure required for unaccepted memory support
>   efi/x86: Implement support for unaccepted memory
>   x86/boot/compressed: Handle unaccepted memory
>   x86/mm: Reserve unaccepted memory bitmap
>   x86/mm: Provide helpers for unaccepted memory
>   x86/mm: Avoid load_unaligned_zeropad() stepping into unaccepted memory
>   x86: Disable kexec if system has unaccepted memory
>   x86/tdx: Make _tdx_hypercall() and __tdx_module_call() available in
>     boot stub
>   x86/tdx: Refactor try_accept_one()
>   x86/tdx: Add unaccepted memory support
>
>  Documentation/x86/zero-page.rst          |   1 +
>  arch/x86/Kconfig                         |   1 +
>  arch/x86/boot/bitops.h                   |  40 ++++++++
>  arch/x86/boot/compressed/Makefile        |   1 +
>  arch/x86/boot/compressed/align.h         |  14 +++
>  arch/x86/boot/compressed/bitmap.c        |  43 ++++++++
>  arch/x86/boot/compressed/bitmap.h        |  49 +++++++++
>  arch/x86/boot/compressed/bits.h          |  36 +++++++
>  arch/x86/boot/compressed/compiler.h      |   9 ++
>  arch/x86/boot/compressed/efi.h           |   1 +
>  arch/x86/boot/compressed/find.c          |  54 ++++++++++
>  arch/x86/boot/compressed/find.h          |  80 +++++++++++++++
>  arch/x86/boot/compressed/ident_map_64.c  |   8 --
>  arch/x86/boot/compressed/kaslr.c         |  35 ++++---
>  arch/x86/boot/compressed/math.h          |  37 +++++++
>  arch/x86/boot/compressed/mem.c           | 111 ++++++++++++++++++++
>  arch/x86/boot/compressed/minmax.h        |  61 +++++++++++
>  arch/x86/boot/compressed/misc.c          |   6 ++
>  arch/x86/boot/compressed/misc.h          |  15 +++
>  arch/x86/boot/compressed/pgtable_types.h |  25 +++++
>  arch/x86/boot/compressed/sev.c           |   2 -
>  arch/x86/boot/compressed/tdx.c           |  78 ++++++++++++++
>  arch/x86/coco/tdx/tdx.c                  |  94 ++++++++---------
>  arch/x86/include/asm/page.h              |   3 +
>  arch/x86/include/asm/shared/tdx.h        |  47 +++++++++
>  arch/x86/include/asm/tdx.h               |  19 ----
>  arch/x86/include/asm/unaccepted_memory.h |  16 +++
>  arch/x86/include/uapi/asm/bootparam.h    |   2 +-
>  arch/x86/kernel/e820.c                   |  10 ++
>  arch/x86/mm/Makefile                     |   2 +
>  arch/x86/mm/unaccepted_memory.c          | 123 +++++++++++++++++++++++
>  drivers/base/node.c                      |   7 ++
>  drivers/firmware/efi/Kconfig             |  14 +++
>  drivers/firmware/efi/efi.c               |   1 +
>  drivers/firmware/efi/libstub/x86-stub.c  | 103 ++++++++++++++++---
>  fs/proc/meminfo.c                        |   5 +
>  include/linux/efi.h                      |   3 +-
>  include/linux/mmzone.h                   |   1 +
>  include/linux/page-flags.h               |  31 ++++++
>  mm/internal.h                            |  12 +++
>  mm/memblock.c                            |   9 ++
>  mm/page_alloc.c                          |  96 +++++++++++++++++-
>  mm/vmstat.c                              |   1 +
>  43 files changed, 1191 insertions(+), 115 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/align.h
>  create mode 100644 arch/x86/boot/compressed/bitmap.c
>  create mode 100644 arch/x86/boot/compressed/bitmap.h
>  create mode 100644 arch/x86/boot/compressed/bits.h
>  create mode 100644 arch/x86/boot/compressed/compiler.h
>  create mode 100644 arch/x86/boot/compressed/find.c
>  create mode 100644 arch/x86/boot/compressed/find.h
>  create mode 100644 arch/x86/boot/compressed/math.h
>  create mode 100644 arch/x86/boot/compressed/mem.c
>  create mode 100644 arch/x86/boot/compressed/minmax.h
>  create mode 100644 arch/x86/boot/compressed/pgtable_types.h
>  create mode 100644 arch/x86/include/asm/unaccepted_memory.h
>  create mode 100644 arch/x86/mm/unaccepted_memory.c
>
> --
> 2.35.1
>
>
