Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD18A6B4933
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 16:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjCJPKh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 10:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjCJPKQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 10:10:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD5512D422;
        Fri, 10 Mar 2023 07:02:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AEA7B82321;
        Fri, 10 Mar 2023 15:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C583FC433A8;
        Fri, 10 Mar 2023 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678460497;
        bh=yON7LGAb64Jf/3zP7cUy3KK1qwd5R+K7iJV4bFwjS1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LqZVMb4GiAcWW+zNNjDkC4MllYc8ouFZiojNKyNwjwIx9TB/+VFxMJZ/pje2Zr228
         EeCxIw8bgy9TrOU8giQGpvH9GEJWDMgsbXmRNTbn06GhRhqr283V+67dW8A1MGJVcs
         lUfTnAhWWhiLpcbxwAGqnzyEpGLGHxwjx7wFZVtNO8OEl+UbGnhOyNiJAtnRVELVni
         8CWhCrEQenkPwejjn7J+GwwI/8EZ/5sSzx3n6kvKZUV8Cg3+dBDizkKJew/BlZ9g0V
         1PvdHezaF+Tfka/YgQvkRnw+zviF7MH9/H54TgEV/v9/8ft27quwPhchZ0U0W7MSbq
         S+PuApNVyKcMA==
Received: by mail-lj1-f169.google.com with SMTP id y14so5597393ljq.4;
        Fri, 10 Mar 2023 07:01:37 -0800 (PST)
X-Gm-Message-State: AO0yUKWh+xVFqdxmmuiEUbATxIB/W7fMBuxqACgryNhDpFIrBfzN6iFY
        Avzq9pzPOZje8U9/7H1xM3AqGXHwF2ba10k7FyI=
X-Google-Smtp-Source: AK7set+HJqzLUwrQjKCjGI1AkMC8LsLBR0lUC+HDKlUEEMRPbsvO907mPQEIvBr7Y6wBBsGpdCTZhUZ052YXIXvZNhU=
X-Received: by 2002:a05:651c:11c6:b0:295:d460:5a2d with SMTP id
 z6-20020a05651c11c600b00295d4605a2dmr8043803ljo.2.1678460495691; Fri, 10 Mar
 2023 07:01:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <3f48e8bb2232220153b353d0f43cb6d96139b2da.1671098103.git.baskov@ispras.ru>
