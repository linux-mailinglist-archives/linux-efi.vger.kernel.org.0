Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D969C5B15A6
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiIHHaF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 03:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiIHHaE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 03:30:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C0725E8C
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 00:30:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bj14so11226212wrb.12
        for <linux-efi@vger.kernel.org>; Thu, 08 Sep 2022 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BYBKvefnfog6brlu+T42oBrw7rDJ/U3oV7dRRMgICjg=;
        b=pR3nzApapIbF1qh6bkt3G+bAmIZzPsTGzPFOR+29ueB+MZY9Nc4QCkmJyWVffMhH3g
         KT/u2bujm4lZB5Siy/FMePO9XtJt6rEq5s/6EYoJfhJ1aFZPMZUdcFbfbqbHcr1KKguM
         0VDqj4JVpgJ4ACsldYJPmbrk6Fs8ui7HPsJTh+RMktfPXSsh+kD86Vc10zyl0eYhnu0C
         ZSpNh4Tyz/AfIqJGclMkLBS/NjYzUyeJ0uMb5P2zFXi2POnp6rIMBkeR2679mLRp+cDh
         MIxw+00wLihgaakue3dXBKS4F0P+xcUPzbzoGUnqarQI1k4OVIeuaWShqkZMT+tzefqV
         smzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BYBKvefnfog6brlu+T42oBrw7rDJ/U3oV7dRRMgICjg=;
        b=iXB2YQzXJjNC8WDGYNkx+CEyEkybMHT9Ypur/DiugwhQU9WYBHpKQ9TRT802i+2y7s
         0aY6NNDl9FiYDcVSUVbWfbboahGDdcN6lf3oFIo4dSuOBLVKS88v9umsVMc6guBJrNcW
         hygZRhrFF6QhgFrXtbLdMLQq26iQTnUZS2t5kKAR6JdK+GICjqmBen6Mhe3OKU+g3tlG
         ZMfGILuh4phSj3NX0tE0qUU29VJ6CDzvy4jS4rT8yJSGm5FvHqluStabYyAsSsm5XRo6
         hLo2jTaPUhVzdT94GdMG5aD53erkPXiwhLd73Cpm9+/dObB0UgdyzQzTEfYONzBkpSeO
         B17A==
X-Gm-Message-State: ACgBeo1jENmlm/dojS6M9NfR3FYEIrZs3f52kgrEYcvSDqb5F1usMeA6
        fHWS7r+CAmjxhOhwappXQa1Qqw==
X-Google-Smtp-Source: AA6agR5uQ72L3FTClNnWwWKdtCrJcSeqPU2gRXaIX5z/QkVD4GU5jcZLNyvVCnCgl1kmEMH7ClZOZA==
X-Received: by 2002:a05:6000:118e:b0:228:9373:70ae with SMTP id g14-20020a056000118e00b00228937370aemr4123096wrx.467.1662622200143;
        Thu, 08 Sep 2022 00:30:00 -0700 (PDT)
Received: from hera ([46.103.15.185])
        by smtp.gmail.com with ESMTPSA id z21-20020a05600c0a1500b003b332a7b898sm601008wmp.45.2022.09.08.00.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 00:29:59 -0700 (PDT)
Date:   Thu, 8 Sep 2022 10:29:56 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     grub-devel@nongnu.org, linux-efi@vger.kernel.org,
        grub-devel@gnu.org, Daniel Kiper <daniel.kiper@oracle.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        dann frazier <dann.frazier@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: Re: [PATCH resend 8/9] efi: implement LoadFile2 initrd loading
 protocol for Linux
Message-ID: <YxmZ9INMSU6lc00b@hera>
References: <20220818085540.2075028-1-ardb@kernel.org>
 <20220818085540.2075028-9-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818085540.2075028-9-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Thu, Aug 18, 2022 at 10:55:38AM +0200, Ard Biesheuvel wrote:
