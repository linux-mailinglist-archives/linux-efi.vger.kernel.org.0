Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07D5AF320
	for <lists+linux-efi@lfdr.de>; Tue,  6 Sep 2022 19:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiIFRvF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Sep 2022 13:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIFRvA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Sep 2022 13:51:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE0B91D13
        for <linux-efi@vger.kernel.org>; Tue,  6 Sep 2022 10:50:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id nc14so25006518ejc.4
        for <linux-efi@vger.kernel.org>; Tue, 06 Sep 2022 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7H88wtMLkwMZAvD9kp2P0Vp7n5A+FDLfMvNgtrBAFZI=;
        b=CpW76y4yb0M3A5frtu1VM1KKgIg8n8jEvX+12EYSA8E8JNqez26Pr6wxP6az9uACYu
         pjNnmBNbYPfFKQp/E9VIA22qWEn+ihBZnsNeIff5hwAw9DabKprL6AFh2YGbFVIBZa0R
         iM2lHoMbWrDkAub5QZzHg0vXj5VnVn5AicjGCVCld5BqLcXILMNbMafvIyHuG2Ta7ROt
         lXvc+hlvzYbEfijbS/ATmEqJxnZnTIAIH/X2sH9XQiqoTc7QToLbezY/FJQr4s28Imtb
         AKi6F6Q3m3w1OcF5cv/hOKxPiblwa+cwAtrBQhIsDny4fKqQaWL2/NbrSY9jr9Qk3UBd
         ikLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7H88wtMLkwMZAvD9kp2P0Vp7n5A+FDLfMvNgtrBAFZI=;
        b=rscXuaQe6uqqhZExWZVFauJSbfVMEYqNjW0zqyLTJTexFRBCpmbZTrqzy56ZwtmyEe
         gMT36K0THHgFoFJ+i3WdBmInQjezpQOSIoULzMQotD66YhpesFHLLi/VzFPw6v8RXLBo
         eLFeta2GD87imya3MoG4oErsF1LQCXbGBqqRZ6lzPslJDaeyW2WCGZ2V/b43XvCsE59b
         k3FQGusNuj2Booalp5YiRjX1BSrdg838fH6ldToFSwTeXF6Tv0DDQpNLH9sJDpKFHEl3
         xkNSnatdnUnKg6lBc2zhBTDGO9cznq4HMDZh7/n6siiOsZJ06u8MUpHDUx9bzhUO7xbk
         PD1w==
X-Gm-Message-State: ACgBeo3DnLJgRKvM97Oyxhiv62HrMhp3BdFEMQJcW1G3QnxLSGZebrc3
        G7FaWsuPxwBr+z0yUdLgzr1HiP0Y6QVG8iJfDAo8pQ==
X-Google-Smtp-Source: AA6agR7DkXf6FiVxQK2H6sJf/DSun78ukMecD+qq+aDjb6xxfkToyzJIKkZpxYuvOsTTNgPvpEgnH9T2PC5JHkfPyjg=
X-Received: by 2002:a17:906:9b87:b0:733:1795:2855 with SMTP id
 dd7-20020a1709069b8700b0073317952855mr40060290ejc.156.1662486653199; Tue, 06
 Sep 2022 10:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com> <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
 <20220810141959.ictqchz7josyd7pt@techsingularity.net> <CAAH4kHa6s3sBRySNu-TZG_6vOaN4KheVy4kvxG5s=wOTDGy2=Q@mail.gmail.com>
 <2981e25e-9cda-518a-9750-b8694f2356b5@amd.com> <CAAH4kHbcfnVWNQHf6Mrg__bSFT6196Sx4kno6o0Zo7hsgOgnNw@mail.gmail.com>
 <984e07ed-914f-93ca-a141-3fc8677878e0@intel.com>
In-Reply-To: <984e07ed-914f-93ca-a141-3fc8677878e0@intel.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 6 Sep 2022 10:50:42 -0700
Message-ID: <CAAH4kHawguTEuDVyz1ysSbH0X_mT=SvxLi=UhwEzXM0abbWefg@mail.gmail.com>
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
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

