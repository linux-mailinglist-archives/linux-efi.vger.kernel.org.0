Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EACD6361E8
	for <lists+linux-efi@lfdr.de>; Wed, 23 Nov 2022 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiKWOeI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Nov 2022 09:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiKWOeH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Nov 2022 09:34:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE7A12753;
        Wed, 23 Nov 2022 06:34:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7D23B8201D;
        Wed, 23 Nov 2022 14:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E67C433D7;
        Wed, 23 Nov 2022 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669214043;
        bh=CL6uXIKxo5TjSgBVdPejsMhade/mRjxvbEKqv49l560=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=arsDZavRT9hnzeYLFHylffVKtGAumwnEWQFaXwxNbIAohlJzPm6i7uIZzY3RmgkX0
         GoNx472dnZmIcDm3jKRXKGgsmyOv0chslLRYWnjaAa/ufpWUItMLj6Uwji6qFHZk9O
         xVpO+Fr4Ayrf6avo901T0ejTbsr9sDJvxa9ZZ3pCTqpQPo+J1/IkKXC9bJxTva61Ur
         H89GrDm6TyCh+JiP6/eTP5ZC2AWzppxCXfSufPRRCRcBUDy9k5CQXo7Q/akQXHXCch
         aOZHtyJoKW3wP7mBFcnI5MDsftrxH5HaqlXse6QkFpzM/oCZ3IxNA5H/maIeIsYe0t
         nszXYeBNbQ6Yw==
Received: by mail-lj1-f178.google.com with SMTP id d3so21634889ljl.1;
        Wed, 23 Nov 2022 06:34:03 -0800 (PST)
X-Gm-Message-State: ANoB5pkYhbEMnpNoJg+Vwp65pFIprYO+HQVDcwLCxrVlI6/ile+U1J6l
        XnCfi8UxGkI+c6wUqr8W40G/y2mNYRHjqmiXe60=
X-Google-Smtp-Source: AA0mqf7bZ16R8YsWswuAAwb0RzuypRMB1q8FhynmVpAsg8sz5ZbwdoovenicyC6GOckRmSaErPTRYIXeUw276wUBY74=
X-Received: by 2002:a2e:88d3:0:b0:277:72a:41a5 with SMTP id
 a19-20020a2e88d3000000b00277072a41a5mr10030835ljk.352.1669214041602; Wed, 23
 Nov 2022 06:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20221122161017.2426828-1-ardb@kernel.org> <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
 <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
 <26c34f9e-3b09-7b10-09a2-993a50790447@amd.com> <Y336yE4P3NjCGavN@zn.tnic>
 <CAMj1kXGnGz+V3tmonitY+3TiWuWJFWj-mQLUbRo+xp8UwZ_SpQ@mail.gmail.com> <66416f08-1daf-63c9-8ecc-47f4e2e09ba7@amd.com>
In-Reply-To: <66416f08-1daf-63c9-8ecc-47f4e2e09ba7@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Nov 2022 15:33:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEo-Q56+0o52Uwi2gNwBpa7UahiuW5Ej9KBXnzB3c4zsQ@mail.gmail.com>
Message-ID: <CAMj1kXEo-Q56+0o52Uwi2gNwBpa7UahiuW5Ej9KBXnzB3c4zsQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 23 Nov 2022 at 15:16, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 11/23/22 04:52, Ard Biesheuvel wrote:
> > On Wed, 23 Nov 2022 at 11:49, Borislav Petkov <bp@alien8.de> wrote:
> >>
> >> On Tue, Nov 22, 2022 at 03:49:29PM -0600, Tom Lendacky wrote:
> >>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> >>> index cb5f0befee57..a0bfd31358ba 100644
> >>> --- a/drivers/firmware/efi/libstub/x86-stub.c
> >>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> >>> @@ -23,7 +23,7 @@
> >>>   const efi_system_table_t *efi_system_table;
> >>>   const efi_dxe_services_table_t *efi_dxe_table;
> >>> -u32 image_offset;
> >>> +u32 image_offset __section(".data");
> >>>   static efi_loaded_image_t *image = NULL;
> >>>   static efi_status_t
> >>>
> >>> I assume it has to do with being in .data vs .bss and not being explicitly
> >>> cleared with the encryption bit set. With the change to put image_offset in
> >>> the .data section, it is read as zero, where as when it was in the .bss
> >>> section it was reading "ciphertext".
> >>
> >> Hmm, two points about this:
> >>
> >> 1. Can we do
> >>
> >> u32 image_offset __bss_decrypted;
> >>
> >> here instead? We have this special section just for that fun and it
> >> self-documents this way.
> >>
> >
> > The patch moves it from .data to .bss inadvertently, and I am not
> > convinced Tom's analysis is entirely accurate: we may simply have
> > garbage in image_offset if we access it before .bss gets cleared.
>
> When running non-encrypted, I imagine all the memory is cleared to zero as
> part of Qemu allocating it. As soon as you put an SEV guest on top of
> that, host made zeroes will not appear as zeroes to the SEV guest, rather
> they will be decrypted and end up looking like ciphertext (hence the
> random values I kept seeing in image_offset). The SEV guest must
> explicitly clear it, which is why having it in .bss doesn't work for SEV.
>

Yes, QEMU will probably clear it, but GRUB, shim, etc do a terrible
job at implementing image loading correctly, i.e., not bothering to
parse the PE/COFF header at all, but just copying the image into
memory and invoke it at a fixed offset of 0x290 bytes into the image
(the famous EFI handover protocol, see the last patch in this series
if you want to know more :-))

This also means that the balance of the file size vs the image size
(where BSS lives) is completely ignored, and we actually have to
relocate the image from the EFI stub in such cases, because we cannot
be sure that the BSS does not overlap with memory that is already in
use, given the top down allocation strategy the EFI usually employs.

In summary, I guess there are multiple way how we might end up in this
situation, and simply putting the variable back into .data where it
came from is probably the best approach here.
