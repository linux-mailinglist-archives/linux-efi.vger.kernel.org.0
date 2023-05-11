Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CDC6FF2A2
	for <lists+linux-efi@lfdr.de>; Thu, 11 May 2023 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbjEKNXf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 May 2023 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbjEKNXS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 May 2023 09:23:18 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1201155C;
        Thu, 11 May 2023 06:21:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C098E320083A;
        Thu, 11 May 2023 09:21:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 11 May 2023 09:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astier.eu; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683811280; x=1683897680; bh=jv
        OklUpmzSY8qaY1xynV5bsmPspeHy7w+6eOx8p4X8w=; b=M73MQWS3GO3JygbJal
        sHzuLI+KVsi7ycupl++RI6zA7+Pl/Z1F9YDUhyc68NWZWeK8D8RzvPIambfK4XnT
        6WPvtKoT7tFrbXcz/LKcBEUm8jmguviVp4RZyo2COy7RQaCZAqwtLaDXq60pJajp
        AXiWkn7H4IqRcgOanhFA17ke0E3bXYDBivCX/M7VFffknWwrsmvf2nGp7iKs1CKB
        15wKFEBE8IwXfnq4gfaBmDQnf0UQngU1MYhsIeyMgy78/ntub+ah6MPc7HDhvtc2
        ARLZPEQ4SpbvvU6aTYMIGzKeJF+/7vVbYcBBLSZTRg3GbLMzGeCpFn18vCW7j7vg
        BEcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683811280; x=1683897680; bh=jvOklUpmzSY8q
        aY1xynV5bsmPspeHy7w+6eOx8p4X8w=; b=IuAWbfwhg3RE8hnRna4C9AojS8Wkw
        h+/hKWuXITyAvCzMqXwyOR/Fup3ptEFxN/zCPSUOgDT9a79d+TucD/Fyk7AzebsB
        YIwwb/yL985FLYHDWFcaVSVFLqznd7BJ72+JHzSiJxEXW+9A88epbIJH84infNoR
        8E9/xjIrIvjqhdMYk6triaFiBBcZzkzxQP+RJfcxVSKM4KsmVhwRE1F6rpw2tSRx
        cHIOX+0GnXg8xwPH5G2AsAQI1PfE5KWQOYfTphcNErWtIs6Mh9EyLfx/ka3rHEwI
        Qft0Rqq1y8PEFn1ZHMN4+RDVblOfwdMyv7v7C5D0Wn19YFGkn/CxwnPtA==
X-ME-Sender: <xms:z-tcZBSIg4rj3sYHnf5IyV6OkTM5fq-ulwOi9_3GHC9-VbOMheI-Zw>
    <xme:z-tcZKwEqThfU4--zRnk4ZQEE1o-EOBDO9WMzsrBkG9S9kiG7MCLovCza65BmbwNU
    vHX0ntsaFKlTzUQnsU>
X-ME-Received: <xmr:z-tcZG3dGWgBGPu6j7EhHJcu_0QgQWHMeZ-kGBwjm49eBOs7OFVk_IDrO3cZMQPoQOa134kHSba1_55aFg8ua0qzCAQbqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnihhs
    shgvucetshhtihgvrhcuoegrnhhishhsvgesrghsthhivghrrdgvuheqnecuggftrfgrth
    htvghrnheplefhjefhvdelueekheeftefghfejfffguedvgffgueehiefggeevjeekieet
    jeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hnihhsshgvsegrshhtihgvrhdrvghu
X-ME-Proxy: <xmx:z-tcZJChUntGfFpovDk1w9Ubb6KHKOvvSC_whzhQbk2F6i376r6J8w>
    <xmx:z-tcZKjuWcxbQL7T_ZROb86oXZIWWNI89Q1-WUSI1mNSjkLyB6Dgtg>
    <xmx:z-tcZNopfAJltjC-MW7QuMzajiuvn4zLoMnJgdUhwFpkMgpHyPkbrA>
    <xmx:0OtcZDaVGlZjWm-cOYGdOITSjvYoNRstKpnW6XsOv8f1s8OTsaIX_w>
