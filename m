Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A631A3B92
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 22:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDIUxS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 16:53:18 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33102 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgDIUxS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Apr 2020 16:53:18 -0400
Received: by mail-il1-f194.google.com with SMTP id k29so91938ilg.0;
        Thu, 09 Apr 2020 13:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQ2KOue7AiUFiMVC6lBYT2P156Hjtv9v6o05CFYH3f0=;
        b=NwMCa4avnNI9EvBdolLgo1RH/LggIsv8aKFnMiyrYdBbzZniH1iVWn1dIUlB1dV4+L
         edfkzxhZlCT3xCAawuh0X2nNFTbXjWFiODKV00Q0QwOyvM8D0n1ebyBUB8rzbkcvnJc4
         1C51ByYwSc86nKEkD41fDFseJUFxhCRjA1sLkUej52PNzk2ph9rGus+u7tHIcSd0KwSn
         FkNYX4Y+b0F67L7lZ02WW+pExOqTl060vfZ8VqDYuTib03TrCqJxafDrEQ51exsZ7UgD
         gvpdwqwaNugEPUQjrYXx/brQAsED8KVP9QujJQVkqY9n0A4dE1OSta/25mPgwkKda4oo
         Yj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQ2KOue7AiUFiMVC6lBYT2P156Hjtv9v6o05CFYH3f0=;
        b=E0rSMSgwTIjlgxxvpXUo8AsDjrfyaOBDrYPi10Cu9xlxek47jFL0+T9rFS0+kP4zdv
         rTkXx4NXk7MBm+jIRCgCRe8KPKOROFYOD+QDqP8oIy40cyC2PYDEWze0v60B/IfSu+H3
         8bds8Z43dayxpmzFySX08MS0sQmcIZ8D8tn90+EE9iAbOa2O1HFBxEjKM/0XmKB8sSn7
         sxCwvSQJuqMTjPqpKhjXyxaWpxlO0P2Vhxh+ENdvIZ/MxOtxZWFz38fuVcSa1Oa8xGqS
         tx4plBlV+DX+LO45mKDB2le15+cnSub/w7s+UvPS734+wGf8NqtHeF+jbglbvxeyMFbd
         q12g==
X-Gm-Message-State: AGi0PuYAc1SqT1Ijbc0qrmw5gIugTadiGui+ACLRHf0qy0Rh7DOPJYiC
        CJbmhMFWaoD4V1MQSOutNLvWjb4h7/bvV+PPpQ==
X-Google-Smtp-Source: APiQypKEgeSzFh1XALIkLwZH2Vu9JegVgqL5GmYmFyQm4OX6+NZUQL3/XDVrY8WdCWgjDNR607tHuutVJUXr3+TUd2E=
X-Received: by 2002:a92:41c7:: with SMTP id o190mr1777526ila.11.1586465598130;
 Thu, 09 Apr 2020 13:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200409130434.6736-1-ardb@kernel.org> <20200409130434.6736-4-ardb@kernel.org>
 <CAMzpN2gJWwVun1Kp6vGuza9LM5KpB=0EwsP8x8eOJQuDGh38Hg@mail.gmail.com>
In-Reply-To: <CAMzpN2gJWwVun1Kp6vGuza9LM5KpB=0EwsP8x8eOJQuDGh38Hg@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 9 Apr 2020 16:53:07 -0400
Message-ID: <CAMzpN2jFbf8k99pWaTYRBmSB+iNAKYsufjEhqO6Vv0qxAcHyGA@mail.gmail.com>
Subject: Re: [PATCH 3/9] efi/x86: Move efi stub globals from .bss to .data
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 9, 2020 at 4:05 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Thu, Apr 9, 2020 at 9:07 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > From: Arvind Sankar <nivedita@alum.mit.edu>
> >
> > Commit
> >
> >   3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")
> >
> > removed the .bss section from the bzImage.
> >
> > However, while a PE loader is required to zero-initialize the .bss
> > section before calling the PE entry point, the EFI handover protocol
> > does not currently document any requirement that .bss be initialized by
> > the bootloader prior to calling the handover entry.
> >
> > When systemd-boot is used to boot a unified kernel image [1], the image
> > is constructed by embedding the bzImage as a .linux section in a PE
> > executable that contains a small stub loader from systemd together with
> > additional sections and potentially an initrd. As the .bss section
> > within the bzImage is no longer explicitly present as part of the file,
> > it is not initialized before calling the EFI handover entry.
> > Furthermore, as the size of the embedded .linux section is only the size
> > of the bzImage file itself, the .bss section's memory may not even have
> > been allocated.
> >
> > In particular, this can result in efi_disable_pci_dma being true even
> > when it was not specified via the command line or configuration option,
> > which in turn causes crashes while booting on some systems.
> >
> > To avoid issues, place all EFI stub global variables into the .data
> > section instead of .bss. As of this writing, only boolean flags for a
> > few command line arguments and the sys_table pointer were in .bss and
> > will now move into the .data section.
> >
> > [1] https://systemd.io/BOOT_LOADER_SPECIFICATION/#type-2-efi-unified-kernel-images
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Reported-by: Sergey Shatunov <me@prok.pw>
> > Fixes: 3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")
> > Link: https://lore.kernel.org/r/20200406180614.429454-1-nivedita@alum.mit.edu
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/libstub/efistub.h  | 2 +-
> >  drivers/firmware/efi/libstub/x86-stub.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > index cc90a748bcf0..67d26949fd26 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -25,7 +25,7 @@
> >  #define EFI_ALLOC_ALIGN                EFI_PAGE_SIZE
> >  #endif
> >
> > -#ifdef CONFIG_ARM
> > +#if defined(CONFIG_ARM) || defined(CONFIG_X86)
> >  #define __efistub_global       __section(.data)
> >  #else
> >  #define __efistub_global
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index e02ea51273ff..867a57e28980 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -20,7 +20,7 @@
> >  /* Maximum physical address for 64-bit kernel with 4-level paging */
> >  #define MAXMEM_X86_64_4LEVEL (1ull << 46)
> >
> > -static efi_system_table_t *sys_table;
> > +static efi_system_table_t *sys_table __efistub_global;
> >  extern const bool efi_is64;
> >  extern u32 image_offset;
> >
> > --
> > 2.17.1
> >
>
> Can we use the -fno-zero-initialized-in-bss compiler flag instead of
> explicitly marking global variables?

Scratch that.  Apparently it only works when a variable is explicitly
initialized to zero.

--
Brian Gerst
