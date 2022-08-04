Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890D4589808
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 09:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiHDHDN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 03:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiHDHDM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 03:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E792261B2F
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 00:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659596589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uT/JWSL7S1LwjzUD5vHlKO14OCOFfgtLi4NSCqEiBtM=;
        b=HIEgXBFY/lPZZGaXy9Qr5Se3/MoyYnvaPeSpRigKYJq4QJGs5evUv7tD0NzajOdjJtOxms
        3mYP8bRjQIwSTFw6/zY/QrUMY16NnftGvU0Q9WWdA5SYwLahK33cR51JvuZmQDnC9VulwA
        8LXEsipNdUcqdzvU1/xOGjWy+GyioWI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-yyt9VP5EOAiXXwCdecGjCw-1; Thu, 04 Aug 2022 03:03:08 -0400
X-MC-Unique: yyt9VP5EOAiXXwCdecGjCw-1
Received: by mail-ed1-f69.google.com with SMTP id w5-20020a05640234c500b0043dda025648so5722009edc.8
        for <linux-efi@vger.kernel.org>; Thu, 04 Aug 2022 00:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=uT/JWSL7S1LwjzUD5vHlKO14OCOFfgtLi4NSCqEiBtM=;
        b=YO6lpENfykdZwpXTfysGJ9wuDQrqDniQ8k99dy0E5U96YkKdLrfaUvNNoWPLafL0EP
         zEdjoZSDzulJyNd2rjKrclQyBzb5BRkQNTqDwBHAQFPgcgn0pA93IEkObRzJBv8D7ssc
         p4wI9fkDK/5yCNH3G8BIt6HlzFxhcxAKR7+pfXiKrI7ErObYjZ9nj94VKReWaH3CRSni
         EE7b59L8nLMNwl0BoSIBvSQgOgvmIWojum6H8YWPYTnU3T6dDunMnJ0VeV3wfUZdeGMe
         uIiMj7fFLnXb7n1GHdeAZFfXP+RiWYc3w1jGi22i0z232BMSSuKf+m1PCT8PGMoKLMu1
         R2lQ==
X-Gm-Message-State: ACgBeo3FNYApGn/7pLr5/J0/CeJAfKJU0Y3ij7BFDdgLuwfCpaxNv19s
        Qszier5tgdIpMrLfi0HgrLwApMhb7VSBEBXzf/ovr0aXGIrzdbAIISJQwD9VPnoLjLOwUSRvWvz
        xa/+cbm96ONjYU/OK7YdD
X-Received: by 2002:a05:6402:35c1:b0:43d:fd2c:ae15 with SMTP id z1-20020a05640235c100b0043dfd2cae15mr594107edc.63.1659596587485;
        Thu, 04 Aug 2022 00:03:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5wg+Yddc4s9P3S2L9QvHuFMSb37mNNiCl1MHOGmwXuOdo4fM7Ge/NgtONH/nzjfM4v3RnWEQ==
X-Received: by 2002:a05:6402:35c1:b0:43d:fd2c:ae15 with SMTP id z1-20020a05640235c100b0043dfd2cae15mr594086edc.63.1659596587272;
        Thu, 04 Aug 2022 00:03:07 -0700 (PDT)
Received: from redhat.com ([2.54.191.86])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b0072af890f52dsm15174ejf.88.2022.08.04.00.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:03:06 -0700 (PDT)
Date:   Thu, 4 Aug 2022 03:03:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     qemu-devel@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
Message-ID: <20220804030012-mutt-send-email-mst@kernel.org>
References: <YusVVLNbLgsk49PK@zx2c4.com>
 <20220804004411.1343158-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804004411.1343158-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 04, 2022 at 02:44:11AM +0200, Jason A. Donenfeld wrote:
> The boot parameter header refers to setup_data at an absolute address,
> and each setup_data refers to the next setup_data at an absolute address
> too. Currently QEMU simply puts the setup_datas right after the kernel
> image, and since the kernel_image is loaded at prot_addr -- a fixed
> address knowable to QEMU apriori -- the setup_data absolute address
> winds up being just `prot_addr + a_fixed_offset_into_kernel_image`.
> 
> This mostly works fine, so long as the kernel image really is loaded at
> prot_addr. However, OVMF doesn't load the kernel at prot_addr, and
> generally EFI doesn't give a good way of predicting where it's going to
> load the kernel. So when it loads it at some address != prot_addr, the
> absolute addresses in setup_data now point somewhere bogus, causing
> crashes when EFI stub tries to follow the next link.
> 
> Fix this by placing setup_data at some fixed place in memory, relative
> to real_addr, not as part of the kernel image, and then pointing the
> setup_data absolute address to that fixed place in memory. This way,
> even if OVMF or other chains relocate the kernel image, the boot
> parameter still points to the correct absolute address.
> 
> Fixes: 3cbeb52467 ("hw/i386: add device tree support")
> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Didn't read the patch yet.
Adding Laszlo.

