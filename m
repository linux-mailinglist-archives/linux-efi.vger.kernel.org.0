Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D5603A76
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJSHRw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJSHRv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:17:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6FF74E1B;
        Wed, 19 Oct 2022 00:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34C92B8226A;
        Wed, 19 Oct 2022 07:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00F4C43141;
        Wed, 19 Oct 2022 07:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666163866;
        bh=YvithFq/cYXopxc+iHqBIQdCZOupODJtjn7SRJgZ1fQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ns5AMUH+HrkSzQfVN+Hy5qDAxlLuPd6C6uuQcZ1Wt+jV7Wmz3TxR/YFUM/9ZzTd45
         WlPbqaYtJflsZ0Tju3/cfsySv2VimxpwzFcWk5TTkvOYpjFE+hIhqsC8HpcR//olTI
         LREG12/EHhdJ6onCGEwSjEdYAKvwbmv9azmIoQqoc6dfSQJCwdQQOA3tPKHxwPLZeS
         k/08TzVzmJzaOgDhyPdpS+8RM2fUmE7k7ScarIdsNqf4xAHFqmnJ3AxQ2QGSHRnQgV
         ElkbJLuhAAXfOAbS0N5rpuG3epV/vVBZygSPNw6e2tT0h2bMhlOutpZD+lfvrrbHlO
         C0oVZSDYJ+BNA==
Received: by mail-lj1-f172.google.com with SMTP id c20so21001551ljj.7;
        Wed, 19 Oct 2022 00:17:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf3T00d7Q6MozC9/bhHAR2NAHk9YKXVNh9iBgCRkvK5Owc5G8bBC
        8r9+TD29y1J/SRFamm9ldMDlOymyf4k+pAtRjsE=
X-Google-Smtp-Source: AMsMyM63sywhif4p/S9ezxUoWJ61TQ9F1XMUT6otL72X5V7qZF/q983ElzTQcxyA4HhnEs2taX1CQZSLwMAjJMvW8go=
X-Received: by 2002:a2e:9a81:0:b0:26c:5b63:7a83 with SMTP id
 p1-20020a2e9a81000000b0026c5b637a83mr2540850lji.291.1666163864565; Wed, 19
 Oct 2022 00:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662459668.git.baskov@ispras.ru> <2fd61a79a1e6885dc47ec826b62a936dd88a0a16.1662459668.git.baskov@ispras.ru>
In-Reply-To: <2fd61a79a1e6885dc47ec826b62a936dd88a0a16.1662459668.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 09:17:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG59mtzbJoREgr4GA9QJkORcYb-XuDr3VoZ-3XYLy7k2g@mail.gmail.com>
Message-ID: <CAMj1kXG59mtzbJoREgr4GA9QJkORcYb-XuDr3VoZ-3XYLy7k2g@mail.gmail.com>
Subject: Re: [PATCH 06/16] x86/boot: Setup memory protection for bzImage code
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 6 Sept 2022 at 12:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Use previously added code to use 4KB pages for mapping. Map compressed
> and uncompressed kernel with appropriate memory protection attributes.
> For compressed kernel set them up manually. For uncompressed kernel
> used flags specified in ELF header.
>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>
>  delete mode 100644 arch/x86/boot/compressed/pgtable.h
>  create mode 100644 arch/x86/include/asm/shared/pgtable.h
> ---
>  arch/x86/boot/compressed/head_64.S      | 25 ++++++-
>  arch/x86/boot/compressed/ident_map_64.c | 96 ++++++++++++++++---------
>  arch/x86/boot/compressed/misc.c         | 63 ++++++++++++++--
>  arch/x86/boot/compressed/misc.h         | 16 ++++-
>  arch/x86/boot/compressed/pgtable.h      | 20 ------
>  arch/x86/boot/compressed/pgtable_64.c   |  2 +-
>  arch/x86/boot/compressed/sev.c          |  6 +-
>  arch/x86/include/asm/shared/pgtable.h   | 29 ++++++++
>  8 files changed, 193 insertions(+), 64 deletions(-)
>  delete mode 100644 arch/x86/boot/compressed/pgtable.h
>  create mode 100644 arch/x86/include/asm/shared/pgtable.h
>
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 5273367283b7..889ca7176aa7 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -35,7 +35,7 @@
>  #include <asm/bootparam.h>
>  #include <asm/desc_defs.h>
>  #include <asm/trapnr.h>
> -#include "pgtable.h"
> +#include <asm/shared/pgtable.h>
>
>  /*
>   * Locally defined symbols should be marked hidden:
> @@ -578,6 +578,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>         pushq   %rsi
>         call    load_stage2_idt
>
> +       call    startup32_enable_nx_if_supported
>         /* Pass boot_params to initialize_identity_maps() */
>         movq    (%rsp), %rdi
>         call    initialize_identity_maps
> @@ -602,6 +603,28 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>         jmp     *%rax
>  SYM_FUNC_END(.Lrelocated)
>
> +SYM_FUNC_START_LOCAL_NOALIGN(startup32_enable_nx_if_supported)

