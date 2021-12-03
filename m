Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3E467D2B
	for <lists+linux-efi@lfdr.de>; Fri,  3 Dec 2021 19:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382554AbhLCSYe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Dec 2021 13:24:34 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40810 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382531AbhLCSYe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Dec 2021 13:24:34 -0500
Received: by mail-ot1-f54.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so4374958otj.7;
        Fri, 03 Dec 2021 10:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aR/ePfeH8SZCsR0u6Fq5Cd4+fUSZxl31ja5HBnpdJk=;
        b=SbAz/yjtAQPKhDVYKjgo1eAEwlUNRq4fvIuQz836veR5b/LQkow5Gsu78iyqqjILou
         xaSsY3MriF1s6t9Rw33O58M6Hm4cRTg35BUiLL5tUoJGSYSIpoCBBolpSVNRI53YEI7u
         WfEM3R4Wwn28D4FYP589P1gW3KwgwkSmXJ6Kq4hPoWPnXVD+Gd8IhAo68tcyotk5cXq6
         Ohne60KQ9UDIHbGxP2FrgcR2wdtH8LLr2Jpk9k4JZOMQ42qyg2HQcNAlZpaTXTzEti5O
         BbmLIF+QrbGydUjhoLUOMqT1300laYw3OlnSnoIChsfmQtHDPHDKJy/ej+zA/GxksW9x
         bU7Q==
X-Gm-Message-State: AOAM533EAknQ6QY6NW4M4VFBViAsyVIXIgAywVpN+ITfTS+ySTbUmDaq
        eLDs/BQaDXyg+WvBBe9TdFMZ9z5dYHnKIINzk8g=
X-Google-Smtp-Source: ABdhPJzy9knuAYlk6AtNOv+Y+i94nixQ52AbrpYzyGiTk7CSQSduZwCCOkNUuECq+ySBG7+w+dLbWxLm04YW6W4kiiY=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr18082042otu.254.1638555669383;
 Fri, 03 Dec 2021 10:21:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637505679.git.yu.c.chen@intel.com> <6774dd4cce68a68b1ac54df3dfd295bb4b04bf2b.1637505679.git.yu.c.chen@intel.com>
In-Reply-To: <6774dd4cce68a68b1ac54df3dfd295bb4b04bf2b.1637505679.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Dec 2021 19:20:58 +0100
Message-ID: <CAJZ5v0j2m8EOVM2EDWtff3tZ9V0eaw3PhA8-bXR-kdMyCfHyHg@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] efi: Introduce EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
 and corresponding structures
