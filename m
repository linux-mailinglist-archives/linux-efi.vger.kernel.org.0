Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BDA296F41
	for <lists+linux-efi@lfdr.de>; Fri, 23 Oct 2020 14:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463639AbgJWMcv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Oct 2020 08:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372849AbgJWMcu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Oct 2020 08:32:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B584C0613CE
        for <linux-efi@vger.kernel.org>; Fri, 23 Oct 2020 05:32:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so1341361wme.1
        for <linux-efi@vger.kernel.org>; Fri, 23 Oct 2020 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z+gHMLIk2JyV3uP4QvUMf3M6m4SouLS+NEvWao+GVVc=;
        b=LUAs1NoUDGYgAjKfPZbAJRWykUjKwTQuEwLpKgOwRQ8e6jZ0Mb6DdyuO0iN50WzasZ
         TYQi90Nc+1AsZVHqyRTYoSpWtBroi/NcU8CtID8xPZZdLZzByMOnfrvhZpZWOUI1ImE/
         dVRmIgLGGWF+lG2sqrVELL26IDrlSpcL/1jmK4U052lEhKFnfBXQ1R8XJoLHjrykL7pQ
         wR1E8cbUOOUV0P5gszJsvSUJ0A40CzKEukCSsfMjRgm6u90RaQ8uoCFY5evRwdEHh6yl
         T0KXr+lQMjsYLdoaZ05yz6p+ChU1r/nknnY1FTO0eej/tvXY1w8hpf0fJeS0QdUMJGjT
         JcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z+gHMLIk2JyV3uP4QvUMf3M6m4SouLS+NEvWao+GVVc=;
        b=fgIllDCX9iU18HMUgqqm+nOfMf3joRtzb8KAjK+WHsryP58HOW8LkBYOje52wP8Xf0
         s4X8q590BhQUvZ+YXVKn7puQzU7VLW2af9h7g0Uk/DdEM7btNaenFRZ1QXNsq3R6KpDk
         Fu/GDEgLWgRGdNz8BNGAMrhGd70FZPNyJwbz8k9NeltfUzVhhyZNYN8Xif9uL1rYjq9I
         Ybghc41r73Qh0dxTzC3jTj9kCECdKJhC2YGkDcKCTT3t8lTLs9VWJrv6ZGyn1gkuTkjq
         C97c78xIK0N5aZQWuP+uWLDrcO00Q0JCGdWrjbR+e0LhFE6nFAtiMqfGn5ey+SkzcO+8
         STVQ==
X-Gm-Message-State: AOAM531eUUEReNyV9AyVtwcz3TF3FDb1ao7nmNT2o8FGfIy+W5IxUFv8
        kwfGtN1hzK4ErgE+5H3XIv3JjA==
X-Google-Smtp-Source: ABdhPJy20QnLwrpXn7vdPTMw3PnkKaBpL7DDkUHrtMUHh80cC++74MVm/hTAUfPD5/mq5pZG1IYRLg==
X-Received: by 2002:a1c:1946:: with SMTP id 67mr2056817wmz.15.1603456369233;
        Fri, 23 Oct 2020 05:32:49 -0700 (PDT)
Received: from vanye (cpc92880-cmbg19-2-0-cust79.5-4.cable.virginm.net. [82.27.104.80])
        by smtp.gmail.com with ESMTPSA id v189sm2829264wmg.14.2020.10.23.05.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 05:32:48 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:32:46 +0100
From:   Leif Lindholm <leif@nuviainc.com>
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc:     linux-efi@vger.kernel.org, grub-devel@gnu.org,
        daniel.kiper@oracle.com
Subject: Re: [PATCH 3/4] efi: implemented LoadFile2 initr loading protocol
 for Linux
Message-ID: <20201023123246.GC1664@vanye>
References: <20201023120825.30466-1-ard.biesheuvel@arm.com>
 <20201023120825.30466-4-ard.biesheuvel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023120825.30466-4-ard.biesheuvel@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

initrd typo in subject

minor style comments below