Why the startup32_ prefix for this function name?

> +       pushq   %rbx
> +
> +       leaq    has_nx(%rip), %rcx
> +
> +       mov     $0x80000001, %eax
> +       cpuid
> +       btl     $20, %edx
> +       jnc     .Lnonx
> +
> +       movl    $1, (%rcx)
> +
> +       movl    $MSR_EFER, %ecx
> +       rdmsr
> +       btsl    $_EFER_NX, %eax
> +       wrmsr
> +
> +.Lnonx:
> +       popq    %rbx
> +       RET
> +SYM_FUNC_END(startup32_enable_nx_if_supported)
> +
>         .code32
>  /*
>   * This is the 32-bit trampoline that will be copied over to low memory.
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index d4a314cc50d6..880e08293023 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -28,6 +28,7 @@
>  #include <asm/trap_pf.h>
>  #include <asm/trapnr.h>
>  #include <asm/init.h>
> +#include <asm/shared/pgtable.h>
>  /* Use the static base for this part of the boot process */
>  #undef __PAGE_OFFSET
>  #define __PAGE_OFFSET __PAGE_OFFSET_BASE
> @@ -86,24 +87,46 @@ phys_addr_t physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>   * Due to relocation, pointers must be assigned at run time not build time.
>   */
>  static struct x86_mapping_info mapping_info;
> +int has_nx;
>
>  /*
>   * Adds the specified range to the identity mappings.
>   */
> -void kernel_add_identity_map(unsigned long start, unsigned long end)
> +unsigned long kernel_add_identity_map(unsigned long start,
> +                                     unsigned long end,
> +                                     unsigned int flags)
>  {
>         int ret;
>
>         /* Align boundary to 2M. */
> -       start = round_down(start, PMD_SIZE);
> -       end = round_up(end, PMD_SIZE);
> +       start = round_down(start, PAGE_SIZE);
> +       end = round_up(end, PAGE_SIZE);
>         if (start >= end)
> -               return;
> +               return start;
> +
> +       /* Enforce W^X -- just stop booting with error on violation. */
> +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) &&
> +           (flags & (MAP_EXEC | MAP_WRITE)) == (MAP_EXEC | MAP_WRITE))
> +               error("Error: W^X violation\n");
> +

Do we need to add a new failure mode here?

> +       bool nx = !(flags & MAP_EXEC) && has_nx;
> +       bool ro = !(flags & MAP_WRITE);
> +
> +       mapping_info.page_flag = sme_me_mask | (nx ?
> +               (ro ? __PAGE_KERNEL_RO : __PAGE_KERNEL) :
> +               (ro ? __PAGE_KERNEL_ROX : __PAGE_KERNEL_EXEC));
>
>         /* Build the mapping. */
> -       ret = kernel_ident_mapping_init(&mapping_info, (pgd_t *)top_level_pgt, start, end);
> +       ret = kernel_ident_mapping_init(&mapping_info,
> +                                       (pgd_t *)top_level_pgt,
> +                                       start, end);
>         if (ret)
>                 error("Error: kernel_ident_mapping_init() failed\n");
> +
> +       if (!(flags & MAP_NOFLUSH))
> +               write_cr3(top_level_pgt);
> +
> +       return start;
>  }
>
>  /* Locates and clears a region for a new top level page table. */
> @@ -112,14 +135,17 @@ void initialize_identity_maps(void *rmode)
>         unsigned long cmdline;
>         struct setup_data *sd;
>
> +       boot_params = rmode;
> +
>         /* Exclude the encryption mask from __PHYSICAL_MASK */
>         physical_mask &= ~sme_me_mask;
>
>         /* Init mapping_info with run-time function/buffer pointers. */
>         mapping_info.alloc_pgt_page = alloc_pgt_page;
>         mapping_info.context = &pgt_data;
> -       mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
> +       mapping_info.page_flag = __PAGE_KERNEL_EXEC | sme_me_mask;
>         mapping_info.kernpg_flag = _KERNPG_TABLE;
> +       mapping_info.allow_4kpages = 1;
>
>         /*
>          * It should be impossible for this not to already be true,
> @@ -154,15 +180,34 @@ void initialize_identity_maps(void *rmode)
>         /*
>          * New page-table is set up - map the kernel image, boot_params and the
>          * command line. The uncompressed kernel requires boot_params and the
> -        * command line to be mapped in the identity mapping. Map them
> -        * explicitly here in case the compressed kernel does not touch them,
> -        * or does not touch all the pages covering them.
> +        * command line to be mapped in the identity mapping.
> +        * Every other accessed memory region is mapped later, if required.
>          */
> -       kernel_add_identity_map((unsigned long)_head, (unsigned long)_end);
> -       boot_params = rmode;
> -       kernel_add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
> +       extern char _head[], _ehead[];

