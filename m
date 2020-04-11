Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824061A4D1D
	for <lists+linux-efi@lfdr.de>; Sat, 11 Apr 2020 03:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgDKBDp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 21:03:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33313 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgDKBDp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Apr 2020 21:03:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id x2so2885666qtr.0;
        Fri, 10 Apr 2020 18:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VXcaUuCkQA9gomy0iPBx4UPJzC3ZDlPjCnEVyPOFA3o=;
        b=EtSwTnjbcsUfIJlKvLBHj4S058hpEWb2V77G0Te1Zw/jLMpcUFnS/R/36H5VBiwyWd
         uOgoZ37fJ2CMAKXkkfPVcmpw8FZLLSxZCV3eW8dBgRzURSKk+PTQwjBF9o+2xpmxRcAP
         BVlslzzLlBYn4iRXPaL/o1ftRWPm10QTnKRgR/27o+7Phqb5V8Bz3hIZ78rh/gFjRE1R
         WayeUQc+0FDUUYEwHBegeO+Nv/e7w1JXrvgyfutFNXQ/C/4hpZCiGy1WDT1vlCWChaL4
         2umgrv1jYJ6tqeGOej5rTxxJcgfoHiOSgPm3ZQMgoS/R93SKvoNvJoNWTKWjKT/wKReC
         O+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VXcaUuCkQA9gomy0iPBx4UPJzC3ZDlPjCnEVyPOFA3o=;
        b=NokYYIQvoRD9bV+vgSZXWGVKwGef/Kdx6R7/Jvy5PTsMX9rBvKWIi9Btshf8Y/3VtF
         QbnKhrHslkpXkoxKamrq3AojuoA6yVJeSBpSR+VbSF8NbN/JANcQzAHZRHAxhNcEhcXr
         EBqYualiH/7pFRIjmPQvl2nWeu8V2s8wXatN5uDzUAFmcC8CZ28OW/grfhgNZ1tTLe5w
         qIkYilqL+ECBqkMQZMDDmCLdFZoLT0COeCCoQP3LkwJ7w17GAUqsBKVGUXyQyNosf/d5
         505Qn2A/JLlGdi56YP8nbgm3HLFA2oMGJWA0JdkRPSTDBtRqC3R2z6DxwQ0naiHF+X1I
         zzHQ==
X-Gm-Message-State: AGi0PuYN/dlAWur+4bjTTRmexlkxa66jr+idGjSH8EvVOgN3tYZzT8uz
        TnfwXHv1OPH362+1rL4OtVE=
X-Google-Smtp-Source: APiQypJtigfGLwOIVIZxFh/QuW7K6+8zqpuqE/VDcUiqppd8eMRh2alqeGY0iT1iq5bggEyRf3gSWQ==
X-Received: by 2002:ac8:2afc:: with SMTP id c57mr1766733qta.324.1586567024512;
        Fri, 10 Apr 2020 18:03:44 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d4sm2881198qtc.48.2020.04.10.18.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:03:42 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 10 Apr 2020 21:03:40 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 3/9] efi/x86: Move efi stub globals from .bss to .data
Message-ID: <20200411010340.GA1612878@rani.riverdale.lan>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409130434.6736-4-ardb@kernel.org>
 <CAMzpN2gJWwVun1Kp6vGuza9LM5KpB=0EwsP8x8eOJQuDGh38Hg@mail.gmail.com>
 <CAMzpN2jFbf8k99pWaTYRBmSB+iNAKYsufjEhqO6Vv0qxAcHyGA@mail.gmail.com>
 <20200409210847.GA1312580@rani.riverdale.lan>
 <CAMj1kXFhtK=FRDKBE5OtenNEtpK=kVwyo+0nqJZ_K80RmtYxEg@mail.gmail.com>
 <20200410151612.GA970420@rani.riverdale.lan>
 <CAMj1kXGMNMdgjinYNgrN2wGRFG4rKE2YHo-=3s4Ofv2KPUMqKQ@mail.gmail.com>
 <20200410180123.GA1155098@rani.riverdale.lan>
 <CAMj1kXGW6V8Zif7-95MbivNgtDoufVt=uMDtYuFvEJCzOub+sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGW6V8Zif7-95MbivNgtDoufVt=uMDtYuFvEJCzOub+sA@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 10, 2020 at 08:03:15PM +0200, Ard Biesheuvel wrote:
> > >
> > > We'll still need .data.efistub for the .data pieces, but that is a
> > > separate issue.
> >
> > You can avoid that by using an archive specification like above. i.e.
> > adding
> >         drivers/firmware/efi/libstub/lib.a:(.data .data.*)
> > to the .init.data output section will pull in just the .data input
> > sections from the EFI stub into the .init.data section.
> 
> Sure. But the ARM decompressor linker script currently discards .data
> before this point in the linker script, and relies on this as a safety
> net to ensure that no new .data items get added to the decompressor
> binary (which runs after the stub)

You should be able to use EXCLUDE_FILE to skip discarding the .data
section from libstub. That also supports the archive: syntax according
to the docs though I haven't tried it.
