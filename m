Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CE312E904
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 17:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgABQ7c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 11:59:32 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37410 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgABQ7b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 11:59:31 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so31842815qky.4
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 08:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eKbihdamlXJStYWHlZHqPPZncw09Cy49HJTe3aNM2ds=;
        b=iPMVnlCyahpRCuP+cx5FRWfzSAK1+bCnLU3luwxZdl+U0Yd2xl9eR7fz/jDYd9q4B6
         LN+I7RMWpzmuklCCZ+fMuJach/1p55nuczbXzNCo9vJTBMuKI3kQm8FcGipaEd5kT0UM
         FLWGPUabsxgwlML9NodazifyAPMqvdsJOCxWdurrn9qOIzhwp7puky1R//tG3gD626UO
         UqAC3Jf5JLvYyPPff1YZexrGIX2AND4T9JfePyqIteF2LGIM339HipogFpm4Lb+qp0nl
         bpMFHE7JgB41Hmu2FSoSl60XJIyI6sOkiMBZg61murHmRNkO6IZBGmVXsLQl3Ch8E28M
         LmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eKbihdamlXJStYWHlZHqPPZncw09Cy49HJTe3aNM2ds=;
        b=KWu+kHah/a6dhU4UjA9JLz4oWeo5RNJjGlEhhGU8dv33SZ8J+DBn/NUUYQuY968ojh
         n5g/ub8CoGHBnbgEbVmWZ110rtnSKg3waZunEPvax8FBIXpJLUY8vw9jQoIgImUdWDww
         ET6MNIXA2/JRg/9do/op9NUonAm2xbvvlTWMaq4Ks6eFkN83rLFkyLSbLSC5Lpoemr1b
         Gk8eY/K0+m9QIPnb06blTVU4wOENR8/M48zbZAyxKTumYbTzJwDFh4Q0344+q+wMQgL4
         Fvz0ZowKDIi/eLR4mjapp7UNwT1Nc6Ti27OARSji/X4vix6G2ng79KNMnCA0oo6HA3kh
         Qk+A==
X-Gm-Message-State: APjAAAWMcF8SjqGeKLPdGi2WZtQQw3F8kacex1eJ6j03kWlETnw7b2lg
        Cds7DXLFLGtn+DDkP6+cUBU=
X-Google-Smtp-Source: APXvYqx6PEMh2mhtz6sxBu9+YBB3D7/f35+RjNhmezH/023TVLejQI8+GRXNeeSCWPNJrmvNU4ADjw==
X-Received: by 2002:a37:a642:: with SMTP id p63mr60033870qke.85.1577984370634;
        Thu, 02 Jan 2020 08:59:30 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w20sm17239405qtj.4.2020.01.02.08.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 08:59:30 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 2 Jan 2020 11:59:28 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
Message-ID: <20200102165927.GA683588@rani.riverdale.lan>
References: <20191218170139.9468-14-ardb@kernel.org>
 <20191231230436.GA78532@rani.riverdale.lan>
 <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
 <20200101190844.GA208136@rani.riverdale.lan>
 <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
 <20200102140653.GA626673@rani.riverdale.lan>
 <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan>
 <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 02, 2020 at 05:28:16PM +0100, Ard Biesheuvel wrote:
> On Thu, 2 Jan 2020 at 16:58, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 2 Jan 2020 at 16:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Thu, Jan 02, 2020 at 04:20:46PM +0100, Ard Biesheuvel wrote:
> > > >
> > > > Yeah, good point.
> > > >
> > > > I pushed as branch here;
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-libstub-attr-const
> > > >
> > > > Could you please check if that fixes the issue for efi_is_64bit() ?
> > >
> > > Haven't built it yet -- but how does this handle the GOT issues you
> > > mentioned?
> >
> > It doesn't. The trick is to add __attribute__((visibility("hidden")))
> > to the extern declaration of efi_is64, but I am having trouble to
> > reproduce the original issue.
> 
> Some background:
> 
> https://lore.kernel.org/lkml/5405E186.2080406@canonical.com/
> https://lore.kernel.org/lkml/20140919104021.GA11552@gmail.com/

I wonder if commit 6d92bc9d483a ("x86/build: Build compressed x86
kernels as PIE") resolved this.
