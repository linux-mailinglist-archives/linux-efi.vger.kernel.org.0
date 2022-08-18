Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA57598A1E
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 19:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345322AbiHRRQ5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245752AbiHRRQ2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 13:16:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DADC12C0
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 10:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17DADB8221B
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 17:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF686C43143
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660842635;
        bh=r9nzNsETLfxbJ/ZbrnlJinCewM+ma7BdBGrtCyHFtAk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AcSXrASkNNSoEgAAKlYPlJ8FuxjjRfnFMrhuZCTniWeBQ1KyK4fSRa+aQp3u/TjdR
         pFuSlPfFf67DZnDF/O00JHQBESutIQpptsKf+Mk+SFR1ubOsiNDcXK7dizZZY2xH4j
         sOrMgHG11V6X+dcnpiwyyH2LT5TFRg1QWvUxxL0EJx6O53SAniL3/YUM1NgWzFkmfU
         Hl7CmemeowLnDbU6AWPvFa4loFvTcesdCaD9AjgDeXQGocIzNgkrf/uzl8vgsRBUI1
         FqH2fJHM+OSv+3o7BJpXiBConwhrL+qjC43XU/fqvLtPzZjdLMAONcZnxE3WLutC9X
         HMuUxQboShqcg==
Received: by mail-wr1-f52.google.com with SMTP id h5so1649751wru.7
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 10:10:35 -0700 (PDT)
X-Gm-Message-State: ACgBeo03sBMr673SDNDYAwJGqaXuW4O0rtegbrIBEHKgOVLOuH8Io8i5
        ZoRzLiszZVSkoVgcjwAPgwEj+Ft460/E23bLrvM=
X-Google-Smtp-Source: AA6agR4DD6NZcwCpFKBnBW+Hp4o8IZUjYaxJeXudo0siUWHz8KXnnC9wvsYKrVtLjC9feb59Ma4wV+POFWmVBfMiBqs=
X-Received: by 2002:a5d:64c9:0:b0:220:79cc:b7c9 with SMTP id
 f9-20020a5d64c9000000b0022079ccb7c9mr2035125wri.103.1660842633869; Thu, 18
 Aug 2022 10:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220817110345.1771267-1-ardb@kernel.org> <20220817110345.1771267-5-ardb@kernel.org>
 <97c62ac5-46c5-c0cd-3226-07a28051a750@canonical.com>
