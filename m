Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60B8419CF5
	for <lists+linux-efi@lfdr.de>; Mon, 27 Sep 2021 19:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbhI0RgQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Sep 2021 13:36:16 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45034 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbhI0RfE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Sep 2021 13:35:04 -0400
Received: by mail-oi1-f177.google.com with SMTP id e24so16651028oig.11;
        Mon, 27 Sep 2021 10:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTl4v4xRY/QeaUhXMVUUEMkzsjdM8aQdj906WW5kU7s=;
        b=RDw4x1Hkfgbhac/lpGI3CErQ7yqRljL+iA7I4aZEggmv0nKNjvttl/W1fhfZceZhnX
         2OVIuA0SpmNQnv9n3OKDvoKYohK7bfOIXwlQ0tY4r8Lbhgd04ILN060sIlT2Tqg+4+mj
         4BWlKbdVM0wdN5T5yX5aHsywXbUYfAoWC0D0iLJTtbYvQJvJX22r4eks2dVWthS4sYKL
         I8MrwTA0n/C2mWwmKOR9rF+aEaemvjkY2Up1y96El9yd8C9RLfHHNWHYb9hiVmUpQxFR
         xKrcGhpcTQN3sb5folcttdsJIplQodmADmkILXnrvpnTiIJX1SwZ4GBtE8kUU3/43Ty1
         /6cw==
X-Gm-Message-State: AOAM533QG/GEKdjgeCnLpOQqxHTA9jCI/XDUZc6NVWh4QeAMQJBdCv0u
        7dVLkGNcE3JgLkt55zCoDxtGUEuO7buZZSZgDo7l+5Zr3qs=
X-Google-Smtp-Source: ABdhPJwXW05EAs293dZM1rzhd2iY7NyFCj+CsMn6l0H9oZ+sKB8TqfUMumz+aoNWEmCmKaqPusGNI5dcmARRoYH8YXc=
X-Received: by 2002:a05:6808:1816:: with SMTP id bh22mr190669oib.69.1632764006375;
 Mon, 27 Sep 2021 10:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631802162.git.yu.c.chen@intel.com> <afe88d0bbab0fbed289cceceec009be99120effa.1631802163.git.yu.c.chen@intel.com>
In-Reply-To: <afe88d0bbab0fbed289cceceec009be99120effa.1631802163.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Sep 2021 19:33:15 +0200
Message-ID: <CAJZ5v0ikSrHuJ25j74ARJxM1wedt63Q8F2kQ4YSgJFSbx+5nOw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] efi: Introduce EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
 and corresponding structures
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 16, 2021 at 5:54 PM Chen Yu <yu.c.chen@intel.com> wrote:
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
> version number is valid. The EFI_CAPSULE_HEADER has been defined in the
> kernel, however the rest are not, thus introduce corresponding UEFI
> structures accordingly.
>
> The reason why efi_manage_capsule_header_t and
> efi_manage_capsule_image_header_t are packedi might be that:
> According to the uefi spec,
> [Figure 23-6 Firmware Management and Firmware Image Management headers]
> EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER is located at the lowest offset
> within the body of the capsule. And this structure is designed to be
> unaligned to save space, because in this way the adjacent drivers and
> binary payload elements could start on byte boundary with no padding.
> And the EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER is at the head of
> each payload, so packing this structure also makes room for more data.

IMO it would be sufficient to say that both
EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and
EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER need not be aligned and
so the corresponding data types should be packed.

>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  include/linux/efi.h | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 6b5d36babfcc..19ff834e1388 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -148,6 +148,56 @@ typedef struct {
>         u32 imagesize;
>  } efi_capsule_header_t;
>
> +#pragma pack(1)
> +
> +/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER */
> +typedef struct {
> +       u32     ver;
> +       u16     emb_drv_cnt;
> +       u16     payload_cnt;
> +       /*
> +        * Variable array indicated by number of
> +        * (emb_drv_cnt + payload_cnt)
> +        */
> +       u64     offset_list[];
> +} efi_manage_capsule_header_t;
> +
> +/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER */
> +typedef struct {
> +       u32     ver;
> +       guid_t  image_type_id;
> +       u8      image_index;
> +       u8      reserved_bytes[3];
> +       u32     image_size;
> +       u32     vendor_code_size;
> +       /* ver = 2. */
> +       u64     hw_ins;
> +       /* ver = v3. */
> +       u64     capsule_support;
> +} efi_manage_capsule_image_header_t;
> +
> +#pragma pack()
> +
> +/* WIN_CERTIFICATE */
> +typedef struct {
> +       u32     len;
> +       u16     rev;
> +       u16     cert_type;
> +} win_cert_t;
> +
> +/* WIN_CERTIFICATE_UEFI_GUID */
> +typedef struct {
> +       win_cert_t      hdr;
> +       guid_t          cert_type;
> +       u8              cert_data[];
> +} win_cert_uefi_guid_t;
> +
> +/* EFI_FIRMWARE_IMAGE_AUTHENTICATIO */
> +typedef struct {
> +       u64                             mon_count;
> +       win_cert_uefi_guid_t            auth_info;
> +} efi_image_auth_t;
> +
>  /*
>   * EFI capsule flags
>   */
> --
> 2.25.1
>