To:     Chen Yu <yu.c.chen@intel.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Nov 21, 2021 at 4:17 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Platform Firmware Runtime Update image starts with UEFI headers, and the
> headers are defined in UEFI specification, but some of them have not been
> defined in the kernel yet.
>
> For example, the header layout of a capsule file looks like this:
>
> EFI_CAPSULE_HEADER
> EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER
> EFI_FIRMWARE_IMAGE_AUTHENTICATION
>
> These structures would be used by the Platform Firmware Runtime Update
> driver to parse the format of capsule file to verify if the corresponding
> version number is valid. In this way, if the user provides an invalid
> capsule image, the kernel could be used as a guard to reject it, without
> switching to the Management Mode (which might be costly).
>
> EFI_CAPSULE_HEADER has been defined in the kernel, but the other
> structures have not been defined yet, so do that. Besides,
> EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and
> EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER are required to be packed
> in the uefi specification. For this reason, use the __packed attribute
> to indicate to the compiler that the entire structure can appear
> misaligned in memory (as suggested by Ard) in case one of them follows
> the other directly in a capsule header.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v11:Add explanation on why version check is introduced
>     in kernel rather than letting Management Mode to do it.
>     (Rafael J. Wysocki)
>     Revise the commit log to better describe the pack attribute.
>     (Rafael J. Wysocki)
>     Refine the comment for hw_ins and capsule_support.
>     (Rafael J. Wysocki)
> v10:Remove the explicit assignment of the last item of enum.
>     (Andy Shevchenko)
> v9: Use GUID_INIT() instead of guid_parse() during boot up.
>     (Andy Shevchenko)
>     Drop uuid, code_uuid, drv_uuid in struct pfru_device as they
>     are not needed. (Andy Shevchenko)
>     Drop type casting from void * in valid_version().
>     (Andy Shevchenko)
>     Use kfree() instead of ACPI_FREE() in non-ACPICA usage.
>     (Andy Shevchenko)
>     Use sizeof(rev) instead of sizeof(u32) in copy_from_user().
>     (Andy Shevchenko)
>     Generate physical address from MSB part to LSB.
>     (Andy Shevchenko)
>     Use devm_add_action_or_reset() to add ida release into dev resource
>     management. (Andy Shevchenko)
>     Use devm_kasprintf() instead of kasprintf() to format the
>     pfru_dev name.(Andy Shevchenko)
>     Remove redundant 0 in acpi_pfru_ids. (Andy Shevchenko)
>     Adjust the order of included headers in pfru.h.
>     (Andy Shevchenko)
>     Replace PFRU_MAGIC with PFRU_MAGIC_FOR_IOCTL in uapi file.
>     (Andy Shevchenko)
> v8: Remove the variable-length array in struct pfru_update_cap_info, and
>     copy the non-variable-length struct pfru_update_cap_info to userspace
>     directly. (Greg Kroah-Hartman)
>     Change the type of rev_id from int to u32, because this data will
>     be copied between kernel and userspace. (Greg Kroah-Hartman)
>     Add a prefix for dev in struct pfru_device to parent_dev, so as
>     to indicate that this filed is the parent of the created miscdev.
>     (Greg Kroah-Hartman)
>     Use blank lines between different macro sections. (Greg Kroah-Hartman)
>     Illusatrate the possible errno for each ioctl interface.
>     (Greg Kroah-Hartman)
>     Remove pfru_valid_revid() from uapi header to avoid poluting the global
>     namespace.(Greg Kroah-Hartman)
>     Assign the value to the enum type explicitly.(Greg Kroah-Hartman)
>     Change the guid_t to efi_guid_t when parsing image header in get_image_type()
>     (Greg Kroah-Hartman)
>     Remove the void * to other type casting in valid_version(). (Andy Shevchenko)
>     Combined the assignment of variables with definitions. (Andy Shevchenko)
>     Define this magic for revision ID. (Andy Shevchenko)
>     Make the labeling consistent for error handling. (Andy Shevchenko)
>     Replace the UUID_SIZE in uapi with 16 directly. (Andy Shevchenko)
>     Add blank line between generic include header and uapi header.
>     (Andy Shevchenko)
>     Arrange the order between devm_kzalloc() and normal allocation in
>     acpi_pfru_probe() that, the former should always be ahead of the
>     latter. (Andy Shevchenko)
>     Move the UUID from uapi header to the c file. (Andy Shevchenko)
> v7: Use ida_alloc() to allocate a ID, and release the ID when
>     device is removed. (Greg Kroah-Hartman)
>     Check the _DSM method at early stage, before allocate or parse
>     anything in acpi_pfru_probe(). (Greg Kroah-Hartman)
>     Set the parent of the misc device. (Greg Kroah-Hartman)
>     Use module_platform_driver() instead of platform_driver_register()
>     in module_init(). Separate pfru driver and pfru_telemetry driver
>     to two files. (Greg Kroah-Hartman)
> v6: Use Link: tag to add the specification download address.
>     (Andy Shevchenko)
>     Remove linux/uuid.h and use raw buffers to contain uuid.
>     (Andy Shevchenko)
>     Drop comma for each terminator entry in the enum structure.
>     (Andy Shevchenko)
>     Remove redundant 'else' in get_image_type().
>     (Andy Shevchenko)
>     Directly return results from the switch cases in adjust_efi_size()
>     and pfru_ioctl().(Andy Shevchenko)
>     Keep comment style consistent by removing the period for
>     one line comment.
>     (Andy Shevchenko)
>     Remove devm_kfree() if .probe() failed.
>     (Andy Shevchenko)
> v5: Remove Documentation/ABI/pfru, and move the content to kernel doc
>     in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
>     Shrink the range of ioctl numbers declared in
>     Documentation/userspace-api/ioctl/ioctl-number.rst
>     from 16 to 8. (Greg Kroah-Hartman)
>     Change global variable struct pfru_device *pfru_dev to
>     per ACPI device. (Greg Kroah-Hartman)
>     Unregister the misc device in acpi_pfru_remove().
>     (Greg Kroah-Hartman)
>     Convert the kzalloc() to devm_kzalloc() in the driver so
>     as to avoid freeing the memory. (Greg Kroah-Hartman)
>     Fix the compile error by declaring the pfru_log_ioctl() as
>     static. (kernel test robot LKP)
>     Change to global variable misc_device to per ACPI device.
>     (Greg Kroah-Hartman)
> v4: Replace all pr_err() with dev_dbg() (Greg Kroah-Hartman,
>     Rafael J. Wysocki)
>     Returns ENOTTY rather than ENOIOCTLCMD if invalid ioctl command
>     is provided. (Greg Kroah-Hartman)
>     Remove compat ioctl. (Greg Kroah-Hartman)
>     Rename /dev/pfru/pfru_update to /dev/acpi_pfru (Greg Kroah-Hartman)
>     Simplify the check for element of the package in query_capability()
>     (Rafael J. Wysocki)
>     Remove the loop in query_capability(), query_buffer() and query
>     the package elemenet directly. (Rafael J. Wysocki)
>     Check the the number of elements in case the number of package
>     elements is too small. (Rafael J. Wysocki)
>     Doing the assignment as initialization in get_image_type().
>     Meanwhile, returns the type or a negative error code in
>     get_image_type(). (Rafael J. Wysocki)
>     Put the comments inside the function. (Rafael J. Wysocki)
>     Returns the size or a negative error code in adjust_efi_size()
>     (Rafael J. Wysocki)
>     Fix the return value from EFAULT to EINVAL if pfru_valid_revid()
>     does not pass. (Rafael J. Wysocki)
>     Change the write() to be the code injection/update, the read() to
>     be telemetry retrieval and all of the rest to be ioctl()s under
>     one special device file.(Rafael J. Wysocki)
>     Putting empty code lines after an if () statement that is not
>     followed by a block. (Rafael J. Wysocki)
>     Remove "goto" tags to make the code more readable. (Rafael J. Wysocki)
> v3: Use __u32 instead of int and __64 instead of unsigned long
>     in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
>     Rename the structure in uapi to start with a prefix pfru so as
>     to avoid confusing in the global namespace. (Greg Kroah-Hartman)
> v2: Add sanity check for duplicated instance of ACPI device.
>     Update the driver to work with allocated pfru_device objects.
>     (Mike Rapoport)
>     For each switch case pair, get rid of the magic case numbers
>     and add a default clause with the error handling.
>     (Mike Rapoport)
>     Move the obj->type checks outside the switch to reduce redundancy.
>     (Mike Rapoport)
>     Parse the code_inj_id and drv_update_id at driver initialization time
>     to reduce the re-parsing at runtime.(Mike Rapoport)
>     Explain in detail how the size needs to be adjusted when doing
>     version check.(Mike Rapoport)
>     Rename parse_update_result() to dump_update_result()(Mike Rapoport)
>     Remove redundant return.(Mike Rapoport)
>     Do not expose struct capsulate_buf_info to uapi, since it is
>     not needed in userspace.(Mike Rapoport)
> ---

