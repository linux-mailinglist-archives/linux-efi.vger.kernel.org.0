Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF5B66DAE2
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 11:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbjAQKZc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 05:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbjAQKZ3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 05:25:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440792BEE7
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 02:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673951082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nwa7yzUz/d5O5ZJ8+0pFVeV97HQ7VfJXVVDyNJvC/Sc=;
        b=cjNzHXwxnXFD7Wgjk0i41inOnU6f2Gsu8DAFdMzhcZlB4RS17daKEdIU7I48/84riIQJE2
        mdH5lkDRpW7WTYdHAPNSNRv1GrKmvBfPNqtlEDFMpUxc21hPZmd1Tl1rNwhs3skJxTS7V2
        Pj6kQt0QNGNv1rVhjyXFTYgXHHZ4980=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-qPNNJ-EaNIGLAhi38TZx-g-1; Tue, 17 Jan 2023 05:24:36 -0500
X-MC-Unique: qPNNJ-EaNIGLAhi38TZx-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51E8B29AB3E1;
        Tue, 17 Jan 2023 10:24:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0DB11415108;
        Tue, 17 Jan 2023 10:24:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6FB541800097; Tue, 17 Jan 2023 11:24:33 +0100 (CET)
Date:   Tue, 17 Jan 2023 11:24:33 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <20230117102433.mawczdq3di6776bx@sirius.home.kraxel.org>
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name>
 <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
 <20230116123057.wvr6rz7y3ubgcm5z@box.shutemov.name>
 <CAMj1kXGVNHqGN2uhziARu9H3RQiqbPJBE1GxHuWzC5gajJyaeA@mail.gmail.com>
 <20230116134246.soworigs56bz5v7o@box.shutemov.name>
 <CAAH4kHb6-6QkMnYbcQ6MyMkwSBUN-Q3CcM3fuiStdbbnSfJv1A@mail.gmail.com>
 <20230116231711.cudsnxvnfg6aef3w@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116231711.cudsnxvnfg6aef3w@box.shutemov.name>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 17, 2023 at 02:17:11AM +0300, Kirill A. Shutemov wrote:
> On Mon, Jan 16, 2023 at 11:43:15AM -0800, Dionna Amalie Glaze wrote:
> > > > I still don't understand why we need to support every imaginable
> > > > combination of firmware, bootloader and OS. Unaccepted memory only
> > > > exists on a special kind of virtual machine, which provides very
> > > > little added value unless you opt into the security and attestation
> > > > features, which are all heavily based on firmware protocols. So why
> > > > should care about a EFI-aware bootloader calling ExitBootServices()
> > > > and subsequently doing a legacy boot of Linux on such systems?
> > >
> > > Why break what works? Some users want it.
> > >
> > 
> > The users that want legacy boot features will not be broken,
> 
> Why do you call boot with a bootloader a legacy feature?

Linux efi kernels can be booted in two ways:

  (1) old/legacy: boot loader calls ExitBootServices and jumps to the
      kernel entry point.
  (2) new/efi stub: boot loader does *not* call ExitBootServices, but
      loads the linux kernel as efi binary instead.  The linux kernel
      efi stub calls ExitBootServices then.

All kernel version relevant here (new enough to support SEV-SNP / TDX)
have efi stub support, so (1) does not really matter in practice.

the efi stub was added *exactly* to handle cases like this one: the
kernel can do efi calls needed on its own without depending on the
boot loader doing it on behalf of the kernel.

> > This means that users of a distro that has not enabled unaccepted
> > memory support cannot simply start a VM with the usual command, but
> > instead have to know a baroque extra flag to get access to all the
> > memory that they configured the machine (and for a CSP customer, paid
> > for). That's not a good experience.
> 
> New features require enabling. It is not something new.

Asking user to manually configure something which can be handled
automatically just fine is a bad design.

take care,
  Gerd