In-Reply-To: <97c62ac5-46c5-c0cd-3226-07a28051a750@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 Aug 2022 19:10:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHgnsGWscVFs_HQ_tLmoLAgcORC8k5Y0K_1m-XZWsxqMg@mail.gmail.com>
Message-ID: <CAMj1kXHgnsGWscVFs_HQ_tLmoLAgcORC8k5Y0K_1m-XZWsxqMg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] efi/libstub: implement generic EFI zboot
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 18 Aug 2022 at 18:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 8/17/22 13:03, Ard Biesheuvel wrote:
> > Implement a minimal EFI app that decompresses the real kernel image and
> > launches it using the firmware's LoadImage and StartImage boot services.
> > This removes the need for any arch-specific hacks.
> >
> > Note that on systems that have UEFI secure boot policies enabled,
> > LoadImage/StartImage require images to be signed, or their hashes known
> > a priori, in order to be permitted to boot.
> >
> > There are various possible strategies to work around this requirement,
> > but they all rely either on overriding internal PI/DXE protocols (which
> > are not part of the EFI spec) or omitting the firmware provided
> > LoadImage() and StartImage() boot services, which is also undesirable,
> > given that they encapsulate platform specific policies related to secure
> > boot and measured boot, but also related to memory permissions (whether
> > or not and which types of heap allocations have both write and execute
> > permissions.)
> >
> > The only generic and truly portable way around this is to simply sign
> > both the inner and the outer image with the same key/cert pair, so this
> > is what is implemented here.
> >
> > BZIP2 has been omitted from the set of supported compression algorithms,
> > given that its performance is mediocre both in speed and size, and it
> > uses a disproportionate amount of memory. For optimal compression, use
> > LZMA. For the fastest boot speed, use LZO.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   drivers/firmware/efi/Kconfig                |  31 ++++-
> >   drivers/firmware/efi/libstub/Makefile       |   8 +-
> >   drivers/firmware/efi/libstub/Makefile.zboot |  69 ++++++++++
> >   drivers/firmware/efi/libstub/zboot-header.S | 139 ++++++++++++++++++++
> >   drivers/firmware/efi/libstub/zboot.c        | 101 ++++++++++++++
> >   drivers/firmware/efi/libstub/zboot.lds      |  39 ++++++
> >   6 files changed, 382 insertions(+), 5 deletions(-)
> >
...
> > diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
> > new file mode 100644
> > index 000000000000..9cf968e90775
> > --- /dev/null
> > +++ b/drivers/firmware/efi/libstub/zboot.c
...
> > +efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
> > +                                   efi_system_table_t *systab)
> > +{
> > +     static efi_guid_t loaded_image = LOADED_IMAGE_PROTOCOL_GUID;
> > +     efi_loaded_image_t *parent, *child;
> > +     unsigned long image_buffer;
> > +     efi_handle_t child_handle;
> > +     efi_status_t status;
> > +     int ret;
> > +
> > +     WRITE_ONCE(efi_system_table, systab);
> > +
> > +     free_mem_ptr = (unsigned long)&zboot_heap;
> > +     free_mem_end_ptr = free_mem_ptr + sizeof(zboot_heap);
> > +
> > +     status = efi_bs_call(handle_protocol, handle, &loaded_image,
> > +                          (void **)&parent);
> > +     if (status != EFI_SUCCESS) {
> > +             log(L"Failed to locate parent's loaded image protocol\n");
> > +             return status;
> > +     }
> > +
> > +     status = efi_allocate_pages(uncompressed_size, &image_buffer, ULONG_MAX);
> > +     if (status != EFI_SUCCESS) {
> > +             log(L"Failed to allocate memory\n");
> > +             return status;
> > +     }
> > +
> > +     ret = __decompress(_gzdata_start, _gzdata_end - _gzdata_start, NULL,
> > +                        NULL, (unsigned char *)image_buffer, 0, NULL,
> > +                        error);
> > +     if (ret < 0) {
> > +             log(L"Decompression failed\n");
> > +             return EFI_LOAD_ERROR;
> > +     }
> > +
> > +     status = efi_bs_call(load_image, false, handle, NULL,
>
> I would prefer to pass the device path of the compressed image instead
> of NULL. This way information is not lost.
>

That way, we will have two loaded images with different handles
claiming to be loaded from the same device path - I don't think that
is appropriate tbh.

What we could do is define a vendor GUID for the decompressed kernel,
and create a device path for it. That way, you can grab the
loaded_image of the parent to obtain this information.

What did you have in mind as a use case?

> > +                          (void *)image_buffer, uncompressed_size,
> > +                          &child_handle);
> > +     if (status != EFI_SUCCESS) {
> > +             log(L"Failed to load image\n");
> > +             return status;
> > +     }
> > +
> > +     status = efi_bs_call(handle_protocol, child_handle, &loaded_image,
> > +                          (void **)&child);
> > +     if (status != EFI_SUCCESS) {
> > +             log(L"Failed to locate child's loaded image protocol\n");
> > +             return status;
> > +     }
> > +
> > +     // Copy the kernel command line
> > +     child->load_options = parent->load_options;
> > +     child->load_options_size = parent->load_options_size;
> > +
> > +     status = efi_bs_call(start_image, child_handle, NULL, NULL);
> > +     if (status != EFI_SUCCESS) {
> > +             log(L"StartImage() returned with error\n");
>
> Please, pass pointers for ExitDataSize and ExitData. If ExitDataSize !=
> 0 a string is provided in ExitData. Return that data to the caller of
> the compressed image. You may additionally print the string here.
>
> The caller then will then take care of freeing ExitData (via FreePool())
> and optionally log the information.
>

Good idea, I will add that.

Thanks,
Ard.