Feedback-ID: iccec46d4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 May 2023 09:21:16 -0400 (EDT)
Date:   Thu, 11 May 2023 15:21:13 +0200
From:   Anisse Astier <anisse@astier.eu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Anisse Astier <an.astier@criteo.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-efi@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jeremy Kerr <jk@ozlabs.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Hughes <hughsient@gmail.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: [PATCH] efivarfs: expose used and total size
Message-ID: <ZFzouh4AJemaJAah@anisse-laptop>
References: <20230426195853.633233-1-anisse@astier.eu>
 <CAMj1kXE2-76KZDxpHBPcZgbB8vGDmLEbiRGmw_5o-rsNzT9oQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE2-76KZDxpHBPcZgbB8vGDmLEbiRGmw_5o-rsNzT9oQw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Wed, May 10, 2023 at 05:13:36PM +0200, Ard Biesheuvel wrote:
> On Wed, 26 Apr 2023 at 21:59, Anisse Astier <anisse@astier.eu> wrote:
> >
> > From: Anisse Astier <an.astier@criteo.com>
> >
> > When writing variables, one might get errors with no other message on
> > why it fails.
> >
> > Being able to see how much is used by EFI variables helps analyzing such
> > issues.
> >
> > Since this is not a conventionnal filesystem, block size is
> > intentionnally set to 1 instead of PAGE_SIZE.
> >
> > x86 quirks of reserved size are taken into account and available and
> > free size can be different, further helping debugging space issues.
> >
> 
> I have no objections to this, but I'm not much of a user space/ VFS
> person, so adding some other folks that can chime in if they want.

Thanks !

> 
> The point of this patch is that user space can query this information
> using statvfs(), right?

Yes, which means that a simple df command will show the used and free
space remaining in the EFI variable storage area:

   $ df -h /sys/firmware/efi/efivars/
   Filesystem      Size  Used Avail Use% Mounted on
   efivarfs        176K  106K   66K  62% /sys/firmware/efi/efivars

Regards,

Anisse

