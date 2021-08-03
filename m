Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611973DE635
	for <lists+linux-efi@lfdr.de>; Tue,  3 Aug 2021 07:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhHCFeo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Aug 2021 01:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233582AbhHCFen (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Aug 2021 01:34:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 758BF60F70
        for <linux-efi@vger.kernel.org>; Tue,  3 Aug 2021 05:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627968873;
        bh=YxiNbcbITCDJq8H//6YyPbk6S6C9q7kbx8Di+XL6G+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aMPtiUAQMJ7KKnZwAOtzJinNbO6nMOn17lJlYHpAL03EfNP63QmuFzt2o674/g8Sp
         RmNhKbf2AOdoDnhwS7JLiiuuWHHsg9BG0gh4ETg2ya0A2eZbFrKgVH53c6NtFp0ftL
         ++yC1RRvJT19sloBq4ntvEotBKfubFK3jJEhp9Pr2hHz31G1PSS/unDtnITqNVbbxP
         Pgp+KTLCd5f++65wkHrZ4er6zsh0vsZ+5RIqV94A7bR7A5y4T0KILx1q4RPo5EJ1zI
         SxeOU2i/B5Ki6iRFKsWf5uB3rQRUz2+slDcYun+p8N3Htcd9KHeXSVRHJASxw2qn0t
         ELCLLjkf3uoMg==
Received: by mail-oi1-f173.google.com with SMTP id u10so26917407oiw.4
        for <linux-efi@vger.kernel.org>; Mon, 02 Aug 2021 22:34:33 -0700 (PDT)
X-Gm-Message-State: AOAM532nhFXvv0DOKUaMIN2yqfIbpnT/RHfw6olpkdi9fBJqf9LYoZmF
        qszQlNwuwrg5q2bZAsOKKT8pKkKSIP8en2gg6Fc=
X-Google-Smtp-Source: ABdhPJxsNRTl+6xus8DcBSeJbhaXUK8gxOcQUQMu8Qj/07kjJ1V8yhbvBpHeOAIBF+lRG5o/k2C6C8iQnARPf1ZrMRg=
X-Received: by 2002:aca:d64d:: with SMTP id n74mr1880177oig.47.1627968872880;
 Mon, 02 Aug 2021 22:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <8434c5ab953db145f74855d97258a346a5bf3046.camel@kernel.crashing.org>
In-Reply-To: <8434c5ab953db145f74855d97258a346a5bf3046.camel@kernel.crashing.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Aug 2021 07:34:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE8p_XiuCUZpRxyx3m_JyvUmZ6YP_dkXQd9VY=+56HENQ@mail.gmail.com>
Message-ID: <CAMj1kXE8p_XiuCUZpRxyx3m_JyvUmZ6YP_dkXQd9VY=+56HENQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Fix EFI loader kernel image allocation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Steve McIntyre <steve@einval.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Dimitri John Ledkov <xnox@ubuntu.com>,
        Colin Watson <cjwatson@debian.org>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Steve)