>
> It really helps this kind of stuff if you can post the *actual* error.
> I assume this was a page fault, so there should have been some other
> stuff before the RIP:...
>

I posted the error on August 15th.  I was bumping in my last post
since I confirmed with Tom Lendacky that it wasn't AMD's patches at
fault.
Here's a new dump below that matches the disassembly:

[    0.043137] Faking a node at [mem 0x0000000000000000-0x000000403fffffff]
[    0.044018] NODE_DATA(0) allocated [mem 0x403fffc000-0x403fffffff]
[    0.044922] Zone ranges:
[    0.045250]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.046039]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.046828]   Normal   [mem 0x0000000100000000-0x000000403fffffff]
[    0.047657] Movable zone start for each node
[    0.048201] Early memory node ranges
[    0.048674]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.049474]   node   0: [mem 0x0000000000100000-0x000000000080cfff
[    0.050274]   node   0: [mem 0x000000000080f000-0x00000000beceefff]
[    0.051074]   node   0: [mem 0x00000000befff000-0x00000000bfbb0fff]
[    0.051874]   node   0: [mem 0x00000000bfbb2000-0x00000000bffdbfff]
[    0.052674]   node   0: [mem 0x0000000100000000-0x000000403fffffff]
[    0.053530] Initmem setup node 0 [mem 0x0000000000001000-0x000000403fffffff]
PANIC: Unsupported exit-code 0x404 in early #VC exception (IP:
0xfffffffface0cdd0)
[    0.056667] CPU: 0 PID: 0 Comm: swapper Not tainted
5.17.0-rc6-173762-gffb12b02c6d7-dirty #1
[    0.057744] Hardware name: Google Google Compute Engine/Google
Compute Engine, BIOS Google 01/01/2011
[    0.058920] RIP: 0010:memmap_init_range+0x11d/0x188
[    0.059686] Code: 77 16 f6 42 10 02 74 10 48 03 42 08 48 c1 e8 0c
48 89 c3 e9 3a ff ff ff 48 89 df 48 c1 e7 06 48 03 3d a4 1e 65 ff 48
8d 47 08 <c7> 47 34 01 00 00 00 48 c7 47 38 00 00 00 00 c7 47 30 ff ff
ff ff
[    0.062121] RSP: 0000:ffffffffac603dc0 EFLAGS: 00010082 ORIG_RAX:
0000000000000404
[    0.063087] RAX: ffffda1ac0000048 RBX: 0000000000000001 RCX: 0000000000000000
[    0.063998] RDX: 0300000000000000 RSI: 0000000000000000 RDI: ffffda1ac000004
[    0.064944] RBP: 0000000000000000 R08: 0000000000001000 R09: 0000000000000000
[    0.065873] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[    0.066782] R13: 00000000000000a0 R14: 0000000000000000 R15: 0000000000000000
[    0.067695] FS:  0000000000000000(0000) GS:ffffffffacd88000(0000)
knlGS:0000000000000000
[    0.068727] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.069488] CR2: ffffda1ac0000074 CR3: 00080020b680c000 CR4: 00000000000606b0
[    0.070397] Call Trace:
[    0.070710]  <TASK>
[    0.070976]  ? free_area_init+0x724/0x7d4
[    0.071486]  ? zone_sizes_init+0x52/0x6c
[    0.071986]  ? setup_arch+0xa55/0xb77
[    0.072453]  ? start_kernel+0x64/0x65f
[    0.072931]  ? secondary_startup_64_no_verify+0xd6/0xdb
[    0.073598]  </TASK>

Note this is a crash in SEV-SNP, but I assume we'd get the same #VE in TDX.

> Another thing that's really nice is to do the disassembly of the "Code:"
> or share disassembly of memmap_init_range.

