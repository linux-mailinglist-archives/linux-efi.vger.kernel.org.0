Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2DE702F44
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 16:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbjEOOIl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 10:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240156AbjEOOIe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 10:08:34 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6007210D;
        Mon, 15 May 2023 07:08:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E1120320094E;
        Mon, 15 May 2023 10:08:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 May 2023 10:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astier.eu; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684159708; x=1684246108; bh=xv
        DWu8rswdlHC9tunZQlzYt+uj6XYdRxiwrOmBMzAAk=; b=kLdAG2spfJKVgbQBr0
        Iwp10RAH+rXzkUN+kc9UEfZQdGv6rgMNsPtJ/0uBCTPX1aNH0xsYJOt2FofTdLZw
        L42db56ns9/u3LsHjFU68O2w/1hT9rXTR34nBfYy+9x4D54d2XtGSR7GsnB+ClzD
        c0/a0reOoIlAic791zIMjbhBXQfzXVUY34x26nMpRiFfrXFgj+muFwByL1aqUNlq
        tiAijpXs8fcDG5JEemeTOFLPJmhr6cZchYDKYh5fQl2fi0OvE8EBA1pcSaZja+eI
        lz/do/b6iOQa7+wr8dqAdJlNSSu52v449W7w+XpBsq/TxQx0kui3/UhTqED97Vpx
        HLjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684159708; x=1684246108; bh=xvDWu8rswdlHC
        9tunZQlzYt+uj6XYdRxiwrOmBMzAAk=; b=ELnpHSnDuqahGMLpwzdlcjqLv91PX
        /hfqsSN8sgXFlMsbVOEc0SdpODcALY04yY5P7/Ckr83995rnrnXKw301SWbF1Hj5
        jrUxt+aiVQ92R4EpozpdZulZb7sCu3VWQnmprWBLn266hXYLQeZgXnx4nRnuNtOq
        +LCLSh5ME3OJZad0CcsIyhitJD/BeMsdxsSqXtPTwM5PajkrS1XaxzwIviAa8kVB
        2GWhzmToVHRu1sxdctK9lJlf5z7Ytx4bNtbhsTXtPsqZbiMbZbGEvWuEtg6ISrsp
        abN+BJmcIGn5XBUyKUqTmZmpmTm1EYtP0R5wuFqWJiFdqVLkjA7XQ1dug==
X-ME-Sender: <xms:2zxiZLk0cr8FT1uc_u7iNtuXP1aH_iRhPllQqWu50bfG2cxnm886Gw>
    <xme:2zxiZO3EgG-84iEo0MuKFi9KWTQFdO0LLMYnfit3ROVQ8q4HEMQJOhgXz61KDThAO
    SSDKZSdkXO4Ww9UBQg>
X-ME-Received: <xmr:2zxiZBofnTJBHBbfx6RuU1QbRROeCJsSMp9IX4KUECJS9b6T-KRpAVItyt3IW-s1luoaO67BqbKQL2xtahL7zeOmUPnx2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnihhs
    shgvucetshhtihgvrhcuoegrnhhishhsvgesrghsthhivghrrdgvuheqnecuggftrfgrth
    htvghrnheplefhjefhvdelueekheeftefghfejfffguedvgffgueehiefggeevjeekieet
    jeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hnihhsshgvsegrshhtihgvrhdrvghu
X-ME-Proxy: <xmx:2zxiZDkGszOAX2kxu6_DD0qk7700iDcbo6M56wy6D_1N-fJlUiJEYQ>
    <xmx:2zxiZJ2goEGJnnRMuPSoG4dRhcGV1viY3UKxf2qiG5KTdp-ymPjicQ>
    <xmx:2zxiZCsNVPmNleDsdeifcYLrVcj9P6ILRUHPozbS6F_HPGWvYhY3hg>
    <xmx:3DxiZF6uy3zBmiFbsRCGmsUW1FdVVKr2g2KB0YTz3jcPUyStDyMOsA>
Feedback-ID: iccec46d4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 10:08:25 -0400 (EDT)
Date:   Mon, 15 May 2023 16:08:22 +0200
From:   Anisse Astier <anisse@astier.eu>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Anisse Astier <an.astier@criteo.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-efi@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jeremy Kerr <jk@ozlabs.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        lennart@poettering.net
Subject: Re: [PATCH] efivarfs: expose used and total size
Message-ID: <ZGI81p+2SNjI4VOb@anisse-laptop>
References: <20230426195853.633233-1-anisse@astier.eu>
 <CAMj1kXE2-76KZDxpHBPcZgbB8vGDmLEbiRGmw_5o-rsNzT9oQw@mail.gmail.com>
 <20230515-vorgaben-portrait-bb1b4255d31a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515-vorgaben-portrait-bb1b4255d31a@brauner>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Christian,

