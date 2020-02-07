Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 066BF155387
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 09:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgBGIMR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Feb 2020 03:12:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46312 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGIMR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Feb 2020 03:12:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so1488208wrl.13
        for <linux-efi@vger.kernel.org>; Fri, 07 Feb 2020 00:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RhtSsZPQxEIGMtQmL13uTWrwtYaQcv2uAFFx/BqaRZE=;
        b=Iq1EpKAgpS6y9E0ptLbYm/g5LXKJJISmjKNvhmES0wbDbMH5zLVr9Wh4x5FWJE09JF
         eMVL2Ze42BWMbOXgOt0vYKBaI1CAKfOHstfXcofCYFdSKDM+Huu7ep2N9gssiznpmfqz
         86eXvCseSzg0VlVqtZL3ykwKnorvqhP38dksJgiGzDT33yuTzp3uXDBOiIScsII4PZIK
         fqK9KbvZGIe+FAliWZvoS8gCZ+TvQYTVXy5IHjVF2DiOBONhOc6ySsry9Mcvxy2AI5+6
         iV11xdMEgismz1DBYnns5kWyMjbgo8QQ8buKT7+4zSKiQa7cB9iyPRV2mgi5GQPm2z3Q
         +Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhtSsZPQxEIGMtQmL13uTWrwtYaQcv2uAFFx/BqaRZE=;
        b=W1bXAMKfQ8nZSX97zquTQ8P0Cg6UWbgGi7V1T2wMhWNTkESDWBgbD1ATK6I64hlWN9
         aaV5b11jjoglzFWf7kioiPhaeBjOMjpgbACfYryviAlC1ohBayAHnvmOzfp92MPbCEW+
         lFK6LdezmzbFFdTL1dwGb5BJirxTgFxOWxsWHkZsFTq6GibChWnK8IL9nJOmtTFgZTzX
         F+kltmHj0DYWovWxsbyTz5tKylAN7aWLl+4CSD1hD1bFCKukWKM+NhkR2kvIwiTOE9ey
         CgKas2U8whhqgtq77yFBrsRbCp+/M5vRNeN8yq+L9/8B2x0R9jO/oJokB92esl8A1ooM
         H4yQ==
X-Gm-Message-State: APjAAAUvs4/braR9uqKyHbzSZkA52CEhdZEKwisFtxoO2wg9N2BiseUF
        DLFS/3JxMPRSBzK54IA8HZI/m9R0MDyJUVPo8vGp2ti07j6F/Q==
X-Google-Smtp-Source: APXvYqx8cIS8WVQ0f++9dJ/4i6q+U/hhZOXte0NdMOcfogNNO4rkYb8C/RivDqFlgOSQadNtNBqpZbm4PlM3AFyJW1I=
X-Received: by 2002:adf:8564:: with SMTP id 91mr3350267wrh.252.1581063133977;
 Fri, 07 Feb 2020 00:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20200206140352.6300-1-ardb@kernel.org> <20200206140352.6300-2-ardb@kernel.org>
 <a6d7fefb-2f02-86a3-66aa-c3c129a91fb1@gmx.de> <CAKv+Gu9Z24GeqrqKhPJN+aAu8crSKvT0ZBeFL=0ik=z2Sd1FmQ@mail.gmail.com>
 <b2535bc9-f9be-e250-4da1-bce0b67abb6f@gmx.de> <CAKv+Gu-X6DKhtbfVgRLPomkkKJ7=4vRs-crLL0p7E7043J4H0g@mail.gmail.com>
 <081d152a-fa9b-886a-565d-b244dea08cd5@gmx.de>
In-Reply-To: <081d152a-fa9b-886a-565d-b244dea08cd5@gmx.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Feb 2020 08:12:02 +0000
Message-ID: <CAKv+Gu-f9O4eon_E7=OUu_tNwybi7u6bF2zMowPHbA-MhiTjNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/libstub: add support for loading the initrd from
 a device path
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Daniel Kiper <daniel.kiper@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 7 Feb 2020 at 00:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 2/7/20 1:21 AM, Ard Biesheuvel wrote:
> > On Fri, 7 Feb 2020 at 00:01, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 2/6/20 11:35 PM, Ard Biesheuvel wrote:
> >>> On Thu, 6 Feb 2020 at 18:26, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
...
> >>>> Please, indicate which software you expect to expose the initrd related
> >>>> EFI_LOAD_FILE2_PROTOCOL.
> >>>>
> >>>
> >>> The primary use case is GRUB and other intermediate loaders, since it
> >>> would remove any need for these components to know any such details.
> >>> My aim is to make the next architecture that gets added to GRUB for
> >>> EFI boot 100% generic.
> >>>
> >>>> Using an UEFI variable for passing the initrd device path would be a
> >>>> leaner solution on the bootloader side than requiring an extra
> >>>> EFI_LOAD_FILE2_PROTOCOL implementation.
> >>>>
> >>>
> >>> This would also require kernel changes, since we don't currently load
> >>> initrds from arbitrary device paths. The EFI_FILE_PROTOCOL is much
> >>> more complicated than needed, and it doesn't work well with mixed
> >>> mode. It also requires GRUB to expose the filesystem it loads the
> >>> initrd from via EFI protocols, which is currently unnecessary and
> >>> therefore not implemented.
> >>
> >> This means you move the complexity of EFI_FILE_PROTOCOL from Linux to GRUB.
> >>
> >
> > No. I am not interested in EFI_FILE_PROTOCOL, only in LoadFile2, which
> > is a single method that needs to be implemented.
>
> I said you move complexity because GRUB will need to use the
> EFI_FILE_PROTOCOL to do the job that you do not want to do in Linux.
>
> >
> >> I would not have a problem if this would only touch GRUB. But if listen
> >> to Ilias we are replacing one implementation in Linux by one in GRUB and
> >> one in U-Boot and one in EDK2 and one in any other firmware.
> >>
> >
> > If u-boot will be used to boot RISC-V in EFI mode without GRUB, then I
> > expect that we will need an implementation of this in u-boot.
>
> What sets RISC-V apart? GRUB for RISC-V is available.
>