0000000000000172 <memmap_init_range>:
 172:   41 56                   push   %r14
 174:   89 f0                   mov    %esi,%eax
 176:   45 89 ce                mov    %r9d,%r14d
 179:   41 55                   push   %r13
 17b:   4c 8d 2c 39             lea    (%rcx,%rdi,1),%r13
 17f:   41 54                   push   %r12
 181:   49 89 d4                mov    %rdx,%r12
 184:   49 8d 55 ff             lea    -0x1(%r13),%rdx
 188:   48 3b 15 00 00 00 00    cmp    0x0(%rip),%rdx        # 18f
<memmap_init_range+0x1d>
 18f:   55                      push   %rbp
 190:   53                      push   %rbx
 191:   48 89 cb                mov    %rcx,%rbx
 194:   76 07                   jbe    19d <memmap_init_range+0x2b>
 196:   48 89 15 00 00 00 00    mov    %rdx,0x0(%rip)        # 19d
<memmap_init_range+0x2b>
 19d:   4c 89 e5                mov    %r12,%rbp
 1a0:   ba 03 00 00 00          mov    $0x3,%edx
 1a5:   48 c1 e0 3a             shl    $0x3a,%rax
 1a9:   48 c1 e5 38             shl    $0x38,%rbp
 1ad:   48 c1 e2 38             shl    $0x38,%rdx
 1b1:   48 21 d5                and    %rdx,%rbp
 1b4:   48 09 c5                or     %rax,%rbp
 1b7:   49 39 dd                cmp    %rbx,%r13
 1ba:   0f 86 31 01 00 00       jbe    2f1 <memmap_init_range+0x17f>
 1c0:   45 85 f6                test   %r14d,%r14d
 1c3:   0f 85 b4 00 00 00       jne    27d <memmap_init_range+0x10b>
 1c9:   49 83 fc 03             cmp    $0x3,%r12
 1cd:   0f 94 c1                sete   %cl
 1d0:   22 0d 00 00 00 00       and    0x0(%rip),%cl        # 1d6
<memmap_init_range+0x64>
 1d6:   0f 84 a1 00 00 00       je     27d <memmap_init_range+0x10b>
 1dc:   48 8b 15 00 00 00 00    mov    0x0(%rip),%rdx        # 1e3
<memmap_init_range+0x71>
 1e3:   48 85 d2                test   %rdx,%rdx
 1e6:   74 10                   je     1f8 <memmap_init_range+0x86>
 1e8:   48 8b 42 08             mov    0x8(%rdx),%rax
 1ec:   48 03 02                add    (%rdx),%rax
 1ef:   48 c1 e8 0c             shr    $0xc,%rax
 1f3:   48 39 d8                cmp    %rbx,%rax
 1f6:   77 55                   ja     24d <memmap_init_range+0xdb>
 1f8:   48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 1ff
<memmap_init_range+0x8d>
 1ff:   4c 6b 05 00 00 00 00    imul   $0x18,0x0(%rip),%r8        #
207 <memmap_init_range+0x95>
 206:   18
 207:   31 f6                   xor    %esi,%esi
 209:   48 89 05 00 00 00 00    mov    %rax,0x0(%rip)        # 210
<memmap_init_range+0x9e>
 210:   49 01 c0                add    %rax,%r8
 213:   48 89 c7                mov    %rax,%rdi
 216:   4c 39 c0                cmp    %r8,%rax
 219:   73 26                   jae    241 <memmap_init_range+0xcf>
 21b:   48 8b 57 08             mov    0x8(%rdi),%rdx
 21f:   48 03 17                add    (%rdi),%rdx
 222:   48 83 c0 18             add    $0x18,%rax
 226:   48 c1 ea 0c             shr    $0xc,%rdx
 22a:   48 39 da                cmp    %rbx,%rdx
 22d:   76 0e                   jbe    23d <memmap_init_range+0xcb>
 22f:   40 84 f6                test   %sil,%sil
 232:   74 19                   je     24d <memmap_init_range+0xdb>
 234:   48 89 3d 00 00 00 00    mov    %rdi,0x0(%rip)        # 23b