> 
> 
> 
> > Signed-off-by: Anisse Astier <an.astier@criteo.com>
> > ---
> > Notes:
> > Patch isn't split per subsystem intentionally, for better understanding
> > of intent; split could be trivial in a later version.
> >
> > I'm not sure whether statfs(2) should return an error if the efi request
> > fails; I think it could be ignored with maybe a WARN_ONCE; which would
> > be close to the current behaviour.
> >
> > Regards,
> >
> > Anisse
> >
> > ---
> >  arch/x86/platform/efi/quirks.c |  8 ++++++++
> >  drivers/firmware/efi/efi.c     |  1 +
> >  drivers/firmware/efi/vars.c    | 12 ++++++++++++
> >  fs/efivarfs/super.c            | 26 +++++++++++++++++++++++++-
> >  include/linux/efi.h            | 10 ++++++++++
> >  5 files changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> > index b0b848d6933a..587fa51230e2 100644
> > --- a/arch/x86/platform/efi/quirks.c
> > +++ b/arch/x86/platform/efi/quirks.c
> > @@ -114,6 +114,14 @@ void efi_delete_dummy_variable(void)
> >                                      EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
> >  }
> >
> > +u64 efi_reserved_space(void)
> > +{
> > +       if (efi_no_storage_paranoia)
> > +               return 0;
> > +       return EFI_MIN_RESERVE;
> > +}
> > +EXPORT_SYMBOL_GPL(efi_reserved_space);
> > +
> >  /*
> >   * In the nonblocking case we do not attempt to perform garbage
> >   * collection if we do not have enough free space. Rather, we do the
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index abeff7dc0b58..d0dfa007bffc 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -211,6 +211,7 @@ static int generic_ops_register(void)
> >         generic_ops.get_variable = efi.get_variable;
> >         generic_ops.get_next_variable = efi.get_next_variable;
> >         generic_ops.query_variable_store = efi_query_variable_store;
> > +       generic_ops.query_variable_info = efi.query_variable_info;
> >
> >         if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
> >                 generic_ops.set_variable = efi.set_variable;
> > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > index bd75b87f5fc1..c5382d5c3073 100644
> > --- a/drivers/firmware/efi/vars.c
> > +++ b/drivers/firmware/efi/vars.c
> > @@ -245,3 +245,15 @@ efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
> >         return status;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(efivar_set_variable, EFIVAR);
> > +
> > +efi_status_t efivar_query_variable_info(u32 attr,
> > +                                       u64 *storage_space,
> > +                                       u64 *remaining_space,
> > +                                       u64 *max_variable_size)
> > +{
> > +       if (!__efivars->ops->query_variable_info)
> > +               return EFI_UNSUPPORTED;
> > +       return __efivars->ops->query_variable_info(attr, storage_space,
> > +                       remaining_space, max_variable_size);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(efivar_query_variable_info, EFIVAR);
> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > index 482d612b716b..064bfc0243c9 100644
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/ucs2_string.h>
> >  #include <linux/slab.h>
> >  #include <linux/magic.h>
> > +#include <linux/statfs.h>
> >
> >  #include "internal.h"
> >
> > @@ -23,8 +24,31 @@ static void efivarfs_evict_inode(struct inode *inode)
> >         clear_inode(inode);
> >  }
> >
> > +static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> > +{
> > +       u64 storage_space, remaining_space, max_variable_size;
> > +       efi_status_t status;
> > +       const u32 attr = (EFI_VARIABLE_NON_VOLATILE | EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +        EFI_VARIABLE_RUNTIME_ACCESS);
> > +
> > +       buf->f_type = dentry->d_sb->s_magic;
> > +       buf->f_bsize = 1;
> > +       buf->f_namelen = NAME_MAX;
> > +
> > +       status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
> > +                                           &max_variable_size);
> > +       if (status != EFI_SUCCESS)
> > +               return efi_status_to_err(status);
> > +       buf->f_blocks = storage_space;
> > +       buf->f_bfree = remaining_space;
> > +       if (remaining_space > efi_reserved_space())
> > +               buf->f_bavail = remaining_space - efi_reserved_space();
> > +       else
> > +               buf->f_bavail = 0;
> > +       return 0;
> > +}
> >  static const struct super_operations efivarfs_ops = {
> > -       .statfs = simple_statfs,
> > +       .statfs = efivarfs_statfs,
> >         .drop_inode = generic_delete_inode,
> >         .evict_inode = efivarfs_evict_inode,
> >  };
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 7aa62c92185f..d2b686191870 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -703,6 +703,7 @@ static inline void efi_enter_virtual_mode (void) {}
> >  extern efi_status_t efi_query_variable_store(u32 attributes,
> >                                              unsigned long size,
> >                                              bool nonblocking);
> > +extern u64 efi_reserved_space(void);
> >  #else
> >
> >  static inline efi_status_t efi_query_variable_store(u32 attributes,
> > @@ -711,6 +712,10 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
> >  {
> >         return EFI_SUCCESS;
> >  }
> > +static inline u64 efi_reserved_space(void)
> > +{
> > +       return 0;
> > +}
> >  #endif
> >  extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
> >
> > @@ -1042,6 +1047,7 @@ struct efivar_operations {
> >         efi_set_variable_t *set_variable;
> >         efi_set_variable_t *set_variable_nonblocking;
> >         efi_query_variable_store_t *query_variable_store;
> > +       efi_query_variable_info_t *query_variable_info;
> >  };
> >
> >  struct efivars {
> > @@ -1087,6 +1093,10 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
> >  efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
> >                                  u32 attr, unsigned long data_size, void *data);
> >
> > +efi_status_t efivar_query_variable_info(u32 attr, u64 *storage_space,
> > +                                       u64 *remaining_space,
> > +                                       u64 *max_variable_size);
> > +
> >  #if IS_ENABLED(CONFIG_EFI_CAPSULE_LOADER)
> >  extern bool efi_capsule_pending(int *reset_type);
> >
> > --
> > 2.34.1
> >