On Mon, 2 Aug 2021 at 15:12, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> We are currently allocating just enough memory for the file size,
> which means that the kernel BSS is in limbo (and not even zeroed).
>
> We are also not honoring the alignment specified in the image
> PE header.
>
> This makes us use the PE optional header in which the kernel puts the
> actual size it needs, including BSS, and make sure we clear it, and
> honors the specified alignment for the image.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> This is v2 of the patch against Fedora/RH/Ubuntu grub2 (ie, fixes
> the original shim lock introduction patch) to address random crashes
> at boot on arm64.
>
>  grub-core/loader/arm64/linux.c | 100 ++++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 34 deletions(-)
>
> diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
> index 47f8cf0d8..4a252d5e7 100644
> --- a/grub-core/loader/arm64/linux.c
> +++ b/grub-core/loader/arm64/linux.c
> @@ -41,6 +41,8 @@ GRUB_MOD_LICENSE ("GPLv3+");
>  static grub_dl_t my_mod;
>  static int loaded;
>
> +static void *kernel_alloc_addr;
> +static grub_uint32_t kernel_alloc_pages;
>  static void *kernel_addr;
>  static grub_uint64_t kernel_size;
>  static grub_uint32_t handover_offset;
> @@ -204,9 +206,8 @@ grub_linux_unload (void)
>                          GRUB_EFI_BYTES_TO_PAGES (initrd_end - initrd_start));
>    initrd_start = initrd_end = 0;
>    grub_free (linux_args);
> -  if (kernel_addr)
> -    grub_efi_free_pages ((grub_addr_t) kernel_addr,
> -                        GRUB_EFI_BYTES_TO_PAGES (kernel_size));
> +  if (kernel_alloc_addr)
> +    grub_efi_free_pages ((grub_addr_t) kernel_alloc_addr, kernel_alloc_pages);
>    grub_fdt_unload ();
>    return GRUB_ERR_NONE;
>  }
> @@ -311,14 +312,35 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
>    return grub_errno;
>  }
>
> +static grub_err_t
> +parse_pe_header (void *kernel, grub_uint64_t *total_size,
> +                grub_uint32_t *entry_offset,
> +                grub_uint32_t *alignment)
> +{
> +  struct linux_arch_kernel_header *lh = kernel;
> +  struct grub_armxx_linux_pe_header *pe;
> +
> +  pe = (void *)((unsigned long)kernel + lh->hdr_offset);
> +
> +  if (pe->opt.magic != GRUB_PE32_PE64_MAGIC)
> +    return grub_error(GRUB_ERR_BAD_OS, "Invalid PE optional header magic");
> +
> +  *total_size   = pe->opt.image_size;
> +  *entry_offset = pe->opt.entry_addr;
> +  *alignment    = pe->opt.section_alignment;
> +
> +  return GRUB_ERR_NONE;
> +}
> +
>  static grub_err_t
>  grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
>                 int argc, char *argv[])
>  {
>    grub_file_t file = 0;
> -  struct linux_arch_kernel_header lh;
> -  struct grub_armxx_linux_pe_header *pe;
>    grub_err_t err;
> +  grub_off_t filelen;
> +  grub_uint32_t align;
> +  void *kernel = NULL;
>    int rc;
>
>    grub_dl_ref (my_mod);
> @@ -333,40 +355,24 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
>    if (!file)
>      goto fail;
>
> -  kernel_size = grub_file_size (file);
> -
> -  if (grub_file_read (file, &lh, sizeof (lh)) < (long) sizeof (lh))
> -    return grub_errno;
> -
> -  if (grub_arch_efi_linux_check_image (&lh) != GRUB_ERR_NONE)
> -    goto fail;
> -
> -  grub_loader_unset();
> -
> -  grub_dprintf ("linux", "kernel file size: %lld\n", (long long) kernel_size);
> -  kernel_addr = grub_efi_allocate_any_pages (GRUB_EFI_BYTES_TO_PAGES (kernel_size));
> -  grub_dprintf ("linux", "kernel numpages: %lld\n",
> -               (long long) GRUB_EFI_BYTES_TO_PAGES (kernel_size));
> -  if (!kernel_addr)
> +  filelen = grub_file_size (file);
> +  kernel = grub_malloc(filelen);
> +  if (!kernel)
>      {
> -      grub_error (GRUB_ERR_OUT_OF_MEMORY, N_("out of memory"));
> +      grub_error (GRUB_ERR_OUT_OF_MEMORY, N_("cannot allocate kernel load buffer"));
>        goto fail;
>      }
>
> -  grub_file_seek (file, 0);
> -  if (grub_file_read (file, kernel_addr, kernel_size)
> -      < (grub_int64_t) kernel_size)
> +  if (grub_file_read (file, kernel, filelen) < (grub_ssize_t)filelen)
>      {
> -      if (!grub_errno)
> -       grub_error (GRUB_ERR_BAD_OS, N_("premature end of file %s"), argv[0]);
> +      grub_error (GRUB_ERR_FILE_READ_ERROR, N_("Can't read kernel %s"),
> +                 argv[0]);
>        goto fail;
>      }
>
> -  grub_dprintf ("linux", "kernel @ %p\n", kernel_addr);
> -
>    if (grub_efi_get_secureboot () == GRUB_EFI_SECUREBOOT_MODE_ENABLED)
>      {
> -      rc = grub_linuxefi_secure_validate (kernel_addr, kernel_size);
> +      rc = grub_linuxefi_secure_validate (kernel, filelen);
>        if (rc <= 0)
>         {
>           grub_error (GRUB_ERR_INVALID_COMMAND,
> @@ -375,8 +381,32 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
>         }
>      }
>
> -  pe = (void *)((unsigned long)kernel_addr + lh.hdr_offset);
> -  handover_offset = pe->opt.entry_addr;
> +  if (grub_arch_efi_linux_check_image (kernel) != GRUB_ERR_NONE)
> +    goto fail;
> +  if (parse_pe_header (kernel, &kernel_size, &handover_offset, &align) != GRUB_ERR_NONE)
> +    goto fail;
> +  grub_dprintf ("linux", "kernel mem size     : %lld\n", (long long) kernel_size);
> +  grub_dprintf ("linux", "kernel entry offset : %d\n", handover_offset);
> +  grub_dprintf ("linux", "kernel alignment    : 0x%x\n", align);
> +
> +  grub_loader_unset();
> +
> +  kernel_alloc_pages = GRUB_EFI_BYTES_TO_PAGES (kernel_size + align - 1);
> +  kernel_alloc_addr = grub_efi_allocate_any_pages (kernel_alloc_pages);
> +  grub_dprintf ("linux", "kernel numpages: %d\n", kernel_alloc_pages);
> +  if (!kernel_alloc_addr)
> +    {
> +      grub_error (GRUB_ERR_OUT_OF_MEMORY, N_("out of memory"));
> +      goto fail;
> +    }
> +  kernel_addr = (void *)ALIGN_UP((grub_uint64_t)kernel_alloc_addr, align);
> +
> +  grub_dprintf ("linux", "kernel @ %p\n", kernel_addr);
> +  grub_memcpy (kernel_addr, kernel, grub_min(filelen, kernel_size));
> +  if (kernel_size > filelen)
> +    grub_memset ((char *)kernel_addr + filelen, 0, kernel_size - filelen);
> +  grub_free(kernel);
> +  kernel = NULL;
>
>    cmdline_size = grub_loader_cmdline_size (argc, argv) + sizeof (LINUX_IMAGE);
>    linux_args = grub_malloc (cmdline_size);
> @@ -400,6 +430,9 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
>      }
>
>  fail:
> +  if (kernel)
> +    grub_free (kernel);
> +
>    if (file)
>      grub_file_close (file);
>
> @@ -412,9 +445,8 @@ fail:
>    if (linux_args && !loaded)
>      grub_free (linux_args);
>
> -  if (kernel_addr && !loaded)
> -    grub_efi_free_pages ((grub_addr_t) kernel_addr,
> -                        GRUB_EFI_BYTES_TO_PAGES (kernel_size));
> +  if (kernel_alloc_addr && !loaded)
> +    grub_efi_free_pages ((grub_addr_t) kernel_alloc_addr, kernel_alloc_pages);
>
>    return grub_errno;
>  }
> --
> 2.25.1
>
>