> ---
>  hw/i386/x86.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 050eedc0c8..8b853abf38 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -760,36 +760,36 @@ static bool load_elfboot(const char *kernel_filename,
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_start_addr);
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size);
>  
>      return true;
>  }
>  
>  void x86_load_linux(X86MachineState *x86ms,
>                      FWCfgState *fw_cfg,
>                      int acpi_data_size,
>                      bool pvh_enabled,
>                      bool legacy_no_rng_seed)
>  {
>      bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
>      uint16_t protocol;
>      int setup_size, kernel_size, cmdline_size;
> -    int dtb_size, setup_data_offset;
> +    int dtb_size, setup_data_item_len, setup_data_total_len = 0;
>      uint32_t initrd_max;
> -    uint8_t header[8192], *setup, *kernel;
> -    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0, first_setup_data = 0;
> +    uint8_t header[8192], *setup, *kernel, *setup_datas = NULL;
> +    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0, first_setup_data = 0, setup_data_base;
>      FILE *f;
>      char *vmode;
>      MachineState *machine = MACHINE(x86ms);
>      struct setup_data *setup_data;
>      const char *kernel_filename = machine->kernel_filename;
>      const char *initrd_filename = machine->initrd_filename;
>      const char *dtb_filename = machine->dtb;
>      const char *kernel_cmdline = machine->kernel_cmdline;
>      SevKernelLoaderContext sev_load_ctx = {};
>      enum { RNG_SEED_LENGTH = 32 };
>  
>      /* Align to 16 bytes as a paranoia measure */
>      cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
>  
>      /* load the kernel header */
>      f = fopen(kernel_filename, "rb");
> @@ -886,32 +886,33 @@ void x86_load_linux(X86MachineState *x86ms,
>      if (protocol < 0x200 || !(header[0x211] & 0x01)) {
>          /* Low kernel */
>          real_addr    = 0x90000;
>          cmdline_addr = 0x9a000 - cmdline_size;
>          prot_addr    = 0x10000;
>      } else if (protocol < 0x202) {
>          /* High but ancient kernel */
>          real_addr    = 0x90000;
>          cmdline_addr = 0x9a000 - cmdline_size;
>          prot_addr    = 0x100000;
>      } else {
>          /* High and recent kernel */
>          real_addr    = 0x10000;
>          cmdline_addr = 0x20000;
>          prot_addr    = 0x100000;
>      }
> +    setup_data_base = real_addr + 0x8000;
>  
>      /* highest address for loading the initrd */
>      if (protocol >= 0x20c &&
>          lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
>          /*
>           * Linux has supported initrd up to 4 GB for a very long time (2007,
>           * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
>           * though it only sets initrd_max to 2 GB to "work around bootloader
>           * bugs". Luckily, QEMU firmware(which does something like bootloader)
>           * has supported this.
>           *
>           * It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is set, initrd can
>           * be loaded into any address.
>           *
>           * In addition, initrd_max is uint32_t simply because QEMU doesn't
>           * support the 64-bit boot protocol (specifically the ext_ramdisk_image
> @@ -1049,60 +1050,61 @@ void x86_load_linux(X86MachineState *x86ms,
>      fclose(f);
>  
>      /* append dtb to kernel */
>      if (dtb_filename) {
>          if (protocol < 0x209) {
>              fprintf(stderr, "qemu: Linux kernel too old to load a dtb\n");
>              exit(1);
>          }
>  
>          dtb_size = get_image_size(dtb_filename);
>          if (dtb_size <= 0) {
>              fprintf(stderr, "qemu: error reading dtb %s: %s\n",
>                      dtb_filename, strerror(errno));
>              exit(1);
>          }
>  
> -        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
> -        kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
> -        kernel = g_realloc(kernel, kernel_size);
> -
> -
> -        setup_data = (struct setup_data *)(kernel + setup_data_offset);
> +        setup_data_item_len = sizeof(struct setup_data) + dtb_size;
> +        setup_datas = g_realloc(setup_datas, setup_data_total_len + setup_data_item_len);
> +        setup_data = (struct setup_data *)(setup_datas + setup_data_total_len);
>          setup_data->next = cpu_to_le64(first_setup_data);
> -        first_setup_data = prot_addr + setup_data_offset;
> +        first_setup_data = setup_data_base + setup_data_total_len;
> +        setup_data_total_len += setup_data_item_len;
>          setup_data->type = cpu_to_le32(SETUP_DTB);
>          setup_data->len = cpu_to_le32(dtb_size);
> -
>          load_image_size(dtb_filename, setup_data->data, dtb_size);
>      }
>  
>      if (!legacy_no_rng_seed) {
> -        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
> -        kernel_size = setup_data_offset + sizeof(struct setup_data) + RNG_SEED_LENGTH;
> -        kernel = g_realloc(kernel, kernel_size);
> -        setup_data = (struct setup_data *)(kernel + setup_data_offset);
> +        setup_data_item_len = sizeof(struct setup_data) + RNG_SEED_LENGTH;
> +        setup_datas = g_realloc(setup_datas, setup_data_total_len + setup_data_item_len);
> +        setup_data = (struct setup_data *)(setup_datas + setup_data_total_len);
>          setup_data->next = cpu_to_le64(first_setup_data);
> -        first_setup_data = prot_addr + setup_data_offset;
> +        first_setup_data = setup_data_base + setup_data_total_len;
> +        setup_data_total_len += setup_data_item_len;
>          setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
>          setup_data->len = cpu_to_le32(RNG_SEED_LENGTH);
>          qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH);
>      }
>  
> -    /* Offset 0x250 is a pointer to the first setup_data link. */
> -    stq_p(header + 0x250, first_setup_data);
> +    if (first_setup_data) {
> +            /* Offset 0x250 is a pointer to the first setup_data link. */
> +            stq_p(header + 0x250, first_setup_data);
> +            rom_add_blob("setup_data", setup_datas, setup_data_total_len, setup_data_total_len,
> +                         setup_data_base, NULL, NULL, NULL, NULL, false);
> +    }
>  
>      /*
>       * If we're starting an encrypted VM, it will be OVMF based, which uses the
>       * efi stub for booting and doesn't require any values to be placed in the
>       * kernel header.  We therefore don't update the header so the hash of the
>       * kernel on the other side of the fw_cfg interface matches the hash of the
>       * file the user passed in.
>       */
>      if (!sev_enabled()) {
>          memcpy(setup, header, MIN(sizeof(header), setup_size));
>      }
>  
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
>      fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
>      sev_load_ctx.kernel_data = (char *)kernel;
> -- 
> 2.35.1

