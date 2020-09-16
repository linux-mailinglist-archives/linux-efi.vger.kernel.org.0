Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F80D26C944
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgIPTGB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Sep 2020 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgIPRqR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Sep 2020 13:46:17 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90343C06174A
        for <linux-efi@vger.kernel.org>; Wed, 16 Sep 2020 10:45:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f142so9013770qke.13
        for <linux-efi@vger.kernel.org>; Wed, 16 Sep 2020 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7nA9P7m0k+Qtks0jy0tjUYx5rLMpxFUcNHQdGm0Klos=;
        b=F4fv9FdXaZcaZZ5aEByrFvjaSyUjpJ4+OQniaTEyxffU+KrbPaNsAX3VCl15+8vWi3
         fE7ORl2qrD8omW+OxaXABzmDdsJO55pk8CdYD6kegUhsGL77T1UruhQSQEa5wfBeDB0X
         LrDdr+dv3Xt6DLlrrv5UpKFkdB5+M+uG/t0yx+s0ZRllOftqJXfBgoErAPSEuk8LLuxc
         ZPFjhsp0j2flHQPmF3kXcupfz4ZkIC7Tb7FSzk+7PSGiTiTj+6tX+isQtl+3ygDFyLEC
         uMngujGRDfBzy96YfMMjAas1frlY6uiyS1cpTXd1H1PXh8aLglJS6/ciIkzuU72Ki7E7
         ud1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7nA9P7m0k+Qtks0jy0tjUYx5rLMpxFUcNHQdGm0Klos=;
        b=tgqckrvyHtNRROdP1D/pGigXNh/2jmgm0cxMFARnSRxSkVpYq6zyuK9LX+Te9UQMAz
         6DJUX/wMuN1YGC3J07byhNNbuGidSi3sH5Ln5MZ5/INLzU/SF+U7y+NoYya2poEoyQH4
         axtdQQSpO1F1NZvcMrtW/Gvovm9U4Zb+aTufj94qf5AAzCcaXISgoIi31+t00irfrDfk
         O4YmvNmHBQuGsTHRAqwyEIuvquCr+rqO750b9po0AKBfcnk3P6dhO+xqMgE7RBXAOvVO
         WTdhbYC2SoX2mVxKOxCgW2yb0pelpgODqHhZk+K+PHgOtqeOxhtMRh6ztU4pL7MrsdIl
         rdUQ==
X-Gm-Message-State: AOAM533+GCS0mh51tPjWybSsecQ1xCRzEAfWzB7T1w2HcqNWda8YpNPE
        nF5NQyY2rTid8gWDKJxSWJM=
X-Google-Smtp-Source: ABdhPJyRXsHXbs/hhSIlxoig6IAB0qjfL1CLpftUscXgBveYYl8oNYPPW84PEUaHZjTwBK2Nr7UoWQ==
X-Received: by 2002:a37:6848:: with SMTP id d69mr23001770qkc.80.1600278352942;
        Wed, 16 Sep 2020 10:45:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w94sm19451442qte.93.2020.09.16.10.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:45:52 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 16 Sep 2020 13:45:50 -0400
To:     Jacobo Pantoja <jacobopantoja@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 2/2] efi/x86: Add a quirk to support command line
 arguments on Dell EFI firmware
Message-ID: <20200916174550.GA1281480@rani.riverdale.lan>
References: <20200914213535.933454-1-nivedita@alum.mit.edu>
 <20200914213535.933454-2-nivedita@alum.mit.edu>
 <CAMj1kXHy4d6zEJhJtdkHyYx-jnhJJzJ4Xi+qyawhjg6hXhAQgw@mail.gmail.com>
 <CAO18KQi9icju0YJ-dGe70NC8oFN0GL0hM1_fn8xE9dEkcrU_8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO18KQi9icju0YJ-dGe70NC8oFN0GL0hM1_fn8xE9dEkcrU_8A@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 16, 2020 at 06:50:15PM +0200, Jacobo Pantoja wrote:
> Hi, I'd like to update my testing and share my thoughts.
> 
> Regarding the patches:
> 1) The patches in email 1/2 (the functions "efi_warn", etc.) are not working
> properly. I got some suggestions for testing from Ard in a separate email.
>   3a. If, in this 2nd patch, I switch the "efi_warn_once" with an
> "efi_printk", the
>   messages appear.
>   1a. I've set CONFIG_CONSOLE_LOGLEVEL_DEFAULT=5, same result
>   2a. I've switched from "efi_warn_once" to "efi_warn", same result.

I had tested on QEMU, and the messages appear there. Not sure what might
cause efi_warn to not work if efi_printk is working.

> 2) Even if they would be working, since it is not logged anywhere, I
> don't really
> think these messages make sense. Idk if these can be made available to dmesg.

They're useful mostly in the case the boot hangs in the EFI stub. If the
boot works, they will generally disappear very quickly, making them
difficult to notice/read.

> 3) The function "efi_apply_loadoptions_quirk" is called twice, it seems to me
> that calling it from the "file.c" is redundant, but probably I'm
> missing something.

file.c reads the original UTF-16 command line. It's possible to refactor
the code so it doesn't have to quirk twice, but this was the smallest
change for now.

> 
> Regarding the quirk itself, in my opinion we should wait for Mario's
> news, since,
> again in my opinion, this is something that should be fixed in the
> firmware itself.
> Being Dell a serious company, I think it is feasible that, at least
> for their enterprise
> products, they might fix it.
> 
> On Tue, 15 Sep 2020 at 17:09, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 15 Sep 2020 at 00:35, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > At least some versions of Dell EFI firmware pass the entire
> > > EFI_LOAD_OPTION descriptor, rather than just the OptionalData part, to
> > > the loaded image. This was verified with firmware revision 2.15.0 on a
> > > Dell Precision T3620 by Jacobo Pontaja.
> 
> Please be so kind to correct my name, if it's being included in the commit msg.

Oops, sorry about that. Ard, can you fix that up?

Thanks.
