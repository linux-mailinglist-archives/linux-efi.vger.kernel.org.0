Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8837B2A5673
	for <lists+linux-efi@lfdr.de>; Tue,  3 Nov 2020 22:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbgKCV2U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Nov 2020 16:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733160AbgKCV2T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Nov 2020 16:28:19 -0500
X-Greylist: delayed 365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Nov 2020 13:28:19 PST
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911DFC0613D1
        for <linux-efi@vger.kernel.org>; Tue,  3 Nov 2020 13:28:19 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 54DDE12803FF;
        Tue,  3 Nov 2020 13:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604438534;
        bh=ubInX6M9m/aIQ5+q2VUuhdOTc5KFBGZNPKFLXMER9ew=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=YMcLmnzZic5K6ZlWerHXLNBoJk9shUTESSxUdHfc/HVLNh4l3rWvudrdjiySdm/9P
         7HMX9Ezi/vSEN29zLQYoAyGNauxV029tTETRVMMvrNgJRjrWtvpt/oM+bj5AP09s36
         ll6J60ZQhPJJLT7qDzn7iYDjfGnYHNv5uD3zC7UM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E0BRlWNH_M5u; Tue,  3 Nov 2020 13:22:14 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B3D3912803CD;
        Tue,  3 Nov 2020 13:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604438534;
        bh=ubInX6M9m/aIQ5+q2VUuhdOTc5KFBGZNPKFLXMER9ew=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=YMcLmnzZic5K6ZlWerHXLNBoJk9shUTESSxUdHfc/HVLNh4l3rWvudrdjiySdm/9P
         7HMX9Ezi/vSEN29zLQYoAyGNauxV029tTETRVMMvrNgJRjrWtvpt/oM+bj5AP09s36
         ll6J60ZQhPJJLT7qDzn7iYDjfGnYHNv5uD3zC7UM=
Message-ID: <c84f8664b543d93a380d9710a653da5f99220f3b.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/7] efi/libstub: measurement initrd data loaded by
 the EFI stub
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Tue, 03 Nov 2020 13:22:12 -0800
In-Reply-To: <20201102170634.20575-1-ardb@kernel.org>
References: <20201102170634.20575-1-ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2020-11-02 at 18:06 +0100, Ard Biesheuvel wrote:
> This series enables measurement of the initrd data loaded directly by
> the EFI stub into the TPM, using the TCG2 protocol exposed by the
> firmware (if available). This ensures that the initrd observed and
> used by the OS is the same one that got measured into the TPM, which
> is more difficult to guarantee in the current situation.
> 
> This is posted as an RFC since it is mostly an invitation to discuss
> how we can fit this into a longer term strategy for arch-agnostic
> secure and measured boot that does not hinge on the Shim+GRUB tandem,
> or on deep knowledge on the part of the bootloader regarding device
> trees, bootparams structs, allocation and placement policies of
> various artifacts etc etc

For background: IBM research is currently working with the Keylime
people to get a boot log attestation service for both the cloud and
less hyperscale instances.  As part of this we're currently working
through what the linux boot system (shim + grub + kernel) currently
logs today and how useful it actually is to a security enforcing
attestation system ... as in do we log useful stuff you can actually
make decisions on once we've used the TPM based attestation to verify
the correctness of the entire log.

> Open questions:
> - Should we do this?

Well, if you're going to essentially replicate the log events shim and
grub currently do, we should really define what we want to go in there.
At the moment shim logs mostly with events that are defined in the UEFI
spec and grub uses EV_IPL with the contents changing meaning depending
on which PCR is being logged through.  Shim also is a bit non-standard
in that it logs the Mok variables with EV_IPL events as well.

> - Are Linux systems in the field using PCR value prediction when
> updating the initrd? Does this approach interfere with that?

So initrd is the nastiest piece of this because it changes any time
anything is updated that triggers an initrd rebuild.  Since it's an end
to end hash of a cpio file with timestamps, the value is essentially
meaningless because the timestamp updates cause it to change on every
generation regardless of whether the contents actually changes.

Ideally I'd like something that's more characteristic of "this is
actually an initrd I created" than some random hash but it's very
difficult to generate that securely.

> - Which PCR and event type to use

Grub logs data (commands and command lines) through PCR 8 with the hash
being the hash of the event string.  It logs binaries through PCR 9
with the event string being the root relative path and the hash value
the end to end hash of the binary.  I'm not necessarily a fan of this
... Microsoft uses opaque EV_EFI_TAG events instead.

Grub also uses the shim lock protocol to check the kernel signature and
that will log both an EV_EFI_BOOT_SERVICES_APPLICATION with a NULL path
and EV_EFI_VARIABLE_AUTHORITY.

> - Is a separator event needed here, given that the initrd measurement
> is   recorded even if no initrd was loaded by the stub?

Neither grub nor shim currently record separators ... again it's an
open question of whether they actually should.

James

> Note that the EFI stub ignores the initrd provided directly via
> bootparams or the device tree, and it would be nice if we could keep
> doing that.
> 
> Build tested only.
> 
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Leif Lindholm <leif@nuviainc.com>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Matthew Garrett <mjg59@google.com>
> Cc: Daniel Kiper <daniel.kiper@oracle.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> Ard Biesheuvel (7):
>   efi/libstub: whitespace cleanup
>   efi/libstub: fix prototype of efi_tcg2_protocol::get_event_log()
>   efi/libstub: x86/mixed: increase supported argument count
>   efi/libstub: move TPM related prototypes into efistub.h
>   efi/libstub: add prototype of
>     efi_tcg2_protocol::hash_log_extend_event()
>   efi/libstub: consolidate initrd handling across architectures
>   efi/libstub: measure loaded initrd info into the TPM
> 
>  arch/x86/boot/compressed/efi_thunk_64.S       | 17 ++++--
>  arch/x86/include/asm/efi.h                    | 13 +++--
>  arch/x86/platform/efi/efi_thunk_64.S          | 17 ++++--
>  .../firmware/efi/libstub/efi-stub-helper.c    | 56 +++++++++++++++
> ----
>  drivers/firmware/efi/libstub/efi-stub.c       | 10 +---
>  drivers/firmware/efi/libstub/efistub.h        | 34 ++++++++++-
>  drivers/firmware/efi/libstub/x86-stub.c       | 26 ++++-----
>  include/linux/efi.h                           | 13 +----
>  8 files changed, 123 insertions(+), 63 deletions(-)
> 