OK, this is simple enough.

Ard, any concerns?

>  include/linux/efi.h | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index dbd39b20e034..80e970f7e6f8 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -148,6 +148,52 @@ typedef struct {
>         u32 imagesize;
>  } efi_capsule_header_t;
>
> +/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER */
> +struct efi_manage_capsule_header {
> +       u32 ver;
> +       u16 emb_drv_cnt;
> +       u16 payload_cnt;
> +       /*
> +        * Variable-size array of the size given by the sum of
> +        * emb_drv_cnt and payload_cnt.
> +        */
> +       u64 offset_list[];
> +} __packed;
> +
> +/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER */
> +struct efi_manage_capsule_image_header {
> +       u32 ver;
> +       efi_guid_t image_type_id;
> +       u8 image_index;
> +       u8 reserved_bytes[3];
> +       u32 image_size;
> +       u32 vendor_code_size;
> +       /* hw_ins was introduced in version 2 */
> +       u64 hw_ins;
> +       /* capsule_support was introduced in version 3 */
> +       u64 capsule_support;
> +} __packed;
> +
> +/* WIN_CERTIFICATE */
> +struct win_cert {
> +       u32 len;
> +       u16 rev;
> +       u16 cert_type;
> +};
> +
> +/* WIN_CERTIFICATE_UEFI_GUID */
> +struct win_cert_uefi_guid {
> +       struct win_cert hdr;
> +       efi_guid_t cert_type;
> +       u8 cert_data[];
> +};
> +
> +/* EFI_FIRMWARE_IMAGE_AUTHENTICATION */
> +struct efi_image_auth {
> +       u64 mon_count;
> +       struct win_cert_uefi_guid auth_info;
> +};
> +
>  /*
>   * EFI capsule flags
>   */
> --
> 2.25.1
>
