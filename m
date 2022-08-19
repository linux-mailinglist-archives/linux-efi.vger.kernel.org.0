Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AD95995C4
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 09:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245475AbiHSHHa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 03:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242670AbiHSHHa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 03:07:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25099E1933
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 00:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5372B824F1
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 07:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92514C43145
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 07:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660892846;
        bh=KOHrQSmT0E4I9ZGpi+HQ2mKLgWpxbTgcBzvfx1Snwec=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LUSbm9rV0rpo2HJuiQ1u3FlGuprAcAtEvlGDTyu9qUhdoY4/GDRzX/f+UeuJEzHzt
         KzM3fMkJMja/9VXevfi+az0RzN+BP2KHPcI+IjxydSbQ4X0znrLkCQ0cS9FFpR4Bz3
         1haagpIgNX+8eeKNFTkeMHS+Zsj62A5sYwAQveWh6L4cD4+elRoJfWdzaPi1FtgtjX
         0AcFaCAK1OSCMPIyC3PBEFHn3uvma0I8T/MbgdY0LOyFxmc4LXuiEcHP5egfXlOwUg
         8OBttj6siL2SbXajBPgRjKUL2Kb3+nL3iP7/+xhgqPzW7NU0QvuCavof+t9YWXVLt1
         Pt5PsHtCTraVQ==
Received: by mail-wm1-f47.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso2037245wmr.3
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 00:07:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo2RsFUNGfvHdagQLqEEAKuwHkJ4phYKb0kOwAEO/Sv14BhHU5oA
        DA6ezK+EPMpwWnmumjznt3g4JCZATC1p0nDvvR0=
X-Google-Smtp-Source: AA6agR5m9jIVx6/6MPkUJZe3ivh1f6SSRI0vCbelUPvwj9F/Hgs9ScD/GYSuNQXWVqz/zm67jKFr/yglZjeEKGqjqdI=
X-Received: by 2002:a1c:a3c4:0:b0:3a5:512f:717a with SMTP id
 m187-20020a1ca3c4000000b003a5512f717amr7046784wme.192.1660892844721; Fri, 19
 Aug 2022 00:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220817110345.1771267-1-ardb@kernel.org> <20220817110345.1771267-5-ardb@kernel.org>
 <97c62ac5-46c5-c0cd-3226-07a28051a750@canonical.com> <CAMj1kXHgnsGWscVFs_HQ_tLmoLAgcORC8k5Y0K_1m-XZWsxqMg@mail.gmail.com>
 <f0660f09-94e6-3268-dc95-cb81d9c6f58a@canonical.com> <CAMj1kXFkDo7zHJ2csfRQpeXTWN2skw2yA_kso2Wu0tXQBKc=iA@mail.gmail.com>
 <607f3bb9-9d18-ba2a-3bea-88ae7be680c8@canonical.com>
