Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36398166736
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 20:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgBTTdq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 14:33:46 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39518 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbgBTTdq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Feb 2020 14:33:46 -0500
Received: by mail-qv1-f66.google.com with SMTP id y8so2445917qvk.6
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 11:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hdCAzedTFon/SykghITSH92T0iSCgPhcqQ2jqiE7QW0=;
        b=nUTZy4gPVzfUNhSL7UGFK5PNgARJwpSfE2svHrpWPUMp/O/6KpvYIWQMF1WCjKvBjt
         Ve1gOjkWmyfLhJH8mw7vbOkWQ+8Y5FtFZ8CTvUuZqukTZN+lTICQavgH1LneXlvt9Nvh
         uFDAViJU1QyioKTJWSkG2y2Z4b9gEyIPKBYV2AAtvN21AsbJHhbQXP5vo7B5uTut408j
         V/Qv6Xq7mlFKJpGyAXZce7hAIgY4HVJZAYIjvejZXh7gVOAED+zegGvWoqzQTstVWKiH
         TH/Nk0sRGXdONqGEPGDXXckazaAtHkGkvnvDTI0NTcSVlifcOkrkotymJDoIzUEoVDcF
         dSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hdCAzedTFon/SykghITSH92T0iSCgPhcqQ2jqiE7QW0=;
        b=fM70W3ixgw4f8ritMwzXz2QlokB4RPLsL3t8ysUKKuV5KGu7vAv7KO9i1mwX34p91f
         3ncsJ9ro7i+Y529ed7n8Nugz3coB9c78whGtswnd3yIY+mhtHE9pmzluCbMsrU5K+TAm
         GnFlYlGNcAmqG3bq3uDCWrSflbXAwj3jSrruDnbWz+39bVT5QYz2T/Q7j3rMOQcMLOWJ
         HCzRTiSGuXpxe4toiIj/tJTfue8d89ZG9zqQtu88xVF6iIuZ+QZ0JcRF1YxuSBNu2jMI
         5qlqvbYZ53Ad1y5SJb+CPbflbmO9kS9Yft/7hozS4vDy9toRvRpyp/mf2kKTi8LT4vC0
         G0Ag==
X-Gm-Message-State: APjAAAVZjQfoaZ8oPW6J59iGG1qnzUp6franYGHojxkZRc8GEqNg6Er3
        2P8PjKnr4iq/e/0wzXD4Iiw=
X-Google-Smtp-Source: APXvYqwdhCQLNax2aGOO85Ow7+tKrdMhfC4h+igxPEJbob6BrcHFAKfDdGl22b9j1aEj9FCX3KY57w==
X-Received: by 2002:ad4:59c2:: with SMTP id el2mr25793179qvb.152.1582227225270;
        Thu, 20 Feb 2020 11:33:45 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v50sm313085qtb.20.2020.02.20.11.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 11:33:44 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 20 Feb 2020 14:33:43 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH 1/3] efi/x86: Use symbolic constants in PE header
 instead of bare numbers
Message-ID: <20200220193342.GA2459390@rani.riverdale.lan>
References: <20200220110649.1303-1-ardb@kernel.org>
 <20200220110649.1303-2-ardb@kernel.org>
 <20200220172831.GA2417225@rani.riverdale.lan>
 <CAKv+Gu_QiXsJyR0X4au+r75DFoQmSUp38+J7BuD3HAH+rJ9gHQ@mail.gmail.com>
 <20200220180454.GA2436919@rani.riverdale.lan>
 <CAKv+Gu_hVszLmChFvrv5MU5aS5-Vuc4AXB7R0XNXn+Amgx=Ogg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_hVszLmChFvrv5MU5aS5-Vuc4AXB7R0XNXn+Amgx=Ogg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 20, 2020 at 07:14:27PM +0100, Ard Biesheuvel wrote:
> On Thu, 20 Feb 2020 at 19:05, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Thu, Feb 20, 2020 at 06:32:39PM +0100, Ard Biesheuvel wrote:
> > > Another thing I wondered was whether we really need the .reloc
> > > section. We don't have one on ARM, and it works fine with the existing
> > > EDK2 loader.
> > > Peter: any idea whether the issue with .reloc you pointed out to me
> > > the other day still exists in EDK2 today?
> >
> > commit 743628e868c5 ("x86, efi stub: Add .reloc section back into
> > image") says that
> >         Some UEFI firmware will not load a .efi with a .reloc section
> >         with a size of 0.
> >
> > Is that the issue you're refering to? It is a bit odd, since we actually
> > leave base relocation table at a size of zero with an RVA of zero, so it
> > shouldn't even look at the .reloc section according to the spec. At
> > least current EKD2 code doesn't seem to -- I think it would even work if
> > you specify fewer tables than 6 so that the base relocation table is
> > missing altogether.
> 
> I can only agree with that, and I have never experienced any issues
> loading PE/COFF images without .reloc sections on any architecture.
> 
> But looking at that patch, it seems it only changes the .reloc
> section's size, it doesn't actually add it back. The .reloc section
> has been there from the beginning, with a note saying that it is
> required, which doesn't seem to be the case today, and looking at the
> history of EDK2, I can't really spot any changes in that regard
> either.

Yeah I thought given that it caused a problem some firmware must have
been looking at the reloc section, but on the other hand it might just
have been that the firmware barfed because it didn't expect any section
to be zero size?