> Recent Linux kernels will invoke the LoadFile2 protocol installed on
> a well-known vendor media path to load the initrd if it is exposed by
> the firmware. Using this method is preferred for two reasons:
> - the Linux kernel is in charge of allocating the memory, and so it can
>   implement any placement policy it wants (given that these tend to
>   change between kernel versions),
> - it is no longer necessary to modify the device tree provided by the
>   firmware.
> 
> So let's install this protocol when handling the 'initrd' command if
> such a recent kernel was detected (based on the PE/COFF image version),
> and defer loading the initrd contents until the point where the kernel
> invokes the LoadFile2 protocol.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  grub-core/loader/arm64/linux.c | 129 +++++++++++++++++++-
>  1 file changed, 128 insertions(+), 1 deletion(-)
> 
> diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
> index 56ba8d0a6ea3..82c7558b4c4c 100644
> --- a/grub-core/loader/arm64/linux.c
> +++ b/grub-core/loader/arm64/linux.c
> @@ -48,6 +48,48 @@ static grub_uint32_t cmdline_size;
>  static grub_addr_t initrd_start;
>  static grub_addr_t initrd_end;
>  
> +static grub_efi_guid_t load_file2_guid = GRUB_EFI_LOAD_FILE2_PROTOCOL_GUID;
> +static grub_efi_guid_t device_path_guid = GRUB_EFI_DEVICE_PATH_GUID;
> +static struct grub_linux_initrd_context initrd_ctx = { 0, 0, 0 };
> +static grub_efi_handle_t initrd_lf2_handle;
> +static int initrd_use_loadfile2;
> +
> +struct initrd_media_device_path {
> +  grub_efi_vendor_media_device_path_t  vendor;
> +  grub_efi_device_path_t               end;
> +} GRUB_PACKED;
> +
> +#define LINUX_EFI_INITRD_MEDIA_GUID  \
> +  { 0x5568e427, 0x68fc, 0x4f3d, \
> +    { 0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68 } \
> +  }
> +
> +static struct initrd_media_device_path initrd_lf2_device_path = {
> +  {
> +    {
> +      GRUB_EFI_MEDIA_DEVICE_PATH_TYPE,
> +      GRUB_EFI_VENDOR_MEDIA_DEVICE_PATH_SUBTYPE,
> +      sizeof(grub_efi_vendor_media_device_path_t),
> +    },
> +    LINUX_EFI_INITRD_MEDIA_GUID
> +  }, {
> +    GRUB_EFI_END_DEVICE_PATH_TYPE,
> +    GRUB_EFI_END_ENTIRE_DEVICE_PATH_SUBTYPE,
> +    sizeof(grub_efi_device_path_t)
> +  }
> +};
> +
> +static grub_efi_status_t
> +grub_efi_initrd_load_file2(grub_efi_load_file2_t *this,
> +                           grub_efi_device_path_t *device_path,
> +                           grub_efi_boolean_t boot_policy,
> +                           grub_efi_uintn_t *buffer_size,
> +                           void *buffer);
> +
> +static grub_efi_load_file2_t initrd_lf2 = {
> +  grub_efi_initrd_load_file2
> +};
> +
>  grub_err_t
>  grub_arch_efi_linux_load_image_header (grub_file_t file,
>                                        struct linux_arch_kernel_header * lh)
> @@ -78,6 +120,18 @@ grub_arch_efi_linux_load_image_header (grub_file_t file,
>         return grub_error(GRUB_ERR_FILE_READ_ERROR, "failed to read COFF image header");
>      }
>  
> +  /*
> +   * Linux kernels built for any architecture are guaranteed to support the
> +   * LoadFile2 based initrd loading protocol if the image version is >= 1.
> +   */
> +  if (lh->coff_image_header.optional_header.major_image_version >= 1)
> +    initrd_use_loadfile2 = 1;
> +   else
> +    initrd_use_loadfile2 = 0;
> +
> +  grub_dprintf ("linux", "LoadFile2 initrd loading %sabled\n",
> +                initrd_use_loadfile2 ? "en" : "dis");
> +
>    return GRUB_ERR_NONE;
>  }
>  
> @@ -197,6 +251,8 @@ grub_linux_boot (void)
>  static grub_err_t
>  grub_linux_unload (void)
>  {
> +  grub_efi_boot_services_t *b;
> +
>    grub_dl_unref (my_mod);
>    loaded = 0;
>    if (initrd_start)
> @@ -208,6 +264,19 @@ grub_linux_unload (void)
>      grub_efi_free_pages ((grub_addr_t) kernel_addr,
>  			 GRUB_EFI_BYTES_TO_PAGES (kernel_size));
>    grub_fdt_unload ();
> +
> +  if (initrd_lf2_handle)
> +    {
> +      b = grub_efi_system_table->boot_services;
> +      b->uninstall_multiple_protocol_interfaces (initrd_lf2_handle,
> +                                                 &load_file2_guid,
> +                                                 &initrd_lf2,
> +                                                 &device_path_guid,
> +                                                 &initrd_lf2_device_path,
> +                                                 NULL);
> +      initrd_lf2_handle = NULL;
> +      initrd_use_loadfile2 = 0;
> +    }
>    return GRUB_ERR_NONE;
>  }
>  
> @@ -247,13 +316,50 @@ allocate_initrd_mem (int initrd_pages)
>  				       GRUB_EFI_LOADER_DATA);
>  }
>  
> +static grub_efi_status_t
> +grub_efi_initrd_load_file2(grub_efi_load_file2_t *this,
> +                          grub_efi_device_path_t *device_path,
> +                          grub_efi_boolean_t boot_policy,
> +                          grub_efi_uintn_t *buffer_size,
> +                          void *buffer)
> +{
> +  grub_efi_status_t status = GRUB_EFI_SUCCESS;
> +  grub_efi_uintn_t initrd_size;
> +
> +  if (!this || this != &initrd_lf2 || !buffer_size)
> +    return GRUB_EFI_INVALID_PARAMETER;
> +
> +  if (device_path->type != GRUB_EFI_END_DEVICE_PATH_TYPE ||
> +      device_path->subtype != GRUB_EFI_END_ENTIRE_DEVICE_PATH_SUBTYPE)
> +    return GRUB_EFI_NOT_FOUND;
> +
> +  if (boot_policy)
> +    return GRUB_EFI_UNSUPPORTED;
> +
> +  initrd_size = grub_get_initrd_size (&initrd_ctx);
> +  if (!buffer || *buffer_size < initrd_size)
> +    {
> +      *buffer_size = initrd_size;
> +      return GRUB_EFI_BUFFER_TOO_SMALL;
> +    }
> +
> +  grub_dprintf ("linux", "Providing initrd via LOAD_FILE2_PROTOCOL\n");
> +
> +  if (grub_initrd_load (&initrd_ctx, buffer))
> +    status = GRUB_EFI_LOAD_ERROR;
> +
> +  grub_initrd_close (&initrd_ctx);
> +  return status;
> +}
> +
>  static grub_err_t
>  grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
>  		 int argc, char *argv[])
>  {
> -  struct grub_linux_initrd_context initrd_ctx = { 0, 0, 0 };
>    int initrd_size, initrd_pages;
>    void *initrd_mem = NULL;
> +  grub_efi_boot_services_t *b;
> +  grub_efi_status_t status;
>  
>    if (argc == 0)
>      {
> @@ -271,6 +377,27 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
>    if (grub_initrd_init (argc, argv, &initrd_ctx))
>      goto fail;
>  
> +  if (initrd_use_loadfile2)
> +    {
> +      if (!initrd_lf2_handle)
> +        {
> +          b = grub_efi_system_table->boot_services;
> +          status = b->install_multiple_protocol_interfaces (&initrd_lf2_handle,
> +                                                            &load_file2_guid,
> +                                                            &initrd_lf2,
> +                                                            &device_path_guid,
> +                                                            &initrd_lf2_device_path,
> +                                                            NULL);
> +          if (status == GRUB_EFI_OUT_OF_RESOURCES)
> +            {
> +              grub_error (GRUB_ERR_OUT_OF_MEMORY, N_("out of memory"));
> +              return grub_errno;
> +            }
> +        }
> +      grub_dprintf ("linux", "Using LoadFile2 initrd loading protocol\n");
> +      return GRUB_ERR_NONE;
> +    }
> +
>    initrd_size = grub_get_initrd_size (&initrd_ctx);
>    grub_dprintf ("linux", "Loading initrd\n");
>  
> -- 
> 2.35.1
> 

I tested this on u-boot n(which also support load_file2 for the initrd).
Even if the user misconfigures the whole thing and try to install the
protocol twice everything seems to be handled properly.

Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

