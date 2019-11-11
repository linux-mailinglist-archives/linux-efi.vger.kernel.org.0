Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0BBFF710E
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2019 10:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfKKJoV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Nov 2019 04:44:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52272 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKKJoU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Nov 2019 04:44:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id l1so1160586wme.2
        for <linux-efi@vger.kernel.org>; Mon, 11 Nov 2019 01:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyGmHFPAq5MfFWdVpHAlD4EbsOFVG2Efcfbi4EJCxA8=;
        b=lkyWCxmvKBof7iItTmaB71uyz6oqJTFW2bQpJkvXn0WLVrdk8YZuLe53ZZTjEqgq5k
         W1kwPabkfEkTtnIHzP0gE2Cxr3Vc8YribXNSLbcB4drD+v8g/8jGORCoxVmrhrcwmcE8
         tYMG0SImcnIlqhl68380xL/ubgLmb80IJole32NOhZV67G5eM/CuvBIWajhFHhfeRYgH
         tJKNjhSBQludY+eABLZp9qdgNM5PeStR2XGg9gMzKQublYnZufw8tqIyN5u2PpR5/5Dj
         Y4RX5dAvqKga6OEvdIZM4bRFLccaElKZ0pqgvGwLDRqJJ+1VdF++h8nx5OCeitYE0KGq
         6rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyGmHFPAq5MfFWdVpHAlD4EbsOFVG2Efcfbi4EJCxA8=;
        b=PENXgdCnttne9CcA9W4wMD68ruCWLimQMC1b62EyzvrYWWiwWdBWHhelSMYD8/Pygx
         ZVRHkZKbkx/5qXuvmtwOarLf/q7/DjSgJDaT/N9086SMd3S0VavLw6y/1T38T9IubRZB
         VXdWGGQOn/1DtkY9LH1pTvIZeez3kc6Dyju/tm75144q8CcsYmGMNGAwQU6T03XPB2E3
         d2RTZHbBYOGmC6DCc9nf5358dkNyVkZjlvuEhRGqlJphmLS3TCLyEAQVLKBkeeZfyJnB
         ma8fgQauzJWUC9uI5euvFShVeUCRL+LqEL1Q3eo27jercnsN1TVpMZa1XASvATcgPmmo
         v25A==
X-Gm-Message-State: APjAAAXWRlh/aWjeRmbE0Diu+QDmqwzsIBTJAQ3ToBuiHDKVn5gzbV3W
        Jdb7hDb3ma9WDkSg7XOVWTilJNRl6Cl4rQs955ialofzvlo9Dg==
X-Google-Smtp-Source: APXvYqxrlb7SP7eTmE5hQeLx53eyUjf5tTLurh+KzNkL06pAbGV4qk3tTWVeJmJ5824+3L3yDLMiJHa9NY31q7nWnww=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr18115743wmb.136.1573465456652;
 Mon, 11 Nov 2019 01:44:16 -0800 (PST)
MIME-Version: 1.0
References: <1573449229-13918-1-git-send-email-anshuman.khandual@arm.com> <dcca9d9b-449a-1a97-c792-467966d8eec2@arm.com>
In-Reply-To: <dcca9d9b-449a-1a97-c792-467966d8eec2@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Nov 2019 09:44:05 +0000
Message-ID: <CAKv+Gu90hqAefaWyXVb7CMGv8JF4nniVKVNNtUg-KOFPdNcOXg@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix comment for efi_mem_type() wrt absent physical addresses
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 11 Nov 2019 at 05:27, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> On 11/11/2019 10:43 AM, Anshuman Khandual wrote:
> > A previous commit f99afd08a45f ("efi: Update efi_mem_type() to return an
> > error rather than 0") changed the return type from EFI_RESERVED_TYPE to
> > -EINVAL when the searched physical address is not present in any memory
> > descriptor. But the comment preceding the function never changed. Lets
> > change the comment now to reflect the new return type -EINVAL.
>
> In the subject line, s/PATCH/PATCH V2/. Not sending yet another patch just
> to fix this (in order to reduce spam). But please let me know in case that
> will be essential.
>

No worries, I can queue it like this.

Thanks,

> >
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: linux-efi@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > Changes in V2:
> >
> > - Changed comment for efi_mem_type() instead of the return type per Ard
> >
> > V1: (https://lore.kernel.org/patchwork/patch/1149002/)
> >
> >  drivers/firmware/efi/efi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 77ca52d86e30..47b0bf7a2b7f 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -899,7 +899,7 @@ u64 efi_mem_attributes(unsigned long phys_addr)
> >   *
> >   * Search in the EFI memory map for the region covering @phys_addr.
> >   * Returns the EFI memory type if the region was found in the memory
> > - * map, EFI_RESERVED_TYPE (zero) otherwise.
> > + * map, -EINVAL otherwise.
> >   */
> >  int efi_mem_type(unsigned long phys_addr)
> >  {
> >