RISC-V EFI boot is not supported yet in upstream Linux.

> >
> >>>
> >>> Also, using an EFI variable defeats the purpose. The whole point of
> >>> this is making it more likely that the kernel loaded the initrd that
> >>> the bootloader or firmware intended it to load, and having a piece of
> >>> simple [signed] code that implements this is the easiest way to
> >>> achieve that.
> >>
> >> At least on my Debian system it is the operating system creating initrd
> >> and defining which initrd matches which kernel. GRUB simply assumes that
> >> files ending on the same version number match. Therefore I would say
> >> Linux hopes that GRUB loads what Linux intended.
> >>
> >> The chain of trust would not be broken if the kernel were responsible
> >> for loading the initrd and for checking if it matches the kernel. Linux
> >> already does this for the kernel modules in initrd.
> >>
> >
> > We can still sign the initrd and Linux can verify the signature. What
> > I am after is an interface that does not require the initrd to
> > originate from a EFI file system protocol, and which doesn't require
> > the loaded initrd to sit in memory for an unspecified amount of time
> > and its information passed via DT properties or bootparams structs.
> >
> > So invoking EFI_FILE_PROTOCOL directly is not going to work,
> > regardless of whether we get the devicepath from the command line or
> > from a EFI variable.
>
> What do you mean by "is not going to work"?
>
> With the device path you can find the handle implementing the
> EFI_SIMPLE_FIL_SYSTEM_PROTOCOL.
>
> >
> >>>
> >>> For u-boot, it should be trivial to implement a simple LoadFile2
> >>> protocol wrapper around EFI_FILE_PROTOCOL that can be installed on a
> >>> handle that also carries EFI_FILE_PROTOCOL.
> >>>
> >>
> >> A U-Boot implementation of the EFI_LOAD_FILE2_PROTOCOL would need a
> >> device path variable to find the block device and to open the
> >> EFI_SIMPLE_FILE_SYSTEM_PROTOCOL before accessing the file.
> >>
> >> Linux would not be needing more lines and we would not repeat the same
> >> code in GRUB, U-Boot, EDK2, etc.
> >>
> >> As said Linux updates the initrd often. If that file is not signed by
> >> Linux in a well defined way, do not expect any security at all.
> >>
> >
> > It is not only about security. The primary goal is to remove the need
> > for arch specific knowledge in the firmware about DT, bootparams and
> > initrd allocation policies without being forced to load the initrd
> > from a filesystem that is exposed via a EFI protocol.
>
> Where are device-trees touched by this patch?
>
> When booting via UEFI there is no need for knowledge of initrd
> allocation policies in U-Boot because up to now Linux or GRUB or iPXE
> load initrd.
>
> Furthermore I need no knowledge of bootparams in U-Boot once we properly
> we support UEFI variables at runtime because grub-update will pass the
> command line in one of the Bootxxxx UEFI variables.
>
> But most importantly I do not have to implement anything Linux specific
> in U-Boot for booting via UEFI up to now.
>

Adding Linux specific stuff to u-boot is arguably more appropriate
than adding architecture specific stuff to EFI loaders that could
otherwise be entirely generic.

...
>
> Your patch claims to fend off a specific threat scenario: A user puts an
> untrusted initrd on the disk and references it in the Linux command line.
>
> If he is able to do so with your current bootloader (signed or not
> signed), he most probably will also be able to delete a good initrd from
> the filesystem and thus force your code into the unsafe path.
>
> That is why I say that with the current fallback logic this patch
> achieves no increase in security. Of cause you could remove the fallback
> logic. But in this case your Linux will not boot with any legacy
> bootloader or firmware.
>

If there is a better way to expose the initrd that
a) does not require the initrd to reside on a file system that is
accessible via EFI protocols, and
b) does not require the loader to know about arch specific policies
regarding the placement of the initrd in memory, and
c) does not leave a time window between the time that the initrd is
loaded/verified/measured by the firmware and the time that the kernel
gets handed the buffer

then I am happy to discuss it. This proposal is the best I could come
up with to achieve the above.

-- 
Ard.
