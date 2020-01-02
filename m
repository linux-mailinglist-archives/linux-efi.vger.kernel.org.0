Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA8112E8AC
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 17:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgABQ23 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 11:28:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51747 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgABQ23 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 11:28:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id d73so6057140wmd.1
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AZijW8MgSToVUcGOqDk8IHPSILUZNs0da2dlNuCsXjk=;
        b=t78YWaWqSs6RSxjBieNp1r0n06K4AWQ8G1A+g5TK6/btRXqxRfeEtVMKp7zYtoy0L7
         bNghRq9N50+M57IF2ntFb3aBTievGsWHdIGuzdUyMyUy06ZCZxC931csVnndcMqs0VhL
         t95LtyttkcPOC0evFjUApQ0ZW61DO8RK+MQRpVbahudVMGF8s7TB5hW/KSuwvSq6avlx
         SyMQwkJjUaTdB71dINK/GYqMVGaj1/Nmlvj9MvIqpUk6Yih+HjybRcRB3be8io5bXQAe
         epQ7GnfPAmbOA1EwJruhJHLIdXyFxBzLk1mr0zwQtiVU27BDm+Ynqpx8MdydCUxeXYbL
         7zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AZijW8MgSToVUcGOqDk8IHPSILUZNs0da2dlNuCsXjk=;
        b=NZDVNThRGxattRcoaOvr45n/jE3mbB0rRcFh6XytfX0NSFqtZlSruF5IgDl1BDbm2A
         5AQwWQ882nnSRkOtYSGgV0U+2k0d6l/CoAevGe+5ywe85PxJ/hUlpI87IFB8hfLc88x2
         n3CvdmFEEv8IYol9BPOZocANY0Wr06xEOvR8mLpQwN5KHyOwO2xeh4/eNfX1uOzF+uDS
         eWG02Gw+A8WvcdwOZclK0e1Man024Y58ktPiZM56tyeP589wOMgtNRHRmW9DZ65IbSYe
         mkKtTU2zoUVpaXIW1InI9TfyOHj4mHmYLHxRAWMmyB+SA5jIXsTXqw3FCwM5XgvBXXZR
         HK2A==
X-Gm-Message-State: APjAAAU+3Hctz9WUNiRi+d3T/4Wwqj9ZexBxyUPqjiw4h35rGgMpH1mg
        Pia99bPPYVfymu6FC/sH23+zprSXSwNQqgTUSH8GnqcHn0I=
X-Google-Smtp-Source: APXvYqwSVIkRSTZCyoFh733QUilX7/TH16bVIGg3KpqyAMGpjTdsioJ5n+7qFc3aeXfJ2nuZnTMQevA2rmPfRlkSyVY=
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr15165903wme.148.1577982507487;
 Thu, 02 Jan 2020 08:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-14-ardb@kernel.org>
 <20191231230436.GA78532@rani.riverdale.lan> <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
 <20200101190844.GA208136@rani.riverdale.lan> <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
 <20200102140653.GA626673@rani.riverdale.lan> <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan> <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
In-Reply-To: <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 Jan 2020 17:28:16 +0100
Message-ID: <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 Jan 2020 at 16:58, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 2 Jan 2020 at 16:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Thu, Jan 02, 2020 at 04:20:46PM +0100, Ard Biesheuvel wrote:
> > >
> > > Yeah, good point.
> > >
> > > I pushed as branch here;
> > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-libstub-attr-const
> > >
> > > Could you please check if that fixes the issue for efi_is_64bit() ?
> >
> > Haven't built it yet -- but how does this handle the GOT issues you
> > mentioned?
>
> It doesn't. The trick is to add __attribute__((visibility("hidden")))
> to the extern declaration of efi_is64, but I am having trouble to
> reproduce the original issue.

Some background:

https://lore.kernel.org/lkml/5405E186.2080406@canonical.com/
https://lore.kernel.org/lkml/20140919104021.GA11552@gmail.com/