In-Reply-To: <607f3bb9-9d18-ba2a-3bea-88ae7be680c8@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 19 Aug 2022 09:07:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGchJNvsFPOW-_W1KgozSyyT_vE=PQiJmRH6NE3wbC7CA@mail.gmail.com>
Message-ID: <CAMj1kXGchJNvsFPOW-_W1KgozSyyT_vE=PQiJmRH6NE3wbC7CA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 19 Aug 2022 at 09:01, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 8/19/22 08:52, Ard Biesheuvel wrote:
> > On Fri, 19 Aug 2022 at 07:29, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >>
> >>
> >> On 8/18/22 19:10, Ard Biesheuvel wrote:
> >>> On Thu, 18 Aug 2022 at 18:42, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> On 8/17/22 13:03, Ard Biesheuvel wrote:
> >>>>> Implement a minimal EFI app that decompresses the real kernel image and
> >>>>> launches it using the firmware's LoadImage and StartImage boot services.
> >>>>> This removes the need for any arch-specific hacks.
> >>>>>
> >>>>> Note that on systems that have UEFI secure boot policies enabled,
> >>>>> LoadImage/StartImage require images to be signed, or their hashes known
> >>>>> a priori, in order to be permitted to boot.
> >>>>>
> >>>>> There are various possible strategies to work around this requirement,
> >>>>> but they all rely either on overriding internal PI/DXE protocols (which
> >>>>> are not part of the EFI spec) or omitting the firmware provided
> >>>>> LoadImage() and StartImage() boot services, which is also undesirable,
> >>>>> given that they encapsulate platform specific policies related to secure
> >>>>> boot and measured boot, but also related to memory permissions (whether
> >>>>> or not and which types of heap allocations have both write and execute
> >>>>> permissions.)
> >>>>>
> >>>>> The only generic and truly portable way around this is to simply sign
> >>>>> both the inner and the outer image with the same key/cert pair, so this
> >>>>> is what is implemented here.
> >>>>>
> >>>>> BZIP2 has been omitted from the set of supported compression algorithms,
> >>>>> given that its performance is mediocre both in speed and size, and it
> >>>>> uses a disproportionate amount of memory. For optimal compression, use
> >>>>> LZMA. For the fastest boot speed, use LZO.
> >>>>>
> >>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>>>> ---
> >>>>>     drivers/firmware/efi/Kconfig                |  31 ++++-
> >>>>>     drivers/firmware/efi/libstub/Makefile       |   8 +-
> >>>>>     drivers/firmware/efi/libstub/Makefile.zboot |  69 ++++++++++
> >>>>>     drivers/firmware/efi/libstub/zboot-header.S | 139 ++++++++++++++++++++
> >>>>>     drivers/firmware/efi/libstub/zboot.c        | 101 ++++++++++++++
> >>>>>     drivers/firmware/efi/libstub/zboot.lds      |  39 ++++++
> >>>>>     6 files changed, 382 insertions(+), 5 deletions(-)
> >>>>>
> >>> ...
> >>>>> diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
> >>>>> new file mode 100644
> >>>>> index 000000000000..9cf968e90775
> >>>>> --- /dev/null
> >>>>> +++ b/drivers/firmware/efi/libstub/zboot.c
> >>> ...
> >>>>> +efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
> >>>>> +                                   efi_system_table_t *systab)
> >>>>> +{
> >>>>> +     static efi_guid_t loaded_image = LOADED_IMAGE_PROTOCOL_GUID;
> >>>>> +     efi_loaded_image_t *parent, *child;
> >>>>> +     unsigned long image_buffer;
> >>>>> +     efi_handle_t child_handle;
> >>>>> +     efi_status_t status;
> >>>>> +     int ret;
> >>>>> +
> >>>>> +     WRITE_ONCE(efi_system_table, systab);
> >>>>> +
> >>>>> +     free_mem_ptr = (unsigned long)&zboot_heap;
> >>>>> +     free_mem_end_ptr = free_mem_ptr + sizeof(zboot_heap);
> >>>>> +
> >>>>> +     status = efi_bs_call(handle_protocol, handle, &loaded_image,
> >>>>> +                          (void **)&parent);
> >>>>> +     if (status != EFI_SUCCESS) {
> >>>>> +             log(L"Failed to locate parent's loaded image protocol\n");
> >>>>> +             return status;
> >>>>> +     }
> >>>>> +
> >>>>> +     status = efi_allocate_pages(uncompressed_size, &image_buffer, ULONG_MAX);
> >>>>> +     if (status != EFI_SUCCESS) {
> >>>>> +             log(L"Failed to allocate memory\n");
> >>>>> +             return status;
> >>>>> +     }
> >>>>> +
> >>>>> +     ret = __decompress(_gzdata_start, _gzdata_end - _gzdata_start, NULL,
> >>>>> +                        NULL, (unsigned char *)image_buffer, 0, NULL,
> >>>>> +                        error);
> >>>>> +     if (ret < 0) {
> >>>>> +             log(L"Decompression failed\n");
> >>>>> +             return EFI_LOAD_ERROR;
> >>>>> +     }
> >>>>> +
> >>>>> +     status = efi_bs_call(load_image, false, handle, NULL,
> >>>>
> >>>> I would prefer to pass the device path of the compressed image instead
> >>>> of NULL. This way information is not lost.
> >>>>
> >>>
> >>> That way, we will have two loaded images with different handles
> >>> claiming to be loaded from the same device path - I don't think that
> >>> is appropriate tbh.
> >>
> >> They both are the product of the same file on disk.
> >>
> >
> > But they are not the same. When re-loading the device path (as you
> > suggest below) you will get a completely different file, and the only
> > way to get at the payload is to execute it.
> >
> > So using the same device path is out of the question imo.
>
> How about appending a VenHW() node with a decompressor specific GUID at
> the end of the DP?
>
> I think that is the most UEFIish way to express that the handle is
> derived from the compressed file.
>
> You could even put additional information into the VenHW() node like the
> compression type or the compressed size.
>

Uhm, yes, that is what I am proposing further down in this email.

See below.

> >
> >>>
> >>> What we could do is define a vendor GUID for the decompressed kernel,
> >>> and create a device path for it. That way, you can grab the
> >>> loaded_image of the parent to obtain this information.
> >>>
> >>> What did you have in mind as a use case?
> >>
> >> The device-path could be used in the kernel log.
> >>
> >> It can be used to find the device or folder with initrd where we use
> >> initrd= on the command line.
> >>
> >> You could use the device path to access the original file, e.g. to read
> >> additional information.
> >>
> >> For all use cases you would want to have the original device path.
> >>
> >
> > What we could do is:
> >
> > - define a device path in the decompressor, e.g.,
> >
> > <original device path>/Offset(<start>, <end>)/VendorMedia(xxx-xxx-xxx,
> > <compression type>)
> >
> > where start, end and compression type describe the compressed payload
> > inside the decompressor executable. (The compression type could be
> > omitted, or could be a separate node.)
> >
> > - install the LoadFile2 protocol and the device path protocol onto a
> > handle, and move the decompression logic into the LoadFile2
> > implementation
> >
> > - drop the SourceBuffer and SourceSize arguments to LoadImage(), and
> > pass the device path instead, so that LoadFile2 will be invoked by
> > LoadImage directly to perform the decompression.
> >
> > That way, we retain the information about the outer file, and each
> > piece is described in detail in device path notation. As a bonus, we
> > could easily expose the compressed part separately, if there is a need
> > for that.
> >
> > This doesn't cover the initrd= issue you raised, but that is something
> > we could address later in the stub if we wanted to (but I don't think
> > initrd= is something we should care too much about)
>