<memmap_init_range+0xc9>
 23b:   eb 10                   jmp    24d <memmap_init_range+0xdb>
 23d:   89 ce                   mov    %ecx,%esi
 23f:   eb d2                   jmp    213 <memmap_init_range+0xa1>
 241:   40 84 f6                test   %sil,%sil
 244:   74 07                   je     24d <memmap_init_range+0xdb>
 246:   48 89 05 00 00 00 00    mov    %rax,0x0(%rip)        # 24d
<memmap_init_range+0xdb>
 24d:   48 8b 15 00 00 00 00    mov    0x0(%rip),%rdx        # 254
<memmap_init_range+0xe2>
 254:   48 8b 02                mov    (%rdx),%rax
 257:   48 8d 88 ff 0f 00 00    lea    0xfff(%rax),%rcx
 25e:   48 c1 e9 0c             shr    $0xc,%rcx
 262:   48 39 d9                cmp    %rbx,%rcx
 265:   77 16                   ja     27d <memmap_init_range+0x10b>
 267:   f6 42 10 02             testb  $0x2,0x10(%rdx)
 26b:   74 10                   je     27d <memmap_init_range+0x10b>
 26d:   48 03 42 08             add    0x8(%rdx),%rax
 271:   48 c1 e8 0c             shr    $0xc,%rax
 275:   48 89 c3                mov    %rax,%rbx
 278:   e9 3a ff ff ff          jmp    1b7 <memmap_init_range+0x45>
 27d:   48 89 df                mov    %rbx,%rdi
 280:   48 c1 e7 06             shl    $0x6,%rdi
 284:   48 03 3d 00 00 00 00    add    0x0(%rip),%rdi        # 28b
<memmap_init_range+0x119>
 28b:   48 8d 47 08             lea    0x8(%rdi),%rax
 28f:   c7 47 34 01 00 00 00    movl   $0x1,0x34(%rdi)    # Here's
where the crash RIP is.
 296:   48 c7 47 38 00 00 00    movq   $0x0,0x38(%rdi)
 29d:   00
 29e:   c7 47 30 ff ff ff ff    movl   $0xffffffff,0x30(%rdi)
 2a5:   48 c7 47 28 00 00 00    movq   $0x0,0x28(%rdi)
 2ac:   00
 2ad:   48 c7 47 20 00 00 00    movq   $0x0,0x20(%rdi)
 2b4:   00
 2b5:   48 c7 47 18 00 00 00    movq   $0x0,0x18(%rdi)
 2bc:   00
 2bd:   48 89 2f                mov    %rbp,(%rdi)
 2c0:   48 89 47 08             mov    %rax,0x8(%rdi)
 2c4:   48 89 47 10             mov    %rax,0x10(%rdi)
 2c8:   41 83 fe 01             cmp    $0x1,%r14d
 2cc:   75 05                   jne    2d3 <memmap_init_range+0x161>
 2ce:   48 0f ba 2f 0c          btsq   $0xc,(%rdi)
 2d3:   f7 c3 ff 01 00 00       test   $0x1ff,%ebx
 2d9:   75 0e                   jne    2e9 <memmap_init_range+0x177>
 2db:   8b 74 24 38             mov    0x38(%rsp),%esi
 2df:   e8 00 00 00 00          call   2e4 <memmap_init_range+0x172>
 2e4:   e8 00 00 00 00          call   2e9 <memmap_init_range+0x177>
 2e9:   48 ff c3                inc    %rbx
 2ec:   e9 c6 fe ff ff          jmp    1b7 <memmap_init_range+0x45>
 2f1:   5b                      pop    %rbx
 2f2:   5d                      pop    %rbp
 2f3:   41 5c                   pop    %r12
 2f5:   41 5d                   pop    %r13
 2f7:   41 5e                   pop    %r14
 2f9:   c3                      ret

> Even nicer would be to give
> an faddr2line of the RIP value and track down which C code was actually
> at fault.

arch_atomic_set
arch/x86/include/asm/atomic.h:41

of INIT_LIST_HEAD in __init_single_page, called from memmap_init_range.
--
-Dionna Glaze, PhD (she/her)