On Fri, Oct 23, 2020 at 14:08:24 +0200, Ard Biesheuvel wrote:
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
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> ---
>  grub-core/loader/arm64/linux.c | 117 +++++++++++++++++++-
>  1 file changed, 116 insertions(+), 1 deletion(-)
> 
> diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
> index ef3e9f9444ca..285422c7bd43 100644
> --- a/grub-core/loader/arm64/linux.c
> +++ b/grub-core/loader/arm64/linux.c
> @@ -48,9 +48,16 @@ static grub_uint32_t cmdline_size;
>  static grub_addr_t initrd_start;
>  static grub_addr_t initrd_end;
>  
> +static struct grub_linux_initrd_context initrd_ctx = { 0, 0, 0 };
> +static grub_efi_handle_t initrd_lf2_handle;
> +static int initrd_use_loadfile2;
> +
>  grub_err_t
>  grub_arch_efi_linux_check_image (struct linux_arch_kernel_header * lh)
>  {
> +  struct grub_pe32_coff_header *coff_header;
> +  struct grub_pe32_optional_header *optional_header;
> +
>    if (lh->magic != GRUB_LINUX_ARMXX_MAGIC_SIGNATURE)
>      return grub_error(GRUB_ERR_BAD_OS, "invalid magic number");
>  
> @@ -61,6 +68,21 @@ grub_arch_efi_linux_check_image (struct linux_arch_kernel_header * lh)
>    grub_dprintf ("linux", "UEFI stub kernel:\n");
>    grub_dprintf ("linux", "PE/COFF header @ %08x\n", lh->hdr_offset);
>  
> +  coff_header = (struct grub_pe32_coff_header *)((unsigned long)lh + lh->hdr_offset);
> +  optional_header = (struct grub_pe32_optional_header *)(coff_header + 1);
> +
> +  /*
> +   * Linux kernels built for any architecture are guaranteed to support the
> +   * LoadFile2 based initrd loading protocol if the image version is >= 1.
> +   */
> +  if (optional_header->major_image_version >= 1)
> +    initrd_use_loadfile2 = 1;
> +   else

funky indentation

> +    initrd_use_loadfile2 = 0;
> +
> +  grub_dprintf ("linux", "LoadFile2 initrd loading %sabled\n",
> +		initrd_use_loadfile2 ? "en" : "dis");
> +
>    return GRUB_ERR_NONE;
>  }
>  
> @@ -230,13 +252,88 @@ allocate_initrd_mem (int initrd_pages)
>  				       GRUB_EFI_LOADER_DATA);
>  }
>  
> +struct initrd_media_device_path {
> +  grub_efi_vendor_media_device_path_t	vendor;
> +  grub_efi_device_path_t		end;
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

Static functions don't need global prefixes (i.e., initrd_load_file2
would be sufficient).

> +                           grub_efi_device_path_t *device_path,
> +                           grub_efi_boolean_t boot_policy,
> +                           grub_efi_uintn_t *buffer_size,
> +                           void *buffer);
> +
> +static grub_efi_load_file2_t initrd_lf2 = {
> +  grub_efi_initrd_load_file2
> +};
> +
> +static grub_efi_status_t
> +grub_efi_initrd_load_file2(grub_efi_load_file2_t *this,
> +			   grub_efi_device_path_t *device_path,
> +			   grub_efi_boolean_t boot_policy,
> +			   grub_efi_uintn_t *buffer_size,
> +			   void *buffer)
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
> +  grub_dprintf ("linux", "Loading initrd via LOAD_FILE2_PROTOCOL\n");
> +
> +  if (grub_initrd_load (&initrd_ctx, NULL, buffer))
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
> +  grub_efi_guid_t load_file2_guid = GRUB_EFI_LOAD_FILE2_PROTOCOL_GUID;
> +  grub_efi_guid_t device_path_guid = GRUB_EFI_DEVICE_PATH_GUID;
> +  grub_efi_boot_services_t *b;
> +  grub_efi_status_t status;
>  
>    if (argc == 0)
>      {
> @@ -254,6 +351,24 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
>    if (grub_initrd_init (argc, argv, &initrd_ctx))
>      goto fail;
>  
> +  if (initrd_use_loadfile2 && !initrd_lf2_handle)
> +    {
> +      b = grub_efi_system_table->boot_services;
> +      status = b->install_multiple_protocol_interfaces (&initrd_lf2_handle,
> +							&load_file2_guid,
> +							&initrd_lf2,
> +							&device_path_guid,
> +							&initrd_lf2_device_path,
> +							NULL);
> +      if (status == GRUB_EFI_OUT_OF_RESOURCES)
> +        {

indented by spaces

> +	  grub_error (GRUB_ERR_OUT_OF_MEMORY, N_("out of memory"));
> +	  return grub_errno;
> +	}

indented with tab

/
    Leif

> +      grub_dprintf ("linux", "LoadFile2 initrd loading protocol installed\n");
> +      return GRUB_ERR_NONE;
> +    }
> +
>    initrd_size = grub_get_initrd_size (&initrd_ctx);
>    grub_dprintf ("linux", "Loading initrd\n");
>  
> -- 
> 2.17.1
> 