On Mon, May 15, 2023 at 10:59:49AM +0200, Christian Brauner wrote:
> On Wed, May 10, 2023 at 05:13:36PM +0200, Ard Biesheuvel wrote:
> > On Wed, 26 Apr 2023 at 21:59, Anisse Astier <anisse@astier.eu> wrote:
> > >
> > > From: Anisse Astier <an.astier@criteo.com>
> > >
> > > When writing variables, one might get errors with no other message on
> > > why it fails.
> > >
> > > Being able to see how much is used by EFI variables helps analyzing such
> > > issues.
> > >
> > > Since this is not a conventionnal filesystem, block size is
> > > intentionnally set to 1 instead of PAGE_SIZE.
> > >
> > > x86 quirks of reserved size are taken into account and available and
> > > free size can be different, further helping debugging space issues.
> > >
> > 
> > I have no objections to this, but I'm not much of a user space/ VFS
> > person, so adding some other folks that can chime in if they want.
> > 
> > The point of this patch is that user space can query this information
> > using statvfs(), right?
> 
> Seems ok to me.
> 
> > 
> > 
> > 
> > > Signed-off-by: Anisse Astier <an.astier@criteo.com>
> > > ---
> > > Notes:
> > > Patch isn't split per subsystem intentionally, for better understanding
> > > of intent; split could be trivial in a later version.
> > >
> > > I'm not sure whether statfs(2) should return an error if the efi request
> > > fails; I think it could be ignored with maybe a WARN_ONCE; which would
> > > be close to the current behaviour.
> 
> Not sure. If you're not returning an error you would have to report made
> up/magic values that could end up confusing userspace. So better to be
> honest and report an error.

Ack.

> 
> > >
> > > Regards,
> > >
> > > Anisse
> > >
> > > ---
> > >  arch/x86/platform/efi/quirks.c |  8 ++++++++
> > >  drivers/firmware/efi/efi.c     |  1 +
> > >  drivers/firmware/efi/vars.c    | 12 ++++++++++++
> > >  fs/efivarfs/super.c            | 26 +++++++++++++++++++++++++-
> > >  include/linux/efi.h            | 10 ++++++++++
> > >  5 files changed, 56 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> > > index b0b848d6933a..587fa51230e2 100644
> > > --- a/arch/x86/platform/efi/quirks.c
> > > +++ b/arch/x86/platform/efi/quirks.c
> > > @@ -114,6 +114,14 @@ void efi_delete_dummy_variable(void)
> > >                                      EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
> > >  }
> > >
> > > +u64 efi_reserved_space(void)
> > > +{
> > > +       if (efi_no_storage_paranoia)
> > > +               return 0;
> > > +       return EFI_MIN_RESERVE;
> > > +}
> > > +EXPORT_SYMBOL_GPL(efi_reserved_space);
> > > +
> > >  /*
> > >   * In the nonblocking case we do not attempt to perform garbage
> > >   * collection if we do not have enough free space. Rather, we do the
> > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > index abeff7dc0b58..d0dfa007bffc 100644
> > > --- a/drivers/firmware/efi/efi.c
> > > +++ b/drivers/firmware/efi/efi.c
> > > @@ -211,6 +211,7 @@ static int generic_ops_register(void)
> > >         generic_ops.get_variable = efi.get_variable;
> > >         generic_ops.get_next_variable = efi.get_next_variable;
> > >         generic_ops.query_variable_store = efi_query_variable_store;
> > > +       generic_ops.query_variable_info = efi.query_variable_info;
> > >
> > >         if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
> > >                 generic_ops.set_variable = efi.set_variable;
> > > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > > index bd75b87f5fc1..c5382d5c3073 100644
> > > --- a/drivers/firmware/efi/vars.c
> > > +++ b/drivers/firmware/efi/vars.c
> > > @@ -245,3 +245,15 @@ efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
> > >         return status;
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(efivar_set_variable, EFIVAR);
> > > +
> > > +efi_status_t efivar_query_variable_info(u32 attr,
> > > +                                       u64 *storage_space,
> > > +                                       u64 *remaining_space,
> > > +                                       u64 *max_variable_size)
> > > +{
> > > +       if (!__efivars->ops->query_variable_info)
> > > +               return EFI_UNSUPPORTED;
> > > +       return __efivars->ops->query_variable_info(attr, storage_space,
> > > +                       remaining_space, max_variable_size);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(efivar_query_variable_info, EFIVAR);
> > > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > > index 482d612b716b..064bfc0243c9 100644
> > > --- a/fs/efivarfs/super.c
> > > +++ b/fs/efivarfs/super.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/ucs2_string.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/magic.h>
> > > +#include <linux/statfs.h>
> > >
> > >  #include "internal.h"
> > >
> > > @@ -23,8 +24,31 @@ static void efivarfs_evict_inode(struct inode *inode)
> > >         clear_inode(inode);
> > >  }
> > >
> > > +static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> > > +{
> > > +       u64 storage_space, remaining_space, max_variable_size;
> > > +       efi_status_t status;
> > > +       const u32 attr = (EFI_VARIABLE_NON_VOLATILE | EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > > +        EFI_VARIABLE_RUNTIME_ACCESS);
> > > +
> > > +       buf->f_type = dentry->d_sb->s_magic;
> > > +       buf->f_bsize = 1;
> > > +       buf->f_namelen = NAME_MAX;
> > > +
> > > +       status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
> > > +                                           &max_variable_size);
> > > +       if (status != EFI_SUCCESS)
> > > +               return efi_status_to_err(status);
> > > +       buf->f_blocks = storage_space;
> 
> I have no idea about efivarfs specifically but I would add comments
> why f_bsize is set to what it is and clarify the relationship between
> f_bsize and f_blocks. Even if just for the sake of userspace to be able
> to interpret this.

Ack.

Thanks for taking the time to review this patch, I'll send a new version
soon.

Regards,

Anisse