Please move these extern declarations out of the function scope (at
the very least)

> +       kernel_add_identity_map((unsigned long)_head,
> +                               (unsigned long)_ehead, MAP_EXEC | MAP_NOFLUSH);
> +
> +       extern char _compressed[], _ecompressed[];
> +       kernel_add_identity_map((unsigned long)_compressed,
> +                               (unsigned long)_ecompressed, MAP_WRITE | MAP_NOFLUSH);
> +
> +       extern char _text[], _etext[];
> +       kernel_add_identity_map((unsigned long)_text,
> +                               (unsigned long)_etext, MAP_EXEC | MAP_NOFLUSH);
> +
> +       extern char _rodata[], _erodata[];
> +       kernel_add_identity_map((unsigned long)_rodata,
> +                               (unsigned long)_erodata, MAP_NOFLUSH);
> +

Same question as before: do we really need three different regions for
rodata+text here?

> +       extern char _data[], _end[];
> +       kernel_add_identity_map((unsigned long)_data,
> +                               (unsigned long)_end, MAP_WRITE | MAP_NOFLUSH);
> +
> +       kernel_add_identity_map((unsigned long)boot_params,
> +                               (unsigned long)(boot_params + 1), MAP_WRITE | MAP_NOFLUSH);
> +
>         cmdline = get_cmd_line_ptr();
> -       kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
> +       kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE, MAP_NOFLUSH);
>
>         /*
>          * Also map the setup_data entries passed via boot_params in case they
> @@ -172,7 +217,7 @@ void initialize_identity_maps(void *rmode)
>         while (sd) {
>                 unsigned long sd_addr = (unsigned long)sd;
>
> -               kernel_add_identity_map(sd_addr, sd_addr + sizeof(*sd) + sd->len);
> +               kernel_add_identity_map(sd_addr, sd_addr + sizeof(*sd) + sd->len, MAP_NOFLUSH);
>                 sd = (struct setup_data *)sd->next;
>         }
>
> @@ -185,26 +230,11 @@ void initialize_identity_maps(void *rmode)
>  static pte_t *split_large_pmd(struct x86_mapping_info *info,
>                               pmd_t *pmdp, unsigned long __address)
>  {
> -       unsigned long page_flags;
> -       unsigned long address;
> -       pte_t *pte;
> -       pmd_t pmd;
> -       int i;
> -
> -       pte = (pte_t *)info->alloc_pgt_page(info->context);
> +       unsigned long address = __address & PMD_MASK;
> +       pte_t *pte = ident_split_large_pmd(info, pmdp, address);
>         if (!pte)
>                 return NULL;
>
> -       address     = __address & PMD_MASK;
> -       /* No large page - clear PSE flag */
> -       page_flags  = info->page_flag & ~_PAGE_PSE;
> -
> -       /* Populate the PTEs */
> -       for (i = 0; i < PTRS_PER_PMD; i++) {
> -               set_pte(&pte[i], __pte(address | page_flags));
> -               address += PAGE_SIZE;
> -       }
> -
>         /*
>          * Ideally we need to clear the large PMD first and do a TLB
>          * flush before we write the new PMD. But the 2M range of the
> @@ -214,7 +244,7 @@ static pte_t *split_large_pmd(struct x86_mapping_info *info,
>          * also the only user of the page-table, so there is no chance
>          * of a TLB multihit.
>          */
> -       pmd = __pmd((unsigned long)pte | info->kernpg_flag);
> +       pmd_t pmd = __pmd((unsigned long)pte | info->kernpg_flag);
>         set_pmd(pmdp, pmd);
>         /* Flush TLB to establish the new PMD */
>         write_cr3(top_level_pgt);
> @@ -377,5 +407,5 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
>          * Error code is sane - now identity map the 2M region around
>          * the faulting address.
>          */
> -       kernel_add_identity_map(address, end);
> +       kernel_add_identity_map(address, end, MAP_WRITE);
>  }
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index cf690d8712f4..d377e434c4e3 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -14,10 +14,10 @@
>
>  #include "misc.h"
>  #include "error.h"
> -#include "pgtable.h"
>  #include "../string.h"
>  #include "../voffset.h"
>  #include <asm/bootparam_utils.h>
> +#include <asm/shared/pgtable.h>
>
>  /*
>   * WARNING!!
> @@ -277,7 +277,8 @@ static inline void handle_relocations(void *output, unsigned long output_len,
>  { }
>  #endif
>
> -static void parse_elf(void *output)
> +static void parse_elf(void *output, unsigned long output_len,
> +                     unsigned long virt_addr)
>  {
>  #ifdef CONFIG_X86_64
>         Elf64_Ehdr ehdr;
> @@ -287,6 +288,7 @@ static void parse_elf(void *output)
>         Elf32_Phdr *phdrs, *phdr;
>  #endif
>         void *dest;
> +       unsigned long addr;
>         int i;
>
>         memcpy(&ehdr, output, sizeof(ehdr));
> @@ -323,10 +325,50 @@ static void parse_elf(void *output)
>  #endif
>                         memmove(dest, output + phdr->p_offset, phdr->p_filesz);
>                         break;
> -               default: /* Ignore other PT_* */ break;
> +               default:
> +                       /* Ignore other PT_* */
> +                       break;
> +               }
> +       }
> +
> +       handle_relocations(output, output_len, virt_addr);
> +
> +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> +               goto skip_protect;
> +
> +       for (i = 0; i < ehdr.e_phnum; i++) {
> +               phdr = &phdrs[i];
> +
> +               switch (phdr->p_type) {
> +               case PT_LOAD:
> +#ifdef CONFIG_RELOCATABLE
> +                       addr = (unsigned long)output;
> +                       addr += (phdr->p_paddr - LOAD_PHYSICAL_ADDR);
> +#else
> +                       addr = phdr->p_paddr;
> +#endif
> +                       /*
> +                        * Simultaneously readable and writable segments are
> +                        * violating W^X, and should not be present in vmlinux image.
> +                        */
> +                       if ((phdr->p_flags & (PF_X | PF_W)) == (PF_X | PF_W))
> +                               error("W^X violation for ELF segment");
> +

Can we catch this at build time instead?

> +                       unsigned int flags = MAP_PROTECT;
> +                       if (phdr->p_flags & PF_X)
> +                               flags |= MAP_EXEC;
> +                       if (phdr->p_flags & PF_W)
> +                               flags |= MAP_WRITE;
> +
> +                       kernel_add_identity_map(addr, addr + phdr->p_memsz, flags);
> +                       break;
> +               default:
> +                       /* Ignore other PT_* */
> +                       break;
>                 }
>         }
>
> +skip_protect:
>         free(phdrs);
>  }
>
> @@ -434,6 +476,18 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>                                 needed_size,
>                                 &virt_addr);
>
> +       unsigned long phys_addr = (unsigned long)output;
> +
> +       /*
> +        * If KASLR is disabled input and output regions may overlap.
> +        * In this case we need to map region excutable as well.
> +        */
> +       unsigned long map_flags = MAP_ALLOC | MAP_WRITE |
> +                       (IS_ENABLED(CONFIG_RANDOMIZE_BASE) ? 0 : MAP_EXEC);
> +       output = (unsigned char *)kernel_add_identity_map(phys_addr,
> +                                                         phys_addr + needed_size,
> +                                                         map_flags);
> +
>         /* Validate memory location choices. */
>         if ((unsigned long)output & (MIN_KERNEL_ALIGN - 1))
>                 error("Destination physical address inappropriately aligned");
> @@ -456,8 +510,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>         debug_putstr("\nDecompressing Linux... ");
>         __decompress(input_data, input_len, NULL, NULL, output, output_len,
>                         NULL, error);
> -       parse_elf(output);
> -       handle_relocations(output, output_len, virt_addr);
> +       parse_elf(output, output_len, virt_addr);
>         debug_putstr("done.\nBooting the kernel.\n");
>
>         /* Disable exception handling before booting the kernel */
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 62208ec04ca4..a4f99516f310 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -171,8 +171,20 @@ static inline int count_immovable_mem_regions(void) { return 0; }
>  #ifdef CONFIG_X86_5LEVEL
>  extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
>  #endif
> -extern void kernel_add_identity_map(unsigned long start, unsigned long end);
> -
> +#ifdef CONFIG_X86_64
> +extern unsigned long kernel_add_identity_map(unsigned long start,
> +                                            unsigned long end,
> +                                            unsigned int flags);
> +#else
> +static inline unsigned long kernel_add_identity_map(unsigned long start,
> +                                                   unsigned long end,
> +                                                   unsigned int flags)
> +{
> +       (void)flags;
> +       (void)end;

Why these (void) casts? Can we just drop them?


> +       return start;
> +}
> +#endif
>  /* Used by PAGE_KERN* macros: */
>  extern pteval_t __default_kernel_pte_mask;
>
> diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
> deleted file mode 100644
> index cc9b2529a086..000000000000
> --- a/arch/x86/boot/compressed/pgtable.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -#ifndef BOOT_COMPRESSED_PAGETABLE_H
> -#define BOOT_COMPRESSED_PAGETABLE_H
> -
> -#define TRAMPOLINE_32BIT_SIZE          (2 * PAGE_SIZE)
> -
> -#define TRAMPOLINE_32BIT_PGTABLE_OFFSET        0
> -
> -#define TRAMPOLINE_32BIT_CODE_OFFSET   PAGE_SIZE
> -#define TRAMPOLINE_32BIT_CODE_SIZE     0x80
> -
> -#define TRAMPOLINE_32BIT_STACK_END     TRAMPOLINE_32BIT_SIZE
> -
> -#ifndef __ASSEMBLER__
> -
> -extern unsigned long *trampoline_32bit;
> -
> -extern void trampoline_32bit_src(void *return_ptr);
> -
> -#endif /* __ASSEMBLER__ */
> -#endif /* BOOT_COMPRESSED_PAGETABLE_H */
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index 2ac12ff4111b..c7cf5a1059a8 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -2,7 +2,7 @@
>  #include "misc.h"
>  #include <asm/e820/types.h>
>  #include <asm/processor.h>
> -#include "pgtable.h"
> +#include <asm/shared/pgtable.h>
>  #include "../string.h"
>  #include "efi.h"
>
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index c93930d5ccbd..99f3ad0b30f3 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -13,6 +13,7 @@
>  #include "misc.h"
>
>  #include <asm/pgtable_types.h>
> +#include <asm/shared/pgtable.h>
>  #include <asm/sev.h>
>  #include <asm/trapnr.h>
>  #include <asm/trap_pf.h>
> @@ -435,10 +436,11 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
>                 unsigned long cc_info_pa = boot_params->cc_blob_address;
>                 struct cc_blob_sev_info *cc_info;
>
> -               kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
> +               kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info), MAP_NOFLUSH);
>
>                 cc_info = (struct cc_blob_sev_info *)cc_info_pa;
> -               kernel_add_identity_map(cc_info->cpuid_phys, cc_info->cpuid_phys + cc_info->cpuid_len);
> +               kernel_add_identity_map(cc_info->cpuid_phys,
> +                                       cc_info->cpuid_phys + cc_info->cpuid_len, MAP_NOFLUSH);
>         }
>
>         sev_verify_cbit(top_level_pgt);
> diff --git a/arch/x86/include/asm/shared/pgtable.h b/arch/x86/include/asm/shared/pgtable.h
> new file mode 100644
> index 000000000000..6527dadf39d6
> --- /dev/null
> +++ b/arch/x86/include/asm/shared/pgtable.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef ASM_SHARED_PAGETABLE_H
> +#define ASM_SHARED_PAGETABLE_H
> +
> +#define MAP_WRITE      0x02 /* Writable memory */
> +#define MAP_EXEC       0x04 /* Executable memory */
> +#define MAP_ALLOC      0x10 /* Range needs to be allocated */
> +#define MAP_PROTECT    0x20 /* Set exact memory attributes for memory range */
> +#define MAP_NOFLUSH    0x40 /* Avoid flushing TLB */
> +
> +#define TRAMPOLINE_32BIT_SIZE          (3 * PAGE_SIZE)
> +
> +#define TRAMPOLINE_32BIT_PLACEMENT_MAX (0xA0000)
> +
> +#define TRAMPOLINE_32BIT_PGTABLE_OFFSET        0
> +
> +#define TRAMPOLINE_32BIT_CODE_OFFSET   PAGE_SIZE
> +#define TRAMPOLINE_32BIT_CODE_SIZE     0x80
> +
> +#define TRAMPOLINE_32BIT_STACK_END     TRAMPOLINE_32BIT_SIZE
> +
> +#ifndef __ASSEMBLER__
> +
> +extern unsigned long *trampoline_32bit;
> +
> +extern void trampoline_32bit_src(void *return_ptr);
> +
> +#endif /* __ASSEMBLER__ */
> +#endif /* ASM_SHARED_PAGETABLE_H */
> --
> 2.35.1
>