In-Reply-To: <3f48e8bb2232220153b353d0f43cb6d96139b2da.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Mar 2023 16:01:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHc9jXzWFB6_p92Q=qHOe=J22t1mrtnTZ_f-=mAv2CiRw@mail.gmail.com>
Message-ID: <CAMj1kXHc9jXzWFB6_p92Q=qHOe=J22t1mrtnTZ_f-=mAv2CiRw@mail.gmail.com>
Subject: Re: [PATCH v4 18/26] tools/include: Add simplified version of pe.h
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 15 Dec 2022 at 13:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> This is needed to remove magic numbers from x86 bzImage building tool
> (arch/x86/boot/tools/build.c).
>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  tools/include/linux/pe.h | 150 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 tools/include/linux/pe.h
>
> diff --git a/tools/include/linux/pe.h b/tools/include/linux/pe.h
> new file mode 100644
> index 000000000000..41c09ec371d8
> --- /dev/null
> +++ b/tools/include/linux/pe.h
> @@ -0,0 +1,150 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Simplified version of include/linux/pe.h:
> + *  Copyright 2011 Red Hat, Inc. All rights reserved.
> + *  Author(s): Peter Jones <pjones@redhat.com>
> + */
> +#ifndef __LINUX_PE_H
> +#define __LINUX_PE_H
> +
> +#include <linux/types.h>
> +
> +#define        IMAGE_FILE_MACHINE_I386         0x014c
> +
> +#define IMAGE_SCN_CNT_CODE     0x00000020 /* .text */
> +#define IMAGE_SCN_CNT_INITIALIZED_DATA 0x00000040 /* .data */
> +#define IMAGE_SCN_ALIGN_4096BYTES 0x00d00000
> +#define IMAGE_SCN_MEM_DISCARDABLE 0x02000000 /* scn can be discarded */
> +#define IMAGE_SCN_MEM_EXECUTE  0x20000000 /* can be executed as code */
> +#define IMAGE_SCN_MEM_READ     0x40000000 /* readable */
> +#define IMAGE_SCN_MEM_WRITE    0x80000000 /* writeable */
> +
> +#define MZ_HEADER_PEADDR_OFFSET 0x3c
> +
> +struct pe_hdr {
> +       uint32_t magic;         /* PE magic */
> +       uint16_t machine;       /* machine type */
> +       uint16_t sections;      /* number of sections */
> +       uint32_t timestamp;     /* time_t */
> +       uint32_t symbol_table;  /* symbol table offset */
> +       uint32_t symbols;       /* number of symbols */
> +       uint16_t opt_hdr_size;  /* size of optional header */
> +       uint16_t flags;         /* flags */
> +};
> +
> +/* the fact that pe32 isn't padded where pe32+ is 64-bit means union won't
> + * work right.  vomit. */
> +struct pe32_opt_hdr {
> +       /* "standard" header */
> +       uint16_t magic;         /* file type */
> +       uint8_t  ld_major;      /* linker major version */
> +       uint8_t  ld_minor;      /* linker minor version */
> +       uint32_t text_size;     /* size of text section(s) */
> +       uint32_t data_size;     /* size of data section(s) */
> +       uint32_t bss_size;      /* size of bss section(s) */
> +       uint32_t entry_point;   /* file offset of entry point */
> +       uint32_t code_base;     /* relative code addr in ram */
> +       uint32_t data_base;     /* relative data addr in ram */
> +       /* "windows" header */
> +       uint32_t image_base;    /* preferred load address */
> +       uint32_t section_align; /* alignment in bytes */
> +       uint32_t file_align;    /* file alignment in bytes */
> +       uint16_t os_major;      /* major OS version */
> +       uint16_t os_minor;      /* minor OS version */
> +       uint16_t image_major;   /* major image version */
> +       uint16_t image_minor;   /* minor image version */
> +       uint16_t subsys_major;  /* major subsystem version */
> +       uint16_t subsys_minor;  /* minor subsystem version */
> +       uint32_t win32_version; /* reserved, must be 0 */
> +       uint32_t image_size;    /* image size */
> +       uint32_t header_size;   /* header size rounded up to
> +                                  file_align */
> +       uint32_t csum;          /* checksum */
> +       uint16_t subsys;        /* subsystem */
> +       uint16_t dll_flags;     /* more flags! */
> +       uint32_t stack_size_req;/* amt of stack requested */
> +       uint32_t stack_size;    /* amt of stack required */
> +       uint32_t heap_size_req; /* amt of heap requested */
> +       uint32_t heap_size;     /* amt of heap required */
> +       uint32_t loader_flags;  /* reserved, must be 0 */
> +       uint32_t data_dirs;     /* number of data dir entries */
> +};
> +
> +struct pe32plus_opt_hdr {
> +       uint16_t magic;         /* file type */
> +       uint8_t  ld_major;      /* linker major version */
> +       uint8_t  ld_minor;      /* linker minor version */
> +       uint32_t text_size;     /* size of text section(s) */
> +       uint32_t data_size;     /* size of data section(s) */
> +       uint32_t bss_size;      /* size of bss section(s) */
> +       uint32_t entry_point;   /* file offset of entry point */
> +       uint32_t code_base;     /* relative code addr in ram */
> +       /* "windows" header */
> +       uint64_t image_base;    /* preferred load address */
> +       uint32_t section_align; /* alignment in bytes */
> +       uint32_t file_align;    /* file alignment in bytes */
> +       uint16_t os_major;      /* major OS version */
> +       uint16_t os_minor;      /* minor OS version */
> +       uint16_t image_major;   /* major image version */
> +       uint16_t image_minor;   /* minor image version */
> +       uint16_t subsys_major;  /* major subsystem version */
> +       uint16_t subsys_minor;  /* minor subsystem version */
> +       uint32_t win32_version; /* reserved, must be 0 */
> +       uint32_t image_size;    /* image size */
> +       uint32_t header_size;   /* header size rounded up to
> +                                  file_align */
> +       uint32_t csum;          /* checksum */
> +       uint16_t subsys;        /* subsystem */
> +       uint16_t dll_flags;     /* more flags! */
> +       uint64_t stack_size_req;/* amt of stack requested */
> +       uint64_t stack_size;    /* amt of stack required */
> +       uint64_t heap_size_req; /* amt of heap requested */
> +       uint64_t heap_size;     /* amt of heap required */
> +       uint32_t loader_flags;  /* reserved, must be 0 */
> +       uint32_t data_dirs;     /* number of data dir entries */
> +};
> +
> +struct data_dirent {
> +       uint32_t virtual_address;       /* relative to load address */
> +       uint32_t size;
> +};
> +
> +struct data_directory {
> +       struct data_dirent exports;             /* .edata */
> +       struct data_dirent imports;             /* .idata */
> +       struct data_dirent resources;           /* .rsrc */
> +       struct data_dirent exceptions;          /* .pdata */
> +       struct data_dirent certs;               /* certs */
> +       struct data_dirent base_relocations;    /* .reloc */
> +       struct data_dirent debug;               /* .debug */
> +       struct data_dirent arch;                /* reservered */
> +       struct data_dirent global_ptr;          /* global pointer reg. Size=0 */
> +       struct data_dirent tls;                 /* .tls */
> +       struct data_dirent load_config;         /* load configuration structure */
> +       struct data_dirent bound_imports;       /* no idea */
> +       struct data_dirent import_addrs;        /* import address table */
> +       struct data_dirent delay_imports;       /* delay-load import table */
> +       struct data_dirent clr_runtime_hdr;     /* .cor (object only) */
> +       struct data_dirent reserved;
> +};
> +
> +struct section_header {
> +       char name[8];                   /* name or "/12\0" string tbl offset */
> +       uint32_t virtual_size;          /* size of loaded section in ram */
> +       uint32_t virtual_address;       /* relative virtual address */
> +       uint32_t raw_data_size;         /* size of the section */
> +       uint32_t data_addr;             /* file pointer to first page of sec */
> +       uint32_t relocs;                /* file pointer to relocation entries */
> +       uint32_t line_numbers;          /* line numbers! */
> +       uint16_t num_relocs;            /* number of relocations */
> +       uint16_t num_lin_numbers;       /* srsly. */
> +       uint32_t flags;
> +};
> +
> +struct coff_reloc {
> +       uint32_t virtual_address;
> +       uint32_t symbol_table_index;
> +       uint16_t data;
> +};
> +
> +#endif /* __LINUX_PE_H */
> --
> 2.37.4
>
